Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06357CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFw-0003iF-5r; Sun, 04 Oct 2026 23:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFu-0003hj-6a; Sun, 04 Oct 2026 23:20:46 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFq-0000RH-Nb; Sun, 04 Oct 2026 23:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUEz6KlF9X4TZ5rHmCxk2vmIAD5vvZms08Wn+gVEw4fWwkdKlpaUnhsPm41Ru1ZmoEd037TSEmo4CPx1vaLboQ90Xx45Vdnbn9hxIAr1U1a6bIqBTHGNTOQUPgjoZ3NYdZ69G+1rlE5000yA+zLmfB7WHx68JnpJFmMaLu8OY37FULJvMMyNzhFcM4HHDktX6vJmOrrGNXzTgFHteCRU+cUHMYW3pGTstjmuOKDaWISCbs99kE0BsqN9a1wyNiR3q10HXHPoGm31V6lacCd45d2z7G3WrX5HZSzcGD45mTJa2KYVmZkCikz/qMj4kh6kXtkNu//NqEb3h09Q9zCzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC7d1oMA70HP5r3a5ViSsW+Sv2OUsxm6UN4cw4bobKI=;
 b=Zjcp+I1l9+UG81aOaOcd5esmGrCT1TZ+UptuQvLd43DWn1oVbDmyi+4l1tdpr/N9PdT84u0FlwGqapLqzfgrPevwMIC8oDoW5wBhcaABFPNDttBcklkNYiWftsj5ZIIj5XfgZdILzWim+Tfpcyr0dyUrxze0RG599Jhqrpu/QCcnnDF9fxQ13jBJNsvCfyxh9WuYr4Fzl5XPB5SwJ16cQaK8YxPo+aHUr6aMNSrfRd8e8TbVeCou+j3VFJHacnfr4OBDZ2+/jcWvGrmHrV5uQCyYLQcOKD/hGl4L9QJfbS0QGcbpWuJUMdHsoqViX92eG6C0P/7MEBs3J65tSx1j3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC7d1oMA70HP5r3a5ViSsW+Sv2OUsxm6UN4cw4bobKI=;
 b=ee5pKnj6UXydNb50KOcQnXr3Qs9N+OuchCqVq8tR18VaaUWTM5Ul5GA69jHj/eAiOFbn3qwHTjITCsLEsu+0AQ/g9dJqJU+9cPEUwRdhyOmQOOmAco8zWsMijuIYo7EIwQ5z94Rd9Oer0s7GImla3piu4hkWMEMN4kZpvnYzqw8GyBoU+OShEyI4zJ+gms1NgFCrH4mriBINIUeSk6qNB5rDyJFGgMn7H8OT3Dw6/vBQeQPH56gEyHw+VQrrB6Oqrk88InKQT7XWyomGBSCNVXTCh4Gek2PmeCvYnD55wrGiMiGsn3m4LV3o/anKwfD4sPt4WLb7Pgxp4lk1obD4EA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 5/8] hw/usb/redirect-server: Implement control transfers
Thread-Topic: [PATCH v2 5/8] hw/usb/redirect-server: Implement control
 transfers
Thread-Index: AQHdVHh5wzLc7FY22kyUozKR/oE43Q==
Date: Mon, 5 Oct 2026 03:20:30 +0000
Message-ID: <20261005032022.3980903-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6e82a1ea-5a5d-47a2-531d-08df228f9c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|5023799004|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: ttoO0sE8Gg9Qo3c/Zj3RpJ4eTJNZ0BVWS5PDZq34KA4EZsjUYH4Xat2sKB8Y9FS7oMgrrznlIbfbI8eUM53TDPjtNU3eLtjZlGLFq5sC5Ke/91hE2cFqSTGPM4r5qTtyA/Y/2tBFm0jl+NByBUgMXDUW1GJGPgWBcOX7WvuDZeHGmOohRAsbK/ymAl9jRZ/PixGgJSHgbFPmbER4bU5c1pbASBq+X/54OJHcm5LWOTo3QWDnG4GX/J2asHogmA091vZaDWCdr1SVphIV6qpAwZE87RkccPSBxbS51hYPoN1Y3RYjdVzUL+2+IfchSn7LBSVm1VkIN3ahKtJD4Z1BMQ7E/WKtGqI56Iy8+NKVnnmvSVD0CXQyn3jCiFlVRQ58xWQq7UqcXQEbyQGHqs+zZoOlqsr5uwltXkjU/yTjr72ZQZphyObW0VA1TSlO+5dynsaXM2wSNNTcxQrL1ZpeB4GteYLR15Z26ZOt/MszdGYnHLf97YH/UTtySPfkol/Za7fYateQzDt1ypd50CChkj4TC7B7hw1qRLMpl00+Jp0VYxEHrfZGq9xbN7/X3EaJhFmH3UTY0DCkglR/HDtjimOQ4Crl0yxN/9OptCnOhZNXJKo5otCHv206ChW4Y6jJLMA07k4YEMdWyYVEEGvgNFF3h9wewpKehQvofQLyl5SrDqKE7OAnenOe8Q+an14vHDywFQj/KBQq71cGEoAkvu66MAMiKCiln9oYk0xBgZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m9vFsat0PVrvAGD9PpBTaKnz/slv2LNDQZLUSN82bzBRmhAbbc6VtK3WYs7p?=
 =?us-ascii?Q?ra282iXIXwFehy6LPjGJ+2lX/h12QBc5oMM4r9wXByBSqboe9AAQEBtmJ5js?=
 =?us-ascii?Q?kboijXNk0bEYoBj2YZoKcZe+LIwjYRim/jA4HNJR5xCzw81lR51Rb3wagMKF?=
 =?us-ascii?Q?RUt/YKF8z1vEnJmIuBPiU8oxZGQ4OScqPp4yQM6LkOQw0fJhULfbtbpmVCLJ?=
 =?us-ascii?Q?a5RDv246zxvuss+m1mVf5Vpm6qyQ6elRNYTbzCBH7mJbBPA78jPYRbQfuvaJ?=
 =?us-ascii?Q?fpaZ4rwdWCOFtiIAkNQ5v6sXXwJsCqrkGdslKI8b9Y/M6bzaLMKLcQ8IUikZ?=
 =?us-ascii?Q?zikoAR+dmbwhRg8jIoKcyzsaGknEQwYDEkvKCQcsXIOIR+jiKw4Uoq9BJhB5?=
 =?us-ascii?Q?jwRbMKUVvjoXuOhyowLczBCDbvTMMvvzf5CQE5GcnccpSOjROSLkCLLQ9VP4?=
 =?us-ascii?Q?INlWq/B/WFKYjuVMBcNWAIgREFKQQN3A5Ps7T0/KkxLu7vH+/8lnCJSdnegC?=
 =?us-ascii?Q?ziK4AhsroCD6v8ohgt0EzNao/pCyY8pROjBMWe2X5b8UIGuZw86zoVGjRunH?=
 =?us-ascii?Q?beNv1By3iepk4uf3IEniM9rGF7WcAJQl1GWNlQHkNoQSRG/DEaGjGPTyleu+?=
 =?us-ascii?Q?RVId3u1cuCE1hw6frYFyaBh15c6rv26CZKa7ubu0CpAQViQlo5tigD2wXp/O?=
 =?us-ascii?Q?IA/dTMGaBqOf/C+GCZYZ1G5Aj0o1xYXLjONRSYGZr13qfNMaH54gwvWDEJxD?=
 =?us-ascii?Q?4PoGwO5BVq/MC3ZXkXwZp4QfVlvV2czQb9RhEIMj3uEuHP/vJ6OA2wLanTiK?=
 =?us-ascii?Q?uyIhXi3T/+VRnURLvpOwPPIbdIhPzQwEbQTXT5Q/C9XIoSxhjhMNMFhyPAov?=
 =?us-ascii?Q?B8gpxGuJ46bRMTD+wxP+nqUlRSe66teZ3SgExjGFwtzcKJ5I3ae2dPXPILhT?=
 =?us-ascii?Q?nW7MffC7ujaC0uT+wQfGPNUps75r4ToJMLUojPnOJeM0HIHRlIgDOcwpec++?=
 =?us-ascii?Q?Pmd6eerOG92tYFmLSqM+ZGBqGWE1dlreKQA/kkYYLKyXYqOxZ8ZRBetNQNPP?=
 =?us-ascii?Q?4jO2JnAEMSilATV3d6ldjEjnbGB3xeoqHjMHnC4OoMhZPySttlGA66P4sRdx?=
 =?us-ascii?Q?K9Labn2g8aBzDJuPq3/j9A2m4qYHyWOaM7v5GM0Jr2Wx1Q26LYEfIMD97DGv?=
 =?us-ascii?Q?+OOo54TTLxD80dkQEkLvNFCK6zRkEJLt5bG/laNGwN0VyJ8RLEGQo15PbiXR?=
 =?us-ascii?Q?082tID8+dA430nxVD5gt7uhvIEWF9BtUWpTgq7MmBukfDoZGUw1JxczIkvBQ?=
 =?us-ascii?Q?+uGQf19+HJwuJpg47yOG5asn0VfK1RQCAjC/yW2C6ruZykgH0UpmHRdzkcFn?=
 =?us-ascii?Q?WmgFDcCDf7/CWjRYyHQVIXOO3Lo6EDv2oxwGloF+5dJEcxlR/VSRkdSzB8K9?=
 =?us-ascii?Q?rW/Tlkzht86JWC8VL7Ql+qmcwcHZiz2Hj6HQMUG+akY8j3GA9n4SPFBdONAs?=
 =?us-ascii?Q?2kPjfy0TcWxYolfxxGS93+b/u9wfzySrNbH6wHkNGryHyM8g/oqIHzs3YXly?=
 =?us-ascii?Q?WpMEpCmlythGwTzCihwQOP/NK4vflcfcZbgzWuA8DUsanL509YoSdMCzo79E?=
 =?us-ascii?Q?ZVWm199DpaJ1ibt5fJbRmlwbcX4Qdq/X8hs51sDmqogajegyefy0SKble45A?=
 =?us-ascii?Q?gCGMvHd5PXV4HIjaSt9jdvSYUDAI+BmBdKeFy6RffPbtTqOGXoZZmzh2OGmu?=
 =?us-ascii?Q?9jj3XLQPrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zWM/Hl/P5sVOOO8f5ml7McAf+3MmonvC9CVmBtqDrNeo9D1Rh8au+qXv/b4Vfilo3dUtBH1dyreDR7vZAq9hveuA2z5MTZKgaHaxInqgc3k2qzvWQeOgh+arYKXfkSI+SgWXgnM8HbCVFwA0SHe1bFhgQUBksP9V/bm2G7aF/QfPi65AlE/YMYsrCKkbs5p1XxtjKN23nG5AKued/wZwFsIThHqzMMmcXpp66VKAdcaUGvMDDPcnolvO++vpc+9SonWXqcB8RXa9voErPJ4BE68B7qOD+VvI2W2jVFE7O2/3TUvFHrSvAQnYKc90L9XdeDQo6/cTz7v/sAroSHzrQA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e82a1ea-5a5d-47a2-531d-08df228f9c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:30.2977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWpeJbTzlHBi7dVqC6WIColCPfUE5yReG8BaHeFWUZWyHrNx99VnlpuO3glG7Rbq7sSnEALS65EzBiY5Ac0Jta53OVSSxiX7UoXaldT+HRs=
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

The host sends a control_packet. Turn it into the SETUP, DATA and=0A=
STATUS tokens the QEMU USB core wants, run them on the device, and=0A=
send the answer back.=0A=
=0A=
The device may answer later, so we have to remember the packets we=0A=
sent. Each one stays on a list until it comes back. We drop the whole=0A=
list on a bus reset or a chardev close. When the host asks us to=0A=
cancel a packet, we answer it and drop it.=0A=
=0A=
usbredir has its own messages for set_configuration, get_configuration,=0A=
set_alt_setting and get_alt_setting. Each one is a control transfer, so=0A=
run it like one and send back the status message.=0A=
=0A=
usbredir wants an ep_info message. It says what kind each endpoint is:=0A=
bulk, interrupt or control. QEMU cannot tell us. It only knows after it=0A=
has read the device's descriptors, and it never reads them for a device=0A=
that just forwards transfers. So we read them ourselves: the=0A=
configuration descriptor passes through us on its way to the host.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |  46 +++=0A=
 hw/usb/redirect-server.c         | 603 ++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events              |   5 +=0A=
 3 files changed, 653 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index a3d5084424..83c4524040 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -15,10 +15,46 @@=0A=
 #include "qom/object.h"=0A=
 =0A=
 #include <usbredirparser.h>=0A=
+#include <usbredirproto.h>=0A=
 =0A=
 #define TYPE_USB_REDIR_SERVER "usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
+/*=0A=
+ * The usbredir ep_info message has one slot per endpoint and direction.=
=0A=
+ * Index 0-15 are the OUT endpoints, 16-31 the IN ones.=0A=
+ */=0A=
+#define USBREDIR_SERVER_MAX_EP 32=0A=
+#define USBREDIR_SERVER_EP_IN_BASE 16=0A=
+=0A=
+#define USBREDIR_SERVER_CTRL_SETUP 0=0A=
+#define USBREDIR_SERVER_CTRL_STATUS 1=0A=
+=0A=
+/* Which message answers the host when a control transfer ends. */=0A=
+typedef enum {=0A=
+    USBREDIR_SERVER_REPLY_CONTROL,=0A=
+    USBREDIR_SERVER_REPLY_CONFIG,=0A=
+    USBREDIR_SERVER_REPLY_ALT,=0A=
+} USBRedirServerReply;=0A=
+=0A=
+typedef struct USBRedirServerPkt {=0A=
+    USBPacket pkt;=0A=
+=0A=
+    /* Saved headers for the usbredir response */=0A=
+    struct usb_redir_control_packet_header ctrl_hdr;=0A=
+=0A=
+    /*=0A=
+     * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
+     * Allocated and freed with the packet; data_size is how big it is.=0A=
+     */=0A=
+    uint8_t *data;=0A=
+    int data_size;=0A=
+    QTAILQ_ENTRY(USBRedirServerPkt) next;=0A=
+    USBRedirServerReply reply;=0A=
+    uint64_t redir_id;=0A=
+    int type;=0A=
+} USBRedirServerPkt;=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -39,6 +75,16 @@ struct USBRedirServer {=0A=
     guint watch;=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
+=0A=
+    /* In-flight packet tracking */=0A=
+    QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
+    uint64_t next_id;=0A=
+=0A=
+    /* Endpoint tables for the usbredir ep_info message. */=0A=
+    uint8_t ep_type[USBREDIR_SERVER_MAX_EP];=0A=
+    uint16_t ep_max_packet[USBREDIR_SERVER_MAX_EP];=0A=
+    uint8_t ep_interval[USBREDIR_SERVER_MAX_EP];=0A=
+    uint8_t ep_iface[USBREDIR_SERVER_MAX_EP];=0A=
 };=0A=
 =0A=
 #endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 824cd274b8..5005ea5f8a 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -61,6 +61,7 @@=0A=
 #include "hw/usb/redirect-server.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/qdev-properties-system.h"=0A=
+#include "desc.h"=0A=
 #include "trace.h"=0A=
 =0A=
 #define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
@@ -68,6 +69,11 @@=0A=
 /* Wait this long after attach before we announce the device. */=0A=
 #define USBREDIR_SERVER_ANNOUNCE_DEBOUNCE_MS 10=0A=
 =0A=
+static void usbredir_server_pkt_free(USBRedirServerPkt *rp);=0A=
+static void usbredir_server_stop_transfers(USBRedirServer *s);=0A=
+static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
+                                           USBRedirServerPkt *rp);=0A=
+=0A=
 /*=0A=
  * The device is whatever USBDevice the user plugged into our port with=0A=
  * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
@@ -78,8 +84,97 @@ static USBDevice *usbredir_server_device(USBRedirServer =
*s)=0A=
 }=0A=
 =0A=
 /*=0A=
- * Device announcement=0A=
+ * Descriptor snooping and device announcement=0A=
+ */=0A=
+=0A=
+static void usbredir_server_record_endpoint(USBRedirServer *s,=0A=
+                                            const USBDescriptor *desc,=0A=
+                                            uint8_t iface)=0A=
+{=0A=
+    uint8_t addr;=0A=
+    int ep_nr;=0A=
+    int idx;=0A=
+=0A=
+    if (desc->bLength < 7) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    addr =3D desc->u.endpoint.bEndpointAddress;=0A=
+    ep_nr =3D addr & 0x0f;=0A=
+    idx =3D (addr & USB_DIR_IN) ? ep_nr + USBREDIR_SERVER_EP_IN_BASE : ep_=
nr;=0A=
+    if (ep_nr < 1 || idx >=3D USBREDIR_SERVER_MAX_EP) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep_type[idx] =3D desc->u.endpoint.bmAttributes & 0x03;=0A=
+    s->ep_max_packet[idx] =3D (desc->u.endpoint.wMaxPacketSize_hi << 8) |=
=0A=
+                            desc->u.endpoint.wMaxPacketSize_lo;=0A=
+    s->ep_interval[idx] =3D desc->u.endpoint.bInterval;=0A=
+    s->ep_iface[idx] =3D iface;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * A device that only passes transfers through never gets its endpoint=0A=
+ * types filled in: they stay INVALID and there is nothing to put in=0A=
+ * ep_info. Take them from the configuration descriptor as it goes past.=
=0A=
+ * Without them the host sees type 255 and refuses to move data.=0A=
  */=0A=
+static void usbredir_server_snoop_config_desc(USBRedirServer *s,=0A=
+                                              const uint8_t *data, int len=
)=0A=
+{=0A=
+    const USBDescriptor *desc;=0A=
+    uint8_t iface =3D 0;=0A=
+    int i =3D 0;=0A=
+=0A=
+    while (i + 2 <=3D len) {=0A=
+        desc =3D (const USBDescriptor *)(data + i);=0A=
+=0A=
+        if (desc->bLength < 2 || i + desc->bLength > len) {=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        if (desc->bDescriptorType =3D=3D USB_DT_INTERFACE && desc->bLength=
 >=3D 3) {=0A=
+            iface =3D desc->u.interface.bInterfaceNumber;=0A=
+        } else if (desc->bDescriptorType =3D=3D USB_DT_ENDPOINT) {=0A=
+            usbredir_server_record_endpoint(s, desc, iface);=0A=
+        }=0A=
+=0A=
+        i +=3D desc->bLength;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_send_ep_info(USBRedirServer *s)=0A=
+{=0A=
+    struct usb_redir_ep_info_header ep_info =3D {};=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        ep_info.type[i] =3D s->ep_type[i];=0A=
+        ep_info.max_packet_size[i] =3D s->ep_max_packet[i];=0A=
+        ep_info.interface[i] =3D s->ep_iface[i];=0A=
+        /*=0A=
+         * bInterval says how often to poll this endpoint. Pass on what=0A=
+         * the descriptor said, but never 0 for an interrupt or isochronou=
s=0A=
+         * endpoint: redirect.c throws the whole device away when it sees=
=0A=
+         * 0, so send 1 instead.=0A=
+         */=0A=
+        ep_info.interval[i] =3D s->ep_interval[i];=0A=
+        if (ep_info.interval[i] =3D=3D 0 &&=0A=
+            (s->ep_type[i] =3D=3D USB_ENDPOINT_XFER_INT ||=0A=
+             s->ep_type[i] =3D=3D USB_ENDPOINT_XFER_ISOC)) {=0A=
+            ep_info.interval[i] =3D 1;=0A=
+        }=0A=
+        if (s->ep_type[i] !=3D USB_ENDPOINT_XFER_INVALID) {=0A=
+            trace_usbredir_server_ep_info(i, ep_info.type[i],=0A=
+                                          ep_info.max_packet_size[i],=0A=
+                                          ep_info.interval[i],=0A=
+                                          ep_info.interface[i]);=0A=
+        }=0A=
+    }=0A=
+=0A=
+    usbredirparser_send_ep_info(s->parser, &ep_info);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
 =0A=
 static uint8_t usbredir_server_speed(USBDevice *device)=0A=
 {=0A=
@@ -119,6 +214,146 @@ static void usbredir_server_announce_device(USBRedirS=
erver *s)=0A=
     trace_usbredir_server_announce(conn.speed);=0A=
     usbredirparser_send_device_connect(s->parser, &conn);=0A=
     usbredirparser_do_write(s->parser);=0A=
+=0A=
+    usbredir_server_send_ep_info(s);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Packet completion=0A=
+ */=0A=
+=0A=
+static uint8_t usbredir_server_status(int status)=0A=
+{=0A=
+    switch (status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        return usb_redir_success;=0A=
+    case USB_RET_STALL:=0A=
+        return usb_redir_stall;=0A=
+    case USB_RET_BABBLE:=0A=
+        return usb_redir_babble;=0A=
+    default:=0A=
+        return usb_redir_ioerror;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The device answered the setup token of an IN control request. What it=
=0A=
+ * wants to send is now in device->data_buf, so run the data and status=0A=
+ * stages and pass the answer to the host.=0A=
+ *=0A=
+ * Each stage reuses rp->pkt, and usb_packet_setup() asserts iov->iov is=
=0A=
+ * not NULL, so call qemu_iovec_init() before every stage.=0A=
+ */=0A=
+static void usbredir_server_ctrl_setup_complete(USBRedirServer *s,=0A=
+                                                USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_control_packet_header resp =3D rp->ctrl_hdr;=0A=
+    struct usb_redir_configuration_status_header cfg =3D {};=0A=
+    struct usb_redir_alt_setting_status_header alt =3D {=0A=
+        .interface =3D rp->ctrl_hdr.index,=0A=
+    };=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    USBEndpoint *ep_out =3D usb_ep_get(device, USB_TOKEN_OUT, 0);=0A=
+    USBEndpoint *ep_in =3D usb_ep_get(device, USB_TOKEN_IN, 0);=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    int actual =3D 0;=0A=
+=0A=
+    if (rp->pkt.status =3D=3D USB_RET_SUCCESS) {=0A=
+        /* Data stage: the core copies device->data_buf into our buffer. *=
/=0A=
+        qemu_iovec_init(&rp->pkt.iov, 1);=0A=
+        usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep_in,=0A=
+                         0, s->next_id++, false, false);=0A=
+        usb_packet_addbuf(&rp->pkt, rp->data, rp->data_size);=0A=
+        usb_handle_packet(device, &rp->pkt);=0A=
+        actual =3D rp->pkt.actual_length;=0A=
+        usb_packet_cleanup(&rp->pkt);=0A=
+=0A=
+        /* Status stage: tell the device we got it. Its EP0 goes idle. */=
=0A=
+        qemu_iovec_init(&rp->pkt.iov, 1);=0A=
+        usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep_out,=0A=
+                         0, s->next_id++, false, false);=0A=
+        usb_handle_packet(device, &rp->pkt);=0A=
+        usb_packet_cleanup(&rp->pkt);=0A=
+=0A=
+        if (rp->ctrl_hdr.request =3D=3D USB_REQ_GET_DESCRIPTOR &&=0A=
+            (rp->ctrl_hdr.value >> 8) =3D=3D USB_DT_CONFIG && actual > 0) =
{=0A=
+            usbredir_server_snoop_config_desc(s, rp->data, actual);=0A=
+        }=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_ctrl_setup_complete(rp->redir_id, status,=0A=
+                                              actual);=0A=
+=0A=
+    switch (rp->reply) {=0A=
+    case USBREDIR_SERVER_REPLY_CONTROL:=0A=
+        resp.status =3D status;=0A=
+        resp.length =3D actual;=0A=
+        usbredirparser_send_control_packet(s->parser, rp->redir_id, &resp,=
=0A=
+                                           actual > 0 ? rp->data : NULL,=
=0A=
+                                           actual);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_REPLY_CONFIG:=0A=
+        cfg.status =3D status;=0A=
+        cfg.configuration =3D actual > 0 ? rp->data[0] : 0;=0A=
+        usbredirparser_send_configuration_status(s->parser, rp->redir_id,=
=0A=
+                                                 &cfg);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_REPLY_ALT:=0A=
+        alt.status =3D status;=0A=
+        alt.alt =3D actual > 0 ? rp->data[0] : 0;=0A=
+        usbredirparser_send_alt_setting_status(s->parser, rp->redir_id,=0A=
+                                               &alt);=0A=
+        break;=0A=
+    }=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The status stage of an OUT control request finished, so the device is=
=0A=
+ * done. Tell the host how it went, with whichever message it is waiting=
=0A=
+ * for.=0A=
+ */=0A=
+static void usbredir_server_ctrl_status_complete(USBRedirServer *s,=0A=
+                                                 USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_control_packet_header resp =3D rp->ctrl_hdr;=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    struct usb_redir_configuration_status_header cfg =3D {=0A=
+        .configuration =3D rp->ctrl_hdr.value,=0A=
+    };=0A=
+    struct usb_redir_alt_setting_status_header alt =3D {=0A=
+        .interface =3D rp->ctrl_hdr.index,=0A=
+        .alt =3D rp->ctrl_hdr.value,=0A=
+    };=0A=
+=0A=
+    trace_usbredir_server_ctrl_status_complete(rp->redir_id, status);=0A=
+=0A=
+    switch (rp->reply) {=0A=
+    case USBREDIR_SERVER_REPLY_CONTROL:=0A=
+        resp.status =3D status;=0A=
+        resp.length =3D 0;=0A=
+        usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
+                                           &resp, NULL, 0);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_REPLY_CONFIG:=0A=
+        cfg.status =3D status;=0A=
+        usbredirparser_send_configuration_status(s->parser, rp->redir_id,=
=0A=
+                                                 &cfg);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_REPLY_ALT:=0A=
+        alt.status =3D status;=0A=
+        usbredirparser_send_alt_setting_status(s->parser, rp->redir_id,=0A=
+                                               &alt);=0A=
+        break;=0A=
+    }=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    /* The endpoint list changed. Send the new one. */=0A=
+    if (status =3D=3D usb_redir_success &&=0A=
+        (rp->ctrl_hdr.request =3D=3D USB_REQ_SET_CONFIGURATION ||=0A=
+         rp->ctrl_hdr.request =3D=3D USB_REQ_SET_INTERFACE)) {=0A=
+        usbredir_server_send_ep_info(s);=0A=
+    }=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -166,12 +401,20 @@ static void usbredir_server_port_detach(USBPort *port=
)=0A=
 =0A=
     timer_del(s->announce_timer);=0A=
 =0A=
+    usbredir_server_stop_transfers(s);=0A=
+=0A=
     if (s->host_connected && s->parser && s->device_announced) {=0A=
         trace_usbredir_server_disconnect();=0A=
         usbredirparser_send_device_disconnect(s->parser);=0A=
         usbredirparser_do_write(s->parser);=0A=
     }=0A=
     s->device_announced =3D false;=0A=
+=0A=
+    /* Clear the endpoint tables: they belong to the device that is leavin=
g. */=0A=
+    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));=0A=
+    memset(s->ep_max_packet, 0, sizeof(s->ep_max_packet));=0A=
+    memset(s->ep_interval, 0, sizeof(s->ep_interval));=0A=
+    memset(s->ep_iface, 0, sizeof(s->ep_iface));=0A=
 }=0A=
 =0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
@@ -184,11 +427,42 @@ static void usbredir_server_port_wakeup(USBPort *port=
)=0A=
     /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The core calls this for a packet the device answered with=0A=
+ * USB_RET_ASYNC. usbredir_server_submit_to_device() calls it for the rest=
.=0A=
+ */=0A=
+static void usbredir_server_packet_complete(USBPort *port, USBPacket *p)=
=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+    USBRedirServerPkt *rp =3D container_of(p, USBRedirServerPkt, pkt);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    QTAILQ_REMOVE(&s->inflight, rp, next);=0A=
+    usb_packet_cleanup(&rp->pkt);=0A=
+=0A=
+    if (!s->parser || !device) {=0A=
+        usbredir_server_pkt_free(rp);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (rp->type) {=0A=
+    case USBREDIR_SERVER_CTRL_SETUP:=0A=
+        usbredir_server_ctrl_setup_complete(s, rp);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_CTRL_STATUS:=0A=
+        usbredir_server_ctrl_status_complete(s, rp);=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    usbredir_server_pkt_free(rp);=0A=
+}=0A=
+=0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
     .attach =3D usbredir_server_port_attach,=0A=
     .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
+    .complete =3D usbredir_server_packet_complete,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -198,6 +472,54 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Submit a packet to the device. The core only calls our completion=0A=
+ * callback when the device answers USB_RET_ASYNC, so call it here for=0A=
+ * the rest.=0A=
+ */=0A=
+static void usbredir_server_submit_to_device(USBRedirServer *s,=0A=
+                                             USBRedirServerPkt *rp)=0A=
+{=0A=
+    QTAILQ_INSERT_TAIL(&s->inflight, rp, next);=0A=
+    usb_handle_packet(usbredir_server_device(s), &rp->pkt);=0A=
+    if (rp->pkt.status !=3D USB_RET_ASYNC) {=0A=
+        usbredir_server_packet_complete(&s->port, &rp->pkt);=0A=
+    }=0A=
+}=0A=
+=0A=
+static USBRedirServerPkt *usbredir_server_pkt_alloc(int size)=0A=
+{=0A=
+    USBRedirServerPkt *rp =3D g_new0(USBRedirServerPkt, 1);=0A=
+=0A=
+    qemu_iovec_init(&rp->pkt.iov, 1);=0A=
+    rp->data =3D g_malloc0(size);=0A=
+    rp->data_size =3D size;=0A=
+    return rp;=0A=
+}=0A=
+=0A=
+static void usbredir_server_pkt_free(USBRedirServerPkt *rp)=0A=
+{=0A=
+    g_free(rp->data);=0A=
+    g_free(rp);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Take @rp off the list and free it. Do not use usb_packet_complete():=0A=
+ * it calls back into usbredir_server_packet_complete(), which would=0A=
+ * remove the entry a second time and free it. usb_cancel_packet() only=0A=
+ * tells the device to let go.=0A=
+ */=0A=
+static void usbredir_server_drop_pkt(USBRedirServer *s,=0A=
+                                     USBRedirServerPkt *rp)=0A=
+{=0A=
+    QTAILQ_REMOVE(&s->inflight, rp, next);=0A=
+    if (usb_packet_is_inflight(&rp->pkt)) {=0A=
+        usb_cancel_packet(&rp->pkt);=0A=
+    }=0A=
+    usb_packet_cleanup(&rp->pkt);=0A=
+    usbredir_server_pkt_free(rp);=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -313,9 +635,199 @@ static void usbredir_server_reset(void *priv)=0A=
     USBDevice *device =3D usbredir_server_device(s);=0A=
 =0A=
     trace_usbredir_server_bus_reset(device && device->attached);=0A=
+    if (!device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    usbredir_server_stop_transfers(s);=0A=
     usb_device_reset(device);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Run one control transfer on the device. @reply says which message=0A=
+ * answers the host when the transfer finishes.=0A=
+ */=0A=
+static void usbredir_server_do_control(USBRedirServer *s, uint64_t id,=0A=
+    struct usb_redir_control_packet_header *hdr,=0A=
+    uint8_t *data, int data_len, USBRedirServerReply reply)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep_out;=0A=
+    USBEndpoint *ep_in;=0A=
+    USBEndpoint *ep0;=0A=
+    bool is_in;=0A=
+    int size;=0A=
+=0A=
+    if (!s->host_connected || !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_control(id, hdr->requesttype, hdr->request,=0A=
+                                  hdr->value, hdr->index, hdr->length);=0A=
+=0A=
+    is_in =3D !!(hdr->requesttype & USB_DIR_IN);=0A=
+=0A=
+    ep0 =3D usb_ep_get(device, USB_TOKEN_SETUP, 0);=0A=
+=0A=
+    /* Room for the setup bytes and for the data of either direction. */=
=0A=
+    size =3D MAX(hdr->length, data_len);=0A=
+    size =3D MAX(size, (int)sizeof(device->setup_buf));=0A=
+=0A=
+    rp =3D usbredir_server_pkt_alloc(size);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->reply =3D reply;=0A=
+    rp->ctrl_hdr =3D *hdr;=0A=
+=0A=
+    /*=0A=
+     * Build the raw 8-byte SETUP packet in rp->data. The IN path=0A=
+     * overwrites it later with the answer from the device.=0A=
+     */=0A=
+    rp->data[0] =3D hdr->requesttype;=0A=
+    rp->data[1] =3D hdr->request;=0A=
+    rp->data[2] =3D hdr->value & 0xff;=0A=
+    rp->data[3] =3D (hdr->value >> 8) & 0xff;=0A=
+    rp->data[4] =3D hdr->index & 0xff;=0A=
+    rp->data[5] =3D (hdr->index >> 8) & 0xff;=0A=
+    rp->data[6] =3D hdr->length & 0xff;=0A=
+    rp->data[7] =3D (hdr->length >> 8) & 0xff;=0A=
+=0A=
+    if (is_in) {=0A=
+        /*=0A=
+         * An IN request. The device starts the work on the setup token=0A=
+         * and may take its time, so send the token and pick the rest up=
=0A=
+         * in usbredir_server_ctrl_setup_complete().=0A=
+         */=0A=
+        rp->type =3D USBREDIR_SERVER_CTRL_SETUP;=0A=
+        usb_packet_setup(&rp->pkt, USB_TOKEN_SETUP, ep0,=0A=
+                         0, s->next_id++, false, false);=0A=
+        usb_packet_addbuf(&rp->pkt, rp->data, sizeof(device->setup_buf));=
=0A=
+        usbredir_server_submit_to_device(s, rp);=0A=
+    } else {=0A=
+        /*=0A=
+         * An OUT request. The device only stores the setup bytes now and=
=0A=
+         * does the work on the status stage, so run the first two stages=
=0A=
+         * here and wait on the last one.=0A=
+         */=0A=
+        ep_in =3D usb_ep_get(device, USB_TOKEN_IN, 0);=0A=
+        ep_out =3D usb_ep_get(device, USB_TOKEN_OUT, 0);=0A=
+=0A=
+        /* Setup stage: hand the device the 8 setup bytes. */=0A=
+        usb_packet_setup(&rp->pkt, USB_TOKEN_SETUP, ep0,=0A=
+                         0, s->next_id++, false, false);=0A=
+        usb_packet_addbuf(&rp->pkt, rp->data, sizeof(device->setup_buf));=
=0A=
+        usb_handle_packet(device, &rp->pkt);=0A=
+        usb_packet_cleanup(&rp->pkt);=0A=
+=0A=
+        /* Data stage: send the bytes that came with the request. */=0A=
+        if (data_len > 0) {=0A=
+            memcpy(rp->data, data, data_len);=0A=
+            qemu_iovec_init(&rp->pkt.iov, 1);=0A=
+            usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep_out,=0A=
+                             0, s->next_id++, false, false);=0A=
+            usb_packet_addbuf(&rp->pkt, rp->data, data_len);=0A=
+            /* The core copies our bytes into device->data_buf. */=0A=
+            usb_handle_packet(device, &rp->pkt);=0A=
+            usb_packet_cleanup(&rp->pkt);=0A=
+        }=0A=
+=0A=
+        /* Status stage: the device does the work here, so wait for it. */=
=0A=
+        rp->type =3D USBREDIR_SERVER_CTRL_STATUS;=0A=
+        qemu_iovec_init(&rp->pkt.iov, 1);=0A=
+        usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep_in,=0A=
+                         0, s->next_id++, false, false);=0A=
+        /* async; the answer comes in usbredir_server_ctrl_status_complete=
() */=0A=
+        usbredir_server_submit_to_device(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_control_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_control_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    usbredir_server_do_control(priv, id, hdr, data, data_len,=0A=
+                               USBREDIR_SERVER_REPLY_CONTROL);=0A=
+}=0A=
+=0A=
+static void usbredir_server_set_configuration(void *priv, uint64_t id,=0A=
+    struct usb_redir_set_configuration_header *hdr)=0A=
+{=0A=
+    struct usb_redir_control_packet_header ctrl =3D {=0A=
+        .endpoint =3D 0,=0A=
+        .request =3D USB_REQ_SET_CONFIGURATION,=0A=
+        /* Host->Device, Standard, Device */=0A=
+        .requesttype =3D 0x00,=0A=
+        .status =3D 0,=0A=
+        .value =3D hdr->configuration,=0A=
+        .index =3D 0,=0A=
+        .length =3D 0,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* The host gets a configuration_status when the device answers. */=0A=
+    usbredir_server_do_control(s, id, &ctrl, NULL, 0,=0A=
+                               USBREDIR_SERVER_REPLY_CONFIG);=0A=
+}=0A=
+=0A=
+static void usbredir_server_get_configuration(void *priv, uint64_t id)=0A=
+{=0A=
+    struct usb_redir_control_packet_header ctrl =3D {=0A=
+        .endpoint =3D 0,=0A=
+        .request =3D USB_REQ_GET_CONFIGURATION,=0A=
+        /* Device->Host, Standard, Device */=0A=
+        .requesttype =3D 0x80,=0A=
+        .status =3D 0,=0A=
+        .value =3D 0,=0A=
+        .index =3D 0,=0A=
+        .length =3D 1,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* The host gets a configuration_status when the device answers. */=0A=
+    usbredir_server_do_control(s, id, &ctrl, NULL, 0,=0A=
+                               USBREDIR_SERVER_REPLY_CONFIG);=0A=
+}=0A=
+=0A=
+static void usbredir_server_set_alt_setting(void *priv, uint64_t id,=0A=
+    struct usb_redir_set_alt_setting_header *hdr)=0A=
+{=0A=
+    struct usb_redir_control_packet_header ctrl =3D {=0A=
+        .endpoint =3D 0,=0A=
+        .request =3D USB_REQ_SET_INTERFACE,=0A=
+        /* Host->Device, Standard, Interface */=0A=
+        .requesttype =3D 0x01,=0A=
+        .status =3D 0,=0A=
+        .value =3D hdr->alt,=0A=
+        .index =3D hdr->interface,=0A=
+        .length =3D 0,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* The host gets an alt_setting_status when the device answers. */=0A=
+    usbredir_server_do_control(s, id, &ctrl, NULL, 0,=0A=
+                               USBREDIR_SERVER_REPLY_ALT);=0A=
+}=0A=
+=0A=
+static void usbredir_server_get_alt_setting(void *priv, uint64_t id,=0A=
+    struct usb_redir_get_alt_setting_header *hdr)=0A=
+{=0A=
+    struct usb_redir_control_packet_header ctrl =3D {=0A=
+        .endpoint =3D 0,=0A=
+        .request =3D USB_REQ_GET_INTERFACE,=0A=
+        /* Device->Host, Standard, Interface */=0A=
+        .requesttype =3D 0x81,=0A=
+        .status =3D 0,=0A=
+        .value =3D 0,=0A=
+        .index =3D hdr->interface,=0A=
+        .length =3D 1,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* The host gets an alt_setting_status when the device answers. */=0A=
+    usbredir_server_do_control(s, id, &ctrl, NULL, 0,=0A=
+                               USBREDIR_SERVER_REPLY_ALT);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -339,6 +851,84 @@ static void usbredir_server_interface_info(void *priv,=
=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
+{=0A=
+    struct usb_redir_control_packet_header resp =3D {=0A=
+        .endpoint =3D 0,=0A=
+        .status =3D usb_redir_cancelled,=0A=
+        .length =3D 0,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    /*=0A=
+     * The host has put this id in its cancelled queue and waits for one=
=0A=
+     * answer carrying it. The device may have answered already, so the=0A=
+     * request may no longer be on our list. Answer in both cases: the=0A=
+     * host reuses ids, and a leftover entry would eat a later answer.=0A=
+     */=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, next) {=0A=
+        if (rp->redir_id =3D=3D id) {=0A=
+            trace_usbredir_server_cancel(id, true);=0A=
+            usbredir_server_send_cancelled(s, rp);=0A=
+            usbredir_server_drop_pkt(s, rp);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Already finished, so we no longer know what kind of transfer it=0A=
+     * was. The host retires the entry on the id alone, and its control=0A=
+     * handler ignores the endpoint field, so a control packet always=0A=
+     * works.=0A=
+     */=0A=
+    trace_usbredir_server_cancel(id, false);=0A=
+    usbredirparser_send_control_packet(s->parser, id, &resp, NULL, 0);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Cancelled and in-flight packets=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * Every request must get one answer carrying its id, even an aborted one.=
=0A=
+ * A dropped id stays in the host's cancelled queue. The host reuses ids,=
=0A=
+ * so a later answer would be thrown away as a stale one.=0A=
+ */=0A=
+static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
+                                           USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_control_packet_header ctrl;=0A=
+=0A=
+    switch (rp->type) {=0A=
+    case USBREDIR_SERVER_CTRL_SETUP:=0A=
+    case USBREDIR_SERVER_CTRL_STATUS:=0A=
+        ctrl =3D rp->ctrl_hdr;=0A=
+        ctrl.status =3D usb_redir_cancelled;=0A=
+        ctrl.length =3D 0;=0A=
+        usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
+                                           &ctrl, NULL, 0);=0A=
+        break;=0A=
+    default:=0A=
+        return;=0A=
+    }=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_transfers(USBRedirServer *s)=0A=
+{=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    /*=0A=
+     * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
+     * a closed chardev, and the host has dropped its own queues already.=
=0A=
+     */=0A=
+    while ((rp =3D QTAILQ_FIRST(&s->inflight)) !=3D NULL) {=0A=
+        usbredir_server_drop_pkt(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Parser setup and teardown=0A=
  */=0A=
@@ -361,13 +951,19 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
     /* Callbacks for messages the remote host sends to us */=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
     s->parser->reset_func =3D usbredir_server_reset;=0A=
+    s->parser->control_packet_func =3D usbredir_server_control_packet;=0A=
+    s->parser->set_configuration_func =3D usbredir_server_set_configuratio=
n;=0A=
 =0A=
     /* The parser calls these directly, so they must not be NULL. */=0A=
+    s->parser->get_configuration_func =3D usbredir_server_get_configuratio=
n;=0A=
+    s->parser->set_alt_setting_func =3D usbredir_server_set_alt_setting;=
=0A=
+    s->parser->get_alt_setting_func =3D usbredir_server_get_alt_setting;=
=0A=
     s->parser->filter_reject_func =3D usbredir_server_filter_reject;=0A=
     s->parser->filter_filter_func =3D usbredir_server_filter_filter;=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
@@ -401,6 +997,8 @@ static void usbredir_server_destroy_parser(USBRedirServ=
er *s)=0A=
     timer_del(s->announce_timer);=0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
+    usbredir_server_stop_transfers(s);=0A=
+=0A=
     if (s->parser) {=0A=
         usbredirparser_destroy(s->parser);=0A=
         s->parser =3D NULL;=0A=
@@ -489,6 +1087,9 @@ static void usbredir_server_realize(DeviceState *dev, =
Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    QTAILQ_INIT(&s->inflight);=0A=
+    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     s->bus.no_auto_hub =3D true;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 2cc6a244b9..25219a018a 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -406,3 +406,8 @@ usbredir_server_announce(uint8_t speed) "device_connect=
 speed %u"=0A=
 usbredir_server_disconnect(void) "device_disconnect sent"=0A=
 usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
 usbredir_server_filter_reject(void) "host rejected our device"=0A=
+usbredir_server_cancel(uint64_t id, bool found) "id %" PRIu64 " still in f=
light %d"=0A=
+usbredir_server_ep_info(unsigned idx, uint8_t type, uint16_t mps, uint8_t =
interval, uint8_t iface) "ep_info[%u] type %u mps %u interval %u iface %u"=
=0A=
+usbredir_server_control(uint64_t id, uint8_t requesttype, uint8_t request,=
 uint16_t value, uint16_t index, uint16_t length) "id %" PRIu64 " type 0x%0=
2x request 0x%02x value 0x%04x index 0x%04x length %u"=0A=
+usbredir_server_ctrl_setup_complete(uint64_t id, int status, int actual) "=
id %" PRIu64 " status %d actual %d"=0A=
+usbredir_server_ctrl_status_complete(uint64_t id, int status) "id %" PRIu6=
4 " status %d"=0A=
-- =0A=
2.43.0=0A=

