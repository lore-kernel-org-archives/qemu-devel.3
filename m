Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A5CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIA1-0005sP-OT; Sun, 04 Oct 2026 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA0-0005rg-Av; Sun, 04 Oct 2026 05:05:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDI9y-0005jQ-RK; Sun, 04 Oct 2026 05:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8bsHOlDhFGtLEYog9/ScyjLhthPdy0hW/kx2Z6qTbW0tTjb6k9o9TngTIJ4FejaiQzbhFhv93FEoJkRgUmq8jVSxn2YJv2Q1NV0MqvRGAN4SycQcUMcZRClZza/xIz77XQ005cHxeW6qQVSoRtBMahgBmI7VnR6nAm2LBYPB34NoIpBppvg1OBFy7xEWURmrEAfGInd1YEnaGODnjgK5ps2cAXmITXJpxlctvPZP9hGFgWIixu94d3L+vzHdX9Sf0miyVklWq0IZkDCmRXa7XI54JRnI3MneSSmwibxFJCA2f2Le3gu3Mt3hiETm2frDLcx52PSrfqW+KPvgSAguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFkH+FxzzXdpSNXj7I6qAD6vZ7uTcOgjP293Bd191pI=;
 b=WePiYd2Ez0OMAd+QjWTqOqapQ2vjlLn23ro8QeTSQSSEkvmQbAuYLabHDwLTZcS5O5vXL0Yq4Dn5C6avfVKU49v2NPUjyJa5f2Sp/fgCxgeYdom0hnjs/XQMoxDWAbo77v6FNO8kscqN+CFVEWT8jXYa68BjAQgfcwNaSLLqIeHFBtav9h7CUVBNp/wLDkxZETi3+5b0opFuJLH2g0/OiacKs3rYscqhEG8cSugImCN7NOaMMT3JB1zTWD0coYmlT6sSFNJL7L+qS2WBcCANhBThnm7rchA69VbB06PhefnUaA90fmvTtulo8pSBcbXkpgHaxuNiibXPgU9g9FJCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFkH+FxzzXdpSNXj7I6qAD6vZ7uTcOgjP293Bd191pI=;
 b=SWEVNkCi6Bkd6OOmHzK0b10zGN+l3FnjdlgrL5RUayUWFWRkNfCpxBQK+aMoWarFb1Y4/jWsQaLC2fWu5BLQHhgn17iBC63QndkSM7HLmd4aJcxl+fb1byLCN2s8S3ovhhxUmRzpRstoimSqA8v0H7VaZC3Voyo0SVL7xDa4IVQjnKvBqLnkJe4+JS6dcYOBRx8j2we+XWBLbsEuSuW9qvHMwZviWCbDtTRHuhPLnX6QKb5yhB6tCzSvrgP9M1gTANm0pNHOlDMd0CglPxIMNTNBA/qMkmyvVezLwGJTwwcFWupxj5MCUMZ5Ri9GS/eNc5Ch2iB6hTaTBGxmKijVRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:21 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 02/10] hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
Date: Sun,  4 Oct 2026 17:04:47 +0800
Message-ID: <20261004090500.3082641-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e77aee-ad3b-4034-4134-08df21f69e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mN14TNlR4GDkpegzxWofRZlWO55G2/Cyb7CYiyfQBWMg1PAgt+aYgVPTyfgpp5SlSXGRt5M4CGOP2mUNpV9HfhTuynX60qXHsefyAPLJZMIFqUgKK7Tm+ukF4H3uPhziWJX5r1n4N0LTXDkdy+goEefvLkz1VwWdeusUMiGPYsiezov8/dM1+abY2NALZCjlu/4yJP2zxj2S6o4RMHt+lOIls7uTMoFn8NouqbkGfcAa7ryvl7qNfVYPf6QI//vYtYriq2zC3yDHsS0XYZ0qMutQmCOi5zIr4d9KEuKwOQS2sxR2XWG7EVhT63XgEKz9TgcGWCAIhsCCOSzdMLbL7+utJWezKNOebdEtUE4+0lQ8YHqyJacNXOBEUhe9jklOxVRbdkP/comU3KuCUDlRjdoqZtBtkH80fn9EGRcJel4E1fn1BlXQA2g69vIaPrOQs+olbwFlDnmsA5zHCDe1pZhuxavsyQXeTdH7WAgd/ySx3AYrHwwn5Dht9NLx+5Xn8YoCgBxKxEgKbS6tuZI42W1hk/UOh3OwVRKzav8chV/FGr0Y/LznIEFwQbvvBzLuOFIWuhep2y/lpxEst8dJA5tG7LWuBbl5Ybvrt1l4h5CDWlzS41F95cmOZmiDPWHok40mz8zKlA06TDf+zIN1Zx1eVaO/gmLULsLV1I6DlzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBIoQdyVuxvwM95mshAa8bqZxbnb1StKrSoGEHRfOmS2yEVfd108T0SWiZiP?=
 =?us-ascii?Q?nmLo3C8QZBrIvTVjQmYNpoqWg/DIM2gZGFxdu/uv2Bz94b1rypL5qCBTnux+?=
 =?us-ascii?Q?cl1FpM5bQoBfjHKbm2uDxFIa1JUfSyx9nrl+Qfivx/xo/CAPRfVeiK8UV9rQ?=
 =?us-ascii?Q?V9bwi5HR4X/JuRjoThnW9AU92LB+smqSJgWXWzl+i8rYskNIBqssPip28PES?=
 =?us-ascii?Q?VJK/eAppozRG1O6uHgzMlxQlccYE89MxLFAEzmiN769JpUlWRl0Lkx/mh8jb?=
 =?us-ascii?Q?F9qwSCPNydwiGzVljJiRbV/+uEL0uZ/JEjLWxPFM2kQcM1r2gMBEGl4JF4nR?=
 =?us-ascii?Q?4tf0qkgneeupnSCJAUn0+UuDQdCRWP4C2F7daC4SlR29U4B/Q+2JsWEoTEwU?=
 =?us-ascii?Q?qOXWMdtKoLF/VtORjoOr4jLBk2AwbeHM7a7KdaQ2qIVfuLpVG4rh3/DZIsxF?=
 =?us-ascii?Q?h6sD1KTBhQ69s3kwRdpEhsF1j0RYJL4d9q4ltFrygtuOPUc3qP/xdjhHmzzi?=
 =?us-ascii?Q?8KDJSZ/2TdsK2ua4o3L03w/GKXT6OBP+DfS+3WNGFp0B67+TVOPSibcO0qH8?=
 =?us-ascii?Q?jsCirZJ+7C/muGfYbvTDVmwfeK2JwvEwmsfnoFLj55dLTSHaNEzqhx5Cjs7S?=
 =?us-ascii?Q?UyOcSdbTjXZASklsJSco4lFYoCNkJMNV5FNPcii4uGMAA2fr9z3sBOgJTs9c?=
 =?us-ascii?Q?dGKtDLxyWhs6VpPE4u9wznbpSez3Fpx1Oczg+XASaCYcX0Ht+zlW3bqWOu+V?=
 =?us-ascii?Q?K15jeEe23EfJA7qQ8Wy6Q2hf7RJYUsJtuHzWQnfK6wh0AZXt0q4vvzuOD8wq?=
 =?us-ascii?Q?ea27TmTNHXzb4x5qGWnosDanD4Sv0jE1SZxHSRGj6sUt8e7fKVgp/HnwJcHw?=
 =?us-ascii?Q?qHY9Qwr9K1EGAGgj5xvtPapkQsOXAFwqBGbzlpca3YkjylsL4lhpJqj61tGW?=
 =?us-ascii?Q?PhEjia6Kq1es81eOZNoXe2oswELdk45qr/CE66qKfF804SQknN0F/ucPGxES?=
 =?us-ascii?Q?CqzQmPALPXUoe41uDyM+7ygKK8UPDg6wqtkLXdXKFptZ0ZoQzTWOBbsRpg8d?=
 =?us-ascii?Q?udjai7A7rm04xPg5UXbwF49JWcVLraMlqdbF1JqXN0BmA2XVzJVbgwCc48lJ?=
 =?us-ascii?Q?vIUsBT6bZAd6VAjMpdUjGzMhJQaL8gG2aLCI2UTv4mdMuNXZAXns+XsGylVn?=
 =?us-ascii?Q?hGNaP1TvVtSklfgltGoqpGrJM0dWSiR4B97Qe3FbXWT8F8lsONPMphXifB5/?=
 =?us-ascii?Q?YwDOnYBHvJ9sW4B9a2yPvV1cDRj/sQiGioIFi41lXeEnnCcZ/GyG2nbudD0M?=
 =?us-ascii?Q?+1rvOAVjgJRLXYBrTcK/JcOp+ZXot+Yr7MSiUT57zdnT2Bkn3amsE6whe1Vh?=
 =?us-ascii?Q?UvtBeji8lbej6kDJ75KXLC1Y8EBIN7KSgaaAovtF4B2pVypw0psqMYYfqrJ6?=
 =?us-ascii?Q?n9kTmJyqOD7LQOjlPpAg+X+im2+wqMpqyjuDeSHk/YfkvUSLrNtag7wcyQxa?=
 =?us-ascii?Q?yw/RFHNbWCnRy5DY/Lv91qiW+l3D3tYWrf/F0BM+mN6HzmDPxXZ55C7vo+p2?=
 =?us-ascii?Q?JCD21EXlLqI17jKZItWrlyG4H10z2ynVTX+Oiue9sTFToKliZJyrm4dS/7Fk?=
 =?us-ascii?Q?C94l5b9xnL67KEHVBfmz+xCEWG8dDk0/2Hr6sqUbZ7tZqBnf+unFolCvE3TN?=
 =?us-ascii?Q?fit6a0fOq8DZCbRPDoPT4ebTyiY097sfwkWbJcvD5+OjTTT3j2waP7eaqmLR?=
 =?us-ascii?Q?bd5y/BEkQuypdz3GHXwJJfAWOd06MxE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e77aee-ad3b-4034-4134-08df21f69e64
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:21.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgWjm5t8rLzlJ7FW6PYqgyYMz06Vo/dwBsGJI7o+n2+HzRueyjk8xKHbjzuvLFbDqAuADVzsVKtHgHZqMtLv8myIspuAa26TAaba8CCV34U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit 56a11a9b7580 ("hw/misc: imx6_ccm: Update PMU_MISC0 reset value")
updated the i.MX6 CCM model so U-Boot sees PMU_MISC0[REFTOP_VBGUP]
set after reset. The i.MX6UL CCM model still returns this bit clear,
causing U-Boot init_bandgap() to wait for a state that the model
never reaches.

Apply the same reset behavior to the i.MX6UL CCM model so U-Boot
can observe that the bandgap has stabilized.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/misc/imx6ul_ccm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index c4f6e372fe..4accbcbeed 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -592,7 +592,7 @@ static void imx6ul_ccm_reset(DeviceState *dev)
     s->analog[PMU_REG_3P0] = 0x00000F74;
     s->analog[PMU_REG_2P5] = 0x00001073;
     s->analog[PMU_REG_CORE] = 0x00482012;
-    s->analog[PMU_MISC0] = 0x04000000;
+    s->analog[PMU_MISC0] = 0x04000080;
     s->analog[PMU_MISC1] = 0x00000000;
     s->analog[PMU_MISC2] = 0x00272727;
     s->analog[PMU_LOWPWR_CTRL] = 0x00004009;
-- 
2.53.0


