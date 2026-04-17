Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F2DF8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtH-0002Mr-6P; Thu, 16 Apr 2026 23:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtF-0002Li-7G; Thu, 16 Apr 2026 23:29:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtD-0005q6-FS; Thu, 16 Apr 2026 23:29:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1zxymSd4tY3JuyEE5QpF9XKDlBTcXlN5yJ8hVQsvMqMeeznhghkoKVvAiK+LYNa0QKqM2zVrDTkv+WtINEYcHcNdKxlYWZ2F57tCOAgtzT3+R/UI/MvSNjxlMoE4hSljjJ7JAbbSDsdlpcUotj6wzlS4ZqqCLL2ISEH8tFcghosAOjswUtZ5VAVcKSAuF7UjjubLkFYzU2xuTgAuqo4j9dK5ekCjKc9OPDDE1rZvWDx6TtucDBmjdos7yZYzZjDJoTJ6yq6yEVKM1OUZVXxaSU6ccjm9a67drsMZoTnC201ne5jHLPw4Pc59LQYunwwUpC/drF7n5hFvC6/cVKBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzHg7bn4ZtL1FbYIhxzeoTjJRUBOgJzpcWtrrsYqKrs=;
 b=eHhRvXQTCqXdJHmF3rw9w44jYi8Sx8uhofKTfMGj0jOocthSZpAEaciT9+5QG+rVoo7AwtNV2NWa0rs+QNnBeci2Bd8OsxGxRnFIwXMuYi7DRehJl/ZBXguLuMLL693a0Vw+h4bz+JRHsmhtx8Z0V3U2y3BBMnyLUR8Qz9iGJqzynLZ/+C0g+zG/pwUaWstov3NP+MLaRteXCUQMrlmHRC/DmneVCz6VuqNJx7e9Xwh4R3JZCs2JaC18T+sfIK62JJA1NuPqtwzvDg2Y/wdFun6mkhyr8MMxVK1HMU7EiGLmeiLRiDmAJq3V1vaMaJHIXcmDOlrEGa0ETkUqJEdnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzHg7bn4ZtL1FbYIhxzeoTjJRUBOgJzpcWtrrsYqKrs=;
 b=oIaH8rNhACH4sxSZocafhRfkY7Rj1cUaLz55f9rXW1JYJbNsfloBNQSbEBXsyjYmBa3pnj5ckh/w2TXWxxD5L5oDlbftMoJbV9awZrhOQnfDipBUoMekRrehk6pbc+oBPkD4YmiDXHYyWRq1mR4/ejvPjnwLyLVk2hrZ31CRxg9RMPx/S1ZlyNaa9w7i/B3nTZ+JkLwCriZXsYjBtwe4y8vlaMUQ9dlW1Fr0sgpf9BrRZwXYQSDGJ50Vo5oTGDyiAiuri+6JYm9Xw1T4BA93WOX9alza1C7M4+w2gKM2zsqko6TMcknJYdAFfVV+2LfoHRaF4Kfofg44OXfW0YZb+A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 11/21] hw/arm/ast27x0: Share FMC controller with SSP and TSP
Thread-Topic: [PATCH v4 11/21] hw/arm/ast27x0: Share FMC controller with SSP
 and TSP
Thread-Index: AQHczhpQGBoc1Lqhb0uh1hxMt/CqoQ==
Date: Fri, 17 Apr 2026 03:28:53 +0000
Message-ID: <20260417032837.2664122-12-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 41450f11-6a09-4ae2-bf80-08de9c317350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DDiclZkax8kZ2OTV28qQAKnP43KyZYP/BqxlL1scSQkDTHqqzNDEG1wy2p7uPNNRObAbGH4hIPe/j5f0YKCWfrUapn/ZLE2jM6ldEt+I1GUmEbZkhrItrTOLFAmh9Snlazwb6ivZ5N0EQFrVWr0ox43jyiMs84/30TAPtru3/x0mvAwM3pC6Xf7XjuTRNZw9ENkFm3YzMl4V5ZGvJopWMv3ZD1YK6HKHumTmQYdBFA2PMVnZGQHuiiXvEj2c7UnpVblkm73t9/JYfdbg/ePsGCz2XHT89TOrWIM2MwiSfWxUGiDUtW5UhbX6PiO9fDMOhK+2lzQPXAHOA+dxwZIcdpbwRyLD9Q8qKzEt35u8jFUuIPrqCQ6GQM0v45mQ+9tVtjzhopzRcyqXtq+4QkoRSlHSTRGGEfME4McC5LO0qNEpusKwMpg3DLcq1uVzEPx+JgiWaddV4IFHN7H3lI+exON9qzQgKRHamvYwf9BRaysR9zTfFMZz63kafBR6GmOFE1YGS1CKLcVpmRxeE+HnWNNL3X936d+KRPrqYMmxQXVMbBiYyO11gWfQsIAzR6BH7HAYv/ry9c4fSKhaZR8sMflVhXVsDi+DwSsLOAyKq4NbsekOSOkR/xfQvBNglwjPxGoeFGKJEja0nMpxJP2FZTRilR8hT7gUBdOroU+6406vusBBJXWR7IjQJ86B6XQPPd3tmMgFFhR0fLpf+s5ylXOFXzrLJJz7eN77yiXNgOqHpg80c3dRibZuajnY6sw72xie9PRqDnG/je4Mc2I5aEKkJUdCOUoJq5VBRPB2QoHI9SJXy4V6rScwLOETczM4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?RYDvCOL74+A9b7yJt25416RM/ALUCF7sUM/KgENXEpJ0E3drqIBaDtk2?=
 =?Windows-1252?Q?SSwkzRqNQ/9CJFCTveuUGyPs+RGYgQ6qE16R/p1DFEzDXEgrAF8Cl0uA?=
 =?Windows-1252?Q?3SUPWx+TjgLnYD2RRnx6g8ij51H+cUQlKm2kx1XVy9ZsrKUBX3SrF+Tf?=
 =?Windows-1252?Q?9cC+TGgGzjOIfQ/unAzuwtym5rptNUUBduaMq60y+FeBsPGFufuakzMY?=
 =?Windows-1252?Q?88Tds4kwMWWhIOcoyOtq6YtUOD2QBbp6OwiWaHTezQnj2Y4M556fLFwC?=
 =?Windows-1252?Q?ob954X3GxEza/xh7AEBRpCH8+hlJz2yuPWvvyRg7U/WPq1qemcN7aqaG?=
 =?Windows-1252?Q?+EnQXek1TGgkLgRFcq9tRoi65VpHxSs6YP9Yx3R56InXgUO2mHl6p6Jx?=
 =?Windows-1252?Q?ZgV8/OCZJOLkKVp6qRgNeuE4rwSTH0/zls1sRZCcGtKrho+YExge8OfG?=
 =?Windows-1252?Q?v5DiVU2oeJUktjxgaDSaED91FYOMAfl1ZUEIvEj6WQfnZxaFRFwqMk33?=
 =?Windows-1252?Q?/Ezg3ffCn08VOJsh0tKkqozj5HcAVjTv1ahM1bAo21JNEsTa75HrxfWI?=
 =?Windows-1252?Q?tyJbd7iw4aMpZi52y/LTL9fmcRgQqnWTBai85FGeOu8lAKQpBHQoQXQS?=
 =?Windows-1252?Q?DTWV+CqLO2AYqlTPHb7aOpCBmZSKzHFMbuXT5CyJsIPwtdg4trmfRsak?=
 =?Windows-1252?Q?qIGtCZ7w8s0tZYeqKm3asF+2vX8rixpA9siic3Xex/eJawUTIZ3vQCxU?=
 =?Windows-1252?Q?i7DtWTcEy2A8eIEJOamk3fQCMVLecdkKz0aK4wDhBw9qB3kNPCY7/hga?=
 =?Windows-1252?Q?Zy+nmyKikxPeOnlapYpljuBnP3vAAHCAvBN6wZKRYkQKk4uFRiUjTlW1?=
 =?Windows-1252?Q?WwklYQuaZf3R1mxrtr8+U0AMciB4TyWADff5b3E5Ol24sgZhoOTcmCUT?=
 =?Windows-1252?Q?I20iEVB94DsDF88+YlaExuKkiYRnW0rrlvMc11/pLdde2rkhOz8UCFBS?=
 =?Windows-1252?Q?0/NTDUPB6aHdHdlQWTqsseuqg1hteaSRTj5fIGOVoOrS+YTb3FR5lPBV?=
 =?Windows-1252?Q?35PNmnNrCqxdH6ojqC7lxqKe+YsUtAj8QO88IlF1vXIx/G/HGL5tr/bg?=
 =?Windows-1252?Q?dRPXRBbO3pm+VJmwPbr9QYAxT3iY3n2JwSNtXQNy72qdDjKvByrzDbau?=
 =?Windows-1252?Q?BJKTlUDxk93cFz8JfSEbfbmdKC5eSfpMrKiCTkjmBSd5nC2hYn5EYvhi?=
 =?Windows-1252?Q?aQBKO+pEowFYpD177D52j30FN5wGzPiIsHWpNSNpl3c7XOQdCEAVsWGX?=
 =?Windows-1252?Q?IiYHyTbfjI1Ti2HbNyJM6FDEAFqs+MpSMjHST6isfzmsstovubOWayLE?=
 =?Windows-1252?Q?rtKVRMDmZNNrzTUmPSR3kyPMVHiXRiI2DXEp3iW3HMsnmPLa7CqAsJBo?=
 =?Windows-1252?Q?+d22rJLTx4fP46UMPUU3YgxKSipUh+1lwAiWvrp1VS7bKjubW55zP28z?=
 =?Windows-1252?Q?fid6j4bOoukJElJ8zlVBcgpk5sIKzQoBrQKPWG96CuQ/lG67sasMM7Yr?=
 =?Windows-1252?Q?S1lT+axyAdyde3v65nhyxNGNnDGZEyOrg4IGIrNE7Y1y2AiRbW0ZDFxk?=
 =?Windows-1252?Q?piGfOcoQ5zTC+caWAzpcHEVvB4DJy+9G3YLHhTmydzcSooSvPjMmTOqr?=
 =?Windows-1252?Q?stlk9WnabTFVOWUDBQSiO8syJ3/vwCmOdp/lnniAOrpRvVzWGMr0KLkD?=
 =?Windows-1252?Q?hV35Mi+ImPiACMB8sO/ka4sB7StIAaMyaCrvE6zXiwTV0YOVJ3q5+VwT?=
 =?Windows-1252?Q?lwhskEBT9a5CQFLyu8+1CBbPhxjj5iftSMyyvtbBwubThtPjZafAs53J?=
 =?Windows-1252?Q?58bM9O6h78NtFg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rtl7kuzQASvhxWQ0p66vdXZF77fvwLU9eINRBK21bAr2T+OW/Mf4rRUKcHkprB9vYZi/X5/Fxp6mG64So24ZbY5QAh7PE0SXVd3JprkZTR/01A0Rd2/7g4ZgA9Awq4Rkx/spGNSk6rE+iLyxD+AYuo9Cbspjkp0bWKbl1sKzL3TKlhIF1VDKa9g6n6YtBmVxww33YOyjI2lQMfCPawNgZFSEP9kYuoYQawMuxxkgH6tyguR5lckt1L5G2Q7MYxAyMWE1bqR/Ga5/lARc/43AhG39a6ZZF44k5xl7jSpgT9Gs55tQsexr/rZNd9BEsYYlbW0Vn7S8BB4VA0++9eZb+g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41450f11-6a09-4ae2-bf80-08de9c317350
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:53.4955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNnelrU5/6LSGUC4kbonka+0N6SEmrVBEeCGUph7pCwmHuUfX0ujbE5pybTkQvImcIzlXFa/HIUmUe0Qe0t/e6II4pdS9fKD/uxFVuSLq0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

AST2700 provides a single FMC controller shared by the main CA35 processor=
=0A=
(PSP) and the SSP/TSP coprocessors.=0A=
=0A=
From the PSP perspective, the FMC controller is memory-mapped at=0A=
0x14000000=960x140000FF. The SSP and TSP access the same controller through=
=0A=
a different address window at 0x74000000=960x740000FF.=0A=
=0A=
This change allows the SSP and TSP SoC models to reference the existing=0A=
PSP FMC instance instead of creating independent controllers. An MMIO=0A=
alias is added in the SSP and TSP address spaces to map their FMC access=0A=
window to the shared FMC device.=0A=
=0A=
This ensures consistent FMC state across PSP, SSP, and TSP and matches=0A=
the AST2700 hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 ++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 10 ++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 10 ++++++++++=0A=
 4 files changed, 26 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 4db995d251..2460a11401 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -50,7 +50,9 @@ struct Aspeed27x0CoprocessorState {=0A=
     ARMv7MState armv7m;=0A=
 =0A=
     MemoryRegion scu_alias;=0A=
+    MemoryRegion fmc_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
+    AspeedSMCState *fmc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 62bd6a0568..56dd86e2c2 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -161,6 +161,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -193,6 +195,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 0500c02755..bfd6fe4485 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -26,6 +26,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -256,6 +257,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -273,6 +281,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 4da4741d8a..166dcb14ed 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -26,6 +26,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -253,6 +254,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -270,6 +278,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

