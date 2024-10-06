import express, { Request, Response, NextFunction } from "express";
import axios from "axios";
import csv2json from "csvtojson";
const router = express.Router();
import prisma from "../database/prisma.config";
import moment from "moment";

router.get("/csv", async (req: Request, res: any) => {
  try {
    // console.log(req.body);
    let instrumentData: any = [];

    let uri = `https://api.kite.trade/mf/instruments`;

    let { data }: any = await axios.get(uri, {
      headers: {
        Authorization: "token api_key:access_token",
        "X-Kite-Version": 3,
      },
    });

    console.log(data);

    csv2json({ noheader: false, output: "json" })
      .fromString(data)
      .then((csvRow) => {
        // console.log(csvRow);
        instrumentData = csvRow.map((row) => ({
          isin_code: row.tradingsymbol,
          amc_name: row.amc,
          bos_code: row.tradingsymbol,
          name: row.instrument_name ? row.instrument_name : "",
          is_purchase_allowed: Number(row.purchase_allowed),
          is_redemption_allowed: Number(row.redemption_allowed),
          min_purchase_amount: row.minimum_purchase_amount
            ? Number(row.minimum_purchase_amount)
            : 0,
          purchase_amount_multiplier: row.min_additional_purchase
            ? Number(row.purchase_amount_multiplier)
            : 0,
          min_additional_purchase_amount: row.min_additional_purchase
            ? Number(row.min_additional_purchase)
            : 0,
          minimum_redemption_quantity: row.minimum_redemption_quantity
            ? Number(row.minimum_redemption_quantity)
            : 0,
          redemption_quantity_mutliplier: row.redemption_quantity_mutliplier
            ? Number(row.redemption_quantity_mutliplier)
            : 0,
          dividend_type: row.dividend_type,
          asset_type: row.scheme_type,
          scheme_plan: row.plan,
          settlement_type: row.settlement_type,
          last_price: Number(row.last_price),
          last_price_date: moment(row.last_price_date, "DD-MM-YYYY"),
        }));

        return Promise.resolve(instrumentData);
      })
      .then(async function (data) {
        // Delete all existing instrument data in Prisma
        let {count: existingInstrumentCount} = await prisma.instrument_Data_Dump.deleteMany({});

        // Bulk insert instrument data into Prisma
        const results = await prisma.instrument_Data_Dump.createMany({
          data: data,
        });

        console.log(`Deleted Existing instrument data : ${existingInstrumentCount}`);
        console.log(`Inserted ${results.count} instruments into the database.`);

        return res.status(200).json({ status: true, message: "Instrument Data Dump Inserted Successfully", totalCount: instrumentData.length, data: instrumentData});
      });
  } catch (error) {
    console.log(`Error while fetching instrument CSV: ${error}`);
    return res.status(500).json({ status: false, message: "Something went wrong" });
  }
});

export default router;
