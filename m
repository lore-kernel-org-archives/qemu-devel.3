Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C8606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KTTK+c26
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSc-0004N0-FZ; Tue, 27 Oct 2026 22:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSZ-0004Lc-QD; Tue, 27 Oct 2026 22:32:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSX-00082k-F2; Tue, 27 Oct 2026 22:32:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNgM5qo6TceZxqEisYeZ/DCjzprWCrdGyfHzHh+I83n372kGJsEzsOy2jgFRfTFff6QPQ0kNS2RA41wxqpXJR0QjjnE8XTcFbpEnKp5PCXHEq640+URuzPdS/ycX/ihQgfuGMhWjz+8Kou0ZsHCdqaCwyTmU3VWE7uKnENwp3m8Rikvy0hLbUl2mHfynqwFLrAhM8EKZxP1Y8oidh4LknqHC7IYB+ZkvzzNnP0xCoVBQQ4Uqn3WYO1zXxgsleTHZbVbqGzaZbwdKD8JS9H/VMYRb7es3W7L6m20foi8jx6fi+3Z50TiMamptazT1eTANtkjqWCxwBuY1t4obVm2oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yNhFyjBQZ5rdY2Y09LtlZ5zw4h/6Icd9ADO/YxoXuM=;
 b=hBAqMsLmaPkgWvjLx0YAYVRnc+/cLLok3VRHzYLmxHtgU8K+Usyo1Um8UqRJzrn2ibCmeSGsnWLAzeojIIHfZa3Sa83yZI0uNHZfbZk5xyHuOUDg1s8fAri3CjVFJGgs5r4jthL9sICWAisC/ey97NhhPhuBVGdFW0XekmxBV+msSrebfUf14IYYXqOWT8Kt23ARBhccEwWkCeUYxQpAt3v6QQtojZX25Vx4s0f+04N06FE6yxbXrjt6cMo7qNf2EzR50U364yDPvayfQmiM/V9pKIAv8zCUImj0pOAZ9zp+AEGoXvMqr3JlwNbgOuTW/GmwMH2kmbgrD7q9PKqEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yNhFyjBQZ5rdY2Y09LtlZ5zw4h/6Icd9ADO/YxoXuM=;
 b=KTTK+c263k+lEyfquiiIf7JDURNxKmQQw283HCmKI/fOk6k2uUy+uY05Xgq3PWnVptK5ACJVe9moppXzzlje4kPqqxH3YAJP4Fy47nUfKLTu8q8gJrL0GiAS9+5ct78Rcf5chvAi9vQZHXWayeePoXLTH00vcxORVroRgTWRzJG9Q4dVfUa14ceHBkSdoTlEKQ4EtEN67nHfOkaIQQ6WM9G150pPiNxGL4We8tlc0d3bySeN52DvcYmjXJgBoIlaTbHe26r4zwXMgQ9XYMSitgEgQLSjKKwAb5l9Vh9GYo4s34Ga0Mra8fB1uAcU005mjZVIaI3IoKbeDUiFaE5kRw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:31:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:31:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 02/13] hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask
Thread-Topic: [PATCH v2 02/13] hw/ssi/aspeed_smc: Fix AST2700 DMA flash
 address mask
Thread-Index: AQHdZoSA2xt3qMXuM0emT3ls4Oz45Q==
Date: Wed, 28 Oct 2026 02:31:57 +0000
Message-ID: <20261028023154.48395-3-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8531:EE_
x-ms-office365-filtering-correlation-id: 60cbd52a-51a4-4cdf-9e6a-08df349ba31b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|921020|56012099006|261026121527099003|261021121427099003|261021123027099003|10067099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: U3op3sagudrHvxYk0vNQhCE3mzZwEaNg7ItZ6YI2XftiQD6FXX1HHZ6NmPefV+596fnaMhCY6wY6TbEoe/5FwiYcQNPB4rvgTvfXfhPE7qlE25chDA/iwA2LBk1LIQnhVrmXFO/G7302BQQw5I7UcZmDOjpMTplop1KIqqiKoRrDeKq0JEb72yoI8AWeZUEy2AIQLlF0iH2XKwTfmfgQk1gm00ks4v6Bfo8cCodr5zUak4RmtqE2VcePLGapYIv37Zbqh1RZE8H1SuYeX4JoeXwCk0Zg/ul7eC7dRbGGkI1P9AgHzL7EzI755d3F0JItaA2qA5x7nMmmTtOQ8pZmZNZtYYo4xrC4IQur/1kMFwhDJpPBKxGu3CSrYpGIXuBw5PCrML5U60b+DIPaKGE9zAqy+02AY2LM7I7fvZ7d01oFTVTuvq0HmZUS55+LnEs2jlyYGde4VPvvBpuEV+jOL0l6qpxqz5gvLVOX2m4DmbE3JgRLfiy2UPir9jI6gtipAoKihUzso+pe+RrRxlwm+wsHwXsOCGvcgYu+3ddjmLrDZsM4Gt9JHyyRW7YvnEmfZwyU30O3aqf0hTlSg/DrjUicGWYZ/xzeDsoOtE6nzmePDkMOqoxu6i5AZh7u7uU+scYxa15e0xc1GmqT94WzFOxWRbj1Od4rkUUyMAMGCEXSGu9ws5t1gEtpvyPYCdtsN/9U/vOEZgjlOvKBX9r13LbPMGEb9c2VLc2G5tp6Kh6stYR+G3hzXGuG7hVnASW3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pV3ifnKu9A1JD21HxdsWuvhhPcdeuL2fbtn4mIdlAxfdMPQN9O8g+4zRv/?=
 =?iso-8859-1?Q?6jjV7u/V8SjSk0ajV/FL/oi6kuHF4f8vBoyCIQeG83iGhg4qVBHDdpu7rf?=
 =?iso-8859-1?Q?0R8VzYxdVAARQgcNgc+gLXm6AdteX25M6bSY4/IDSQ2EoChGbfe/LILgPK?=
 =?iso-8859-1?Q?+Y6XLiNwMqxGF7fblReDFR/HIZhXzX5qElxmu0wfQKF22zVWTtiir0C9VE?=
 =?iso-8859-1?Q?sViSmB9dNtTf53ho69UYnsD7gJeKxPDzlk6RRnGKzRbSub3lJJJ8o89+LR?=
 =?iso-8859-1?Q?/0nZhaCsCuIcWHHxzSurX3ucw0BcTmujVU2Lc9QeQhnBX8Ir51dz5x5XQy?=
 =?iso-8859-1?Q?0azbrutVUsHfJsbnTB7B/Gz/bmURAhiw6A6tH2dIHbuWqlukr99mHpehBa?=
 =?iso-8859-1?Q?+z5mcnlh3AkSQ4L3AfF5itRPcDfPKjpKU1FXM1t6ZI2ufGSTgtkX0p14EZ?=
 =?iso-8859-1?Q?XJ/jKIbIv5B7d0LMoc2zKxS/vP0iHhLDR0W9F18WBs1QiTljYzts4QycXT?=
 =?iso-8859-1?Q?KThbtHYScUoP0IgeqaHC5crvis6zom3M9Lzz8GEZnKUsPAAaRdFFRPSLCo?=
 =?iso-8859-1?Q?x3uM8YIDs6nxo+sBG9K/ZVpiWuHm3T9KplgbICo9z8aPNu54y21Z2hNGtv?=
 =?iso-8859-1?Q?rLHrPeq7kca54qi3oBNOJoDudB2SDbDLnXHYEAynmVRlR3zgnQ9ZOUX/4n?=
 =?iso-8859-1?Q?9MCLt2UkjVUS4ZGMdY0xLbwuFR956y3jGZuEnRpohB9SguQbLzemx3gi6m?=
 =?iso-8859-1?Q?/h6q4qP0mcdujRZhBYA/PzDlZvYczqVBbrgRnQ9PQWpaPAscfu6POChzg/?=
 =?iso-8859-1?Q?NiaooSZOfl3mYbCT9tVgT+Syx/lqWcit6RuKhBMe6kBnKAMCENJb7vjE5U?=
 =?iso-8859-1?Q?sxMd3K9O9YHW2f5bzlCzlyt5eGABkEhIQQXG0sPflLSAzU04kkPl1ww+z6?=
 =?iso-8859-1?Q?KAiZSGK5Gb6gXTZI3XCyWa02iUf9f6EhFftPeakI39V/LCr56Xn0yPI8/M?=
 =?iso-8859-1?Q?O4stgZDzX4nZHpTbibjAtZUNFG3163zmATMoWfm8zyns4l0uAqbbcUn5PK?=
 =?iso-8859-1?Q?nAJ+Ic+m0apJgsGoW+APdbrtjEdh7eFlBBS5ivsfdBa7nk1fXRsoBkCxXv?=
 =?iso-8859-1?Q?giKQZFkw4AWyI6sW9IQOMc/FyFpgVc3z/lrDblFA/WTC9GrzVIWKRPs2Tu?=
 =?iso-8859-1?Q?zuKqNVVMNAYaxs+3Q1xHVyFP1cMJkPUL4D02vuWoMvDJiCvfw3OwrRuASh?=
 =?iso-8859-1?Q?6/d5w30QqKKseeW2debZhXljICgvs1c37BrPUmV9oxUDPblyEzXFrPt5Zk?=
 =?iso-8859-1?Q?uyWQXNWLcKq26CRVjVmxklggvzNJTCN48Vh+r3L7rpZzTgOh9Kj0dw54jt?=
 =?iso-8859-1?Q?81iRyDuu/PzuTj7CKeWFikJlndAz+XnxHDRDWsPoKkUo93ZkYxoEBvR4KK?=
 =?iso-8859-1?Q?Kx0gIpbjcJ+i67QvNGm4JX3heTGO/alM2u/ZToEZVQyyOqVFsCBRDaZJoR?=
 =?iso-8859-1?Q?LX2BSvEwyC14b2WGI5qePjEY1Fi4x9CeXUza8BheaZPEVyRMS1nPKihbDu?=
 =?iso-8859-1?Q?5PjPe9cqRNmOoSH6Z/Sdrh9gPw5wUaMC7I4eY6Z1C7/79RC/ZUw1QrONZ5?=
 =?iso-8859-1?Q?jNK6H9L4wGSKH4bvAg4DVakt6xBYX8Ni+ONNp/qlX/oYHslHUzHNA7igZK?=
 =?iso-8859-1?Q?U4MLelv5njsEWLIeQu67EVCBVRxmOThK1lCjDixU3x3lJTxORi5nii98xd?=
 =?iso-8859-1?Q?LiikK9om6/HvyzHTaWYuWnvw9Ya/otPf1ANra75r5g7M3azdRuLAMyla4j?=
 =?iso-8859-1?Q?QeRUkV623g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cbd52a-51a4-4cdf-9e6a-08df349ba31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:31:57.0839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yg3PVM7ZyatOS7UtaQ8iX5mnODprNz5y9LY6dAsPDpGGX2kBYgOI4nW0RYF3DNYOQ1gGCFQRGc7THrH5yFtVhRbgtA7GZkVMEJEduDtbltU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DMA flash address register (SPI084) holds the offset of the=0A=
flash access within the controller's flash window. The AST2700 FMC,=0A=
SPI0 and SPI1 controllers use a dma_flash_mask of 0x2FFFFFFC, which=0A=
clears bit 28, and SPI2 uses 0x0FFFFFFC, which limits DMA to the=0A=
first 256MB of the window.=0A=
=0A=
With the default segment layout, FMC CS2 is mapped at offset=0A=
0x10000000. A DMA read from that offset is masked to 0x0 and returns=0A=
data from CS0 instead of CS2.=0A=
=0A=
The Linux driver programs SPI084 with the window offset masked by=0A=
0x7fffffff, so bit 28 is a valid address bit.=0A=
=0A=
Set dma_flash_mask to 0x3FFFFFFC for all AST2700 controllers to cover=0A=
the full 1GB flash window.=0A=
=0A=
Fixes: bdb3748dba30 ("aspeed/smc: Add AST2700 support")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index 10ea9e5aa0..c0c3666dbc 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -1952,7 +1952,7 @@ static void aspeed_2700_fmc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
@@ -1989,7 +1989,7 @@ static void aspeed_2700_spi0_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
@@ -2025,7 +2025,7 @@ static void aspeed_2700_spi1_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
@@ -2061,7 +2061,7 @@ static void aspeed_2700_spi2_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
-- =0A=
2.53.0=0A=

