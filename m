Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC1606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=E2/VTqhn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGJ-0007d8-2d; Mon, 02 Nov 2026 04:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFF-0007KQ-LP; Mon, 02 Nov 2026 04:22:25 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFB-0000W7-M0; Mon, 02 Nov 2026 04:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7DnHgbFVYC5tUzfKI+QmFXwJl7L0cL2VmKld0fp6hFUFMVrMc1Oj6ee4vHd3mrbdZYM74vsZiWXslKqgcssD8oM147xhrqB3lQFAKJSiYmxFn82RJotCF5R45BgV+ECrGtKjxXwA/oQ5piP9MAho8iNdbK5E016Q5MB3rJ/Iwgw90ixEc+bgRk4ih2elQ4qQ6qrOHtU4JWFMdxQl6kpYfIdega/u8HGcBHkIgZW73zuAAp3Nsv/925Fx5ySKwRTgaTpdsim1bvv7eGJIcmTtjIDx9+f2uvOnW4dcHwfEedCuhfUgphLgj+pOVry8pk0V6Q0FKilzNhJzYYiAXY38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/weoH6ZmGNv3F1ySUYIYUkaiPCki7/dI1nyzOzA3iFs=;
 b=ZEF26RUqJ4NaFQ46LInW3i8Sv6nWLMu0I11ZzuhJGYOH9UwVLuA554YK0zMHREJi51+CCFcl/3DQeEogXj55kmXJiWyfuxonz0PHyON8y2xlq7IXQf7iAUTvJ9g0tOqg6QPzS1ofqEGhURISmIAwQ5IMNeHf+GhuhhSWepcy1HxnXgTsRLPrRVOXTGuSX7wYwUpb0iFZtyfBzt+ZKZNEbSjKlTnmmNeEXQGFvkfKLrZw+ih70ZFRPvAPa++5lQ7Z4vEJyONoXUXWDk1N/UT5YIRiRemMd1fMo8O2QLkvpFnJ7MBx4X9Jo4WMjIfs7j0AUjsarkQkkFuOqremO4o+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/weoH6ZmGNv3F1ySUYIYUkaiPCki7/dI1nyzOzA3iFs=;
 b=E2/VTqhn48JMTWQ3pjSIspfCjdTKfrIvysBl2M2Cu44nwQAX0DQ/z1QvRYraSdLllNsdmWeoyncQXs6hGk6H9p4HUlhaXpp87AngYUdrGHfcZpJGSCrdGlnmCC08bOs53lbS3U2+X9mFCHZC0d4E/S7KWU9MOCzBLptr2CrA+YhdaJSWx3pHH1qQjAcllWszbTVHx3gQwSqq21dhfnvnXJ7Lbjc/1+E7DlUdpN6UZ4kpv5UMBTxvdOv/SDgy/KIEmjuCUX6GjpgNwXnhD1OHhfZ2Hqgb4Z4n2VkvdG7GF4gLA3Rlu+F19mhhpKly8hj5RgAUbVhYWFnUKNuIIYDfNQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5265.apcprd06.prod.outlook.com (2603:1096:4:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:03 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 00/18] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v8 00/18] hw/usb: Add a usbredir server transport
Thread-Index: AQHdaqueTQ6Kc9PD/0iLa8igmngQXQ==
Date: Mon, 2 Nov 2026 09:22:02 +0000
Message-ID: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5265:EE_
x-ms-office365-filtering-correlation-id: a8a8b418-eb61-4f14-e621-08df38c2c14f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|3023799007|6133799003|10067099003|18002099003|921020|38070700021|56012099006|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261022113327099003|261026121527099003|261022115727099003|261022075727099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info: +6/1iqsp/kw29gWDX4qyBM0qHSlXrh2NibINL3kAdIUi1FH+b/ZCI4dYFlGn+hk5dacKpj5N0NEXf3qQinkngSaFvtWp2un1tLftD2NkYrqjDYNmD1frsrjhofDP0je7Z44ktt9UqREg24AA6vb206CKtkgP1PJp0vIRrDjIfI0VQlUTIKq6WyxIGbGJuCJ3lb1geddIm3b7zUhaG7M1o43NGdZQWKFvo7XsdjrhMBx5CO6F+YvVZlO7GBWkOQEp0LoOBncbDTsYZwlvADh/SN1QKNpvxXNJUWSiv5qL4Kiz//0Ev+tqtSPrmWl1xdB/pOfz0lcRBOrd286tTgwtN6CZLJDqpWFOBAuIEFCGoPixOXtRxZXJtzDj4eygQB84/HY09RZCttAAjIprXWI83TPcK9Gn3ts61+MsoNfl9Bviyr9mwINcI6ysm067xqCkCAv/Tz0aiUKAdDRvOJ221YZ0at2Lp1q/7C/0fOfeY9nvRMf+GR7raZj5wRXYTLRPgTzS+lzjgVcrAGiESECMHrcyAxa0ns7jCl8tWy/jzNsmotX3o+eb9yJVmYh/DLLtE7uWnhSsCJcceIT5bP6pVQavCmdWqAypdbO2QZCmZLtOhY5zhf97RmWhsZ4gepg11vCsfCddx9Bevx9tGBNEZ8FRczPquvtWPRbLWZmogOIl2glpOlYlBaGrlbWb1sQT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(10067099003)(18002099003)(921020)(38070700021)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261022113327099003)(261026121527099003)(261022115727099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vw+C4zZvdvYeXXvv/pEL4yZX2oYa5PD4uvtL6dNOSYkeCm37Oo9OUt4p0X?=
 =?iso-8859-1?Q?dzRJJ9/H9WXU6lne7OVg20U1mS/USVok+VS3DP3H95OedxHlxARrWvQmms?=
 =?iso-8859-1?Q?o7Q4Z8mql7+SDoSIovdg6SS1WEFfBZc3V7LDJMhr+aq+eTX5R/BSUDV1wY?=
 =?iso-8859-1?Q?l6INu/0giNloYzxaPZXZsGidWiqnSYG8DDH1qv5ctZLZZkHAHVw5ZNyvTh?=
 =?iso-8859-1?Q?vQd6/E3gpkYXn0fNyKkWw8hJ0y5FZMwMsI6vcxemmA1aAz2AykRs2LMEwh?=
 =?iso-8859-1?Q?cTzKTgzDHKHTfpVu7MTeo1+LwzYw5god9eMlEu8knbWTzeVjHYzt5Cijap?=
 =?iso-8859-1?Q?FAbGLoBgeeUMfLBodv6r0ZkJDYtxXFv4TIiW5yT52VACBcLUe7LD/bATRK?=
 =?iso-8859-1?Q?Dh4tv+NSzpNGzpmVa13SP+YQVFVWbwcaEqc6ZremnuIVZAlwVOACJyJ2nW?=
 =?iso-8859-1?Q?Uv1+ecgeCblPhqbb/g9vF0wsSkYOwRKDXoaOAryI844c53y+p7ciIDtk56?=
 =?iso-8859-1?Q?ky4BwVzobIzcTnH3mDZApfIfEzhLZix2bNWCuD3J26QTuB2deeDG4wyRKM?=
 =?iso-8859-1?Q?Gwo5WgYd6TIJ2BNU+sKKaaRn1cC57rcreDHmDJf1HnLK2xCL65NFbZUyvl?=
 =?iso-8859-1?Q?f2yPLCgnTneCD2FVdqBWDhZTDT1cutbT6arH/U5vrC1+1eXRaR5fsIMY66?=
 =?iso-8859-1?Q?bOdUV7yWweSWh5dB57EsSK40RQQM1UMvuaTapxfTJWvTCf5H9kNY36k1wc?=
 =?iso-8859-1?Q?MZpaKABjDA1GkNqHooe+IrdjPYTYgy2snfvyMbt4fNCXLPcWnX9MVxN/Cc?=
 =?iso-8859-1?Q?FUSMiop7GheysjDl0vctEcwyr9tXwVWdoPNVowxJouBGVpM1hGM49wKsxh?=
 =?iso-8859-1?Q?MfYZuh9MXCaI5FuFc04m+pNI22L55pVVtX7uISSNVhIwDTydjdnlnCUoGS?=
 =?iso-8859-1?Q?4oBG3mxa5WQZkp/tkmNu0h8/+huUrY7+mW3ZKwShPeQi7jV+RhbsITIWno?=
 =?iso-8859-1?Q?6ZfLU9VsdEFcUYrRa2BvAYVWzquiJ23qgHKTU5LbFfui1bX9dTXA65Ee5R?=
 =?iso-8859-1?Q?9ztk5mlzqzIVr67dM/EiWmCpqGoQBdlBF6M6MUoUF+m1NKo8CySLp6IjqV?=
 =?iso-8859-1?Q?vmVhUBgofb4U+aK6Y3Jw6aYtl3nhetCgf7hokQHw+XMz5Ss357qzCW6orC?=
 =?iso-8859-1?Q?qf4SQHwD+l96ceMldcF9u2akvoqQ11FzoCCSbvV/D7uDVZuhPeY1H9iL5k?=
 =?iso-8859-1?Q?5emzG3bHnQ3FsJZ7KSaPQkirgO5EL3GTQkcRYp2lCiZz5KqWI1fceVmK2s?=
 =?iso-8859-1?Q?t8WsZ9Zl7glkW738Kt1HKC3RPdNFRb6qZeoG22UTnjIJHuR4dB65vKrbDd?=
 =?iso-8859-1?Q?JO742HKdckrdH2Qj7PpLB4yiVHr6B2WgYpBRKvZqceFDrs3k34k//nODNT?=
 =?iso-8859-1?Q?FsdWXm259jPoVIAo02wOMmT2uuFI/NEhPYe8Lx/q9rgGij2/ZhLN+F50ie?=
 =?iso-8859-1?Q?jqr+F/BKYrY692ZIG0JGE1y4i5ClJ0fs4ub7xbupu66gR94sPKdeRX1BEA?=
 =?iso-8859-1?Q?yHQAb/XBA5sODPlVfelRttEnVQS3guOyg3wbmnT0kRWNGjVRL4tQPLQZ5z?=
 =?iso-8859-1?Q?e23BELi62JHu3WoBw/Wi6/yH5KnE8jI/lOXCDsTbvXg80SfhMhHzYVgqXk?=
 =?iso-8859-1?Q?4JcgWlAyHUsBSVNDuO9BqXkp+tfW6nwaq4rPJODwS4xgRJgufKH8F9rQEP?=
 =?iso-8859-1?Q?2qL8zIBoQS4UhRL3uRSNDgl3gs7YMr7DEU6EU91fkNp0D/YWg6zpr1PGou?=
 =?iso-8859-1?Q?kg6RDiJ9GQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uBKjgVfodI79C/up70Mk140Z505l3R9RVLbZ3QxecXYobluGUbQAr2dbyQ4Gf+bpzuvLqpa4kMjiJGXU187Q690J1EwVJzZub6vLiIm3Ma/sDI3cMOPkjQ3PezQoDBtTvI5vFX5kV2ZAFYqJuMCzQiFZeRRkCubGPfuYniZeCfS+J/A4UB9rjQbraYvmbhJ3CEzSNDygkVNu5l6A5wmfg28m0iOCabGPL+ksM1djUZYO+Hxr7707U8lTYu4AvurNaL6dV2w+8AAaD2bRjUXu80Y6hUq16Mj/BivrfdCV63sgfu2LcjLuz5GQfiqrqfDtzOVXa6/pqRBOa4b6R6iQcQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a8b418-eb61-4f14-e621-08df38c2c14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:02.7518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wn1MkdSahLvIWZO1BF5+lKrwK/a7tu8UL8rwgayszts5rKpJnuF6BbUoJrXMHoGobaVmgExt0MlI4hmMcq0m0wzu3ptRhFg9jiz208DGiUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5265
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
v8:=0A=
 1. Report how many bytes the device moved on a bulk or interrupt OUT trans=
fer.=0A=
 2. Implement isochronous transfers for an OUT endpoint.=0A=
 3. Announce the device from a bottom half, and reset it first. The old=0A=
   path hit an assertion, and the device has to be in DEFAULT state=0A=
   before it can answer anything.=0A=
 4. Avoid cancel a streamed interrupt or isochronous packet.=0A=
 5. Turn the automatic hub off by default.=0A=
 6. Give every USB host controller an auto-hub property, off by default.=0A=
 =0A=
Jamin Lin (18):=0A=
  hw/usb/bus: Add an auto-hub flag to the USB bus=0A=
  hw/usb/hcd-xhci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-ehci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-uhci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-ohci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-dwc2: Add an auto-hub property and leave it off=0A=
  hw/usb/xen-usb: Do not insert an automatic hub=0A=
  hw/usb/bus: Turn off the automatic hub by default=0A=
  hw/arm/npcm7xx: Keep the automatic hub=0A=
  docs/system/devices/usb: Note the automatic hub change=0A=
  hw/usb/redirect-server: Add a usbredir server device=0A=
  hw/usb/redirect-server: Connect usbredirparser to a chardev=0A=
  hw/usb/redirect-server: Announce the exported device=0A=
  hw/usb/redirect-server: Implement control transfers=0A=
  hw/usb/redirect-server: Implement bulk and interrupt transfers=0A=
  hw/usb/redirect-server: Stream interrupt IN endpoints=0A=
  hw/usb/redirect-server: Implement isochronous OUT transfers=0A=
  hw/arm/aspeed: Enable the usbredir server transport=0A=
=0A=
 docs/system/devices/usb.rst  |    7 +-=0A=
 hw/usb/hcd-dwc2.h            |    1 +=0A=
 hw/usb/hcd-ehci.h            |    4 +-=0A=
 hw/usb/hcd-ohci.h            |    1 +=0A=
 hw/usb/hcd-uhci.h            |    1 +=0A=
 hw/usb/hcd-xhci.h            |    1 +=0A=
 include/hw/usb/usb.h         |    1 +=0A=
 hw/arm/aspeed.c              |    7 +=0A=
 hw/arm/bcm2835_peripherals.c |    1 +=0A=
 hw/arm/npcm7xx.c             |    2 +=0A=
 hw/core/machine.c            |    6 +=0A=
 hw/usb/bus.c                 |    3 +-=0A=
 hw/usb/hcd-dwc2.c            |    2 +=0A=
 hw/usb/hcd-ehci.c            |    1 +=0A=
 hw/usb/hcd-ohci-pci.c        |    1 +=0A=
 hw/usb/hcd-ohci-sysbus.c     |    1 +=0A=
 hw/usb/hcd-ohci.c            |    1 +=0A=
 hw/usb/hcd-uhci.c            |    3 +=0A=
 hw/usb/hcd-xhci.c            |    2 +=0A=
 hw/usb/pc87560-ohci.c        |    1 +=0A=
 hw/usb/redirect-server.c     | 2075 ++++++++++++++++++++++++++++++++++=0A=
 hw/usb/xen-usb.c             |    1 +=0A=
 hw/usb/meson.build           |    3 +-=0A=
 hw/usb/trace-events          |   39 +=0A=
 24 files changed, 2160 insertions(+), 5 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.43.0=0A=

