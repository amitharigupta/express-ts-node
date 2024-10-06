-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `instrument_data_dump` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `isin_code` VARCHAR(191) NOT NULL,
    `bos_code` VARCHAR(191) NOT NULL,
    `amc_name` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `is_purchase_allowed` INTEGER NOT NULL,
    `is_redemption_allowed` INTEGER NOT NULL,
    `min_purchase_amount` INTEGER NOT NULL,
    `purchase_amount_multiplier` INTEGER NOT NULL,
    `min_additional_purchase_amount` INTEGER NOT NULL,
    `minimum_redemption_quantity` INTEGER NOT NULL,
    `redemption_quantity_mutliplier` INTEGER NOT NULL,
    `dividend_type` VARCHAR(191) NOT NULL,
    `asset_type` VARCHAR(191) NOT NULL,
    `scheme_plan` VARCHAR(191) NOT NULL,
    `settlement_type` VARCHAR(191) NOT NULL,
    `last_price` INTEGER NOT NULL,
    `last_price_date` DATETIME(3) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_date` DATETIME(3) NOT NULL,

    UNIQUE INDEX `instrument_data_dump_isin_code_key`(`isin_code`),
    UNIQUE INDEX `instrument_data_dump_bos_code_key`(`bos_code`),
    UNIQUE INDEX `instrument_data_dump_amc_name_key`(`amc_name`),
    UNIQUE INDEX `instrument_data_dump_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `instrument` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `isin_code` VARCHAR(191) NOT NULL,
    `bos_code` VARCHAR(191) NOT NULL,
    `amc_name` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `is_purchase_allowed` INTEGER NOT NULL,
    `is_redemption_allowed` INTEGER NOT NULL,
    `min_purchase_amount` INTEGER NOT NULL,
    `purchase_amount_multiplier` INTEGER NOT NULL,
    `min_additional_purchase_amount` INTEGER NOT NULL,
    `minimum_redemption_quantity` INTEGER NOT NULL,
    `redemption_quantity_mutliplier` INTEGER NOT NULL,
    `dividend_type` VARCHAR(191) NOT NULL,
    `asset_type` VARCHAR(191) NOT NULL,
    `scheme_plan` VARCHAR(191) NOT NULL,
    `settlement_type` VARCHAR(191) NOT NULL,
    `last_price` INTEGER NOT NULL,
    `last_price_date` DATETIME(3) NOT NULL,
    `fk_id_asset` INTEGER NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_date` DATETIME(3) NOT NULL,

    UNIQUE INDEX `instrument_isin_code_key`(`isin_code`),
    UNIQUE INDEX `instrument_bos_code_key`(`bos_code`),
    UNIQUE INDEX `instrument_amc_name_key`(`amc_name`),
    UNIQUE INDEX `instrument_name_key`(`name`),
    UNIQUE INDEX `instrument_fk_id_asset_key`(`fk_id_asset`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `asset` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `bos_code` VARCHAR(191) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_date` DATETIME(3) NOT NULL,

    UNIQUE INDEX `asset_name_key`(`name`),
    UNIQUE INDEX `asset_bos_code_key`(`bos_code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `instrument` ADD CONSTRAINT `instrument_fk_id_asset_fkey` FOREIGN KEY (`fk_id_asset`) REFERENCES `asset`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
