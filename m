Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE3CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw5-0008KI-FK; Fri, 29 May 2026 02:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw2-0008Gm-3K; Fri, 29 May 2026 02:43:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw0-0002Ht-Di; Fri, 29 May 2026 02:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG+8Us7CBWsDHB3QSAxTaZtgjoHt/FxrQcjEDY8zV37xhkS/xW0vx5rADyw6h41VCawKImR1twATZpX2tDz9H6rFPAuXEQCd1yNoBAgtevxlhVHC4r9J4hiOQholqqIAFkGbRp0cK40IDHudkzwOGZFg8N3T3Hxhd3gjSNylWJG2JWFwHhRZLreDxT/8aG4EwOhTy1ocvNu0d8lipk6Uvk4RsCJtIp4tFTzonGh/yj3AqKOddzew1xBuTemIxkcYDF2s7odGihisyvOJKbpN1LkHBiO+qM2qJq48fys/Bx1MQykxV/Uhi7mlLlPGFg3MXvGchi2MdlUa5aFaRt3Hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2COri3OAciOAuppdn0wldz4F70fDz5mKgITSi2apk8=;
 b=NCJKK6fEwgT7IHrGexrqbYMBycFKf9JVTJZHZjg7WMwVlLJ67RbFI7kOaLhBFGbz+cgXqFbTbfrFPnoZOPyyKEhYTD6e1DeCEMjYmXgG7pRCEif7gmJKHUCmISJ8fUU4X/UwGlkTnlKC/vXR0G5NHEfGl3n4m6QYMB8SWYbVtqxorkPbhEY2hEysZ4IkOBOmiRmh/EXUY28kqHc1AsSzcX/jQNpHmpswVfHKHdd4SFDdiWOmP02pB+FiryEclhz9aDx0HPbWO4ljhIUED3X9S4xoYZVx2Nt0E/ADB+odGtfQXfwcn7OwppVavUQ4szx2xkv+fI8t1zaWfMV5RKvptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2COri3OAciOAuppdn0wldz4F70fDz5mKgITSi2apk8=;
 b=kEt71DiHoUdXVvXhGHwsuEM9zUl+f/caEg4lCMXhDogE/sR+OpzJCou3Y1Cy3VaqOAUDx+N5L26pKAkjigdY1XpYwbHH541zgmNK7ccb5cyCQrKiDTulwyTpUKHe0fIr11klmGOScPylzH8Hiidf232Zs1fyuQ1d/1dXlgiUb70KdYvEySWc0OMm+L2fMt9UVNjIrneg5yf1I7mtmqs9FnbIOLMMjXuEVcBtN5FI4wT6SLutJ0Jiskaqn2PkVtJVf4+Yu+/tqt0BP4k1CBIHj1WszKodNGst2YHhqJqYL5UGQIIBQZnMTmrHdob76hv+CZ53c0DAE2MZnJByW6tL/Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
Thread-Topic: [PATCH v1 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard
 I2C device
Thread-Index: AQHc7zZhOIvpzBPIukWFXsINZP3HIQ==
Date: Fri, 29 May 2026 06:42:55 +0000
Message-ID: <20260529064243.2064188-10-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYNPR06MB8451:EE_
x-ms-office365-filtering-correlation-id: 9f38e16d-84d7-4fef-406c-08debd4d8396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: mVyhte2CV79YCsN5MuhENX+PoNODQEzWJNfYeVftkK404WuIA6LjZ5LCrMwa3dywAvoql4Qwq28gSGQ0myUKWm5BXXVwIbhhGHhOm2/8x9oiS2I2Sf3gmTbVRCwPtOI1uawT5oiU8Pv/x/G+gs2wSRvjXcGklEiHYVMBdd8ga/s6dM3iJSp8K48lCjUvB5oTqeRx/tCG5SlMZRun1IFuH+fr75Phhn8rnzFoozuQeEayQBx1dKFssYd/rnXu8WEPcVUMQKEjVduiaq3oEyisp35e+ZeTIy6BgfNWNyw6m7z3SklxuV76313k4p6uy3q3ZIXNpwDfZ60CgaEUkS9yiTzBlPrdLs/9IL+fH08Uq1eqatooVGYzwxMOZp4zmO4AECMVReaPtzUWoUVzYVkMmm6sgbcvKdiReKfkO5TPrP0QwTwXMyYmPr0xWvN+Y6Ogayxc+Zzn2Y3ZYM07Oc3q52GO6UGiE5gw4cNsyRRMJZCF87MdYwmHEf0uJAQrh2T3c7Vwm/CXiZ8UOkZun1dHF+Y9YP0czSeIPWE+FWebkP9NsY/bFmlCPPAEWz61FP04shbOMEg8VM7OwG2pwx3PTMIuW+D+7pIuicqMpV/80/SusnKmrRtCH/V0asyeJRQs5sRKR26jGOa2VaDmGTnpAIh9oi8QH0QM0gm4IDzNeqOu5jEOGJAd8LDp1/3NH38uYflozqy0uDgpIHfvWa1eYvbaNQVccwlNIA4rQYruC7TwrmA/GTjC+mvQNjqumKgM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?km1IKITOiri29HkombxrFKmsM+5MfUBu5ewhnmtjbMO/kGk8zm4boIjnp0?=
 =?iso-8859-1?Q?iCDhH+RgvhPb/OjP8caexhyVCc+P4VvKfY6il6toN3eSR2PfxioK3WEeYO?=
 =?iso-8859-1?Q?Oe2mzld1ieB3OYtrgXIVWGhrg3udwfLyAAWmsrv0bkDyWuyhaR6ZZf0l2N?=
 =?iso-8859-1?Q?DnAK0J8y6um5hVHcaUZ/hQqKnEfXjVqJSUDMCLvx0qC/GE7jnpPqu3+tpS?=
 =?iso-8859-1?Q?YQjK7h8wpCzA1PMYcDwFhD/tBPC4rnkTLp1865qyWk+eNq5O0VNBTz7xa+?=
 =?iso-8859-1?Q?yWKG27N0LrUtEExdIPgiECNtalvZ0Si8BTFL2KsMKjuZ7Ie3x8Z806NKPz?=
 =?iso-8859-1?Q?h25LOEAG/c1Kl8zMgwjsJ4lrMcjULjTFzq6AsVNfLQdIXpY4Wob+UpiWuK?=
 =?iso-8859-1?Q?jPR7c76I4tiGHkT1kL8LulvW6jUmpiKpO3O3146c/tyJGqpRgYp7tf25Tt?=
 =?iso-8859-1?Q?BCP5BDKUkfYglYcLtQ+vAgTqNXrAZ13oyCw+/GoZDkt02Rnh4clMz1WbXc?=
 =?iso-8859-1?Q?zGx4jOxmyUmv7MTawa9bguCBEQzr8Ci9SYfLB0tTzdCgw0HgEHXh+Ah+cA?=
 =?iso-8859-1?Q?Lcp/w+G/BB4sZUkK6VXviiYJ44fDxb7bag733dqKa4DL/qLEIxNisoGShT?=
 =?iso-8859-1?Q?sdmG9H1qiYHDy0Vi26ECd+Z4EaMq2+OKiV/goYIh5CpoCGtZD6pQRDsxSo?=
 =?iso-8859-1?Q?NMrUFO/bgcws3ouy0lF7rHDwvxivtjFZfQemGwl09faCuM+JrX8fiERiYR?=
 =?iso-8859-1?Q?GcDbQtikATvnADf5eH0NzkwNFc/PRbG+ipeLYmFRuprpaOR0I0K47ez2js?=
 =?iso-8859-1?Q?kzyHMdgRzyU36HzmQNItIyRZS8yq1/y7p5wAy3gIgPzmYFlLZtdHveQSia?=
 =?iso-8859-1?Q?qp2+//3gJpMRBjEv/Jc7riFgW6P8xg6B1WlaqoVwsPLZwwkFETqHJgFzr9?=
 =?iso-8859-1?Q?+jEl4eBzjqdxe3+ADonM8Jczexrtt+X3aETtsAwk6P+YwyBs16tmo8V03s?=
 =?iso-8859-1?Q?NTVzdHEgVLqYeiwIEL7TAdWkiolKT2ovHrddFuQfIJpLFwk8w/e33txCeI?=
 =?iso-8859-1?Q?4/TasW9PslfespfVU8+ADMrmo0Me9WFs7uscbEJgaH3/jaLRj5GV1fg19/?=
 =?iso-8859-1?Q?dqAPqmo72ZF+WuFWciRHQvOlm6V+CS+kZu2gfpeFyqbz3a02bgP7/s/w+g?=
 =?iso-8859-1?Q?/NfMOglIYDTdWEFHjIIQVzJf9Ot7ogFwrBqwENaghisrsgNk0+YjTIuIn5?=
 =?iso-8859-1?Q?3UnExwrFHsoLikYvmKChgn0StWT1quDWPWYS61wmNVXJQHxcOkIHH16aQe?=
 =?iso-8859-1?Q?HO0YE8aFx0Dk/GVY+7M41TaqroNYeinWPeauuaisaEesqXjIRVzGcR5BvI?=
 =?iso-8859-1?Q?yOrToxXVCmFUh7Gn7/34FBSs+V/oDuoS6MbzvTR+wWFnKTOBgPwuHSXTIw?=
 =?iso-8859-1?Q?dOjw4l999ihkxqlqQCT0BSH/R7FWZ/KX/lUlNEtJm6y8+313XtkuPGA7UG?=
 =?iso-8859-1?Q?cArUHqQlAFpDpeSzMkz5u3VA5GyPbQZVtLFAPHTCKOMadaHMb7ERlqGwEV?=
 =?iso-8859-1?Q?pIzABSVTnccbxnh6pR9yIJySQ6E59tJ+vep8mFpjUrZdMsu3giP1zP+3pG?=
 =?iso-8859-1?Q?m3nlql6bhDCVR/7zXXHZd3GjI5rlfDHMYmwYD3sRL3qmp2N7s1YamCpPz7?=
 =?iso-8859-1?Q?3xiIvVqArvWzr4zMr6+xIH2aQs+U0LCgAEaKls3ooeAhQSO/dgbeOrdRcx?=
 =?iso-8859-1?Q?98pLU4JIPuDGOOJPm+lOUI62Nu+jmybqLJ+0WMFa2gORp5bGjBJ++blZvK?=
 =?iso-8859-1?Q?QxU40YldGg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: arVvsXYNDcK8lMbSYztKLA1+7mNUNH0ZMBQC45KLDf10bEhklwZ0tS8oL3j5+XZLjv2QqkekdnIl7awBbhKFuUHsmwQqfO9AXtcJqsEzzin4T5021hnwUQtp4MlXsle+GOAWI84mTOt6S+pEIXHq5e1fnZ5S0uGzbFOB9m+k6io3l1nhEXw5j655OksLRHA5+KCCwlDhxgeWfG9cAswnFLQ4i3rRjUK7MGbk3AKIccYJ7YqP5KQVeIEgSQsfglSCt1mPz5asnlQ+wOurTlNgsp7wCAWIVPuZV2ncyDwFZAuyYSnvCIT01cdrZo6H/FW8ZXnkEClGdpAuhSpEAaL1SQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f38e16d-84d7-4fef-406c-08debd4d8396
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:55.0451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vu9gR3Flr2gCkjlkcVgj4Ptqr306zvwJFFEIA0nrmXKrenTddoclG42y1Flo1S151tjwhwfLsx1nYC7UL3OQhimL61xEfDktMkA9keMXYyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
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

Introduce onboard I2C device initialization for the AST1040=0A=
EVB model.=0A=
=0A=
This change adds the initial onboard I2C device setup flow=0A=
and instantiates a 24C08 SMBus EEPROM device connected to=0A=
I2C bus 0, matching the current AST1040 EVB hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040_evb.c | 18 ++++++++++++++++++=0A=
 1 file changed, 18 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
index 1d9b55247f..392b0d5159 100644=0A=
--- a/hw/arm/aspeed_ast1040_evb.c=0A=
+++ b/hw/arm/aspeed_ast1040_evb.c=0A=
@@ -14,6 +14,7 @@=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
 #include "hw/core/qdev-clock.h"=0A=
 #include "system/system.h"=0A=
+#include "hw/i2c/smbus_eeprom.h"=0A=
 =0A=
 #define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)=0A=
 /* Main SYSCLK frequency in Hz (400MHz) */=0A=
@@ -38,12 +39,28 @@ static void aspeed_bic_machine_init(MachineState *machi=
ne)=0A=
     aspeed_connect_serial_hds_to_uarts(bmc);=0A=
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);=0A=
 =0A=
+    if (amc->i2c_init) {=0A=
+        amc->i2c_init(bmc);=0A=
+    }=0A=
+=0A=
     armv7m_load_kernel(ARM_CPU(first_cpu),=0A=
                        machine->kernel_filename,=0A=
                        0,=0A=
                        AST1040_INTERNAL_FLASH_SIZE);=0A=
 }=0A=
 =0A=
+static void ast1040_evb_i2c_init(AspeedMachineState *bmc)=0A=
+{=0A=
+    AspeedSoCState *soc =3D bmc->soc;=0A=
+=0A=
+    /* U10 24C08 connects to SDA/SCL Group 1 by default */=0A=
+    uint8_t *eeprom_buf =3D g_malloc0(32 * 1024);=0A=
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_b=
uf);=0A=
+=0A=
+    /* U11 LM75 connects to SDA/SCL Group 2 by default */=0A=
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x=
4d);=0A=
+}=0A=
+=0A=
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,=0A=
                                                   const void *data)=0A=
 {=0A=
@@ -55,6 +72,7 @@ static void aspeed_machine_ast1040_evb_class_init(ObjectC=
lass *oc,=0A=
     amc->hw_strap1 =3D 0;=0A=
     amc->hw_strap2 =3D 0;=0A=
     mc->init =3D aspeed_bic_machine_init;=0A=
+    amc->i2c_init =3D ast1040_evb_i2c_init;=0A=
     mc->default_ram_size =3D 0;=0A=
     amc->macs_mask =3D 0;=0A=
     amc->uart_default =3D ASPEED_DEV_UART12;=0A=
-- =0A=
2.43.0=0A=

