Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CBCC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOS-0007bQ-Uc; Tue, 22 Sep 2026 05:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOR-0007ah-6X; Tue, 22 Sep 2026 05:02:27 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOP-0002CW-4X; Tue, 22 Sep 2026 05:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8fDK/hl95Yt6K0+QkSM44VGJtSgqUSRqXVvx2a1l+KffRjf2Zdl/MX++fy72KU9dbViIqJJWKsS4Fg/NLxY4QFMiwnzsUcExEvO7BG7RZu2Y+hNodDSAa7qbvLvdxbCsVv6Fcv2EGo4Xp41oTUduW9+G2atGuadRcYwEe6Vx/xluqD+rMUMm9e13UCMb3yV3lPaHxiE0OByyZgXY26Ku2HwybNT/6KXtlxOb0zo19+A9ga640yZ0II9w3DiHHDkS63FPJdUe7iE0LGfY+lV/iCjj+bYmzCR69QdKEHJgVvBIuJaT/YtUzFCW/A2xrLxIZB0dMGDWJ4xfDXyukGbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHNcaI2SuXpm1YHTioqdDUpzNLbqZV7kd0pVa8rreq8=;
 b=eBmW4pFIyeOCm4Q0ePIJbsb8XlCJfIaL4A0c7vvsrYG6XLdCmJfH3CrsbmsY8mLhKp1VgzvUrEypI1tKAELqSguPRxZL0yqqmg6ZHioK97+gNF0YsvGxrircJ5PVvIxKcw7Es9ACqDbe+LfX/6W8ECitKfXimTBCZTGoMTAR+G8+AqjlOF0JoHuRT+h7SaKQ2tWtDQDvESQ4vXd1LOpraVkBmU91cmkKkAOaN0309qr3wBbOUrK4iFBm6anHaeq5wcNl6Qk6FLScFWGjnEWPHFRtG8NGlAxttfg9oSD2ovnHj3YRiUw5aO17EFmsGW2VYHVnt8IMksY58xqgBOa59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHNcaI2SuXpm1YHTioqdDUpzNLbqZV7kd0pVa8rreq8=;
 b=eMbXDXWwqYgVqj0WtzCN3nP7S0zgwcHFqW/Lmw1vS2O2Ss65IAG5qExhMItS0lnu9BcNvrIbeC7tnaEPcKJ+6EN1R9Pn10nQOPpA9+METx1wRs9APR2gJQbhbS11Qb6C6OFgPDYE7zg5MsZ7bqsiKcNNlVKulXSaIIUNAncjcgAMVbCH+gwl/1+A3FPg45J+wyoMOqAJLygFTbm/jKkuy2U9iGq3ekh+7lpFbq4Lrv56OSbEW9V9CbWf807EhRZagBIq6FH/ccnTsrBC67y239COH3yR3VqB5T+zLRFtPr0ZjE6Ggd+DM8M3R6S7Sn4R/UqyQSp04WWStuBvlkrLng==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 15/19] hw/usb/aspeed-udc: Support single-stage IN transfers
Thread-Topic: [PATCH v1 15/19] hw/usb/aspeed-udc: Support single-stage IN
 transfers
Thread-Index: AQHdSnEPhhIdLo/LXEqtBfZXKYA0XA==
Date: Tue, 22 Sep 2026 09:02:14 +0000
Message-ID: <20260922090154.1792077-16-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: e64851c7-5b01-4b4e-123f-08df1888320b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|10067099003;
x-microsoft-antispam-message-info: xB+rGkn74vDMV3ei19BA3B6LSuWYjX/m8ST6AxPPNzLMjc4QLl03mop1oMAlDByJJiOMiGs+iHjAdT1RL8g9lk173ucFjkeCwFzrFMeOuEDYbGfQGRn4/iwsP6uTH0+wtsAD+lO9ThSahQ/6JG04uJFME61E/X6Drv7PVXXzNpxau7VMbK+kHep/RhobMT6uamHYzAyiXKVisIS0oxAAFhRuWFY6BxJN9WVLnusTYSZpnD4fiKq6o9R1IC66yDTKAEPVxb0ksk6kbP2yxKyYlXRCRaytsSr6eDnbfDFhK/+qB1VIXjqwribZ1gN24bmknztTDQJ4JnY7xzxB77sdAaoc0z6lf0dQniUQ+0e9Y5bz9nY6SZhb5LS6/UzLY6m/8gn4xZpHHYs6bn3vSicMF41h564gSA1zjqDDdjbuISRvyDXPVu1FXYoM1T+Vv73TXzgmd1O3tJl5qBxeCyyBag/7eR2OsTfvJjHmYsx83t6eURxad44Ci1S1E8ByuOg4tWW/Yvrmpo1DJZPMXEq1tQXYnzXwkN/lUuYP+mnYNVnyqBXG9BnGqEA6JzeuvceVRttR6SpkBf3uS/WN9YeOtaT7IdnH4/jCKJlcpj/3ehh3G9ru570HbRDzmmgX+1QGYn28TkM0vVJVPJiTSfI3JulXhw9MNFo0B+/QuXK/zx4iup2QWga31bxP0VHyWWI05p8oflhkm//vuKa4Czsk5fIUnqJbB7IVcGYES73daBo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F+C7XvTuXl/1SoOYbp5U/4U59ndHecSRHrDCH+XPqOZk3D6Bg5FGQ+TAbS?=
 =?iso-8859-1?Q?xSirOLbVhBbqSAOLjpKKSEkJ/5YVwAJbahqXd3Gav/AofEbjQsKWbgnEFn?=
 =?iso-8859-1?Q?iuEAzWmH6XCeEq3vI1ltABv+sWC1zCU9uLqLgG3s7zw1KbNmPf6DF2vWaZ?=
 =?iso-8859-1?Q?26b9IVTq1fOhKFOQYuIn30YoCf0VYb6R7hajooMT19KC0FSLRCPMWxL36L?=
 =?iso-8859-1?Q?nD02kTsy81BtwG4R7JJ4Z1bVilkFQA/dIrc7+zNIMEl63HkBZbXMNR5aSa?=
 =?iso-8859-1?Q?pzVz/XmRe+oBUTUjzLiBoRXBkwynVZGBjHoLDK8Qfv2VJL6zC4hNCK6Jg9?=
 =?iso-8859-1?Q?pH21BS8BgAAEs3Ea7G1GNHrb1sXde3b0Exo5JxbIgnUTFOiOA7D7Fg5fm9?=
 =?iso-8859-1?Q?E+bnGHlJ9LPSbgp+44sbtLOrAyKXXi0ggBWsSeoJjauP/Q9oMwNnCnxhs9?=
 =?iso-8859-1?Q?cXmxi3BKOUylkUVNNexG1R2PT68IiaiMcs3tsHVcDhjP/mjIowzta0xEIW?=
 =?iso-8859-1?Q?xxnGTfs8nvfxEH3iZtXtliMXC/PjxDGnskI87rAF3oupekRfYzEugBqoMo?=
 =?iso-8859-1?Q?GC4h+AHCTuv3R+LMoXHgf1vM6oYbmxzaqRXFGeFcN8hPcy1qsAmeJ2d0Ii?=
 =?iso-8859-1?Q?9F/w4rgu/sjszuDUJKDSOYFp17wQqfyX7pFoc6UpgixHNg4+tmzCsFVA/Z?=
 =?iso-8859-1?Q?RkIYb/E637cuTp46khJn81xtYdppEnk6lbRX2+cT3rDxpRdyjJ5mxhwPou?=
 =?iso-8859-1?Q?lQK8BSmmNyq/YIeDvn+j9RMpvmADemy1mM8ULJQUhHHZhqLN8KYjLs1uqW?=
 =?iso-8859-1?Q?FJz1OQEgzJwYAdNN+fuvS+mKo5jCgNqX2bNkAAi45UN5azCg4Hhm2D0dNY?=
 =?iso-8859-1?Q?zxvAsloc4droaY08YUSt5Y5H94oGyrFFly+nru7HeIOfS3jGy1u9pk4xxS?=
 =?iso-8859-1?Q?tiUwTKUzboPQUM7zMMw5y5bBDy2hP85+WGTWI9Ym/rTACnidvtV49jiExp?=
 =?iso-8859-1?Q?6KO7rg+QregPjEsMu8OFnT7wmh4uzwhd8Cj0aeuvyqiqV+ZBcsjs3waez6?=
 =?iso-8859-1?Q?+Hilu23VJA0B2Cy850izZ5BDb19yAEeyyF5AZLS5ZY5tieAck9LDtNOvYk?=
 =?iso-8859-1?Q?tvTeBG60LRo13trGQIWfyCg/+d3rICZsdPtkI+VqFYOF3R8qZlxgtITvm6?=
 =?iso-8859-1?Q?41iINTSkpn3OyVP48bnKI8smI5cKXHQnR7S5o0fGcu9F8o76+wZZkUgNxE?=
 =?iso-8859-1?Q?BbWAaw8T3ymyEHKKFU6hVbpNZYKIYEjGa2yFnFFYqvwuznSXS6d9XvGfGi?=
 =?iso-8859-1?Q?sWrzix05zCtAe67Owqn4//Y+AKuU/H78YqHCzJvXJ+CphBxEc3QLFCUe4Y?=
 =?iso-8859-1?Q?4rQCb39P6D31ZCg5/ruRocS2plDoWRlJueJWdUtCdY4Myihsvht5fcPCE/?=
 =?iso-8859-1?Q?5ZKfewPvEgoMpLMV/e9ejIsEuWeu8uDeqHOgmkaUEMtkdGTeCd5fbwJslk?=
 =?iso-8859-1?Q?nHuYi0SP0Yg7wwnAGofzVhF+QWuQCZSNKfpMawNWr/pLB2JVhL6ktFTzzG?=
 =?iso-8859-1?Q?8oVGZSpzC8eWaQee28MlVKz+LaT6VNUqDE495uFMc0/W3ogLnL9shDSKAS?=
 =?iso-8859-1?Q?9EGaoFpzYSRFgpRJUOGcrN2kni9pQAvjAUwKLOICdYiPYm/2JhXUZVe6BP?=
 =?iso-8859-1?Q?7KI/FsBvevxW+Qsi8lrLcsZkeSduW795Ql8Mf9jDAZ5BPkwBTeZyr2UNHL?=
 =?iso-8859-1?Q?X6IpDIfASsXblITluPkww6YN6zViXSloIC/RZ8XTWLfJFyaA30q/gBzuZv?=
 =?iso-8859-1?Q?tKiPDAQbbw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0BP4Jp16B0yBMMtYUpvCmqkDD/eX1Mt3vwtlgjeaN1JxOw4MO6/6USzDDXFCGKm0zDjSNMwBhx4Q0EwIH9qemEO8o4xq7tnQYtVbaG9OuoTIU3tf/wIGpNkTeRGH4x0m51Q+JuY2iTXsjhgyQ1cnpQAdoZbikZ3eLbd0283PpeH+0CG1C3HcQCJ62GuR4qSczepw/O6FxL40bccuUyFy/nfXc5RShhMATsjF/ba4DaE9ARyAldAB+Pr3iLGhFAGwvSiidQbE+/erYphZTbhjL3BG5T+yWteJpDcZH4nirUyOXbAyeg9eGhzpX1HLHCAHkbe98MaYwSDtww9lYAC/0g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64851c7-5b01-4b4e-123f-08df1888320b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:14.2117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJHpnOe784Yr6CDMgRLLHYs+j3kA4vDDdWmMhcpNYRc4c08vtPKKTbWtjodRdVDSNVIo75Wzb+qac0mJHCPV0l5wrP5jFVa8Ikicr9Lvm/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The controller can send an IN endpoint's data from a descriptor ring or=0A=
from a single buffer. Only the descriptor ring was modelled, so an IN=0A=
endpoint in single stage mode sent nothing.=0A=
=0A=
Add the path: one buffer at EP_DMA_BUFF, its length in PKT_SIZE, queued=0A=
by setting the write pointer. How to tell whether anything is queued=0A=
also depends on the mode. A descriptor ring is empty when its two=0A=
pointers are equal. A single stage buffer is queued by the write=0A=
pointer alone.=0A=
=0A=
The buffer can hold more than the host asks for in one request, so keep=0A=
an offset into it. The rest goes out when the host asks again, and the=0A=
guest is told only once all of it has gone.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |   2 +=0A=
 hw/usb/aspeed-udc.c         | 108 ++++++++++++++++++++++++++++++++++--=0A=
 2 files changed, 106 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 42916c0bd6..6665609501 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -53,6 +53,8 @@ typedef struct AspeedUDCEP {=0A=
     USBPacket *pkt;=0A=
     /* bytes of the current IN descriptor already served */=0A=
     uint32_t desc_off;=0A=
+    /* bytes of the single-stage IN buffer already sent */=0A=
+    uint32_t single_buf_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
 struct AspeedUDCGadget {=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index c48e2c5f1b..dcced1b8fb 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -566,6 +566,60 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(=
AspeedUDCState *s,=0A=
     return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * IN transfer: the guest gadget driver put one buffer in EP_DMA_BUFF, its=
=0A=
+ * length in PKT_SIZE, and kicked it with the write pointer. Copy that=0A=
+ * buffer into the host's IN packet.=0A=
+ *=0A=
+ * The buffer can hold more than the host asked for. Copy what fits and=0A=
+ * remember how far we got in single_buf_off, so the rest goes out when=0A=
+ * the host asks again.=0A=
+ *=0A=
+ * A buffer smaller than the packet makes a short packet, and in USB a=0A=
+ * short packet ends the transfer.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single(AspeedUDCState *s,=
=0A=
+                                                        int ep, USBPacket =
*p)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t buf_len =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT=
_SIZE);=0A=
+    uint32_t left =3D buf_len > e->single_buf_off ?=0A=
+                    buf_len - e->single_buf_off : 0;=0A=
+    uint32_t pkt_space =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                         pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+    uint32_t addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t len =3D MIN(left, pkt_space);=0A=
+=0A=
+    if (len && !aspeed_udc_ep_copy_to_pkt(s, ep, addr + e->single_buf_off,=
=0A=
+                                          len, p)) {=0A=
+        return ASPEED_UDC_XFER_ERROR;=0A=
+    }=0A=
+=0A=
+    e->single_buf_off +=3D len;=0A=
+=0A=
+    /*=0A=
+     * The packet is full, but the buffer is not finished. Complete the=0A=
+     * packet. Do not ACK, and leave WPTR set: the guest still owns the=0A=
+     * buffer, and the next IN request sends the rest.=0A=
+     */=0A=
+    if (e->single_buf_off < buf_len) {=0A=
+        return ASPEED_UDC_XFER_DONE;=0A=
+    }=0A=
+=0A=
+    /* All of the buffer went out. Retire it and tell the driver. */=0A=
+    e->single_buf_off =3D 0;=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       PKT_SIZE, buf_len);=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       WPTR, 0);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    return ASPEED_UDC_XFER_DONE;=0A=
+}=0A=
+=0A=
 /*=0A=
  * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
  * buffer the guest gadget driver set up.=0A=
@@ -667,6 +721,40 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState =
*s, int ep,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to queue one buffer t=
o=0A=
+ * send to the host. If a host IN request is already waiting (parked becau=
se=0A=
+ * there was no data before), send the buffer now and finish the request.=
=0A=
+ */=0A=
+static void aspeed_udc_ep_in_kick_single(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /* Do nothing if no host request is waiting, or no buffer was queued. =
*/=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* A kick serves a newly queued buffer, so start from its beginning. *=
/=0A=
+    e->single_buf_off =3D 0;=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in_single(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer =
for=0A=
  * OUT data. If an OUT packet is already waiting (parked because there was=
 no=0A=
@@ -739,6 +827,8 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr of=
fset, uint64_t data,=0A=
         } else {=0A=
             if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
                 aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
+            } else {=0A=
+                aspeed_udc_ep_in_kick_single(s, e->index);=0A=
             }=0A=
         }=0A=
         break;=0A=
@@ -774,6 +864,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
         s->ep[i].pkt =3D NULL;=0A=
         s->ep[i].desc_off =3D 0;=0A=
+        s->ep[i].single_buf_off =3D 0;=0A=
     }=0A=
 =0A=
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
@@ -896,22 +987,31 @@ static int aspeed_udc_find_ep(AspeedUDCState *s, int =
ep_nr, bool is_out)=0A=
 static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)=
=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    bool is_desc =3D FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_=
OP_EN);=0A=
     uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
     uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+    AspeedUDCXferResult res;=0A=
 =0A=
-    if (rptr =3D=3D wptr) {=0A=
+    /*=0A=
+     * In descriptor mode the ring is empty when the pointers meet;=0A=
+     * in single-stage mode one buffer is queued by setting the write poin=
ter.=0A=
+     */=0A=
+    if (is_desc ? (rptr =3D=3D wptr) : (wptr =3D=3D 0)) {=0A=
         /*=0A=
          * No IN data is queued yet. Save the packet and return ASYNC=0A=
          * instead of NAK. A NAK would make the host retry slowly.=0A=
-         * aspeed_udc_ep_in_kick_desc() serves and completes this packet l=
ater,=0A=
-         * once the guest gadget driver queues descriptors.=0A=
+         * The kick from the guest gadget driver serves and completes this=
=0A=
+         * packet later, once it queues something to send.=0A=
          */=0A=
         e->pkt =3D p;=0A=
         p->status =3D USB_RET_ASYNC;=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
+    res =3D is_desc ? aspeed_udc_ep_xfer_in_desc(s, ep, p)=0A=
+                  : aspeed_udc_ep_xfer_in_single(s, ep, p);=0A=
+=0A=
+    switch (res) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
-- =0A=
2.53.0=0A=

