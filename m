Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8ECCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjcs-0001nN-Se; Mon, 19 Oct 2026 05:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcK-00014Q-7W; Mon, 19 Oct 2026 05:25:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcH-0002px-Fn; Mon, 19 Oct 2026 05:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMjiZKLAPb7m/ZlvUqOqvd+ECUsdcsLktKXhIaSTZ2mRnp3HwDcYElCAgHlRfLV+WKB7dQnmimwndBJQDd9yiUKo0d1qkcDtR1r0RdWLw8U50HQN4q/KRzPszcBPiyrKP6ehW6VGKsJFKKzAi4Dsnu+hZH3nkTwFpp/SdXz+OpdyjV3kCoidRsK+SqmiE6ikBZ0Rd8yrq+N4E01Wpb3Mg+M6YHhF9ZTkuI7yH5kv/RcekZh03+mFHu9FM2MwTPEn606IT1Pip0ZYFwjS0V0CDP0BrY2R0+XP8bRjbqqylBbifAubO21z/ISN3xSpo5Dil0NaySMnupAYxvQD/TnOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlpWl4VfvHmboYoCzX0SCSSVDN1OlOTj27/QRelaZgk=;
 b=EyoiAh51tvQO3wsu9qpeSG4Y9rIga+KjU/MBUoIKyRoWrgA1156RdmW2OCkfcpnFpWNHsK9UflXgzAUhzIgWJeo3jXzbeiW7nKo7qhw6g81SeKou7MXovIp7EbRvRgw98JpXUp5mOBewb2NUTKtCE1tsjieDFd1WQxbrZQjDpsn61CSDHIJBM4KLXUq7Z2skZ6QmW7k9DtSoJpaQaVxNV/nk5CmKviByh98SDfI1orVYysibR+Mej2CWL1tUedtqwfm8TOr0NZOaMlmJgXeASaHxZYup5oR1IpPya7rNU57mLVhoctqzfEMkNxoTlPHUdmoHh0DO85yt7aJv89jL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlpWl4VfvHmboYoCzX0SCSSVDN1OlOTj27/QRelaZgk=;
 b=gm+zQDcIrkJqQZtWvtembYbEeNJCZsUGt+D07VX7eqEGj8CXNhWq9cbQ4+dt5GYeAjmaxsuFVlXcJBvHr9Rmt0+NjzTKrnyJ/5oEkcJChDkEPHBP13BTLOA08IeTejpGqUNZt/VGCvl/KzIRSrYojJFbiPs2syur9ivWSlF/hVmnrCaBECDrPP0oJ6Fh/Ynz9ykkgHHviXD1Zq41PUZOSffsDlSlXzgeC5ZRSf2K1QKEd0jbbzXqaa6ENFwNI4ytay8pF9iHb+Fs+BggzAy8zosdAJlelioztSkZtigQcANTZzWtx+iqtTFUaTbnSzxR0Txfh2H9xH4FG0WZmo9Lww==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 7/8] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v6 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdX6u11f7u0GqUe0WINlKGYeDSzg==
Date: Mon, 19 Oct 2026 09:24:57 +0000
Message-ID: <20261019092448.278079-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 490d0fac-b9ae-4041-4093-08df2dc2d7f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|5023799004|10067099003|261009221227099003|261009221727099003|261009223327099003|261009223027099003|261009220027099003|56012099006;
x-microsoft-antispam-message-info: TfdzXZ3Qm0CvkL+zeO5Ksgjoy5ObxnvapIdBKfN467srgKXYy2o1DbOkYiXMU9pts5goA2+caLAWa05FEFQhObkzm33QmMSqUVeo9RVAJphm+iR8LbG3QItFquryZSxyP7/r00aFOgnY80gQfni4xHGtPG9D/JdzAioM7FrTp+s6kSZ0gg9ktVwr0SRGHVSrC8HYbWg7YdZNp6vD6l0IdRT8uD+n+QabavhSi4oVJF3j2zLcRl2eWw5AZ7SI2U3qKD3iHHrEGDYWng6mSszeu6WARn7kVCzHMLYoIF84EIsDUwSSa5XMD+qMUfT4ZA3/ip2tElX9qQi7WIPiPh9m1l/1rXHwInZNAiHj9rN2+2+B/geeoYocvnFC/VIJ1Uk6Rr+pxXfjzokusvlQBctIweg2BKT42slhFWF0c9LlzLaHvnn9YIWAX8L1XlvK+XREFs1wW498m+OfLnAZjtPeN8G+xQM7QardtZeHb7XiIerjIOmE1yJubbvXg8axfqdv9z487Ud835A6htQEpC7ROrpDXaLphlqJv+1APlAl9lKaC7JSpmtTIonvVqKSejpu7QH0AE0zE6n+W+33BnaZYfzrlw0KIo8HrfGWZqHag/RCnk3tSetQARPDDduWqrasr11kjBJZNsV8pMtjka0SrP9sGthrjLNvh3pYHSACv0BfPXh25u0OWw4Adf2XAunxNIA/vff8vAE3Y0KtSn6eyhhryUKxs/IknMvcl7d6Z8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(5023799004)(10067099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009220027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SzrR1OYQXz4mM9auKXldabM5WnNBzLZ2MQTdURVamFbRb/SczvGC6UJHqW?=
 =?iso-8859-1?Q?qC2PESpFfe2vMFQtlX7cmGMJrAFUSzPNoE0nrpfN2uABcD7Z3N4Qed4cLJ?=
 =?iso-8859-1?Q?0skUJ/hbKz/dtqxhsWZbOTQcmiNUKMfe0EBqG1VAUgbljaRznGV1L8dh4m?=
 =?iso-8859-1?Q?DUizcXtQRu0SSNYzMjXwfTM9kypEVqzUgHvMydSVCO/JSu2bFUXep77mpL?=
 =?iso-8859-1?Q?qHTnWRTyzpd0P/6LkG003VVRdIRgWmQNA/FkU+OUny3M1lVKBl7zYqqYR9?=
 =?iso-8859-1?Q?YrkuukzFhmFskVNQzwdAS/N2WgZGeh6as7JA11+65g75j8XHe9u2NvCMMq?=
 =?iso-8859-1?Q?SpZES+oEzJkyD1iUdACyRuCrTh7OxWh0stnMkV3HUFMOrZwjmMWbW407a8?=
 =?iso-8859-1?Q?aO8seZpVzn+WYnTwgrOrsr5k4LvvySrYWU7lqIQOY87N+E9lB4SCjVeh4B?=
 =?iso-8859-1?Q?6oaTm012GFpVPMXF9hIyXtSlaXiZttXrvGjsPtrheBq5XrxpuwV68h2fSe?=
 =?iso-8859-1?Q?DFl1u/BekzqN/Hhv/QNHJ739B3hUr1MUsXLkSabU/n3JFI/pAjIOJ66j12?=
 =?iso-8859-1?Q?0OYObpKnMMrAvN69AC97tinqAxBMDCL/IJbx+8UiCjRbqyA/cJ8rfNwrDJ?=
 =?iso-8859-1?Q?WyuNwKL/wCKZkt6h83PO+TLve5lsNlU0b01SaJLBw0wAR55S4D29w6wyzB?=
 =?iso-8859-1?Q?bYkXHLd2c0l+GXoPqYCjrLyGjNcw2Y/Yk4ZxXIqcixaORGfVxgw6CWPsCr?=
 =?iso-8859-1?Q?BS8jMpvKxq7U2L7gRqZBnWPeZ3hRJ+nVH5ZtX5JpOOre00/ZJhjpwJivRS?=
 =?iso-8859-1?Q?aLCc75xc9ZHLm02u2hNibOcwuOw7vyNExLURGT+9K3A75l25MReXMlBu0p?=
 =?iso-8859-1?Q?BykU5Pqc8RBJ2aqp+SAJTpwwCkLBmOA1DjDbECsyCqCSjgz4Xx+bApWyvR?=
 =?iso-8859-1?Q?LITtZljQL1pNlda5T+PxS+CfNv5ns0YpLzLk1sNAxN6YDh/IFHgHjuN3Gj?=
 =?iso-8859-1?Q?fe2gIj2x6YpqvnfwSkj63U8EDcNerB2iGDF3MVESQLuUJlxSmqbEpfidtS?=
 =?iso-8859-1?Q?ok8Y+V9XUCMLYQGp/r9I3Fn40TUNkDNkGrcfR4L3ZjhSO/wNEY69kOSKfe?=
 =?iso-8859-1?Q?1hJZPEIiaKOCv8KwwEkf46IK0Ni3YrzOCD7e0aPsgHumRtlvSzSmUPtCcB?=
 =?iso-8859-1?Q?tDn07UNAuW4FYnHge9lmUyVts7SsFO77YRKSPMpEmU6En+tB/FLC8Wdk6R?=
 =?iso-8859-1?Q?yo1XlI+DtY3HDqZvpxXRfL43wnb5VmKZAQqDZdQWMhItVbKooeUcVMK+aq?=
 =?iso-8859-1?Q?TL1ml/z1zmRz+hNndbi8LKtJYpc1F+cPT9GnyP7biBAFGYyU9qoNUVyFJ8?=
 =?iso-8859-1?Q?tQod8bxRMH6bxwXg2mz98bjvxTP8eo2FLHHVpU+Rf2jjg3tiXQry0V9I1x?=
 =?iso-8859-1?Q?ix95cOiFTwbDHFI5LcPZ8KA+wdHu1Pcs0KhMEd0u2ZrLUsvOxxiY4TrGN1?=
 =?iso-8859-1?Q?YuNX8wtUEzWTPgNhDcmFPlAKBRMKmsw3en639n7w8+tM5GvUDFqLyll4S7?=
 =?iso-8859-1?Q?jSzVa5fBOET3Lx0Z6GzRWOa5vXyohI9VhlImZt3EntRuq4dW4KudElRQDv?=
 =?iso-8859-1?Q?pozpJ/d1aT8i81NNjHto4RPl4oIyeoRGC140iCtdcL8GNLGDH/4WaXx4+7?=
 =?iso-8859-1?Q?JZ5VZMQIqdqdXnnsUdQdavXjW3qXii+LowIiGSrOdPX/VSJCFM3Ac2R9c4?=
 =?iso-8859-1?Q?FJYwFeiL3D6t+n/F0K8PJaOqItMpmYp5WmnIS6u7RpAN1ix8hniQkxU3gb?=
 =?iso-8859-1?Q?qWRi4Rq9ug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490d0fac-b9ae-4041-4093-08df2dc2d7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:57.6176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG07WGVczP8gn+sERugct0NdRgUZjx7TXIsGWY0mN3mLv9jD4W6UIsSQJ5x2M4UV51j8qTuXDXX6Zqpm0wSZFZqgkBVdlDRnyYNyWK7TTV0=
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

Interrupt IN is not a request and an answer in usbredir. The host asks=0A=
once with start_interrupt_receiving. After that it expects a packet=0A=
every time the device has data.=0A=
=0A=
Park one IN packet on the device for each streaming endpoint. A device=0A=
that answers USB_RET_ASYNC holds the packet and completes it when it=0A=
has data. A device that answers USB_RET_NAK gives the packet back at=0A=
once, so park a new one when the bus reports a wakeup on that endpoint.=0A=
A slow timer parks one too, for a device that does not report a wakeup.=0A=
=0A=
Wait for the endpoint's bInterval before parking the next one. Some=0A=
devices answer every time. Without the wait we would ask as fast as=0A=
the main loop runs, and the guest would get no time.=0A=
=0A=
Give every endpoint its own timer and bottom half. We ask each endpoint=0A=
at its own rate.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 310 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 314 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index f81dbae2d0..6b2e65c126 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,7 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/timer.h"=0A=
 #include "qemu/cutils.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
@@ -82,16 +83,30 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
 #define USBREDIR_SERVER_MAX_EP 32=0A=
 #define USBREDIR_SERVER_EP_IN_BASE 16=0A=
 =0A=
+/* An endpoint number is 4 bits, so 0 to 15. */=0A=
+#define USBREDIR_SERVER_MAX_EP_NR 16=0A=
+=0A=
 /*=0A=
  * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
  * This is the largest transfer accepted.=0A=
  */=0A=
 #define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
 =0A=
+/* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
+#define USBREDIR_SERVER_INTR_DEFAULT_LEN 64=0A=
+=0A=
+/*=0A=
+ * Ask again this often after an endpoint answered NAK. Most devices wake=
=0A=
+ * the bus when data arrives, and then the next ask happens at once. This=
=0A=
+ * timer is for the devices that do not wake the bus.=0A=
+ */=0A=
+#define USBREDIR_SERVER_INTR_RETRY_MS 1000=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL_SETUP 0=0A=
 #define USBREDIR_SERVER_CTRL_STATUS 1=0A=
 #define USBREDIR_SERVER_BULK 2=0A=
 #define USBREDIR_SERVER_INTR 3=0A=
+#define USBREDIR_SERVER_INTR_STREAM 4=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -120,6 +135,14 @@ typedef struct USBRedirServerPkt {=0A=
     int type;=0A=
 } USBRedirServerPkt;=0A=
 =0A=
+typedef struct USBRedirServerIntrStream {=0A=
+    USBRedirServer *s;=0A=
+    QEMUTimer *timer;=0A=
+    bool started;=0A=
+    QEMUBH *bh;=0A=
+    uint8_t nr;=0A=
+} USBRedirServerIntrStream;=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -140,6 +163,15 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming, indexed by endpoint number. Every endpoint=
=0A=
+     * has its own timer and bottom half, because every one wants to be=0A=
+     * asked at its own rate. The timer asks the device again, after the=
=0A=
+     * endpoint's interval or after a NAK. The bottom half asks at once=0A=
+     * when the device says it has data.=0A=
+     */=0A=
+    USBRedirServerIntrStream intr_stream[USBREDIR_SERVER_MAX_EP_NR];=0A=
+=0A=
     /* In-flight packet tracking */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
@@ -580,6 +612,90 @@ static void usbredir_server_intr_complete(USBRedirServ=
er *s,=0A=
     usbredirparser_do_write(s->parser);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * How long to wait before asking the device again. bInterval means=0A=
+ * different things at different speeds: a number of frames at low and=0A=
+ * full speed, an exponent at high speed.=0A=
+ */=0A=
+static int64_t usbredir_server_intr_period_ns(USBRedirServer *s, int ep_nr=
)=0A=
+{=0A=
+    uint8_t interval =3D s->ep_interval[ep_nr + USBREDIR_SERVER_EP_IN_BASE=
];=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    if (interval =3D=3D 0) {=0A=
+        interval =3D 1;=0A=
+    }=0A=
+=0A=
+    if (device && device->speed =3D=3D USB_SPEED_HIGH) {=0A=
+        interval =3D MIN(interval, 16);=0A=
+        return (1LL << (interval - 1)) * 125 * SCALE_US;=0A=
+    }=0A=
+=0A=
+    return (int64_t)interval * SCALE_MS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The device answered a parked request. Send the answer to the host, then=
=0A=
+ * ask again, because the host still wants more. Do not ask from here: the=
=0A=
+ * device may answer at once, and this function would call itself over and=
=0A=
+ * over. Arm the timer instead. It also waits for the endpoint's bInterval=
.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_complete(USBRedirServer *s,=0A=
+                                                 USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    struct usb_redir_interrupt_receiving_status_header st;=0A=
+    int ep_nr =3D resp.endpoint & 0x0f;=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int actual =3D p->actual_length;=0A=
+    bool retry =3D false;=0A=
+    int64_t delay_ns;=0A=
+=0A=
+    trace_usbredir_server_intr_stream_complete(ep_nr, p->status, actual);=
=0A=
+=0A=
+    switch (p->status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        resp.status =3D usb_redir_success;=0A=
+        resp.length =3D actual;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, 0, &resp,=0A=
+                                             actual ? rp->data : NULL,=0A=
+                                             actual);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        break;=0A=
+    case USB_RET_NAK:=0A=
+        /* nothing to report yet; ask again shortly */=0A=
+        retry =3D true;=0A=
+        break;=0A=
+    default:=0A=
+        /*=0A=
+         * The endpoint failed. There is no data, so send a status=0A=
+         * message instead. The host gives it to its guest.=0A=
+         *=0A=
+         * redirect.c ends the stream only on a stall, so do the same=0A=
+         * here. If we end it on any other error, the host still=0A=
+         * thinks the stream runs, and it never asks again.=0A=
+         */=0A=
+        st.endpoint =3D resp.endpoint;=0A=
+        st.status =3D usbredir_server_status(p->status);=0A=
+        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);=
=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        if (p->status =3D=3D USB_RET_STALL) {=0A=
+            s->intr_stream[ep_nr].started =3D false;=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (s->intr_stream[ep_nr].started) {=0A=
+        if (retry) {=0A=
+            delay_ns =3D (int64_t)USBREDIR_SERVER_INTR_RETRY_MS * SCALE_MS=
;=0A=
+        } else {=0A=
+            delay_ns =3D usbredir_server_intr_period_ns(s, ep_nr);=0A=
+        }=0A=
+        timer_mod(s->intr_stream[ep_nr].timer,=0A=
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -662,6 +778,9 @@ static void usbredir_server_packet_complete(USBPort *po=
rt, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTR:=0A=
         usbredir_server_intr_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_INTR_STREAM:=0A=
+        usbredir_server_intr_stream_complete(s, rp);=0A=
+        break;=0A=
     }=0A=
 =0A=
     usbredir_server_pkt_free(rp);=0A=
@@ -679,7 +798,25 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
  * USB bus ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_wakeup_ep(USBBus *bus, USBEndpoint *ep,=0A=
+                                      unsigned int stream)=0A=
+{=0A=
+    USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
+    int ep_nr =3D ep->nr;=0A=
+=0A=
+    /*=0A=
+     * The device has data. A streaming interrupt IN endpoint may have=0A=
+     * answered NAK. Ask now instead of waiting for the retry timer.=0A=
+     * Every other transfer already has its request on the device.=0A=
+     */=0A=
+    if (ep->pid =3D=3D USB_TOKEN_IN && ep_nr < USBREDIR_SERVER_MAX_EP_NR &=
&=0A=
+        s->intr_stream[ep_nr].started) {=0A=
+        qemu_bh_schedule(s->intr_stream[ep_nr].bh);=0A=
+    }=0A=
+}=0A=
+=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
+    .wakeup_endpoint =3D usbredir_server_wakeup_ep,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -730,6 +867,87 @@ static void usbredir_server_drop_pkt(USBRedirServer *s=
,=0A=
     usbredir_server_pkt_free(rp);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Interrupt IN streaming=0A=
+ */=0A=
+=0A=
+static bool usbredir_server_intr_inflight(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, next) {=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM &&=0A=
+            (rp->intr_hdr.endpoint & 0x0f) =3D=3D ep_nr) {=0A=
+            return true;=0A=
+        }=0A=
+    }=0A=
+    return false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Ask the device for data on @ep_nr and leave the request waiting. A devi=
ce=0A=
+ * sends data only when asked. Do nothing if a request on @ep_nr is still=
=0A=
+ * unanswered.=0A=
+ */=0A=
+static void usbredir_server_intr_park(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    int len;=0A=
+=0A=
+    /* No device to ask. */=0A=
+    if (!device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* The host did not ask for this endpoint, or a request is unanswered.=
 */=0A=
+    if (!s->intr_stream[ep_nr].started ||=0A=
+        usbredir_server_intr_inflight(s, ep_nr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    len =3D s->ep_max_packet[ep_nr + USBREDIR_SERVER_EP_IN_BASE];=0A=
+    if (len =3D=3D 0) {=0A=
+        len =3D USBREDIR_SERVER_INTR_DEFAULT_LEN;=0A=
+    }=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_IN, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->type =3D USBREDIR_SERVER_INTR_STREAM;=0A=
+    /* streamed data carries no host id */=0A=
+    rp->redir_id =3D 0;=0A=
+    rp->intr_hdr.endpoint =3D ep_nr | USB_DIR_IN;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_intr_park(ep_nr, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
+/* BH and timer callback: ask again on one streaming endpoint. */=0A=
+static void usbredir_server_intr_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServerIntrStream *st =3D opaque;=0A=
+=0A=
+    usbredir_server_intr_park(st->s, st->nr);=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_cancel(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBRedirServerPkt *tmp;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH_SAFE(rp, &s->inflight, next, tmp) {=0A=
+        if (rp->type !=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            (rp->intr_hdr.endpoint & 0x0f) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        usbredir_server_drop_pkt(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -1168,6 +1386,60 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The host asks to stream an interrupt IN endpoint. Send the receiving=0A=
+ * status first. Without that status the host throws the interrupt=0A=
+ * packet away. Then ask the device once.=0A=
+ */=0A=
+static void usbredir_server_start_interrupt_receiving(void *priv,=0A=
+    uint64_t id, struct usb_redir_start_interrupt_receiving_header *hdr)=
=0A=
+{=0A=
+    struct usb_redir_interrupt_receiving_status_header st =3D {=0A=
+        .endpoint =3D hdr->endpoint,=0A=
+        .status =3D usb_redir_success,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+=0A=
+    /*=0A=
+     * Endpoint 0 is control and an OUT endpoint never streams. There also=
=0A=
+     * has to be a host to send to and a device to ask.=0A=
+     */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN) ||=0A=
+        !s->host_connected || !device || !device->attached) {=0A=
+        st.status =3D usb_redir_ioerror;=0A=
+    } else {=0A=
+        s->intr_stream[ep_nr].started =3D true;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_start(hdr->endpoint, st.status);=0A=
+    usbredirparser_send_interrupt_receiving_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        usbredir_server_intr_park(s, ep_nr);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_interrupt_receiving(void *priv, uint64_t =
id,=0A=
+    struct usb_redir_stop_interrupt_receiving_header *hdr)=0A=
+{=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* Endpoint 0 is control, and an OUT endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_stop(hdr->endpoint);=0A=
+    s->intr_stream[ep_nr].started =3D false;=0A=
+    qemu_bh_cancel(s->intr_stream[ep_nr].bh);=0A=
+    timer_del(s->intr_stream[ep_nr].timer);=0A=
+    usbredir_server_intr_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1257,6 +1529,17 @@ static void usbredir_server_send_cancelled(USBRedirS=
erver *s,=0A=
 static void usbredir_server_stop_transfers(USBRedirServer *s)=0A=
 {=0A=
     USBRedirServerPkt *rp;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 1; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        s->intr_stream[i].started =3D false;=0A=
+        if (s->intr_stream[i].bh) {=0A=
+            qemu_bh_cancel(s->intr_stream[i].bh);=0A=
+        }=0A=
+        if (s->intr_stream[i].timer) {=0A=
+            timer_del(s->intr_stream[i].timer);=0A=
+        }=0A=
+    }=0A=
 =0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
@@ -1303,6 +1586,10 @@ static void usbredir_server_create_parser(USBRedirSe=
rver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->start_interrupt_receiving_func =3D=0A=
+        usbredir_server_start_interrupt_receiving;=0A=
+    s->parser->stop_interrupt_receiving_func =3D=0A=
+        usbredir_server_stop_interrupt_receiving;=0A=
     s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
     s->parser->start_bulk_receiving_func =3D=0A=
@@ -1424,6 +1711,8 @@ static void usbredir_server_chardev_event(void *opaqu=
e,=0A=
 static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+    USBRedirServerIntrStream *st;=0A=
+    int i;=0A=
 =0A=
     if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
         error_setg(errp,=0A=
@@ -1443,6 +1732,15 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
 =0A=
+    for (i =3D 1; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        st =3D &s->intr_stream[i];=0A=
+        st->s =3D s;=0A=
+        st->nr =3D i;=0A=
+        st->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                 usbredir_server_intr_kick, st);=0A=
+        st->bh =3D qemu_bh_new_guarded(usbredir_server_intr_kick, st,=0A=
+                                     &dev->mem_reentrancy_guard);=0A=
+    }=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -1456,12 +1754,24 @@ static void usbredir_server_realize(DeviceState *de=
v, Error **errp)=0A=
 static void usbredir_server_unrealize(DeviceState *dev)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+    int i;=0A=
 =0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
     g_clear_pointer(&s->config_descs, g_hash_table_destroy);=0A=
 =0A=
+    for (i =3D 1; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        if (s->intr_stream[i].timer) {=0A=
+            timer_free(s->intr_stream[i].timer);=0A=
+            s->intr_stream[i].timer =3D NULL;=0A=
+        }=0A=
+        if (s->intr_stream[i].bh) {=0A=
+            qemu_bh_delete(s->intr_stream[i].bh);=0A=
+            s->intr_stream[i].bh =3D NULL;=0A=
+        }=0A=
+    }=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d74860ad4b..96f46c5fe0 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -420,3 +420,7 @@ usbredir_server_bulk_complete(uint64_t id, uint8_t ep, =
int status, int actual) "=0A=
 usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
 usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
 usbredir_server_intr_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_intr_start(uint8_t ep, int status) "start_interrupt_receiv=
ing ep 0x%02x -> status %d"=0A=
+usbredir_server_intr_stop(uint8_t ep) "stop_interrupt_receiving ep 0x%02x"=
=0A=
+usbredir_server_intr_park(unsigned ep_nr, int len) "parked IN packet ep %u=
 len %d"=0A=
+usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

