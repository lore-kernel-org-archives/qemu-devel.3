Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C8DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtl2-0005aK-2t; Wed, 14 Oct 2026 03:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtl0-0005ZA-2y; Wed, 14 Oct 2026 03:50:38 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkx-0006xt-H8; Wed, 14 Oct 2026 03:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXERmx3EYfHX6tnzkbGIjjN48DYQ4IV9zUxmurORwLLoUvrC0hvp4zfM+hsLs0yQvfqDaBhJRiDFwZcEHZysRA/r+Mvy6wou3fViUsB9NxPMUtFyuMNV3Jhnr6oSJ6XkPjgMu7H/W7d2cAF+iq/I4s3QfjMdDyvUHsoNNeBcTvLObflO5CgQZRuc1nAinVZVX6ev2zPthUUmmWek38Jee7s3AzH2TCrxGE/CytSPW6QWEcnZGw5kVdtkWlP8w3/8YnnKWBwnknN7sbkZi9Bu/N/Pzq9ZAEsx7eEHX67jjGL7ZR7Ts8/mZPVAhUHXtAphjUUdwoJiCsm5LERb3eGcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spsSa7HxV+iPKFNqr8eDd5O/JBrvYRVKMich8D0Ahpg=;
 b=peKlV5IsXRpgqOSwthCSrkV7s4J4Vg2+hilG6bFRThQL5z00xkFhNrxPpGoHQ+Seg8wqP+RtwqxSWDYCdHYEGQiumeddFgORv+QRyRzWuAn/D4KoMYgcnTuOD5UTxJJSAVts50LzBub6iFOYEcmo11VqZUOFAcZLotA5Cm+SyQAjoc83HhzUNtezNWjRsoISdLEb3PE2/PiKpQELuaZuOJn1rlLze9FG1a61LG0tbnsO1gz3zh9OBN4wnPhSvkLVpzyiPG7yzyjlHCjP50WeBUBvSKdDB2blECkWwZNMIo0+4WO3LzxF3ceVuPeO/wJHYBB7u5JRoCw/lZG5y05nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spsSa7HxV+iPKFNqr8eDd5O/JBrvYRVKMich8D0Ahpg=;
 b=VCdZJt0dxIaI5i4P6O25J6hgtzzkhi7ib1WU93PzwVxIqDRh7YTj5vfzkC7HDseg4W1A9sRJtKL3xxuftPfVZNdfzicKMMCyYJrgD9nMeIBeVHhrgWaJOMoKJvg9Ibem8gZEM2U/i+Lhl5h2yXTDjp/iJIlshZRf8PRXPxbtskzSdJ4vHOpiSQWHO6jCsI3xllUDkNRq/U1frVlOYsgTKcxar7Y8VTYwrQoQV3zIaE/6j8vqwF9hsjqIox6N+AQQvzevO4wfgktgEvkiLT0jtYTYVBh9FX0mC26A5S1CB8Br4yyyJL/T8KSstcd4qgyRl1EsaiGuARs7Du8fDXrKzA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:20 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 7/8] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v4 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdW7CpqukpKISz10Ow54RlzxCrmw==
Date: Wed, 14 Oct 2026 07:50:20 +0000
Message-ID: <20261014075011.2708115-8-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6864:EE_
x-ms-office365-filtering-correlation-id: 159e5910-76e9-405b-c309-08df29c7cbd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|921020|38070700021|5023799004|261009223027099003|56012099006;
x-microsoft-antispam-message-info: ih4YpLzhGTYndTd7Kjtr6hOuIi9hDDdq+C19RC6uqLM/mSPcWRz99RkJgqCy1jMELQyTGQ6cmpG0JN7x292JAtow8SQ6Noec0eSEl/jHFpxQ2jccC5Q26adhhE23w2hB9EgrNYAFnpthGgl6XMqbsBeq5skW1z1Kj9xvkxvdEbF+Ro8/GLfMybijUbWBLXCHn2gDVyWlg4LLwn3WSGJ3BEdVF3nUOXk5mypcYOonTIud14se4hiEogQ8itH47rEL9zgDLWLph5RkBHO7mSDhR075FDnvYaX1Yf0uLFvxNlfGXhBRACAKfbNhOhFUbqE0YiNfEoPNSLm/i7G5Dhlim0xCYUvIXPfrzkQ+1fxz+d4ho2SATKqIVCdzIceWS13pjtibmaI32/73JZgu30yQ3Jkl8cixeZ87ULIU7B8QZhC1MwWSD76QstX9gW1UE1/ltg97ZEhZY7MNEZDHj8EHx0X33kkkT+9vPdoxP5l92IlnpjiqbT07U/LNb2zg6XgzoaQOVZ+BnOXRl72zsMOGP0DYgZOI2ex+ztOn33lf7uXElCMMNUBEPojMS7T6xT/lSjMGkMkegXMZbMZXmTy3M2/wUb9zMXpyblMEdbBDxl5p5BDgAj6pzwE9vWu2fPAHAmWWrFMbSi0uw3aeGId+vhXVwDpr1CZWgAjZLOGebege4QSHV4Qg/Uzh6FyxaKzXEboD1FJSBmUEtwVdMAP0a/xWkBbfx0Azhc5BQdqlKvJi0LmZ0cp0zROqM1yJ7IEA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(921020)(38070700021)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EG/c1aj45fJOBsSBt61fkoay494OjVocZKBeS8nUS8keo9G5XM/KDvSaES?=
 =?iso-8859-1?Q?wfD6MB0Abvs9/yz27RLWmRh3mdXC4F/NWqJd/HJFExUoFOfOjZeqAPzLU6?=
 =?iso-8859-1?Q?cCR7i0vR+L+1ACJif3t8JU4PT9OWPBdpF3s7rvVifuN7d67/t9GOExD0uS?=
 =?iso-8859-1?Q?/XbWh5QX4g6EaPAFghSkDaSnsaTt8Bu37XQf1tGee1vf1fB3gq6bZol+bR?=
 =?iso-8859-1?Q?pxhfAveocl700R19JpvVjgYhzlAL8d2RSf/PLZ0GQxB2fcDCjjlDZU8gtb?=
 =?iso-8859-1?Q?Z5+BWZy2ky0vll33Hl9e1tV3FSBozMrb9ZRm7qz5MX5bKuJp4njlT8LeaT?=
 =?iso-8859-1?Q?9fc/AMmcXvhepjECgy+nmRU1IQdicemN21172w2vKxLRZhk6Wre/tGAn87?=
 =?iso-8859-1?Q?wIITHY5M5ouaTuAAG3h86kRjPKan02wf50stgrAwf56Efw5GXBSQH+Qqjq?=
 =?iso-8859-1?Q?SQCSjL0KVECIDKJoDCbUTESLo/0PQpKhkXEoHLNzg1gYhNxOBXdaY9PxSK?=
 =?iso-8859-1?Q?6en0/yuCq1dXkDOPQIdQm170Dl9m5v8KwP8q+2EYsrY10TDtCSG0lyHY8G?=
 =?iso-8859-1?Q?2qpKgoB0af/5fdCAUS805dxOpDMI37B/P0JlXk8xqCH0g6z0buM3cUbs75?=
 =?iso-8859-1?Q?h5iuWGNJ7K1BjWK/MJGyZmG3RP9QpssOjGz7UAdMFTaoSYGn7aZiD4o502?=
 =?iso-8859-1?Q?KvF2Mo2bx41k7KBOqvGO657v1kGJV4WuIzTbn/mg2NjT5XG2yrx2cPORSj?=
 =?iso-8859-1?Q?WUPaRW1O8gDwe3fEywvI+3qoB8zsGberZtkHaADxIBW2CPpd4F9/x15NuN?=
 =?iso-8859-1?Q?KerF3RqgtbNfXjNu1+PYOTOAJ7CQTe/aORPrCzeVbwOb3AaIJJmgUydUAJ?=
 =?iso-8859-1?Q?BGqYQIOFvqe0FbNilOJhuDCFdXYj9QrMj328IlomnUehnpDwWyMKPiwze8?=
 =?iso-8859-1?Q?/bSJg50O4CvdKfPuXlFar20J0uu6adMuJQiNsb1b/4rZYr8ZwP0bVuSy1J?=
 =?iso-8859-1?Q?pHEYJE570RDNC0jgf3K5yT1nY3YxWxfHJJS+VKIUKQLCxyGHPnQHQASrN/?=
 =?iso-8859-1?Q?BwA74I2EbRLIq/u37UU6E4Avv6PJn93mEXMqvHfmpLDvOsgKMKuwpp+Phl?=
 =?iso-8859-1?Q?Q98EF0ykYAG0/8CMysglBTf3HZoybN/TJ92v/2UVhSSjY2PtrTZs8+klxc?=
 =?iso-8859-1?Q?zKoY2/bwwjvBJHlfS54WY4aT/glXcm4Oq2lflakV/3nuMjqa3CdKaVvXRj?=
 =?iso-8859-1?Q?wpPOD9Bp7Ibi8hif0o4F/6w71ThZbohEvofPaNvETC+frmOaTDQuCmOnCy?=
 =?iso-8859-1?Q?64ORK3T+ZVuurfl4s4TGQvVrBGg/JvGF2W1Hd9OcLpEPuUXuBceQOfpN3w?=
 =?iso-8859-1?Q?uZapQ10CaUlg3SCu8pBU+cXsTuQsvx0SefTJ4vpCRRFN7oveYQ+7kRZbPe?=
 =?iso-8859-1?Q?p00xZukPkVjtwW+wwjYoFK7oKyNXqRTfaLVNJm50lAVgO4vwbftDvlaN+/?=
 =?iso-8859-1?Q?lrqlMCXJ9ctTNiaVQXcheepfXGPgGIljo2+uyAc1KYvO4onfbC+cvSW0Qa?=
 =?iso-8859-1?Q?/80t1CbRdAiXvkkeLst1F38S088MsGT75It8FgkX5Bjf8RKJo+o65G45zq?=
 =?iso-8859-1?Q?jDpq0dnoCkznyKS03aD8IYc/Ci0jcJWLMaHoZfHTm3Od6bkK8OeyuN7vp8?=
 =?iso-8859-1?Q?fw+hS+xhg97dxd0pCZ/22wwv0Hv9N74DW/Rx4XqMBDbusv+VP5HuhsLYrt?=
 =?iso-8859-1?Q?3zdXxwexG558lX+VcvU41H+3FQyX84XH4bfCG4+BDGnqHXrqx7I23IgD9k?=
 =?iso-8859-1?Q?ASJcFQ2z7w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LuddpLGyW6hwcqyIXz1vZAhywuxo8kBY2wG0ibWD+hikSijMeLxpmp/jDMsCTahVjcLmzwoo9kZ+iSgeg9IOk7zKwepsCKzfWvHO7uZyC7avG50PXDNZgpO+8Ezesi9V1FE96mNjaCPGbcTfhqhgPt4d2Y7w42Yg6CLd0YuOxHiP6eyrSmUJb1flu9MsHhUZydhs79uMtELrVdk1MB7ToMo37riJsOYLrJW7JEQ4y18Gu5avKjpGTmCQysw4F48zB9FTSuzDAFAsclUxHyJ2VZEwoMiptsMTHc46PhBCJoKc9nx6l0MUxlsiXqvSGupYA/SxbDI7vaa0nWSeMPrzfw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e5910-76e9-405b-c309-08df29c7cbd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:20.4360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyC6olhslZBYtjj+DdbTrFL7+HB5IgZqWM3jPKZWzuoIchGCs+2UhgL2ud2NeERPQo1MLfQ/Sn5W0gNuSknHvf6mblPUVZ/lBBt+f0RXLwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6864
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
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 289 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 293 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index bf5286b649..c613147fbd 100644=0A=
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
@@ -140,6 +155,16 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming. intr_in_started is indexed by endpoint=0A=
+     * number. intr_timer asks the device again, after the endpoint's=0A=
+     * interval or after a NAK. intr_bh asks at once when the device says=
=0A=
+     * it has data.=0A=
+     */=0A=
+    bool intr_in_started[USBREDIR_SERVER_MAX_EP_NR];=0A=
+    QEMUBH *intr_bh;=0A=
+    QEMUTimer *intr_timer;=0A=
+=0A=
     /* In-flight packet tracking */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
@@ -580,6 +605,86 @@ static void usbredir_server_intr_complete(USBRedirServ=
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
+         * The endpoint stalled or failed. There is no data to send, so=0A=
+         * send a status message. The host keeps that status and gives it=
=0A=
+         * to its guest. On a stall the host also ends the stream, so end=
=0A=
+         * it here too. A later request from the guest starts a new one.=
=0A=
+         */=0A=
+        st.endpoint =3D resp.endpoint;=0A=
+        st.status =3D usbredir_server_status(p->status);=0A=
+        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);=
=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        s->intr_in_started[ep_nr] =3D false;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (s->intr_in_started[ep_nr]) {=0A=
+        if (retry) {=0A=
+            delay_ns =3D (int64_t)USBREDIR_SERVER_INTR_RETRY_MS * SCALE_MS=
;=0A=
+        } else {=0A=
+            delay_ns =3D usbredir_server_intr_period_ns(s, ep_nr);=0A=
+        }=0A=
+        timer_mod(s->intr_timer,=0A=
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -658,6 +763,9 @@ static void usbredir_server_packet_complete(USBPort *po=
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
@@ -675,7 +783,25 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
+        s->intr_in_started[ep_nr]) {=0A=
+        qemu_bh_schedule(s->intr_bh);=0A=
+    }=0A=
+}=0A=
+=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
+    .wakeup_endpoint =3D usbredir_server_wakeup_ep,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -726,6 +852,91 @@ static void usbredir_server_drop_pkt(USBRedirServer *s=
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
+    if (!s->intr_in_started[ep_nr] ||=0A=
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
+/* BH and timer callback: ask again on every streaming endpoint. */=0A=
+static void usbredir_server_intr_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    int i;=0A=
+=0A=
+    /* Endpoint 0 is the control endpoint. It never streams. */=0A=
+    for (i =3D 1; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        usbredir_server_intr_park(s, i);=0A=
+    }=0A=
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
@@ -1156,6 +1367,58 @@ static void usbredir_server_interface_info(void *pri=
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
+        s->intr_in_started[ep_nr] =3D true;=0A=
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
+    s->intr_in_started[ep_nr] =3D false;=0A=
+    usbredir_server_intr_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1260,6 +1523,14 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
 {=0A=
     USBRedirServerPkt *rp;=0A=
 =0A=
+    memset(s->intr_in_started, 0, sizeof(s->intr_in_started));=0A=
+    if (s->intr_bh) {=0A=
+        qemu_bh_cancel(s->intr_bh);=0A=
+    }=0A=
+    if (s->intr_timer) {=0A=
+        timer_del(s->intr_timer);=0A=
+    }=0A=
+=0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
      * a closed chardev, and the host has dropped its own queues already.=
=0A=
@@ -1305,6 +1576,10 @@ static void usbredir_server_create_parser(USBRedirSe=
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
@@ -1444,6 +1719,10 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
 =0A=
+    s->intr_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                 usbredir_server_intr_kick, s);=0A=
+    s->intr_bh =3D qemu_bh_new_guarded(usbredir_server_intr_kick, s,=0A=
+                                     &dev->mem_reentrancy_guard);=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -1463,6 +1742,16 @@ static void usbredir_server_unrealize(DeviceState *d=
ev)=0A=
 =0A=
     g_clear_pointer(&s->config_descs, g_hash_table_destroy);=0A=
 =0A=
+    if (s->intr_timer) {=0A=
+        timer_free(s->intr_timer);=0A=
+        s->intr_timer =3D NULL;=0A=
+    }=0A=
+=0A=
+    if (s->intr_bh) {=0A=
+        qemu_bh_delete(s->intr_bh);=0A=
+        s->intr_bh =3D NULL;=0A=
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

