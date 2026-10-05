Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DAACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFl-0003eQ-LC; Sun, 04 Oct 2026 23:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFj-0003dl-Um; Sun, 04 Oct 2026 23:20:35 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFh-0000R4-1t; Sun, 04 Oct 2026 23:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvfcU9+UsLigFnh+p3lWVjYwgfuSjV8mzlj3D4qT8nurD1PgJHE2TihJSv4i6O9MsyfZSnizqQrVpUDSSbfJLLxCuNemGxaboROlqhgSvY0DBPTraut58JKn2lmzfa1kLZ48mpLp4+jj/pN5GV49PzYBAxO8qg7Abma5QLUw9VsQHCuCJDMMQqkkOrmS5eFZ9KYmhzz9oOoMurIeyoS78BenLsUzpqmnizFKYY6/NqUWztiM8EFTIvzbffvEIXrZ3MJuq6dETSKfba3smJz+6Y8HogVuNuwU/42RdfWzbGInnoy1CRybgtKyJwpj75qHhV5JG02eV5GzLbgblpsbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWtWGH0Q+1ESNCGIvX4vOsnLVZSgq+WGiY+Ug/kPMi8=;
 b=Y/MrS5ILisAdMNMPrOWr1tGp9TQPD+wOleQ/o8MBZdbIAbkSrLOAeClcuwpm1TxznqXnjv9/ajhtrFhy+lOFKKiRCWipq379bPbVtyirC/Tb4YzN6vwjBOOsl0gJYYBNUz5lRsxEj3WZwapSO4CryvzCy9DK772k8+nkVzxfvWq6yKvVnJtlgAH81DwF8qutGl1o0YZBQEe8Vlt8NhwvTh+qHWg2FkgsQY0R/l8MU5iLX/fuUdcbbs7TFd+PnrOmr24x3oM+neD9+3lfKZE4I1uYOaH7nU88+h1GsWUC+LbrZo3Fag4Dblhq6Afesdi6sOR819TlPP3vFQ4A16/u4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWtWGH0Q+1ESNCGIvX4vOsnLVZSgq+WGiY+Ug/kPMi8=;
 b=HRHcs+YJ+EBxdpRe/GG0+YQtDVk8mHehel7E7rngr0uLRQ6v9o3nKqnGtj1WDXkSY6RMJ9+0XunwtwO4SZVt763R8PCPHd3iKaENqbtkWA83NgADQZ2+lZI5AlFRops+k/ElSVj2C6BaWM/btQM5hcmbguE0B80DhiuBFp1OOPHTnm6By4HrDkv/CqaI7YDF6Veh08/456CHpOiZqGoGhgNX3x73arAdB3vtNXCPTFhDZAs2TqNHRUjw2Dh3dwLoIaztVHXUGyT+30q983QDby0K6DS2crwVIIwH59bb1M/LY+Cu9b8BCdx0RrAz44n0XQlf/R5T6qaqOBUufpDRGg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KL1PR06MB6396.apcprd06.prod.outlook.com (2603:1096:820:e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:23 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v2 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdVHh1XDfdwLBh+Eq8dXlQJCb8eg==
Date: Mon, 5 Oct 2026 03:20:23 +0000
Message-ID: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KL1PR06MB6396:EE_
x-ms-office365-filtering-correlation-id: 81de1587-a62e-4630-86a5-08df228f9809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: tZ08Ry+gEFj4Ylrqw4TXBckQG9zWT3m4BgGZi/WgVCfyWrl8P+qHdjY5wbF2tCNxIKDyI9rY2OqDAMzBPT2t5bQT1uY85BnM5FFvJW69n69W/dzGOARgVi2rHB8hDDtLCiee68sYAYp9jUoJ7zPLM06Zm3i1uDP5T0XPik+KAeUWHU2wg+K7V09iIIoBDb4dB0DIq76uSRL9PH0Ht6AYeXB+eZ0rt6ahu2Zun9Z34lOhU9bb89vgWqoCQrrdGn5+sHRvR7YSvKaMn9zD2dvwr/z8djN8MdGmES93iZpt2NM9Lly1+qasCO8lPj2PNpQBC12Xgd4gFXhTzAh8tSoczksL24vik2hOUMCLqBG/1nCXZl3cVQwprG0gbSBkZ8HdbQrYNXb3oTHcj8iiaAet59AHopnOjZVsfHR91UI8ivwTkB4fp71/r347xicMB8iHjA2MB0FK7S4GqC/tMgPQDjg9jFb+l8M2ewIpu4sL3mRx+uAzzKUdGSIpLjFjsCiJzb1DfPi/IzJ4sHUytNO+aBsRIm1DrvAcC2fVTy0eTgUJl0IV2re4/ZvHhDbBGOrp/+8yPSe3TvMVJyn5+GRDVprinlI6WlKXGd7jg3iQ7lJ0om98t3ojtvOm1UftXjc5C+OLt4S7Kl9pycY1btNYyR+4hV4TeaEOVH7dFfwgq5Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tSr3hISsLKC1zpQw3kU02He+g7RRNcb1jZH1TOqIGQxgm9exxoeNZN/FxnSJ?=
 =?us-ascii?Q?ZY8PvAShRRxsuHM/SB9hNPYT7oDSe8vv3cSeowNQdWGjv+oBOaavIqryXx28?=
 =?us-ascii?Q?TmCrmBEXlLZTvszdUJq7IdTuBHo8rn6dctbhLyBBwGq4ZJG1NjTDEd6aUUiX?=
 =?us-ascii?Q?hkHAAPHuvKnzlrkPTuTsi6el+XQ4iifcHIAZb59L59ebyVQzYSwkomK3dWbT?=
 =?us-ascii?Q?WEpLRYJpRmCtcc1lUv3Z9caFmCiPP5qj3gLC4X1/zSavUMbjqgHWDkcUYmUB?=
 =?us-ascii?Q?usn8rYOtrRkjZxOB3hA96nTZdEaznRZ59GACoRgmYpe6Z6Fk7BpHJ4vvxTGN?=
 =?us-ascii?Q?Fwbq3zKWqjbMQPiQ3rkw8fqQQaP7sgVVPdCac+E/3Ist2kmMhJ5x1FIXVFt6?=
 =?us-ascii?Q?9Jkg9Ic8/pw4qn3ToIeaK3Oi3h+Hbp1t7t+x2GGSgrEXFlRpv5zt2QBUHXQt?=
 =?us-ascii?Q?CfxXAYwg/3cC7StqrkkgOZQXYJk3YCLS55ara7qf1NS5Z8ZW4gQmhBmhHpPk?=
 =?us-ascii?Q?XQBohW67W9Lz1QEDzlunt7DWJWVdG8cBkAmwfPlGuKrR6/9PVIng2KXXocjZ?=
 =?us-ascii?Q?lwVQ8Tg2hZ37my2KhxpjCpHI0vHsZjsdux2uaCWZ+ezyc9306fXPgYgbmZyo?=
 =?us-ascii?Q?SX8xLDKRF/2cCDx29AD0nAunbTYEtvmMViaVlSCdvHvEp/oPE6lsIHeQpPNh?=
 =?us-ascii?Q?HbaqlwNaX7J5E2PR8Xmx2+BiX6mIXEzfg3t/fXKaLMEVFt0woKjBYMq/ZV+F?=
 =?us-ascii?Q?ifkF2b+r2k/qL3Q70zTHNYrG7lVU6YOJt2JNkF6ochho/68nlMn/YYDjgKyc?=
 =?us-ascii?Q?UbGzGQGO0YsI/vrLlHXl69FdKIteeZVZbrHlEfjx1p6QKI9Dz+TLTZs6/Szg?=
 =?us-ascii?Q?EUHqUJ4aX/s+15iixmg6VDgOXkADc4lOO/oubuq+y3Az41IBPzmOKCoB+Mo9?=
 =?us-ascii?Q?to3eK0IOdDLKKxaPgTEBfyTWLP04xfRpmLtG81FMUhxABEZVPonjX08eZBqc?=
 =?us-ascii?Q?bPxWz9ByfP03qDKRGemzVUYrKSiy8lpHNfqUNlDLjJYHCoxEn/jbSyIB27l8?=
 =?us-ascii?Q?I1hL8fuu5nFZAmViPbIHb6kr3HJhqXI8g6kcudaHWeZWYN6Xa5m0/V90E8d5?=
 =?us-ascii?Q?QfZiPu0U1UvLjY63AtRXKaxhvTBnSi1oepCUubi4aCi/hCDMAqYxhtZFehiR?=
 =?us-ascii?Q?HrcHumz0AiEZPrr7vxk3+/SwOuVMzEabpcuWVRg9Ic9L1voU7bC2bX7ejxsi?=
 =?us-ascii?Q?hANg7zCXAGAzyPqiSxPd06xfQNQ7MUCweTDVQrKPiufpg/mdEdIYRPnsLC0N?=
 =?us-ascii?Q?2eHrU6j9O7P8IwBRN2Ud0Dt5vVNtwixB1pPZIjnBKmiLe7B+zCcdy69Dk7iL?=
 =?us-ascii?Q?6+oDq8JtqlBXyQPnCFDRjn4WNfKMXLeX6+Yt85SEu9txBThIHrMZn1K1/EZt?=
 =?us-ascii?Q?s3Wj5f6ncFTaxPsg6zF9sR/0BAJs9OIzMz6jaVSVjgAOqxlyaAhNLlM3k8p1?=
 =?us-ascii?Q?7SBqUThIfUtsvRPWlG0+cw4vitlaZmb7nicq6xkyG4jCqk9Y72r/uBZsiIap?=
 =?us-ascii?Q?e/YyXl8WdLoaEqzQzzCWnOihmogIV0ZyI8ywpsoG6go0Czovcol0Mzs8HZLR?=
 =?us-ascii?Q?HDSJkR5EBV6nZN+jOPE9IYNbbYO/8a6XJQ8SBn3+HLiMBVPsZxTF+91kg/Fd?=
 =?us-ascii?Q?+11DTOsaRDBj2FkyhocUFVuxlxMtN5AVs90ZRQYb5ayal/3h4nWLi7FsYbze?=
 =?us-ascii?Q?h9n6wDMw3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EdAolH3XIIu5ba51S9hV1m6n7QcgCScTiXR28jyy0tjlhiBoq0SncG1m+u94/3wvrOCyRHOwXxcgZ9/FhpoLxLQ/Sd7rrrjh6qOiofW6BCJ/ad8i5vJ8A1zuh0SJNHXMjt4oQTCKZsiVlrx9gqH3JHrwR9E3JYOuL9Ij9YOU8T4VWyRRoQbkeSW4TYKa73NdKVdhSYwB2Vng8pdtzBIMEk7x6pKpPQ9ViOO4tX8PBDWf1UZWanm+D4X7DUwn/bRNlpVtH6tSKsUAJQjnboIZtpac0N3gM153Bg+URMC8X/gYMR+mrrtR5oFDk3uTKt937KjgEMTBG7z9q4z1OmeMbA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81de1587-a62e-4630-86a5-08df228f9809
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:23.5730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddqKFz1k7tkdiKqz+o367c8sZLTYp9UahqpWpcMn/RIqJFQy0IXN99LL1BTXxuj4X8y42s8nYwv+BFitJv7v5+QhIchMefrdzit8V25pRbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6396
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
Testing=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
A plain usb-storage device was used to test the transport. The storage=0A=
device is attached to usb-redir-server and exported over a Unix socket:=0A=
=0A=
$ qemu-system-aarch64 ...=0A=
-chardev socket,id=3Dusbredir0,path=3D/tmp/usbredir0.sock,server=3Don,wait=
=3Doff=0A=
-device usb-redir-server,id=3Dusbredir0,chardev=3Dusbredir0=0A=
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
This also demonstrates that usb-redir-server is not specific to the=0A=
ASPEED UDC. Any USBDevice can be attached to its USB bus and exported=0A=
to a host controller in another QEMU instance.=0A=
=0A=
v1:=0A=
  1. Add a usbredir server device=0A=
  2. Announce the exported device=0A=
  3. Implement control transfers=0A=
  4. Implement bulk and interrupt transfers=0A=
  5. Stream interrupt IN endpoints =0A=
=0A=
v2:=0A=
  1. Split the original series into USB and ASPEED parts as suggested=0A=
     during review.=0A=
  2. Keep this series focused on the usbredir server transport.=0A=
  3. Move the ASPEED UDC changes, AST1030 UDC support and its functional=0A=
     test to a separate series.=0A=
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
 include/hw/usb/redirect-server.h |  116 +++=0A=
 include/hw/usb/usb.h             |    1 +=0A=
 hw/arm/aspeed.c                  |    6 +=0A=
 hw/usb/bus.c                     |    3 +-=0A=
 hw/usb/redirect-server.c         | 1604 ++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build               |    3 +-=0A=
 hw/usb/trace-events              |   27 +=0A=
 7 files changed, 1758 insertions(+), 2 deletions(-)=0A=
 create mode 100644 include/hw/usb/redirect-server.h=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.43.0=0A=

