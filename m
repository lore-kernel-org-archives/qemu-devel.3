Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DFECC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF67-0005D6-9t; Thu, 15 Oct 2026 02:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5B-0004do-Rn; Thu, 15 Oct 2026 02:36:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF4y-0006Y0-05; Thu, 15 Oct 2026 02:36:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfXJJxTY6eWG6TxI+NFeCftq48dClSB9E5OEUC72MFX2zS/AZEydiPQT9VYVMUTk5+6p2SLrhjXjSIUu6DpoyuRWfq5Mtm7ZMfpFlgNhWu1KNmXirGIM0naqm4GNg5sxpIL/qSwJmS1gkmgTyZ/zca4u9HMNAs4Ht4im39MtDBt2sSzLMnljxuwYMjAk5lnLwvXQpxbAZBZ2VAiIRFIZdkf6F7EoCLVRijavu5C9od6pu/7nPUM0bZUTj8kPaAiDdHJSaYYYFspRFIbmgPct7hmo5l6yZ4RZ00CMmlzBZKZvfNQK6RLZkMKUpfdNyrN+Uj52rLIXQPlW71KzTOIDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XNFZvezOayPn920RwVkTOE2DocIErkkXV6J0qnZrKQ=;
 b=aIw1p7Hp0EsmAivm1yjAZ/5D6QGV2EWhFWcgVDmyI5J3dsWfykxl+escrX8XYFEhDJuxOV5g4Ev1msviaRAJfFk2Yxqh7czZn/i6e7fPX65/nFvdsRoK4VqXYwNuvM+wzzoVEEhYutsEes14hYqJ9/Fn+X4oMjLHEuhs2Br4XKOlR9VnDkNcm7lzrAaEU2cUxCGtPX5ji2N8oMDobmetX9CeLV126DLo6w8lgLpjifJHwFEUvwlejBe+sriIFWuYhjQS8IR0AqN/s2mdV38I8F7GPrlKZTddtAuYoS/8q7xMZ+ytmpuw/JxDtHqc+VDqaQWHgvbsPRIkJvAN8f9veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XNFZvezOayPn920RwVkTOE2DocIErkkXV6J0qnZrKQ=;
 b=YYJc1HbL0ne7X6KYzc4z+TtrJ+LdI5mXu2MMcrEKryIMmVQvyPsa8nl/TXkEUXpolfUqd1iqkZtFh6GCJia7J5KWmiR4GDx0Rj8HgfGiSbjErC7jhhk6y5GuFXjDRYaeSXa5vrxcxj95QaoIrBe3jmuN1Etb70HIjlBOH9yc+Dwdhy9Bq13aOa2HU3xvDcWc1GVMiJj0tyX+DpBMUYJ51+3AnwaFIwBpClWi7pxFmQcim7MHBLnvP5anNpNWlqJjZ/QVwN/Etb9DPHCawtZVswmFTrjM0Wnv+uIcAOJ1sIRDtsdZDYdt6P6Wis/nlOg6cBiCvUGLLktAEwpFC5pOMA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7219.apcprd06.prod.outlook.com (2603:1096:4:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/9] hw/arm/aspeed_ast1040: Add common realize function for
 AST1040/AST1080 SoCs
Thread-Topic: [PATCH v1 2/9] hw/arm/aspeed_ast1040: Add common realize
 function for AST1040/AST1080 SoCs
Thread-Index: AQHdXG+CKKSanebg/k23hzkf1xBKBQ==
Date: Thu, 15 Oct 2026 06:36:28 +0000
Message-ID: <20261015063625.186708-3-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7219:EE_
x-ms-office365-filtering-correlation-id: 6b3e5e89-3a49-4f93-f6ec-08df2a86a542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|921020|56012099006|261009223027099003|261009221227099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info: kyR8pJr2J8z32EhgtwEfkMwJRY+zc8ko0XVHiLf1kToazkb1cKdAVVbVBfnNhOlC/VCjJYK1cRuHtgXjDxzQPGv2GWOvpzq40TVLE39Ft07Blvunk8P8DCpRs5CViHsn/3imt67bf3jYskn7EaKIZMDTkyHNS+HCykUUMm/yiJ8q/RuSKIAktQ4cwcWrC3vJzYBpui+9iYwFdrtDLHpSFdauTqv8h6GOWt06oboTDR0cKpmjVH4QJ9PviTJlxd+f4/tIwsebdQ/Y9JzWADe5k5BULqi8oWu0d45KXLxCO1IEp0lxshJo0PklabdI+Q1tYEBeMkWMELKTiDWRfIIeJDgJK+oXLaUISA+uId2YjEu3poJ3Ts7dliJ1WHWzAYq5jlKayL/xqOaCvLCs5775H/nEkZuztrHEVK0QIoDnqFgduxtO1CeLbxb7GzgeysIpE3q7VB3eUj3Wk+ihw2fjHPCoT2I68mc21GlL0ozObO8Bm62Kl7rtMjFVOo6DVZtFbWh4GG53k6KU0bLyE+tq68jco6Y0GMeMPFqXHLlflpn8sMgK3wF6dlk6Lw17psx0x9T280ECIYAfqNQ8Xzgg4esalWRUYUEfXLV6IZhgU5SiFKRjdE6uh4hf8o8ZLiDN1pkGewWQg3L9+/pSYgrx9vR+Qk+OzO/e1an1lvQAlenm0LQyRKbO8fVspJhpioM2qbuJiqwYnKkOpSrVpRQ5TQBpMSc+qMyrUTRoXU/Buf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(921020)(56012099006)(261009223027099003)(261009221227099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dAZRgq2cJ+cFhJO1LY8/P9FXH1Uima/+gjtZ4lv1mvKM8E+sD7Lw8dAzif?=
 =?iso-8859-1?Q?knkijSkEbwKPMlP0Vx5zbP421/t0slsCWVZESKc/LuwNzzuXGlafl3NECm?=
 =?iso-8859-1?Q?wHtsvgsDIzPy2z/j2LLoMgEw3KKvL6Rd4BLKVeBLXELNt4p4mp8Smr2FfN?=
 =?iso-8859-1?Q?se8eyfd9YwiO7vjUVeNvMyK8cBwpcFdyELoI3O/86gGRwS3JOs5Pfg4t6g?=
 =?iso-8859-1?Q?WFK1CecqpspQkSGGdzo4Ecguxf8j3oDp9eTaGHegfR+66RJh+Fjfs7l3+2?=
 =?iso-8859-1?Q?9pYRCR1U1WYe2dXJOqsXfvQwWN6pJogouORLKK+IapKuSpV2PgHydLZPN1?=
 =?iso-8859-1?Q?OT2p/7FY/Z7SwWv/HX/gd0l//RyGVW0REi/zitofGwvDzpggQkLQfKHdDg?=
 =?iso-8859-1?Q?z1TPn1/SpQzQ4PkKUMF18nm4sl79zOY3wTanuveJ2d/zz8tlnrqcR6LZo8?=
 =?iso-8859-1?Q?GG7LSwATPkaxn/2lCjrl9ke3aXQVQ8mpZ+UM6OthibVNRfWvXFQmlan+5B?=
 =?iso-8859-1?Q?MGRdt/21NM+DCFAlH/Ijh0J4pYVOa0a8WQVbwdEOHLqMxlF/z3z09B85iz?=
 =?iso-8859-1?Q?4DFCMhUqgj9eUEjLgMBXHw08fKGlb6tL910TqrLswNpb3ympIKSk1rkgrM?=
 =?iso-8859-1?Q?eC4l/L/gZg3bpfImNq2kxRRRE267sqinCwACGo4MIlK65FHiBIr9CHVsna?=
 =?iso-8859-1?Q?I0uth3ArRul4U27zOYo0whdpd5lu7naj2xdZHERgtA670FBy+qb4YnFzNM?=
 =?iso-8859-1?Q?4dgpACy5nNj9qsVH5KnjsR0Pwo+yq8EWhFsPpdo/dKgv0B1vR/VkhjC2Ki?=
 =?iso-8859-1?Q?q/6DI/SKnGEevU5fuNTWRE39eCfeMYBJA9tzX+SgprRUKwfOBbQen6C1sL?=
 =?iso-8859-1?Q?cd98z+PUhmkVeQ6MTkewzeqm+6hwbqnVuIONB5CevW985X8YLgKVgQCqBM?=
 =?iso-8859-1?Q?y3dEkAevg7LOY40PNTSGQZc0WxP+LKfpGKqWSNMW5pF+kjat2/wcwQZD5i?=
 =?iso-8859-1?Q?zZPCz+yyw5iJ2gwsgquebMboa1tkPufvJjDfESF7GpL4VpxjQuolv3UjV6?=
 =?iso-8859-1?Q?1qCs7H3rY6I/Cp7TYjme9mM64tVv2KDZEOkyPYoRf2jXKYmCLbY4BMzIbq?=
 =?iso-8859-1?Q?irvaJfj02GJJ88iXI6vw0xQ3w8areq6596g676ugnzgfLXIdcaKVbZMqEu?=
 =?iso-8859-1?Q?ifEWfg8KoAGRstWSBKr2/M6Elp04Rw9E4xtLElWqJvJIbxNuV8/FlRMPDL?=
 =?iso-8859-1?Q?0uei92MkaF/3PjXW1XDAcEpEn4QkV2Irjsgy8Syt4kYH/Hhg721fXUClAB?=
 =?iso-8859-1?Q?KPuSle3V/wUeeR28Ry5ZccNA2GY8WUv3pTMgV1oxBAO9EzHPoTXFR9skoc?=
 =?iso-8859-1?Q?PcbrWbCFKsHNL/F/Tcif4yflM944gtcn2u+dqFYg6+lIZeISp+x3dIES+Y?=
 =?iso-8859-1?Q?1rfTwhL9w5NrSZaSRv4K+1r1v6GQR1LSSEoRgwXPqjTjW7qzddgHJ8dZLg?=
 =?iso-8859-1?Q?YCiH1uB6+gZKuokJflPGU54RNBEPM0gFfY60ZzMYwqyK2DuSJSvG5HJcAw?=
 =?iso-8859-1?Q?L5YfD/T48VkuHeoHPcfa6gJOFlV0aNTQE48fGkU+q5dQYTIBvAVKJUcoDb?=
 =?iso-8859-1?Q?4411jXcbDVFwwlyNSI793OAa+EFlGKOyctFndBi76OdFEaRLtcij4c/xEy?=
 =?iso-8859-1?Q?HSmvo1D+wEZDuVOa152i42zKYCQX42lGcUyY9hJs4etfA/XQjLF6gEvvgB?=
 =?iso-8859-1?Q?ezZT4c5fDenVPvD64vhTo27t5kcAG/sVZuKoBsc3fh5vGpq+COdOZ7EWCx?=
 =?iso-8859-1?Q?s78Fq1K2qg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k2dX8yyfAV3cPLU0SDFOum3a3iP05Sqic2wlBjNi9RQ7i0ILkTsh0+c2vwjmQCmW/VGp5WVY8azOg80wY9jQgEVVJ0P8ECUOm0gu/0SrgAbw7DDu5wOOZK+Ed9LCHRiaide+gad7MpL2FaIz2ZZ2eLECi421uJfv5DGBXubt+WLLK/lXO+sisl6nCuaa8w9TIyTSJUo6MUS1anl5++pJ3fe4dCLpttieXK1v/ZjrdPUegKw4LELNjXRjpf1GWUmR7QPYkQhRs2wR4dCvhBk/qzlQ8I36P0aMtnJ2nHzbJT9RbsKpM2tGnYYxyNlwboFvtQKhz2n1w+8uMEyK0e4Ytw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3e5e89-3a49-4f93-f6ec-08df2a86a542
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:28.5838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdQgHq8Lpv5Y0p6ysIbQBdfuo5RkZNBOUWKsSxTHMWWQU0NiJqRE60JzjU1QAPRiS4M5zATr8JsT2dhwS1yoCmLdChdZKcRTwq8cEPcmf0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7219
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
The AST1030 and AST1060 SoCs share common realization through=0A=
aspeed_soc_ast10x0_realize(). Similarly, introduce=0A=
aspeed_soc_ast10x0_g2_realize() to provide common realization for the=0A=
AST1040 and AST1080 SoCs.=0A=
=0A=
Move the shared AST1040 realization into the new common function so that=0A=
it can be reused when adding AST1080 support. The PECI and eSPI=0A=
controllers are only available on the AST1040, so their realization is=0A=
kept in aspeed_soc_ast1040_realize().=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 62 ++++++++++++++++++++++++-----------------=0A=
 1 file changed, 37 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 5d2713e8bb..28abbe7010 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -162,10 +162,9 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
 }=0A=
 =0A=
-static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
+static bool aspeed_soc_ast10x0_g2_realize(Aspeed10x0SoCState *a, Error **e=
rrp)=0A=
 {=0A=
-    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
-    AspeedSoCState *s =3D ASPEED_SOC(dev_soc);=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(a);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     g_autofree char *hyperram_name =3D NULL;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
@@ -176,10 +175,10 @@ static void aspeed_soc_ast1040_realize(DeviceState *d=
ev_soc, Error **errp)=0A=
 =0A=
     if (!clock_has_source(s->sysclk)) {=0A=
         error_setg(errp, "sysclk clock must be wired up by the board code"=
);=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
 =0A=
-    /* AST1040 CPU Core */=0A=
+    /* AST10x0 G2 CPU Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
     qdev_prop_set_string(armv7m, "cpu-type",=0A=
@@ -196,7 +195,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
                            sc->sram_size[0], &err);=0A=
     if (err) {=0A=
         error_propagate(errp, err);=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],=
=0A=
                                 &s->sram[0]);=0A=
@@ -208,14 +207,14 @@ static void aspeed_soc_ast1040_realize(DeviceState *d=
ev_soc, Error **errp)=0A=
                            sc->sram_size[1], &err);=0A=
     if (err) {=0A=
         error_propagate(errp, err);=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
                                 &s->sram[1]);=0A=
 =0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
                     sc->memmap[ASPEED_DEV_SCU]);=0A=
@@ -224,7 +223,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
     for (i =3D 0, uart =3D sc->uarts_base; i < sc->uarts_num; i++, uart++)=
 {=0A=
         if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],=0A=
                                      sc->memmap[uart], errp)) {=0A=
-            return;=0A=
+            return false;=0A=
         }=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,=0A=
                            aspeed_soc_ast1040_get_irq(s, uart));=0A=
@@ -232,25 +231,16 @@ static void aspeed_soc_ast1040_realize(DeviceState *d=
ev_soc, Error **errp)=0A=
 =0A=
     /* ADC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,=0A=
                     sc->memmap[ASPEED_DEV_ADC]);=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
 =0A=
-    /* PECI */=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {=0A=
-        return;=0A=
-    }=0A=
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,=0A=
-                    sc->memmap[ASPEED_DEV_PECI]);=0A=
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
-                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
-=0A=
     /* GPIO */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                     sc->memmap[ASPEED_DEV_GPIO]);=0A=
@@ -260,7 +250,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
     /* SGPIO */=0A=
     for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {=0A=
-            return;=0A=
+            return false;=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_SGPIOM0 + i]);=0A=
@@ -272,7 +262,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram[1]),=
=0A=
                              &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,=0A=
                     sc->memmap[ASPEED_DEV_I2C]);=0A=
@@ -291,7 +281,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
         object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
                                  &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
-            return;=0A=
+            return false;=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
     }=0A=
@@ -300,7 +290,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram[1]),=
=0A=
             &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {=0A=
-        return;=0A=
+        return false;=0A=
     }=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,=0A=
                     sc->memmap[ASPEED_DEV_FMC]);=0A=
@@ -314,7 +304,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
         object_property_set_link(OBJECT(&s->spi[i]), "dram",=0A=
                                  OBJECT(&s->sram[1]), &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {=0A=
-            return;=0A=
+            return false;=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_SPI0 + i]);=0A=
@@ -328,6 +318,28 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     create_unimplemented_devices(OBJECT(s), s->memory,=0A=
                                  aspeed_soc_ast10x0_g2_unimp_devs);=0A=
     create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(a);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+=0A=
+    if (!aspeed_soc_ast10x0_g2_realize(a, errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* PECI */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                    sc->memmap[ASPEED_DEV_PECI]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *=
data)=0A=
-- =0A=
2.53.0=0A=

