Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C31CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtkt-0005Pm-KK; Wed, 14 Oct 2026 03:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkr-0005Ny-Kf; Wed, 14 Oct 2026 03:50:29 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkp-0006xt-3g; Wed, 14 Oct 2026 03:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSiz6rHgyhzRVcJE/N4YtPYRXrrj+t8PdZIfVF5cIRrlQ7mO1T68dMGp1QUceBjCPTOsmmsPDcA7XbRNCURMjPQ/jHIkMZpX0mFFoBlUmAgwdp1y3iFrfITG6ekmsh/i6PKhcDhZPIga9o7R/FlliIV9ma1+1YMhhha24J3B+XMeFBGi37c7ViGH8OUq7yzLoySPcL+KsxsTqlwp8p7t3lyNhLAn17B3bUIz259XpdPQp/+hybfp3geiJmkReSALMTEZkVGrf9Sg05X69toAhWcyPS9VvZGP0Fz+zFn+Lf6UfdLvce4Qf9Pd9ohkz5xza57yyfmPW5UvUvQau1h2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PSKX8TwVxC3ANgLapzMYqTi/bdGzSYi+OkjrTIUTE4=;
 b=lZsjjqxfKXI1A3+2COEE4NZlsxTCV/ie2CRNKF8qxP0RoI4356eZvD4DxqgIYyH24VlRwvWxuSEnibgpKRFs/1tEcI8MFNJkpAQNrp1KkTHwBe4paR6Gs1GOR/76Rhk2moUfeOt7i0B7DU/iwqFK+5TyltJ+OhwC87SnuxwE/xKogKw/i0m7uiylBIk0AsCk0JERHXyXdfI4F2IRz/LVBc5jslW2kj4ZchSz4XRxJNjviItKcFve8y5/srk11xYP85B0mf4hy7ZYa21Zj8oM791xHI/87gxHIEWqyXGKvQ1UwU4Iy2dRJpaCsGeyUP6Mp3t2CR9kc+eeWU9/J2ZLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PSKX8TwVxC3ANgLapzMYqTi/bdGzSYi+OkjrTIUTE4=;
 b=qi3wDRHA4ZmesQQA0bPh9egUknwy/L5YcDLCe4Avgwaqk8gykkAuKiSe1PRktjb0zupEz3iVCzYw+oOpeNj8NwaAVHMGRkcfRI/ltKtSJ9xabUYdAWDepeY4xbNUm/CSATtsppoV/Qfw8/WMmrxT1QbFljQcA1dFaKSmVDP6ngs48PIXBfmyOKWvn34PK9aded/k93ZzO47blYCDh9CYVQOVnNeO5PNj+buV/3c18E8pbJqkxALWgXd5VLoFbLKUuBOQkZU4L+MQfSdH+VzHVmCx5Tqdcj8Ap32J5esY0V+j53f9J2AfI+g8ASbqIzYYnPSNK5zqOU2s9zm9hDWcmQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v4 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdW7Ck6qBc7W7pukKIlBaH06if8w==
Date: Wed, 14 Oct 2026 07:50:12 +0000
Message-ID: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6864:EE_
x-ms-office365-filtering-correlation-id: c81282f1-c71c-4e64-e28c-08df29c7c70e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|18002099003|3023799007|921020|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: AVESfh+pnrf7Wfr9RK0W68pJoZsn/bilCARKtxaHhN6PVhhPe8L5fNhT8HEs34iuODBPIDtJepZkQEnAw2uw9EA8qfKfIWS7/K4XMDAsMaJAZXIV+BBdTYtCF84LbXAaaZkmNtf9SY4LQ4ewno38+dktNx0QOR+AbFyTyvN5HzY4YZUWabRisr17fy0QWheIEwDUOpi/kCn8Gur2ZRZzjyOaNtF4Vqw2B9bujjzwYVZto+HgpNlS1OmwnuY3Gczqko78Y2wRrz2z/SIanBtvVrtN0MgCeig82TTurOusNUuo2EhtfbA/cmGTab9riBgk0gru3v96uzkVAr+Hm7AaZZnykzV6zsG0AZ3rLpcTu6Pp6yv5Hxc9xrIL1WtwVarzt6Pe7KPFvvIhU4W0tE1flD4G0ItXTcPbe+tI60HFvUJQMHZf4n11E3ry3JmQddG07gHv4rhB2twKMTT1ZhXsPt0grkV3EYEFWd1ZG+twekbA75gvUjU9n7uD3jdFR0g+7cMy6aaN2iP0VqbWwxrLX9XmlGDO1N8zEJ3+ZdScRTxjbZC3yOXAPVmnJPoXMtvIDmUDEqhvcRNTp7JwjH9btZdyG24aPzChKJsHHU3QhVaaX0KLpaU088vHpEEj067e+EydHOLYivFCjY5dyLxEC4yxlaaDChOa+rcrVC20JE1vsgrWQMNzvdAowBLvfUMW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(3023799007)(921020)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XpnxZmJxK8txRw11REL/VuAQssaLYwEN+X936cvJKh4yfrLuloadRshEKq?=
 =?iso-8859-1?Q?FeVi9C05H5ZmcwaJLynnnQJ1Erc2nUL7NJtjDwr+k5LlQ1ku6AKqwuKeat?=
 =?iso-8859-1?Q?8wXEuJMd5JpTFO81mb9obZj+INBG2+rKO/RaDahUJDDkxophUL+Vv8nIW3?=
 =?iso-8859-1?Q?kNzgyzqH5Ia4cBQxs2fwWLLDYs/7/PX6P3OWrewFKURqlGmIRD37opnRXu?=
 =?iso-8859-1?Q?uYx4VQElyu5UXU5AH1X2ww4hJyKd2ZRN/lFVY186mxqy+/4BHIt4rbcKWt?=
 =?iso-8859-1?Q?qi5kbKfb/Mwe71txJnBV6E2nCnio2exnAYekR30DjlekYXc4Zy/AAIH15s?=
 =?iso-8859-1?Q?zf0XUiXMCILca0teYUFzSdSrPLvHAHRKSIvprVRhBfzyJgMbwt1Ql7phwJ?=
 =?iso-8859-1?Q?uankHlafWj9uyqRtqxMA4VkVaR4POhTPGD+gNYUZHmrCUJkXPzbOZs+VPc?=
 =?iso-8859-1?Q?u/8xZOqkv9oJpX0tdNpjI9wLyHD7QAeQp33+iqSN6IfvsCP0t64JUPHgmS?=
 =?iso-8859-1?Q?fVOjM8g3hk81DQSA/o21vIhjRlAuhDU7j47g3CESenF3vD5QBciAh8jaB2?=
 =?iso-8859-1?Q?SmVkFlkxqp4ELDKc9NwCRQ8GUWIbSu72fpfO0n232UcyV5kvpGyMznZmil?=
 =?iso-8859-1?Q?Q1Mf85c0Nder2ufH+1Azi3OSXMrCeoG42aRCtynzMD35sMamOrPi4HJRtH?=
 =?iso-8859-1?Q?fZqEzBhIxqFansuf4Mlx2D9ugaaBaSFBFcPHqHIF6eOaT/MZHIaHcetgxZ?=
 =?iso-8859-1?Q?RqDpc5C0lzf0rnPKgM1sL21w4orM0nPP9De2y0Y+J+wgwSrThBjI/SYIva?=
 =?iso-8859-1?Q?j9EftgSyqIrrTrtW3y0P52gQAGIn644XBh4xO+INgyolYBVJGlDt3iMaCx?=
 =?iso-8859-1?Q?5Rjkv7cJ3AU5O33gn7hu8DHZtmygsDoWGZ5qvFln6SINEwqZyqeFB0igrx?=
 =?iso-8859-1?Q?BCfU1P28ICePpv3bxHozNKMW6mgDtjUJdytnHnXdiUXVCfbDJTlGh2nBSe?=
 =?iso-8859-1?Q?kb1sFBtcJpIGCPEDmvnp/LouW2mPm80GhZzBs/tQpAWsD1W3PZREctfHyZ?=
 =?iso-8859-1?Q?JxO0hIXCH5X/riyROaXV2cap9VMIMGkK1MsTUQZf/spycpSGH2T7m3FRbe?=
 =?iso-8859-1?Q?vKHHIlbX4nf0LbwdEyZuJGlXOg0vLcs4yj8hYtyls9fpU/fE3/cOurmmmd?=
 =?iso-8859-1?Q?LFLYL8eoonOY9r1KUj/FkVAQGYsNiSpP/T2j2ybVCt0LhFPZ7a4DDuDzlF?=
 =?iso-8859-1?Q?cXjbJzmowfPXfoj5yhK0Gnye4p1wP26OIc/2E7I9+iumxmwLxpXz6vXV1M?=
 =?iso-8859-1?Q?pND6YN5p2kQOsQ5dKLtLGXF23/BVrRBxboy4ybRIMNwDsbN/405Uv3KmCg?=
 =?iso-8859-1?Q?5ttUbucWNOE+rEFmlIvnQ0SweomNTfnedzCMDb4IHtd8GsBDtGXI4jHeVx?=
 =?iso-8859-1?Q?lvTf6fYeyDgHMxSYsKzq84SZEfRIRyTkng71xQ7BkU2Gj8OXOsyL0cQHxx?=
 =?iso-8859-1?Q?xc2I0rQeYdWvrAY8E2j0zPo4wds2QhZ5yYc09zGuhxcYYsjrLK37KAfdAv?=
 =?iso-8859-1?Q?/mnkUB09NrD4mBKMIzsKW9w7UVaD30UgM5Q6/u1CsRmRJx1WTAQfRGpxpW?=
 =?iso-8859-1?Q?G71cdhhwHUzvabKeUo7ZB2q2AX9wBuFPfYdqfs+w9lk+cwsRpl9Rnnd8M6?=
 =?iso-8859-1?Q?cKFGw6No0Ig+51RJG93ZTBy18ZKnkFQRxTuqLpdaU57l1V/io7fbTzYuaE?=
 =?iso-8859-1?Q?hiMVzxVZYlj5F2lOA+D6iBrmWfpGBWGLTwYGpR5JixlIsJ6FNw2/93mBju?=
 =?iso-8859-1?Q?yp1V7cDREA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vLEAB4Qso7HGDTLEmsUfwC7SlIAyEYdYSxB306HdCpjyj5MGVvZFRmSd8RCVxFyMxeYmQd7FEsLeutK9kbzE9AEcW8Cseyac6pmKzTUtzTPjWBMi6ZXighR455JqX3PdGpXeUBrBeJ7SUmMZUNtCPIcnc9Mc5XyQ8UcmgZfzFlW9M8/8+kC5l0pfwFzgbLRBDyBNIpLeHfXC2bW8azrK75d684IfaF/gW1n5zEN+V3V1BTH37DK3HLs2Mjj6uiLRRvyKt3aQWMN0/whFlTY7QKpakDTZKCkW7qXwWqNGgyHxpCsZY1HaQyQXU+tsskNMeq2w3bBsBumRcxfy+dxSlQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81282f1-c71c-4e64-e28c-08df29c7c70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:12.4106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q+Sme+y3KDDVNoguqJJp83IyU+8JtdHeNV6Qd99TFXrmooZfl9dQXszNrSGprDeCOdNzXciIr7ru7cp4WOYrdkG++syVF3c+iaDGyZ3j5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6864
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
 hw/usb/redirect-server.c | 1797 ++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |    3 +-=0A=
 hw/usb/trace-events      |   31 +=0A=
 6 files changed, 1840 insertions(+), 2 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.43.0=0A=

