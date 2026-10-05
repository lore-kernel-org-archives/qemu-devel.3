Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD39CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFo-0003gD-Aa; Sun, 04 Oct 2026 23:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFm-0003fF-FZ; Sun, 04 Oct 2026 23:20:38 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFl-0000R4-0N; Sun, 04 Oct 2026 23:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0aE2/Zh9Y7skUY6egteMRzTDS4cLiCLENN/nuFYTYJ0h1yo90+gvMynO/Mfl427lQORNaRkWwDiPAlnrJLsGLrfw2atBHdzWgzyfr/18f9c/60Rl2Ur66HAlRdII5dU2kRNfdTJ+kC4b5EPFGusTVMNeAUrWBLUupQgTj0y4oIY2FMdRcWP80/uW8rafD+FK7vwgu98cLZ2AW24NeC6Q9jUfycSzvrNz7pzbdM1UYEwCh1Gpwn6mBu/j9iJsvSmB8rFczBWSzX1lhhtQwDsp+fUou3xF2stG5D+ZwaDzwVQuBNt69cPfQVkHH4mM0TMtwtlYUOIilDGqeLxmuNmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsJmAsp9QadFzA97/R9bBBZE3T3GASTqNNfqpEXygsg=;
 b=kkvps0QMm8Do7Iqb7OASE0NcxXNUfOafSWsRo3ZxCzZ6E0gGW3d/kOcgyEzu2tU4EVuiVdDsoqJ7ui03AAmRbbBeECPL9Bfq+zMllZ3InF5a6of9jpXfw3hP4MzDOrGVzc5fA4JwMKYkHubCTmyiss6e74VnCpP8N0Kb6ccLbiioYcs0kTUPDE8wKpNOj3+ott1S7+KdjnFhFbjvEJVtBW8maWJQIdKd/E3T+mFOuoRNHb94W/24Xqo/aOVaPur1uaWuF3WtgCUuFBxfFrjKEi21ydMqxT12TUluJqAJced9SRfYVCQAVDrXoX+VjJiNwJEKFLv+RtIi6ilYOLfNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsJmAsp9QadFzA97/R9bBBZE3T3GASTqNNfqpEXygsg=;
 b=E728AlT9jWbQZJRxDXXB8Nm4AHDmUrr1BuI2qo3miA82qZejDgxAWNk/05ll5FxEfMc6pQUhyj0ulAOxsQbYI6XMt6egtOHA8pufTq9nkZxcq5OaUbQM4lCWKY890YJ0HBlsiEc1cGEY30FvtcMybJjm2Js5XCL/uJA81QJ2Z7vPlYAsDU+ZK0fqjzuyz1pyk7sP4FhDQqcHUDJJNs5fqGmW1YNB7yNJLSYU3N42XI+i8LCQ+MTz1MMd7xOVcOiLMCA+F6jnjMgKcZqQimiTTTdLVc0Y17HoFUwE1yOp8a+ZvDyZh4MB6yjfwvvPEPNJCfx+RIBNuBDAT/bt4rbK5g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KL1PR06MB6396.apcprd06.prod.outlook.com (2603:1096:820:e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:25 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v2 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdVHh2za6o6IT7402PoTiy0txRVg==
Date: Mon, 5 Oct 2026 03:20:24 +0000
Message-ID: <20261005032022.3980903-2-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KL1PR06MB6396:EE_
x-ms-office365-filtering-correlation-id: 388bfe57-6e0a-4c79-05cc-08df228f98d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 0RtwTZCPHsrZpByu9az790mwmLEVj0LN+MzN83T9rolD1SrVzxUHknbM46CNQ3ZFU9JO84u0mE8upDk8dgE7tzKtOS12ihx8xcx3KJvIApjWuA+Gu0Let7C0DCsiTBlLbkvdUZIDLHDbnCt7P67Msy5Pwxt2y+sIbGNHwqUJGwnVvEaUo/uo4L0sIw5HvQHqEpHlED5fK31Oeu/r0vAmmUwQm2AHYL9pqWnuNfMUlVVe5+x+X49j4fwnIG3TPx46laCQMLNRiGjEQcpqcGUhXTvtYZYL5o1VwMYgz+Y+2pyHetztIlamdB3vABegYV9wx2A5PbQ0bN7rMajgngETVuEBxVacb3T7exVMIngWTrL14avwZN5QKQhlgDjUSi7rlyVJLV7dF44/HrS87sNf1omRlvres2eHHm/10mLUDzZxB/YOW86rflfFJZ1Znd1/ZZgn44TTUDf7EBlA+Tv8nsBe9TH4KmiH4OVGIZmUzX/XztuGXiFcPx36c41FPJEgc5OLjp2E4P4tS1Irp7v6YjWw1+B4bLy2uPGrrl6Rq/R1Psd+3uNRqdXU2mSRVm2YXK5XhlqEHCQGBmQw6PMQgI6LUbleqMQYHsZjsAVHMv3VMpTfqrmuS85sTEfv5hd3x/FeVBH2o9kgn53vXFkx1jNN0sT73c9qOzv+Zb1bZ+h0U7sFlXauL1dPXoUbLeKwVpVaJWRhI7Zz8pXh0pXZwmRY5rp9QW75XnqzTP2f8WU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EeKFVEspoqmZet/PogEMRr6wXtt5Jr8oqn45eG9YG9O+V8I1lib0gj8QDjZZ?=
 =?us-ascii?Q?RUoliM5/odhjWSD+ageC7LG2kXZ25+LAjwzgu4bAFzpeMNdJoYEAyEWy/3fD?=
 =?us-ascii?Q?WwVxjNYuNRHDKoRtcw6r4V6WkjSY/uXr/wFXvS1LJsSlBZIUAEYhSK4zrJfr?=
 =?us-ascii?Q?WwyfX5bSV/W8DwbjYRnpY64shntoDfr4AdNqrsWy/ap1Xn+vE8YuFXKEfBBm?=
 =?us-ascii?Q?2AD2M0vxI6yXKoRju+cjRFyWaau64BwTw3Vh7JyFHClwOdgN/KfY9Vf0RU0u?=
 =?us-ascii?Q?mWNImg5k5kj5p7Ij2KI9KMj2mMRIA/a/iFbLfItCysjkbOXLjhMXRt22HWBk?=
 =?us-ascii?Q?QvU2FrNKXRR8Bc727FAzCNoDh5ymiSwej9VZpSmS5rVB6iULRCU0mcw2wvw1?=
 =?us-ascii?Q?Uj9foQj0k+S4SsrB1bJ3YdyKGG3z+LpVESLb8tUwJFwx/LHu4uzcHAfQzv0B?=
 =?us-ascii?Q?pEjDEiSDiLmEK2TuOAaEceTI/BeRBke+sZfL3iWZeAw5XOlvI7QJAs7lXjrK?=
 =?us-ascii?Q?EKKmXu6eCx2V2U6KvdwmMn41HK7joq3wZFa3qy/z9UnpY9YLM4hxHlh02oRl?=
 =?us-ascii?Q?PAxJi9SJhTVVp4s4Wbi1U4PSWldVCsqlR+a2SA1FOJCX3m90N+jvevpdNxE9?=
 =?us-ascii?Q?MFcva8ZHfMF3GNcwRv1wOl4/aarX8o22+kc3rbeQ0wc+Xf+RoI/L1BHaa6x3?=
 =?us-ascii?Q?FIopp6YyfEWBX0EOmea27cgkSUnqFw6kLCrt4hY/+BALWa03q+YZYikUjk39?=
 =?us-ascii?Q?Sx4YydOEJEQcV4vIBAcejYu/me2HKEivRJACDyinHXYK1GLg6Tgy7nDzP5KT?=
 =?us-ascii?Q?MqItPaJk1xECf3x1rVjHA0lNpuGsq71FqrwaGrh/hICM3fS0Eu1LaOaEVUQz?=
 =?us-ascii?Q?//l1wTMBGk35bd9EAKC6ERw8LiPpp+tLhM0A3n1WZc1BpABcsQ9V+Owxd3Ts?=
 =?us-ascii?Q?RBC1glUysY3dfalkDOc2e03wTQaXEbmF/TVWJ4DaKrvbAAC+whWD2XzHippF?=
 =?us-ascii?Q?0GDcWmQa6yWuvtPJvLOGEFuUilXVjGCBvjYTFngKUWAuaeyi+wzCC0wSPTmN?=
 =?us-ascii?Q?i5SETyWuvKB381UbqGdVdfonilREEFw521F3C72bWbGOvCpJ1fLilQFmMIYs?=
 =?us-ascii?Q?l4w3sySlyaslYizlFKm0QSb+t3sI3lRNGLf9CkigZRg3P0qHK0qVwsm9z6gG?=
 =?us-ascii?Q?v43Bc1uIkabPGRwByVE5LnyJDP8Jxwj094FsAN86xMzXxkM7Ccyq0osTutBY?=
 =?us-ascii?Q?VvEVsStwC0u+h245tGTS0kl/DpwNYacYBtRnyqH0xOWGzjQrrhu76cJhWWdE?=
 =?us-ascii?Q?mm50YtvAEJCGKt4mOJ4a7aXXY1LqTTfiSqNzn6UHiYHFJf6YNkMor1slcSpL?=
 =?us-ascii?Q?D3z0KAnoPMJAOBNikwB3SY254Fxhx12FS4OI7gbuf9XI9YMaLtJVQDb5U5rH?=
 =?us-ascii?Q?AmWyi3M7ViSuoJpjHJkKbX6CN+lrTdCw1f0Nn+1vVKriIeWiIETkK5i/fZIN?=
 =?us-ascii?Q?BlHYI/o9Fk0EvJiXo9JMrxasChz+dW6DDAwrudE9zVel936FVQuUg2WQ8BjA?=
 =?us-ascii?Q?OhecoXLicjz4CoLpa51trSuP/3s5T40rQkC0FQFn8bBnSwvyd4VOtiKmEkGP?=
 =?us-ascii?Q?i0RwE7kC90Yrh0UzS18BFB7Fs08vJQOd5WtJZWNjHL1lmqBm3ojQTdqjaqgX?=
 =?us-ascii?Q?86MRdfBAdUGxte65Yle4gk7r2dSApAtc+jhYXGbaf+/RUf7fEMW4UYnjUSNB?=
 =?us-ascii?Q?23kkbC2VmA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5YF8VnflqiavEgpKQDz+2LQRtgoDoVd+8fH4OtwOSU7V/wiUjp++6/roqDuPddQ9dB0vVGjGR1rneg3+GGTDrfGopp5F8KKQC2TdE1ZlzrN0wWw0pcynM8fUTpqcLYYSwua96RFQKe8FUfiMqxOi2tDBG4FD87zcssaB/zY1yxDiVZ9LEic89i1D6vUVaMF2n6zW9QATowicpSkASjD5yO+43fNgvRD33xV3nmEJ+kbNSTNrqipyvCqlRXrD1hLrMt8V0jZppt4AIc9oSaNaOsNspuO1l5if53buPgljI5Oi3ztO3bUnTg9pCKCE0TzffdfcTzQvOK4rojEUcJeZZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388bfe57-6e0a-4c79-05cc-08df228f98d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:24.8984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpjhB2NMjU1+x4yCLsJd0BB+uYxZUVkqKagDg3utXWTGOJbxt3nXt86jDU4wrPeUP+oO6bbtX4iOZSbq5CFtxJC7clRB8dM6Z5DsWye8bWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6396
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

usb_claim_port() inserts a usb-hub when a device is plugged in and only=0A=
one port is still free, so that more devices can follow. That is what a=0A=
host controller with root ports wants.=0A=
=0A=
It is wrong for a transport that carries exactly one device. The hub=0A=
takes the last port, and the device that was being plugged in ends up=0A=
behind the hub instead of on the port the controller watches.=0A=
=0A=
Add no_auto_hub for such a bus. It keeps the ports it registered, and=0A=
-device fails with "no free ports" once they are used up.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 3 ++-=0A=
 2 files changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..ab96812adb 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool no_auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..8a24b1837a 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -413,7 +413,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && !bus->no_auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
-- =0A=
2.43.0=0A=

