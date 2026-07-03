Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886DBC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYZ4-0008Sv-C8; Fri, 03 Jul 2026 03:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYZ2-0008ST-NN; Fri, 03 Jul 2026 03:43:56 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYZ1-0004IZ-8R; Fri, 03 Jul 2026 03:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fly6HFd7hQTw/1L04wSunyk9+c3h85wl2+A3bsm1EJ7tyvaFJ8pwEmVp2Rgd3wkIO7zbO9GErykqT6PM/TApZ7G8pLhrSWDFjDazSXT6sH/2NP58Rv9HjOJy05+li0OcB+oQlbmZ55/uGWgdkewvxDhmSAxYr5WFvw7gXRjkRktdo8JptWjUj4eOVCWx1IhXow0mwen0BbOGWi/ItxFyV0AjEu6tfZiRDgNljUeSfKEtQHDT3a0JJErA5pl30jhs2tPA3EFi808IOjkn9O2Qysyn7Y2EOj+GxRcPEbZpxPDfrdO4p165zNCgSW4gW7EqmfZ096KunB3qddTymv0LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+y91dGg+hWNgOQxOevXvocpd565pzFhnAkFP/pt9o4=;
 b=GmCxoP+Li/Cf2KZkr2vQlheaGgsl9y7K6PYFt+VKIkAmJWWwgMotK2c1kR7ffl+sa5IKE/CM4u/ViklZhZl00YSWNz6QTkWw6LahvEgFJQzumj/SFcck0vTeBCyjhOAnk/ft1c6f292HnvwOOG4fUfoQ7F5d1ejTd0RndSnLycjf1FzOR1upa0N8t126RvCTOUqrR32X2oPk2uGPtCYIQSP6sucZd3w0KZu4w7dHrkcmJsNcDalcEzuARKl5ZYuvYn6jjVetPzpNfQ9mTv6pnW8xvH/K32SNuty6V4Je3riZI0BFgtpy+1RNZ4ZRzt9/t2aoevv3TPVTy+CWtNkPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+y91dGg+hWNgOQxOevXvocpd565pzFhnAkFP/pt9o4=;
 b=JfOswZcbbECavYe2ANmlGGcbQU1gTRO73IXlQOKu8tuNDtlc8zVWs5YLiU5tjy/BMeUh19v0+W473TuRf0SevYCNmqRFLvzlk5tdpLBfS+WHdxbReep2obXEfVxWCTaQ6513aB5V63bb5fizhOYeh0x6A0bFfk8SAPIl8Rt+3lvYlK9+dD5sLm0IDjtbrOPeFhGRgvc3lXDZa8m14l4uKc4Rf91waRMJGoRvT70AtTB8erNjuOiei55qchJt00uzXMqD/RhDxMDptOE5dDVO3uj5vKvPjBLyWkpqP/fT28kmF6h+XXhEJGPcD/hBEityS1v6KJg5kCZgNeohLHhXEg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 07:43:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 07:43:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/3] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v1 3/3] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdCr+oNl8HJH0GCUqipWD50Ge91w==
Date: Fri, 3 Jul 2026 07:43:37 +0000
Message-ID: <20260703074332.1049473-4-jamin_lin@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5040:EE_
x-ms-office365-filtering-correlation-id: 3b93e814-f44a-4f75-6b53-08ded8d6cafc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: uaK8N+GSFjjQUx8W5ffmtU9AM5Kr7Twi/kAcHhjgH9il6gs6hmyIGnHb5etuE7uKIJ0zaPcbx8vtO017fFaLSKWIRJUwR5A0Se4oFfENiqb2DKvn+HApI28A5WS52fJddLqMc8FeLbFWNKXx29lKpLYemkZO7JdeJdbYqQdUF06OtGAehzkQgeNVM/51bNp3F87svHjfbblZLuWtUTEbcDdgBf0LZVdEH8AgKVQCL24UGTboxPRGsw8ye8+b8r+v/QQMvYu6kGOjiuWk2lFW8V64nEmUjC9Gz10NdE3B80H83CSedmFWS0lkkG5LMSyLBj37SjqJ6Hcpt8+5WX3rf7+mPuzkEqXrVWPFn3SUjd29SMardR28WYcQeDeAli7JjCZudkci96XXUKPPc8iWBMOxxYQPWEIpIq2Lx4+QVx+wyU4z0Pf/yRzOPdR8bHWCNx6tAdKHXkkNeiiOqfAEkdrll9KRO3v14mO63ZZFO/m1uDqLavC8KUS9ripsNcwRpL381U5qEItm9V1hYxmcQ5Me514sffmIlUlB5Jgi/yfsdXOR9gKFDeOxbm4E5plyHLaP4/TrfOscGZPWwlnJKlO6s1PGJfLiGszgj6nhhILRQhM0DaG07R27faCl1sjqQWZwwoR/8Gp64u8fZjGC39HucUR9+PN7ZTRv6VX/4S9Pri2pFQC5e/da6d3Qc5gaTz4LJB6bickEd0csq9IP/q8v9hRAuXN9GMdkLiD6M9k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KBwSuM05G6P0RVayhN1FYyBfvAatD7/SzpVxkf9hJfZvd1hdMLYZfmE3pM?=
 =?iso-8859-1?Q?9Y7PZAS3DbB23QV1/u2X4NlvDAzBxa8ZjR3yNuWKfbWjdenr6gEcBA+eWb?=
 =?iso-8859-1?Q?vJZAG9qF7xcvbk/bQdCXalDgwkPMLSP7f4qL5MgZV0tLOR6/zq0ZopT4Dz?=
 =?iso-8859-1?Q?Bkrxv3SB+4p9vsS3uPcqPoGnVz7+R2hHdQIMECo/1gvhLeqkS707pulp4T?=
 =?iso-8859-1?Q?MTARuYdMwZcwzZSG6LiWi//rNYiXRw+mjkYYsGg6fI9NlsaHsazlMZoJBA?=
 =?iso-8859-1?Q?Uv9oifY2ZHYrYLNQZEREfyMrUQLIHmg2T3HyUSuUZQhK0Qig3RdLysyJ5o?=
 =?iso-8859-1?Q?q51JklWxLEkQ2wd5bXzkTdy68AHID7GWPsmdyDs8ayuLvIyLsJgD5e/NSm?=
 =?iso-8859-1?Q?DynuCNzQQHyF/dvOZxJxCay98xfNW5fHfp4KtwvjI9lmWzI2Wl9z0V7lZ0?=
 =?iso-8859-1?Q?b/XrRgUqkCI4papcCt8VNEq+P3M3Oq6tk6fHvaPVEufvqdHtpoZmVXyS0O?=
 =?iso-8859-1?Q?7nRFBDpFoXgmXSAcGtZltyIscl4z6FjIfv9unCMENanhS9FzBLq+elY0+7?=
 =?iso-8859-1?Q?BXo0lEuVPZRwd4xPYY3NUiRvEcjQ9S6rZzDu6adA8smOUpLhHMtEkpRyCr?=
 =?iso-8859-1?Q?QhctRBAYXqfdUPmXFG0Q3OwSpJn4XuBf+uVd0s6b8m4NIWuUu+IML5IgIS?=
 =?iso-8859-1?Q?WHxwKLh2vpek80a8vcKDMlHcEGocqZ/OVHjMt2m5C5ck3nh0TslM71VGuC?=
 =?iso-8859-1?Q?OZeXHIdUIUWN2WnBsHZq2pc8lK/+D5QP4OnYxraIoUVf97139rqf9KhdAG?=
 =?iso-8859-1?Q?Shbm6lAUDYNzijqHRTSJpHhBglmouM6by5m5gZxvV+fdI4XiioOnZRTPjn?=
 =?iso-8859-1?Q?WCMbzlEsMyNWOJvld8JlY7pcugZYkoV58Ty5AboNrOQv2qiAX1fLRQ/TRy?=
 =?iso-8859-1?Q?YDQ04fCP1dd8EmDoFrPyFhxW7zDoKAnQdI5N9k4VFzo4to+9xksjUi22VZ?=
 =?iso-8859-1?Q?wa3/dGmz837g5Hm4qvJaMbmvtVa6HDI338N36tnX0Dc/iMm4JR9C9109IE?=
 =?iso-8859-1?Q?W3MNbZrkoMswZE+fTJBpqSPrlsbtUGd1AWS3Nn1WBPiPPdoh0V1EcK7zpM?=
 =?iso-8859-1?Q?+Xk+N/ogsBe85cCS/CJ1Q2rv/mjeRkcu1Zz5G8bLyrYIhG72pEJXNpGlj4?=
 =?iso-8859-1?Q?zfpJEM5gNJvOwz6hu9IVxX6koa9RtQ6jRRQ1Zt/9y1W8CRilemgszWBQ3z?=
 =?iso-8859-1?Q?r6WEA13+dX/618bQD19eo2y4zI8/QiEwMdqhFqo76T0B5U4mMIAomCcQ+N?=
 =?iso-8859-1?Q?oP6RO930olGbo0yxsWYLJRc7yaXBNxEV+p5SeA0wnP5daYGrpEY94HD+TL?=
 =?iso-8859-1?Q?G6qAnmxitse+wqSSTKm6fte64yhKYqGvTPrTphVbZ2y12lSbLZvTUF2qeU?=
 =?iso-8859-1?Q?mwqFyeSwzjAVIUjq+sqY6KaEb1r4iEYaTeyIkrbCwNjVhYCP6rXG7Y/JZ8?=
 =?iso-8859-1?Q?A+iDkPAw9J0xERgUfnNHFRouK+rO+0Oaz3sZpDeT1MGfyJGGBantZG4cWO?=
 =?iso-8859-1?Q?rNPgCDE44GSHAqDIBCMa+SjwgI7n63rcwZ7c2GrlhCnQVpU6mA0mpRysJQ?=
 =?iso-8859-1?Q?+twPAvajE4U8NnHp5YtVQYo+I4iKQ3dMalngfONQKBuZ0SATQnyj9Frqts?=
 =?iso-8859-1?Q?egOo2CWqDBV4pbLf8TrrKfd+GMo7sbEXptefcfxliWbVpkM3A3ZuHHlHbT?=
 =?iso-8859-1?Q?cywAXEfxR3hvsy3DFTwoaUmezQsG+KbO7krNqVJBBm9RnXJetXchzXs7f7?=
 =?iso-8859-1?Q?4YadSwH3Ag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CElPP6vvMh4FLRHBu5Np0TS4kOyZ4gAxhtphcJIOhbY2sb11WxutL1tihQJ+kIa+AwxkzGwXebGSiFclutklzQw1myL6dqFFw8L3SPE2JbEH3ZfVVLm37933zHrd9g6kO/jhZYHnLzzlGgih15G1IWdte0VwEsUdlp0dRMPRwtfwBRuf1DuuN4IY98qm0nwxcxaRUTRyfMlY0M6x+GmQsnnxW2tQzvBQHXJ66AD8veCa2+v3mAAkEHqhUqyx+aktDf4k2dTp6SgmoT8HYT3RA5vqCKpAWpEdXL50OQnFKnOiZIecf7tpgDTRrP7M9QLau3PXmuNr1BseVdMx6essOQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b93e814-f44a-4f75-6b53-08ded8d6cafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 07:43:37.2891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LCi99BEKcRgk84t+bbLOYDCg0rCLzDA2645DHKF3/2B8+ywUhzbnMJsdfvWzOVb/fr0uWjX3SIbOMGHjqKZNMY3l5RRn3MsbVpFxwUGkF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040
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

Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC:=0A=
map its registers and connect its interrupt.=0A=
=0A=
The gadget USB device is not created by the SoC. It is a separate,=0A=
user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a=0A=
USB host controller's bus; it finds its controller through the "udc"=0A=
link property, e.g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast2600.c     | 13 +++++++++++++=0A=
 include/hw/arm/aspeed_soc.h |  2 ++=0A=
 2 files changed, 15 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..7d97f10448 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI1]      =3D 0x1E630000,=0A=
     [ASPEED_DEV_SPI2]      =3D 0x1E631000,=0A=
     [ASPEED_DEV_EHCI1]     =3D 0x1E6A1000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x1E6A2000,=0A=
     [ASPEED_DEV_EHCI2]     =3D 0x1E6A3000,=0A=
     [ASPEED_DEV_MII1]      =3D 0x1E650000,=0A=
     [ASPEED_DEV_MII2]      =3D 0x1E650008,=0A=
@@ -113,6 +114,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {=0A=
     [ASPEED_DEV_SDHCI]     =3D 43,=0A=
     [ASPEED_DEV_EHCI1]     =3D 5,=0A=
     [ASPEED_DEV_EHCI2]     =3D 9,=0A=
+    [ASPEED_DEV_UDC]       =3D 9,=0A=
     [ASPEED_DEV_EMMC]      =3D 15,=0A=
     [ASPEED_DEV_GPIO]      =3D 40,=0A=
     [ASPEED_DEV_GPIO_1_8V] =3D 11,=0A=
@@ -214,6 +216,8 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
                                 TYPE_PLATFORM_EHCI);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+=0A=
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);=0A=
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);=0A=
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),=0A=
@@ -573,6 +577,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
                                                       ASPEED_DEV_EHCI1 + i=
));=0A=
     }=0A=
 =0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_UDC));=0A=
+=0A=
     /* SDMC - SDRAM Memory Controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {=0A=
         return;=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 3aac144cd4..74fd83e957 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -36,6 +36,7 @@=0A=
 #include "hw/gpio/aspeed_sgpio.h"=0A=
 #include "hw/sd/aspeed_sdhci.h"=0A=
 #include "hw/usb/hcd-ehci.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
 #include "qom/object.h"=0A=
 #include "hw/misc/aspeed_lpc.h"=0A=
 #include "hw/misc/unimp.h"=0A=
@@ -138,6 +139,7 @@ struct Aspeed2600SoCState {=0A=
 =0A=
     A15MPPrivState a7mpcore;=0A=
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */=0A=
+    AspeedUDCState udc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"=0A=
-- =0A=
2.53.0=0A=

