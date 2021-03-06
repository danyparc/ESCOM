import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jdom2.*;
import org.jdom2.output.XMLOutputter;
import org.jdom2.EntityRef;
import java.io.FileWriter;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;

public class BuildXML extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession s = request.getSession();
        PrintWriter p = response.getWriter();
        
        Element root = new Element((String) s.getAttribute("raiz"));
        Element elems[] = new Element[Integer.parseInt((String) s.getAttribute("cantidad"))];
        
        String tipoAtributo = request.getParameter("tiposAt"), tipooo = "";
        
        String arch = getServletContext().getRealPath("/multiaportes/salida.xml");
        String arch2 = getServletContext().getRealPath("/multiaportes/salida.dtd");
        
        Document doc = new Document(root);
        XMLOutputter fmt = new XMLOutputter();
        FileWriter writer = new FileWriter(arch);
        FileWriter dtd = new FileWriter(arch2);
        EntityRef ent = new EntityRef("elemento1");
        
        for(int a = 0; a < elems.length; a++)
        {
            elems[a] = new Element((String) s.getAttribute("n"+a));
            for(int b = 0; b < Integer.parseInt((String) s.getAttribute("a"+a)); b++)
            {
                elems[a].setAttribute(request.getParameter("at_name"+a+b), request.getParameter("at_val"+a+b));
            }
            root.addContent(elems[a]);
        }
        
        try
        {
            //dtd.write("<!DOCTYPE "+s.getAttribute("raiz")+" [\n");
            
            dtd.write("<!ELEMENT "+s.getAttribute("raiz")+" (");
            for(int a = 0; a < elems.length; a++)
            {
                if(a != elems.length -1)
                    dtd.write((String) s.getAttribute("n"+a)+"*, ");
                else
                    dtd.write((String) s.getAttribute("n"+a)+"*)>\n");
            }
            for(int a = 0; a < elems.length; a++)
                dtd.write("<!ELEMENT "+s.getAttribute("n"+a)+" (#PCDATA)>\n");
            
            dtd.write("\n");
            
            for(int a = 0; a < elems.length; a++)
            {
                for(int b = 0; b < Integer.parseInt((String) s.getAttribute("a"+a)); b++)
                {
                    if(request.getParameter("tiposAt"+a+b).equals("nmtoken"))
                    {
                        tipooo = "NMTOKEN";
                    }
                    else if(request.getParameter("tiposAt"+a+b).equals("nmtokens"))
                    {
                        tipooo = "NMTOKENS";
                    }
                    else if(request.getParameter("tiposAt"+a+b).equals("entity"))
                    {
                        tipooo = "CDATA";
                        dtd.write("<!ENTITY entidad1 \"texto\">\n");
                        elems[a].setText(ent.getName());
                    }
                    else if(request.getParameter("tiposAt"+a+b).equals("notation"))
                    {
                        tipooo = "ENTITY";
                        dtd.write("<!NOTATION imagen SYSTEM \"image/png\">\n" +
"<!ENTITY entidad2 SYSTEM \"http://www.multiaportes.com/wp-content/uploads/2014/01/logo.png\" NDATA imagen>\n");
                        //writer.write("<!ATTLIST "+s.getAttribute("n"+a)+" "+request.getParameter("at_name"+a+b)+" "+tipooo+" #IMPLIED>\n");
                        elems[a].setAttribute(request.getParameter("at_name"+a+b), "entidad2");
                    }
                    
                    dtd.write("<!ATTLIST "+s.getAttribute("n"+a)+" "+request.getParameter("at_name"+a+b)+" "+tipooo+" #IMPLIED>\n");
                }
            }
            
            /*for(int a = 0; a < elems.length; a++)
            {
                for(int b = 0; b < Integer.parseInt((String) s.getAttribute("a"+a)); b++)
                {
                    writer.write("<!ATTLIST "+s.getAttribute("n"+a)+" "+request.getParameter("at_name"+a+b)+" "+tipooo+" #IMPLIED>\n");
                }
            }*/
            
            //dtd.write("]>\n");
            
            writer.write("<!DOCTYPE "+s.getAttribute("raiz")+" SYSTEM \"salida.dtd\">\n");
            fmt.output(doc, writer);
            
            dtd.flush();
            dtd.close();
            writer.flush();
            writer.close();
        } 
        catch (Exception e)
        {
                p.print(e.getMessage());
        }
        finally
        {
            p.print("<html><head></head><body><h2>Documento XML generado correctamente</h2>Archivo guardado en "+arch+"<br/>Solucion FileWriter Servlet Linux: <code>chmod 777 carpeta</code></body></html>");
        }
        
    }
}
