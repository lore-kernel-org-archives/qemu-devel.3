Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E500CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw4-0008J8-Rb; Fri, 29 May 2026 02:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw2-0008Gi-0J; Fri, 29 May 2026 02:43:10 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvz-0002Iq-Ng; Fri, 29 May 2026 02:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx6trVHsTJdlH9/IkM2rS4bHsjC9X+ynl4QcxFwfLj9ItSU8RmbWjjoo4kF1JQdvESSPYDzFiQDcoIsa8zj+2U8T3tzxWfHKqQAyyZuU/VnJoATRf3cWuFOUOLo/iyOxvyEJ41yDY9PxSPUQXqwe7ZDyjKnuVy+T8ts6Pl9n4kbKb5iEhS17Y08wcn5i4AlwYPe8MFqxyCH803OOq/hE5rA+58lrw+M2dzoIuyLfIh5SQKeYMkNnp/OI77zqaZYvDTgacmXJUUYvL9u6YzbPmf2sZ2bqwaYxp4v7Dn0+U1oMDmJtsTGNK3kaP7KbSqAFxQwzeV+sYKhvnRPxqJIbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYP2oCrF2Mk3PQeHuh/IjODUlbCOHOnzegTEQRVubr8=;
 b=yW4x4xvkzRzBqHcvb4LgIDbM6tc6kxk7Z6/DvGFsnWB0H4OEBL80pFMfxfquoMLAFRH9J2G6t1uZGB8j+fsiaN46JmHNqmoE2fIdPmrmH98zlMOlQ+uYs/bn6bW1nu0dXMoclcVWCLalZyQhogHagFCUkKD9HHAMIAZzzyORuVjHjm6qCAzjJyC65RqZgummWrSiJMdG6Sr1khFd/i1B9NcWpkFB4ofKaITYInYmTw6KGb44zQEllSZIO8M2lStYBweVoBp8rj3tdkIJ2DA+WOeTyrq8K9rmjcM3sflehezVYQbGFQQf29BkrN4qsToeJ6tsE0CfNjmRdcNJ/DBJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYP2oCrF2Mk3PQeHuh/IjODUlbCOHOnzegTEQRVubr8=;
 b=oUhZh1HRP5ostlD/8GZIm5wrZFLAeSo6Rc2qISTC4k67cSglV3YZikIHnnR19QPcM/8UeYPM57ZDVbyiY5PdariJL8IfEJV+EcIAoYZdi+s5W8RFOtr8vwuh6t7RGgDfOn9ZKHFWaS1FpLGB1ny7ZpBUX4Uu4pOT+Tn+ZEngRsL//hjLpfokqe54sEuz1UYDz5/GhPUMzJdjcPBkKWI1UBiM6s6vXCTE8fNOnm6j62bZaxQNev1iQHKckmg6DYO65LyllNgl5LONLkbwhD1EHfWyplgONFtrzyIHD0Ks3vRjRTdrKAcZTDkWASRMQ5dDqRaVP6C/aFUBvm+FiNpNYQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Topic: [PATCH v1 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Index: AQHc7zZgTC3y9PuZ4Uqodo/0a1fAGQ==
Date: Fri, 29 May 2026 06:42:53 +0000
Message-ID: <20260529064243.2064188-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 7ddfd6e6-aaf3-4757-ebd6-08debd4d82b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 064JZpAtzMdEvpYFaUxpy8+6J75sqlYFVQKNKWXqP8uf5VES3wZp/dLIAtHqwOPPc/MGFSLLmf3R7lC6aeapvKfgW49+uZx/vb343w823yDtNrzV/HUUx9gggNx5cdTIFrbErw2hlrGYrY+ZmZEL3T2RWfKK4mj5RQp4+VS4SnfCDBqUkkkjXS7GHpwDOSpAD7T8697ejfanjW9U1qSYyuFED/ZUXzo/K+0ZyJZgtjZGSSAdc23n1XkSngybZK6WPQY11HklAHlB7o2gydps7NyR8Vj1ovHVptPPlJGYxca1owOwz81un9uZnbf4TKlLcygRoRMOU/xSxLEu9Q5UXvz2yke8+UG+mqLOyA8Jx5Cx0obTY7LjtZ/vYFLxWlmssrvlaBK6qI9jHgjHXnxihv+3OnSIvrjA62+PsfGFvTBYcKpwrkrq509xxUkQMi0f5bKLbJIH7+LBtdWxl52HH7h5MS9LQHydnGseYCP0tKLYweWamHl6VyWV2gYH7dVL7+z5lpWNam+IYxbkjKohJk+2QIomo3N5W9RjGKoSD8WMRsfK6G2fNP0dKauwg0DgF55Yt4MNkYH2bGJfjU+ecywO7uZIZUEyOFSrMxW18ZGVdWDKdLba3gLsDj4eVpvtt4NZ+Kd3R/k7UxOnn2S6f52oyWdPHHo7pZ05Pnqro6MctU6PpmO9DUufrpIfzcWb6H3Q97hgLL4KX9u/BrIZ/WDVklbtgEsR/57krZ8m+20E3iZIsHuV5l7cGTIyTi2H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JqyxYw3DL+L8LDAAP2Dd82qvg7WNPrGAcBqKb39ixQZ8+v9CtiE+Hjwmby?=
 =?iso-8859-1?Q?0FwzaxVn7diGK/P28buFuwGjObVk6f577+lVGN8V6UrHsDmsxoBjtJSB2R?=
 =?iso-8859-1?Q?zjPi0FkEQ3S7Ovh/IuUeHVdQfHnrN76PG3K1hqO+lhFkLQZjl2ihSmhe3T?=
 =?iso-8859-1?Q?THVL3tYXI+JNpBaybFyKdmILbk+sIIMzjPHpGx6MhPuLELsy/DJ+zJ/yK0?=
 =?iso-8859-1?Q?01mHv0rpMHFB4PfQLWG2p3bwIibgbbPq1wys2wk5gOPP74hliHtGDbEwnb?=
 =?iso-8859-1?Q?aBx/h2URBgoPE+i6zS8s8PuWm1mjljv9cT5lqPlhmHJ54o12fG7Mq80V3+?=
 =?iso-8859-1?Q?VEnwm8PhNv/+RQ7hFaU1orTNeGAhgR3Wd+Fj1RORChREOHPLWWuST/pURc?=
 =?iso-8859-1?Q?TG+I3wsjKDul18RtDZWMIORjSHfDdl2LgZtfVLeuA9TzeZbLM9IzbQ0vg1?=
 =?iso-8859-1?Q?xsuxtbguiQA7k6twjzifpEZNDC5J6TPpDzhOpz+CguezUZ7u77R2CGtBTB?=
 =?iso-8859-1?Q?hrVd7eCOLNWQM1Kfz7Zzqx4aI50fbdngQ8Gj3dPEtdU6iM87UJAubvHDsD?=
 =?iso-8859-1?Q?KLvrsVdfRmvr+vc1kAa/UAMq/Qr8/XK8LFIMeTqMTUjABwVfHgsaP0dIbq?=
 =?iso-8859-1?Q?WfKzQnxUmLNcr0Eci1JShWTv6mqRosr4ZuUOs65sUMB2d3bUZ+uLJAakAp?=
 =?iso-8859-1?Q?UwQ3uJZ2SbSVsY64kX9nnGSTUTaz3l9PzDfW5bAw0oMSCBaHuaKzNatLvl?=
 =?iso-8859-1?Q?ekKquQ3YE4b1yEeYg2utJwt1asBMnujSQ/QF3/5+QsOEO+BDnwNrBGiQuj?=
 =?iso-8859-1?Q?qyOA2Y4u2dtXKMTUR02agyEvFtv0q1yPuZIbQ3JGUnRuqU7vt6qLfQhG+H?=
 =?iso-8859-1?Q?waMwV8g3cT0iDCltS+uUmomLyQRUOu5n84Rh2uM53RErwwMoNzwgZMsoBn?=
 =?iso-8859-1?Q?W4YKYOfEWZSmZewL88XEvsH5bzPEInREj+PZrfg00ZAazcCsLNjx/KhZo7?=
 =?iso-8859-1?Q?lU37vfsmZVeolzNRRawGgTg9BuFWmPWsyxQiKiu6i+KZR1AZ0+2RBcxODM?=
 =?iso-8859-1?Q?cfu7FsoaON8kQtyUP3gUfY0OjVEDWUjXKrLLwq6Q63MmRYn9GO9WAazFT7?=
 =?iso-8859-1?Q?Qmqcdxw1K7I12Mj55XTdIASWAjwutEW8kHwSZcOGxL5zTI0k0ZI0uRH9h3?=
 =?iso-8859-1?Q?j8llFg9tTx/3eH9B8mTKcHDK2mqlekEjaa2XkRsDRtkhpxpdi2r2TLoKNC?=
 =?iso-8859-1?Q?++vdApbppg1tm3egyH5+lqGa2EFXLwmFrSpkZvODwe0HG+1z5JNUzVvIvl?=
 =?iso-8859-1?Q?WiUCE5dScOc07qaP3vJXQGOfulX2wiGDF/+Ce3cOEd0rAYl2fqOxXqkmzI?=
 =?iso-8859-1?Q?LYzl29yoj6TCc2lXEyECAT/92PYrXdHtVi+W39gww/o/kLhAaHjTM3q0jZ?=
 =?iso-8859-1?Q?K3q1gr0cKLBB2IHSll3nhW/9tP1pd4UT45IJ5mIFTgF+Xa6bF6ZRX3WU2P?=
 =?iso-8859-1?Q?0ouwFFNb/DsPnOejgyQxplyof46xSCpHoc7hijoYgDbNYsJb4X7V7unEIk?=
 =?iso-8859-1?Q?nwdKGYPB3rKT0r+IcJc7EA7u4bBLfT+wXDHzsoNddBWZpiD5g02KMjLI2g?=
 =?iso-8859-1?Q?7NAfZQ1xZ9EjUIYX5Sy9V2+BI/DobBwydD+kTBtDlEKp80awsJoZePg5am?=
 =?iso-8859-1?Q?A4Se5Y+lSDzExmLOMUNe+VrBiFu6simnj54y+IcMM/NDR0agpxnW0ht+xK?=
 =?iso-8859-1?Q?t2FR74ce9NB/HfGvmgMLIoh51SZjpM68R3KKPBNU6hEAT+cvBNUH3mY4Oz?=
 =?iso-8859-1?Q?VUm/1RprwA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lMNYJIm8Ek38S0lwOJzApp4rGNc6rzIx0eQtivaEB4Is5tI4ZKCapAHYAA1ybRL+omwinOYN452O7qppmbUHPw+Rkkxd1ZDEJ+yZUmStpUBIWdsR5KAbko1fBg0GJtDl5vecX/d6efzmnyvrHaV1PvyZpwNGVFqm0vlDIJsLxqlPUuk6oAdNjCHfVi07JqstqTGNRJXb1yd+XGjnKHBhQyTLNQU4J17UiCJAd11bLHRpnhRAUUODDLdt2YGiD7H4izG8UyOPKuO6qNJnJG5g2VRfsoAsK2V46VkhldT+c863t2huTZGpe7BdFHV2IJ65/m+D5DGPDOxAFBIE5Tvfsw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddfd6e6-aaf3-4757-ebd6-08debd4d82b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:53.5840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTHC8A7tfFIEAZPxnSCLuFsiAuQ9LGwpgrV9KFtvkBOQiVFviKOmDPE01srCHN2mLpxdkq2XX7k70AdBshBNWlzoFLC5fFOnlsXWDLMOVxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
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

Introduce I2C controller support for the AST1040 SoC model.=0A=
=0A=
The I2C model type is selected from the SoC type name, allowing the AST1040=
=0A=
SoC to use the corresponding aspeed.i2c-ast1040 model.=0A=
=0A=
The I2C controller is mapped at 0x74C0F000 and uses IRQs=0A=
64 - 77, with one IRQ assigned per I2C bus.=0A=
=0A=
The controller DRAM link is connected to SRAM1 (HyperRAM)=0A=
for DMA support.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 24 ++++++++++++++++++++++++=0A=
 1 file changed, 24 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 77211ce1f3..a4fe0658d5 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -94,7 +94,14 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(obj);=0A=
     AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+    char typename[64];=0A=
+    char socname[8];=0A=
     int i;=0A=
+=0A=
+    if (sscanf(object_get_typename(obj), "%7s", socname) !=3D 1) {=0A=
+        g_assert_not_reached();=0A=
+    }=0A=
+=0A=
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);=0A=
 =0A=
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
@@ -117,6 +124,8 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],=0A=
                                 "aspeed.sgpio-ast2700");=0A=
     }=0A=
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);=0A=
+    object_initialize_child(obj, "i2c", &s->i2c, typename);=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -233,6 +242,21 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + =
i));=0A=
     }=0A=
 =0A=
+    /* I2C */=0A=
+    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram[1]),=
=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,=0A=
+                    sc->memmap[ASPEED_DEV_I2C]);=0A=
+    for (i =3D 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {=0A=
+        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&a->armv7m),=0A=
+                                        sc->irqmap[ASPEED_DEV_I2C] + i);=
=0A=
+        /* The AST1040 I2C controller has one IRQ per bus. */=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

