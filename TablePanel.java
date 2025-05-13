import javax.swing.*;
import java.awt.*;
import java.sql.*;
import javax.swing.table.DefaultTableModel;

public class TablePanel extends JPanel {
    private JTable table;
    private String tableName;
    private JPanel formPanel;
    private JTextField[] textFields; // Campos de texto para cada columna
    private DefaultTableModel tableModel;

    public TablePanel(String tableName) {
        this.tableName = tableName;
        setLayout(new BorderLayout());

        // Crear tabla
        table = new JTable();
        JScrollPane scrollPane = new JScrollPane(table);
        add(scrollPane, BorderLayout.CENTER);

        // Crear panel de botones
        JPanel buttonPanel = new JPanel();
        JButton btnAdd = new JButton("Agregar");
        JButton btnUpdate = new JButton("Actualizar");
        JButton btnDelete = new JButton("Eliminar");

        buttonPanel.add(btnAdd);
        buttonPanel.add(btnUpdate);
        buttonPanel.add(btnDelete);
        add(buttonPanel, BorderLayout.SOUTH);

        // Crear formulario para los datos
        formPanel = new JPanel(new GridLayout(0, 2)); // Filas dinámicas, 2 columnas
        add(formPanel, BorderLayout.NORTH);

        // Cargar los datos y columnas de la tabla
        loadTableData();

        // Acciones de botones
        btnAdd.addActionListener(e -> addRecord());
        btnUpdate.addActionListener(e -> updateRecord());
        btnDelete.addActionListener(e -> deleteRecord());
    }

    private void loadTableData() {
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName)) {

            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            tableModel = new DefaultTableModel();

            // Crear campos de texto dinámicos y etiquetas
            formPanel.removeAll(); // Limpia el formulario anterior si ya existía
            textFields = new JTextField[columnCount];

            for (int i = 1; i <= columnCount; i++) {
                String columnName = metaData.getColumnName(i);
                tableModel.addColumn(columnName);

                JLabel label = new JLabel(columnName + ":");
                JTextField textField = new JTextField();

                formPanel.add(label);
                formPanel.add(textField);

                textFields[i - 1] = textField;
            }

            // Agregar filas al modelo de la tabla
            while (rs.next()) {
                Object[] row = new Object[columnCount];
                for (int i = 1; i <= columnCount; i++) {
                    row[i - 1] = rs.getObject(i);
                }
                tableModel.addRow(row);
            }

            table.setModel(tableModel);
            formPanel.revalidate();
            formPanel.repaint();

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error al cargar datos: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void addRecord() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            StringBuilder query = new StringBuilder("INSERT INTO ").append(tableName).append(" VALUES (");
            for (int i = 0; i < textFields.length; i++) {
                query.append("?");
                if (i < textFields.length - 1) query.append(", ");
            }
            query.append(")");

            PreparedStatement stmt = conn.prepareStatement(query.toString());
            for (int i = 0; i < textFields.length; i++) {
                stmt.setString(i + 1, textFields[i].getText());
            }

            stmt.executeUpdate();
            JOptionPane.showMessageDialog(this, "Registro agregado exitosamente.");
            loadTableData(); // Recargar datos

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error al agregar registro: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void updateRecord() {
        int selectedRow = table.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Por favor selecciona un registro para actualizar.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            StringBuilder query = new StringBuilder("UPDATE ").append(tableName).append(" SET ");
            for (int i = 0; i < textFields.length; i++) {
                query.append(tableModel.getColumnName(i)).append(" = ?");
                if (i < textFields.length - 1) query.append(", ");
            }
            query.append(" WHERE ").append(tableModel.getColumnName(0)).append(" = ?");

            PreparedStatement stmt = conn.prepareStatement(query.toString());
            for (int i = 0; i < textFields.length; i++) {
                stmt.setString(i + 1, textFields[i].getText());
            }
            stmt.setString(textFields.length + 1, table.getValueAt(selectedRow, 0).toString());

            stmt.executeUpdate();
            JOptionPane.showMessageDialog(this, "Registro actualizado exitosamente.");
            loadTableData(); // Recargar datos

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error al actualizar registro: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void deleteRecord() {
        int selectedRow = table.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Por favor selecciona un registro para eliminar.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM " + tableName + " WHERE " + tableModel.getColumnName(0) + " = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, table.getValueAt(selectedRow, 0).toString());

            stmt.executeUpdate();
            JOptionPane.showMessageDialog(this, "Registro eliminado.");
            loadTableData(); // Recargar datos

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error al eliminar registro: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
