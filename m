Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E2DC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqfQ-0001mx-TG; Fri, 19 Apr 2024 12:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeg-0001Ek-CV
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00016e-RT
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so1148552f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542393; x=1714147193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7l7h8u/bxo15dj8FUkHA8n7B20eh8IiyRKSK0v2thnY=;
 b=dD8qbkxUUVPVlmjyuWo8KvMg+WF5QWoYulRtcCpD8x3a5e1ODOh4/0C/+x/bJnkzyI
 i7EjPcp8GJKJEUuPgJqiWd3IzvXdgsteFWX/v9EZUiDoQ+tZKYp0rSUU1wvZ/T93kCdE
 P1jkTh+NTIfb0bu0ieku4PNez0M0FEOvmf2ie3t2FBC3M7Eo/pFUwUZ/qNe++hwe/MYl
 7rvhsQ6C0d3X6AL08+tOs3Fc8mHZB+2eB3kfSdsk6d0Sa+scgkyZn4yqesbwIB9jyHAg
 5OCBhbXmCCmI0V/xtEsUp7hYw1mVEiAxq8pGtsGuycxrpYV2IbkQ1zDV/oortL3S7AuZ
 h2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542393; x=1714147193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7l7h8u/bxo15dj8FUkHA8n7B20eh8IiyRKSK0v2thnY=;
 b=bmJutcaZB+f6DZdET85Wy7GfKCyEIwjJYJUTys0y/khj1Wfal7zPoRzYxGJNBAKP34
 NGgSVHVVpIUYa6d+d7NfBm5/uajCgpo7yLULgm8t5TQMqGrNudn3YuZzCrxArgvCg+Aa
 Q+zPSpdyD+uqFXL5toxNhZtrJxQrOm3TtJMo+Dkg+KpIZH3zvjxFnn9dg5haxui8Sgqp
 I4nq3fD8OtBbclCQ56BzOt+wVk8c8mntNgSzM38Rchn/IrG8doIIj3zpkMDhPvzVl90Z
 +hkCg/2/Kx+dMC5TmFiA7pqJRQXe7m25ZreC1Uj+1L7HuQ6m+A3sgQ2lS7Tn+wBx9cti
 XsJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfujoUqKgLy/ZmW1tIvtHbKNRuWAmhLyelMSIpWYv5osWayUbLjufEu4kpK5ucTMd2CwFw5hxDQHajJAwjTmvZffnyta4=
X-Gm-Message-State: AOJu0Yx77/uZjqy1x/igfAmqKiqt67jMQi6kA6hDZsBbSJw/8m0zXzMK
 ouUn9bPPoXbNa/VEyYbQbkc4hawdhXy/XpWKt8ZOVLwUD0JtlRQ4Lzpa2XDy6HU=
X-Google-Smtp-Source: AGHT+IF860s44i+iY0UVmGVcOh/CDrs78uYJvS8fck2EA3pOZTiNLQ3UAvR3r73qt0LuoujRtxz5RA==
X-Received: by 2002:a05:6000:4022:b0:34a:5d59:5501 with SMTP id
 cp34-20020a056000402200b0034a5d595501mr2062192wrb.4.1713542392891; 
 Fri, 19 Apr 2024 08:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:52 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 09/22] target/arm/kvm-rme: Initialize vCPU
Date: Fri, 19 Apr 2024 16:56:57 +0100
Message-ID: <20240419155709.318866-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x435.google.com
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

The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
the PC can also be set, and is ignored at runtime. KVM also accepts a
few system register changes during initial configuration, as returned by
KVM_GET_REG_LIST.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: only do the GP regs, since they are sync'd explicitly. Other
  registers use the existing reglist facility.
---
 target/arm/cpu.h     |  3 +++
 target/arm/kvm_arm.h |  1 +
 target/arm/kvm-rme.c | 10 ++++++++
 target/arm/kvm.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc0c84873f..d3ff1b4a31 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -945,6 +945,9 @@ struct ArchCPU {
     OnOffAuto kvm_steal_time;
 #endif /* CONFIG_KVM */
 
+    /* Realm Management Extension */
+    bool kvm_rme;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8e2d90c265..47777386b0 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -220,6 +220,7 @@ int kvm_arm_rme_init(MachineState *ms);
 int kvm_arm_rme_vm_type(MachineState *ms);
 
 bool kvm_arm_rme_enabled(void);
+int kvm_arm_rme_vcpu_init(CPUState *cs);
 
 #else
 
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 23ac2d32d4..aa9c3b5551 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -106,6 +106,16 @@ int kvm_arm_rme_init(MachineState *ms)
     return 0;
 }
 
+int kvm_arm_rme_vcpu_init(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    if (rme_guest) {
+        cpu->kvm_rme = true;
+    }
+    return 0;
+}
+
 int kvm_arm_rme_vm_type(MachineState *ms)
 {
     if (rme_guest) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3504276822..3a2233ec73 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1920,6 +1920,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_arm_rme_vcpu_init(cs);
+    if (ret) {
+        return ret;
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
@@ -2056,6 +2061,35 @@ static int kvm_arch_put_sve(CPUState *cs)
     return 0;
 }
 
+static int kvm_arm_rme_put_core_regs(CPUState *cs)
+{
+    int i, ret;
+    struct kvm_one_reg reg;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /*
+     * The RME ABI only allows us to set 8 GPRs and the PC
+     */
+    for (i = 0; i < 8; i++) {
+        reg.id = AARCH64_CORE_REG(regs.regs[i]);
+        reg.addr = (uintptr_t) &env->xregs[i];
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    reg.id = AARCH64_CORE_REG(regs.pc);
+    reg.addr = (uintptr_t) &env->pc;
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_arm_put_core_regs(CPUState *cs, int level)
 {
     uint64_t val;
@@ -2066,6 +2100,10 @@ static int kvm_arm_put_core_regs(CPUState *cs, int level)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+    if (cpu->kvm_rme) {
+        return kvm_arm_rme_put_core_regs(cs);
+    }
+
     /* If we are in AArch32 mode then we need to copy the AArch32 regs to the
      * AArch64 registers before pushing them out to 64-bit KVM.
      */
@@ -2253,6 +2291,25 @@ static int kvm_arch_get_sve(CPUState *cs)
     return 0;
 }
 
+static int kvm_arm_rme_get_core_regs(CPUState *cs)
+{
+    int i, ret;
+    struct kvm_one_reg reg;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    for (i = 0; i < 8; i++) {
+        reg.id = AARCH64_CORE_REG(regs.regs[i]);
+        reg.addr = (uintptr_t) &env->xregs[i];
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_arm_get_core_regs(CPUState *cs)
 {
     uint64_t val;
@@ -2263,6 +2320,10 @@ static int kvm_arm_get_core_regs(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+    if (cpu->kvm_rme) {
+        return kvm_arm_rme_get_core_regs(cs);
+    }
+
     for (i = 0; i < 31; i++) {
         ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
                               &env->xregs[i]);
-- 
2.44.0


