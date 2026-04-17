Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5707CF8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtY-0002Yt-CA; Thu, 16 Apr 2026 23:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtK-0002P5-7Y; Thu, 16 Apr 2026 23:29:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtI-0005oG-Hi; Thu, 16 Apr 2026 23:29:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCzjSWUNtIK2Z+Hrxvql4B1ySpJsuTDe+3k65k0x23CObIvo1+CT2bRLsF/2x9nA81jniukZDewujlFm2zzGhHrBVR5O0sntI9xbSAJIzF0EafOjRBJB2U1QRiyz9PFcgKBRqRGAt0uDkvpxKq/AAV2bT47GpeZmYKlEuRvN1szYCtM8AwJmBJTtX1+CwvnzQ0xXq91iGlL0KoKG60qLO5GOHLqbIS88EioDTmNURjMtmPfMTB7ToZHys+SELlC56unNIklEliEugufE5txHZDeQIQHQ/zTm0oyO/FQz6zGZj3xBqQdtfbzr8DFk1Rq5AWYD5+gze+H/LqXufEAgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wdn49wxih/GxlQRPCZsSv0ZU4aHVolZYhvwrQewYITs=;
 b=Up0E0Kpc8/zxMzTGrcb1dAOPNmxNhgdg3StXvROq/+2gsG7h+SQkYZpqaONJIUWhGYIfzVSG8HtGr8M/um73R3GImC1YXKO1ur0fr/3FcIXbv2fyXcEEoXoy0K2Xj0oZslN1qsKsSmd4vx9lU3bpE+0iqNfKzh490uoLeGo+q1llNnFoOmHnW7DV+4n6s2ljum/g4oM2PaVSFyuO76swsnc1G5yeWUmnwS/qpXDpFlu0S+FxEJM/bGmQMCmzQ78+fe0Q7OOc4iUY3mRu0+iDQMNAsGtzOEcOR4lJJXzAv0XuRlKGZaM5k8/Muits+2UczpImYFB5xeJq9ZW1klVufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdn49wxih/GxlQRPCZsSv0ZU4aHVolZYhvwrQewYITs=;
 b=lDfG6Xq9Tay7J5XBdLULmXLsGjMEGZrvfE5zyyUCE7tDAXpFjDHwBUaLzu9vxBPa660H/qC3i2n/o2QKtU4e/ucy5lphoYWICFX60GvLfabpEnFxG1qAc8Z+YjeKnya/x5AXGjL8XhproQFbTFJzrVZpHGUa1rP44b3+pxAxi0ggEgvczPLQUwTgZ66OuYAgYuZJ/BB9fdyqG8RAlnLP/IGcQT1vOKYIXxB5bCspBs3YlIlN00fKwB6nxurpAUQG/q0vn9KUWOdB0cWtwrjvGeQ5E8qluOvZEuEYZ+P2fHBd+mcJT79NSaIra8eJXSktckBQOtjQvC2l2BN/13cfmA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:57 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 14/21] hw/block/m25p80: Implement volatile status register
 write enable for Winbond
Thread-Topic: [PATCH v4 14/21] hw/block/m25p80: Implement volatile status
 register write enable for Winbond
Thread-Index: AQHczhpT9wtBbTDpD0ylh+liRbo2Cw==
Date: Fri, 17 Apr 2026 03:28:57 +0000
Message-ID: <20260417032837.2664122-15-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 3a34299c-5297-4b2b-cdd9-08de9c31759b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8/r4B8kwKyYbi7STmS4cywDxC7AIDChQ8r12NWcukwEm6oAfB1ZMR+9d5aXTeavxTFQSXFY8FvE6Tzavn/SE6MvVelaT/YzdjKKMFWThmiX0JBNNGZI4ksRDBuX4EW4STQriMhrA199o8ww90etrbngQieZ/jh3lhlR27x85tGZpfoX1SO42/E2qZ4uPrswEh3Pw8NRU0u+vkSZam3tiY4yMUo0ttIIovCwvFDI4DORjXub4We5Iw/Gqzmh59sFw0ol6+tgUgqKyRiGSIMFi0hBFvvyrGIce9xfkHTgCjN3VdXq6/blaOk9OL4EVR8hpLqBF3CsGcSdol0lDEldk3g3yW/vSbAZXgkxTPmr01MhXUUD+18rTb70zS9Ykwn9YUv4lNTNSV+bnGEg/dGHeegvZDFf+pRauzvQT+ziaVgqIvpOO5klQDJ2RqMmppNXxMipG7ojq916DTE6MVE0KiCKw7pTLn+2nVndUnR3aihKFv3SCyrx9qjqyJWkdWXNSxiPQ+zDlmpq1iMjGqaMuQe1Q5fvHjY/xaIVMd8m/227ulGhDkxyQMatArkNT0qMEiJk5FSXxumz9LQpvAdGMAHYP46DZqW4Shbs9TGqAn+2Wgr8Z5y7hdmnpJLPPK6VQoGJ2AfAbsFYIeV4yS4trVsIo4Tof0fxtZ4knQM4RvwzQFVaQm3FkEIx/8DEFXqP3vX3qp1LQQFM6LRGXUwHCN7mqhMnp0McqRCfd/E4z/aSBtddpINF7kZM0A8uReTDPX6JVT/Wuj0fszyXk1IA8ZJJ/AW5gXbimJh84ld0YcD3efzaYEYI55478l/xXuqSP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XEPFZGbJTGJcGLgQR5zRfF2no6H5tB1c4dy5t8s5SSzlt4LSQ7LHM2oNU/?=
 =?iso-8859-1?Q?hq/EL8yo4MOZmgxMKjdVIwGd4wEjwehCSNWHQqDxO4qBROpr7HGPiQ6hyX?=
 =?iso-8859-1?Q?oL0q9lY2fDZDl7ZEJKYk5z8YJ9UIQiOKCWd/Lm8inlsRJmIL+H3S9ipQJe?=
 =?iso-8859-1?Q?KDREe1oEXlqa2F8kxlTng5VKGwdkzBCTj6SYNrSJUEBsJYiutquNJmvtli?=
 =?iso-8859-1?Q?U/ZsicE35HNrzvkerzvdoEbQ8kK8QpOV9+6DDRmjLE4yvkCpZvUznjWPWY?=
 =?iso-8859-1?Q?ueXzKQ8pr43YcHgX3N7IwuUoyVcsog/qUgqwZr3JWaTQp+UfsLhqKTSWXH?=
 =?iso-8859-1?Q?WIOPVlxHSf4uAQ8z0/Ur5wy0s9/IKjwv9HxblRu/EEP4Ga8dZlaKkt8sRr?=
 =?iso-8859-1?Q?lT4rRSMp9MaUBgP0SoNq2++eiXBMWRdtiG389jxHA7J7KWYXZeEmKyewKy?=
 =?iso-8859-1?Q?uieRkYG9N2wdscz1M3qw7PzJutvl/pvqQ0pjGqVYTEgmW+RlRNJrNZ+BYs?=
 =?iso-8859-1?Q?KPz1hQsM+3vYXpCf/z5PSVLhd+KnPyFb4uz8lvQYNBBPL+nwF1VcPtqHpk?=
 =?iso-8859-1?Q?R0docJWHdY54rb7z2+6+RwlYbCgla8HcJXcDFwDaAVn3HKamyQiRJJbSVo?=
 =?iso-8859-1?Q?4ZHJ4sIkHU4avCEaVyv6qdriDmdh7PQRF07gOJWd0PSBYvACivnEulgQd2?=
 =?iso-8859-1?Q?slhsMfPAyaAjSYnzxINL9n6ORKXbIyGiVH04ZbNXwWi9DSHzi8IgJ7YdDq?=
 =?iso-8859-1?Q?KBwFmw9YFcQjfXBKbgVHUMU8ywBGo5jU0PWBVFxqTAsrwSoGNDzQcFDgqx?=
 =?iso-8859-1?Q?eK+SMeuzK/Q0EahnFO1zRyVX9kJn/m9J9NvBlxWBH/4DVScq9Un1CxhPWJ?=
 =?iso-8859-1?Q?gwXVmGNxtaDTDAHnWJgfLlU72c9PmexNbhzUB6q8Ly7I0fvIsdYo6+DJRs?=
 =?iso-8859-1?Q?0IPjnzCODsUOjv3WYn3JO2qVQs5Fh82Cv6q83LOpFhL16hhFUkQrL7YLkN?=
 =?iso-8859-1?Q?dNrWIt8ENsQswgTspu0mgcruRzhKsG0I7jLhkvxez+QRTTUAohB6tEkxdb?=
 =?iso-8859-1?Q?BMRyoIbxcQDO3GKRuAVvg2DFkJsFZfFsC5LoykpPKMZbvJGkt80S5Urrfg?=
 =?iso-8859-1?Q?lXT6q5hgFY7VTwuYb0d50yXwVMwU5ZeOli7Fsvg8rXmLbgqT8tz4tNDoEJ?=
 =?iso-8859-1?Q?X6biR/YgHUKSt3WZgTg3Z5VoqpWFrUSXgTuhedeSLptEHeNIfXHQeOqSWs?=
 =?iso-8859-1?Q?0dPvdvwK4tju2RirNbwrOY+0umvFlaHEJx8xP+tw/QJk6+jTYkMofbfy4Z?=
 =?iso-8859-1?Q?n0b7jBEFXNNj1cKWjQaepC8QflemadE3KbEGlQtJxw5gHMH83zthuhEsMK?=
 =?iso-8859-1?Q?T35928JcHq6dMTMkRhuuRBGvxHXamVjPdwQ9dtjLPrJulaQNUCWGmhgOXv?=
 =?iso-8859-1?Q?C7uUlFOrzRnmliqHHbDMb5ekjhnT67zwAG5laGKSEr6m+BY5Xmr8f4k+U5?=
 =?iso-8859-1?Q?iHqNgbUJJTfIFMutnkMTcrSg/XK99yLZlFfPZq8rg5PIEsxma6TCXuXJHg?=
 =?iso-8859-1?Q?J3hmF9USqx0hgCKA7zOG7KHYDh/jSDoUCmBpuRK34bQPUqD8YYmwJjxDkL?=
 =?iso-8859-1?Q?Z2Vbnxpl0huVoD+FP0ba7VAfva7mUyEZeWp3/M1IeRIEdqzUSSaoD4n4li?=
 =?iso-8859-1?Q?72Ts25T28+Gd0p4FnC3jS2mPZrVgG54ObpFCu5H8XMgCXQuvl73DS4Oi4q?=
 =?iso-8859-1?Q?0VSMUSjAqZfhwDjVf05vvxuGg9gzqzavC71sEmh6m0uuFdrDbY/eZUUC24?=
 =?iso-8859-1?Q?pTid2pgIZg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c1vBfhesbAgO/jPeh7n6RYJRalhdbXcUxZ4F8YHakTIEyqYgzNkGJyZfpd6AJrKtPGzISMXgZSuFJ9OQ3TouAvXCOB0+Do1sotJKECG8DTPLk26zNAdHyrXhH3WLqE52MnNhz+RaXYW5zfi1aYB2Pf7Vr4gkdhBr8kOQy+cW495W81ygRompjAd9aer8ARn+9RhKHUa4MwU2u1GDE6vFwAjrcuQ2WxW6On0w7dGGrKJLr0En7//1njTE/NwbU89XczS8JvYOLcKsstvHO39q+peE9IcmqYVy5vYI2HahSTG/kWdU0nztM7fGd1c0JMVUIFXpSCVq7F1Sf94jZZiSQA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a34299c-5297-4b2b-cdd9-08de9c31759b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:57.3111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRJTjF5zs06hGXEN6/qj9vrambC7wqE+1ebJUPBTXt0sbhsBDXAIYias7PD81oH+GWzMyXshTb5L2F0GXJug6f4TK3DTfgjbx8eoSIVzf4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Winbond SPI NOR flashes require the Volatile Status Register Write Enable=
=0A=
(VSR WREN, opcode 0x50) command to be issued before updating volatile=0A=
status register bits, such as those accessed via the WRSR2 command.=0A=
=0A=
Currently, WRSR2 handling only checks the standard write enable latch,=0A=
which does not fully model Winbond hardware behavior.=0A=
=0A=
Add support for the volatile write enable mechanism by introducing a=0A=
separate volatile_write_enable flag. For Winbond devices, WRSR2 writes=0A=
that update volatile status register bits are gated by the VSR WREN=0A=
command. If the volatile write enable latch is not set, such writes are=0A=
rejected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/block/m25p80.c | 36 ++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 32 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c=0A=
index b8a2543c0b..5bb8b8efa9 100644=0A=
--- a/hw/block/m25p80.c=0A=
+++ b/hw/block/m25p80.c=0A=
@@ -438,6 +438,11 @@ typedef enum {=0A=
      */=0A=
     WRSR2 =3D 0x31,=0A=
 =0A=
+    /*=0A=
+     * Winbond: 0x50 - Write Enable for Volatile Status Register=0A=
+     */=0A=
+    VSR_WREN =3D 0x50,=0A=
+=0A=
     RNVCR =3D 0xB5,=0A=
     WNVCR =3D 0xB1,=0A=
 =0A=
@@ -510,6 +515,7 @@ struct Flash {=0A=
     uint8_t spansion_cr4v;=0A=
     bool wp_level;=0A=
     bool write_enable;=0A=
+    bool volatile_write_enable;=0A=
     bool four_bytes_address_mode;=0A=
     bool reset_enable;=0A=
     bool quad_enable;=0A=
@@ -897,6 +903,7 @@ static void reset_memory(Flash *s)=0A=
     s->pos =3D 0;=0A=
     s->state =3D STATE_IDLE;=0A=
     s->write_enable =3D false;=0A=
+    s->volatile_write_enable =3D false;=0A=
     s->reset_enable =3D false;=0A=
     s->quad_enable =3D false;=0A=
     s->aai_enable =3D false;=0A=
@@ -1305,8 +1312,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
          * combinations of the two states are called "software protected m=
ode"=0A=
          * (SPM), and status register writes are permitted.=0A=
          */=0A=
-        if ((s->wp_level =3D=3D 0 && s->status_register_write_disabled)=0A=
-            || !s->write_enable) {=0A=
+        if (s->wp_level =3D=3D 0 && s->status_register_write_disabled) {=
=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
                           "M25P80: Status register 2 write is disabled!\n"=
);=0A=
             break;=0A=
@@ -1314,6 +1320,17 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
 =0A=
         switch (get_man(s)) {=0A=
         case MAN_WINBOND:=0A=
+            /*=0A=
+             * Winbond requires VSR WREN (0x50) prior to updating volatile=
=0A=
+             * status register bits. VSR WREN does not set WEL.=0A=
+             *=0A=
+             * Accept either standard WEL (0x06) or VSR WREN (0x50).=0A=
+             */=0A=
+            if (!s->write_enable && !s->volatile_write_enable) {=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "M25P80: Status register 2 write is disabled=
!\n");=0A=
+                break;=0A=
+            }=0A=
             s->needed_bytes =3D 1;=0A=
             s->state =3D STATE_COLLECTING_DATA;=0A=
             s->pos =3D 0;=0A=
@@ -1332,6 +1349,16 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
         s->write_enable =3D true;=0A=
         break;=0A=
 =0A=
+    case VSR_WREN:=0A=
+        switch (get_man(s)) {=0A=
+        case MAN_WINBOND:=0A=
+            s->volatile_write_enable =3D true;=0A=
+            break;=0A=
+        default:=0A=
+            break;=0A=
+        }=0A=
+        break;=0A=
+=0A=
     case RDSR:=0A=
         s->data[0] =3D (!!s->write_enable) << 1;=0A=
         s->data[0] |=3D (!!s->status_register_write_disabled) << 7;=0A=
@@ -1824,8 +1851,8 @@ static const VMStateDescription vmstate_m25p80_block_=
protect =3D {=0A=
 =0A=
 static const VMStateDescription vmstate_m25p80 =3D {=0A=
     .name =3D "m25p80",=0A=
-    .version_id =3D 0,=0A=
-    .minimum_version_id =3D 0,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
     .pre_save =3D m25p80_pre_save,=0A=
     .pre_load =3D m25p80_pre_load,=0A=
     .fields =3D (const VMStateField[]) {=0A=
@@ -1837,6 +1864,7 @@ static const VMStateDescription vmstate_m25p80 =3D {=
=0A=
         VMSTATE_UINT8(cmd_in_progress, Flash),=0A=
         VMSTATE_UINT32(cur_addr, Flash),=0A=
         VMSTATE_BOOL(write_enable, Flash),=0A=
+        VMSTATE_BOOL(volatile_write_enable, Flash),=0A=
         VMSTATE_BOOL(reset_enable, Flash),=0A=
         VMSTATE_UINT8(ear, Flash),=0A=
         VMSTATE_BOOL(four_bytes_address_mode, Flash),=0A=
-- =0A=
2.43.0=0A=

