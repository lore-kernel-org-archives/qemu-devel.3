Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AD8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYYy-0008Qm-MS; Fri, 03 Jul 2026 03:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYYv-0008Pr-Lk; Fri, 03 Jul 2026 03:43:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYYt-0004IZ-AX; Fri, 03 Jul 2026 03:43:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxap2nNPtyLTrY2tzYA1HFq4n40W2D6P6UK1tVfN/ls2I/hS0NnZViQkQBmvs08rwKlPTFqSZrjcuKXax0I8/w22DSeHKJeLWWrUqDEUBsCaMWc4dr9IKju/UQmQkgL60vKWT9qCVll77Vy1iJXxLHuyGWFybk6s1F6zUod/HO0OvO2NTbIKF3D9hFEiOzIlq57WAyAg2sYEQlX39UQJKfBP4HHviYJLZ3ZfqplK5fKGLZFvVvXA90A/6PDgF/YzhfLRBnkYDBVMY4E0OwLGNxYnhHW6cjKmz0Rj1BYeoTvdeT1GWckaZ2px23aGJoadrQr4BuHQh0S9z/SMuXjfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u9uP1qyHSWrFRYDiCcQ0ZnlswzwAXJM23lZJceYmvg=;
 b=R50E5iB1xkEr31xp2eHQFalQwdJwcRktLvw2bJOLOqi4DUXZzPDko/F3JUexpdhns7LzOKO9HUw4pLeKKC9o5DCaIRI68t9QXx8kbwZHylP3saNgSQO+Td2wf0sgx8c/VrAsln4lBOLxV2ENWFBzMmtgs3WX5ZMweUuSokTfIIR8zHWqJL2iMrQcol8AfeBc8lcwzSpwvokc+g79WEQGZvJQDxP+GZJ9Qs5DInU+jOaEfaOVWAY4lfv1AE7zNfO7IkcCuF5SZbs4N7YRXMX+LYXpKYulXV591SavmT8TOAgN7oGDpQPjTJGZlb//TdZK+v8hJLmwmynHUb4xQzWayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u9uP1qyHSWrFRYDiCcQ0ZnlswzwAXJM23lZJceYmvg=;
 b=ZhmFBOztFhbLRA0XTF9ZNEROq+4o1N9+kkjt2fP7loK7AvniOj4b1Ik8hkmarW8U4yMfeQHHVSEBhrnxbTajGkmJ2ZSVdKhNAwRWZ9qXBukTPMuHJGVEa7Cm3+Bdurfxa/Khu5v46sgVeBlGICLhaX8ziwy2+H+8r/UJgRMAdz3KUP9JeON068uwdyy+gXSvegRtiWVQReNY0E2gLuXFlqt8hYZifWz8B/kTrqRaPu254P+YKTnx2YcAZvObdDnBn7j93dehPXw+LwXTOvsdEbn6xxMMcr9ipl6CERgOY+pfKiYsKv3GKMUfnnClw/0QtnG0vw4WKYcn6zduZK8NFw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 07:43:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 07:43:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/3] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Thread-Topic: [PATCH v1 1/3] hw/usb/aspeed-udc: Add ASPEED UDC device
 controller
Thread-Index: AQHdCr+nGAvHtrLIiEy1KPuFrHkplQ==
Date: Fri, 3 Jul 2026 07:43:34 +0000
Message-ID: <20260703074332.1049473-2-jamin_lin@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5040:EE_
x-ms-office365-filtering-correlation-id: 7d6d87bd-530b-460c-ad18-08ded8d6c992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|38070700021|18002099003|22082099003|3023799007|56012099006|6133799003;
x-microsoft-antispam-message-info: KIf9D1rt5aKwgA7UXeh463o4EHJAnQODRM44zMdmKEJCSquIssWMk7KCHhMsiWYIHQ+w+ecOXvoOMCmTyH560y7Vx58ARBWZ3l5fL+pnHM5/gywSrRaF6RjWN3EGFBKpNBo1xx5YRJchLJBDxwIsN17FYzfmJALKuf79H0jtXXzXV+4yIE4+nzb2gA5TX8CksRr/IEFXO5tGH8JdmsTHiNaQiwcfc7cgTfThtO7C5ez+gHSb53GsEReLFAykVXejXfxo1mDRUCnjEEysVPaGnfI3p7EFSeau0b4A3odTvfSXBkpd1R3TpYCCed6Oa135LXrsFEuqCYDeg5LMXwNptDXKjQK+5AmpwG0Xvc2zc9zic/iXtaYlArvxpHJ/eUWKNEAGWUdEv2pkrWsemjDth/BLZAnWw//yokNMg8uFkjgNyQpd/QD0qrhkg/Ml/myJHLvf7SGjVfoQhsM96SNH8ff2L/Utk+MmwGWGG5PRUYUE5TSFfnXJQUpgQXHkVViyZlW5enjuqB2M0meeBdSKivHpLkq9cz3/5UOKtMlsDCWXgjt0H2+pR4D8pUXJBgCFS8hi55aNzVxNmahJtZ2OH6YLndIHjVg3fJcpup11CISLUhvcpzJiA8M38L6UOXXSK6ZJ8MZyTccaYH7+kaREGbtLxakQEt054YzbenDrPka2dhaKSGtNF1zj9UuHXHjtEEXzle59Xjx4FQVmpB530H9tJl0KERGfYeHvrmQys9gjgr6A+DsB1HILH2goUnf7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?opUvqVcHNHYnpbgm47qdMgCQbL3zZWBeKnb0VjLspPCXtMVZk2zPX344or?=
 =?iso-8859-1?Q?Ddi0u9+9EjG+fQZgn9FvfMs6dAXTm6j2RfMTWxvY81g20Wsg3/ntHEs/eQ?=
 =?iso-8859-1?Q?w5yV7w1D6GtaF2NgbQf5wCxx5r40d0CKm40B0CvkXyl55h9FiI5uhGJFBY?=
 =?iso-8859-1?Q?HTOA+y9ueYrBNODEU3mHJhPHlhhO6VX/ndqAvNkOFiy0KMiIN68pT/k9nj?=
 =?iso-8859-1?Q?euNwYP6fiVSZKb8dxEy+0PjIvGK4SqpzUYwO/ULo8Zwg/gNSh/qbv4jFR2?=
 =?iso-8859-1?Q?tyxv0ixMnlF63SadfUfJEcuMT2XBc/EKKzY2Xxy1fwBonOdjZ6ZeQtWdDz?=
 =?iso-8859-1?Q?Eb3YHeHsguNoE67tJT+ZgNbNqq8cxfcJEcg2g0JP/I3Y1JuY8KId4+kGEL?=
 =?iso-8859-1?Q?4WBnT1c5s3YqfZPmoFJScagQPYQ/xHMix4r0zm8x86aEPvnnpm1TBqCyse?=
 =?iso-8859-1?Q?WfXFx6BPEk4gt9Y3xgkHOtl141F4Quqjw/WADNw9kdMwnx+pFVBnmBgMdY?=
 =?iso-8859-1?Q?hmq/rzjtLUHuwSrpYACknZMXJIRFCHHW1uisXPTfxocoUBMm2WMbTQdiwl?=
 =?iso-8859-1?Q?K9/HVa5vjR7dtWOVzjpDZQqD9KbZJM93LOO+um+5NgI7oyWSA96tecOAUe?=
 =?iso-8859-1?Q?VH7dESBbf+qLuZ4G7e48rpkiC3snn7QTo34zGhc7Jb04Knh6Y8FBZSnFAt?=
 =?iso-8859-1?Q?q7GlL2NlHKZQZ0tD7zfjAC2+zPRniwAg+hiZ3vJZHQnGcHYQfXWGlbuW9z?=
 =?iso-8859-1?Q?PJ1hBfhioBo9wvBl9/YvbJAWXB51Q8gO5CMAEoXYpL8hfi6DNyV+oTQUQT?=
 =?iso-8859-1?Q?jA48ecvJxDCRhYhd9z2ovhA8PjGCeVI2Qws5BvI7+6XcOjoj3u6whmpthY?=
 =?iso-8859-1?Q?mWCxD+AI72X0BX59z95iQzWU7XAwYZlhY/d88zB0p+l7tehX9RwZkw1XH7?=
 =?iso-8859-1?Q?hzVqEuSS5uuaIema8qdSynoKp/228D7SA+1T3+DnDeHAmf9WwV4frrfqT7?=
 =?iso-8859-1?Q?bcZRMuenKYKosAh31AXypODcw5vitcC3ecprrCUBm09vWJh0K812IvvU7D?=
 =?iso-8859-1?Q?ctiHRAfeR0QVO3IVjw4iDz4ZZ4tVE+f1f9cM8fosoivXgrXJqa9NGDl/6e?=
 =?iso-8859-1?Q?zeW8D2WCoz693njhMOOxtlxmGE0KzNlWSktnjrvXxHAmAWSiuCI3CLA+vw?=
 =?iso-8859-1?Q?VSWdTQKB7F+/PlieYrEGqxNOSQZP6ks6DUIR+EThx7naSQDPepNqDqrW3D?=
 =?iso-8859-1?Q?ESIGO3cKZ9bgrQONsw95Tnh/JslxpKItuHVmAQj2fan7PmLLRQ+AKFvXyz?=
 =?iso-8859-1?Q?DStLVqcRsL3f7N4o5l9UuzmVxfe16t4hYTOE4ee4/x7HFFLPIdzbBJzfn+?=
 =?iso-8859-1?Q?AZ8w+R+HOQo78JIMRc1dM+w8uY7baV0SS/kNgx8CBX+mH+TynYsvEMw7e5?=
 =?iso-8859-1?Q?gTFsmd1P4/k2ZbwlwiLBC/k+sRvYNZDmRNFQ7upOKNKV/7wablI94xa9XR?=
 =?iso-8859-1?Q?NWXSVwwrKYc4cnEEshJRK3l44hXL/zcCDIEuDxqdroSiliDcYyh/15B2PQ?=
 =?iso-8859-1?Q?+1rNpRMRAz3uh3YX9UgpSvkEb1q4fi6q0dFVTnDgCRrFysHjPbCgt0M6fn?=
 =?iso-8859-1?Q?brqcax+NZqPHSaQojodZE82xv54gMymFEnmYdt6M0dRJWzjCNpBEUtncNg?=
 =?iso-8859-1?Q?Zu2yCi8Zpn/QM+kAc/wxlCPrbBQWzLJUGXQOtXb/plE6J4+YFF7F1aQHuA?=
 =?iso-8859-1?Q?AEVeH9dMq8lxkpUvzdF4FExu0NNY0Z2en09RHx4ecP1phKmoVcDETVpE12?=
 =?iso-8859-1?Q?fb2zbOVr1w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D8mNLK9vqFZ/nWuGQ93xSemq8q1UegabtI3RLNn6mInEuI9ONVZZkhLqVC6YqZgI5P+nNIjNCW7cZ2NIblstBA7aPNa72/awpWR9rkZVxDm4n7AiBofqY/88N/Swve3uGxubdi1Y13ZjVVmWq8Rmd0uEX4RQksFAZwaV1firVIBqwCdARjY/3gTc9zlbcnJ3hDR2S36KjOw1b9WCO6kyVPtvpOY7VlurWeKGdIbLoivvnRvaryXHv38MzarWb+6YWUK+l+3TfbU8FzIWDii90MQ6GrJfQuuZMdhfyMJAbTysvs6gi+i3y9qm8akzIGKkGp/Y5zLpVC3ZzzyyIn7ZKw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6d87bd-530b-460c-ad18-08ded8d6c992
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 07:43:34.9269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUVeS+BcpG/DCh4EBj8f/QIEj5VrJv4GvHZxWbuLSxldqaOri9+Xt3MiRtT1aMnZLiQHQ4MDenARVGIzsSiLb5DPRazCozIEDd78Gx/p3us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040
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

The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one=0A=
control endpoint and four programmable endpoints, driven by the Linux=0A=
"aspeed_udc" gadget driver.=0A=
=0A=
Add the controller as a sysbus (system) device: the MMIO register map=0A=
described with the registerfields macros, the interrupt line and the=0A=
soft reset. This is only the register/system side.=0A=
=0A=
Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).=
=0A=
It is not the gadget USB device (TYPE_ASPEED_UDC_DEV) that a host=0A=
controller enumerates, which is added in the next patch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/usb/Kconfig              |   4 +=0A=
 hw/usb/aspeed-udc.c         | 264 ++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build          |   1 +=0A=
 hw/usb/trace-events         |   7 +=0A=
 include/hw/usb/aspeed-udc.h |  54 ++++++++=0A=
 6 files changed, 331 insertions(+)=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index fb798ccbee..8fcf9f48c9 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -532,6 +532,7 @@ config ASPEED_SOC=0A=
     default y=0A=
     depends on TCG && ARM=0A=
     imply PCI_DEVICES=0A=
+    select ASPEED_UDC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig=0A=
index de95686720..e8c00f813a 100644=0A=
--- a/hw/usb/Kconfig=0A=
+++ b/hw/usb/Kconfig=0A=
@@ -146,3 +146,7 @@ config XLNX_USB_SUBSYS=0A=
 config USB_CHIPIDEA=0A=
     bool=0A=
     select USB_EHCI_SYSBUS=0A=
+=0A=
+config ASPEED_UDC=0A=
+    bool=0A=
+    select USB=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
new file mode 100644=0A=
index 0000000000..9be9cfcf13=0A=
--- /dev/null=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -0,0 +1,264 @@=0A=
+/*=0A=
+ * ASPEED USB Device Controller (UDC)=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Models the ASPEED USB Device Controller (UDC), driven by the Linux=0A=
+ * "aspeed_udc" gadget driver. It implements one control endpoint (EP0) an=
d=0A=
+ * 4 programmable endpoints.=0A=
+ *=0A=
+ * This file is the system-bus side of the controller: the MMIO register m=
ap,=0A=
+ * the interrupt and the soft reset. The gadget USB device presented to a =
host=0A=
+ * controller (and the endpoint data path) is added on top of this.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "qemu/module.h"=0A=
+#include "trace.h"=0A=
+=0A=
+/* Root / Global registers (offset from the controller base) */=0A=
+REG32(UDC_FUNC_CTRL, 0x00)=0A=
+    FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, UPSTREAM_FS,       1, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, STOP_CLK_SUSPEND,  2, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, AUTO_REMOTE_WKUP,  3, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, REMOTE_WKUP_EN,    4, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, TEST_MODE,         8, 3)=0A=
+    FIELD(UDC_FUNC_CTRL, PHY_RESET_DIS,    11, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, EP_LONG_DESC,     18, 1)=0A=
+    FIELD(UDC_FUNC_CTRL, PHY_CLK_EN,       31, 1)=0A=
+REG32(UDC_CONFIG, 0x04)=0A=
+    FIELD(UDC_CONFIG, DEV_ADDR,             0, 7)=0A=
+REG32(UDC_IER, 0x08)=0A=
+REG32(UDC_ISR, 0x0C)=0A=
+    FIELD(UDC_ISR, EP0_SETUP,               0, 1)=0A=
+    FIELD(UDC_ISR, EP0_OUT_ACK,             1, 1)=0A=
+    FIELD(UDC_ISR, EP0_OUT_NAK,             2, 1)=0A=
+    FIELD(UDC_ISR, EP0_IN_ACK,              3, 1)=0A=
+    FIELD(UDC_ISR, EP0_IN_NAK,              4, 1)=0A=
+    FIELD(UDC_ISR, BUS_RESET,               6, 1)=0A=
+    FIELD(UDC_ISR, SUSPEND,                 7, 1)=0A=
+    FIELD(UDC_ISR, RESUME,                  8, 1)=0A=
+    FIELD(UDC_ISR, EP_POOL_ACK,            16, 1)=0A=
+    FIELD(UDC_ISR, EP_POOL_NAK,            17, 1)=0A=
+REG32(UDC_EP_ACK_IER, 0x10)=0A=
+REG32(UDC_EP_NAK_IER, 0x14)=0A=
+REG32(UDC_EP_ACK_ISR, 0x18)=0A=
+REG32(UDC_EP_NAK_ISR, 0x1C)=0A=
+REG32(UDC_DEV_RESET, 0x20)=0A=
+    FIELD(UDC_DEV_RESET, ROOT,              0, 1)=0A=
+    FIELD(UDC_DEV_RESET, DMA,               8, 1)=0A=
+    FIELD(UDC_DEV_RESET, EP_POOL,           9, 1)=0A=
+REG32(UDC_STS, 0x24)=0A=
+    FIELD(UDC_STS, HIGHSPEED,              27, 1)=0A=
+REG32(UDC_EP_DATA, 0x28)=0A=
+REG32(UDC_ISO_TX_FAIL, 0x2C)=0A=
+REG32(UDC_EP0_CTRL, 0x30)=0A=
+    FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
+    FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)=0A=
+    FIELD(UDC_EP0_CTRL, RX_RDY,             2, 1)=0A=
+    FIELD(UDC_EP0_CTRL, TX_LEN,             8, 7)=0A=
+    FIELD(UDC_EP0_CTRL, RX_LEN,            16, 7)=0A=
+REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
+/* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
+REG32(UDC_SETUP0, 0x80)=0A=
+REG32(UDC_SETUP1, 0x84)=0A=
+=0A=
+/* Per programmable-endpoint registers (offset from the EP register base) =
*/=0A=
+REG32(EP_CONFIG, 0x00)=0A=
+    FIELD(EP_CONFIG, ENABLE,                0, 1)=0A=
+    FIELD(EP_CONFIG, DIR_OUT,               4, 1)=0A=
+    FIELD(EP_CONFIG, TYPE,                  5, 2)=0A=
+    FIELD(EP_CONFIG, EP_NUM,                8, 4)=0A=
+    FIELD(EP_CONFIG, STALL,                12, 1)=0A=
+    FIELD(EP_CONFIG, AUTO_TOGGLE_DIS,      13, 1)=0A=
+    FIELD(EP_CONFIG, MAX_PKT,              16, 10)=0A=
+REG32(EP_DMA_CTRL, 0x04)=0A=
+    FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)=0A=
+    FIELD(EP_DMA_CTRL, SINGLE_STAGE,        1, 1)=0A=
+    FIELD(EP_DMA_CTRL, RESET,               2, 1)=0A=
+    FIELD(EP_DMA_CTRL, IN_LONG_MODE,        3, 1)=0A=
+    FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)=0A=
+REG32(EP_DMA_BUFF, 0x08)=0A=
+REG32(EP_DMA_STS, 0x0C)=0A=
+    FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
+    FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
+    FIELD(EP_DMA_STS, TX_SIZE,             16, 11)=0A=
+=0A=
+/* Device-reset default: root, DMA and EP-pool soft-reset bits set (0x301)=
 */=0A=
+#define UDC_DEV_RESET_DEFAULT \=0A=
+    (R_UDC_DEV_RESET_ROOT_MASK | R_UDC_DEV_RESET_DMA_MASK | \=0A=
+     R_UDC_DEV_RESET_EP_POOL_MASK)=0A=
+=0A=
+static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
+{=0A=
+    bool level;=0A=
+=0A=
+    level =3D (s->regs[R_UDC_ISR] & s->regs[R_UDC_IER]) ||=0A=
+            (s->regs[R_UDC_EP_ACK_ISR] & s->regs[R_UDC_EP_ACK_IER]) ||=0A=
+            (s->regs[R_UDC_EP_NAK_ISR] & s->regs[R_UDC_EP_NAK_IER]);=0A=
+=0A=
+    trace_aspeed_udc_irq(s->regs[R_UDC_ISR], s->regs[R_UDC_IER], level);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size=
)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint64_t val =3D s->regs[offset >> 2];=0A=
+=0A=
+    trace_aspeed_udc_read(offset, val);=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,=
=0A=
+                             unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
+=0A=
+    trace_aspeed_udc_write(offset, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_UDC_ISR:=0A=
+    case R_UDC_EP_ACK_ISR:=0A=
+    case R_UDC_EP_NAK_ISR:=0A=
+        /* Status registers are write-1-to-clear */=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
+    .read =3D aspeed_udc_read,=0A=
+    .write =3D aspeed_udc_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+    .impl =3D {=0A=
+        .min_access_size =3D 4,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
+{=0A=
+    AspeedUDCEP *e =3D opaque;=0A=
+    uint64_t val =3D e->regs[offset >> 2];=0A=
+=0A=
+    trace_aspeed_udc_ep_read(e->index, offset, val);=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data=
,=0A=
+                                unsigned size)=0A=
+{=0A=
+    AspeedUDCEP *e =3D opaque;=0A=
+=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
+    e->regs[offset >> 2] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
+    .read =3D aspeed_udc_ep_read,=0A=
+    .write =3D aspeed_udc_ep_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+    .impl =3D {=0A=
+        .min_access_size =3D 4,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_udc_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(dev);=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    int i;=0A=
+=0A=
+    s->regs =3D g_new0(uint32_t, ASPEED_UDC_NR_REGS);=0A=
+=0A=
+    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_UDC,=0A=
+                       ASPEED_UDC_REG_SIZE);=0A=
+=0A=
+    /* Root/global registers occupy the low part of the window */=0A=
+    memory_region_init_io(&s->reg_mr, OBJECT(s), &aspeed_udc_ops, s,=0A=
+                          TYPE_ASPEED_UDC ".regs", ASPEED_UDC_NR_REGS << 2=
);=0A=
+    memory_region_add_subregion(&s->iomem, 0, &s->reg_mr);=0A=
+=0A=
+    /* Each programmable endpoint has its own register bank */=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
+=0A=
+        s->ep[i].index =3D i;=0A=
+        s->ep[i].regs =3D g_new0(uint32_t, ASPEED_UDC_EP_NR_REGS);=0A=
+        memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,=
=0A=
+                              &s->ep[i], name, ASPEED_UDC_EP_NR_REGS << 2)=
;=0A=
+        memory_region_add_subregion(&s->iomem, ASPEED_UDC_EP_REG_BASE +=0A=
+                                    i * ASPEED_UDC_EP_REG_SIZE, &s->ep[i].=
mr);=0A=
+    }=0A=
+=0A=
+    sysbus_init_mmio(sbd, &s->iomem);=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(obj);=0A=
+    int i;=0A=
+=0A=
+    memset(s->regs, 0, ASPEED_UDC_NR_REGS * sizeof(uint32_t));=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        memset(s->ep[i].regs, 0, ASPEED_UDC_EP_NR_REGS * sizeof(uint32_t))=
;=0A=
+    }=0A=
+    s->regs[R_UDC_DEV_RESET] =3D UDC_DEV_RESET_DEFAULT;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_unrealize(DeviceState *dev)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(dev);=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        g_free(s->ep[i].regs);=0A=
+    }=0A=
+    g_free(s->regs);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED USB Device Controller";=0A=
+    dc->realize =3D aspeed_udc_realize;=0A=
+    dc->unrealize =3D aspeed_udc_unrealize;=0A=
+    rc->phases.hold =3D aspeed_udc_reset_hold;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_udc_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_UDC,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedUDCState),=0A=
+        .class_init    =3D aspeed_udc_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_udc_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index ba55c28ef6..d4ba60a91c 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -27,6 +27,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files=
('hcd-xhci-nec.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))=
=0A=
+system_ss.add(when: 'CONFIG_ASPEED_UDC', if_true: files('aspeed-udc.c'))=
=0A=
 =0A=
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))=
=0A=
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c=
'))=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 0d4318dcf1..fb79e24fba 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -377,3 +377,10 @@ canokey_handle_data_out(uint8_t ep_out, uint32_t out_l=
en) "ep %d len %d"=0A=
 canokey_handle_data_in(uint8_t ep_in, uint32_t in_len) "ep %d len %d"=0A=
 canokey_realize(void)=0A=
 canokey_unrealize(void)=0A=
+=0A=
+# aspeed-udc.c=0A=
+aspeed_udc_read(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " val=
ue 0x%" PRIx64=0A=
+aspeed_udc_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " va=
lue 0x%" PRIx64=0A=
+aspeed_udc_ep_read(int ep, uint64_t offset, uint64_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%" PRIx64=0A=
+aspeed_udc_ep_write(int ep, uint64_t offset, uint64_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%" PRIx64=0A=
+aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x,=
 level %d"=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
new file mode 100644=0A=
index 0000000000..eb279dd9c3=0A=
--- /dev/null=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -0,0 +1,54 @@=0A=
+/*=0A=
+ * ASPEED USB Device Controller (UDC)=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_USB_ASPEED_UDC_H=0A=
+#define HW_USB_ASPEED_UDC_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_ASPEED_UDC "aspeed.udc"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=0A=
+=0A=
+/*=0A=
+ * EP0 (control) is served through the root registers (UDC_EP0_*), so only=
=0A=
+ * the 4 programmable endpoints get their own register bank / ep[] entry.=
=0A=
+ */=0A=
+#define ASPEED_UDC_NUM_EP       4=0A=
+/* 32-bit registers per programmable endpoint */=0A=
+#define ASPEED_UDC_EP_NR_REGS   4=0A=
+=0A=
+/*=0A=
+ * The root/global register block spans 0x000...0x087: the SETUP data buff=
er=0A=
+ * ends at 0x84. Size the backing array to cover the whole block.=0A=
+ */=0A=
+#define ASPEED_UDC_NR_REGS      (0x88 >> 2)=0A=
+=0A=
+/* MMIO window: root registers below EP_REG_BASE, then the per-EP banks */=
=0A=
+#define ASPEED_UDC_REG_SIZE     0x300=0A=
+#define ASPEED_UDC_EP_REG_BASE  0x200=0A=
+#define ASPEED_UDC_EP_REG_SIZE  0x10=0A=
+=0A=
+typedef struct AspeedUDCEP {=0A=
+    MemoryRegion mr;=0A=
+    int index;=0A=
+    uint32_t *regs;=0A=
+} AspeedUDCEP;=0A=
+=0A=
+struct AspeedUDCState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* container: root registers + per-endpoint banks */=0A=
+    MemoryRegion iomem;=0A=
+    MemoryRegion reg_mr;=0A=
+    qemu_irq irq;=0A=
+    uint32_t *regs;=0A=
+    AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
+};=0A=
+=0A=
+#endif /* HW_USB_ASPEED_UDC_H */=0A=
-- =0A=
2.53.0=0A=

