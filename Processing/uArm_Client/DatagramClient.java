import java.net.*;

public class DatagramClient
{
   private final static int PACKETSIZE = 100 ;
   private int port;
   private String addr;
   
   public void init(String addr, int port){
     this.port = port;
     this.addr = addr;
   }

   public void send(byte[] data)
   {
      // Check the arguments
      DatagramSocket socket = null ;

      try
      {
         // Convert the arguments first, to ensure that they are valid
         InetAddress host = InetAddress.getByName( this.addr ) ;
         int port         = this.port;

         // Construct the socket
         socket = new DatagramSocket() ;

         // Construct the datagram packet
         // byte [] byte_data = data.getBytes() ;
         DatagramPacket packet = new DatagramPacket( data, data.length, host, port ) ;

         // Send it
         socket.send( packet ) ;

//          // Set a receive timeout, 2000 milliseconds
//          socket.setSoTimeout( 2000 ) ;

//          // Prepare the packet for receive
//          packet.setData( new byte[PACKETSIZE] ) ;

//          // Wait for a response from the server
//          socket.receive( packet ) ;

//          // Print the response
//          System.out.println( new String(packet.getData()) ) ;

      }
      catch( Exception e )
      {
         System.out.println( e ) ;
      }
      finally
      {
         if( socket != null )
            socket.close() ;
      }
   }
}
