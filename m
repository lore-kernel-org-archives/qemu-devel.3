Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE01606A338
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fihyOasy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEj-000067-QL; Tue, 10 Nov 2026 03:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEY-0008VK-TC; Tue, 10 Nov 2026 03:29:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEW-0002yp-KK; Tue, 10 Nov 2026 03:29:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLN+NwUDR68LImd37u8NPdSXaXozhbp5MiEH8HLan1V4rIIMCE2G76PTp1+BW7KrtXAPaHi2Hst5UcKiuIE9MugQPA1QXuKDbhkoP/5T9Vl0reovpdIRSPDapmCYBwioIkdc3VIb8qyzreesSDhVvKd+XQbSXkbB+rjvG/C0Ojg/OritDqQIdsPWn4C6Afv+oqPozNuzgzer3AmKh+IHSv80Jshju/ZViNC+Vux1/zaYaminIeQC346wM1QhLFDAISrMxaqicXJ3/5qW/wJfDZp66VyjcJ4OR8jLVEqJo4/Gpfh+acM5W6x70ZyoCBon684k0O+SGmXO9yRJZqfuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+QKJg7PIvXAo4FsRu0WFtyIH6nc8m7gEtGwhLfVy0A=;
 b=diz/DdSToiHdwRpt8yESmO/nWB2eETWlfMSzsTnVuyChj6SaCG31IC0yDXNWCkdyPuMJG8RHhia+iqsRSMpgwMycIUEVzgMj4bHKL2RL0mo2uAfP6zDSX3a/iuiGo8HVsYg9myH3oxBM7CAABnJjCE3d1i6sbTeP6TEnyB2GNBIEsqZYbMOv7s5pOavJMUTgdfN3XJEUmuhJVX8HAi0HKozZbgTqkoT0irsi1Q0dmS1VjiZJCC37zc+VbukRxruFd6qhrLf4oCO1w9X2Rc+LMxd4xqHHSHmnrO0Wd6bf1BdT0rQQvbidRVabiymqgN4ZakMD929XgOYKOK/aGcA7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+QKJg7PIvXAo4FsRu0WFtyIH6nc8m7gEtGwhLfVy0A=;
 b=fihyOasyvRdkI3NHJicOAokxbiSuKWaFHp7Mahv6p1aUbWWiI27UGbbNXlhJEGh6bdK1Qw5SWWnWnFEGyCQWHhtCqGwHqxap9tf4cvbg8b4pVCtuAzD69XFt8VNalmtyOLy0wYw6HJ5RcIR6/2G8zmucym4SafbiGTMHpIy5+iYq95dmBLrtQ7pxJTYJ7WKgJSRjyVNizD0pYargPwNbdl5WNZWq6p2BB43NVE6SOMIA6unt0VZ2OHQpTiQW1D5jgjyder17+uwkmhJEVyeTxS4MnK0bbERC2Tv58HXjspAw7eEQ0o6n0L2hYI8lgXlfqHLwQugMS4kpLmJIvbczbQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 08:29:20 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 02/12] hw/usb/aspeed-udc: Finish an EP0 IN transfer at the
 status stage
Thread-Topic: [PATCH v3 02/12] hw/usb/aspeed-udc: Finish an EP0 IN transfer at
 the status stage
Thread-Index: AQHdcO2VPWwPoLiTeUudWL0zpM1sIQ==
Date: Tue, 10 Nov 2026 08:29:20 +0000
Message-ID: <20261110082917.240329-3-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 65475503-2b60-43e0-82c9-08df3f04b7d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|38070700021|261102123227099003|261028144727099003|56012099006|261022105027099003|5023799004|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003;
x-microsoft-antispam-message-info: Oe69aF3zv9zVgrdxN6FWq1XqDi/RT001rkJoCKDUV+GakKBQeefs67kIbnAiEjajlAExkZo4nMd7mBKzW+CZaD+0sZpDdvmL+OUG7jinTWhuRV+a36/EpLw+dZlwJ+nncGeL16bzSkdDOMRKIAiYctm8UF1u6FG5dgAFAm46TDc+xCx8wDnOsyoykDzLiq8NRy8J0vnI4M5RzGPH5EckOJCzFegLV/TRY0VDiRVWM7/FhSqxUdENxhRdQq7I1wMu3RDquTqgVRNmD98eY5sUKr0F7AZIpZcZEwGWHRivKJyDbdH/UeoqaKuhteWU9zYKofRmG3jNiKJ+PX6WRID/kZ87rHiiIjfWAJhToaLV/FcbwAs9yhrB1p+GguShAuxfAZQvvR68IXnbkSR+aYfF7idcsLMjzRfzjdExdEXkz+jJgkpBtysb2RYLabkJfrpOjRzsyWZYXWC8tYGazfDsPQC1IeZ/VoPQGArb7QhIkSTVOy4eDR7USuO5qt1d2Sx5mkV5VdUCBlD0tjeXyegbWgc9rdJDLi57rhxHU/h9zJqReVGSzZJZLyWWOYv8FqWeGC0N42CHNs2pdoepicY2gJlPjnXseeSH7sUFzGz08XrJTQC2mpNJU1DUN1t6FPGWwkgOQCaXyTht3iI74lYBMdSHxSnyVuV+LlbQXuEd/7ArKwdfibrAXM1MSgPVk73mvSCDpUPfRovBw4mglMXWNZc5RxdFv1fg6gBsRZe5NHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(261102123227099003)(261028144727099003)(56012099006)(261022105027099003)(5023799004)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3IXQ2cXP1Nzm/m4CNcvXDaI1LVOblZzuQKJa4yVW+iOHuHwRxj8BQf8Tsn?=
 =?iso-8859-1?Q?EiUytGAHC0B9jwMKaLQDdjl8ml6/c+2KvEhgviaTCr2FUSLi+RBZq9MyOE?=
 =?iso-8859-1?Q?b8fD18beO6xPDa/DHiF06SoDWohOhVFsWmNTbbmHtzqrp07R9q/ZrPxWyV?=
 =?iso-8859-1?Q?SAmffxd1zec/KRZ3bE9Rbv0T25NEpB/8Ji+MrVLtTnq2wZIm4X/vFA7ZlQ?=
 =?iso-8859-1?Q?/25URtpCeqdKhqdl7hC65+I6hGyQQzrueernJH90A869NXeLP0an8H8Ior?=
 =?iso-8859-1?Q?5RF6iIJk3QUteIiul68bz3u3uy7hGTbJeFSXqwT9amPMaqN7dV8fzTpDHY?=
 =?iso-8859-1?Q?CHl4jQivALH0rB2tKKLW3fvzf1fGtTjUUBlG4Am1zGYEX0mXrek9h1eAPB?=
 =?iso-8859-1?Q?8+vCy08MVUidyvzwEWF4zwq74axB8A8hq+PH4MoIRweqQbnI+Oo/M28FEX?=
 =?iso-8859-1?Q?phG9G2vwZjLFZ6zCOrb448XcVBHSgFJyy7FlFhw0nXaH+T8DlOX38bRWyX?=
 =?iso-8859-1?Q?rVDYXalyWLzEvh6CBlbPQsrU7jRxmBQtWcQfjl5J/awJavOVad2FGFHE8Y?=
 =?iso-8859-1?Q?Fk55ly8MHzyjGZmmrEm18iJMg5c+utD8O6gBmbnaBu++KhAKvNePEJbTo2?=
 =?iso-8859-1?Q?761Ztgj1ji6k7yIdqLdthbUOSCi2wDleB2V0PAc98euv+6FWl8Z5PVRA4L?=
 =?iso-8859-1?Q?Re26rqZRaA+n57o1R++X9hOVsOtSsSHXDBZMci08uRViOHOKYKhiRkHh70?=
 =?iso-8859-1?Q?KdSGfwdoTfbHBecSdzCJfbqEak4WeAF51OJLafjy0FnAjuzxZIXCHCKYce?=
 =?iso-8859-1?Q?SRRDoPobXExf3c03yaZEJbYSSS8R82i2ESKIPycuz/0arF3AFGFHln60CC?=
 =?iso-8859-1?Q?k4N1lDQvv/+KOYJavdG7xnhisx/nmo4CqkpUvlahk+7ts2/FML4p8eKVND?=
 =?iso-8859-1?Q?DycYip0Xk7jj0CNzJrTzCrBojBtwkw1Rd3A5XIkRUHgleurNmKo/iI5rtz?=
 =?iso-8859-1?Q?qcCyeFaOonrS6UwEDswTgrDqiryMIAQoyMRoE4iKYbtqu8nadTrpyHt/FK?=
 =?iso-8859-1?Q?jKKN3EhVg+/vrj+d4KsB6sQnToMr1xdfq9ZbxJR/FbE8yl6KT4Z/pUibjg?=
 =?iso-8859-1?Q?VYRgb7jyktsg0ftrvJn1DakoFdF6KYliWHqAmCXbZ3aKNNSyXx8ff+zvAl?=
 =?iso-8859-1?Q?953+WNEyu+OGkqoaJXJeQUsHIBFlKQW7EhcfCfSXFF1cwpb3nr0MtILaJL?=
 =?iso-8859-1?Q?i6qrPdm1Igjzuvaz2dCICge72RV7ccWuXPSJFy9qK310TGDcHc8ngg54PW?=
 =?iso-8859-1?Q?0GD6O0HyO5tJJdAq+rFNiFjlHI/3sUUEWP5xzoIC3vmuSSJ7DNbuLDzDYb?=
 =?iso-8859-1?Q?lqBccB4RouuPrANAcixIsfW+aMTAuflgCgXKAaOl8IaYtbxghBcFYITrTr?=
 =?iso-8859-1?Q?V5EV5fMxK9HB68bW2vE0HEtTOMYqdrpaOlhj9rsN743x7Eq2zA8F4pughO?=
 =?iso-8859-1?Q?h4qvoOT+FUDaEn/EFrTKo4Ik2crUXC7VOCZoO8OFr8HYTgTGOCkJeeKxwf?=
 =?iso-8859-1?Q?vQTiv+gakGBFgmdMPRo/Zt2MV3eq6BSTw9Ubhm1K3lXVcjZbL+QOxdqmi9?=
 =?iso-8859-1?Q?iTUMW+q1As/xRTnaWuU+TKJr4ngZaC59U6BvurqQiGdGaMpUyubVNrdmFP?=
 =?iso-8859-1?Q?YZMmuRttA1XgAgMNTkybfXKcxmMfMUZtKvtgGg7Necpc3yZ39nWH8PIH4E?=
 =?iso-8859-1?Q?TbY6kRIqbYgCF+Tl8SgR2pxRdcJdA6FhjYpsr7y7RjnR0GAL/+DecQtJKr?=
 =?iso-8859-1?Q?VFNoIGHHTQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65475503-2b60-43e0-82c9-08df3f04b7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:20.5240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1pUtHUa1uPNtnHfcW5g5GKReKdDyz4QBcRfCQdzdfH2prninNPBWYgcHnL5jct4eJQEGqYfQggbdGRC7DrayCuCdQr/3FIo+8RX+04lp/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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

In a control IN transfer, the data goes from the device to the host.=0A=
At the end, the host sends an empty OUT packet to the device. The=0A=
driver gets an OUT ACK interrupt for it.=0A=
=0A=
The model sent the OUT ACK as soon as the driver set RX_RDY in=0A=
EP0_CTRL. This could happen before the IN data was sent. Real hardware=0A=
sends it only after all the IN data. This can break an IN transfer of=0A=
more than one packet.=0A=
=0A=
Send the OUT ACK only after all the IN data is sent, and complete the=0A=
packet then. In a control OUT transfer, the data goes from the host to=0A=
the device. After all the OUT data is received, send no more OUT ACK.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |  1 +=0A=
 hw/usb/aspeed-udc.c         | 19 +++++++++++++++----=0A=
 2 files changed, 16 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 42916c0bd6..1cfef6dba9 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -84,6 +84,7 @@ struct AspeedUDCState {=0A=
     uint32_t ep0_setup_len;=0A=
     uint32_t ep0_offset;=0A=
     uint8_t *ep0_data;=0A=
+    bool ep0_in_done;=0A=
     bool ep0_dir_in;=0A=
 };=0A=
 =0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 355512822b..6a5d05ce1f 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -209,10 +209,10 @@ static void aspeed_udc_ep0_tx_ready(AspeedUDCState *s=
, uint32_t val)=0A=
         return;=0A=
     }=0A=
     s->ep0_offset +=3D n;=0A=
-    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);=0A=
     if (txlen < ASPEED_UDC_EP0_MAXPKT || s->ep0_offset >=3D s->ep0_setup_l=
en) {=0A=
-        aspeed_udc_ep0_complete(s, s->ep0_offset);=0A=
+        s->ep0_in_done =3D true;=0A=
     }=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);=0A=
 }=0A=
 =0A=
 static void aspeed_udc_ep0_rx_ready(AspeedUDCState *s)=0A=
@@ -222,14 +222,24 @@ static void aspeed_udc_ep0_rx_ready(AspeedUDCState *s=
)=0A=
     uint32_t n;=0A=
 =0A=
     if (s->ep0_dir_in) {=0A=
-        /* Status stage OUT (zero length) for an IN transfer */=0A=
-        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);=0A=
+        /*=0A=
+         * Status stage OUT (zero length) for an IN transfer.=0A=
+         * Send the OUT ACK only after all the IN data is sent.=0A=
+         */=0A=
+        if (s->ep0_packet && s->ep0_in_done) {=0A=
+            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);=0A=
+            aspeed_udc_ep0_complete(s, s->ep0_offset);=0A=
+        }=0A=
         return;=0A=
     }=0A=
     /* no control transfer is waiting: nothing to receive */=0A=
     if (!s->ep0_packet) {=0A=
         return;=0A=
     }=0A=
+    /* All the OUT data is received. Do not send another OUT ACK. */=0A=
+    if (s->ep0_offset >=3D s->ep0_setup_len) {=0A=
+        return;=0A=
+    }=0A=
 =0A=
     /* OUT data stage: hand host data to the guest gadget driver */=0A=
     n =3D MIN(s->ep0_setup_len - s->ep0_offset, ASPEED_UDC_EP0_MAXPKT);=0A=
@@ -975,6 +985,7 @@ static void aspeed_udc_gadget_handle_control(USBDevice =
*udev, USBPacket *p,=0A=
     s->ep0_setup_len =3D length;=0A=
     s->ep0_offset =3D 0;=0A=
     s->ep0_dir_in =3D (type & USB_DIR_IN);=0A=
+    s->ep0_in_done =3D false;=0A=
 =0A=
     trace_aspeed_udc_ep0_setup(type, req, value, index, length,=0A=
                                s->ep0_dir_in, udev->addr);=0A=
-- =0A=
2.43.0=0A=

