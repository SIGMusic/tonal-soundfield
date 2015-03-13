class Chord
{
    0=>static int mode;
    0=>int style;
    Chord @ next[];
    int notes[];
    int root;                         //the root key
    int type;                         //major,minor,etc
    float probabilities[][];              //probability for each next state
    Chord @ modulationSequence[][];
    Chord @ modulationChord[];
    int modulationTarget[];
    fun void init(int root, int type, Chord next[], float probabilities[][])
    {
        setRoot(root);
        setType(type);
        setNext(next);
        setProbabilities(probabilities);
        setNotes();
    }
    fun void setRoot(int i)
    {
        i=>root;
    }
    fun void setType(int i)
    {
        i=>type;
    }
    fun void setNext(Chord c[])
    {
        c@=>next;
    }
    fun void setProbabilities(float f[][])
    {
        f@=>probabilities;
    }
    fun Chord getNextChord()
    {
        return getNextChord(mode);
    }
    fun Chord getNextChord(int i)
    {
        Std.rand2f(0, 1)=>float rand;
        0=>float c;
        getProbabilities(i)@=>float p[];
        for (0=>int i; i<p.cap()-1;i++)
        {
            p[i]+=>c;
            if (rand<=c)
                return next[i];
        }
        return next[next.cap()-1];
    }
    fun float[] getProbabilities(int i)
    {
        return probabilities[i];
    }
    fun string toString()
    {
        [["I","i","Idim","Iaug","Isus4","I7"],
         ["bII","bii"],
         ["II","ii","IIdim","IIaug","IIsus4","II7","ii7"],
         ["bIII","biii"],
         ["III","iii"],
         ["IV","iv"],
         ["bV","bv","bVdim","bVaug","bVsus4","bV7","bv7"],
         ["V","v","Vdim","Vaug","Vsus4","V7"],
         ["bVI","bvi"],
         ["VI","vi","VIdim","VIaug","VIsus4"],
         ["bVII","bvii"],
         ["VII","vii"]]@=>string s[][];
        return s[root][type];
    }
    fun void setNotes()
    {
        if (type==0)
        {
            [root,root+4,root+7]@=>notes;
        }
        if (type==1)
        {
            [root,root+3,root+7]@=>notes;
        }
        if (type==2)
        {
            [root,root+3,root+6]@=>notes;
        }
        if (type==3)
        {
            [root,root+4,root+8]@=>notes;
        }
        if (type==4)
        {
            [root,root+5,root+7]@=>notes;
        }
        if (type==5)
        {
            [root,root+4,root+7,root+10]@=>notes;
        }
        if (type==6)
        {
            [root,root+3,root+7,root+10]@=>notes;
        }

    }
    fun int[] getNotesWithin()
    {
        return notes;
    }
    fun void setModulation(Chord modulation[][], int target[], Chord chord[])
    {
        modulation@=>modulationSequence;
        target@=>modulationTarget;
        chord@=>modulationChord;
    }
    fun Chord[][] getModulationSequence()
    {
        return modulationSequence;
    }
    fun int[] getModulationTarget()
    {
        return modulationTarget;
    }
    fun Chord[] getModulationChord()
    {
        return modulationChord;
    }
}

class IntList
{
    0=>int size;
    IntNode @ first;
    IntNode @ last;
    
    fun void offer(int o)
    {
        IntNode n;
        n.init(o);
        if (size==0)
        {
            n@=>first;
            n@=>last;
        }
        else
        {
            n@=>last.next;
            n@=>last;
        }
        size++;
    }
    fun int poll()
    {
        if (size==0)
            return -1;
        size--;
        first @=> IntNode n;
        n.next @=> first;
        return n.object;
    }
}
class IntNode
{
    int object;
    IntNode @ next;
    fun void init(int o)
    {
        o=>object;
    }
}
class LinkedList                   //great pain to write a linked list in chuck
{
    0=>int size;
    Node @ first;
    Node @ last;
    
    fun void offer(Object o)
    {
        Node n;
        n.init(o);
        if (size==0)
        {
            n@=>first;
            n@=>last;
        }
        else
        {
            n@=>last.next;
            n@=>last;
        }
        size++;
    }
    fun Object poll()
    {
        if (size==0)
            return null;
        size--;
        first @=> Node n;
        n.next @=> first;
        return n.object;
    }
    fun Object add(Object o[])
    {
        for (0=>int i; i<o.cap(); i++)
        {
            offer(o[i]);
        }
    }
    fun Object getFirst()
    {
        return first.object;
    }
    fun Object getLast()
    {
        return last.object;
    }
}
class Node
{
    Object @ object;
    Node @ next;
    fun void init(Object o)
    {
        o@=>object;
    }
}



//runing code starts here
OscSend send;
"localhost" => string hostname;
6450 => int port;
send.setHost(hostname,port);
Chord current;
Chord I;
Chord I7;
Chord ii;
Chord II;
Chord IIdim;
Chord ii7;
Chord iii;
Chord III;
Chord bv7;
Chord IV;
Chord iv;
Chord V;
Chord V7;
Chord vi;
Chord VI;
Chord Isus4;
Chord VIsus4;
I.init(0,0,[I,ii,III,IV,V,vi,ii7],[[0.1,0.1,0.1,0.3,0.2,0.1,0.1],[0.1,0.1,0.1,0.1,0.1,0.4,0.1]]);
I7.init(0,5,[I7],[[1.0],[1.0]]);
ii.init(2,1,[iii,III,V,vi],[[0.2,0.3,0.4,0.1],[0.4,0.3,0.2,0.1]]);
II.init(2,0,[II],[[1.0],[1.0]]);
IIdim.init(2,2,[V],[[1.0],[1.0]]);
ii7.init(2,6,[I,V],[[0.3,0.7],[0.3,0.7]]);
iii.init(4,1,[V,IV,vi],[[0.4,0.4,0.2],[0.2,0.3,0.5]]);
III.init(4,0,[IV,vi,iv],[[0.5,0.3,0.2],[0.2,0.6,0.2]]);
IV.init(5,0,[I,V,V7,III,bv7],[[0.3,0.3,0.2,0.1,0.1],[0.2,0.4,0.1,0.2,0.1]]);
iv.init(5,1,[IV,V,vi],[[0.3,0.4,0.3],[0.2,0.4,0.4]]);
bv7.init(6,6,[V],[[1.0],[1.0]]);
V.init(7,0,[I,vi,ii,iii,Isus4,V7],[[0.2,0.2,0.1,0.2,0.1,0.2],[0.2,0.1,0.1,0.2,0.2,0.2]]);
V7.init(7,5,[I,vi],[[0.8,0.2],[0.4,0.6]]);
vi.init(9,1,[I,ii,iii,IV,V,IIdim],[[0.2,0.2,0.1,0.3,0.1,0.1],[0.2,0.2,0.2,0.2,0.1,0.1]]);
Isus4.init(0,4,[I],[[1.0],[1.0]]);
VIsus4.init(9,4,[vi],[[1.0],[1.0]]);
VI.init(9,0,[VI,ii],[[0.1,0.9],[0.1,0.9]]);
III.setModulation([[VIsus4]],[-3],[I]);
I.setModulation([[VI],[I7],[VI]],[2,5,7],[I,I,V]);
Rhodey  instruments[4];
IntList beats;
IntList keys;
LinkedList chords;
chords.offer(I);
keys.offer(0);
beats.offer(4);
0=>int rhythmCounter;
fun void generateChords()
{
    chords.getLast() $ Chord @=> Chord lastChord;
    if (lastChord.getModulationSequence()!=null && Math.random2f(0, 1)<0.2)
    {
        lastChord.getModulationSequence()@=>Chord modSqs[][];
        lastChord.getModulationTarget()@=>int modKeys[];
        lastChord.getModulationChord()@=>Chord targetChords[];
        Math.random2f(0,modSqs.cap()) $ int  =>int choice;
        modSqs[choice]@=>Chord modSq[];
        modKeys[choice]=>int keyChange;
        targetChords[choice]@=>Chord targetChord;
        for (0=>int i; i<modSq.cap(); i++)
        {
            chords.offer(modSq[i]);
            keys.offer(keys.last.object);
        }
        chords.offer(targetChord);
        keys.offer((keys.last.object+keyChange+12)%12);
    }
    else
    {
        chords.offer(lastChord.getNextChord(1));
        keys.offer(keys.last.object);
    }
}
fun void generateBeats()
{
    Math.random2f(0,1) => float p;
    if (p<=0.6)
    {
        beats.offer(4);
    }
    else if (p<=0.7)
    {
        beats.offer(3);
        beats.offer(3);
        beats.offer(2);
    }
    else if (p<=0.8)
    {
        beats.offer(3);
        beats.offer(3);
        beats.offer(3);
        beats.offer(3);
    }
    else if (p<=0.9)
    {
        beats.offer(6);
        beats.offer(2);
    }
    else
    {
        beats.offer(3);
        beats.offer(2);
        beats.offer(3);
    }
}

fun void sendKey(){
	send.startMsg("/key", "i");
    keys.poll() => send.addInt;
	50::ms => now;
}

for (0=>int i; i < instruments.cap(); i++)
{
    //instruments[i]=>dac;
}

fun void playChord(Chord current, int key, int beat)
{
    if (beats.size==0)
    {
        generateBeats();
    }
    current.root=>int root;
    current.type=>int type;
    send.startMsg("/key/root/type", "i i i");
    key => send.addInt;
    root => send.addInt;
    type => send.addInt;
    current.getNotesWithin()@=>int notes[];
    <<< "Chord Name: ", current.toString() >>>;
    <<< "Sent key: ", key, "root: ", root, ", type: ", type >>>;
    <<< "Beats Played: ", beat>>>;
    for (0=>int j;j<beat;j++)
    {
        Math.random2f(1,2)::second=>now;
        float dyn;
        if (rhythmCounter == 0)
            0.2=>dyn;
        else if (rhythmCounter == 2)
            0.11=>dyn;
        else
            0.07=>dyn;
        Std.mtof(36+(key+notes[0]%12))=>instruments[0].freq;
        dyn=>instruments[0].noteOn;
        for (1=>int i; i < instruments.cap(); i++)
        {
            Std.mtof(48+(key+notes[i%notes.cap()])%12)=>instruments[i].freq;
            if (j==0)
                dyn=>instruments[i].noteOn;
            else if (Math.random2f(0,1)<0.7)
                dyn=>instruments[i].noteOn;
        }
        <<<"beat: ",  rhythmCounter>>>;
        (rhythmCounter+1)%4=>rhythmCounter;
    }
}

spork ~ sendKey();

while (true)
{
    if (chords.size<5)
    { 
        generateChords();
    }
    if (beats.size<5)
    {          
        generateBeats;
    }
    playChord(chords.poll()$Chord, keys.poll(), beats.poll());
}


