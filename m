Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC98CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsje-0003Gy-J2; Sun, 31 May 2026 22:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjc-0003FU-Ll; Sun, 31 May 2026 22:50:36 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjb-0002en-1u; Sun, 31 May 2026 22:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVj6hM63/MBJbSaoK3ILPN1nFHRyUu45AkiB4TIiXX/BBgkfjYgzjD42qbZ2Pbi8jRIiEgFNNYcOSp6cVrWu1b4/pESz5fwq4EJYTt4/c9a2WGzwDHvWjfllgP07AtEQ/Qypx5wremkwBEsIpqtX60JuYUnerOTOFZVBC++UOmXpmzXYjlnwzsYdGU81YC+ysw0BzvMjKnyEltTeJCgMu65o5rG4I10tfUDpevpAu3mmLxpxq801mCsjbr1LLWTDoDxGmhNcfngV1H5EBKnCFfdld5zZ26iVs6sSPrT6cRE+LyU6hYTrjC5EDzcMSqhDfR9iJ+LAkb8r5szmfvIA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ+9McoYiIYGKPD4GX+9dS9lyTiwHjFppwirxmH0TcM=;
 b=oDwPmTV97RWzKITWx7eF9cxYgeUMs4vu0SYtm7l+Re8AhVbRXtq+4uaP5klq4NGI6nHk3IX1crI9aS88AkBGEZzrp7XlRrjS2DVwcv4V/LXFWB+6KZZnvejTr8xIRP3fBbyjkqg/nJof5pmXpgmgEXv7cecjGuKJoJ4HaZXOIQBizwE0EKHCCU3rlRCCLwTEl1b6pofJWmkwMZJQQKI1+BjQ6ygCR2WQUxuuhBPtRNI5vILX1Y7JldD2cs2gj6d0iQ/4kfqPd2eUt8Fsv43mXF/aPwDJHkL82jOdiiTitiDZnaneHrVc+dyufr9BpE1x4kfcuWvnO0LTZRis+8a7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ+9McoYiIYGKPD4GX+9dS9lyTiwHjFppwirxmH0TcM=;
 b=RVV7LJziCHFNuC76cJD6AGNYZYZ9sLYdVvgUckaz5bJ+46YbgPUuR5nPCNeCb83Vo73EbCJSMQ9+8Wv7IL+WxMTtcM4pizuK5Q4coaFEsHyx/zgL2eWOTBQPcc1tedRqSQca3ZfupkLJSqmHzsFHZAhYlChc0d3fMf/BN5F7YO4y43P5zP7M1eJvav0CrR3J2Rv0dpvAKaL0GAhHO415vW8wLOgCsWldWa0ztNBjBbXqmAT3vfxlUSfVOIYvWqUubwsec62i+MVd4FuA5swsgmMNZR+/YISXgIcN+XXhy/lhZgUro4xeY0KPIcEuAZGBSKcP4VYPQ1aJglswxm+IoQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 13/24] hw/gpio/aspeed_sgpio: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 13/24] hw/gpio/aspeed_sgpio: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFisl8h63JLBkuyFA1FRU8fug==
Date: Mon, 1 Jun 2026 02:50:20 +0000
Message-ID: <20260601024959.2347639-14-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 02756ebc-4eeb-429e-8402-08debf888565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: BNrb68yD0RBtRl4k+o+4HD8USTgo8eE9x00hg8yRpfszzh0Jjm/jIXVziBvH6x6eFlOYSech4d6U+dtMI0V5xt7oTS1CGemF0DIBrwf18nTtwlhwqTlnn6I9FZJ85KU3UgsPfnluuI43t8Y5B5eqFOsZCN4Qda/7Na9M3Se+zl2cKwxQA+brOxD7SnyKAzhzedPqxosPeLcZB/oGXCOasxLZUuoOIxBUWJ47r0aSYNE2ohQtN5lm/2gz+vZD2PDAMPsYwrb63fkgHIDI2q18eJXSBO4Od5sVKO2v2UWx5XaoJKvRu11DAWKHMsEkxFeMWjVmUNkiEZ5dq7zBOy5e8HvcoBH4Jq6c8g+s2L3Qt0tjbdLXAfRoR+n5lHD3i0HFUrcLlxjU69SpYdhsfCNu3sraj41TOLzT8sqANRzd+oIrM0GUPRrHYU9yckWSGpn7a+CFHlHfIwgGZPisRRfDyt20BrnVWDlqojCd0veTz6NPDlvsx09Vhv65yusZS4js5GMIt/+TmZQF86ssCcAf7CQPdEcCrEXhy02Q2RG+G3QV29W8qpkxpMihXlLhsXFp2wtqoZ2i0TPUliSzuJOWY8XS+wVtOG5Y5EuK0bWmU+CysYSnMFKYuvwnCphIfEvEbPtaZ512cToyEtp0AqqxfErz8cAKiCa1C8/Oy4DwZQDM8XBEJBP4RZK+9nQoD6VDFwULV7QEElr5xR5qWaziJHnYXl41+OkKmR0pKKKtT2au7LwF+JKN1O/KW2l35OSQXoBMAIKab3amsA6lXvrOTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2MrniMOQgSttQkPSuOL2d1JDC5qCc5WXtTH95S48kC/TkbyqUPQ4qBYMhK?=
 =?iso-8859-1?Q?Tx5wvKrc3LC/a1pnKyl2p1GBhTU5QT10j3o43fLc4qw4YlTrBOAahKPrX7?=
 =?iso-8859-1?Q?Mz1RmvcQ4gv0XF8Ulri4Qc256W8AC6CgdPPDXDkyS5vFvjpAXYYZVa/0vf?=
 =?iso-8859-1?Q?FNMzPpMKacbzL2C7kEbxw+hzxZaUOlUYFLeWQFPunpNvoVbCLSNQq3qtHm?=
 =?iso-8859-1?Q?vqdSngfCCAU7fFNeOVOop3FerlZsZjlknJPKjd05KB9/1JH5yPDdEXZpUl?=
 =?iso-8859-1?Q?8CVwFJmjKnd3mLSEdzJFr25XJoC8/iEpSoyxtBq/SbYIG/dQKzzdMgiQaN?=
 =?iso-8859-1?Q?6+f6utK1GMOgYRpyw8kP+ToSYvxcnZVNCUs4V8bHZ2GKoIY0nhWBGCRyl1?=
 =?iso-8859-1?Q?wpgA1zmgd8dTc75px8GcnH95mKmOJLSf+78fHKZIqyIsKZer84IZlp2+us?=
 =?iso-8859-1?Q?qDSaipVAy7xl42rxDrzktk5ZpI/XQdxDX5G0tcSedRGnryODNu/wkoNFhT?=
 =?iso-8859-1?Q?QkSERiQ0b2s4iPJ4jnm5Wqtkpn0Kw42qqWGcileJIHl3v3fZ2HxIzc5Kg7?=
 =?iso-8859-1?Q?9ydMYidLEvoAyhKyKVRipkChVKOi1Iu5vs3pqBt3crxOLpMYRF72JU5VOd?=
 =?iso-8859-1?Q?KWE5fZdl+oj8EwIXLyjFICq2Ce6Hc72KEq1b54nP+IX5MJr9VY3c/3PIvR?=
 =?iso-8859-1?Q?JYvzsJ/anUsXTXCJuAQnISiPdboLyUBhf7t9EWpDZfwjSKjHN4oCyapr8f?=
 =?iso-8859-1?Q?X6MGCN/VyfkmHLPaIebWla4guNV52HPNyyeoUhOnDLmDHYqAciQsKkPEJw?=
 =?iso-8859-1?Q?eb1PCYk2uv0T10KvWQUtfFnXytwirowTcM7uNxaH1/M5ngJgaiX5RASYYB?=
 =?iso-8859-1?Q?P/MXMo0bBH3vLLAWUiEPGZriM/ZJcYUUdKY408/Nwltt9og8frO9gUc+Zl?=
 =?iso-8859-1?Q?oxwHHeh/KcWF9sXRR9owmKCNHNvazj/4nkvBaEtk9jC6vI1XstnMt+FVl6?=
 =?iso-8859-1?Q?6p2OQDldPtJr7Pesggtq+0FyeMNSvC761+fY+ZviEgkUZ6CoRBjbuvr8Wc?=
 =?iso-8859-1?Q?7bVdiGRGjK5h55oyh5nWeGoXqdN6VFXZFevgGBCnGBiI8P11e7xhwdfSEO?=
 =?iso-8859-1?Q?Dmr4a9zChp1Lvh+tp77hrBPxpmRTqAJ77efK4t7tAgkuZG16U3REzZAGd7?=
 =?iso-8859-1?Q?lMzzYuNUYvZQqXXZeA1PVsZ5fYUNJi/oD7jdp3UqHZClDdGhDWS9/Temvr?=
 =?iso-8859-1?Q?xQ8JFMaz+QIN9i0R8e7/fODgotb58rBlZws14RChQoD/TFHX43iizqcwyE?=
 =?iso-8859-1?Q?PIW2cIN+HZvLN831cSXhXYLFowW8h1dTfIGDJh4kkTEy6JjW+9NrSvsX2o?=
 =?iso-8859-1?Q?+oE/vuVEabEUunY2X98KMJ5LbAElRasahUz9orXmE3ll79wzFo0OphW8Bm?=
 =?iso-8859-1?Q?zz6pC0wQ5+miQAYIX84hZ1c7zKwHvOzzfGHJf7tsDE+jJu1zCo2Uy51iN2?=
 =?iso-8859-1?Q?GhE55Hn2IOp+OxsjkkZZTpNBiYMKuMsbcU3k+zSazbXAuLVBHXrCpMdzXl?=
 =?iso-8859-1?Q?mr8cm3xJ2o+ljG8YOn44WEt1eOXzwMpegSZLtNxDihdWBbHk1LAoFM109v?=
 =?iso-8859-1?Q?m1w+KWuFwBRDhanhodW68YI9xhsoCdbhRO2uWGppdmi6i8qiB1VPk0OE45?=
 =?iso-8859-1?Q?LLG8KPHq9ehVPi1DYhjWwpaG2vpJg+xLjY8MrTtykGtMWJUHu0zLDbuPzK?=
 =?iso-8859-1?Q?jNks5BErAtltbuFASYc2oATGYHWmapzX0VpZKwhe/6c+o8AxRVOqcbhBBs?=
 =?iso-8859-1?Q?IN+AgRjWGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WmxGwR7POZH277cg9ROpdWpOR8bl7Z4mUjy5VE204i8Ne8bw/wkJyWpeKchoYmpVBuj35221dfNDr3J3emiRpAnM9guXB1EbrFJ3zGh2IoQnGqH821C2JbsRG7Fr8X6Ub/ShKeteqWNoEt3Hi8vU1bSEkVTNzRgELI6h/vMkRfU0VcVbBhxo335UHFypYWjzGL5VoRglcrfTM3+/9oJypics6aChfnz0u3cZMptacmE5h41Ov1a1e7N1na8GSTeJDc31mt4T+9M6QwxRTG7HSKuK4oW/7OB3vZyz7Ke4PotyKX2zQmaq2mvynhgT+R+w2uS51Jy1Xt58BuJmamToSQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02756ebc-4eeb-429e-8402-08debf888565
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:20.7214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/Kq2PEjzWdBtOrbuppxfhNVi00bJefDp0euycL1+24Tj2aaDOTCW1ctoXW1Qpph1OVCY6GsKggeWGUcWJMxElOhXNxlHueR0xiLCdqKcOI=
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
Inline 2 standalone TypeInfo variables (aspeed_sgpio_info and=0A=
aspeed_sgpio_ast2700_info) directly into the 'aspeed_sgpio_types[]'=0A=
array, removing the need for separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/gpio/aspeed_sgpio.c | 37 ++++++++++++++++---------------------=0A=
 1 file changed, 16 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c=0A=
index 0c53b03464..7d2f736995 100644=0A=
--- a/hw/gpio/aspeed_sgpio.c=0A=
+++ b/hw/gpio/aspeed_sgpio.c=0A=
@@ -321,26 +321,21 @@ static void aspeed_sgpio_2700_class_init(ObjectClass =
*klass, const void *data)=0A=
     agc->reg_ops =3D &aspeed_sgpio_2700_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_sgpio_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_SGPIO,=0A=
-    .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size  =3D sizeof(AspeedSGPIOState),=0A=
-    .class_size     =3D sizeof(AspeedSGPIOClass),=0A=
-    .class_init     =3D aspeed_sgpio_class_init,=0A=
-    .abstract       =3D true,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_sgpio_ast2700_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_SGPIO "-ast2700",=0A=
-    .parent         =3D TYPE_ASPEED_SGPIO,=0A=
-    .class_init     =3D aspeed_sgpio_2700_class_init,=0A=
-    .instance_init  =3D aspeed_sgpio_init,=0A=
+static const TypeInfo aspeed_sgpio_types[] =3D {=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_SGPIO,=0A=
+        .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size  =3D sizeof(AspeedSGPIOState),=0A=
+        .class_size     =3D sizeof(AspeedSGPIOClass),=0A=
+        .class_init     =3D aspeed_sgpio_class_init,=0A=
+        .abstract       =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_SGPIO "-ast2700",=0A=
+        .parent         =3D TYPE_ASPEED_SGPIO,=0A=
+        .class_init     =3D aspeed_sgpio_2700_class_init,=0A=
+        .instance_init  =3D aspeed_sgpio_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_sgpio_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_sgpio_info);=0A=
-    type_register_static(&aspeed_sgpio_ast2700_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_sgpio_register_types);=0A=
+DEFINE_TYPES(aspeed_sgpio_types)=0A=
-- =0A=
2.43.0=0A=

