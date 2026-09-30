Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB1CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBohB-00020G-Vo; Wed, 30 Sep 2026 03:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBoh3-0001wB-MP; Wed, 30 Sep 2026 03:25:33 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBoh1-000289-MG; Wed, 30 Sep 2026 03:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA7lxkQ22uCiN5V5r5eiD0aty5yANNpAFOiO26YQndk6hVnN7NpLMJaXTFCoK5Tn2jm3NxIrGnbEBEW2I8yQ1KLNfMGKXHoe1sWERTx1OFK3ZwSNopcKCOMNcJOdE3OucS1bTKu+v+2K1w7AIy3dos43C1JJMF1bnBDbF3QtDg0m0CsS1hXyPmhbQaVITA1fOcOIGMPaK6SZinKz6wn1AV2zz1bbOyog4+XIaeo+YafoLmOp+19VoUPPj61b/TUuVx4sLISWFKPaTH2QfCC++BMv3ACX6Ys4FojOtUBzv4+onIPzstsBa4iAe3vqxJW5t38XPAIHzmAMNiVvhtCn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2utsIS2hIQPvvVxszHPx6Eqwg+xM2tXOe5NTE8ITIyw=;
 b=tiR6bJMnOPNNUhYvEkDgRdYgs6mQeP9x2pYRDctyLN1TYzL1WdeHOi3VNJqDQrBcReD3JNEy8TS4P+XW1rju+fKb947WJBAmZmoUgBvGDsCzKnZneHZypxO2gL6JTKSzsvBS6+iW3TFj9HCONwKTQapUCXYuFN/06suddMfAnCcC0S8bq7jXoRIJhAhhzJkiOnwp6saFiFFxSQIeNmgxM5dVt5jkM9LM1wAh207HPIgSJkLVQ/0tTCcIvSt+Afd6TkvGrktM2KDKUwhQ+m++36vMP+if3SaSG15LHbKpULO+x9kdFZyzlHhfXR2oZywfwGyu7tjetwSFT44Aqa4MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2utsIS2hIQPvvVxszHPx6Eqwg+xM2tXOe5NTE8ITIyw=;
 b=VIBo1c821qGhGKEBFmeFbGInwKeHvvMB7DdbP+O6n2I0R9kvRQi/tsUtFL7M/6vVrFLCHBmwsCjqZ9ZKAombZDnFz6eZZq/RPZFQ4sl/PExTiFe9IcyWxdadG8mLEZbDaYfCgXvn/TKFv/phpSwtFzEdbyjPYidZ06ay6qmUgm1XZ6U8X9qzQtrpo1yUQe9rwMNxBRd4sY74YUvJNgJTAKaO2UaoSxZJuruJSjCRcKnheyHAsYlTDmfHmH2Xk/qJR+ghJKD3scyVbh6ukCtrDjS/3CVLfZ7JkRXL9I95sKL/+7hcENHr0lofrTzFOd4D6pZAk5s316mojuovUFHPlw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:15 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/11] hw/arm/aspeed: Sort device IDs alphabetically
Thread-Topic: [PATCH v1 11/11] hw/arm/aspeed: Sort device IDs alphabetically
Thread-Index: AQHdUKzWkDx1i7OeUk60bYIf3nxl4Q==
Date: Wed, 30 Sep 2026 07:25:14 +0000
Message-ID: <20260930072501.2612119-12-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6616:EE_
x-ms-office365-filtering-correlation-id: c1b1b0b5-3de4-436a-e8ef-08df1ec3f8bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: lr93qakhZwMueSr3bQuDLMqCGLVpiAqQ/kz9f8p60TwyLzNqXFfntcjpKeNJoDbcE9Xy3ROoA1R4bcNj2epj/sz0piePdvon3lgdlYlD03YV3fC3xpizTWmoXbyawkgSTAeV8LLfFx7tvePJ5qnR0qzp6scD5PRBy6aKC/L4c5g+Y+TdiJBZqL0efgJ+DUOdYMM4PMprxL7jb2wMxXGHaEW0EhsrAzWyWMop2zt1TeBwEJelP5W3PxGvLFCZLES4H1iGNwaRIla9p2kDg10hVDeAjBQLnwtKyJaePBdk6Vm8M0DS5TenhINWHMb50P0ewyDwl1HaYjrdHZdBSdxMZqQP2JCvHnHd0tPVxLJX2sDevHV2qBE+3lnqEy/i2spFuUFMT3XYIofMQPjcR4lm0B5HM0UWZbzGlQyDLWhX88AC8DoomyeHjG/t/Ta3CtXebeC37BTiEXQUKiPbgE+XHnp+bpw9HLjpQ7cvgumDkcKSs6GUIwP+v8AO3ZWeP37ClSgSHylxhG5nOvXnQh36/6UqDua2069pXkh8gVyW2L1MJAs7N8CTni8s+HyTSS1gPMxoVrP8o7WSDn7p/H5DMYvNGbMGrSQKIwTOOe/qkLfExQc+GJtLaJlGN7oO+1t5rKKqxNJTRrNF3dr3x+vpfDMBYtzQwqzQ1Uzfw+FdPdhuiLVJXUIMN9Cl4Y5ChYOcIQ3pn+4LsemNiU4iNjAz4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?92mBf+rONMsrP82WApNQHaDrkq4M2vHrY+RLrelgJfYN2+VGAaVB0/zMWd?=
 =?iso-8859-1?Q?vN7IyevILInsScOkW31i4VBySmNmZpG2v0y5VqYh+ehPVpifqoU6y8cx1p?=
 =?iso-8859-1?Q?NwSCMce47DlKdJTyM6nD5vu5rz1OCm8tzuX1Pm9Kj/J4bkn9KGoqQ49qoj?=
 =?iso-8859-1?Q?l2jJrVxlGnBsUBDEI3RwRZGqGBgp9xFN7lyO3uGasPzeL41mvMDZtPtynN?=
 =?iso-8859-1?Q?BPBndZuvF7fMz0hOxLpUVzoLedW36ItJoUISzpylNf7NprNMSxRvKbWOiC?=
 =?iso-8859-1?Q?DJzhcSfxcGptUSRMAauNIIAWBOeKSylPv84PpqeomjhFPnn8pNbUxPLaiB?=
 =?iso-8859-1?Q?K6UUSQlYlLprA7vTW+R/iuWU1GU+E7IEz+gH6arcnurHpbc4vINX6ulddz?=
 =?iso-8859-1?Q?RgBox6QoRQvHpk4hkVddmanCz5bHlKJB20VzP7QOboPH++sIWPVgSkM1z8?=
 =?iso-8859-1?Q?lmdXI8syu1FrEff8b7jriuXvu0OuzIlj4d7GTdpic4t8g/oobKJcIZkV19?=
 =?iso-8859-1?Q?hBfCZegdOW6QGV2WngGcHnfP2HyyKZgS586PXV+YEhkGV721FJ3WZtSkV6?=
 =?iso-8859-1?Q?RcZe1CgMVlM0++x+h84ABjYdsXR8Hs9SCxSoreJbyPL41uMqP8GhHijsS6?=
 =?iso-8859-1?Q?7eatG1lJEtL49d7YalNbubzRr79roBML6TKE96VUsx/fmQXQ47Zx7q4hVt?=
 =?iso-8859-1?Q?TpR5jRgjnHBmXIoid8CV1EEUMvq39Od8q8spa0flme6GRwgIdXt+TS3j/H?=
 =?iso-8859-1?Q?SaeYFtc3zSbpynfqDARm9Mk8brd1Mq9B7p4CASWJvK/Amzc4ns5jnw4T2k?=
 =?iso-8859-1?Q?bgNCyzyKOZVEA14yWSpblDPO7b6ZNP64h3t0/QfsPw8BMDrqjjaIBtSaF9?=
 =?iso-8859-1?Q?MTJ41GwyaU1ez+rYadsGh2XiBmuiEIdUtbwhFRLMyb7F8LFJKoGcDBgpeR?=
 =?iso-8859-1?Q?P2ms1QA2gtAhJ/hVYopfL4wo6mt/9dcDShERpeTZKxM6t9QTF9y+D5Qpci?=
 =?iso-8859-1?Q?IRfbKjZlQPVudevnCReKl8xBl4VbeSxA3RAecrDb0ki8WQun0/7hrA1GZV?=
 =?iso-8859-1?Q?rcxGSdoyVwuixLuyM+0wm7Bd7nbrzuQrF6Y8Jkls7oFdZP4ebumxYg9+Bn?=
 =?iso-8859-1?Q?ebah2KWccda87cN4BCGI6BCWyLOhXMyjiRPzYzypL2cDzJsNLtNPxHmlzE?=
 =?iso-8859-1?Q?N2G+l5/JW1p64ogRraUwWcjdinu5KTgEte52xUT80YG7K4IirKQqNTGyuf?=
 =?iso-8859-1?Q?2mC9mQhESEphh4uBzIeeNY06HHHzFsH8Koxeiz7roiMC6S0PJKHMTR1v4X?=
 =?iso-8859-1?Q?zmEjHa2g2Wrayj+bFmly1UrYdrLQzDsdbtU2EHoWYLA+vx0FnpAeSMUVoL?=
 =?iso-8859-1?Q?bsWaFO3w1XOF98Rs/UbtMwRnNayUEx3GD6xCpHOM89Yyn0mcyEm4PoQ1C/?=
 =?iso-8859-1?Q?XUfYCjVUbEjtNks+icMxUeWLWMvte+110yGwY9XvzGnoqLluqYUCtwfzu8?=
 =?iso-8859-1?Q?1aTClp3As7EPzf1gftpyJIkKjC89aVr2sjwTTjVoujlAH/sczVzepsSBq8?=
 =?iso-8859-1?Q?tcHHJw7TDmD9aJY/R2cs4PRMjNsQJLi/FHStZkDkvt1X9pqcStA5F+AxuV?=
 =?iso-8859-1?Q?qMFq+XY+p58wziq5u+fVbeYD+HNipLe+i6iAvzniNuQ9Vb3TDSOMaNNox1?=
 =?iso-8859-1?Q?hmJ0EL2nQm0jLreLLHcv2AUkppyT+aMNugBm17iwiZMTNpQrMSpRl7ZRfO?=
 =?iso-8859-1?Q?ughkDwbZm+8Z/8m1kCIKSb8LQWuheL12fSxCOxVKxHyzUjFywayTMXyeYa?=
 =?iso-8859-1?Q?dg/5Ay9HoQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0pd7R/pRE49l+yXGRwzGG+povSKJxRuKkct6aTJNzjIycQOdH4RXU8Ci50XnxCj+Gh/0rkwMTBgUbqaZE87+xBy4X+nmMOaJXNcSxqPPHYA7XZN8MRS5ZtHcVbapzhDQ3ngOAs39jhinsxnfe+rbbE/goob+3T+zW+ckQURsa8PL4r+zmKIb1lcXxB9yLHle6nmY2j41+izLnZmePkQlbMXvvtJ5Bkes2UyzSe8C7IV+V8C33xswXw+6eySrAX7ufR2juQGEBVTdHZm5jZiJU8rFxN5sJ3O3/f3pqeGIPPuGXB+binztt6FIY8SHDdfnZgykn/pBKIk+d5O3r+5kqA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b1b0b5-3de4-436a-e8ef-08df1ec3f8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:14.9695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sHQcYyMTnx3tmACX3rx+GbC3/uOA27zoe72VwuGgtH5Ne7RgQBNKR04RQjlbau7qQZTKq9GAYpX24BE+CCjGaOnCwHgUBtCYW1syfpeOwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

The ASPEED device ID enum has grown over time without a consistent=0A=
ordering rule. This makes it difficult to determine where new device=0A=
IDs should be added and reduces readability and maintainability as=0A=
more devices are introduced.=0A=
=0A=
Sort the device IDs alphabetically to provide a consistent ordering=0A=
rule. Keep related numbered devices together, such as SPI0, SPI1 and=0A=
SPI2.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 176 ++++++++++++++++++------------------=0A=
 1 file changed, 88 insertions(+), 88 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 0ef45561e0..c201263937 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -194,64 +194,56 @@ struct AspeedSoCClass {=0A=
 };=0A=
 =0A=
 enum {=0A=
-    ASPEED_DEV_VBOOTROM,=0A=
-    ASPEED_DEV_SPI_BOOT,=0A=
-    ASPEED_DEV_IOMEM,=0A=
-    ASPEED_DEV_IOMEM0,=0A=
-    ASPEED_DEV_IOMEM1,=0A=
-    ASPEED_DEV_UART0,=0A=
-    ASPEED_DEV_UART1,=0A=
-    ASPEED_DEV_UART2,=0A=
-    ASPEED_DEV_UART3,=0A=
-    ASPEED_DEV_UART4,=0A=
-    ASPEED_DEV_UART5,=0A=
-    ASPEED_DEV_UART6,=0A=
-    ASPEED_DEV_UART7,=0A=
-    ASPEED_DEV_UART8,=0A=
-    ASPEED_DEV_UART9,=0A=
-    ASPEED_DEV_UART10,=0A=
-    ASPEED_DEV_UART11,=0A=
-    ASPEED_DEV_UART12,=0A=
-    ASPEED_DEV_UART13,=0A=
-    ASPEED_DEV_VUART,=0A=
-    ASPEED_DEV_FMC,=0A=
-    ASPEED_DEV_SPI0,=0A=
-    ASPEED_DEV_SPI1,=0A=
-    ASPEED_DEV_SPI2,=0A=
+    ASPEED_DEV_ACRY,=0A=
+    ASPEED_DEV_ADC,=0A=
+    ASPEED_DEV_DP,=0A=
+    ASPEED_DEV_DPMCU,=0A=
     ASPEED_DEV_EHCI1,=0A=
     ASPEED_DEV_EHCI2,=0A=
     ASPEED_DEV_EHCI3,=0A=
     ASPEED_DEV_EHCI4,=0A=
-    ASPEED_DEV_VIC,=0A=
-    ASPEED_DEV_INTC,=0A=
-    ASPEED_DEV_INTCIO,=0A=
-    ASPEED_DEV_SDMC,=0A=
-    ASPEED_DEV_SCU,=0A=
-    ASPEED_DEV_ADC,=0A=
-    ASPEED_DEV_SBC,=0A=
+    ASPEED_DEV_EMMC,=0A=
     ASPEED_DEV_EMMC_BC,=0A=
-    ASPEED_DEV_VIDEO,=0A=
-    ASPEED_DEV_SRAM0,=0A=
-    ASPEED_DEV_SRAM1,=0A=
-    ASPEED_DEV_SDHCI,=0A=
+    ASPEED_DEV_ESPI,=0A=
+    ASPEED_DEV_ETH1,=0A=
+    ASPEED_DEV_ETH2,=0A=
+    ASPEED_DEV_ETH3,=0A=
+    ASPEED_DEV_ETH4,=0A=
+    ASPEED_DEV_FMC,=0A=
+    ASPEED_DEV_FSI1,=0A=
+    ASPEED_DEV_FSI2,=0A=
     ASPEED_DEV_GPIO,=0A=
     ASPEED_DEV_GPIO_1_8V,=0A=
-    ASPEED_DEV_SGPIOM0,=0A=
-    ASPEED_DEV_SGPIOM1,=0A=
-    ASPEED_DEV_RTC,=0A=
-    ASPEED_DEV_TIMER1,=0A=
-    ASPEED_DEV_TIMER2,=0A=
-    ASPEED_DEV_TIMER3,=0A=
-    ASPEED_DEV_TIMER4,=0A=
-    ASPEED_DEV_TIMER5,=0A=
-    ASPEED_DEV_TIMER6,=0A=
-    ASPEED_DEV_TIMER7,=0A=
-    ASPEED_DEV_TIMER8,=0A=
-    ASPEED_DEV_WDT,=0A=
-    ASPEED_DEV_PWM,=0A=
-    ASPEED_DEV_LPC,=0A=
-    ASPEED_DEV_IBT,=0A=
+    ASPEED_DEV_HACE,=0A=
     ASPEED_DEV_I2C,=0A=
+    ASPEED_DEV_I3C,=0A=
+    ASPEED_DEV_IBT,=0A=
+    ASPEED_DEV_INTC,=0A=
+    ASPEED_DEV_INTCIO,=0A=
+    ASPEED_DEV_IOMEM,=0A=
+    ASPEED_DEV_IOMEM0,=0A=
+    ASPEED_DEV_IOMEM1,=0A=
+    ASPEED_DEV_IOEXP0_I2C,=0A=
+    ASPEED_DEV_IOEXP0_I3C,=0A=
+    ASPEED_DEV_IOEXP0_INTCIO,=0A=
+    ASPEED_DEV_IOEXP1_I2C,=0A=
+    ASPEED_DEV_IOEXP1_I3C,=0A=
+    ASPEED_DEV_IOEXP1_INTCIO,=0A=
+    ASPEED_DEV_IPC0,=0A=
+    ASPEED_DEV_IPC1,=0A=
+    ASPEED_DEV_JTAG0,=0A=
+    ASPEED_DEV_JTAG1,=0A=
+    ASPEED_DEV_KCS,=0A=
+    ASPEED_DEV_LPC,=0A=
+    ASPEED_DEV_LTPI_CTRL1,=0A=
+    ASPEED_DEV_LTPI_CTRL2,=0A=
+    ASPEED_DEV_LTPI_IO0,=0A=
+    ASPEED_DEV_LTPI_IO1,=0A=
+    ASPEED_DEV_MII1,=0A=
+    ASPEED_DEV_MII2,=0A=
+    ASPEED_DEV_MII3,=0A=
+    ASPEED_DEV_MII4,=0A=
+    ASPEED_DEV_OTP,=0A=
     ASPEED_DEV_PCIE0,=0A=
     ASPEED_DEV_PCIE1,=0A=
     ASPEED_DEV_PCIE2,=0A=
@@ -262,49 +254,57 @@ enum {=0A=
     ASPEED_DEV_PCIE_MMIO1,=0A=
     ASPEED_DEV_PCIE_MMIO2,=0A=
     ASPEED_DEV_PECI,=0A=
-    ASPEED_DEV_ETH1,=0A=
-    ASPEED_DEV_ETH2,=0A=
-    ASPEED_DEV_ETH3,=0A=
-    ASPEED_DEV_ETH4,=0A=
-    ASPEED_DEV_MII1,=0A=
-    ASPEED_DEV_MII2,=0A=
-    ASPEED_DEV_MII3,=0A=
-    ASPEED_DEV_MII4,=0A=
-    ASPEED_DEV_SDRAM,=0A=
-    ASPEED_DEV_XDMA,=0A=
-    ASPEED_DEV_EMMC,=0A=
-    ASPEED_DEV_KCS,=0A=
-    ASPEED_DEV_HACE,=0A=
-    ASPEED_DEV_ACRY,=0A=
-    ASPEED_DEV_DPMCU,=0A=
-    ASPEED_DEV_DP,=0A=
-    ASPEED_DEV_I3C,=0A=
-    ASPEED_DEV_ESPI,=0A=
-    ASPEED_DEV_UDC,=0A=
-    ASPEED_DEV_JTAG0,=0A=
-    ASPEED_DEV_JTAG1,=0A=
-    ASPEED_DEV_FSI1,=0A=
-    ASPEED_DEV_FSI2,=0A=
+    ASPEED_DEV_PRIC0,=0A=
+    ASPEED_DEV_PRIC1,=0A=
+    ASPEED_DEV_PWM,=0A=
+    ASPEED_DEV_RTC,=0A=
+    ASPEED_DEV_SBC,=0A=
+    ASPEED_DEV_SCU,=0A=
     ASPEED_DEV_SCUIO,=0A=
+    ASPEED_DEV_SDHCI,=0A=
+    ASPEED_DEV_SDMC,=0A=
+    ASPEED_DEV_SDRAM,=0A=
+    ASPEED_DEV_SGPIOM0,=0A=
+    ASPEED_DEV_SGPIOM1,=0A=
     ASPEED_DEV_SLI,=0A=
     ASPEED_DEV_SLIIO,=0A=
+    ASPEED_DEV_SPI_BOOT,=0A=
+    ASPEED_DEV_SPI0,=0A=
+    ASPEED_DEV_SPI1,=0A=
+    ASPEED_DEV_SPI2,=0A=
+    ASPEED_DEV_SRAM0,=0A=
+    ASPEED_DEV_SRAM1,=0A=
+    ASPEED_DEV_TIMER1,=0A=
+    ASPEED_DEV_TIMER2,=0A=
+    ASPEED_DEV_TIMER3,=0A=
+    ASPEED_DEV_TIMER4,=0A=
+    ASPEED_DEV_TIMER5,=0A=
+    ASPEED_DEV_TIMER6,=0A=
+    ASPEED_DEV_TIMER7,=0A=
+    ASPEED_DEV_TIMER8,=0A=
+    ASPEED_DEV_UART0,=0A=
+    ASPEED_DEV_UART1,=0A=
+    ASPEED_DEV_UART2,=0A=
+    ASPEED_DEV_UART3,=0A=
+    ASPEED_DEV_UART4,=0A=
+    ASPEED_DEV_UART5,=0A=
+    ASPEED_DEV_UART6,=0A=
+    ASPEED_DEV_UART7,=0A=
+    ASPEED_DEV_UART8,=0A=
+    ASPEED_DEV_UART9,=0A=
+    ASPEED_DEV_UART10,=0A=
+    ASPEED_DEV_UART11,=0A=
+    ASPEED_DEV_UART12,=0A=
+    ASPEED_DEV_UART13,=0A=
+    ASPEED_DEV_UDC,=0A=
+    ASPEED_DEV_VBOOTROM,=0A=
+    ASPEED_DEV_VIC,=0A=
+    ASPEED_DEV_VIDEO,=0A=
+    ASPEED_DEV_VUART,=0A=
+    ASPEED_DEV_WDT,=0A=
+    ASPEED_DEV_XDMA,=0A=
     ASPEED_GIC_DIST,=0A=
     ASPEED_GIC_REDIST,=0A=
-    ASPEED_DEV_IPC0,=0A=
-    ASPEED_DEV_IPC1,=0A=
-    ASPEED_DEV_LTPI_CTRL1,=0A=
-    ASPEED_DEV_LTPI_CTRL2,=0A=
-    ASPEED_DEV_LTPI_IO0,=0A=
-    ASPEED_DEV_LTPI_IO1,=0A=
-    ASPEED_DEV_IOEXP0_I2C,=0A=
-    ASPEED_DEV_IOEXP1_I2C,=0A=
-    ASPEED_DEV_IOEXP0_INTCIO,=0A=
-    ASPEED_DEV_IOEXP1_INTCIO,=0A=
-    ASPEED_DEV_IOEXP0_I3C,=0A=
-    ASPEED_DEV_IOEXP1_I3C,=0A=
-    ASPEED_DEV_PRIC0,=0A=
-    ASPEED_DEV_PRIC1,=0A=
-    ASPEED_DEV_OTP,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
-- =0A=
2.53.0=0A=

