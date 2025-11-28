-- CreateEnum
CREATE TYPE "age_category" AS ENUM ('Kid', 'Adult');

-- CreateEnum
CREATE TYPE "subscription_type" AS ENUM ('Basic', 'Standard', 'Premium');

-- CreateEnum
CREATE TYPE "transaction_type" AS ENUM ('Purchase', 'Rental', 'SubscriptionPayment');

-- CreateTable
CREATE TABLE "Transaction" (
    "transactionid" INTEGER NOT NULL,
    "userid" INTEGER,
    "billableitemid" INTEGER,
    "transactiondate" TIMESTAMP(6) NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "type" "transaction_type" NOT NULL,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("transactionid")
);

-- CreateTable
CREATE TABLE "User" (
    "userid" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "subscriptionid" INTEGER,
    "paymentinfo" VARCHAR(255),
    "registrationdate" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userid")
);

-- CreateTable
CREATE TABLE "billableitem" (
    "billableitemid" INTEGER NOT NULL,

    CONSTRAINT "billableitem_pkey" PRIMARY KEY ("billableitemid")
);

-- CreateTable
CREATE TABLE "movieshow" (
    "movieid" INTEGER NOT NULL,
    "title" VARCHAR(200) NOT NULL,
    "genre" VARCHAR(100),
    "releasedate" DATE,
    "duration" INTEGER,
    "rating" VARCHAR(10),
    "billableitemid" INTEGER,

    CONSTRAINT "movieshow_pkey" PRIMARY KEY ("movieid")
);

-- CreateTable
CREATE TABLE "profile" (
    "profileid" INTEGER NOT NULL,
    "userid" INTEGER,
    "profilename" VARCHAR(100) NOT NULL,
    "profiletypeid" INTEGER,

    CONSTRAINT "profile_pkey" PRIMARY KEY ("profileid")
);

-- CreateTable
CREATE TABLE "profilesettings" (
    "profileid" INTEGER NOT NULL,
    "parentalcontrols" BOOLEAN,
    "maturityoverride" VARCHAR(50),

    CONSTRAINT "profilesettings_pkey" PRIMARY KEY ("profileid")
);

-- CreateTable
CREATE TABLE "profiletype" (
    "profiletypeid" SERIAL NOT NULL,
    "typename" VARCHAR(20) NOT NULL,

    CONSTRAINT "profiletype_pkey" PRIMARY KEY ("profiletypeid")
);

-- CreateTable
CREATE TABLE "subscription" (
    "subscriptionid" INTEGER NOT NULL,
    "type" "subscription_type" NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "maxscreens" INTEGER NOT NULL,
    "billableitemid" INTEGER,

    CONSTRAINT "subscription_pkey" PRIMARY KEY ("subscriptionid")
);

-- CreateTable
CREATE TABLE "watchhistory" (
    "watchid" INTEGER NOT NULL,
    "profileid" INTEGER,
    "movieid" INTEGER,
    "watchdate" TIMESTAMP(6) NOT NULL,
    "progress" INTEGER,

    CONSTRAINT "watchhistory_pkey" PRIMARY KEY ("watchid")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "movieId" INTEGER,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "movieshow_billableitemid_key" ON "movieshow"("billableitemid");

-- CreateIndex
CREATE UNIQUE INDEX "profiletype_typename_key" ON "profiletype"("typename");

-- CreateIndex
CREATE UNIQUE INDEX "subscription_billableitemid_key" ON "subscription"("billableitemid");

-- CreateIndex
CREATE UNIQUE INDEX "watchhistory_profileid_movieid_watchdate_key" ON "watchhistory"("profileid", "movieid", "watchdate");

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_billableitemid_fkey" FOREIGN KEY ("billableitemid") REFERENCES "billableitem"("billableitemid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userid_fkey" FOREIGN KEY ("userid") REFERENCES "User"("userid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_subscriptionid_fkey" FOREIGN KEY ("subscriptionid") REFERENCES "subscription"("subscriptionid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "movieshow" ADD CONSTRAINT "movieshow_billableitemid_fkey" FOREIGN KEY ("billableitemid") REFERENCES "billableitem"("billableitemid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "profile" ADD CONSTRAINT "fk_profile_profiletype" FOREIGN KEY ("profiletypeid") REFERENCES "profiletype"("profiletypeid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "profile" ADD CONSTRAINT "profile_userid_fkey" FOREIGN KEY ("userid") REFERENCES "User"("userid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "profilesettings" ADD CONSTRAINT "profilesettings_profileid_fkey" FOREIGN KEY ("profileid") REFERENCES "profile"("profileid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_billableitemid_fkey" FOREIGN KEY ("billableitemid") REFERENCES "billableitem"("billableitemid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "watchhistory" ADD CONSTRAINT "watchhistory_movieid_fkey" FOREIGN KEY ("movieid") REFERENCES "movieshow"("movieid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "watchhistory" ADD CONSTRAINT "watchhistory_profileid_fkey" FOREIGN KEY ("profileid") REFERENCES "profile"("profileid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES "movieshow"("movieid") ON DELETE SET NULL ON UPDATE CASCADE;
