Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D9606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=S4/KeMe6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3R6-0004r7-QJ; Tue, 24 Nov 2026 22:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3R2-0004ph-6i; Tue, 24 Nov 2026 22:12:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3Qz-0006xi-VF; Tue, 24 Nov 2026 22:12:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhhFHS+vYm+qKxuWxCvnqf7NL/Pwse4H+QPnCWLjWw9AyUYKksBLxNlAuzwrhnZLNS7VTg9HFwHURfIeqXu00nn/Pb35EOv+xpqrCw//PoMFr+5hZbV4qp1UYin1rVCbhX0JiOcPWeGb3CyjaeIP1yxOJgQLPEmZd6tJcDIk0etHDffdSRJLdADrEEihif0vmStXnkQkmySPOVEzjQP1K8GZwhIW5hJ9Ko7XE7Q0CatMS+/U2GvCFVTpvMzpTawqmBxoyGJu6VPxcCAOQQ/WAXDuCt/0CUyba6n4itRZenNg6lPsWxm/bGrEWi+6OdHx1ps35lADQ8IdwgQ0AKPCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd6Qw2uqI90+AQH3F7Hm2Ot6V5/jcf0gC/d61q7v9bo=;
 b=yagAZ87l3zLtIs1/2jKRMH4GtKkOBXnB+DPpOzBQAIHab33XFhyS0y2dX57Ry4DdG/fhf/xeEFWl/3AXF5YvrfZ5zapWNPi5OeyCB4wOIAv2fS0uFRfOcTamSr1NnxDFMWcZfWRCYgZumXmKVqzSdSL76wRmUjsBSMUxteX0Q0rlwH5/ISKM1PQp/6D8nzaTv6grKSFYUHHB2v27R6yUIvd9GdU6syuEI/1vDLM2YG8wzr3s2ryRobu0wBMgeVHMXgnQgmrSZNavCteL7VFszenygNrlhXnIQq9rg0aVhZpwtR9fHcn9F5ws60tOEIeVmJMTndBeFXpNJzxx8TXFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd6Qw2uqI90+AQH3F7Hm2Ot6V5/jcf0gC/d61q7v9bo=;
 b=S4/KeMe63AAAoXDh4GpM+PNoTFlujMKXG53kjJon8ad+vJSFvi2/AnNY4kgvfXC6n0o72Lh0/KyEJfI8i8rDoDvqRVqf85x8kuKC7g71sAQFdukADV38TJcdqzdu1bHNppWGQpjbY2AFhdtIlAA+7voW+J2OgqrhiID0WhlL6F+ik5HAnHN4nPZf4xlXLfhK4tJk7umpvforoajpleIyAoUCotKi4dXifb0LbIqO4Pp2kSNLBe5dBNDES+IlunHLVfEdQa/h5InJOq8i+iwj1kpmgkdMEFbrBQ2Gl6KxXDTYE4KPrts25Kcr/7wccvYXOW0HHa0r0cd1WzFdtg5kyw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8895.apcprd06.prod.outlook.com with HTTP via P2P;
 Wed, 25 Nov 2026 03:12:28 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 03:12:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/3] hw/pci-host/aspeed_pcie: Fix lost INTx interrupts
Thread-Topic: [PATCH v1 1/3] hw/pci-host/aspeed_pcie: Fix lost INTx interrupts
Thread-Index: AQHdfIrNAAUN2lc2n0GKOgsZNWDhbA==
Date: Wed, 25 Nov 2026 03:12:27 +0000
Message-ID: <20261125031225.3810653-2-jamin_lin@aspeedtech.com>
References: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8895:EE_
x-ms-publictraffictype: Email
client-request-id: 27ac14e2-da8c-4919-881e-14c6fc0189fe
request-id: bb1fb046-b380-4b36-0a84-08df4aa1ef9b
x-ms-office365-filtering-correlation-id: bb1fb046-b380-4b36-0a84-08df4aa1ef9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|10067099003|56012099006|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261026121527099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: 9kbUv1e8/uckpS2Pi0l65zFy1Z6iTBY92cMk6NC2OgJzEOyiMQBPhzUqG2fvKYTw3KNCfPdMq44LWcDLbfsQahKDpW7/Rv4eCS7LacO3Mymiu4Hy6AB+2+TIgzFSyceIW5hq2mCCuRkTruwZN5h4dTw+i+y1DU9vvQJH/AljfswEkZw01t5072C3vQgTsjGOprE9nle9ekTNY/aTBzQu8pXsxOwfta6UpQHIcbQm7twu+oYdrAwmod0b0jKrpFPo731torXGzl8QooITYXNDf/BN/JEeMmw8m1szIkCVkqwCzZlsN5k+UyDGKRTB8i06MxrWDEdXkqkbiKqHIGobv8PfNeAmLZDKgkNdtcucIH5WyuWdhUAPVM80QZ1EJID0rKbGmHsakwOSfAOtmI8Kq6aY4zhbZothk5N2DKDEWDdBKes7Y5FLg3xUjLN5+USNMebkTdVuO+2FaRlhsjKXS3vkWiU7jmwLm6UihWmFMwI+8TFWxuedYIQAPijuoeGk+Gy4ZKA5VSswQMDBhtCeyFZJxWGa344ySOTsfbKV5PmdBaozjd9dvNbS1JfTGAOknFet8zWCHOoTMFeYsSv3q4e4AVYRIdpa69JOmW1uNLtsxexd0/sVLQ46N5AIZApUFz3SeWsvia3/4d5Y+r+UawThLiQhS64RJiRJTOl93fuxbTJmZSWyC7Hu1Vvsq7HpsR87jfi35tlfW30rRzMcuMBw7p0rAipc1zVtTTW09yU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B7R0NqQHvFRU2uayoggAXxIuh+9R9KINJMrTMOP51NJK/NWhhjVpO6pQ6k?=
 =?iso-8859-1?Q?9ZBM/j5THvCi23aWlfmKDM3GF2MpOapoJa3GHm5vOY6+OgiOQDSFI/jKJ7?=
 =?iso-8859-1?Q?2FxiL4o5oPn1uyahHmEdeqlKrvxYFEbzqeNYhdZSrpIBtDNWyNGR5kz/gS?=
 =?iso-8859-1?Q?dJgGFwik+kPXLftgBYjcMUB0Trz1lOCU22khbjrOTjVkvZzkpNDlO09rvM?=
 =?iso-8859-1?Q?KLD0HL2G1tnlEi4j5TCk31q7J3NKcTHzuUScHGh0aBQuU/jA1AkDMhb99k?=
 =?iso-8859-1?Q?on3pikoxzvZ1s5VLhNLT8WXe2wgFdO8/BW3/IFY3fDorI/9kNNQjdtcsV0?=
 =?iso-8859-1?Q?NdZ+GbdnZ4yLQQsOFwrGXvoEFRGgcGoND/MQMPBQnpTmi4SnUlXe8gPTxx?=
 =?iso-8859-1?Q?QC3cBnxOXWzl6MWSqXQ+J2u4VU+0AhFBdW1aazM1kopcJXQWYIYTP4ontL?=
 =?iso-8859-1?Q?uxC2DYk8D8u2aTxbt/hobI5bY64msVgW4jvt5WTrcaKaVRGf/AR7UYDr3P?=
 =?iso-8859-1?Q?a2uqh/Dl6TCoamwtdJwY13m5Jrh0tjGgZN6urLmAmub9zqFvBebrQZO8Bu?=
 =?iso-8859-1?Q?smIslr3iwTC9bSsLL6jjB+TWedq5u0QFFVMSA2eafVx2O82hIzpwYtfUba?=
 =?iso-8859-1?Q?DRc9FwTkukzyi7zRtM1WuXCEInlMoBAf7THp3ScfMtAnB3ngWaur2CulBd?=
 =?iso-8859-1?Q?g2l0EZEeCF3Y5vWiLVCfIaM0tSO8S6Bu8PyMob/SXiTMqoIr+qsmNFw+HH?=
 =?iso-8859-1?Q?0XDs5zSDHx4CCFZkP4qBiFLUYgCrIzbf4mxSOkLKaGkEWmIybOIWUgB6xP?=
 =?iso-8859-1?Q?+QDqqJilfmyMUREk5nZpmp1X9pDW2kpGF4WG5+5I6OEpF5StWAhZsFRFGG?=
 =?iso-8859-1?Q?gdYPR1wg6jNdKcdun5ffn5tmKQ1+DlMIz73XUbdeOsR87FEkOSEjVAUIez?=
 =?iso-8859-1?Q?byCoElhXjkS6UQwfKv4/cYjQ+ftVXooqLOSNEFGM/VO6HqGBcA8cQ15kQ6?=
 =?iso-8859-1?Q?IwgQFbPIkyXW30bOdRyH/JhC/amAO8zFEye3Z0SlyLGYl4LaZLTOE/FSA7?=
 =?iso-8859-1?Q?ZhJMgISwPlsseILNewnE9naOlqUeSgMahxUUck8oHoeyCjogJGfJzTLI2G?=
 =?iso-8859-1?Q?74ep9FFDrvSIloQ6ep+bQ/xKu5hyc2LiM65h3V/gmoaKU2Sjt8KsQK/myS?=
 =?iso-8859-1?Q?BclzdE8WxIHDwgdse/s6aZxzKw4gTri/IqlC2A6cknunevQ4KT6d+Bka3X?=
 =?iso-8859-1?Q?CTGDoL+HS1RIT5WW7hzQo3SlqxqsxJw5Wk/0oA37Ay2VXzpzFXGtx4IFWQ?=
 =?iso-8859-1?Q?L5aDCdWcsxUMA+ci6t+udxsEAobDMDvBPKKzp2Tm/Quq9V0HjILu9t25Hj?=
 =?iso-8859-1?Q?jTxKL1bGTiPmcYv63DJ4QoS2q1I+RnTPWIO3WAdzEQU2xpEUQk8fdBVq5+?=
 =?iso-8859-1?Q?WId1OKRjP3ufDqrU75QBslUZ0O8V3Jxjuipzl651GGIpZN9NpbNfHQH7dA?=
 =?iso-8859-1?Q?atfKcXcA9Tpdc9omr2jmxbFjc/9aY2nlSbmsBRUvA9nS39O56vYn9Gx/Zb?=
 =?iso-8859-1?Q?2jVWxb1P8uZY6WlxbXUgONBYFiePk/veYRYqh7MW5Q2NibmdyA4Ht0cqIg?=
 =?iso-8859-1?Q?kgT39OMQbW+Q9+mAe6CcTdQldmjVP2l1wwjIDI0v2be34nRiDtP/HavCjV?=
 =?iso-8859-1?Q?9VXn18TELcL9RhzVWAnbJr57b3OAIu3GEu4OPYJz2ZQwb0PSdb6Pb9SUVM?=
 =?iso-8859-1?Q?FsGg9IEvp4ZwTX9ZLX8q4/v2jW7EUL1tkHBGX9r7+YxiLN+TVb4h4vaGXk?=
 =?iso-8859-1?Q?mW4CvXvUrQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1fb046-b380-4b36-0a84-08df4aa1ef9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:12:27.9019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpFXzGTzYAAXu2evQHtqzKTvwpP2lzIlXPi0IsNq16QLSPCETrOacS78wcJbpc65lo2b3SOjhE6gr4lXACAdkyaA3BkWA+6xyxzD4ZZ2KKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8895
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

The RC has one interrupt line for both INTx and MSI. It should be high=0A=
when (INT_STS & INT_EN) !=3D 0 or an MSI is pending.=0A=
=0A=
The model only updates the line when a device raises or lowers its=0A=
INTx. A write to INT_EN does not update it. The guest firmware masks an=0A=
INTx while the handler runs, so an INTx that comes in during the=0A=
handler is lost.=0A=
=0A=
For example, with INTD (bit 3, 0x8):=0A=
=0A=
  1. The device raises INTD.=0A=
  2. The guest firmware masks INTD.=0A=
  3. The device lowers INTD.=0A=
  4. The device raises INTD again.=0A=
  5. The guest firmware unmasks INTD.=0A=
=0A=
  step  INT_EN  INT_STS  line=0A=
  1     0x8     0x8      1=0A=
  2     0x0     0x8      1=0A=
  3     0x0     0x0      0=0A=
  4     0x0     0x8      0=0A=
  5     0x8     0x8      0    (should be 1)=0A=
=0A=
The guest never sees the interrupt from step 4.=0A=
=0A=
INTx and MSI also overwrite each other on the line. If an MSI is=0A=
pending (MSI_STS0 =3D 0x1) and a device lowers INTD, the line drops to 0.=
=0A=
If INTD is pending (INT_STS =3D 0x8) and the guest clears the last MSI,=0A=
the line drops to 0 as well.=0A=
=0A=
Compute the line in one place, aspeed_pcie_rc_update_irq(), and call=0A=
it on INTx changes, MSI changes and INT_EN writes.=0A=
=0A=
Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space and=
 host bridge")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/pci-host/aspeed_pcie.c | 41 +++++++++++++++++++++++++++++----------=0A=
 hw/pci-host/trace-events  |  6 +++---=0A=
 2 files changed, 34 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c=0A=
index ceb010f213..2362409ab7 100644=0A=
--- a/hw/pci-host/aspeed_pcie.c=0A=
+++ b/hw/pci-host/aspeed_pcie.c=0A=
@@ -89,12 +89,29 @@ static void aspeed_pcie_root_port_class_init(ObjectClas=
s *klass,=0A=
 =0A=
 #define ASPEED_PCIE_CFG_RC_MAX_MSI 64=0A=
 =0A=
+/*=0A=
+ * INTx and MSI share one RC interrupt line. Compute it from both, so one=
=0A=
+ * does not lower the line while the other is still pending.=0A=
+ */=0A=
+static void aspeed_pcie_rc_update_irq(AspeedPCIECfgState *cfg)=0A=
+{=0A=
+    uint32_t msi_sts0 =3D cfg->regs[cfg->rc_regs->msi_sts0_reg];=0A=
+    uint32_t msi_sts1 =3D cfg->regs[cfg->rc_regs->msi_sts1_reg];=0A=
+    uint32_t int_sts =3D cfg->regs[cfg->rc_regs->int_sts_reg];=0A=
+    uint32_t int_en =3D cfg->regs[cfg->rc_regs->int_en_reg];=0A=
+    bool level;=0A=
+=0A=
+    level =3D (int_sts & int_en) || msi_sts0 || msi_sts1;=0A=
+    trace_aspeed_pcie_rc_update_irq(cfg->id, int_sts, int_en, msi_sts0,=0A=
+                                    msi_sts1, level);=0A=
+    qemu_set_irq(cfg->rc.irq, level);=0A=
+}=0A=
+=0A=
 static void aspeed_pcie_rc_set_irq(void *opaque, int irq, int level)=0A=
 {=0A=
     AspeedPCIERcState *rc =3D (AspeedPCIERcState *) opaque;=0A=
     AspeedPCIECfgState *cfg =3D=0A=
         container_of(rc, AspeedPCIECfgState, rc);=0A=
-    bool intx;=0A=
 =0A=
     assert(irq < PCI_NUM_PINS);=0A=
 =0A=
@@ -104,10 +121,8 @@ static void aspeed_pcie_rc_set_irq(void *opaque, int i=
rq, int level)=0A=
         cfg->regs[cfg->rc_regs->int_sts_reg] &=3D ~BIT(irq);=0A=
     }=0A=
 =0A=
-    intx =3D !!(cfg->regs[cfg->rc_regs->int_sts_reg] &=0A=
-              cfg->regs[cfg->rc_regs->int_en_reg]);=0A=
-    trace_aspeed_pcie_rc_intx_set_irq(cfg->id, irq, intx);=0A=
-    qemu_set_irq(rc->irq, intx);=0A=
+    trace_aspeed_pcie_rc_intx_set_irq(cfg->id, irq, level);=0A=
+    aspeed_pcie_rc_update_irq(cfg);=0A=
 }=0A=
 =0A=
 static int aspeed_pcie_rc_map_irq(PCIDevice *pci_dev, int irq_num)=0A=
@@ -129,7 +144,7 @@ static void aspeed_pcie_rc_msi_notify(AspeedPCIERcState=
 *rc, uint64_t data)=0A=
     cfg->regs[reg] |=3D BIT(data % 32);=0A=
 =0A=
     trace_aspeed_pcie_rc_msi_set_irq(cfg->id, data, 1);=0A=
-    qemu_set_irq(rc->irq, 1);=0A=
+    aspeed_pcie_rc_update_irq(cfg);=0A=
 }=0A=
 =0A=
 static void aspeed_pcie_rc_msi_write(void *opaque, hwaddr addr, uint64_t d=
ata,=0A=
@@ -541,6 +556,10 @@ static void aspeed_pcie_cfg_write(void *opaque, hwaddr=
 addr, uint64_t data,=0A=
             s->regs[R_H2X_TX_STS] |=3D R_H2X_TX_STS_IDLE_MASK;=0A=
         }=0A=
         break;=0A=
+    case R_H2X_RC_H_INT_EN:=0A=
+        s->regs[reg] =3D data;=0A=
+        aspeed_pcie_rc_update_irq(s);=0A=
+        break;=0A=
     /* preserve INTx status */=0A=
     case R_H2X_RC_H_INT_STS:=0A=
         if (data & H2X_RC_INT_INTDONE_MASK) {=0A=
@@ -567,8 +586,7 @@ static void aspeed_pcie_cfg_write(void *opaque, hwaddr =
addr, uint64_t data,=0A=
 =0A=
         if (!s->regs[R_H2X_RC_H_MSI_STS0] &&=0A=
             !s->regs[R_H2X_RC_H_MSI_STS1]) {=0A=
-            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);=0A=
-            qemu_set_irq(s->rc.irq, 0);=0A=
+            aspeed_pcie_rc_update_irq(s);=0A=
         }=0A=
         break;=0A=
     default:=0A=
@@ -718,6 +736,10 @@ static void aspeed_2700_pcie_cfg_write(void *opaque, h=
waddr addr,=0A=
         }=0A=
         break;=0A=
 =0A=
+    case R_H2X_INT_EN:=0A=
+        s->regs[reg] =3D data;=0A=
+        aspeed_pcie_rc_update_irq(s);=0A=
+        break;=0A=
     case R_H2X_INT_STS:=0A=
         s->regs[reg] &=3D ~data | R_H2X_INT_STS_INTX_MASK;=0A=
         break;=0A=
@@ -740,8 +762,7 @@ static void aspeed_2700_pcie_cfg_write(void *opaque, hw=
addr addr,=0A=
 =0A=
         if (!s->regs[R_H2X_MSI_STS0] &&=0A=
             !s->regs[R_H2X_MSI_STS1]) {=0A=
-            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);=0A=
-            qemu_set_irq(s->rc.irq, 0);=0A=
+            aspeed_pcie_rc_update_irq(s);=0A=
         }=0A=
         break;=0A=
     default:=0A=
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events=0A=
index a6fd88c2c4..26730beafc 100644=0A=
--- a/hw/pci-host/trace-events=0A=
+++ b/hw/pci-host/trace-events=0A=
@@ -1,10 +1,10 @@=0A=
 # See docs/devel/tracing.rst for syntax documentation.=0A=
 =0A=
 # aspeed_pcie.c=0A=
-aspeed_pcie_rc_intx_set_irq(uint32_t id, int num, int level) "%d: num %d s=
et IRQ leve %d"=0A=
+aspeed_pcie_rc_update_irq(uint32_t id, uint32_t int_sts, uint32_t int_en, =
uint32_t msi_sts0, uint32_t msi_sts1, int level) "%d: INT_STS 0x%x INT_EN 0=
x%x MSI_STS0 0x%x MSI_STS1 0x%x level %d"=0A=
+aspeed_pcie_rc_intx_set_irq(uint32_t id, int num, int level) "%d: INTx %d =
level %d"=0A=
 aspeed_pcie_rc_msi_notify(uint32_t id, uint64_t addr, uint64_t data) "%d: =
0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_pcie_rc_msi_set_irq(uint32_t id, uint64_t unm, int level) "%d: num =
0x%" PRIx64 " set IRQ level %d"=0A=
-aspeed_pcie_rc_msi_clear_irq(uint32_t id, int level) "%d: clear IRQ level =
%d"=0A=
+aspeed_pcie_rc_msi_set_irq(uint32_t id, uint64_t num, int level) "%d: num =
0x%" PRIx64 " set IRQ level %d"=0A=
 aspeed_pcie_cfg_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr=
 0x%" PRIx64 " value 0x%" PRIx32=0A=
 aspeed_pcie_cfg_write(uint32_t id, uint64_t addr, uint32_t value) "%d: add=
r 0x%" PRIx64 " value 0x%" PRIx32=0A=
 aspeed_pcie_cfg_rw(uint32_t id, const char *dir, uint8_t bus, uint8_t devf=
n, uint64_t addr, uint64_t data) "%d: %s bus:0x%x devfn:0x%x addr 0x%" PRIx=
64 " data 0x%" PRIx64=0A=
-- =0A=
2.53.0=0A=

