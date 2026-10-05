Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC7CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRK-0006dt-Kk; Mon, 05 Oct 2026 02:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRD-0006XK-4L; Mon, 05 Oct 2026 02:44:41 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRB-00005B-Kf; Mon, 05 Oct 2026 02:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnRZ8xNIRNpXx2v/smeClxDOKElvosDY5Cyw0cKe8bLcPHVBxxJDemeGvDFnTf+LWQimQFVcd/wgq+9aI/JtRR4TRba11YCsnqfNIw3mAfzjJLSKQbxpb3SwhKN/K+k2eT8vLOXlHgHp2qxNYCchZRgu4FaX4th5ckMIt259XRnIGlTpYYH+FV6iKWvPXTYr/NqI9QANNbsOtv0+NGAUGHJDCkRwbjp8FQeXW6XJXDZqqJFCTUAgaYU2Ibnb6WxWszfoENsClbcDQL0gSaKiAC6jJvySkSZ0qpEo9rK0LAapaaITmRH8GkcoI0ZlC9HN0O3y3Ahx4tmQP4Cud4zctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2tlE6K/zMHYkzfBwexonGJI3LGBR7qCo2qBBj6MwFM=;
 b=eLszclB30brx3KHgKQPjJXWC511CM9Nu0DgRvrZG1kvcOxOACnUph0XTj2AgFGxdvAfiidXEDiphz13eSowznjPPadt9NK8AG16pdKyZY8ox5fGWHW3tPmJ0RRpft4pfvSosaCvqVPtGgqr7W0fjk6hlazvoNlyZgAXqqns8DHO0vzd3u+9oDoOAhylWEcGHqTfa9pbDnIO+sNNDwcO8M64vTQAdjS4fUbURzAL/3rBhlDIn/a9cXbVP82uHq49/mGiaOe/YX2fok2N4IAAEkkL6ADnQn8ApoBpcvjXoAr6MZms7LypLFhc8p4DU9dljaSFKreWzcPS0KO1mwS6QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2tlE6K/zMHYkzfBwexonGJI3LGBR7qCo2qBBj6MwFM=;
 b=VavEuSPGxrZxYosuoLm202iSZ74b9GdI/Oz0FOj0wuhexynSysAid4iA89FyaUNl8pP6brUHrUI1RrVbQh+J4+Rb7Is4wXs9yPOhkFqt9Yi2FjMv8E9la0OUJ4LShFoHBxdkrXx/zkHni1fLA7hpJtNcs9/XvCfVlvQelkN536Z0G9qi0bVaxLIn+KOmnFvsOJn7BXCr9JB+11cOPyOddVmcZqhtWVG6Et/Z/2w6uK4g1js0nchH1Q5DUHZBvmjfxhRru4EqjIfgZ5Mnis73NTpdPhEaBd+3CvtUSDW+S51BA7X2Ja4INmwG9VeEGTfagEAiDLDhZqr7GcSbbqkUkw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:28 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 05/11] hw/usb/aspeed-udc: Store the EP_DMA_STS write first
Thread-Topic: [PATCH v2 05/11] hw/usb/aspeed-udc: Store the EP_DMA_STS write
 first
Thread-Index: AQHdVJT2hZZmdBDzmEi5HlFZvk7EQw==
Date: Mon, 5 Oct 2026 06:44:25 +0000
Message-ID: <20261005064418.3060881-6-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: 446b9b79-9e50-4648-218a-08df22ac1a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006|5023799004;
x-microsoft-antispam-message-info: 3Bq2Svq6zIFmH1dukuf6am0WJA+n6SjATqTsW3HV/nqT8t1WO+eAr1k4LTRnQlYNTqE2pkcP6ueyLSw6YoOSsiRTWKk1jZ9LQAE0fU0O8vG/mN6NB/fb2jruLoFA+jG0IlB0KMly1RsbEwMD2XS6uqjlYkJefqX/+8s/noj/JgcCyuxNoHnyzetWU6MnYKD8jw3HpfjO5IbymAJPxXZqOoryxWJAiX9lxbq20kyOdgsXzB1HcLeB24jqXj2pOa/ab8oOrMFIdyxyzEcOOqaFsFLafydNRIJplNJRqhuP47khmD/aiUIq3cL1Qc1JzBiDXlHvcuZ8k+do+TpAx3/Or7noFmBlF2Qc27nqfPsWLX6nNxpqxhgnuCx/3xl+rIBBHdOf9JPT9FGUiXAA/DDgR2NlYVyMNS4BOoDf7J/bCEAaG0ASIBQv6S5VU2wzkQrXsOf0Nb1JFudML0qPdkgw3SvOPAjug+JJZx15dmhpTOgKVkzTjR+XYyxbkGHMj2jI37HnGY/1Azhslt5mfTV9BIfvG5F88dt1Gpumep/fF5own+m5k2XBzPlVifnOsZSzX/ciPzD6r6IDDLZ5lKZTnwLNrM85cUOgqBaFplJO5kOZ9LKRbgvrJ5FNTLB1m/TKaMdohMVB5f6cde1hxqCANK0N2kDB+epmxz3qIu2LryTtzUIC7pqiJ1wfwQWN4DYPhicZD3fXLs9sjrIbcPmnY604SWE93C+J4RjVMnfZnwA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yMRPIuMrsUw6FnXZ/5OLqyh8QdoVbAY2Tn7E9niTIE3i0a76BFODhDJAOa?=
 =?iso-8859-1?Q?Sz4eo7obU/QM9jMh680bHJtQBHZh8VGlfF+wnmro675xz3KlI/vv0cPpkc?=
 =?iso-8859-1?Q?Dhdg1vGmqvDkNoYPZY96rb1e+y5vI7C6kz12QCqwNkomBz1xw9Twj+nK2M?=
 =?iso-8859-1?Q?D7y0PWur4H9Yfxu/bAnGJwQe8stFEaZULsbNtQMkzJ+mdVzuviaXPRHWFx?=
 =?iso-8859-1?Q?YBwOBdJ8BNrMDbU2P0oKV4y79Lyb0W8mc5XzwbznP6UeBaKmEtnzzpY/cE?=
 =?iso-8859-1?Q?OX972uYu/lEhJtpcaxiwdafBBAfQPUBxKBOkp0Oec7yRBMF5lZfzvyHWBd?=
 =?iso-8859-1?Q?eolBI8QEsOls4bx/IMv0gqEIL5SW9AqCn0DgRAf18z5hjBwWzOB0WXhOK/?=
 =?iso-8859-1?Q?A5OfV1hH3YGbwNYFnralZ9WVB964LmpRW0+rsHS/DoH4P5x+6NXaZlbPRZ?=
 =?iso-8859-1?Q?JUZnTqr6qJ/qgjmbOknzsSrkCi9rD0rLvuX5zcUlb3jPUbK0lFElq9CjxV?=
 =?iso-8859-1?Q?mXUSuQSkB4T77bRJXf2M8LFvdNNwjqwhQFLJ6D2aGIVCZyUhCc4j3p4je6?=
 =?iso-8859-1?Q?r44edqsqpPONMoWBGJ4HO6R+ylntVfwjGyiJ9aMh8brEFl9SsS/qrqnfKa?=
 =?iso-8859-1?Q?MlMOrNMPmNrKJSgZdWI7ROwZySkamwyQyrSM1DeE2qeqiLIjetEbplhXZ2?=
 =?iso-8859-1?Q?/HynnQLwuNzKb3y8EgYhmM4lOeXhEiJlPGlrYTHIfnHT14yroSXdWLQPpy?=
 =?iso-8859-1?Q?gOD9JBBAIlZaQpicEBSjsWQjwmAFczfpzqpDbWQukne7K3G4oFwz8fAk2/?=
 =?iso-8859-1?Q?ZQfH+soHqPwO/MxMhTL6YL7fUoN//CjJ82gKQ0LyNKBqXqrMfxwSB2okJq?=
 =?iso-8859-1?Q?Zsjajz7kOB7Rv77K99B5cg+5uKCe56h16TSBmOSIKCzAtV5JV9Xm//Hf+d?=
 =?iso-8859-1?Q?z4FgRnd9G4Co4aK95LgG6dDvFnhOBDkwMX+/3LwUsv7RoJNZ0XsnD534lV?=
 =?iso-8859-1?Q?8D6xcs5I/P5lmprQKrhY6po9xOXxAbFpl6cvkMugqvYBLXHnI8kP1upiDu?=
 =?iso-8859-1?Q?RQVQRFvap35D0040Qo7n0i8rXR7wmWvj1BkAM3Y6D90jX1rM2msCw3Golv?=
 =?iso-8859-1?Q?YBU3wJTPFDAUdfRdPhLn1XTYM1YiG5ejozmsPOukvbPTwoVtKTsBSROCe3?=
 =?iso-8859-1?Q?/huD3UjOllANA30z0kE1mFYZSO9G3uyVxp+4MIImPqqFHIL0VlKfFDwR9K?=
 =?iso-8859-1?Q?ryKpxVJi04JNLd8yoZGPSfdpBQx/rxr7GQxdi2Ddgf6sQ93S88G5DYiTAA?=
 =?iso-8859-1?Q?CW3f4y4nofPoUKxZVMsyG2cUcxeu5+mDspKZSL3+u/bsMQfbVJ20P7CQus?=
 =?iso-8859-1?Q?ntR7XZhhAQjFDPoKwXr5aOaOMIPOM5GR915nuq0nWNl8avKwNhoGC8vRSK?=
 =?iso-8859-1?Q?4kC26nQeSsCGJ5hjhJOCviDAM8eJuWZsYNCQE1IA6ZgmdDx3PlYtMn8vKZ?=
 =?iso-8859-1?Q?aNCPt3xyFcVND47uSdfbNFPCc9hxV558Jtqo6jBDnX1fx96Q2y9j4Fh7JT?=
 =?iso-8859-1?Q?uDDBcuR1ZCTWPLW4HZDXRwE30/DHGWNUq17n7yZ6MEExFEbQ7eZHCO/4Am?=
 =?iso-8859-1?Q?af6c4OtCCluiGU0iGSuWa3tDknBKP0dS/wrgsho5Wxyzz5jIWmLGDcZTnt?=
 =?iso-8859-1?Q?y3Gl0BolHAzTsISdMUbQuARPXKSbReQthGF39lEBXsXFGymK1aOFX8mMtl?=
 =?iso-8859-1?Q?I3UKZ0HD81WdIV6R05XD5N95GgjhWzuD5VTpgPvu05ZkDwT2OpK6AYyM3J?=
 =?iso-8859-1?Q?e5z6MtL0qA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NA+V1XxXWVAyAFd/GsElC8Mb3koT6YlFvport4iGEgVMHYYWOba7sUA5eVJ+BlfPMAmgLDWuSMxZCFznFtXtA7DJu6h2xWFaRGTqDbUbFUse0bkIqLUcfYmsYIrZ9+VU/yeKYxvw4meHMR5UgmeC0YgZw4Xn97kS8yOxBi+/VkZnc07s/x4j5wziynBKuX2TXE6myX+rKSKjLyKr9BC8HR2qLgcP2y91G62mlev7WPLxgKI3aLD+9oVSnVkAjJG7832z5GAm4dhbe/lrScfTXrAyViTixYmU5xV1DF3e0YRFVTFroa0dpXwKQYRuNaIT4Qz5/YLrSAKI19Tr6evaYQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446b9b79-9e50-4648-218a-08df22ac1a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:25.0741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyIPxcdkMq/6OVxK0pX9cG7f9ebySKvSfFSLdRDeUVOsLv8bSQ9OWBwe4xhBBCCRH313owfKgSjcdbDi3g0mizG1HNFXVZTfBrzz1RCH018=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
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

The other helpers run after EP_DMA_STS is written. The descriptor mode=0A=
kick did not: it had to run before the write, because it stored the=0A=
value itself.=0A=
=0A=
Write the register first in every case, then call the helper. The order=0A=
is now the same everywhere, so a later change cannot go wrong on it,=0A=
and the code is easier to maintain.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 19 +++++++++++--------=0A=
 1 file changed, 11 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index b43f077c2d..4572914e16 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -619,12 +619,13 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_sin=
gle(AspeedUDCState *s,=0A=
  * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
  * the next kick.=0A=
  */=0A=
-static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep, uint32_t=
 val)=0A=
+static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep,=0A=
+                                       uint32_t old_val)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
-    uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
-    uint32_t new_rptr =3D FIELD_EX32(val, EP_DMA_STS, RPTR);=0A=
-    uint32_t new_wptr =3D FIELD_EX32(val, EP_DMA_STS, WPTR);=0A=
+    uint32_t new_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
+    uint32_t new_wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WP=
TR);=0A=
+    uint32_t cur_rptr =3D FIELD_EX32(old_val, EP_DMA_STS, RPTR);=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
     /*=0A=
@@ -641,8 +642,9 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *=
s, int ep, uint32_t val)=0A=
         cur_rptr =3D new_rptr;=0A=
         e->desc_off =3D 0;=0A=
     }=0A=
-    /* store the guest's write, but keep our own read pointer */=0A=
-    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);=
=0A=
+    /* keep our own read pointer */=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       RPTR, cur_rptr);=0A=
 =0A=
     /* nothing to do unless an IN packet is waiting and the ring has data =
*/=0A=
     if (!p || cur_rptr =3D=3D new_wptr) {=0A=
@@ -715,6 +717,7 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr of=
fset, uint64_t data,=0A=
     AspeedUDCEP *e =3D opaque;=0A=
     AspeedUDCState *s =3D container_of(e - e->index, AspeedUDCState, ep[0]=
);=0A=
     uint32_t reg =3D offset >> 2;=0A=
+    uint32_t old_val =3D e->regs[reg];=0A=
     uint32_t val =3D data;=0A=
 =0A=
     trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
@@ -725,12 +728,12 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
         break;=0A=
     case R_EP_DMA_STS:=0A=
         val &=3D 0x77ffffff;=0A=
+        e->regs[reg] =3D val;=0A=
         if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
             /* IN, descriptor-list mode */=0A=
-            aspeed_udc_ep_in_kick_desc(s, e->index, val);=0A=
+            aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
         } else {=0A=
             /* OUT, single-stage mode */=0A=
-            e->regs[reg] =3D val;=0A=
             aspeed_udc_ep_out_kick_single(s, e->index);=0A=
         }=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

