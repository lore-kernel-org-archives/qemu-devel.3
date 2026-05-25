Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D94CD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN96-0001ug-1x; Mon, 25 May 2026 00:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8p-0001lN-3d; Mon, 25 May 2026 00:42:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8n-0001K9-IM; Mon, 25 May 2026 00:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9EZCrO2TVsOsTI/3JVp0VjeqGwnkKIb8+Uw/BT24V3PeQfSJsqT7t17MeAopJ8d9UpLu0Uwe4uPTC3OOfoHjqSnjVizdF1Pmv3SPuCfpYDzI9l/1a5s4CkfuBBT16itNzTz2MK/sYtwqNTfFmnLuU4rrOXI4CAfoOrA0ChVjGXPyQ4m3lWYz2jB1RxhfrLJVN5+fnKn+BV0zu9IjZ6cYMou5Ampin6ZCmsTXJy8FUNA62D9dsyH7oj3f+xMx/5HyOKkm8V8CoSoMn+fDs0hUrZvW7JUu27f2ktVJ1v0yFPWQV1/LKVeMxsJhr1OBz3Fg65QbQ681vF55Rb1w33FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anFV0w+zxvgfMPYk4uL8tkCNtUEgLVIVY1tJw676CNU=;
 b=M61Z7ittldkZAfP0rUkmdDOL1h0Vytvymoy5hFEZWQHTNxZ9EbDXfUjmvgrfV1n7oaTKUmE/sCWHNP+qfcqIkHZp+rfRWwo3hNKsd/tBaDzSF6X/z24ES34lWC685Dk+Ms8rWkeOuyzU1jlWdWLt9kO4qWloip7dSeYufgyDO7/QHjQTbqjdVASAKpuLs+Kxl9Q83btg6uYg8t2k/vCdvRBLYZDszfSxT+sEXAY2tz2D3hdlWJT1bMWL9iNIbK6njBU+EIMnvdIvRUzudZfvjh1iXQgDEeR3PlsvR87r4CWqqzsTitUGb+gtUBBLSxG2dwoKnZ5jAi3bSm1pkU8cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anFV0w+zxvgfMPYk4uL8tkCNtUEgLVIVY1tJw676CNU=;
 b=K2Q8eTn3RYmNZrBrGpamWaeOmD21IGPo14RtOOpSS3ETxgvsANJ68HN4lFc90wqL0wIgN5Uidiu6ypStcPiABfdWkODQMz1okH6d6lE7b93ZDNcSk9Uw7/U85JqgCKLUeBlKz7FxtNVnIU35u0dIoWN+Uu9jxNbnxvTZ9IZn/kyyPnagDa1kD7+nrT341H3rKzUbUamPbNp6Di6Sk9zYKE+uYL+0mCrUP2OLcDpimBhSd4fi0mRkJT8iTzLLwYC+fM39zEzKGp2RJUFLkZFd3EK8N3sr48O9lCkV1XuaSr9tPkkGpasrS0mamnwXi9Fu/n02a7FN6yBmBFUyM4BY7w==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 04:42:04 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:42:04 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 23/23] hw/i2c/aspeed_i2c: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 23/23] hw/i2c/aspeed_i2c: convert to use Resettable
 interface
Thread-Index: AQHc7ADVTvsbpu+w4ESIUMf6PMvf8g==
Date: Mon, 25 May 2026 04:42:03 +0000
Message-ID: <20260525044129.3133916-24-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: cb5a348b-6d4c-4625-1777-08deba17f7ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 7DBYomyojLjGxqixRHZCNLHtGdSGMJ9Y5zIW5s2SeKoPMb/MoKsK44VH+vuE1ES3LyLPM77ZpfnthjSW0SmhF04Oa2kzY3gY1Rqgh+Wu6bUzClXmD3KHpAuVtpAay5BOlBlrd2gN2FU5h/XkQK729PxTYHRbUSehl4V7OTZkEYlLQG9DB81zFkb8DXtvIfp6iOIIeW4B+d7psb0vfTDi/GI5tkFNVxpEbk8BHo5Xm2fuLyTiZG2z1bbx5MGOPMtq/iX0pKJOaSECjR3/plpFuXOAlcldbt4esv6tijFC2BCbChes1BF22ajml+cm6qTPmEHL82pHT9eO8mj78IGybGbhRo5mDCS57/KaoQenUhQuF3hBH6GMHqWoVJGEKQLIzzj4J8SRmW9Gh7qS7rAmIb28zViqh+M/nvL0vKes3L3PXW3b84XevR+iEvyVQsLrJDMFvf05148WZVPSnU9o1DvO58lbezfIW1Y33g5vhJF+p5ITaBopiH/+AWA0CzqXBGrGxndWNsilLwaoLOfiBx0GOb7mbY4lNWXP+eJyCv/mPhvoICTaWIT3cHajeJHZnyU2LvBB2TdwKH8lgmVeU8Oi3rQX1LXZ+vnOwpOvv/ZK42uIngq9N4Kt6pm9iZKzmYh+gH/B15/4cbWCBq7o/0Qtzzlwvkw7uwpJtvQD//+3k1dttpViWeEWUhhDgpdZLXv8FVKtcWLMK9FskeugDkmyq64a+C1hxm2II4b/RI/4gVp49sxOvnvwhtqj/akPbCkETYo3OUzS4kxW7laZ4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ml/UazD+zIeMYZT1os8LI3H43MJtE1CX+TgoyjZBjUJq9K1Ua5K+qagDt/?=
 =?iso-8859-1?Q?GI7ypBUplz4lgFfwnVOKmS6NvlV0qDM+GSsCUDW23kLTY4Iq6q6JDGuuE1?=
 =?iso-8859-1?Q?P/kTd5jIwLcGOYi+gh+6uuyJb0aRHtmHq4nOTguhfTKjSQEj0fj2eGRdPm?=
 =?iso-8859-1?Q?u3Wiz4GtWIrkIswmOwqpuML6esaH5VfgXDnEU3/b3cguSts+5QSAHQF2da?=
 =?iso-8859-1?Q?WvFohgmy2pH96U/0RzWPtNH1VW6DmLGoxfTm5qRFg5Cfvw7W7uyBFd1Zg2?=
 =?iso-8859-1?Q?N1fFYZ9VGvKHRaiwpD+Jvlexgqa3NgsTmc8DC/sWVLKtmT9MWxtojjna6j?=
 =?iso-8859-1?Q?p/WuFRxj4wmGDqm6NC+y5PxJY+qBun41QNr9pdOqmK2vqBv/6gibOpW+HJ?=
 =?iso-8859-1?Q?CD4SYw5+hOly1nZVZ97ZFyirIIqT/7gwlkeIHstIQ4WwVQOIQviqJDSc3+?=
 =?iso-8859-1?Q?j3xicjQ+qAkGHr4VNPM6hJ9POusQEhyK/nZEen8TCjTkS5rWuelVPlBc83?=
 =?iso-8859-1?Q?ZRClKJLJ966uRdstV8HCdBA6pUzLFpXD18887Izazbo30NiSW0ADXN4gfM?=
 =?iso-8859-1?Q?Jd1sSgV65GPYUwddx8+a2/ZyXTclcs/kPrXbWPeLD+xvWV8tdG2FgRpUAv?=
 =?iso-8859-1?Q?eefGMKcNzZBwBXVLdn1om3aXr41rg8njbym6oEU7ufg2oI9epaSb2/b4OQ?=
 =?iso-8859-1?Q?IgDXk5BscFtchrHM5M22AlwxAeFI4cSSfiZ8ONsXCG7BKkLSFgh9168QPX?=
 =?iso-8859-1?Q?O5nPsdjabv1l//NR4wW2Xf6Hg7QFn4z+62u8Q/5RfaLT8d0vzU53lu3eWb?=
 =?iso-8859-1?Q?wXtwoDzsHgDfIG9oW3Z8t5jKWvv9nrSg2d7B9VceJB1dDKX9SJvD19InlF?=
 =?iso-8859-1?Q?2VjCKd7vT6PiUR7nNkJ0dFto2YE7yTaA+zLZ+8XooitvJ/NLYmj7i1S5Ei?=
 =?iso-8859-1?Q?AvoL0Ghdacue2PTYXp0IInzxR0Mqg2NhLMcJdDnUp6a3mqoAQ6082sbBhM?=
 =?iso-8859-1?Q?mCnIiU/2S3tPWeEkmnVtiaheE+IMvHh+aA3wv0xXHTtyIuBXgnMW/SORx0?=
 =?iso-8859-1?Q?ti0za3hpOz5RgGJ//GCHLqdYY6Ook8wC5gxpCVO+TfkzY9ToiHcw+20Tdb?=
 =?iso-8859-1?Q?8ydaCdWZmupMV8X36PEArHflhmdQRAy1KfknbA6kOYcEsRmgprZ0bVak1J?=
 =?iso-8859-1?Q?FreIZhoBXLSsbteQwYNmyWdu3GaE9t6TfJkYRNdRF2unvRMYmzkeGfPALG?=
 =?iso-8859-1?Q?UJot2k/yAVokGZ4kJxBB8Y4IPFzSksZh2UFsGO7kFhkWWmmpZf6Ioe3RaB?=
 =?iso-8859-1?Q?Zz/9auAU61cdSbwwBw3nfUX3hs+5rOnK8wldqZ28n1x9aj2CfFgs2HcR+B?=
 =?iso-8859-1?Q?OFwyLJQwJfm48okAC4oZIrRxYoNLBs2KD9gFqdBZi8rufYYdV90iWq9Sj0?=
 =?iso-8859-1?Q?SWEfcfPGW9295FFQusmHDjk54v2z3lDjGNqNn7jERF8aSfIM3wL4LdhqYv?=
 =?iso-8859-1?Q?8Gtk6WQzSzRub2NK2dndtiUaJLgnVGTjQGcqEx6vgWscEYkeFMYmoBfagh?=
 =?iso-8859-1?Q?wD2Gd7qUYwWsql4dJ4r1pg6UGfoygM4WyJNMy9ZQl8sBlnWC98iPmZz68l?=
 =?iso-8859-1?Q?OVrJdn1H0vRgVQNNVc8d0JFQ9f3EacFQtpbG9ejbgxK5NYrdU7Pbk+vXRV?=
 =?iso-8859-1?Q?km48PDaP9khKAafrE+BL4qW4iZmIRR3GuoKe0Ocr4Fs1I91cpxQD6PBcPR?=
 =?iso-8859-1?Q?1siryjhYFdQZ5CuIUsSiivs3wq61UolxNF4gMcXUTGKIom7JzTycIu58jX?=
 =?iso-8859-1?Q?AbEC+1wavw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oJiD09xHs/389sOMywRNWebLO/lb+bMwhamErarHIk2dCPFaLqdtFxLLafTEonXX5MvkfmqjDwrp/QMpiRetRDbVnbtCRblyxDbNuzWV8ztHPA5eaChiQ183Tw7ufeNrzPun8bqOLuFrKodx6Z9o/P0JQS8nPyX+djfxyJdcVzFLRNtiYwQGdvbjB4TED9aXSOrJ5FeBRen4gzpMtFIrBVtJqAWBObWCdNgZYD5qvQAQ+z7R8fLo1ulIKjPeSuZbie8d9pjXIVursuASLQvohpAxyO3HvijhcV30I98WVSWZh8nYXPOoFEAWArdlee/K4PLb/5YzW4mHaKTv/s6jsA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a348b-6d4c-4625-1777-08deba17f7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:42:03.7446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyNX8h7dy/vLTgZH4BXSnNNRbNYrf6nxXoB64o58nIq0m6/oT8D0g7IWWJ6eKHaXxw71tIthpHTIHcHm2JrKmSGCZ9XTVCGixM08QPu+DF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c | 14 ++++++++------=0A=
 1 file changed, 8 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 90f83a03fd..80c4457500 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1160,9 +1160,9 @@ static const VMStateDescription aspeed_i2c_vmstate =
=3D {=0A=
     }=0A=
 };=0A=
 =0A=
-static void aspeed_i2c_reset(DeviceState *dev)=0A=
+static void aspeed_i2c_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedI2CState *s =3D ASPEED_I2C(dev);=0A=
+    AspeedI2CState *s =3D ASPEED_I2C(obj);=0A=
 =0A=
     s->intr_status =3D 0;=0A=
 }=0A=
@@ -1363,9 +1363,10 @@ static const Property aspeed_i2c_properties[] =3D {=
=0A=
 static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->vmsd =3D &aspeed_i2c_vmstate;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i2c_reset);=0A=
+    rc->phases.hold =3D aspeed_i2c_reset_hold;=0A=
     device_class_set_props(dc, aspeed_i2c_properties);=0A=
     dc->realize =3D aspeed_i2c_realize;=0A=
     dc->desc =3D "Aspeed I2C Controller";=0A=
@@ -1506,9 +1507,9 @@ static const TypeInfo aspeed_i2c_bus_slave_info =3D {=
=0A=
     .class_init     =3D aspeed_i2c_bus_slave_class_init,=0A=
 };=0A=
 =0A=
-static void aspeed_i2c_bus_reset(DeviceState *dev)=0A=
+static void aspeed_i2c_bus_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);=0A=
+    AspeedI2CBus *s =3D ASPEED_I2C_BUS(obj);=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
     s->pending_intr_sts =3D 0;=0A=
@@ -1556,10 +1557,11 @@ static const Property aspeed_i2c_bus_properties[] =
=3D {=0A=
 static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *data=
)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "Aspeed I2C Bus";=0A=
     dc->realize =3D aspeed_i2c_bus_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i2c_bus_reset);=0A=
+    rc->phases.hold =3D aspeed_i2c_bus_reset_hold;=0A=
     device_class_set_props(dc, aspeed_i2c_bus_properties);=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

