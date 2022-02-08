const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializbapp();
exports.myFunction= functions.firestore
  .document('chat/{message}')
  .onCreate((snapShot, context) =>{
       return admin.messaging().sendToTopic('chat', {
           notification: 
               {
                title: snapShot.data().username,
                body: snapShot.data().text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            },
       });
  });