Nom du projet : TD5
Binomes : Landraudie Marine et Maciolek Sebastian
Temps : 2 semaines (2 séances)

Tâches à réaliser : (lien du pdf http://dam.lanoosphere.com/Sd7g1fg5fd/dam_td5.pdf)

1 Mise en place projet

En cours - Créer un écran d'attente pour le chargement des données (objet UIActivityIndicatorView)
En cours - Paser les données du xml http://dam.lanoosphere.com/poi.xml

2 Affichage de POIs sur la carte

- Créer UINavigationController ayant pour rootViewController un object UIViewController nommé "MapViewController"
- Ajouter un objet MKMapView au MapViewController
- Ajouter un "pin" pour chaque POI
- Faites un reverse geocoding des coordonnées de chaque POI pour en récupérer l'adresse
- Centrer la carte sur Cannes - 43.551534,7.016659
- Créer un zoom permettant de voir les POIs dans l'ensemble
- Afficher la position de l'utilisateur
- Reproduire le design imposé
- Mettre en place un bouton i affichant la fiche détail du POI en pushant le viewCotnroller 

3 Fiche détail

- Créer un bouton pour lancer u appel vers le numéro du POI (attention au format)
- Créer un bouton pour afficher l'itinéraire dans l'application Apple Maps (quit current app)
- Ajouter une map
- tracer le trajet entre la position actuelle du device jusqu'au POI
- implémenter une fonction "share" qui permet de partager le nom et la photo du POI en utilisant UIActivityViewController
- charger l'imagine du POI de manière asynchrone

Tâches en cours :


Tâches terminés :
- Créer une nouveau projet vide