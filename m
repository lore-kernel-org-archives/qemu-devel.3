Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B192CA9ED6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mW-0001m5-Io; Mon, 12 Oct 2026 02:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mS-0001k7-2H; Mon, 12 Oct 2026 02:45:04 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mP-0006Ms-2V; Mon, 12 Oct 2026 02:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6jCmIEi4S2SVjgYtvhioJytcfyiCfnV/cu/DvvBerGPAz5+GutUhhk6oaq+9Y27YMTYb+0JqrRM1YoHignEJYK/mTzeP/eZ0pE1mVakTXX5bDnGgXkFQjiXR2IIxBNuA5/xWyIGWxacN5Cxm6UShKvwKGEF1Kvfp1YYvDhcgCjT1Z3ekwzhIQZ6IYxZPVKi7X1hEJvBx0RPGVOHHfJFG5FMbnzAfrv77WgFT3d8dD/aUdKowYc6WtBFBwtZSWa6F356dHbcbaAeZJaYkkR0TZvF+dxhgx71Piuf+qBQRSzfPt9qV3eBBw5+g33PXvpYo6M3m6L60SvLRBzA0SNPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrh2gjTTcrdmVDm/JU8V0+cqIE/AHIAuDpY8W9oAd7U=;
 b=ZwhhTCEvtCrz3GWDstWKYA/Kk1kknBcqQ/uhr+tTyqgmH+dPaAGup2HPbCXBgpVnNY6A07h7+o1U2y+Tx4gXuYhdnK3WCyhRBBzU4dek7EJ+QObxcxf5zv+59+G7PGfmhu7iNZkILxrGZXeby8det8Sfo/OxoHSUdiMukdgyReh7O5QPh1yldnKJ8wSjWiJSVoab3JpQxtBRJkR/43Q9hnoftMTPJmUupmvVRdYQdvJ7Sjo7qHq811/AgejX8W086cAb3ZQZl/stl4iNirxwMAhOOW6fXJe+wRV3iK48rT3vAdrKEoUTGMnGNYoxw+gAPWOAXoYBNRFxhdHm4fcVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrh2gjTTcrdmVDm/JU8V0+cqIE/AHIAuDpY8W9oAd7U=;
 b=ileEXgreE65oP9bLWZ5C1j6sJCb26Of6PBazU9389zorxELHppy3SKDdtWjMnfnayf/j1q94xXvGPYP1HKWkdkgnt3lcPDTmKdls9vU8lM2G5Hhp059zW8LBdtlW4s3wxDSMXTpoYN54Y7x4sBAU+GNoWFx7gt4Lgc0zUOtKOGyZlg7tVxZU80wNA2eWRwfn7Z9SlEL2Mj8YRoSSEUAAMPnwBmqZpJ29yC4UmEfbqmY8IUWYkHzpJlEO5qigfPAtZcrN86q6/tWB32yRmwzQUaA6bzAlctK7TO82Sunz4oWVRF0SebjXUBUAa7vW436RJXK+fD5jw4AtY3TcYXM3dw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:48 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 02/12] hw/arm/aspeed_ast2400: Use a table for unimplemented
 devices
Thread-Topic: [PATCH v2 02/12] hw/arm/aspeed_ast2400: Use a table for
 unimplemented devices
Thread-Index: AQHdWhUsT11ipMqmeEyWoIhrZbrxwg==
Date: Mon, 12 Oct 2026 06:44:48 +0000
Message-ID: <20261012064445.2571633-3-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 49588668-c0b5-4867-2908-08df282c4f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|260925021311599003|260925022911599003|260925021911599003|10067099003|261009221227099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: HhQsOTHbEKnZx0VYKLS/BiaEkhWMwXZwCNejLa7vv5pXgeD2UYnqhCEAixUelcQa782IC5kumcIPVTP76aL8omX7qLB8kjCTjyVJnsPimwgkzCPd3qciK2xvuaxICqhU+VIMf4iyi+BJuv3iJZziqJ1ZAff0rEcbbHWYuGIa/Dz4nHzRAVjONUSvUoIf8PPdlTcS2ZCt/UWtgV7X4z6qxsM8unsYX5js8EclouIEpRArlbvu9orlXEPzL+JRadWEKAS2fwqtQGZZcPL7+bDrDBzniXlvlKhpnS580N8qTSl9mfjo1/qUjrHwwSrSqmvyD4R0wkRO7kRd55l5BTVaj6OuWi6pWA16M/6oCWC2onM3GX4P5OvWLsYvV993h3VsLbxiOlhThKcP/cD7lkjSw5jWWFRTzJ0Aoqk0XU+1jShGdGt6OwtuEuBkN+lr3ExQUAnEmiukTinuufEIG1xP812t5cADqVNxcXnu2rW5Ok7jD9Hw473qAhFwMVl12F6pz5JVOxnwxWrewVsAzYhM87Dwf0b98HbhXU1jglOdQQJj7p7sa1oRCizAqXA6UqtE09aNw2JqEvZbHPKMeh7oq94TdbpXdnGcp2vONFrf+S3dH3+izamVEXBzegMnkHpiFe25aO00jIdL9FUFgJUMJlPhK/RWiCR6CNT+kvU3Y9CKPfjoHSIM1PyycbCWDuMf3CoUj9iwvUvA522q/ZeJfUQJnjJZmedoFoZ5BswaNLUB8gXRtcJsmaK+PvG21gNU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(261009221227099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?28nXk6LwOHQVzMwEIDxThMzUCIlHCj3wolWh4nJGP/CutmnnrKfo0t/oE9?=
 =?iso-8859-1?Q?kmCUg4CLwJZNjwbv9YRhLknekltY6BWq/2ositPF8wEnaKei5XwX2nKPsx?=
 =?iso-8859-1?Q?7F+e7tJF7AcX306L0jObQPNjN/PX6IehSpGDnFuNdBM2MBznAux2Vj712c?=
 =?iso-8859-1?Q?LgdTBsAjkGbbKEZvKKWIJeUrEwBdMZ9v6L5zIGkuafbSe1mxudbDJ8tsFF?=
 =?iso-8859-1?Q?nSzYPEr/lrNQxncMFaRgLHC29FhlvN7iur3lQKpklq8H5xlrNZ/BFL1IaO?=
 =?iso-8859-1?Q?YKTZzbEse8yquRbOB4VkBVUZewca06/Sp5U4vNMXPBLaQT6s4NRs4Z2G7t?=
 =?iso-8859-1?Q?NaDHovNUnPJcR0xyW8nZcTpjal+311rL5qPstXYlPfZ59tjANKlei0COdM?=
 =?iso-8859-1?Q?T7/v9LN43k1Rpzerbq7n3mmN0fYqtKFqzAWSVIFXGyk8A2PHXkn8lPlf6T?=
 =?iso-8859-1?Q?FwY8434QRQfaR4dm8kG3vn8I1zH5wumacTg10IiTTkwpEzSlW2mb7B6Y9U?=
 =?iso-8859-1?Q?I1uz2W9qSaQfY+Su5rOEvaPZFG0LqzSs6eYcONU0P5IDFxPAsz7hGShjCy?=
 =?iso-8859-1?Q?3SjB91xQG4iDad4KijEl+vPUB3gMvo9aXbjilqEyAs8Tz2R34G2aQOor38?=
 =?iso-8859-1?Q?fyMA24Aro49GnAj/5Ic6wMggVLiZmDk13Ojv/avXhAbB0vLPKdNMFBR5/l?=
 =?iso-8859-1?Q?2Db7Jyl8XQI/992vuQJSfAIZH+wIavO1u8rfaLHf1OjMvP5DoNC2vq7Arm?=
 =?iso-8859-1?Q?tmEu7mvEPKWFyAT4GNHTTBvnHqFmiijz297tGjG8nJn666G1lLZnsiLCSy?=
 =?iso-8859-1?Q?YuFK5hOaOc5gxP5sQgqoiS+ymcemRZ8CbhGAvJ09MDA0ZbiOyMhX1rtPzn?=
 =?iso-8859-1?Q?rkgVXOtGmTAB8yFDmHLBaT05QtRjnp/4kgv9ngEN3mPsmAIAYh1IjOjWhi?=
 =?iso-8859-1?Q?s/lP9ZIhIEOxlQfVD8VSYbpxhvTBpC+NhF1hb+86/NZ+/yvM4Xw6f6E47U?=
 =?iso-8859-1?Q?8zC15kRfsbDzuzFMNA6XN8jPUSbXvNrOqzQWhuolwk8+O/RLS7CCbW0EM+?=
 =?iso-8859-1?Q?l65pB8I/78y0vqIbLhD12XfcWnxMgnjO9Tvd3yeK+oW3SawzUtOSTWNXKI?=
 =?iso-8859-1?Q?69ljTeeFC3JqIDIKytwMZAmhmUxGnX/nusK2d9CFhSXVrlaKRBuqENYsfC?=
 =?iso-8859-1?Q?3xzg0lq8Kl9u7n3TbktJWhxrp8l9deIAFZgq3ni3rUJu2lCUTmP52sWvx0?=
 =?iso-8859-1?Q?IdQM037wOBj7xM/wEsSjbGKWthND9S7/A6y3CS4eb8Ly+O71tY0I3UcQz9?=
 =?iso-8859-1?Q?5lhcGM1rRObGgGN5WVFraQI2pOqbBD66DJfmJ/nVw+ASZqIP0LGy/mNFAJ?=
 =?iso-8859-1?Q?xGQNxDDazfjEMIOsSVfLQs+b4fN1wCamcnESnBKzThMROrnr/zNsoGwW/B?=
 =?iso-8859-1?Q?Ci2ikLDDsv4C+sKFxkoOi9fXKRg8LvYtt8j1sxYANTp90muziEBEOHoigE?=
 =?iso-8859-1?Q?DSiXXuGvSThg3hoMOto9yoiuiKYFOpdTgpKOmiIjBsB2EQfh5pB1jDkiKk?=
 =?iso-8859-1?Q?nJoFCwu10nXVRGe0RYLDsjffaHvBSgnRaqbeaYwNpoGJXJZzeALQ1u3VGn?=
 =?iso-8859-1?Q?KqAQ9Yh3CAHp3WydGB12q8v4QJkGM4UlZg+r81Fdr76A0KAnl7qfOswZiQ?=
 =?iso-8859-1?Q?1tYgWo4cfPyJIkocCejqocKirY+jrYkUZZOAzU0kI3hKwDY4Ljk74KHfq6?=
 =?iso-8859-1?Q?U7qlfexNk+Sb4/KU/YMWqvHZh4G2GeWkJKJQDk2FAefyx6jcIeah50T8zO?=
 =?iso-8859-1?Q?lxg93jrDUQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HE/xAaip8767WQeEh3tvTJRKcVCRah0OeNOPExoLV6nK6CvPOUVrEe4IA4KvQBoQFVReB0FwZwS0maZWddSJ/oQIbYpw6x/dwKxqjskD6X8RH8q360r0mIGJh9G9RUZcd+utr0GetHCQCV/OZZvfDRKIO5mTR3V56CNoXJOoxrGl7C/XFic7jItHQl6vg4KPf9Fj8mjsLx7dZzFKnl4j3iJPgr6JxUX9YK8MZsKpizp00o7nNCsrgREphUesNYk4IlSVFtNVKyOi2yqA1Z1n1FMdGnbPa61B7OMHqyoKngtIcRh8dUNjjMN0B2Sq5DPpPLWbu9LdRzbHwOzRT2tghA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49588668-c0b5-4867-2908-08df282c4f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:48.1864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkjSt70cWYnM1QsC7MwJ4CylsOn3aIzZPoqpFLJayGJJedYAmD4qCmjGu+F7krp+ztB3kSa5Tt6lohsP3tJc+R3B3QGX+J8UiYuFWSjN75E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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
Add an unimp_devs table in AspeedSoCClass to describe the unimplemented=0A=
devices, and use create_unimplemented_devices() to create and map them.=0A=
This makes the code easier to maintain and read. Convert AST2400/AST2500=0A=
to use them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  1 +=0A=
 hw/arm/aspeed_ast2400.c     | 25 ++++++++++---------------=0A=
 2 files changed, 11 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 38226d9b80..8426134223 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -190,6 +190,7 @@ struct AspeedSoCClass {=0A=
     int ioexp_num;=0A=
     const int *irqmap;=0A=
     const hwaddr *memmap;=0A=
+    const UnimplementedDeviceConfig *unimp_devs;=0A=
     uint32_t num_cpus;=0A=
     bool (*boot_from_emmc)(AspeedSoCState *s);=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c=0A=
index 79a653f65f..fa2782da61 100644=0A=
--- a/hw/arm/aspeed_ast2400.c=0A=
+++ b/hw/arm/aspeed_ast2400.c=0A=
@@ -23,8 +23,6 @@=0A=
 #include "system/system.h"=0A=
 #include "target/arm/cpu-qom.h"=0A=
 =0A=
-#define ASPEED_SOC_IOMEM_SIZE       0x00200000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast2400_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_IOMEM]  =3D 0x1E600000,=0A=
@@ -134,6 +132,12 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {=0A=
 =0A=
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast2400_unimp_devs[] =3D=
 {=0A=
+    { "iomem", "aspeed.io", 0x1E600000, 0x00200000, -1000 },=0A=
+    { "video", "aspeed.video", 0x1E700000, 0x1000, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed2400SoCState *a =3D ASPEED2400_SOC(s);=0A=
@@ -239,9 +243,6 @@ static void aspeed_ast2400_soc_init(Object *obj)=0A=
 =0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
-=0A=
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
 }=0A=
 =0A=
 static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)=0A=
@@ -259,16 +260,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SPI_BOOT]=
,=0A=
                                 &s->spi_boot_container);=0A=
 =0A=
-    /* IO space */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  ASPEED_SOC_IOMEM_SIZE);=0A=
-=0A=
-    /* Video engine stub */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),=0A=
-                                  "aspeed.video",=0A=
-                                  sc->memmap[ASPEED_DEV_VIDEO], 0x1000);=
=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 =0A=
     /* CPU */=0A=
     for (i =3D 0; i < sc->num_cpus; i++) {=0A=
@@ -542,6 +535,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *=
oc, const void *data)=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART1;=0A=
     sc->irqmap       =3D aspeed_soc_ast2400_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2400_memmap;=0A=
+    sc->unimp_devs   =3D aspeed_soc_ast2400_unimp_devs;=0A=
     sc->num_cpus     =3D 1;=0A=
 }=0A=
 =0A=
@@ -569,6 +563,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *=
oc, const void *data)=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART1;=0A=
     sc->irqmap       =3D aspeed_soc_ast2500_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2500_memmap;=0A=
+    sc->unimp_devs   =3D aspeed_soc_ast2400_unimp_devs;=0A=
     sc->num_cpus     =3D 1;=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

