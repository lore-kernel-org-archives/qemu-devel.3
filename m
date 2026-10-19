Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15E5CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjcl-0001OW-Nc; Mon, 19 Oct 2026 05:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcB-0000sE-EJ; Mon, 19 Oct 2026 05:25:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc9-0002q3-BB; Mon, 19 Oct 2026 05:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh3Qs3+7YHxRKWKe1WbIUm5rHPO3npBo+h9B7eNYgosyPM4+n3hu/DI+NG2+2PyMzVNxZYkFTzUB6hLUdHFzrB3bMb/th2QogmS73PeWlxLtVPmvzZtwu+z9bDzm9mGc+KfjMHc7QJN/bigvu9rulCIJBIVswZIy8kEUhyO3jzVUGcToLDJf+Qtz/YhpksfPBQoAcAib8FGvhyoueHhApZhHMdw1qEml9S1hjKDuLMKKnpeVDzL2SidiBG7bSqk+k1mEMj8/7JImwsCcFCA7JeWpL3xGlXgR41011IGOXaj4A8WvAqzlnLiPA9H0sfJlDqaqRMP+h+55Y4Nz+i+PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vxh/rVlU30trvHzTKWQgAgRQ/n0I7ZiMf0q43HPqRU=;
 b=A2d/RbnqIqGs3iPeMoXKS2ukLkrri5NYvlu0LES+59Z/1YypJqJ/aoiNpMVYRYpd0pdwjZK5KjbZcusAqOHjWEzrv7+fmlkI9Or7J4KsXvhbMUybKl0cMAO/HMVZPMJ1tsDNGPWRz2UxYd55kLshKm6mM4B39T6uiGOKrfgCfHzidMRqTa2xdPf8E3T0hvWys35LWV7E2F+HKv2VUL5LmOqp/pJf2P5/ZVIWpJNssrVYK1yLcQF6zfBEIFJ9z31WzlOkcrCGlNQ9aGlBfy6kKvsU/yrV6r03MfyYmYHpWzi0xr2B2DhTgiiPB2kU54FubARcrVbk+WhHwbO+XoGI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vxh/rVlU30trvHzTKWQgAgRQ/n0I7ZiMf0q43HPqRU=;
 b=OsOsvke7HGYH6G0/7xYfekD9anXtU/a1zKmq0HjRDXCTUQENoaTVuqFp2MGq8Z1F+MZPqyrHUR5OXRxpXh989g1KCe6sXd8l6SbuaIRq5o7BzDSVqXOBpfoSXp+CjqOk9PlB4EZDxvWaoEa52/RjZzbe8cc/X0HbmEUdwXq2UzguaqtN4Ao09x3uhdZoFKkBMeyG7zoBZEzoRN0SWTtZaGvuHIuIQ97IrPEDtN+qyxzcrTkBPVq/6Vz1Y7gGDomX0w0hTyb8mrmccWcm/z+ZSPFdWHTABxUnl7QKqEiAAECT3blE0zskFT8CrcGNSR9kaW70NVyKaCGQ/R+VXQwRlw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:54 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 4/8] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v6 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdX6uz2+boWJ2jX0KmWRmM9RqiLA==
Date: Mon, 19 Oct 2026 09:24:54 +0000
Message-ID: <20261019092448.278079-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: d16e155c-6763-4354-7455-08df2dc2d5b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|3023799007|38070700021|5023799004|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: /1jUVLiBRzCq2VbTA8xLq8ed0pjWF7SNol1B02S0fQrRjOeyodlThW8uSv386KqeohXE3iwFK+ploJhNFRTnWWtUayNEvrluLlEN/vLBo03VYqVnf/+q2nKbbf55yC276NH7FcKqRj0DYPsvEocK4I03w0c21NnaVifAHZYG1WfuKgXPeWMo2fELtSdLEb5DwqPrpLjLLUHfKmz3pm4f6mVToj4cMmg/MFjSHOzQQ+0HpaQ6zjD5FtMn+9DciV+/249QMd+dNCWzoa6pulXSpAHMLFIYbycbMDBcHZOWOwnBG2EZZaBgr0HYh5l4HP+m6rb4fCnR+BHTjo3TRBQEC8x8ZqTiJwtOK7LavaN56haB3Y3kdBVppBxQWVrjG30DsSFCOhzBeFZ4Ae3WioHzBI6/j1PNHShfm6PDpvwpIDtJBbkX8Evh6YZ6e05AvimnOgcx96eXJvkO0TBLoagY47WYpU5w1IP6KZDi0xBFJYBXer6n4elMDDWZqfU2hKLAJWj995wSH0fKzT2UMly/LPyrkyJUEHyiPemA/RNjiorREVKF6Gl2fCHxKVyzDGfO96kIAdp+CQ0H3w8DDkuwWmRVGEIW0qmPRBlAf+XmtejVYBAaMQ6sUPeeyWe44f/C0YJS4CtzhUmHSN6DHd43vsTlCYGo1q32tmJ+jsGph24FLJGWpgqTh40ugPObWgFaJvYy1weR2N/thYyskcNkezwdXxv1lfqrskjhyB9tQ1Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021)(5023799004)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jYOGlFz8jKnnaa+Vo8kJ4n+Adu4nXPTfGw2cc9RPJWinh2Rp3opZbmZKF2?=
 =?iso-8859-1?Q?48UTuQ0BJAe++iMHAUVD/T3ElbfBO1XNY44SXkJmV79QLYj8q5iTxWbi8K?=
 =?iso-8859-1?Q?spP9xij44hHJcHXen4C/9U2GR7vAfZqHxtZpD7XN8hq1NDHuj9p56x2fOl?=
 =?iso-8859-1?Q?+9UreFW0p9MgHP+oIhXjwY954JnkaUsLhkIK3g636cu1l+b42NSSWtaDMo?=
 =?iso-8859-1?Q?MYvP3YoOEpRhC+m/lPoi/HvFKTYKLdLXn7uLRtgO8Amj6zmCjbOmfrg99k?=
 =?iso-8859-1?Q?V1rIpaLfFCkRLA8KsLTQdgEm8tMObTttwLhfz/f+upoAOI7GegexkRnGk0?=
 =?iso-8859-1?Q?/wDnFfRnojBZKl3GH5VyqAv/isZ65W6vxZPBZ4ul7pb7dkuyFz+Y3FqiEW?=
 =?iso-8859-1?Q?mvuaU0XNOnhM87o5rN6rTkY7LXfK4z246J9UVkboowtLCC00I5+M/pY6Q5?=
 =?iso-8859-1?Q?f039fPXmroVN/uZSwvPoKhwrQEQQjl4VtgQRAjjfbZPySm4JAWEmmyAea4?=
 =?iso-8859-1?Q?IoWkKPU1m3IY8lirGwdZT+QSu5BC5eQ6MKWBIkooXet4CNQiSJ5wcYaDLf?=
 =?iso-8859-1?Q?RAWK0oOJp9IbQ1l5GDMrhRuTcPJkMayr4kFQX8x8pyp+vyLQISb+HWUF71?=
 =?iso-8859-1?Q?5pdCzoM+TP+lBvb481Br99DqA6Y2WiDWJOeYpM0uD2whn5PQkCNWTGRgcX?=
 =?iso-8859-1?Q?8uoxg+9934XhDB1fHmxSjP11IF+/v+JqbTOX3qh57bnG5HlETqUS8/vKAW?=
 =?iso-8859-1?Q?Owtwqi3Z0rRsJXnq0q6lugUpIGjmOXL5BffYHS8Gxz/ycJsihfDLFdByer?=
 =?iso-8859-1?Q?QBPAGOSidKKOYdXdTQ935oqShftpdOVxnBHy+bioY3onsZ0jmDkql/PcoK?=
 =?iso-8859-1?Q?zo99LC7YE66sOvV7EKj6a/oLl4ra17q/j3Qt2LxEdsXYdNjTXrtpFeSyV0?=
 =?iso-8859-1?Q?nB68gMwhCvkICFgdEFaT1iWXHYGNVZTJOXiHGwj7fS4y81KqDgRoYtn25J?=
 =?iso-8859-1?Q?W1uy+ffaaqxUNssEwKZmPP+HuqwmHhz16ctZ60v/7ltNrTtEQMYZ5sLj18?=
 =?iso-8859-1?Q?379BJyiMJSD1b0JbxFnc5S5ZhuU3eevzo92nutBWNIrFVEOz/jEgAQqg5V?=
 =?iso-8859-1?Q?baWVoE0eaNsJwZxFLN5tmfa0E6kn6esZzTkSfDhRAgU9WaZtxg2afWxjgD?=
 =?iso-8859-1?Q?MWrfLdIi1+YrICzFXaIxDZPRGXejTcj+1R+h+Eur2/jCizqkjxPagzGotO?=
 =?iso-8859-1?Q?5+EetkE81Q/aYOoNQyPy/wFlX65my8o4yJHmbZk3UeBEu/O2mX/hIY8jdE?=
 =?iso-8859-1?Q?2WdZlImpoA411BEVamhFAl0NJf5D2lRImTgwFUZvyrW85wLODz9dMQs1Yq?=
 =?iso-8859-1?Q?he6iL1s8TQg5TIlG1VpiN+xbGz1m9bPyy6MVt1DPGayD0fz6mHX1GzW2OS?=
 =?iso-8859-1?Q?Xu8AJu+ETrFqM/2Iq2hJTKW2sXcG13VboKzvLYVJ+z0++jqC6xw7ZXptOr?=
 =?iso-8859-1?Q?Jt3u4rmV52f2qvi+nyOJIGhKf2Vak7J1qKMa1Vj3jE+/NHRGjwHrRYrT81?=
 =?iso-8859-1?Q?14U76MFIedkDdtzlm5dpBuQAU1LfjnHqD8kiOSeD0v7Jnouk0cCNFt22s+?=
 =?iso-8859-1?Q?zPrJKlOI7qlNCMb4jWYPexbLGfy8h7yX/j4rDvIgaKsLAVvkl07C396Wj9?=
 =?iso-8859-1?Q?t2tNgU89Q+NJhc3yxJaSnzBdTBnX14AVuE/KJqhNk4dTW2P28hTvLukErR?=
 =?iso-8859-1?Q?b9jOZEC/Fbe1dWDLJuybMDPK4cMehCAEc8wK6jwQQfkEZ8mrFEcxFNb2/S?=
 =?iso-8859-1?Q?d8kWmaTB+w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e155c-6763-4354-7455-08df2dc2d5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:54.1939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7e6laoPGRVf8bOrRFF1t1kgJTqHSTOQN0A+xNc+gl49bJSFlZ0V55dTlChdDYtDqhJp2Q7k0F59uyKZNIE/Q9Lom2eAEQEbtzt3gpnXt7E=
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

Send device_connect when a device is attached and the host has greeted=0A=
us, device_disconnect when it goes away, and handle the bus reset the=0A=
host sends before enumerating.=0A=
=0A=
device_connect carries no identity. The peer asks the device itself with=0A=
GET_DESCRIPTOR as soon as it enumerates, so anything we put there would=0A=
be made up. The speed is real: it comes from the device on our port.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 130 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   7 +++=0A=
 2 files changed, 136 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index d5ec8338df..dc4bb53383 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,7 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
 #include "chardev/char-fe.h"=0A=
@@ -90,12 +91,88 @@ struct USBRedirServer {=0A=
     bool in_write;=0A=
     guint watch;=0A=
     bool host_connected;=0A=
+    bool device_announced;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * The device is whatever USBDevice the user plugged into our port with=0A=
+ * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
+ */=0A=
+static USBDevice *usbredir_server_device(USBRedirServer *s)=0A=
+{=0A=
+    return s->port.dev;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Device announcement=0A=
+ */=0A=
+=0A=
+static uint8_t usbredir_server_speed(USBDevice *device)=0A=
+{=0A=
+    switch (device->speed) {=0A=
+    case USB_SPEED_LOW:=0A=
+        return usb_redir_speed_low;=0A=
+    case USB_SPEED_FULL:=0A=
+        return usb_redir_speed_full;=0A=
+    default:=0A=
+        return usb_redir_speed_high;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_announce_device(USBRedirServer *s)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    struct usb_redir_interface_info_header iface_info =3D {=0A=
+        .interface_count =3D 0,=0A=
+    };=0A=
+    struct usb_redir_device_connect_header conn =3D {};=0A=
+=0A=
+    if (!s->host_connected || s->device_announced ||=0A=
+        !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+    s->device_announced =3D true;=0A=
+    conn.speed =3D usbredir_server_speed(device);=0A=
+=0A=
+    /* Put the device in DEFAULT state. The host may not reset the bus. */=
=0A=
+    device->addr =3D 0;=0A=
+    device->state =3D USB_STATE_DEFAULT;=0A=
+=0A=
+    /* Send this before device_connect. The peer needs it to accept us. */=
=0A=
+    usbredirparser_send_interface_info(s->parser, &iface_info);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    trace_usbredir_server_announce(conn.speed);=0A=
+    usbredirparser_send_device_connect(s->parser, &conn);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_port_attach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_attach();=0A=
+    usbredir_server_announce_device(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_detach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_detach(s->device_announced);=0A=
+=0A=
+    if (s->host_connected && s->parser && s->device_announced) {=0A=
+        trace_usbredir_server_disconnect();=0A=
+        usbredirparser_send_device_disconnect(s->parser);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+    }=0A=
+    s->device_announced =3D false;=0A=
+}=0A=
+=0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
 {=0A=
     /* We only export the device on our own port. Nothing to do. */=0A=
@@ -107,6 +184,8 @@ static void usbredir_server_port_wakeup(USBPort *port)=
=0A=
 }=0A=
 =0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .attach =3D usbredir_server_port_attach,=0A=
+    .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
 };=0A=
@@ -210,13 +289,53 @@ static int usbredir_server_write(void *priv, uint8_t =
*data, int count)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-/* The remote host greets us once the socket is up. */=0A=
+/*=0A=
+ * usbredirparser message callbacks=0A=
+ */=0A=
+=0A=
 static void usbredir_server_hello(void *priv,=0A=
                                   struct usb_redir_hello_header *hello)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
+    char version[sizeof(hello->version) + 1];=0A=
+=0A=
+    pstrcpy(version, sizeof(version), hello->version);=0A=
+    trace_usbredir_server_hello(version);=0A=
 =0A=
     s->host_connected =3D true;=0A=
+    usbredir_server_announce_device(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_reset(void *priv)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    trace_usbredir_server_bus_reset(device && device->attached);=0A=
+    usb_device_reset(device);=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_reject(void *priv)=0A=
+{=0A=
+    trace_usbredir_server_filter_reject();=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_filter(void *priv,=0A=
+    struct usbredirfilter_rule *rules, int rules_count)=0A=
+{=0A=
+    /* We accept any host. The callback owns the rules, so free them. */=
=0A=
+    free(rules);=0A=
+}=0A=
+=0A=
+static void usbredir_server_device_disconnect_ack(void *priv)=0A=
+{=0A=
+    /* The host saw our device_disconnect. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_interface_info(void *priv,=0A=
+    struct usb_redir_interface_info_header *hdr)=0A=
+{=0A=
+    /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -240,6 +359,14 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 =0A=
     /* Callbacks for messages the remote host sends to us */=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
+    s->parser->reset_func =3D usbredir_server_reset;=0A=
+=0A=
+    /* The parser calls these directly, so they must not be NULL. */=0A=
+    s->parser->filter_reject_func =3D usbredir_server_filter_reject;=0A=
+    s->parser->filter_filter_func =3D usbredir_server_filter_filter;=0A=
+    s->parser->device_disconnect_ack_func =3D=0A=
+        usbredir_server_device_disconnect_ack;=0A=
+    s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
@@ -267,6 +394,7 @@ static void usbredir_server_create_parser(USBRedirServe=
r *s)=0A=
 static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
 {=0A=
     s->host_connected =3D false;=0A=
+    s->device_announced =3D false;=0A=
 =0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d141661673..2cc6a244b9 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -399,3 +399,10 @@ usbredir_server_chardev_open(void) "chardev opened"=0A=
 usbredir_server_chardev_close(void) "chardev closed"=0A=
 usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
 usbredir_server_log(const char *msg) "%s"=0A=
+usbredir_server_hello(const char *version) "peer is %s"=0A=
+usbredir_server_attach(void) "device attached"=0A=
+usbredir_server_detach(bool announced) "device detached, was announced %d"=
=0A=
+usbredir_server_announce(uint8_t speed) "device_connect speed %u"=0A=
+usbredir_server_disconnect(void) "device_disconnect sent"=0A=
+usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
+usbredir_server_filter_reject(void) "host rejected our device"=0A=
-- =0A=
2.43.0=0A=

