Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DB3C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDE-0000YC-Mm; Fri, 17 Jul 2026 04:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeD8-0000WU-OF; Fri, 17 Jul 2026 04:46:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeD5-0003vk-PD; Fri, 17 Jul 2026 04:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD9ZMpnY3uU8FUn6BWliRdotW+96THh4UyQCDDd8mT8Mj4eI8Nfq/dpqleHfc6Jwt8Qmy2hyepGTZ8veb3nLXQjkra8wtEB33Qq8NnrZdfU7v+n0ZOEemXIlWyoQ3X5GPiXijqm3JK7jmm84YsW3Efmw2EkqMC64zUvXOUMRAQnXDl2GjrQySy2HhjgJHHmQh+JBwY2PNsVzn6LcnwkHSbUDG58cFg3xOdH1spLBfs5yTRc6IRIbI5F+t/SvBmT2hOwVyHXPS4G6qSHUdGhs9OncrJnTTABr6n0CvqhM9LXDXKm/x2kI+1VPaieuKW/4dQeH9VEWIK2ueZJn3Mxv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EtducN+8fhTYctWm2wbtQt49nfZB2JwSg3flxJyjbM=;
 b=QoaLnD1wwY6BkNUloKVEw/p1zzchTIz22cy++0ki+5Tb1ALzVxI+iDmTDp8VmNwlt4bD4E1KM9ixwFOOufSVSt3+5rTJ7s2KfJOqtarLSPveGtK6Q+sMjsP79j3t8/Rwvik9wqnu83Xx/6Oj5sZ7FzA9iIxJfU/ZMOa1moq4q9p8wiRm4Ms1hYrb8LSqQFvFDYDi9DOfxSqrZAOG9lmMrSpTirMyITlU3JWnpghBVuDn02yGcRAbLfcdI6/LmmGzql0vXopj19/zoQDQpxRnJqJodNeVnhRny2Mh1DypOrLz6QTz7C3oZlFuyKxNofxpb2h0HHfo4QNEBEO1xEB7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EtducN+8fhTYctWm2wbtQt49nfZB2JwSg3flxJyjbM=;
 b=rN90aFBUglaU5QQnq94shCMpNWkZk+Su1CC34/X5lahBZDLR0CFXH51aHoPBBMnzRruU3ynGLkWkGY1J3EJAacej5wx2pPUOs76LMezaBu7ASTZcBztu7TpEpq2gJV5ftiRM/GPXTFqfsAREriPS+e/QCWNGc2ev4D0Rsew01FbDep3eBJMwl+fwQbA18DbG3hOjhJIRj0n+xQbXDPs7BsBOESjuZEVf7808AMOPR+8ae3k3ysqQ1FPBil1jH4p8O80jryEhFaYRDKfIvLhJMmMebOGFsbhTN1gRB7HMWwUTzaMlH/1uW9wJjQbcwjMNyxMSixypaTxGhq/kk9UM8Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 2/9] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
Thread-Topic: [PATCH v4 2/9] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700
 users
Thread-Index: AQHdFciyqMh/T3nUyEulOKnlW5vApA==
Date: Fri, 17 Jul 2026 08:46:02 +0000
Message-ID: <20260717084559.3477061-3-jamin_lin@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: c51b1df9-b307-40a5-36ac-08dee3dfd54b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: GuowIXIG+rlHw6SYCXJT9V51JEWcM1zKDRX4cCjdEdSeSJJu/ZZt8JroBa6RW2f0TW237kn0y6SisIQcithqy05Ib1EcMv9IlC1z2IKPI65TXeVJTK5VE2HKn76j0H1tn2T+ljgUBo5SRrOnM/e9CNB3sdHd4Nq7N6TjuenKUZqbX0J51fkzNURehx82A/byhwf1fZ6RXK/CDWkFxsSBD8xrp7MLy0dY2L7MiKcd7niVqp8BvcXjQhUMaP6knQKqyHbmM5c0T7QxndYD8VM5fojBGNTKEbUXxytJPIxRyBxX/lfKAcg0UxxSlPQySoJ46WTx0WVdjndYBbFGbUDhbCnz8yq9PTFLpqro4XshnNhgH0X74PoN9+IAcNsmNZma52LH2IfUmetYLM+KlJzWFDbwjaVgNQ8k0iPeScsVIhv3m05j3EojSo9gmZZd/x/FtlH7SdzFYjgS/F/Po5wuTGBxyv2MA/iyFJ5ldba9fRuSbGrSDzwgIinyl3jvRxoz0mYl1UgT0tsEYrLxsbPxEjsOva6ZZKCL3Y3CO+hHseNNjGMp9BJPO4F6ksHe10JS+sTeHyXvtkjIImMmvD/b/Shuye5/Y0HSkpEW4iF/IaQyiGgvktMBO0kc4OOGOEwWtHtItFRFOjWrKXxNl4JZrSvTKYkK/EYlTa+0YiEbftO2e3Kqn5eWtx01PvS/5YL/gx+cU1tmuHym9+CYhgfosXw6M5VBgMvjk3w1QDT29rpXtJJYBr2BilHE8sWdVNfZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fwgp82aZS5gy1oHdFDa0iE5MDwjmYdSvomhRzP80PXhu5yIX8uV7DM0fJE?=
 =?iso-8859-1?Q?HfSvropPcvWjh6KOzRJ+8ysuV3Ir2MxFTrKd9N6PWIIK+bRk8j9dlV2VwQ?=
 =?iso-8859-1?Q?XUUGBM10NCmWXZRTQmD98OTVf9JTVDgbmk/mov+UZqvFJMs5iwKlpEdvdB?=
 =?iso-8859-1?Q?mZ14AjxoXYBk9Nb8bCHLeCIFgA+FANPOfZ1aZQW/XGGUYCsvWpVHigAFwV?=
 =?iso-8859-1?Q?sFAda0Ilxdlun7SFpkiK2c3QeUaQUSo11nRgZ4pABsEfiQYAt0b/beLvud?=
 =?iso-8859-1?Q?5CzcLtuLGZJ3GQ6CroLXs/MvHwd2GMXIycYhLVozAnlsC/gPzMXaFrOYZu?=
 =?iso-8859-1?Q?EVlWxLULnfrcS+U1E4GRAH0EQdrYzNvYSdB/FnvaDohrJfqk1E+SxF4QWV?=
 =?iso-8859-1?Q?wZjIYOQtSq3cu9lxbr8ku/xllS5V+PuTJgAgMvncHZk1WPI7iCmUP2w6ez?=
 =?iso-8859-1?Q?DTK+cDY2+JUUf+EqI4WLEhflmAaLlcumKGRt50GWUoH/FwbWMhUHiT4dcG?=
 =?iso-8859-1?Q?cdyr02YYDWPugqkOeaRTdeKPtn8cBHiL0Qq74DxLgbfKOtaYClNL8z7tPA?=
 =?iso-8859-1?Q?YxifwOGYzbjvQU8AvPBzNr/XmkSgoVgUenYZ6nyTamsu4rZMFBKDnn+4u1?=
 =?iso-8859-1?Q?h8yaAFNc9I7vCapxYdo0NRGIQZZM6Om2Ua0JsnJS8wW6ArK1IjEpCPEnZ4?=
 =?iso-8859-1?Q?3RLLHx5OdBAbejgKjHZhgjsuOZhzJkUkq7psRDwDJxDzx7vpPaOYyTX0RN?=
 =?iso-8859-1?Q?RDPI6dtF5YUqEcURj5/UJjjaRX0qbxHWv+8FDMGqszc4jjJ0hh4XWkX/pp?=
 =?iso-8859-1?Q?ar+7EvPOBn2jqZAR3RpSST4AV8lGq5jN0tI6lISkpkKzrmkBIyrHI62YZk?=
 =?iso-8859-1?Q?GqU1ATkokd2UpUDymDo/896+U0FB851yWeAwiaH63cPzt3xiIjsE57VmBS?=
 =?iso-8859-1?Q?z192lTRTaFp8N2IwO6TaX2ag+jdZzf/XXQPU1ccecaIN5XUvJNZ0fHALX6?=
 =?iso-8859-1?Q?wDEaevgSq4XKusgizQ+JZIYFSea+XzH0+YEJr0hsWdPOmAfo5bAJY0lCWn?=
 =?iso-8859-1?Q?Qzysj9dAZ4gMzGJzBVrrbx9vRjK+1+QFwvb8ZaG5AQbN6SP3DFgQB+eVeg?=
 =?iso-8859-1?Q?nl0ljLQcB0VlGdr58lRqe80VokUzuf1NdgV7OqjEZGJjqR5e5Jwe02T4Me?=
 =?iso-8859-1?Q?xT9Z8kzj7zGiK12pEHuG8YgY5cl7/lubbo7cQQ2LY0tXGiN8NtGpshCu3i?=
 =?iso-8859-1?Q?r5e6A050Vs9ckebxqa+VjJYE7WRWTCvg9N7QjPP5aRIuvRSOv3BRXRcWjc?=
 =?iso-8859-1?Q?F98+oj2+w0GVnKP8VLZMjlYKOnq1GejrQKlV7o9ncEwaXVOjZB+OfY3t2S?=
 =?iso-8859-1?Q?HO5WQKKx70ua62fQ/dohfLRXp12qmHhaaOaIKvJcOC5iTxnnHybkB6wcTl?=
 =?iso-8859-1?Q?yG7UbZyHfSvKStgHztgYSy9VfDHR/e4xi0CFhGzyC4WKt4hojkJ11QmZq9?=
 =?iso-8859-1?Q?sMAbI7/9N4m+kNDTIRqF3CJDONcZqcf2m41nXkxqoFIm6KzViU777yBx3Y?=
 =?iso-8859-1?Q?WoYIyhmj1HXIEq3zEW4BLAWpV+qbawKtmYxB6TLQS5gNy/SqJI+e0YlRq+?=
 =?iso-8859-1?Q?NQbKHinxCzXmOSgYdfgw8l6o7wsqCPQpJxZEdt1M2SD9YvPArfFQsF9h+P?=
 =?iso-8859-1?Q?lOpj3o7EiFykHvu/yQyk2PLvaU916EkgkYWmpOa0r20/GP2Fm3FpBNY9lU?=
 =?iso-8859-1?Q?piMqUKzDWfTSC3sM3pnlJ8+yqLnKC4A5nxA1YZIoCPzCiMMwXZtR+4QZms?=
 =?iso-8859-1?Q?A9EEyS730g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eRgkKbKQvC/OY3mvC2lwv5st5aMmv6poIcsL4U0Hul2W4G07jvHT8SMdCRwVbm94Zwaek1bMUxM+ouGoHEBfcONNYO8yI0bugjsK2zWwBV1Ev4PGH3VGsrVjfGm3PI/SJxIh5QODZfVOPa8nJWrq2uaO04jUVsPL4DTxgQG+CvNbgZHBSqTGpv9HJQ01RQmBEaxHJRHAzZ3ROo/BGe9O2Ry1RZs4GKuLCkXD9LIx7LSp3BpvalJZ6nGEhPRE60Dy7u4wPNZst6030Nww2AjdprDLzva7CfRD/a8p2KIWT5pmKr/xaKc4Sgsm8x+hFwiRAkok65hlL52M/zJQiSmJuA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51b1df9-b307-40a5-36ac-08dee3dfd54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:02.8438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ODOpZ1c8UqyyL70h6f7BExL1NlbCB9tdJU4wxZ8OD+IqEClkedQ11xSyd6TUYPJNEBEdsyhRJKlTzY1VYRt1Kv253r6q4so2A9IN3VJAs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Now that Aspeed2700SCUState has been introduced, update the AST1700 and=0A=
AST27x0 SoCs to instantiate the AST2700-specific SCU subclass instead of=0A=
the generic AspeedSCUState.=0A=
=0A=
Also update the AST27x0 FC board to link the SSP/TSP coprocessors to the=0A=
AST2700 SCU instance.=0A=
=0A=
This prepares the AST2700 platform for subsequent patches that move=0A=
AST2700-specific SCU functionality into the subclass.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 +-=0A=
 include/hw/arm/aspeed_soc.h     |  1 +=0A=
 hw/arm/aspeed_ast27x0-fc.c      |  4 ++--=0A=
 hw/arm/aspeed_ast27x0.c         | 16 ++++++++--------=0A=
 4 files changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index f7bd4e8650..39c5977cf1 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
-    AspeedSCUState scu;=0A=
+    Aspeed2700SCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 41dc04e293..cd68c7f1ca 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -151,6 +151,7 @@ struct Aspeed27x0SoCState {=0A=
     AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];=0A=
     GICv3State gic;=0A=
     MemoryRegion dram_empty;=0A=
+    Aspeed2700SCUState scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 7d9fade68d..8d49bb95d6 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -158,7 +158,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->ssp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -190,7 +190,7 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->tsp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 7c062580f2..6365dbd638 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -435,12 +435,12 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());=0A=
 =0A=
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);=0A=
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+    object_initialize_child(obj, "scu", &a->scu, TYPE_ASPEED_2700_SCU);=0A=
+    qdev_prop_set_uint32(DEVICE(&a->scu), "silicon-rev",=0A=
                          sc->silicon_rev);=0A=
-    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&a->scu),=0A=
                               "hw-strap1");=0A=
-    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),=0A=
                               "hw-prot-key");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
@@ -808,10 +808,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vboot=
rom);=0A=
 =0A=
     /* SCU */=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {=0A=
         return;=0A=
     }=0A=
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->scu), 0,=0A=
                     sc->memmap[ASPEED_DEV_SCU]);=0A=
 =0A=
     /* SCU1 */=0A=
@@ -934,7 +934,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
         hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
 =0A=
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&a->scu=
),=0A=
                                  &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
             return;=0A=
@@ -1037,7 +1037,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));=0A=
 =0A=
     /* Timer */=0A=
-    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu)=
,=0A=
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&a->scu)=
,=0A=
                              &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {=0A=
         return;=0A=
-- =0A=
2.43.0=0A=

