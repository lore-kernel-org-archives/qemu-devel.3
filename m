Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6D8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFy-0003jZ-Sj; Sun, 04 Oct 2026 23:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFx-0003j7-HH; Sun, 04 Oct 2026 23:20:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFv-0000RH-8V; Sun, 04 Oct 2026 23:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDQE15PXB4sWry0HtrzFxrvs+GO12Sw3AwFz6goamucfkEmk6JqPPG9lKO+N2GbEN5AViaXGzfWlRgaE+Bp3/b37p5chz+5iyJh5Rhmvjqk3uCGaVzT1VgcvJ4l3qS9WJcbs3cNK/F/zT3WZeyMaSHqIt2PfvwyelpQ4vGBoPylFRADrdvlcbvxXnEzbGanlmnk/vnnRotZiICzzC7I1gnao4PrkSqrgVcy28i1TbZMzLUZckBXDbwE+U6+AJc+HFm0iWg7/9omDhEtIVRbmgiQTwQ5uaVgBhmWTolFX0lv3bKhSQj4cxVBF64DWPSzeAKuxpFDFBZxS/l1nCxpftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx50n5I/IrzY6FYkdUflCsvrG3tJDuCTjT5beRk48bE=;
 b=d6I/Z4EQbP+gBFmaGpIk6eLrR3MpHGFFlOSo68CttxjLQGYyvFNYcDxFSuUIthpRgyJ9Q1fi+n6+UTynSU2MuA7EA/pP/4PZmKrOQl3T5dpmvGaipUYR5RyIibEtlU2MLpXjs4Lepg0Ly4OkMmQgBRpoWrnPjTZRInSQ556Dz5efAZbPb19Cx2hdide6+qt0uPb4axUcZv3XZozr9HmSNpMQh3bPJ7SJ4KCni5wl+7xq5EjG6ZeGNKhQkcCb7fGBpHvxj4FAlYciXP3Iuz54Ou9/pJE3bJw9AeuHw69GVq0cyVc/Qiqvx6aUMjdQm/MayFqydniAHSya9rxfgUjdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx50n5I/IrzY6FYkdUflCsvrG3tJDuCTjT5beRk48bE=;
 b=GT/XF5Iw3yMPU5zL9a4c3LV17MyZvKn3iB2aej9Mto372jh2U2KC+6L14WGQM+kZu3d0pW19BSbhMGc4FjXOaorWvNZ6JIGdrAv5gwkhwpW0a4IdRtDK/Etmi+TTAV2PeVx74vqDPuxZ0Om08kvdHPnxuzDkAVDhvWfKdneuJkbE8m0XJJSl9HdaEj4gJRhJ4q+mj7GXGWQ2uNKWlp04ApMnhth0Oihmbmv4GmujhJzFJ8dJxOe1XGNXQB/X6BV5uLeKWvw/PI0u2i/vujNhNNIXUI1WzltH/Q390ex3vId3/+nTbDDTBSxbEKiNoQpddJVbWVHtaJiEU4BAwfPsmg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 6/8] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v2 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdVHh62Fspi3tkhU27HBXcmYEgWg==
Date: Mon, 5 Oct 2026 03:20:31 +0000
Message-ID: <20261005032022.3980903-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: fd3d6c40-02fe-42a7-05d7-08df228f9cc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|5023799004|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: YeA8rydiih8UpBscHTFvilwe+7W/ZViHhVQIPo6xGfGmd9qA6NDO2IMhsiw3WDIkeWEfGOyxFZjg6BAau5MewTXK+Igolcf+KMyPNNLhr7PpzfGosw3O8OEZdlK2y9OLB8D93Qa9oRHy/K0FrBKFEhkQxx5s84hLbNEaQVnMP1aSTac0OTTDLTnRMFEXTSnvecf9SIyk5nBOuJ6IkxqU9jXDYKV3hdsaJ1Cb1OUm0c1ThKlqyZPduHY/8JmZKSy8FerWRD09LoxsPbU49hapsw5S7RX89CM0T5bZOumP6ew4DDdQJdy46Wr1rH5Jj19EgLKAV4/qecPJ49ZN3PpacnY1NomBgtEDKUUPJArCEb8Xcf1P/s0Zt20kst/FfEhV+7Ihz19bg5JcNXdtBQz2Z0LbLyDGlQAwL2pU6EZQZrH7IJbkNIN54sY8Kre8WfEUfjjS+CtmuSeaFEMzIUpVAAQEE1HxP/EM7D4OI8D0jEIX0gOlghIVBcIbGAnnOgkvR/Ekh8E2Lfq3UizlTyzwRYc7jncHftCXZo+NQeT4YP/PD9GqGmRiO/Dlc91OArwImiCLs0ZQjfgA0GirLO01Lv24EMmlEUk1dA8IX7iQWM77VQzh3XsJMYLRnD678AlMe0hIa28WUr6RAQgSwS7pfLLjowuXp0FxDt5o77t6/qvH1xLs03KTfukMmnXH7DQW3AzRUPB73Km6PQhGO2rpVgv7W9RoYAaL8/zJLBKKpLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ci08Da3oDinqXMmlEuj9s33VmYRVfmW+H6IEg9iTPO4SjrEFPWk0Nom40QYM?=
 =?us-ascii?Q?TPoPmj1w/iXCjIezC7QgA5JhjLXMMZByzfxm+xMnefYfEIb6QgOZW++uWy2K?=
 =?us-ascii?Q?UY2h2UK1Ol49hGG3fgllY08j02xrUGskV9zytrX1khCGc+KDLr8rquB7oRRX?=
 =?us-ascii?Q?UuXLUdFkw5AGgiF3KnVLcO6bIT1cZPgvGj+wrSVqFT4YUISZ2f1rFOui1R4e?=
 =?us-ascii?Q?CZHA0m8trbYxf+1QUMFs3uPEQLzjTAaTCGR9qzwIcxu4oxWVBGU1IOolUa6M?=
 =?us-ascii?Q?ht3ndPanZlMdO30Ib0nOtziJfjk54cLmMoq2VwNKzLc+JrrydfVFjwVle77C?=
 =?us-ascii?Q?4ftg/3iJQvg1DJxYJgLbDGvSFXewbd1nzoaezXd3E4i8F28tarM6IWOGu9nV?=
 =?us-ascii?Q?znMniMg3JJ/WrwuW/m7clBb0jOIuml4ZXsqW6Z7QRL5Hf8H1UuSvGSladfoU?=
 =?us-ascii?Q?cJQX2dMVg8Op2mRHcDU4mmaqCkI1peZBXewpS5rKyUARi8+7vxjPshIU6ztv?=
 =?us-ascii?Q?SKjpkJTOvLAdh7WqsSTA4hDodGCA3kgKXt5pP07Kv0udors43NODbp3C2X+2?=
 =?us-ascii?Q?DipfVUxiWp+EEULpb+5OwpC4Jx11F8Mf96A1nIdEjVyvpVQE6YmNgcb+1rwr?=
 =?us-ascii?Q?GdPo0IYMqNcQ/B36w5HdgPfLuTZd4WUEd96lpz2oxCTETRbnBeChaBkfem9K?=
 =?us-ascii?Q?ex+5LAA9PwnISLXbPs8rF0T6qc2jpHpQTE4bGst0uSGIDf2cIL2A/wHROcW5?=
 =?us-ascii?Q?x3Vk8vVtwvrLAVg9lhLec9udueSi5gNDbfpnC59VZh+5r+IAxT4pn/cv/vYv?=
 =?us-ascii?Q?+1Br8z4SVH9j69dN+XBszek1WXzSGyS/V7eKXHL6g+EXTN9L6MIvT0rMUXcN?=
 =?us-ascii?Q?syH6JIkHnTtlmTFgQzlTfshk2YHAuGEzzALAh/hwJS3XN5B4vmDbout2iksf?=
 =?us-ascii?Q?2SkSOBZ+f/UTM9XNewM/N+d92Q5Z6L1xrj2qHCSjiNbgoTwZPj1Z6RvixPGx?=
 =?us-ascii?Q?lKjN1GTg8ra3DjPR8BqZ0wznOA1PjjsNbHJq/MO1VxQF6aXIcEmRKRM21Wp7?=
 =?us-ascii?Q?WG/XEys2l01h6ouh1VyGmKghKR1dnBn8o4nMgvhWDR3fznSDRHiAz8gIl5lP?=
 =?us-ascii?Q?n+ydB/ZaOjsq142i5fYd891oVvGYhxsj/Nz4QLogU5XIf5DQIZEO66CrqUt1?=
 =?us-ascii?Q?g2KYDY1Zk0yjqa2l+GyYlQBZIP7c3C7lpz3KrkSWhWguaHSmAsJQJ7XqeJT+?=
 =?us-ascii?Q?xA2OhmFXnd+gVJ/XU5jgFDQMdNGEYPhaSKb8IlFebNgIYcf6Y11SxPJ2Pweb?=
 =?us-ascii?Q?aFwDR1eoxyI3BmXtE9sp/Z4behosnw9OaoepMYpaXrpjQ5hv8tcYkjUyMeHK?=
 =?us-ascii?Q?Uhup/MnpCMNmh7+ubl2B90HEv1ifOw3CX/0Ks0tnLTXKR/1Y4ZVp50bVzxaI?=
 =?us-ascii?Q?BOEcMyJ7AYBLNvO8li9l5MUVLXuylRe6zOU2uRLIqpnkLbakxNbiqtVuE0r3?=
 =?us-ascii?Q?Hk8QfThG21OB75L02k2Q8w7Guy7JbKYfaXso0SbKB2jHAP7epvFHjT2tSsVW?=
 =?us-ascii?Q?vFzA73mBHri7NciXYFCTlA068P1bLu16lliNreDXfpmD3nGcOgoTcKyrlvUv?=
 =?us-ascii?Q?1Zqgr+pV5PZyfy1ooQRzXDXrGAdjqgeA9ylFIEvzU64+mCO3thtBjsXHlXP8?=
 =?us-ascii?Q?RuMEM++N4hNzJ3zxmKlcsnK3iDm/5Gaw7krfyWR/3wmnJcACKcRnHWAGIH1W?=
 =?us-ascii?Q?VY7TnRx3rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3GeBKBMY15nHaPo+ERwV3gB5BkmHmXzrV8OGk/8NDCu9yltLt9skLeg6lQkG97kyMrcjh6nXHi88iLSmA9ViQCuCYN9tMWkRUtBjBhomFDK1YxkTQPp5hZGP/i9xw6SNhWsNxSswpXp/PvTAzxxW8RyLzs2F1F1BvCfSI1aZxgeQ058UcvSYMFwn0M/lNosLW8S2c+WvbQAjPDJw84suz4q2C+G9d8elJzUZ/Cw4Kp9NxMC6VYTDH0G3/Iv0TXL9SBgVaIH0WLTES0d+DVazX9BHgNYB+7Xl+sVf4Zu9QFxK7iQ5geiQxdPBrYmmq3UH6x7l2nibvxwymqad2WXD+w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3d6c40-02fe-42a7-05d7-08df228f9cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:31.5877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkIZ+qqQcWAKcKK+H2DlFkVDwv92TkXmJNHliKtI/fqynN2MkaR7Coa6mLmwzvOOzoOYGXmoafJKb+fWgESFQDQu1IOJn5rQqmvoKShzP50=
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

Send bulk and interrupt packets to the device and return the result to=0A=
the host. Each one is a request and an answer, so they reuse the packet=0A=
tracking added for control transfers.=0A=
=0A=
A bulk request carries a 32 bit length, so the host can ask us to=0A=
allocate up to 4 GB. Refuse a request that big. Do not answer it with=0A=
fewer bytes instead: the host counts the bytes it gets back, and it=0A=
resets the device when some are missing.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |  11 ++=0A=
 hw/usb/redirect-server.c         | 193 +++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events              |   5 +=0A=
 3 files changed, 209 insertions(+)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index 83c4524040..f7b2261db4 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -9,6 +9,7 @@=0A=
 #ifndef HW_USB_REDIRECT_SERVER_H=0A=
 #define HW_USB_REDIRECT_SERVER_H=0A=
 =0A=
+#include "qemu/units.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
 #include "chardev/char-fe.h"=0A=
@@ -27,8 +28,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
 #define USBREDIR_SERVER_MAX_EP 32=0A=
 #define USBREDIR_SERVER_EP_IN_BASE 16=0A=
 =0A=
+/*=0A=
+ * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
+ * This is the largest transfer accepted.=0A=
+ */=0A=
+#define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL_SETUP 0=0A=
 #define USBREDIR_SERVER_CTRL_STATUS 1=0A=
+#define USBREDIR_SERVER_BULK 2=0A=
+#define USBREDIR_SERVER_INTR 3=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -41,7 +50,9 @@ typedef struct USBRedirServerPkt {=0A=
     USBPacket pkt;=0A=
 =0A=
     /* Saved headers for the usbredir response */=0A=
+    struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
+    struct usb_redir_bulk_packet_header bulk_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 5005ea5f8a..a733a007e3 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -356,6 +356,52 @@ static void usbredir_server_ctrl_status_complete(USBRe=
dirServer *s,=0A=
     }=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_bulk_packet_header resp =3D rp->bulk_hdr;=0A=
+    bool is_in =3D !!(rp->bulk_hdr.endpoint & USB_DIR_IN);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+    int len;=0A=
+=0A=
+    resp.status =3D usbredir_server_status(rp->pkt.status);=0A=
+=0A=
+    /* Only an IN transfer carries data back. */=0A=
+    len =3D is_in ? actual : 0;=0A=
+    resp.length =3D len;=0A=
+    resp.length_high =3D len >> 16;=0A=
+=0A=
+    trace_usbredir_server_bulk_complete(rp->redir_id, resp.endpoint,=0A=
+                                        resp.status, actual);=0A=
+=0A=
+    usbredirparser_send_bulk_packet(s->parser, rp->redir_id, &resp,=0A=
+                                    len > 0 ? rp->data : NULL, len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    bool is_in =3D !!(rp->intr_hdr.endpoint & USB_DIR_IN);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+    int len;=0A=
+=0A=
+    resp.status =3D usbredir_server_status(rp->pkt.status);=0A=
+=0A=
+    /* Only an IN transfer carries data back. */=0A=
+    len =3D is_in ? actual : 0;=0A=
+    resp.length =3D len;=0A=
+=0A=
+    trace_usbredir_server_intr_complete(rp->redir_id, resp.endpoint,=0A=
+                                        resp.status, actual);=0A=
+=0A=
+    usbredirparser_send_interrupt_packet(s->parser, rp->redir_id, &resp,=
=0A=
+                                         len > 0 ? rp->data : NULL,=0A=
+                                         len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -452,6 +498,12 @@ static void usbredir_server_packet_complete(USBPort *p=
ort, USBPacket *p)=0A=
     case USBREDIR_SERVER_CTRL_STATUS:=0A=
         usbredir_server_ctrl_status_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        usbredir_server_bulk_complete(s, rp);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTR:=0A=
+        usbredir_server_intr_complete(s, rp);=0A=
+        break;=0A=
     }=0A=
 =0A=
     usbredir_server_pkt_free(rp);=0A=
@@ -828,6 +880,105 @@ static void usbredir_server_get_alt_setting(void *pri=
v, uint64_t id,=0A=
                                USBREDIR_SERVER_REPLY_ALT);=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_bulk_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    struct usb_redir_bulk_packet_header resp;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint32_t len;=0A=
+=0A=
+    if (!s->host_connected || !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? (((uint32_t)hdr->length_high << 16) | hdr->length)=0A=
+                : (uint32_t)data_len;=0A=
+=0A=
+    /*=0A=
+     * Too big. Tell the host the transfer failed.=0A=
+     * Do not send back less data instead. The host would see the=0A=
+     * missing bytes as an error and reset the device.=0A=
+     */=0A=
+    if (len > USBREDIR_SERVER_MAX_BULK) {=0A=
+        resp =3D *hdr;=0A=
+        resp.status =3D usb_redir_inval;=0A=
+        resp.length =3D 0;=0A=
+        resp.length_high =3D 0;=0A=
+=0A=
+        trace_usbredir_server_bulk_too_big(id, hdr->endpoint, len);=0A=
+        usbredirparser_send_bulk_packet(s->parser, id, &resp, NULL, 0);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_BULK;=0A=
+    rp->bulk_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_bulk(id, hdr->endpoint, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The host sends an interrupt_packet. It is a request: interrupt OUT=0A=
+ * data to write, or a single IN request to answer.=0A=
+ */=0A=
+static void usbredir_server_interrupt_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_interrupt_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    int len;=0A=
+=0A=
+    if (!s->host_connected || !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? hdr->length : data_len;=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_INTR;=0A=
+    rp->intr_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_interrupt(id, hdr->endpoint, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -851,6 +1002,24 @@ static void usbredir_server_interface_info(void *priv=
,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
+    struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
+{=0A=
+    /* We do not advertise bulk streams. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_start_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_start_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_stop_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
 static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
 {=0A=
     struct usb_redir_control_packet_header resp =3D {=0A=
@@ -899,7 +1068,9 @@ static void usbredir_server_cancel_data_packet(void *p=
riv, uint64_t id)=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
                                            USBRedirServerPkt *rp)=0A=
 {=0A=
+    struct usb_redir_interrupt_packet_header intr;=0A=
     struct usb_redir_control_packet_header ctrl;=0A=
+    struct usb_redir_bulk_packet_header bulk;=0A=
 =0A=
     switch (rp->type) {=0A=
     case USBREDIR_SERVER_CTRL_SETUP:=0A=
@@ -910,6 +1081,21 @@ static void usbredir_server_send_cancelled(USBRedirSe=
rver *s,=0A=
         usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
                                            &ctrl, NULL, 0);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        bulk =3D rp->bulk_hdr;=0A=
+        bulk.status =3D usb_redir_cancelled;=0A=
+        bulk.length =3D 0;=0A=
+        bulk.length_high =3D 0;=0A=
+        usbredirparser_send_bulk_packet(s->parser, rp->redir_id,=0A=
+                                        &bulk, NULL, 0);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTR:=0A=
+        intr =3D rp->intr_hdr;=0A=
+        intr.status =3D usb_redir_cancelled;=0A=
+        intr.length =3D 0;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, rp->redir_id,=0A=
+                                             &intr, NULL, 0);=0A=
+        break;=0A=
     default:=0A=
         return;=0A=
     }=0A=
@@ -952,6 +1138,8 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
     s->parser->reset_func =3D usbredir_server_reset;=0A=
     s->parser->control_packet_func =3D usbredir_server_control_packet;=0A=
+    s->parser->bulk_packet_func =3D usbredir_server_bulk_packet;=0A=
+    s->parser->interrupt_packet_func =3D usbredir_server_interrupt_packet;=
=0A=
     s->parser->set_configuration_func =3D usbredir_server_set_configuratio=
n;=0A=
 =0A=
     /* The parser calls these directly, so they must not be NULL. */=0A=
@@ -963,7 +1151,12 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
+    s->parser->start_bulk_receiving_func =3D=0A=
+        usbredir_server_start_bulk_receiving;=0A=
+    s->parser->stop_bulk_receiving_func =3D=0A=
+        usbredir_server_stop_bulk_receiving;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 25219a018a..c9ab80c6ba 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -411,3 +411,8 @@ usbredir_server_ep_info(unsigned idx, uint8_t type, uin=
t16_t mps, uint8_t interv=0A=
 usbredir_server_control(uint64_t id, uint8_t requesttype, uint8_t request,=
 uint16_t value, uint16_t index, uint16_t length) "id %" PRIu64 " type 0x%0=
2x request 0x%02x value 0x%04x index 0x%04x length %u"=0A=
 usbredir_server_ctrl_setup_complete(uint64_t id, int status, int actual) "=
id %" PRIu64 " status %d actual %d"=0A=
 usbredir_server_ctrl_status_complete(uint64_t id, int status) "id %" PRIu6=
4 " status %d"=0A=
+usbredir_server_bulk(uint64_t id, uint8_t ep, size_t len) "id %" PRIu64 " =
ep 0x%02x len %zu"=0A=
+usbredir_server_bulk_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
+usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
+usbredir_server_intr_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

