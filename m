Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B355CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjcR-000189-OK; Mon, 19 Oct 2026 05:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc8-0000pA-Eo; Mon, 19 Oct 2026 05:25:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc6-0002q3-B8; Mon, 19 Oct 2026 05:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgmijFeIjV9oeQufaSPFz5MI1Q/JoeVSgNT+/qSFa+AF5LSGQc5NnBZpE69StGStUggHKW1n/XBDwWH+SXL3j5ciV4fD2OSHFmYQL0Y00HuLQJtpHOyR5HPG+jQY/CBr4nfX6gT5L19wQtElYmHfUSdFx3MSsvnvfTJSZScUrq544lLFUjnSUI2pAJbT6Iic3qgHb7VYxtdA4n+eizU+CTI8guzJIqTMpXoSt9yeaz1tKEu6ZVnGBTLebaG0oDA9aOoOiyEZsZ6hY0G8b9cB4GNY3X63qEX26KvhxVi54Xu00HABnMAVOhIQLmVmCZM+yR8hSPVrM7qAF+XbnpftQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7QpU1I9PddUbq7KU7W4QSCJqTAKi2IkgTSdW3O8SHg=;
 b=v1K6gN5T2NfBfS11muUXDZnqwtsU47gSJedj9zqSJ8BGzpiyTXuiCK1pclajSXbv9nrUdYN9IOb48D6i95abJjwRte6omgb+7c42qO2nCeL1OeuPo75wzr66PvpiV0n7LToSkLbJir8msyRzMieE/CymlRDInW6/IfEpS9X2rAlIHx2TmGf+bqDauSFOc1h211eVv1EBTpNlHTIUEU7knu89RQdck8W1QZNCVYJKm5HtL3mBjGio6SFhZdkE/gfBiIq04DIM1M+YyaBMO3hYVhdYO/1uUTInV7MPx3YERao5LQB67xZS5mU7pDKLyx4kT3ik0y4esZ9cL5BNNzy2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7QpU1I9PddUbq7KU7W4QSCJqTAKi2IkgTSdW3O8SHg=;
 b=f5vleaekwM8RbbGmPb6wujrHd5MPlSXydng/iyVd+jseJ27SIgeuqzmjuNgeVzfgrBttElvTa5EaPBXd/9Of7GeGQW/vQTZb7reoLYOyNVbUttY2c5SEQpykrPbrG1mhPgvPMY95H5DpbqutW/BrlkndEtgKBXAFz1kV+3APyEsUM+QBtsO7veO4q6nQ80Y9iu1fcwOc76Hv4p83R2VqHO+0hhZ67X5/b+BQHAGDxsHfMRNG3tGrFveYW7EhblGuGtrKUtvSDp1qZ9KVI6l7ILHYhVgmKUsmpbDTXrnpiDoFblPiAf+PnT2F4U15ItSQPmoWl1cl/qeoJGXl8+hqMQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:49 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 0/8] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v6 0/8] hw/usb: Add a usbredir server transport
Thread-Index: AQHdX6uwUe8c5n7eQEayIOsedxH9NQ==
Date: Mon, 19 Oct 2026 09:24:49 +0000
Message-ID: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8674:EE_
x-ms-office365-filtering-correlation-id: 36a24b8d-726f-4e13-a06b-08df2dc2d2f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|18002099003|3023799007|38070700021|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: TrTCq5MV7X6508xbTQrtbZAJ+h94Vuqa08+KULpqrCPSwS23vvSapq7R6ELGRGDn3u4z3qURa2ZiOsv0jpbrJpPP91eXTPxacGf7xTGI/h7hA0cJHKPQ90oBhRltydM4MFGyFP2euS71Krn9Yyrku/fqahXd2nf+2jQbDOAtndl/9oXw+psuZONr59rGxjSu0TG+ZXcyjfFViPkXLC/LeKn0Md8k3SEwAPvYDOSXvGMCg8o6f8dCZ3yCwOkvMug8jV/H8Xl9IaRoAYBSNlRf/pXbX8V3OBjQyRD2XUZsyi5XVfRrvX79BTyWOYxzD4LT6WkKem11uKBp8E+7qNj+v+F93Vb261wKyO9LEqBVMfUSNoN6IPguk64K/ETi3Kd0UGqOo1+w3dBLpxV7RHeGlaXiD5ijNWCd4pBKgI91sZWQk23T1KURlZ21Z+Ewek+lvOsM2iAdRp9lVXq1zDfIgvuer5kUjU4P/B47iIdz72+yoA6G8shO8yd4CO5gRdl5wfgbEoC06rl5rmMm9Oo4zP2RtbxxqFWBb9HpBEh4E8laJRVOYbzSjFJHORkWOJvVYtFghehISCdIGgUbeO1sSzWktPn4vw0eo+J9Lya4T/WBdrQkShYeWmNoGBL/UCDtaFzMFdn+ayyfqxQteTD5SuKmoCdrfpZuO2lE2LbDWAw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(3023799007)(38070700021)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b4nywfRZKy7XlYH1ZoCSknOMiwRwxZUxWwtymgDlqpCCpJEs8Dqp9PMnI7?=
 =?iso-8859-1?Q?0xUtnJ+y8o5Urjl41/4hsJQyHOJIgcLVGGWjsMorbf5Dw4q9DfXK+jo+hw?=
 =?iso-8859-1?Q?r4lQbu6YsQLuzcRxkpMlcXeINOv/NiaIyQQVLNwaWat1rPd0NlTkHzZVdq?=
 =?iso-8859-1?Q?fSdCJwvAkcMORFUQeKtfIeai0tPfqNkpTd2a0rutZz+/AJ0384FSkufVQq?=
 =?iso-8859-1?Q?3GFfJY7Xnr5gkv412Q/WYRQLzsLE8WTEcuT5VY7Bbx0M7jU+Me5fLVcj5w?=
 =?iso-8859-1?Q?KmruqeAsLSv6v6aPMzVS6AdXeHLi4+kG+OjZdA4rVyPQFg1aWEYDJRtPqz?=
 =?iso-8859-1?Q?oYPbBqgcUjgsdsG69O/xNRQc0JjjVMp70i3IQywI4f3v42AHUhdo9PJM9h?=
 =?iso-8859-1?Q?jEH/teU47fK3g78509QRX7tJamfCOGuuLUu7nUfxlz0zrPInGEGDwScwCy?=
 =?iso-8859-1?Q?R0Bl4cJXO5W7Ra6hSyL+6ye73SXlOyQfLtg1CjZi1f08vRrYWLnwlGPO63?=
 =?iso-8859-1?Q?+kzswLqg9NBwdWyJHkeoAYXBDQ4NkER2uF5X4Pbw12n32MbAezxAic/xdw?=
 =?iso-8859-1?Q?smqWoN7jkzGGfy/nVwxZhigMa+Zs/oNAnUizZzSqMKuNkqqTSfSm80qMmN?=
 =?iso-8859-1?Q?qjbbg6muUWBuXkmGXVCoOiheukwfgSpcEr5j+9UIXskj+KCGp/rzFPWjy4?=
 =?iso-8859-1?Q?USuwBoh7/PA8qjZIKvl3qpG0owds51yikEi68LUCvZmY2xF3vCbm9iwkGR?=
 =?iso-8859-1?Q?KzN2ZvBScddhUPJfg1DARNw7B1kLzw07lYTrtDS8VPDZyZOg2yfd1/TuQq?=
 =?iso-8859-1?Q?bjXNbDuzdOgDGDmzi/1xvUpaVPKUOr40px/c66NkchG30oLITu8mc0+I46?=
 =?iso-8859-1?Q?rp4+nhvH0qUY8FoCvyVits9kLhC/kVTkN+m/+mLV/vEc4ytD5xZSv15dsd?=
 =?iso-8859-1?Q?MMgVQkOpEfQA6vN1h1DixGGVZ+xSq8HM1Dl+9qeHNylX8dwzAZClElVMzd?=
 =?iso-8859-1?Q?D6LbNwEZUKeDee0o5AHBdZzL69EX1ujtbWxPa4nNV/05H3AOozDnUt4PWz?=
 =?iso-8859-1?Q?6yZW6VbwB9PRd5oSgRPu+z9Nux2IM2+bcPXv4lTAyQDLIDSmaFob8xDHAO?=
 =?iso-8859-1?Q?BwouhY9T12ZhXHSZsF45ooxyEllWlfq/J8X2w8osKv8qItUwbMet6D82B1?=
 =?iso-8859-1?Q?p29AiBaN2C8j9+Yglw9w3AN6S1Jfh/tfqOtI4BK0VVM/lagEAWCUsI5sU+?=
 =?iso-8859-1?Q?lIZA25jt7TxoXRFE5oCaJn8IGFa2Igsp1KZBYh3q0YMWNFzZeAqq+JK3UE?=
 =?iso-8859-1?Q?trg++Be8Vu6qS5vtUl/+rCZqlmoEY/XnQdEwPjBd+/2HZTW9xF/ZO5ieWD?=
 =?iso-8859-1?Q?J60v5EVlAmwcer2zK1P/KeJA8YPBtOpv7LZeilPgRGcUWG3UMpuViqsaeF?=
 =?iso-8859-1?Q?I+nL3rB85zc9sDt1Fe1duB6G50KiRdIGjo/F+GqJ3/yw7+NqzUHc02V/tn?=
 =?iso-8859-1?Q?oH3xiE7gMvckguIjoP949CZjYUButJV9wl4gRPNwGOhce8g2SN0eHA532C?=
 =?iso-8859-1?Q?TbG+fo8DE8N550lKBCYr0tzdaAdNe6Zgdwh7hzw/LCxLK0qwfRCf8QiG7Y?=
 =?iso-8859-1?Q?v+VSnpEV2AHvfkjUtM4HMNbpjm1yEZ4O8baprqA2dhg4RFYMSRuuK5IEax?=
 =?iso-8859-1?Q?iC6mkvkJQVBfgGXS51Ghrngd6xJoo7n3kBsAi25ej6YmAga4BCeV9mHgHk?=
 =?iso-8859-1?Q?IlHymTQXTdifjPrCtInNI+r6CqJ/1UXrpvSHRNT8wdS8UznPKeIdyfeIyF?=
 =?iso-8859-1?Q?j7rhmAgzug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a24b8d-726f-4e13-a06b-08df2dc2d2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:49.5057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9Ifjc2RQzcnljomQhdGNG0EYiBiSo8PgWi9tWUT6c8C/mXkNhZVAWcRPl7t072OPFDKazKQ+qpTMEBOanWl1G0aLR45HP+KvoDnhbcd0B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8674
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
 hw/usb/redirect-server.c | 1817 ++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |    3 +-=0A=
 hw/usb/trace-events      |   31 +=0A=
 6 files changed, 1860 insertions(+), 2 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.43.0=0A=

