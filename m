Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C18CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjY-0003C9-RM; Sun, 31 May 2026 22:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjX-0003BK-I2; Sun, 31 May 2026 22:50:31 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjV-0002en-PH; Sun, 31 May 2026 22:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvgNhMwu83uGSLaIgbO5QXA+cKB3jCffHjvdTeP0gS1EXA/3c7UK2HLOmbX8B9GQ1sb9sbdWrgye4NsUlAKlnEtBTh+tv5Wh3zBb0edoOBVi7ZCYHS0NYrlNtUvjuFLhfT3AB+F7PlZRtdIBO6zKIeLaq6HsyVqtnQ4JTVJkZeSnn16nGzechF5QD13BwFUZqIe+7zb8Mwf1du/ny6dS1kr4u2ei6day6XpOQfusAwr+7d5kryvQYEEsDQBeoEByhWM3NavqRCUDZwkTBUQSggxOjvCuTyyvd8J9yOwyNncm48zrbAjy9BPSES0Gy0u34gu6KvTqFedgUMWz5iGFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WI6Iis7H9p1SAsxk0nfQakCjnZ4WmWtB9pDakcSwgQQ=;
 b=qMPkCiXqMl/2hfStGn0WzmsItmue8kJGs1iuBv1K6lPTkqQJUYvfwrTUYt1N2fM5XJEnxba/s3v/GiQXHa+c1VRwzCJamilZVbPD1+mN5ISmaYaYcwbSMHZ+b5nBOA0NclIZJ14obfb4Rpd7FZO55K+fONtP1mSx0SYKrP2ds5lnBdA1bw08p8l6WN2+zxTQezxWUdBnwrchGXuqbwDDQclLPeUJQZe4JXQHyBkMOXLh9VAbAwZZHgakG/ZwgBfiu92m7GjZ3R/8vxqdqKaDjYpIq9xFWD8YazePVqaDbS7K6LpsRBF05RZhzPtmmzcKGHu92Wg52Sx6/k2YQaenxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WI6Iis7H9p1SAsxk0nfQakCjnZ4WmWtB9pDakcSwgQQ=;
 b=S2/jrd1vtqbNu9/ETVyW+a6FF379IQC2yFvh8Rbdl355snJWM93n85ielvQcpzmZtleDDxjl/zFJbsizzezofHlBTmy2KnIO2MtnB98EV8Vsn3RE/Gq4jbTax5TcVhIRN+W2S0fLVKLoEfYRSmleiG+eeG8FJhp8LUlHD7VR7oYh/b343aTjeHuJIx9ofXei1RVYBBtDbaGRAmiD2sM8Yhp6jcQFmA9wjEeegx0y8KgIMY9WDLS4XNGN9jXVPeIgfMqSUdCxhzmXtR+LXPzQubXq1zZbVyzyEuK6PakSfz9jcytd3GU5LYOfK0e5Y+1nhibdHKYpPT8t1BXf4O9WZw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:14 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 09/24] hw/misc/aspeed_xdma: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 09/24] hw/misc/aspeed_xdma: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFfLEYiIAaRXUierIpt49uvKA==
Date: Mon, 1 Jun 2026 02:50:14 +0000
Message-ID: <20260601024959.2347639-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 2c872ae8-68fa-4334-5af1-08debf8881d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: kTaRBtGZj8jUvr1uTYe+Mlt1qpRHOdu/PRuvdgbHdW5QkXYkuIPRydbu7FOcWvlq9OBZTvcPV7Dx2svDwDDGydkTTSywbfGd6PpO6KkmlsZ7Dswpqx1nSykPwbNIzO3AP8hcRlmzHnZELWBEG0IebUve4rNqkObW7ppaIGax2LUZVVevM/eGbk8fcAFrmkFhUTFWXhWD1CuJpLd1dHQOrFlP5AgYHBWHMDeIeU+kXGK6454vNpQ5GeHSLFTwBtvwbEnwFI+qIWzn16yzg4u/sG+R87R5YwrF8gSYkClfJ3XkVf5qUBDSpbT2QACFla+AhOlVliSWz1GrDYOLG85qufnA4sDvcu/H6iSssxqKfwiY1zaasF9axh+d8YmsXme6WzH8KSLS64lQV305kgxACMiGjKX5BCzX/WUa/Yuz759D1iYMJbx4JMTCqN3+723pPXxFNJIUnv+4rdhScEsocsoxLTBNeLWlrRnDMBn//eBtg6h/KtTmHhuL8PyeYwPjYR3aexVRsWfybIm4czt3kUyEGcE/ZtEKVPHx8Bq06bvkDfRfwfjPR82DgdVoQ9xP5JsZuyICL4VyYZFU+rTN1wPBxvsK0ZGS0D4V/59gnVpRHNdEu++Q/59S65M0DEk2rb24x54NbOusC7mbUOFtvhSpaMiWuXDA21v50xPrcmgRAiJizCC669Fxbai7NftRGQR5nIw58cD4kmqrDRlV/P680ZJAdOciH5geWMK3KOqXsbcYhDqY6THzwtY8GGzarAvfzYXQeKoSLc/ki5iQHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jFZsByhU5xLPJ2U+VIQn+A8NuwK4FD6TnWpRHmcp4mMcX+3aRXOxxF0nNu?=
 =?iso-8859-1?Q?VRFlgac7uuqMML1Tcr/mb4VOYPb9cOYOSczasfHM3TQvgX7SuvEXn73ct+?=
 =?iso-8859-1?Q?kRKWyiS22T3Tspn6mCTBUjDYAYPP24P56KKgo2qBbA+/C8w/WZSC8CvfOB?=
 =?iso-8859-1?Q?OWl60og3/P1yNinXxTpaBKAGuOCrxwDwPM+Sy+v14R2DfvZgZvM3/nTCxC?=
 =?iso-8859-1?Q?U+iiMIyIV+spof19RR/iYo4izOdptfNMk4dEoOcg6jD98S1KxsPalEXFvi?=
 =?iso-8859-1?Q?IB2r9WjDusotWHslk5aF3/QEmvoBx8C/Lamk4OLwtLdwe8GvjEV8nuhr1s?=
 =?iso-8859-1?Q?N0hyoUPQ04/M5XZUKKuiVYhTURG7uRBOJsAhPO/8c52XwdrH/SjNWgtXyn?=
 =?iso-8859-1?Q?5hG4xesKcxM+5+uUoO8Fbj3y210/geFybkCYRF655+jlgV50TaIwvIX/mW?=
 =?iso-8859-1?Q?fcTBdjnukwJv3fqjLekKJtubfDmFtCtEwEoq2qLl+FSGIGjuq//NhtAg3i?=
 =?iso-8859-1?Q?dyfe1mz8Nt4G8G6o4RUqth3PgA11tGfhdjs8H3SqvnwjIFTR6rGuPIHlB9?=
 =?iso-8859-1?Q?HL2jyMZzB+s8mYNWvPSjl7KXvdSnODhleqB73E89kija9F38AppSQz1JXK?=
 =?iso-8859-1?Q?L8JoWGIf0wYZQ20wdAgpXUXqWow7l0Fxym/2g/ni/qFONYyuboyNt9zXJC?=
 =?iso-8859-1?Q?UrOzZxV3SEI61iqhWCEch68/qjEavd/oS90f7iHUooRcOMzCawEpjmfsas?=
 =?iso-8859-1?Q?Epy/nUiEHC9PwK9smbY+hxL0+4v6aES6iYSphevfqczjAGEamgPWVOZ0IL?=
 =?iso-8859-1?Q?8qoUtksIan+f8fAyWYyg6jjd5NAFzcyQHWVQinOKvAHwneZTyTohD4gOSB?=
 =?iso-8859-1?Q?lQsBTB4u4Iak7gB4F4D2zlZ9PdPe6DEOjzWu07n+N+4WLgKKA9NYMW+oBf?=
 =?iso-8859-1?Q?qxtzWzv1Q898FMLhDA5Gwzge2DwYY1ARWChIKev9dQ/NRsq2zAhh1Lf0ZW?=
 =?iso-8859-1?Q?6owrj7hGX6yKyweWBLVDGflzyhYJhlYjeY9eaWJ+uruKEYjTtyrnbtYjvJ?=
 =?iso-8859-1?Q?i0Bz5SLvAaPpAroIRbyTRvmS+JbxfZCk9ThMxxhKkRsTOoMsQkDdho/liO?=
 =?iso-8859-1?Q?vafPF2DEI/hl2wHl2q/sXPjYnbR2a1syZgIZCZlSqko6OwgpzelI5Hvd5A?=
 =?iso-8859-1?Q?CN8bxyhBGSPQntnhz7rErW1vlk2U3BZg/SM30aZYWxO0NOaQ3R2/SU3Tt/?=
 =?iso-8859-1?Q?BaqdtTXvvjEebXqYrFzbbYuky2CUzl+rjTyf5dZxHwdzJJwsWNSexEAJvG?=
 =?iso-8859-1?Q?u9nUKpSYw8PhN8u407L4CbdpMh5VH8iKOAnIjRtYKb8fJiQubbakh1ktiN?=
 =?iso-8859-1?Q?AjNEtCosgo9lSXabzl2B/Lq6nJcziB1UIomBWQx/dguc2mMq4qSHVZRHYz?=
 =?iso-8859-1?Q?Y19RaZHqZaAtzBvHaBQNxQRK6yw4fZkH+N7evF6oGlk4/PHgAFVtmdafhy?=
 =?iso-8859-1?Q?mryaR2HIjUmA8q6niaU0Fh85w1wedOxLSAzbCRCevNYN9bBtcVglySoDPT?=
 =?iso-8859-1?Q?dcGVQco3SPgRkCrMtzH0JCqKF4pSnhukpdyO/9ypCXEffolOtBY8ZN7LBF?=
 =?iso-8859-1?Q?jUzysGJeacwFe+FrWnGI0sjzNbo6b4E96rB+kS54sEJtXWSrsnsqt3DVtD?=
 =?iso-8859-1?Q?1fRIRgRiVRdbl7cm9wQbvNVe2BDuWHk3sNFRKuynf3Vv10ajQxqWrzePrt?=
 =?iso-8859-1?Q?v9PHmxtHru1LuwpcCrg7lWagi4Ao+3OcnumFdQ3eYANa4E8i54Xgv67a7I?=
 =?iso-8859-1?Q?jkprHnFRPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CPKj7hhOAJGQ+ah+sxkYU92MZdJJJZGM2K0kClyCFv97N8qF0g4fu3RJ2qvaDAITNz3kE9UvSsmBdYReD1bN5jlIAP8JMGuBnozleJshebTSogPDWx2uPtwkimtYliThPixkNHfiwXBNHf3B4+a9gmLxsRUBFuEKTpu+fNcfdwVYW9U8O4qMeNdq7tiSbI991in2sGXblIVcl2Q7VH0HPxm7d2Ul46WbSHM0aZK8dO+7V2IhT/11G4iQDn4OLW5EkSJgdLBshvJvt4jo+Tu7ccqrzJxl2n4TbrUPCe7KzM8rtCau3nqkwaiNPkZ4SQY91OCXIlq32Avh36plhHxQZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c872ae8-68fa-4334-5af1-08debf8881d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:14.7926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cDEoprvt8vK4tE0g/mZn0cAFCh60huUwGCF5ZljfOVSBkgyP9Hqqt5oSby4pqsM3npFRBhL78RvgldaVfvUT9LiE7bZP9s6x8QPeI6kLUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 4 standalone TypeInfo variables (aspeed_xdma_info as abstract=0A=
base, aspeed_2400_xdma_info, aspeed_2500_xdma_info,=0A=
aspeed_2600_xdma_info) directly into the 'aspeed_xdma_types[]'=0A=
array, removing the need for separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_xdma.c | 58 +++++++++++++++++++------------------------=0A=
 1 file changed, 25 insertions(+), 33 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c=0A=
index 80b3259333..58a471ee03 100644=0A=
--- a/hw/misc/aspeed_xdma.c=0A=
+++ b/hw/misc/aspeed_xdma.c=0A=
@@ -167,12 +167,6 @@ static void aspeed_2600_xdma_class_init(ObjectClass *k=
lass, const void *data)=0A=
         XDMA_AST2600_IRQ_STATUS_DS_COMP;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_xdma_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_XDMA,=0A=
-    .parent =3D TYPE_ASPEED_XDMA,=0A=
-    .class_init =3D aspeed_2600_xdma_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2500_xdma_class_init(ObjectClass *klass, const void *da=
ta)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -189,12 +183,6 @@ static void aspeed_2500_xdma_class_init(ObjectClass *k=
lass, const void *data)=0A=
     axc->intr_complete =3D XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_D=
S_COMP;=0A=
 };=0A=
 =0A=
-static const TypeInfo aspeed_2500_xdma_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_XDMA,=0A=
-    .parent =3D TYPE_ASPEED_XDMA,=0A=
-    .class_init =3D aspeed_2500_xdma_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2400_xdma_class_init(ObjectClass *klass, const void *da=
ta)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -211,12 +199,6 @@ static void aspeed_2400_xdma_class_init(ObjectClass *k=
lass, const void *data)=0A=
     axc->intr_complete =3D XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_D=
S_COMP;=0A=
 };=0A=
 =0A=
-static const TypeInfo aspeed_2400_xdma_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_XDMA,=0A=
-    .parent =3D TYPE_ASPEED_XDMA,=0A=
-    .class_init =3D aspeed_2400_xdma_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_xdma_class_init(ObjectClass *classp, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(classp);=0A=
@@ -227,20 +209,30 @@ static void aspeed_xdma_class_init(ObjectClass *class=
p, const void *data)=0A=
     dc->vmsd =3D &aspeed_xdma_vmstate;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_xdma_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_XDMA,=0A=
-    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedXDMAState),=0A=
-    .class_init    =3D aspeed_xdma_class_init,=0A=
-    .class_size    =3D sizeof(AspeedXDMAClass),=0A=
-    .abstract      =3D true,=0A=
+static const TypeInfo aspeed_xdma_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_XDMA,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedXDMAState),=0A=
+        .class_init    =3D aspeed_xdma_class_init,=0A=
+        .class_size    =3D sizeof(AspeedXDMAClass),=0A=
+        .abstract      =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_XDMA,=0A=
+        .parent =3D TYPE_ASPEED_XDMA,=0A=
+        .class_init =3D aspeed_2400_xdma_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_XDMA,=0A=
+        .parent =3D TYPE_ASPEED_XDMA,=0A=
+        .class_init =3D aspeed_2500_xdma_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_XDMA,=0A=
+        .parent =3D TYPE_ASPEED_XDMA,=0A=
+        .class_init =3D aspeed_2600_xdma_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_xdma_register_type(void)=0A=
-{=0A=
-    type_register_static(&aspeed_xdma_info);=0A=
-    type_register_static(&aspeed_2400_xdma_info);=0A=
-    type_register_static(&aspeed_2500_xdma_info);=0A=
-    type_register_static(&aspeed_2600_xdma_info);=0A=
-}=0A=
-type_init(aspeed_xdma_register_type);=0A=
+DEFINE_TYPES(aspeed_xdma_types)=0A=
-- =0A=
2.43.0=0A=

