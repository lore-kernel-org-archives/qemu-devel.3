Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FDCCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF68-0005GA-74; Thu, 15 Oct 2026 02:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF52-0004cr-EK; Thu, 15 Oct 2026 02:36:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF4w-0006Xr-Nj; Thu, 15 Oct 2026 02:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+vgZEDGI0Uyeb5Bpfv9GQrKUoYO3EpJWcVN5zjOWzqky0kLyAV9Ase55PNAHIxkzFv4xifyl4n2hgZNHSgURCBSXmRRfCRwsTXjWAE/DXpR2cEKu735a4xaDl9xFaM3ELsKzgSGKH1/AnMwiIbSePCSwEuAfZH09WDMupAVfNTJg4ztLt6cgsYnCQ9EBPu+WzB+tQn+zEKD+m44E1QJp62NCVfiFrJL/0kZnTNseSk6IpzcGonG/T3JxwNSLrEplBm+jgQkjWxUEgRQSFWWiktFHrHvHWDx1vdgj2cv3knnYAdkBtIpEprs27iaAgOsG8oBMXTMh3ohpVRX1M3N4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmuJM2a3n1igDojakaSfVL4Udswa3tbWmf2X+Zxz2Mo=;
 b=qTKWfs7q96hXfssoFRuz3hUNa3tjeMaXt6qPdIsU92VJ+MqRXZUB1KDgbomabKwr7XhZTshBFH5Uasve3PsaGVVO5ChsnBe0SlpL28SNe+zxxgf1DiBCy92iKVXMHZPjMpF64FmK2Bxi6rx8IzM9YQ5/QyyHvJgmV03NWOXPWiKoVx96nnQEPeqbk49Z5jmq5J4UH17M8S4hUxS8qnqxsXGWih5jN5e8lauLM397/p23ho9rttBckGsDzun8Uki5bzpDv/N6rDdmSdJTB2UTuJpCtV+BGCwaATwF9FlX8M/j5AVsse894VwfBwXAwjFJ4GG+OqHpsb1LHoOIgbXZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmuJM2a3n1igDojakaSfVL4Udswa3tbWmf2X+Zxz2Mo=;
 b=mMRY4D5dTzdf61VNA3Ud8DrDaNePmK9b3MSQCBCtyqITqPrAQlpQN77NWEzJ2cM14iFQ6mFSNhoA7UI+1NfknHZ4Yy/qVaJqm9L1Z9Ql8rZWaRzGDeP+o0ilPI+n5hqVLcCLRdn377EQyTtO+rEjqMJTW9zIR2urujcIRRDDjKb8JI1RTqFFPqvoAc/Wdx8co0mSYznO0IP22wGz5Z28w2XoHhnMWZpkLoopScc7e3FpMJDl5ahnk2DmBY5dUPMx2UKy40qtK9GLqU9yytdgHg0L1483WjFHjJJTbcX5tbwPG6v7AcY/CqjPvNlOP4TD9Ft8R/UJlZP2VOTGCqF0yg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5049.apcprd06.prod.outlook.com (2603:1096:400:1ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/9] hw/arm/aspeed_ast1040: Add common init function for
 AST1040/AST1080 SoCs
Thread-Topic: [PATCH v1 1/9] hw/arm/aspeed_ast1040: Add common init function
 for AST1040/AST1080 SoCs
Thread-Index: AQHdXG+BXjYyFhHlgkmbsbfG+g/cWA==
Date: Thu, 15 Oct 2026 06:36:27 +0000
Message-ID: <20261015063625.186708-2-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5049:EE_
x-ms-office365-filtering-correlation-id: a51454bf-056e-4398-530c-08df2a86a49d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|10067099003|22082099003|921020|261009221227099003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 5HwaDdoaTFDgxSVDFmti0PCd+Hn5jkF8D/4r2kp3xXTVCPlZw/M3l5Q7ClReMrMx1p0cDHVWpGBSbxFTphQAJsBYZl8TXefdsVrvUz0oLay74rlozEtDKqfZqNGIJlrR3I7BUdGg1PEUseG8K1roDL6BFvnT35LL/Ney7sm8v/PVTKHjZFi03Jx/zgPC0xfg0A+gP5jnjAh3vfBGBbJkFcxnDpmD4rLjcS6aoKyzyRKmRWApPHxAcJ40ILT90ssKy65rMZlKBDQsAohTdgwxrZByTHTs+WQ5cscNU94tKv4kT/If/YZLGWys1B7J6yYO+m0fNP7kCRPFO0hwVqROah6nfd2kaAEw6Y0GdguMcbsuwO7+Y7qxDjfnL6Y1NXS+YkrkF1jQlCLWatBOooVKgxecddmLXn5xR5c1mEGVjTbz3qp7beSHKpPYn0VP8sOgtD4UZsecoxH3qtSW8WH4lJAVx4HFJ1tst97TqoIhEug7oXvV0cX11xTQMcXjGLvjhtwlc1NZ2L3ryZSTV0w6LRCQdVTI19BDhQxL9200Zf8bKIbayzv1duU+1qf+r7hN4MS/P0F2hsVm71a7LicXwDwpC2IXXG7R08VQCaArvWjdQUgr/pFdxZShstNPkf3QW2TSELtdZGqkzTgDGTzg0VraEDkmKqznm9lVftSz9a+HbU1RDULQF4ki3pMs7dWd4RGo4nyhu9Jf1wP3T5Ahvllbhr4nFPk8tcSiPC4kQRw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(921020)(261009221227099003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kvOl+NO5fDwGPQ9fu+CPd+v55pWoUGQBZmH10uBMplDqClVjwtrEegc1sc?=
 =?iso-8859-1?Q?cZj/gI+NMKznpE5CCEkivLV92Czad7LuWbTufeNsnum1pRv9OQU0TA2lrq?=
 =?iso-8859-1?Q?aMvequb7DGd/Yzp6a0ranm7dPhbqpAaV9GeKqB4iErZRECtglD1zVbJFBu?=
 =?iso-8859-1?Q?DJJ749ZUmTYzttHBBz/Gwfp8suHLkbEu8aXU9RlAqwRAxdjbJVYiRpXAUa?=
 =?iso-8859-1?Q?bGFZYrlwsE4m19f55GOPvNa3EpVG+szcKXJszOENaciomzmOtyIy2pnha+?=
 =?iso-8859-1?Q?AXbcg6idHbqJb228cyeRzmXXUB5ht56lckl7fMIO2bnCezTkVAjpT9yzNG?=
 =?iso-8859-1?Q?YyOxVRLd/BmZou8ToaY0vhoQXtY8Hm9pYvPIpbNor266B43yD1LNThRorY?=
 =?iso-8859-1?Q?5IS6Hr/hrphtUt8dx2S66yxEXFWEXXSqOZ03eZWNIZ3YCjKVvDze9lUWDE?=
 =?iso-8859-1?Q?E14PpHPAg4f/z51O541ccJ8eY8R2x7IzlSIByeR0n96R3TDcUhAyfgsPA9?=
 =?iso-8859-1?Q?F3eeesw4p2AJda+G2NNwxdi5dh2AXCVnaF1hsV2Kgt80HzZBo26HyNy1Mz?=
 =?iso-8859-1?Q?Od0+/3VTFIMhHgaiPhjbCAOrMsk0rnwUeP3i3BuDU5U7qICnPxqinLkDKm?=
 =?iso-8859-1?Q?/2+2QioSkMcGzHTpRlMY6tJufDrUKWtNQljOpFW+PXZuniDZhZIolMgNzw?=
 =?iso-8859-1?Q?HxA8Mqm21UvqXAsCVBroD7pxseGUF+/kqvzjUBtqMlfEiZksSwl4hjPspp?=
 =?iso-8859-1?Q?FQgO9BN00LOnuJKXMWVCjLd6sRlzGeSXJE6to8P5auzxvrLpglpFNDBdw1?=
 =?iso-8859-1?Q?wz7Try+Ceamq5CL5OJiX6p1243PJl7UWMFkn+Bykeu54KY5I34sWVB0IY4?=
 =?iso-8859-1?Q?JY7yJegMd8RH1VXERVYi8uXA10s/MkA36coQicc9gIsVnfxFm1AYeJTrhG?=
 =?iso-8859-1?Q?65KBMAp615lzL8sd8q7/ElJbd5YgiT3QUpXp7vuYFPbs7zDbLMFeGXcTX4?=
 =?iso-8859-1?Q?qf1MQY1okia9SEyVdslokcMOPcy001RCGdIxi6bhG7bJz7cL1PvCh/0XNb?=
 =?iso-8859-1?Q?6ifBrltH7oWJEjMdYhbjedX6kiMf5Co++ptt78DNh5th+HFnZztLq1o5nj?=
 =?iso-8859-1?Q?hgWXXLyp4+1GQSE+hN7HhPHv1+NC4Qo+niExFs6inGnY9D8FRX6dSEea3A?=
 =?iso-8859-1?Q?LFGLfFX+0P6qen4CtndY2g4sPC/XRlmJg3GA2zD9Ap8cCk859MLi0qhxpS?=
 =?iso-8859-1?Q?0jn4meyfYu/hkkBUO43/asVnkX4YktYS9bNvIMmrXFxbYheMN7SbmAJila?=
 =?iso-8859-1?Q?Parlsg5iloe7oW0BHiG6IZcDgR6ByHfyWDOq/p0GGUSR5LqSstvMQy8MOs?=
 =?iso-8859-1?Q?gj31AuPAXeB3JLb+2FCiaLxV2jk3qJe2M6cTCb9fNqboIXzKnfIUW8MiVQ?=
 =?iso-8859-1?Q?e/yOYm5XnsdIMDHYQqZRL4EiVPf2TTrynhpr6EBr1jAnhcpxoO3nKpH8rb?=
 =?iso-8859-1?Q?W2m0lCnkXPjekRpQP99Nefj6ozoayLsyGOT93qQdtkDEgBnRKU+Rr8hPlX?=
 =?iso-8859-1?Q?PgGqfTZh7xjXfTfD651Lv4/GDD0WYSzzNZlWN0RYGCdRqdabFz+N7fhl+W?=
 =?iso-8859-1?Q?DYQubRse1LHJg+jXjXQ9ltjrAFLjAWQdpab4N2AVLA7d+mGz3EJiBsjJGD?=
 =?iso-8859-1?Q?8TDA5Z4UQ5UsxgAXD3xGnGILQ7gXEvqCka2j/mUYQdOupAF+5VeIv55MsT?=
 =?iso-8859-1?Q?pehxZjwpiSZMuC5WuFowiYXDsdm2Rq3AZcQx4URF1tWnm8N6iyByCtctau?=
 =?iso-8859-1?Q?QpkKQYThLA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MC9GH/RemEHB5s14bFplOOrk3U7ZBGxrcUGy7GPo/ewnLP0dkn8fScBOtsqbyXJkqdS9Rlarj1k6R9XoMjSCendM9f28AfEpHPBMWkRgErhvV4VCmLRzjN260LkBfrjq1DZlBkuNypi0p7IPTPVmljo8aRNscvwonQfEelXYKBCNGyOUZ6Ak2dxf/3/Wd0yn6ggucNoSYe9fQtaLwfctlblCX+foFZY9v8N7vEC+ygUj68KDpMwifBMgwXKaN9jFGRAhNXlcTaHWxYPtVKt+n1H5QhgXnedoUzMDuEF6C6CGFvlba3K1+h6wocPJOIWJsDdoLtfPIjkoZ7eNJdoXgg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51454bf-056e-4398-530c-08df2a86a49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:27.3781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yswU/FlLtt0/5VMhpUs8OlhNQcNFfoPEMH/PGxI7+mF7TXC/4Dd0QM8tcTDnogHR9/5mbI0Cd3eNXh6Sd2LJea+TGqOb5L7aNiacWPzinCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5049
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

AST1040 and AST1080 are the next-generation SoCs of AST1030 and AST1060,=0A=
respectively.=0A=
=0A=
The AST1030 and AST1060 SoCs share common initialization through=0A=
aspeed_soc_ast10x0_init(). Similarly, introduce=0A=
aspeed_soc_ast10x0_g2_init() to provide common initialization for the=0A=
AST1040 and AST1080 SoCs.=0A=
=0A=
Move the shared AST1040 initialization into the new common function so=0A=
that it can be reused when adding AST1080 support. The PECI and eSPI=0A=
controllers are only available on the AST1040, so their initialization=0A=
is kept in aspeed_soc_ast1040_init().=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 36 +++++++++++++++++++++++++-----------=0A=
 1 file changed, 25 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 74a1097bd7..5d2713e8bb 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -81,19 +81,23 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_PECI]      =3D 164,=0A=
 };=0A=
 =0A=
-static const UnimplementedDeviceConfig aspeed_soc_ast1040_unimp_devs[] =3D=
 {=0A=
-    { "pwm", "aspeed.pwm", 0x740C0000, 0x10000, -1000 },=0A=
-    { "espi", "aspeed.espi", 0x74C05000, 0x1000, -1000 },=0A=
-    { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },=0A=
-    { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },=0A=
-    { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },=0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast10x0_g2_unimp_devs[] =
=3D {=0A=
     { "fmc-filter",  "aspeed.fmc-filter", 0x74000400, 0x1000, -1000 },=0A=
     { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
+    { "pwm", "aspeed.pwm", 0x740C0000, 0x10000, -1000 },=0A=
+    { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },=0A=
+    { "caliptra", "aspeed.caliptra", 0x74200000, 0x100000, -1000 },=0A=
+    { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
-    { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
+    { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },=0A=
     { "i3c", "aspeed.i3c", 0x74C20000, 0x8000, -1000 },=0A=
-    { "caliptra", "aspeed.caliptra", 0x74200000, 0x100000, -1000 },=0A=
+    { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast1040_unimp_devs[] =3D=
 {=0A=
+    { "espi", "aspeed.espi", 0x74C05000, 0x1000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
@@ -105,7 +109,7 @@ static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCSta=
te *s, int dev)=0A=
     return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);=0A=
 }=0A=
 =0A=
-static void aspeed_soc_ast1040_init(Object *obj)=0A=
+static void aspeed_soc_ast10x0_g2_init(Object *obj)=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(obj);=0A=
     AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
@@ -117,7 +121,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
 =0A=
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
 =0A=
-    /* AST1040 uses the AST2700 SCUIO model */=0A=
+    /* AST10x0 G2 uses the AST2700 SCUIO model */=0A=
     object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);=
=0A=
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);=
=0A=
 =0A=
@@ -129,7 +133,6 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
-    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
     object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
     for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
         object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],=0A=
@@ -150,6 +153,15 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast1040_init(Object *obj)=0A=
+{=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
+=0A=
+    aspeed_soc_ast10x0_g2_init(obj);=0A=
+=0A=
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
+}=0A=
+=0A=
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
@@ -313,6 +325,8 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
     }=0A=
 =0A=
     /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory,=0A=
+                                 aspeed_soc_ast10x0_g2_unimp_devs);=0A=
     create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

