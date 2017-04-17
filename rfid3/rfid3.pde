import com.phidgets.*;
import com.phidgets.event.*;
import shenkar.phidgets.*;

InterfaceKit myInterfaceKit;
RFIDPhidget rfid = null;
PFont font;
String tag = "";

void setupReader() {
try {
rfid = new RFIDPhidget();

rfid.addAttachListener(new AttachListener() {
public void attached(AttachEvent ae)
{
try
{
((RFIDPhidget)ae.getSource()).setAntennaOn(true);
((RFIDPhidget)ae.getSource()).setLEDOn(true);
}
catch (PhidgetException ex) {
}
println("attachment of " + ae);
}
}
);

rfid.addDetachListener(new DetachListener() {
public void detached(DetachEvent ae) {
System.out.println("detachment of " + ae);
}
}
);

rfid.addErrorListener(new ErrorListener() {
public void error(ErrorEvent ee) {
System.out.println("error event for " + ee);
}
}
);

rfid.addTagGainListener(new TagGainListener()
{
public void tagGained(TagGainEvent oe)
{
System.out.println(oe);
tag = oe.getValue();
}
}
);

rfid.addTagLossListener(new TagLossListener()
{
public void tagLost(TagLossEvent oe)
{
System.out.println(oe);
tag = "";
}
}
);

rfid.addOutputChangeListener(new OutputChangeListener()
{
public void outputChanged(OutputChangeEvent oe)
{
System.out.println(oe);
}
}
);

rfid.openAny();
println("waiting for RFID attachment…");
rfid.waitForAttachment(1000);

System.out.println("Serial: " + rfid.getSerialNumber());
System.out.println("Outputs: " + rfid.getOutputCount());

System.out.println("Outputting events.");

}
catch (PhidgetException ex)
{
System.out.println(ex);
}
}

void closeReader(){
try {
System.out.print("closing…");
rfid.close();
rfid = null;
System.out.println(" ok");
if (false) {
System.out.println("wait for finalization…");
System.gc();
}
}
catch (PhidgetException ex)
{
System.out.println(ex);
}
}

void setup()
{
  myInterfaceKit = new InterfaceKit(this);
size(400,100);

//Don’t forget to create the font in the tools menu above
font = loadFont("Verdana-12.vlw");
textFont(font);
fill(0);
// setup Reader
setupReader();

// close Reader: Should add a button or some other trigger to call this method
//closeReader();
}

void draw()
{
background(200);
 myInterfaceKit.digitalWrite(0,false);
 myInterfaceKit.digitalWrite(1,false);
 
if (tag.equals("0102388ec4")){ 
text ("potato!", 50, 50);
myInterfaceKit.digitalWrite(0,false);
 myInterfaceKit.digitalWrite(1,true);
}

if (tag.equals("0102389892")) {
text ("turkey!", 100, 75);
myInterfaceKit.digitalWrite(0,false);
 myInterfaceKit.digitalWrite(1,true);
}

if (tag.equals("01023882a3")){ 
text ("cow!", 250, 25);
myInterfaceKit.digitalWrite(0,true);
 myInterfaceKit.digitalWrite(1,false);
}

if (tag.equals("01023893b4")) {
text ("lemon!", 225, 50);
myInterfaceKit.digitalWrite(0,true);
 myInterfaceKit.digitalWrite(1,false);
}
}