Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96749CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjcr-0001ja-EQ; Mon, 19 Oct 2026 05:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcL-00014j-Kn; Mon, 19 Oct 2026 05:25:23 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcK-0002q3-6o; Mon, 19 Oct 2026 05:25:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3tYq9zj69SzZ8HevvyQm3re0HkcLiVb0hSK96/q50wJZSSggm0J5IZrV3Tode6xfxvv/ZWne/4Gn0FSPkOjYn2YRR1GvpcBAbdGiDF2o9E9H1d7vY5tfM9A5EiGpH1kiw5CDWFL6uSqo0mnsnUqmdQieSGrRzM/Q8HVhv1cBS+GYFeKM5D2NeKPArGFOHxobq5YIXxaExeGUateed3JFRocjRm29gU4T1hl8fmjD66BVNTKk1Ce6hF9zkOgXrTxWyk465i7kb3QgSyQ+q2wFE4h3zaryXBKUEiZiWcEwJ0ORyRluV2hpPl3qXCSbjjqf53cvyCmGPC/bY3+fY6MeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=pCN2gLUHBDomJPEQpKe90JC4T4dV2gPZKaqZtUVWjRUy7EUMcveYozkEj6tUaqKGdFfFcClzqtDw+xFQOuJ1Ccbtcxl4LO+jqprYU5S+mmPe7jmXa+wSmPRGB3n9IDKMi8g1XAHlPORXEU0SnRAPROj409J+BWDVE8/wXv3fd9Jt4F0gYeg/zGB5wOyFpsVSrPyt+aqLu86W+tQw/xaUqK0AQAclQ+teJ07rwIdzhJXXBlPYdsdkW8RkKfdTbcht5A/PYBHPseqVnWnJW7oMquFg+yuZ3s0tuh4Ydft5E9JUXZfFaV/v+NhHIqeGoYm/YnIOoiVyWtzKXLJXWWEIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=gF4Z8oVL3sSIfrvqz4OV0G0SQfmUG7hNa+3gWeRv75DylQZ1JBNaOhlGxwrx77vlwefK6a0/qkcvYrVr30Wa5BrLdmvu1LIaOHr21fiSP2MoaOILI/gjvTNn4r+NWu7o+nw3QNLq6KNA0SeLbjOIKP4TTMK3pKwE3PDqESf86xcPAcoWvZayytUN1R/pVqhVEWmNTf2nA2wghuCT0Tmtqg9LCF+judRUsbrWbWSAvXpFZ97nCl9Fi26rLSrI7WsYUi4u/gOyzfZKjCypxGSEcA0euAKXdS+Cs55+svg9kJfw/T6wtwqyrCDwRfYrlKs57eGNr5m+3JKvXOhmVt9ZtA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 8/8] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v6 8/8] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdX6u1fGooNpPe7kKxgBE3zKEL4w==
Date: Mon, 19 Oct 2026 09:24:58 +0000
Message-ID: <20261019092448.278079-9-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8674:EE_
x-ms-office365-filtering-correlation-id: b73fc95f-f7ec-4ea0-3775-08df2dc2d859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: dVFVV7qfIbfAZbEGD/1WK7ZpUBmc1ngSw9bfjjXxch/dWZRcMl62TQhsovnW9uqIUY/NaesUe1XI2A9Up3t6YfVduvvmuKf6YU7U1YJ8A5NgW/WzIrhTjl6OJ+n2DnP6uJt2SPVXnufD40Kln8VQRf9nj+BuXCjVZ7Wiu04+K6cT6RhaGVECcG872Sg9MuPOqdHVcO/52/y0XpRIfKz7+TiUYhBhOLj7aSor6CMbogcfNEo1K+4hAFXckoTkpY2OX9dmKjAiNQ8ieADPINIE3PA25sn2apfGWAjewRHwRW6D8JCysrASnB3CPrJnArwh4xdsydUBxnZsuiduY68ZhXPAGVYDRZASWv99KPNyhH8bJszMC5qAjYbnZ3QjBrjK/RwEXnaupHAjFHeLyEzZDy0oM+WvNTgUmUKnBKRqv6CF3WSJuSsqC2rFEke2Zq1sJlB48gNYan3JMVLCKwkC5xVlu1wHcsJLmh4GDbIB6G3fDcygBkj0eQlFDISQGCk2tksQxp6NnrNt/bXysfqgsUFF37q80SmWueUdEd8sCBLaVsQhID3+aooDDdIjfQ0e0s1dbLd2iwnqAWrrcH7jMB5hyzHqWjEwWs11iS4jMF2VGqM7Ja6ON4hULACk/g4GzQdd73ZTA2GriHCVDLIJqtUXVhP/htIZjG3q5dJJUHbHtYm2JHeLNv/fjes6zAM2/vOHBh8aXQYjf3xlFfINM+00Au4sHaJ9WM5G0YVeVVA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UreRzWgvonUxno1Cyubs+c2f5nlwDLtkxWnyTN9BdViTDUdvu6XPDq5jhD?=
 =?iso-8859-1?Q?T3G0bWvz1c4qBr8ys0aWu7wWtvtiN3WmLITutOPFAxEgtlPMOc4BFWbfIL?=
 =?iso-8859-1?Q?W0XffH7OZMhLstcTRFj0fuwRi//cxbgfZ0hxx0jMZaDwCgQnb6x7n1IUmT?=
 =?iso-8859-1?Q?ojl3dmFRz5WhrIeuL6R2f6PSB2pEbei5yvNLujzgaxYRM0p5iuBnjYt4Fb?=
 =?iso-8859-1?Q?6vW1Uo1J60TyiKapKsEGMRuAFA2aVtrXLcPq7Wn/3UKuJZc4NoHGnrhZAA?=
 =?iso-8859-1?Q?BcUzD5LvAVn9JAMxYyU2Fouvu1TAWBjXw4EB+H7zW7YZPcxMI3FbPvsQtt?=
 =?iso-8859-1?Q?AgXvZJqxQDErH6/Wy/DPKerWtyTqofxw8+O22l9fxb3jgeeFbusyq0Rvur?=
 =?iso-8859-1?Q?c5XC4EDAwF0ad5J8KSGUEFy2FziQSm4YgoTs/lv8gJgL7bqXew287d0IK3?=
 =?iso-8859-1?Q?gUrzHWiOVRHzQj9zl+CG+MbkBD7j6C0xqePgN7W69qENlUvO8/2WCe/Xy5?=
 =?iso-8859-1?Q?z0WUIeicJwzccCAmdyrsIsYqUx5wnqxC4lbc+l5GSClZLlXzQ9RLpCqCmg?=
 =?iso-8859-1?Q?OUuqAzcDWiiw4AuWmeKrHEZ51hhcXsjS1js/1UHkI3W/oRK2dpjxGmY/B0?=
 =?iso-8859-1?Q?NasYD2EeN9c6/haaxdyXikzOD0UPMskcczcNnDsIyaNlwKSFDaiT1Wo7AC?=
 =?iso-8859-1?Q?udg2fRTvLe1QYVcPwNCel7S48sNf+WYB+3AZ2iM/PO66ik/S9MFW5Q5JfR?=
 =?iso-8859-1?Q?dzyXxN+VCCi2aFDgyjz1U/B7D1og+S07Lfw+WE83yEYZqLbYViFHadB+Of?=
 =?iso-8859-1?Q?4cPodjrKF0edxqTTWWOc+iz0PbV3oiK5rcq+8WsoX7EJNsIddZvMzjwLw7?=
 =?iso-8859-1?Q?o1OElr1nO52c4ZpZD6e7zvGVEpUPoOTKk89kUqUlxkj6PhyhDdyzw0If+k?=
 =?iso-8859-1?Q?JF2AFPzDuLyNugPBJtg+uEcjxLtKxLim+3n5u0IY2YZedTpZ+0oUlpEnWf?=
 =?iso-8859-1?Q?GAMZhrP/jsPAMDDociJs9jGPvX/v6CwBdy4cimqPZPKF29ScmmfqamI6FC?=
 =?iso-8859-1?Q?bvIJm1TrFX3bDE55AUZE2mdnpDJf5uylOi26QZf0BtZ6C8soLyX30pwgde?=
 =?iso-8859-1?Q?/+LtKnzoMSJ2R2T3mnL4Fj5cSiSUWi+GqEM+S491S/kZxoNpyJn4l3o+8y?=
 =?iso-8859-1?Q?vtRYDDWz2SfaetKx3JsKk4vVsRcPFky+IPwlAgAXn5fwV2pXP61vQlALyj?=
 =?iso-8859-1?Q?JPDf9GgfsX1bpgdD74tRAUqNefc49mHsZP5Hdap4XU/Wqg0XUD/NJXjoea?=
 =?iso-8859-1?Q?1XauQXKSD+bqcwMUatm7m9t7N/A0xEEQaNUWq3mKkbblaQl7muZuaGMTEa?=
 =?iso-8859-1?Q?un3tgpUDXOxI660M5r6vAbyScyTV0v4noqTF/E/th6iM23kcTRQCEcstse?=
 =?iso-8859-1?Q?4XtuHmfi9xTHtCVjM7g8Xm6MnSYh5drUOoIVLo5qLwZv5KYFSG/qyg+rx0?=
 =?iso-8859-1?Q?6LKeeGLDiXK3ZdVexreGtbLy8zvevsoTdzAb4KphQmkUNBKG6nZ5XHA8H/?=
 =?iso-8859-1?Q?/jZkmluptrSPX9LlZrHWC+xpEroOnzmuWB+MtqeALbEN+rFOotLyYE2Z9B?=
 =?iso-8859-1?Q?D4MR5qkkCOhq7/su+b5PNc6NTgZzNyqmP8j+v+4lZFBI/9kVr5kkeCQ5ru?=
 =?iso-8859-1?Q?YPzk8NIcGLPbpKlQEVRGvgisxpkFbTt6T3odXiNtTaYHb7cDxgG2TKUynJ?=
 =?iso-8859-1?Q?KUh/026U8P+dOc6pLbsM/e6X6v5Fyyzum0NX91zlKyy8GrGv0ObpyUJCpu?=
 =?iso-8859-1?Q?9FZB9D9Agw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73fc95f-f7ec-4ea0-3775-08df2dc2d859
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:58.6453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96P7Q9g2WhNyj+nqNVOlQgq3iopdV9n1O42o1BuLe8cl9pMPlzbr8DS0I+Tfan306KZ/hsFLsDUZ71qE1BqzRBIaMRWDRPXDAozo/6GfJOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8674
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Let the ASPEED machines accept "x-usb-redir-server" with -device, so a=0A=
UDC gadget can be exported to a USB host running in another QEMU:=0A=
=0A=
  -device x-usb-redir-server,id=3Dredirsrv,chardev=3D<chr>=0A=
  -device aspeed.udc-gadget,bus=3Dredirsrv.0,udc=3D/machine/soc/udc=0A=
=0A=
x-usb-redir-server sits on the main system bus so that the USB bus it=0A=
provides can be found by "bus=3D<id>.0". That makes it a sysbus device, and=
=0A=
a sysbus device can only be created with -device if the machine lists it.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/arm/aspeed.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c=0A=
index a7cfbd6c5e..fc27ac1788 100644=0A=
--- a/hw/arm/aspeed.c=0A=
+++ b/hw/arm/aspeed.c=0A=
@@ -409,6 +409,13 @@ static void aspeed_machine_class_init(ObjectClass *oc,=
 const void *data)=0A=
     mc->no_cdrom =3D 1;=0A=
     mc->no_parallel =3D 1;=0A=
     mc->default_ram_id =3D "ram";=0A=
+    /*=0A=
+     * Lets a UDC gadget be exported to another QEMU instance over usbredi=
r.=0A=
+     * The type name is spelled out rather than used through its macro so=
=0A=
+     * that this still builds when the usbredir library is absent.=0A=
+     */=0A=
+    machine_class_allow_dynamic_sysbus_dev(mc,=0A=
+                                           "x-usb-redir-server");=0A=
     amc->macs_mask =3D ASPEED_MAC0_ON;=0A=
     amc->uart_default =3D ASPEED_DEV_UART5;=0A=
 =0A=
-- =0A=
2.43.0=0A=

