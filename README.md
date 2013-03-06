Perseus-Word-Search
===================

A graphical interface for Mac OS X to browse the greek word database of Perseus (http://www.perseus.tufts.edu/)

The application is based on Librum objective-C library; all files of this library has the prefix 'LBR'.


Usage
=====
When you start the application, you'll have an empty word list. To populate the list, you've two ways:

* open a XML file, with the Perseus syntax.
 It takes some times to parse the xml file.
 **Note:** you can find the whole file with all greek forms in Perseus Hopper:
download the source [[1]] and navigate to sgml/xml/data, the file is greek.morph.xml;
but actually is too big to be parsed from the application. Maybe future version will resolve this limitation.

* open an archive file that you've previously saved.
 Archive file contains the same information of xml file but it's much more fast to load.

You can find the file containing all greek verbs in this repository.

After you've populate the list, you can filter it using the search field.
You can use a latin keyboard, mapping between latin and greek characters is as follow (beta code convention [[2]]):

a:ALPHA
b:BETA
g:GAMMA
d:DELTA
e:EPSILON
z:ZETA
h:ETA
q:THETA
i:IOTA
k:KAPPA
l:LAMBDA
m:MI
n:NI
c:XI
o:OMICRON
p:PI
r:RHO
s:SIGMA
t:TAU
u:UPSILON
f:PHI
x:CHI
y:PSI
w:OMEGA

Copyright
=========
**Perseus database copyrights**

Tufts University holds the overall copyright to the Perseus Digital Library; the materials therein are provided for the personal use of students, scholars, and the public. Any commercial use or publication without authorization is strictly prohibited. Copyright is protected by the copyright laws of the United States and the Universal Copyright Convention.
For more information: www.perseus.tufts.edu

**Source coide - Librum library**

All the source code in this repository is developed by Librum.
For more information: www.librum.it


[1]: http://sourceforge.net/projects/perseus-hopper/
[2]: http://en.wikipedia.org/wiki/Beta_code
