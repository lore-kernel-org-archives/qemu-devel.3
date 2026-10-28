Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99076606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=WwOeG+FZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY3-0004oC-SD; Tue, 27 Oct 2026 23:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuXx-0004mz-Kt; Tue, 27 Oct 2026 23:41:53 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuXv-0005ca-0i; Tue, 27 Oct 2026 23:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGGskqJGN1P8Y8Rww+8wWijRGY7Q2ZRGashm+5wHdxeJF9KcwWLuW+cYJiyrra10sw0EWKOmZY0iAoJodE9WSBEAHMjzzVx8leSDx4QruUwzl2cyb8FV3F3dQ8+jLQEja+BOgiL2PZI6B2GrpKtnHJFjWBlSym0HhCWR3wg+eB4O7e7A5g2NQAELad31NiCIE6/IGYyWUnYEaxfZjccAr3wG1ZFys+S1VuTAWOnb1cASSojw7ZdvNMWrT14zNYaHbalyc8gG30HW22EzMxwfk94tQ0zYZuHGfw49RGXQR5oZMrTe2qi+iYO3meCyEbUuBqqs3FxkJhqNREQA3tRGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwggOAbUkUdVrATsEJaQV+YDzh6v8H4QQUjwyIWHlm0=;
 b=vWMEyt+CFkX8e7iIYUzQyW34YzVq/p8RhBWJ89k7zzmwyxpmJiny6FFj2dn6eFIU/rilYhQA3GzdL339AY7A7F+tXjupgJTDSid2mFmICzCv45rgpmuXsWL0FmCQMV6WZj36LYX/6nI8irGo3Wu+1JiMbyZtujN8qMI1wlBp9lVCoS3pm9pDOTr82oDBY2mEUSmfkNH9mT9KMPLHuTEhV1XnzHXOztbrGs3fIn6WSFVAT1pD5hwKX9Zj+miLSdT7OozAPy9xT8viSnahmVxmjToCZoNmSuj2TIxpFEW6uRu495t7gkRN1sKV4jUe8mSuIme5dp8GRQp8+wzOVS1vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwggOAbUkUdVrATsEJaQV+YDzh6v8H4QQUjwyIWHlm0=;
 b=WwOeG+FZcqW/J15Wp5Gg9gzBVRlJX5UC5p2YK2Db1FnNhomCT7zVD5BBvcfSVElOwmtJ8snX+G/dV/Mhe6dpPiMaGlnRvVrDJ413c7yQ5PBxUotu+gaTWfi9SX3kPHMe8c70kV/M25qApV7ykuFBrMdqdgwMb3ru26SuKS8yVkMsj9VvKjmWKyywcHqjEVVFadDlYZTDySDvewhitH6ABYaz2+491YNP8+SJ/8z2IQ/LVnYXzS/cQvMMffbQur0qnJkEVGZIQhRSf/8L0p1psFMwNjWb+D/8EhUUZakcol9WAQB9LNhlElhfk5/2xn+Mbu/fSonCnAvJRpVcgM7Nmg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SETPR06MB9120.apcprd06.prod.outlook.com (2603:1096:101:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Wed, 28 Oct
 2026 03:41:41 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v7 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdZo4+yi0nT5k1lkSNmoIzkMRcIA==
Date: Wed, 28 Oct 2026 03:41:40 +0000
Message-ID: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SETPR06MB9120:EE_
x-ms-office365-filtering-correlation-id: 0fd6cc54-3dda-4684-df7d-08df34a560e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|38070700021|10067099003|261026121527099003|261021123027099003|261021121427099003|261022113327099003|261022075727099003|261022115727099003|261009223027099003|56012099006|261022105027099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info: N8PkLCODDRG4oJ2m+z6kSRGesxLP8KLKiFz+uyltCQU67Pr4pCGKbPvmEh0xq3BYi02fSk7Dnp2zBaq/olAGIBp6Q6dM65XLYcSKDkU/SckGu10xbZ9I+FObJhd39Bdq7ueVsULlTwkuo9OEV29rr4B/IVy670z1+o2l3sBv7X0moLDKXfg6WLQ34QVErPEWdz4dOFEeJCewEltVIUIMIuInUW9bi3m7pFRMLJv7jmhByxJ4JF2v1d41pTmB8CPwX5qKM08GqPJ7l+BXPg34TsnUPCWVozUSWQ6CDWzjoVs7ZJy+w8r9Fkdc9WxEAmwlSo9UbM4nN0RUE11S5lFBRKD1Pt2nnTuLaQBtvvMkixNQ2/c1V5/RKPZdK0gZw/6QGI3URgBainFsHqETCVkWFaIw+i/EbkdoSCpQTPAEmrAwwgkzynEmDIQIMYdx11HLbA62dfbvt7MupsQp5kSaftqVX5iEFf2fqitbn0bUyLI+Lwx9muoXvkd6Xc4mMTdsp8nE5EvtfYh5kBpsKSdemUbHdpWcja+bgfAH9VuHYGjBtLUbHrWtfaVFtRA8DuDQUIJEERi3SCUxUWA4SCnbQHfWyJjZAw/IG9V0tBT57oIwDdauNn7LrDgjJFRxfFZSU7Wsr4wGmBH7bhmvmKa54v2Egxwj5Z9sCsJXBcBKd6g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(38070700021)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022115727099003)(261009223027099003)(56012099006)(261022105027099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yrs9sfVYZI0/xiLh6NYFrlAF/oGvJFG+OtKJd5zBYfpi2Q4f5wd8RH+uUT?=
 =?iso-8859-1?Q?SZIspNicE80uNhRDeHWHhE30p0XdLmLQcKPKduG3xeVf+jiAx2ab5SBqAF?=
 =?iso-8859-1?Q?j2uAY76JBOuoLllUnfAGEC0X4eh7DviSxqWHjgwk4bfktH2fzVF/UVwdia?=
 =?iso-8859-1?Q?V25xWg42luG4pG5nZys5Ppkg/mX27btlAbOczqpdJdH63AQ2eUbJAcPK2C?=
 =?iso-8859-1?Q?c4JKXC3uBtMGpPxT3WXHSIacmZrLZTC1UFXWJKD50NFrsp43lbSaRShTbt?=
 =?iso-8859-1?Q?rZS7dq2EteyADfK41f1Ddn1pNCbHhpp459QP3WDxirBKzHNQksns244gYZ?=
 =?iso-8859-1?Q?HsBsI+srWRzSg7Inqppul1pvxynEW3jM2aD/V09+PSlAD944s2moI5rZ5L?=
 =?iso-8859-1?Q?p1QUFgXZaZfpC81wKMtm16buE2HYZl+qqyRfuacwJQcFVQOdOj7YGAme6c?=
 =?iso-8859-1?Q?ofLLFYVxsmWqrpDzB9dXWhr9x419JH1wqwLK7jhLQfM0Cm9WRGgLBreEP5?=
 =?iso-8859-1?Q?TTtAIVUXicNSwH9RwRmVyFL7ewKDjYa0UPEIOIquXxK9ZrovGeNmnDiXeG?=
 =?iso-8859-1?Q?uea9V//uh4csXcU6Nu8dq0Nesimstw0NsMVEhbDaeXaJs0f/kk6xO4+QDN?=
 =?iso-8859-1?Q?Qu6CVWsxJwtQQ4TT9wFNK5wFfceiCw2YI4QXitkkMUuBs260b3WEdNZcS6?=
 =?iso-8859-1?Q?9Ifi6oeKzSt/TogUeJx6STXTPq3yaRXDe7ZrdCwkbN+wLdOzDjIZbnTVNL?=
 =?iso-8859-1?Q?sIC2cJ4XgSjJ00eD1ArqhFIh++vPfNzNYWADyKudTrtcuJuvRy+uCNYjFQ?=
 =?iso-8859-1?Q?oOqq0t8LvQ0mtQDg1l5ZAzqSAQaRitGT4ROaF8mqfBqIaGwDlkeu2EC8hJ?=
 =?iso-8859-1?Q?STo2SgY5n6sl08nR3laJysFdOJDW4+REgZWnEDfFoRLdayNkXGCE9VPVK9?=
 =?iso-8859-1?Q?WsqzF4JUgN7E56iJRYSSw8lI/3UP16sQf9KGTgAUmKruC8jWBDMca8kIZx?=
 =?iso-8859-1?Q?JOKD7T1cuktwkanUx4KSlgihJPRhYBRJYezb1JTuPuDhUWE5wyZNZL5sFn?=
 =?iso-8859-1?Q?Tbwpx0zeQrrytP4jF7UTxrttcylwcuaLFB1/C+7Bul1pfuTiAwHFO/8X+Y?=
 =?iso-8859-1?Q?1o5Jj6ulZJA1NE3MzMFWm6WgqX6V+wkMLmII3tL4EbSoedSQBK75fSeHga?=
 =?iso-8859-1?Q?sTzYYEd/Iz2PeqyxGqtIkqWHMXRnU3pKZnBaa1CMpULb/Qnqajt50IbiY6?=
 =?iso-8859-1?Q?kN//yTQ/vd7lyxZMr1w0mVbXnZ7Vgkzt/FomeV0hdn0QqrXxQ08WhWsy5h?=
 =?iso-8859-1?Q?6W9EfqK6UCYv02AopRABRLN7OffRJ/iGhd+nhYXPGLeIjw96ZtokajudeM?=
 =?iso-8859-1?Q?LBP4ZtzzetLkK1qjnM9wFqORXTc9MJ7R1fmo6DqFk5wiy0FG0qLQ5ZF7gK?=
 =?iso-8859-1?Q?vRP8273tqHJqeEr5A3krUbQpDPZIHRb/h1juAgIAkN2raImPQO4bTzwHjL?=
 =?iso-8859-1?Q?rHxT7GxuIynJ8tkRqpV4cT1/9tUECzLcn2iwtCK1ou3ka1TXqVQ0XAVXOQ?=
 =?iso-8859-1?Q?bPpSVbw1pJ4uIegVFSWIaOXtPly40FPkG9HMz30GOte0oF0Mf2xllOeXri?=
 =?iso-8859-1?Q?mSe/veJA1bOJZfLaAplp9JmjpsjRojLWNhxVLnshf1hagcoVEK30Vgu266?=
 =?iso-8859-1?Q?bQj2f3ez3uKgmtsL/gMB3RuawOpjiUVeuFD8rEOS8ZcoZvs5m1H2Vp2Nyl?=
 =?iso-8859-1?Q?RMyifI1+CxNHmoC+uhkPnfAWyn8Vaq5hm2MLSsW6ELkLEbqJgBZy/vNHfM?=
 =?iso-8859-1?Q?+QYnAwtjrg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd6cc54-3dda-4684-df7d-08df34a560e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:40.9169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AsbPs2m/DT+c1PWJTJZpEP6LIezG8xPVthrAiGQXPysWyJnFZkpCAtANq5gndYC+jYhtNxTUrXZoSqN9/auMiHo0nwSps19CWenbKKdI/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9120
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
v6:=0A=
 1. Fix a build failure from a missing header.=0A=
 2. Free the packet data in the control, bulk and interrupt callbacks.=0A=
 3. Cancel the packet before cleanup on USB_RET_REMOVE_FROM_QUEUE.=0A=
 4. Send no reply when the cancelled transfer is not found.=0A=
 5. End the interrupt stream only on USB_RET_STALL.=0A=
 6. Keep a USBRedirServer pointer instead of pointer arithmetic.=0A=
 7. Cancel the BH and delete the timer in stop_interrupt_receiving().=0A=
 8. Start the interrupt stream loops at 1, endpoint 0 never streams.=0A=
=0A=
v7:=0A=
 1. Add a flag for the automatic hub and leave it off by default.=0A=
    UHCI, OHCI and dwc2 turn it on.=0A=
 2. Drive a control transfer with one packet and the setup fields in=0A=
    pkt.parameter, instead of walking the token stages.=0A=
 3. Keep a request the device answered NAK and send it again when the=0A=
    endpoint wakes, with a timer for the devices that never do.=0A=
 4. Give each endpoint one struct, holding its waiting list, its retry=0A=
    timer and its descriptor fields.=0A=
 5. Ask more slowly after a streamed request answered NAK or failed,=0A=
    and keep the endpoint's own rate for the good case.=0A=
    =0A=
Jamin Lin (8):=0A=
  hw/usb/bus: Let the controller ask for the automatic hub=0A=
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
 hw/usb/bus.c             |    6 +-=0A=
 hw/usb/hcd-dwc2.c        |    1 +=0A=
 hw/usb/hcd-ohci.c        |    1 +=0A=
 hw/usb/hcd-uhci.c        |    1 +=0A=
 hw/usb/redirect-server.c | 1893 ++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |    3 +-=0A=
 hw/usb/trace-events      |   34 +=0A=
 9 files changed, 1945 insertions(+), 2 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.53.0=0A=

