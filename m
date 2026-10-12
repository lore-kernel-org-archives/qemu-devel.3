Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91300CA9EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5av-0006Or-0F; Sun, 11 Oct 2026 22:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5as-0006NY-Mm; Sun, 11 Oct 2026 22:16:50 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5aq-0004ly-LS; Sun, 11 Oct 2026 22:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hohnBd37bUyPtB6hEbWPxQnM5cWkUQYeSikoFSRCM/nqtDK5X0A4P1qN/gvXdMxXJZK377+VpdoAkOy3Zc2PsogZcsQRxpVg++T+LeZNohDUZrndZ5Ioxv2hYF8exdNj0F5u8o3h6vp1tg75qn187WYsRRHB6zb4dpGAFACCF1WiY53Taq03goYZyp0nMH07ksulD+qE2ikEf6uD5mCeQbJ8wupSntJqirq4NuNROLButjgSEwE+f1zedDrqzZYN6yQewzAF1EIoxV7rlNWvjpfYWjVFF8cfpGcwixXOgQgZQY9CYeSfuSwdz/j7llJwtA/aqi3uMiKOC8LtjtOu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp7f/YkiXiADZQsWAnrvSLReiw23DrzojfQZ2uOCSpM=;
 b=HtydYB0qWpusD7U5F4fRsErdQaVq5wCdOz1+8Uf8tN0s6XOhezQtJr351KxjlDSRWYtHUzUPC86vDLd3LHAj/8UtColm5cY+PPbwGRicIWDyr3rudaIHTL9PBXNobLagWg222SYmKX4cDedyQ92J2f+3JCxFYfFYsusHipUgLauHp/hmTDkmcDKv8t5wXEOUU/Ew0pAy71oX/uACDfgfRTcEu5NgOKyign/EbwUHvHEscci61FZN6VrcpZwChz7hiAZLERtZC+0fl7VT5eJFampRCy+bwSoJ8DPEYIXqA0f95AAMDdqkC1y7s1eQSSS+lARNmyj890laVkfEiOg0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp7f/YkiXiADZQsWAnrvSLReiw23DrzojfQZ2uOCSpM=;
 b=Tk26tHRsMHPDgDQIlIMWqPF5IXVCc8pZXInNqECPc1j2HQuXd/SnNJFefgofZVMplxwYlq9ana408vT2nsn2+PWOnwxdDf6JhTD2WHJKVjCMEM07fYie9Lm5L515Jw6ZZITTCEv22AM+V8Hj6e93uQITq+0dLnFRJh/tXwWlwaeie0sCu+f9BVYc7ANg2XIG0ABRPtjYFCc+LAYD5ODFo5HYuYHQiKX5V0MiI1HCkMtB3Z38tEbMuMZ1+uxzFE4eE+JJV6q0/h9YKyM+TRe6Y/yqs3Lqzz3A0kId4Mj8EkKJsv42hl8iO/ruSB7UyQqTVQRWMKVgEjh1mi/wob94jQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:38 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 2/8] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v3 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdWe+2iKOUJSOAb0yEZbAi4O0T5Q==
Date: Mon, 12 Oct 2026 02:16:37 +0000
Message-ID: <20261012021634.2006424-3-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5398:EE_
x-ms-office365-filtering-correlation-id: 1b123b49-fdc2-4b34-8da5-08df2806d8bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|260925022911599003|260925021311599003|260925021911599003|3023799007|261009223027099003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: k65VSs960EvI72SP6gUadgpPFdR9R6UHLPWziqdPBiLW9X+PPUYBbYnRKSYkrruoEtVfbmEYjfaklOJFpVQCKC3W6ycA5uF4KsFGDtzTh9k8+6zOhybOLtHYZgt4aHY52xnzb8gmrgPO7sLTsyjG+e4dWnwyM/+td297sZ1E4N0iFeg3OK/PgJC+O5YWJCm2zpHXbv0Ci5knEK7eHLuPhtmHtqWxbpMzqptLgkxjODkXnguL0nQuR7dV8ouR5WHFzuJrC1Dz795M20jwGRAAyS1Rtm5OLUG5qpEG6WFVtpHcHPtZHn5dQraKPusctEc+DbN3SGK9W6XV8CLTHu8gjfTjWSgJCyD1f6A4xOuiXeAtL/3Q47ODpIVpKqlXpItZsRlXP1FOQ341gqpZSIRgwpSZqhK6O+2XguOZCF08YHJNn5F7tERLZfmy4KYXwWlQLUGnORvy3ltEaAinKvxRbDYWKmXRoPrvGrYfEdO8v+CdBcepIUe3csGt6ODYyl8E36ciBuPzpfJngRDpgygdlCBzK3VLTmHX63yQyG7B/NijUOT7EG9jWhnm2vRMuHIHNb5NZyiKEC6gZEjeufzrADKmQrxhGE+DLdqaVFtiG5mncramYx8roQM+kZNIkao9HuN4mR3bqEgGPFXtQC0/XezYLHt0Pxo3vxbOOvstW2+89xuHrz4xLYeE2Dqc67QBMt0aLwYGHcWcJqKf9aReirMg8PBpCNG+ljMgl+0OGqE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(3023799007)(261009223027099003)(5023799004)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wa/DqJH13BXMwi8sc/vxkrnx64lkMC91PasxC4CSx3kKGYXqABYGfVTkWq?=
 =?iso-8859-1?Q?GZlEkfcpkG5h45VM8tNjQnrCmSVHcC4M4dgUVX1bSV1PBpWirbm4z3DUPx?=
 =?iso-8859-1?Q?QNxbcKTNCHTKMm3cGHahhwSaIMoMd/1HwlSXmOXg7ovr0ducYv30m1q28m?=
 =?iso-8859-1?Q?G1NXzBRmFdT9aGobN1w4C6zWp1nz5P82aVANCOmwvYJxzaJnZ70/X8+TOY?=
 =?iso-8859-1?Q?eTwT/J0lS5ISykwHNORrptwRZ1I0duUsb8Ja4iZI2UkZ1dJzi0n/HQR9vE?=
 =?iso-8859-1?Q?U98c3Ew2tu5fmn9tYlPIiVKUrIuOu8yL6fhzyClDbRFEl79ljum3CDcn0E?=
 =?iso-8859-1?Q?ptfJOSIa5UpvfcubyPlRppnBGf1Bhzf7ZSC7bmcuJCwg7nfmtsCol0VCx+?=
 =?iso-8859-1?Q?jMQ6HsnRwnkzsiH6eZZnuRK4qhzTvNFfdhlC8pmECPxnc4K4B1ANSWLTyS?=
 =?iso-8859-1?Q?u+bCa+8ylnRxUoOmx+kdLF0JQhyfGoLtFozqC+XiUgq0lASJdDeKhE2hCg?=
 =?iso-8859-1?Q?u6CGaIzvuOGYEDstdJAhzPCNhAg0HVCXkQbxDXCnSOtwTea1gZIi/895nh?=
 =?iso-8859-1?Q?KHXlJ7tM0sVdFIzTmeeC9+bBMsHr5t6LR9QkqLqNyFksUJcpzl/61UZaaD?=
 =?iso-8859-1?Q?SoF2z0sWZ2AlTNGZZK3I7dE3Cq2Pb/OJToO9l+Jhg6zNk4eqQB2oDfDzpF?=
 =?iso-8859-1?Q?Z7Rw6uh0atwKOjKBDFeGFQABUVMetCk6gG0SdWrc5j3krYEHb/b54bmBw7?=
 =?iso-8859-1?Q?8fj1QN4vXZKTIhhoJ6o9LcnEILDXpVa/rxcbukHJiDS9LRwJbbMaRFqB91?=
 =?iso-8859-1?Q?70Q7IBBxbF5SAMVggVxrrX6V6mKnuaQQHML0S489MknLJZ/yX5pke6zNBN?=
 =?iso-8859-1?Q?k7HomYT6svvUI0vKQWmboDOfyFFK4pPHEmtSpJmC2ZG2a/2AiBcD3taGok?=
 =?iso-8859-1?Q?jFdvZq/k+tMSAgo1Tr4B6w1zOy/O2TboOjPOOlB5zVstfLR839K8ctHpMN?=
 =?iso-8859-1?Q?Sb6CUD4iKj2GnIHg3/AhOc2SPEpjnyNgCjtXLLKrRmOAybSXSEz4vgChYV?=
 =?iso-8859-1?Q?SLlY+c4zl1zHbDY7o97rY7A7Xv8DvME6j/2lxJgwqK1okv/B6R0phqaC4t?=
 =?iso-8859-1?Q?NZYYYqhuVuUhaMTzkaFZuKth08jdOPCNyRWZvOrFQKtK5LZaAmTUE0u5l8?=
 =?iso-8859-1?Q?A0BSnmMk/dYl5Y813ajOaZZHXMw7DBjmcFLSv7gdHZRBmh2Hw9h13UJotU?=
 =?iso-8859-1?Q?KDLuvJSFaZh4AO6PnZSgEsiWd61hItMX45A7SReBUS9Q5BRuxKhpbVM0io?=
 =?iso-8859-1?Q?h90UsewocDkQjifIjVWgoL95BN6LqTG8hWnCk7XaybZiL+XLKtOJT+7CWh?=
 =?iso-8859-1?Q?ynZ7tPxeyrXRMJnN9ErkqJ/05+1iW+Kl29w9eycowxiXWZZBQyXRvqGEo8?=
 =?iso-8859-1?Q?wMuDCawQZ2ZWqz/TuTnJPStLnVha9owpwLNxaU5W1Hbf5LpskEXTZxfEaC?=
 =?iso-8859-1?Q?9ipvdueR4J5FQHdPAFrJvUkMjOw9tNc/+enptUEHUEKl15ii45aXvMAM9v?=
 =?iso-8859-1?Q?RkDGH0sbZ+wIZXpIpkBnAOjD7sy6BM9lID5OBfR4tJM9y0fze2Pj1+0eEz?=
 =?iso-8859-1?Q?0mogghITKhYxf+rQ+aFWfpzDMqs308bdR079BZ34X9Rd1hZ3xSLnPBLMul?=
 =?iso-8859-1?Q?pa/3adZQHCDwUpTseKjBJ+QCly7s86/ti9ORdYWcZFMdEVBkhsltyJYSfM?=
 =?iso-8859-1?Q?KnDr44JH5Js6iLUMLdO5RFRzSf84wRUyL1dIAKkWGMZ5Zwz4P415PNQUQS?=
 =?iso-8859-1?Q?0IFnkMklDQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LHW6nZxxnd8PnPm3OLu7GcTszS6ozXLk5CfceLEBdV4Srvzqj/CxiPTFBMUcS9koclgVHrCddIo6n66Pxvsyq47/bJca0HpN/ih2kx0aZxbhOyo/8QBNPsADqXAgJdRRFAGB07Adf5qyKi9ZLGU+irEkkcpTJ0M7k/QAzZRB1rgQRMYexJ4w+PJMlENQOMpbioy8jVtrhwMRe1EInQ6yqEn6SYvEYIGF12lhNaDnVwLdcdHHaXDj8ooh11cjIA9ueblgeszrbc0iydiKrG2R4FJZE4uywWSI2KDA2CJJLyKvXdbuZby0ceEwlQ8/tPf3ngQ2Egeu2bKbp0nyNi55Vg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b123b49-fdc2-4b34-8da5-08df2806d8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:38.0306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHAbvmNfjdNqZXqYEJOEI+wk9sBzHk/itiHgg7z69e/e+6vyGqiE/Ys8YofraUA9FQ80WTcrpeMeLCVQPZRqWg3QECodMTF/+aQth+zQDqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
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
2.53.0=0A=

