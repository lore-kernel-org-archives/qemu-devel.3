Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76445CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjco-0001ag-Jf; Mon, 19 Oct 2026 05:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcH-00013Z-Tq; Mon, 19 Oct 2026 05:25:17 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcD-0002q3-Aq; Mon, 19 Oct 2026 05:25:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHgr/MJgGysBOJ74FVknIZ3CXhqbfs2jqiLJoAdiwfsL1JCPf5Gi3Sz09esyHs3nIY8BdybJO2nQLbX8O/T20LWRzkd2b1egFZDLH9IMWyMhpR3EFQtxFW3oaew+ZdA31PUr21XTIbt7EgQkeYfNFU99K0pucFBKn27PFjJip5ztDJK1eBoAaVV4NujcP6bmpq3Hts25wV7UcS+DfVdZBnuXSpQErXbUkaHNXrVAurf7iYvivUJjjYC34v34JF5ALZHcvgdvR3iEm+fXDWmBTN2b3yb7/teLws0yhZiuIgePEn2iHBaLfpSSiINr4ji7F+SxX+YivUWz52RDfmBd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDwKo/OPqu468bbvazCVJNFp4/EqZSw5M/eXZDUFjvQ=;
 b=IvLcw20GHoCjnPFZU3ODWysxfwKaeD9lo8mU8zTZebmkmz2x2HTXAA4ohE8R9Sc3VgCBUjvRMv1TdzmqLk4kT+QA012Bu7YC61BRU9GgR/EQaqQAFKNl4/dFNB7C+OoV7V8txxFCymdQBuLg3T+n6g24BqXwFaQmyAurMa4WHdyuc5N3HSIGqF3srQGTrDwSNlrfLhF/DpThLLi7KNhqdc1/qkAQ1sSpchlaEb+t4I8jk/bXkpwbUXTVGpLxbHS6exY2gsLC33zD9tETUJne7tbhFggLsMOFNY8S0fZ9XRe/tDnfr49MomFcJ+ouXT1/XooJJdpi0X/gHUuZ6cOmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDwKo/OPqu468bbvazCVJNFp4/EqZSw5M/eXZDUFjvQ=;
 b=emKTZ5UEhoNoq1L4K6vDfntT9VbA12rgKjmHjiU5BACnk00sYEpJOVl4BnyFs3yLItw2gEOP8Q4Y+ujA801lLYACRiGZEINtWKC6vPHbNNLgib6/JcOW6Y+o7R/4rIbH6SSmslhoO7/m+Z8+Fcw2/Oh5o1eD1lj7MnQxfZNjZGF+3BQpo47c8ZCkzdgQqloSms+fIAQ8w2oC11d5jcb4pVW6YPJEkitoO3lUb+YFM4qyLlf4nMcazYqbMey6NYFiui+qOqpw3isubOrEfw3UHCAM0Vcqif3eBrxDdRvjVxBBQFw9D6Ii4hB7VJlEGbesiGYW38DUOAnsSgv3BmB7+g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:55 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 5/8] hw/usb/redirect-server: Implement control transfers
Thread-Topic: [PATCH v6 5/8] hw/usb/redirect-server: Implement control
 transfers
Thread-Index: AQHdX6uzsNgpvb33CkmJcAzYvN6qDg==
Date: Mon, 19 Oct 2026 09:24:55 +0000
Message-ID: <20261019092448.278079-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: d0331081-d72f-442b-9c71-08df2dc2d663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|38070700021|5023799004|10067099003|261009221227099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: CeQnT4eZVT47IlrwPKk5qcpvXb70sINUwIn1RZVQGwtPmOAcYvLsAPypwBZQdDrK0tIXmMxyz+61Ct9l8wy1SL2hJUEIePfiAlchvtPmVkr8//IEn9CnC31g7CYG3mFlO6Lv50/Ymr/QHr9kxFMc/q8m6oVosRLYogFijyCd0qJ3vbqRfiLak3TCtNqdd9gE7qZYSnSvQtgDhifhmd5uMhDxU00gSwp8RDoj9UC38HyTnw1w8tMu6RutEt2NSjZVNwNyqhQYZ4R8oPBGv+GzgH13vy7ooargwFsla3+dCIUfvBJq1PRK9hUXUN1IzHESyhnra40h+qpCcJjsMvLuwG6GAttr2JrnFJwPcT+6UVcVFrW69duW+in7pH/UhI68Q9PNWh3iE6tteXL2I+c/Z/Hn9TcauMdkyxvVnMYLDX76U5g92stD6PeMy0zGTaG4/aRwInyUYjVrFs7C6jzqbs/cVXw51znSlvosRiebh0mNw9wuSJsm2ups7rwKCCHmWpKZuodG/O74LbPe7j5+E95U+TKPgccCTFFEW5RXBC2wKyUD63yzFTaAbCQZy49YZK/k54IWX2bGHw3aoIVUcdW4/2tGZ7I9Gg27eIbPJOQ1YEd5btkcyWIjTuA6vriO48Yf0ZpxtaP9dlKMp3qDQnWZJAKAVRyDRtnwSr6MLWifpqvmWuSMWQCjeBYnRBuibqZMO49s7tkNG+UJoYuyoj7j9q0HTi+WhbsZY40GJgQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(38070700021)(5023799004)(10067099003)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AgXquy1udR4dvtiXrPhN2JCcdyj1QDVgOs+QGkMxBlRP/UaRvN3F4pX54t?=
 =?iso-8859-1?Q?+QVVb/8v2F9btRXGLRYg8pTCEhllekJ++7fQ17SZ/tQhPMLluzHa6l0idb?=
 =?iso-8859-1?Q?ppw7uGRTMXkMeMF8EvnS/GTEVsz1PGmpbH2txDz2brtj1ZTKfEpUeVj1yc?=
 =?iso-8859-1?Q?IVzG71k1Zz2qGrmiMctEPKIFRLDfTAERMpPuHgkEW2SRgJ591vFFNEKi2J?=
 =?iso-8859-1?Q?u6XIGtO9uAcq8rbZsk/6Tco3OpTHQ8sMrbmxgjXpScls0Q2fFubePQqhrg?=
 =?iso-8859-1?Q?oS9NeFnKq4X1Qfa6InIfgpbF+9E82SSdlHgVLGAl7MCBX47pP0IuIHtO/8?=
 =?iso-8859-1?Q?bM+prn2swagBzyS2EfpylsLLHKigMHlEzouxLVLToA8RZdAQbA4NqojzMn?=
 =?iso-8859-1?Q?VSN4aWuVySnFSkfnFZLOF7/YH/NjP++JNfkhmdMDamI9Ram5Fpo8uXHNhQ?=
 =?iso-8859-1?Q?/oFV7BgYrU0KFthCyx1uGkgUjBCwdUpm+gZqMDkOZprDGUEgCB4YtHY746?=
 =?iso-8859-1?Q?eC0N8VuniInFNO+w+teXLqvkA69O9WB/2gqRY7ubpwziZ3OurFECgw6AbK?=
 =?iso-8859-1?Q?lRZAj4iirfDp3VQVtQD1PjmQ5a1qevG5GlIxZfiNZok9gG3/SzgspNiK8j?=
 =?iso-8859-1?Q?zmC7BgMBU7seiUuJ+DRmLJCy95h/jVgVWLlG16z5/QWhsvQySXMlkdSIVQ?=
 =?iso-8859-1?Q?Rjt+qGH8j8bLSq0bLScph0QXDo53xdZeyxirtSJxgb30kcQY7u9lbf/VYI?=
 =?iso-8859-1?Q?rFKm17KzDyWwL+ohpsRH4LRGK6ad5CR/VGa/DwEWB/FXgps9uwHESuPqts?=
 =?iso-8859-1?Q?wi/AegVLnL87XiWWt2frSraIR2iP93yKbAPDVPVEcMpu69u9NY0DExL4z+?=
 =?iso-8859-1?Q?z38XwGt76RyA3wTZKzjWLcqlzuhwj83FpDxY5gy9Sobna8NUv7/gMu8aYO?=
 =?iso-8859-1?Q?4UffQdUKbhycYlKZpAEIAeo4p6IEiFTnWKYpJv6AiyjsY+ji+oDzLS1ZEF?=
 =?iso-8859-1?Q?n38VYrUJn7YHPNNcNREIioBrvC0Fz6JpiaRUkwIo/jtAPBYOwfprLzv5X1?=
 =?iso-8859-1?Q?VBr8P2NuH1o9O50dwY7FJKeRfnhA9oJ7aRvQpb1QhocdD2BqhVgz4Wa1Qi?=
 =?iso-8859-1?Q?BQ/2F+F9gTdfYKaVtXjvJzX+yZlg5MX4yN+7tdiKd1MIy0lIs7W3hIM3g/?=
 =?iso-8859-1?Q?XdtJwLR7RAUScyiNIPxKDSlhWBpsBrhIYTEYkG60rJ5bQxvWn+QdZVjecw?=
 =?iso-8859-1?Q?zpuyNkS1BJF6P0P4XTka1wPe0MZtx1txyzYw9N3Ucjaa0CL+D/Jh7ZK/gv?=
 =?iso-8859-1?Q?PKkS1RGeab37tebgiI10wqKU/dwWw7rhL2v0Qujm6794vv9fy3gNVH5uTC?=
 =?iso-8859-1?Q?Eji+CpuvqgsF4EF4Bwr/PfB5kBsf48dw1JeOF7+tVcRZJXLSdPC8JfmdGU?=
 =?iso-8859-1?Q?x98ATRkDyE/b6GvZ4Mh/+Y0LbmZZA4pYfU9WmattjOmL26ZPhJ7CT8zD89?=
 =?iso-8859-1?Q?FjGmtBJlkeyyLWWfiJG1aryJEHSewnseh1gG7+uuQYIk0SBxVLF8v9wU14?=
 =?iso-8859-1?Q?m+CO6rIPiO4EsHD/ByOGgzq1bQP8xgFpeX9z44n28W8ZgUtXn3ahwr005y?=
 =?iso-8859-1?Q?39NBZY05k1AuSBlPKfxkRFWeMtxmp+9JzuLC2GhCg2JXulZiIqhsEcFDRr?=
 =?iso-8859-1?Q?uFVJLFA+8M/QQ6Vl+V58cSzlZJo/0KrB/ah3lPcvK6nweThRhYuSLSj4FK?=
 =?iso-8859-1?Q?1SIro3K38ALgwoqE76UkPoX9SmjrNwaKunFB/WQtKHwu1fKU0y1uiOhDfC?=
 =?iso-8859-1?Q?pVNKIVI/nw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0331081-d72f-442b-9c71-08df2dc2d663
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:55.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nqG2ocjXwAMGLVv4N/cc1hSpW7eE/iCG5dQJKz/q8dqKmbRH+gxL0Qx2vsXHFffnIQ51XE0zEcpth15A6KfV8WwjGJEVXZ+7xLaSmyXBiQ=
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

The host sends a control_packet. Turn it into the SETUP, DATA and=0A=
STATUS tokens the QEMU USB core wants, run them on the device, and=0A=
send the answer back.=0A=
=0A=
The device may answer later, so we have to remember the packets we=0A=
sent. Each one stays on a list until it comes back. We drop the whole=0A=
list on a bus reset or a chardev close. When the host asks us to=0A=
cancel a packet, we answer it and drop it. If it is no longer on the=0A=
list we already answered it, so we send nothing.=0A=
=0A=
usbredir has its own messages for set_configuration, get_configuration,=0A=
set_alt_setting and get_alt_setting. Each one is a control transfer, so=0A=
run it like one and send back the status message.=0A=
=0A=
usbredir wants an ep_info message. It says what kind each endpoint is,=0A=
how big its packets are and which interface it belongs to. QEMU cannot=0A=
tell us. It only knows after it has read the device's descriptors, and=0A=
it never reads them for a device that just forwards transfers. So we=0A=
read them ourselves: the configuration descriptor passes through us on=0A=
its way to the host.=0A=
=0A=
A device can offer several configurations, and an interface several=0A=
alternate settings, each with its own endpoints. Keep every=0A=
configuration descriptor, build the table from the one the host=0A=
selected, and send a fresh ep_info when that selection changes, so=0A=
ep_info never describes an endpoint that is not there.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 745 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   9 +=0A=
 2 files changed, 753 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index dc4bb53383..29a9fbc941 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -63,9 +63,11 @@=0A=
 #include "qom/object.h"=0A=
 =0A=
 #include <usbredirparser.h>=0A=
+#include <usbredirproto.h>=0A=
 =0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/qdev-properties-system.h"=0A=
+#include "desc.h"=0A=
 #include "trace.h"=0A=
 =0A=
 #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
@@ -73,6 +75,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
 =0A=
 #define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
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
@@ -92,8 +129,27 @@ struct USBRedirServer {=0A=
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
+=0A=
+    uint8_t alt_setting[USB_MAX_INTERFACES];=0A=
+    GHashTable *config_descs;=0A=
+    uint8_t config_value;=0A=
 };=0A=
 =0A=
+static void usbredir_server_pkt_free(USBRedirServerPkt *rp);=0A=
+static void usbredir_server_stop_transfers(USBRedirServer *s);=0A=
+static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
+                                           USBRedirServerPkt *rp);=0A=
+=0A=
 /*=0A=
  * The device is whatever USBDevice the user plugged into our port with=0A=
  * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
@@ -104,8 +160,170 @@ static USBDevice *usbredir_server_device(USBRedirServ=
er *s)=0A=
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
+    addr =3D desc->u.endpoint.bEndpointAddress;=0A=
+    ep_nr =3D addr & 0x0f;=0A=
+    idx =3D (addr & USB_DIR_IN) ? ep_nr + USBREDIR_SERVER_EP_IN_BASE : ep_=
nr;=0A=
+    if (ep_nr < 1 || idx >=3D USBREDIR_SERVER_MAX_EP) {=0A=
+        trace_usbredir_server_endpoint_dropped(addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep_type[idx] =3D desc->u.endpoint.bmAttributes & 0x03;=0A=
+    s->ep_max_packet[idx] =3D (desc->u.endpoint.wMaxPacketSize_hi << 8) |=
=0A=
+                            desc->u.endpoint.wMaxPacketSize_lo;=0A=
+    s->ep_interval[idx] =3D desc->u.endpoint.bInterval;=0A=
+    s->ep_iface[idx] =3D iface;=0A=
+=0A=
+    /*=0A=
+     * bInterval says how often to poll this endpoint. Pass on what the=0A=
+     * descriptor said, but never 0 for an interrupt or isochronous=0A=
+     * endpoint: redirect.c throws the whole device away when it sees 0,=
=0A=
+     * so store 1 instead.=0A=
+     */=0A=
+    if (s->ep_interval[idx] =3D=3D 0 &&=0A=
+        (s->ep_type[idx] =3D=3D USB_ENDPOINT_XFER_INT ||=0A=
+         s->ep_type[idx] =3D=3D USB_ENDPOINT_XFER_ISOC)) {=0A=
+        s->ep_interval[idx] =3D 1;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_save_config_desc(USBRedirServer *s,=0A=
+                                             const uint8_t *data, int len)=
=0A=
+{=0A=
+    const USBDescriptor *conf =3D (const USBDescriptor *)data;=0A=
+    uint16_t total;=0A=
+=0A=
+    if (len < 4) {=0A=
+        return;=0A=
+    }=0A=
+    total =3D lduw_le_p(data + 2);=0A=
+=0A=
+    /*=0A=
+     * The host reads this twice. The first read is a few bytes, just to=
=0A=
+     * learn the length from wTotalLength. The second read has the whole=
=0A=
+     * descriptor.=0A=
+     *=0A=
+     * A configuration descriptor is 9 bytes, so a shorter one is broken.=
=0A=
+     */=0A=
+    if (total < 9 || len < total) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    g_hash_table_insert(s->config_descs,=0A=
+                        GUINT_TO_POINTER(conf->u.config.bConfigurationValu=
e),=0A=
+                        g_memdup2(data, total));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Some devices only forward transfers. They never read their own=0A=
+ * descriptors, so the USB core leaves their endpoint types at=0A=
+ * USB_ENDPOINT_XFER_INVALID. Sending that in ep_info does not work: the=
=0A=
+ * host sees type 255 and will not move data. So read the configuration=0A=
+ * descriptor and fill the tables here.=0A=
+ *=0A=
+ * Only what the host selected counts. A device can offer several=0A=
+ * configurations, and an interface several alternate settings. The=0A=
+ * endpoints of the ones not chosen are not there.=0A=
  */=0A=
+static void usbredir_server_build_ep_tables(USBRedirServer *s)=0A=
+{=0A=
+    const USBDescriptor *desc;=0A=
+    const uint8_t *config;=0A=
+    bool active =3D false;=0A=
+    uint8_t iface =3D 0;=0A=
+    uint8_t alt;=0A=
+    int i =3D 0;=0A=
+    int total;=0A=
+=0A=
+    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));=0A=
+    memset(s->ep_max_packet, 0, sizeof(s->ep_max_packet));=0A=
+    memset(s->ep_interval, 0, sizeof(s->ep_interval));=0A=
+    memset(s->ep_iface, 0, sizeof(s->ep_iface));=0A=
+=0A=
+    config =3D g_hash_table_lookup(s->config_descs,=0A=
+                                 GUINT_TO_POINTER(s->config_value));=0A=
+    if (!config) {=0A=
+        trace_usbredir_server_config_not_found(=0A=
+            s->config_value, g_hash_table_size(s->config_descs));=0A=
+        return;=0A=
+    }=0A=
+    total =3D lduw_le_p(config + 2);=0A=
+=0A=
+    while (i + 2 <=3D total) {=0A=
+        desc =3D (const USBDescriptor *)(config + i);=0A=
+=0A=
+        if (desc->bLength < 2) {=0A=
+            trace_usbredir_server_bad_descriptor(i, desc->bLength,=0A=
+                                                 desc->bDescriptorType);=
=0A=
+            break;=0A=
+        }=0A=
+        if (i + desc->bLength > total) {=0A=
+            trace_usbredir_server_descriptor_overrun(i, desc->bLength, tot=
al);=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        switch (desc->bDescriptorType) {=0A=
+        case USB_DT_INTERFACE:=0A=
+            if (desc->bLength < 9) {=0A=
+                trace_usbredir_server_bad_descriptor(i, desc->bLength,=0A=
+                                                     desc->bDescriptorType=
);=0A=
+                break;=0A=
+            }=0A=
+            iface =3D desc->u.interface.bInterfaceNumber;=0A=
+            alt =3D desc->u.interface.bAlternateSetting;=0A=
+            active =3D iface < USB_MAX_INTERFACES &&=0A=
+                     alt =3D=3D s->alt_setting[iface];=0A=
+            break;=0A=
+        case USB_DT_ENDPOINT:=0A=
+            if (desc->bLength < 7) {=0A=
+                trace_usbredir_server_bad_descriptor(i, desc->bLength,=0A=
+                                                     desc->bDescriptorType=
);=0A=
+                break;=0A=
+            }=0A=
+            if (active) {=0A=
+                usbredir_server_record_endpoint(s, desc, iface);=0A=
+            }=0A=
+            break;=0A=
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
+    usbredir_server_build_ep_tables(s);=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        ep_info.type[i] =3D s->ep_type[i];=0A=
+        ep_info.max_packet_size[i] =3D s->ep_max_packet[i];=0A=
+        ep_info.interface[i] =3D s->ep_iface[i];=0A=
+        ep_info.interval[i] =3D s->ep_interval[i];=0A=
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
@@ -145,6 +363,165 @@ static void usbredir_server_announce_device(USBRedirS=
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
+            usbredir_server_save_config_desc(s, rp->data, actual);=0A=
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
+    if (status !=3D usb_redir_success) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Two requests change which endpoints exist. SET_CONFIGURATION picks=
=0A=
+     * a configuration, SET_INTERFACE picks an alternate setting. Record=
=0A=
+     * what the host chose, then send a fresh ep_info.=0A=
+     */=0A=
+    switch ((rp->ctrl_hdr.requesttype << 8) | rp->ctrl_hdr.request) {=0A=
+    case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:=0A=
+        /* A new configuration puts every interface back on alternate 0. *=
/=0A=
+        s->config_value =3D rp->ctrl_hdr.value;=0A=
+        memset(s->alt_setting, 0, sizeof(s->alt_setting));=0A=
+        break;=0A=
+    case InterfaceOutRequest | USB_REQ_SET_INTERFACE:=0A=
+        if (rp->ctrl_hdr.index < USB_MAX_INTERFACES) {=0A=
+            s->alt_setting[rp->ctrl_hdr.index] =3D rp->ctrl_hdr.value;=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    usbredir_server_send_ep_info(s);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -165,12 +542,23 @@ static void usbredir_server_port_detach(USBPort *port=
)=0A=
 =0A=
     trace_usbredir_server_detach(s->device_announced);=0A=
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
+    memset(s->alt_setting, 0, sizeof(s->alt_setting));=0A=
+    g_hash_table_remove_all(s->config_descs);=0A=
+    s->config_value =3D 0;=0A=
 }=0A=
 =0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
@@ -183,11 +571,46 @@ static void usbredir_server_port_wakeup(USBPort *port=
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
+    if (p->status =3D=3D USB_RET_REMOVE_FROM_QUEUE) {=0A=
+        usb_cancel_packet(p);=0A=
+    }=0A=
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
@@ -197,6 +620,54 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
@@ -312,9 +783,202 @@ static void usbredir_server_reset(void *priv)=0A=
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
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    usbredir_server_do_control(s, id, hdr, data, data_len,=0A=
+                               USBREDIR_SERVER_REPLY_CONTROL);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
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
@@ -338,6 +1002,70 @@ static void usbredir_server_interface_info(void *priv=
,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
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
+     * Not on our list means we already answered it. The host uses the=0A=
+     * id to find the request, and the same id is used again later. A=0A=
+     * second answer could land on the wrong request. Send nothing.=0A=
+     */=0A=
+    trace_usbredir_server_cancel(id, false);=0A=
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
@@ -360,13 +1088,19 @@ static void usbredir_server_create_parser(USBRedirSe=
rver *s)=0A=
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
@@ -398,6 +1132,8 @@ static void usbredir_server_destroy_parser(USBRedirSer=
ver *s)=0A=
 =0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
+    usbredir_server_stop_transfers(s);=0A=
+=0A=
     if (s->parser) {=0A=
         usbredirparser_destroy(s->parser);=0A=
         s->parser =3D NULL;=0A=
@@ -487,6 +1223,11 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    QTAILQ_INIT(&s->inflight);=0A=
+    s->config_descs =3D g_hash_table_new_full(g_direct_hash, g_direct_equa=
l,=0A=
+                                            NULL, g_free);=0A=
+    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     s->bus.no_auto_hub =3D true;=0A=
@@ -511,6 +1252,8 @@ static void usbredir_server_unrealize(DeviceState *dev=
)=0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
+    g_clear_pointer(&s->config_descs, g_hash_table_destroy);=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 2cc6a244b9..0ed20838b2 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -406,3 +406,12 @@ usbredir_server_announce(uint8_t speed) "device_connec=
t speed %u"=0A=
 usbredir_server_disconnect(void) "device_disconnect sent"=0A=
 usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
 usbredir_server_filter_reject(void) "host rejected our device"=0A=
+usbredir_server_cancel(uint64_t id, bool found) "id %" PRIu64 " still in f=
light %d"=0A=
+usbredir_server_ep_info(unsigned idx, uint8_t type, uint16_t mps, uint8_t =
interval, uint8_t iface) "ep_info[%u] type %u mps %u interval %u iface %u"=
=0A=
+usbredir_server_config_not_found(uint8_t value, unsigned have) "no descrip=
tor for configuration %u, we have %u"=0A=
+usbredir_server_bad_descriptor(int offset, uint8_t length, uint8_t type) "=
descriptor at byte %d is too short: bLength %u, type %u"=0A=
+usbredir_server_descriptor_overrun(int offset, uint8_t length, int total) =
"descriptor at byte %d runs past the end: bLength %u, total %d"=0A=
+usbredir_server_endpoint_dropped(uint8_t address) "endpoint 0x%02x does no=
t fit our tables"=0A=
+usbredir_server_control(uint64_t id, uint8_t requesttype, uint8_t request,=
 uint16_t value, uint16_t index, uint16_t length) "id %" PRIu64 " type 0x%0=
2x request 0x%02x value 0x%04x index 0x%04x length %u"=0A=
+usbredir_server_ctrl_setup_complete(uint64_t id, int status, int actual) "=
id %" PRIu64 " status %d actual %d"=0A=
+usbredir_server_ctrl_status_complete(uint64_t id, int status) "id %" PRIu6=
4 " status %d"=0A=
-- =0A=
2.43.0=0A=

