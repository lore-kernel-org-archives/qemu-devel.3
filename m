Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3FDCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5dh-0001DH-AZ; Sun, 11 Oct 2026 22:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5dY-00010C-Hi; Sun, 11 Oct 2026 22:19:36 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5dW-0004uw-6M; Sun, 11 Oct 2026 22:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTDO4Sdk8KElshVx5P+IVR/JXHwqzAHstCAqQeFcd4WDEMGfHuPP4Gabm0qoK0mPO1AP0AZ8xHvZUj+j9Dp6nsSsD8RLg7yP9jU7x7CX7Yrnvcsmh0ZEsD8sAtXY/GPt40Ca+zRcaDJYLTF4+lLU0GD538UGtnprDOPDMjoARGjtw6lZUcfCANHvTs9wJ6ZrOiRdU8YTjNOx+OIehwrFO5YqK77VL7Vq087SdqJ34WFK3nsLeuut2R71/iu/LBYIETQzFtjlgEqpHCfTfvPKvfXnls7WjY7LcKsd2nNG3w4KOGTZis/ZtWMJswXe9y0iFgnRJI0jQ+VST9d3Aa2wnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQNMuyI5DlrwPepwXuu8gmKQadQ9mUrwuCcDsQYzSSo=;
 b=jyWEkH03WTI8rH48qGpxM+4+pxroL6IpGrl7kH8ky8lMGQ2y6v+e5CWjWKbbXPN0ZXdIwB1u8UZT2XyTw5miF7nXKgD05CmuiF15nus+K18PM7VNZ5A5H7BVg69DprQ6US4WXXfzo8KVmkqTKEiSdFlzyLJPfeMApGMy4cnF2pvtN08A4ILAi2E0nf/kV4xjqHzbJLap/Fr5yILzoUqAlo5325dBEmgFYot83ur31VmXwl//WJKpD7dhM6zuKr6Ddy3s2uau1KwIY/A2GjKgprcPj6d+OhGM3vy2fbY4VfzgQ4OfzcbeUQlHOAapu1Gwptp9C7mRCzJ+cXbjK2sJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQNMuyI5DlrwPepwXuu8gmKQadQ9mUrwuCcDsQYzSSo=;
 b=Rwth28/C0Eg8vzDXCQ7H6nIBP7d7CtzcNr7XDh1rYkWEHxhX52CwdUXp9Vu6aFFTnUM1C8kLM3pyJQacM5voBU9gku6Dx/MgAxilCvGskz8TB+coVupf5MksNx3sKbWJCXZMzpuvl3F8BOlKxWHfCSEeuwdDN26kfZRXcv2Nc9cc4BTVKy0m+xMsUNLySS/6UUTaUezI6/gt3QiLDUSmUv5xwAT0mzBwRV1RH8wnZD8QM1eMpuVhOweNdTCshfZ0C3tXvovkVcdVJIiTK8yKlyKt+Jzc7Mq6W8KLG6ty10b/QpSgvF518yLwoLj3MKpugNErk6pJtAMei326Bex61Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUXPR06MB8293.apcprd06.prod.outlook.com (2603:1096:d10:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 02:19:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:19:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v3 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdWe+0scw4Tjcj60yshy0Jz4Mc/Lb5K91A
Date: Mon, 12 Oct 2026 02:19:26 +0000
Message-ID: <SEZPR06MB7362253969B582A50E53B0B1FC9F2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUXPR06MB8293:EE_
x-ms-office365-filtering-correlation-id: 8cc42a3b-3023-4308-7eda-08df28073cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|921020|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: jtSvUNPrDTq2BtgUAtqdHraJIhzZmVwEpnOzV02vm0CX9Vd92OhG0PMdn+/7Sc6zuYchimZxIY9qFMwPNasw1CC0pOSaKGXeFR6oSfy+D8Hb9xdjJxiaglxgO8mZp2/FcnoNdSmWmu3c1okDdBV9kYjEa3dZcI43oONTtkWAsllhCgxT3irta+jvqdja7NcFh+zAD0MpNrQla8YSzJ19UN1FnztHyrgvQp3zNpMj6VM7PebeAs6Cexq9RJXX0Tr6T5pPUdTX6basM0ww/DFPSUZPUmmAf3qT5oCDyoqC2ZYq0dXULi3tPHMZ+Ifo6tSX8oB5uyFWIxSOpc6xwrnR7wS0VLq8FlM7xdOzWwT/cUyNpvrLHcvsjQj/NxTFB20+QXvW/TKqcNyM3GUi/5LuLN0kMw1ikVADhMqYy5Lwd6TonIp50Qd/aa6Etwqdeh9o+XLtczJscZfxEFDO2CX4eCDH7YkAIfYPprcwd2vnPTP/xOewZbwuZnUTvf4TssEq+i6lyHVuuwagkPa2AFBbnS/jncomi32LkhcAb48mJCwH4J3ukgesKKuv+sF18rOW74kM8+5WQoDydoXExX4Iaj5sNpTMNbFhugYyTwkeitt1SI/CJZxmPyJS8Oo4+DsN22lAvDyY1ZmhIT/UWtVnwSGEcUwRnqj3L0nIzOwbbq2B8AwD5sMppqNBUHHmNH83
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(921020)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?75Mlc2nL1to6Maznjx7Xu7SyTNLwpU5UYXdbpq7ItQmDrjz7GNz9r/ZAi4?=
 =?iso-8859-1?Q?OsyE9VKHNaI8GfZ/rQqiSbtXwMZp235enEed4f1yw/66hq/OKbrrMtAOuH?=
 =?iso-8859-1?Q?+T5+u044M5eT+rQ1FxHzvHJZ1yckM8BvotGwpwFQh3obSTrnZSME3fdfk9?=
 =?iso-8859-1?Q?1Xdd3DA15x5H8/OCLIvsfhcRJgXxg+AA3257FvhH+im3p1zS+z3cLbVWpi?=
 =?iso-8859-1?Q?p+i+o/x9ZwCKtHg+mQ/nJC6pWsgqqCZbvgsapfX1JyQ3fSAXvPny03FlfV?=
 =?iso-8859-1?Q?9O88LgbErHLe/97VVjyTiBLTFrpdO4W2ooYWEq47ba8dD/OELTHeFTDze/?=
 =?iso-8859-1?Q?bDOKoS89hFxyCWumuZdju3m0P/joa71+vKpUkl+K4vlN4fkcCI3wlVNmDg?=
 =?iso-8859-1?Q?tT2+g/xODTdKSEHNKBuN2lY3R0QkrNO2DPUSMSBDOMTWIkKvdOX6NFLWGD?=
 =?iso-8859-1?Q?fg1MM9L8D2F+EGvA44WpeMaxyxxAaphPW9Dtdtj7e2Swfhog5CbCbZufjk?=
 =?iso-8859-1?Q?tE5LGO5SP7wQGl7LN+5d7N6pOc6SzbzrJ/9K/5ByYa6CEl3wnSlMNjeKAu?=
 =?iso-8859-1?Q?oONUCUZbyBvHMkv/rudOZErmWpqRLRXW2djhDceollYpueC9Kn8iyw3vHe?=
 =?iso-8859-1?Q?IA/TBZgvmQQfqShIWbo6jI2fepda2NR4qU+P5PNPTek0VVlxrmBgzd2f+a?=
 =?iso-8859-1?Q?JU30jrG/tJykCGXtg8tzfvp1lvxpu2uSTnbwtcAy93nXBpyypsf5kr2hIp?=
 =?iso-8859-1?Q?BRaskBRMKPAsgX8dvx/4n8I0RADj47PHHWs0JSAZlnJCzX9GaL8UpRPJQ1?=
 =?iso-8859-1?Q?To4AB5bAZ79QigmHgs2y59jG/S1cWeSgcmvslpl7lWzuLAFDXM9zrCqihc?=
 =?iso-8859-1?Q?mvNhjL3bwz/s3BHTjgaj3ogvUGdwLnp/bCuRP5ZUSVycRHN6fxe9hFVmo/?=
 =?iso-8859-1?Q?vjqvDm72h1D1s9JmL30rNbcQaPAt4r2SIY0FK2lSz+++XEn1tKm9/D4bZL?=
 =?iso-8859-1?Q?E02wYXPfppcTw21V5HZXBstOYdLpIb5WB0WkhmG8mkFzfEWkXXcXR8jgux?=
 =?iso-8859-1?Q?KqM0xpq266zCQvJ+90FyXEaFfvbidOezX2yRNaj0LWQy8VCGobf8Ar2CZJ?=
 =?iso-8859-1?Q?rqZoMIOAY8Er1XJrtNeO9GlJRHX9Rojd/YcI9Y3Lyd5g74rS2N639ST+z2?=
 =?iso-8859-1?Q?GJQM2Cu8oVI0aAUsVd6EQdSE48NQ/eSM1xuEJeNhsTBJTtGT22V2V8Jdh3?=
 =?iso-8859-1?Q?/2e8B1wRuKjBZJeh2BI4H6VbOcemFK4ihLgrMDy4Fqhm7M1wBoeR2MMuUP?=
 =?iso-8859-1?Q?3tNa3J+xbZrIdlBEH/+jCWAgCNEFbiLzpR5PuVTG45NhNh78cdKA0j4f1B?=
 =?iso-8859-1?Q?eBrNhl2zv6GkzhAAVLfPE3uIlqbdYJyS938+TlCKhcMXi5aE4GBmjRXvtv?=
 =?iso-8859-1?Q?DCjrWecVCZyBScoCvuqM6EMbDyoBAPZ4tkfqMylTndvzncdzdpTu/xT9bI?=
 =?iso-8859-1?Q?pIpeDJpVN2Ez6c/GOf8MqfMgHjz3h87/SGIV+mF5BdP3oFUb27S4RNnfBP?=
 =?iso-8859-1?Q?0KxltTxARfizgzxpRV3jOP3j/FDnoowCY4Xg/DHmW7KqioUYnk8FRqGou9?=
 =?iso-8859-1?Q?QxEjF9JBA0lEOcVYJShUjlxh19sPpRuj4BIDg5hd1RuFmThn8uLIDUrJcs?=
 =?iso-8859-1?Q?I3+n1ZE8MQSkJM1gxc7gqnQT3NAiBImTdAz+YWiYph/wNrQwGMDXN3xXpN?=
 =?iso-8859-1?Q?gRl7OarC0XxN6KAYfWp/5zOKbFu4Am41pY4dmMwbMUUFSD6ClZHif5mwnL?=
 =?iso-8859-1?Q?ra8iEhKYuQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jgul1m34xmwg7cPik8Ao+FKh/XsTqI3+m2HJTp2aNmhsTGn9etlNTXp+TRmUUVQnW03YYipjHWuKZaJXwjbKO6Za+nrICJpuayhSiLqTIbcv4C3EN6qUBioyS2neKeovESDAafO4MNbJAsY7FPglbrfdAP7erdc0HihRe/eB7h55tPHHT8Qe5aEeasSAcl30mD8ki+3Szt+pNSicX36qAZMCyIw30lVMSNFcKuC0Bvni/N3MADpZYOdIIilPRAvSCAmfxA4dlIvw7azmREI2beD/IRTw82noFnrO+iqRoHwDIDzX5/MxNE9R0gLcZigcz33XqmTOJpmUghAC4Jzq3w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc42a3b-3023-4308-7eda-08df28073cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:19:26.2414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygDWZwDqSCg4reHjkGntdE5ohvpx13sKG39MC/G/rQQ9k0N9QMuEKPYa6PLX8GuPkA6Nx8/2Ga4vlb4jrVKypYzDiM3U6sDlvWhTcwDAbac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8293
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

Sorry lost to add Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

> -----Original Message-----
> From: Jamin Lin
> Sent: Monday, October 12, 2026 10:17 AM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
> Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;
> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley
> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
> list:All patches CC here <qemu-devel@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>
> Subject: [PATCH v3 0/8] hw/usb: Add a usbredir server transport
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
>  hw/usb/redirect-server.c | 1669
> ++++++++++++++++++++++++++++++++++++++
>  hw/usb/meson.build       |    3 +-
>  hw/usb/trace-events      |   27 +
>  6 files changed, 1708 insertions(+), 2 deletions(-)  create mode 100644
> hw/usb/redirect-server.c
>=20
> --
> 2.53.0

