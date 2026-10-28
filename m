Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12D606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=D+yWugsF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuYA-0004tB-H0; Tue, 27 Oct 2026 23:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY7-0004qw-Kh; Tue, 27 Oct 2026 23:42:03 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY5-0005d8-9S; Tue, 27 Oct 2026 23:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc/K4RNUDRP1tGKJacQXnWWhljMiRneUGTnucmv+U/mM2AMGXlzNpcGHW9wIKwqL89OrK8eEsBom7XgCespvyxLJy7RojPrASwxg/f05329huazaYheXbjehzRGoCXpTt8AlQWpkkfp2M/mYhla7+WM31lRiXtiBbQGqjeavHSwfeY9JDLKxwd+9sVp8yVFmFtYIq2FeQPH5AnRjWBT8f4qcLxAzfAo/JXgkg9a4yrpbfmN6jaCCh0vg3qF0AI4Izu0ohFyzE1WuMMwr+zb/rQxX22XsgZEK/5NEBsE5PnPrN7rBAn9tpJISUCa1vNGk92yEW+4J2hMf5r1uWBrqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71XwDHqi9NFG+sNpI1jGZH9W2OkRvy9YfjzqDPzsptc=;
 b=QKqv5faSGQJnANgGdXxNb7CcO9u4WEkfTxbALzgd39GyElZk87E/lJcgCBJ79I+4RsCVoNLHQB3UErmln+BsS7fE1DG7UxyygST48EbWk4aIeXyUSq9PhE/0qd2dTmgp1dw9IwHkCYI1XOQkRCoEpIcYSF/JMg2A2BBS+dlXQY7940LFooRjevNSITH8BakZnvLteqQizytPn0YO8N2iifwb90k9nYPJrWjsVrWkZTwY75qo1EV51ldbAfEhSbaHjab7O6PUQlFmvRFydzi+XkJL+SWbzd1DNm6ht+I9uo+ti/V4YSk/8Kj1FJGwKNKYb886PDB/luyO+RgfScnzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71XwDHqi9NFG+sNpI1jGZH9W2OkRvy9YfjzqDPzsptc=;
 b=D+yWugsFbGOycCXVwYx7a1K/u0LoB7KQcx4HYmz/msEGCSFplXjWmfoKJz382rK5DDzQKjjYHnY7VBu85K2aV90AYOFt7jgytyIg75JOtTN9fbk1IIYS3jkwOsnn1TvOR8vdSUm52LFLBd3tZqfzmZPk/AT2xwUgC8EN/Jga3qpb9WlfANVkrcS0AnVN2DugMv8KHNtDoYGhcyfHOcufo1/ed0zFfEdt1AYp0ZYGzvGiyJrgc3hiTa9wZu8utbR61b2lmuoHhlaWLHxhrw+mN59bk6IW9t1GsKKX8JXDJ3fJmtExH/WI4alm/ogHCpjxc+9iQK//YslFPzbYYEZgmg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SETPR06MB9120.apcprd06.prod.outlook.com (2603:1096:101:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Wed, 28 Oct
 2026 03:41:45 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdZo5BumtgaWGS+Eqi0U9La8Z+aw==
Date: Wed, 28 Oct 2026 03:41:45 +0000
Message-ID: <20261028034140.367393-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8da34407-277b-4e17-49ee-08df34a563ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|38070700021|5023799004|10067099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|56012099006|261022105027099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info: nq0TGJeF4gsfJ13EgKADLMUgf2iNopSCdpyxqocQTbVxZV1991SXdwKYrDCH4ZvWeM8IJgg9RoVbK5G6s0N5yYHRfbqHstkwNONrijWurePbuVZgvAYZFwR2XPSsCySCquE3QZHSwGrDuiAEPkx32yqr5TF2Zx8xdRg5DipDXATykpxhLIc09KGok0LJ3we9lSybjab5IodDalAxOkVGsUFSA0g6gkwSclrcN4GeFPx3pnxqmr1h/GHFQ/La+6Mb7N5DVkxok67hzW9bK46Itb4K7dXKKtZlMzGivAqvnM9l3xnEjyKXOrKEoehcyFZYtVbpBBxzbbH6kTwUr40RvuK+Vw0sMLdmp7BeZdLCwzC9Hpj129h4jl1xi1V4I1QRTAPyr8cWlSXCO+N/k/rJ4OL2puzxtrHF99L6Rpj14KAnfkL0cCjr+88DcFZVBRB8eY/5bSLKTL+lbqlorvTUZgcw/bBITsiBh57MhFJ6TV33Oa0H8JP2FusLSKDnpG7eF6p1T147nd8oZPNFbsmHHOp29YPA9GIr+z0MutSu4gwclgMVX6avcUfOyZ3GQcD60EHGgOWs0S0P32Pyk4ieHcl1UeqUGC0Xj7Oo9iaXOE9ZzFon7rPamu+9dJ/oH6Y3dt/fu4slbdKTVud2k5fTQhkIuf96Zcl0GE1uJMA1FTVYHXCPQkkMWziWbGOdSq/igw+1+ZzNORUR+zA5aCfPe3KiPscrT2pMTDJCYHgjLL4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(38070700021)(5023799004)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(56012099006)(261022105027099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lDvKnMpSkauSKtYxX+K0K9krl4AYHsSXNSI3a2ThgmCVhRXdbDLi1YmhgV?=
 =?iso-8859-1?Q?XG6G4fSGkKHlqPnkLgmKHUKPd+42g/hF98b1DjOMNN/+GISbFMUOV9f2HP?=
 =?iso-8859-1?Q?tVNApYxMvHQyyfDG+69tkv2BSvfORU/n3VZdH+yFO2JZ9xgCSj36gMtyuW?=
 =?iso-8859-1?Q?g/9kcIsQOSZQ0EK0lP+7BEgv3QwaRfp3HeDulPCRwHH8t7QNqHiRSAtv4c?=
 =?iso-8859-1?Q?U4Jt2uoxfHCb5Ar8+ZNqXkOxr/KbyxKnPgLPYZKy4fefGJPlcYGWQg8IlC?=
 =?iso-8859-1?Q?Tf1QWyH4Tt3zrX0/7Fta6RWX5mG6MnOJUIyWJPOGVqOdijpq3m05HVV2jP?=
 =?iso-8859-1?Q?4F/38DLGfBTg9j5lT2I0os2lHwtj1D8OaGlyDRks74tqlcmh8vA4t4vqux?=
 =?iso-8859-1?Q?Il5zvhrseQqlh28c3ws/M26tGC16N0a851biRPjTVY0zcvRCCTV5J8SMtK?=
 =?iso-8859-1?Q?YRKWq1yzxeCpY0dPhcSOC+7FSuJVyIhFdAR0aOlQ4zduMSLf0VXIXn59+w?=
 =?iso-8859-1?Q?woRzYXyf1stmWrUUR4atcKVdCymfm64RdoQhtPQ0z2u9GikAZJQ3+KZq3l?=
 =?iso-8859-1?Q?sKNHx2utvkRq9Ho70cPG4neVF6e7alsk89bfMk7sdb17G3UrYuF6EIC+i9?=
 =?iso-8859-1?Q?7l3Kg4aNY7EHFMPATjVGNlMsV5wbZJu6XsEy52KcH1jp+RrskDthHIB0F5?=
 =?iso-8859-1?Q?3LZXrpwG07TS0rjYBMg5UNLng56pmf/VFbdAEydhPnheMDO2G/xzDjnn5q?=
 =?iso-8859-1?Q?dqyhuznzR3/7FrsEpRx7ZKC6SYg1JypMdn6y0rr1rjwuVEDbmem03mhdSg?=
 =?iso-8859-1?Q?ga2a3CCKMjtCYtV5Gzlofy9N7N1snhuIrVvM7py25zsR7Mr1tVwybKdHQ4?=
 =?iso-8859-1?Q?x6GqvPhYE7/oClSxhm6UwLlZ/L+PA+iC937MZXELJ5Qiu7HHCJnRTzqz8t?=
 =?iso-8859-1?Q?D7x4trX3Jjby+7XQFsKgYXMOqIXvpm0jnLfoe6uWxxh20sMpr0yC2P5ROh?=
 =?iso-8859-1?Q?/bsJi4XtYTALGaBRZGNshCKTN8pJrAMC+rpSQfo2tHcH7UlNBhJ4Y9bFWx?=
 =?iso-8859-1?Q?jJeR4LltFfuvz9TlcQSKbrZJyboKJ0COQpoK4gVaW/XLRS285/BwXewQLM?=
 =?iso-8859-1?Q?IVtnKE5azvT6AhC8RPf1GfM7upgqQmcG24DY4KRV6vFx8KHkiUMrpeQcXV?=
 =?iso-8859-1?Q?OjsTAcX3pyvcKi5n7NIkvsetw7GaEf6ByvOewAcgC6IZtbmyOQy0B/A5SW?=
 =?iso-8859-1?Q?Mys33GfEJaGM5JQ04FlwnJDB7hPZGw6gO+qSIbaGRxORZxS4WIVo5JKEob?=
 =?iso-8859-1?Q?cQDdixLydeH7fHTctS13NRPose9LVBctFrrJmWZnwZxarJSbqUL3CgYKvV?=
 =?iso-8859-1?Q?02gZXY3T6B803hJu6WiLOuZLqjhYbW9qiQj+XrbIi8x0ogM6wcTjgWa2YN?=
 =?iso-8859-1?Q?6xsuQ4Xy0PPCgSlkuZhbTZRKSNv2gs79tUQTgPaZV21qah/Tsbkjz1BnuR?=
 =?iso-8859-1?Q?DXBMojV3bov0wih0gX4Gff9GJoPHPkdswDjQvnzUz91g8pe/w+Nxpetvla?=
 =?iso-8859-1?Q?PB4Ty9suXx3wBB1YFBuI02mEHHIoz01kfbneuAFXRqDLvJbVxUWVgKHx37?=
 =?iso-8859-1?Q?8J8Y9Fix4AU1ftLw2ydc3DWtVOC5Nd9VZemBBx9dn7y2NNknTZ5dRe2rwk?=
 =?iso-8859-1?Q?8SH278d+5gv2QVC67IFjA10mosDXX5V8undFscF0aW/0vGHEzAnc0XDB6B?=
 =?iso-8859-1?Q?qL499LsHNlTppowKa9rdCCsTqjJea7y8Yu3TrTx8oZa/4JUS6N8l13dDfC?=
 =?iso-8859-1?Q?QlXLIRTQww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da34407-277b-4e17-49ee-08df34a563ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:45.7917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbkmCa3jHoV9M3SkgKwAcrwYd56IQAMgy2OGgItaegJcUOM159cqsUydpCVm8Y87VMKaZSYpd75xSSlwNh9TnUoKSt8DU8v5HjXAOuMEZ8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9120
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
index 4971d81af4..ad6e4c422b 100644=0A=
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
2.53.0=0A=

