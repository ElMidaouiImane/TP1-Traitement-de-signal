<div align="center">
  <h1 align="center">TP1- Analyse spectrale d’un signal transformée de Fourier discrète</h1>
</div>


<summary>Table of Contents</summary>
  <ol>              
      <li><a href="#Objectifs">Objectifs</a></li>
      <li><a href="#Représentation temporelle et fréquentielle">Représentation temporelle et fréquentielle</a></li> 
      <li><a href="#Analyse fréquentielle du chant du rorqual bleu">Analyse fréquentielle du chant du rorqual bleu</a></li> 
  </ol>
  
  # Objectifs

> • Représentation de signaux et applications de la transformée de Fourier discrète
> (TFD) sous Matlab.  
> • Evaluation de l’intérêt du passage du domaine temporel au domaine fréquentiel
> dans l’analyse et l’interprétation des signaux physiques réels.
> 
> **Commentaires** : Il est à remarquer que ce TP traite en principe des signaux continus.
> Or, l'utilisation de Matlab suppose l'échantillonnage du signal. Il faudra donc être
> vigilant par rapport aux différences de traitement entre le temps continu et le temps
> discret.
> 
> **Tracé des figures** : toutes les figures devront être tracées avec les axes et les
> légendes des axes appropriés.
> 
> **Travail demandé** : un script Matlab commenté contenant le travail réalisé et des
> commentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a
> semblé intéressant ou pas, bref tout commentaire pertinent sur le TP.

# Représentation temporelle et fréquentielle

Considérons un signal périodique x(t) constitué d’une somme de trois sinusoïdes de fréquences 440Hz, 550Hz, 2500Hz.  
  𝐱(𝐭) = 𝟏. 𝟐𝐜𝐨𝐬(𝟐𝐩𝐢𝟒𝟒𝟎𝐭 + 𝟏. 𝟐) + 𝟑𝐜𝐨𝐬(𝟐𝐩𝐢𝟓𝟓𝟎𝐭) + 𝟎. 𝟔𝐜𝐨𝐬(𝟐𝐩𝐢𝟐𝟓𝟎𝟎𝐭)  <br /> <br />
  1- Tracer le signal x(t). Fréquence d’échantillonnage :   fe = 10000Hz, Intervalle :
Nombre d’échantillons : N = 5000. 
```matlab
fe = 1e4;
te = 1/fe;
N = 10000; 
%%
t = (0:N-1)*te; 
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
plot(t,x);
title('le signal');
```
![Signal](https://user-images.githubusercontent.com/121026639/210076143-85ac4739-76c5-438b-bbfe-d6655599fafb.png)  
Pour approximer la TF continue d’un signal x(t), représenté suivant un pas Te, on utilise les deux commandes : **fft** et **fftshift**.  <br /><br />
 • On remarquera que la TF est une fonction complexe et que la fonction ainsi obtenue décrit la TF de x(t) entre –1/(2Te) et 1/(2Te) par pas de 1/(nTe) où n
est le nombre de points constituant le signal x(t). <br /> 
• La commande fft codant les fréquences positives sur les n/2 premières valeurs du signal et les valeurs négatives entre n/2+1 et n, la commande fftshift permet
de les inverser.  <br /> <br />

2- Calculer la TFD du signal x(t) en utilisant la commande **fft**, puis tracer son spectre en amplitude après avoir créé le vecteur f qui correspond à l'échantillonnage du signal dans l'espace fréquentiel. Utiliser la commande **abs** pour afficher le spectre d’amplitude.  

```matlab
 f =(0:N-1)*(fe/N); 
 y = fft(x); 
 plot(f,abs(y));
 title('le spectre Amplitude avec fft');
 ```  
 ![Spectre fft](https://user-images.githubusercontent.com/121026639/210078411-6dde7707-5c52-4367-af1b-e50cc3c340a1.png)  
 
 3. Pour mieux visualiser le contenu fréquentiel du signal, utiliser la fonction **fftshift**, qui effectue un décalage circulaire centré sur zéro du spectre en amplitude obtenu par la commande fft.  
 
 ```matlab
 fshift = (-N/2:N/2-1)*(fe/N)
plot(fshift,fftshift(2*abs(y)/N));
title('le spectre Amplitude centré avec fftshift');
```  
![spectre fftshift](https://user-images.githubusercontent.com/121026639/210078825-f10313e7-ef28-43a2-ab98-888d9102319e.png)  
<br /><br />
Un bruit correspond à tout phénomène perturbateur gênant la transmission ou l'interprétation d'un signal. Dans les applications scientifiques, les signaux sont souvent corrompus par du bruit aléatoire, modifiant ainsi leurs composantes fréquentielles. La TFD peut traiter le bruit aléatoire et révéler les fréquences qui y correspond. <br /><br />
4- Créer un nouveau signal xnoise, en introduisant un bruit blanc gaussien dans le signal d’origine x(t), puis visualisez-le. Utiliser la commande **randn** pour générer ce bruit. Il est à noter qu’un bruit blanc est une réalisation d'un processus aléatoire dans lequel la densité spectrale de puissance est la même pour toutes les fréquences de
la bande passante. Ce bruit suit une loi normale de moyenne 0 et d’écart type 1.  

```matlab
bruit = 20*randn(size(x));%bruit
xnoise = x+bruit; % signal+bruit
plot(xnoise);
title('le signal bruité');
```   
![bruité 1](https://user-images.githubusercontent.com/121026639/210085245-e2c9590f-07c0-477e-8b51-343be11df2b3.png)

 
<br /><br />
5 – Utiliser la commande sound pour écouter le signal et puis le signal bruité.  
```matlab
sound(x) %le signal
sound(xnoise) %le signal bruité
```  
<br /><br />
La puissance du signal en fonction de la fréquence (densité spectrale de puissance) est une métrique couramment utilisée en traitement du signal. Elle est définie comme
étant le carré du module de la TFD, divisée par le nombre d'échantillons de fréquence.<br /><br />
6- Calculez puis tracer le spectre de puissance du signal bruité centré à la fréquence zéro.  
```matlab
ybruit = fft(xnoise); % le spectre de signal+bruit
plot(fshift,fftshift(abs(ybruit)));
title('le spectre Amplitude de signal+bruit centré');
```  
![spectre bruité 1](https://user-images.githubusercontent.com/121026639/210085315-770ffbac-9a50-44f1-b97f-b4d188062553.png)

<br /><br />
7- Augmenter l’intensité de bruit puis afficher le spectre. Interpréter le résultat obtenu.  
```matlab
bruit = 50*randn(size(x));%bruit
xnoise = x+bruit; % signal+bruit
ybruit = fft(xnoise); % le spectre de signal+bruit
plot(fshift,fftshift(abs(ybruit)));
title('le spectre Amplitude de signal+bruit centré');
```  

![spectre bruité](https://user-images.githubusercontent.com/121026639/210085537-727ec133-496b-4085-ab69-75b3b6b57a3a.png)
##### Interprétation  
plus l'intensité de bruit augmente on perd le signal informative 
<br /><br /><br />
# Analyse fréquentielle du chant du rorqual bleu  

Il existe plusieurs signaux dont l’information est encodée dans des sinusoïdes. Les ondes sonores est un bon exemple. Considérons maintenant des données audios collectées à partir de microphones sous - marins au large de la Californie. On cherche à détecter à travers une analyse de Fourier le contenu fréquentiel d’une onde sonore émise pas un rorqual bleu.  <br /><br />
1- Chargez, depuis le fichier **‘bluewhale.au’**, le sous-ensemble de données qui correspond au chant du rorqual bleu du Pacifique. En effet, les appels de rorqual bleu sont des sons à basse fréquence, ils sont à peine audibles pour les humains. Utiliser la commande **audioread** pour lire le fichier. Le son à récupérer correspond aux indices allant de 2.45e4 à 3.10e4.  
```matlab
[x,fs] = audioread("bluewhale.au");
chant = x(2.45e4:3.10e4);
```  
<br /><br />
2- Ecoutez ce signal en utilisant la commande sound, puis visualisez-le.  
```matlab
sound(x,fs)

N=length(chant);
ts=1/fs;
t=(0:N-1)*(10*ts);
plot(t,chant);
title('Le signal')
```
![échantillion](https://user-images.githubusercontent.com/121026639/210089458-fc1dfb12-a500-4f4d-8f56-3576abc7df06.png)
<br /><br />
La TFD peut être utilisée pour identifier les composantes fréquentielles de ce signal audio. Dans certaines applications qui traitent de grandes quantités de données avec
fft, il est courant de redimensionner l'entrée de sorte que le nombre d'échantillons soit une puissance de 2. fft remplit automatiquement les données avec des zéros pour augmenter la taille de l'échantillon. Cela peut accélérer considérablement le calcul de la transformation.<br /><br />
3- Spécifiez une nouvelle longueur de signal qui sera une puissance de 2, puis tracer la densité spectrale de puissance du signal.
```matlab
dsp_chant = (abs(fft(chant)).^2)/N;
f = (0:floor(N/2))*(fs/N)/10;
plot(f,dsp_chant(1:floor(N/2)+1))
title('le spectre')
```
![densité spectrale](https://user-images.githubusercontent.com/121026639/210089890-a1fdf5bc-491a-4ded-8a2b-370e051089db.png)
<br /><br />
4- Déterminer à partir du tracé, la fréquence fondamentale du gémissement de rorqual bleu.  <br /><br />
c'est la fréquence de premier pic (16 Hz-17 Hz)


![fréquence](https://user-images.githubusercontent.com/121026639/210090738-23b442bd-1414-4504-af4c-32abf920c391.png)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
<h4> Réalisé par : EL MIDAOUI Imane  </h4> <br/> 
 > Encadré par  : [Pr. AMMOUR Alae]

  
