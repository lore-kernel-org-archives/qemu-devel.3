Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB764606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nhXxtbOr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3R7-0004rE-53; Tue, 24 Nov 2026 22:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3R3-0004qB-P9; Tue, 24 Nov 2026 22:12:41 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3R0-0006xv-PE; Tue, 24 Nov 2026 22:12:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVuhg34n4LkXAc4trD1brVjYk9Zeg/kE7m+QivpUQ3cbWSF6Z57EJznkqGkYiqbQolknm8T5TOMQ1pm0XQXBgljAC+CLN33RSI2FksR8em6h6aqlZz5Jy1iVeFzYa1DkP41aJUnNKGOnp0I6Bbpg7cyKp90PGwIObMLiF/uE/P+PcxrSO3SH9rnDWOKwIlAhUEido+XH9mhp5haIokiFLinWh50UyzW97bwLAo8T/X3ObFlejs8eE2pdFYZxkuS2iK744hO5Q+avQoErAkef/qSq6kcKooQlCD3cOXloo22SsHMFcdONdm5oIJbvIEJnGHYHKJ/KYk6yUpy6VK1okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2IOHIuEqleN3w7iqCMsxXbJSQTGfF/5TXvYsYCLBMU=;
 b=vXCKu5yPijNO4n8pJbRN9qweBKw5M/wxUa/1bajVeYSQib1rO1PYUNIn7S05hHXZmXfMi5j7eUlLz0IjJfqs+J7NX1w8xKLleHl2PzbfMB0azVdIzW3Ska0eWnsxRAedj8U/KcmuCdgTqZz5plRnsE30ecWoEG8dpYjuEFD3/B8wR6scunb6z26dvw2mbq/qFc0WrXeUvSPY2ssIzCppzl4p73mX5rcYgwIETrSYJSAQKaVVMhcFB+47JBkvpR3o9jnU5zDdJGltOcXbvWydBh+LQOYVAKk7wiZo+k+AdP0O4vKBK4A8rY4ewUMyAofown9+cGFRH2ThrsX7LHjymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2IOHIuEqleN3w7iqCMsxXbJSQTGfF/5TXvYsYCLBMU=;
 b=nhXxtbOrsXg+qKnKkeiwfcS5uLRQuoKBWdW2Ykt/K2Ckn++t48ZbdWwzOk+BcIyvqrQbvJcAYBVyNvzJFGsC4RaUSL2SUy9JCEnMbJkHfmas9Hmh0cGuC/yZIDYczDAIKGEfF/JoxPFJcqRK3nHKoMpl/34QGYc+jukN0i/PhaPAGYXAU+a0cj6Kp4RUDl8guRnZN8bm8cTnMw/+FFXjrtOZjEB6/z83goJs5yVeFrkNDEI1eRL8ZAOQc0gs8RT5xwwafH4oHVjbNwk6BodzfRS+GseBRIPO75TC/yC5EhekHtse0N5AF+TkxbecmMmZlpggMc49PVHTIcyXSlX+tg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5732.apcprd06.prod.outlook.com with HTTP via P2P;
 Wed, 25 Nov 2026 03:12:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 03:12:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/3] hw/usb/hcd-ehci-pci-aspeed: Add the AST2700 PCIe EHCI
Thread-Topic: [PATCH v1 3/3] hw/usb/hcd-ehci-pci-aspeed: Add the AST2700 PCIe
 EHCI
Thread-Index: AQHdfIrOjj4C5dUTOE+cFcLZvDiU8w==
Date: Wed, 25 Nov 2026 03:12:30 +0000
Message-ID: <20261125031225.3810653-4-jamin_lin@aspeedtech.com>
References: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5732:EE_
x-ms-publictraffictype: Email
client-request-id: 4fc4f953-3562-4f42-9468-f4bf22aa8761
request-id: 33d80b32-e60e-48c6-9356-08df4aa1f0ea
x-ms-office365-filtering-correlation-id: 33d80b32-e60e-48c6-9356-08df4aa1f0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|260925021911599003|261021121427099003|38070700021|10067099003|56012099006|261102123227099003|261028144727099003|261021123027099003|260925022911599003|260925021311599003|261022105027099003|261026140227099003|261026121527099003|22082099003|261009223027099003|18002099003;
x-microsoft-antispam-message-info: 0ou0xbvcCYR/fT2fk3HwsyHX2nPgg3AvvuwkPqXxFb2KXSA8rNejYGKQV9TnCHCzFxHq55oGvFXNRbxxJAQQEziiBKTufgmI+i53v8EHhht8N8kI6IrC02ie/F3k17gzn71VIEebtG1QrUaehnvA0tH1tZfG+tg31FZhsy/Vc4WbKXxF7eFZGHHfSA6CpCYbcOs1beESm+QzCOXsaH+U8vHaGmsS9ANbki3/ko9n+Xjz4A7RezqxT+2jCzuo8hdsnXY9TGzE9+PvU8mdSUo8fTXVyc2EHEm0rC7k2M455UAz0gdl2IPI3OIbxeC+XsSQ74hMmfKLlkLxX+pLTjN03gsrCN2PKvSvbLaNtkbE5Gdlep2F4tiYs2CiyBfV+c5Xw4MCXBsQ5DD2w2Boe7m5Bw11Fe3+JtPGaRjrQqnYUlRyGXkumVLT+/qLyQ8CZXgYW+z9RaDnEUwkWUTYRR2eVjl/1VYwi/NH+WCIIVHtWhMq+0iJm4EQAbjSaA25Y6ltI0yfL9sdu5UhI1i0+1MU7R2OguSmFMS34fW4HXNIpSGQkHdvG3A5ibgbIxZbuEKjuTiCjhd2EQlNt5k0y6EwCsTNsVLTAhIIlz/61zeq9fYljv/fLvp4sYDEIZpmN864Wp/OgKcxhizz+Y+N4OjLHCotHPZvbRuER5FXFaeoUpw7V0uA+tFoceqxGukcwPTf+bTzTxfbDJ54dWw7hVeRYgMVbZtQnEn9/s0yWYNtafc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925021911599003)(261021121427099003)(38070700021)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261021123027099003)(260925022911599003)(260925021311599003)(261022105027099003)(261026140227099003)(261026121527099003)(22082099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S/hrHREtUPnBWD8krcAsW8vEiLnIl5EmjEQTWqxSLRY6YrOrzHoKKmbqpw?=
 =?iso-8859-1?Q?QhE5WgBhlmO2xuqD6d5mKL+5zwhVFBwc+uRhb/Bor51fx7ziEC6y4IMRmx?=
 =?iso-8859-1?Q?VN6rvz4bXf/HWz0PLdHnb1odd8MJRQw3SzyemABV7hmAHFxK1P88CriXkq?=
 =?iso-8859-1?Q?B4zzHPJhgjDKst3smR3s+neQWhEHogXtpN9lTSdVSauQmubU8ITAz4OH+f?=
 =?iso-8859-1?Q?MzXe0nizVmd9MFjO2yGSXyM6nogRxutU75FPnQHACeRTM6Q3FYQizhJvcY?=
 =?iso-8859-1?Q?elDXvYxugKLeY8lsABeUG6ell8zcVklCIqUTiyusiKD0zWWVytibSI8H9f?=
 =?iso-8859-1?Q?HG86k6Zyh29PiE5a6ozmksgr8dsQ2jX5yDVaTH0pb6JZojhC7P3Li+F8a3?=
 =?iso-8859-1?Q?lW9JUzGdJf5AaTLmqGe+TR7N/vh/iwqa9LmFHrvmUn1kb3rinvusuiTBCc?=
 =?iso-8859-1?Q?H74hXAWMzlUqt0h2SmZVQWoiDvZOeik/3E22TDBc3UXvyimQrAv8Fh74Or?=
 =?iso-8859-1?Q?QcZIQqTquQzdLuALbCm7zxU1wLKoqbWOVHZtGsOs+/dxk9CEgXm89oYUA0?=
 =?iso-8859-1?Q?/RNOYA7REyNU26tzAo677AxwsqOKiBjIS/QOkVDE3LxK485/otSTJq4Wja?=
 =?iso-8859-1?Q?9PKY/lSWwoFTkVd0jF9Hlprk4x3xSbMPtzf+Z8jugVtoNLStZS7q0Saq/O?=
 =?iso-8859-1?Q?8Wy3wfJ3092Y3YrmHz+njoYk/One45nOB2XeyFuUXolujhoGD2Z7yTl1g4?=
 =?iso-8859-1?Q?MBNSrCx0FSkWcYrxVHB54Y0X1PdtOoGw2KFBpYLh/Mf+J4w4vLzVa7qyWP?=
 =?iso-8859-1?Q?yggPvd4d71BlC49cspN5mLMQKvz3j0QYVas4Hg3+rCzYi1B5c1qyvEuAT1?=
 =?iso-8859-1?Q?RPusIEZR214niv67cLC7F0LgB0E1dNaCYXdFXCknln8cfAXZoiY72838/v?=
 =?iso-8859-1?Q?28t6DYEmToqFwgjCRZbkCJPKKbTBK7ccP/kWieEPyGeS0DSBdTaDs2zEh3?=
 =?iso-8859-1?Q?xX3FppVrmOS1cOUsd/530ly9llzAPUe3tc8/ojl3CTt18eUHhJ/V4YB2xV?=
 =?iso-8859-1?Q?Tj8UCODX+05Z5xpvl8V+V06/9XQN7OOMYcoPWTF2ZOZAdr4JoYE9hgeEve?=
 =?iso-8859-1?Q?hfXtGz9DZMu/DXPQVEcltz69DfH2SQZdLhWnnDDVuJDz7VUIfTjDm9Ezr7?=
 =?iso-8859-1?Q?qd0HYoUsK3kEab16vuFj8tvE4KpGsv6Sw0G0TTPspKR2MbqiQISjonSFJQ?=
 =?iso-8859-1?Q?cM0vgg7k1OdSgLzThOZAhbOgKUQrzE7qBEWm3eKav1weHx7xCJTTD+9pfS?=
 =?iso-8859-1?Q?9qIvUItEN9I+uRPL7GLXe3yRcTG3w3XRf3YG71s5WBLJi3oWTnQPn8UnNv?=
 =?iso-8859-1?Q?FetsK1B9eDjsKvyGlk8o+FZNy7TEgn9O2UfpuM35Xbzkqk+WQHIpXieu3q?=
 =?iso-8859-1?Q?wd7R/WCWXMidOdrWvlQbACu/gS6GOJy/srA22hkyIbosoDvGco6PvYows2?=
 =?iso-8859-1?Q?Dl65mVS2MMoEMVH30FgVRop/WjBeLJIW+sVfhXzPX4bO0xRkstFMOQ+aCq?=
 =?iso-8859-1?Q?pm7QltoiAw7wVZ180prGJZutfwizYxvoT7GZHfvkuxyJmcaMoTxUU6TzfY?=
 =?iso-8859-1?Q?OCy2kYTtiZqtknOWpr587XQ1Z1+hD8DzRIVraQL/mL06H05K0KL4WH3QbW?=
 =?iso-8859-1?Q?aOIUr4Lw5SokT7R4IwmBiMlLFdnZnI4oFyUGWppqIjzPzSoWchZm345fln?=
 =?iso-8859-1?Q?jc5wa6RUw35Dhy7qa1CbIQCLohtnB9Sf7CzwZ94kJAzHU1NIqene170Q/m?=
 =?iso-8859-1?Q?0xqKwu1uUw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d80b32-e60e-48c6-9356-08df4aa1f0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:12:30.1228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36uzucHhcBHWwny08DztUjgCkCcKC7ugryXldtHY+pSKnj/2Mqo8m7n1JVasfX1T5PGhvBcyjreSfQYlwZO6kEpSZuyQzSrkwgp+Hn5voDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5732
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST2700 PCIe EHCI (1a03:2603, rev 0x72, subsystem 1a03:2603) has=0A=
an MSI capability at 0x50 and uses INTA. It supports 64-bit=0A=
addressing.=0A=
=0A=
Add it as a new type, "aspeed-usb-ehci", based on the EHCI PCI device.=0A=
The new type sets the IDs and the interrupt pin, adds the MSI=0A=
capability, and turns on caps-64bit-addr by default.=0A=
=0A=
The guest decides whether to use MSI. If MSI is on, the device sends=0A=
an MSI each time the EHCI raises an interrupt. If MSI is off, the=0A=
device uses INTA. If the board has no MSI support, the device uses=0A=
INTA only.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci-pci-aspeed.c | 118 +++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build           |   3 +-=0A=
 2 files changed, 120 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/usb/hcd-ehci-pci-aspeed.c=0A=
=0A=
diff --git a/hw/usb/hcd-ehci-pci-aspeed.c b/hw/usb/hcd-ehci-pci-aspeed.c=0A=
new file mode 100644=0A=
index 0000000000..e18fc047b5=0A=
--- /dev/null=0A=
+++ b/hw/usb/hcd-ehci-pci-aspeed.c=0A=
@@ -0,0 +1,118 @@=0A=
+/*=0A=
+ * ASPEED PCIe EHCI=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/pci/msi.h"=0A=
+#include "hw/usb/hcd-ehci.h"=0A=
+=0A=
+#define TYPE_ASPEED_EHCI_PCI "aspeed-usb-ehci"=0A=
+OBJECT_DECLARE_TYPE(AspeedEHCIPCIState, AspeedEHCIPCIClass, ASPEED_EHCI_PC=
I)=0A=
+=0A=
+struct AspeedEHCIPCIState {=0A=
+    EHCIPCIState parent_obj;=0A=
+};=0A=
+=0A=
+struct AspeedEHCIPCIClass {=0A=
+    PCIDeviceClass parent_class;=0A=
+=0A=
+    void (*parent_realize)(PCIDevice *dev, Error **errp);=0A=
+    PCIUnregisterFunc *parent_exit;=0A=
+};=0A=
+=0A=
+#define ASPEED_EHCI_PCI_MSI_CAP 0x50=0A=
+=0A=
+/* The EHCI core calls this function when its interrupt changes. */=0A=
+static void aspeed_ehci_pci_set_irq(void *opaque, int n, int level)=0A=
+{=0A=
+    PCIDevice *dev =3D opaque;=0A=
+=0A=
+    /* MSI */=0A=
+    if (msi_enabled(dev)) {=0A=
+        if (level) {=0A=
+            msi_notify(dev, 0);=0A=
+        }=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* INTx */=0A=
+    pci_set_irq(dev, level);=0A=
+}=0A=
+=0A=
+static void aspeed_ehci_pci_init(Object *obj)=0A=
+{=0A=
+    qdev_prop_set_bit(DEVICE(obj), "caps-64bit-addr", true);=0A=
+}=0A=
+=0A=
+static void aspeed_ehci_pci_realize(PCIDevice *dev, Error **errp)=0A=
+{=0A=
+    AspeedEHCIPCIClass *ac =3D ASPEED_EHCI_PCI_GET_CLASS(dev);=0A=
+    AspeedEHCIPCIState *s =3D ASPEED_EHCI_PCI(dev);=0A=
+    EHCIState *ehci =3D &s->parent_obj.ehci;=0A=
+    Error *err =3D NULL;=0A=
+    int ret;=0A=
+=0A=
+    ac->parent_realize(dev, &err);=0A=
+    if (err) {=0A=
+        error_propagate(errp, err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * INTx uses INTA. Send the EHCI interrupt to=0A=
+     * aspeed_ehci_pci_set_irq(), which picks MSI or INTx.=0A=
+     */=0A=
+    pci_set_byte(&dev->config[PCI_INTERRUPT_PIN], 1);=0A=
+    qemu_free_irq(ehci->irq);=0A=
+    ehci->irq =3D qemu_allocate_irq(aspeed_ehci_pci_set_irq, dev, 0);=0A=
+=0A=
+    /* If the board has no MSI, use INTx only. */=0A=
+    ret =3D msi_init(dev, ASPEED_EHCI_PCI_MSI_CAP, 1, true, false, NULL);=
=0A=
+    assert(!ret || ret =3D=3D -ENOTSUP);=0A=
+}=0A=
+=0A=
+static void aspeed_ehci_pci_exit(PCIDevice *dev)=0A=
+{=0A=
+    AspeedEHCIPCIClass *ac =3D ASPEED_EHCI_PCI_GET_CLASS(dev);=0A=
+=0A=
+    msi_uninit(dev);=0A=
+    ac->parent_exit(dev);=0A=
+}=0A=
+=0A=
+static void aspeed_ehci_pci_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    AspeedEHCIPCIClass *ac =3D ASPEED_EHCI_PCI_CLASS(klass);=0A=
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    ac->parent_realize =3D k->realize;=0A=
+    ac->parent_exit =3D k->exit;=0A=
+    k->realize =3D aspeed_ehci_pci_realize;=0A=
+    k->exit =3D aspeed_ehci_pci_exit;=0A=
+    k->vendor_id =3D PCI_VENDOR_ID_ASPEED;=0A=
+    k->device_id =3D 0x2603;=0A=
+    k->revision =3D 0x72;=0A=
+    k->subsystem_vendor_id =3D PCI_VENDOR_ID_ASPEED;=0A=
+    k->subsystem_id =3D 0x2603;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_ehci_pci_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_EHCI_PCI,=0A=
+        .parent        =3D TYPE_PCI_EHCI,=0A=
+        .instance_size =3D sizeof(AspeedEHCIPCIState),=0A=
+        .instance_init =3D aspeed_ehci_pci_init,=0A=
+        .class_size    =3D sizeof(AspeedEHCIPCIClass),=0A=
+        .class_init    =3D aspeed_ehci_pci_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_ehci_pci_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index 240c5344b7..9e09310d1a 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -18,7 +18,8 @@ system_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hc=
d-ohci.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'=
))=0A=
 system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sys=
bus.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))=0A=
-system_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'=
))=0A=
+system_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'=
,=0A=
+                                                          'hcd-ehci-pci-as=
peed.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci-sys=
bus.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'=
))=0A=
-- =0A=
2.53.0=0A=

