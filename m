Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA017CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsje-0003H3-QV; Sun, 31 May 2026 22:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsja-0003Dy-K7; Sun, 31 May 2026 22:50:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjY-0002Y8-Rv; Sun, 31 May 2026 22:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vehDyCfLYkz0qrAMS7O78GEuRZHYQwgV9KlT5hQ7tJzwJILBSlkgHbUq44yJaSbJJmqokT3AJ4Dni2MDAuLga3iwM6prs2502/a9nwq7FvzmbPdjoSiJabTCaq3Q3F4pzSezJQBnXA7o89L3agf3cqm264ZCAgcX7tHkiXKqXXsQAgwO/UsU2+VvU3EPl4NOjmwpLfh3rznb8C2TIlACHjNpx4vW2Q8N4NVMs+zKFJOG2llBR4F/wYH7fmcpuapdxBHIR7e7Y8e0HI/BF4HIfbeYTw8ulJFMpVmqtwDumNbSDplOXlb752Qwr/k62G3aMmwkgwt4J1CF5HoqDpRn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgqgMTEFSNJe4FZPOPLIihdFIqOOVCIGU6DEj0JnHjU=;
 b=Rh510AGBRDQXTgizdaqQyptZkluoALA+tGjBWvRfcSWVXu0lFW2hsdScz9a/xABCWRgg1tvyTSl4Z7iDKJPtZzGlXUFgYrbolIVSsjFdGBGouBoDUzPW+exI/2CJ4OGnxUAtdYTtPjA3tAXqL46w+r8jjIPhtHWS9WhRYEk1YusWVjbzAjqF4mjiold449d+LbrrhWQvuzf31JiseEbivwUgLtgiAlu8LNb2lxKar3N1cbV3+lwcujfabjAjp48SM/1RHqVBKdPN1ooXw6YvzWmd/jMrC1HpkvG5IRsOmTLxR667qE1+HrZWMKd/+QhLKhd3uJ6SCJLhsUFCSJFlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgqgMTEFSNJe4FZPOPLIihdFIqOOVCIGU6DEj0JnHjU=;
 b=GaY54s4h/mBDzPR6LTsFvq2ZTUp5GBiQvIDTcno4+gtUNk9tL31vkV/s3UjR9iBZaUYmh396epUZp05IAcXRLxN8/ZVB88IFZnd+WJg889W6T88euavolZ54GHrAT7HtCHuBxTfrIBmdoMwQCkgaYrQsQFQOAGmXvDCAW+f66svR3ikxn+5DrtVL4Xl5RXoz9zaLaMhF88BoTGjM9L+N32v/S1zDj499Twe9UOWKx5npsqJOBRFHj57Vurx4KxEiL7Oksnai2iFFV0Tspf8nVAOvGnVm6P1ScGs3Dp7orxracKY07ZOy12kekmzLCrAhOeZ4nQ66gMbMJ21S0tcR7A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 12/24] hw/gpio/aspeed_gpio: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 12/24] hw/gpio/aspeed_gpio: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFhZfZiu4BZ30i6z64DiE/nag==
Date: Mon, 1 Jun 2026 02:50:19 +0000
Message-ID: <20260601024959.2347639-13-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: ddf52236-ce14-4bb6-84af-08debf88846a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: 1FlsZD4K/uzdYFBCTjx/MZJMhoeJqAeeYOUzk6EgP7Powueblb03BriK8mvt6vDFKUDyS4KpmUlpvtaSl99U7bmsRPWnMWwOB/f0qiKBhc0K2c2kbTIscNI9ltTUARcVGjejX05x/QDuB8LUgjKHzOQZt3uaMmkpxnseb6aRVSHsKwYkVRsnVGPzxep0Qr8m7MgqV39HFzHo4qnRLFZEhjKaaIvrLWkkNOX14xEr93zWi9+OCSjRTZS/jFsZrdS/Q5BJCFuXHogdhxUOCg8YrFc/tDxHwbo1M7Ym8ebXToGxnOFM/2NjYLaIzL6eVVibnPfbkNOXS13Wti+RwJmm0XwRIBtyX+pR0TmRwGkIJNvGGGQEPcSiosXZVE6hq3OeDyED/Ey0djJ5pMsYjurS2pSLz9duIGuCpenmiQStrZBlkt4672dXfdf02BF1X259RusgsvWrk/INniSQ2l75MiE8aPwSeXyGTBA/KCFTu+foZtsxQ1kiEPYJDq3xJMkk3OAUMwzzg21CFTcqLSjl1Hl2lLfRqhrs9yAMCHwwHYT0CDSRpzhQOW9JWSIHoviuXoEH7Jshr9/Iqxot0tY2g3LDkfhuYrCNyADL5b8s+HyRwBh2Kpd9nv+8ywEoMfFYgW2CecHJ5Q9tw8rCEaCAP7hbn5Z+YqlOduCyLOJ0xpVaEzXXF6x3qgJpkKEkbr0VwLr2x+6RCftxkV9AAGovjWgi76UBJucnuJMHs4+E/Nw0Nh7qjw5dIZyJlxCqHk+ZEveJbVtzJdT/VKHCVBaJjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tN9IiICvx4BcThRv3ui1TwzmCgEsIS48DjnCvKOho7m23LOt3GDWWC68v6?=
 =?iso-8859-1?Q?xSIZCWFCR1ER6QoHpy4bEjM/l4LxbkuYCEmtwExO5uZwuYDclWtK5319rm?=
 =?iso-8859-1?Q?1vOKgrYu5qujt2ASouVmEhKl3nqhmbisx99bz1atNNkMwsAWSb47ku77/g?=
 =?iso-8859-1?Q?l4+YT5KuIsGSomvymGWrkF/6P5At3IkTp8vo/64uHveb2MdxaMzuydV3g+?=
 =?iso-8859-1?Q?WzaJB0OSDvhWmjiMrSpQAtkVJjChu1JiROJlwwrTJw+xCrCpXswy5r3lPm?=
 =?iso-8859-1?Q?qPRBn1N4tqQJci38XLb/NIYwbuEqueQrvp2pW/31zyjZmnhA3Hvbsxvp7b?=
 =?iso-8859-1?Q?nMZU2ZOOk4t2WmtQJQWg2Iy4MTY2mGx3cJJuc4JW0lUmNpF/PylG+fkrtA?=
 =?iso-8859-1?Q?k9zTkRU8P2NcBC7KH8HgrMP5mWpKxLaRwIlyBPKEssFXCyyzPBJwybuGXG?=
 =?iso-8859-1?Q?QxyzWRYCwfDzPe2RjM3o9LPK6BYI0KdAw47mn+XzHw/0KyKXNRCuDwxpsD?=
 =?iso-8859-1?Q?/1/7eqxuGZk3dwHc8sTnQ2F9yGzmYGVNM2JpcM+4SBopmbiRJTDKfRLQxI?=
 =?iso-8859-1?Q?ZAgeYBPiPp7qsrpiHhykH43kAVbpyWM7fFY4cNfYllsF0f2aNLNvFipUis?=
 =?iso-8859-1?Q?wur2ZZ0m27zDz4rTPYHxJ0UvaGMY0fcz6efSU/8l3frrhneFy8k/hrM4GR?=
 =?iso-8859-1?Q?L3XENqEFnd3vnaQ+7BMnLvjYjkrDJ9ceVa2HrEqoFucshOKCADBx92/9ye?=
 =?iso-8859-1?Q?56hueVfQJ+fVtYaCFBJ56dbuV4D9Tx5gLOn/ub9Z/q4xsdUfbHG/wvuVcp?=
 =?iso-8859-1?Q?UOBI9OsGGKZkRrNz0Mi1myQlsaIjC9M5Qyyorkr3puFUV7LVSqm+o+sk4w?=
 =?iso-8859-1?Q?+KEubFqTlvKU/NqhP02x+dCZ2SkF4LKNO3Vunkg4nb8sRHztkX0Mxy6P5E?=
 =?iso-8859-1?Q?aq7tkwElL5R7xQZ3DTc8pe1QE7+MkaiDItcKppoIMqJIPRJN+dCl4w6r1f?=
 =?iso-8859-1?Q?iysprfhQGE2sgWtuWOTk2IHeZMPqZQuSdiXM1D0UeUevJaukMMEhvqnVgu?=
 =?iso-8859-1?Q?kC8WmGD9sNR6pboGkdyC+hS+SBx0vTZF098aQJwC2zrBpCud3BI3aLQxkK?=
 =?iso-8859-1?Q?B+/4AH8FWzXMdCOQIfkGhKF/CJPxQbsnsVINPSFQvn9NMIm1IVT6oJ6Al2?=
 =?iso-8859-1?Q?xFTYgo2p6X9F+CfE5RSeeLsxv2+nM9ApCkqvsZw5fwXGSJBUXm3NQhgfxM?=
 =?iso-8859-1?Q?yX86wyoGcwyayHE9vggOkSGOifK9w3aj5T11CyQSiXM3YGlMMYNd2AIc4E?=
 =?iso-8859-1?Q?rg8SWim3J6mK1S1nBjVv7DRK7MN1o2pBgmXko0rbHscMkN2ZiL729CV6GY?=
 =?iso-8859-1?Q?B7tYCQEtpyQX8sdpC3ExDD3y2PjvRKm11WntR+Z5gZ7JdbaFu/bxbMg0Yp?=
 =?iso-8859-1?Q?T0yxJdLzaTA0O0oqWL0ASTaBtIaXlUQmBcfHx22N+5BgsF1k3spykPUkr5?=
 =?iso-8859-1?Q?F38D8zjBr0Xq5+c3fxJeDGH4yFv6FDEFGpkVXghwtSQehV2cPiejIRnaT7?=
 =?iso-8859-1?Q?OgZ0rtjUhEqkqvK3d+gR+w9isGnvIcyY8DeU6aUSZ8Ot9s9+GjxRCS5e1u?=
 =?iso-8859-1?Q?o7iD2Qt33gXQF1G1essh77S8viUMVfvUZdTVQSYVOJiZTQVidVkpvuWCJS?=
 =?iso-8859-1?Q?Ut2TCs3QpHefizHOu/QAyb35Vd0I7UZ/9M3ITP5E3z1noh5mkg0xJnNgN6?=
 =?iso-8859-1?Q?IoZOOn2TlWp0b0to3CU1IA0OaOgm4xbXraAXs80YIogXWTfqwF8GfWx9DF?=
 =?iso-8859-1?Q?vlLw8jcydQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: emSuMKkMhmeznk6Pk7z2WToZ5Ka9rRq5Ll4XJXYykPmVdBamw6TcxfWVLsv4eOAYm8DyaJFRh9zGHAFR/7OmkCbogtBr/rIyI9LCaIE/ifl57g9Wq13iky+V64Lxl/4Vo5KNTwb8HN6qLzs5qYdlj7FsNQZVQ5ro45i85tKkDnvbpeGel5Q8FZqmG70cp+xiNxJjvc6v53IQkDlekHFo5kPdtpICZzVGMs1Tp5qyp5XOOCXngTEN84HZdDTf4ytcAMwPXNoMgGLZsmd2ohAAycFztlRY60i3gLMm7SJk1DbGL0tDCuYxcAvY8RiTHel6YAPUgkynrG5JVV+sbY9pcw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf52236-ce14-4bb6-84af-08debf88846a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:19.1163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6IZqmOtBltmQ+xPAGRyuO5CnnZ7y7Hckf5Yq4bVEqz8eDXMVpD+BzrNcP4yvxNycH/FpM1KZYtGAPkcL86X7ZwVmnnLqF6dlUqOuj327g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 7 standalone TypeInfo variables (aspeed_gpio_info as abstract=0A=
base, aspeed_2400_gpio_info, aspeed_2500_gpio_info,=0A=
aspeed_2600_1_8v_gpio_info, aspeed_2600_3_3v_gpio_info,=0A=
aspeed_1030_gpio_info, aspeed_2700_gpio_info)=0A=
directly into the 'aspeed_gpio_types[]'=0A=
array, removing the need for separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/gpio/aspeed_gpio.c | 107 ++++++++++++++++++------------------------=0A=
 1 file changed, 46 insertions(+), 61 deletions(-)=0A=
=0A=
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c=0A=
index ef321b7386..1cf6f5df55 100644=0A=
--- a/hw/gpio/aspeed_gpio.c=0A=
+++ b/hw/gpio/aspeed_gpio.c=0A=
@@ -1620,66 +1620,51 @@ static void aspeed_gpio_2700_class_init(ObjectClass=
 *klass, const void *data)=0A=
     agc->reg_ops =3D &aspeed_gpio_2700_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_gpio_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO,=0A=
-    .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size  =3D sizeof(AspeedGPIOState),=0A=
-    .class_size     =3D sizeof(AspeedGPIOClass),=0A=
-    .class_init     =3D aspeed_gpio_class_init,=0A=
-    .abstract       =3D true,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_gpio_ast2400_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO "-ast2400",=0A=
-    .parent         =3D TYPE_ASPEED_GPIO,=0A=
-    .class_init     =3D aspeed_gpio_ast2400_class_init,=0A=
-    .instance_init  =3D aspeed_gpio_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_gpio_ast2500_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO "-ast2500",=0A=
-    .parent         =3D TYPE_ASPEED_GPIO,=0A=
-    .class_init     =3D aspeed_gpio_2500_class_init,=0A=
-    .instance_init  =3D aspeed_gpio_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_gpio_ast2600_3_3v_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO "-ast2600",=0A=
-    .parent         =3D TYPE_ASPEED_GPIO,=0A=
-    .class_init     =3D aspeed_gpio_ast2600_3_3v_class_init,=0A=
-    .instance_init  =3D aspeed_gpio_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_gpio_ast2600_1_8v_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO "-ast2600-1_8v",=0A=
-    .parent         =3D TYPE_ASPEED_GPIO,=0A=
-    .class_init     =3D aspeed_gpio_ast2600_1_8v_class_init,=0A=
-    .instance_init  =3D aspeed_gpio_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_gpio_ast1030_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO "-ast1030",=0A=
-    .parent         =3D TYPE_ASPEED_GPIO,=0A=
-    .class_init     =3D aspeed_gpio_1030_class_init,=0A=
-    .instance_init  =3D aspeed_gpio_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_gpio_ast2700_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_GPIO "-ast2700",=0A=
-    .parent         =3D TYPE_ASPEED_GPIO,=0A=
-    .class_init     =3D aspeed_gpio_2700_class_init,=0A=
-    .instance_init  =3D aspeed_gpio_init,=0A=
+static const TypeInfo aspeed_gpio_types[] =3D {=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO,=0A=
+        .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size  =3D sizeof(AspeedGPIOState),=0A=
+        .class_size     =3D sizeof(AspeedGPIOClass),=0A=
+        .class_init     =3D aspeed_gpio_class_init,=0A=
+        .abstract       =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO "-ast1030",=0A=
+        .parent         =3D TYPE_ASPEED_GPIO,=0A=
+        .class_init     =3D aspeed_gpio_1030_class_init,=0A=
+        .instance_init  =3D aspeed_gpio_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO "-ast2400",=0A=
+        .parent         =3D TYPE_ASPEED_GPIO,=0A=
+        .class_init     =3D aspeed_gpio_ast2400_class_init,=0A=
+        .instance_init  =3D aspeed_gpio_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO "-ast2500",=0A=
+        .parent         =3D TYPE_ASPEED_GPIO,=0A=
+        .class_init     =3D aspeed_gpio_2500_class_init,=0A=
+        .instance_init  =3D aspeed_gpio_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO "-ast2600",=0A=
+        .parent         =3D TYPE_ASPEED_GPIO,=0A=
+        .class_init     =3D aspeed_gpio_ast2600_3_3v_class_init,=0A=
+        .instance_init  =3D aspeed_gpio_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO "-ast2600-1_8v",=0A=
+        .parent         =3D TYPE_ASPEED_GPIO,=0A=
+        .class_init     =3D aspeed_gpio_ast2600_1_8v_class_init,=0A=
+        .instance_init  =3D aspeed_gpio_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_GPIO "-ast2700",=0A=
+        .parent         =3D TYPE_ASPEED_GPIO,=0A=
+        .class_init     =3D aspeed_gpio_2700_class_init,=0A=
+        .instance_init  =3D aspeed_gpio_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_gpio_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_gpio_info);=0A=
-    type_register_static(&aspeed_gpio_ast2400_info);=0A=
-    type_register_static(&aspeed_gpio_ast2500_info);=0A=
-    type_register_static(&aspeed_gpio_ast2600_3_3v_info);=0A=
-    type_register_static(&aspeed_gpio_ast2600_1_8v_info);=0A=
-    type_register_static(&aspeed_gpio_ast1030_info);=0A=
-    type_register_static(&aspeed_gpio_ast2700_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_gpio_register_types);=0A=
+DEFINE_TYPES(aspeed_gpio_types)=0A=
-- =0A=
2.43.0=0A=

