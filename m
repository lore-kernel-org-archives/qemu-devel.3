Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800EDC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yD1-0001QX-CP; Mon, 31 Aug 2026 05:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yCz-0001Os-He; Mon, 31 Aug 2026 05:21:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yCw-0004qT-4j; Mon, 31 Aug 2026 05:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nht56dl0HT4l8/fZg2rMdrhdX7QUn9knNSc2H7iWBcc6TUOS5QP327DYZwnj+clI5+vmyKgOfNUpqUXPsy2w9v+X0mipaLM/UvQs0vn6Ip6w20mFd+YEn1xmPDBSckni6++SO+IVTKaGRbncFucRAmxOdKBSSMv9yOeb8QHs0S2Ndx3eHb79qBg7D2wk6JaIrgplkj271B2vU8tw6n+HZIgilf/61lMQwGXra5W7JDReKsMY+yg4lBcwz/4FqtGoyQHUkBruVCpN87OKqaE5VAqQbXqQvJtIIAw3gV+qGKmn3d0aXnt2iVotVB2uBF7yLsupCVuTxG6ONYNw6xMHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp/w82jFrUCgFrw+r5XjaSCOJHZNlACpQuvKlgNQF4Q=;
 b=Zq1rlznFJ3wGTP4KFM6a4RKFLbhoQUzoLW5QXhTKvALE1wAaHKlRMIoRlE3h2e8Uhlx4YnlQTGVwi1IDonpsyM8GxWgBfdxb/omMji2RiB7ioYITAMWAt3Ji4j5/uKcShFRKOZ+EE7kMqEnPkIXPq4AXheRgzWDKyRfUBNWgwsKaVLylUiFNAFbdoLEDlkdwn7VTn7wVcMs2SB4YOTbhnkwCe8tWym/jAf03GTKSI0hjoa3he+Y+c2nokq2+GIPyC5j/edVHISFd7vcR+J8ShB1YsOrRBRXQWlWY7UCZrYpvFRGik0EGIe1t31FNlnEMyeyTjt35kO7P4SLDz0DTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp/w82jFrUCgFrw+r5XjaSCOJHZNlACpQuvKlgNQF4Q=;
 b=RNG4MO9z2kgvueVVH0vGJaqicmH+i3qE4yJgjpXUH3tUTW7UgpmIp8G/+TfV06pg/q2i4iBlyt2HqMIm5FkmNRiuoN1Dc5Q1fQitJYvgTdIjoJ7guyPGon91iv0SrXqBhXFtE92vIx9gXEltJxIfbJEymJPADs7R7LEIB+FD5pgNTHj2yR1MD8KZBVYCYOGpJdv05R507PAPrpCx62O+6WYiBtXy7P83r9+dUOF/Fj0OTvFfRfUJps42jC11VJIezwkfd4ZEIrwo5aMKQwfo3LIeQiFa11lGiNkWASSJlSR97pP6b6DybOWQt4Gc2zi9wK3rUV40AuXP3Q4utD7/2Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5018.apcprd06.prod.outlook.com (2603:1096:4:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Mon, 31 Aug
 2026 09:21:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:21:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Thread-Topic: [PATCH v3 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Thread-Index: AQHdOSobn5pbI0bj3kmqa3KsmmW56g==
Date: Mon, 31 Aug 2026 09:21:29 +0000
Message-ID: <20260831092125.1022201-4-jamin_lin@aspeedtech.com>
References: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5018:EE_
x-ms-office365-filtering-correlation-id: 10f5db53-cdd5-49c8-e06c-08df07413dcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|921020|38070700021|6133799003|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: nwR5OH6H6lawcO8CYV1+xFVLxjfnQrA/sxU0rWV2+KNKPAEFK+D2Fr3gvPGzhg7TDatHokw6m6TH7+hdntgAu1SeDcTCMMHnko3XQt9XTsjrn+8TKRoKI9+wPxpIWQEH4APUpXnLdSBT2lg6/hcL7qisZPhHKt0Ms5Yszj9vfepI2fgRN8mTT+X28VQiu82BXpqGc9G9Gk2zRPfMrZlhZaSPVxjCHWFnIv24xJc6iuM84gh2zpT7xmX4AtSMarCFSUc0XXHyxTWduBy5FfgmdXM0Iki8JJ0MPG35zEayRE4GGWbsoik3X9vaRpOPtOPEl+a/MfE4IpzqJFc9Kq5gfFpyD8K4eXDocREU5IXKzSeFZtq8CaVDVn7vvXw5cPX8Xaj3ZJGQ1AhbB7IF/JbYsuwTOvZZXZEEJEc0qsAR3yAOWtd8iYl7CmuYlOMTNnE7bqwPgqrXJ3rgxKuOr6gV/4wd2cfcDpxkXIktFoMdxLrA2loUyTsARsBjsl+X8dpKNcpphmYYV3dCkawxs10VbK3caVBOdhxiBXcUZdN27NadTz+BinQpJm2woXceM1FnisrxQevI+J9WQxrwE/p/g1yDKFi9oxNPHE7xq9n/tbLe9r0Q2ivqhMdiuw6SDOKi8cXB3QjjERtllLdHIa9bDpkQJ0XSNuSfUFABqE3eXO0ttpK3B4UBxIyhPuhTgP59g0sNPU7oCkt/DIcTk94m+QSDDUvQxTf8wWkDaj+tvNgWpX3WVFhjxu27R+HZF0nt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(921020)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EPsd0VtuCB0a2PhEi1kRdYyA9DrV/HALeJfmm0VhH5b3VDWSdgbEj/SNLr?=
 =?iso-8859-1?Q?uwZ384k87ExHhZSAiK9H7ze1W1XQjckQ//B6CTHg/8EWQfOrn8W0QG2O2p?=
 =?iso-8859-1?Q?rGU9PBI+v3jcmJ4dnyFbDXMYIav0pOQYqi+Ou+ZWYFtHDzbMIqm9quVivT?=
 =?iso-8859-1?Q?t8g5r9Z4HeUodAxEx2ObDT6GJho29XTGLCT4Rv8mX95ftW48VHAnq4rMCj?=
 =?iso-8859-1?Q?ixxFlcfUpO+xbLhxaOlowt8YiZ8TTV1ZLXE9tjDoYl44Xki6WGlYjAvr3g?=
 =?iso-8859-1?Q?L+gBKRv0kMTRSWamjgQWxsfied/AQM2Bt7d1nfdlhm6HCdzxWeX9ZG2TmZ?=
 =?iso-8859-1?Q?9zUjZrCa2hvQMpeHScbK1oPv9D6PqhNBcl1U/rhRmjSBhy1VcyaxtYn1HP?=
 =?iso-8859-1?Q?JG1I7EgDVNacJpNxaNyvJ1fTdWYwiULnK5+aGMQCIZnGVFPoddG2pxSvIY?=
 =?iso-8859-1?Q?O7k57QnpllMHedlbFINz3m7AR62sKjAND/ferZlf9Ed9rPukLtmFiZ7ZTo?=
 =?iso-8859-1?Q?MhtmxbP8wuRX3aZbjOGLvJWpJfV37YxsDqQdKQK/40KsYmlvVP7SPKPOu6?=
 =?iso-8859-1?Q?MSBNM5pWQXSp/fikFyMB5ZZe6SbF3HG5gmfWvm1VmiQ/UmTJZPWyRTrttK?=
 =?iso-8859-1?Q?EdAwJ1VCfiHCbL5Kvv7/2sGMZMCmeqZz/2pa/M+asWN0CY0Uc6ZTpH/4UC?=
 =?iso-8859-1?Q?XaAG7GPkgKaajFxtmDeFT+sOR9PE69nr7ZIzWUvXeDm/m+ATdzFaS0kFuw?=
 =?iso-8859-1?Q?WrrAlLTO2Vp7kfY01CHJ7C7i+QHkn87SAlUpAYUOH+/64vWUETKIT0ecA5?=
 =?iso-8859-1?Q?62XgUZsMjcwrezaNLqI1x5SfixdnhKumdZjvfq6zEckaLZh3o0lcahtXpl?=
 =?iso-8859-1?Q?m0c0XVRhIeSe1m9+d0wkCkzHsqh+YpDb5MK2CYJeCADA6Hm5QM8vEY2Gne?=
 =?iso-8859-1?Q?aXyux8n5i3/WTo5XAGAE2gcY5H+wq2Qg9Bi300wh0eVfV2TgUkdzd1E5ag?=
 =?iso-8859-1?Q?TxKEawKWD8r0wwA+Aau06C4Uel0arywxYJYHH6KTbEBUcBLBVT3NTmVTya?=
 =?iso-8859-1?Q?ZDQs++lePkUhNqlPVa8ynOlzAFzmE0gXrp+8sY/TQ9JOUONnuO6MCAIVAe?=
 =?iso-8859-1?Q?ieXvwvvBjyLMFDajTXlFXay1bMi1zPZzBeYPactUdzxcv3rmNAg+ZpS8ez?=
 =?iso-8859-1?Q?AHhiv8Dx0HlU3RGr3tPSd6piP1lUtLGyLH8gcZ/w92yAUXBalxLYUFY6s5?=
 =?iso-8859-1?Q?FeZpt4sXjqcbenvSJPA1Sk+/3iwFZ5IgpUhS6Hxr8Dftx4JIjpC0aru0+o?=
 =?iso-8859-1?Q?OyNK9kOCU5WVnRIGfZg4Il1CTC+KaQiiZdar8G/Xri4YE2pvm/qKSgCdYB?=
 =?iso-8859-1?Q?1wdVvnyKDXl4H6ji9eTjZ7liGm9LzqDRaE1MRvoQVdOgp8NNCIOoWHShzz?=
 =?iso-8859-1?Q?XgtkEuGmHuSMQaJ29aF0m56ls9p/NeRS2udg6gireIxgfCD0blc9CcMXMT?=
 =?iso-8859-1?Q?msQw2a8soIOt3fr8+axf5dQwKNIrP5+xhsCHhIYFhbUEAjexWPFIr1llCV?=
 =?iso-8859-1?Q?FFsX7I7ar82zRzXZALHSJdrc0TRy1DVhumpXT9u94ihkXN/YMlqifD+c34?=
 =?iso-8859-1?Q?1GF7iZTE0FEDcNk0B/pF7IJzRnw2POsH2EUThbz1KJbKWDtJmHen5N8VDo?=
 =?iso-8859-1?Q?d+W60sQ/yk6DngYtHdaItTiLOtR2Y8BAKKjAc7o6T5CGQHi/iLa6xvbpFm?=
 =?iso-8859-1?Q?mUjPqs0X1xuTXaImHgwzsmbuV5ZQ8QEl5O8GnfHyz9HLummUVEn8bCNwjo?=
 =?iso-8859-1?Q?FqcuPTqw5Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sTYMsDz+UGVLuDBCSsMZ6XKtByGYejQ744FagbLr5wxFbX+mE9d2nKqnQH/lrWaYPCk47ff4luwhoHddsOJ61bZjoyRgQJc8XN6VgVpBlv0PS4ZBW0B2v9SKBjPyJYcFFinYR9+KbPdgAED1KzPIhJRr4aYkzVen3VrvcqM7F2JvVG1jwII+sXziziIs2qBgT3eQLHYaFd6RKOZZbHWc9yUQ4UcYfsh9YtbW0VarHeZLj5CUqPkddUXpo6dtcFdhUvFlm/L+l+cCO+S++JSUh39hkW2tcfRIS7ZpYLse4JrZOjI5Jx1gBQ6U33mnSOEpmXdHdAUL8JgqDwEa95NmDQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f5db53-cdd5-49c8-e06c-08df07413dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 09:21:29.7587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9so07di7GkNO4zow5kA7B0mCjN8q2a2y8Nm9NGibK9p4DmEtndBLoCI3PPHIfPlCpBzDz60VEeDLrPFpsvOlXfclWw7vTSSFqZ/EffZYyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5018
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

Add the bulk data plane for the four programmable endpoints. The gadget=0A=
driver queues IN data through the descriptor-list DMA ring and arms OUT=0A=
buffers through the single-stage DMA registers; host bulk transactions=0A=
are served from / delivered into those.=0A=
=0A=
The DMA mode is taken from EP_DMA_CTRL.DESC_OP_EN: IN endpoints use the=0A=
descriptor-list ring, OUT endpoints use single-stage buffers.=0A=
=0A=
A transfer larger than one host packet is served across several polls,=0A=
with the host packet parked (USB_RET_ASYNC) until the gadget queues (IN)=0A=
or arms (OUT) more data, then completed from the matching DMA kick.=0A=
=0A=
With this the gadget data endpoints work, e.g. a mass-storage gadget can=0A=
be enumerated and read/written end to end.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |   8 +=0A=
 hw/usb/aspeed-udc.c         | 457 +++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events         |   4 +=0A=
 3 files changed, 464 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index ab9d016c61..7701c1aa34 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -42,6 +42,14 @@ typedef struct AspeedUDCEP {=0A=
     MemoryRegion mr;=0A=
     uint32_t regs[ASPEED_UDC_EP_NR_REGS];=0A=
     int index;=0A=
+=0A=
+    /*=0A=
+     * host packet parked until the guest gadget driver queues (IN) or=0A=
+     * arms (OUT) data=0A=
+     */=0A=
+    USBPacket *pkt;=0A=
+    /* bytes of the current IN descriptor already served */=0A=
+    uint32_t desc_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
 struct AspeedUDCGadget {=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 70a2296062..a6eaf6f97b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -72,12 +72,37 @@ REG32(EP_DMA_CTRL, 0x04)=0A=
     FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)=0A=
     FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)=0A=
 REG32(EP_DMA_BUFF, 0x08)=0A=
+    FIELD(EP_DMA_BUFF, BASE_ADDR,           0, 31)=0A=
 REG32(EP_DMA_STS, 0x0C)=0A=
     FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)=0A=
     FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
     FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
 =0A=
-#define ASPEED_UDC_EP0_MAXPKT      64=0A=
+#define ASPEED_UDC_EP0_MAXPKT   64=0A=
+#define ASPEED_UDC_EP_MAXPKT    1024=0A=
+=0A=
+/* DMA descriptor ring (256-stage mode) and descriptor data limits */=0A=
+#define ASPEED_UDC_DESCS_COUNT  256=0A=
+#define ASPEED_UDC_DESC_MAX_LEN 4096=0A=
+=0A=
+/* DMA processing-status idle codes */=0A=
+#define EP_DMA_CTRL_STS_RX_IDLE 0x0=0A=
+#define EP_DMA_CTRL_STS_TX_IDLE 0x8=0A=
+=0A=
+/* DMA descriptor (DES1) fields, in guest memory */=0A=
+#define ASPEED_EP_DESC1_IN_LEN(ctrl)   ((ctrl) & 0x1fff)=0A=
+/* interrupt-on-completion */=0A=
+#define ASPEED_EP_DESC1_INTR           BIT(31)=0A=
+=0A=
+/* Result of moving a host data packet through an endpoint's DMA */=0A=
+typedef enum {=0A=
+    /* whole packet transferred */=0A=
+    ASPEED_UDC_XFER_DONE,=0A=
+    /* not finished, keep parked */=0A=
+    ASPEED_UDC_XFER_MORE,=0A=
+    /* DMA failed */=0A=
+    ASPEED_UDC_XFER_ERROR,=0A=
+} AspeedUDCXferResult;=0A=
 =0A=
 static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
 {=0A=
@@ -97,6 +122,14 @@ static void aspeed_udc_raise_isr(AspeedUDCState *s, uin=
t32_t mask)=0A=
     aspeed_udc_update_irq(s);=0A=
 }=0A=
 =0A=
+static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    trace_aspeed_udc_ep_ack(ep);=0A=
+    s->regs[R_UDC_EP_ACK_ISR] |=3D BIT(ep);=0A=
+    s->regs[R_UDC_ISR] |=3D R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
 /*=0A=
  * System bus device: MMIO register interface (guest gadget-driver facing)=
=0A=
  */=0A=
@@ -330,6 +363,288 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
+ * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
+ */=0A=
+static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s, int ep, uint32_t =
addr,=0A=
+                                      uint32_t len, USBPacket *p)=0A=
+{=0A=
+    uint8_t buf[ASPEED_UDC_EP_MAXPKT];=0A=
+    uint32_t copied =3D 0;=0A=
+    uint32_t seg;=0A=
+=0A=
+    while (copied < len) {=0A=
+        seg =3D MIN(len - copied, sizeof(buf));=0A=
+        if (address_space_read(&s->dram_as, addr + copied,=0A=
+                               MEMTXATTRS_UNSPECIFIED, buf, seg) !=3D MEMT=
X_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep %d IN data DMA read failed\n", __func__,=
=0A=
+                          ep);=0A=
+            return false;=0A=
+        }=0A=
+        usb_packet_copy(p, buf, seg);=0A=
+        copied +=3D seg;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN transfer: send data to the host by filling its IN packet from the=0A=
+ * buffers the guest gadget driver queued in the descriptor ring (from the=
=0A=
+ * read pointer to the write pointer).=0A=
+ *=0A=
+ * One host packet can be bigger than one descriptor's buffer, so we copy =
from=0A=
+ * several descriptors in a row until the packet is full or the ring is em=
pty.=0A=
+ * If a descriptor is too big for the space left in the packet, we copy on=
ly=0A=
+ * part of it now and copy the rest on the next call; desc_off remembers h=
ow=0A=
+ * far we got. We move the read pointer to the next descriptor only after =
a=0A=
+ * descriptor is fully copied, so the guest gadget driver can read the poi=
nter=0A=
+ * and see how much was sent.=0A=
+ *=0A=
+ * This function raises the endpoint ACK by itself when the ring becomes e=
mpty=0A=
+ * or when a descriptor asks for an interrupt.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep=
,=0A=
+                                                 USBPacket *p)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t mps =3D FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);=
=0A=
+    uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t desc_base =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t desc_addr;=0A=
+    uint32_t remaining;=0A=
+    uint32_t desc_ctrl;=0A=
+    uint32_t pkt_space;=0A=
+    /* des_0: data buffer base address, des_1: control/status */=0A=
+    uint32_t desc[2];=0A=
+    uint32_t offset;=0A=
+    uint32_t chunk;=0A=
+    uint32_t dlen;=0A=
+    bool done =3D false;=0A=
+    bool ack =3D false;=0A=
+=0A=
+    if (mps =3D=3D 0) {=0A=
+        /* a MAX_PKT field of 0 means the maximum packet size */=0A=
+        mps =3D ASPEED_UDC_EP_MAXPKT;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);=0A=
+=0A=
+    /* walk the queued descriptors, filling the packet */=0A=
+    while (rptr !=3D wptr) {=0A=
+        if (address_space_read(&s->dram_as, desc_base + rptr * sizeof(desc=
),=0A=
+                               MEMTXATTRS_UNSPECIFIED, desc,=0A=
+                               sizeof(desc)) !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep %d descriptor DMA read failed\n",=0A=
+                          __func__, ep);=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+        desc_addr =3D le32_to_cpu(desc[0]) & R_EP_DMA_BUFF_BASE_ADDR_MASK;=
=0A=
+        desc_ctrl =3D le32_to_cpu(desc[1]);=0A=
+        dlen =3D ASPEED_EP_DESC1_IN_LEN(desc_ctrl);=0A=
+        offset =3D e->desc_off;=0A=
+        /* how much to copy: min(descriptor bytes left, packet space left)=
 */=0A=
+        remaining =3D dlen > offset ? dlen - offset : 0;=0A=
+        pkt_space =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                    pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+        chunk =3D MIN(remaining, pkt_space);=0A=
+=0A=
+        if (!aspeed_udc_ep_copy_to_pkt(s, ep, desc_addr + offset, chunk, p=
)) {=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+        e->desc_off +=3D chunk;=0A=
+=0A=
+        if (e->desc_off < dlen) {=0A=
+            /*=0A=
+             * The packet ran out of space in the middle of this descripto=
r,=0A=
+             * so only part of it was copied. Stop here, and leave the rea=
d=0A=
+             * pointer on this descriptor: the next call resumes copying t=
he=0A=
+             * rest (desc_off remembers how far we got).=0A=
+             */=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * This descriptor was copied in full. Advance the read pointer to=
 the=0A=
+         * next descriptor and reset desc_off so it starts from the beginn=
ing.=0A=
+         */=0A=
+        rptr =3D (rptr + 1) % ASPEED_UDC_DESCS_COUNT;=0A=
+        e->desc_off =3D 0;=0A=
+        if (desc_ctrl & ASPEED_EP_DESC1_INTR) {=0A=
+            ack =3D true;=0A=
+        }=0A=
+        /*=0A=
+         * This descriptor is shorter than the max packet size, i.e. a sho=
rt=0A=
+         * (or zero-length) packet. In USB that marks the end of the trans=
fer,=0A=
+         * so stop here.=0A=
+         */=0A=
+        if (dlen < mps) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+        /*=0A=
+         * The packet is now completely full, so the host has received all=
 the=0A=
+         * data it asked for. Stop here.=0A=
+         */=0A=
+        if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       RPTR, rptr);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    /* The guest gadget driver completes its request when the ring drains =
*/=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        ack =3D true;=0A=
+    }=0A=
+    if (ack) {=0A=
+        aspeed_udc_raise_ep_ack(s, ep);=0A=
+    }=0A=
+=0A=
+    return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
+ * buffer the guest gadget driver set up (single-stage mode).=0A=
+ *=0A=
+ * A host packet can be bigger than one buffer, so we copy at most PKT_SIZ=
E=0A=
+ * bytes per call, continuing from where the last call stopped=0A=
+ * (p->actual_length). The caller keeps the packet parked until it is full=
y=0A=
+ * copied.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int e=
p,=0A=
+                                                  USBPacket *p)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_S=
IZE);=0A=
+    uint32_t remaining =3D p->iov.size - (uint32_t)p->actual_length;=0A=
+    uint32_t data_buf_addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t len =3D MIN(remaining, chunk);=0A=
+    uint8_t buf[ASPEED_UDC_DESC_MAX_LEN];=0A=
+=0A=
+    if (data_buf_addr && len) {=0A=
+        len =3D MIN(len, sizeof(buf));=0A=
+        usb_packet_copy(p, buf, len);=0A=
+        if (address_space_write(&s->dram_as, data_buf_addr,=0A=
+                                MEMTXATTRS_UNSPECIFIED, buf,=0A=
+                                len) !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep %d OUT data DMA write failed\n",=0A=
+                          __func__, ep);=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS],=0A=
+                                       EP_DMA_STS, PKT_SIZE, len);=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS],=0A=
+                                       EP_DMA_STS, WPTR, 0);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    if ((uint32_t)p->actual_length >=3D p->iov.size) {=0A=
+        return ASPEED_UDC_XFER_DONE;=0A=
+    }=0A=
+=0A=
+    return ASPEED_UDC_XFER_MORE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to tell us it queued =
more=0A=
+ * IN data to send to the host. If a host IN request is already waiting=0A=
+ * (parked because there was no data before), send the data now and finish=
 it.=0A=
+ * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
+ * the next kick.=0A=
+ */=0A=
+static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)=
=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
+    uint32_t new_rptr =3D FIELD_EX32(val, EP_DMA_STS, RPTR);=0A=
+    uint32_t new_wptr =3D FIELD_EX32(val, EP_DMA_STS, WPTR);=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /*=0A=
+     * A normal kick only sets the write pointer and leaves the read-point=
er=0A=
+     * field 0 (the read pointer is ours to advance). The guest resets the=
 ring=0A=
+     * by writing a read pointer that is non-zero and equal to the write=
=0A=
+     * pointer.=0A=
+     *=0A=
+     * We check non-zero as well as equal: on a normal kick whose write po=
inter=0A=
+     * just wrapped back to 0, both fields would be 0, so an "equal" test =
alone=0A=
+     * would look like a reset by mistake.=0A=
+     */=0A=
+    if (new_rptr !=3D 0 && new_rptr =3D=3D new_wptr) {=0A=
+        cur_rptr =3D new_rptr;=0A=
+        e->desc_off =3D 0;=0A=
+    }=0A=
+    /* store the guest's write, but keep our own read pointer */=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);=
=0A=
+=0A=
+    /* nothing to do unless an IN packet is waiting and the ring has data =
*/=0A=
+    if (!p || cur_rptr =3D=3D new_wptr) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
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
+/*=0A=
+ * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer =
for=0A=
+ * OUT data. If an OUT packet is already waiting (parked because there was=
 no=0A=
+ * buffer before), copy its data into the buffer now and finish it. If the=
=0A=
+ * packet has more data than fits, keep it parked and wait for the next bu=
ffer.=0A=
+ */=0A=
+static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /* nothing to do unless an OUT packet is waiting and a buffer is ready=
 */=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
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
 static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
@@ -346,10 +661,31 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
                                 unsigned size)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
+    AspeedUDCState *s =3D container_of(e - e->index, AspeedUDCState, ep[0]=
);=0A=
     uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
 =0A=
-    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
-    e->regs[reg] =3D data;=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_EP_DMA_BUFF:=0A=
+        e->regs[reg] =3D val & R_EP_DMA_BUFF_BASE_ADDR_MASK;=0A=
+        break;=0A=
+    case R_EP_DMA_STS:=0A=
+        val &=3D 0x77ffffff;=0A=
+        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
+            /* IN, descriptor-list mode */=0A=
+            aspeed_udc_ep_in_kick(s, e->index, val);=0A=
+        } else {=0A=
+            /* OUT, single-stage mode */=0A=
+            e->regs[reg] =3D val;=0A=
+            aspeed_udc_ep_out_kick(s, e->index);=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        e->regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
@@ -375,6 +711,8 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
+        s->ep[i].pkt =3D NULL;=0A=
+        s->ep[i].desc_off =3D 0;=0A=
     }=0A=
 =0A=
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
@@ -468,6 +806,95 @@ static void aspeed_udc_class_init(ObjectClass *klass, =
const void *data)=0A=
  * through the MMIO register interface above.=0A=
  */=0A=
 =0A=
+static int aspeed_udc_find_ep(AspeedUDCState *s, int ep_nr, bool is_out)=
=0A=
+{=0A=
+    uint32_t cfg;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        cfg =3D s->ep[i].regs[R_EP_CONFIG];=0A=
+=0A=
+        if (!FIELD_EX32(cfg, EP_CONFIG, ENABLE) ||=0A=
+            FIELD_EX32(cfg, EP_CONFIG, EP_NUM) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        if (FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) =3D=3D is_out) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)=
=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        /*=0A=
+         * No IN data is queued yet. Save the packet and return ASYNC=0A=
+         * instead of NAK. A NAK would make the host retry slowly.=0A=
+         * aspeed_udc_ep_in_kick() serves and completes this packet later,=
=0A=
+         * once the guest gadget driver queues descriptors.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        /* not fully sent yet: save the packet, wait for more descriptors =
*/=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_out(AspeedUDCState *s, int ep, USBPacket *p=
)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+=0A=
+    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),=0A=
+                                 FIELD_EX32(sts, EP_DMA_STS, PKT_SIZE),=0A=
+                                 p->iov.size);=0A=
+    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {=0A=
+        /*=0A=
+         * No OUT buffer is ready yet. Save the packet and return ASYNC=0A=
+         * instead of NAK. Writing now could use an old buffer address and=
=0A=
+         * lose the data (for example a mass-storage CBW). A NAK would mak=
e=0A=
+         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this=
=0A=
+         * packet later, once the guest gadget driver sets up a buffer.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        /* not fully received yet: save the packet, wait for the next buff=
er */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_udc_gadget_handle_reset(USBDevice *udev)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
@@ -531,17 +958,37 @@ static void aspeed_udc_gadget_handle_control(USBDevic=
e *udev, USBPacket *p,=0A=
 =0A=
 static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)=
=0A=
 {=0A=
-    /* Programmable endpoint (bulk) transfers are added in a later patch. =
*/=0A=
-    p->status =3D USB_RET_STALL;=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    bool is_out =3D (p->pid =3D=3D USB_TOKEN_OUT);=0A=
+    int ep =3D aspeed_udc_find_ep(s, p->ep->nr, is_out);=0A=
+=0A=
+    trace_aspeed_udc_handle_data(p->ep->nr, is_out ? "OUT" : "IN",=0A=
+                                 p->iov.size, ep);=0A=
+    if (ep < 0) {=0A=
+        p->status =3D USB_RET_STALL;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (is_out) {=0A=
+        aspeed_udc_ep_data_out(s, ep, p);=0A=
+    } else {=0A=
+        aspeed_udc_ep_data_in(s, ep, p);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)=
=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    int i;=0A=
 =0A=
     if (s->ep0_packet =3D=3D p) {=0A=
         s->ep0_packet =3D NULL;=0A=
     }=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        if (s->ep[i].pkt =3D=3D p) {=0A=
+            s->ep[i].pkt =3D NULL;=0A=
+        }=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 098c3d6179..80ead23358 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -389,3 +389,7 @@ aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"=0A=
 aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t i=
ndex, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bReques=
t 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"=0A=
 aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val =
0x%x, dir_in %d, off %u"=0A=
 aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"=0A=
+aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_id=
x) "ep_nr %d, %s, iov %u, ep_idx %d"=0A=
+aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
+aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
+aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
-- =0A=
2.53.0=0A=

