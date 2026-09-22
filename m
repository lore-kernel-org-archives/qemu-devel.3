Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942E4C98305
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOG-0007UJ-Bn; Tue, 22 Sep 2026 05:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOD-0007Sv-6u; Tue, 22 Sep 2026 05:02:13 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wO9-0002BR-Cm; Tue, 22 Sep 2026 05:02:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuEQHugcjgt/O09tS6Ff/Zip2znZPrQV76QPKaUU/qK+zN15INHnKr38bcKi7LBwfJ90T8medDDhD2f+3FCHmV1H1/0WG5uokpoYqVkxaW8yQIzdceh9vMNUN2CDP6C2kTRZSL+bbIM6l++5u3uG7mRvhCXBucU7UaTpNF9o3T7CKmQ1xhs9wIRfihrHWr2kNsZXGr2+K6U76tSxjNqGISkmdJmq1jOwR2Nkr0mFgJ93d4n5bQZDHS1LmoLs93WO8Lh6TFHXD7coPvC1duQFDtnruJeKpCljQLJYZinIN8n2H8VcYZtX/e0TjAPvPQlC4jBBO7apJyjDJ7/OKsWleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m6tC//KgtnupiY6CN4VSwunZywynYQ6gD8UPNtjtlU=;
 b=XUeg4pKRwzOnNFKrqhGfUDTLpyRY++RHovhEWaZkYvMj/Cz6RqjY3P+Mo6bhARkSJDH1RLnmAQUJpVd0GugZ+e/kqbWtM8f6OqB6BjB/LrsLWKiWcNwVrKFQzsLhngPlyAJJQuoukjY02TQC65McbQju9pHCKTRkDxW2WkDqKNcQqSAcK1Rr0wmdfTIe+6GdERx3t+azPpoNECVDZyFVpycCW4Gh06B/0siW9lsPBuIkcPNaYuXXavw/VO9iQs03RKZIcOVSgxaGd1ODKjrGbixgldaiq+FByXRG0CZmqoLNMIXt+P5CQQVzUzoZwkZXKUJoFV39zIU5aSro1L+lZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m6tC//KgtnupiY6CN4VSwunZywynYQ6gD8UPNtjtlU=;
 b=r8harF8xma+MdZObY2mk2sNsdtPkIJmaW0nNVp1PcD8iBhLljUpwdLkAwZnslThpWJHS1n588ZWviYr0yWnTx1zoqVMQc/fFm4vlAKVvsK71lI0f6s56PHnwvjnnxpAjy5dW034+3DGAbKXKjuyNB5P/+CmMhIyy/Vp3wUeu98Ygyl+hKP8JNcmd2ULLYwC1WESknfCREyJZilKwdRcvrCjBUPzH2D1kOik5NjZL1jQkRCCX4gYy0SZzE6vxqZooZgUzK2FrtSAuhxM2T6IdUwn7lKNXXZaAGxRvsj+BODzzMRgbemlMzjE1A6zFD1a0PuORt6ViRbRQZ4b262IwGQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 09:01:55 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:01:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and AST1030
 UDC support
Thread-Topic: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
 AST1030 UDC support
Thread-Index: AQHdSnEERPamrUtxCUGTRaU5xPzZPg==
Date: Tue, 22 Sep 2026 09:01:55 +0000
Message-ID: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5090:EE_
x-ms-office365-filtering-correlation-id: d52595a8-fd77-4c84-ade9-08df188826c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|6133799003|3023799007|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: IE4o1AMwm+Z12LBAmn8WR7JbOO9W0dlR9OPi2hSepGXtXiQTd13xHfgDJANKJdB0qFKe+lrZflUdn4Ye24KSNnKd7VYnVuU7kS9G1Q7vaL1BbBls9AyTBzQp7KVXGi0ajZ/7AOhW+WORTUikBmY88u8zqIwmmlFBZVYtfrTKhombCrKRK9GlY5qVARdq2SFRPG3qjXeYJ31pu9nBiOR762o5wmTGKv9CwCQEMPDjtirxz9pOPFUFp9h/pwaB//NKusLvuoUAv641EeW3MO3NuwJnd8stfpjeq6biVtosWDxgqPZByTQ5ZmO6ebkTCT/274qZ4mwcKqX73jWMZPu2MWAOU1yL9XeaXbihZjE6nhY7ohvbdqCDYfIRBG1E43FAVz4+mPwua71H9ZDWhPnWuc3mdaBL3T+NJaeQ/zwFHR06gT7ocKOpOMZNDxiv3ihCKvRN6f7hRbI2+C6FcmCBMyW1uLkozlu2M/RmUpJgXn12obk1A9A892T3qMy31wI38/+pwJxye5RF+FiIR4gAdXlgv5mSaalGAkskaEFUeIzhYbZABS2n6395PMlzBrKXnzTlAh+VQN5Pio8FkzF47ZX5vFdoyC3qVID7WyN9PXhT11dtORVk3gWtVDvvTRDodtRflCouwVmbdpjVbrwxmI9pClJ68TBBlAOB+iQa7pQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0F4n5cV6sL75E1UGPAN28rzj9dXmX/zXdee9F6kbPnS2v/XunSwjdanNh+?=
 =?iso-8859-1?Q?2HBzFokRHwhZef0HtN5uMcLI2zdBbOOGjQ8ZQD0Y1UJ2TGlC2b3TW8ZZEa?=
 =?iso-8859-1?Q?b/ax4LcfqnbfKaCFva5OW7wtZGm7M1cgCp2enyHXWIWXnGqxlRz1Lj8MkF?=
 =?iso-8859-1?Q?ag7jE+E+6xubIuwm/fixZoPiYJ6CpvQ5GnEQ9EIOsTlnbb9myMFieRHs7p?=
 =?iso-8859-1?Q?pZVx2exrH4v9T9CYC3/MbgkjffzzOsEEWZI3OhMU+cWr9GUs9ZH5pm2tt9?=
 =?iso-8859-1?Q?C75VuttZg+/h5viH++aZszdA8rGl9hHXkHW1MLgVEH3cGmrkVi6PZ3BG+G?=
 =?iso-8859-1?Q?VoyCy90Ez+AL0DXrKA8kWQaAt11wv1qBA6beukbtj1rUo9jbueKpbU+vib?=
 =?iso-8859-1?Q?w5iFVKQ4zosgFLbQ5TcoUsxRbJV87aMj1Oqsg0nIDySFrrwFZ6iMcosqFN?=
 =?iso-8859-1?Q?fbZy03Iwr7iWgymkCRnkFLvGIP/4gR0NLyKD2i5EcgXGh8WfxksOC8lpUJ?=
 =?iso-8859-1?Q?HBPLqL6gVeOZlh+PKLID/y0PdHdh+p5IJcEM6IDUkFHzkvFLX42mbNJEMS?=
 =?iso-8859-1?Q?v0qjQPE9NDA1GZQZ/IIdrLcZAez/Dchr7sWBZIRRuoGPlxwNkkccCEo6SC?=
 =?iso-8859-1?Q?meRrRo6r+MpZWwJQHc5eb1QuWtMuPARd9qseXvGURTBKdKg1YTFXF1QDoL?=
 =?iso-8859-1?Q?K0e1iAEsnakA2KSTBJMmHC+nARLcpzCczFaxQ48SIs18Xj7nTWOeggXQIJ?=
 =?iso-8859-1?Q?o44fmLBMnYNpz0ItIjEXd2SZOXssMnKjI4gG/rKDnsFkoWn4hf1Yfp59RD?=
 =?iso-8859-1?Q?23ULrp2Ojaf05vsGmrOQoRGuf4lIPePXggggmIISkKvthxaWjb/dgkOG6f?=
 =?iso-8859-1?Q?RC+vNZBQ2eBTCTox0gZoHK7dVOzQ6z2r8B8dum54Clcm1YovMp5Uqc3rO0?=
 =?iso-8859-1?Q?jEGgLRbsSvVKIfGQ6LgOd1IpAH21Ef+9JJNH+0Wvvi4oTH4bsK58WEbQhR?=
 =?iso-8859-1?Q?NZAjPN2wG9gSHe+7kmLGXCmLUzU+u0M25gftmGrNCKITzfBdMHlEXbBu3r?=
 =?iso-8859-1?Q?MMjh7tIO6ToX4sH0QrbBn/H6tmxCrtNk8dEB+hHaPsDG8xUS1gm7n8z3CC?=
 =?iso-8859-1?Q?Y6sDsYVXAl+pHLsWlat/+u+BX3WIvE6UfTJtQfW3SFsygJ5ITo2gDgJsPt?=
 =?iso-8859-1?Q?fgIN5xNMD9gHeM6bt3W6msM7QxCe9jejYp/wOX0KBBpFqe1X6W9jPLEHcG?=
 =?iso-8859-1?Q?RFKSmDGK036a8y3AL/lFOz3S3KQN1/9VojK8JBF7t4Fpr82lV60NQv1uIK?=
 =?iso-8859-1?Q?Xwoh79A0OvYhMFfeAuSwZjdLNjIdWRhpCAE2F+EfhQ3kmCPJJCiJ28iOh8?=
 =?iso-8859-1?Q?7YVmE/1OKgCjQCu+zwBIYQAmc2bDOkPCwJ2FVNK8KGAnOAWdfV+jUsXdQr?=
 =?iso-8859-1?Q?wmyQl3aWihtkMyj6SYEpxHL8dddlwYCO4L3wC16VVpuDhfHlolZMI3xr6C?=
 =?iso-8859-1?Q?DIxYRYZcXAlpGsBJgU94NI6s8fOpR3fYsfpqTKorC8CfHYdSilhhkN51TH?=
 =?iso-8859-1?Q?SmjAa++L82ZAsP/YCT3EQh8ykCyuVWYa1b2Jf8T7o8Mi7BQOK/RmNoxSnK?=
 =?iso-8859-1?Q?dXIpwLgup+/g5CUeIN7Df7uZZ8IHBnux5iiy7NPveKFMeIluGy1sLxLOwk?=
 =?iso-8859-1?Q?aDAV6wTxJhoJ5Mb3CrXEnTqcRvGBClSX952+NG6oZ8gSmas1x8m9+e0lrd?=
 =?iso-8859-1?Q?lYQ5WmyqViHFGzxm4/ERf0Q/wrTQePSPnDlksNIwO0ISMzge2sYjgpq9Zw?=
 =?iso-8859-1?Q?RvVUiFXYlQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gH8gg3wzw2JkPGySM6iKWh4aHdnZrHyPD/ZxuhFreoDehltdYMCskOQ48sfyaqqA+bKFq4PDuUjT27UY1kOVWfXvTONS7XCjktJJgkbVXlBiBNV69JIW1Lk2qi/uxlvLEnSI6nqQUSluqyNvAJn9TOpq7h2+xPgKLQ19RrZ2qMNEiRCVC8HL34tsFVQ4cFDMFlZXVNU8j/oOkf4pSs4OAiSa0ZMJF4ZP0dtAtuFMRJsT/WO8kOMvPQVJWlH6K3gVGzltcjN5Qu9AYP/2n0DPemnWevhUhqb1xD68JtcrNJHvbr09TLlsFK+jIgJx6Sd4O6zmOmONknMjET5lu+eljg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52595a8-fd77-4c84-ade9-08df188826c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:01:55.4440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWKfU5yQxG23imcSUrb5N9EUoBgeK2/ZWTnU8yzL1DtG8rFI79nFtd8oLSE3qvUCdaMm4JZaR+LXRVRYXYt40JYfko7qFVj5u7K3Wklrepw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5090
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

This series redirects a USB device emulated in one QEMU instance to a USB=
=0A=
host controller emulated in another one, over the usbredir protocol, and=0A=
uses it to bring up the ASPEED AST1030 USB Device Controller (UDC).=0A=
=0A=
It is the second step of a larger plan to model USB device-side support on=
=0A=
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
usb-redir-server exports a locally emulated USB device to a remote USB=0A=
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
    usb-redir-server (the server, this series)=0A=
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
usb-redir-server is the server. It does the same thing, but backwards:=0A=
  - it reads a usbredir message from the socket and runs it as a USBPacket=
=0A=
    on the bus below=0A=
  - it takes the result of that USBPacket and writes it back to the same=0A=
    socket as a usbredir message, for the client to read=0A=
=0A=
A USB device has to sit on a USB bus, and in QEMU a USB bus is always made=
=0A=
by a host controller. So usb-redir-server makes one and acts as the host=0A=
controller on this side. It models no real chip: its cable is the chardev=
=0A=
socket. The real host is in the other QEMU.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported: the=0A=
protocol has no device address field. To export several devices, run one=0A=
usb-redir-server per device, each with its own chardev.=0A=
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
  | usb-redir-server            |                     |=0A=
  +--------------+--------------+                     |=0A=
                 |                                    |=0A=
                 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D unix socket =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=0A=
                           usbredir protocol=0A=
=0A=
Testing=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
1. AST1030 CDC-ACM gadget, enumerated by an AST2700 host=0A=
--------------------------------------------------------=0A=
=0A=
The device side owns the socket and has to be started first.=0A=
=0A=
  $ qemu-system-arm -M ast1030-evb -nographic \=0A=
        -kernel zephyr.bin \=0A=
        -chardev socket,id=3Du,path=3D/tmp/usbredir.sock,server=3Don,wait=
=3Doff \=0A=
        -device usb-redir-server,id=3Dudcredir,chardev=3Du \=0A=
        -device aspeed.udc-gadget,bus=3Dudcredir.0,udc=3D/machine/soc/udc=
=0A=
=0A=
  uart:~$ usb enable=0A=
  uart:~$ usb print 1=0A=
=0A=
  $ qemu-system-aarch64 -M ast2700a2-evb -nographic \=0A=
        -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -snapshot \=0A=
        -net nic -net user \=0A=
        -chardev socket,id=3Dr,path=3D/tmp/usbredir.sock \=0A=
        -device usb-redir,chardev=3Dr,bus=3Dusb-bus.3=0A=
=0A=
  root@ast2700-default:~# lsusb=0A=
  Bus 001 Device 001: ID 1d6b:0002 Linux 6.18.36 ehci_hcd EHCI Host Control=
ler=0A=
  Bus 001 Device 002: ID 2245:1030 ZEPHYR Zephyr DFU sample=0A=
=0A=
Data was checked:=0A=
=0A=
  2700 -> 1030   echo '1234567890' > /dev/ttyACM0=0A=
                 1030 console: Print Data: 0x31 0x32 ... 0x30=0A=
=0A=
2. A plain usb-storage exported the same way=0A=
--------------------------------------------=0A=
=0A=
Any USBDevice can be exported, not just the UDC gadget. The machine on=0A=
the exporting side is only a container for usb-redir-server, so it does=0A=
not have to run anything.=0A=
=0A=
  $ qemu-system-arm -M ast2600-evb -nographic -serial null \=0A=
        -chardev socket,id=3Du,path=3D/tmp/storage.sock,server=3Don,wait=3D=
off \=0A=
        -device usb-redir-server,id=3Dkeyredir,chardev=3Du \=0A=
        -drive id=3Dusbdisk,if=3Dnone,file=3Ddisk.img,format=3Draw -snapsho=
t \=0A=
        -device usb-storage,bus=3Dkeyredir.0,id=3Dmystorage,drive=3Dusbdisk=
=0A=
=0A=
  $ qemu-system-aarch64 -M ast2700a2-evb -nographic \=0A=
        -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -snapshot \=0A=
        -net nic -net user \=0A=
        -chardev socket,id=3Dr,path=3D/tmp/storage.sock \=0A=
        -device usb-redir,chardev=3Dr,bus=3Dusb-bus.3=0A=
=0A=
  root@ast2700-default:~# lsusb=0A=
  Bus 001 Device 001: ID 1d6b:0002 Linux 6.18.36 ehci_hcd EHCI Host Control=
ler=0A=
  Bus 001 Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
=0A=
  root@ast2700-default:~# mount /dev/sda /mnt/usb=0A=
  MOUNTED=0A=
=0A=
  A 4 MiB file was written, unmounted and remounted, and the sha256=0A=
  matched.=0A=
=0A=
v1=0A=
 1. Add a usbredir server transport=0A=
    1. Add a usbredir server device=0A=
    2. Announce the exported device=0A=
    3. Implement control transfers=0A=
    4. Implement bulk and interrupt transfers=0A=
    5. Stream interrupt IN endpoints=0A=
 2. ASPEED UDC=0A=
    1. Make the SETUP buffer byte addressable=0A=
    2. Support single-stage IN transfers=0A=
    3. Clear EP_POOL_ACK when no endpoint ack is left=0A=
    4. Mask the reserved bits on register writes=0A=
    5. Use the endpoint max packet size for OUT transfers=0A=
    6. Test the usbredir server transport=0A=
    7. Add the USB device controller for AST1030=0A=
    =0A=
Jamin Lin (19):=0A=
  hw/usb/bus: Let a bus opt out of automatic hub insertion=0A=
  hw/usb/redirect-server: Add a usbredir server device=0A=
  hw/usb/redirect-server: Connect usbredirparser to a chardev=0A=
  hw/usb/redirect-server: Announce the exported device=0A=
  hw/usb/redirect-server: Implement control transfers=0A=
  hw/usb/redirect-server: Implement bulk and interrupt transfers=0A=
  hw/usb/redirect-server: Stream interrupt IN endpoints=0A=
  hw/arm/aspeed: Enable the usbredir server transport=0A=
  hw/usb/aspeed-udc: Make the SETUP buffer byte addressable=0A=
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
 include/hw/arm/aspeed_soc.h                 |    1 +=0A=
 include/hw/usb/aspeed-udc.h                 |   13 +-=0A=
 include/hw/usb/redirect-server.h            |  116 ++=0A=
 include/hw/usb/usb.h                        |    1 +=0A=
 hw/arm/aspeed.c                             |    6 +=0A=
 hw/arm/aspeed_ast10x0.c                     |   17 +-=0A=
 hw/usb/aspeed-udc.c                         |  290 +++-=0A=
 hw/usb/bus.c                                |    3 +-=0A=
 hw/usb/redirect-server.c                    | 1604 +++++++++++++++++++=0A=
 hw/usb/meson.build                          |    3 +-=0A=
 hw/usb/trace-events                         |   36 +=0A=
 tests/functional/arm/meson.build            |    1 +=0A=
 tests/functional/arm/test_aspeed_ast1030.py |   52 +=0A=
 13 files changed, 2088 insertions(+), 55 deletions(-)=0A=
 create mode 100644 include/hw/usb/redirect-server.h=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.53.0=0A=

