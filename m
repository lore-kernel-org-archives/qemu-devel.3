Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECB7107760C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2woY-0005ve-Fb; Wed, 18 Mar 2026 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w1Y-0002cy-It
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w1S-0006Qw-Mc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso1407965e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773860017; x=1774464817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2E9dkyclMm1Bw8RNQiNxi3vU1BzLiWqIgGZE5zUnoY=;
 b=DCKmZZm/mIyzTGMvFeD4+7+S2eB5qPDbo14BMUrB4UYo26WXWmgutLU/dmbR/OmXKJ
 Gjk5ilySMeK6IGnEBAe1Y4ytPmR7lgb3vzyB2U8ImyxzULeQktTFbWLYbs97+ECmIRfK
 CZLfM/jwHL65kJwQTb9XrcUXQ+q3Q0S0kQ65rF3sUVzs+8Z1QaJG+3mOob6XNxw+3jcm
 S1+agYwIef475l/vBMwodj/os7HwfXvIcJ1hx1LJufugEEgGbCxySegJ6TEYB77HsQ8K
 A/8mU8CJZY4QmkhdEIsuUCFOJaoy52nzsnIH5LqCKwGQzfCzc6ngK/KQP7UlfxBoSxUs
 j6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860017; x=1774464817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M2E9dkyclMm1Bw8RNQiNxi3vU1BzLiWqIgGZE5zUnoY=;
 b=TnMyb2UIAn6td/MO9F2xKghVdWJEnXYddXOIVXCYr4acXWXbhuZffwiUfaPeUM7LkT
 lhq+SlrUTmy8XccX+YBfn49QP9enlRxsoYJ+9pfTay6hFg9CP+bFiEfOPpWScX4PcxbQ
 W70kfc7levDzsZjAI2MBt+jAZEElgY4L/53Bc+GWoVgjyrk5NRBkhUEnWbwmWNbt0dE6
 YP7E1q3fITf2BoUXRoxLIVWXbNZi4qsMWUxuP9ow2BRoi1gXGAtQMZijMj3qMscnKwE4
 89eeERzhRvKymYWra3QD44eVRnvk9KHf4599ctR8TKKQl0IcTS+aJuxGIiWiitA4POcd
 mSpQ==
X-Gm-Message-State: AOJu0YzEuI1c4Gox8auCOBVvbZuzVysM3p7DavsjOLjLH90ViHHuGxI4
 Bx8UHZQouI3RmDnyzab4kYBosLLFNns1ikWKDY4xbNBfc0Rd7nwoMUxQlL3c+i59bpQ=
X-Gm-Gg: ATEYQzzisxXAvkdZ3DxBIzhBN29utPc/jZ75FXYfI6ACjQnMvohrJJxS4VL+PU+Scpk
 BNn3Ma6l6fAdmvrSCv1YdC43e4jW/vSd8ZQtcwOA2GuMqkDopkr5EmqAUL8yJWp1fRXOoDTCCw2
 WIAdfLb4eIXr1Cd/fV+XZE5mQRrzQhHCFpTDAJ6L1fdWMyT6rO3w/SHMxKuCNRZf0E9u/Zm8Ckb
 8DRu9R3d1FQaT5aPKGLS+ETU0nX34LE8Dh7ZdJalLPmkJxf4ZB7h5BHjky8tC/bf6FJgAE3tNW5
 e3ArUsrO7l0UyeT8ZuGISBMQluNKD++6e8qGuJ8foFCDq7AVqZQlWJvtEV1a7r1zIchyNAbdyQc
 EKmseHQP/rXW7f3JvpWpt5ke60G3UxB1znq4ayxmrkavNBqbTu49mhDtz6yCi/OMCS3iN44TElU
 k2vb3pGVl8QOtUVz8BRMxaXTvn9aJahan6nlMYcSO9E3BKwp+Y2ts2b85kT16+JmL5nqIvQjaY3
 KFBWaMBjfXLT3UansSo6AKbH2rV282htiq9SeI=
X-Received: by 2002:a05:600c:1f93:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-486f445e26dmr74478575e9.26.1773860016738; 
 Wed, 18 Mar 2026 11:53:36 -0700 (PDT)
Received: from luis-IdeaPad-Flex-5-14ALC05.. ([148.69.202.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b0bc58sm16135905e9.3.2026.03.18.11.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:53:36 -0700 (PDT)
From: luisccc <luisccunha8@gmail.com>
To: qemu-devel@nongnu.org
Cc: luisccc <luisccunha8@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH 5/6] target/riscv: Enable SPMP support in CPU
Date: Wed, 18 Mar 2026 18:52:35 +0000
Message-ID: <20260318185238.99143-6-luisccunha8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318185238.99143-1-luisccunha8@gmail.com>
References: <20260318185238.99143-1-luisccunha8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=luisccunha8@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:19 -0400
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

Integrate the SPMP implementation into the RISC-V CPU model.Memory access checks are updated to take SPMP configuration into account when the extension is active.

Signed-off-by: Luis Cunha <luisccunha8@gmail.com>
---
 target/riscv/cpu.h        |   1 +
 target/riscv/cpu_helper.c | 139 +++++++++++++++++++++++++++++++-------
 2 files changed, 116 insertions(+), 24 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e19c1216ea..bf05ab66ce 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -130,6 +130,7 @@ enum {
     TRANSLATE_SUCCESS,
     TRANSLATE_FAIL,
     TRANSLATE_PMP_FAIL,
+    TRANSLATE_SPMP_FAIL,
     TRANSLATE_G_STAGE_FAIL
 };
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..de20f6c9f4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -36,6 +36,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
+#include "spmp.h"
 #include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
@@ -1113,6 +1114,42 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
     return TRANSLATE_SUCCESS;
 }
 
+/*
+ * get_physical_address_spmp - check SPMP permission for this physical address
+ *
+ * Match the SPMP region and check permission for this physical address.
+ * Returns 0 if the permission checking was successful.
+ * The SPMP check is happened before the PMP check.
+ *
+ * @env: CPURISCVState
+ * @prot: The returned protection attributes
+ * @addr: The physical address to be checked permission
+ * @access_type: The type of access
+ * @mode: Indicates current privilege level.
+ */
+static int get_physical_address_spmp(CPURISCVState *env, int *prot, hwaddr addr,
+                                    int size, int access_type,
+                                    int mode)
+{
+    spmp_priv_t spmp_priv;
+
+    if (!riscv_cpu_cfg(env)->spmp) {
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return TRANSLATE_SUCCESS;
+    }
+
+    if (!spmp_hart_has_privs(env, addr, size, 1 << access_type, &spmp_priv,
+                            mode)) {
+        *prot = 0;
+        return TRANSLATE_SPMP_FAIL;
+    }
+
+    *prot = spmp_priv_to_page_prot(spmp_priv);
+
+    return TRANSLATE_SUCCESS;
+}
+
+
 /* Returns 'true' if a svukte address check is needed */
 static bool do_svukte_check(CPURISCVState *env, bool first_stage,
                              int mode, bool virt)
@@ -1616,8 +1653,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type, bool pmp_violation,
-                                bool first_stage, bool two_stage,
-                                bool two_stage_indirect)
+                                bool spmp_violation, bool first_stage,
+                                bool two_stage, bool two_stage_indirect)
 {
     CPUState *cs = env_cpu(env);
 
@@ -1625,7 +1662,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     case MMU_INST_FETCH:
         if (pmp_violation) {
             cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
-        } else if (env->virt_enabled && !first_stage) {
+        } else if (env->virt_enabled && (!first_stage || spmp_violation)) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
         } else {
             cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
@@ -1634,7 +1671,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     case MMU_DATA_LOAD:
         if (pmp_violation) {
             cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
-        } else if (two_stage && !first_stage) {
+        } else if ((two_stage && !first_stage) ||
+                    (env->virt_enabled && spmp_violation)) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
             cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
@@ -1643,7 +1681,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     case MMU_DATA_STORE:
         if (pmp_violation) {
             cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
-        } else if (two_stage && !first_stage) {
+        } else if ((two_stage && !first_stage) ||
+                    (env->virt_enabled && spmp_violation)) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
             cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
@@ -1766,8 +1805,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPURISCVState *env = &cpu->env;
     vaddr im_address;
     hwaddr pa = 0;
-    int prot, prot2, prot_pmp;
+    int prot, prot2, prot_pmp, prot_spmp;
     bool pmp_violation = false;
+    bool spmp_violation = false;
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
@@ -1820,16 +1860,38 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             prot &= prot2;
 
             if (ret == TRANSLATE_SUCCESS) {
-                ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                               size, access_type, mode);
-                tlb_size = pmp_get_tlb_size(env, pa);
+                int vm;
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    vm = get_field(env->hgatp, SATP32_MODE);
+                } else {
+                    vm = get_field(env->hgatp, SATP64_MODE);
+                }
 
-                qemu_log_mask(CPU_LOG_MMU,
-                              "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                              " %d tlb_size %" HWADDR_PRIu "\n",
-                              __func__, pa, ret, prot_pmp, tlb_size);
+                if (vm == VM_1_10_MBARE && riscv_cpu_cfg(env)->spmp) {
+                    /* S-mode Physical Memory Protection check */
+                    ret = get_physical_address_spmp(env, &prot_spmp, pa,
+                                                    size, access_type, mode);
 
-                prot &= prot_pmp;
+                    prot &= prot_spmp;
+
+                    if (ret == TRANSLATE_SPMP_FAIL) {
+                        spmp_violation = true;
+                    }
+                }
+
+                /* Only apply checks when the SPMP passed */
+                if (ret != TRANSLATE_SPMP_FAIL) {
+                    ret = get_physical_address_pmp(env, &prot_pmp, pa,
+                                                size, access_type, mode);
+                    tlb_size = pmp_get_tlb_size(env, pa);
+
+                    qemu_log_mask(CPU_LOG_MMU,
+                                "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
+                                " %d tlb_size %" HWADDR_PRIu "\n",
+                                __func__, pa, ret, prot_pmp, tlb_size);
+
+                    prot &= prot_pmp;
+                }
             } else {
                 /*
                  * Guest physical address translation failed, this is a HS
@@ -1855,16 +1917,45 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
 
         if (ret == TRANSLATE_SUCCESS) {
-            ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                           size, access_type, mode);
-            tlb_size = pmp_get_tlb_size(env, pa);
+            /*
+             * Check both SPMP and PMP if the core is running in bare mode.
+             */
+            int vm;
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                vm = get_field(env->satp, SATP32_MODE);
+            } else {
+                vm = get_field(env->satp, SATP64_MODE);
+            }
 
-            qemu_log_mask(CPU_LOG_MMU,
-                          "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                          " %d tlb_size %" HWADDR_PRIu "\n",
-                          __func__, pa, ret, prot_pmp, tlb_size);
+            if (vm == VM_1_10_MBARE && riscv_cpu_cfg(env)->spmp) {
+                /* S-mode Physical Memory Protection check */
+                ret = get_physical_address_spmp(env, &prot_spmp, pa,
+                                                size, access_type, mode);
+
+                qemu_log_mask(CPU_LOG_MMU,
+                            "%s SPMP address=" HWADDR_FMT_plx " ret %d"
+                            " prot %d\n", __func__, pa, ret, prot_spmp);
+
+                prot &= prot_spmp;
+
+                if (ret == TRANSLATE_SPMP_FAIL) {
+                    spmp_violation = true;
+                }
+            }
 
-            prot &= prot_pmp;
+            /* Only apply checks when the SPMP passed */
+            if (ret != TRANSLATE_SPMP_FAIL) {
+                ret = get_physical_address_pmp(env, &prot_pmp, pa,
+                                            size, access_type, mode);
+                tlb_size = pmp_get_tlb_size(env, pa);
+
+                qemu_log_mask(CPU_LOG_MMU,
+                            "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
+                            " %d tlb_size %" HWADDR_PRIu "\n",
+                            __func__, pa, ret, prot_pmp, tlb_size);
+
+                prot &= prot_pmp;
+            }
         }
     }
 
@@ -1897,8 +1988,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                              wp_access, retaddr);
 
         raise_mmu_exception(env, address, access_type, pmp_violation,
-                            first_stage_error, two_stage_lookup,
-                            two_stage_indirect_error);
+                            spmp_violation, first_stage_error,
+                            two_stage_lookup, two_stage_indirect_error);
         cpu_loop_exit_restore(cs, retaddr);
     }
 
-- 
2.43.0


