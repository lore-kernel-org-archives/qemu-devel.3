Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E0DCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogw-0001sh-6Z; Wed, 30 Sep 2026 03:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogu-0001s9-R8; Wed, 30 Sep 2026 03:25:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogt-00027I-4H; Wed, 30 Sep 2026 03:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJP5aYd4lc/JJJbX0lnGpMRf56lfQIG2bGP5oWJetV0wZaucRlSmqnYI5WA83cavArjXui5Vu6j5QLYD7gTH0Y8vJ4WqTeqH1SzUNuMsDztNDxgQEVLLU/9rQHMnaV29N/THFmXShktctvJldSJ2twJHWg1TjT7jTEmiQwAoSgRfiW4Q6ljgLTYdmoxnT7TIMxo+Vax2+Xf0Uhvsp7fzzyhy8vQ8HWK/p7rONPJRJJdOtXjrWQDW2ufWPEKmBL8U29vAf+nZ4Sgz7MVc0mdEGGblkhOko3j3LpVlT6qN8CrC9xL2UUb03KDcAByu+qa7FhSt/pyQBAHWaNECUWu5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81Xl9K9ybPyz7LxQRHWhDxo3A389zHPsd7yQiZd27qg=;
 b=N2Cmwst8QCQeJkldTgRM/lp4tAxkrhGXHtaswQET0BB/7VJ+QbmeFs5T5FhS1NxgKky749FoEJB1Y0Ej1nEbJvQcXtoyYctVxHGZIfM4w6gAkljJ8MY1Pd9dE7gZlvEoCYkihq44uzx1E27+Uj8RVfvNIb6SUKqsuQIVpoL472SdIaZKzCtq6cI/0C8wuGjaVb+qIRndvLQkT439zjoSEMianhuhQA8GwgoiXJRc3Ux/64g2SGyKQyue2khBeTB6NgYYyXzitpGcQG+v5UufbBLAHuLBsSOnNRKg6/1b2dPyUQHuSsh/0+wK5H4KsFSVvU1CW5Lr3GLqOnuFvVCNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Xl9K9ybPyz7LxQRHWhDxo3A389zHPsd7yQiZd27qg=;
 b=aJnwFIjr5U/Klohu6SqCWGb0bX8V4iCPGFSi7WUXrCz/X0SHY91/I9LOg1DHVEMiPOftlRL7K21B47XfxeMdkh6WDC3Sjh53s7w2DgeFYU0ooXk0WtawdpA16UXDKMiI3PZWWvoBi7zf1FxefyuER1wGJ08iz52B9UBKl1OOq0VXvPd0D3yJjrEyELbDV6nKjT5e/u/h3kjGQfHaRGPYmVFAzJSAEC8MFav9Jzhtruz7T7GjUB4HukzfOHQ5yjAfc0tqJTHc6THjNMrreK4T98zLsN16ZmdoxzeSR6ra4SPOB9MduzcV4UgHBO6KQJ0rIXrkvJbTltSdVM1Tlwhp8w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6451.apcprd06.prod.outlook.com (2603:1096:990:2d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:06 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/11] hw/arm/aspeed_ast27x0: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 03/11] hw/arm/aspeed_ast27x0: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzQiKWCMbXveUiPIqlj+bRQRg==
Date: Wed, 30 Sep 2026 07:25:05 +0000
Message-ID: <20260930072501.2612119-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 1982e52f-ca0e-43ae-cf50-08df1ec3f357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: pquuf8MbnN3NMFAfMFAN4t/bATU5mP3V6iTeEUcrMT1KpUCTh/8hXheVH83nswqlVZXAwbErS1uv0XIi/rp0HX7FRUS2RI01L5qO47TehdWMRots0qPhzLWT+TQYVvNivbJpAfOx6DZn17WY9MraHApZKbq1JhWgqwGI9qax74idUY7Ct0r181lWnxpFDG1B0RHSj6/RAmRkp9F6gVNjkNOeZccCqgxeNmHnh2YgLpZ4CUpZLOwviYn+iZpItAZCCEQgH80j4DQoAIg7U24xC4Q5JZhCnRlrs0S2ZER1AeEHGNhxb2CzC6YphPR6ZNG+anxK7vh6FmAeo8TXxo6Agv/Xbx2cYFh+LHkr5GEp4ZXgOQk1K0HZ60eVhacNpPlPh+Zu/nJnDXAFb2ooRtc3RfoPqV/Djw9dETvf4xJBANESeqQ+yMu7Xhe6Og/cZtSFdZZW1MdVfNmmbSUJTe8O081ztw82gWSBT2C6D4LwAp5S62ehHfgvzkbVC2EsCfkr7G96A2bD040+yygNBe9gmuI3n4UiWy1xYTffMujdB66pQrci/KEPm0MDJfLwGLRQfW4lN7dSY/c2WLe/pzH6aOCvXZ3cJjjCJYdBaQxRqUpXsYbjT653bRFmLBC5Ck++0PLap0YID4ySrGkoI9auV4tPRtxF5co7jIBlc48hhExTm/9TTRSblrKBKUThh2HjAHmmdH1TcT8kVM0iD3wtOVrysJAjN5Dm5+de+e33gFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YtwoT8Rp9QOkGQAG8QcgiKeCBYgJkeO7pRumxc72xos6yfr9IJ5hLqkFus?=
 =?iso-8859-1?Q?hG2bCGHpPvCJHAcWCFw7WASWxV87ivo7yTFGz1yM9sve8AaDvWjIw1zfix?=
 =?iso-8859-1?Q?yd4VTX4UL3JExSFEHyEZpcEzLCofTp5g4iOZmStSZhJDrxC+hRtDfr0AWq?=
 =?iso-8859-1?Q?dqJqEewwTPr3PFVllZcsWWeLBYVcOPym8mtXMqoYTyZr+8RGJmKqxuFwf8?=
 =?iso-8859-1?Q?JZd79//O+ykufho1Q/Ien6bhfLi+C12u4dJh38LTFrdKW9q9Jg3S7HWn0X?=
 =?iso-8859-1?Q?M056xdJiDKj7pY7hB5tCfgjJvSUuOIGyPXtiSTCQSdM8QGDNKpJocSBBzb?=
 =?iso-8859-1?Q?XeqdvWP7bn0F07Svj74yMF4c5G1CHMRFLax+X5cMDHovUlkKrX6/juFFTl?=
 =?iso-8859-1?Q?ADDeKubwnwvKH4fdzkQo/5U/WFLModaZO5IM8bKvjNTXPwKQv1IiQ/lmZX?=
 =?iso-8859-1?Q?7wvRfWWY+u5greWn5X97PTa1pn/kNMAwkb0kgDYjpy5hGn3oVIN+jJ+zmb?=
 =?iso-8859-1?Q?pMaINm0+KFzDQZ4VjS3Yo5KM8B76iDwzxMrykt0H4ulzef9LmFHT0e15Nu?=
 =?iso-8859-1?Q?UXzP3LyEjJGjlhA6rZZl4bpIa7ivHGf0qNl5/SWY8yVMuhs3/Bc6Zp0+Gb?=
 =?iso-8859-1?Q?GIWKILbVmH7/J6FIRhYJ8Ag3JzHN0xUmippncyUWGXkVzNEy3qfM9kxD9o?=
 =?iso-8859-1?Q?u+qX9GWciSXjRwfes7KF7Pxm/dLGCKspFE+dq1pBAP1hAJHEVVrEt1cA0P?=
 =?iso-8859-1?Q?Zh3CK1CIJJ/HJXJ1QUVOHp0MfH+Pm9d4W0N0gkipM9EG0kop6ZWSMe6PTU?=
 =?iso-8859-1?Q?/1tpsytpWJq+Ry2+CpAd03JUdzL/hzbv4aRT4H0XASAf0DPznBK+VXhZw5?=
 =?iso-8859-1?Q?9v6E0A+ZWPtn1fVtjmNalN0cc4ktoinNqOBB+HE5l+UX6S1KTvRt+fQfFl?=
 =?iso-8859-1?Q?YUUnSOyq0CHxmYv/3KY5Yk9og1YNZj2etTj1kUocSfJJF9Km6kX/UMHxak?=
 =?iso-8859-1?Q?S6hexAD8ej36z9o2dKrsnQD2VuW9Y9c51AKggtIQ1PaCdyX3feWaPMCYv8?=
 =?iso-8859-1?Q?rwyl1KG7I70nWVc3UglYG7HrKq4qlfAN9GkqLXZ9lnfk9BCJzLyvUGWgNb?=
 =?iso-8859-1?Q?/7zqvY6xEcK9vXQZICyAh6D2KAbNDsy7Hwwz+Xex7nuTOQ4GEJ9SGRCFsM?=
 =?iso-8859-1?Q?lmPCg8jvZQ5OfdGy4uFFzZkgBrL6QEiK3CnjFiVu6FV9kYy91wnJ4jCo0C?=
 =?iso-8859-1?Q?Nqkwp/QgPRDqhK0Eosf4wNRcQXZkswrB5+v3xuqjNs7+KvbkcYiqkDZOu3?=
 =?iso-8859-1?Q?cEp4T8Apb8t5BJ80FGQKtPqYxEcuz/eJ96G8ecMjwX9BUAiKggWM09sHGt?=
 =?iso-8859-1?Q?PR8eUrFdziMLotLnRAzuZ6//5LV/d9MG3TvvcdEbyecQ+SiYU0BwVgTvgY?=
 =?iso-8859-1?Q?WPoPQHf32iwRdi5t4CZoFH1Sxaae0FDXwlB5iTDMoyWUBjikXI3+1gcpsM?=
 =?iso-8859-1?Q?rgA6f2x3/gIjSqSZWccRqjEC3exIP0itV7c/dDtammXFASThFIJSfytRKf?=
 =?iso-8859-1?Q?AyP6f6TsMWAsvjxGmdKgt+cuwnUR0O+MlcIaSZBh0E8ltPot8b2jnEm1SF?=
 =?iso-8859-1?Q?3H3PXOa52en+fy3HrmKDLTjl1cmN0KZRWRj+6aibTo7MCP9jfjSM9TL9rq?=
 =?iso-8859-1?Q?sZwV6ZQaOuD7iCAnNLpY1sz/6MSzBRJ8Gf0c4GJYeN2pjpO9EMRh4SGqv/?=
 =?iso-8859-1?Q?zlp181NgEv758R9NkKQQ5ajouiPYK3qc2+rukf6wJtce6pwPD5R3PdMjLi?=
 =?iso-8859-1?Q?VUBrJPfNPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NSgH1zoazsvcmY8M+rhd5atFqKxrADAYFQIIyMVsjAYYH8Vi/WWMfs3zYXwnwpGa8khU5t59BuOmyQQGRYsHJYro8w+el8pGaykkPYdbpyxYJU4FcZywerveRDPetJmPzpYOr4un3x4QHBJzGJN2ujKP3ETZC3XkWM4eJk5mW0PufEdGg4/AnUvdwdy9l8J0KwR82GON2H7sSrNIy/QVxwlVxb5WXBIWdP9kcpxV11hLAbiIr23p6egLawOg57kZ3Ht/8nskBKseo/l2zluUY2lfI2NNdbhhFgawuXgYQebw1ryTheZljR8Hx8mrazokjQh26NqCV1iIV/FKSKmr9A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1982e52f-ca0e-43ae-cf50-08df1ec3f357
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:05.9954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQxydwCe1WVQS+Ly3/u58AKEZP7zJN+0ZJ0Roe67MW7AIsUBz58IiHKUxvD3iFVMn1CsxTfxRa54XhwPmNZo2tbtRUahtHYNl/LRcyLmmcg=
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
code easier to maintain and read. Convert AST2700 to use them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 49 ++++++++++++++++++-----------------------=0A=
 1 file changed, 21 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 6365dbd638..1d887fd87f 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -24,10 +24,6 @@=0A=
 #include "qobject/qlist.h"=0A=
 #include "qemu/log.h"=0A=
 =0A=
-#define AST2700_SOC_IO_SIZE          0x00FE0000=0A=
-#define AST2700_SOC_IOMEM_SIZE       0x01000000=0A=
-#define AST2700_SOC_DPMCU_SIZE       0x00040000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,=0A=
     [ASPEED_DEV_IOMEM]     =3D  0x00020000,=0A=
@@ -263,6 +259,14 @@ static const struct gic_intc_irq_info ast2700_gic_intc=
map[] =3D {=0A=
     {201, 3, 1, ast2700_gic201_intcmap},=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast2700_unimp_devs[] =3D {=0A=
+    { "dpmcu",  "aspeed.dpmcu",  ASPEED_DEV_DPMCU,  0x00040000 },=0A=
+    { "iomem",  "aspeed.io",     ASPEED_DEV_IOMEM,  0x00FE0000 },=0A=
+    { "iomem0", "aspeed.iomem0", ASPEED_DEV_IOMEM0, 0x01000000 },=0A=
+    { "iomem1", "aspeed.iomem1", ASPEED_DEV_IOMEM1, 0x01000000 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast2700_unimp_devs) > ASPEED_UNIMP=
_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed27x0SoCState *a =3D ASPEED27X0_SOC(s);=0A=
@@ -559,14 +563,10 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                              sc->silicon_rev);=0A=
     }=0A=
 =0A=
-    object_initialize_child(obj, "dpmcu", &s->dpmcu,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "iomem", &s->iomem,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "iomem0", &s->iomem0,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "iomem1", &s->iomem1,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast2700_unimp_devs); i++) {=0A=
+        object_initialize_child(obj, aspeed_soc_ast2700_unimp_devs[i].qom_=
name,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -699,6 +699,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     AspeedINTCClass *ic =3D ASPEED_INTC_GET_CLASS(&a->intc[0]);=0A=
     AspeedINTCClass *icio =3D ASPEED_INTC_GET_CLASS(&a->intc[1]);=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     g_autofree char *name =3D NULL;=0A=
     qemu_irq irq;=0A=
     int uart;=0A=
@@ -1137,22 +1138,14 @@ static void aspeed_soc_ast2700_realize(DeviceState =
*dev, Error **errp)=0A=
         }=0A=
     }=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-                                  "aspeed.dpmcu",=0A=
-                                  sc->memmap[ASPEED_DEV_DPMCU],=0A=
-                                  AST2700_SOC_DPMCU_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  AST2700_SOC_IO_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem0),=
=0A=
-                                  "aspeed.iomem0",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM0],=0A=
-                                  AST2700_SOC_IOMEM_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem1),=
=0A=
-                                  "aspeed.iomem1",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM1],=0A=
-                                  AST2700_SOC_IOMEM_SIZE);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast2700_unimp_devs); i++) {=0A=
+        unimp =3D &aspeed_soc_ast2700_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *d=
ata)=0A=
-- =0A=
2.53.0=0A=

