Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AF2C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOO-0007Z4-26; Tue, 22 Sep 2026 05:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOJ-0007W5-3h; Tue, 22 Sep 2026 05:02:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOH-0002CW-A7; Tue, 22 Sep 2026 05:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqGIGeYEqHacU0mh1zXUQJSj/LIfxP47abufEmNVz20iHurOTmzLV3yY+4Asr2LyR+FLxZlMY2z5L6HF4Atd3z9zeaF3KfoU1myexj8tLcIcvfr56tHR3sxC/pGZ3dPyFHgvHCxQK5c12qcwqLlf0fsdCjOvgHgE2wB9uL22aNX5LI9f2k6Uy/WcfrxYuSWZK6lpMiVtM84HIvMLgbECWSC+OhyXzEEI+PhFk3Vx8X1q5zyG3g9RwZPljTjUVeKQMKxlzX02LPJtVaWOM8SgtKDLn/fI8ZRafW1l8flS60pAWiPZWHj/jXcJ4LlwAG1S8TuGfqTH9B7MeK+M6Ml5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU/JmFyj8AjEXc6vxUStaeKcG+jPAL6ABpcehOkBosE=;
 b=OrKC+OMMb+rOCB7WSGJi2QDAdGSBXGuDR8SDBDU+4iZf1m1pofK7BXsyK/kqiVMTef4tHZIPeZFPB3tO2PeOPykT1cD3z9MFMOcufSd0UENokJ/A3BdaMGd43ooBUksLy1LCS8oiNiadBIESis3ON3YijfQSmV0gDY0bOsMJg6O1DQYcSwhE8uE6esta+zi22Z3FVkcoovp6sT0490VlDHfyN0XB+RpLD3pwqw5t63aQ2nyDv5O0YFdg6zXcOhgD0+gceyQF2kquAxGIvsxRslKwoSGXJYCoyTFJgAqgn+uBU91JCq55WpixkWg3Q+rRFmhD7jZpLEzE214k6G1EOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU/JmFyj8AjEXc6vxUStaeKcG+jPAL6ABpcehOkBosE=;
 b=Kqz0IpbUI2O9zBk/96XFHigH4l03UmxCo14xZIQH3+p6/IzqZnSCm5EcK8SQjurXRgkgneJFXNvM39km6LEcd5RR5SeT7HNbcZVfVs+regcg5UvSIt1Jp5KwFBEj25/9W6r+OpVdpi2yUnoSO68aNliZSP6t8rbqHl6ne713ODkqfQh+ZvVUpsMQpHW5UBzDE7D956bXhAcdSp58p7hMqqCv62IDPbT/2o7CXvesqKo5Z7Sud5dR4wLA89wjL90hdhY7rJfo3od011lXvxXZ2c/4bFdJ8/Eeuvi0jjdicTTWkV7ka/UweHn1eoyjdmOpRz7CkIBfFI8K1aJc2XE2yA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:08 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 10/19] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
Thread-Topic: [PATCH v1 10/19] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
Thread-Index: AQHdSnELYWGsFRo56EGJRFVl2z0+aQ==
Date: Tue, 22 Sep 2026 09:02:08 +0000
Message-ID: <20260922090154.1792077-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 83f07ad7-696f-4f7a-49e1-08df18882e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: cr70NrLW1WNXSegptlR6wtgkpBajQ1WVONTpUdA80Puxu+oQwIu0X9sguC6efOBJP3fPLxMkQWFaNsTW3bN3olK1JE2ygpVoF+qrvC6Jzmg5kgbNvRpWp7xpvARmgl763sCOaVIa9IyCRP3VP/cK4y++pULxSi1RkLjltRKfbyVEh+u0vxKxaXJOjhGBJ9lfHrcFE21ZkihYImKcwF2duirDSQNM1ojNOnkCZxVbC0C+Fj1GyeMpUIBki7BqFVf+QmwdxREtzkHL8abiE2KW8PX8yeGXxuZk436rLObJjfF68O5GTo/xcQa0/e1XQteWyv7zARbwOygfD3m2gH9rVeWOPZNgdNdpQ3o3WZ83sNyShjJYyxQaTxqf/inj9TxnU6BZNOjwNoEAYomWJq1ugh4xo+sLONNsE7NP8AuJJw92pCvYCw8JPMPUrEkUYnh8lL27nZtyseQbGyVjG1DqtAb6wdQ+mKo8M0DBaFaHra4tlClCLt2abYioV/CWeNWSwJcrggbDU5UsSgzlfVfS9R95oXMSiKu4K1iAP35tTlSMKTKOzkVHgDfj5X+2ix5jCqcnmYQzlvtx2WYDEv4JZwd1w7MTG9I4s+se60n0iGstHGYGmAYFpTCVgVeBiYlYs5jXtely+i9AccK1uKb3zzyrtSdyQcuxI0Ays+hFq7fa/4m0+AzW/TMHhy5r/r404oUNSACwk5JeezHm9rg/sdGKbKScW4Vd3BVUC6LOLOY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L3VCwCvACXYOYO3zcbfWrFNgMI7cj/jbkZIlJFxPP4BHTaS8QlafYcGaId?=
 =?iso-8859-1?Q?9Vfar9LRovdPVW5F/6bnj+fpYX9lRU0ZNWuGnYymDcFbo/3tR9aa0e8Tx8?=
 =?iso-8859-1?Q?Tl/hP5LW6w/j6lmoSy9uNJ0dTpjY64XX7c085KkHji5MckYEvAyYJK2sZF?=
 =?iso-8859-1?Q?LDuLa6aY/ea5vRmG4DF6AWwlS5Dfa3DdUdSOMdAy29LVfjwTKrXpsJg0Fs?=
 =?iso-8859-1?Q?h+lCaB2GE4n4OF+D5+ZQNd1SzHKgBZd3quBTktDlR7IpWx+sXP9c53lXVg?=
 =?iso-8859-1?Q?Dnh68cpXjSktZG0JDDZSuTxlQIYZcuXrx5nXRvD5jtia4D71EeendNxP3z?=
 =?iso-8859-1?Q?kpF20TKcV/UTPKP38PY5i/fwzIrYZDt0vmA8bZz886QlPf9IMNjmVJ3rqs?=
 =?iso-8859-1?Q?2NnqfmiqUsdto1UFDOVMenGjpefLNl0fP+7aX57Bx++vSrmWJMs9DB8hLW?=
 =?iso-8859-1?Q?6U8miJq9BOHYDGjn/jKUx5vhTI+eyNp/2/C5OA8KXAxBOENpBXFO0y5vgj?=
 =?iso-8859-1?Q?31Nh/Mg2VEJMpmwVTpqgKoNprmSds2YSJOr1q9BvkdV+8VKiq8wG2mGJ5/?=
 =?iso-8859-1?Q?5Ubd259eY7DUOqeq9kpUfXbyDZAet0waEumurifBTbmUFU9fd3jrr0s9KI?=
 =?iso-8859-1?Q?/GnkGqED6S/H+rjNzcMf2eIfZG/C7d6LE5tn6BnZyTbA2gLIiq6UU0j3Y/?=
 =?iso-8859-1?Q?fwTkgfMoDyHLtf/GXA6UPnQ3RS/COeLaEe+XgTyhfNQlpVnjMpDi611I17?=
 =?iso-8859-1?Q?aiFNatT+FYcUChF0yM8X4I8trEXivoEYK92ZOJnwVlCSkoPR1nSyq6J7zv?=
 =?iso-8859-1?Q?EbS2mqbF7OFHAVC3HUlH/Byu1cj4/uHx9MdATu8lCKn3sg6PWJy2hN5d4y?=
 =?iso-8859-1?Q?YLVjxdXBEeKgEtu9BKkHxGj65BKvsr5Pw0F18+ddgxnaLlxjNRMZZxbH1I?=
 =?iso-8859-1?Q?aPNVZ1VzV3gte1rMc57Q0mUCh+4i54OBXBdNJozF54V76YbuKmHuJxMIHB?=
 =?iso-8859-1?Q?K15Z3MJdEIVzVS3UWLw5/5dNHD8rkJXD4aypHGr5Yu/iz8DNYmqZ3uLt7b?=
 =?iso-8859-1?Q?6DagpRJBVpNjNulAWdjiX6e0JpT4qyos65B+o2/Vi+3d5+gmH5RDAcwiCb?=
 =?iso-8859-1?Q?wq8TrcivNsiw+5+CqDe/AM1GgWr/KqbxameM2irl+HxoaiiwTjeJ63rQnS?=
 =?iso-8859-1?Q?gmyZkNP8ug0HoSNPt5HYHipV+hu+dN0pxaUn70rEvHAtd8hezwVWPa0Czq?=
 =?iso-8859-1?Q?Lk2PD3De09Nxpr8ASwMmhTPRSBVhS3s6jWt21yYGx50k7NU4FDFimlcw3j?=
 =?iso-8859-1?Q?Mki8v3McM9vAtnvJ4+fTM6p5YCn1nD6fm7TuZ6NfBcEjIaQETSJEUcm1g+?=
 =?iso-8859-1?Q?9yjyfKO15TA3CP6MQwdc6drrYkD01PhZlFGRTli4NvcRhZz/+UfVHpXeBk?=
 =?iso-8859-1?Q?BvqXaeGdLhTmdmAqg3XpqGa97ySaqyGXYnuoLOIj/e52p3MeW7FMaUlnCL?=
 =?iso-8859-1?Q?zvxs1pRH8bnUYIs7zrpw1LTanKjUqzhX6ciumICqQ65eDxSVGuqRpAP9PU?=
 =?iso-8859-1?Q?v4MhtwFcilZJKsZG4e2nkGFKGYjBwZELqaLSfRk1ayHm7dvSEFR/+4sWO0?=
 =?iso-8859-1?Q?KmndrN7/EWTiBllNQ/FwzfA/7ALbiXXCbv6ecHH7Yy0Q8jCDK1BtZL8uA/?=
 =?iso-8859-1?Q?oNvLMIc4iIY12n09YMt+WSwvPO3g7a0FBLBYj8ANc7vh9XFx1MgRJMJW1l?=
 =?iso-8859-1?Q?cJbsh6uGgypXUS40ec2haJcQ5QQaxYrTXZkVqcMUrlLkhmxMBo1pNDbP82?=
 =?iso-8859-1?Q?lM6pJkPpSw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BzUS6KixbOw8DPGEPhTZClZEtRPVDILEJ7/3Pi47j3FXSZGxbSdlLSdNSlACyLImzc/vcd+fyQDsitJ4GCVXPbzf9LhL1FXqZDCMLn4/YTOoy0Z+Z6Dj8gb726I4+kLKhzrFkOg9aA1TZwRyR7yZiW8Cc2xZWs83IbWizdxMdBZhKrGNrTH8VScVQ3CK8UwneVnWVUdmcO6Mb9ABazaXaQWLD0M5t4KaNeVGXaFGY4GONJNCe0uGZ8pIA1KXSERjGdrErLuEItt1qghUl1Y28j4Gul2mQeGIEYxGQ3WcUxxwLVN21iM1ANYUslwV4s/NnuTUZGQ34iXk3XrZFWqr9A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f07ad7-696f-4f7a-49e1-08df18882e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:08.0412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3K5+OoR23jQ5LqshtpwNB0c16uv+FKNNfeD1SHA8BteepYvmEXuXJTfqrX58Yu1Hrt6ikq7ARGeb3bwN7ggw576ORNbU0otHq/XWoMzGXc=
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
---=0A=
 hw/usb/aspeed-udc.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 355512822b..95fe823534 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -319,14 +319,24 @@ static void aspeed_udc_write(void *opaque, hwaddr off=
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
2.53.0=0A=

