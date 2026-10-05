Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F29CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFp-0003ga-M4; Sun, 04 Oct 2026 23:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFn-0003fX-3S; Sun, 04 Oct 2026 23:20:39 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFk-0000RH-Tn; Sun, 04 Oct 2026 23:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcR0U1rFI7c6c7mn7lG2rNLHh9l+KEF2vofl8+1fwLhECYPuKoqldkYkquydWV+nmxwVN6Tz1QFm8gKbOf4OsyUpm/1y/I3DE/+2XzkXRFY/mcNuLA/yzBcbnkGHBvGd5V09mny+eBe8yU/9LdZ56aCBJBCbyQCeg0dBX3uORzsH3O3bPRcLpHrc8fBZHm+AJUC//GNnGzJIEit4A6g+rcOGox7eRgBtLwx79uVA3Z7vY8Rrbept4AQkJP9dtdyU3lHo28OzCMKehg3k0c8hhsr1uBpFCqtykIOhTVKRwryfEcsIJHTwu+CukzKmiiGZyKG1KOsgi0XYiXi65NwpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CftF4ge8UXA+FckTQ5LV/lx8huJxTvOcqV/M+IlvGXU=;
 b=xNpDUTp8ZkJ8tIT7bt8iRBitnPaAStMYlxOGqS40UKGQwEOdco7Y7359BRD3h40tXlpJIJ46RfADNC9njPlofPX6gVmvYl7C9ucs1OYVz81Wd8WQTbJYNbZ1lo4f5FRosnIXJePybSgIDQoOjfCWd2KuJo+mTowk6hOPX/TVQ3cS6kx45TySSXEHNKtvUH8tFnPPjIE0uxh3TWR+f4qPEeyYA31yo6cHDW7SthX4DUzlpXFJibLSkYButeBJDCw4vMFQkz6g+d4nPvJSzCo1OTfRzRQxd1CWo/eLHUppwuF5Du2u/I5hKny4nQ2mHGcQ3nqzURyyD1i1ttHsyRY27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CftF4ge8UXA+FckTQ5LV/lx8huJxTvOcqV/M+IlvGXU=;
 b=f6RPAgNXd3muKlVE6fH/E5qJWUSRplgU/StC32pMj+O2x5s39C5i28B2jxN61lfDbrQp7KUhv5dLwCevd+5od/lxCI65qjbxqjja/8JLsIB/vOZqM57sYF5EVDTV46K3tSxo2bJKHJCM3PhH+hWFVMEy0NYrj/2kvD7+gMhlrcadjqP1ZX2NcQAVi4+bcZuOX/ikZI1rdYhyK+BXS1gBvM4Sas8XPnGnHV0bmgrW151VrRFOap4lsbfFSvNdemu9m0kqPVTVZlao3dEiEwm7c1oNRTXADVMOsWyxDXZ0Dslk6O8eOlpEL9yWUa4XwwbLK//cC1FCaObkHjhB+eH98A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 3/8] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v2 3/8] hw/usb/redirect-server: Connect usbredirparser to
 a chardev
Thread-Index: AQHdVHh3Y7UzoIZshEWCtkCa6vL3fw==
Date: Mon, 5 Oct 2026 03:20:27 +0000
Message-ID: <20261005032022.3980903-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6b62ee63-e959-4d98-889c-08df228f9a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|5023799004|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: kL3ym7dYD5wl7UifAycmARa4NCL5KGck92KYV0JKS3ajUXPauaODHY2pN6MYYuMfyg6zc7O+rwong64CIV3SqzIlZQoSUhQF/rnjgU6vBB/ETSIAtcEy4XQuGGAyjGPKBfRjo7xYMQ6lbYMHrfYb99YqIgOBh/VR5HSl+8eJbzyyn5F8qgE6alRKOlG0qzV5KecllAqMIdhU8AAtsruU3dwq6ZWf+4k5gW1pXBjOSg1njTCbtv+73fI8YaENPs64b3aS0WCFD+4LJFXDxWOwUtXoNmBtMHpFoCpLeExm6FW6MaTj9Iw5UeoKpcg8skFvpfpyQTBL5ksWIa8nvKVEiaNFSPKYY1B5TXwxHEarTAz04o5qa1Apgzq1JUn6WjP3joEoEHw05RVIH81klGnQOXBi7nnD9trFB+q5ridPWVl9Ot4eoaw4DOnAwgE90KcE7W759p1qg9UcyiOiJ7EyHjN7mAnQ4xz7JzTtKXj7Ud0isPasGmn0jrH4aGK8pSt3+xDrMt5yMt2YbskELzLQ8Mq6l6qDh1GsmE7SCZTIaSixWWUu4NBZ1up2JOxU9wNFaBHG4ZpfAbXHsiLOl3xm6pjH38x9qBF4GvFXGCJ4VhOSS245Quazn14eCjnVKjVle1eqVvj74oyVCo+U7cDeICX2ihOU7UHD7RitClUY+q5eH6URLVAkf57pQxrVddwB+oVg82i+EruvRzS0BVEqLZOM/JJFr5x4Iqy47+dr0W4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tTR83xikhgzOb64JKmhRd91OEC2ChTCm0uBJubR+IidcekVpYAsedP8TNzc?=
 =?us-ascii?Q?st+LeINFzY+twjP7yWORfemlNIhVcb3r1x6V/YJEtXQKv8+oSL0sSVekQept?=
 =?us-ascii?Q?NsXslCBJnsNEMdd7WZ/mLXO2G45s3/93teuAGCJUo7WbITyZtkTyeLgeaxVC?=
 =?us-ascii?Q?NpfWIqy/rlasD/I/v7I89ODNFMbRMCssGDQYK1G65jMB3Ne8MBYTL4QMGfDO?=
 =?us-ascii?Q?DsiJ4lVe82uttOlYcrSCboLpOvWb/a0gRWiFoY/A6Jr/ibR200qcDD8jN3bb?=
 =?us-ascii?Q?oEGW2JJLNT0DyhMIKEQPRw0TypCLsonB+qPq5omEdfcc0AKNo2KdwSeamiyM?=
 =?us-ascii?Q?Ux3WTa54TeNzE/hvjtoGJGssmH+9htVm4o30BFpsUxZqQPZPsx+N0rpwRKsB?=
 =?us-ascii?Q?iduo/akv6pIzkzyIM3zAcYanZx/B6p93+0r8noabkzoVV5+G3sptiXr+j49F?=
 =?us-ascii?Q?foQVfH/6D7BBx7fLeZJ4j3FfcNhEOvrk+38BzrKHr9Yz5hN7FE0+FDmJ11pP?=
 =?us-ascii?Q?K60lz0CV01hBTDpyRcZ8/sGgVA23memZrOB+ZcXwlgbEGyb3cXNr+LvEC9la?=
 =?us-ascii?Q?ZGz5fc/weLz+PpDMW/ddUK8LQtX97ZWdZPSR3pPoF0VreFYJIfEwNDq21StI?=
 =?us-ascii?Q?KidUyUGzJBS54BSWCqOCPy4g2wEAZQVCbDJewJgIdYs54WGKzqeR88W7n9zF?=
 =?us-ascii?Q?hTS++bKggR7LxnD62D5fvlFPVnxEsvZW3hHG5y/h8l8YU0PA6tGbLKak3OY3?=
 =?us-ascii?Q?WRhDL7+tIVJ8hFI9AQdE88vh5lodVN3mB+ozCCOBMeEqjUfT5kg0gUPyvbtN?=
 =?us-ascii?Q?F49Z3k3HKOFww1/2yU+p99FZiciOGom3gPQFoFW3Lwj39YyuVYydCedF7MsF?=
 =?us-ascii?Q?Uj42q/tBpSr3+HsjCMZEctXokAolx+lc2IQHmleOQT1VhoQ8BgYUFoMy0R4m?=
 =?us-ascii?Q?D1WUigD8gjmyH3O6oIZUAEHJ2x4T0pS66hS6N2xypGgpT+U5sYOyKXJTUD8I?=
 =?us-ascii?Q?xp8zJSyxQn1kjZjoQoef09ciRGftzb66Kq9hyNr/pTMr92DKdMccwAzjiJyo?=
 =?us-ascii?Q?LDRYTDi8fos3TicG4Kz2b7tJBKorJ5VOZ/MLO+xIW/MZlE9q7bWVm6lrslUI?=
 =?us-ascii?Q?N4ub+oZz9sQommYlI87aBMxsvBlEPpEFzAsl703ZZJC3xhU5V7FgyHewPH0r?=
 =?us-ascii?Q?Ct9kHAf63wbEQ+T1HRqFuZG6idcL0av0FiTIx/MvkAMN+LlNAocKiBlGlNWF?=
 =?us-ascii?Q?+E3bABS6Ni4dFCyCfUBiKAvMuukriLqh1Ck7XaKqZTF6XRmdkCODrNbpnpCp?=
 =?us-ascii?Q?epZz74nqDDoeK+T9A7xajY1uz9b2NF/yBU/oxWdMfgUq0V3wHRPa+o32rNN+?=
 =?us-ascii?Q?mNSe2b7Me1Y+Ro8tBDAolV+Yec1p+ijgrlfQ34HKLYIp74tWsbmlyCSx6tOr?=
 =?us-ascii?Q?IbaSUTq0dlycvFQP9plnt3C5zXUaWzzxDYl/XknHqNXwVJ3sNj+gbMuxFJdV?=
 =?us-ascii?Q?xZSnqJDOizDXgSfltJPYH2VQFbgi6DRNt6sWDwfOPCa1sfZtRLa2hXrNBszr?=
 =?us-ascii?Q?q5+L3X5fhubA43pINMDc/vJh7AuVSQavUFahgO/7LKTDAi6YiVx4O4BxpObR?=
 =?us-ascii?Q?rmMckgGI0fDixmCl1fY5RkvwFAgHJIBhkUkUGwB5owEtHMG5AsJMl2vfQwVv?=
 =?us-ascii?Q?3Dw3g32aTBNVlrAiKOexoAE7NutmINbqHPBU/iwF3HhoQX2BxiksVepfb+lY?=
 =?us-ascii?Q?LACIvgEoVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lZLqFz1JtbeRz2m6to3X3Ng8PeweOrR4yb5CaqJVDUy9HYSEgL6CN66Kr5Mc5Rjtc5Pe5Yd2uUjUYH2o5e1KsO3Lbrw+jCUlIPxo08FzGszslflUNXSd7r92oNZWNAWdO3QTr8Rt/RTbD80EkNDxNEHrsqUh776sMHipD8i3mJPgmCGJXR8NtibOirNe8YLcfUNvV30v6qGxmmOlTbtzDbkKWYRuNZ+otWGaoXl49sIJq2joVZv/ChIgRFeq+75SEw2+ALvZiZrYTFmei4hUgOVeUmldN+oaPvOAi0ufys36DAB7RzfBeE0cyUuzWeQhbQnaRDooYetFa7dKsPoY9g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b62ee63-e959-4d98-889c-08df228f9a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:27.7567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vlOfDmQFllTirzNNjWyozQseDFmC2CvmPZ9qZhPs4CX6ZJhf7kJuY1RbI8Fgw/aGEHcUs+sfzr7qEBz8Dwh5wmJXvGj4HVtZr6vIgXNFWg=
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

Create a usbredirparser when the chardev opens. Feed it from the chardev=0A=
read handler. Destroy it when the chardev closes.=0A=
=0A=
The side that exports a device sets usbredirparser_fl_usb_host. This=0A=
side drives the device, so it is the USB host for it. redirect.c is the=0A=
other side and does not set the flag. The library uses it to decide=0A=
which direction a packet may travel.=0A=
=0A=
The chardev handling follows hw/usb/redirect.c: take no data before the=0A=
parser exists, do not write to a closed backend, do not re-enter the=0A=
writer, and let a close that is still queued finish before a new=0A=
connection opens.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |  15 ++=0A=
 hw/usb/redirect-server.c         | 268 +++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events              |   6 +=0A=
 3 files changed, 289 insertions(+)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index e81d4e0608..2af881bda9 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -11,8 +11,11 @@=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
+#include "chardev/char-fe.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
+#include <usbredirparser.h>=0A=
+=0A=
 #define TYPE_USB_REDIR_SERVER "usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
@@ -22,6 +25,18 @@ struct USBRedirServer {=0A=
     /* USB bus */=0A=
     USBBus bus;=0A=
     USBPort port;=0A=
+=0A=
+    /* Properties */=0A=
+    CharFrontend cs;=0A=
+=0A=
+    /* usbredir over the chardev */=0A=
+    struct usbredirparser *parser;=0A=
+    QEMUBH *chardev_close_bh;=0A=
+    const uint8_t *read_buf;=0A=
+    int read_buf_size;=0A=
+    bool in_write;=0A=
+    guint watch;=0A=
+    bool host_connected;=0A=
 };=0A=
 =0A=
 #endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 5f365f0a35..c36b5c16c4 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -50,10 +50,18 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "hw/usb/redirect-server.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "trace.h"=0A=
+=0A=
+#define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
 =0A=
 /*=0A=
  * USB port ops=0A=
@@ -81,6 +89,232 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
 };=0A=
 =0A=
+/*=0A=
+ * usbredirparser I/O and logging callbacks=0A=
+ */=0A=
+=0A=
+static void usbredir_server_log(void *priv, int level, const char *msg)=0A=
+{=0A=
+    switch (level) {=0A=
+    case usbredirparser_error:=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    case usbredirparser_warning:=0A=
+        warn_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    default:=0A=
+        trace_usbredir_server_log(msg);=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static int usbredir_server_read(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    if (s->read_buf_size < count) {=0A=
+        count =3D s->read_buf_size;=0A=
+    }=0A=
+=0A=
+    memcpy(data, s->read_buf, count);=0A=
+=0A=
+    s->read_buf_size -=3D count;=0A=
+    if (s->read_buf_size) {=0A=
+        s->read_buf +=3D count;=0A=
+    } else {=0A=
+        s->read_buf =3D NULL;=0A=
+    }=0A=
+=0A=
+    return count;=0A=
+}=0A=
+=0A=
+static gboolean usbredir_server_write_unblocked(void *do_not_use,=0A=
+                                                GIOCondition cond,=0A=
+                                                void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    s->watch =3D 0;=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    return G_SOURCE_REMOVE;=0A=
+}=0A=
+=0A=
+static int usbredir_server_write(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int ret;=0A=
+=0A=
+    if (!qemu_chr_fe_backend_open(&s->cs)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Re-entry guard. The chain is:=0A=
+     *   do_write() -> this -> qemu_chr_fe_write() -> chardev feeds us=0A=
+     *   -> do_read() -> a callback -> do_write() again=0A=
+     *=0A=
+     * The second do_write() would walk the same buffer queue as the=0A=
+     * first. Returning 0 means "sent nothing", so the buffer stays for=0A=
+     * the outer one to send.=0A=
+     */=0A=
+    if (s->in_write) {=0A=
+        trace_usbredir_server_write_recursion();=0A=
+        return 0;=0A=
+    }=0A=
+    s->in_write =3D true;=0A=
+=0A=
+    ret =3D qemu_chr_fe_write(&s->cs, data, count);=0A=
+    if (ret < count) {=0A=
+        if (!s->watch) {=0A=
+            s->watch =3D qemu_chr_fe_add_watch(&s->cs, G_IO_OUT | G_IO_HUP=
,=0A=
+                                             usbredir_server_write_unblock=
ed,=0A=
+                                             s);=0A=
+        }=0A=
+        if (ret < 0) {=0A=
+            ret =3D 0;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    s->in_write =3D false;=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+/* The remote host greets us once the socket is up. */=0A=
+static void usbredir_server_hello(void *priv,=0A=
+                                  struct usb_redir_hello_header *hello)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    s->host_connected =3D true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Parser setup and teardown=0A=
+ */=0A=
+=0A=
+static void usbredir_server_create_parser(USBRedirServer *s)=0A=
+{=0A=
+    uint32_t caps[USB_REDIR_CAPS_SIZE] =3D {};=0A=
+=0A=
+    s->parser =3D usbredirparser_create();=0A=
+    if (!s->parser) {=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": failed to create usbredirpar=
ser");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->parser->priv =3D s;=0A=
+    s->parser->log_func =3D usbredir_server_log;=0A=
+    s->parser->read_func =3D usbredir_server_read;=0A=
+    s->parser->write_func =3D usbredir_server_write;=0A=
+=0A=
+    /* Callbacks for messages the remote host sends to us */=0A=
+    s->parser->hello_func =3D usbredir_server_hello;=0A=
+=0A=
+    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+=0A=
+    /*=0A=
+     * In USB the host is the side that starts every transfer; a device=0A=
+     * only answers. The exported device sits on our bus and we issue=0A=
+     * its transfers, so for that device we are the host. That is what=0A=
+     * fl_usb_host means, and why the side that exports a device sets it.=
=0A=
+     *=0A=
+     * The other QEMU does not drive the device, it receives it. In this=
=0A=
+     * protocol that makes it the client, and redirect.c leaves the flag=
=0A=
+     * clear.=0A=
+     *=0A=
+     * Without it the library refuses to send device_connect.=0A=
+     */=0A=
+    usbredirparser_init(s->parser, USBREDIR_SERVER_VERSION,=0A=
+                        caps, USB_REDIR_CAPS_SIZE,=0A=
+                        usbredirparser_fl_usb_host);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
+{=0A=
+    s->host_connected =3D false;=0A=
+=0A=
+    g_clear_handle_id(&s->watch, g_source_remove);=0A=
+=0A=
+    if (s->parser) {=0A=
+        usbredirparser_destroy(s->parser);=0A=
+        s->parser =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_close_bh(void *opaque)=0A=
+{=0A=
+    usbredir_server_destroy_parser(opaque);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * chardev callbacks=0A=
+ */=0A=
+=0A=
+static int usbredir_server_chardev_can_read(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return 0;=0A=
+    }=0A=
+    /* usbredirparser_do_read() consumes everything we hand it */=0A=
+    return 1 * MiB;=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_read(void *opaque, const uint8_t *buf,=
=0A=
+                                         int size)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* No recursion allowed */=0A=
+    assert(s->read_buf =3D=3D NULL);=0A=
+=0A=
+    s->read_buf =3D buf;=0A=
+    s->read_buf_size =3D size;=0A=
+=0A=
+    usbredirparser_do_read(s->parser);=0A=
+    /* do_read() ran our callbacks; flush whatever replies they queued */=
=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_event(void *opaque,=0A=
+                                          QEMUChrEvent event)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    switch (event) {=0A=
+    case CHR_EVENT_OPENED:=0A=
+        trace_usbredir_server_chardev_open();=0A=
+        /*=0A=
+         * A close event only schedules chardev_close_bh. If it has not=0A=
+         * run yet, it would destroy the parser we are about to create,=0A=
+         * so run it now and cancel it.=0A=
+         */=0A=
+        usbredir_server_chardev_close_bh(s);=0A=
+        qemu_bh_cancel(s->chardev_close_bh);=0A=
+        usbredir_server_create_parser(s);=0A=
+        break;=0A=
+    case CHR_EVENT_CLOSED:=0A=
+        trace_usbredir_server_chardev_close();=0A=
+        qemu_bh_schedule(s->chardev_close_bh);=0A=
+        break;=0A=
+    case CHR_EVENT_BREAK:=0A=
+    case CHR_EVENT_MUX_IN:=0A=
+    case CHR_EVENT_MUX_OUT:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -89,14 +323,46 @@ static void usbredir_server_realize(DeviceState *dev, =
Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
 =0A=
+    if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
+        error_setg(errp,=0A=
+                   TYPE_USB_REDIR_SERVER ": 'chardev' property must be set=
");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     s->bus.no_auto_hub =3D true;=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
+=0A=
+    s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
+                                              s, &dev->mem_reentrancy_guar=
d);=0A=
+=0A=
+    qemu_chr_fe_set_handlers(&s->cs,=0A=
+                             usbredir_server_chardev_can_read,=0A=
+                             usbredir_server_chardev_read,=0A=
+                             usbredir_server_chardev_event,=0A=
+                             NULL, s, NULL, true);=0A=
 }=0A=
 =0A=
+static void usbredir_server_unrealize(DeviceState *dev)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    qemu_chr_fe_deinit(&s->cs, true);=0A=
+    usbredir_server_destroy_parser(s);=0A=
+=0A=
+    if (s->chardev_close_bh) {=0A=
+        qemu_bh_delete(s->chardev_close_bh);=0A=
+        s->chardev_close_bh =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const Property usbredir_server_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", USBRedirServer, cs),=0A=
+};=0A=
+=0A=
 /*=0A=
  * The link to the remote host is a chardev, and we cannot migrate=0A=
  * that. So this device cannot be migrated either.=0A=
@@ -112,8 +378,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
ass, const void *data)=0A=
 =0A=
     dc->desc =3D "USB Redirection Server";=0A=
     dc->realize =3D usbredir_server_realize;=0A=
+    dc->unrealize =3D usbredir_server_unrealize;=0A=
     dc->vmsd =3D &vmstate_usbredir_server;=0A=
     set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+    device_class_set_props(dc, usbredir_server_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo usbredir_server_types[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 80ead23358..d141661673 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -393,3 +393,9 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uint=
32_t iov, int ep_idx) "ep=0A=
 aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
 aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
 aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
+=0A=
+# redirect-server.c=0A=
+usbredir_server_chardev_open(void) "chardev opened"=0A=
+usbredir_server_chardev_close(void) "chardev closed"=0A=
+usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
+usbredir_server_log(const char *msg) "%s"=0A=
-- =0A=
2.43.0=0A=

