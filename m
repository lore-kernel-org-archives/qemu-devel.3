Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9151CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogr-0001pT-D8; Wed, 30 Sep 2026 03:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogo-0001od-VK; Wed, 30 Sep 2026 03:25:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogm-00027I-PG; Wed, 30 Sep 2026 03:25:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai53SyedePeBlGrV66zOUpCsDi71/EKO28Y+FWDM2/uQ3VZyaGYYpJ4CPG7Nlp2NnNZIllb5NB+t8PosEzsxwsToczTq/obdH8eml0qN5VQ5NB9JBa9oLweYTia2DUnI/LZ1X6et0rniTILoHvnhw/vtAhh/A1xxjq5F+jj278E3uYFG+f6i1IkLX9JyQgYPFQmAHQ4O49pXyrFX0PKmqE9fqPtRCYOVcxvxWpskhxJJ+PCqQMejygjDfN1i3I6BtMKx10Pf+Z5pKxHP3We5SB4G5cD12l8DBRR1kLyH46AxuSM3D2T8MQaFHA72Lqva971m4uk98qLAG9Ro59XKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxBJXiZHpU14uKs7zERXXgTWaKGU3bKWnifn4ynDM34=;
 b=asq+jLr7o9pFA5AfsTe2rbd8x2OwXI9X5mUint3PVUhLJ5A42gibQg9iMqadDBAyax2qdMWqdyMleJzAo/IdG9qFZXXkx86LPNB3v6favaVMaUCi7FlVMoRKqjbMbhyJpVVPF9+7sgEDtcTKtpxcyRD7CYIrBcd/u0oPAQ+pYRWBCwPbv6+OynLX/OO6xDtn5xYz97i0I+EVgeI8yrVEE5NkuPiVCZ+mU2bc9GoJjiIYyll9AC7aKlg4as+0aCGeS0LL48vUY5w4c4g6csEEv+dKZr9diHvVhwLtA0MrANDa24Mp9w1FVVBmm5iSqonOFgFO+r2nB76YnkBHzoFYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxBJXiZHpU14uKs7zERXXgTWaKGU3bKWnifn4ynDM34=;
 b=Fq4gGIpxkAJX/nYXqZ/PG+Cp+uq4J4ewkFr8VO0T35BHn6O9RcLMSumPUF1oZHF/3CyP5m4Z0x+wknnnPri/rW4zrsaahokjryEhZ1gSxnow7j8QPC4dlHLznNqZCi11IBPT1mZHDB16G8/3r/C9PjrGaM9WfAbqPtltPmK0LIPUtld227ZB7gOCfy3vDjcYlt+r69/3yUyy4Ls4dDl70BaiHU45UN4aNMos7NK7PKZJQ7cWyzJsDN7LZ29vpMoghXecRIR0r/XRqhvCPZfru1dn+OixEOPjSzWvG1kEFccrrH+lfcBIzOPvJ6p4php2aSzWBCnKYDX5joEncGkoFg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6451.apcprd06.prod.outlook.com (2603:1096:990:2d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:03 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzPC3bzrx/LLEOP46GqYDApeQ==
Date: Wed, 30 Sep 2026 07:25:03 +0000
Message-ID: <20260930072501.2612119-2-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6451:EE_
x-ms-office365-filtering-correlation-id: 3b63f393-2447-4ea5-a268-08df1ec3f1e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: T2SQrWJV9qBbrlVsfjYqzBC1xwzf2N6HiOBBIZQJdCUhJtPh4oq2wf9bM4IxccipbH23kAOXXeBt2AHDgBrQHHRfejn3uUhn+f4DXg3ys39XW1M8JYfGKZXBusUMoBNJbpYp/MeXMHtzf+AJv6hEhAAPSA054+u2CA2/zvAnM/vlHcYzx76+tzDNQX5EQkGeMZRGrWUSPUgmZ1Y7k1ROJD61xaFL5ip+M4pgRx3fFuqLJEJVuefKlvNT11dfIKtE/8tzLY1/ANeJjzFsz6Emk7vMEUbniNCkX+1wsD41Fz5CxncSSKb4RlBPdWY6DayOEYrJXBUZmltJ/nW73n3/1C8Em/qQfOlKhDMHp53txh4ET46DZyo/Bb3cXEAH5L0ndnmWFlvu88VsWs1hFRSDFnod67bGO3Sf6pwrBFBfooVBhQtxe0D0V9eg+roQLthf50soqGqAj8Uy1vvFA5e4VrXTuDwagf0KRxU4Nv01Nz5ckYjsLJ02Q1HUoCIQ5Qk2e8+ZwQqZBotbhvgoxBfadx8ZNqun4NckSUlapBG67vTLAi8BbpszWgYjj7OG22TlwX4HeyciXWjUoSpLNItUNVTSZWsysPE0w9Tf8Wr1dFrIJalamwkrSttIiR+hJi8EvOn1A0qQtIbUBr6PkG/APDDPVY81adCzL2n2xbKOGNIj0E20M24dja9F2Y0WnS/ox/2nAReiNBxpiE+ESSsac1+jxuVk0UaRW8bo6sqrrlQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x/TrHA/KhFLoSHAg/OdAX+hrmkpXAAYmBLbBEUMAk79ZAizHLYbDlqcCMU?=
 =?iso-8859-1?Q?nT3+/wehrzynZ2UfjXe06e1jMqMMtgscgO0O4waLROEfGN6Ybv3TaNj5LE?=
 =?iso-8859-1?Q?ZrdZnV28cPq34Tek6um0YYZXi0tgLVc9NNPw4yBE+8a6ny9RBOaH+aDefu?=
 =?iso-8859-1?Q?5yePkmhIWvMgsls7dNnaJxJEbllimLhSpgwddXudTXoEmsYQe6S+B4ctyB?=
 =?iso-8859-1?Q?2VvK+miAGptNV7kMnz3y+H9DEGOMfTnaOnabUP954JPH0gpbF/s3ajU6Ey?=
 =?iso-8859-1?Q?rrCX8ua8LFP677lb4Vx+0+fggNvSdPDM55SUYDamaZ4U5vW8M1RjCgfVi8?=
 =?iso-8859-1?Q?SbMTBeEpOhXwFe6401T9Q47rkO7i/U8JG54a/OyexgNOW2LFCMX+kgEYA4?=
 =?iso-8859-1?Q?5bqJQAygLf6I9NL76iBtWJfTCOjHDGSteWnK7zhsxD2l3arsdzxLjGp/lp?=
 =?iso-8859-1?Q?giyWBJK2w8Wqaw22HITI8iXDL7oItIm1eQwNrojXhj5J+xtUiP4LoSBUvH?=
 =?iso-8859-1?Q?e3aByjvyv1Y6vL1OgT4gR0L4toAOgUGk3NEb38KDcJxr0n7jYBukdqiPmB?=
 =?iso-8859-1?Q?6HFzoWtqhdInNMpvYuQuRLJpSfC+o+Cp0ly8NsYnrbY8QayL8Tm+US4/1F?=
 =?iso-8859-1?Q?3BPA7ty9nUrlwatr9jHCCnmxm2R9faqF1NH5Bf1LW4ZRRk5xPHewlo2Yyz?=
 =?iso-8859-1?Q?c4jkdK+taLz0K++26VIipscImE+UUkRwvM83+t7tYI/qAS/J63T55mmHZO?=
 =?iso-8859-1?Q?qYenvepWaVO0AnoC3XddQDjWhYxPV4WEmxPpOw6u9ChZXWlI1EZ+mXhmHO?=
 =?iso-8859-1?Q?RhiXrgaj6Wi2eFYrIv+xzzrLiSjK8bFxYb8XLQpG692mpivkdvNixS6J4J?=
 =?iso-8859-1?Q?JZso6L/weEn54WN3wcxaBaGEf0PtE/ckwLS4ijPss8UMRdJxAUWwThb88X?=
 =?iso-8859-1?Q?GOIfyvRQn8iWkSfHloS7cFAz+MIxoRVwzDJxxuvE4NrmLsMy7WPjHeW0nA?=
 =?iso-8859-1?Q?rkbDQVp9wu/cO43hXh1Zn5tiiNGpo/GyDBQPAAxbTTcth5tGzGx/lrlGXn?=
 =?iso-8859-1?Q?r6nY7Ki81LF1tWGaN0z8mv/YQpptEYrz9fOb6qBcyMaddrjkvgZnwzzM1e?=
 =?iso-8859-1?Q?ntPm/8irub4BeajOBdo3oS9vs6BH/L1OA9CDINwNwVynYhncNQVSuIsWcX?=
 =?iso-8859-1?Q?zy23JwSYs5/3TUs7RVfVz/ZFHmtmfNhZAPKdmLhClM8qYfuVVlwiiNA/F1?=
 =?iso-8859-1?Q?uCUKd3s5SDziLsqrfQDXG5E3XxID0wz7V5j12LlnQzq6TQRJbYFI8SbCiY?=
 =?iso-8859-1?Q?rUaPfGAHhXwhMP2cibHcIuU6Ezmnq+A2rdZeITnqLTbqAc9RV0rkr8smSH?=
 =?iso-8859-1?Q?mc6mwPs2DDSWHnQYdGXTlgmZISh5qoa8OLi/vj3HNA1cg6NyVXt6BdPMPT?=
 =?iso-8859-1?Q?NCXp02CxOGatnotv4vPYvsedF0KQRnCNyEx74SNRHvkefGSXqPDs0OMc2h?=
 =?iso-8859-1?Q?6DANiLRUnVyixYOZEMxdG9AhM0xu2b38yMuKOCHZ3alEK07rOP7jHXD3oW?=
 =?iso-8859-1?Q?v437wCIkzuoBScbAdWXwNUAFD4eAKnUaKzJz0aF7BZUREUM/ozumAZGpyj?=
 =?iso-8859-1?Q?FKalEsWgcHUGJMJWJZcXd8Rrpv2aC+UOOTxd6EVs22YkT6YuGlOYGZmZdO?=
 =?iso-8859-1?Q?9OrpHliquO+v6n3Z6bFbTFDAlGztCMF4JmwixWTAUZOzhYwSM59TBqPyyx?=
 =?iso-8859-1?Q?M1csD7yW5Rua5Q+4CZuYjidB5zMwjDqel8mU4992POsdFXjqB3F5buiv66?=
 =?iso-8859-1?Q?D+b9Dvo99Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eFPG/prvx5hArosqaoJjJonllaf5X8gaZzPXBtN6qJ9yEZ/bDHa5vAt1b0QwnRmHsUmrhEPCYV5n0+Jr0zUT5TpymzxQcBSUC8ACPbmTiTzR0mbgRXmpzxV7unZ2Y9UAd/QdVblrcMo2WSpmP6HqW1c5SKnWHPeAGLcoWwrX1RxTdni7cY95dDEwmAgXW/OW27BCq6ZEbX1nnBPrrdlU73DGvgK0QKooXEQg15m2peVxq/ml09WfuqlVJ6iC8Jtg6J94PKP8IPlzFe6ruGJLZHpG5AGS5pcvBCQUFYAx5078zhKI8/RgExwoc0TveAMNtHa8XU112eixzZZXxoULZA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b63f393-2447-4ea5-a268-08df1ec3f1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:03.5547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1etOkYJXiI/0qMSscUQKkaOJ3aepXB+7YaqBoNt8zLNPrdAi7RYfXxnCJ/gZUUN+mn8Du3VmLMt/YsnGbJ0kfikSfnMYSVO2WBaqovW0c9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6451
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Add an "unimp" array in AspeedSoCState for all unimplemented devices,=0A=
and add an AspeedUnimpDevice table to describe them. This makes the=0A=
code easier to maintain and read. Convert AST2400/AST2500 to use them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  9 +++++++++=0A=
 hw/arm/aspeed_ast2400.c     | 33 +++++++++++++++++++--------------=0A=
 2 files changed, 28 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 38226d9b80..a9ef4b3550 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -64,6 +64,14 @@=0A=
 #define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
 #define ASPEED_SRAM_NUM 2=0A=
+#define ASPEED_UNIMP_NUM 10=0A=
+=0A=
+typedef struct AspeedUnimpDevice {=0A=
+    const char *qom_name;=0A=
+    const char *region_name;=0A=
+    int memmap_idx;=0A=
+    uint64_t size;=0A=
+} AspeedUnimpDevice;=0A=
 =0A=
 struct AspeedSoCState {=0A=
     DeviceState parent;=0A=
@@ -119,6 +127,7 @@ struct AspeedSoCState {=0A=
     UnimplementedDeviceState espi;=0A=
     UnimplementedDeviceState udc;=0A=
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];=0A=
+    UnimplementedDeviceState unimp[ASPEED_UNIMP_NUM];=0A=
     AspeedAPB2OPBState fsi[2];=0A=
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];=0A=
     AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];=0A=
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c=0A=
index 79a653f65f..3bd9df4e09 100644=0A=
--- a/hw/arm/aspeed_ast2400.c=0A=
+++ b/hw/arm/aspeed_ast2400.c=0A=
@@ -23,8 +23,6 @@=0A=
 #include "system/system.h"=0A=
 #include "target/arm/cpu-qom.h"=0A=
 =0A=
-#define ASPEED_SOC_IOMEM_SIZE       0x00200000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast2400_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_IOMEM]  =3D 0x1E600000,=0A=
@@ -134,6 +132,12 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {=0A=
 =0A=
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast2400_unimp_devs[] =3D {=0A=
+    { "iomem", "aspeed.io",    ASPEED_DEV_IOMEM, 0x00200000 },=0A=
+    { "video", "aspeed.video", ASPEED_DEV_VIDEO, 0x1000 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast2400_unimp_devs) > ASPEED_UNIMP=
_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed2400SoCState *a =3D ASPEED2400_SOC(s);=0A=
@@ -240,8 +244,10 @@ static void aspeed_ast2400_soc_init(Object *obj)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast2400_unimp_devs); i++) {=0A=
+        object_initialize_child(obj, aspeed_soc_ast2400_unimp_devs[i].qom_=
name,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)=0A=
@@ -251,6 +257,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev=
, Error **errp)=0A=
     AspeedSoCState *s =3D ASPEED_SOC(dev);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     g_autofree char *sram_name =3D NULL;=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     int uart;=0A=
 =0A=
     /* Default boot region (SPI memory or ROMs) */=0A=
@@ -259,16 +266,14 @@ static void aspeed_ast2400_soc_realize(DeviceState *d=
ev, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SPI_BOOT]=
,=0A=
                                 &s->spi_boot_container);=0A=
 =0A=
-    /* IO space */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  ASPEED_SOC_IOMEM_SIZE);=0A=
-=0A=
-    /* Video engine stub */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),=0A=
-                                  "aspeed.video",=0A=
-                                  sc->memmap[ASPEED_DEV_VIDEO], 0x1000);=
=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast2400_unimp_devs); i++) {=0A=
+        unimp =3D &aspeed_soc_ast2400_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
 =0A=
     /* CPU */=0A=
     for (i =3D 0; i < sc->num_cpus; i++) {=0A=
-- =0A=
2.53.0=0A=

