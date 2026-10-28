Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86FD606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=G+u+1L1B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY6-0004qE-AA; Tue, 27 Oct 2026 23:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY4-0004oo-5g; Tue, 27 Oct 2026 23:42:00 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY2-0005d8-1B; Tue, 27 Oct 2026 23:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgHjspAKt/8a1Gc4IybAuAT3P7Tle0KKkqBA+97G3JjIdobf9xP79rAcC7YYzbWJ5pTbLs4loR9Qcxo7GG4AKeIsI2xf3rqeRzy0z+9QMpj7HwHa4fjvefK0OwDhs/EqC0DrZcjWjMErz8CDeGxMq5+cajS2x44Fe57Zdscyaldphtcj6+rgbORb3DndthUX3XabzFykPtd6aWyuH4kcpNlJEi0GfnhFyi2RpFnXZuKuuUFVfKoKHp43lLXb7YGdPgJ5XmEJyZx7Ri3Qqtb5H9rsHbJfeYGB2qzZ2Wpp0D1DmH/kJD6mpYvxTmFuXhmK0sRsHCTL65SXPumXmMuqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1ZVCZx1snsvOtYAw6qdLBzE62j+HLr/Knu/6YHxQEY=;
 b=TlSvFxFu8AXkFeuFgDpGFZn6whcLjRL9kEUOiki7om6j40puRya9IIk0HDWZ16QYwim3LeL9qX1UTk7+0LDiN9bo20yWLabZDK3lXWrkPbJCXQFQUENTGmAuRdP2NmlSs2IcoI+RPuHiMRplwuq7EvYfIjmoI+XQZyKIfCS8dCPNGzb4eIV9w0fSO0heQWTEmEG9M7T2gqO+kXygCtSgEpF/8bDnnKlMO4IMrnhNlqiVbzoTx9sspnnGZqF1z1e264sV9m50NKgWYmqZopvIXBViwgohZKCqpGdjhTXNg8EsQlsb1s+ivlexou5qtns/Bajz2E9jeiBbm9u/18iv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1ZVCZx1snsvOtYAw6qdLBzE62j+HLr/Knu/6YHxQEY=;
 b=G+u+1L1BoSv13qZWyVsq+ZsYQspa9ckupVtOuyE6dyMpSilmUf8DMD1B9US0zhxvSUR2iWtY7W+goQfAnqC2sa7myPBC30Ex771q95B9lfR3gugivROtQeKcqKbCAgclX2bF5vvEpjcMHFweu4x1SyLa1F/zGQJtFTN9CAcH1fkUxWO33VCFg9QCeOZ3IBbpdongPXJ3fKmJWIh5g5vRGrz/gAxuv2BBaSW5IlhKAjgoZZp9mJJxcQMslXJ4Mr0N+Hu+z1mSxotq21cgo9HX1TGfN/vaY6F40+B0eH67seGUnlmx9oSj2/3cgWu7STp0T/67f3fFug+9QkFhNJo9hg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SETPR06MB9120.apcprd06.prod.outlook.com (2603:1096:101:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Wed, 28 Oct
 2026 03:41:42 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 1/8] hw/usb/bus: Let the controller ask for the automatic
 hub
Thread-Topic: [PATCH v7 1/8] hw/usb/bus: Let the controller ask for the
 automatic hub
Thread-Index: AQHdZo4/eTRVuHgeREKvQrdpx7V0Uw==
Date: Wed, 28 Oct 2026 03:41:42 +0000
Message-ID: <20261028034140.367393-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 4f1c3a19-a0f0-42c7-3719-08df34a56199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|38070700021|10067099003|261021123027099003|261021121427099003|56012099006|261022105027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dxZV/542OXmakmWNj+wTKx2nUwroCOAVVn2XJQnNBtpCVz9SvXDPur2X8/PSmKiAgoEjPIuOaXanMb8Fse6tBv3oqELy3zPb9A12+MNpvdK8xch570QpQKeVlBbaLuNkx/h1Wu5RtYBtKgmYI9bCWFB/7f7hJK/2gzBnV4E28cs7YLPFuUbfrqc6CrryihA5BkGCdYtPxYluiQtb/ak3vQplXQ4Cw/O8h5K9qHmIFh8Fj4kOds43ajLr7SSTLYNJsMq6cZOrLROeSzUvuVo+ij5lNuRBSDQO5C10d1klyazOb5+RDqfSr0M698LZ9XeYKRd5TVBOOX9XamDIRCJGsula1kH9xCks8PM4Gv23HJ3RNHdsGUpUGQcGvANT7/FnpWeXp1oEHpmjM4R14pE4fqdOUB23J2e67tyDmfb7aLnXBRwVW/fbQZE2UNcZd8l9FqOQPEK/VUEBewYJIGpZOxEYobU/w8BilyLnLk/A1yA6zVAQeooCXhKSke6huDF5RY/7iVu7ogmzHy4TM6u7hcKy7m0vNL1sRwuYo+HKrU767DD7vyrLvRC1dWdk/VqX6DDS0FEud1L5zHm6pVHvcKFTnA0X2kbR0bcJERfTmlSvUw/YeTg6/tiuQPmGrHC206G7cqzzEzCLe5UZtv2jacdsJOaFWVulgwkVtQRBsJSvgZM7w9ciqZWORDSsis4ewFkHg3e0qbSsPUprx40l1wmS5V+G1FKCiHP4zVD8+5k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(38070700021)(10067099003)(261021123027099003)(261021121427099003)(56012099006)(261022105027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FluyVpGrD6dwQes/hmeV47wSEKyFtsz9LYPRxrjQ9a8MnZrFb2zN7d9bJh?=
 =?iso-8859-1?Q?ulQh85eNdTASKuj7uWjCptXsesOmAaeFdmGFeB0z/2cvMPA++kLrHR6hMH?=
 =?iso-8859-1?Q?r29jS5+h3z5KV7p7K8Z0+BQwB4wJn2zSVIFQETjn8zLldZE/nGWq01fPXk?=
 =?iso-8859-1?Q?Qrr2YlxhgNE2ezRExy7Wp19dtVrQe3CMhPLxUA3zqbXIoUFpgDknNqy+i9?=
 =?iso-8859-1?Q?A+mNiUGMfAC3JB0g3w1KmYdsEpN9H7yCRX2kKXouKXutU4cNvOnTTtWg1+?=
 =?iso-8859-1?Q?8AzOlQlrvW0vipa2nUL77bhyE23WkqxToxeVlCXVlWWDZfQ9rSByxPkVuM?=
 =?iso-8859-1?Q?UrMgjUySnlSmjJ1QPurwUQ+AaB0FtOMD+Uz0TmxD2I2XvEkN2Tlw8iDaDv?=
 =?iso-8859-1?Q?PfLeE0DsHOwcIr1OLNXtAOe7TjZXr+tNUcFoPSU9z0H5i+tl4LvVJPybUw?=
 =?iso-8859-1?Q?0EHr1z8IjiscyrTJVh2qiRArfmie6MfAp/FH0SFRCmhn7Yh5pDBSZPLcJ+?=
 =?iso-8859-1?Q?jW0hnSUuuON19lW+8fGKScDi7/jv0jenLACNWSbMrKrc8EE42iN0MqqDuW?=
 =?iso-8859-1?Q?d9fr4p05DammM4kaw7EDwOdqUiCJMW03aECu1oyj40qEMlAMXBDc+GQ1zx?=
 =?iso-8859-1?Q?MJKHESEvMNiMgBzhLfVA9xtkVZ5r1oOT4jF/nwBghlKC2IC+YDL3KvLn14?=
 =?iso-8859-1?Q?KKrDrwatFNYpV85Ny8cGPOO6M7PjaA3j13EUkp0HlVb1xK+aq+5npuvraR?=
 =?iso-8859-1?Q?Ny//O46dXnDzVlNxKYQHNF4PguPqzLiivUPKMWQOMjKftek9jysFhupPnm?=
 =?iso-8859-1?Q?Nv+csNIvEAOJItBZNboLE6t224jRY0ulvLjywCPpSresgFi9rd3dZkAKzD?=
 =?iso-8859-1?Q?FriWaFP0jEXt8z+i7BCAXYL/ZUpGdCPbVXS+k6wEW1IsCXlB8A+DBGo1/S?=
 =?iso-8859-1?Q?WAtrqtVxmo5X62b6XNL/vhBtRRu6RbWByW2yTwdpnB4vKprTk/mOfXaFtL?=
 =?iso-8859-1?Q?h63M4Blz/i7zzuWgct7C9ejTmvn0dNKwPdH1WemT8nA+xUT5o++8yHvFMY?=
 =?iso-8859-1?Q?wSzWe4VkQryTq/+rjLw/DHNR+1knGtsitJxR7oItGpy29mPgmvIpx7QxKe?=
 =?iso-8859-1?Q?d1zckR58v5v9Pho2bpngE19vg26nurRKWVMhIUB/nhRCa3deP+04ENMSf3?=
 =?iso-8859-1?Q?XAyactfCE3oX3PL4iZ6RBnvv3bALHrTmFSfHeWrYT+p+PtZvsiDU/RxqT9?=
 =?iso-8859-1?Q?AY7+pBWQ/bpcv8w2H3JLaHfog7OaOqU5L+XMwGWqA+IJ72jW9HFHWsjQ2y?=
 =?iso-8859-1?Q?n8R2qbAwpMV3PXOLdC4JJLBHFvRDvWCAJP+x88L7iO14d7aTcPP8nupaC4?=
 =?iso-8859-1?Q?HTjjXfpTC1YozajBfqNdkfONlv4QRthZRLba0KFwXRRgkYUHaxX85axPZa?=
 =?iso-8859-1?Q?avAuVVdQEE2dsBG7D6x2n/Kc0ZoaXz1mJf4CbluwCLcn4Q8lRf8GC2VOja?=
 =?iso-8859-1?Q?orPUVEjrcrxF/wWWq5+lJJyy6ju8WnVOgC1xPE0Gf0q0h3ArCrp17hE6xh?=
 =?iso-8859-1?Q?vY5s7HO5jjWGXutL7e8IsV/YMPw+XhZUcNUInOXLRFAEGZXiZgM0ht64Zt?=
 =?iso-8859-1?Q?ZY9OoKij6xyqSGShIKEaNwSZpw1IhEvdX6LPBI1Kc8AZUlYjiXkprYhr+y?=
 =?iso-8859-1?Q?kodmvpRhId27PHoFbwO8KQFEz3/zd3soJ02cAXis4sUiNcNTsT8+ZeRXXl?=
 =?iso-8859-1?Q?ifHBkqwgdA+UCm2u3jULtvXJ+Z8mv8sACo/aGyT/BYUzW9ZG9B2wRot2MU?=
 =?iso-8859-1?Q?Bt8hya376Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1c3a19-a0f0-42c7-3719-08df34a56199
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:42.1312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFLgVeUoD8x2pumRbDv7M/DO29IDa3OKEEpFhy8AlE/MN5E/TCdGn+OtzvZSbyKIXqRgGbhN2TptuFT8fkLQhCCbEhou6jD+X/ZZEPbj3p8=
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

usb_claim_port() plugs in a usb-hub when only one port is free, so that=0A=
more devices fit. Every bus gets that today. A controller with a single=0A=
root port then puts its only device behind a hub, and a transport that=0A=
carries one device cannot use that.=0A=
=0A=
The hub speaks USB 1.1, so this belongs to UHCI and OHCI. Add auto_hub=0A=
and leave it off by default. UHCI and OHCI set it, both when they own=0A=
the bus and when they join one as a companion. dwc2 sets it too, so the=0A=
boards that use it keep working.=0A=
=0A=
xHCI has up to 15 root ports, so it no longer grows a hub on its own. A=0A=
user who wants more ports there adds "-device usb-hub".=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 6 +++++-=0A=
 hw/usb/hcd-dwc2.c    | 1 +=0A=
 hw/usb/hcd-ohci.c    | 1 +=0A=
 hw/usb/hcd-uhci.c    | 1 +=0A=
 5 files changed, 9 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..cc1d6d74b1 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..d1ad22ac94 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -363,6 +363,9 @@ void usb_register_companion(const char *masterbus, USBP=
ort *ports[],=0A=
         return;=0A=
     }=0A=
 =0A=
+    /* Only UHCI and OHCI come in as a companion, and both want the hub. *=
/=0A=
+    bus->auto_hub =3D true;=0A=
+=0A=
     for (i =3D 0; i < portcount; i++) {=0A=
         usb_fill_port(ports[i], opaque, i, ops, speedmask);=0A=
     }=0A=
@@ -413,7 +416,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && bus->auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c=0A=
index cd3b61158d..104f493105 100644=0A=
--- a/hw/usb/hcd-dwc2.c=0A=
+++ b/hw/usb/hcd-dwc2.c=0A=
@@ -1354,6 +1354,7 @@ static void dwc2_realize(DeviceState *dev, Error **er=
rp)=0A=
     address_space_init(&s->dma_as, s->dma_mr, "dwc2");=0A=
 =0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &dwc2_bus_ops, dev);=0A=
+    s->bus.auto_hub =3D true;=0A=
     usb_register_port(&s->bus, &s->uport, s, 0, &dwc2_port_ops,=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       (s->usb_version =3D=3D 2 ? USB_SPEED_MASK_HIGH : 0))=
;=0A=
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c=0A=
index 5e5fe41f47..d6b1fc5b62 100644=0A=
--- a/hw/usb/hcd-ohci.c=0A=
+++ b/hw/usb/hcd-ohci.c=0A=
@@ -1987,6 +1987,7 @@ void usb_ohci_init(OHCIState *ohci, DeviceState *dev,=
 uint32_t num_ports,=0A=
         }=0A=
     } else {=0A=
         usb_bus_new(&ohci->bus, sizeof(ohci->bus), &ohci_bus_ops, dev);=0A=
+        ohci->bus.auto_hub =3D true;=0A=
         for (i =3D 0; i < num_ports; i++) {=0A=
             usb_register_port(&ohci->bus, &ohci->rhport[i].port,=0A=
                               ohci, i, &ohci_port_ops,=0A=
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c=0A=
index a7b9fe1317..f11664bd55 100644=0A=
--- a/hw/usb/hcd-uhci.c=0A=
+++ b/hw/usb/hcd-uhci.c=0A=
@@ -1213,6 +1213,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **=
errp)=0A=
         }=0A=
     } else {=0A=
         usb_bus_new(&s->bus, sizeof(s->bus), &uhci_bus_ops, DEVICE(dev));=
=0A=
+        s->bus.auto_hub =3D true;=0A=
         for (i =3D 0; i < UHCI_PORTS; i++) {=0A=
             usb_register_port(&s->bus, &s->ports[i].port, s, i, &uhci_port=
_ops,=0A=
                               USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);=
=0A=
-- =0A=
2.53.0=0A=

