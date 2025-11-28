/*
  Warnings:

  - You are about to drop the column `genre` on the `movieshow` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "movieshow" DROP COLUMN "genre",
ADD COLUMN     "category" VARCHAR(100);
