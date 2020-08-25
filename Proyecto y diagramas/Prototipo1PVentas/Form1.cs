using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Odbc;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Prototipo1PVentas
{
    public partial class Form1 : Form
    {
        
        public Form1()
        {
            InitializeComponent();
            procClientes();
            procProducto();
            procTipoVenta();
        }
        Conexion cn = new Conexion();
        int Cantidad = 0;
        double Total, Precio;
        String Producto = "";

        void procTotal()
        {
            Cantidad = Int32.Parse(txtCantidad.Text.ToString());
            Precio = double.Parse(cboPrecio.SelectedItem.ToString());
            Total = Cantidad * Precio;
        }
        void procClientes()
        {
            //en esta funcion buscar se seleccionaran las clasificacions de las peliculas y se mostraran en el cboClaficicacion
            try
            {
                string query = "SELECT * FROM CLIENTE";
                OdbcCommand comm = new OdbcCommand(query, cn.nuevaConexion());
                OdbcDataReader mostrarC = comm.ExecuteReader();

                while (mostrarC.Read())
                {
                    String nombre, apellido, nombreCompleto;
                    nombre = mostrarC.GetString(1);
                    apellido = mostrarC.GetString(2);
                    nombreCompleto = nombre + " " + apellido;
                    cboCodigoCliente.Items.Add(mostrarC.GetInt32(0));
                    cboCliente.Items.Add(nombreCompleto);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudieron mostrar los registros en este momento intente mas tarde" + ex);
            }
        }
        void procProducto()
        {
            //en esta funcion buscar se seleccionaran las clasificacions de las peliculas y se mostraran en el cboClaficicacion
            try
            {
                string query = "SELECT * FROM PRODUCTO";
                OdbcCommand comm = new OdbcCommand(query, cn.nuevaConexion());
                OdbcDataReader mostrarC = comm.ExecuteReader();

                while (mostrarC.Read())
                {
                    
                    cboCodigoProducto.Items.Add(mostrarC.GetInt32(0));
                    cboProducto.Items.Add(mostrarC.GetString(1));
                    cboPrecio.Items.Add(mostrarC.GetString(3));
                    Producto = mostrarC.GetString(1);
                    
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudieron mostrar los registros en este momento intente mas tarde" + ex);
            }
        }

        void procTipoVenta()
        {
            cboTipoVenta.Items.Add("Contado");
            cboTipoVenta.Items.Add("Credito");
        }
        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void cboCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            cboCodigoCliente.SelectedIndex = cboCliente.SelectedIndex;
        }

        private void cboProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            cboCodigoProducto.SelectedIndex = cboProducto.SelectedIndex;
            cboPrecio.SelectedIndex = cboProducto.SelectedIndex;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MessageBox.Show("La venta fue realizada exitosamente");
            /* for (int i = 0; i < dgtDatos.Rows.Count; ++i)
             {
                 string Producto = Convert.ToString(dgtDatos.Rows[i].Cells[0].Value);
                 int Cantidad = Int32.Parse(dgtDatos.Rows[i].Cells[1].Value.ToString());

                 try
                 {
                     string query = "SELECT * FROM PRODUCTO";
                     OdbcCommand comm = new OdbcCommand(query, cn.nuevaConexion());
                     OdbcDataReader mostrarC = comm.ExecuteReader();

                     while (mostrarC.Read())
                     {
                         int CantidadProducto = mostrarC.GetInt32(1);
                     }

                 }
                 catch (Exception ex)
                 {
                     MessageBox.Show("No se pudieron mostrar los registros en este momento intente mas tarde" + ex);
                 }

                 // MessageBox.Show(""+Producto+" "+Cantidad);
             }*/

            cboCliente.Items.Clear();
            cboCodigoCliente.Items.Clear();
            cboProducto.Items.Clear();
            cboProducto.Items.Clear();
            cboCodigoProducto.Items.Clear();
            txtCantidad.Text = "";
            cboTipoVenta.Items.Clear();
            dgtDatos.DataSource = null;
            procClientes();
            procProducto();
            procTipoVenta();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            if(cboCliente.SelectedItem == null || cboProducto.SelectedItem == null || txtCantidad.Text == "" || cboTipoVenta.SelectedItem == null)
            {
                MessageBox.Show("No debe dejar campos vacios");
            }else
            {
            procTotal();
            dgtDatos.Rows.Add(cboProducto.SelectedItem.ToString(),txtCantidad.Text.ToString(),cboPrecio.SelectedItem.ToString(), Convert.ToString(Total));
            txtCantidad.Text = "";
            cboPrecio.Items.Clear();
            cboProducto.Items.Clear();
            cboCodigoProducto.Items.Clear();
            procProducto();
            }
           
        }
    }
}
