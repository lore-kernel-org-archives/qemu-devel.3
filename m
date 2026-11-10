Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0960A261F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=FM3GtC6q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEV-0008Tp-Tt; Tue, 10 Nov 2026 03:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhES-0008TA-35; Tue, 10 Nov 2026 03:29:32 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEN-0002yp-J8; Tue, 10 Nov 2026 03:29:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsdMyRyUr3H8lI3ZSm/hKAmVwIIfe1gpoS2JFjns0OkGi/K8fbazfpQM29sw3PM2dWIHJ/xMmxObIfqfMJ4I5PJ8xg7zT/cU4tW5hWfFHruHSZjJCP174aA5mL4pZ2Lq0DK0oVdr+5YO6wemZl4F2EnByrdNCdKZgKlVpYx6pDEeFT6XUguR/quPFtQTC2Jjpf90YsSDXxLfG6C35GIPlWwxZjUZGlJvKxzOVHtFC1VgXe8EFw0qzpDpGUYuPkRde3cz39iiOCi2iVEEL8m4qHvgsseKVN1XG3EVyAB8xPw3uF2hiWzxBip64Z3iiCfR6hERM5n4w3aRLGkSsBw/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIyfU62WbV0qZP2LyO7l9viuafH+OcklFtHzZc0fCUM=;
 b=PhN7Y83bn7+7DjOky+Hqta+iard+BvAKF6cDqu7M/OZr3tTGZOFs12N1e64BmBhKoPqZ5aktLAhqFxRx8B8qlewGSqBXuwgPNaGlM83bP4jEWFa9kt33Nz07p4bVfTNirWLYsS7pkDxQmpjgzlvt4wUu3s3OLyiPWChv4ZWu3gQkdsyLh9Ug7zZlzP81AheaX0bl1FqGub91z4UzgD97hryawaNxBexAuOlPtMDy8ouiaI1Ujugf8YGMvBkX8Ukko1xvMSTDbk9hcvd4R+NZAfy6uFSf1TRvMgJlG1QRPCsx/l6laL9AaESL+YnH5ZB2SXEU42g+dMrxvrvd9BiMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIyfU62WbV0qZP2LyO7l9viuafH+OcklFtHzZc0fCUM=;
 b=FM3GtC6q9FBhG3nNYAX1RaP8twKl0WWPBb41TBWldu/hNlqr0mv1mX/M7Qs3jflE2B6dkfB3m3ZeHaMtmkSN2a6la1xKrCnKJD7xU+4JUBt3ge6n9EgZtBRuM/9wEqIEnrVCIfOiHjSUcvDTKduEm+mXo1rrl5mJuez4vPi6j8V0T2vu3zcOGzThMZ7+lgCIBq2URb7+gywy/iwrGoZRuC1YxCxT/QE/eP/oMlHLRNsWxAzeZ4TxUz3UYcHqX3IeVPQRyRBbkHWZoYxIcksu1Ub/NJQuhXEj/ZCjgEeO95V1qqb8OLZ12imIVKqAFD5zTV0Svgfmt4za8ELcttyiuA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 08:29:18 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 00/12] hw/usb/aspeed-udc: Add AST1030 UDC support
Thread-Topic: [PATCH v3 00/12] hw/usb/aspeed-udc: Add AST1030 UDC support
Thread-Index: AQHdcO2U56EN53BBiU6UZ6QLst/AfA==
Date: Tue, 10 Nov 2026 08:29:18 +0000
Message-ID: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: c3d9283f-42f8-45b0-79e2-08df3f04b68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|3023799007|10067099003|38070700021|261102123227099003|261028144727099003|56012099006|261022105027099003|261102130727099003|261026140227099003|261026121527099003|261021123027099003|261021135927099003|261021121427099003|261009223027099003|261022075727099003|261022115727099003|260925022911599003|260925021311599003|260925021911599003;
x-microsoft-antispam-message-info: +FEm5eSyvyCNVeAPSYMkMk3oeFn/HQIchNXbvMN9VyropZArvhzZufhPciCs75uH/2TeNqQ/urbHG+ZqETis1Vit7E6FfVydsCt3JwYN/jNO3QPJZi9Cb5dmkLXrlgNCNbWgG4u6fj0F+gc/+NbLr6NMO17wMIvE2d2WaFAvdEN9XbXHK9DdqIKXJfm8mc5RpOImlYDmozFGmy0Art1XxW59N7x05eSvgfBRpL1SyfLtcR4Qlfj1lOw3P+Fpqq1IlFj1vOJgAFh4HPAIJlgpu5hiSxcbV7FCQpCB9Jwhf3wa6t2yjWKlBgGknjLOUyAtxc35RO9dhLDYkUUwBi7qtAdsiDcdQbzQTevHUpByiO3r1SGVcScF6lav4H4Vkfu/4nom0wss1vsVkSynNYU1gosdXOTyhlpcyy1Ueb22WuRQaVRThgb7EpXdlBS8K+IgNZCTh/756qNUSWBIQAsbDigA/aG1bcS3a3StJIUJ6tPuAdcPl81hA5zMQr2f0USvMVNe4YVx1FitMnHbVhjazy0bmOoHcW3EkZ4CsSpPP0N4oGlNzI/UL9KDrdsV4UpGsQWTZ5GnOIgOSQL72jFEQ4trD1tHMmDbsGC8rVRSVvXfiApoevK8iBL7tsBB1jFTBGyTqtTnRD+KrnAZhZjY9T0wvwTZ7N2obUns+AsxeUk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(3023799007)(10067099003)(38070700021)(261102123227099003)(261028144727099003)(56012099006)(261022105027099003)(261102130727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022075727099003)(261022115727099003)(260925022911599003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v0UQEOFvetXULRfePOe80WC2hhPDH6LxDqiso7fc/CpAkf5/9+eE+u0KCG?=
 =?iso-8859-1?Q?EDeOSwxXjZOthVcODTdnCmxfk3LC90sw34e72Xk7r2+5iXkrY4F0ryLwkG?=
 =?iso-8859-1?Q?hRQkDVtDNf6J7Yiwgc6z52cEDxZYDIqBFwIeLYocQjXXqWXKajQnka1V2A?=
 =?iso-8859-1?Q?ULKtF3IM6n7H3bnrHJwz4XH1ZTXfTaf5ZrjE8rdFI0v0aQdS/Sdm0oD2/w?=
 =?iso-8859-1?Q?FyF0okt/g22+QFcYlAYm/qqa3RTDKlIeScS6CzdgMAvxz8n2s5gr6YdrLc?=
 =?iso-8859-1?Q?uaTPDA79jz2RJtEqTn42t4bYAeOBaLxtf1FAPdDGTdK9e2LRdM+URh3e7y?=
 =?iso-8859-1?Q?cM66wI6DQyGRHoXkTfcLIEh6ECXBRbf5JLvX9iXdf4fhfO15LNu8wtXNle?=
 =?iso-8859-1?Q?3H2QKIvzbOe04hWhC3Hdb2dzhWPAZOacoe75tLV/fa7zENYcAFoExoHrvt?=
 =?iso-8859-1?Q?9HhzSL+X6Wt3+LpXm7CO2BHtDKNyUe2n43uDyUQAj3XNtbzbjYOD0D4yF6?=
 =?iso-8859-1?Q?VVILEClpXxzNrASJ7LHDBc///H+cokzlsHxzch4kS96P7zZmOM+UjKozpk?=
 =?iso-8859-1?Q?Eey/Zmojadnc9plNsFFKlYX2PNMjIK7YGY2/8e8whBJc7UHEhH86OAdgky?=
 =?iso-8859-1?Q?MFMo1/RmiSnfPEtsQ7iINAge1CbbxLIMK+MJEi7aCkc/Y8ut1N7cXi42O1?=
 =?iso-8859-1?Q?zpNyJQXMDQFNgsr4V6wgV/tjZMwLK4Njetjc5p4iIWCmELapX70qKsysiF?=
 =?iso-8859-1?Q?ZaR5UFNQi+0HuFO8QmZ//aetlTbUivtJNHjDSkaf8flerU3lSXHeK+K2H0?=
 =?iso-8859-1?Q?XfJ9mjCybDvN0Qm8vPCRTTRIt1zOyD9cpS32iqlyBGKVhrmZJy7jvJVXjv?=
 =?iso-8859-1?Q?wuXchoUNx5RsvxVr7Bkc6HOgxkAi+Y1uYWOltU9vFMnX3/YpJdn31MaEI9?=
 =?iso-8859-1?Q?OoFN9cL28cD83bidF3ipMk1TJbyOFLpuWgAgS+RVgEZoQYl6ftHQCM64Ev?=
 =?iso-8859-1?Q?VQUmRlMRj+Snn2QlFFINc3hUdxDgEGnUoV3EyorjCm17mZko2TE0J7vK3N?=
 =?iso-8859-1?Q?sThFd5kuUtxJgQsMgdnV34FH/B8NmTTyM9sOV5fblWBhAjP5lH+93/rrsb?=
 =?iso-8859-1?Q?MuKMkjv+VmVP6K1mUZ78Q0lZ2oeOlkpJTYNlDrt6DS17ThMdnmTL8xtYeP?=
 =?iso-8859-1?Q?TQ2YDWCujw74shIEbG5OjcVMeR3/7GN/5bG4IGAExTWHQUhUbGqOGrmTUh?=
 =?iso-8859-1?Q?pYy5txsolYg66fbS5dtyqvjMqLKuAiNEXP9o9D8wmfevFFQ888+Ftoz/SD?=
 =?iso-8859-1?Q?/zmLGOgl7jAod6Q82uR5lx8mfi3rSuhWQ/rHQy4xcGk/CAJtcz4pM1+Hzi?=
 =?iso-8859-1?Q?hFewXyDTLT6BnntgQFgZarBIpCUd/EwXtP4GPgb6F+UNndkUy/c+/nHO/Y?=
 =?iso-8859-1?Q?aZND/nkg0p1igdZBRcPjCTTQxaWkMQW9HZU+FrEtSlBjI9A+LV4wSnaYdB?=
 =?iso-8859-1?Q?CD6vyf3Pa+pPvRmDgjlgJ3mWcyoIT/FRNJf3U3cIOlpSX7TOQ6Aby8RqZb?=
 =?iso-8859-1?Q?cKwz8eY3UJr2eORXCSt5n+na0mX77CkKgOrD5y1DZqiq4LwtEQ+q9yeQEV?=
 =?iso-8859-1?Q?TMh2DVjFN1+nIuYd/VgmUKbcByJCNXibHlUWq+KrS3wMzpxQybaJ/2qCtE?=
 =?iso-8859-1?Q?EJAxOgSgfb6GB4KdT9tcHpPcFcBqLs5JaHCT7gKFNI11XafG6oNiRWSsZf?=
 =?iso-8859-1?Q?zqnMOA4Fe+kvgaaHx4Pq0TnTVS/rmiaMz8XXzDsKcRqQzI+PZtl3DWi7JU?=
 =?iso-8859-1?Q?S7K4xLRnPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d9283f-42f8-45b0-79e2-08df3f04b68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:18.4736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9FRlmqUwE34WOzL5nrK2No5jADCg6bckVRclJP/rwhURqV3ERg6VDB4kV2c/nEmnvEG9i/7nUWynu0chDLdvu6GhZXi4+WWX2yeEgvo0ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds USB Device Controller (UDC) support for the ASPEED=0A=
AST1030 and extends the existing ASPEED UDC model with the transfer=0A=
handling required by the AST1030.=0A=
=0A=
The v1 series included both the usbredir server transport and the ASPEED=0A=
AST1030 UDC support. Following review feedback, the two parts have been=0A=
split into separate series. The usbredir server transport is now sent=0A=
separately, while this series contains the ASPEED AST1030 UDC changes.=0A=
=0A=
Dependency=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The AST1030 UDC implementation itself does not depend on the usbredir=0A=
server transport series. However, the functional test in this series=0A=
does depend on it, because the AST1030 has no USB host controller and=0A=
requires x-usb-redir-server to export the emulated USB gadget to a USB=0A=
host controller in another QEMU instance.=0A=
=0A=
The functional test therefore depends on:=0A=
=0A=
[v9,00/19] hw/usb: Add a usbredir server transport=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20261110072818.288334=
9-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Background=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
This work is part of a larger plan to model USB device-side support on=0A=
ASPEED BMC/BIC SoCs, which has three goals:=0A=
=0A=
1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host=
=0A=
   (EHCI) controllers, so that work targets the AST2600 UDC: its gadget can=
=0A=
   be attached to the SoC's own EHCI bus, letting the guest enumerate its=
=0A=
   own gadget and exercise the UDC end-to-end.  [Done]=0A=
   https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@as=
peedtech.com/=0A=
=0A=
2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC=
=0A=
   needs a second QEMU instance. The UDC gadget is redirected out of the=0A=
   guest with libusbredir and attached to another QEMU that runs a USB host=
=0A=
   (a VMM, or an AST2600 / AST2700 guest).  [this series]=0A=
=0A=
3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media=0A=
   support in QEMU.  [future]=0A=
=0A=
This series implements goal 2.=0A=
=0A=
AST1030 gadget to an AST2700 host=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
        QEMU #1  -M ast1030-evb              QEMU #2  -M ast2700a2-evb=0A=
  +-----------------------------+      +-----------------------------+=0A=
  | Zephyr   usb_dc_aspeed      |      | Linux    ehci-platform      |=0A=
  +--------------+--------------+      +--------------+--------------+=0A=
                 | MMIO                               | MMIO=0A=
  +--------------v--------------+      +--------------v--------------+=0A=
  | aspeed.udc                  |      | EHCI3        (usb-bus.3)    |=0A=
  +--------------+--------------+      +--------------+--------------+=0A=
                 | USBPacket                          | USBPacket=0A=
  +--------------v--------------+      +--------------v--------------+=0A=
  | aspeed.udc-gadget           |      | usb-redir                   |=0A=
  +--------------+--------------+      +--------------+--------------+=0A=
                 | USBPacket                          |=0A=
  +--------------v--------------+                     |=0A=
  | x-usb-redir-server            |                     |=0A=
  +--------------+--------------+                     |=0A=
                 |                                    |=0A=
                 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D unix socket =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=0A=
                           usbredir protocol=0A=
=0A=
Testing=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The AST1030 UDC was tested with a Zephyr CDC-ACM gadget. The AST1030=0A=
side exports the gadget through x-usb-redir-server:=0A=
=0A=
$ qemu-system-arm -M ast1030-evb -nographic=0A=
-kernel zephyr.bin=0A=
-chardev socket,id=3Du,path=3D/tmp/usbredir.sock,server=3Don,wait=3Doff=0A=
-device x-usb-redir-server,id=3Dudcredir,chardev=3Du=0A=
-device aspeed.udc-gadget,bus=3Dudcredir.0,udc=3D/machine/soc/udc=0A=
=0A=
uart:~$ usb enable=0A=
uart:~$ usb print 1=0A=
=0A=
The gadget is attached to EHCI3 of an AST2700 guest through the=0A=
usb-redir client:=0A=
=0A=
$ qemu-system-aarch64 -M ast2700a2-evb -nographic=0A=
-drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -snapshot=0A=
-net nic -net user=0A=
-chardev socket,id=3Dr,path=3D/tmp/usbredir.sock=0A=
-device usb-redir,chardev=3Dr,bus=3Dusb-bus.3=0A=
=0A=
The AST2700 guest enumerates the AST1030 gadget:=0A=
=0A=
root@ast2700-default:~# lsusb=0A=
Bus 001 Device 001: ID 1d6b:0002 Linux 6.18.36 ehci_hcd EHCI Host Controlle=
r=0A=
Bus 001 Device 002: ID 2245:1030 ZEPHYR Zephyr DFU sample=0A=
=0A=
Data transfer was also checked:=0A=
=0A=
2700 -> 1030 =0A=
echo '1234567890' > /dev/ttyACM0=0A=
1030 console: Print Data: 0x31 0x32 ... 0x30=0A=
=0A=
A functional test is added to exercise the AST1030 UDC through this=0A=
usbredir setup.=0A=
=0A=
v1:=0A=
  1. Make the SETUP buffer byte addressable=0A=
  2. Support single-stage IN transfers=0A=
  3. Clear EP_POOL_ACK when no endpoint ack is left=0A=
  4. Mask the reserved bits on register writes=0A=
  5. Use the endpoint max packet size for OUT transfers=0A=
  6. Test the usbredir server transport=0A=
  7. Add the USB device controller for AST1030=0A=
  =0A=
v2:=0A=
  1. Split the usbredir server transport into a separate series as=0A=
     suggested during review.=0A=
  2. Keep this series focused on the ASPEED UDC changes and AST1030=0A=
     UDC support.=0A=
  3. Add the AST1030 functional test using the usbredir server transport.=
=0A=
=0A=
v3: =0A=
 1. Finish an EP0 IN transfer at the status stage to fix an AST1030 UDC cra=
sh.=0A=
 2. Update the functional test to scan for the AST1030 USB device from AST2=
600=0A=
    U-Boot to reduce testing time.=0A=
=0A=
Jamin Lin (12):=0A=
  hw/usb/aspeed-udc: Make the SETUP buffer byte addressable=0A=
  hw/usb/aspeed-udc: Finish an EP0 IN transfer at the status stage=0A=
  hw/usb/aspeed-udc: Mask the reserved bits on register writes=0A=
  hw/usb/aspeed-udc: Clear EP_POOL_ACK when no endpoint ack is left=0A=
  hw/usb/aspeed-udc: Rename the transfer helpers after their DMA mode=0A=
  hw/usb/aspeed-udc: Store the EP_DMA_STS write first=0A=
  hw/usb/aspeed-udc: Pick the EP_DMA_STS path by direction=0A=
  hw/usb/aspeed-udc: Support single-stage IN transfers=0A=
  hw/usb/aspeed-udc: Use the endpoint max packet size for OUT transfers=0A=
  hw/usb/aspeed-udc: Add trace events for the transfer paths=0A=
  hw/arm/aspeed_ast10x0: Add the USB device controller=0A=
  tests/functional/arm/test_aspeed_ast1030: Test the usbredir server=0A=
    transport=0A=
=0A=
 include/hw/arm/aspeed_soc.h                 |   1 +=0A=
 include/hw/usb/aspeed-udc.h                 |  14 +-=0A=
 hw/arm/aspeed_ast10x0.c                     |  13 +-=0A=
 hw/usb/aspeed-udc.c                         | 309 ++++++++++++++++----=0A=
 hw/usb/trace-events                         |   9 +=0A=
 tests/functional/arm/test_aspeed_ast1030.py |  51 ++++=0A=
 6 files changed, 343 insertions(+), 54 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

