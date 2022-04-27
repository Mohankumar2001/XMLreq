<%@page language="java" pageEncoding="UTF-8"%>
<%@page import = "java.io.*"%>
<%@page import = "org.w3c.dom.*"%>
<%@page import = "javax.xml.parsers.*"%>

    <%
        try{
            String id = request.getParameter("user_id");
            int userId = Integer.parseInt(id);
            String name = "";
            String email = "";
            String userName = "";
            
            
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new File("C:/Users/Mohan Kumar/eclipse-workspace/xml_users/src/main/webapp/user_data.xml"));
            
            NodeList nList = document.getElementsByTagName("user");
            
            StringBuffer sb = new StringBuffer();
            sb.append("<users>");
            
            
            for(int temp=0; temp < nList.getLength(); temp++){
                
                Node node = nList.item(temp);
                
                if(node.getNodeType() == Node.ELEMENT_NODE){
                
                    Element eElement = (Element) node;
                    String currIdString = eElement.getElementsByTagName("user_id").item(0).getTextContent();
                    int currId = Integer.parseInt(currIdString);
                    
                    if(currId == userId){
                        name = eElement.getElementsByTagName("name").item(0).getTextContent();
                        email = eElement.getElementsByTagName("email").item(0).getTextContent();
                        userName = eElement.getElementsByTagName("username").item(0).getTextContent();
                        
                        sb.append("<user>");
                        sb.append("<name>").append(name).append("</name>");
                        sb.append("<email>").append(email).append("</email>");
                        sb.append("<username>").append(userName).append("</username>");
                        sb.append("</user>");
                        
                        break;
                    }
                }
            }
            
            sb.append("</users>");

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write(sb.toString());
        }
        catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    %>
