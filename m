Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=qnn5XETF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY5-0004q0-QD; Tue, 27 Oct 2026 23:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY3-0004oL-9v; Tue, 27 Oct 2026 23:41:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY1-0005d3-1z; Tue, 27 Oct 2026 23:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XG7CPbcXNkfsxqJlu+H3utwI5HWodJHvPJLScWBCyAMQ9/bubfgO2BS90bmReflmV9Q3ToadeqNnUmi9blJkgOub59XkrTy6/sFVArNl4KD09YiHJ71Wkowp0QjyKjnui2upsWnlw8FJSBosyOHWn6VNlsSz0neYju71qYrDsh6m+41I/XJSMKQ5V+3qhHAdgz/hfXT4IgXtbccw/iaCU+b39eXBTM9I0kKPy77Yu4Tj32KaCQpdWTud3QJGeXi6qR9jOphydUB3gy7YNcxOX0zF4KbnOplPRFqHikrOen+ojgarYgxZlAlsTakYvNFebFQeWr6LoZ6zEgnVmtyNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9KBL722jSrGVhNzZRt/bUvuwFf2XpOwwXF2+cbFt8g=;
 b=DaXl5m8vFJQk0m3ZHwhEko/zvoJc1uCcxvknLxnU4FBD0UJXgGPKwXHaYoZ3QyUcLMnECkmR8e94L6O8lmkQFOsG6ttl2aQxalfGSrW0DTOm9ShdrmHtrSigJaZAeqRsZ5RbbIWrg22SaW3b1JmYR4sNrph6AdTnOcmB7UTVqod8oMxCSJ7oU0LofW1Qwd79OLoZudr3/FqLrQ1i80Gk1zEpBnvo4UONsJ5Y45U1+9PBWo8JdDjjqw50girluWf2y+kaOCbR2jcZeN69DtER4kEQUc6t/lGRWANl1v7F13UcrXYXqTDyvn3aLmShgsfH1Wy7YMDyQxVAiiM6oyQphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9KBL722jSrGVhNzZRt/bUvuwFf2XpOwwXF2+cbFt8g=;
 b=qnn5XETF048JZ6MzhLr815x3rUvXRULYY46hChxfCNAWERseqRqzh3wPbdV3VAxfVbSFLaYWlENNF3WALIdmBzKcBmw+wEi23y1H9rRwtcdDkX95E8adh735J2HZhTNjowWQnr7W8ZCKzEUDGhcy5YDgueyc5Cb9oLGPEdU5YHL18Y6FDxPulnpU9rNYADzos+SF2ggsGAG/WKZG9ORWOxjRBA2UAfP8t60MO4WiGcmmsVlFHL6dIuBCoA/fENj4qsIlXWmgIALKxIWA9/+xU2uanoMnHK9Olp8XEV2nJ0q7YFX8nleiBSOcTEjSqDp+06JIXJnGcyMx1zd8HM2LuQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEZPR06MB5117.apcprd06.prod.outlook.com (2603:1096:101:4d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Wed, 28 Oct
 2026 03:41:50 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 8/8] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v7 8/8] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdZo5EMAxGKrAMikKRxbvKFYWrPA==
Date: Wed, 28 Oct 2026 03:41:50 +0000
Message-ID: <20261028034140.367393-9-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEZPR06MB5117:EE_
x-ms-office365-filtering-correlation-id: 30f009bd-ba44-48ea-be1d-08df34a566a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|261026140227099003|56012099006|10067099003|261021121427099003|261022105027099003|261009223027099003|38070700021|261026121527099003;
x-microsoft-antispam-message-info: JOlAYHVUvk6icEB9JwiPa0qDNyqv7D3BonebDn4AB3r/54MkKzmtjs5GgwgS/nTsjBxlcopHqENUHtIPHz3uhsRXJfNZyC3jhSMmKODj0BQRaj/KPKMpQbCctnYiB9ptQzgK4bKR1AV8RFOcarcUwDDFgmgF1TOY6WIKL/ABZ4yjSZwgq/pFeJzEj7bmSvxr7E0QKhReH6ZYGCDVYCyMbCbQPCFHTUMKJmSKMevJV0b4QdnWwEFACwjEfQGYWnuRD+Hai0Mwbdlx/+rhDK9ra/TF5IbrhLbSshCfY3SQBM6UvUFa238ugfpmNCXPpAh2RqDvZge/MotQEf2/UywrpDR7lsSS4195Yii0Z0mRXiX/19zlm9J3ySeS9iDwBrm0tGT/PjrQDouIYnyhFgNnl8CAivfhf3e2ZTOc60W5UWsruHWQZgMe2xtZxT3nBN8jAgXyTF2K8bsnpcW2deKeySQyZe+A9eUHKJ3m7bAYZcwNsJsEOP+J1GU+cVuQeQrLju5xrKqdlMpQf3tUlJ20uTZd4+HojjAOe8pAcr3mqwjluT7H8ePnwUF+K+A14rHHakIJzMi2BZ4Grl1pbqP3iZe3VzKnzOFXcSwvM0En3eNU99DfkR4v1QtgyIhsaSEf9gJ7hpnoF59nmxfe5/dyg5ce+jb17W/oO8JHuJ13/In7vr9D7fZ8+NR7GSzFTJAEVh7PNgxXX5bV9JXCEM77nOtiDSuMvPxurQz7xomiAG0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(261026140227099003)(56012099006)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003)(38070700021)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O8F5Wma0+jtNTIJAmUBg69OtYlpVEW06Bj2ixfQyYeZrdeezkUS1geBqEi?=
 =?iso-8859-1?Q?LbjbHu8GG+AVpA3GLrJWWnjjSdwTY6Oj2yOK0Wkr9T7lQQJOlVJsvIAF+r?=
 =?iso-8859-1?Q?Kr/itRwdHColyQIo4gsI2807ImcrApI7KTtDQV27aHvCstKisWBdfK51Cb?=
 =?iso-8859-1?Q?o/eCGU2/IKH9JicHB1Qi7BKtHi2yduzH5cmq8oVwik3nsXnKevpGkd23Bd?=
 =?iso-8859-1?Q?f1Rj5ZlLQnBQ7jitYpK0nIwA8HDW7verNKTGV00Wc3zl9wmCHDjXZRRoR7?=
 =?iso-8859-1?Q?9Pm7F6AVYiqhrPma0ahm3gM6BnKa/QA75qIIsKFqRaHHVv9VYwWM7Zp/cp?=
 =?iso-8859-1?Q?T25V/CrHvDqMp9F0h3HbMwZvSxdVDBGdvexSpZkbobQFSwsBsErjmY4MUt?=
 =?iso-8859-1?Q?Of2qCxRVp68FO4B92wmqDwKrVqQ7d2nG/6aWpD7pNGf+HWXY4mL//82957?=
 =?iso-8859-1?Q?vy7CePPnE6on5cf1/dJm2sVNTU60fSDIc3RxTNVSGREmyDlFNg77C+pB0L?=
 =?iso-8859-1?Q?fJRFhOnQ4usnHuU4hLfKCLOY9AKiS+d3gDJDGpDGy2LkpkPcw7KjO7pYrj?=
 =?iso-8859-1?Q?f3aCdLOYhIkL/qmQaDPXveICyahxslddFzAiifYvGx7tP5KamYmZ7GwRu3?=
 =?iso-8859-1?Q?Z7KwVgZdIKLPNydAeTlQWLyfrwskSlUBYapTAEWpi/PPX2iYYgwcZp87Vm?=
 =?iso-8859-1?Q?Y+CvYtJoX/bUK+I2izkFl35BZzpdnD0p8y+0VyceIgqLjHRULFY0yj/3OJ?=
 =?iso-8859-1?Q?rRZtfrm6jT7Ny0fsemDcyyyqpzHeGuNREw/YqXKMBkn/tyV+vtyNu1Fnu6?=
 =?iso-8859-1?Q?qGNcfZEPSOALdKaJ3ioRfDuIF8aWOiNgQnc73XemtIOOxObVWhmzkvmwBg?=
 =?iso-8859-1?Q?iRQftZAH1LuzzXmNUsPH58a/wIsEDuL7XFmlvYuXMjs6vPi96GbWFT2OHE?=
 =?iso-8859-1?Q?40QcVmWlRhvWJw2+0Z5u8+OkFZdAPzPmy1ugOJB0xXOqlfOMvnKYU5PjIO?=
 =?iso-8859-1?Q?XzWJFOxaO/LPsYGGFB3hollBicN09bRW6129H9LQebcCZ53aTNArV/dzy6?=
 =?iso-8859-1?Q?FgCWQmbbfmmMk2ycMiBGKoJP2lm9vbZe5WGwRy0qCW3qecwJ7KjgH1sTRG?=
 =?iso-8859-1?Q?acGUovoBmN7dI1Ez5L4DbvqJzOmzbcL0t33ddIIcvvX3KgPGyYXEiFu+Uf?=
 =?iso-8859-1?Q?yi9MJI+yxgAuXVUOjULE+68vjSWI3tyO9Q3Kho+dyEZVlImZSnVI4utRep?=
 =?iso-8859-1?Q?fNdEyYOgkfM54UmMegvGwlePUNYoowudk6pyXCRfGJU8emyIjZ2L4flc/S?=
 =?iso-8859-1?Q?8DPKQXwDMk4C98qkymIm7rzfIuzDFofSz/kGhVOZOTWLPqey0ctLmGogVc?=
 =?iso-8859-1?Q?LuVk1OafaIZblooAGUxgVjySL+dFzsiFjUznH9U1ztQCjzvALrIEiGWtpP?=
 =?iso-8859-1?Q?7VhjHE7ZW3YTwgtKKPkb5g6HoKryQ9+FBDCxuu2wKRY/B6ZGPPcXbj4aw2?=
 =?iso-8859-1?Q?slij0uQ155EZjhiBdYfHf6nMVvLWj+60z0iu2bVWDVQ5dXibJcm6IU46oI?=
 =?iso-8859-1?Q?W5XYQ99QevxMjjZPTwUtYUzKZOQAKT+pCwepNSV4k28dXmZX9OJZveA+sY?=
 =?iso-8859-1?Q?tuLn6fyE1EUaQFt2ATuox5T8hvzRDzpKveqhAo7qHBLs78TtX6nVRIcADw?=
 =?iso-8859-1?Q?SnIL/tj7aSknsy8Yn5PpOGtUJ+kB0p/ZmyfXBxNNMOAt0XcfKYxr1MKuUd?=
 =?iso-8859-1?Q?7YyHyfshs5XHFeii5nBvjlV/xjuyCR6iNjrniq2K8o4jZE26XJk7o41Ljx?=
 =?iso-8859-1?Q?GCEYJCIT/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f009bd-ba44-48ea-be1d-08df34a566a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:50.5751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75f31Fun/vRdOPlavCH/mbh0i7y3EJn9XrniJaYbkcrMYFa/O1pW47pRMVMMM0ioEhHgn2OEVlkOw3TuA1Y49io7LCbtpZz++9mEHBoQvHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5117
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.53.0=0A=

