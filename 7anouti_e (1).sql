-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2026 at 05:23 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `7anouti_e`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerte_ia`
--

CREATE TABLE `alerte_ia` (
  `id_alerte` int(11) NOT NULL,
  `id_vendeur` int(11) NOT NULL,
  `id_produit` int(11) DEFAULT NULL,
  `type_alerte` enum('STOCK_CRITIQUE','VENTE_FAIBLE','OPPORTUNITE','CONSEIL_EXPIRE') DEFAULT 'OPPORTUNITE',
  `message` text NOT NULL,
  `niveau` enum('INFO','AVERTISSEMENT','URGENT') DEFAULT 'INFO',
  `score_sante` int(11) DEFAULT NULL,
  `lu` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alerte_ia`
--

INSERT INTO `alerte_ia` (`id_alerte`, `id_vendeur`, `id_produit`, `type_alerte`, `message`, `niveau`, `score_sante`, `lu`, `created_at`) VALUES
(1, 1, 21, 'VENTE_FAIBLE', 'Chargeur #21 Score sante 18/100 Stock critique 80 unites 0 vente ce mois', 'URGENT', 18, 0, '2026-05-02 10:19:01'),
(2, 1, NULL, 'CONSEIL_EXPIRE', '3 conseils non appliques depuis 14 jours Canal EMAIL recommande', 'AVERTISSEMENT', NULL, 0, '2026-05-02 10:19:01'),
(3, 1, NULL, 'OPPORTUNITE', 'Campagne Fidelite VIP performante ROI 340% Meilleur canal EMAIL', 'INFO', NULL, 0, '2026-05-02 10:19:01');

-- --------------------------------------------------------

--
-- Table structure for table `campagne_marketing`
--

CREATE TABLE `campagne_marketing` (
  `id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `type_action` varchar(100) DEFAULT NULL,
  `objectif` enum('VENTES','VISIBILITE','FIDELISATION') DEFAULT 'VENTES',
  `statut` enum('BROUILLON','ACTIVE','TERMINEE','PAUSEE') DEFAULT 'BROUILLON',
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `budget_alloue` decimal(10,2) DEFAULT 0.00,
  `budget_depense` decimal(10,2) DEFAULT 0.00,
  `revenu_genere` decimal(10,2) DEFAULT 0.00,
  `nb_clics` int(11) DEFAULT 0,
  `score_ia` float DEFAULT NULL,
  `conseil_ia` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campagne_marketing`
--

INSERT INTO `campagne_marketing` (`id`, `vendor_id`, `nom`, `type_action`, `objectif`, `statut`, `date_debut`, `date_fin`, `budget_alloue`, `budget_depense`, `revenu_genere`, `nb_clics`, `score_ia`, `conseil_ia`) VALUES
(2, 1, 'SAINTVALENTEIN', 'PROMOTION', 'VISIBILITE', 'TERMINEE', '2024-06-01', '2024-08-31', 5000.00, 800.00, 6000.00, 0, 6.2, 'Taux de clic faible. Essayer le canal SMS.'),
(3, 1, 'Fidelite VIP', 'EMAIL', 'FIDELISATION', 'TERMINEE', '2024-05-01', '2024-12-31', 3000.00, 200.00, 9900.00, 0, 9.1, 'Meilleure campagne active. Email tres efficace.'),
(10, 1, 'RAMDAN', 'EMAIL', 'VENTES', 'TERMINEE', '2026-05-07', '2026-05-13', 123.00, 0.00, 0.00, 0, 0, NULL),
(11, 1, 'RAMADAN', 'EMAIL', 'FIDELISATION', 'BROUILLON', '2026-05-21', '2026-06-16', 77.00, 0.00, 0.00, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `conseils_ia`
--

CREATE TABLE `conseils_ia` (
  `id_conseil` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `urgence` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `etat` varchar(50) DEFAULT 'NOUVEAU',
  `id_produit` varchar(255) DEFAULT NULL,
  `date_genere` datetime DEFAULT current_timestamp(),
  `date_accepte` datetime DEFAULT NULL,
  `date_expiration` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `conseils_ia`
--

INSERT INTO `conseils_ia` (`id_conseil`, `type`, `urgence`, `description`, `score`, `etat`, `id_produit`, `date_genere`, `date_accepte`, `date_expiration`) VALUES
(2, 'Promotion', 'Eleve', 'Le produit #21 a ete vu 3 fois. Lance une promo -10% cette semaine.', 92, 'NOUVEAU', '21', '2026-05-04 00:00:00', NULL, NULL),
(5, 'Bundle', 'Moyen', 'Offre groupee Chargeur Rapide 65W + Cable USB-C -15%.', 68, 'NOUVEAU', '11', '2026-05-04 00:00:00', NULL, NULL),
(6, 'Promotion', 'Moyen', 'Les Masques Chirurgicaux x50 (id=27) sont peu cliques.', 75, 'NOUVEAU', '27', '2026-05-04 00:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `produit`
--

CREATE TABLE `produit` (
  `id_produit` int(11) NOT NULL,
  `id_vendeur` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `categorie` enum('ALIMENTAIRE','ELECTRONIQUE','MEDICAMENT','HYGIENE','DECOR','MAKEUP','AUTRE') NOT NULL,
  `prix` double NOT NULL,
  `quantite_stock` int(11) NOT NULL DEFAULT 0,
  `seuil_alerte` int(11) NOT NULL DEFAULT 5,
  `statut` enum('ACTIF','SUSPENDU','SUPPRIME') NOT NULL DEFAULT 'ACTIF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produit`
--

INSERT INTO `produit` (`id_produit`, `id_vendeur`, `nom`, `description`, `categorie`, `prix`, `quantite_stock`, `seuil_alerte`, `statut`) VALUES
(1, 1, 'Huile d Olive 1L', 'Huile d olive extra vierge', 'ALIMENTAIRE', 45, 80, 10, 'ACTIF'),
(11, 1, 'Chargeur Rapide 65W', 'Chargeur USB-C rapide', 'ELECTRONIQUE', 35, 100, 20, 'ACTIF'),
(12, 1, 'Cable USB-C 2m', 'Cable de charge et donnees', 'ELECTRONIQUE', 15, 150, 30, 'ACTIF'),
(21, 1, 'Paracetamol 500mg', 'Boite de 20 comprimes', 'MEDICAMENT', 4.5, 200, 30, 'ACTIF'),
(27, 1, 'Masques Chirurgicaux x50', 'Masques jetables 3 plis', 'MEDICAMENT', 10, 120, 20, 'ACTIF');

-- --------------------------------------------------------

--
-- Table structure for table `statistiques_ventes`
--

CREATE TABLE `statistiques_ventes` (
  `id` int(11) NOT NULL,
  `id_vendeur` int(11) NOT NULL,
  `id_produit` int(11) NOT NULL,
  `reference` varchar(100) NOT NULL,
  `periode` date NOT NULL,
  `nb_ventes` int(11) NOT NULL DEFAULT 0,
  `revenu_total` double DEFAULT 0,
  `taux_retour` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `statistiques_ventes`
--

INSERT INTO `statistiques_ventes` (`id`, `id_vendeur`, `id_produit`, `reference`, `periode`, `nb_ventes`, `revenu_total`, `taux_retour`) VALUES
(1, 1, 21, 'REF-CHARGEUR', '2024-05-01', 42, 5040, 1.2),
(2, 1, 18, 'REF-CABLE', '2024-05-01', 28, 1960, 2.5);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `date_naiss` varchar(50) DEFAULT NULL,
  `e_mail` varchar(150) NOT NULL,
  `num_tel` varchar(20) DEFAULT NULL,
  `mot_de_pass` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `role` enum('admin','acheteur','vendeur','livreur') NOT NULL DEFAULT 'acheteur',
  `status` enum('Banned','Unbanned') NOT NULL DEFAULT 'Unbanned',
  `face_id_enabled` tinyint(1) DEFAULT 0,
  `face_image_path` varchar(255) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `entreprise` varchar(255) DEFAULT NULL,
  `type_produit` varchar(255) DEFAULT NULL,
  `vehicule` varchar(100) DEFAULT NULL,
  `permis` varchar(100) DEFAULT NULL,
  `zone_livraison` varchar(255) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nom`, `prenom`, `date_naiss`, `e_mail`, `num_tel`, `mot_de_pass`, `image`, `role`, `status`, `face_id_enabled`, `face_image_path`, `adresse`, `entreprise`, `type_produit`, `vehicule`, `permis`, `zone_livraison`, `email_verified`) VALUES
(1, 'Vendeur', 'Demo', '1990-05-15', 'vendeur@7anouti.tn', NULL, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, 'vendeur', 'Unbanned', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2, 'Ben Salah', 'Ahmed', '1990-05-15', 'ahmed.bensalah@email.tn', '21655123456', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, 'vendeur', 'Unbanned', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerte_ia`
--
ALTER TABLE `alerte_ia`
  ADD PRIMARY KEY (`id_alerte`);

--
-- Indexes for table `campagne_marketing`
--
ALTER TABLE `campagne_marketing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conseils_ia`
--
ALTER TABLE `conseils_ia`
  ADD PRIMARY KEY (`id_conseil`);

--
-- Indexes for table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id_produit`);

--
-- Indexes for table `statistiques_ventes`
--
ALTER TABLE `statistiques_ventes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `e_mail` (`e_mail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerte_ia`
--
ALTER TABLE `alerte_ia`
  MODIFY `id_alerte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `campagne_marketing`
--
ALTER TABLE `campagne_marketing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `conseils_ia`
--
ALTER TABLE `conseils_ia`
  MODIFY `id_conseil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `produit`
--
ALTER TABLE `produit`
  MODIFY `id_produit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `statistiques_ventes`
--
ALTER TABLE `statistiques_ventes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
