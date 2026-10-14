Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A6CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtkr-0005Nh-Cg; Wed, 14 Oct 2026 03:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtko-0005M2-Bx; Wed, 14 Oct 2026 03:50:26 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkl-0006yR-RC; Wed, 14 Oct 2026 03:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKxIE38F1cWkKtFTnLjtwF/4E6Rklj3OPNdaStOhQ0JAvfHdbMVd+SV+w3tJsLFrKwt2quJ3Y/FGt8m8K2vetL5qxI56fVtQSSu8QPpnPxwMnHfBi6SpAN55jAqA1jfti3YL3w800KSTLO7Ifn/fVYcBeQLQm5BSlAH4RrEhsMm6nOnoJThlH79ZCaI2asIs8JcySX+uO4Xa88cMz+VX6W5TPh55XKKWWorVDAUNN+EjYUsK/RHYdMeEm2OP6I7amx8hrqQKpanzMuCKwCWr8IXbuTuBoC0FIpIvrOaAx1Z7HG4Q4hFu4Igvi/KckFTnUrD3JoGpsHH2IhD2umsw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoIdk+bIu91xNHY/z+G3v2+Q6AidKeXa+hnwvGsnAU=;
 b=Ky3z02XPbAAlHwKWx/cHNMo0eiuC4nX0ehIoqUf69v7qcrzl/EQ5vWIU76XruizUvmTqmGTBc/IPYHpRXq+f0aTZ5Iv4mJmHewwozX2wJt4JnMrXih2ZSSb6wJMQjpo6IFRf+MAg9mbRxQLkSrUS3FqNia8F+Eu4DmQHqZJwJp5r2hszI+fPIVFdaBIvgJzKlLFdrcmtf8i/VzoGwnCEPRfWoQz7BgnFbu4P5wPnCMbkHY2A+NNX6xp87/RuBvzgCAGDuz2yAPrOQ5hayq5GLm4ZXnslRCdzVTaal7E3SpazS5FgCLZCSawEfTbBDjUdJP91XYqkz+bTFU5IR7Royw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoIdk+bIu91xNHY/z+G3v2+Q6AidKeXa+hnwvGsnAU=;
 b=Eu89BiIMUywNACFGI8UpYM2lRkVTfT3TZqs86wP3RyL/Ohlda6dKDuIa0Ac427mMa/UZEdLBpXvRCeIf8miJ1BjaOTB+h5ISwGn24RETFEznBx9frpZFIZE7DEqM41VQYNqUxtmhNeKOCmwBmjrpiyULf0FoL0f28h3B/v5Vptvhwq5QsfYRLE/TXSN2CRZdJoXk26SivI0V9fn7hCExqa0NpHiifXrXkRaoF8LRFEJyyfaNEYalOmdo+V/vHVftC8zgTmsPC1WjkNVakMqh4LbqGgoJtI5NznLKrg7eRmdZltzohYkxvE67EeC8mVoBMZIH6T3Iy2fy4L6eIU0Bgw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:15 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 2/8] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v4 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdW7ClgHybHzBz70mNBYX5gD1PMQ==
Date: Wed, 14 Oct 2026 07:50:14 +0000
Message-ID: <20261014075011.2708115-3-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6864:EE_
x-ms-office365-filtering-correlation-id: e35e40dc-b7ca-4f28-d215-08df29c7c897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|260925022911599003|260925021911599003|260925021311599003|3023799007|921020|38070700021|5023799004|261009223027099003|56012099006;
x-microsoft-antispam-message-info: 6NAYM9eAtMECScYOMU/o5iRLOzh2qHUf8ZAqjpHvUOeZMy0YdyE5SMhnKYUOhwCst7wlYLRRZQYXpxk8MS17sQNmhtMw6A2Z+CmKmE9SXljOsy6GKYa2sHnd3DQGxSCrVUgzoqV1HDEp7gP2oDleo+Nt/GFkEl1SKIfekNwQdZviYz3rZPHDJIWpNEMD2Igd/v0rsNy6lumykI/oCizq13gwKwawfn9QmMs667fylQW7Q0qdqigeHsSpuXjeGksryaeLLmdNmvXd46nQg8y0ot3Ag81lUvibnAGBp4SoEylVSx3ltuPlbzR7NXRdPGcrXxiFrZJxWAN07bWgSXDbcmlUkHHN0RdGh8R6ahqe5IqxZ/NA36kEQj4n9WG+0CSGxLMLfhrT3L62OZ4qdxsia0FMbQ7dbQ/Lx/7HOy0V5WQb0UY+OcJZas7utLeJd9bcIGrU9qlkB+42SLNg7By3ZiQPIXMXebXQ8ULfe650u33C7Y9X8QTNjxGqW0f6bdr/uGUycENjYjtqcvDmq8ZFvs2YHenBs9ASe7lj2xx/6Idkb1EtxM1XsJ/UoAJJ0+/qJsuxX6DRcreoq36GL0sGUi4Y+ptN2wm4HpT81vcS0Mz7MWRC4MWLp/XzFc6hitkopHxTKWE+gPN25czm0KAOqvKyCPtGeiF5aSi3DGHzNnrO1q53Hcae1uvYGx85fjOAywl4eKBP5fW7LBkahpKZrOhJTQJcDME6hs0VEti2+MJCIW57mkjGDrSVSOLT62b4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003)(3023799007)(921020)(38070700021)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yMh9CyFJcB54YJpKZpZU+3y+FR1V38GPa9KRbn2qC0idFaVv+m7Oj7nh8j?=
 =?iso-8859-1?Q?jSMxtW9bdlByJDpFQezJFWgeZ7G6GKKNiGB80i7E94IpsYufCXDvGgZkEL?=
 =?iso-8859-1?Q?FktZKLXqNENrs/3bEbTfRV8RgpKQNZw7sNy5W4z0RVivL6rnaJD4N0f9hM?=
 =?iso-8859-1?Q?UDEj3Cstond+Xhdonnn76rH5W7ZQ3LK3j7yT4yVxebEtltWkwALckUQ660?=
 =?iso-8859-1?Q?zmdBtQtCt1n+YwoMAlFKBSo6Qe3McgIYnJ2JrzODEylaguJpF7TehePRHn?=
 =?iso-8859-1?Q?mRBbzuDGhVdsl5RiStgcoauIpSBPgW6A2EZWj5kn1D2tW1hNOFezeiBPlg?=
 =?iso-8859-1?Q?0z+pK5W0QnWejlnrWNQ9hzQ8sfYqyNZhrzMEtG5NkXx2lMUEbuyxEmwPL1?=
 =?iso-8859-1?Q?Zh8dnCk/6Uu9lbm0HirVR7KMOm6DGVxtLewss5nSOswgNARjuin40kEQeL?=
 =?iso-8859-1?Q?ogTg9FtmBH0Jw7H6Hk9p7E2WghJwgyWrak0kzB/49cqK8Lhtv5/SNPwn/O?=
 =?iso-8859-1?Q?VlEnvdbMHwD83FO1UZFcg1gIljItLId/ZUAdTmk9VjmkB7zyhGovsXYPVU?=
 =?iso-8859-1?Q?zMkpI+0ZDZ2OfhVN8Gx5H2gVfrn1o0JGokNr4fzvndHBUroDSgntich6B8?=
 =?iso-8859-1?Q?gYwnWeTB39NTcutc54tP0hRICzWCyUgUfJ4ZwegkbSr3hrqnfvdwbP7gQL?=
 =?iso-8859-1?Q?hhR2ZSPWEdROxD2p4GxEx6vY2NpD1hFW1F9KTo5OwDTvjnacCJI9Rn4Kvl?=
 =?iso-8859-1?Q?aRDFQIIq9uccpnmt/QnvdcR/DNA4HsSxSjIWzuB0EzQDigYTo1e7KNTB8h?=
 =?iso-8859-1?Q?VaKTu+pyGQGcR6IpmtBppmzzxreLJ3Y7u3FEAbDJuIyoODKRQ1gEAjII5r?=
 =?iso-8859-1?Q?wIMkGYhohKsz66h8SKafoxvCk5c9L1wyMlxW+V2Ed6hOlICbSNthnKNiFy?=
 =?iso-8859-1?Q?7quGg1qo+7BwyU2foa5AHMO1aMErnf5eoZcX83uMyJEfka7tjFWiQ0Y0ct?=
 =?iso-8859-1?Q?SFIBk/9S7PtUoP/FB1I4p4ZxNaOn0yc83ONmsz6LlFehIxql4oPOe/qEAR?=
 =?iso-8859-1?Q?h10aqAjZhQt64BX9OYqXljD1pU34wwhkAl7nYFj9xYBURceQtQXR5LjUtl?=
 =?iso-8859-1?Q?db5J0rCxTZPYncezlxLdwmxjCyPd5uNm5+8QhIkHhCEG52yRUTieP64RY4?=
 =?iso-8859-1?Q?9VJAA1tAAZHRL5duLSE4NjVCHLeGgJY+/bw3u9qWohqFbMRdKom8NEOzW/?=
 =?iso-8859-1?Q?MFil6ovqRzPobE/+pF6Yg+zf+HAlH+5+tn0pKs5Gb+uuIOTM1tlkTvH9rv?=
 =?iso-8859-1?Q?2HnknrSL5PVoL61a8VaABIdQ5OzqvLHSBrjPv/ZRxzmRlfEA4P+vlaWkuh?=
 =?iso-8859-1?Q?GBJ49Ph7QMuP+jVo4LrwV0b6xaRX90MX+EkNvp3pVhZ2obw2MhGuvuUOFo?=
 =?iso-8859-1?Q?BWoyvbz0ZuG1cTnRmgEo801gb2fvvcBGIdxx8ttgNRufq94yLN1kmFtgJB?=
 =?iso-8859-1?Q?Hxuhi0DeZMBpNy+xnogyQGWwlnol2sdQSbNgp4YDKOcasdmwzZKWDVfKlK?=
 =?iso-8859-1?Q?61JlvRdrxLps2Hien9EVVmr/SG1zfwbqzD/GVbRUCTuu0K9tFHobhHotek?=
 =?iso-8859-1?Q?1hisb3s6jV+bifejzODSLfSRqPhcDyID03uaha5oFwVp39H7BvAtT9AlzV?=
 =?iso-8859-1?Q?CAPuQObuB8zxwf6FbAVCx7QDa2T6TSEh9UMTLaqJn8Honp+HhWEMxab9gj?=
 =?iso-8859-1?Q?+GKs4Snlmy5zYGwqWNTzXwEQ8iGYEI+/6FO0Y0c1KWeU8qbcBv5m48J9hh?=
 =?iso-8859-1?Q?KhMB2asicg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q+4IiZKN42myxQDK/7r3sOYEZ/yeUFtHzV/Dq3KyAG+ht3Rq0hpyMTDw7zOvpzykochGaVgJ1ALSyKwtYdkeYa9O8hTj5LZFFQIEA7aOOHe91wBo5UEbVIUxhM+gkGXcgVoyjF1OZ1o99Na7iMUYHU6BftjHUk/qB11R6en1XGXgtKqQ5J/23LBmNPhWhap/itQrXcdQDiECrT4OmkgWhpz0xFLIUyhBLlwpsy2Zr38wp2PgUnjOZFohF7J0aP7A3Zh6OZvrup+Gxs/NpxWDkz6YkLtwWkCIq8v5eT60ISo1xKYzuuL8DN7OdyyZiRtsFApTxDgjN2YTAFKUxKYhEw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35e40dc-b7ca-4f28-d215-08df29c7c897
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:14.8413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5vpSuGLAyvBS0BKNsOvuBXXBg+Rlj0uEgNl+4ssrts8WhAfeRfgq9Fn8MSqPUVd2TgsKg+M2OVQLIFU0bEUwhgASikuEEpg+ehcm3GqjV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6864
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

