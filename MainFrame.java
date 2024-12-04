import javax.swing.*;
import java.awt.*;

public class MainFrame extends JFrame {
    public MainFrame() {
        setTitle("Gestión de Base de Datos - Chicles");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JTabbedPane tabbedPane = new JTabbedPane();

        tabbedPane.addTab("Chicle Base", new TablePanel("chiclebase"));
        tabbedPane.addTab("Cliente", new TablePanel("cliente"));
        tabbedPane.addTab("Combinación Sabor", new TablePanel("combinacionsabor"));
        tabbedPane.addTab("Paquete Producto", new TablePanel("paqueteproducto"));
        tabbedPane.addTab("Pedidos", new TablePanel("pedidos"));
        tabbedPane.addTab("Polvo Sabor", new TablePanel("polvosabor"));
        tabbedPane.addTab("Proveedor", new TablePanel("proveedor"));

        add(tabbedPane, BorderLayout.CENTER);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            MainFrame frame = new MainFrame();
            frame.setVisible(true);
        });
    }
}
