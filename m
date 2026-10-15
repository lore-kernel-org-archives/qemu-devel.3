Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7D1CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrF-0000LE-A9; Thu, 15 Oct 2026 05:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrA-0000In-Hj; Thu, 15 Oct 2026 05:34:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr7-0006Dg-I0; Thu, 15 Oct 2026 05:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyCP2hMloPYhMj7u/I06Y28zhdNJEBDjJ24w4CD8VhhgyVV71t/r3o4X2Cx/kRvyIKfujrFdBX29qVyWaE8JZVid6e9FskhCrmNpMAorQzKbdyNOe9k4eZQi//8mZu8JMBVfh1S8qHXfHvqs08UN9Aa8FCuxCLkDMaan7PPV3ng4Qizw8P3Tc/MuH86wyBeJj6QkRfJyKCjpEV/i2x2p3X2BxPNphLGd/xC/mb0qXOIVZJVX8mfz6R9MZ92aaeEuT+vAsqwoO5CV439nw3FPwXx2rGAByTO5tZ46mEQYWjE8k7pcZLs6vK9XeQ2o8cHHEySmQbINqda00/QeR1bOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzJkIHHAongGi5wKoqAHGBrOereIQjvb5ARw/TgaKqM=;
 b=CnEJF4tId7v+Q/atXorvqn60XTL0olLAzUa/bhfzxN0Jf/ZPl+dqBgCWZzsxVJfgglPh6Li5TZNEJ/YwMxLXoHb8pMz3RN3uB5O3AyJU6s4+Epkv9hjbeYLOKot/rcOjDDZCcBHXmS6WYr3bIGCv5SctaOWv3JcaOYxwdMSQ0fXBh8sjzP9GSWzzUE+onc/OdcpwUivGohAPV2se0LJMuWy1Osg66GNcQeoJBcA0AEOw9a8OSM7mM8WCjYyhbAvBr4dl/L8H6pr68CRqsaQCdFfBZ9p575EX3bd5v8HjfWGu+POS+fZxuqXpVWO9MDDYnHamPK12aHXvu7b6vknl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzJkIHHAongGi5wKoqAHGBrOereIQjvb5ARw/TgaKqM=;
 b=DPaNFt+yLwgeNVzKMzBF300+eEYrzl8AeKKgH3uXy+xYHBv78s4l5YSCmDu/kw3+Mj5MSheiEEtLn5FdNtUjdKlh/Wj3M0vDeuCwpMIT5ALDwawZDnrujmecC6RfKeEevCvT9/RUg3AgmCxXT7fzM3A3ApbqyyIkhVkEBnOmr2t86YAupaeI63CV52TwaWGcatJFb/+raRFB12olOugyd1xjoGjACSf0mhlLMdv1lowM7qbIltPgkPbtHspe5Kid65oPXQBCO9tCJDja27Tq/o4yqwrZRqy2DoH5bYR845o9ibXLUltbViKFuh8FiBiWl9x5YKf+itF3SDT0tdtaag==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:21 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 3/8] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v5 3/8] hw/usb/redirect-server: Connect usbredirparser to
 a chardev
Thread-Index: AQHdXIhbhyF1+EYA2k61r3vOehVY4w==
Date: Thu, 15 Oct 2026 09:34:21 +0000
Message-ID: <20261015093417.573063-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 94d4798f-dead-4aa2-b50f-08df2a9f7e15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|921020|5023799004|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: 3FGXMGbfI685EMOJBOU6tWCJBAwoBKqSA5fg4vjrSi3U8dsZCryv+x3H/KyZWF2XIgoTOW6d7wVjLJwJR5NZM8vfkZbdl9sXJ5I/UEQgGQ4Y9BPPYmPLI1Tb/CRvVcxKYU0xqWjDxWo+KOiRMYcp7W6B5EVdsMjj9vaUQtZ7aWqewPg6SbnqfL6qarIrPe1fqp/zGqNe8tX1H/yYVIiHZndCJVgi8aoRE3ZRU7VrYL98jF6csspsRwFrL/Vl0JQ2ANL42d01W2ziJa/iWkWfgpW1kgwFbXlk2LJE8SUjHLQzhY3RhTTPX+ZBWMlDt4N6llKx6/ZHIcrpsh1z1uZ8s3a+rLTg50SOr+7tNXGDj6qqsEiLJuG3L4wR8QKquvplhoxe172qeYkqbbzHUhMPwe0/A94LBAL7DBAtmjv7kvvtwNKEJgPK94OZdQrKMssHr1MNdPAQn9HdBdERK6p0L1DNSGFc4VQch0XObMRrBPXECJB/wKs80FZ9UbE9RuDmdImLZ4IaUOLJKwf0sOT6OVDjGOWtrVMpkkkECQjU4tb82qpAtQKvJ3CXBhC5+7Pm6nIn20aI6TB/us4HZIdOF+KE9oMAG2Bm/59qzjvZ10V8EoMo42knf+3MjhwyeVAiOAFtuW9c0Nu2SyfW850L/t5iSeqFyH3OVSmxHsHk1HoxODgRd9n3oCylvnf67MePvmdiA5zgUkbQkvvrnteHlfNIZ2trF9ZdaLEWYO/dHPj5UcWrrkkFjwcFLpN0F79y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(921020)(5023799004)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mcjf/YmsSEg2MUv/NodeW6+0HeVxTzhUvGU5pZBVBIteAlFEbETa51abDj?=
 =?iso-8859-1?Q?fFTiaG7bVC1e7YbUa5YGLIbeDdx/XQtx4IRs+Nc7VYR6h3XSbiogffyIdi?=
 =?iso-8859-1?Q?jsTxFiaHnqhsexPiVIitzs2k3/CRoR0kCWShoedqIrMQosFYgQTzBpBnu3?=
 =?iso-8859-1?Q?jvwt3Dq4zeHBMcgybCjFtrshcaxn3WzIzb1DdS/PzrbJn8qne78++VxrIs?=
 =?iso-8859-1?Q?pASvS7vOp78aZ/oW9VBoGFNPHg7CsD929ihxgOZnBzYc/I1YrTVrbKi6C0?=
 =?iso-8859-1?Q?SnXXtbEwwN4mKoMQ6bGi/T1jIYMRFw2XvkAPENyOalgLKx4Rlb+3RucBgM?=
 =?iso-8859-1?Q?R0W73ynr13XwV0iNyMQ4DTKyIxDD7Q4tYlPfuIXZKQN3jugD+y8s+fZKIg?=
 =?iso-8859-1?Q?VyGEzMKd5ziYUjNDvQqzBt1/mDgt6vZwTt8LChG8BIOqg0FigiZcInpEQV?=
 =?iso-8859-1?Q?QifbmjUuDR5js+M6joVjTKfmVWSfRG3y3/1lTpnTfdfWBsAi5st3TqKD7j?=
 =?iso-8859-1?Q?fgqPXyGqOfrKMQnSL1+4P9n+RlvaHNSJDEuxfRTKZjYvHG5WPlodWPFCPA?=
 =?iso-8859-1?Q?S5tisDTj9na3cxf4Dhv4QN4cWW3fdZdHYyN5n2WmoykFL7cNQltCHzLIvH?=
 =?iso-8859-1?Q?OdgOHbmLABBSZeqRPavFxaKY7egadReR8uCSSMAeKG6NKhj9e3NRpW+BT/?=
 =?iso-8859-1?Q?/3Be7YZwfjsU5bgxPX6Yu8TA4O9AzeLpAzXYVlaAK4rHvRdlTWWEXjhvSn?=
 =?iso-8859-1?Q?kTfgvhAgfP97I1uBCcoDMyGrCV73WjcIhTnaK6iIns/0ij8untf4OAIhqt?=
 =?iso-8859-1?Q?zRKHfTtZUYbWh6jjJBCbMkeqy4TxvR32VfZpT2Nu0/W9dkGuQ8nSrYoC79?=
 =?iso-8859-1?Q?xOqVft4XmW4XQJdpCU3buXptuiRKXnHGMoWG328JPKhpTweTJNLI1VvagS?=
 =?iso-8859-1?Q?d37wUmvEP1Uv4W9/LHJMQqWQkhngVuqGweh9h/chUS2EEomwb29LJQJKZr?=
 =?iso-8859-1?Q?WaUCc5CPAGU8T8NlrsK1H2gMLhEESO3nmKyd2NS7QCbUPJoe3g5YSX2IoQ?=
 =?iso-8859-1?Q?hkdRjHelG4LAkrSaU5VqQU/2cSa4V76LqBd6nbC64lOIVT/YUy9kGMoSdT?=
 =?iso-8859-1?Q?SIX5Bs0gMco+OPO/AzY/16RfCXT9atJKz65sr6DHunqhEtj7AML8zg9WnR?=
 =?iso-8859-1?Q?yAOpcnJWLysYYDMrXysUhjMTyMd2UCOYReTzLbLHddzkcjcPuBpZ4/FJq5?=
 =?iso-8859-1?Q?QfdbWXv/WA0lDqOwD9nS1ZlsOso2Xf8QvbKFRb4iuWbnShHKLyWhY80I/K?=
 =?iso-8859-1?Q?CfHcFSd/s7uGW6pamqzk7MnTm7ceoAgaWvIlsKs10DgIFjeTYwdVSusKOM?=
 =?iso-8859-1?Q?BQUk2ZS8TaU9UeUK37wGWR7g0sw8O1LxfVtMM9ZNAKboxqxhovDj5txtIL?=
 =?iso-8859-1?Q?FFaZYn9CSGmgG4hwm5DMgkqdYHzV3tAM03o9WaVziesgOrQILfAhJDHZml?=
 =?iso-8859-1?Q?S2D44IcsJYFQHKmBs92In6T5J8+ewqzohwz1S+WbMo8IQDtHfp6aqeFZMb?=
 =?iso-8859-1?Q?kdMFb5gSCG+U4w1tY1ejxHAwZB+Km9BniRzDFPz3D0EjtT1A2sF/KumrT2?=
 =?iso-8859-1?Q?0oQPHom6oaGhr6a/XPEfm0yMCv23oJ/SWdv0+qnRq5rGOq800R4l6hzvp/?=
 =?iso-8859-1?Q?lNyIwG2YSOmBuxQ4xwCYF1Y6OXONS1rAEGivrhPIA75E+gUUofMXzgvWdO?=
 =?iso-8859-1?Q?pHKGFCEu2TW9nuTmbt0YsxGVUHN5HDMXW2//tSgIoeYDtV0SLnrpgu4K0g?=
 =?iso-8859-1?Q?Sq9269Nhiw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZVlitd7QLMyct3WtxijfyFSlQxjnvqgFAKi6gFnpjnsZUNVComYZBy5bJ4FYvJRzKMl2am+ItF5ojYzCnKxFe1fqZMcdHCNK2rck81w7Xeb31qJ3okWO69BWqUo9Vq7ww2WcqPmISAHSDxjb+c1eJB7RjPodMLsiok3DIqjqfx7TZ6Emx9mrYi54ycjfURyeG+i23XH7tnISUR/GwkiCvHUWy3HX/bCA0LN3KZ6u6tgavHKJ9R3zs5vna3n7eE2bYSKQX4zhC1bjcbl4n0e4aiLcbsgiKIfJZraX15u6uQhVCoU6d1wdgrGKqECJEwRfjaf4kyb3Mq2RAQx1CVFrpA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d4798f-dead-4aa2-b50f-08df2a9f7e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:21.3359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wD3UTt844tK2Zgq+TcPqqpBlmLeqUpq5smJukXmeSFYnCHVaP/cf8nozCSfjySuuXh8cT+Xz046XrJ1OmsMCESIx6DMUfTbo+YFk4x+LJCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5527
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
 hw/usb/redirect-server.c | 284 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 290 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index bc883add0e..a48b821642 100644=0A=
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
@@ -94,6 +118,232 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -102,14 +352,46 @@ static void usbredir_server_realize(DeviceState *dev,=
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
@@ -125,8 +407,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
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

