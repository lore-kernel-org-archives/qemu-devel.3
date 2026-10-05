Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0F0CA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFm-0003f1-JZ; Sun, 04 Oct 2026 23:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFj-0003dm-Vj; Sun, 04 Oct 2026 23:20:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFh-0000RH-FP; Sun, 04 Oct 2026 23:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5MRSDJn80KxuTzmVO2rtAwMDbizNDt0FvTZ+QZwyA/34G0pw8p0XKrWS+X7LmxVUf33k0vcevjN+4X2j4kKIsWqX7G+4/dJo7NGRfsqBafAxcmXpZ6VCGf2dylAVw/zJakk31HKuvCoKgI9LYVkaNQpmidWmkG7Q2CwsWsDXpdWW7loxmT6wewx5cyF1z1fUVu1b0SLGXfgSuW534sl2geY4rslPnSYBFOHVL/ilAaeT30c5DlIRTrPwFpkMH9cs8mwjwdj0qg/IXNCmwO99WWEbwJ11qq21D+FX/ISmxqrPoWNToKoDHCMo0+/3ubTsapVldrHw/uyn3KRcc6nXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBYo2CjxxlZwh3r095vHmRMcxWTEEPYXItHwKbPlG8Y=;
 b=mWjcIF+pdkOU9E3NKkm+YfGiwm0L71rm2CNSxju63rXLw34sjn0xJpXyZVyTyHnhY/GDhKplYWBCtVX++zakskKTDATssgxVAZIJ+HgytA3Tp4kVHDJvCxZ2FeA3oVPrBTeM33u3mviInFa9cgMqMa+edafgjvdhT1dfu/EqqBnSyqyOaO18lydscYXJZb2stGHv4we0SPcATF1ixBqt1txutisZmkwkMkVhZRVldMKXqvq6bjybujZ4QStNKuiAKIGUztnxu1r0imRNEZk4hBh1gZaJbCw4otaiLU4ZBoV73eWQ8phrH0q0DN7nQzMCqygDuZQ+oiF6xwGGDKKxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBYo2CjxxlZwh3r095vHmRMcxWTEEPYXItHwKbPlG8Y=;
 b=lBUrfyHSyXIhBVV9ZcWq7C+7prAyrGjUlXBbsOQ5UdOcmcmLW3VrH9yImxFJ+aIj6r+BHGR1F5N2so9j8V2KGF0tuZ2nsZW8GcoYbjhYCtqNeZgSDzPndOcDX6jo0CN7Pts2R4tmdqwO/qaxKnFz7thAPGbeQKwxpgF6Tq+1SjNxTRz4H4E6/iEgl08oUgrN/15V9+8OAoIUxPGVNQy8nZQiNCNZ2cFJIqaHvW8rFUkzPaf1jDJOgzPWXsrPZ6TsOCQ/5KtV4WXbr2OrvRkFpf0tcLgF5xUX8p0eWaKodqqqk0YPYpsytoqMOwejudjDagWxtu4Zjt+hIGmkPGYkvQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:26 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdVHh3uLXv2VFpZkCIJ+Dg/sNXxw==
Date: Mon, 5 Oct 2026 03:20:26 +0000
Message-ID: <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYUPR06MB5945:EE_
x-ms-office365-filtering-correlation-id: ccaf9de2-b1a9-4c07-0750-08df228f99a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|5023799004|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 5uFqfJM6PkHyfuHF0Lwd7CaSqGV55s/9n+yUnxZU2trtxMT0K5FiFFXI6kZJQ9+SVoCBiGhQ64Ao+/K8pfMcuVgYTf5dh1tg+0beloEdGyCzD3syIKj+W6GEiRhIpFujFAygLfsRDYFTzQalQQtHhFm+/DwmKNelUbUKnart0BdGbs4zuWBPkQY27a8YpYAi+wfoIbXW/XyLOgXhNnfQ3MApsNLC9/htjP2hp4Tn4x1gFKSJGjScqJjPEHmro2uyj6RLZl1H5NM0LtNmFmZKZgUA1fV33pquMwepRe+WnZzoj2UIgVa4aQiFHiCQnQxfv4HMWUWYFBVmCSOmWb0DBCIvEXvLA8k82QIR05KwbOnYmlpRdwrRVJApxujObqXHlbt82Fo5BAH/9g19nySkxyr+xLMpdsz6/UPFXUTEfyRkc7GXIu+HGEN5/5sQ910ir7NtJ9uekZZKqcay62zenubhNNoPqa4VnOEkMt8jCQ2qr4xG46p1MBZzutC8vmWPSFWPm8J7IfxEHxJelRonwe+OXs9UTXK33kyyZYZC8aT+q71u9FPMTjhQI7e09I5nv46ztDt663LgUColvBKxQRhMHIRtz4gvXRGMtd3ML7THvSE8hYmT0sf4pwoPvTcJDhC4jpQ4hBIrjuCtcSVox6lIB3T0jftbxuTjbzhloRRIyD/FcUV6WMjC9tT14lAhRHTs1l7ihdj3NDqfAW47TxcTsykWJSb9IHZ109Bzwm4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rYxH9TIb/bdSm2tcwOkY/rT7Dia6n9vhlx9f10x8KJYsnSbrjnP2YorD3wcB?=
 =?us-ascii?Q?cBQVepKQwhqyssWmwvurl+8RGs08kUiHn+a2MH9NpFKlS7i7TBl/xZo4DF4m?=
 =?us-ascii?Q?kakDxYpEOvcF+/EugqOmhhjaP5HGfneetda6vZAlWUSCGaW2G8dOys3ggvYy?=
 =?us-ascii?Q?++Wm/My3IY+sJca4a2/pwZQkzaRWg1+Il/DLOS36PeTOhZJSGGZbAWf5R+Gp?=
 =?us-ascii?Q?TVasWXgbWQwCUaWoipgOq+d32067OeVDOEqPTk90vDzInV3MFK4vU432ABdp?=
 =?us-ascii?Q?1B5qQa1/7cfoeDDthzWNg2icvcWh92WVRqgRN3kgQOT7zoj9UGz5sFQGqie9?=
 =?us-ascii?Q?Adr1AW2ASV71Uoka+AETKMkM+D/M7VushvuP2G8NNu5f6VI18qlM7/QNc8bb?=
 =?us-ascii?Q?zsuThQdMd+Pn2CFZMbGdjAHnXxTv17Cc3F6yenHZbvmD381jVcJKBp8aLnw9?=
 =?us-ascii?Q?cGONfye7q0CJgmPOn7HnXmLAFBGlOuQ8vgmtdAbyUgq4Q8a2aWTZ7Snj6lPu?=
 =?us-ascii?Q?36OvjUgxyC4pUsWpZd7McvjJXpVQ2sRwfa+E+kzgh0PpqbZFgRmxkbK1kDDv?=
 =?us-ascii?Q?pXbwKuSZbdMfvaGsAnH2dHMQfPLKBUqRBej40RHaTr1J4cpOkMz/eXChwAQx?=
 =?us-ascii?Q?9Mp+6mO4mBmlRpizJYt/NpEN1+mRdyWufX5osxaFGgAuKjKtCS1KabP/ur6H?=
 =?us-ascii?Q?ZbeOjEBW6czFX70f0q3IjKT4vbbR2AO3Av2nPhmH5am6u/MSL6aTc/DAo6kf?=
 =?us-ascii?Q?aoaLM6FOu07Jmgw3EiYD8WghlwMPzU4VqLXk26y1U3hNOtIQwxhTamPHUhKZ?=
 =?us-ascii?Q?4u5hA2uodrnto/iKhSO+VH/P43cV85s41JfcK2eErhZomYmDFcmCHRNy/t7r?=
 =?us-ascii?Q?+fMDu2M+GOYYFT6Fuw6hC4VOyLWLw5uhQ2trgZ0iTamKIHCrmstzAIHTVCDW?=
 =?us-ascii?Q?uUrbJD8JwseqjfsZ4QhqHVV1UVno0eGILEDS0t5szD+d1qzc/eBguioRPUGK?=
 =?us-ascii?Q?9TB/vWdSWlkIld/MEVpZDQOaHvOpUzdb7wGyFHQlkhQNKvaYgttqL2bK52TE?=
 =?us-ascii?Q?tFu7NHOWchH25+Isj34s0JCaOjcU0kGGyeS/JbpwV6dCkRC1ql//+qj3CSGE?=
 =?us-ascii?Q?sVteeRMpTNhUaq+TJPx48YTVv60vN7F9PXMCvNsvpCg6uymsIOC207t7GPlR?=
 =?us-ascii?Q?pcBDbUx7OKcnsGrdq/HIgcevAQ/zG2qp5FqdS/JXW5XeN8Os5v0jJ1avJhb8?=
 =?us-ascii?Q?e/eCaXCuWzMvruanXyj0Eurvb7AGOeiEyAdBiQ/unL2//vciNl7nocFdraRJ?=
 =?us-ascii?Q?bwWXUgFwq7/2ioxPFtcILtgmXXJHmOhqQOz3TtXSksFde6Vzdj3Ud0oR216r?=
 =?us-ascii?Q?e9nJSqIZbLGfRF68mG3qaM/6rnvW2Wn5/jaaZROK9mR2jUdA9GTxWTnrclRV?=
 =?us-ascii?Q?dEZf15w4xa+zSp0RRTCIWLiCQP84UVKmA5sUAhZqpDpAP+niU3HMARYxIe3o?=
 =?us-ascii?Q?gKo/WSrZdxBDzi30QKf0j+PT+IppeExgPVwaaaVWdfJHEwS1ObN6xslTlZeQ?=
 =?us-ascii?Q?eXXYC6QWjbNKR55swoQahLh/H9rwBlgRa+cg8INDzDgn83ESjFqwU00C0DMM?=
 =?us-ascii?Q?Vvyt4M+er9gz442f1qY7ECRbGnJd3G+jkeK6fDDcCk1w4QBodoTgqY/V8ccX?=
 =?us-ascii?Q?rwqltyzekCKUcwwHMlVRLaahi9HNF4P+yhXWovrZCJPzKJWRgN+orZtJrw+c?=
 =?us-ascii?Q?1JIohsd1bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aL1Fl6TgFpGQOMQ+sFA5G2Ov0jZIK9xAOZ+KgfAocHnbjR39PKvSWNgCWF6AjDNvI2/2k6a8pZAbwnGO1LUG9H96BkbO00/r2BZSrq29saHnLAvyVOhIeNhqyrPc9bftC9lYFFLg3r5dqGYZx/nSg6eWOjJ062wK3uuagHxNM5U3oeymmswbZXWkhRmTS3ef9fBPRUbqrmXjm3WFmBPQT+2Dm8QMrnFicDSEo3u+8urmiI/MfO0qS67/oFTLvpOjbI350EK03JW0q2zuYEIV1kLSFqBcjn7t50eUbXYtL4ECFZ1t7JhcRrFtX80kk1zG5JMukL4dWVgQHgnB3h5eTQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaf9de2-b1a9-4c07-0750-08df228f99a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:26.2482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfEc52J6+e50rsmBZvepyQqW4hFIe40RVa+OoMGMELoNCwfv/82dNPZI/0r3dzgyqInCGwlYGLZqpCXxWQr9MYg/0VAqlrU2JCjG33+l2TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5945
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

Add "usb-redir-server". It exports a USB device from this QEMU to a USB=0A=
host in another QEMU, using the usbredir protocol. The other side is the=0A=
existing "usb-redir" device.=0A=
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
usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |  27 +++++++=0A=
 hw/usb/redirect-server.c         | 130 +++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build               |   3 +-=0A=
 3 files changed, 159 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/usb/redirect-server.h=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
new file mode 100644=0A=
index 0000000000..e81d4e0608=0A=
--- /dev/null=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -0,0 +1,27 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_USB_REDIRECT_SERVER_H=0A=
+#define HW_USB_REDIRECT_SERVER_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "usb-redir-server"=0A=
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
+#endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..5f365f0a35=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,130 @@=0A=
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
+ *     usb-redir-server (the server, this file)=0A=
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
+ * run one usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/usb/redirect-server.h"=0A=
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

