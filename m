Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83888C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOO-0007aA-VL; Tue, 22 Sep 2026 05:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOK-0007Wm-D0; Tue, 22 Sep 2026 05:02:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOI-0002Bc-6j; Tue, 22 Sep 2026 05:02:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXke7QcWE7R0kpGfuI0vXyz7wFGLTn+uZiO5L10X3ju0DRU/KzuCFAsVQnNZQwpSCVY126z1zBMFSvC5SDfAO0WdB8f0XHILql60r8WGooYNCU5rYCr7nFzDH6eI8IaBQnejjbFfmEY8Veqcyv41huWzN8oHgSINx/qGQlAjSZ4I/tSZFxBBBHnveMYJL9K9RVbywk7M8W5dErCyfNHD5O2dhDBoqXVbqIJa36D/XhdQRpxfiJVZjO/pOf5Tlsi/NAlADwpAiXxQvYK1912OotKrXDte+JJ/mDN7H3lpj5845kMlzmxp8DN3wfSy3jJ8IyRR9ZOLvkUzZlhDAfJvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsajMUETsE3Ty9K3/qnG5jZcPTKzpskahWJBp50byN8=;
 b=XvJKdi4ACCbP0o+Wpx2Gj1SqiBGDEI7ped3RHkLr0zxLakj7HW6nwnZSQivRPTDDwDSpFBexM93jvTnNn6broCIrN4TfnL0VZcZTd/DqMXlD36zR+0WsWo8//NFOdQ61eYo/V5Mh+QMxArAWFLkBCalwwCxd61T+YhZzDUEWGhZJ4Rh9YBn51Kvd5rDiSPf+MWUhvlpjL366OUOAhecIOqv+RWW8a1NzJd5HR7Bhn/dIiaNzhVn+M4z0znZpxsiIcMNbwUeUl1S9GoIdrZAwRGbSIfswy7dY94UAXLiydPjUaubSGLoIkI5WW0oawykdkQJuUdoxaTgvAUApPsUWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsajMUETsE3Ty9K3/qnG5jZcPTKzpskahWJBp50byN8=;
 b=WCMjAubvDB86ixyQX4xQs2QPkS9Ciz/EwLnMCaa/k8C2iPdM5V/SRHBzm8LROCGxLkSXGRFULL6T/2bQMzT8/AKTU94eC0gd74vIBdvdnAW1OStbyfBtQur/z/BQkNEniAI/G5CV95zntcLTQlFQDPQoEmEHwY+waq85LoejwnM8T6ftExxLGuX0K6j+VWq0E1qBwRDNwv8ZMe5FXUAYmw7zPP0x2ylgJCGzF+Ww4ZG3b5eWQbvABoHPQyJh5S4qJvfbL304pSFRUlXzxNb0IBZ1ThUuNdkh2DEpHWsnfCD/4CE2u+ijvdn7k3LaVPLCLAAY14wQrPPmKj6rZOKxnw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 09:02:01 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 04/19] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v1 04/19] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdSnEHJTbLGrJuPEOvL7OV8PWYlQ==
Date: Tue, 22 Sep 2026 09:02:00 +0000
Message-ID: <20260922090154.1792077-5-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5090:EE_
x-ms-office365-filtering-correlation-id: ce60c032-d0e6-4ac6-47bb-08df18882a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|5023799004|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: BDflsnK+ULl/XdavDCEIO6RRx5YieunW88pbAmtWF8hpUvKWJeSyZ4JdSSmIqt6HcNZkXS8KgA9NbLb40Vly/jH5xkYOsVt6sb8x8oXxP4vifC5oRf4Lpxc0vqQ81INX7f17QYQ6L89V4hIDbuFkUjQME13eRQFihOEJgim0M0G0V7DnqulXAewx6Mjyw4q1+TQwVohB21r9nVeq36ZQnhR8jWDt2tV9E3a6hGHRC8bnUvXPqV9qnWRJLpZeVdhn/SJGt7konUB5S94Cx3d84m1EZG6WgheB1MPD0bwFsfgqOJe15ZW/hfjTSEogcuicIrb6wLA10EQx47NriR8GV468YlO/catP9lloWZKFUtbdAZuJ1pxwR7zW3V6FGhywmwQA+KslsZxbwNqAXvXnhHaaOgKccMjQvZfVoYEG9E0tGMcY0Ml2tJtkCk5FFxygkDV+R2rPEzN/1x33Qb5zHBCVMZm0qyx9vDTPXu31tIhASiD5dWIXIkNQitYr1rVFQ5r6L9JV3mbA5UxlpWYJEwDVaVi7HAfQBc2+Gdb4F2QnG0c7IdGqAgUaI3PJZVOpPw01IkvQderek/42wMwT9YWRilnrZSqdr/KUfXRZzivdBvSa3CR2NaxZLTr62SF8qOF0NOvoehas7hkJvqUHpkAkoXgPpMv0LEbpiofm9v3DAwrRvShpVOqDv19gWZ3wDg8QASrk9K7Sd0EiI7gBLEkpSHg+0Hd276mqVbXJFj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(5023799004)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2w14x/Jm8TYamSbpQCzE6/gzx2JYIMPp39m86N7fPUD4Y1Rf5jhLgMFlpm?=
 =?iso-8859-1?Q?+IIlfwv5l1q1HGpDSz1tkVq0WkH2omBFpSCtmzC1wbtPIt9PuExhanm3Wu?=
 =?iso-8859-1?Q?D/PbqgEuJlp7/o1jVQhY0oaAB3pcG0IAP5dpGth1Er4kZ8MDzNZVLo/mKe?=
 =?iso-8859-1?Q?8BYF1rTqbuhEgxUGMDgTsT4/84ws/VnXv1uaUl/gAUfaUydnU3x+oJ30wv?=
 =?iso-8859-1?Q?88brB6R4yn0OrSILFMTFN/nl8CVLXtNk1elg9kJ9b2F3Sy0zGDtTLdreUh?=
 =?iso-8859-1?Q?TL2RMu22cNgP3T25yFsM8Zj5mtB1/tYH8Jp8pULGHdnTbPaRMu4F5EQm6n?=
 =?iso-8859-1?Q?5At/qGNqPBdNW16hfbjUOp7+aB71X0Gr19qSdsCSrjn+tjVVgJ+OeG849U?=
 =?iso-8859-1?Q?ysJo+BwoMPQ1I54CiZhYhVIaXz/dS93FBhxoF92YpcDX5o+12jpbU80joC?=
 =?iso-8859-1?Q?vDCARtTmkTgTdNiizt5E0TMEGh4SmpryaEhszgwZiNcH8AMzXt5DhwR2sR?=
 =?iso-8859-1?Q?5av+3xKbjg1QGURPhCubrU+E/mjPo2jmJ/Ff/wvr6S35EsZkKSUZAni9Je?=
 =?iso-8859-1?Q?z8eAZfPCeaJL+ZExQgfzeGa/ObToNmVKGV6ea/43UeU+CS89vFrgufY+6W?=
 =?iso-8859-1?Q?9CLezSGr4K5dzwLv2tmMs/d5ItAIsPLPOItrKbHXli6tpW6RDP9FsXaWmI?=
 =?iso-8859-1?Q?73pvgaBMDi6BxYxfCCde9crQ2BqdkkeyUcqcQk4IBSU/VEkuPixb56wc61?=
 =?iso-8859-1?Q?nSqpWPGazzvkR47rNQUOgoMTfz43N8xB1JNgHzmsfjJkmwODbBfZhtOyr8?=
 =?iso-8859-1?Q?pIEWNwp8MlwSh4VLPoX9Mxf2wZonKRoQievE3GldvjSTF+23lpar/Gb0ai?=
 =?iso-8859-1?Q?+JQWgZesB/j9JHcM0XfsRwh+03eiJfUcnLENwJA1l7R6A4Jt3JFXMpJk8S?=
 =?iso-8859-1?Q?lHFRwlFXMclxFl0rBVAM98Wqwmxxx7qYe0oVFrG4NLSyq6DCE2AWtIJf87?=
 =?iso-8859-1?Q?nUSAcUX1D70YSZrzdnezhn2YG+iaXEtbldX+YF0+Mhdofm2MhCxPThjEXF?=
 =?iso-8859-1?Q?ipVvkoetJaoM/Zz0FMz97dq/Ezk71OWzbREYcCZiMKzrdKySJiusyxH9n9?=
 =?iso-8859-1?Q?n9N6T9RcEBwEnP9QNUdhRTBXGQ2jeDETxjT3nqnS429i1eKMjIP8wLkQJ8?=
 =?iso-8859-1?Q?9/niqCr5/WkVrvccFUI6XQmLoZWD9t9bygLtkbuLNO9aGODGIVUMyfIzMm?=
 =?iso-8859-1?Q?W5SjPxJ0nqJpoE0V80jNELsbyXwobL8P8I9JxK5yB4i84Mqe4B6tBpEdKk?=
 =?iso-8859-1?Q?NWxOKHxw7U+2yjAlI897d5hbe8gsj0SrJYrzGlLYpFWBseYUrYq61GVtaf?=
 =?iso-8859-1?Q?GT6ORV1Nv5DU42ZaE28EJfA5uAVIJ4pL1xPuai0pRjc+vOew/puWBl8Hg8?=
 =?iso-8859-1?Q?T0RXsPf7GQsls83kwrUYJvuI8FFD9jkSZlX3PnNvm3WOn/ztoHTUN4Z8ms?=
 =?iso-8859-1?Q?NkImWGuYyFIufFfMdbX0g8QGY7cyEae6F9JTORsJlIv9/rRery+Tv+g0Fj?=
 =?iso-8859-1?Q?oBU8BOsPr94sgBf/C8VfOCDlCThxaTN+R/AhhjlDES87lurb5xCs7J7jgg?=
 =?iso-8859-1?Q?TE/1/A1piifBaw4+I28/xQY6qxs6lqgRFR05nW3uIsgKNKGlojmDTsGogo?=
 =?iso-8859-1?Q?p0KBSPYss8XDo5nZn2gKTbyjCGH1mZWbBDPV57zk3R7c5nJidDBPKYLlzA?=
 =?iso-8859-1?Q?RWnokYbJxR6YdPFnqJTJn6VUuCfuFdYQtpvpTDlEtsSpryZXPGs4pmRJ8H?=
 =?iso-8859-1?Q?JutQ0dT8HA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dkAV2BK08TqTR7M/P3CX4Rn5ktxBNhmsbo02Y44V3Eufwfpk7AET3HiG4dF++4TuBzZHds0QUGyU4CO7BeodIVJUZ5RHrRZf1FPGkPSXpRrsPzb4IL+ljs5rQYW6Qm+G9GCYyxOgjWdwtcxl6jWkiA6KrO1+4tHdOfQ6p6GqmNtLDiWA5k4Ajr8ORLK4hMzg0skdERvPrclj6yoP24ku2gq6I1kSXhBdGirjoSExHBeNeAH8xJoTliOK5zaLe/K93g4MznOXlpyg8MGv1q0okM7zDINHOpN7ZVPi+cRbnBJWeNk6wEv+AgEN1MUVq50o1pmtY7dAzyAEjVM3enVXhA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce60c032-d0e6-4ac6-47bb-08df18882a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:00.5793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1VeS5sDh4ZEXPprQL41CjaXCEPUciaO/clYjE8rOp/fo9ESRRe2UTjeYaNDHQbbLF/vf7SSqdzrFjfOxj1fhM7dPPAcsqiignQzl0FCTQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5090
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
Wait a short time before sending device_connect. Firmware often toggles=0A=
the USB pull-up a few times while it starts its controller. If the host=0A=
starts to enumerate while the device is off, we cannot answer its first=0A=
request, and it only retries after a control timeout of several seconds.=0A=
=0A=
device_connect carries no identity. The peer asks the device itself with=0A=
GET_DESCRIPTOR as soon as it enumerates, so anything we put there would=0A=
be made up. The speed is real: it comes from the device on our port.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |   2 +=0A=
 hw/usb/redirect-server.c         | 166 ++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events              |   7 ++=0A=
 3 files changed, 174 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index 2af881bda9..a3d5084424 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -31,12 +31,14 @@ struct USBRedirServer {=0A=
 =0A=
     /* usbredir over the chardev */=0A=
     struct usbredirparser *parser;=0A=
+    QEMUTimer *announce_timer;=0A=
     QEMUBH *chardev_close_bh;=0A=
     const uint8_t *read_buf;=0A=
     int read_buf_size;=0A=
     bool in_write;=0A=
     guint watch;=0A=
     bool host_connected;=0A=
+    bool device_announced;=0A=
 };=0A=
 =0A=
 #endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index c36b5c16c4..824cd274b8 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,8 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "hw/usb/redirect-server.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/qdev-properties-system.h"=0A=
@@ -63,10 +65,115 @@=0A=
 =0A=
 #define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
 =0A=
+/* Wait this long after attach before we announce the device. */=0A=
+#define USBREDIR_SERVER_ANNOUNCE_DEBOUNCE_MS 10=0A=
+=0A=
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
+    struct usb_redir_device_connect_header conn =3D {=0A=
+        .speed =3D usbredir_server_speed(device),=0A=
+    };=0A=
+=0A=
+    if (s->device_announced) {=0A=
+        return;=0A=
+    }=0A=
+    s->device_announced =3D true;=0A=
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
+static void usbredir_server_schedule_announce(USBRedirServer *s)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    if (!s->host_connected || s->device_announced || !device ||=0A=
+        !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    timer_mod(s->announce_timer,=0A=
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +=0A=
+              USBREDIR_SERVER_ANNOUNCE_DEBOUNCE_MS);=0A=
+}=0A=
+=0A=
+static void usbredir_server_do_announce(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    /* Only announce if the device is still attached and the host is here.=
 */=0A=
+    if (s->host_connected && s->parser && device && device->attached) {=0A=
+        usbredir_server_announce_device(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_attach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_attach();=0A=
+    usbredir_server_schedule_announce(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_detach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_detach(s->device_announced);=0A=
+=0A=
+    timer_del(s->announce_timer);=0A=
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
@@ -78,6 +185,8 @@ static void usbredir_server_port_wakeup(USBPort *port)=
=0A=
 }=0A=
 =0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .attach =3D usbredir_server_port_attach,=0A=
+    .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
 };=0A=
@@ -181,13 +290,53 @@ static int usbredir_server_write(void *priv, uint8_t =
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
+    usbredir_server_schedule_announce(s);=0A=
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
@@ -211,6 +360,14 @@ static void usbredir_server_create_parser(USBRedirServ=
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
@@ -238,7 +395,10 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
 {=0A=
     s->host_connected =3D false;=0A=
+    s->device_announced =3D false;=0A=
 =0A=
+    /* The announce timer may still be pending. */=0A=
+    timer_del(s->announce_timer);=0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
     if (s->parser) {=0A=
@@ -336,6 +496,8 @@ static void usbredir_server_realize(DeviceState *dev, E=
rror **errp)=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
 =0A=
+    s->announce_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,=0A=
+                                     usbredir_server_do_announce, s);=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -353,6 +515,8 @@ static void usbredir_server_unrealize(DeviceState *dev)=
=0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
+    timer_free(s->announce_timer);=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
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
2.53.0=0A=

