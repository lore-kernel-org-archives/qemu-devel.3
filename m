Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B07606D03B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Ijo3EP9G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEl-00006f-Qa; Tue, 10 Nov 2026 03:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEc-0008WB-Hk; Tue, 10 Nov 2026 03:29:42 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEa-0002yp-Fa; Tue, 10 Nov 2026 03:29:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlLrc6DsT4YPLvCMkFkSVBCTj84DIw97WRh5hsqJluCglKM0cl+G7qTBudtBzQVcESSeGq78L5DQf/hvWBGxDKF9dAA/Bg3LYC+mREYzdn/nhUGHqb++1qnkkGS8QprAlBxRXB4Po9ERUEFm47LE9wKcadidqCW7j3B0rKiw/a5blWbmSHF57jr/AOWYjJ2fYa9WoQ9aao0x3UH13XG/Pi4Z6ArGGWKhtxHc1AD88AnWOCzKX4vxBtI8HSnDjTeyOYYT0x3vNmM8wBybx5g5LH3lQ4L9zAXoDB4tkSSyiu6GnKx4nb+iFGC9CJWd4ho5z2Bt47HgTsGxs4M15bQEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqTh4mAYo3Xq4wXEnINC8peVw2PNs4Qgk4K4T1FQl38=;
 b=lgzf0u8SfFuZinj1nIGFGsmzrkM59VO4a84z+YAl/EqvSwDI9sMEcSGbhbHkV5tbG/q4wDUmsrdgO/lGzyVfoFWHFdd7kfrokAzMFH4FfXMuuclQNL61i+EMNhAnJtHYofiJAgrHReKZRoinEYxB69VsgI33hHXteJzS/2ZuSBL70w6Xri2IS715SSWpXT3B+P6wFDS6+0XJNugLvnKNCogUZrjIKEvqilBOYrFW0S+DvMBrde4yOxSLdQNKMqKnnxPxnrJF9tbEyS5Cwfa6WWy2c8DkA2cr7a/Nf74gDyxOksVnTOdoURlo+XAhyEHvinHhh+WJXZhaXPu7joq/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqTh4mAYo3Xq4wXEnINC8peVw2PNs4Qgk4K4T1FQl38=;
 b=Ijo3EP9GZI3q7uOnBWhEeHtBZO/JCRSUXu7/PXTx3V6R+zzUc2dAJlzZMmuxlCQUoKV7l3DdX8PvzVlDM4pi+w+Rg9K+0h1rDotBRI5VKCRzNLO8ekMlXeeK5BbUNDeZpOeI3NAyjPFAYBk4Cg9kYY4WJFD8SqEknWlTvb1wCfF04uAycpcRW+y5eMAk2ivpyJBEsTDTAYJE2/6pLcsJxTEDZEawhODTxcfUx+DJVQA2LjXIlWZ9SfCUhP4/Rx2HCqcnGEwqi0zOJFvgrfhTEBK3ax7jOr8f2QPy5stlG5l+EPwRymQTOAi3DigpMtPMoww5eq3jZIDIA2ZvCUOvqA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 08:29:25 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 03/12] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
Thread-Topic: [PATCH v3 03/12] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
Thread-Index: AQHdcO2VRa30O60gv0SoyAqoQndtGA==
Date: Tue, 10 Nov 2026 08:29:21 +0000
Message-ID: <20261110082917.240329-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ef1f1f80-f627-4d58-da07-08df3f04ba83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|38070700021|261102123227099003|56012099006|261021123027099003|261021121427099003;
x-microsoft-antispam-message-info: 9FQRpV4LQlGYTCnLixmk/gGKwXOWTKAZXE7fflsm6A5v/QCns5EORSWU70XFnnAHv3dYbFFUT/dgv8h5kYd9NWD5HEuLCS6+mHlX/ETQuEg3YnUgR0Tc4/uUpNWEsW/xYlcyvAWPyxEt6yfSGvdlPT7V+mDCdb25etTciyZlICWscEjmC+KHZlfbmzCreZqnguwmNzwdXGkmEQ4yrXsE7yllRVHkntQ2puoNG0sTLDJNeuRb5NjBSjmOJ8kzyMsiTgKM6el/cyCb35qDEeLT4R9NkyRmxzPNtwGDz0A8OgZtRajD4h+FoBmV+/8b2osoyF07O3pX4J2AMOOhntiqlIz//T+UyChl6STugPSIPhK+5PegnkVxQpCFesK5Tk4g/lUGxJw2VkOXZ1N6UW564gqQyY89Z9UfLRxTJuDljOrBdsFl3P4HWGnoGTjUVk78pEKHucYOrGnLr4vNPzOmOtbba6hRsKCYXB37MJzYMi8GUJkTMIyoqgczLqPGtW1FzYitV1AEyjJOQ7cpA5bDc+O2yTQwlyAfZFJs3tBIlPEEYxFOoENpUYLXcqVSNZOEzwNhXNtqqebICVZKmQhyLqo8868O35yzTN64feZQ+vdvNI+4u0WY3hDpMgKMK1JgEHpsLQP4is5o1q/SJuXv9FfdUlJmGJQtwxAOqugpOtmVMr57FyD90Yp5PIzvddgADqe2eCxtdD8XUZJogZ9/FAwQ4D/REX5U9vq40SMRjBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VzwDVQ7j1zi1G1JnPEjGlOulwFqsVYVOmkJuNlVXA1eMmcN6uUbVOE/7m7?=
 =?iso-8859-1?Q?hI4mS1j9/1Lm8QnfJZfhLscFT0fzNuZX2W2znLFrWoBIE0N4SAVPQafNYF?=
 =?iso-8859-1?Q?wpEWsLtVVilIxMi2GXX7fAt4pAdNZGrWdjnSi8J1yKwAanA7eLYoDX0LTk?=
 =?iso-8859-1?Q?hY2ft3tTAOc6x9j5nrN0xAfidruOWVdZ7K6An0pXUXE/VK/buAIdRmfuyE?=
 =?iso-8859-1?Q?L3PYLGQtT8v3nCd8SBKYPaBQm3c/wCr4viT8gCFSP7dq9ldePCkYWCNcUn?=
 =?iso-8859-1?Q?/DLBGv/tmP45PP9Zpj1rNpprT5ChGV4SHPoRQFMRqN0xgF0b77K4Eh9CC5?=
 =?iso-8859-1?Q?OuD3lGlpq4G9TG/gt4G8uO6kUDgI0FYh54gE/oZegHGfJwSEC0rOr8SGI9?=
 =?iso-8859-1?Q?Z6LbkzbGcka33OmzZfY2YyOOZDTuoYL7z7oGcEJLyzT4dk6CBFveuh4CQg?=
 =?iso-8859-1?Q?MzER3JJQeJy3TYrmP8ohJ2VUgPB4nChvSz5IWBUI34pjfFDXncuKDVDma+?=
 =?iso-8859-1?Q?tUQduCaDFBPflO2PmV6KalnDW+pBXgOT0nK1eJ8cwXGMd7gfzF5KSdLzLH?=
 =?iso-8859-1?Q?17LK14f3GIRd7OAVCnwM280geGRddWC6AhLa7uo7k6kHyw4fJdgMnbkqrb?=
 =?iso-8859-1?Q?l7mUIF7D/kbnN9nyQtmdDBHJuqh1hWDYwJ5/+OgeW+H9v74FDbq+Ep6gdR?=
 =?iso-8859-1?Q?dHRYjeP13sFsQ8bI/nZpCGcALNc3/P54XWd6o8XEYFE06+HBf/gNt9mSdZ?=
 =?iso-8859-1?Q?hgviALFBTE0RlsiM2FFpbn5z3LZu0rs7egvNMPJmiZvDdZBgrTkcd2DK/5?=
 =?iso-8859-1?Q?NRqKWsD/Ro+/c8DWPqceP7P00VmWWnzNl+A6hnPtPBPOHdcn0TGzkoE2wb?=
 =?iso-8859-1?Q?h/aIBMnHCGGY4ffNHAi3vRYPkqecaR/LzxvjFkxtylttlza6GAbni/IyWY?=
 =?iso-8859-1?Q?jioQxvu9jsyUOvrFVqbcRbDWggAs5U4lI7TFfR1PKD2OQ3nNkQk0w0jTBb?=
 =?iso-8859-1?Q?Th2YTNIzZ2toucQKRE5HoHN554WpfOfcu2gaBU9GWE79cooiHfJiNA6nKe?=
 =?iso-8859-1?Q?MENKeT59AD0mJe+rz0W/SGd9iyRTwL5tk70KBIHRywHeuybHIqERDyrN+u?=
 =?iso-8859-1?Q?x9ITNTx1HTCx/u104cQrhXQopkSBifkOqjLwJf1ogHCgxVjfljCRoZ6fgi?=
 =?iso-8859-1?Q?HE8cf7DPOUSShdOmUF1FH1b44MbCyxBvkKDkwkx+EBP7ZXnPOjIK9CG7nc?=
 =?iso-8859-1?Q?apS31cnAHFcVE7zJI6SY62LeL7Nz8OdGYVi026VySTpYeoJdLnIyH9ypPs?=
 =?iso-8859-1?Q?QF+EIS+i0wRGD7zvx/HW9SewFmwZCShKSiR1h+8g+in+YiGNNPfGUUsDm5?=
 =?iso-8859-1?Q?5HnulJ8hQS9w7LgNfntO5f81c+1fJvyTwpY5uQV4IqZtF0WTxn9w6jxAXs?=
 =?iso-8859-1?Q?YDU5skW9X944iws+giK+aKF64N01Pvk0vcysj0KD247ca3iVAWVZsIwlAH?=
 =?iso-8859-1?Q?cSIc5rlQOHq0U4xPnMDR9kgHxtCarTaNavwnmVs8UEreITXLYjrvOfVvR/?=
 =?iso-8859-1?Q?VvY8zEUi1g16SPsFomKzwl7D8i5d4xMv1FYU83iXAPH5rWml0ih0npEKKL?=
 =?iso-8859-1?Q?R9f8T4mpDtDNJLP+Ndi7yWbIaeiR/ZqbD65F/14CzBu/AZt7NK2Uh8MsgR?=
 =?iso-8859-1?Q?RztxJ8Hl8TX9QenIiO1ulXJpOvyoH0iXxB8EoPXf3CeOL85Kc5cEc2dvxO?=
 =?iso-8859-1?Q?bfJArV1aXQnPUOeypwuLC+nUbGMPycbA7WhYIXpXJgouSPe1LvD1op9iEr?=
 =?iso-8859-1?Q?cvPnc1hIBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1f1f80-f627-4d58-da07-08df3f04ba83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:21.5678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egjWcvGmmL54cI7RrwlrY2Sgbaee/9eZsXo+QKewrY6Ood1n9yRb4ys7JAXOxC7jVnQmI+zdJVm8dTSaj2gfxg6r58n7cNFZCd7Uwr8ynWc=
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

Writes to the interrupt registers were not masked, so a guest could set=0A=
a reserved bit and read it back. The hardware returns 0 for those.=0A=
=0A=
Mask each one to the bits the datasheet marks read/write:=0A=
=0A=
  UDC_IER         17, 16, 8:6, 4:0=0A=
  UDC_ISR         8:6, 4:0=0A=
  UDC_EP_ACK_IER  3:0=0A=
  UDC_EP_NAK_IER  3:0=0A=
  UDC_EP_ACK_ISR  3:0=0A=
  UDC_EP_NAK_ISR  3:0=0A=
=0A=
UDC_ISR bits 17 and 16 summarise the endpoint pool. They are read only,=0A=
so a write cannot clear them.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 6a5d05ce1f..945940cc99 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -329,14 +329,24 @@ static void aspeed_udc_write(void *opaque, hwaddr off=
set, uint64_t data,=0A=
         s->regs[R_UDC_FUNC_CTRL] =3D val;=0A=
         break;=0A=
     case R_UDC_IER:=0A=
+        val &=3D 0x000301df;=0A=
+        s->regs[reg] =3D val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
+    case R_UDC_ISR:=0A=
+        val &=3D 0x000001df;=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
     case R_UDC_EP_ACK_IER:=0A=
     case R_UDC_EP_NAK_IER:=0A=
+        val &=3D 0x0000000f;=0A=
         s->regs[reg] =3D val;=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
-    case R_UDC_ISR:=0A=
     case R_UDC_EP_ACK_ISR:=0A=
     case R_UDC_EP_NAK_ISR:=0A=
+        val &=3D 0x0000000f;=0A=
         s->regs[reg] &=3D ~val;=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

