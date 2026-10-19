Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD182CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjcg-0001Kf-SC; Mon, 19 Oct 2026 05:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc8-0000p6-Cu; Mon, 19 Oct 2026 05:25:06 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc5-0002px-RF; Mon, 19 Oct 2026 05:25:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLJpG4tBWYHtQdNwdoqTjZJ/rhaYz7soCn8rp/f4SQETRlnjQfgSMTbwo5Afu41Ss/G8yOcJnOR75EhahZdS77GeF1OCHbUXiVU+AsAIdSYduHsmDpirD5IfVZsKvWyfCqm9fyGktmPk0UtbUOUjrqJ8eViuKkochbQQGJhcVStKIMaIydDNBqb4WjIzmAL7NJkYX+8MVHYIcwhXmpqCnLlwWq3DLRdIr3RK6k9WZywC3+sIHOF8CFdpuBMdZTiqWm4wOGDro8Ji7jONEHvG3D3AUMW1HH/L3HM7p31s8Mlk1gac1ej7vzgcqbS/MkTw1sz2iPUykqOGPFnjvIwg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoIdk+bIu91xNHY/z+G3v2+Q6AidKeXa+hnwvGsnAU=;
 b=QlCj0ZdjCiKJ0yxgnGF70xdZB1Cq5ndhNUiM2fP1SNzdCYXVpmoHQwNXbISCboxK1XIQUyzUQkQfSyRHzY3IYPKUEgS2hPVyGRIOz8sEAaa7Jpn+D6FzM0xxi6Su/w3AMFzD8D+FptwghRUzRWOyv19/yvPuFHSZbHdp7WzE6xSVVFwodC7CbHwJ+NAqDX4o+itVaZqqmQbkorubLBgmorf+DCUx03tuv4C3+DBc6U/M+htICYmzEIxL6HayLz+haTV24HIp0zSK0yy8P83QNk7Gm/+TqrB+3oqofACIZAtyQ4P50Q6V1v0S4hBkffLnhSxcV+Qfl115LBd+BeRsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoIdk+bIu91xNHY/z+G3v2+Q6AidKeXa+hnwvGsnAU=;
 b=F5uJjuK60vsyisQZ5Uann1nU9OPGbi/9QSvXSd6SFZxoLogzK1OVuKbOPOMltnY9z/W8YwVEPEckFMwf2Sobhzwh6VQ/+N2h5ubfceokGUkyGfBhFDD8NBrDrDm0sjDEu4xj8/p203PuPG15+Iy2KzC6CypA1wHy4KO963QoonDcFnMv5OSRZXwl9GfqhPE5LQS5Bq4G6f/0oaZ3RZtihw+YCfqfVaneX4NhGSlTl/JLnmSWBuLV/w2p6uYG3crfuwSUTdJfKtoY9FLTHexyDBRkSDjvoqQ4e6BWGBlHMfqhkCEYXxKVcSrdEP5CqZripGP4iXTw7vdjXivNX+c7aw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:51 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 2/8] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v6 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdX6uxBAEBWZRop0atMAoc0Fd6DA==
Date: Mon, 19 Oct 2026 09:24:51 +0000
Message-ID: <20261019092448.278079-3-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8674:EE_
x-ms-office365-filtering-correlation-id: 41c6ab13-b094-41d6-141a-08df2dc2d446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|3023799007|38070700021|260925021311599003|260925021911599003|5023799004|10067099003|260925022911599003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: CEfVTPsVTlzXd9YBSnsDH7FT5YRL5U1XG5ZYrmsaPZX2CeQ+o7WetgItKY42ULtv75KHz6W84s8ZYB2EtVviyNw+00u21/TwaT6AF4EmnRI1qeVNCU225PVGyB+MveC36+kZO/fHFjzBt0apm1KrHoX1jbph/JY9g4xAj+ofUG7hMrkh454slXxTKpQynZYM9f1e5NwoWaRBdAwr6y6DqVlIgx8Z+tpK1yOtai2sNusjaFqfEYtzuy1SSoSVyr1k6C5AHbprbKYl856a8n5tCQHnuZuxfOK6Fu0lefGagcPRgsI4p+hlni6Xjc1mebpXZLXQMzBBrAAp/C2mXekMaZv8vpBhsJ0yPRixMi/3zM+0Tj0hhbdmTBnayRr2HrPsQhL8Py96km5hOxJs/n6GWrDE3TRl1fDsmWuT76yENVmci4PsCleJKGUHV6PE3m5e07lY57HJK6ILhx2snJnDpK4kDQudP0WFdtvhLUSaObgf2I4ax3O3tKNJyxTGtmI2Y8EeOiojFLofdzdCWK6mgq0wR08ZUtO9JQPrViyoOpMSC2Ikzu2kMPgcU5PrzHfbGazKmBJ86YoRMHH6K/6uYxFHg2wIkj6zL2ItEJmgdi45uEHvd/Gf5PMpMdP4ER91ZfHud4M+alypBHxfkXZQxYL85NBzThLxMci1Iz4fkfWprogsG4ZGPCX+3K95fQTPCA9EVPIAFwd5OSV7l3TSqG40p72DjcKs8rLmUTJs5YQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(38070700021)(260925021311599003)(260925021911599003)(5023799004)(10067099003)(260925022911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oo7FCiaKx69VKDqOfvOdoI2PfgeyVzwZ7DQMGpj45/Sy4X1Q5YZf6pyp4B?=
 =?iso-8859-1?Q?nASKgn+F4omTKDoQ63wVDhz9ZgsTStcfwBgHlshXYvPx8qvnwdqqYuIiWU?=
 =?iso-8859-1?Q?ilGau9S/EY4ZiGt1WrThco47oYUcSZx1ok1qrSVd8zo9cVkX3gNE8kPVGH?=
 =?iso-8859-1?Q?IvdRutM1WSeN2TWkEOAcOUmPwF1ufrCIWIics24mT+foe7rCuuRfrik50Y?=
 =?iso-8859-1?Q?qC5ONy7oQ41zylE8zv/m1A3+oMirz49Uu2cUpzDx8h+8WcbeLU98gD79Og?=
 =?iso-8859-1?Q?efpq7jXM0x9PkdmuWirOqzrqZhQIttnCjbglrpLrUzxiu3FWG9GnjcQmko?=
 =?iso-8859-1?Q?a48kZLeam27d6mv3LUfNJ6hfsLIwC1PY25fibT73Ks5k6otqIGWGVbe0u9?=
 =?iso-8859-1?Q?/XlsqnC9H5IPw7mqcp2tw9p/wP1uas/hU6s8SeWOzqxp0Zz84wbuWFh3jA?=
 =?iso-8859-1?Q?NPUpfiGhpjR+TPt39fozbHoNOD/2su0dJyakBe/cTgXwMcxnAo+d3Dc3uq?=
 =?iso-8859-1?Q?dz86ZogTAeWGIQ+D5+MaA0T5Z9/3dbe8Q7+w/3kWf/xw00j6RPaY4VtR0T?=
 =?iso-8859-1?Q?hoG1CbW2fMmFK/WAp/1a2KyeuIdsoQLssGb78ca7o11bRAsY1uoo5Zc1ap?=
 =?iso-8859-1?Q?nVbRpTmyVSgBvBgOL0LQHiH2qBkoPm3VBIsrkQKd2qh4CZUrtRBTyYE962?=
 =?iso-8859-1?Q?YCLSDOdoWu52uw62QoJ8o+s0VsbBmGJCU64pIfmDxqPTUFwQE3jV7/ThpH?=
 =?iso-8859-1?Q?QlhS9uPaurR9Nen3CMvZed4b+GlFbQsL2zRAkTbITR3jgjJOlKLqCyFkMu?=
 =?iso-8859-1?Q?nxj5BC4XGy/QMl148TIpf2bo2kOJmQqinKNVEEp+Sa3T1kZEoD7fmVAkT/?=
 =?iso-8859-1?Q?S+GEOoVcwYS1ayWpR16R0FWNpF87SuXVRJRUpe+JQbLIsB56yzpJi19DAi?=
 =?iso-8859-1?Q?3aXR18Yne9QIp0X4NLXxYwhMDMIQXYo5PqTk40EYot/9g/DONR5dEJF2wO?=
 =?iso-8859-1?Q?oDJAaTyqRK0Lo4v/GOHK77IxP49Ur1wkjwADVj3OeWnKjYlKUIKW8NSKfg?=
 =?iso-8859-1?Q?YHqN6ChHljLKF+IFU0+e3rGpnd4k+8ayBfm8nu54HtHK5yJaCPvyruchE5?=
 =?iso-8859-1?Q?FlMY55XeJAWLI9UbPtvsuRALKU7tOKAgnUXMhCWoJyfRyHqJNt5XkdyiJ+?=
 =?iso-8859-1?Q?vVQ3KFvAjbGBaTh+D2jlB/fNJ5N5+vbJtizrZI56F/3O93FmtY7SX/mbHp?=
 =?iso-8859-1?Q?CxQKd84Ic9pDL20gBEXIQaVw3IZC5UpR1qyNk2a85zLNze+266XlKEC/wK?=
 =?iso-8859-1?Q?Aj+A+JT4w8mj9qNqCiwEBS3+oEgW4CuIFQ0uryrKmBzgREicbSrYhFR6zx?=
 =?iso-8859-1?Q?9snggdvzlEt8AL34mq9S3dhextqJRQ1rR4GtJR/T3+JQwvwme2H7AbWhft?=
 =?iso-8859-1?Q?FHjTERT7F46TI6OJOO7CO/IFDOeTmIw+7bImRSiQXUrJGBd3CzVD7J02ki?=
 =?iso-8859-1?Q?A9yX5ZzlPuIeZjSneQ69ZjGqbKZmuq6T1zIHz0xTotlLLBAA7WQBzhG6it?=
 =?iso-8859-1?Q?nIuyvH5yZcZYIwGhhEzNjw3Fast+mAPl4HuI4efoQrKG/OKdzJQODlS8pB?=
 =?iso-8859-1?Q?qzH3JVo4I+pqC4mHyqs0N3CG2hXOhoOonmHIsZvzrpoTomOFHP4/edYjqu?=
 =?iso-8859-1?Q?KtmEHpkWUKRR+y5YApEl+oZ9fQAOmWm0Lmyq475yzL3o7mymV59/Q8KKI8?=
 =?iso-8859-1?Q?DmxRWqxnwGu97fNLSfWlZt1+6u1gSFsxerBtkq1kIwpLj7RBebwxN2zEnN?=
 =?iso-8859-1?Q?puynFWsUcg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c6ab13-b094-41d6-141a-08df2dc2d446
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:51.8085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7VLVnwt4L1P4Y2ahwD+xLL7BtI23gtEqdfBNaZwcZ1oEKiAfK6HCqOWZ/WgN2jYbCVvmuRoLfKsEzMXc7RRJA69NYbKmpy3fIjfNlSbYcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8674
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

Add "x-usb-redir-server". It exports a USB device from this QEMU to a=0A=
USB host in another QEMU, using the usbredir protocol. The other side is=0A=
the existing "usb-redir" device.=0A=
=0A=
The name has an "x-" prefix because the device is experimental. It has=0A=
to sit on the sysbus so that qdev can find the USB bus it provides, and=0A=
that may change later, so the name is not fixed yet.=0A=
=0A=
The exported device is plugged in with "-device <dev>,bus=3D<id>.0". So we=
=0A=
have to provide a USB bus. To find that bus, qdev starts at the main=0A=
system bus and walks down the tree. A device that is not on a bus is not=0A=
in the tree, so the bus it provides cannot be found. We have to sit on=0A=
the main system bus. That makes this a sysbus device, even though it has=0A=
no MMIO and no IRQ.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported because=0A=
the protocol has no device address field, so only the device on the=0A=
first port is redirected. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 143 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |   3 +-=0A=
 2 files changed, 145 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..bc883add0e=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,143 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Exports a locally emulated USB device to a remote USB host over the=0A=
+ * usbredir protocol, so a device emulated in one QEMU instance can be=0A=
+ * enumerated by a host controller emulated in another one.=0A=
+ *=0A=
+ * Architecture. The left column is a request going to the device. The=0A=
+ * right column is the answer coming back. The middle hop carries=0A=
+ * usbredir messages over a socket. The top and bottom hops carry=0A=
+ * USBPackets inside QEMU.=0A=
+ *=0A=
+ *     remote QEMU: guest driver -> EHCI/XHCI=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     "usb-redir" (the client)=0A=
+ *              |                     ^=0A=
+ *     usbredir |   chardev socket    | usbredir=0A=
+ *              v                     |=0A=
+ *     x-usb-redir-server (the server, this file)=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
+ *=0A=
+ * "usb-redir" (hw/usb/redirect.c) is the client:=0A=
+ *   - it takes a USBPacket from the remote guest and writes it to the=0A=
+ *     socket as a usbredir message=0A=
+ *   - it reads the answer from the socket and completes the USBPacket=0A=
+ *=0A=
+ * This file is the server. It does the same thing, but backwards:=0A=
+ *   - it reads a usbredir message from the socket and runs it as a=0A=
+ *     USBPacket on the bus below=0A=
+ *   - it takes the result of that USBPacket and writes it back to the=0A=
+ *     same socket as a usbredir message, for the client to read=0A=
+ *=0A=
+ * A USB device has to sit on a USB bus, and in QEMU a USB bus is always=
=0A=
+ * made by a host controller. So this file makes one and acts as the=0A=
+ * host controller on this side. It models no real chip: its cable is=0A=
+ * the chardev socket. The real host is in the other QEMU.=0A=
+ *=0A=
+ * usbredir carries one device, not a bus. A hub cannot be exported:=0A=
+ * the protocol has no device address field. To export several devices,=0A=
+ * run one x-usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
+=0A=
+struct USBRedirServer {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* USB bus */=0A=
+    USBBus bus;=0A=
+    USBPort port;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB port ops=0A=
+ */=0A=
+=0A=
+static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
+{=0A=
+    /* We only export the device on our own port. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_wakeup(USBPort *port)=0A=
+{=0A=
+    /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
+}=0A=
+=0A=
+static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .child_detach =3D usbredir_server_port_child_detach,=0A=
+    .wakeup =3D usbredir_server_port_wakeup,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB bus ops=0A=
+ */=0A=
+=0A=
+static USBBusOps usbredir_server_bus_ops =3D {=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Device registration=0A=
+ */=0A=
+=0A=
+static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    /* One port: usbredir carries a single device. */=0A=
+    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
+    s->bus.no_auto_hub =3D true;=0A=
+    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
+                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
+                      USB_SPEED_MASK_HIGH);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The link to the remote host is a chardev, and we cannot migrate=0A=
+ * that. So this device cannot be migrated either.=0A=
+ */=0A=
+static const VMStateDescription vmstate_usbredir_server =3D {=0A=
+    .name =3D TYPE_USB_REDIR_SERVER,=0A=
+    .unmigratable =3D 1,=0A=
+};=0A=
+=0A=
+static void usbredir_server_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "USB Redirection Server";=0A=
+    dc->realize =3D usbredir_server_realize;=0A=
+    dc->vmsd =3D &vmstate_usbredir_server;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo usbredir_server_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_USB_REDIR_SERVER,=0A=
+        .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(USBRedirServer),=0A=
+        .class_init =3D usbredir_server_class_init,=0A=
+    },=0A=
+};=0A=
+module_obj(TYPE_USB_REDIR_SERVER);=0A=
+module_kconfig(USB);=0A=
+=0A=
+DEFINE_TYPES(usbredir_server_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index 429dcd6a24..0061b935e6 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -78,7 +78,8 @@ endif=0A=
 if usbredir.found()=0A=
   usbredir_ss =3D ss.source_set()=0A=
   usbredir_ss.add(when: 'CONFIG_USB',=0A=
-                  if_true: [usbredir, files('redirect.c', 'quirks.c')])=0A=
+                  if_true: [usbredir, files('redirect.c', 'quirks.c',=0A=
+                                            'redirect-server.c')])=0A=
   hw_usb_modules +=3D {'redirect': usbredir_ss}=0A=
 endif=0A=
 =0A=
-- =0A=
2.43.0=0A=

