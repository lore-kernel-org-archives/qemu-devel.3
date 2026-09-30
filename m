Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DCBCA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogv-0001sG-3p; Wed, 30 Sep 2026 03:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogs-0001qY-5R; Wed, 30 Sep 2026 03:25:22 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogp-00027I-UE; Wed, 30 Sep 2026 03:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoYuA9XbSmPTCDC2TyamGVrW5w5Zy/p2RllrMJjTqv2IV6bQ0p+dkxEajVGURaiUnSMKxsvUafdGLCD7n3syAZvnqT+fNhbPL0NlkFuxaJWxGDhGNb0Mp2erwfzNz8FztPs9TFeeekm0XeK6BiXvlWGmqGavPtefTWrQBCTw8LYcOU3cH3DV3RaEQZk6JGlN70ACkkGARg51POvHoFF0tyfXeZz84RtxFV9UKMH3vkRC/nuz8nMm05tGaAigLQYnhNK6rRygfkFqpuLMDrKVVOzfZP3LBXSa7QuSDslKuFwfBO+e9VcpADOZQ92tli6PJpa4GdfSNDwbMyWVnZgFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beZ3uaKVIHn5lU+EvHtu8r2c95x2+bI1CrvpGQouiHA=;
 b=xvHlt5x0E5iuLB6d9has0oERa/bc+6n2DsBy7i0esWZT6x0f4X+XAaC5iep9751JebuhLbDJU+lnuT1nfcdDUkyocKAzcO7mbrJq5Sfxn7Z58dL5lsc1pdA6OD6ESbV3/Uy47iz1uGRGPYdLwCR7eYIbSwaTXu1R3ck74EziWJvlQXHPUQt1ROjun01iHrxTgoIcEpxbdqNFOy4lwCNoYxqgovh9tQtxOnVvrV9rMXxOn6ghu6fbo1FX/pmVQe0fTV4E0nOYHUmIlk/lo02XaXLSZR8o8OiM86Wc2Ynhr+axl6cTuO/h5leaNGVzBmDJ40fiZbAsoCl11TntPZddGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beZ3uaKVIHn5lU+EvHtu8r2c95x2+bI1CrvpGQouiHA=;
 b=VMWXr5IhR+ii3beJuD1b6ymvTXE3tKidnpnQSmsjzENGQ1t2/qRvdW4gK8w6uSws2fpWUpQe1Mr57+0pP72rnOqhQe3rELMOG4uVRKeV6cLc8Qp2jVa/4cCjmta0+wyiXfzlJNyYkABmrjgknbceQ9EboLPgcm/HRj8SxevJ7l0aFZMSMtLvsM9GRs5CJwlZIpEwWx+xYw87E6meH8TynFApmylP6zaFaBbls1q6CTf2aVJ2qZHeVpM6NdA9arB+xYeIFp77cnROkdy4iVMox7xyG56R7SYGYRMsbjBdP6hG0sP0hYZ8yCOzqukY69eXdb+WXXyLryRsqAO+I6T8JA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6451.apcprd06.prod.outlook.com (2603:1096:990:2d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:05 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 02/11] hw/arm/aspeed_ast2600: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 02/11] hw/arm/aspeed_ast2600: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzQrXmdJ81ET0S8yGLsyoi6lQ==
Date: Wed, 30 Sep 2026 07:25:04 +0000
Message-ID: <20260930072501.2612119-3-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6451:EE_
x-ms-office365-filtering-correlation-id: a715828b-065e-495a-43cd-08df1ec3f2b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: +LUu0yMI68gFVbemX+W/TgCQbjb15J9uJfgo/509zSTi/QV7HhKIcSLCzfUSV9fOYuzeK/4M7784kb90k1Z70L6uA+vpxZ8FZ+qprJI8ICg/34tgsCKkRCNS8yUkRs73QgxblcXrG8Hhasyu1kmBlfMb1SBCbYQzThrROdjq4826M2oXSBJlpgnQkl+wYReM/6IExIAHwpKg4jlyoGN9kQkK0gzbC954XwxG03gAqPZDGSvlT5rwYRazAFUfKLXm+sn+8OkTFko0YG+kW09YDYIla5cFeeUCCpvf0k/Y2UOynkDbAoZf4ZH2moR+qPfDKuygHoLrphIlSUxND20Kk0OOp3TIHFwnfBtRwjGPmNF45PWyhm1XCPlS6q47fvAtHDSAqF7605jITtg8k6FW0/QKGc8z+n7NBW9YVsG5xDk5iD6MXNPwh25RdiYJ3QFoCy+BqvtpkaMjIioJffmRpL808QLoeHxdKd/kWGBGSftRYjaSzUGb5MsRythrbpnD7B/I6e3tOgK0JFfiECIaJY3IWCIpqsiAKE7Zi0MxVxirGhsJ6vloQcZR5n5E4jIfNBjxPY4ESzc8Je9seCP04ukjV2M1iFWff7tOdSOjA1F3qg4Faapx5ZhMsnuflfgFFLdMR0WPyKiwHFlax5s7z/HuV8iqKXVogzqWAKKRAM3Gm2vKJPs/S9qXO+iv78P6s6/ZpFwaPufTmWQQbi6xfKQVVnFpJQ4ktCkV1XpIzAM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vLX2thpZnjoTbctAfNknt0+wI6eS0T9gy71rmuafPSacerrTZrrHVfbHTN?=
 =?iso-8859-1?Q?twAkEUcFeqJdNwzGB+Lm6QOm9fQ1i1RDCfY7gN1saX05fxKz9UdYcE5BPU?=
 =?iso-8859-1?Q?TxlISKPYpXxKT1WyGVUtwhQi2su4RwbWu1dKAb7pynaqZIR4MjZFS+uenm?=
 =?iso-8859-1?Q?EFN6QCYjp47VvJYcUKoFWQ5saPfYsKRdz84J+OJFxnZI7f48mbwYXB+pZ9?=
 =?iso-8859-1?Q?e/KmdnaNx32/c/ML/qTG4RYzaQi+/m5anBviVzlxEevGkWQtHGhHnnIGGT?=
 =?iso-8859-1?Q?Y4NU10+95RlH0njRc+rJmqvdoDyXeRVnhrKuYVlrV1Pvflph8BarKFLAYd?=
 =?iso-8859-1?Q?cwCCOgfUOkOCbGp3qttHqd33d2IgPJp7Q3Ik8+vdF65NN/FKe+Bcq8Xw2m?=
 =?iso-8859-1?Q?nDDufyijGgU2jhbQIhksOnHG50r3vHRij0qG58jF29Epv7YCLmOiyv4xMz?=
 =?iso-8859-1?Q?jxOEboLR2RyIuPn025KJFa5SoOOMpzvT+Q2Nqa3TPQiFVZFGLczgn+CsQ3?=
 =?iso-8859-1?Q?v0a5gHJDxityonGa+UH617sOB2WZnJLOKBOlB7eIDr7BVsv5ELBTS33Epa?=
 =?iso-8859-1?Q?X07O8IET2Ui5b/OfKbydqeIEa8wYKQ78C8ObrYTWV1P7YUTsrsrpIJ8VRC?=
 =?iso-8859-1?Q?zVyL6RCrTBoIZ3tNQjDOFLXTaE4avd19rUJQ1Ej8QPfLIy2vjK2pDZz3HE?=
 =?iso-8859-1?Q?epUVgBN91TtwZ96WniMFXp6Qdh5NFe5IDDu79QkfWTroCfx0A5fsfWpSxK?=
 =?iso-8859-1?Q?PS6IJ9zJG/QkIP1sapTcCK7TFTZl8Q6+gMlMfCxrRcSI1z1wG5I7gQ3G4v?=
 =?iso-8859-1?Q?SUx4iDLe9+IQUmafQbWdy+XKP3Qyr9PBvKk7IE/856EllJSkoTF0aM8yiO?=
 =?iso-8859-1?Q?YD5hxTo3Vp2FEejzzGhDIO9v4clkA10UT2uFfMY9MZ9tCvg6PlKlNIwdm8?=
 =?iso-8859-1?Q?UBaPwmMn1MVMVOP5ftnMLu3vP3wwAXpPoD5fx8yQyuowWI55MWgFr/On+k?=
 =?iso-8859-1?Q?49qFu6xJJozuQm6/LFnNKt6ntNgrR43IK3YzqWtlVgdvuND2hQWvOzjlE4?=
 =?iso-8859-1?Q?Knbzi3Vzwr6U0DbmEyM3oLBWw6PBzEBcCCZ/+UUIQvumLHmRkOnHQjthoR?=
 =?iso-8859-1?Q?N8xhrXUur8T3j+6BN95rO8gUJTkTGlyGVVkzThhX5LMmaPkBp8qz1D82QO?=
 =?iso-8859-1?Q?Zuw46b534yidFsvtuW2F8cC3Mu+5Q9Zysu1pLyQ21+kt34FlJvm+tQ5VKT?=
 =?iso-8859-1?Q?IlRXN1wQuLtRQbngEnjN/q67p/h3ptjtHiCxUc7ZyjNQYWhe+5WHQG6ytm?=
 =?iso-8859-1?Q?0KNUFUI2rVa6anawMqAmg2k9tXyApcY9Eyelq6vGKip03B6U5ifvX2vcHs?=
 =?iso-8859-1?Q?hqwmdGegba6BoVoSxwL4/oe541I0b1zVJ3/0/oUk0F1NilPm/8dabX/KoE?=
 =?iso-8859-1?Q?RLcVpi5rdz5ItQaueFBswneTh7Ub9T5m+0JUuY1rHe7Wi+EoacVXKcfCDa?=
 =?iso-8859-1?Q?YY2CP6Xs1rdppY9C6aJdURVoQHOoyQfRTAVcMV2XTgtv9Eg8OeexiTGRnR?=
 =?iso-8859-1?Q?pLKIXfF2xeZrx8Dsni2tWiqOaLmiQHXMQX0UFtunBAHwIEaMMQuz/uZyPR?=
 =?iso-8859-1?Q?LAYNJbTJRaujFqIbO/EX+z9VvdrcqL8oW9IW/9mbCKLMfv/ttGFlXGkBMZ?=
 =?iso-8859-1?Q?nKxyINXuDW0c1SrnEbbFOynUPJ5gsglm/yoNium2QyOGbLWvWlJPQK9e4q?=
 =?iso-8859-1?Q?mkus1nLH88Zmo+ksGPY8i+NuLPb0IkUlRG8+wtAlIQuUrPmvm3zj6BF7Ew?=
 =?iso-8859-1?Q?vaXt8TJEEQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xzfP4km+kMYdyF2LObdofQoyoO2W6CVvTPLt02o3kAO46ylIoogNwBbQEb2bTzvHwSscYX21wJBcrmhW5s7ubcs+INhyPPk/CTEcqTfJFafBTF798tqxlPSu8Rh81UQ2AmnRcLdaPeNtXazzlajNHRtgnw6lLwhqH0ayH8i/5efdaXS/lrwEQP1xiSLPS4Tpoy2KdLFIpTOxkirsj/Fmt16npS1b2+sqfjtG4EGXlLe2ANxNTSaoBe5aLfstFhbScDojJtfBXCzoav2h5w9LYNDgG8e+uxWV1P0aKYKOdVjLEMQrRBaUnpYWY9zPEn+A6H1YeuPVrNuEIMb/GtI7ZA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a715828b-065e-495a-43cd-08df1ec3f2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:04.8580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiDvld23RI/56sd9i+GBkOAH6ElOn1b863EdXCvBU5HEAPWVTS+fc8HMiUJ/DoT4lwO+RovsbrUxl4C/OAFlLGQYidQ6Xy5KY9iyp6rs2EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6451
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the "unimp" array in AspeedSoCState for all unimplemented devices,=0A=
and use the AspeedUnimpDevice table to describe them. This makes the=0A=
code easier to maintain and read. Convert AST2600 to use them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast2600.c | 53 +++++++++++++++++------------------------=0A=
 1 file changed, 22 insertions(+), 31 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index 1a10d0fe1e..ef57bd0ba5 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -19,9 +19,6 @@=0A=
 #include "system/system.h"=0A=
 #include "target/arm/cpu-qom.h"=0A=
 =0A=
-#define ASPEED_SOC_IOMEM_SIZE       0x00200000=0A=
-#define ASPEED_SOC_DPMCU_SIZE       0x00040000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x10000000,=0A=
@@ -149,6 +146,15 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {=0A=
     [ASPEED_DEV_ACRY]      =3D 160,=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast2600_unimp_devs[] =3D {=0A=
+    { "iomem", "aspeed.io", ASPEED_DEV_IOMEM, 0x00200000 },=0A=
+    { "video", "aspeed.video", ASPEED_DEV_VIDEO, 0x1000 },=0A=
+    { "dpmcu", "aspeed.dpmcu", ASPEED_DEV_DPMCU, 0x00040000 },=0A=
+    { "emmc-boot-controller", "aspeed.emmc-boot-controller",=0A=
+      ASPEED_DEV_EMMC_BC, 0x1000 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast2600_unimp_devs) > ASPEED_UNIMP=
_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed2600SoCState *a =3D ASPEED2600_SOC(s);=0A=
@@ -282,12 +288,10 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);=
=0A=
 =0A=
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "dpmcu", &s->dpmcu, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "emmc-boot-controller",=0A=
-                            &s->emmc_boot_controller,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast2600_unimp_devs); i++) {=0A=
+        object_initialize_child(obj, aspeed_soc_ast2600_unimp_devs[i].qom_=
name,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 =0A=
     for (i =3D 0; i < ASPEED_FSI_NUM; i++) {=0A=
         object_initialize_child(obj, "fsi[*]", &s->fsi[i], TYPE_ASPEED_APB=
2OPB);=0A=
@@ -374,6 +378,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev=
, Error **errp)=0A=
     qemu_irq irq;=0A=
     g_autofree char *sram1_name =3D NULL;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     int uart;=0A=
 =0A=
     /* Default boot region (SPI memory or ROMs) */=0A=
@@ -382,22 +387,14 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SPI_BOOT]=
,=0A=
                                 &s->spi_boot_container);=0A=
 =0A=
-    /* IO space */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  ASPEED_SOC_IOMEM_SIZE);=0A=
-=0A=
-    /* Video engine stub */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),=0A=
-                                  "aspeed.video",=0A=
-                                  sc->memmap[ASPEED_DEV_VIDEO], 0x1000);=
=0A=
-=0A=
-    /* eMMC Boot Controller stub */=0A=
-    aspeed_mmio_map_unimplemented(s->memory,=0A=
-                                  SYS_BUS_DEVICE(&s->emmc_boot_controller)=
,=0A=
-                                  "aspeed.emmc-boot-controller",=0A=
-                                  sc->memmap[ASPEED_DEV_EMMC_BC], 0x1000);=
=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast2600_unimp_devs); i++) {=0A=
+        unimp =3D &aspeed_soc_ast2600_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
 =0A=
     /* CPU */=0A=
     for (i =3D 0; i < sc->num_cpus; i++) {=0A=
@@ -469,12 +466,6 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
                                 &s->sram_container[1]);=0A=
 =0A=
-    /* DPMCU */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-                                  "aspeed.dpmcu",=0A=
-                                  sc->memmap[ASPEED_DEV_DPMCU],=0A=
-                                  ASPEED_SOC_DPMCU_SIZE);=0A=
-=0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
         return;=0A=
-- =0A=
2.53.0=0A=

