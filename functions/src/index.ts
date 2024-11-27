import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Firebase Admin SDK
admin.initializeApp();

exports.notifyNewArticle = functions.database
  .ref("/offres_emploi") // Adjust the path to match your database structure
  .onCreate((snapshot: { val: () => any }) => {
    const newOffer = snapshot.val(); // Get the new article data
    const payload = {
      notification: {
        title:
          "Une nouvelle offre d'emploi a été publiée. Etes-vous intéressez",
        body: `Profile recherché: ${newOffer.search_Offer}`,
      },
    };

    // Send notification to all users subscribed to the "articles" topic
    return admin
      .messaging()
      .sendToTopic("offres_emploi", payload)
      .then(() => {
        console.log("Notification sent successfully!");
      })
      .catch((error: any) => {
        console.error("Error sending notification:", error);
      });
  });
