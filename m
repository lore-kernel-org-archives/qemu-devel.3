Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FE1CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjcn-0001U9-CW; Mon, 19 Oct 2026 05:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcB-0000sG-HB; Mon, 19 Oct 2026 05:25:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc9-0002px-A4; Mon, 19 Oct 2026 05:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/3L8ZFqmR/bDcizCbdvHiG3+RT4gwxRsGl7LJu5xMD+f/qvxabTALUJH+GKHmdRvZlGxkMTk+w7g1UcAoqkRj/gs/LhLWg+ermEg8JSUjDQ/D8EqrP4N2btKn3Nd5FgMnupeUDwDQN0/xPacvuojnVk5R+1gQkBVGvvbe8+QFwYDWG41nZzI22yItXLEogfie/4Q+zpfXZ+mIU1E6iWk+Qx8f8CteeuS6yoWsTyAQiDD6fZks/NhYn1eRd8h0UrxjrUwZAPg0z1WbTjb16toEoiHHbdW8G7j4+0Kt/UeyOD5mpwiw1BSDSJnH3aGR1iazwgy5SvstUefC0vfYm0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA8Iady+/oo/JZmrFI7jZpFg9mzpdIwQiwyReEas0CU=;
 b=SxoGobNxVTAPsvPMeZFexdCh5H2a1WKTgJvZLj1UxTNIX4Zp8+Jr+coly4+HBhGu9E239zA8/ZXOTdBW59LKaPqEFjbEk3+WjjXK+zpGczNmvCjSpcfJt/N3nUzU/DoFGRX1LE06MvzXlEYpqo+BfqfUMRRt/3I/NSmOi1wZSWUEuxdlT+MUWRIWdknt1Ca+0DGUSofewmnDvKIc16kg/k6wPbf0DucZwl+DrMLaT081CMaQLooxcQBEdECtZuuimWi0QsNZX+q0o61iDswCiUl4h11p3JPCoMQ1xlX4lXtPdUnADfVHq+EID8rpasl+lprDUbzYwTwZhIG/WSbdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA8Iady+/oo/JZmrFI7jZpFg9mzpdIwQiwyReEas0CU=;
 b=PsldIwRvZCFuD+/2dlEVn9T7h9pw1fve2M76jqW2hi7H2I25YGGXzgsdvqgAYyn4+QL16i4t8ylnHcKzsad+G9DGGVcb/MsQsB7aCYDozhXFbkvoUNBqnE9hyt75gMgQbsPYhFVmxWg3gxBN3mf0hbODxyXt+0wojngMZbGNKAqWtNy+WfpPGclm00Tfnga0bI08A2P+pxLZzBdtes/OHmnHDi6OVyGcalRAGuu6N8OBN6IwyEXSLMKxRbg61RdIzfCKWDBsaS7G5TWK7D/au941Zh1JAefbnVmwo3iLsl8qAxcn1/0Z3u4isl6lNp4aaklexbCI1cioBZv9Xgq0Kw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:53 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 3/8] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v6 3/8] hw/usb/redirect-server: Connect usbredirparser to
 a chardev
Thread-Index: AQHdX6uyoWipJGEmTECn/Np3rZBCYQ==
Date: Mon, 19 Oct 2026 09:24:52 +0000
Message-ID: <20261019092448.278079-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 86d904b3-d274-40bc-515d-08df2dc2d4ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|3023799007|38070700021|5023799004|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: l4i6oKMrU5LEy4tHC9tHWbgfMXfk2SI61obXneKDuVbvrZ1DW1FwjY5UPXEF9aPB5ZoeFPA2WfgjyFDoxLxD30a+v25svy4GZ35trhAQ0t6/oeY76WTsUvy6j3Ll5mcpM2AiNmB3j1P3WuMrZ4BgM70DCLpZB18MaFeW1+MVN66xA+3mwmqdpclgdzduudOomnsEkwPfdR0t9h/CYakH0NBlPl7UJL/osQb/McJyhRAmDfpsv1JBR3I3AemApaFtkUOnBu2jCEjUmkFthtipbdsS8ncNmLR9DqNvaxPrfq5fAUijgj1IY77suWD/hQed76VK4XJ9mSbVmrw7qfWg6XAylVPBR7fKIB5C3KWitdLDSYAU5igzylt72kDXZNt83QMAGZWzJvQrHQW9W3BqjrOJPNU3sjxxWk9lcAXaCMjT1q9WWdvHyKfdNvoPYS4CEWRBIjOsxN0KOJVjMrX/OlwdFBH/i8gVKN13Ii/yw4LVuwwl2JlKXOJro4bCt27LBkXCJVTLd9WpK1tN2o0tESeqGhpUpkiD1gJAMg2KpbsvctHVZzrQbjr/WUiOqWq7tzwXlnUM6dgk/PkWVU9oL90c1mHx45DvJsFeJ64873bzmkmCCYrIWOxsLNp8lWJOHd0aQsjg4NjbDxZo0OqzAjqdlQOm21zgNZxtk19EXvDCCU600ix/ujZWTYP605iGenSSTvku4i1cQWl7la9qvVTL1fOcNSbpjvNTYAc06qI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021)(5023799004)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j+nHsg5MYskwkfk9uKXtIgFXpKScUV/Tdb+VoJy9zqMqH+owS+LcC/JtHA?=
 =?iso-8859-1?Q?8pACIt5tzZnme0KyWRTZzDDZLN1wu97oX19hYF3JprR7vvAYu25I60Bmru?=
 =?iso-8859-1?Q?/NuMKlFzdfNYREjC7L42UPZYhT9nSep/1sJr9DE46OIvh6ry3wOKeYIve9?=
 =?iso-8859-1?Q?KDYFVTSac4KmV6Bu38G1erOKc9YYXz4hqQIFOLwSsxFl3U+4tamYJiQiHg?=
 =?iso-8859-1?Q?E+LgLw5uGgsqhd3P6RvFqYnwlTJfUUjWEIcH9CxAkqs+Q4oew4qnUe5Dnz?=
 =?iso-8859-1?Q?ibkQJLU9wVhs1gvJT0+H4JWXedt188pC/3BbVoW8x7x7wrV2huVZlMwj+W?=
 =?iso-8859-1?Q?vnBNsnA5Mhp6LuPHDYmv27dozAkrwBve4yfNh4Gt/n2qgjkJ4hC+SuVgx3?=
 =?iso-8859-1?Q?wnXyoh3Kn17TVOnU13VKlHlQLBtAj2l3NEg1uA7j2sHVWYY66t/CSofFvx?=
 =?iso-8859-1?Q?VcUSdtXmj4eTrRkgp6nda6AoZQBbFHK499s0sUB7tZK3jG4frx6nPBL8yu?=
 =?iso-8859-1?Q?oUmzy3oMNCV1uvp8qhQc4fPdNxPgEvByOm9/sxsn1QMb143Tu1TmMs1N43?=
 =?iso-8859-1?Q?/avUQcYqi8xzeZJGUcAxsAMzviKHvltsSqdcrCsp1jOkBThRY3csN2NAN1?=
 =?iso-8859-1?Q?JuA2k55wUuLWG+S0kGQvgUkGU6Wjb95A4r7RMpxijErIL4sKr3oCY2NUos?=
 =?iso-8859-1?Q?41yehEzYIxHD/EhKxFMqO9/p3cHjyotmIlq5vWyHiLMp2PwqNILYiwvP7J?=
 =?iso-8859-1?Q?ZB2y1l4lnNKaa5/B7Zh9vG5yWacKEoSVp5tEeFuZnzs94IMqNcQes6XzTz?=
 =?iso-8859-1?Q?Z6GNMQO3vL89HX+UpqRuMUumblLlpbJIr12TC4QgecAZTZd+6KzLb6LIfA?=
 =?iso-8859-1?Q?9t0Bcdf4VpFBhRrTE5pZUCPDwwPGAnQTOAFVHnmo0JNDzTrVzAjb2B9XwQ?=
 =?iso-8859-1?Q?4BSMIaShfkj1vR8Q2E48HHF2AvV+CfuUGFYOFKpyQOGEo5K8Y/3bl52NFb?=
 =?iso-8859-1?Q?uPzhUIrT/x/4rcOtMBIYUd1aySozN0W5Lk/tPHHQ07NrO/ZUdLLBPF338E?=
 =?iso-8859-1?Q?DwF54Lf+OT4c9dwNzI1BD7UJYmdW2ipkJG9qduXKTz9PkunCbKkYY/uFKQ?=
 =?iso-8859-1?Q?7TKAjeVqLRcjYp01RTEis5wc4FK8TRMpeB1xZCa+SlpkOlRattzMGU69cM?=
 =?iso-8859-1?Q?Ns4OEKZVNa6CSo0E7yz9M3C0F1cezppYjlmxpYCObS8rGuSK5NvgCHFwOz?=
 =?iso-8859-1?Q?9GxykK0oUtE/zGyrDDv7f2YDW6a1PevNskcqMlMQul6Lrpfoui74CRanEi?=
 =?iso-8859-1?Q?9k2PU6ogjijynW7Jrmul8nUV2vxDF+0dIYg+QmrNWMztOIJcQAtkWs6xkM?=
 =?iso-8859-1?Q?FKlJIVtrEXSqbH+khrke19jatRPvyBxxLzRIU4kQ5LeXLiLIIDDCw1Zyxk?=
 =?iso-8859-1?Q?Dyp4rSIqfy+vF1IDkPkf4HoGOXPNlktbNMzeCTJLwIeT44S/tkMByBca3x?=
 =?iso-8859-1?Q?FEoFILwsUbRbrGUarC81rjTc3utCgVtpjCPHNiqo/32EWUd4k+X/0hEmaK?=
 =?iso-8859-1?Q?lSps0sAqgvYwxH3Zxlv8oXq4KduWEvO5B4r8jN0fbhMsL1u8WPGfbsKQ8p?=
 =?iso-8859-1?Q?FrJmwkKBIRb7sTKTa0CWRaMo8y6OIQ0FFIFY5MRQPkv3qIi7XOOoSkx85F?=
 =?iso-8859-1?Q?yR3/mmwPIHbVfPb7qzJcFJ7JoRwCZUiemgzdiwLKDwB3opkUzuE4nQ8Eti?=
 =?iso-8859-1?Q?1mbR8Dhjy07gUjVZsLtctvgRiUjscSYLJtir7GlhOVdN5bKpYV5b71VcBX?=
 =?iso-8859-1?Q?9SkNX8cO/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d904b3-d274-40bc-515d-08df2dc2d4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:52.9899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iGIAZ3I7KM0zTYcCW5nr8l4V2UUz8ANeJDdvNe/0xpRes2IbWlnVVtzA4ufTgpgRk+4ZSynpK9qfnV6L4eoYkJ1MdnJRa3fb4jz/H05Muw=
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
index bc883add0e..d5ec8338df 100644=0A=
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
@@ -102,14 +353,46 @@ static void usbredir_server_realize(DeviceState *dev,=
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
@@ -125,8 +408,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
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

