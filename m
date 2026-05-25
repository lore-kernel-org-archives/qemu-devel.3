Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58499CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8p-0001lS-G7; Mon, 25 May 2026 00:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8Y-0001gS-5r; Mon, 25 May 2026 00:41:59 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8U-0001Gh-Or; Mon, 25 May 2026 00:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkM+0xMEwHFHnfmE4SPm/M9pI6bGBwYzzUo6wojXp8X/MIq1UUpRC5ZfqLYh9Ydj3/Dq3YO+AKSD1lHOM3oe3Hxdr+GXvY0xRDXJxAMBTr2Juu/77BwkyBLg6z0vNOcBF115VQbmOFdmmrLBJD4w+ouB4isn0PhGwDBF/Q191bp7CnuRVslFxSbCuW2RvxAkeToBK5r3XXzMhvWYkHEm0flg7861hRu/Vwp9Ts/0Xd8mlYXqKEPrGzc5Z5YCoPkXRBHxxwc/vyX+AmYE9HH97DfDkQ1Hh9TwBjAR86IwVhrQ1QnA2tWUROa3BPVswh1RNZzh3A271FHNGTBxpMJFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m39CiX2XtzBlTGBxERtCaA13oD1n3ZygaY6tOKd4Zk=;
 b=XHoAViPMtKWdoqRMXdiEQGXKXRM7EfRZj8MwzScBGeiaJNHZqwgnlUadPVyVF4FB3FrdXGj+jZICECshH7KdIRfY0OSPIj02jrJhfxEiD25+VwaDG+DEjbEmhgH7QikPX2wYrJcVdNJwdwKAWPNdJ8xThmzSBBXRI8iOd34ACBmNfQoizkw7vNF1F3Qa7sB3TZTid5ioHQY0H13lwwnW9p685kd6qD33mVEmQHnfOWMHI2hVPuvqzpHu14A+WUBLLzqV/Uvg5NHFfri4XhvRPA+0gfJsczF1Wk0tWrd76yt1RGTK9R5s63Tqgr5Upc9OFmPIbTMn3sZD1vAUMNmWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m39CiX2XtzBlTGBxERtCaA13oD1n3ZygaY6tOKd4Zk=;
 b=Omd1LTBBnDHGAC03nm6pzU6QMXyEOoLQCoxS7tDiKfqSeYYbLlo5V3bECbDsRqMEK4VPWYEfzef6WrU4c21tX5ViQgDckFIopNHoJv5senrHGYSdl/qawre1ilicTrpWvNUL3E67ihWIEkncMbBF+GmPQdg72TnNmDQtgIpnSIxug+UvUGHsyYskMWzJ154xtaBS7yM86cExgNE0MpQ031Sjb8PSrYUT3m8NrcOfBHkYFBCQB6T1L3OzPaCWb6mqcuAoWYympJKfo06NmMDhO84yKtm9JvYJV76Pq47WYVoWngdhBO2Dp8a9SqkWooemwG89ARHKePscPzzSkvYEoQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6593.apcprd06.prod.outlook.com (2603:1096:400:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:48 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:48 +0000
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
Subject: [PATCH v1 12/23] hw/gpio/aspeed_gpio: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 12/23] hw/gpio/aspeed_gpio: convert to use Resettable
 interface
Thread-Index: AQHc7ADMxtRntt1l60OFEgEobX4M4w==
Date: Mon, 25 May 2026 04:41:48 +0000
Message-ID: <20260525044129.3133916-13-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6593:EE_
x-ms-office365-filtering-correlation-id: df0d1c89-3908-4c3b-b1c8-08deba17eeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: m6O4avmgHNMzcJvGXMObuajsKm5O9ExO8eg0qINpiodptpero6Xi1oYJ+RCc95wShjHNsy/jFhPDj62MFKs18fBR2w+j8uaVqE14Reg3M4u7mCY0kdIUsNDhebCZHpUinWUFagCwphsTVg7PWUwP6yQUwdhurYTB/A63tpkpIuH2y+rk1DuNCdfqYfHDFHBsim221E0tBBAuB0/bMFzFKFQtwaBITrtaSjeqDeNZSOAwkhxxPU3TrIsR2Ujy3+98J6I+itMVlbp+1eIHO6bxp7GESQYppOgD8ATERu3rY+ogNNvaC6i/TNIyW3wwfpqzw/0KA1C6yIGrmL3QIboCbfpDdceqLczTIq1L2PHlHRFl9Qcoh7ziMm+FldrFgv9JkXIHgATTqoaCsNdIJHcvJVxsMIPqijdvJLwbJC8PFjQjdnruC+Hi1Lgzej2ClIqiRIN5O73P973+I83CC2ki6/lXuYgw4MhdCwETJmHVfwIWwPCKJk2iorIlRJl5X90pBc3gAxNQZHYieIe013VzrK7WVi/sSHNKqhVPkJTbLPmQg9Ghoi+jaF5EVLMN8PBFW8wkRvhJEG/hHD1QL8OEBxh/CWtZxB+CQ+sUYCUHwQ0cbMA3MvX2xwxYN9r1S6/3uYTpLbl1Cp1jQLL8WSw0WnKsUFvOQcsjyU50fSo92DMZfUQ1NmP7PLJLpt2e7Ya8mT8/9keb7kA7arEdjDG2S7kcWwd3kG81UeJ8imA+ZLaeS9EXadkwLZKsY3b8gMqgSiWye2cH4twTHVZbUcuW4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KbKSVyvo72rW6G/MqQjiE5/MiufNVXwFeMzZDfyT+4Wa2E18VC5GCIj8M0?=
 =?iso-8859-1?Q?Ec/AuGJfhrwOiZNdWp95lS9P4Xmxa4/KqB6m75Y3qfroXE35yclRJOKgJi?=
 =?iso-8859-1?Q?pVjI6J6XQOoV6llgo85IgsQiYSOzNo06oHVBQa/Rr90ZhABrTTK0cPFc6l?=
 =?iso-8859-1?Q?NOdWidVNAtVNgtKD3z8RJheIv6SuTOJw0VP4IWVMHfa3gv5xNQKTbosuOW?=
 =?iso-8859-1?Q?hPRvCdAX2enxgBW+MqmoswnYN728W73hmLQ4lZO/BGOPwkZ0S7P7GeRupO?=
 =?iso-8859-1?Q?6v5bO0z7KSj0GgSEWEGeZ0GN24JQQIDt8PoXAgzI4tmzunPR+CZDDW5DRU?=
 =?iso-8859-1?Q?CPB42CgvZFaTZohlRlx27kOfd5UFPicwaAKHmDQwuiGqlRsjLDt62Sntjh?=
 =?iso-8859-1?Q?ExxWUZzKRKqmcohvpuPqnC5Tq66LClFgMtnqFaj5hICqYjKGIulVwT5IIP?=
 =?iso-8859-1?Q?MTzM/Z47wQEB0d5tii+ljcKbI6CWrrc6t+irfBHt7XD+Q15b2AU9jfHxwp?=
 =?iso-8859-1?Q?fEaqVfxe+6FKs7qlhScXxKLgW2wgppRb2xPviWTEXlo6cEjPQSGUkUJ6HW?=
 =?iso-8859-1?Q?EqrzwEiuXzdVhNNYx8GVZRd6xpnVCG8Ngtnd2SLWIg/1p028SotO3NHKqT?=
 =?iso-8859-1?Q?ZRQzAdxVeLCWBTUnZrrKw8Pz/jEqmj8iUBG8VLAZLMTaUiYjdYCo4gKJQO?=
 =?iso-8859-1?Q?QPfX7ApJMvjD0FHEzjT6kxI7zsjcBu/E7vz2eRSNC3evY+8GIGrjZqDycC?=
 =?iso-8859-1?Q?clA+rdRXXfrky/cI0hJpvozb2TfO3ApRaxZuQXBWgL3JokTAeEmEqZx0y9?=
 =?iso-8859-1?Q?YHmAzrLwAEjri9Ibc2dpbyY6777j94AySSdiqxZJRYRroNZuJ1OTwM0I1D?=
 =?iso-8859-1?Q?B/d9qK0g6uxdjp6681jcXmPRrsbtdRm9Xu3tOCyq8GFs26MVNEjQme3Y3x?=
 =?iso-8859-1?Q?f8CNFXV1SjZ3zC8pTOLYgRok9uoHPH8IOtTcoAgEBFa95j8xOUtJzsSRul?=
 =?iso-8859-1?Q?zjP0keByw6OgYLCAiF7UclOfjkUgVhlSfRBGBjM9h5floRSabythLXb9b6?=
 =?iso-8859-1?Q?k9fOWKz8JP+/a0Fjq6Y2d7F4oeT/n0FLtX7y8Uxo9LV6/nezlxEkGoxPHi?=
 =?iso-8859-1?Q?LEgvMK1q/j+gdUOKpyQgYyi+rL3j0BsDMEVoPJfNSd5OC+BNW5TBrahCVZ?=
 =?iso-8859-1?Q?bYBgI8z6e8Yf7mMWVdoqvE+toSxKTu2lwZFep7zSGFbyL7FllXS5/HKfVl?=
 =?iso-8859-1?Q?ulshVtpGlF/bTOlOMfVKQU7Rd4GP26apqkKzH7Exfqh5BKq3qUsl4ye+2Y?=
 =?iso-8859-1?Q?tGXKLHeFpLFyZGJLoFmq8hhguP0XSuzEkEVIq8DkwKFg58VRSe5u879QWZ?=
 =?iso-8859-1?Q?pPLd2QTc960wkAiiuRElGmHJ7kaE9YpwDMTIhyU/Fg2YQx9IGWEDvY8L19?=
 =?iso-8859-1?Q?zSKtOfAfXAUs3TYJdf+LeVnUNwwbUy7YAXYZIjLpkkLD74zhWu+HAWdwvO?=
 =?iso-8859-1?Q?QzD+VFaN2xyEloWlt8zC2V7DnSB6LLY9fb+YejDBxMyf4k/gQpOzy5Vcwx?=
 =?iso-8859-1?Q?f100RyY9ztCSV1Gn/P10Ch2jKAmvkvvV3IHFEzO8OhY7DrFWMq5OjjaaQ6?=
 =?iso-8859-1?Q?8vkXtF3ge0zn2JZk/wz6Jwjy26nKlurRH2AF2tArzyLxzdocH1EfmjGuMl?=
 =?iso-8859-1?Q?tSJVQqMah5KLgG6pNbBy6cjpbbsW+1Hnznckgq4kVfoq4L9VDoo8QyB1fo?=
 =?iso-8859-1?Q?EmUGzopLmCoKwruEqc2onE/Tnw70utgV9/SfmTUYwNUjK+GeaFhPwKCjrf?=
 =?iso-8859-1?Q?Gh9lLN2qZg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WeaF0BIhb7iqiGoX5bL+Nly8/wwz3/AgRpr2IcfCbRs5ZMeibpp5LJLOngDerJSMFvLzkiTx1caD6ACjgii1P0Uf2RN0aYZ/JDRAK/Ajp86xg5gke7xNe9cJGy3vtgNqzRp5RC8KP1XNukUwp9liA0tHKXpXIcDLQqTYIOby7zvpvpKRH7ZicVr6gu4vh3CPJfcpF3q5EICumzhII/mcNZecIV+tEh+5btukla/KBxYhpJUv6lhMvmjxsVnmOI2n+V+qJFFUy3SRe7eQo3/ebcSuV17mqOS0VC9hmSbLNQMc6LAruifrP2RbCciOyfSqUX7iBW/CTvYyNHSQoDuSlQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0d1c89-3908-4c3b-b1c8-08deba17eeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:48.4683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L15qBt60JfFsPZnRLLWjOsU4Ek8zd1XBBr9aXC57b6cjnW7Bx0inj/GC+5R9zWXUta6MLLQk2wtUYb3ghlMp6xJN2zcC//m3Is2PNtM77PU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6593
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/gpio/aspeed_gpio.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c=0A=
index 7d0f87e90c..ef321b7386 100644=0A=
--- a/hw/gpio/aspeed_gpio.c=0A=
+++ b/hw/gpio/aspeed_gpio.c=0A=
@@ -1430,9 +1430,9 @@ static const MemoryRegionOps aspeed_gpio_2700_ops =3D=
 {=0A=
     .valid.max_access_size =3D 4,=0A=
 };=0A=
 =0A=
-static void aspeed_gpio_reset(DeviceState *dev)=0A=
+static void aspeed_gpio_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedGPIOState *s =3D ASPEED_GPIO(dev);=0A=
+    AspeedGPIOState *s =3D ASPEED_GPIO(obj);=0A=
 =0A=
     /* TODO: respect the reset tolerance registers */=0A=
     memset(s->sets, 0, sizeof(s->sets));=0A=
@@ -1533,9 +1533,10 @@ static const VMStateDescription vmstate_aspeed_gpio =
=3D {=0A=
 static void aspeed_gpio_class_init(ObjectClass *klass, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_gpio_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_gpio_reset);=0A=
+    rc->phases.hold =3D aspeed_gpio_reset_hold;=0A=
     dc->desc =3D "Aspeed GPIO Controller";=0A=
     dc->vmsd =3D &vmstate_aspeed_gpio;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

