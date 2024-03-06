-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `surname` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `contrasena` VARCHAR(191) NOT NULL,
    `edad` INTEGER NOT NULL,
    `celular` INTEGER NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Prenda` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NOT NULL,
    `stock` INTEGER NOT NULL,
    `precio` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idPrenda` INTEGER NOT NULL,
    `text` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Comment_idPrenda_key`(`idPrenda`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Articulo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Categoria` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `idPrenda` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Compra` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idPrenda` INTEGER NOT NULL,
    `idUser` INTEGER NOT NULL,
    `idComment` INTEGER NOT NULL,
    `fechaCompra` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Compra_idPrenda_key`(`idPrenda`),
    UNIQUE INDEX `Compra_idUser_key`(`idUser`),
    UNIQUE INDEX `Compra_idComment_key`(`idComment`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Vende` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idUser` INTEGER NOT NULL,
    `idPrenda` INTEGER NOT NULL,
    `precio` DOUBLE NOT NULL,
    `resena` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Vende_idUser_key`(`idUser`),
    UNIQUE INDEX `Vende_idPrenda_key`(`idPrenda`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Dona` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha` DATETIME(3) NOT NULL,
    `idUser` INTEGER NOT NULL,
    `idArticulo` INTEGER NOT NULL,

    UNIQUE INDEX `Dona_idUser_key`(`idUser`),
    UNIQUE INDEX `Dona_idArticulo_key`(`idArticulo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_idPrenda_fkey` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Categoria` ADD CONSTRAINT `Categoria_idPrenda_fkey` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Compra` ADD CONSTRAINT `Compra_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Compra` ADD CONSTRAINT `Compra_idPrenda_fkey` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Vende` ADD CONSTRAINT `Vende_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Vende` ADD CONSTRAINT `Vende_idPrenda_fkey` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dona` ADD CONSTRAINT `Dona_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dona` ADD CONSTRAINT `Dona_idArticulo_fkey` FOREIGN KEY (`idArticulo`) REFERENCES `Articulo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
