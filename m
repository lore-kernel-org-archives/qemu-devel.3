Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA0CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHr5-0000I4-T4; Thu, 15 Oct 2026 05:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr3-0000HJ-4a; Thu, 15 Oct 2026 05:34:29 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr0-0006DP-1U; Thu, 15 Oct 2026 05:34:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAs/kLqsqlfYu0sjGDpYeHsuzs/kZfqq1Ju5R54SAtuRnqiOUKphuQhFWXSOgys+VC22VK0O+cvkoBSUN28zNq8pWQdITSCf8nGRiT++ZKX9754kKuCRnV+A2R2FgxPDFivBz5FAeXTFxeGqjMZsQ6Skm1ZDs3Q3fG03jqMVDJId8gUavsa3XVuhGq7SCh7JUK+TUIWCF+sQUqNw8wM5colo/i8C/PbB7hUEJ2XDCLeUWY25oJa6NHJya1+8bQE2gfcxty34IvPnR2t4skijTukDqsIl8u2SVUlwdBzdhQvAVmTsc8cgpyvgPtU60ttbY2BaHR+f+vJOgzsGDPjtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il9uuVv3uZXKc+TZrWSUh3nxtcgoYeeV75v0RaKNZFU=;
 b=yZt43nDr67hDiuaiBKYrC+WmWJrpluBJAyooHxbF4z7svnCf2Z34FQ37jlCWzBrQ5Pnq/KbhPufywvWUMACIOE8Tt7VzkO+FMoRPi5nbfgMEx/lcLVyumZnOz39+7TV85Ve8lJR5iZtJMOi8/Knu3L87wQO8hyV7OFR51XP2/GLVGT/CjLFtVkzucDOhOVwPkxD6r3B1LnpKVk/zjiGuy6ZXDJVxQet5nrb5ld5MxL+4f6FKkINOKuJ5W3DcB45TaVAeEeOWQ3QWJYl2XbulZA4dS4fFvpb1N/V4zjNvCwaboV1EMdBvdQwxN7AI2ExbgvEERRAnQqzExwhXs3AKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il9uuVv3uZXKc+TZrWSUh3nxtcgoYeeV75v0RaKNZFU=;
 b=DYVsqOa5Ltb9gMuBMfWYMCzo50k5QG+AIJOd3zIdGJeO0XphhqRdUdnUdU+Ga5QnaZkAxb5CmmNM95nXcRmE5Ah+D1JOcEWkuhS5YM1Xp/zgzKgCUQkF9vuuiqx/C6nXdxdiCxM+czj81TRc5vBQm8znd1+OesT66j7aZwcnU46gdSMNn/wyVPn5bV9TD0w9VnSCBcNhkl25UirDBcgK8p02UjmIDmI0dwYcz/HCQudakjXk7yeEA7jkBNsxGTBx8Dg3Pxx7KGOGYnmjExPHzecjRO/ydHgLEgzkNAM+fliiVKe0m1l5NHSzz0oQ8Zl57QMjdoIwbQ36L1St4/3ipA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:18 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdXIhZKh426Uwd8kuEqIWpGIQDug==
Date: Thu, 15 Oct 2026 09:34:17 +0000
Message-ID: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5527:EE_
x-ms-office365-filtering-correlation-id: d0202990-069f-44cd-a8c9-08df2a9f7c12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|921020|261009223027099003|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: KMKlHm8mypcFBNKO0z8sRknszQZBhvvAzlGuq0BacQieUvQarcZmflXLhbyosWQF8e7RWS9D/E9v5dXUhkE1vNkwzIN4l63j4f3VfQN9vOh3X72Cp0w8dHd1S4v1ZVOa7404xiPwWuAkcRkyeCYlwFsYkoPatgZJ9rK/+aEQHohaGqqk6YQMyE1FzBV5Mxox7i17AIx/hHSpNbjtbe6y5aHy5wvTNqa1U2RrawUeeQlcVjR0OHfV0NAnp6N7fo6DPisax0EMA4pO59xgWIyzRcYARbXqW6yNrvSK8ofgNJVr2f/jDGEhn7En98Rl/I50t9+v46eytPLm1BWIXM+mJ34QoAyx7/QqiZcZC3AKbr6y/CMgXyMu4NVDyLHTmSvKC4JIzH2/KhphW7wPizvcWfHGhofcDQ04kqMYm/vt8d1W8XQxZRO1KJrAoNv/WCysQVtD3rwmEPEID28qxw0Zm/N7H3CZtHury0YbHjqmovsCjaVrbE1950cMWPWuokMTEAgrtqc7OxysgNZszNYwUbubnSgu+Tn9ktmkaUlxqBQ/sP+rKVQ/aqUTJGeO70/V2MXfVyVPTwnItdLzTkLtOF6VibRLzKcBiAk1Vx2Jrz/yhnFRdJdskEsU1h4d3ku+FF04p2VQgpFt4IB6qoJ9NIZt0u4SbnroPnKaj410OVwZM+4oAHO68sozYz7fi1MY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(921020)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SLYt93mdLfTEoeqKvb848vbeo45m+VcwI7JAl2A/RLsPc+RdX3z+VlXo96?=
 =?iso-8859-1?Q?TT/3NJfWDuZO16aj+2i7LXJjNQvkc4SAKzB1Ztrvz3mkquRj0eDm+1nLbZ?=
 =?iso-8859-1?Q?8PmP8w4H3QnOHAM5CrOV4np+RMKntC7sTBfyDnCdp2M7uHqWyWJWem4yMw?=
 =?iso-8859-1?Q?cjnMuq4rwrK57my/XVVJb9tVSp64HnpbSO3XXuzl4oi38asl43Gwfkperw?=
 =?iso-8859-1?Q?DEUrXjRD493PEenmqCDMVyOX+tlB/X5s2kFjFezjXOz9G6sdIBhoozPbMj?=
 =?iso-8859-1?Q?6PKvFh9Il34yG4oDykQVLICL3WxMWHAUslsAeA+RIOBDumyM3UQV5rxoMy?=
 =?iso-8859-1?Q?M+IwI8kCOwYzJu77BAUuXWkb0w6zE7hvZGFD4T2NiUI956esYPefaM4WZl?=
 =?iso-8859-1?Q?k0tAqV9wTB8dRvvCAfAdvUn24kNYlq4E3/degWJBlnzX3e9XzrmIs8LfHi?=
 =?iso-8859-1?Q?Fijl4faJDXJJEtdIGb/9sQYKh9p+gL7I5DUz3B7LVKz7R1C0X296AdC2XQ?=
 =?iso-8859-1?Q?waoFA7GVgHvt+yQEiDancj+32yCSApgP9XUDVNNxknmKqWQo2EgnhVQpuF?=
 =?iso-8859-1?Q?dE1V73mSxtnfo+NV1salEwGdcdV/AP9AEalPrxeNFR6uxXdfAe228tQvGm?=
 =?iso-8859-1?Q?zdZRMmIsTIs9XKeBTGiM5xomytHzt4lloTmTld9yP5Q3Jkw9AvMZraovC5?=
 =?iso-8859-1?Q?tlVX86dpu3xil/OJxuNzDNO1mUbo+/BhKxn8pSOhVOVu6dGXQsFdfmH7ID?=
 =?iso-8859-1?Q?y54LzMzVSa1o/0a33KasyMRVGDthLCQboexfR1kYp5IbgZnWNAztku7s8z?=
 =?iso-8859-1?Q?INkKTRTn0vm3/W39lBKf789hMBJgI11FnIJ5BzTW4T9fzbQwx0nmWVnUbp?=
 =?iso-8859-1?Q?hUCD/sP/ezbjXNSvuEt7g0zyyXee3u0ZzpyX5GtRFMW6mEu4xWLbqGJIo6?=
 =?iso-8859-1?Q?3YhnUyTcoPI1dBYDbyJ6tCbA87ZEBPOn1m+388ZfwzdlQ+c6ypJqsDoYy1?=
 =?iso-8859-1?Q?yJzmEJ3vTA4zMuBrCwtv6waFRblVkQicQWZftcdWOL3j0hPv+hFjlZ11uK?=
 =?iso-8859-1?Q?Uh1G58BQjeor6obffdEjQ516JLa1jDlQuTf3AHrh5DSsN07SsfVsOn3b8E?=
 =?iso-8859-1?Q?st1zbnTPWXpvNxCdZvzNCM+FNj9e1rp0d0cjFCeJsOUGj7ny8Nktv4NcjO?=
 =?iso-8859-1?Q?oMozUYgFkKNjh2qNtoIAyNiQiQr5GJtOXSiuXH7mwePQBpOcbDS4jd49GY?=
 =?iso-8859-1?Q?CCLUF1yypvJRnfOY0dxJBWxOEIbYhRySynck2Ho0Teqef/M//MhdBZ9QH/?=
 =?iso-8859-1?Q?ndPsMa5dtLSJc4zSJvwiKvH7BkQwuGBMg8x12DE/OemdH84YeG29zohP1d?=
 =?iso-8859-1?Q?FMxdpH10t+sMUq+hAqWjtI0fr1PkQHulfzBlgI+CD+DSKltc4+IuLrw9KP?=
 =?iso-8859-1?Q?Hraysp5feJ7OztgXV+tXjwLM6eNoMPxTR8jnPdiM8QgkicMKO2MMUAqVSA?=
 =?iso-8859-1?Q?66smGhaviIYo/rr6nGytTYglTQ78epNW/zkCC1T68FBuGwvAJq85ti0Gjg?=
 =?iso-8859-1?Q?ZiPpmg4hRh1wu175wtfzUxZDAJup/BGGkQ1uUV4dRfZBbPx3j2ti21RYvQ?=
 =?iso-8859-1?Q?pjQVnMeJL4NuewKzLrwnRSb6x+etHuKt2zpgifZxlpBSI42U2GPgMBSeiu?=
 =?iso-8859-1?Q?nfjwFNRQE/zY6da1RRMAza5eeBnswU+fcvr1xMu07EsrSrsec3LicW+QZI?=
 =?iso-8859-1?Q?CCJuQSjFYvKTQS2t1COlYHKrG/C8Fuu6DZxODoBZhXfD6Gygsi6asmzva+?=
 =?iso-8859-1?Q?U8q0UKr2fA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EjA9A8qM2xyl5PYdeoBS+Pfj7LFshr/YLQ+Zl54SgqhCwaWltjSalsqqdDhDbN8JdxdHu6W6Ha9pehle4qIlb0SkksnDlFkeYUTNV9bKAFaaQOl2+anwx8l+ygIz8P0woOTX9Qf5DUKPdzy0lQ+VxiUC1nx4J5zCJI6f/b27vSU40PHoFxXCf/UYmUjOd8vVApYn4Xo24K94j5079Ln8vN1ravN9YMzcNNfPmIED3hg+sBr/hu+QVgv6WzMDYHQBuyDzxQ21JytftPVIE7dxHB8PAf7sqloQbT2b5XvJ9+ykBAKMhS4iochjQLm7z5qpovAkuVfGe2HGFdvTXfmGCA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0202990-069f-44cd-a8c9-08df2a9f7c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:17.9321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnXOdceuDAt9j6F4V7Ng/RHxhnjahD7qGmo0v+fxebjBYattGpnNSoGHEj0khWqtVRCNsy0JDf35omfAIxfu47ZWGFWpcL3X5zAVWH09rWU=
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
v4:=0A=
  1. ep_info now says what the host chose, both the configuration and the=
=0A=
     alternate setting. Keep every configuration descriptor, not just the l=
ast one.=0A=
  2. look at the request type too, not only the number=0A=
  3. wait for the endpoint's bInterval before asking the device=0A=
     again.=0A=
=0A=
Patch 7 lost its Reviewed-by because it changed. It used to ask the=0A=
device again from a bottom half, which runs as soon as the main loop=0A=
comes back. So there was no wait at all.=0A=
=0A=
A keyboard answers NAK while no key is down, and the retry timer paces=0A=
that, so it looked fine. usb-net's status endpoint answers every time.=0A=
The loop never stopped: ask, answer, ask again, about 17000 times a=0A=
second. The same main loop runs the guest's timers, and it had no room=0A=
left. The guest stopped feeding its watchdog, and the watchdog reset the=0A=
machine.=0A=
=0A=
bInterval is the rate the endpoint asks to be polled at, and the rate a=0A=
real host controller uses. The stream now waits for it.=0A=
=0A=
v5:=0A=
  1. Use a separate timer and bottom half for each endpoint.=0A=
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
 hw/usb/redirect-server.c | 1812 ++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |    3 +-=0A=
 hw/usb/trace-events      |   31 +=0A=
 6 files changed, 1855 insertions(+), 2 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.43.0=0A=

