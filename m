Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D66606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=C6dWbIa0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuYF-0004v5-7D; Tue, 27 Oct 2026 23:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuYD-0004u3-7k; Tue, 27 Oct 2026 23:42:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY6-0005ca-UU; Tue, 27 Oct 2026 23:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syW632amLal9ZGn7CkDPoK0Y5qLmkWXs7PbdDCvYP3aNWjoIbXNzl8oCnFFVZ1K4UNjlslix8CS00UOGcrZrp1Ounxw0Umah1jVUs3/bqDXd7WMYzpyNRxSrgfVUk1ewsZBEeM7gbyA+Ak6mQltA2BvbkQzdBbx3awX0CYX5gh7ihG8ISJs4vwk4ychGEaaiV9pkmVLCQPNIUVvZ4Cb7AZuDX7xiUI3iRJmuiSnDf7T1hbHwhX9pBVEjzX3G2f3yVHF9Y91Nnw7G3Hmn26nlagMEgIpKJh/ierznyeqmq9cNzYjolTJeAoPdvL16Ntny50VTlY1ctPdIKsPuqhNpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dud85uuBtgyMBC0iCOTe5WXf3ksLz567Uva9mp6rRcE=;
 b=GrSl9GFzc4GAmr9U4szTo3HgbQYuS0QYdUcJYFdtBRXpYrzudvf6dLKgb12qrpMBXMIkt0QrWH2fMncofm7mM16uvDOttOFuOmjG56IVW0kUjOPWuqjUc9mkw1m7wKMofN38FvppsKqq2Qk3vN2hgB7mAxBFu48htf7RicWE2s5pVsH0YSUbBEsaVnihszFX7Pp6UvMP74vkv7xjqZAtg8hZGrbaQb1IkqzL/UdNrGZTMCSX+2jp3r61pJI2KXmz4LdUwv20HTPJiBOrxXEaiHZrY1XJ0VzzhfQhR4mmNkodhNjchNxuPJ4hkeFrh1j8A6EZVRwCo9CFN+FSHO2bNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dud85uuBtgyMBC0iCOTe5WXf3ksLz567Uva9mp6rRcE=;
 b=C6dWbIa0dTaMg+6AC6UTRWHSmJWpwBf/wqqBEYdu/p49skU3WKIzJxV3y1sYHUS71aR7ZEPEDGOdpNT5GVmWLEpV8VFhtLvNtwPfusWqwBe+tukkTT7u5jbgDSX+Tm+7pfpJyZuySMEgVLQD50LO8Iaik0ph2XuBWPifg1kyanPnD5M6XtZylUuIabnhM53gJRprTKUdLJWmgUNd6KfmntOyOAvrwVD7RTtg+GdB2t9qe1fW0v0SK8OOJKvkoKI4hRPsJJrhIVUBG1s/mX1wlvjxRJt9PFzpikaS9jHnuqU0Qgw4ndzPW6uJycOpYg6xIrkRh0KX0dFRwL0sijB+Rg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SETPR06MB9120.apcprd06.prod.outlook.com (2603:1096:101:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Wed, 28 Oct
 2026 03:41:47 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 5/8] hw/usb/redirect-server: Implement control transfers
Thread-Topic: [PATCH v7 5/8] hw/usb/redirect-server: Implement control
 transfers
Thread-Index: AQHdZo5C/tNGsMVwYkaVwNVSJMsTRQ==
Date: Wed, 28 Oct 2026 03:41:47 +0000
Message-ID: <20261028034140.367393-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8d3b18da-4bd7-42c7-b7c9-08df34a5648e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026135527099003|261026140227099003|38070700021|261026130827099003|5023799004|10067099003|261026121527099003|261021123027099003|261021121427099003|261021135927099003|261022113327099003|261022075727099003|261022115727099003|261021133027099003|261009221227099003|261009223027099003|56012099006|261022105027099003|261021130227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: ZO+kN4jJ3oneg6Kas/JxK3I3BguVReDMCiPf6tLbd79Hw9gCU/xhFQ1XMd7EyP3MBwzaMjAzn2wR8PzmasbMyPA1BkG1MfOO8sp/4gz/BEr0i/yPWfeskpNPzIF0UolQtb2MiePkp+ETyr8VH5KwFhBc8Z0lYGqbUPzWWwXqEriUWQDjGLzihuPoJ66szNEUbeGDk9hRjBVWfQSAmeExwUtwLR+TQIzy+7HRXaXsKAdr9ePn1cnBw6i+Da1qDkR8eO94cSGzWLxWFQI5S5rnloYxbnc8+abby0ytSZ6gkc0xzVxOGJFL3cP4+skLh+iNiatQ3hcdeCJ3rI3Krt9bX7FaPdhmvss8/CO3/40qZVEp+5I6jxIFf4cfweRkoD8XC9gsKZmsuZ/CMuM8kL8tYlGBoG9F55V3ZE4a47gRbT12RVnHgmX0Csgz97yVdtzxPd2+7DkT8iJooKFVJszeZaZgp63yGciQn2fR35UVCb0VVkMgyKkq77fy/yUI2lxq3xXZLrn4+Rje2wcuGTGadUrXAXG+E926pbZEMBgscoD/Vu8882ONYlaEE/xjEPNN29G6GkEIaUOxvYgya+rrKFMBzMsxT5bGXEf6RpCNezu2Y92HDQCS6g/Zr6dffw18YC1ujgaccT25OBV8rqfsgQqwW9FFOrCt+1vyQdjhAEeEysMwHllRNPWMqwz1HJUhxURvqKk81njsUlD+2Fhih6GPwdRMGTARELqVq1z4E3U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026135527099003)(261026140227099003)(38070700021)(261026130827099003)(5023799004)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021133027099003)(261009221227099003)(261009223027099003)(56012099006)(261022105027099003)(261021130227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xTz0Dmyjd3LQQExJ0PAcfImT0lD1AjKkoWdVtZo6zTI4CrzeY7CXBHlrg3?=
 =?iso-8859-1?Q?mlaPz/q1LYz6cSz86KsVFURFAZUS9fdF8Z6KEtYn+P4S9SM+zVW4HE2T/x?=
 =?iso-8859-1?Q?i4NhJcoswre69LKLayxwZRoIoLzU2kR1nEiqAxrBHug7LC4rWHcJHjHqAB?=
 =?iso-8859-1?Q?s95Ytke/oXfAtY5eoMunJC3KjPeG/OT9gdTNoJ+8kBimtun28n2KBhcM8e?=
 =?iso-8859-1?Q?Ac5rJmv0T8FNAgPZXL5IuPk4tB1smbLZYNxJrxur9kESFk2IpJAMw8dt6m?=
 =?iso-8859-1?Q?y4Su3kW4pG8DbJZQWtU1xoyeI21wwONXEySCBrECk3cQoZ6Q1EQJzFpvZl?=
 =?iso-8859-1?Q?Gg1myp/vpKISUFYC0tFt9iSN4pPZ0WlNpSRHrFarGU0IPwAP3JpvdK9Cnh?=
 =?iso-8859-1?Q?bOAPEoZbaHlz5mFfeHR4in6vg9Kq7V3Ffst+qV0yRwZKPIKeZfYbRuo55v?=
 =?iso-8859-1?Q?HIkmumNWltJQ6fYxvMTLWX2Ggq4Jj/87j+hyPEnvEjAlDG6Ub6UUc7kk/g?=
 =?iso-8859-1?Q?2yqEl8GnbOzuLwmpQBqGXdj8J77vA3iTtphfkzHL/jq0fdBrwSURJBUVnr?=
 =?iso-8859-1?Q?B8Ql8ieizGe/Qh1nHMrz+yEfeGzyQUwN30zJzZiXeouoSNKVt638KsHEnu?=
 =?iso-8859-1?Q?ro8Teqk4mAZPv5TcIRTbPt5DBvoC9qS9Zpbj5Q1wg8a89jZoU2pol1Brjj?=
 =?iso-8859-1?Q?FqeHTkQ/9m3boOiFu1CZq4YGOwrnqWplxU8ptq2hR8WeUpHJS2wsddMeLW?=
 =?iso-8859-1?Q?klSBPf6PWARRh6rud0ZbGecdS2NvjnM67ePR0tXydmV2tH4Hsj/iRmhV2t?=
 =?iso-8859-1?Q?aEyoUmpg1nTHvRQYlhMM64PsjqEwtRgaSn/S2Hg0ZJBJ25IXgv/fq1ob0M?=
 =?iso-8859-1?Q?4kzqi1t2Hq2aO2rfUCBN2NjqJOSShtZmFjivWo5Txd3xxx35lXTmBVDwIM?=
 =?iso-8859-1?Q?gBeiz01H+RY6fKt5A1zqYWts23k3h/bVFw9hWllxpV5r+0EnuOSEgO0rSW?=
 =?iso-8859-1?Q?ZQIVh05KQbvPUw5IeC6Qad+mqQmUlcIt/OPfWiKD87GM1GQWQqDDE84Igb?=
 =?iso-8859-1?Q?bgS4RjUuCJWXgPBPXQu8zx1ww5cNBCyRPbHUDmcF7+QY6MqdADxv3tP566?=
 =?iso-8859-1?Q?Uz+JoahculNmFuxzPBvkRehmRVgLmy9ftj1CQARkG8Y3UDQx3j1voT4egx?=
 =?iso-8859-1?Q?PYYNyoFEGka7FfDTIGDA0E8MvGketSjKRqaR3NtrUSmPtnzG5XEJ4PZdv9?=
 =?iso-8859-1?Q?cq1eTLVl0myhR0zcoXluc3c8QtfWo+ecgUWoRqHkeBSFjYl+BYxz1TMqW2?=
 =?iso-8859-1?Q?kmqBQlwK+h8Tz8TKaXDIPmGf36PA6fc9ABdNPijByZU2jTNA0BfGr0IcJ0?=
 =?iso-8859-1?Q?/Iu9lfRemvqmAowDdTXb0TKCaq8KWDfPUCCJH0YRpVSk4MxyOCU22gF0LU?=
 =?iso-8859-1?Q?NzkiQLYZGxEzkayvF0rdUr7trsvcxbWELPeJGaixBxAFGqpEHYs9G2Nm+0?=
 =?iso-8859-1?Q?C174QbB6EHwo1NCXxrOecoGOCrpreMXznrcitcmkAd/H40i3cTb9UECi89?=
 =?iso-8859-1?Q?/aX7b6KfR3a5X3BQOlgZjnA3ZJb4bqZLgCz/oJNpk6rBbhbIS+WQh6kRAp?=
 =?iso-8859-1?Q?uAcRijBP1a9G1YrdcVUBTTuYN1vc1RZiNoIPl1TGAP2Lez401HsO6AjgFQ?=
 =?iso-8859-1?Q?VpAADJrLgjlPvzkpLPFOaESLwhZwJMRBmfuNayp34jsZt9lKGeuSmmD0CY?=
 =?iso-8859-1?Q?BUWaI7su2MUfrlje9/Uwo+FKvDkYNcI7DSvbZ3VsvO1sz7NN6ej+3iclDE?=
 =?iso-8859-1?Q?EYkPY1ROKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3b18da-4bd7-42c7-b7c9-08df34a5648e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:47.0654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4X4F+/yjyYkq38HGAetFLaHPvQoSrk03ay/fE2hBrc/YbVurH77ObfLwxGA8GB4kK+44kITS35QyjlQte7Fdey/IWjecvX0meSZ8T4IK9zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9120
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A usbredir control_packet carries a whole control transfer, so hand it=0A=
to the device as one packet with the eight setup bytes in=0A=
USBPacket::parameter.=0A=
=0A=
The device may answer later, so we have to remember the packets we=0A=
sent. Each one stays on a list until it comes back. We drop the whole=0A=
list on a bus reset or a chardev close. When the host asks us to=0A=
cancel a packet, we answer it and drop it. If it is no longer on the=0A=
list we already answered it, so we send nothing.=0A=
=0A=
A device can answer USB_RET_NAK, which means the endpoint has nothing=0A=
right now, not that the transfer failed. Keep the request and send it=0A=
again when the device wakes the endpoint. Not every device wakes it, so=0A=
a timer asks again as well.=0A=
=0A=
Every request is checked before we act on it, and one we turn away is=0A=
still answered, so the host never waits for ever.=0A=
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
---=0A=
 hw/usb/redirect-server.c | 813 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |  11 +=0A=
 2 files changed, 823 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index ad6e4c422b..61ac5473e5 100644=0A=
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
@@ -63,9 +64,11 @@=0A=
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
@@ -73,6 +76,83 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
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
+/*=0A=
+ * Ask again this often after an endpoint answered NAK. Most devices=0A=
+ * wake the endpoint when data arrives, and then we ask at once. This=0A=
+ * timer is for the devices that do not.=0A=
+ */=0A=
+#define USBREDIR_SERVER_RETRY_MS 1000=0A=
+=0A=
+#define USBREDIR_SERVER_CTRL 0=0A=
+=0A=
+/* Which message answers the host when a control transfer ends. */=0A=
+typedef enum {=0A=
+    USBREDIR_SERVER_REPLY_CONTROL,=0A=
+    USBREDIR_SERVER_REPLY_CONFIG,=0A=
+    USBREDIR_SERVER_REPLY_ALT,=0A=
+} USBRedirServerReply;=0A=
+=0A=
+/* What the device said when usbredir_server_ask_device() asked it. */=0A=
+typedef enum {=0A=
+    /* It took the request and will call back. */=0A=
+    USBREDIR_SERVER_ASK_ASYNC,=0A=
+    /* It has nothing now, so the request went back on the list. */=0A=
+    USBREDIR_SERVER_ASK_NAK,=0A=
+    /* It answered, and the request is freed. */=0A=
+    USBREDIR_SERVER_ASK_COMPLETE,=0A=
+} USBRedirServerAsk;=0A=
+=0A=
+typedef struct USBRedirServerPkt {=0A=
+    USBPacket pkt;=0A=
+=0A=
+    /* Kept for the usbredir response. */=0A=
+    struct usb_redir_control_packet_header ctrl_hdr;=0A=
+=0A=
+    /*=0A=
+     * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
+     * Allocated and freed with the packet.=0A=
+     */=0A=
+    uint8_t *data;=0A=
+=0A=
+    /* Every request is on this list. */=0A=
+    QTAILQ_ENTRY(USBRedirServerPkt) inflight_link;=0A=
+=0A=
+    /* Only a request that must wait is on this list. */=0A=
+    QTAILQ_ENTRY(USBRedirServerPkt) waiting_link;=0A=
+=0A=
+    USBRedirServerReply reply;=0A=
+    uint64_t redir_id;=0A=
+    int ep_idx;=0A=
+    int type;=0A=
+} USBRedirServerPkt;=0A=
+=0A=
+typedef struct USBRedirServerEp {=0A=
+    USBRedirServer *s;=0A=
+=0A=
+    /*=0A=
+     * Requests the device has not taken, oldest first. A new request=0A=
+     * goes on the end. We always ask about the first one, and a NAK=0A=
+     * puts it back on the front, so the order never changes.=0A=
+     */=0A=
+    QTAILQ_HEAD(, USBRedirServerPkt) waiting;=0A=
+=0A=
+    /* Asks again for a device that does not wake the endpoint. */=0A=
+    QEMUTimer *retry;=0A=
+=0A=
+    uint16_t max_packet;=0A=
+    uint8_t interval;=0A=
+    uint8_t iface;=0A=
+    uint8_t type;=0A=
+    uint8_t idx;=0A=
+} USBRedirServerEp;=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -92,8 +172,22 @@ struct USBRedirServer {=0A=
     guint watch;=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
+=0A=
+    /* Every request the host is still waiting for an answer to. */=0A=
+    QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
+    uint64_t next_id;=0A=
+=0A=
+    USBRedirServerEp ep[USBREDIR_SERVER_MAX_EP];=0A=
+    uint8_t alt_setting[USB_MAX_INTERFACES];=0A=
+    GHashTable *config_descs;=0A=
+    uint8_t config_value;=0A=
 };=0A=
 =0A=
+static void usbredir_server_pkt_free(USBRedirServer *s, USBRedirServerPkt =
*rp);=0A=
+static void usbredir_server_stop_transfers(USBRedirServer *s);=0A=
+static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
+                                           USBRedirServerPkt *rp);=0A=
+=0A=
 /*=0A=
  * The device is whatever USBDevice the user plugged into our port with=0A=
  * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
@@ -104,9 +198,212 @@ static USBDevice *usbredir_server_device(USBRedirServ=
er *s)=0A=
 }=0A=
 =0A=
 /*=0A=
- * Device announcement=0A=
+ * Descriptor snooping and device announcement=0A=
  */=0A=
 =0A=
+static int usbredir_server_ep_index(uint8_t addr)=0A=
+{=0A=
+    int ep_nr =3D addr & 0x0f;=0A=
+=0A=
+    return (addr & USB_DIR_IN) ? ep_nr + USBREDIR_SERVER_EP_IN_BASE : ep_n=
r;=0A=
+}=0A=
+=0A=
+static void usbredir_server_clear_ep_table(USBRedirServer *s)=0A=
+{=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        s->ep[i].max_packet =3D 0;=0A=
+        s->ep[i].interval =3D 0;=0A=
+        s->ep[i].iface =3D 0;=0A=
+        s->ep[i].type =3D USB_ENDPOINT_XFER_INVALID;=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint8_t usbredir_server_ep_status(USBRedirServer *s, uint8_t addr,=
=0A=
+                                         uint8_t want_type)=0A=
+{=0A=
+    bool is_ctrl =3D want_type =3D=3D USB_ENDPOINT_XFER_CONTROL;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    int idx =3D usbredir_server_ep_index(addr);=0A=
+    int ep_nr =3D addr & 0x0f;=0A=
+=0A=
+    if (!s->host_connected || !device || !device->attached) {=0A=
+        return usb_redir_ioerror;=0A=
+    }=0A=
+=0A=
+    /* Endpoint 0 carries control transfers, and nothing else. */=0A=
+    if (ep_nr =3D=3D 0 && !is_ctrl) {=0A=
+        return usb_redir_inval;=0A=
+    }=0A=
+=0A=
+    /* An absent endpoint has type INVALID, which never matches. */=0A=
+    if (!is_ctrl && s->ep[idx].type !=3D want_type) {=0A=
+        return usb_redir_inval;=0A=
+    }=0A=
+=0A=
+    return usb_redir_success;=0A=
+}=0A=
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
+    idx =3D usbredir_server_ep_index(addr);=0A=
+    if (ep_nr < 1 || idx >=3D USBREDIR_SERVER_MAX_EP) {=0A=
+        trace_usbredir_server_endpoint_dropped(addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep[idx].type =3D desc->u.endpoint.bmAttributes & 0x03;=0A=
+    s->ep[idx].max_packet =3D (desc->u.endpoint.wMaxPacketSize_hi << 8) |=
=0A=
+                            desc->u.endpoint.wMaxPacketSize_lo;=0A=
+    s->ep[idx].interval =3D desc->u.endpoint.bInterval;=0A=
+    s->ep[idx].iface =3D iface;=0A=
+=0A=
+    /*=0A=
+     * bInterval says how often to poll this endpoint. Pass on what the=0A=
+     * descriptor said, but never 0 for an interrupt or isochronous=0A=
+     * endpoint: redirect.c throws the whole device away when it sees 0,=
=0A=
+     * so store 1 instead.=0A=
+     */=0A=
+    if (s->ep[idx].interval =3D=3D 0 &&=0A=
+        (s->ep[idx].type =3D=3D USB_ENDPOINT_XFER_INT ||=0A=
+         s->ep[idx].type =3D=3D USB_ENDPOINT_XFER_ISOC)) {=0A=
+        s->ep[idx].interval =3D 1;=0A=
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
+ */=0A=
+static void usbredir_server_build_ep_table(USBRedirServer *s)=0A=
+{=0A=
+    const USBDescriptor *desc;=0A=
+    const uint8_t *config;=0A=
+    bool active =3D false;=0A=
+    uint8_t iface =3D 0;=0A=
+    uint8_t alt;=0A=
+    int i =3D 0;=0A=
+    int total;=0A=
+=0A=
+    usbredir_server_clear_ep_table(s);=0A=
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
+    usbredir_server_build_ep_table(s);=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        ep_info.type[i] =3D s->ep[i].type;=0A=
+        ep_info.max_packet_size[i] =3D s->ep[i].max_packet;=0A=
+        ep_info.interface[i] =3D s->ep[i].iface;=0A=
+        ep_info.interval[i] =3D s->ep[i].interval;=0A=
+        if (s->ep[i].type !=3D USB_ENDPOINT_XFER_INVALID) {=0A=
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
+=0A=
 static uint8_t usbredir_server_speed(USBDevice *device)=0A=
 {=0A=
     switch (device->speed) {=0A=
@@ -145,6 +442,108 @@ static void usbredir_server_announce_device(USBRedirS=
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
+static void usbredir_server_ctrl_reply(USBRedirServer *s, uint64_t id,=0A=
+    const struct usb_redir_control_packet_header *hdr,=0A=
+    USBRedirServerReply reply, uint8_t status, uint8_t *data, int actual)=
=0A=
+{=0A=
+    struct usb_redir_configuration_status_header cfg =3D {};=0A=
+    struct usb_redir_control_packet_header resp =3D *hdr;=0A=
+    struct usb_redir_alt_setting_status_header alt =3D {=0A=
+        .interface =3D hdr->index,=0A=
+    };=0A=
+    bool is_in =3D !!(hdr->requesttype & USB_DIR_IN);=0A=
+    uint8_t value =3D hdr->value;=0A=
+=0A=
+    /* IN reports what the device sent, OUT echoes what the host chose. */=
=0A=
+    if (is_in) {=0A=
+        value =3D actual > 0 ? data[0] : 0;=0A=
+    }=0A=
+=0A=
+    switch (reply) {=0A=
+    case USBREDIR_SERVER_REPLY_CONTROL:=0A=
+        resp.status =3D status;=0A=
+        resp.length =3D actual;=0A=
+        usbredirparser_send_control_packet(s->parser, id, &resp,=0A=
+                                           actual > 0 ? data : NULL, actua=
l);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_REPLY_CONFIG:=0A=
+        cfg.status =3D status;=0A=
+        cfg.configuration =3D value;=0A=
+        usbredirparser_send_configuration_status(s->parser, id, &cfg);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_REPLY_ALT:=0A=
+        alt.status =3D status;=0A=
+        alt.alt =3D value;=0A=
+        usbredirparser_send_alt_setting_status(s->parser, id, &alt);=0A=
+        break;=0A=
+    }=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The device answered the control transfer. Some requests change the=0A=
+ * endpoint list, so save what the host asked for.=0A=
+ */=0A=
+static void usbredir_server_ctrl_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    bool is_in =3D !!(rp->ctrl_hdr.requesttype & USB_DIR_IN);=0A=
+    int actual =3D is_in ? rp->pkt.actual_length : 0;=0A=
+=0A=
+    trace_usbredir_server_ctrl_complete(rp->redir_id, status, actual);=0A=
+    usbredir_server_ctrl_reply(s, rp->redir_id, &rp->ctrl_hdr, rp->reply,=
=0A=
+                               status, rp->data, actual);=0A=
+=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch ((rp->ctrl_hdr.requesttype << 8) | rp->ctrl_hdr.request) {=0A=
+    case DeviceRequest | USB_REQ_GET_DESCRIPTOR:=0A=
+        /* Keep the configuration descriptor. It says what endpoints exist=
. */=0A=
+        if ((rp->ctrl_hdr.value >> 8) =3D=3D USB_DT_CONFIG && actual > 0) =
{=0A=
+            usbredir_server_save_config_desc(s, rp->data, actual);=0A=
+        }=0A=
+        break;=0A=
+    case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:=0A=
+        /* A new configuration puts every interface back on alternate 0. *=
/=0A=
+        s->config_value =3D rp->ctrl_hdr.value;=0A=
+        memset(s->alt_setting, 0, sizeof(s->alt_setting));=0A=
+        usbredir_server_send_ep_info(s);=0A=
+        break;=0A=
+    case InterfaceOutRequest | USB_REQ_SET_INTERFACE:=0A=
+        if (rp->ctrl_hdr.index >=3D USB_MAX_INTERFACES) {=0A=
+            return;=0A=
+        }=0A=
+        s->alt_setting[rp->ctrl_hdr.index] =3D rp->ctrl_hdr.value;=0A=
+        usbredir_server_send_ep_info(s);=0A=
+        break;=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -165,12 +564,20 @@ static void usbredir_server_port_detach(USBPort *port=
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
+    /* Clear the endpoint table: it belongs to the device that is leaving.=
 */=0A=
+    usbredir_server_clear_ep_table(s);=0A=
+    memset(s->alt_setting, 0, sizeof(s->alt_setting));=0A=
+    g_hash_table_remove_all(s->config_descs);=0A=
+    s->config_value =3D 0;=0A=
 }=0A=
 =0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
@@ -183,20 +590,170 @@ static void usbredir_server_port_wakeup(USBPort *por=
t)=0A=
     /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The core calls this for a packet the device answered with=0A=
+ * USB_RET_ASYNC. usbredir_server_ask_device() calls it for the rest.=0A=
+ */=0A=
+static void usbredir_server_packet_complete(USBPort *port, USBPacket *p)=
=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+    USBRedirServerPkt *rp =3D container_of(p, USBRedirServerPkt, pkt);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    /* A cancel can arrive while we answer, so it must not find this one. =
*/=0A=
+    QTAILQ_REMOVE(&s->inflight, rp, inflight_link);=0A=
+=0A=
+    if (!s->parser || !device) {=0A=
+        usbredir_server_pkt_free(s, rp);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (rp->type) {=0A=
+    case USBREDIR_SERVER_CTRL:=0A=
+        usbredir_server_ctrl_complete(s, rp);=0A=
+        break;=0A=
+    default:=0A=
+        g_assert_not_reached();=0A=
+    }=0A=
+=0A=
+    usbredir_server_pkt_free(s, rp);=0A=
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
  * USB bus ops=0A=
  */=0A=
 =0A=
+/*=0A=
+ * Hand one request to the device. USB_RET_ASYNC means it answers=0A=
+ * later, and the core then calls usbredir_server_packet_complete()=0A=
+ * for us. A NAK means it has nothing yet, so keep the request.=0A=
+ * Anything else is the answer, and the core calls nothing, so we call=0A=
+ * usbredir_server_packet_complete() ourselves.=0A=
+ */=0A=
+static USBRedirServerAsk usbredir_server_ask_device(USBRedirServer *s,=0A=
+                                                    USBRedirServerPkt *rp)=
=0A=
+{=0A=
+    USBRedirServerEp *ep =3D &s->ep[rp->ep_idx];=0A=
+=0A=
+    usb_handle_packet(usbredir_server_device(s), &rp->pkt);=0A=
+=0A=
+    if (rp->pkt.status =3D=3D USB_RET_ASYNC) {=0A=
+        return USBREDIR_SERVER_ASK_ASYNC;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Keep the request and send it again when the device wakes the=0A=
+     * endpoint.=0A=
+     */=0A=
+    if (rp->pkt.status =3D=3D USB_RET_NAK) {=0A=
+        trace_usbredir_server_nak_park(rp->redir_id, rp->ep_idx);=0A=
+        QTAILQ_INSERT_HEAD(&ep->waiting, rp, waiting_link);=0A=
+        timer_mod(ep->retry, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
+                  (int64_t)USBREDIR_SERVER_RETRY_MS * SCALE_MS);=0A=
+        return USBREDIR_SERVER_ASK_NAK;=0A=
+    }=0A=
+=0A=
+    usbredir_server_packet_complete(&s->port, &rp->pkt);=0A=
+    return USBREDIR_SERVER_ASK_COMPLETE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Send everything this endpoint is holding, oldest first. The device=0A=
+ * answering NAK stops it again, and the next wakeup or the timer picks=0A=
+ * it up.=0A=
+ */=0A=
+static void usbredir_server_kick_ep(USBRedirServer *s, int idx)=0A=
+{=0A=
+    USBRedirServerEp *ep =3D &s->ep[idx];=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    /* We are asking now, so drop the timer. A new NAK sets it again. */=
=0A=
+    timer_del(ep->retry);=0A=
+=0A=
+    while ((rp =3D QTAILQ_FIRST(&ep->waiting)) !=3D NULL) {=0A=
+        QTAILQ_REMOVE(&ep->waiting, rp, waiting_link);=0A=
+        trace_usbredir_server_nak_retry(rp->redir_id, idx);=0A=
+        if (usbredir_server_ask_device(s, rp) =3D=3D USBREDIR_SERVER_ASK_N=
AK) {=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_retry_ep(void *opaque)=0A=
+{=0A=
+    USBRedirServerEp *ep =3D opaque;=0A=
+=0A=
+    usbredir_server_kick_ep(ep->s, ep->idx);=0A=
+}=0A=
+=0A=
+static void usbredir_server_wakeup_ep(USBBus *bus, USBEndpoint *ep,=0A=
+                                      unsigned int stream)=0A=
+{=0A=
+    USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
+    uint8_t addr =3D ep->nr | (ep->pid =3D=3D USB_TOKEN_IN ? USB_DIR_IN : =
0);=0A=
+=0A=
+    usbredir_server_kick_ep(s, usbredir_server_ep_index(addr));=0A=
+}=0A=
+=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
+    .wakeup_endpoint =3D usbredir_server_wakeup_ep,=0A=
 };=0A=
 =0A=
+/* An endpoint answers in order, so this waits behind anything else. */=0A=
+static void usbredir_server_submit(USBRedirServer *s, USBRedirServerPkt *r=
p)=0A=
+{=0A=
+    USBRedirServerEp *ep =3D &s->ep[rp->ep_idx];=0A=
+=0A=
+    QTAILQ_INSERT_TAIL(&s->inflight, rp, inflight_link);=0A=
+    if (!QTAILQ_EMPTY(&ep->waiting)) {=0A=
+        QTAILQ_INSERT_TAIL(&ep->waiting, rp, waiting_link);=0A=
+        return;=0A=
+    }=0A=
+    usbredir_server_ask_device(s, rp);=0A=
+}=0A=
+=0A=
+static USBRedirServerPkt *usbredir_server_pkt_alloc(int size, int ep_idx)=
=0A=
+{=0A=
+    USBRedirServerPkt *rp =3D g_new0(USBRedirServerPkt, 1);=0A=
+=0A=
+    qemu_iovec_init(&rp->pkt.iov, 1);=0A=
+    rp->data =3D g_malloc0(size);=0A=
+    rp->ep_idx =3D ep_idx;=0A=
+    return rp;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Take @rp off every list and free it. Do not use usb_packet_complete():=
=0A=
+ * it calls back into usbredir_server_packet_complete(), which would free=
=0A=
+ * the request a second time. usb_cancel_packet() only tells the device=0A=
+ * to let go.=0A=
+ */=0A=
+static void usbredir_server_pkt_free(USBRedirServer *s, USBRedirServerPkt =
*rp)=0A=
+{=0A=
+    USBRedirServerEp *ep =3D &s->ep[rp->ep_idx];=0A=
+=0A=
+    if (QTAILQ_IN_USE(rp, waiting_link)) {=0A=
+        QTAILQ_REMOVE(&ep->waiting, rp, waiting_link);=0A=
+    }=0A=
+    if (QTAILQ_IN_USE(rp, inflight_link)) {=0A=
+        QTAILQ_REMOVE(&s->inflight, rp, inflight_link);=0A=
+    }=0A=
+    if (usb_packet_is_inflight(&rp->pkt)) {=0A=
+        usb_cancel_packet(&rp->pkt);=0A=
+    }=0A=
+    usb_packet_cleanup(&rp->pkt);=0A=
+    g_free(rp->data);=0A=
+    g_free(rp);=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -312,9 +869,160 @@ static void usbredir_server_reset(void *priv)=0A=
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
+    USBEndpoint *ep0;=0A=
+    uint8_t status;=0A=
+    bool is_in;=0A=
+    int size;=0A=
+=0A=
+    trace_usbredir_server_control(id, hdr->requesttype, hdr->request,=0A=
+                                  hdr->value, hdr->index, hdr->length);=0A=
+=0A=
+    /* The host still waits for an answer, even when there is nobody to as=
k. */=0A=
+    status =3D usbredir_server_ep_status(s, 0, USB_ENDPOINT_XFER_CONTROL);=
=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_ctrl_refused(id, status);=0A=
+        usbredir_server_ctrl_reply(s, id, hdr, reply, status, NULL, 0);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    is_in =3D !!(hdr->requesttype & USB_DIR_IN);=0A=
+    ep0 =3D usb_ep_get(device, USB_TOKEN_SETUP, 0);=0A=
+=0A=
+    /* Room for the data of either direction. */=0A=
+    size =3D MAX(hdr->length, data_len);=0A=
+=0A=
+    rp =3D usbredir_server_pkt_alloc(size, 0);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->reply =3D reply;=0A=
+    rp->ctrl_hdr =3D *hdr;=0A=
+    rp->type =3D USBREDIR_SERVER_CTRL;=0A=
+    if (!is_in && data_len > 0) {=0A=
+        memcpy(rp->data, data, data_len);=0A=
+    }=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, is_in ? USB_TOKEN_IN : USB_TOKEN_OUT, ep0,=
=0A=
+                     0, s->next_id++, false, false);=0A=
+    if (hdr->length > 0) {=0A=
+        usb_packet_addbuf(&rp->pkt, rp->data, hdr->length);=0A=
+    }=0A=
+=0A=
+    rp->pkt.parameter =3D (uint64_t)hdr->requesttype |=0A=
+                        (uint64_t)hdr->request << 8 |=0A=
+                        (uint64_t)hdr->value << 16 |=0A=
+                        (uint64_t)hdr->index << 32 |=0A=
+                        (uint64_t)hdr->length << 48;=0A=
+=0A=
+    usbredir_server_submit(s, rp);=0A=
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
@@ -338,6 +1046,80 @@ static void usbredir_server_interface_info(void *priv=
,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBRedirServerPkt *rp;=0A=
+    int idx;=0A=
+=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, inflight_link) {=0A=
+        if (rp->redir_id =3D=3D id) {=0A=
+            idx =3D rp->ep_idx;=0A=
+=0A=
+            trace_usbredir_server_cancel(id, true);=0A=
+            usbredir_server_send_cancelled(s, rp);=0A=
+            usbredir_server_pkt_free(s, rp);=0A=
+=0A=
+            /* The rest were waiting behind this one, so send them now. */=
=0A=
+            usbredir_server_kick_ep(s, idx);=0A=
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
+    case USBREDIR_SERVER_CTRL:=0A=
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
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        timer_del(s->ep[i].retry);=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
+     * a closed chardev, and the host has dropped its own queues already.=
=0A=
+     */=0A=
+    while ((rp =3D QTAILQ_FIRST(&s->inflight)) !=3D NULL) {=0A=
+        usbredir_server_pkt_free(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Parser setup and teardown=0A=
  */=0A=
@@ -360,13 +1142,19 @@ static void usbredir_server_create_parser(USBRedirSe=
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
@@ -398,6 +1186,8 @@ static void usbredir_server_destroy_parser(USBRedirSer=
ver *s)=0A=
 =0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
+    usbredir_server_stop_transfers(s);=0A=
+=0A=
     if (s->parser) {=0A=
         usbredirparser_destroy(s->parser);=0A=
         s->parser =3D NULL;=0A=
@@ -480,6 +1270,7 @@ static void usbredir_server_chardev_event(void *opaque=
,=0A=
 static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+    int i;=0A=
 =0A=
     if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
         error_setg(errp,=0A=
@@ -487,6 +1278,18 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    QTAILQ_INIT(&s->inflight);=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        QTAILQ_INIT(&s->ep[i].waiting);=0A=
+        s->ep[i].s =3D s;=0A=
+        s->ep[i].idx =3D i;=0A=
+        s->ep[i].retry =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                      usbredir_server_retry_ep, &s->ep[i])=
;=0A=
+    }=0A=
+    s->config_descs =3D g_hash_table_new_full(g_direct_hash, g_direct_equa=
l,=0A=
+                                            NULL, g_free);=0A=
+    usbredir_server_clear_ep_table(s);=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
@@ -506,14 +1309,22 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
 static void usbredir_server_unrealize(DeviceState *dev)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+    int i;=0A=
 =0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
+    g_clear_pointer(&s->config_descs, g_hash_table_destroy);=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
     }=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
+        timer_free(s->ep[i].retry);=0A=
+        s->ep[i].retry =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property usbredir_server_props[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 2cc6a244b9..d63156a930 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -406,3 +406,14 @@ usbredir_server_announce(uint8_t speed) "device_connec=
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
+usbredir_server_nak_park(uint64_t id, int ep) "id %" PRIu64 " ep %d"=0A=
+usbredir_server_nak_retry(uint64_t id, int ep) "id %" PRIu64 " ep %d"=0A=
+usbredir_server_ctrl_complete(uint64_t id, int status, int actual) "id %" =
PRIu64 " status %d actual %d"=0A=
+usbredir_server_ctrl_refused(uint64_t id, int status) "id %" PRIu64 " stat=
us %d"=0A=
-- =0A=
2.53.0=0A=

