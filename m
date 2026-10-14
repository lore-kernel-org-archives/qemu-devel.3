Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F8CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtkw-0005We-I2; Wed, 14 Oct 2026 03:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtku-0005TA-Sf; Wed, 14 Oct 2026 03:50:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtks-0006yR-NU; Wed, 14 Oct 2026 03:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4An3NIyG44PCkmrlrZolaur5Eg0v9VsmUs+rNlpgjX8myv5TF4LWM2XP4/75TyVvZYka8cEWfEBj3bbfNGQQkfndU46zTQ3rWeabvx0YphFJN4pN8WcvgHSOlNTVsF0vQJJQ06iFW+Hd4ElX+BwFEkrExrWPe8CVr6ITcZQQa5oKddt9tgKZYoMDupiWQyIw4JxBkV2YA7DSzWPZDAvOV/JkA29OUrJqfj5WRHfDvv4Uw0vZCdlofomxaXi/N+7m4SnI4k6e/u6hCamqia1NnKUAzbvoXfjoYyMHKl/OpDANTBeaixXt2JFDNcIvvHuy99LcPa0777rEypdR+S6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgDjjmk5aJEtzJDYSy+QAfsdDtiz+Zj2L+u3qb/6gB4=;
 b=xj0FvHgOV/ZpDFV0/zQ3rGdFe9iOjUgJ2/zKWZjXJ5/xNrt+kP++BFpmFbUMse1yF3MB1yc2cKSfUZQR4Y8OdzE/+XIdl+JRbEV5GO55o4D0xAmVLUFyHndAx6qDBherPQKOQ/1UoS8WL1ZAmMa0dTuhkmYt4S9NEzrJR5GuPySEYEnok/5mnYcJ3Q9MM1mbXxY1Y5D8BsldJR3ll5Vzap70CeaNTl2F7MTjQ8lY5KDPwxLZhjcWgFQCn5bgOaPfQr3zyiWjqtOluj77DZUVI5/InN2JZRglt372usce3eC8bp/ELO6Zyur1phgIQekDM7aNK8py8tb9t6KM4j+7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgDjjmk5aJEtzJDYSy+QAfsdDtiz+Zj2L+u3qb/6gB4=;
 b=UHT8XDaK1kZ3SGMuqDAxJr4GYz7/j2PG8EeoUS2MzpNYLADhwFY7usSWoo1Z8ouRziaHMXvN+E/e/IQjaNuTIqN7efzErf41p2StwIIID0tjDovdABlA+eRmAEv5wvW7d+Kt9Q7r+tC2vCDxsU2OCjR4r5jquSIaPhBPf4Rtk7IKPO46YMPE8aUqRbojqO2v8YMh2LZFE/6qboBOxEr0sY/gG9AQsj+Fnir+TaXhd/PmFcDWoknHzRjH3BXoP9euQDq5LZAoL6u87VGgQ7zvD4RicDXgmO+31ZEsJl/MopMfIV8DWdC8u66rxhPa0YHGOLIDes+Dpx95EeVyTl1s7Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:17 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 4/8] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v4 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdW7Cnmct61icUVEG1STKZc9V8MA==
Date: Wed, 14 Oct 2026 07:50:17 +0000
Message-ID: <20261014075011.2708115-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e173b212-a919-469f-fe64-08df29c7c9cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|3023799007|921020|38070700021|5023799004|261009223027099003|56012099006;
x-microsoft-antispam-message-info: YJ12DRV9OZbpXKWsYZHZkK1MHSufDPt1ikEvfGzJjHhZoC+hy9afugVPAIZmOIpTSmGJE3+AUyVr5d4KA4HN3P7SJYRAitEff5xeRUXwNLLTMfIo6JBrA9jtiK7f7zYthDaWHI61kSKD6Wr7YjeD6mYX2d3gWrK3Ao4yZI7FEuv7F11HLcYNuGSR6HOScR6x0HQ5P5Rb2YIV7HCCxyk+4cPw7L22J9Xmce4NX3LK0TkTncEwuiW9YW+tcM1KCWgtuLwkDgOoyke8Ffe9sfD30LgixF0SqPojZLZ/FF9vp8kDl0Qqg866r42yzrb/vkYruwkJfvX/rI7MGmSdt/9S2kCcn6R7kJ9149EVQ9fwJ2P7HhdHGXJjmDHAYlF4EaJ+YVvQcY97oVsxZ6b1sd4EFgcrZN5Ke5BIJOL7smEG94yATtBfzOtqKN6tjKUahzi9Qoq8CYst+hm2mw7BTqICie5ByEHmIIbt8iNTHJfrX/lNE/6paNPT621Up4h9PZNq+gbOJQltHf3/ekSCpKZXcxmhEiRoMv9tdr2k6XfwtdgOZeCu/1hdGBvKczsp8wspVgqtarVG3RrBZ7s8LCnRYhCWfkP653MG79uhWpQQF1hO+Psvs4OwC90T0IbFSqk7cDj3RxAWnCJsOpmXudaBT4eWt/9tYa62YVMnH7pZE0Dvj3fmpHvsn8Ri7rhDg2NyJuv3gmEVYqrVbFdwWKFf9G9ST2N7Qrc0+oYQUUMhbUJGdrwioDgw5Rx2iVfKnHTG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(38070700021)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7Ms5iszyFNSXo6fTe2xNnNxbKhM0s1+S3IIAEjvqEwG1YHiA27pgHUEH/J?=
 =?iso-8859-1?Q?1D9ucCjADCgQZIclSfr1H4GREpBqZ4hoztBFBa5is5bl2bUGKTPLtwLuEr?=
 =?iso-8859-1?Q?s3P9GlVZgmwOvrRwz1aMSx0xYpxLdNpOJGTpwFxc/UBUhKILwNIc+d8Nhw?=
 =?iso-8859-1?Q?NTwFC3L/1lPNDHBZ27ocLOVa41YWjrH4OCmP4sClYVVdOi5U6Q3kAGkY2D?=
 =?iso-8859-1?Q?uQAtw4stwbPFfC54pyr/2/x8WbdSjNK30cXm0uilNzl+Bg/6TjgB1l63fU?=
 =?iso-8859-1?Q?JTkOXlnNSyr+ius3LtASToT1YcJ2UT2Y+Ipd0S+0WjabWu0g2JYNNkhVnd?=
 =?iso-8859-1?Q?4yMOgYsp/7ikbnkM1E8LeeqT5rmxu1tS+Na+PMrgwSUx14pZr4q1/1WbL+?=
 =?iso-8859-1?Q?+oieWmX+cXku+xPIOnDjs4J2hkpXHy6zoyyOdfnxgAoodwv+gEvRu5paxK?=
 =?iso-8859-1?Q?87tiegcZVYPCKvafhnbozSR5JHzTdbEALBa++YlYrFMVE2FhczQ65ry8Az?=
 =?iso-8859-1?Q?C9bYoP1ociZDdyCm/e2+RPoNhX/5BkE7YUrp8mYrMKcKJX4/Vr1YIsGUwm?=
 =?iso-8859-1?Q?OyegaBzaNaAhRVFPcUc1Jj9bm0/oMJahtf+JZW7qEupovDi4CYmup0cgtZ?=
 =?iso-8859-1?Q?K1sSG7PyVXwseKqVczYjbGAaVGCjrjvSpIC5+SikgJmazqYtFsNqLYLUJA?=
 =?iso-8859-1?Q?G6tQwlLCs3w5ooe686fM1xJ5PmRgnBoeKFkVRXDp+rwq6DKUxVaHZOp3I2?=
 =?iso-8859-1?Q?oIaJMoiLfuPFA5J9q6d6J1SgGuxoMvvsqvYMImskgVeFLc80/qKNbfJ3GZ?=
 =?iso-8859-1?Q?JJo1HdXlYKbBuyZRZ9+n/Kj6pRY/QluNPUV83azhkIO/Fwc8oL2i43Fwfc?=
 =?iso-8859-1?Q?YcgrbAvMdV5HD6Dr0wDbwao96qlFX3KwmQwjW/QK1SitwUigcRnt41mIMu?=
 =?iso-8859-1?Q?xgw6aIB5bAeECnTV5bSw1/StpR1vZRFlvfWtBgWhaQmaKY0m0ZGFiSNXDp?=
 =?iso-8859-1?Q?CssHl16vR4LZKUOJ+4C44Zzt/9cOQjJ5uNUwx5EOn/Kdjn9jSApxZcxn+b?=
 =?iso-8859-1?Q?srRimE8DYWj7VTqYoKfANBk2VnL/3aSZA3dk1ELLnYVvgVhcfAQ81uuSQb?=
 =?iso-8859-1?Q?ewHlz8lTPiCTY3YJt4cGZDJq0tC9W9pOf3V/Geh4nPacfA732NcaA6X/RC?=
 =?iso-8859-1?Q?XhSTT6VNlY8NPUgFGtuA+YHei0AWLhYD4UtXB7TO+p+Z0QQvCVzCyDyogA?=
 =?iso-8859-1?Q?Fc+/wtgeYTs6PAH/vJQbf/6+zzIY4y1mdRwIMPrinGAjTVH+9XhLc2j7I7?=
 =?iso-8859-1?Q?G48b3jpzebTjeKdvjTCHO0MGy+5Rpp4BKSwndgC4MAooGYKS9CZU2cXIia?=
 =?iso-8859-1?Q?QFPEA1deBcgl7GlHGaakkSy9DY+hmZeq3Y+1HbDrQeYKRH5xsmrCGuYjWg?=
 =?iso-8859-1?Q?BFaInXirXit/MX6KQQEQ0sYA83pLSY/RjuvjlOPgmvu1tSs3MTqWwo48so?=
 =?iso-8859-1?Q?mlPLxmbZp1G6r5l/vcCEChUHz5Eou2xlA6S9GGsRAHiV32WRrWUjpeLYpk?=
 =?iso-8859-1?Q?qGSgzbhlJQoYX5hG6HiIcEVm0b+8/3knuAwHs0LIfoblCjT47YOHDDTr7b?=
 =?iso-8859-1?Q?L+JIQ8MM3m6TdACC06EYSEDWYKQ41rO07q+5QKfwvsju91CEzuTjRg7Uc1?=
 =?iso-8859-1?Q?qdWGGKkOU+I0kqGwqXdXSGEEBggX9p1rt/Cff7BwxyklzW72y2ovSoN3ty?=
 =?iso-8859-1?Q?TTeTgV83RaasGdD+cohox4nFvpHw8KUIvMPx9i97XDGJHTMT1AiuQRKKAk?=
 =?iso-8859-1?Q?bw/GvpRCCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TtlcnqTa50n+kJadgDLJBvRbu2DUqZ2akIMFCmZ/Y6vebkvhPN6GQNYkwvAYcS3CEXio8D7jja5Fg49l1VRT2w9Re08QxOHVe0frBQAQrwkaglNEUx5Ncm6gO63MP0Wdr/yzQfWCBOEyKa4WlfYj/S1sY2lRb1PvAQdTnO1Dkmk/R7bOWHpTv/n97ZGxGJa5xmesFYmbGNDoCHjvBZO67XUDP1uQRebFQVM89UDEL50g2dhsovMAMI+Ps2jEMiiAvCBZYs763goWmTnN80ggBikWVLv+T2jW3dRVVt84xSq92d/1T83rEC0pr1TD/xBStwpX38JCa20PdozGpKCvwQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e173b212-a919-469f-fe64-08df29c7c9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:17.0263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tn2zSXx9Xc6LeVTIAeIB0FCfLfsRrMDrQsUt8V8FHodOpqSV8pypk7JJKujfV/BJQUQZLT8QlxL5XVc2ZE86UgB+lbKVA4EZ3fE1+N8+WcA=
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
index a48b821642..05ee0f3873 100644=0A=
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

