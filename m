Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA863CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0eH-0004VD-M7; Mon, 18 May 2026 12:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0dp-0004Hu-T8; Mon, 18 May 2026 12:16:39 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0dm-0004cN-Ot; Mon, 18 May 2026 12:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLGuUWcXcM1SSZGbFXadOLYIkb1c+tN6VBJA7l1wfuG0PAxIao4vd1AEkMzbx/iiE+5w/+9U3f+tDlbK6hgwQRH59f90W2K2KFFVRy5ut+8JqG5L9huOIwSx85V/o8HLRfMMGBWlJl5LoH5ZhiJS59KgCxixBijbmo10FThAgSjqjXQLlOa6Y7ZTPQWsrTh/KCzjV5z9PZKVRAtT2a+bzUqM64/NMDtbUouJrjC8ITyxhX0/zwoeADhcset0seAu3Ssh2CXoJk1ZfEg7a+9XmbzyELTCVmHlI4vxKmJC6b+RcMShHpUuFz0WqP5dPZEwmesR7tjzJueuxsBmoD3QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm6v+LM/18oicffGB/KKcmXbo568/S/T7fOLdh8kbR8=;
 b=zC+0p+UwF5PlpIHRkpeRrXgA+EmIe9rbrNp3a1yofn21OZOW/m+1QRLACQh7cNe/qK0PpaUmpI8RJjcjx4LXCb0F39kuBcakvq/DiCwY1bNzdFUxNIPQIYm3o81ZBeCpBmm8h3FHrCjQuS0Fz6LtzSNNYGchyv/N2+oDhAvR4LUqA396Ekgcmy3VGqFqYuJi4hKUp6YYTaEWDTL9AD+ZB7Gu+Z48j9Yz7LvaF3Ws7qJwaxtsg5L2bUA0LCWG25uGkZJ+u0VWp6gnvNp/xzTbhkdYYppRpstargPg2T2isYJjME8N0O1XyAdN6rCZXzBVG1c4f3IFrV4/k6x6ZPfOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nongnu.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm6v+LM/18oicffGB/KKcmXbo568/S/T7fOLdh8kbR8=;
 b=cMkaHwGro3LD8OMIvPMhYcyi9G/hNHKVYFgbR7QnovyUP6O16Np7DlOeJ3jstHKZWRvCqLRwcojaHgDpzfSUimBSkB/lBmnnzsNvjnXxfV/oHcSrU1esPiw1r8nJiXurGkPvwVQXVWEWM0K/xIfGxXBbbPnKr8C0u9lx6O+9amZ3CtfJOk5o6/J9b4T7aVHKzikY7BmzzDUp/tSUmM211h3ROdIDYfoNd98nvUegzVi5MUy3DJI6l+dpH1Du2ctr/fw1s475nYkWtMe6NaD4yMak9PWt/TzGe2zMzksVvJlDgRQfieJr6ZH026/5QZLvv9XtiTbl1UA/9thG7gcD8Q==
Received: from DU2PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:10:232::15)
 by VI0PR10MB8665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 16:16:18 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::95) by DU2PR04CA0070.outlook.office365.com
 (2603:10a6:10:232::15) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:16:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:20:10 +0200
Received: from jkgcxl0012.jkg.st.com (10.74.22.122) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:16:17 +0200
From: =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Date: Mon, 18 May 2026 18:14:01 +0200
Subject: [PATCH 3/3] target/arm: implement v8.1-m PAC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260518-pr-pacbti-v1-3-8932a885b03d@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|VI0PR10MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e1b9d7-998f-4485-e871-08deb4f8cb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|42112799006|11063799003|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: oBUCC3KrRjF9AvOS1aUICxsq3kjj5wHMfTS1RUASbkt0OY5/y9IuCTFziK/DZAetXw7tJgARl46OJnqwrz6cpzpovlrGG5IoPq+Q6NIpZRVqG3uG1yxEblG1XKVBD+skO8YG2cGHqCQezQMxvIErAIy9d7mU2vEUZkb/4Z1cP1CIiwxlWtvVSpARVlOlv0/FQ888TkzS81yckXmQ2Nx2oPhJ2Amgzkff09GnTwoflZx+5yCcx8qdNkZmN/pet2xl+skRPEYC5Zu6UW77s5hBjEFQz3eX5vIwAGPL3ECxsrde/eBO3OkGp57NGIOLFHQJuwJogveKI7w3sqzGcgvXiOi+kCid7N0fY1bh5qnQ22Xrrfc8LOTsAsst8zykrgTp0mTS6YGb2XLEyzygAtKEBJdJrIlSUhSFdCzZObYNp2gjT1qxu1sLPDchyyBfMhEyDQiwF3YuUuAk746SEJTy8Lqlyr6WMS9KGby4yA6LEsSlYSqk8crlDSnSlrDq6bF4L2nS34Fjg2nH/XPhMYMJBPGDZurcjVOPOie4gBi/XY6w/pmwSecKpt6iXaZ2HbfkrlpE8sUk3CF/1iabyhDDNRYkznlSCN61qLwlAzPUJRQBzLw66qpDXmefQWGinmLIuHcKwX9JMzxAZ5cS7CZ5XzUpZ/DeYRTkOQS/oMSCLPSlLj564hP1tsxCG9M+SvYpjkuEVJybxB97XrCMHH9kG4WUvf/Y9leppDJsvu/T1lk=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(42112799006)(11063799003)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2djnJLosY2JjBDqeMlluR3sypP1Tre2zhk0ZmUZdDQSXweZpEQSzwMo2Oyi89B2JbWmqQTFnXU5mGne6pGCjvLC6V7Oit/zQiy7qhHD9PZcfxtL/IIY8P6AB20b/EmdY1F4Ca+xurfxHTJ8bgAiItkJbAkFNN7fIMA5dw3lji60ZC0weRR53QCiBUUHeYHJUbA7DQ+l3zNztMxR2PqaiHmqFejkQMZkP65F+h8k+cFxHQJrPbmAFNqHm9dXm05kzRQHvDolm17/EQC2kKbZzdYQ3QFAeP+JNmGosHgM9X5t1LVCtNpapfSkMe5ZyfXRNMzXomSALGdt6YbbaCdMnMt+yujlyfseAX83fVR8bkKNvyL9YpzoTE2qlelg7SHCaiXW43uWyIOBYwY1Z6yJADmDYB6QEw7oW1NQVftXcVpo8vmH3Q+A1f1W7ygdMeQuR
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:16:18.3627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e1b9d7-998f-4485-e871-08deb4f8cb0c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8665
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=torbjorn.svensson@foss.st.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

The algorithm used for hashing is a simple XOR between the pointer
and the modifier using the "implementation defined" scheme.

Signed-off-by: Torbjörn SVENSSON <torbjorn.svensson@foss.st.com>
---
 target/arm/cpu-features.h  |  6 +++
 target/arm/internals.h     |  2 +
 target/arm/tcg/cpu-v7m.c   |  2 +-
 target/arm/tcg/m_helper.c  | 17 ++++++++
 target/arm/tcg/translate.c | 98 ++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4e44245a8b..60bd7a0765 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -114,6 +114,7 @@ FIELD(ID_ISAR5, AES, 4, 4)
 FIELD(ID_ISAR5, SHA1, 8, 4)
 FIELD(ID_ISAR5, SHA2, 12, 4)
 FIELD(ID_ISAR5, CRC32, 16, 4)
+FIELD(ID_ISAR5, PACBTI, 20, 4)
 FIELD(ID_ISAR5, RDM, 24, 4)
 FIELD(ID_ISAR5, VCMA, 28, 4)
 
@@ -583,6 +584,11 @@ static inline bool isar_feature_aa32_m_sec_state(const ARMISARegisters *id)
     return FIELD_EX32_IDREG(id, ID_PFR1, SECURITY) >= 3;
 }
 
+static inline bool isar_feature_aa32_m_pacbti(const ARMISARegisters *id)
+{
+    return FIELD_EX32_IDREG(id, ID_ISAR5, PACBTI) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
     /* Sadly this is encoded differently for A-profile and M-profile */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 00830b1724..cbb0a1d8fc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -90,6 +90,8 @@ FIELD(V7M_CONTROL, NPRIV, 0, 1)
 FIELD(V7M_CONTROL, SPSEL, 1, 1)
 FIELD(V7M_CONTROL, FPCA, 2, 1)
 FIELD(V7M_CONTROL, SFPA, 3, 1)
+FIELD(V7M_CONTROL, PAC_EN, 6, 1)
+FIELD(V7M_CONTROL, UPAC_EN, 7, 1)
 
 /* Bit definitions for v7M exception return payload */
 FIELD(V7M_EXCRET, ES, 0, 1)
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 5cfda232cd..3beb2b23fa 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -269,7 +269,7 @@ static void cortex_m85_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR2, 0x20232232);
     SET_IDREG(isar, ID_ISAR3, 0x01111131);
     SET_IDREG(isar, ID_ISAR4, 0x01310132);
-    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR5, 0x00200000); /* PACBTI=implementation defined */
     SET_IDREG(isar, ID_ISAR6, 0x00000000);
     SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
     cpu->ctr = 0x8303c003;
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f2059ed8b0..1160fe8d87 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2658,6 +2658,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                 env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
                 env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
             }
+
+            /* Only update PAC_EN / UPAC_EN if PACBTI is implemented. */
+            if (cpu_isar_feature(aa32_m_pacbti, env_archcpu(env))) {
+                uint32_t enable_mask =
+                    R_V7M_CONTROL_PAC_EN_MASK | R_V7M_CONTROL_UPAC_EN_MASK;
+                env->v7m.control[M_REG_NS] &= ~enable_mask;
+                env->v7m.control[M_REG_NS] |= val & enable_mask;
+            }
+
             return;
         case 0x98: /* SP_NS */
         {
@@ -2784,6 +2793,14 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                 env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
             }
         }
+
+        /* Only update PAC_EN / UPAC_EN if PACBTI is implemented. */
+        if (cpu_isar_feature(aa32_m_pacbti, env_archcpu(env))) {
+            uint32_t enable_mask =
+                R_V7M_CONTROL_PAC_EN_MASK | R_V7M_CONTROL_UPAC_EN_MASK;
+            env->v7m.control[env->v7m.secure] &= ~enable_mask;
+            env->v7m.control[env->v7m.secure] |= val & enable_mask;
+        }
         break;
     default:
     bad_reg:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index ae1351ef03..e13119b33b 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5012,26 +5012,80 @@ static bool trans_SMMLSR(DisasContext *s, arg_rrrr *a)
     return op_smmla(s, a, true, true);
 }
 
+static void arm_gen_test_pac_enabled(DisasContext *s, TCGLabel *label)
+{
+    int bank = s->v8m_secure ? M_REG_S : M_REG_NS;
+    int mask = IS_USER(s)
+        ?  R_V7M_CONTROL_UPAC_EN_MASK
+        : R_V7M_CONTROL_PAC_EN_MASK;
+    TCGv_i32 temp = load_cpu_field(v7m.control[bank]);
+    tcg_gen_brcondi_i32(TCG_COND_TSTEQ, temp, mask, label);
+}
+
+static TCGv_i32 op_create_pac_hash(DisasContext *s, int rn, int rm)
+{
+    TCGv_i32 res = tcg_temp_new_i32();
+    TCGv_i64 ext_ptr = tcg_temp_new_i64();
+    TCGv_i64 modifier = tcg_temp_new_i64();
+    TCGv_i64 temp = tcg_temp_new_i64();
+
+    tcg_gen_extu_i32_i64(ext_ptr, load_reg(s, rn));
+    tcg_gen_extu_i32_i64(modifier, load_reg(s, rm));
+
+    /*
+     * This a very simple implementation that just xor the two
+     * inputs. The goal is not to replicate any of the predefined
+     * hashing functions, but use a simple check.
+     */
+    tcg_gen_xor_i64(temp, ext_ptr, modifier);
+
+    /* Return the lower word */
+    tcg_gen_extrl_i64_i32(res, temp);
+    return res;
+}
+
+static bool op_pacg(DisasContext *s, arg_rrr *a)
+{
+    TCGv_i32 temp;
+    TCGLabel *done = gen_new_label();
+
+    arm_gen_test_pac_enabled(s, done);
+
+    temp = op_create_pac_hash(s, a->rn, a->rm);
+    store_reg(s, a->rd, temp);
+
+    gen_set_label(done);
+    return true;
+}
+
 static bool trans_PAC(DisasContext *s, arg_empty *a)
 {
+    arg_rrr arg;
+
     if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
         return false;
     }
 
-    /* Handle as if PACBTI is disabled. */
-    return true;
+    arg.rd = 0xc; /* R12 */
+    arg.rn = 0xe; /* LR */
+    arg.rm = 0xd; /* SP */
+    return op_pacg(s, &arg);
 }
 
 static bool trans_PACBTI(DisasContext *s, arg_empty *a)
 {
+    arg_rrr arg;
+
     if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
         return false;
     }
 
     /* todo: reset EPSR.B to 0 */
 
-    /* Handle as if PACBTI is disabled. */
-    return true;
+    arg.rd = 0xc; /* R12 */
+    arg.rn = 0xe; /* LR */
+    arg.rm = 0xd; /* SP */
+    return op_pacg(s, &arg);
 }
 
 static bool trans_PACG(DisasContext *s, arg_rrr *a)
@@ -5040,7 +5094,26 @@ static bool trans_PACG(DisasContext *s, arg_rrr *a)
         return false;
     }
 
-    /* Handle as if PACBTI is disabled. */
+    return op_pacg(s, a);
+}
+
+static bool op_autg(DisasContext *s, arg_rrrr *a, int set_pc_from_reg)
+{
+    TCGv_i32 expected_pac_hash, actual_pac_hash;
+    TCGLabel *done = gen_new_label();
+    TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
+    arm_gen_test_pac_enabled(s, done);
+
+    expected_pac_hash = load_reg(s, a->ra);
+    actual_pac_hash = op_create_pac_hash(s, a->rn, a->rm);
+    tcg_gen_brcond_i32(TCG_COND_NE, expected_pac_hash, actual_pac_hash, fail);
+
+    gen_set_label(done);
+    if (set_pc_from_reg >= 0) {
+        gen_bx_excret(s, load_reg(s, set_pc_from_reg));
+    }
+
     return true;
 }
 
@@ -5050,18 +5123,22 @@ static bool trans_BXAUT(DisasContext *s, arg_rrrr *a)
         return false;
     }
 
-    /* Handle as if PACBTI is disabled. */
-    return true;
+    return op_autg(s, a, a->rn);
 }
 
 static bool trans_AUT(DisasContext *s, arg_empty *a)
 {
+    arg_rrrr arg;
+
     if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
         return false;
     }
 
-    /* Handle as if PACBTI is disabled. */
-    return true;
+    arg.rd = 0; /* unused */
+    arg.ra = 0xc; /* R12 */
+    arg.rn = 0xe; /* LR */
+    arg.rm = 0xd; /* SP */
+    return op_autg(s, &arg, -1);
 }
 
 static bool trans_AUTG(DisasContext *s, arg_rrrr *a)
@@ -5070,8 +5147,7 @@ static bool trans_AUTG(DisasContext *s, arg_rrrr *a)
         return false;
     }
 
-    /* Handle as if PACBTI is disabled. */
-    return true;
+    return op_autg(s, a, -1);
 }
 
 static bool op_div(DisasContext *s, arg_rrr *a, bool u)

-- 
2.43.0


