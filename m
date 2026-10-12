Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56757CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5ar-0006NH-UE; Sun, 11 Oct 2026 22:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5ao-0006Mh-Te; Sun, 11 Oct 2026 22:16:47 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5am-0004ly-93; Sun, 11 Oct 2026 22:16:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPXAD/8XWRNfPkDLCH0UCWzvHT7Bdc/5rD4w77VmOXw90SRbxASiqH5ioRl/BocCJjO7Tye2MoqVxmOfR9Z4IJfE/7KYVpnPW9cWr9X/qe5ofi0FWBqcD/jWTi5PXmnlJBbPVL3xAptiexFT+AbFqz+RHJ9joMQrX76LFxx+7J+x41FYvs7bmifyMSv+khiy7XpCEcO2NcG0JcbMcpU8kBBtC0u9S/ZYRANUfMmiSTMdhJTGBmHaTXoT7AIybwjWcGFy9S2TTcpNKwQlwQ2fQkY69CBJcIO3Bzw7gCqsnGmy0xruIzCrtBDXWATv15DFKZszrtTFWPMPYETfqTx3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm1RCoJokleNogpOHAv79Ze+74DPxFPGpcdAma4OPR8=;
 b=lJtAIiX+mOqf5i/uaegKbb+Wo7bp4jx5RemWy7tcZeBp+szTmEnujShsAj399CcaTI9n+frhmCxLoI+Y2ifDzajTAxFuMilvTpzxNBgpCvoTZwrHxN7NdzfOV36YdXM4/cUq+ICeuFlS7zQ0/KTSWrdK0H0iQsr6nFBtVaNwYiNEszkTryFKb6dVcfefYpzD8rL64U7jQZZMXY1dZgXGosTvvCiqqEexE0Jze0Cp7n4FcNl36zPg5HhN/NJ3aWENm50gAHBnbcOcSzpODs5PhScCwr4i2cnbZz15PV6G2pmk2QGsb2exQXepxF1gdBZXIalZDGsLExa/L8y6lCwQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm1RCoJokleNogpOHAv79Ze+74DPxFPGpcdAma4OPR8=;
 b=EMN5EirCGuPWzx14RcB4MNbqvKcPNZMSaUcj2ilm6/fnjbKsO2GFasUdqiiLMt7dMjAcnV83wjpthaWjRuPDqrUws5HWuFyR49/jV2JwaHzS1lNgtM/uBm8BBvPRxkdrL8GFeDN49yfcS5ocvVCP6GHs58uoNiYJ5asevcHizj0ekeFfMmqQ69nj3iwC5Rtb72TWMbI5nG3OHrIkiy32nF3kY5DfXN7kdqsRBLRAe68Sk56HswmdKxky7EftqAopnlyt+bwen/HnuLpQlrY7OrY96UQ1x9Agwb1DqNgVuogxpjLlhzOmlG0MogYG8yAmugHt8BeylzhK3LQUg/M2lw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:35 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v3 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdWe+0scw4Tjcj60yshy0Jz4Mc/A==
Date: Mon, 12 Oct 2026 02:16:35 +0000
Message-ID: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5398:EE_
x-ms-office365-filtering-correlation-id: 4aa16933-62a5-41cf-1e44-08df2806d74a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|10067099003|3023799007|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: p6ivAEEqYrK5cJZHXyW5dAxmSN7fvF89RcxHB0pDPJf7YCh88DnHAtGsKSinaJ6uT7ntDGPNobaUKgRYOeEUF5nQ65SpWeMinC24T56DpIKRn0n/dMtgnfjett2P4N6kjTEfFzI9GDy9ZBCFlLXwtwooAQKnH7JjJqShTdLckLb3Wa6bqpYf1+O+IKsrXeLr+7cwSIjojrrd2G9TdVkKAVbVWUlc0sVp5xawaL2YYLUKAbpluDOAYnxN1N5ktBenmWV99dlILgpiynlMyRi/wZRVzFr31/TIG2SG6W3zmmTq8I8yQxFHZjz5l5/NxKcJdNAzfA6uK3XpdgBftNtPVwZJycrBgYHCAuf/N2ewftASzuW13QAkdIj2CLIxsQRFl+lK+gWQY6fbnR2WCulvlVjbE63DSJ1oKxqE9gYXPNbe1yTYLG7yyVnN/nsJ+Tfxh9fbVDFrn+slvCQwL5ky4sPRE7v/O46PLU+tzoQcLTsXBvLyZ+ZqTfeOaKGMOMKYeAsuZXifUFMhtyiNVCCF49FPqwl6PV33RUhrnL1C0KO6MeXO/qCMT3pM1Bd2dCpjNSJ7f57Y14KXE+oDe/ykI8RS5DbkT0wUIl0/5zosuFoKMROYygOo8xXwBbAh85LH2SBhTV/vKi0OViZHHDJ1UIReq3aHaSX88/sAeLRsyNs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(10067099003)(3023799007)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KAnOAuqV85x0cOqocCdLFg0Ch+CkakxWb8aDjVol42aOXRjNYCqRUWe4dB?=
 =?iso-8859-1?Q?9GU7tCOXIUewZVUWIV7ZRUlnyNsHt+BGiCo2zGuBsqU52iE4NmnWAbVWJV?=
 =?iso-8859-1?Q?oqYWF0FUnbBSZnCmY3oRuMyOhDHixR4Q3VOReXcFc9XXFaet72goJmRU+s?=
 =?iso-8859-1?Q?SE6lfqqBee69JpSwuRlEVgphWmMZusHSgktDgkDWxyHereiCMqyJ6KlVWL?=
 =?iso-8859-1?Q?bJnWvK6L0IQqGGT0FxNIlx1Hc+PsHRO9lns6t8Lqk211eUSFN2E+9OE6k5?=
 =?iso-8859-1?Q?qI8Da8lteSQOBx+9kXYfP4QtedpHFrPnFxcyeMmkkOlICskUNOPBG4qn0o?=
 =?iso-8859-1?Q?XcAfCPPsntMcXrGd0/Eganj0sKoCMtTHRWASCPFflrKIDCG+/PAINZxOqp?=
 =?iso-8859-1?Q?pMGhdsARhBvnbjwiJ4n/QdvQhob3U7f3POSXDUGv2iIjA3xWbzAHGXPZQ8?=
 =?iso-8859-1?Q?Sm/6RKfONKThuy29h4eSKzgrKzdJsFvVau28hKkZewf3EFCCPnWrblvEx1?=
 =?iso-8859-1?Q?XENZGQLPtrketYmmJXp//xsH9wchigIIhCKrRti7bLcT2Q+S31hl52kzOD?=
 =?iso-8859-1?Q?7aJISNHqLQVIjWTqGh1SyzTVdgqI6SFGAdw9DxCMzBh89Dea+IbRL3+C2q?=
 =?iso-8859-1?Q?xho+xfuM66041q6LnedROp0wzpKVO7VWaU9OAEX9LNoZHTaExLbdjkSqHd?=
 =?iso-8859-1?Q?c4b3loY/ZwbbkWTehA/qfrPG0PJ/RYyhp5jpMvR9KZoWwRZHRTGXFP3IbM?=
 =?iso-8859-1?Q?pg2GtSKxEFWMQvBYI75SfkQQFGD7M1dJWs9ST5Y0zZWAcKLiduKINFvu8j?=
 =?iso-8859-1?Q?/ffZ9Y6MAaRvQSAdcZUVK7M2czIeluEpekqW1P21eeSLxJWGZeCtMFvd3s?=
 =?iso-8859-1?Q?9hiHsenQOdKq/EN2pOer+HrzKxHMlNFgi7BoogMDdN32BbmljaASNRIZnM?=
 =?iso-8859-1?Q?4anLY3hT7dihQb9HJsk7mEzhyzjT1Ju/wQxIZ1zKJQWsNmIbdJgKbJjGgU?=
 =?iso-8859-1?Q?cAtTP4y+nvoNp6ROUXAWQq+KnSw7olbJplJvqWfeovojwIRPcamBG1MYaf?=
 =?iso-8859-1?Q?5k0YI3vez/5ujMk/xAa3UhiSb9zkesZ/qSIsNjfwqjhxkOtsyZn26WxuQQ?=
 =?iso-8859-1?Q?HT8VBSvmB40hc85lOiwfCk4LoiS7mFk7esEuYIe04p0IkFR6r1z9GhcAYx?=
 =?iso-8859-1?Q?WGPMV5vCc3sPk2dM66ZS79wFQfhrJr2n37/7EIcpR4gIWPEvSWRkBDwqqU?=
 =?iso-8859-1?Q?+YI6G6tuZuZjKXyRR06suRLKHojbI3x/idAZst2Mh9ykDen/WQea+EX1FX?=
 =?iso-8859-1?Q?jG9CDFzswQyWFa64Y6QXcVfh/0mbvPyIuyOeC2458mLDRYxnUsfqjOwX9I?=
 =?iso-8859-1?Q?tKJIY7Py8tWnr5R8466k1MmCzm088eAixGbc0G2ucq1WI9TXmZpskU94Xg?=
 =?iso-8859-1?Q?puMXM6r5ARTPe8YmOTzUk5zhJMW1pUqv9Y2K3LywD3nuiyjGhiJLgw4dv+?=
 =?iso-8859-1?Q?kLT67LjXWlCPj8sfHz69VhgoiaIdtXLKxf0QXrg40QFcX8C5dfY5ycRvBZ?=
 =?iso-8859-1?Q?4iocBhZy7L/i8/f/v48A0eELdJXPRDcWZp4ACgPepiPb3ckXjF0XI/aTC0?=
 =?iso-8859-1?Q?4cElIa+aAmv3Fmd2OgBVBB66PeGS/qr26V+rcqQdFt2kUqtMiw/iWGnxWp?=
 =?iso-8859-1?Q?l78wQ7QL0zZxxnCP/SofxvLPQhMT2/i/AOMWQGuO+uEDf3wcTPzGAHV8Vc?=
 =?iso-8859-1?Q?okE06+VWT6pT1qZdMM+Q6zwGK8iVrvee/VRsNcWeslgkA96UKXyQ+PseRo?=
 =?iso-8859-1?Q?DbCr2LE/7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jabRIVJ6xZcm+ML4QJf7dc6TLLz2NhCFQ7ZFDfnxa0Q55ycyDyZSXnJaMGD8a4rlHdZW0B2eYLXF1/bmAikPe2geRgZJIXKi+ddOo7WWf1JmI0+w+vr5sM3Fk/xmDFRg+utM6YoDjIU9+gLtjiAi+ito9Z2oXI/iyds+s03Trjb966MGsFTnZQzsHzTzbf7EWHfv+pcpqnckfbc5y0XvqpkMJXJEpSBy2OyimyRho9CO/aO6hFKotyZVLgSGHBek+PrRVN3Ja3T24QaNz2NiVvj6aZYKqRdt8JWoeECv6mEjIoyGML8cmfF00m1tjjVZpB34b/4Sk2JgeSA6PhK/hw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa16933-62a5-41cf-1e44-08df2806d74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:35.6273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1KPFMIVTesDE6pjz0RePHwdT9T85RlSDjQmWFvuEG/1xshHTGjMIVzyfUz2MEOBrb+bzd+sPV8s3uhFr14d05JFmRBY6coC+j39YcgkT4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
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

This series adds a usbredir server transport to redirect a USB device=0A=
emulated in one QEMU instance to a USB host controller emulated in=0A=
another one over the usbredir protocol.=0A=
=0A=
The v1 series included both the usbredir server transport and the ASPEED=0A=
AST1030 USB Device Controller (UDC) support. Following review feedback,=0A=
this series contains only the usbredir server transport. The ASPEED=0A=
AST1030 UDC support will be sent separately.=0A=
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
The transport=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
x-usb-redir-server exports a locally emulated USB device to a remote USB=0A=
host over the usbredir protocol, so a device emulated in one QEMU instance=
=0A=
can be enumerated by a host controller emulated in another one.=0A=
=0A=
The left column is a request going to the device. The right column is the=
=0A=
answer coming back. The middle hop carries usbredir messages over a=0A=
socket. The top and bottom hops carry USBPackets inside QEMU.=0A=
=0A=
    remote QEMU: guest driver -> EHCI/XHCI=0A=
             |                     ^=0A=
   USBPacket |                     | USBPacket=0A=
             v                     |=0A=
    "usb-redir" (the client)=0A=
             |                     ^=0A=
    usbredir |   chardev socket    | usbredir=0A=
             v                     |=0A=
    x-usb-redir-server (the server, this series)=0A=
             |                     ^=0A=
   USBPacket |                     | USBPacket=0A=
             v                     |=0A=
    any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
=0A=
"usb-redir" (hw/usb/redirect.c) is the client:=0A=
  - it takes a USBPacket from the remote guest and writes it to the socket=
=0A=
    as a usbredir message=0A=
  - it reads the answer from the socket and completes the USBPacket=0A=
=0A=
x-usb-redir-server is the server. It does the same thing, but backwards:=0A=
  - it reads a usbredir message from the socket and runs it as a USBPacket=
=0A=
    on the bus below=0A=
  - it takes the result of that USBPacket and writes it back to the same=0A=
    socket as a usbredir message, for the client to read=0A=
=0A=
A USB device has to sit on a USB bus, and in QEMU a USB bus is always made=
=0A=
by a host controller. So x-usb-redir-server makes one and acts as the host=
=0A=
controller on this side. It models no real chip: its cable is the chardev=
=0A=
socket. The real host is in the other QEMU.=0A=
=0A=
The type name has an "x-" prefix because the device is experimental. It=0A=
has to sit on the sysbus so that "-device <dev>,bus=3D<id>.0" can find the=
=0A=
USB bus it provides, and that may change later.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported: the=0A=
protocol has no device address field. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
Testing=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
A plain usb-storage device was used to test the transport. The storage=0A=
device is attached to x-usb-redir-server and exported over a Unix socket:=
=0A=
=0A=
$ qemu-system-aarch64 ...=0A=
-chardev socket,id=3Dusbredir0,path=3D/tmp/usbredir0.sock,server=3Don,wait=
=3Doff=0A=
-device x-usb-redir-server,id=3Dusbredir0,chardev=3Dusbredir0=0A=
-drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw=0A=
-device usb-storage,bus=3Dusbredir0.0,id=3Dmystorage,drive=3Dusbdisk=0A=
=0A=
The exported device can then be attached to EHCI bus 3 of an AST2700=0A=
guest using the existing usb-redir client:=0A=
=0A=
    -chardev socket,id=3Dstorage,path=3D/tmp/usbredir0.sock,reconnect-ms=3D=
1000 \=0A=
    -device usb-redir,chardev=3Dstorage,bus=3Dusb-bus.3=0A=
=0A=
The AST2700 Linux guest enumerates the redirected USB storage device:=0A=
=0A=
root@ast2700-default:~# lsusb=0A=
unable to initialize usb spec=0A=
Bus 001 Device 001: ID 1d6b:0001 Linux 6.18.36-v00.08.03-gaf2f426c5786 uhci=
_hcd Generic UHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.36-v00.08.03-gaf2f426c5786 ehci=
_hcd EHCI Host Controller=0A=
Bus 002 Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
=0A=
This also demonstrates that x-usb-redir-server is not specific to the=0A=
ASPEED UDC. Any USBDevice can be attached to its USB bus and exported=0A=
to a host controller in another QEMU instance.=0A=
=0A=
v1:=0A=
  1. Add a usbredir server device=0A=
  2. Announce the exported device=0A=
  3. Implement control transfers=0A=
  4. Implement bulk and interrupt transfers=0A=
  5. Stream interrupt IN endpoints=0A=
=0A=
v2:=0A=
  1. Split the original series into USB and ASPEED parts as suggested=0A=
     during review.=0A=
  2. Keep this series focused on the usbredir server transport.=0A=
  3. Move the ASPEED UDC changes, AST1030 UDC support and its functional=0A=
     test to a separate series.=0A=
=0A=
v3:=0A=
   1. Move include/hw/usb/redirect-server.h into redirect-server.c.=0A=
   2. Drop the announce timer. The firmware does not toggle the pull-up,=0A=
      and the delay would be machine specific anyway.=0A=
   3. Rename the type to "x-usb-redir-server" to mark it experimental.=0A=
=0A=
=0A=
Jamin Lin (8):=0A=
  hw/usb/bus: Let a bus opt out of automatic hub insertion=0A=
  hw/usb/redirect-server: Add a usbredir server device=0A=
  hw/usb/redirect-server: Connect usbredirparser to a chardev=0A=
  hw/usb/redirect-server: Announce the exported device=0A=
  hw/usb/redirect-server: Implement control transfers=0A=
  hw/usb/redirect-server: Implement bulk and interrupt transfers=0A=
  hw/usb/redirect-server: Stream interrupt IN endpoints=0A=
  hw/arm/aspeed: Enable the usbredir server transport=0A=
=0A=
 include/hw/usb/usb.h     |    1 +=0A=
 hw/arm/aspeed.c          |    7 +=0A=
 hw/usb/bus.c             |    3 +-=0A=
 hw/usb/redirect-server.c | 1669 ++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |    3 +-=0A=
 hw/usb/trace-events      |   27 +=0A=
 6 files changed, 1708 insertions(+), 2 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.53.0=0A=

