Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98FFCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrD-0000Jv-8H; Thu, 15 Oct 2026 05:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr6-0000IF-RN; Thu, 15 Oct 2026 05:34:33 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr3-0006DP-Qr; Thu, 15 Oct 2026 05:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMuvpJqkvOkuBS2YFQvJfoGuTRRoxtdFUYdQtB6hlrDh14fT7fnPwpu5tisqyr1d3tiIU81k/C8WEPVlGbAtBohm/j3eb0y4l+dN36C8eL0mzfgYrfcITQ2rQqAJCUr349WAhqGSdY2GAcT5Vk0WL4dT9CPYBsYpyLDK1NA3ukD8T+EeZJyAuq0ib9TfANDSIJxA0NKRD/DXRJZlQ9p5/bkKASFXPIswj1Awp1Skk2Tqol/EsFMq9CsJyJcaztMTlcIADBJbwoKL2hkpqgyeFMYeW3YtK+bBOS3JW8jAuL228W7c130aQ6LjBACwN8QglbTWsBjRmgkJgav6paXZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoIdk+bIu91xNHY/z+G3v2+Q6AidKeXa+hnwvGsnAU=;
 b=n1NWMZ4DS+i+UNZjcxAqxKrrcW1shaLfYObOTr/h+zX70N1FrG7r4ugnS40wU1xZ5CxJlcXIHz0CLioINXzUKBuPCTn7RoZ86+JlC3hpCdMrWlgpf00wH5yN72+xGJaS/CnvfCsISwiCmvxZgRIu0MaC0Wc4E56W9SmR4SUffeTN2DzdOtybiGsEX+8+W5F6LeiqeYOQ4K/z6X9cwbpLC2439cWmEDp8K8JOjEzWBQ8gqBgDaLfjwobPaUqPANaOe3tlG2VTTUk5IotQ3iCaAfYOEfcb4DEBLEhaqyVb+3vbYhIYUlqXTexDPkRrVOqHrrUjy7DB2pm2QGDjSCpf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoIdk+bIu91xNHY/z+G3v2+Q6AidKeXa+hnwvGsnAU=;
 b=p22Q0sznrPhxI/2yV+H93oTvbqPIuVz5wybEEPkuO9rWwA6DgNA5Wv6I22dB1O/xRWa81mj1NniPi5zyRnp0ZuNXY0VfUJLAkhfUhR5Ywesph7Fr9/4CwVPD1BVasHlxx+f1Wqs0cF5WMAgp4PXp39gt9AZPAkTvnFrOIh6U231ajk/StcAqwo1tTXRA2KewkXPGSbTqDDboncd26p0e4z00Tb7HxwtSAIiMsBMagauCxPKdup4lwBVnmXEFE7IkBKZYazpy16xn5SBWZHVx3hfH+hGNGEB9eCe75RNeJubiH+v7+4r0b20UTysqexidGwkvBCpb0WpolEaHmB2ehw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:20 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 2/8] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v5 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdXIhaGxQ7G6gD/kW/RmXUHtdUfw==
Date: Thu, 15 Oct 2026 09:34:20 +0000
Message-ID: <20261015093417.573063-3-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5527:EE_
x-ms-office365-filtering-correlation-id: 46722bcd-f6f9-4ba7-b8c1-08df2a9f7d65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|921020|5023799004|261009223027099003|260925021911599003|22082099003|10067099003|18002099003|260925022911599003|260925021311599003|3023799007;
x-microsoft-antispam-message-info: MG3SsWJedtI3UTEJWyr/szL4kZHLxz6R3/YoJk5Q+zZw/YcfpsSoaVaPEEs7RGotNRSjuWk8s55yahP8DA6sRsFnsLVHBdVbKGzIxEej7k0q5xa3VwiNxURuzZlYflITVdp69xnKjcqKVgHFN+mdxzuHpqW7Eab2whwyvub+RmwlPjLHvSLDBWfOIKPy2f2fBpRvBRYyBJJuFPnkeSrwl7Gb3A9Ije2Vwnuj8zeMEJXplI9auLvc7ufkB4BunAkyalN0WcONmtu7ps/vksEIZcL8qp8+dnOn2wfmZotpBSkbWLT1bmldj1p66ce0B0pOuhLM6dexjVujzRCXOqC0itSFz4bcilAltOJSDZRbkCETrCi8GwIADtquNjInlshum0Zj28zgqVxV/QGDeKYBngQJvqotIURrWyLPne2xx4FaBICJxrhqGQMbIvj3pdzSa8NOLSQD35hQiSxF/5hFdh5xauo1MDicrn1cHqbGh9WZqZDQkbOJUJqDObFvgy3tW2LIcdQCdPXOn3XhGOCdD0T6weOH+hmRf1gxaquZuZUw15U30dpSIQUQYSUisV4YHXEiPd0YZn5HT0o1gYG4rPDFPqZ3vZLFifc656LNtyRPgtJmq07MeQlH2NvxupQaKdDtWjfsvlNxNpMb3l/gzJeujtetIhkPskEVdvFJLiJEfbvW/TaXVUhazTjQ9Maag12I6YZpPtr65MKzHqVrFuRF2t7R0EqigGovnqn204mV1Yl/dfLVg/8Ju9ezckjk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(921020)(5023799004)(261009223027099003)(260925021911599003)(22082099003)(10067099003)(18002099003)(260925022911599003)(260925021311599003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wlR/5wXgaN/XIk4bXuGf/BOdouB5FVxiHTVf2yo9QAt7J3Js8Leyr7KM3o?=
 =?iso-8859-1?Q?h5zm+3ghwPJUIuebqHEsNfHs8e9hIi9wGSR4SSQ9Sdqewz1But1uPa8SAr?=
 =?iso-8859-1?Q?za6nGBszO4J4bWUVOPN6bC88BJUmI6vPFKlryZ184GNHan69d3P9QsLmXP?=
 =?iso-8859-1?Q?Q7KhUYFZDKyebV4Pta6vYlm9ZNy9blzsd4upnz5SnD76fQlV5q09mPt4eN?=
 =?iso-8859-1?Q?L8U13taW8pd24YO/HAXUvFaT1S2nVQ+RikULYdW/nCb+swa+iSRCzt+DYc?=
 =?iso-8859-1?Q?rlo2DIj3f74fkHSkJizYz4+ApRBxdP8Yw2X+yBtgnXjZoyWGHP0W+cML55?=
 =?iso-8859-1?Q?EMnd+b4hE9t8MWQQxftpflJOcxrmp0h72ghFB77pEdczlCSqLv9MGr5g9d?=
 =?iso-8859-1?Q?r6hw/o8uDXI0GALkmzjBDBujOb4Mc2jqIM5FNAw+QWDb3mGbJMWWLcVgZL?=
 =?iso-8859-1?Q?XdQw5VBOEzhq1KIqa44J6WrwD1Jav6Jkmc5jWQh0UwzvBEkSmMoPsL278w?=
 =?iso-8859-1?Q?uJawhKJD85G8xT70DY+cfga71r2DI6pfNNUdygk568hNBR+6LhIEJqdBHM?=
 =?iso-8859-1?Q?zYCzJYs0uTcq+mFWJRycZi7gVqWly4bhfFXDOnkhYpU67SbxxAHokYDt0W?=
 =?iso-8859-1?Q?Syz5K/QmIk/PgZjQA4d5AVKNPQV2h/KNfwfuiMYwFkqHiGrcxedVbgPvNT?=
 =?iso-8859-1?Q?skFX16VVbGfwTHddl9eoHFGSABMvtNJp1HL14uD2BKczHFR9t9Lei2P9kQ?=
 =?iso-8859-1?Q?dfVjg7IoruuP+454e93zcQiIi8NTTRCZJBiOu6dKKWRfdiVq5nDmE5ggD6?=
 =?iso-8859-1?Q?gLvyo8aX/HfQ3VWvd9fhBqU+J8lW3fhfZLyS6lMZ9ZWZveYgXBzOhIwhc/?=
 =?iso-8859-1?Q?+CElevxWOCaC25/aZFaP2O8c8ZICBhex5Qi1f4MGkVX8Eg/V6oWtv06gG+?=
 =?iso-8859-1?Q?R7POK7tgajySh4Udo7c/AVKJYS72gsmuZ27IZtVbZenzsqhg9nfWfSEHTK?=
 =?iso-8859-1?Q?zZjZaxaEbWMds/toJDwAyn/KdLOYwfjpPmLICTWaTOOvhw0sTjeFGW9+Wf?=
 =?iso-8859-1?Q?Wietc0V9sA58Nf6gsHPAekAMyCMSOu4sh6yXJWsVgzg3O17d0XU+OXipQX?=
 =?iso-8859-1?Q?lPXQE4fTQv1po9qj45m+6KztYUICE6Ro31kOoxmWBLtBJsLuJLZWdJDbJ6?=
 =?iso-8859-1?Q?VFgnJXXQmGofPefbNSoSSmCe5pc/7luxhavfdHhDhu91wCdPtmdeqWZGJc?=
 =?iso-8859-1?Q?Pt/6yopyZeiPGRF5Gyg2KPorLVACNfn6cVV/z34C/3WFopByPbSAFHI0lC?=
 =?iso-8859-1?Q?0mtwoZF49kHvB75Yn74oO4KlZD1jFm4kJ5eopIFMG3RkfpR/25PbOPq+IC?=
 =?iso-8859-1?Q?EQDArcpKfTk2Jc175I0ExoNzpJdkkedE7SR2vWWOTqlqMJ+TPhnZB1LQ9t?=
 =?iso-8859-1?Q?MRGBjCWeHtY5ncWKz29XWOdD8GxSUiPXJr3JK2g7moUj3Tol0dxUxGkq2T?=
 =?iso-8859-1?Q?zo3jXxnZE3T2mlVywrBqiG3sU4Uk3HH79J082PzOsfyuBGOHuBYW3ApHif?=
 =?iso-8859-1?Q?4TWkAeo4Sb8peFGl20VH+QRM+IGK95MDy0pIQ8rN7LEqzMTvpfZuop5hSZ?=
 =?iso-8859-1?Q?QYAgx8WPy2+kh87zt1XCYxKAcQ8zqv8LNQ5Z5/oB4Og4Tz4tT1p3VFE/LO?=
 =?iso-8859-1?Q?eudGpLPSpQCuJDNSuGnW3QDnzAtkqzvdVwnPzS3BUA6Wz58Mv80+AWDiig?=
 =?iso-8859-1?Q?3PNlY09hSEtku1PBeY82PcJJ4zPLqFlHEak7ua0YiLMp8yjpfwnqXQjSxU?=
 =?iso-8859-1?Q?VgmlA4AbJQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Eqst7D/0iH9n6XWHddIpfB0oEiRBxrxhZKi/LjDPsqytmqyQe/A5C4pbrdmyY9tf8WiBxCHnZ22jJhyT4RxbEkfWWkB3zeAKdSu1XDgEJyPuiL50H+nIT/2UG8ZCwwvJgUP1ImBF5irIe7TQv3jNVl3iuyF8ZEqWcqMjNcJ24j4ls/b66w/c4fBx8SOlpyIkar7JEk8iqk4U3vwE4Kmo2kn2WMh/z1d6KOu6JtewH/j84kVkris8COwtPiPxIJUfCxSBKnu+p8iFl0h3ICm8p1Yv9IKiaIdgeWw1Cn+c2fHGCK0ozTottmWrC+xGUWr2mLgPXdXD1nPBGpbDpIwEzg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46722bcd-f6f9-4ba7-b8c1-08df2a9f7d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:20.1642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oLtvpBQ5TlkF3lbXoS9MQI3GpH0zEDxixiJ9QoGzIofRZk24AdKMDx0RdG7DqUv7L7r5Pzaf3HxN7R67HUKeU7wsKz8KGLEaY9VCqBajtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5527
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add "x-usb-redir-server". It exports a USB device from this QEMU to a=0A=
USB host in another QEMU, using the usbredir protocol. The other side is=0A=
the existing "usb-redir" device.=0A=
=0A=
The name has an "x-" prefix because the device is experimental. It has=0A=
to sit on the sysbus so that qdev can find the USB bus it provides, and=0A=
that may change later, so the name is not fixed yet.=0A=
=0A=
The exported device is plugged in with "-device <dev>,bus=3D<id>.0". So we=
=0A=
have to provide a USB bus. To find that bus, qdev starts at the main=0A=
system bus and walks down the tree. A device that is not on a bus is not=0A=
in the tree, so the bus it provides cannot be found. We have to sit on=0A=
the main system bus. That makes this a sysbus device, even though it has=0A=
no MMIO and no IRQ.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported because=0A=
the protocol has no device address field, so only the device on the=0A=
first port is redirected. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 143 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |   3 +-=0A=
 2 files changed, 145 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..bc883add0e=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,143 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Exports a locally emulated USB device to a remote USB host over the=0A=
+ * usbredir protocol, so a device emulated in one QEMU instance can be=0A=
+ * enumerated by a host controller emulated in another one.=0A=
+ *=0A=
+ * Architecture. The left column is a request going to the device. The=0A=
+ * right column is the answer coming back. The middle hop carries=0A=
+ * usbredir messages over a socket. The top and bottom hops carry=0A=
+ * USBPackets inside QEMU.=0A=
+ *=0A=
+ *     remote QEMU: guest driver -> EHCI/XHCI=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     "usb-redir" (the client)=0A=
+ *              |                     ^=0A=
+ *     usbredir |   chardev socket    | usbredir=0A=
+ *              v                     |=0A=
+ *     x-usb-redir-server (the server, this file)=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
+ *=0A=
+ * "usb-redir" (hw/usb/redirect.c) is the client:=0A=
+ *   - it takes a USBPacket from the remote guest and writes it to the=0A=
+ *     socket as a usbredir message=0A=
+ *   - it reads the answer from the socket and completes the USBPacket=0A=
+ *=0A=
+ * This file is the server. It does the same thing, but backwards:=0A=
+ *   - it reads a usbredir message from the socket and runs it as a=0A=
+ *     USBPacket on the bus below=0A=
+ *   - it takes the result of that USBPacket and writes it back to the=0A=
+ *     same socket as a usbredir message, for the client to read=0A=
+ *=0A=
+ * A USB device has to sit on a USB bus, and in QEMU a USB bus is always=
=0A=
+ * made by a host controller. So this file makes one and acts as the=0A=
+ * host controller on this side. It models no real chip: its cable is=0A=
+ * the chardev socket. The real host is in the other QEMU.=0A=
+ *=0A=
+ * usbredir carries one device, not a bus. A hub cannot be exported:=0A=
+ * the protocol has no device address field. To export several devices,=0A=
+ * run one x-usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
+=0A=
+struct USBRedirServer {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* USB bus */=0A=
+    USBBus bus;=0A=
+    USBPort port;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB port ops=0A=
+ */=0A=
+=0A=
+static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
+{=0A=
+    /* We only export the device on our own port. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_wakeup(USBPort *port)=0A=
+{=0A=
+    /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
+}=0A=
+=0A=
+static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .child_detach =3D usbredir_server_port_child_detach,=0A=
+    .wakeup =3D usbredir_server_port_wakeup,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB bus ops=0A=
+ */=0A=
+=0A=
+static USBBusOps usbredir_server_bus_ops =3D {=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Device registration=0A=
+ */=0A=
+=0A=
+static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    /* One port: usbredir carries a single device. */=0A=
+    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
+    s->bus.no_auto_hub =3D true;=0A=
+    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
+                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
+                      USB_SPEED_MASK_HIGH);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The link to the remote host is a chardev, and we cannot migrate=0A=
+ * that. So this device cannot be migrated either.=0A=
+ */=0A=
+static const VMStateDescription vmstate_usbredir_server =3D {=0A=
+    .name =3D TYPE_USB_REDIR_SERVER,=0A=
+    .unmigratable =3D 1,=0A=
+};=0A=
+=0A=
+static void usbredir_server_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "USB Redirection Server";=0A=
+    dc->realize =3D usbredir_server_realize;=0A=
+    dc->vmsd =3D &vmstate_usbredir_server;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo usbredir_server_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_USB_REDIR_SERVER,=0A=
+        .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(USBRedirServer),=0A=
+        .class_init =3D usbredir_server_class_init,=0A=
+    },=0A=
+};=0A=
+module_obj(TYPE_USB_REDIR_SERVER);=0A=
+module_kconfig(USB);=0A=
+=0A=
+DEFINE_TYPES(usbredir_server_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index 429dcd6a24..0061b935e6 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -78,7 +78,8 @@ endif=0A=
 if usbredir.found()=0A=
   usbredir_ss =3D ss.source_set()=0A=
   usbredir_ss.add(when: 'CONFIG_USB',=0A=
-                  if_true: [usbredir, files('redirect.c', 'quirks.c')])=0A=
+                  if_true: [usbredir, files('redirect.c', 'quirks.c',=0A=
+                                            'redirect-server.c')])=0A=
   hw_usb_modules +=3D {'redirect': usbredir_ss}=0A=
 endif=0A=
 =0A=
-- =0A=
2.43.0=0A=

