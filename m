Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3B4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYyr-00023F-6I; Tue, 30 Jun 2026 09:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYym-00022l-TH; Tue, 30 Jun 2026 09:58:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyl-0003om-9I; Tue, 30 Jun 2026 09:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRampWPsGeuVvM4a4VU/EEbxVjwNN1ouTqVSNTDv3AZ6zWydv7eHK2w5png7Y7S+OKGknTDDdpaEkGkW6Kj4OOEOIpRLZ26WUIMfaCuh60JmnSRm4386TKATvqUtM13/spLsXvFDHSqc4DDAFwdKYbmV8aTXVljo2J3T76kqhHDk5rkzm3SEjDJYa2+UN77f2uEs0gxlOk6kQJr/O6mV5ZBSiaAJLvQsA1td/CjW+8O0i6LId6LmJDVJG6mHqC1sndUlwR4gtyCMrZ0sI38TosLskpiSUzlaC0ccWYMpJGh7zOz/65jbv6+Z69QcssqXRfupyoB8g6AeWOP0U/+KqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENCf4yX4DLqru6hMUl/+ERSODshf7YuA/2OVunt83Bg=;
 b=sN7uJ/oVhQ8rRcZTrxrEm6ev1bXe0dllOEc8GIp8ePQe/0R1Nlo1nz1dYUTjfPn9rtSPN2DABhPPn6RnnCSQW/mL5ivkIjrHdVcb4wL4AOZv6UkKAUi1uNg+BHacvoCWgDD3a2j1XZIOdsK9SnUOrRrtUqP8kLC5KYs2rcsDgVFoBLCHOLyWsw3dnIjprpcLY3PmWVlSqFfkfrElAz/oXGwpPY+6gNT1MVOueIiuQsaNOw1xrtEGrVmEw+Cl9GiBcmZ+HO9X9pXP3ZidZr5V0CGbKxTLAjQWFnkS4EtvrU3rn+ui+1FrnuxIWDnSqfkHUM4PhGZLyZWVKV4qZfQXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENCf4yX4DLqru6hMUl/+ERSODshf7YuA/2OVunt83Bg=;
 b=Dg31aYzs++wquiaVwNepNA+zNcy5561bHRcAJunuFyXkwf8WAHRO9tARTicVbJ6Az5PKIUVjeM6uvzYKRxkIPTe2h9LIh0BK8WX56GaLXN8iocANXTFlQva49yNnA4lBruGQ72o1VPIrqkrcB2D/+xmBNtsLkV68HyT7j/2v06hymwxfznQt5t2N9DcmoHJLZbw98mNpZeel67KL29WjSHW5OPDfdrDEWlD++5iMrGiyGHHFBNtTf4F/3k0aPw2Q3P67wa40no+kVx+3gPFfyUnKSmf8ZzoXTVsF5G6IfvvvRl6hJvjSx7wBDjjNzAd2xFfw8UD5mZteECcjeWiDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:11 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 07/10] hw/ssi: aspeed_smc: Fix direct-read dummy bytes
Date: Tue, 30 Jun 2026 21:57:26 +0800
Message-Id: <20260630135729.466264-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 272496c8-84e3-47f7-e498-08ded6af9f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|7416014|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: apPIGzg0txUS2aPRCxSoKy2I/0Rg5jT/6dYVIxMx/Ovbasae4NqBywdy7B5Z8udO3yWiSa33SzB6vyoyAfsMbYu654eCke5busBKHQxqPWL87gPwFmAw+rL7v1goac80VpJPjpbO7C1mOv7zIbHvO70II3uzX6Q0ZP5R9Fj5hqgDK4EM5QA83/1kreqBiYxTzgpzdur2/8vt7soKsSURBK4ngGY23xvF7mNyCK/Ceg0e3NyPd7f42hG3UMIL0kZUrduWqUnL3WVgOPuT60qqECjtKhcieO7jccXhWUgtwRWl9vh3rNUPzkPapjXzpEthpMALhq9TsyqaiYwuGeJBcRVLyEkEAjNIA4/qzBQqo5XJHLmdgxqKTLip2nNBtg7aUYJ4ue49yrokRmSiAmuT9RABA/aupGLTy18JkOrLOFhuRyoRZIYwGaXmr3X2Yg0SZdxwa+8zO7wUQq9ygxYQctgw6V/7cOAL/ZekK+AH4B0yXDITOu4oEwJkYJdqSiCRjVPYll0jhUUFLTaPRnXZ6oPqWm0yOSht2UrVj5QLmI8De9J52oumeaa6l4yu2SAnugiplFgZZEjzsN3krm3NVBD9OVRESbjds3abyOJmaxzx+VeoBJPL4/AVzt13Mrkuutt8oTmh9DqCCh2A/sIFuJsgtTFB2FwpgL3o4cb5tpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(7416014)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdETN+mrBPAq40RnEelFhVKKlAx9wEeEh2IlurbfHQDkC8PoYjTN03/yIFcT?=
 =?us-ascii?Q?y5TAw4W+llvED1OoHyTkFTqf2TtHQ8PgAj8CJT+bVEXaDrKX8T4S7vdiQj68?=
 =?us-ascii?Q?AqToC7W33ureLIfrYLDvwPTY5qTma93syxG3tZ78U3jcChVZwwGy0nvrk2af?=
 =?us-ascii?Q?BEswEgxi4wmHtB4/AEcclBMX/0A1GbLJaIMNiDWttGQjj1A8XkhSg9VpS874?=
 =?us-ascii?Q?EMQdeQ6O9pjeo6d2N8DReI/CR3HIZ7BwBhSV+8hY3u72t2wNPCo4EHV1M65s?=
 =?us-ascii?Q?sTXFEjVkwvNd9qy5izMiA+MUbJUtQlJGFnU9pRaQWHlF+5GadXF8dX6v4TQl?=
 =?us-ascii?Q?ZTx2J9cLXO/HJ/5lONHaRTUMV+UZDxWXEs+fBvuOz3fIhnhDfS2z5o8928Wd?=
 =?us-ascii?Q?Dp9EU+Vxd+aq098quvfU+pHP8umJJ1O2+SGUcreQ9OflfsQZL4doaIS2jEkQ?=
 =?us-ascii?Q?wSQ7f3eLCjbNTon5mwVX2HzVqEYy+dWSBeroac5c6jIIwr4FavRcpHWWS5ih?=
 =?us-ascii?Q?07AH/NHw8HLCjWvDck8XURd3tDIcytUzHxsbLB5/QW+9PK2lK83PE3ldNUKT?=
 =?us-ascii?Q?JY39vxG+JUuSEAcLTd6PdN4R1Uxor2a026jXrTvu+pPKM3EsDfvyM9+KOKFu?=
 =?us-ascii?Q?4O87pVDIneElRgNpgnmopcnY649BU7A37ruIW6PHwnKXkvX0I/rfxXnispkL?=
 =?us-ascii?Q?O/V0+QgcQ/jNVP+hnxOTVFt/YYc9t6AWI1aNRB9/fk6aNt+M4OazU6lI0LPt?=
 =?us-ascii?Q?rm7coGU+3VO1G+FyyK6jfijGLMoEh9YWUTC5nXfxJYmoZYSd0aiVQzdLtKRf?=
 =?us-ascii?Q?1+nPtWJwY16cwpSJGXr7D67te3QbO+xkL9ecXiF/bvPJxssEyOZqaoqpMoOA?=
 =?us-ascii?Q?ybEbAPaSgxdqFctGOi1KIRR5/b8dIrSrx52V9/XUz+3Jcxiysz8hZKPbfrhJ?=
 =?us-ascii?Q?GeRnuZG8ss3D8qR8l6qdX5GnKBvXfIFwswXiCE9h6Fkm/4X8Ev3f/NNb/B0T?=
 =?us-ascii?Q?Jgfo05DukNc9OhEjxHFQ3AXVeAATtiMhq6wz7IgqWbelSGLaGV8nHbEdoCGp?=
 =?us-ascii?Q?C6ER9XvQYauHZK8GtYhVVTi5O1XGE7j+FlrjjoM8OuTsifEUiQ1hMlC1yEDt?=
 =?us-ascii?Q?dJB01yHcy7qUy5KToGvzSvUox2MRXK0uejR5BBeD2ThmFPF43rzkbihZzQCH?=
 =?us-ascii?Q?NcT6P0FjU7pGFabe79waNjyjDV1+WTjz9RGBbklF+NWqHINSn96fOymLvzzN?=
 =?us-ascii?Q?KIE8wb1KUQmMl4gLa0xgLOQjXYLm9mZzgPgSRro6J5ZaQytwu8jgp8nUGm3S?=
 =?us-ascii?Q?YSWkwLye1OjTZcsZ7VqmnoyU2ssrbCEeDAH2UVGDTU43cTXnAxDnQ8HUnf/b?=
 =?us-ascii?Q?A4qOm2Du3VIEFLhJnz+qe04Tj6tDZw2U45n+/keVV9JnOi8NejqX8/R+P51x?=
 =?us-ascii?Q?3NNxh3pDWX9JI74G+qwOgTh1rS22EoGLQAQpb92/tqNu9XRHqrrDgvA/6FXN?=
 =?us-ascii?Q?6d7X8AoNKFnj37nAIV2iiLI7vUbR9S/oOzliDxpbgFOhT+peJRpBJM3KLiRH?=
 =?us-ascii?Q?XIQbNv0Zo8LWa2pSNP+D+P31ChpsLjXt3MNkUK82jlfXj2Jc4ngBrOmTuE4P?=
 =?us-ascii?Q?g7nXyW4R9ST/190hND+v0xgwbP/uJkWswwj5dh0/imKyNTbngYzC64yFXswZ?=
 =?us-ascii?Q?ZBPxDRB+7qIagj7MQegpjFQMkT8fR4cj1hvxYaII3z21gJhPT7tkTO53diKB?=
 =?us-ascii?Q?S0uaBmKz6sqXJrIho6m3QBXm1Xz72DQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272496c8-84e3-47f7-e498-08ded6af9f38
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:11.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVoh4slonqCioel9h7TAndHtbaUNOo7tLohozsB31y2b+rHgaXuQ2Q0Y31ZGWmXUqQtg+R0aDgscpoFGXhQsxEvmWKjmJ7CRh895uAvh5c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
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

m25p80 now consumes fast-read dummy phases as byte counts. The
ASPEED SMC direct-read path still treated the CEx dummy field as
raw cycles and emitted field * 8 SSI transfers. Convert the
ASPEED dummy field to SSI byte transfers using the selected
direct-read data width.

Fixes: ac2810defa9d ("aspeed/smc: handle dummy bytes when doing fast reads in command mode")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/ssi/aspeed_smc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index d87fbd798c..f5abc9fcc9 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -449,19 +449,28 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
     return addr;
 }
 
-static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
+static int aspeed_smc_flash_dummy_bytes(const AspeedSMCFlash *fl)
 {
     const AspeedSMCState *s = fl->controller;
     uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->cs];
     uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
     uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
-    uint32_t dummies = ((dummy_high << 2) | dummy_low) * 8;
+    uint32_t dummy_byte = (dummy_high << 2) | dummy_low;
 
-    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
-        dummies /= 2;
+    /*
+     * Scale the controller dummy field to SSI byte transfers using the
+     * direct-read dummy/address bus width.
+     */
+    if ((r_ctrl0 & CTRL_IO_QPI) ||
+        ((r_ctrl0 & CTRL_IO_QUAD_DATA) &&
+         (r_ctrl0 & CTRL_IO_QUAD_ADDR_DATA))) {
+        dummy_byte *= 4;
+    } else if ((r_ctrl0 & CTRL_IO_DUAL_DATA) &&
+               (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA)) {
+        dummy_byte *= 2;
     }
 
-    return dummies;
+    return dummy_byte;
 }
 
 static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
@@ -487,7 +496,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
      * settings, let's check for fast read mode.
      */
     if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
-        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
+        for (i = 0; i < aspeed_smc_flash_dummy_bytes(fl); i++) {
             ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
         }
     }
-- 
2.34.1


