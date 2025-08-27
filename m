Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F40CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4cl-0004zz-Cx; Tue, 26 Aug 2025 21:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cU-0004Qg-Lt
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cH-0007Jx-5Q
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:33 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-323267872f3so4976055a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256748; x=1756861548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSe8riRjhb8O3kX08ti8qa14kSiIJuoOb2wA1l/P/pk=;
 b=znDACpFXCAMxv5DzqX86DZhnao1GjF6A7WeRKoV90I2Vskk3A1DELyufIb8sSYa4ta
 xw06VdUr/sDqFbySdAruz++qqtj/QYqQMo1arNdcIXNqTXAlre4gGl1c9+0n8apf70Q1
 J8+P30sXGRRFXGyad3+a2eGlREsFec0+0TDuQAm05I9d+6hy8UYpdv6JiQTH+inrjEwF
 UQ2O2COiEVCP4QALvFwj4Xx1BJbLDE5AZmqSBZmng/rPqY367m4E6nFybmwPo2g9+KxQ
 NqnLo/cPqDYo3lw2CtuUGf9meW/WKvITpFmaEwpgmd/Uj3YDemOTlcJJHe4j4FQhcQXZ
 eeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256748; x=1756861548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSe8riRjhb8O3kX08ti8qa14kSiIJuoOb2wA1l/P/pk=;
 b=kjmaABR7RRRHQ60fF/0M8Ze+z2sY1vqxCTnGNjEqE4iIkuPTMCcTzLWmTHH5oVaU+V
 l93+WqEkoXNolZjA23dL+eDXh1Rr7m9X1cvlwcxJ3rwCH5trfRCxmI/wSeyJfWOjRA2F
 YGOiEH32adCxr5ZI6mHmXsmnfNjWq5kURqH4hJF9f42LXvoLSCassHWFj0Y2rkisLgtT
 CTVClspa+KXDdnyWl4mmwSTrZQzMJLIeWTe0sImo72o6xduSzTJVn/QKX7E62zDxiXgG
 peIKBe7ENYAmjjBOibgcZGs8rZBQRfgjLyC4gq2BlKyVs2hHSHCtwSCYoXTf6cPegb2B
 0xEg==
X-Gm-Message-State: AOJu0YxAv6eHotNyG6i5S1yG52tvikDpIcQEHXXfrbkOJ/3cZdQJajHv
 BCrtJ6Lyuv6dWme+6j2/pJv+mC0HenLrt2Sigl+H2RmscPyzyWYFgFDtUimsDCWUjIPtK+jb6u8
 WC+xEPdE=
X-Gm-Gg: ASbGncuvfvswmHcz+wzGEN9j4B64bROuTH5hZYv/bQUdoit0VVYKPYw+jXwES33EmCo
 t3sODpiCWLj4enBDC9+VjRi3tjumj3Cg1ISP3bvnYHaHZwNQtSVjLyOfw/e/VzSHlG6YId+ARr7
 txhkAh0A8xG0g0nI0wNYWpLeBgq/pWb9jSjdVZao42mVJyvuSjG4PH92cpVD7Rkb8nLWkStkSqd
 sUzNI+X1LE7SYgpG4oMUYD6TSyk449RWMdKSrpnDkMT6PtBciK/4tpotHtRDvciTtS5AEJB0g8B
 GEOBFfBS20C2Em/pG7QtGJNr1dqueQ/Dy0lNnEjJ3e2UDOeDEcI+QTON9REeXv9BHgpgqQig95F
 QjwzW9dSs0szC3QFhHyxTh7a9FTiUG/aEE7sS
X-Google-Smtp-Source: AGHT+IFA5oZPxNUGizV7wFeIpe/aYobhUrWo8IuE1XqMukiwfiDEPQpgcf/0sgIX4oYI4d63JmXxOQ==
X-Received: by 2002:a17:90a:e707:b0:31f:150:e045 with SMTP id
 98e67ed59e1d1-32515ed147emr22149559a91.32.1756256747890; 
 Tue, 26 Aug 2025 18:05:47 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/61] target/arm/hvf: Replace hvf_sreg_match with
 hvf_sreg_list
Date: Wed, 27 Aug 2025 11:03:57 +1000
Message-ID: <20250827010453.4059782-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Change hvf_get_registers and hvf_put_registers to iterate over
cpregs_indexes instead of hvf_sreg_match.

This lets us drop the cp_idx member of hvf_sreg_match, which leaves
only one member in the struct.  Replace the struct with a const array.
Instead of int, use the proper enum type: hv_sys_reg_t.
Rename from hvf_sreg_match to hvf_sreg_list because there is no
longer any matching going on.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 45 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fcfa9a999..37d8f795eb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -394,11 +394,6 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
 };
 
-struct hvf_sreg_match {
-    int reg;
-    uint32_t cp_idx;
-};
-
 /*
  * QEMU uses KVM system register ids in the migration format.
  * Conveniently, HVF uses the same encoding of the op* and cr* parameters
@@ -419,9 +414,9 @@ struct hvf_sreg_match {
 
 #undef DEF_SYSREG
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  { HVF_ID },
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
 
-static struct hvf_sreg_match hvf_sreg_match[] = {
+static const hv_sys_reg_t hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
@@ -434,7 +429,7 @@ int hvf_get_registers(CPUState *cpu)
     hv_return_t ret;
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
-    int i;
+    int i, n;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
@@ -463,13 +458,9 @@ int hvf_get_registers(CPUState *cpu)
     assert_hvf_ok(ret);
     pstate_write(env, val);
 
-    for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
-        int hvf_id = hvf_sreg_match[i].reg;
-        uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-
-        if (hvf_sreg_match[i].cp_idx == -1) {
-            continue;
-        }
+    for (i = 0, n = arm_cpu->cpreg_array_len; i < n; i++) {
+        uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
+        int hvf_id = KVMID_TO_HVF(kvm_id);
 
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
@@ -553,7 +544,7 @@ int hvf_get_registers(CPUState *cpu)
 
                 val = read_raw_cp_reg(env, ri);
 
-                arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
+                arm_cpu->cpreg_values[i] = val;
                 continue;
             }
             }
@@ -562,7 +553,7 @@ int hvf_get_registers(CPUState *cpu)
         ret = hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_id, &val);
         assert_hvf_ok(ret);
 
-        arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
+        arm_cpu->cpreg_values[i] = val;
     }
     assert(write_list_to_cpustate(arm_cpu));
 
@@ -578,7 +569,7 @@ int hvf_put_registers(CPUState *cpu)
     hv_return_t ret;
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
-    int i;
+    int i, n;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -605,12 +596,9 @@ int hvf_put_registers(CPUState *cpu)
     aarch64_save_sp(env, arm_current_el(env));
 
     assert(write_cpustate_to_list(arm_cpu, false));
-    for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
-        int hvf_id = hvf_sreg_match[i].reg;
-
-        if (hvf_sreg_match[i].cp_idx == -1) {
-            continue;
-        }
+    for (i = 0, n = arm_cpu->cpreg_array_len; i < n; i++) {
+        uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
+        int hvf_id = KVMID_TO_HVF(kvm_id);
 
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
@@ -688,7 +676,7 @@ int hvf_put_registers(CPUState *cpu)
             }
         }
 
-        val = arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx];
+        val = arm_cpu->cpreg_values[i];
         ret = hv_vcpu_set_sys_reg(cpu->accel->fd, hvf_id, val);
         assert_hvf_ok(ret);
     }
@@ -899,7 +887,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
-    uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_match);
+    uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_list);
     uint32_t sregs_cnt = 0;
     uint64_t pfr;
     hv_return_t ret;
@@ -924,17 +912,14 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* Populate cp list for all known sysregs */
     for (i = 0; i < sregs_match_len; i++) {
-        int hvf_id = hvf_sreg_match[i].reg;
+        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
         const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
-            hvf_sreg_match[i].cp_idx = sregs_cnt;
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
-        } else {
-            hvf_sreg_match[i].cp_idx = -1;
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-- 
2.43.0


