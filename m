Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A93F327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Y4-000097-J0; Tue, 21 Apr 2026 05:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xx-000068-R1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xv-0007rn-PA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f2766905fso1751598b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764250; x=1777369050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyfgNwxD7uW39nGLmk9krGfH2I0Eiy0mWwuB3E99/8o=;
 b=gVbrOvasM8DnZBsGXzegdfdAIaePtk+I82/7UXZ0Ge7sj34Nl7q9LFeqWBjsJZYzdu
 uB20l7f8P4aVBCe/lZxNfx62JCjvMPY2k+Fyngsq/lsKOSYpywHo78wxMR/EAyzF6MnC
 5BMA7ceLykKB8UI89F8P4TwecrQNY5Dlpr+1CTGSbIEvYuu+Gs7tpeD95CPCcGmT2Lpo
 Fr3ABuT+FjzzDEBI1sk6w7ewSEl9SgR/5bGRs0pQ9c443lQwo8UsVFym17alROtqfxgs
 zsBHv4TKk0KlxSU2pseSByk78q2BYAJSqC0Dq6uem4W/uc4QGkmeyPQd3hge/Lrh197o
 cXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764250; x=1777369050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PyfgNwxD7uW39nGLmk9krGfH2I0Eiy0mWwuB3E99/8o=;
 b=q7pXMNU6SXbGhaGs523GgHQuf0BeMTFCa2PcNsH/Iw0en15e4bvUObAUlcf3onTCwd
 TPwFVUo/CSYi7eWgB74t5rxcAjR95+bPC2UmG6LyT1oMOP3eitSViNfqRAyvqQD+ENKO
 B0wNtkJhghiYZEVOAXtPKtuSP36ptpZz+cr8Zvwkv9mE7OvnYViAOumNQR4LmZXq2jzE
 NTWnn1IakVXoxHQC1TFtIfKHPCNYuTW4/2bhI+iHwRwoI6F3KeLKc1r0ZrfcMqhDKp+B
 OAvjo1uIdlC4EvLbVgq+T7eS++8MqGlLiDn3LJoAKk4FNDwlyhN4Flh4ufaKnA1Wj76h
 OVIg==
X-Gm-Message-State: AOJu0YyD2YxB7H03tSycH6RYJtJeA1cgs2LX80SX8JVfDlydzhkXdT7O
 NzwGH38TWwmLcKRDHDW90ABXcsnU5fRJr7snfC9i95TVsTCFTGua6beEP3mEL0bEEqV9CbspzE8
 YBoJRbtKdGFUdh6Mc93vIbdvOue0Nj2BobCmLbItnVNCowtKDGPx6vfUS7m0jLFYauqr3Jvn5Ru
 2vbMIOOTnN81wszAa9ZKW9K7A8WSTLxQoRM/CY3XvArm4TqZ8J
X-Gm-Gg: AeBDiet9q0eAmBGI2exWyf8J/+kGr+KVfLc7AswGz4bJlTdLDHY8l+kYEjDpFATQU5O
 nXC6t5tpfaoKFgEKs0AWFY+AJrBAucLn4j5shwTbibxBMZY02EKxz0LtTp1CjWn395WQsGea3Le
 VF9or42QMvinw22RoDaaWtladzzCnmWu11cjNY259Zt7uSzDvLMuueK6M2y/VpBTh70Z3JAooqf
 2Gk2ZJcZoyVYucH9z3MzUmXHxfCaX6BRmFno3SdFI6qgEQ7DAikMBmTpsb98mT/ey6SQO1DQrkn
 lrBC0Ltn7WiNVvb73Ym4JS9FpMG81mKYkSmIDMuiHZeVyGOYEI1DjyQSe2wDKT09bESj58Jk2ix
 a/NQiTSWbvtllsaCerUChqLwj+YK9sfmBby8k2xsTfBjetBkYsmd6YS+KhKnvy1F43gt4Xitmws
 8f0nusHEHIaodKIArDdmMVGWfsNmVxXLgkpdVHGmSHEWc14MHm0kKc6Vy1CBCi
X-Received: by 2002:a05:6a00:340a:b0:82c:ae0e:dea with SMTP id
 d2e1a72fcca58-82f8c8c39b8mr15692296b3a.32.1776764249647; 
 Tue, 21 Apr 2026 02:37:29 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:29 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 3/6] target/riscv: Fix pointer masking PMM field selection
 logic
Date: Tue, 21 Apr 2026 17:37:12 +0800
Message-ID: <20260421093715.2995067-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
References: <20260421093715.2995067-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

mstatus.MPV only records the previous virtualization state, and does not
affect pointer masking according to the Zjpm specification.

This patch rewrites riscv_pm_get_pmm() to follow the architectural
definition of Smmpm, Smnpm, and Ssnpm.

The resulting PMM selection logic for each mode is summarized below:

  * mstatus.MXR = 1: pointer masking disabled

  * Smmpm + Smnpm + Ssnpm:
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U-mode:  senvcfg.PMM
      VS-mode: henvcfg.PMM
      VU-mode: senvcfg.PMM

  * Smmpm + Smnpm (RVS implemented):
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U/VS/VU: disabled (Ssnpm not present)

  * Smmpm + Smnpm (RVS not implemented):
      M-mode:  mseccfg.PMM
      U-mode:  menvcfg.PMM
      S/VS/VU: disabled (no S-mode)

  * Smmpm only:
      M-mode:  mseccfg.PMM
      Other existing modes: pointer masking disabled

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 51 +++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 513bad21afa..bab4153e53b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -131,13 +131,47 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+/*
+ * Returns the effective PMM field.
+ *
+ * @env: CPURISCVState
+ *
+ * The PMM field selection logic for each effective privilege mode
+ * is as follows:
+ *
+ * - mstatus.MXR = 1: disabled
+ *
+ * - Smmpm + Smnpm + Ssnpm:
+ *     M-mode:  mseccfg.PMM
+ *     S-mode:  menvcfg.PMM
+ *     U-mode:  senvcfg.PMM
+ *     VS-mode: henvcfg.PMM
+ *     VU-mode: senvcfg.PMM
+ *
+ * - Smmpm + Smnpm (RVS implemented):
+ *     M-mode:  mseccfg.PMM
+ *     S-mode:  menvcfg.PMM
+ *     U/VS/VU: disabled (Ssnpm not present)
+ *
+ * - Smmpm + Smnpm (RVS not implemented):
+ *     M-mode:  mseccfg.PMM
+ *     U-mode:  menvcfg.PMM
+ *     S/VS/VU: disabled (no S-mode)
+ *
+ * - Smmpm only:
+ *     M-mode:  mseccfg.PMM
+ *     Other existing modes: disabled
+ */
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode = cpu_address_mode(env);
+    int priv_mode;
+    bool virt;
+
+    riscv_cpu_eff_priv(env, &priv_mode, &virt);
 
-    if (get_field(env->mstatus, MSTATUS_MPRV) &&
-        get_field(env->mstatus, MSTATUS_MXR)) {
+    if ((priv_mode != PRV_M && get_field(env->mstatus, MSTATUS_MXR)) ||
+        (virt && get_field(env->vsstatus, MSTATUS_MXR))) {
         return PMM_FIELD_DISABLED;
     }
 
@@ -149,12 +183,14 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
         }
         break;
     case PRV_S:
-        if (riscv_cpu_cfg(env)->ext_smnpm) {
-            if (get_field(env->mstatus, MSTATUS_MPV)) {
-                return get_field(env->henvcfg, HENVCFG_PMM);
-            } else {
+        if (!virt) {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
                 return get_field(env->menvcfg, MENVCFG_PMM);
             }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->henvcfg, HENVCFG_PMM);
+            }
         }
         break;
     case PRV_U:
@@ -171,6 +207,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
     default:
         g_assert_not_reached();
     }
+
     return PMM_FIELD_DISABLED;
 #else
     return PMM_FIELD_DISABLED;
-- 
2.43.0


