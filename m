Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CC2FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfn-0005Yi-61; Fri, 06 Mar 2026 10:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfT-0004qf-0h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfQ-0002ol-VV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso85647325e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809238; x=1773414038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k5ddPJjM0MxsfGESCFhraxMnQbyEw+ntSKrCf/tpMXM=;
 b=iX2DMGlhfzPXFxt+6AylaGj0jhZj3l0SbVCz/ApvQT0qTtKQV8xiwcS6e/we5ccnOv
 CcFJmUYi+q5ESSxuZV00qN6t391c7X8tw4Xke4nD6TkUiqnUmtSK6kFR+F9OhzUe4gpG
 Lq0oNzFb2jZiB1wlsg+ujTWelFafMI5eLUOnONODeNvWHV72x1Oz+gbwOI8yl38xnP+y
 OwBBjT5waHCq9YWBLLBopmXXCl2Al42M4CkT4kuCKkbxqaRi0A71r2swmDZPK1upq2jH
 I+C4LKR41wJtO2B9yy7Pqe+SFIRHkDO9A4eim/tbZ3cocOP8yBglFC57wMk+M6JxIbsr
 BoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809238; x=1773414038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k5ddPJjM0MxsfGESCFhraxMnQbyEw+ntSKrCf/tpMXM=;
 b=C4tMYXidTKQKgcogWjR2n292rgWcpUYV4L6SvZbhbCfg5JoHlsJri1VIoVUCtHp94e
 dQNOYNNt8rTgEDrrBp5Sos1Rl8l5w7r5aqijtpbqoFYuWqfrl5OLonj0o70woRUubtKx
 BJPA0i/SjA0UnchzFcjs0yYrisfHIbDiT+ZT4NSEhFvFyoX/Um4ke9kaCtAw0ZmUvkVi
 UlGdjdsRVWzDaFs8W2POShAwrcgcjFbGXU67DvS1wd2HuYb4ZXMlUHA1EhbxNkz9sMMq
 wsjKwX8M9ILuVb+zatTXH/biLDzakaSF8u49tAnFzf7bEri8jKh8OvQsPn8hmOcWx1FB
 9riQ==
X-Gm-Message-State: AOJu0YyP6DVcN/BtlU2wj82skMwmikIEXu6Yfv1MLhPZDQd596uuwoZY
 9n7TO4ocpgGi8PNiXS8twi7xanRZ9jWPVVpqGAuGtAhKdbzpTKewz5oExrwduxiB5cAmpgSP05C
 zPhv6
X-Gm-Gg: ATEYQzwT+XC2Df5A194Dz1EuqiGz2kUYNrRRop7qUBdeechiqSZO7dm6VvEy2MM9pAO
 5im0GGOwCG6saJiQhN2XIXIoGIdebvTX+v2uGp3/+icX5g9VO5smDvliKLo4O9+SzItRDnbvbBu
 wVH89tfIh7yp7QW7qgHOC7zQfcfjSWMFvUs5S+NPFkO+LxdhZ/5cCQpTImb7Zk8zCh/HVMlGu59
 +lQLEZ1Q28x+q+k28KGBPy0GUi/V82hFn/mH4APkOCmhtNStexIL/oUxOulpj4bCbRqsPwfr9zs
 PyROdgYezkxvQBiBNo2TmKSF4fsbr5sMTPwqXaaMzZlEvPN+zF7iM+Lpx0MTvDGLz/xQiY9IRs9
 QlmqvzA/0+RBrfbWIe/874/X0M0+BkFM+UQfKK71gDh0jEz45Mji7nij9vhanXVohyRWK8YGa9h
 6ykXyE+0y+LtoCtgrXIOEzOAzPEsI107fzOtrZEFih3C6Bf1B5mPpg9LwFVpJv/17dvj9EQbHir
 33lZQc4DL65IejYcQ7PyjMpcgliC78=
X-Received: by 2002:a05:600c:a12:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-485269648fcmr35579955e9.23.1772809237765; 
 Fri, 06 Mar 2026 07:00:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/49] hvf: sync registers used at EL2
Date: Fri,  6 Mar 2026 14:59:36 +0000
Message-ID: <20260306145939.2162189-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

In addition, sync the state of the EL1 physical timer when the vGIC is used, even
if running at EL1. However, no OS running at EL1 is expected to use those registers.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260306130107.35359-15-mohamed@unpredictable.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 55 ++++++++++++++++++++++++++++++++-----
 target/arm/hvf/sysreg.c.inc | 44 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f8d5a4f596..6e41789ba8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -473,31 +473,61 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 #define DEF_SYSREG_15_02(...)
 
+#define DEF_SYSREG_EL2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#define DEF_SYSREG_VGIC(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
 #include "sysreg.c.inc"
 
 #undef DEF_SYSREG
 #undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
 #define DEF_SYSREG_15_02(...)
+#define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 = true},
+#define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic = true},
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, true, true},
 
-static const hv_sys_reg_t hvf_sreg_list[] = {
+struct hvf_sreg {
+    hv_sys_reg_t sreg;
+    bool vgic;
+    bool el2;
+};
+
+static struct hvf_sreg hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
 #undef DEF_SYSREG
 #undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
 
 #define DEF_SYSREG(...)
-#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
+#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) {HVF_ID},
+#define DEF_SYSREG_EL2(...)
+#define DEF_SYSREG_VGIC(...)
+#define DEF_SYSREG_VGIC_EL2(...)
 
 API_AVAILABLE(macos(15.2))
-static const hv_sys_reg_t hvf_sreg_list_sme2[] = {
+static struct hvf_sreg hvf_sreg_list_sme2[] = {
 #include "sysreg.c.inc"
 };
 
 #undef DEF_SYSREG
 #undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
 
 /*
  * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which are
@@ -1308,6 +1338,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 #define DEF_SYSREG_15_02(HVF_ID, ...) \
         g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 #define DEF_SYSREG(...)
+#define DEF_SYSREG_EL2(...)
+#define DEF_SYSREG_VGIC(...)
+#define DEF_SYSREG_VGIC_EL2(...)
 
 #include "sysreg.c.inc"
 
@@ -1334,12 +1367,20 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
     /* Populate cp list for all known sysregs */
-    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
-        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
+    for (i = 0; i < sregs_match_len; i++) {
+        hv_sys_reg_t hvf_id = hvf_sreg_list[i].sreg;
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
         const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
+        if (hvf_sreg_list[i].vgic && !hvf_irqchip_in_kernel()) {
+            continue;
+        }
+
+        if (hvf_sreg_list[i].el2 && !hvf_nested_virt_enabled()) {
+            continue;
+        }
+
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
@@ -1348,7 +1389,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     if (__builtin_available(macOS 15.2, *)) {
         if (hvf_arm_sme2_supported()) {
             for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
-                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
+                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
                 uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
                 uint32_t key = kvm_to_cpreg_id(kvm_id);
                 const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 7a2f880f78..c11dbf274e 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -153,3 +153,47 @@ DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
 DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
 DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+/*
+ * Block these because of the same issue as virtual counters in
+ * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
+ *
+ * DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CTL_EL0, 3, 3, 14, 2, 1)
+ * DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CVAL_EL0, 3, 3, 14, 2, 2)
+ */
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_TVAL_EL0, 3, 3, 14, 2, 0)
+#endif
+
+/*
+ * Also block these because of the same issue as virtual counters in
+ * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
+ *
+ * DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CVAL_EL2, 3, 4, 14, 2, 2)
+ * DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CTL_EL2, 3, 4, 14, 2, 1)
+ */
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_TVAL_EL2, 3, 4, 14, 2, 0)
+#endif
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTVOFF_EL2, 3, 4, 14, 0, 3)
+
+DEF_SYSREG_EL2(HV_SYS_REG_CPTR_EL2, 3, 4, 1, 1, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_ELR_EL2, 3, 4, 4, 0, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_ESR_EL2, 3, 4, 5, 2, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_FAR_EL2, 3, 4, 6, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_HCR_EL2, 3, 4, 1, 1, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_HPFAR_EL2, 3, 4, 6, 0, 4)
+DEF_SYSREG_EL2(HV_SYS_REG_MAIR_EL2, 3, 4, 10, 2, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_MDCR_EL2, 3, 4, 1, 1, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_SCTLR_EL2, 3, 4, 1, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_SPSR_EL2, 3, 4, 4, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_SP_EL2, 3, 6, 4, 1, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_TCR_EL2, 3, 4, 2, 0, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_TPIDR_EL2, 3, 4, 13, 0, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_TTBR0_EL2, 3, 4, 2, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_TTBR1_EL2, 3, 4, 2, 0, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_VBAR_EL2, 3, 4, 12, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_VMPIDR_EL2, 3, 4, 0, 0, 5)
+DEF_SYSREG_EL2(HV_SYS_REG_VPIDR_EL2, 3, 4, 0, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_VTCR_EL2, 3, 4, 2, 1, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_VTTBR_EL2, 3, 4, 2, 1, 0)
-- 
2.43.0


