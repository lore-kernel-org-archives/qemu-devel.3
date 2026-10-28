Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C7606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=TAUNZsrL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY9-0004t3-QA; Tue, 27 Oct 2026 23:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY6-0004q3-1C; Tue, 27 Oct 2026 23:42:02 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY2-0005ca-Ri; Tue, 27 Oct 2026 23:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ30zkIvS4LneWqt/URcl667WVjxDn4+BBKAoenwutJpG2dndzGQBB2UCvMgbGAgL9OhVVZYAtFhK+3XHTRlfRKnhbhX2OMKSX1Xvq0aPzSv5z6Kmg9C9NodnDqMJyaqKc/kBRCs7xr2fC5ugQ0O3TOau+b96Vqemai9kkVenO3yxITDeIqNjYVV8M0mJGOoGgvl23KPetLqvxWee9ftStNNndaKgqGlWZr5NqXDZqSNnm/WLdvV2rAaIjntbz2RPqNzflX/clpAcqISJ072I8Erw+Vz3QX/1SNSnhPik9az4mN1hKqHYw0VJBhqhX0P7fmt2+QP4i87Xij2gS6Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp1HEOORdeq3g0dLrVsVmEIFOj0hZLfi5S5lXIF9DOc=;
 b=vs6x1Y3YUI83x0XROvUWs/OLyyYvuLq/k1Z+xc4q3NrO53X1Hk6e04M0DIQjWxeKW6ZLo/zzDKWB25GAhD87pwg+L9qsV6t0a/AZ9HjKVnHT0PpiN19tqijtP6hhzEf3jrGMYTwGjgy128aS2eR/Iaj2XIPyvE7k1QTJmsBHSJqVnrZBgA2cEhBrk3F5kTsd12JdUZDZnjCNOrAiCvtOhxDaqd5yTig/y0ZlK0InjF+Z6FgBBZiLjdvnkhtRZERYEyRgOCTZIAuPI1lIbtiDH+0ZusT9nd2CtABZpz+G1sp7a1NlhuaXGQMk2QJTpbuZXUeVOOWVSuGfNvRsJKzuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp1HEOORdeq3g0dLrVsVmEIFOj0hZLfi5S5lXIF9DOc=;
 b=TAUNZsrL2yBozl5e4GtkX7kctPXelw/xj92jHH9Srepws6XCj7nwt+4mEKgKj26MMukQ6orcrSey3cIKEUkA0zYjYpyVnHO2y7joLDlnXed2Yyg48MeE9TNrLK+SP6ky/SI49MPg3xw0JSYi+OHB+dMWAsP3NqgXysfl52RciO9GM6Fd9VzHEbsxHllZqZe+peSa/PPfUQ6ZS9J7eNkvm/KbbOFpr9Hm4WUKxykc89JQ5XIiMwyo7VL0lXovq/QPSE5SavtBPNGSzmOyetwJJ2dvrFGzjuwJ/Z2p/x24vJrpyZfALZ4b+L4gBkRITPbuQEQcfREGSlh4TgJICnF53Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SETPR06MB9120.apcprd06.prod.outlook.com (2603:1096:101:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Wed, 28 Oct
 2026 03:41:44 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 3/8] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v7 3/8] hw/usb/redirect-server: Connect usbredirparser to
 a chardev
Thread-Index: AQHdZo5AjgtuV1uCgUSYo23mFqqtKQ==
Date: Wed, 28 Oct 2026 03:41:44 +0000
Message-ID: <20261028034140.367393-4-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SETPR06MB9120:EE_
x-ms-office365-filtering-correlation-id: 7fc5c8ae-6162-4518-682e-08df34a56300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026135527099003|261026140227099003|38070700021|261026130827099003|5023799004|10067099003|261026121527099003|261021123027099003|261021121427099003|261021135927099003|261022113327099003|261022075727099003|261022115727099003|261021133027099003|261009223027099003|56012099006|261022105027099003|261021130227099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info: 8YysFQH9S89zNzvD71Q8JTN41iuNIdUtB7Z3LJ3LdlNccxrM+2TPWLmjblggO4s8V4FCcdogiVmwTw2sqlghBlLzEbGsjdIQRr1QQkBQwMG8rs0CxeYjcX5i1gbUeZ/sACRYaMQCDHTrEUqE2mplNRL36vf3/Umh8hyjaU+uKx2PNGksCCggAwpclHbmozjaMb3n/RUMEo2s0DnBdsg+/rAJjplC0DPkFCEYshCXrDRPXZjafQteW/uEUs923n6gcFtDBbR0swlNaema80Fzqr/YInIoPa6wtuiXKMgzHKKn3hgN0KZIQ7WLALjYskSdhMjH1BC6NXT/sauxC403bhJXdl9Vq7uZEIHdBBLL7BDGSVxA1jYEx95L3+ksB/7V0YEj19/SnZdasnNLpXJGebuVDAhF90+NIdJeOteIrel60NKkRMsOj/+mBLtRE4IJVThdrmHjREhd2B4+SScKmnB4MrBeEN1YIUtCA4d8znqBPuLdLyhy2IuKmZdjlNDq/3NeV5qdGwWplGgdIiWpxIjA6QtGSFyrhrglXArbqwXPUu671Cy99GfvDP+sfvYU+mGEbMSkcjf+EIcK3GliTn9skWjFcx/bRBSk70Rrs1vpJ28D2cUl8Sryj54UnCk/xTnC9EB6dmZ6YQ1ZHc8opbPh0J+T2O4NXUIx8CM9iwiyWxJg/uTpII6LyMWy+e8iWHeAZtrmDWo/iO5ewwF9lhK5ZMrDRgQO5fFzizKk7pw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026135527099003)(261026140227099003)(38070700021)(261026130827099003)(5023799004)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021133027099003)(261009223027099003)(56012099006)(261022105027099003)(261021130227099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tj0A0U4cnltfznyxvn74VhGwggXfCGiG/wLcYiDyfD+AI8/VHB+ajNd8XJ?=
 =?iso-8859-1?Q?oXQ//q8eVIjPJH5QK4s5cGL5hBcSJ4d058IPzDPn3eVk3gxWV2AczdoQwh?=
 =?iso-8859-1?Q?B1OyOYvxdiDvTkgk5dCyy/UkzPrPPt9EBxSmWzZpBC58XjnqQJSL9oVy3W?=
 =?iso-8859-1?Q?1wD27yL/hhcQcrIbPt3+/KHVyGE6m1+JfKmcyMZq3ErxxJQRi9JkquBKBU?=
 =?iso-8859-1?Q?Zw/Ag9KQS8XuXzkUmvH2jFCykCnFPsNGR31XFRuSIhXxCdATPx6bgr8Dc0?=
 =?iso-8859-1?Q?Gn2NEzIOukUrrwkuSUvFQrX3cHO+sj0Z22N8F3GcB8rdLTzpJEDwYOiixW?=
 =?iso-8859-1?Q?ETKwwZbJVI1ryn7AAHvh4GBs+x64ulw7O18BBFls/f6R/Hg5Ek9vTRbFe1?=
 =?iso-8859-1?Q?kSypTGewQGCgqrWUac+tJ5MrC8ixy6u3uGSwbt0Zw5Js5QnjvKicHyj+iK?=
 =?iso-8859-1?Q?eLGMo1v8kHEhrRoAtnTJAGQa305+yd6LJLhaqR6scVY+FqQkqXFa6qRywu?=
 =?iso-8859-1?Q?hCRJdU7tST4/i+7ePgobw0NQhyy/cIpH3uWMoETGrWpO0EjRsS9dxTl6vm?=
 =?iso-8859-1?Q?tQvxLkC0y4LZfftK/n1wpK83HzvgqVDNwnc1EMxWPxbTGgLL1ktl+GcCYu?=
 =?iso-8859-1?Q?BjJf06sohEliRXF1nAi6t1wzOZ4GWQYJlAWKHB6+yI9PapMYpepiPpKrdx?=
 =?iso-8859-1?Q?AyPvST+cugAnPmIih4N7+bV49x87UnpoqkayS/bYdcdfrgujGO6T556I0W?=
 =?iso-8859-1?Q?19DnKqFqMzM2qxB9pdkXy3uDk16QRGUALaoj+ua6XGvwZNdN6b7gcLok6Z?=
 =?iso-8859-1?Q?CVVY4z0qNFqzZr6vvYbKbWX2HoSuO05F2+6Qh4ZEqsy2nBhJZCFOyauweW?=
 =?iso-8859-1?Q?8tfevgnjCYQXLOlh7CkIfxEh/cyJNtGum/+6e0MRVroG3Vf4gieDGzmBpq?=
 =?iso-8859-1?Q?mWXu8lSDAy77tl+/OJjQiHqt3EDEzwbU1PTcLLC7zmHEkJXkn8Z9MoP393?=
 =?iso-8859-1?Q?F9vVVsexzzXbl5NGzWqPwuCDgYUAoFehUfvz8pfp35SjqA76OFbbu/PIsH?=
 =?iso-8859-1?Q?0U6Hk37fq8fh0AgRgyjHa/mAkdPot+xoo4/674ZvIM+N8/Y2bMvx/Nu1S0?=
 =?iso-8859-1?Q?cQnqRq8NbLXgFv5Mxbw0zVq59BU7Ihn15BxeuvlzwhGiOYK05kJsprS5eE?=
 =?iso-8859-1?Q?kQbLmSsxiapMRQr1yt+Wg4zvJ1Oss+Z2eoAU1p6rOaN+9kRx/RDRcZ9XpF?=
 =?iso-8859-1?Q?NHVu8+jWjBqcLYoZDMnjKq1wgqUfar4cDc4XKsfdoJLg8H3iV3KpMzBWMR?=
 =?iso-8859-1?Q?vOikRB3T/JJ5wUGwhIWDG1/uFMldqWWTUhFdjdU6ZBJlMIkquPTxqBqqqx?=
 =?iso-8859-1?Q?2HvQuGdPKnOSIDqWoYSnbgB3gpnfTFSAhI3G6wKtemvePGGyNtOVUI4k0b?=
 =?iso-8859-1?Q?as7AmmfFGWvtlorCfQzEsGc+Ab6zPXYU+jBz5xnqJlF9M3iyWhynGl/frl?=
 =?iso-8859-1?Q?/gEgN6vHJsUTbpUIESAApiMf+95wdRFJxpDs/Jpiugk1GEXMyFVWf+9AyI?=
 =?iso-8859-1?Q?lDiL7/LRRvBRuZPS7zS+2Ukvt9IHuj5TNlIFYP92/wrdG56yJY4fAu0kQo?=
 =?iso-8859-1?Q?Mlhk3+Q6iwK5jJ9rT2xJfcxiRJwSxeiaCrw1dWbtSoeg8sHjxrRn7SyvZe?=
 =?iso-8859-1?Q?3kb3NmaHFk9jHDSNVAeudn6mzrFn8SUZ40jsSwj3f8l1BcpS84qW/jBOOQ?=
 =?iso-8859-1?Q?TyjJ0ocnSmrkLiyonvM4srp02isvKCCcA2ANsBkE2cKtZi/7LWwsQfXT7N?=
 =?iso-8859-1?Q?NC1mj4/75g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc5c8ae-6162-4518-682e-08df34a56300
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:44.4604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ty+8tB/+dVQkt/NeQqn6zSAp4NHLS8mBWzyoFcbxyM0EvLkL512VEi9l4kjl+o9R9AYuiXujaHR6b7+JvN5zvSPPk4jV85+Q1SD1/7q9H6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9120
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 285 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 291 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 8399bc2349..4971d81af4 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -50,22 +50,46 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
+#include "chardev/char-fe.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
+#include <usbredirparser.h>=0A=
+=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "trace.h"=0A=
+=0A=
 #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
+#define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
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
 /*=0A=
@@ -94,6 +118,233 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
+    case CHR_EVENT_RESIZE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -102,13 +353,45 @@ static void usbredir_server_realize(DeviceState *dev,=
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
+}=0A=
+=0A=
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
 }=0A=
 =0A=
+static const Property usbredir_server_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", USBRedirServer, cs),=0A=
+};=0A=
+=0A=
 /*=0A=
  * The link to the remote host is a chardev, and we cannot migrate=0A=
  * that. So this device cannot be migrated either.=0A=
@@ -124,8 +407,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
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
2.53.0=0A=

