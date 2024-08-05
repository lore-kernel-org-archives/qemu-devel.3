Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D55DC52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 04:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sapQ4-0002OK-P5; Mon, 05 Aug 2024 00:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sapQ3-0002NA-G0; Mon, 05 Aug 2024 00:34:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sapPz-0002sY-KO; Mon, 05 Aug 2024 00:34:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc587361b6so72080395ad.2; 
 Sun, 04 Aug 2024 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722832436; x=1723437236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T00IJXdwE1eN9SB6ZJWTUgcKsTLlTmZyN21u6SvYh0E=;
 b=hZregIqnAzfJllXGmPeJnIC/4z+jiFd79pcJSCSkhz3/PGhY3aPKh5HBh3MpCLiRsm
 gsNRgGAzwwnPlfVmaQVlWwMQH1BFAcwhgUhPYDuwewaSFzydbyOyjMAOqWx74comlTJ+
 SnQ/TXH49FsB8L12jHbc3UfdGz9kHqQ13yDHQgBmhXYguGJ9QKZkogkIwfdNRk5sBZpC
 OVkb3L7IokMKelBHG4g4XK1El8B8Ax7yg1Ph1FEmeQffU0W+WiswCImkyieNvZo0L+rp
 35zKyyTazZP2Oy0AJaMO7dgBB70e2G/hCH5CN9GVsBf1UYEYoQ7PB+TM9kXZ+1fwONbk
 PUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722832436; x=1723437236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T00IJXdwE1eN9SB6ZJWTUgcKsTLlTmZyN21u6SvYh0E=;
 b=UYGBVZzGSLeOGw1m+XTfoh4rGpJh1KUQW0eWVkutrR0XLwhySy7dXrPNtPSLGLe7wQ
 xl5P8o10nY0MhmXLKu5OJ/GTxiMwh7gODz5QKEXBi+JiQArRf9nfxwotVfwgXJ0mqboU
 XCRgxbvFXwASrlR5TknYMITB5c/cUiJQ1Q0VtqS8RutiQFbxM1HtwSUwcr/Yo/ySgNVg
 zUQPA6M8050tEmDOu+gOdKFsRa876/UjY0HQN+Yr7s6PSsQZmEBTeKMxpuoGluUAVncn
 DwGFQqP4h2I/EIyfL4cMzxpMEwflj8xf34FI8m/oQRwOqyZS5+3WUw8wPYQhCikZOpjb
 bAoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQhgjBiNtR4XAf2ccFWpN6mmuWiAhxDvSl9MUHBIlhiyPFk1IsqaGT7P6BRZKIMXCJLL6LiLppye0IkrBOD5GdL4Ga9NU=
X-Gm-Message-State: AOJu0YyeleTTisIA95h5/RuJlMiPbJWZ9Ran+fGrRWLvHgUzfeeizBPA
 nf0tTkqUG1BdYh3vz1lcWznm/zIy3efCwgE/a3APBqOV7ifO9hJ2aPQPWZqa
X-Google-Smtp-Source: AGHT+IEOJA4z6gScW6t+Z4yKk5JUiyegBfRs6K+Nm6VsPKAAoUYDl5pwBwDZdsOy46jyVbkdeSPz1w==
X-Received: by 2002:a17:902:d501:b0:1fd:9105:7dd3 with SMTP id
 d9443c01a7336-1ff5750acd3mr111823065ad.64.1722832435457; 
 Sun, 04 Aug 2024 21:33:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f29cd5sm57420725ad.56.2024.08.04.21.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 21:33:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Alistair Francis <alistair.francis@wdc.com>, atishp@rivosinc.com,
 bmeng.cn@gmail.com, qemu-riscv@nongnu.org, alistair23@gmail.com
Subject: [PATCH 2/2] target/riscv: Remove get_field and set_field
Date: Mon,  5 Aug 2024 14:33:36 +1000
Message-ID: <20240805043336.72548-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805043336.72548-1-alistair.francis@wdc.com>
References: <20240805043336.72548-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of using the custom RISC-V get_field() and set_field() macros
let's use the newly introduced mask_extract64() and mask_deposit64()
functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 10 ++---
 target/riscv/cpu_bits.h   |  6 ---
 target/riscv/pmp.h        |  6 +--
 target/riscv/cpu.c        | 20 +++++-----
 target/riscv/cpu_helper.c | 83 ++++++++++++++++++++-------------------
 target/riscv/csr.c        | 82 +++++++++++++++++++-------------------
 target/riscv/debug.c      | 14 +++----
 target/riscv/monitor.c    |  8 ++--
 target/riscv/op_helper.c  | 70 +++++++++++++++++----------------
 target/riscv/pmu.c        |  6 +--
 target/riscv/zce_helper.c |  2 +-
 11 files changed, 156 insertions(+), 151 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb6..43428f748b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -637,8 +637,8 @@ static inline int cpu_address_mode(CPURISCVState *env)
 {
     int mode = env->priv;
 
-    if (mode == PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
-        mode = get_field(env->mstatus, MSTATUS_MPP);
+    if (mode == PRV_M && mask_extract64(env->mstatus, MSTATUS_MPRV)) {
+        mode = mask_extract64(env->mstatus, MSTATUS_MPP);
     }
     return mode;
 }
@@ -657,10 +657,10 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
         case PRV_M:
             break;
         case PRV_U:
-            xl = get_field(env->mstatus, MSTATUS64_UXL);
+            xl = mask_extract64(env->mstatus, MSTATUS64_UXL);
             break;
         default: /* PRV_S */
-            xl = get_field(env->mstatus, MSTATUS64_SXL);
+            xl = mask_extract64(env->mstatus, MSTATUS64_SXL);
             break;
         }
     }
@@ -709,7 +709,7 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 #ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
 #else
-    return get_field(env->mstatus, MSTATUS64_SXL);
+    return mask_extract64(env->mstatus, MSTATUS64_SXL);
 #endif
 }
 #endif
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32b068f18a..1574037101 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -3,12 +3,6 @@
 #ifndef TARGET_RISCV_CPU_BITS_H
 #define TARGET_RISCV_CPU_BITS_H
 
-#define get_field(reg, mask) (((reg) & \
-                 (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
-#define set_field(reg, mask, val) (((reg) & ~(uint64_t)(mask)) | \
-                 (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
-                 (uint64_t)(mask)))
-
 /* Extension context status mask */
 #define EXT_STATUS_MASK     0x3ULL
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index f5c10ce85c..8f3ef81298 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -84,8 +84,8 @@ uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
 void pmp_unlock_entries(CPURISCVState *env);
 
-#define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
-#define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
-#define MSECCFG_RLB_ISSET(env) get_field(env->mseccfg, MSECCFG_RLB)
+#define MSECCFG_MML_ISSET(env) mask_extract64(env->mseccfg, MSECCFG_MML)
+#define MSECCFG_MMWP_ISSET(env) mask_extract64(env->mseccfg, MSECCFG_MMWP)
+#define MSECCFG_RLB_ISSET(env) mask_extract64(env->mseccfg, MSECCFG_RLB)
 
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..345175c754 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -953,17 +953,19 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
          * The reset status of SXL/UXL is undefined, but mstatus is WARL
          * and we must ensure that the value after init is valid for read.
          */
-        env->mstatus = set_field(env->mstatus, MSTATUS64_SXL, env->misa_mxl);
-        env->mstatus = set_field(env->mstatus, MSTATUS64_UXL, env->misa_mxl);
-        if (riscv_has_ext(env, RVH)) {
-            env->vsstatus = set_field(env->vsstatus,
+        env->mstatus = mask_deposit64(env->mstatus,
                                       MSTATUS64_SXL, env->misa_mxl);
-            env->vsstatus = set_field(env->vsstatus,
+        env->mstatus = mask_deposit64(env->mstatus,
                                       MSTATUS64_UXL, env->misa_mxl);
-            env->mstatus_hs = set_field(env->mstatus_hs,
-                                        MSTATUS64_SXL, env->misa_mxl);
-            env->mstatus_hs = set_field(env->mstatus_hs,
-                                        MSTATUS64_UXL, env->misa_mxl);
+        if (riscv_has_ext(env, RVH)) {
+            env->vsstatus = mask_deposit64(env->vsstatus,
+                                           MSTATUS64_SXL, env->misa_mxl);
+            env->vsstatus = mask_deposit64(env->vsstatus,
+                                           MSTATUS64_UXL, env->misa_mxl);
+            env->mstatus_hs = mask_deposit64(env->mstatus_hs,
+                                             MSTATUS64_SXL, env->misa_mxl);
+            env->mstatus_hs = mask_deposit64(env->mstatus_hs,
+                                             MSTATUS64_UXL, env->misa_mxl);
         }
     }
     env->mcause = 0;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..a15d5e161e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -46,15 +46,15 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
     if (!ifetch) {
         uint64_t status = env->mstatus;
 
-        if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
-            virt = get_field(env->mstatus, MSTATUS_MPV) &&
+        if (mode == PRV_M && mask_extract64(status, MSTATUS_MPRV)) {
+            mode = mask_extract64(env->mstatus, MSTATUS_MPP);
+            virt = mask_extract64(env->mstatus, MSTATUS_MPV) &&
                    (mode != PRV_M);
             if (virt) {
                 status = env->vsstatus;
             }
         }
-        if (mode == PRV_S && get_field(status, MSTATUS_SUM)) {
+        if (mode == PRV_S && mask_extract64(status, MSTATUS_SUM)) {
             mode = MMUIdx_S_SUM;
         }
     }
@@ -111,8 +111,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= riscv_env_mmu_index(env, 0);
-    fs = get_field(env->mstatus, MSTATUS_FS);
-    vs = get_field(env->mstatus, MSTATUS_VS);
+    fs = mask_extract64(env->mstatus, MSTATUS_FS);
+    vs = mask_extract64(env->mstatus, MSTATUS_VS);
 
     if (env->virt_enabled) {
         flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
@@ -120,8 +120,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
          * Merge DISABLED and !DIRTY states using MIN.
          * We will set both fields when dirtying.
          */
-        fs = MIN(fs, get_field(env->mstatus_hs, MSTATUS_FS));
-        vs = MIN(vs, get_field(env->mstatus_hs, MSTATUS_VS));
+        fs = MIN(fs, mask_extract64(env->mstatus_hs, MSTATUS_FS));
+        vs = MIN(vs, mask_extract64(env->mstatus_hs, MSTATUS_VS));
     }
 
     /* With Zfinx, floating point is enabled/disabled by Smstateen. */
@@ -387,7 +387,7 @@ static int riscv_cpu_pending_to_irq(CPURISCVState *env,
  */
 uint64_t riscv_cpu_all_pending(CPURISCVState *env)
 {
-    uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
+    uint32_t gein = mask_extract64(env->hstatus, HSTATUS_VGEIN);
     uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
     uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
 
@@ -439,12 +439,15 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
         mie = 1;
         hsie = 1;
         vsie = (env->priv < PRV_S) ||
-               (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_SIE));
+               (env->priv == PRV_S &&
+                    mask_extract64(env->mstatus, MSTATUS_SIE));
     } else {
         mie = (env->priv < PRV_M) ||
-              (env->priv == PRV_M && get_field(env->mstatus, MSTATUS_MIE));
+              (env->priv == PRV_M &&
+                    mask_extract64(env->mstatus, MSTATUS_MIE));
         hsie = (env->priv < PRV_S) ||
-               (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_SIE));
+               (env->priv == PRV_S &&
+                    mask_extract64(env->mstatus, MSTATUS_SIE));
         vsie = 0;
     }
 
@@ -638,7 +641,7 @@ void riscv_cpu_interrupt(CPURISCVState *env)
     BQL_LOCK_GUARD();
 
     if (env->virt_enabled) {
-        gein = get_field(env->hstatus, HSTATUS_VGEIN);
+        gein = mask_extract64(env->hstatus, HSTATUS_VGEIN);
         vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
         irqf = env->hvien & env->hvip & env->vsie;
     } else {
@@ -844,29 +847,29 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     if (first_stage == true) {
         if (use_background) {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
-                base = (hwaddr)get_field(env->vsatp, SATP32_PPN) << PGSHIFT;
-                vm = get_field(env->vsatp, SATP32_MODE);
+                base = (hwaddr)mask_extract64(env->vsatp, SATP32_PPN) << PGSHIFT;
+                vm = mask_extract64(env->vsatp, SATP32_MODE);
             } else {
-                base = (hwaddr)get_field(env->vsatp, SATP64_PPN) << PGSHIFT;
-                vm = get_field(env->vsatp, SATP64_MODE);
+                base = (hwaddr)mask_extract64(env->vsatp, SATP64_PPN) << PGSHIFT;
+                vm = mask_extract64(env->vsatp, SATP64_MODE);
             }
         } else {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
-                base = (hwaddr)get_field(env->satp, SATP32_PPN) << PGSHIFT;
-                vm = get_field(env->satp, SATP32_MODE);
+                base = (hwaddr)mask_extract64(env->satp, SATP32_PPN) << PGSHIFT;
+                vm = mask_extract64(env->satp, SATP32_MODE);
             } else {
-                base = (hwaddr)get_field(env->satp, SATP64_PPN) << PGSHIFT;
-                vm = get_field(env->satp, SATP64_MODE);
+                base = (hwaddr)mask_extract64(env->satp, SATP64_PPN) << PGSHIFT;
+                vm = mask_extract64(env->satp, SATP64_MODE);
             }
         }
         widened = 0;
     } else {
         if (riscv_cpu_mxl(env) == MXL_RV32) {
-            base = (hwaddr)get_field(env->hgatp, SATP32_PPN) << PGSHIFT;
-            vm = get_field(env->hgatp, SATP32_MODE);
+            base = (hwaddr)mask_extract64(env->hgatp, SATP32_PPN) << PGSHIFT;
+            vm = mask_extract64(env->hgatp, SATP32_MODE);
         } else {
-            base = (hwaddr)get_field(env->hgatp, SATP64_PPN) << PGSHIFT;
-            vm = get_field(env->hgatp, SATP64_MODE);
+            base = (hwaddr)mask_extract64(env->hgatp, SATP64_PPN) << PGSHIFT;
+            vm = mask_extract64(env->hgatp, SATP64_MODE);
         }
         widened = 2;
     }
@@ -1048,12 +1051,12 @@ restart:
          * virt_enabled (MPRV+MPV)
          */
         if (first_stage || !env->virt_enabled) {
-            mxr = get_field(env->mstatus, MSTATUS_MXR);
+            mxr = mask_extract64(env->mstatus, MSTATUS_MXR);
         }
 
         /* MPRV+MPV case, check VSSTATUS */
         if (first_stage && two_stage && !env->virt_enabled) {
-            mxr |= get_field(env->vsstatus, MSTATUS_MXR);
+            mxr |= mask_extract64(env->vsstatus, MSTATUS_MXR);
         }
 
         /*
@@ -1061,7 +1064,7 @@ restart:
          * execute-only permissions
          */
         if (env->virt_enabled) {
-            mxr |= get_field(env->mstatus_hs, MSTATUS_MXR);
+            mxr |= mask_extract64(env->mstatus_hs, MSTATUS_MXR);
         }
 
         if (mxr) {
@@ -1776,25 +1779,25 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             } else if (env->virt_enabled) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
-                env->hstatus = set_field(env->hstatus, HSTATUS_SPVP,
+                env->hstatus = mask_deposit64(env->hstatus, HSTATUS_SPVP,
                                          env->priv);
-                env->hstatus = set_field(env->hstatus, HSTATUS_SPV, true);
+                env->hstatus = mask_deposit64(env->hstatus, HSTATUS_SPV, true);
 
                 htval = env->guest_phys_fault_addr;
 
                 virt = false;
             } else {
                 /* Trap into HS mode */
-                env->hstatus = set_field(env->hstatus, HSTATUS_SPV, false);
+                env->hstatus = mask_deposit64(env->hstatus, HSTATUS_SPV, false);
                 htval = env->guest_phys_fault_addr;
             }
-            env->hstatus = set_field(env->hstatus, HSTATUS_GVA, write_gva);
+            env->hstatus = mask_deposit64(env->hstatus, HSTATUS_GVA, write_gva);
         }
 
         s = env->mstatus;
-        s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
-        s = set_field(s, MSTATUS_SPP, env->priv);
-        s = set_field(s, MSTATUS_SIE, 0);
+        s = mask_deposit64(s, MSTATUS_SPIE, mask_extract64(s, MSTATUS_SIE));
+        s = mask_deposit64(s, MSTATUS_SPP, env->priv);
+        s = mask_deposit64(s, MSTATUS_SIE, 0);
         env->mstatus = s;
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
@@ -1810,10 +1813,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             if (env->virt_enabled) {
                 riscv_cpu_swap_hypervisor_regs(env);
             }
-            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
+            env->mstatus = mask_deposit64(env->mstatus, MSTATUS_MPV,
                                      env->virt_enabled);
             if (env->virt_enabled && tval) {
-                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
+                env->mstatus = mask_deposit64(env->mstatus, MSTATUS_GVA, 1);
             }
 
             mtval2 = env->guest_phys_fault_addr;
@@ -1823,9 +1826,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
 
         s = env->mstatus;
-        s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
-        s = set_field(s, MSTATUS_MPP, env->priv);
-        s = set_field(s, MSTATUS_MIE, 0);
+        s = mask_deposit64(s, MSTATUS_MPIE, mask_extract64(s, MSTATUS_MIE));
+        s = mask_deposit64(s, MSTATUS_MPP, env->priv);
+        s = mask_deposit64(s, MSTATUS_MIE, 0);
         env->mstatus = s;
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         env->mepc = env->pc;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..b73a76d61a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -139,19 +139,20 @@ skip_ext_pmu_check:
         return RISCV_EXCP_NONE;
     }
 
-    if (env->priv < PRV_M && !get_field(env->mcounteren, ctr_mask)) {
+    if (env->priv < PRV_M && !mask_extract64(env->mcounteren, ctr_mask)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     if (env->virt_enabled) {
-        if (!get_field(env->hcounteren, ctr_mask) ||
-            (env->priv == PRV_U && !get_field(env->scounteren, ctr_mask))) {
+        if (!mask_extract64(env->hcounteren, ctr_mask) ||
+            (env->priv == PRV_U &&
+                !mask_extract64(env->scounteren, ctr_mask))) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
     }
 
     if (riscv_has_ext(env, RVS) && env->priv == PRV_U &&
-        !get_field(env->scounteren, ctr_mask)) {
+        !mask_extract64(env->scounteren, ctr_mask)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -464,14 +465,14 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
      * No need of separate function for rv32 as menvcfg stores both menvcfg
      * menvcfgh for RV32.
      */
-    if (!(get_field(env->mcounteren, COUNTEREN_TM) &&
-          get_field(env->menvcfg, MENVCFG_STCE))) {
+    if (!(mask_extract64(env->mcounteren, COUNTEREN_TM) &&
+          mask_extract64(env->menvcfg, MENVCFG_STCE))) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     if (env->virt_enabled) {
-        if (!(get_field(env->hcounteren, COUNTEREN_TM) &&
-              get_field(env->henvcfg, HENVCFG_STCE))) {
+        if (!(mask_extract64(env->hcounteren, COUNTEREN_TM) &&
+              mask_extract64(env->henvcfg, HENVCFG_STCE))) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
     }
@@ -491,11 +492,11 @@ static RISCVException sstc_32(CPURISCVState *env, int csrno)
 static RISCVException satp(CPURISCVState *env, int csrno)
 {
     if (env->priv == PRV_S && !env->virt_enabled &&
-        get_field(env->mstatus, MSTATUS_TVM)) {
+        mask_extract64(env->mstatus, MSTATUS_TVM)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
     if (env->priv == PRV_S && env->virt_enabled &&
-        get_field(env->hstatus, HSTATUS_VTVM)) {
+        mask_extract64(env->hstatus, HSTATUS_VTVM)) {
         return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
     }
 
@@ -505,7 +506,7 @@ static RISCVException satp(CPURISCVState *env, int csrno)
 static RISCVException hgatp(CPURISCVState *env, int csrno)
 {
     if (env->priv == PRV_S && !env->virt_enabled &&
-        get_field(env->mstatus, MSTATUS_TVM)) {
+        mask_extract64(env->mstatus, MSTATUS_TVM)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -1080,7 +1081,7 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     uint64_t mhpmctr_val = val;
 
     counter->mhpmcounter_val = val;
-    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
+    if (!mask_extract64(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
@@ -1110,7 +1111,7 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
+    if (!mask_extract64(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
@@ -1134,7 +1135,7 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
                                         counter->mhpmcounter_val;
 
-    if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
+    if (mask_extract64(env->mcountinhibit, BIT(ctr_idx))) {
         /*
          * Counter should not increment if inhibit bit is set. Just return the
          * current counter value.
@@ -1208,7 +1209,7 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     }
 
     for (i = mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
-        if ((get_field(env->mcounteren, BIT(i))) &&
+        if ((mask_extract64(env->mcounteren, BIT(i))) &&
             (mhpm_evt_val[i] & of_bit_mask)) {
                     *val |= BIT(i);
             }
@@ -1505,7 +1506,7 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 static bool validate_vm(CPURISCVState *env, target_ulong vm)
 {
     uint64_t mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
-    return get_field(mode_supported, (1 << vm));
+    return mask_extract64(mode_supported, (1 << vm));
 }
 
 static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
@@ -1514,10 +1515,10 @@ static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
     target_ulong mask;
     bool vm;
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        vm = validate_vm(env, get_field(val, SATP32_MODE));
+        vm = validate_vm(env, mask_extract64(val, SATP32_MODE));
         mask = (val ^ old_xatp) & (SATP32_MODE | SATP32_ASID | SATP32_PPN);
     } else {
-        vm = validate_vm(env, get_field(val, SATP64_MODE));
+        vm = validate_vm(env, mask_extract64(val, SATP64_MODE));
         mask = (val ^ old_xatp) & (SATP64_MODE | SATP64_ASID | SATP64_PPN);
     }
 
@@ -1538,7 +1539,7 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
                                  target_ulong val)
 {
     bool valid = false;
-    target_ulong new_mpp = get_field(val, MSTATUS_MPP);
+    target_ulong new_mpp = mask_extract64(val, MSTATUS_MPP);
 
     switch (new_mpp) {
     case PRV_M:
@@ -1554,7 +1555,7 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
 
     /* Remain field unchanged if new_mpp value is invalid */
     if (!valid) {
-        val = set_field(val, MSTATUS_MPP, old_mpp);
+        val = mask_deposit64(val, MSTATUS_MPP, old_mpp);
     }
 
     return val;
@@ -1571,7 +1572,7 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
      * MPP field have been made WARL since priv version 1.11. However,
      * legalization for it will not break any software running on 1.10.
      */
-    val = legalize_mpp(env, get_field(mstatus, MSTATUS_MPP), val);
+    val = legalize_mpp(env, mask_extract64(mstatus, MSTATUS_MPP), val);
 
     /* flush tlb on mstatus fields that affect VM */
     if ((val ^ mstatus) & MSTATUS_MXR) {
@@ -2051,7 +2052,7 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
     };
 
     /* Find the selected guest interrupt file */
-    vgein = (virt) ? get_field(env->hstatus, HSTATUS_VGEIN) : 0;
+    vgein = (virt) ? mask_extract64(env->hstatus, HSTATUS_VGEIN) : 0;
 
     if (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) {
         /* Local interrupt priority registers not available for VS-mode */
@@ -2122,7 +2123,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     }
 
     /* Find the selected guest interrupt file */
-    vgein = (virt) ? get_field(env->hstatus, HSTATUS_VGEIN) : 0;
+    vgein = (virt) ? mask_extract64(env->hstatus, HSTATUS_VGEIN) : 0;
 
     /* Selected guest interrupt file should be valid */
     if (virt && (!vgein || env->geilen < vgein)) {
@@ -2192,7 +2193,7 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
 
         counter = &env->pmu_ctrs[cidx];
 
-        if (!get_field(env->mcountinhibit, BIT(cidx))) {
+        if (!mask_extract64(env->mcountinhibit, BIT(cidx))) {
             counter->mhpmcounter_prev =
                 riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
             if (riscv_cpu_mxl(env) == MXL_RV32) {
@@ -2695,7 +2696,7 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_cfg(env)->ext_sstc && (env->priv == PRV_M) &&
-        get_field(env->menvcfg, MENVCFG_STCE)) {
+        mask_extract64(env->menvcfg, MENVCFG_STCE)) {
         /* sstc extension forbids STIP & VSTIP to be writeable in mip */
         mask = mask & ~(MIP_STIP | MIP_VSTIP);
     }
@@ -2707,7 +2708,7 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     }
 
     if (csrno != CSR_HVIP) {
-        gin = get_field(env->hstatus, HSTATUS_VGEIN);
+        gin = mask_extract64(env->hstatus, HSTATUS_VGEIN);
         old_mip |= (env->hgeip & ((target_ulong)1 << gin)) ? MIP_VSEIP : 0;
         old_mip |= env->vstime_irq ? MIP_VSTIP : 0;
     }
@@ -2814,7 +2815,7 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
      * that our in mip returned value.
      */
     if (cpu->cfg.ext_sstc && (env->priv == PRV_M) &&
-        get_field(env->menvcfg, MENVCFG_STCE)) {
+        mask_extract64(env->menvcfg, MENVCFG_STCE)) {
         alias_mask &= ~MIP_STIP;
     }
 
@@ -3330,9 +3331,9 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
     uint32_t iid, iprio, hviid, hviprio, gein;
     uint32_t s, scount = 0, siid[VSTOPI_NUM_SRCS], siprio[VSTOPI_NUM_SRCS];
 
-    gein = get_field(env->hstatus, HSTATUS_VGEIN);
-    hviid = get_field(env->hvictl, HVICTL_IID);
-    hviprio = get_field(env->hvictl, HVICTL_IPRIO);
+    gein = mask_extract64(env->hstatus, HSTATUS_VGEIN);
+    hviid = mask_extract64(env->hvictl, HVICTL_IID);
+    hviprio = mask_extract64(env->hvictl, HVICTL_IPRIO);
 
     if (gein) {
         vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
@@ -3445,10 +3446,10 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
     *val = env->hstatus;
     if (riscv_cpu_mxl(env) != MXL_RV32) {
         /* We only support 64-bit VSXL */
-        *val = set_field(*val, HSTATUS_VSXL, 2);
+        *val = mask_deposit64(*val, HSTATUS_VSXL, 2);
     }
     /* We only support little endian */
-    *val = set_field(*val, HSTATUS_VSBE, 0);
+    *val = mask_deposit64(*val, HSTATUS_VSBE, 0);
     return RISCV_EXCP_NONE;
 }
 
@@ -3456,11 +3457,12 @@ static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     env->hstatus = val;
-    if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
+    if (riscv_cpu_mxl(env) != MXL_RV32 &&
+        mask_extract64(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
                       "QEMU does not support mixed HSXLEN options.");
     }
-    if (get_field(val, HSTATUS_VSBE) != 0) {
+    if (mask_extract64(val, HSTATUS_VSBE) != 0) {
         qemu_log_mask(LOG_UNIMP, "QEMU does not support big endian guests.");
     }
     return RISCV_EXCP_NONE;
@@ -4277,7 +4279,7 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
  */
 static bool check_pm_current_disabled(CPURISCVState *env, int csrno)
 {
-    int csr_priv = get_field(csrno, 0x300);
+    int csr_priv = mask_extract64(csrno, 0x300);
     int pm_current;
 
     if (env->debugger) {
@@ -4292,13 +4294,13 @@ static bool check_pm_current_disabled(CPURISCVState *env, int csrno)
     }
     switch (env->priv) {
     case PRV_M:
-        pm_current = get_field(env->mmte, M_PM_CURRENT);
+        pm_current = mask_extract64(env->mmte, M_PM_CURRENT);
         break;
     case PRV_S:
-        pm_current = get_field(env->mmte, S_PM_CURRENT);
+        pm_current = mask_extract64(env->mmte, S_PM_CURRENT);
         break;
     case PRV_U:
-        pm_current = get_field(env->mmte, U_PM_CURRENT);
+        pm_current = mask_extract64(env->mmte, U_PM_CURRENT);
         break;
     default:
         g_assert_not_reached();
@@ -4627,7 +4629,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
                                                bool write)
 {
     /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
-    bool read_only = get_field(csrno, 0xC00) == 3;
+    bool read_only = mask_extract64(csrno, 0xC00) == 3;
     int csr_min_priv = csr_ops[csrno].min_priv_ver;
 
     /* ensure the CSR extension is enabled */
@@ -4674,7 +4676,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
         effective_priv++;
     }
 
-    csr_priv = get_field(csrno, 0x300);
+    csr_priv = mask_extract64(csrno, 0x300);
     if (!env->debugger && (effective_priv < csr_priv)) {
         if (csr_priv == (PRV_S + 1) && env->virt_enabled) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 0b5099ff9a..0eb01a2fa5 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -572,13 +572,13 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
 static inline int
 itrigger_get_count(CPURISCVState *env, int index)
 {
-    return get_field(env->tdata1[index], ITRIGGER_COUNT);
+    return mask_extract64(env->tdata1[index], ITRIGGER_COUNT);
 }
 
 static inline void
 itrigger_set_count(CPURISCVState *env, int index, int value)
 {
-    env->tdata1[index] = set_field(env->tdata1[index],
+    env->tdata1[index] = mask_deposit64(env->tdata1[index],
                                    ITRIGGER_COUNT, value);
 }
 
@@ -587,13 +587,13 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
     target_ulong tdata1 = env->tdata1[index];
     if (env->virt_enabled) {
         /* check VU/VS bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_VU) == env->priv);
+        return (mask_extract64(tdata1, ITRIGGER_VS) == env->priv) ||
+               (mask_extract64(tdata1, ITRIGGER_VU) == env->priv);
     } else {
         /* check U/S/M bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_U) == env->priv);
+        return (mask_extract64(tdata1, ITRIGGER_M) == env->priv) ||
+               (mask_extract64(tdata1, ITRIGGER_S) == env->priv) ||
+               (mask_extract64(tdata1, ITRIGGER_U) == env->priv);
     }
 }
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f5b1ffe6c3..cf24cb4002 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -154,11 +154,11 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
     int last_attr;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        base = (hwaddr)get_field(env->satp, SATP32_PPN) << PGSHIFT;
-        vm = get_field(env->satp, SATP32_MODE);
+        base = (hwaddr)mask_extract64(env->satp, SATP32_PPN) << PGSHIFT;
+        vm = mask_extract64(env->satp, SATP32_MODE);
     } else {
-        base = (hwaddr)get_field(env->satp, SATP64_PPN) << PGSHIFT;
-        vm = get_field(env->satp, SATP64_MODE);
+        base = (hwaddr)mask_extract64(env->satp, SATP64_PPN) << PGSHIFT;
+        vm = mask_extract64(env->satp, SATP64_MODE);
     }
 
     switch (vm) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 25a5263573..1f760810f6 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -135,17 +135,17 @@ static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
                                 uintptr_t ra)
 {
 #ifndef CONFIG_USER_ONLY
-    if ((env->priv < PRV_M) && !get_field(env->menvcfg, envbits)) {
+    if ((env->priv < PRV_M) && !mask_extract64(env->menvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 
     if (env->virt_enabled &&
-        (((env->priv <= PRV_S) && !get_field(env->henvcfg, envbits)) ||
-         ((env->priv < PRV_S) && !get_field(env->senvcfg, envbits)))) {
+        (((env->priv <= PRV_S) && !mask_extract64(env->henvcfg, envbits)) ||
+         ((env->priv < PRV_S) && !mask_extract64(env->senvcfg, envbits)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
     }
 
-    if ((env->priv < PRV_S) && !get_field(env->senvcfg, envbits)) {
+    if ((env->priv < PRV_S) && !mask_extract64(env->senvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 #endif
@@ -273,22 +273,22 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    if (get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
+    if (mask_extract64(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    if (env->virt_enabled && get_field(env->hstatus, HSTATUS_VTSR)) {
+    if (env->virt_enabled && mask_extract64(env->hstatus, HSTATUS_VTSR)) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     }
 
     mstatus = env->mstatus;
-    prev_priv = get_field(mstatus, MSTATUS_SPP);
-    mstatus = set_field(mstatus, MSTATUS_SIE,
-                        get_field(mstatus, MSTATUS_SPIE));
-    mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
-    mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+    prev_priv = mask_extract64(mstatus, MSTATUS_SPP);
+    mstatus = mask_deposit64(mstatus, MSTATUS_SIE,
+                        mask_extract64(mstatus, MSTATUS_SPIE));
+    mstatus = mask_deposit64(mstatus, MSTATUS_SPIE, 1);
+    mstatus = mask_deposit64(mstatus, MSTATUS_SPP, PRV_U);
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
-        mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
+        mstatus = mask_deposit64(mstatus, MSTATUS_MPRV, 0);
     }
     env->mstatus = mstatus;
 
@@ -296,9 +296,9 @@ target_ulong helper_sret(CPURISCVState *env)
         /* We support Hypervisor extensions and virtulisation is disabled */
         target_ulong hstatus = env->hstatus;
 
-        prev_virt = get_field(hstatus, HSTATUS_SPV);
+        prev_virt = mask_extract64(hstatus, HSTATUS_SPV);
 
-        hstatus = set_field(hstatus, HSTATUS_SPV, 0);
+        hstatus = mask_deposit64(hstatus, HSTATUS_SPV, 0);
 
         env->hstatus = hstatus;
 
@@ -324,23 +324,23 @@ target_ulong helper_mret(CPURISCVState *env)
     }
 
     uint64_t mstatus = env->mstatus;
-    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    target_ulong prev_priv = mask_extract64(mstatus, MSTATUS_MPP);
 
     if (riscv_cpu_cfg(env)->pmp &&
         !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
 
-    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
+    target_ulong prev_virt = mask_extract64(env->mstatus, MSTATUS_MPV) &&
                              (prev_priv != PRV_M);
-    mstatus = set_field(mstatus, MSTATUS_MIE,
-                        get_field(mstatus, MSTATUS_MPIE));
-    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
-    mstatus = set_field(mstatus, MSTATUS_MPP,
+    mstatus = mask_deposit64(mstatus, MSTATUS_MIE,
+                        mask_extract64(mstatus, MSTATUS_MPIE));
+    mstatus = mask_deposit64(mstatus, MSTATUS_MPIE, 1);
+    mstatus = mask_deposit64(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
-    mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    mstatus = mask_deposit64(mstatus, MSTATUS_MPV, 0);
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
-        mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
+        mstatus = mask_deposit64(mstatus, MSTATUS_MPRV, 0);
     }
     env->mstatus = mstatus;
 
@@ -360,11 +360,13 @@ void helper_wfi(CPURISCVState *env)
     bool prv_u = env->priv == PRV_U;
     bool prv_s = env->priv == PRV_S;
 
-    if (((prv_s || (!rvs && prv_u)) && get_field(env->mstatus, MSTATUS_TW)) ||
+    if (((prv_s || (!rvs && prv_u)) &&
+         mask_extract64(env->mstatus, MSTATUS_TW)) ||
         (rvs && prv_u && !env->virt_enabled)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else if (env->virt_enabled &&
-               (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
+               (prv_u ||
+                (prv_s && mask_extract64(env->hstatus, HSTATUS_VTW)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
         cs->halted = 1;
@@ -376,10 +378,10 @@ void helper_wfi(CPURISCVState *env)
 void helper_wrs_nto(CPURISCVState *env)
 {
     if (env->virt_enabled && (env->priv == PRV_S || env->priv == PRV_U) &&
-        get_field(env->hstatus, HSTATUS_VTW) &&
-        !get_field(env->mstatus, MSTATUS_TW)) {
+        mask_extract64(env->hstatus, HSTATUS_VTW) &&
+        !mask_extract64(env->mstatus, MSTATUS_TW)) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    } else if (env->priv != PRV_M && get_field(env->mstatus, MSTATUS_TW)) {
+    } else if (env->priv != PRV_M && mask_extract64(env->mstatus, MSTATUS_TW)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 }
@@ -389,10 +391,11 @@ void helper_tlb_flush(CPURISCVState *env)
     CPUState *cs = env_cpu(env);
     if (!env->virt_enabled &&
         (env->priv == PRV_U ||
-         (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
+         (env->priv == PRV_S && mask_extract64(env->mstatus, MSTATUS_TVM)))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else if (env->virt_enabled &&
-               (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
+               (env->priv == PRV_U ||
+                mask_extract64(env->hstatus, HSTATUS_VTVM))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
         tlb_flush(cs);
@@ -425,7 +428,7 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
 void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
 {
     if (env->priv == PRV_S && !env->virt_enabled &&
-        get_field(env->mstatus, MSTATUS_TVM)) {
+        mask_extract64(env->mstatus, MSTATUS_TVM)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
@@ -438,12 +441,13 @@ static int check_access_hlsv(CPURISCVState *env, bool x, uintptr_t ra)
         /* always allowed */
     } else if (env->virt_enabled) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
-    } else if (env->priv == PRV_U && !get_field(env->hstatus, HSTATUS_HU)) {
+    } else if (env->priv == PRV_U &&
+               !mask_extract64(env->hstatus, HSTATUS_HU)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 
-    int mode = get_field(env->hstatus, HSTATUS_SPVP);
-    if (!x && mode == PRV_S && get_field(env->vsstatus, MSTATUS_SUM)) {
+    int mode = mask_extract64(env->hstatus, HSTATUS_SPVP);
+    if (!x && mode == PRV_S && mask_extract64(env->vsstatus, MSTATUS_SUM)) {
         mode = MMUIdx_S_SUM;
     }
     return mode | MMU_2STAGE_BIT;
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 3cc0b3648c..1738cbe353 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -94,7 +94,7 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
     CPURISCVState *env = &cpu->env;
 
     if (riscv_pmu_counter_valid(cpu, ctr_idx) &&
-        !get_field(env->mcountinhibit, BIT(ctr_idx))) {
+        !mask_extract64(env->mcountinhibit, BIT(ctr_idx))) {
         return true;
     } else {
         return false;
@@ -429,7 +429,7 @@ static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
         of_bit_mask = MHPMEVENT_BIT_OF;
     }
 
-    return get_field(mhpmevent_val, of_bit_mask);
+    return mask_extract64(mhpmevent_val, of_bit_mask);
 }
 
 static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
@@ -445,7 +445,7 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
         of_bit_mask = MHPMEVENT_BIT_OF;
     }
 
-    if (!get_field(*mhpmevent_val, of_bit_mask)) {
+    if (!mask_extract64(*mhpmevent_val, of_bit_mask)) {
         *mhpmevent_val |= of_bit_mask;
         return true;
     }
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index b433bda16d..7898e310e3 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -35,7 +35,7 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
     target_ulong target;
     target_ulong val = env->jvt;
     int xlen = riscv_cpu_xlen(env);
-    uint8_t mode = get_field(val, JVT_MODE);
+    uint8_t mode = mask_extract64(val, JVT_MODE);
     target_ulong base = val & JVT_BASE;
     target_ulong t0;
 
-- 
2.45.2


