Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC001C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz07-0003J7-KM; Tue, 07 Jul 2026 02:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz04-0003BE-AO; Tue, 07 Jul 2026 02:09:44 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz02-00083r-Bh; Tue, 07 Jul 2026 02:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLZqkrFKa5tjiNPo/wp+YpWikVsb6X/lL59AQeDuJBY+RX5vduxEep6Acu4t+pWJDDUknFetsVspe6hEeJDY1chn8r9h7iS/yt667WuP/d6Y+KObo4WqwDLllSA1octzOQINC7r3z45Q31TK3QO5CpjKNJmVd0jAgMGfqPOKuabQvGI8rRhhvhiTyvXpxoxrKHamG0urSJesoWQKcxTzCsKWS9ke8QBmEx8XQTRLxOjiKNQAao08F6H26RPmPy+exhaJvTfr7Thwe4EKh9E4lZTxkL4xfuzv1rEtPHY1VL892oLCZoRclC3z2G1RZvmL80CSP72NRflGFJilTGkeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaoJvTrELxBcgL9jO6GyUKfJAHLk3MGcBjLn7Ra6uQE=;
 b=SG48sq96AjpA5WeFm+/LE2DIGMhKhmWAxQcd/jp221vk+03gTAcaeGkvuJcmkSkyBm5vcybX+mrCYcx+IvU6mT9QiI0KukImKdBwUJ+VUIig8f0HOOUr+s0/Oar0wkTduHq4QElBkpQR7U2Fvt05Bd4vnldkqgO/G61wawAwRje01KjzU4Qh9Cn2NewgDLys4mWPnnlh8mZVar3Es/U6LX4s2tqeyR7I218alieyXa4IOkVZ25H/HOTIeviVdRgnBdzWNwRczo/ECFiKU8h7ZF1eRkCsyzb6AxjHq18/1NM4AGz0ZoprwOfOsqyVzjKRfZOX83OSdD4rL1mwwIgDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaoJvTrELxBcgL9jO6GyUKfJAHLk3MGcBjLn7Ra6uQE=;
 b=UmK/gz31MbcFQ6wQZcR3VAla3k3uBhG4wXQzu61elPu3wHs1NDe2BuO57uRkkL7Mh5J3Svy+Cxwm6+m9cbkQRwWI/Oqa07wVoz570UaJ1rAuq2pqRo4Y9EkiBovLsesIwKnuTapsFx/YfF+yLWlaa+0qkNcbHqKHBewflT0tQISPhsEF1IaqloFDL0aPphsh4t+YypuvVRh8T0gOUVIZUYJB6Wv9XoSMT40Vuez1D6DNJkwM7QyMS2P+H1/l36BAnCVOLpRyYGiPn3WNVWQVfGJDJEhVrsNKPqFNloHlaLxFyZRwfgb7NeOLccB6YFyd/vCy/NUeXVOD5Ph/v/ZlJA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 6/8] hw/arm/ast27x0: Share single SCUIO instance across
 PSP, SSP, and TSP
Thread-Topic: [PATCH v2 6/8] hw/arm/ast27x0: Share single SCUIO instance
 across PSP, SSP, and TSP
Thread-Index: AQHdDdcrt25rl7z8YkW+U3e+6kij+g==
Date: Tue, 7 Jul 2026 06:09:29 +0000
Message-ID: <20260707060919.350637-7-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: e876130b-5d63-4550-0f19-08dedbee4e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: Zu1NhD16FRU2XP2g4HOThq8r3nQs4XSP5Tcv1WC4sXufJih2yx38Qdf8yNnRoqQwATh/ZmohQrn8uyxZ6V2JAz2xEO7M1IbPOUwKV8XMwfpytbPJWyJc2l4SSxTq0UagAdi7kxNK3Jl0Exbhgmt3WxuNdSmLeC71xap4B9142Elld4TK48QFWoHOllyuzQ9A/oI39eHDt1W5ccXn5KOINvoJA3fvx+71wW6x+Ro5AjCOsityTR8SWIqH8ti++lORVBIx0BQOocWQsnQd1RW0ZBRqFTHJ6bko9za8z0tbEXa4N96220JkTkv3orfwiIVONUMWzEpt0/DhAHGUBBJDO6NrU2lcgBdR94eiPjVY0vpgK6hTeWW/KjnmH17OhktsWZj9gJbeC441IZzjyMuXWhYKawEEbtoXo/I5DgSa8Vr/SuI7QYZ3BeUmmp8lBxhZuMHFeNe3WaA38p03rvzkNaFsYFc4zl3aIoit1Ahx7WKPfgJ6ZEKYkRYWmcSDgmzsPlpQP9Z7WuNkb2pAyAVDCQj/5eijRptLBiVicweHhvAqsdqe0Y/kXowW/KPxyfqYzpVJyKD8C3SE09R7f8LBrZyl2GJHD3g9q/BhZBg8pQJ6gNDsb5LA59+B2MThsDrGVFyGFls4zqsZC60siCdphRbRCozWUV8ksw+e8l3wHa17X5K7s3xIk3dXusWQRBe9+TCz0Mi4YjN4/1qun+7nbFDiA6GcWhqS8o10QElOclqy2dbt4wGFFS18QSHY3J05
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?j0cKh9vIYWpLVDcOMiiYWzQECRKLMLmAafCflHNX0gu2GZQCcDTZyP9f?=
 =?Windows-1252?Q?es4dW0/FpDMN3d/VU1Yrl+pg4fftm1GN/Uwa+EyXPBaQmWfqqG5iDjlM?=
 =?Windows-1252?Q?HspqFBIuTdKuVqWphNHeEuvzZR6J/ytYhaQjoSrFN3dq2zCatiqJwrYD?=
 =?Windows-1252?Q?EMm7Xux2AEZUbmm70fMkS3sjWs/THDupvzTCMhL4XK/G2IWrMLtfC1l1?=
 =?Windows-1252?Q?jWl0V/9nh63K6SjX9b8o33nq2ThTSoAJaJqqsw9aViJQudvRDDU3aBqP?=
 =?Windows-1252?Q?O2yd8Bx3xQmLMpltBpOA55spi27tbDaBtN7HBX+XnI9K69qvYnP8/kgs?=
 =?Windows-1252?Q?cO1fyuzLE4XGBZ+xSp9J9U2IK2ged+JblU5TfCtaiJiXolBc96WZarkK?=
 =?Windows-1252?Q?izjLyVrTe/5D+obcdG/B1Z7dd8gfMrbXtOmw7jVDUXcphOXpkkYN5HKt?=
 =?Windows-1252?Q?hfLrqaaR/UlTvKLoC0E+F/LaTf7DthDvk0l09bU1c4FjOiDlXWmV8EZr?=
 =?Windows-1252?Q?ppHKAZbJ234my9H8Em/QnSFOfCTOSbn38lPggSHO7sjNWdyZl98XzMkZ?=
 =?Windows-1252?Q?V/EEOX+Qq98gs5/JSgrperHOLtV/AhrmCTkqrE+8K4boda6ttiwAx7vz?=
 =?Windows-1252?Q?3su1iI70pjZKpmxi/T4h/QAABILlUv0mLJl3R0gRfsZmXtaCHio0sHIZ?=
 =?Windows-1252?Q?SA72MDQXxcWz5gO3MNbMzYP5MKqCu+TH//QcosCs1o9FrsgMo0GbwHF8?=
 =?Windows-1252?Q?nIULpRRU5ImRyVOCXvvtSyGch7K/wKRozwvwGEAdC2TbpxEUwkedC/op?=
 =?Windows-1252?Q?1dnwJJPfp4l7Xbw6CwVUnPEVqTLPgyIHkJm/uZP84JqaJTihafRNkfFo?=
 =?Windows-1252?Q?yzqP6XxUmjqAspd/3ssISjSRRaoh8ZdXxyi8foKxeAuXtsaV8nOX/eWy?=
 =?Windows-1252?Q?U1hf8RghkgNHIUWOdPuzrBfOXAQlEh2tsScMEw3rFr+SnbBCBQ19GFWl?=
 =?Windows-1252?Q?VdDkoOZNAchdho0WT3jZkjLbGi9wggqgQ5P/lPjJpXeBo3yYaejd8tnK?=
 =?Windows-1252?Q?q9kj9ExZ74rBZel4CMuMGn2NaToppwR01+k10wRim8xfyN63x+tSnW1K?=
 =?Windows-1252?Q?pYiGBiGan4Gq4pNyz9gKFM27cCFbwXf3tyYDVDjGX05ROBBVH+5BSacr?=
 =?Windows-1252?Q?N0iA2i7hr0HlB2+ZoSrWz4kCIEKf9RiTL5Dqc2GakIb9ecreu0VJfreS?=
 =?Windows-1252?Q?fXioQk+Mc78aBYT9toHUX+OuTBFHaRHkU00Acf3BRI5v4zo/03okqmd7?=
 =?Windows-1252?Q?SrOn8bYs1ZYPe1upuMTTQO9KpucToOuvvdj3Q7YOG5mIwzS6pX4Qctte?=
 =?Windows-1252?Q?60sxU4W+rTQffDViBNNmtGo0CGOWtR8srkwin+lDzsFOiqafvJ5AObFC?=
 =?Windows-1252?Q?7UOqc+CPQ/koJ8EdY0xxJpTTXtWNmxseeRZBsMM2CMPivkEzcc9BC9Ft?=
 =?Windows-1252?Q?DUt2SbS4PpxtlcxCJ6/gKq7dsRf5Tw5S30YbwkzN0Y1uCql1TTp54D3a?=
 =?Windows-1252?Q?McuwfzqfcTsTI4Zs6fYupDzzMM2Z5zKHb5K8eJbU7qnLU+GboCUzRPkS?=
 =?Windows-1252?Q?dnM0hA9Ur946zsLgCfjT2EgbUtSBSXeIGqB4KR6A9d+PVVlp6fVgqnAx?=
 =?Windows-1252?Q?dRD2jI/e413Nyy43Q3Fmkf3A1vx41jhvlQgkSO5pGH3O9gTXRSbQXUfQ?=
 =?Windows-1252?Q?EQa0SYU3MirpJWGtZlKd8lWC6Ddd2U47xnrYHbAI3XmMXCvcYCRDsA2j?=
 =?Windows-1252?Q?706Jr2StC79LZB+5zWnbpeJvIBWnzWdPi040TWbi5pUUWqFcyYJyz/Ys?=
 =?Windows-1252?Q?5EWPq+IwLxfDAg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iTdRyKCcw6Zeh9ewDUa7Ao2kVcJiIXKQ1b2tCshGU2WYyvh3/AxqeLaY8rZNISI4o5V6iidK4hgo2YaEpd6JDQrBoANEnpcJ1SC2muD/PeC6t7QhuHPUOjxb6WT4hD5mLaOBA0lgKCiHMCNogQZzs5aId8PzJ3XAd9Fj8kpUuBe7fZU/lsW0KLr3gTunPIhQGPk0lepiTRCvE09hzXZYaFTtNyGDuAFdndRlxCYpR56kpAxLVTxPxFy4TwZF7W3aydaDAhFetVWh24f4Oi5pIKnAszW5vb/OEJWDFUCnmnmciJds18n3FWerdZI8femNUV5VDVAU0bEGVZBalnBpCA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e876130b-5d63-4550-0f19-08dedbee4e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:29.4011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etaGa65/Cfeb3XpHKVUdltuTnbC3vigXypwYdGRexBmzafePu0R7PjYl/xcS2cR2/JlDoCg0fKtLWAqO3ATyW7m0kRN9YkIV8sjx4Guo+sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

AST2700 has a single SCUIO hardware block, memory-mapped at=0A=
0x14C02000=960x14C03FFF from the perspective of the main CA35 processor (PS=
P).=0A=
The SSP and TSP coprocessors access this same SCUIO block at different=0A=
addresses: 0x74C02000=960x74C03FFF.=0A=
=0A=
Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCUIO=
=0A=
device, resulting in three independent SCUIO instances in the QEMU model.=
=0A=
In real hardware, however, only a single SCUIO exists and is shared among=
=0A=
all processors.=0A=
=0A=
This commit reworks the SCUIO model to correctly reflect the hardware=0A=
behavior by allowing SSP and TSP to reference the PSP=92s SCUIO instance.=
=0A=
The following changes are introduced:=0A=
=0A=
- Add a scuio property to Aspeed27x0CoprocessorState for linking the=0A=
  coprocessor to the PSP=92s SCUIO instance.=0A=
- Replace per-coprocessor SCUIO instantiation with a shared SCUIO link.=0A=
- Add "MemoryRegion scuio_alias" to model address remapping for SSP and TSP=
.=0A=
- Create SCUIO alias regions in both SSP and TSP coprocessors and map=0A=
  them at 0x74C02000 to mirror the PSP=92s SCUIO registers.=0A=
- Ensure the SCUIO device in PSP is realized before SSP/TSP alias setup.=0A=
=0A=
With this change, PSP, SSP, and TSP now share a consistent SCUIO state,=0A=
matching the single-SCUIO hardware design of AST2700.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  4 ++--=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 20 +++++++++++++++-----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 20 +++++++++++++++-----=0A=
 4 files changed, 36 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index adfc3c4512..b77ea06e7f 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion uart_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
@@ -45,14 +44,15 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedCoprocessorState parent;=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
-    UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
     UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
     MemoryRegion scu_alias;=0A=
+    MemoryRegion scuio_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
+    AspeedSCUState *scuio;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 58d0b4d7cd..d14a42ebca 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -157,6 +157,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -187,6 +189,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 28bb59c8c5..fa492f1797 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scuio) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'scuio' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SCUIO */=0A=
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",=0A=
+                             &a->scuio->iomem, 0,=0A=
+                             memory_region_size(&a->scuio->iomem));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
+                                &a->scuio_alias);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
                                   "aspeed.ipc1",=0A=
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
-                                  "aspeed.scuio",=0A=
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
                                   "aspeed.pric0",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index f5c4a02161..3a98bd232c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scuio) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'scuio' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SCUIO */=0A=
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",=0A=
+                             &a->scuio->iomem, 0,=0A=
+                             memory_region_size(&a->scuio->iomem));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
+                                &a->scuio_alias);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
                                   "aspeed.ipc1",=0A=
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
-                                  "aspeed.scuio",=0A=
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
                                   "aspeed.pric0",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

