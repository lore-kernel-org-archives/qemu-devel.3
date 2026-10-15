Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C04CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrG-0000LZ-4N; Thu, 15 Oct 2026 05:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrC-0000JN-En; Thu, 15 Oct 2026 05:34:38 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr7-0006DP-Hi; Thu, 15 Oct 2026 05:34:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKQpGrCYqZP+LUmgXr7mvWP7mUEb2OhTEjGuD0xNkzh9/MfblyzO/LpJRmnVpnvHqbkg03a+IzoIyejjLe5z+yO0YDhDEybE6HopaLOT6SnWuUW3sLPON4vzRD858ptG6EDBMOqDCjv2qWg9UsGzRPgBo/kB9BA72SCOl6m408kaIJdrZpJ1YoJUAR3bW5Pc3v/drGvSC4N2m6id2yV+AKGZZI12d/YGa4mgCa4S3l0hrqxSTWV2Iq8XW1h+QAg2+0sZWsPFhaoWwcjoWyW+M3ypKvQZDCevb8BeRROs/7UyiDcaZ9H0lCAhIY9ihPgTuar6wNXr8MK0dELKVG9zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgDjjmk5aJEtzJDYSy+QAfsdDtiz+Zj2L+u3qb/6gB4=;
 b=LjgGbIdUVWluzbkNvU+eZjQFo2HEnuVLGvqO/RNXO749Zn5FpZwQUobRILTRRlQ18PXGJab8rRzWM85nbPnZEwSzCsdc9Zoh3e4ibjmjhpy3ZxVXTjeOahe9frgsiiF0ezIgY2QWbFrsQJ2CP34yYCqLb2weDBrbh9IpYaURNaRUpP1dIuYDOATw3VNick30JM6nPf+kFA27xxyoBnWZjDaFxq5MLPxZxa1SlCZzeSKnuZ5Kgs9mgB7ZSaApQ51jSI9wSANp12i24CglVVEdzEltc7PHeli5vHvpOaimWKY6fiXpJNrFqdhqt6OMh28D5lCtnNlB3otsRDUX8eUbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgDjjmk5aJEtzJDYSy+QAfsdDtiz+Zj2L+u3qb/6gB4=;
 b=Py2/lQnuew3e2HoBwGQ/igVbC/WYolx0lSH1R7Ffm+bgBP3JwXcQFS/Bjr6q5G37XwgAUSJf8RtQlIyHgMc6Q9hoHgx7iI8tABklhZoWyTUPBydHJRxyc/heCAvugcO5mLcjXP/YPVVhnEwRjKOlQjzVOiotzJ7b6qF9xELRCmTRxlrlW6SIy62DrLWEDu/FSO8mjrp0SXeXGSdMEkne9YA5iFNJuME2ajfg02wQ85TBo6aM/AiwG/neUbrV7ujNJCYKqF5cPIEVsS2n+fTOep+LzMIsEfURi162Y67M5r9M/C9Sy7XTBBtAOhtMu6dqoq2Kq2VlFdONolNRTE9Dkg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:22 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 4/8] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v5 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdXIhcM3X+mumNX0+nHX6PGK24kg==
Date: Thu, 15 Oct 2026 09:34:22 +0000
Message-ID: <20261015093417.573063-5-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5527:EE_
x-ms-office365-filtering-correlation-id: c2bf4559-07b7-4a89-537e-08df2a9f7ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|921020|5023799004|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: Sy/3fEZRDg4LvwoIEGOY/AqE1HXklXIj80ANiusO41nY5v6XERiXU/LvXYwMgmu/dKoIVw3S0k15Cyd4p3l96g6fx1ZhVSq8XShtVGBKnE00m1V3fjeXOcHJd9HgCaI8jrdCUAiwoFuvpIB03RpJX/tbUac4ztvs+Y009mO1XHI92gmvbz41olGkAAJQcLqkKumGOn3d3Ouv7xCuIbGwXl8VYDU4gfnvR6hnvXQeIunsGM6NZjGhDgWrYgfqgCjKhlKcjC1T5p5l9+qkwDgG4KVT43dKb1Kyfoh6NUIWcmCAq7vlYUj6XdE4IdTW9qozv2UN3kkdziLAZeHkAZrXckHsULaoacV32M4jY5jz6zse+ueztUIlvP7iuNS+fKy+GGfqkiXRMGHvrWXOZ9oBASAylHi2o+eq19CiZCfQ6XDqY0DLFQyS/B54vIa09M7rwvk0+LKW2tFYwLr8lCWPteJQpYgU+gcL3MKJlpCi3ppqX9yxusBiCmwZ2VI5qFWcGU9yHk6+KYgvJm5WBPemK0/gFglkxWluAXtICj9hYAVlEkteuGQ5ySI2NDDxnJhV/0CzRBk23/UnF1LUvVXdc0R0GZ8vp5GLG8GF6akDA6gZBp3E/90EcMCL1WhQOdfJeFAF2V2M9YYCHHY8QXH4kh4PsXEohsWg3fUnVo5zVxQD0x6cyZrEAhmXptSs444RgqjOk/Gyy2wtRVsKb889bIhDcN8L+iekyhS2aNU/PxAGSVPInq9kcQuN3cBoNxNI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(921020)(5023799004)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yuygyjil1cdAJb3HbBJS8gk65IM6sYvJeqpRwYJea+kzafInCbs4l0UATW?=
 =?iso-8859-1?Q?ibRgZZ9hhbAmHkG2EB55XV0DZX5H7lM3Op1oAzFB/h1os9FsGqk8iR44bg?=
 =?iso-8859-1?Q?qbGKYbp9wvB4/bsz2SIbhRZocrO8fwT8B5mW/nCLFgp6pf+62rALqWMTqo?=
 =?iso-8859-1?Q?QWoIYKvF+XTQZxd8dh2LGue+ZFDr11APi7o+9Np52jQ+zZ5y7OssIfEfYY?=
 =?iso-8859-1?Q?dAO3sRszEvuW/GyZvwc2kLUNN+QHSNbDnhJGSnv5V9NMsTO4fOU+N5bEbv?=
 =?iso-8859-1?Q?0mUAJDD4xywtONEPGrwXJoIEGUjtoe0MmozhS2qVY/2EyAzolOZ+0LT8Zr?=
 =?iso-8859-1?Q?T4ZPXSjzaPwTHIctnra6KB4vwvuy6rSqT4Q7/VlZ6b8QfAiVq3DQRivbBG?=
 =?iso-8859-1?Q?e4Ndzw5gdYtAbaEgQZ+hbeFGq072ijpaK2Rg1Jf4vFbG3L3cuOOwm7UAh7?=
 =?iso-8859-1?Q?I8ADPof0hzv1IKYPmjt1hynXwKg5ANsGYSm3VYShbWSeFP/f9I4nO9RGL/?=
 =?iso-8859-1?Q?IQInjtoRQUmSZry1w2xeyFXv/7oWPB7fhrM6snPdu2Ohyicm5qx3KVZkNr?=
 =?iso-8859-1?Q?POJYi5c15hP1+9CXIKCHksJTxRBdQAiyokkHRSWy0G43TvSm9x4ZHYWaAo?=
 =?iso-8859-1?Q?yKU1xuTgk5s4wYY4t15mS5FMoV5YqNTsWYT6HaSut8TeoGSYN+41N3CvOZ?=
 =?iso-8859-1?Q?MtHFqBOsjXLUcAkxRMSNi5X9zNCxYHFWsKv2Qb01WtLd6z/NaEtcSnSiYx?=
 =?iso-8859-1?Q?g6MJ7blaxevFK2wzB0DryKSGiDb3oZetgBJ544HMCht4rJugzyPfDRcRs8?=
 =?iso-8859-1?Q?QPzE+wehG89VcZKuC9YAZlpsjAdGd12UZcrfLwhA82Hc5ub0wjd66N+w1s?=
 =?iso-8859-1?Q?KF6jB4gYXIw0LMF+TQo9iU964q91UfqNj3OJQmdjq0geYcp9s8abNfU54R?=
 =?iso-8859-1?Q?9C1Qj4uwit4USKcjXl3uyleOcJ1CcAkQthdvRsERUZx7LHg7U1qnGBg1ud?=
 =?iso-8859-1?Q?+WO1QHoIPloL8g7Dhgff+EYm9H7Jx8Ojb6Y6TVljtLNwEELpGVKZvOrail?=
 =?iso-8859-1?Q?/8AAiBOx5rixUyjBjofj/Pe71gnRJkyTYpBDJBltZTVBDB9CYNWadV6FLD?=
 =?iso-8859-1?Q?c0LxDapqn6Y6AByMAImAdvk1w1s81wTxITIg5gupeIbC3BzypkYPhgmGfd?=
 =?iso-8859-1?Q?dedHZVjh0Xs0ubYEF8qU3+dRWAc8RSrNACREY1MLvUbbrFD2bbQqr1TAvV?=
 =?iso-8859-1?Q?Ekk4KptexfTeQJMtxnrB4ltaALBRge2n3pumobvYjQpqJl9ACj4rkQWFPG?=
 =?iso-8859-1?Q?fcM+c2qVntPu27AmWaxoT7BX7422rjjePAa+2ZfrSXXI1tWZHD0AQVSkxQ?=
 =?iso-8859-1?Q?gJ8E81AavopKegawzOSVACCZohJWhdTJorqfNnEYfMFPQyECkLaB/wz32i?=
 =?iso-8859-1?Q?17C05xBKnhCN58n6Qq3YiA9h5kqCA+SYuStz5r1fTYf3RS0A7RRINK02O9?=
 =?iso-8859-1?Q?UIcRpt5Phei0DnPZ5rnAu/P1eF/Zm0Qur8dZFcAlUKdBiweeWfwHdGbdhb?=
 =?iso-8859-1?Q?veLSpH962eETeGpCY1tZyBObGyOUyP5HorcY4I9OQGmA0K0XgT28z13qxi?=
 =?iso-8859-1?Q?F3z9tJK+3FrkPJVT1FkfMFMRIu/UgspjienhxMXUkZ0A2nydXr7XkzVocX?=
 =?iso-8859-1?Q?ZW+tP/F7pcyvKV5SSBtYOyCJNgw39NmDemQwQxtgjAHx1+lQgMLbgmhBvu?=
 =?iso-8859-1?Q?ge54y9dBD0Pkhz8b3IM+6NFJWcysXGC711WjL6l/9PAYbQbp8LBuz3WLfX?=
 =?iso-8859-1?Q?d3rKN+rm/Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JVOHgZhtVwBF/CH23tkl0yPm2v9Z5nZGSvfRaAfROU9cXeCPZX/msAUuhBHGeTGLnyd66eUw57xrOGEDhZTKTGY60+9moV6m25Z9FObWuSP8PFAwld48BXBb4ZfTaavO++LTMjLKaqJxwg/na9oql7MkJ6aPc+tSMAzDryaikUMSj1fu/kqgM8YBSYiK5eN/MeaDG6p4HN1uQJTH2IRVe5HedPJljHLeDL+F/5KaIPkuMBfCjkaBMCqerTDzMuUIzuOwQYjUlKPX63gByvslddJhUKnZgfgx37YMtUj2xrueBQK3yBj6dpPqoTcQcXEkOZ8N25fWu7x664t3ANdx3A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bf4559-07b7-4a89-537e-08df2a9f7ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:22.4571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMxuqjkhSRoKXd1Q6rX4yV4dy9O87mk8emX4UMCRf4PAxJSY8/sUWuGVLIaJYfSsvMit1c6W7pkxkz+otWmpSeRfBaXjZMR1XQTtixsp8VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5527
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

