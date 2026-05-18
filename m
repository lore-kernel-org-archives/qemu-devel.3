Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0eH-0004WG-QK; Mon, 18 May 2026 12:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0do-0004Df-2u; Mon, 18 May 2026 12:16:28 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0dl-0004a7-EA; Mon, 18 May 2026 12:16:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHccQ6lG0tm4O4HammxOT36FkwDQRAIm2ZGLgJg1iui57QtvphAktZGrYDLd8C/zdr3mZH72VEVOzxIx+RepqQc2UKUtEah44nIz/9KXIMgSQaS99vbimnocNwQkmHWvsmDUCggQXWEIVsimpE7Q0BqUmedxm/IAF+M+sktzWPstOmPzfR4rpAF1bmlVzkcVGNvNRg396MaC8hE+pVI9DCxUNCjTDFZkmo7jvarqrnJKvP5GycFlMz0Le16/IfWuvPQ1nine0KS1l3iQ9j0lKokk2IVCwCFFaN9Cs8z5s5qWSbk4SlTzeVbK1hslMAjC5/yAN2djjFnSH/C/5uk19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bjlG9gzxWevazCUMGmFwkWjGmHaToEazOwrHxf8SuA=;
 b=GjTN/PGDLPnewwwfDsqm0OnJLc37UTxrCpJs3CWTOL9EFkMJLbtUDf2Jx2KluiseyE/dsISFEKFcqTuJ9sD79xHE6sqXVg1jUn7slbXAlGuqHuIlj2PaFiHYc0tzMTjf7sOMONizOI1HswJHO45ufon60ozZco5zQjdWoVS6Yh20K+HIfVvEc59vZNSZYsg/0BMkehl0wdxifA2/lU8gbCCaBjQR/Yvdl+zu5rtb0Fm2ClvLCnQ5QZg4IbLbpKO4YQL5HeDoqcv9cfU1QccjU7tgmAIk+SbwQNfPwE44U4duYzWOJtHPj5PHyS7L/mP0iLv9JE8GjkQScazXESFd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nongnu.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bjlG9gzxWevazCUMGmFwkWjGmHaToEazOwrHxf8SuA=;
 b=Hrdx5HO40DzYRvdxBdFPzjrJABDAtQJA+NZY6JuBX99YNX+CsWAkMx/aK5NJ2md8DdnqutEOzJEstYIS8ZgAVFKJ1v60C5tYmv2GiT7UenCzb6wQjvPIk4AoQNISj6voQpkOqeQUSb3fKYBfNOuAg66vLALLbCRE0f/oTJ8Y1CHN9gsmy5fIszXeIVJNqYEAyNvVSVRrAYb9KMbqWGa/xpnLl2T9FWEPNMmJbRSQWgbNtZt3UOs72V9B3Elb5JepZ1ykGpgicqBMp+0Sq6l+9vTWFZ7RcdiMDf6i8f8mHerHAc5ysY8Zucduy4QooIPPBFoskiLVvi97B2eyXVBrOw==
Received: from DU2PR04CA0081.eurprd04.prod.outlook.com (2603:10a6:10:232::26)
 by PA1PR10MB9711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:56b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:16:18 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::7a) by DU2PR04CA0081.outlook.office365.com
 (2603:10a6:10:232::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 16:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:16:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:20:09 +0200
Received: from jkgcxl0012.jkg.st.com (10.74.22.122) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:16:16 +0200
From: =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Date: Mon, 18 May 2026 18:13:59 +0200
Subject: [PATCH 1/3] target/arm/tcg: define cortex-m85 cpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260518-pr-pacbti-v1-1-8932a885b03d@foss.st.com>
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
In-Reply-To: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
X-Mailer: b4 0.13.0
X-Originating-IP: [10.74.22.122]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|PA1PR10MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef81e4d-8244-4d76-7ce7-08deb4f8ca9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|42112799006|36860700016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: ReGyxlIeaXpeUlRP5ts4zjH5vMF5NTyUw4i+Pvx8eD271o8krg1F7/onGEWNHwRrL4CqwOn0lVfQoeTd5GMs1aYMcrTbB2noVdjTBpqDTli6Z3cVxDxUwgzLDA3J1LHDELH7WlnieylHGdnIGRs+mCBTokhuS8sorsd/VCPYArRP6IUNwjCiiPFNWSj9cLqMNRN70MgcNUeHXniKPiZtbMy+6K5UVLgipTN9QKKw0gFsQxdrTcoa0IUXykEug1VI5KeYYF0mM3pfxFmDE/5oH4ZxinMgt4or9GLCLgHLoPtr3uHtafBjFiVWVhRXoveOZkWXxZzJEWfw2RguZNl1QOasJC8tLAlPZX1utf6Bd4+EJS29yhtN4DmakgHkkDTaQapO7dCM1Igv++VuPai4WESHwT2So2uPU4FoDEzI3EaI3lbwcyqQa0ftvvb64wJD/feZlW/9R1wp5ScrlXPuzlSysso8IrdsaOiWoRDjUZNyF24Wp+9HxzMa1mItJsZln0DAQTTvsJyNJCrx9bkjoC1U+cr4V4+itx6iDBVs+9+Jgi5jmdmBVMBdlFRjqEZmvAcJeN2eIgzISqNrYMrvBoONFdfl177mbLqHkwvObKPoUZmUmXQ7O76cdJ5ZuFzdDmCHMSSkYmGLTx713Y++mIFrU4UX/GXF+1jPGHp4VV2J3esUwU55kQLgZP2SuAYiAFFOyap0Q0HGnlpbm6lRbJupoLkF5DyCRKeDnFJKqig=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(42112799006)(36860700016)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ljiXUSVVZCV4m3udEI3Op0kQifJv5paBYEDCNMjnw2xhHWxIDfexQKxg8VqU615vS6oqDXssDVaML7qdWrpDJ4rYLt4OQ7/ua9VRXE22r9zdmu5jW2+YXjdPiUFjTzo6BpPL+UHLVbe+lcFpgpkoZXvMO5Hsv824p/preVnBSBh/nv+R3h/Iy/dlzhc4s0dkW0s+9mRUmSpKryxZbjZWrtHm1cXc8I3OCTqP4ugMYaCkhgCuQhZt/dXpRR5BmJplSDpegOqglkNSob3KujO0VjDqI000IzjDVoD2t+/ebnaaypCaiNDOZxHVPXgk1PD2WijnCOz/lYVne/FwjtMLQBEpEjcnVahfYWTOHNqP+HONrsibnnc/Hv7gY8w/1mSWUTs3FhFeHr3p8PEbp/8BIT5oUnZq1Otb5rbNahEVgRtGLX3Aq8E/q0sMKc4QhE9i
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:16:17.6005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef81e4d-8244-4d76-7ce7-08deb4f8ca9a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9711
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=torbjorn.svensson@foss.st.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Torbjörn SVENSSON <torbjorn.svensson@foss.st.com>
---
 target/arm/tcg/cpu-v7m.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f1..5cfda232cd 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,44 @@ static void cortex_m55_initfn(Object *obj)
     cpu->ctr = 0x8303c003;
 }
 
+static void cortex_m85_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x411fd230; /* r1p0 */
+    cpu->revidr = 0;
+    cpu->pmsav7_dregion = 16;
+    cpu->sau_sregion = 8;
+    /* These are the MVFR* values for the FPU + full MVE configuration */
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x12100211;
+    cpu->isar.mvfr2 = 0x00000040;
+    SET_IDREG(isar, ID_PFR0, 0x20000030);
+    SET_IDREG(isar, ID_PFR1, 0x00000230);
+    SET_IDREG(isar, ID_DFR0, 0x10200000);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_MMFR0, 0x00111040);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000011);
+    SET_IDREG(isar, ID_ISAR0, 0x01103110);
+    SET_IDREG(isar, ID_ISAR1, 0x02212000);
+    SET_IDREG(isar, ID_ISAR2, 0x20232232);
+    SET_IDREG(isar, ID_ISAR3, 0x01111131);
+    SET_IDREG(isar, ID_ISAR4, 0x01310132);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
+    SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
+    cpu->ctr = 0x8303c003;
+}
+
 static const TCGCPUOps arm_v7m_tcg_ops = {
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
@@ -290,6 +328,8 @@ static const ARMCPUInfo arm_v7m_cpus[] = {
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m85",  .initfn = cortex_m85_initfn,
+                             .class_init = arm_v7m_class_init },
 };
 
 static void arm_v7m_cpu_register_types(void)

-- 
2.43.0


