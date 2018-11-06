-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: mysql.nekomusume.net    Database: tantocuore
-- ------------------------------------------------------
-- Server version	5.6.34-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cardlist`
--

DROP TABLE IF EXISTS `cardlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cardlist` (
  `ID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `cardnumber` tinyint(2) NOT NULL,
  `gameset` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cost` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `chambermaid` enum('n','y') NOT NULL DEFAULT 'n',
  `vp` enum('n','y') NOT NULL DEFAULT 'n',
  `attack` enum('n','y') NOT NULL DEFAULT 'n',
  `buildings` enum('n','y') NOT NULL DEFAULT 'n',
  `reminiscences` enum('n','y') NOT NULL DEFAULT 'n',
  `events` enum('n','y') NOT NULL DEFAULT 'n',
  `private` enum('n','y') NOT NULL DEFAULT 'n',
  `beer` enum('n','y') NOT NULL DEFAULT 'n',
  `description` text,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `ID_2` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cardlist`
--

LOCK TABLES `cardlist` WRITE;
/*!40000 ALTER TABLE `cardlist` DISABLE KEYS */;
INSERT INTO `cardlist` VALUES (1,3,1,7,'Anise Greenaway','Treasury Maid','n','y','n','n','n','n','n','n','VP: 3<br />[Draw +3]<br />[Employment +1]'),(2,4,1,6,'Ophelia Grail','All-Purpose Maid','n','y','n','n','n','n','n','n','VP: ?<br />[Draw +1]<br />[Love +1]<br />[Serving +1]<br />[Employment +1]<br /><b>------ At the end of the game ------</b><br />If you have more than 1 Ophelia in your deck they are worth 2 VP each if you have an odd number total.  If they are of an even number total they are worth -2 VP each.'),(3,5,1,5,'Sainsbury Lockwood','Laundry Maid','n','n','n','n','n','n','n','n','You may exchange one \'1 Love\' from your hand with either a \'2 Love\' or a Maid with an employ cost of 4 or less from the town.'),(4,6,1,5,'Tenalys Trent','Nap Maid','n','n','n','n','n','n','n','n','[Love +3]<br />[Employment +1]<br />Each other player draws a card.'),(5,7,1,5,'Natsumi Fujikawa','Cleaning Maid','n','n','y','n','n','n','n','n','[Draw +1]<br />[Serving +2]<br />You may discard 1 card from your hand.  If you do, each other player with 4 or more cards in hand chooses and discards a card.'),(6,8,1,5,'Nena Wilder','Teasing Maid','n','n','y','n','n','y','n','n','[Love +1]<br />The player(s) sitting to your left and your right side must, if they have any Maids in their Private Quarters, take one Bad Habit and place it in their Private Quarters.'),(7,9,1,4,'Esquine Forêt','Scrapping Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />You may discard up to 2 cards from your hand.  If you do, you gain 1 Serving per card discarded.'),(8,10,1,4,'Geneviève Daubigny','Cooking Maid','n','n','n','n','n','n','n','n','[Draw +1]<br />[Love +1]<br />[Serving +1]'),(9,11,1,4,'Moine de Lefèvre','Employing Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />[Employment +2]'),(10,12,1,3,'Eliza Rosewater','Policing Maid','n','n','y','n','n','n','n','n','[Love +2]<br />You may look at the top card of any player\'s deck (including yours) and then decide whether to send that card into their discard pile or not.'),(11,13,1,3,'Kagari Ichinomiya','Sewing Maid','n','n','n','n','n','n','n','n','[Serving +2]'),(12,14,1,3,'Claire Saint-Juste','White Maid','n','n','n','n','n','y','n','n','[Serving +1]<br />You may return one Event card in your Private Quaters to town.<br /><b>------&nbsp;When&nbsp;an&nbsp;Event&nbsp;is&nbsp;placed&nbsp;in&nbsp;your&nbsp;Private&nbsp;Quarters&nbsp;------</b><br />You may reveal this card from your hand.  If you do, return that Event to town.'),(13,15,1,3,'Safran Virginie','Chambermaid','y','y','n','n','n','n','n','n','VP: ?<br />[Love +2]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />For each set of Safran you have as Chambermaids, you gain additional VP.<br />2 Safran = 4 VP / 3 Safran = 8 VP / 4 Safran = 12 VP'),(14,16,1,2,'Azure Crescent','Chambermaid','y','y','n','n','n','n','n','n','VP: 1<br />[Employment +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />For each set of two or three Crescent sisters you have as Chambermaid, you get bonus VP.<br />Each set of 2 different sisters = 3 VP<br />Each set of all 3 sisters = 7 VP'),(15,17,1,2,'Viola Crescent','Chambermaid','y','y','n','n','n','n','n','n','VP: 1<br />[Draw +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />For each set of two or three Crescent sisters you have as Chambermaid, you get bonus VP.<br />Each set of 2 different sisters = 3 VP<br />Each set of all 3 sisters = 7 VP'),(16,18,1,2,'Rouge Crescent','Chambermaid','y','y','n','n','n','n','n','n','VP: 1<br />[Love +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />For each set of two or three Crescent sisters you have as Chambermaid, you get bonus VP.<br />Each set of 2 different sisters = 3 VP<br />Each set of all 3 sisters = 7 VP'),(17,3,2,7,'Tiffany Wise','Staff Maid','n','y','n','n','n','n','y','n','VP: 2<br />[Love +3]<br />You may exchange the top of your Private Maids for one of the Private Maids available in the town.  The Private Maid you get rid of is put face down on the bottom of the Private Maid pile.'),(18,4,2,5,'Carillon Vandoor','Governess Maid','n','n','n','n','n','n','n','n','[Draw +3]'),(19,5,2,5,'Francine Barbier','Library Maid','n','n','n','n','n','n','n','n','[Serving +2]<br />You may return two \'2 Love\' cards from your hand to town to get one Maid Chief of your choice from the town.'),(20,6,2,5,'Renée R. Rieussec','Pet Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />[Serving +1]<br />If you have 6 or more cards in your hand, you must return a card from your hand to the top of your deck.'),(21,7,2,4,'Domino Bonaparte','Black Maid','n','y','y','n','n','n','n','n','VP: ?<br />[Draw +2]<br />[Employment +1]<br />After her serving, you may [Serving -1] to send her to any player\'s Private Quarters as a Chambermaid.<br /><b>------ During your Serving Phase ------</b><br />Return this card to town &#8658; [Serving -2]<br /><b>------ Chambermaid bonus ------</b><br />Each Domino is worth -2 VP'),(22,8,2,4,'Amaretto Renard','Dressing Maid','n','n','n','n','n','n','n','n','During this turn, you treat the \'2 Love\' cards as cost 2 and the \'3 Love\' cards as cost 4.'),(23,9,2,4,'Victoria Calderan','Destruction Maid','n','n','y','y','n','n','n','n','[Love +2]<br />Discard the top card of your deck and an opponent\'s deck.  If your discarded card was of an employ cost of 2 or more than the opponent\'s, you may return one of their buildings to town.'),(24,10,2,4,'Emily Raymond','Architect Maid','n','n','n','y','n','n','n','n','[Serving +2]<br />[Employment +1]<br />During this turn, your cost for each building is reduced by 1 (to a minimum of 1)'),(25,11,2,3,'Rutile der Sar','Ninja Maid','n','n','y','n','n','n','n','n','Discard the top card of any player\'s deck.  Gain the following bonus based on the card type.<br />Love &#8658; [Love +2]<br />General Maid &#8658; [Serving +2]<br />Maid Chief &#8658; [Draw +2]'),(26,12,2,3,'Phyllis Lumley','Guest Room Maid','n','n','n','n','n','n','n','n','[Love +2]<br />You may discard the top card of your deck.  If it was a card with an employ cost of 5 or more, you gain an additional [Love +1]'),(27,13,2,3,'Lilac Hawkwind','Bodyguard Maid','n','n','y','n','n','n','n','n','All players must discard the top card of their deck.  After that, put a love or maid card from town costing 4 or less on top of your deck.'),(28,14,2,3,'Felicity Horn','Chambermaid','y','y','n','n','n','n','n','n','VP: ?<br />[Love +1]<br />You may chambermaid a \'Chambermaid Chief\' from your hand for free.<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />2 Felicity = 4 VP / 3 Felicity = 8 VP / 4 Felicity = 12 VP'),(29,15,2,3,'Suzuna Kamikawa','Chambermaid','y','y','n','n','n','n','n','n','VP: 1<br />[Draw +1]<br />[Serving +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />3 Suzuna = 5 VP'),(30,16,2,3,'Grace Saulsbury','Parlor Maid','n','n','y','n','n','n','n','n','[Love +1]<br />You may place any maid costing 3 or less from the town in any player\'s discard pile.'),(31,17,2,2,'Pauline Dumond','Tea Maid','n','n','n','n','n','n','n','n','[Serving +1]<br />You may discard two identical cards from your hand.  If you do, draw 3 cards.'),(32,18,2,2,'Ririko Hiiragi','Chambermaid','y','y','n','y','n','n','n','n','VP: 1<br />[Love +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />As long as Ririko is your chambermaid, you may treat \'Lily Gardens\' as if they cost 5.'),(33,3,3,7,'Fryda Viento','Oceanographer Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />[Love +2]<br />[Employment +2]'),(34,4,3,6,'Laura','Island Folk Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />You may chambermaid any number of Chambermaids or Chambermaid Chiefs from your hand for free.'),(35,5,3,6,'Clorinde Sea','Mer Maid','n','y','n','n','n','n','n','n','VP: 2<br />[Draw +1]<br />[Serving +2]<br /><b>------ At the end of the game ------</b><br />If you have employed 7 or more Maid Chiefs and/or Chambermaid Chiefs, Clorinde is worth 0 VP instead of 2 VP.'),(36,6,3,5,'Lydia Leon','Adventurer Maid','n','n','n','n','n','n','n','n','[Serving +1]<br />Reveal the top 5 cards of your deck.  Choose one of those cards.  Put the chosen card into your hand and the rest into your discard pile.'),(37,7,3,5,'Florence Spring','Chambermaid','y','y','n','n','n','n','n','n','VP: ?<br />[Love +2]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />If you have 7 or more Chambermaids or Chambermaid Chiefs in your Private Quarters, Florence grants an additional 5 VP.'),(38,8,3,5,'Cynthia Lakes','Nap Maid','n','n','n','n','n','n','n','n','[Draw +4]<br />Each other player draws a card.'),(39,9,3,4,'Caldina Alley','Sea Bear Maid','n','n','y','n','n','n','n','n','[Draw +2]<br />Each other player with 5 or more cards in their hand chooses one card from their hand and puts it on bottom of their deck.'),(40,10,3,4,'Riya Naragashi','Fireworks Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />You may return this card to the Town. If you do, your Serving Phase and Employ Phase end immediately and the number of cards you draw in the Discard Phase is increased by 5.'),(41,11,3,4,'Chinatsu Kooriyama','Interpreter Maid','n','n','n','n','n','n','n','n','You may return 2 maid cards fom your hand to the Town.  Of you do, take one maid card from the Town with an employ cost 7 or less and add it to your hand.'),(42,12,3,4,'Fea Primrose','Beach Maid','n','n','n','n','n','n','n','n','[Serving +2]<br />[Employment +1]'),(43,13,3,4,'Romina Vautrin','Job-skipping Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />[Love +2]<br />Your Serving Phase ends immediately.'),(44,14,3,3,'Daphne Coraille','Sea Folk Maid','n','n','n','n','n','n','n','n','[Serving +1]<br />Put one \'2 Love\' card from the Town on top of your deck.'),(45,15,3,3,'Margareta Torrente','Island Food Maid','n','y','n','n','n','n','n','n','VP: ?<br />[Draw +1]<br />[Love +1]<br />[Serving +1]<br /><b>------ At the end of the game ------</b><br />If you have employed 3 or more Margareta, they are worth -1 VP.'),(46,16,3,3,'Germaine Mahle','Juice Serving Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />You may put a Chambermaid Chief with employ cost 3 or less from the Town into your Discard Pile.  If you do, draw a card.'),(47,17,3,3,'Evita Catala','Watermelon Smashing Maid','n','n','y','n','n','n','n','n','[Love +1]<br />[Serving +1]<br />Put the top card of any player\'s deck into their Discard Pile.  If the discarded card was a \'Love\' card, you gain extra [Serving +1]'),(48,18,3,3,'Valencia Pretre','Chambermaid','y','y','n','n','n','n','n','n','VP: 1<br />[Love +2]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />During your starting phase, you may put your chambermaided Valencia into your Discard Pile.  If you do, draw two cards.'),(49,19,3,2,'Hyacinth Arrow','Chambermaid','y','y','n','n','y','n','n','n','VP: ?<br />[Love +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />If you have two or more Reminiscence cards in your Private Quarters, Hyacinth is worth an additional 2 VP.'),(50,20,3,2,'Nonnette Soyeux','Dolphin Caretaker Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />[Employment +2]<br />You may put a card from your hand on top of your deck.'),(51,3,4,7,'Elsa Reinmaier','Total Management Maid','n','y','y','n','n','n','n','n','VP: 2<br />[Employment +2]<br />Draw 3 cards.  Afterwards, every player who has 4 or more cards in their hand chooses and discards a card from their hand.'),(52,4,4,6,'Hermina Baum','Money Keeper Maid','n','y','n','n','n','n','n','n','VP: 1<br />[Love +3]<br />After you draw your new hand at your Discard phase of this turn, you may discard a card from your hand and draw a card.'),(53,5,4,5,'Toni Darling','Confectionary Maid','n','n','n','n','n','n','n','n','[Draw +1]<br />[Love +1]<br />[Serving +1]<br />You may discard a card from your hand.  If you do, gain Employment +1.'),(54,6,4,5,'Nora Morgenstern','Negotiation Maid','n','n','n','n','n','n','n','n','[Serving +2]<br />You may pay 1 Serving.  If you do, reveal 2 cards from the top of your deck.  Put all of the Love cards into your hand, and discard all the rest.'),(55,7,4,5,'Nadja Kersten','Bar Maid','n','n','n','n','n','n','n','y','[Love +1]<br />When you employ Nadja, you may gain a Beer card for 1 Love.<br /><br />You may discard a Love card from your hand and pay 1 Serving.  If you do, gain a Beer card.'),(56,8,4,4,'Gina Kersten','Bar Maid','n','n','n','n','n','n','n','y','[Draw +1]<br />When you employ Gina, you may gain a Beer card for 2 Love.<br /><br />During your Employ phase you may gain a Beer card for 4 Love.'),(57,9,4,4,'Sara Leonhardt','Floor Assistant Maid','n','n','n','n','n','n','n','n','[Love +2]<br />You may put a chambermaid card from your Private Quarters onto the Discard pile.  If you do, gain Serving +2.'),(58,10,4,4,'Julia Kunster','Potter Ware Maid','n','n','n','n','n','n','n','y','[Draw +2]<br />[Employment +1]<br />Sneak a peek at 2 cards from the top of the Beer deck.  You may change the order of the cards.'),(59,11,4,4,'Kirika von Heidemann','Welfare Maid','n','n','n','n','n','n','n','n','[Draw +2]<br />During this turn, you treat the Chambermaid Chief cards in your hand as &quot;1 Love&quot; cards.'),(60,12,4,3,'Anna Hartmann','Silver Tableware Maid','n','n','y','n','n','n','n','n','[Serving +2]<br />When you employ Anna, you may discard the top card of any player\'s deck.'),(61,13,4,3,'Renata Abendroth','Punishing Maid','n','n','y','n','n','n','n','n','[Love +2]<br />Choose a number and a player with 5 or more cards in their hand.  That player discards a card that has employ cost the same as the chosen number from his hand.'),(62,14,4,3,'Aileen Hammerschmidt','Gambler Maid','n','n','n','n','n','n','n','n','You may discard up to two cards from your hand.  Draw the same amount of cards as were discarded.'),(63,15,4,3,'Ute Krombach','Chambermaid','y','y','n','n','n','n','n','y','VP: ?<br />[Employment +1]<br />Draw an additional card when you draw your new hand at your Discard phase this turn.<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />if your Alcohol level is between 2 to 9, this card is worth 2 VP instead of 1.'),(64,16,4,3,'Kaori Hamasaki','Chambermaid','y','y','n','n','n','n','n','n','VP: ?<br />[Love +1]<br />Chambermaid &#8658; [Serving -1]<br /><b>------ Chambermaid bonus ------</b><br />3 Kaori = 12 VP, 2 Kaori = 2 VP, 1 Kaori = 1 VP.'),(65,17,4,2,'Paula Lauenburg','Weathercast Maid','n','n','y','n','n','n','n','n','You may discard the top card of any player\'s deck.  You can use the card\'s ability and bonus as though you had played the card.  If the discarded card was a Love card, gain that much Love.'),(66,18,4,2,'Nicole Schmieg','Apprentice Maid','n','n','y','n','n','n','n','n','When you employ this card, put it onto any player\'s discard pile.<br /><br />Return 2 Nicole to the Town from your hand.  If you do, gain a general maid card with employ cost 5 or less.  (This ability does not require a serving)'),(67,27,101,5,'Arisa Hayakawa','Cleaning Maid','n','n','n','n','n','y','n','n','[Serving +2]<br />[Employment +1]<br />You may pay 2 Servings.  If you do, select an Event card in your Private Quarters, and return it to the Town.  Gain Love equal to half (round down) the Employ cost of the card you returned this way.');
/*!40000 ALTER TABLE `cardlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-05 17:08:24
