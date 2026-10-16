Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF2CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHbTr-0007fQ-DD; Fri, 16 Oct 2026 02:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHbTG-0007Wz-KZ; Fri, 16 Oct 2026 02:31:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHbTB-0006C9-B2; Fri, 16 Oct 2026 02:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyL6jE6C9+ObQ5EIg7gXmdVuccNeHwFSd5ffPE7peAigbNHgHh1ar9ulr0E23SToNi3oa3uaXdRbFC2XDHhzilyS0OQax/JcAILrGtS36iB1SybxzdwdboMRzT6m7AcG7Ri8u6hVHEvCPFdrOTkutDQlW0xVsrQnG0TmbLgzc3ensy4S3U/z83I2uVklSmTALdMXi3cxyCoZGi6EN+J5knCDf8mhDSOkmncm/4X8Vj44E94CgsKmSftB7ppb9CYFb6NGx4DoWFx3Gdh7t8YpuaQ3ZKZRfAtNChgRsGRF+ADo4XYp8/hM5UigefZqIEqA1aZ9Coljf/yd6spyJcpX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtZJqYIlc07oRrl9iFaAXAo1WonnuzkdHtPcXRO7Tqk=;
 b=RMotLOQAuv6PkyVyajw8mKRuM17wEPuKN3V3JBzkDFrbJ1c436PQp5PbcP6QcneSbAp3zxbWU8YRZEIcxTejIQax0HxFYDtY7hpRdJ4ebQCJ7ozK7564bmVfMZbQb/ZOJ1Gy4wAVATlgA7FxD2i/328MXssbE+yASMKjTC2eNc732xzPGxtsD09YP4joD8JKhO7SjdcvdT1nZ4ncoWoGfgvC4ilXnxtvyTP7ZDJPVxC0wfvYRQTvqSjRWftYpP1PTNqyjmL0SWfXkyaTebhcn3TQeDDUH37NYHzjX1W+I1d2oupRTJ6beNREfuh+PsIWERXUnCy4ZZd4PGiUJUUDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtZJqYIlc07oRrl9iFaAXAo1WonnuzkdHtPcXRO7Tqk=;
 b=RozkMDAce8osYOIt9rtVfUmSy5aDocLE0u7nTS3kNTuKQU+owwcw3qd5iyeXZ3Y6hzJRs0vMQfswpG2iBGLcFBFeegvm6gHZvQKFE1RbIWdhczvHYNPCD64LZ4a1yOeDyib006fdFr+vbht+/y0p1dI9SQ3k90lznPCM7B/w7OjaX4uhTKcZslSPXsaLMjLXcjJMKEbZjRMWzYUdcjUYr46IGzWtD45+nf6CZLM3w43YfqXtkJmKSJbRgacHdBKnvVjSfuaCYxR/mOCKpgWi3y7XvKW7kyN7+BcJziG8A+yBmNgkU/I7MyMbighH4TelGNHI2WPH4KCLuLR3RaCXVw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 06:31:00 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:31:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdXIhZKh426Uwd8kuEqIWpGIQDurb/tdjg
Date: Fri, 16 Oct 2026 06:31:00 +0000
Message-ID: <SEZPR06MB736219AC450D3B79101424E7FC9B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYUPR06MB6196:EE_
x-ms-office365-filtering-correlation-id: 79b51211-e25c-45a5-991b-08df2b4f0b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|3023799007|921020|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: AmljBgnZD49iEFVv75rGCWYoZjYdPZWuVfvzfPDhGMyuVrwvJDRbEri/uZ0fYg6PkJ3z5UQmAkcZNaYwmyMyrsdpmrmY7LahseeluG29oCC9dhQP9m253G2h7FrO/hH06w0BtsTrKp2UM3aACFmdZ4vMP+EQ+H6WFRSnIxo1LZFiA568M77E05m7BvIz/n+zNt1JaFoC+a0Tx2M5kqdztLLtuudCksjUY72KP8lf8COQa88WydSInYATHj6UoIzxCE7ay4JUp4y2UQlFYBnR5WUKfDJQ6qva2CatoAKcpLrE/Jn8VFTdR7WMF6/JWAXIUFnNgBTfqegpmpgaCuizOuzWstdtKe0uxoWkJGpMC2k3SBn/BNRjYsbKQdjPKyY4E2BJ3Nhy+e1PxvYsFjQpmrhe7MquB+yJBvxETwhcw+EGGfvgQQaXg/AZ1gXo+d+3OXRYfT9/QzLtx/Noeph5saepoaZ2hG69gusrZNZAhKQVKMZDbegKoGdCPH5C/RCZI95a+ypyfQewqD0k/B2jbASpPFyp3SlNRb90qOVlOPGiQt6kKg45rsmrcuQ8Tq3PSnwtCNrFWEtB4dZCHX1domSAQX9ZlESb8124z4Mxr+c2c7UeL/HoIdOe3KfoF1rCxjFuCyREO7kwutdUpA2iu2vpHwQzfQtnLCFvUsdZCwa2BMIl2mYBLxBxKxPZztAz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(921020)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nEDljnwI8P+XfIce5gI6G75aKbLu3gL3MHLFpZnVW2hyGu1L8YWGGP5X1S?=
 =?iso-8859-1?Q?m86d/d0l986g//S8yC/38m4Frz44AvczZMItDETZUjqYMzTi+3DA8ApBbf?=
 =?iso-8859-1?Q?NO50vOtb8zlEsSO+iWPhZXpr62qdwABiLbbFFn9AHe8iXMIsgcWgruzSp6?=
 =?iso-8859-1?Q?DDKs/R492SVINXk5YW+/pJ+L1KXTBXLb16LrT+PDDQtBeo3oRcfdqleccQ?=
 =?iso-8859-1?Q?IkyT5+EPx+g1ORoAIMfnt9reQ2LCoQM9P7f+lFcbuaNMgtHDscjjnwkUVC?=
 =?iso-8859-1?Q?SZTL2m+bZ71Lsfe5zSUaRfy+W1ajBCLtOAdZzqFBK29OkCfr+wPfj9/md6?=
 =?iso-8859-1?Q?BWgrG7pK2sZPXPXou/k7zDqjrF2egs4JBkAaZnPPoYXzJkJ+rlXRJ5XMgX?=
 =?iso-8859-1?Q?Opn0lsbA01Z2k0ol2kszEJCYg1XySTVBx1IlW5nK7vSOWOJxV/18hKYbEp?=
 =?iso-8859-1?Q?TianEsThmF/6araFaD4B1ZCwaQlngvlmo1zGeyo5swsWnxFCFO77dAEFR4?=
 =?iso-8859-1?Q?+fYLHsUSKfroupeT7s8zbDWEaOiJ2GG6fKBJYfRXqop/McBdIKNe+/6quQ?=
 =?iso-8859-1?Q?VHLrz+6DW4CGu9lnwqxED5Hl0qXQvDqMpfPqLkBM3sa7eM71LDJD/W7bev?=
 =?iso-8859-1?Q?696hhvmaoaCm5qMsbZ97YJOsCq99KrOMHAH9Y63czXDuhbUAuBwOlEKHLY?=
 =?iso-8859-1?Q?ShED5iUaqo7tF/J5PmSQatb24DN6EWXTGKpqCjZnP5wP9SLMT26b3ybEDh?=
 =?iso-8859-1?Q?yUt5wezkat5TuDVZPTvI9HOECdpoeLbSc8WCtIzC+gAY3mPBssJ3faEoY2?=
 =?iso-8859-1?Q?+QeCVMFBcL99vbJJrO0+J7mNLpg3/m2smYD+vy37D1bjkkV4P5pNd8q1AK?=
 =?iso-8859-1?Q?fPAC15gGEafXd17cTyq1Bgcx0PJwPcwY9b6b7KhK2rbtZ6tGFbILSvpNjX?=
 =?iso-8859-1?Q?rwGgK+G7FTGQDs1OBqC9S2A8vD3FABKYCaLGhE0UYT4vrViJtmttS6WklO?=
 =?iso-8859-1?Q?AMjofTCvZgSyrSIg8cQ7pmvA1a2uBmDsz/zLqAmePAQjy+lnNznvgNI+3E?=
 =?iso-8859-1?Q?me+ZLK+eRGb8/Kp+2vAwjG6QGFqDUkEsdiDQwc8sKOn16nmKHqnI1IxolB?=
 =?iso-8859-1?Q?fRy/VqCXRVO5KzAr8hbNlcITfv9QmEyc93hl0Bp19zmkU2oM0s+Fl98CG4?=
 =?iso-8859-1?Q?9Y/6dLnvPhYZoqS4mC5pT1SaAYHKF4pi2kCf1Vvqb0ApTfPnpgUF/t9ATY?=
 =?iso-8859-1?Q?clEwiAPub8qWEAqqJGI0LfPUKvFhEqZx0Tbn1FkW5vEkTC6Wr/UkUw18ZL?=
 =?iso-8859-1?Q?VPciHPNLKVKt2glke3l0YZkX1D/Y2b2Cpr9V1fgiq7lLr9okfcOLLqtwNw?=
 =?iso-8859-1?Q?xG0quXkpdKKSPkHl6kVifSn0Z+VUGCHzH4bg9cZV2eBtyu5nNa9g5p2ZhR?=
 =?iso-8859-1?Q?mrhpQYFqgYypIBpBFsnibWA8XGxMNbSUlxksOFO5Lon840l3zPDOb57Tld?=
 =?iso-8859-1?Q?IeRDMN4WvHvssknTBOjWhMcoPhTZLTGtUSFakBTQ8I3/63D95psehGNNR7?=
 =?iso-8859-1?Q?bJdfhRmTn/3oZkhLZObJ/S/7+NYmWVfrfz6ZkxEdjJme9TmHAwm09C2WEP?=
 =?iso-8859-1?Q?ugEFDYBWKnP/GPQli7/drvgs9sEeJ3H/wjcE3Ci8lfRkEJVS0SkI7+S7CD?=
 =?iso-8859-1?Q?97xH8Ta2Bku1ruVZ61cO6dcTbJuBNc4I/UDJbddA8SW3Ah5jktZO1jhXbV?=
 =?iso-8859-1?Q?HPdsOb3aLcRLyQc2hbw7fQYXVaStdOpmAg6yNYm8VviN6WS6QH+KD2GLyz?=
 =?iso-8859-1?Q?/e+NRkS/hA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZJe+hcLejTu5TJ5LJmWZu3npuby5xiUd0ru7++KcROB6U3KWyZUiWgJ2OmyIDFvQ0ORZzFWaHB46S/Xs0KKLyK6YOeuzEUap38CSYNeUIdPZgUnAt+9e9EgentwcaEpbDFkiGX3l3Eex6BMvzOm8Y58MOmZ4U1KddONdSJL62C4F8/YRV5TRJI8uDIJHAllpQ28d4Xg+aLoiGLDuaWLMZoje3q3bvTpofQuduQuxJ/P3+ZlV8OOiAc/rC597dQMyPLtXz+vOUIp7C5uwSiLoo0MWNf2uZZYpyr1oAY+tqQZVTQhI07z910CTd0TtiPb6dQLl74hJCuZ4E/7rpmr/0Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b51211-e25c-45a5-991b-08df2b4f0b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 06:31:00.0411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5er7kqIjiZcSYyQafmtq0vw7a6IDMedPKdpPiVgx5AQaeLfRbcoE/nUq3GvZ//GhSKWCMBWhbDzSY6EWerPVYDIh4n94qS/CTCJQAkueHGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6196
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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



> Subject: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
>=20
> This series adds a usbredir server transport to redirect a USB device emu=
lated
> in one QEMU instance to a USB host controller emulated in another one ove=
r
> the usbredir protocol.
>=20
> The v1 series included both the usbredir server transport and the ASPEED
> AST1030 USB Device Controller (UDC) support. Following review feedback, t=
his
> series contains only the usbredir server transport. The ASPEED
> AST1030 UDC support will be sent separately.
>=20
> This work is part of a larger plan to model USB device-side support on AS=
PEED
> BMC/BIC SoCs, which has three goals:
>=20
> 1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB
> host
>    (EHCI) controllers, so that work targets the AST2600 UDC: its gadget c=
an
>    be attached to the SoC's own EHCI bus, letting the guest enumerate its
>    own gadget and exercise the UDC end-to-end.  [Done]
>=20
> https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@as
> peedtech.com/
>=20
> 2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UD=
C
>    needs a second QEMU instance. The UDC gadget is redirected out of the
>    guest with libusbredir and attached to another QEMU that runs a USB ho=
st
>    (a VMM, or an AST2600 / AST2700 guest).  [this series]
>=20
> 3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media
>    support in QEMU.  [future]
>=20
> This series implements goal 2.
>=20
> The transport
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> x-usb-redir-server exports a locally emulated USB device to a remote USB =
host
> over the usbredir protocol, so a device emulated in one QEMU instance can=
 be
> enumerated by a host controller emulated in another one.
>=20
> The left column is a request going to the device. The right column is the
> answer coming back. The middle hop carries usbredir messages over a socke=
t.
> The top and bottom hops carry USBPackets inside QEMU.
>=20
>     remote QEMU: guest driver -> EHCI/XHCI
>              |                     ^
>    USBPacket |                     | USBPacket
>              v                     |
>     "usb-redir" (the client)
>              |                     ^
>     usbredir |   chardev socket    | usbredir
>              v                     |
>     x-usb-redir-server (the server, this series)
>              |                     ^
>    USBPacket |                     | USBPacket
>              v                     |
>     any USBDevice, "-device <dev>,bus=3D<id>.0"
>=20
> "usb-redir" (hw/usb/redirect.c) is the client:
>   - it takes a USBPacket from the remote guest and writes it to the socke=
t
>     as a usbredir message
>   - it reads the answer from the socket and completes the USBPacket
>=20
> x-usb-redir-server is the server. It does the same thing, but backwards:
>   - it reads a usbredir message from the socket and runs it as a USBPacke=
t
>     on the bus below
>   - it takes the result of that USBPacket and writes it back to the same
>     socket as a usbredir message, for the client to read
>=20
> A USB device has to sit on a USB bus, and in QEMU a USB bus is always mad=
e
> by a host controller. So x-usb-redir-server makes one and acts as the hos=
t
> controller on this side. It models no real chip: its cable is the chardev=
 socket.
> The real host is in the other QEMU.
>=20
> The type name has an "x-" prefix because the device is experimental. It h=
as to
> sit on the sysbus so that "-device <dev>,bus=3D<id>.0" can find the USB b=
us it
> provides, and that may change later.
>=20
> usbredir carries one device, not a bus. A hub cannot be exported: the pro=
tocol
> has no device address field. To export several devices, run one
> x-usb-redir-server per device, each with its own chardev.
>=20
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>=20
> A plain usb-storage device was used to test the transport. The storage de=
vice is
> attached to x-usb-redir-server and exported over a Unix socket:
>=20
> $ qemu-system-aarch64 ...
> -chardev socket,id=3Dusbredir0,path=3D/tmp/usbredir0.sock,server=3Don,wai=
t=3Doff
> -device x-usb-redir-server,id=3Dusbredir0,chardev=3Dusbredir0
> -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw
> -device usb-storage,bus=3Dusbredir0.0,id=3Dmystorage,drive=3Dusbdisk
>=20
> The exported device can then be attached to EHCI bus 3 of an AST2700 gues=
t
> using the existing usb-redir client:
>=20
>     -chardev socket,id=3Dstorage,path=3D/tmp/usbredir0.sock,reconnect-ms=
=3D1000
> \
>     -device usb-redir,chardev=3Dstorage,bus=3Dusb-bus.3
>=20
> The AST2700 Linux guest enumerates the redirected USB storage device:
>=20
> root@ast2700-default:~# lsusb
> unable to initialize usb spec
> Bus 001 Device 001: ID 1d6b:0001 Linux 6.18.36-v00.08.03-gaf2f426c5786
> uhci_hcd Generic UHCI Host Controller Bus 002 Device 001: ID 1d6b:0002
> Linux 6.18.36-v00.08.03-gaf2f426c5786 ehci_hcd EHCI Host Controller Bus 0=
02
> Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>=20
> This also demonstrates that x-usb-redir-server is not specific to the ASP=
EED
> UDC. Any USBDevice can be attached to its USB bus and exported to a host
> controller in another QEMU instance.
>=20
> v1:
>   1. Add a usbredir server device
>   2. Announce the exported device
>   3. Implement control transfers
>   4. Implement bulk and interrupt transfers
>   5. Stream interrupt IN endpoints
>=20
> v2:
>   1. Split the original series into USB and ASPEED parts as suggested
>      during review.
>   2. Keep this series focused on the usbredir server transport.
>   3. Move the ASPEED UDC changes, AST1030 UDC support and its functional
>      test to a separate series.
>=20
> v3:
>    1. Move include/hw/usb/redirect-server.h into redirect-server.c.
>    2. Drop the announce timer. The firmware does not toggle the pull-up,
>       and the delay would be machine specific anyway.
>    3. Rename the type to "x-usb-redir-server" to mark it experimental.
>=20
> v4:
>   1. ep_info now says what the host chose, both the configuration and the
>      alternate setting. Keep every configuration descriptor, not just the=
 last
> one.
>   2. look at the request type too, not only the number
>   3. wait for the endpoint's bInterval before asking the device
>      again.
>=20
> Patch 7 lost its Reviewed-by because it changed. It used to ask the devic=
e again
> from a bottom half, which runs as soon as the main loop comes back. So th=
ere
> was no wait at all.
>=20
> A keyboard answers NAK while no key is down, and the retry timer paces th=
at,
> so it looked fine. usb-net's status endpoint answers every time.
> The loop never stopped: ask, answer, ask again, about 17000 times a secon=
d.
> The same main loop runs the guest's timers, and it had no room left. The =
guest
> stopped feeding its watchdog, and the watchdog reset the machine.
>=20
> bInterval is the rate the endpoint asks to be polled at, and the rate a r=
eal host
> controller uses. The stream now waits for it.
>=20
> v5:
>   1. Use a separate timer and bottom half for each endpoint.
>=20
> Jamin Lin (8):
>   hw/usb/bus: Let a bus opt out of automatic hub insertion
>   hw/usb/redirect-server: Add a usbredir server device
>   hw/usb/redirect-server: Connect usbredirparser to a chardev
>   hw/usb/redirect-server: Announce the exported device
>   hw/usb/redirect-server: Implement control transfers
>   hw/usb/redirect-server: Implement bulk and interrupt transfers
>   hw/usb/redirect-server: Stream interrupt IN endpoints
>   hw/arm/aspeed: Enable the usbredir server transport
>=20
>  include/hw/usb/usb.h     |    1 +
>  hw/arm/aspeed.c          |    7 +
>  hw/usb/bus.c             |    3 +-
>  hw/usb/redirect-server.c | 1812
> ++++++++++++++++++++++++++++++++++++++
>  hw/usb/meson.build       |    3 +-
>  hw/usb/trace-events      |   31 +
>  6 files changed, 1855 insertions(+), 2 deletions(-)  create mode 100644
> hw/usb/redirect-server.c
>=20
> --
> 2.43.0


Patch 3 does not build on current master since

  13d2f5e4b0 ("chardev: add CHR_EVENT_RESIZE")

QEMUChrEvent gained a value and the switch does not handle it. I will
fix it and send v5.

Sorry for the noise.

Jamin

