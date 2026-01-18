Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32C3C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaoX-0003ld-6L; Sun, 18 Jan 2026 17:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaoR-0003hY-Qd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 16:59:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaoQ-0008JD-87
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 16:59:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso23934415e9.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 13:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773596; x=1769378396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Z2dvTrseTxOg307MHO4uCzaKs+nhbHFu0/LcG6p+m8=;
 b=nIs8G4BOFeNEji5yG/zmAFO1ZTRDnunlYTjUBweqI/RGt6mhtoFfBP1e8H2/dt4Tzi
 NjNH86mGjfBM257Yz6fAumU890T2xlSRSmq2cdYwOQiyEFqW5oygldsjovjFHBL47SrT
 XWKVQTGZ6tDeJlo+3Cr6WlLQUITAeZH23bwdyVq3waQ+0V2gxUoyoAvcZzhnmsi9IgHl
 YurGXrOnt9nDzBITMfyPYHO25GBkdmeSxDu0GgxFAWPB/j8NsnPrg3RzZLGT/CqaNIO0
 DcYo/EmUU1yaSO4uGF4BE5eI7YlL0BDmAgW+8H8bd2jY6meMOSmT1AMwIEpdbuh0wrsb
 uJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773596; x=1769378396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Z2dvTrseTxOg307MHO4uCzaKs+nhbHFu0/LcG6p+m8=;
 b=afVPMCNu0ExcEw4/YncS7l+6NPFnUO0eP71OKp+/47EAYAOh+zcAcosdpDKDk/T0Ii
 pA/yxDnUMMrB3YiUHge4w1KMRnNM2WW8vVy4nmXyzsunaNPw2ZLqKLpoWFZtXA29Cl3f
 WESjWFo3+EUJm5pS1j8M0pdBO6/9zy8TXaAR03EmpydoTu7Ht0bA9DmoAo8vjZLDu03l
 iR1bJknz9U1w2lOnQ1vrLE6u7WGIbNNJa8fVqLUYNcOohrtRvL5JE9x8O7Ioef3wdoKg
 jscS5nzwAqIcEbyIjnqtwavN3VwEdzhF5wzD6DSWd6R8+0buoimo+u7myJ/hpuJSCQrh
 nUSQ==
X-Gm-Message-State: AOJu0YxnZOqDbTlD9zFG0irqQ7nV6/+4QJN/U9X058FsZiIxifMDfM9y
 gaxumZRxJreneHZuJTuJCiK+GFFckT/5gG6AtJ+9/9hJJz7p5MO/UR7KoeRX+QLMEdg7dVTsEUp
 teN2ss3o=
X-Gm-Gg: AY/fxX4rRdbjapjhhyjd7pf/kGv2IR09fglg2jlgge3LRGCbGkS7lJDSCcpmJYwpOca
 gRQtwCtOH57G7Nkug0luTbFdqMDir5FXDl/MBiUOZry8dv6s+HbquavgY3Gujia0/eU/24wBBzw
 6gRDUoT2QtIMwY+mKEjoChbK/w3e54zaxLQ4qt1A2S1wh8VWr8lLX7d0VGDPy1P7YUeKHvvAOC5
 Q/Q0CCbWbTnCsfLuaqwMsDBHUracn4TfJolf1tLPO3bmufZFFi4ht7GgM94n1jVGDml7XfrJzp0
 UBBQS8qTFrWoNC9QkUb7OryI0Mb2xuviPNToCkkj2xE+2nGipiok9OVj+pYy3knD8PPjw2kUg3K
 3JlLdKGcI+GCiyP0IL1Nzt838KDyaf3Z3WxeOCU8L0vcfi9/c8+1d1uwQ5trIRoaGkFxR8eU5+Q
 cnb0DJVsMV612hI2AQVU89vOYp9yWNx0N7aSKGYQ0gGn3Zo5WTxfNYyH6yTMUM
X-Received: by 2002:a05:600c:b93:b0:480:1db1:b44d with SMTP id
 5b1f17b1804b1-4801e34cab5mr128428675e9.27.1768773596257; 
 Sun, 18 Jan 2026 13:59:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c9cbcsm158555475e9.12.2026.01.18.13.59.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 13:59:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 1/2] target/arm/hvf: Move hvf_sysreg_[read,
 write]_cp() functions around
Date: Sun, 18 Jan 2026 22:59:44 +0100
Message-ID: <20260118215945.46693-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118215945.46693-1-philmd@linaro.org>
References: <20260118215945.46693-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Next commit will use these functions prototype earlier. Rather
than forward-declaring them, move them around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 142 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e4c0d936f1f..fcb7fa3b30c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -423,6 +423,77 @@ static const hv_sys_reg_t hvf_sreg_list[] = {
 
 #undef DEF_SYSREG
 
+static uint32_t hvf_reg2cp_reg(uint32_t reg)
+{
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
+                              (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
+                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
+                              (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
+}
+
+static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
+                               uint32_t reg, uint64_t *val)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const ARMCPRegInfo *ri;
+
+    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
+    if (ri) {
+        if (!cp_access_ok(1, ri, true)) {
+            return false;
+        }
+        if (ri->accessfn) {
+            if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
+                return false;
+            }
+        }
+        if (ri->type & ARM_CP_CONST) {
+            *val = ri->resetvalue;
+        } else if (ri->readfn) {
+            *val = ri->readfn(env, ri);
+        } else {
+            *val = raw_read(env, ri);
+        }
+        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
+        return true;
+    }
+
+    return false;
+}
+
+static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
+                                uint32_t reg, uint64_t val)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const ARMCPRegInfo *ri;
+
+    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
+
+    if (ri) {
+        if (!cp_access_ok(1, ri, false)) {
+            return false;
+        }
+        if (ri->accessfn) {
+            if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
+                return false;
+            }
+        }
+        if (ri->writefn) {
+            ri->writefn(env, ri, val);
+        } else {
+            raw_write(env, ri, val);
+        }
+
+        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
+        return true;
+    }
+
+    return false;
+}
+
 int hvf_arch_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1161,46 +1232,6 @@ static bool is_id_sysreg(uint32_t reg)
            SYSREG_CRM(reg) < 8;
 }
 
-static uint32_t hvf_reg2cp_reg(uint32_t reg)
-{
-    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
-                              (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
-                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
-                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
-                              (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
-}
-
-static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
-                               uint32_t reg, uint64_t *val)
-{
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
-    const ARMCPRegInfo *ri;
-
-    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
-    if (ri) {
-        if (!cp_access_ok(1, ri, true)) {
-            return false;
-        }
-        if (ri->accessfn) {
-            if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
-                return false;
-            }
-        }
-        if (ri->type & ARM_CP_CONST) {
-            *val = ri->resetvalue;
-        } else if (ri->readfn) {
-            *val = ri->readfn(env, ri);
-        } else {
-            *val = raw_read(env, ri);
-        }
-        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
-        return true;
-    }
-
-    return false;
-}
-
 static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1454,37 +1485,6 @@ static void pmswinc_write(CPUARMState *env, uint64_t value)
     }
 }
 
-static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
-                                uint32_t reg, uint64_t val)
-{
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
-    const ARMCPRegInfo *ri;
-
-    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
-
-    if (ri) {
-        if (!cp_access_ok(1, ri, false)) {
-            return false;
-        }
-        if (ri->accessfn) {
-            if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
-                return false;
-            }
-        }
-        if (ri->writefn) {
-            ri->writefn(env, ri, val);
-        } else {
-            raw_write(env, ri, val);
-        }
-
-        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
-        return true;
-    }
-
-    return false;
-}
-
 static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.52.0


