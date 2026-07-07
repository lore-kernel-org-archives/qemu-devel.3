Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1EFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVl-0001Jd-1X; Tue, 07 Jul 2026 18:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVj-0001Hj-3c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVg-00047N-1t
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cace91f112so823855ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464203; x=1784069003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+Uo2EB9jLwY0LEkC0O2VfYLiSzWX0HxD0y0hCTws0U=;
 b=RU6tVLs+XzWnh1zZEQNAStKReKTInR3IZUZUaqjn17moDpi2ykq/wCnJRSnDN0GXBc
 INwhHbSixX+woY1ro2p6stCtldTJmr49isLiXcoBtRXEVRgwqmN+PyJkovmqpR3P6rxX
 gArznS7ojnbVr+aDbi/VK4PiNFaCRBHA/JHz+bLzQQQwHROE6124gUIgtVI9n6mdnlgz
 wUZ5+3zPTiiTxgXdt//YJVQPlbvb4GqyuLeOv4PhzPwuEy/8VOUL7gFDt6yHvtxsV7Vg
 5+v4/FDEv09RCy8yJ03u2NQc7AHOLvFoEpVIcE4wSDsssAepvMEudiLlhYFYEcEnJ4t/
 bYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464203; x=1784069003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S+Uo2EB9jLwY0LEkC0O2VfYLiSzWX0HxD0y0hCTws0U=;
 b=V81qpVHski4M0mzvFQi0sHQVmVxg275nF/3IO0xd6ENPXXKDh5N3urbJazdDqGv2w5
 P/uIuw10TFlF/G/jDBvEKzw/9S0yGBS+aYq68ZADlx9lwdME/+/LxX4hvdF6kttPlQxF
 9BYn42JWZj/dIsDHV+KnRZu1/JwnqFroWs+VO7Oy4pM+g5B+gPTNqrw2cJEAttBDIb8p
 KHAG9BCIbb07r5DOPjz8gIXBcPjGC2GEVr1vrG8aZRDuxlZ+TdD92Zseb1Y8XrvcQthw
 J2Zr4A0xGMCvx7nyldWny1cVH/Mgui/IXzNrEIodi84IzfL9TAFmrenqkS4IAhVNxN0G
 rtsw==
X-Gm-Message-State: AOJu0Yxhky35G3E8JfwQfPfFX74IN/H+cvGa9OruXJsdRdoQQuv/qHbB
 JQNQkW8hOgKXgXwMi0lQSR/vPZEpeN+BC5JpsIHy28gCpJlJ42nmI+d7cQKRCsQ/9QM=
X-Gm-Gg: AfdE7cnC8PDtV2sykXfBByB+p10jlg84Zu3Ftk4BOYJeLqZ1KKlajbiKXte9v/SXftj
 LTnRo8YK8wX5QQP2sFjrWXRcFAyNBwhSAWpq8GnjsJUabVWtJJOCK/20KuSKWRLjA3HPu+aX3z5
 X8knmeTDXru6emXBrJThBjXGUYTY1h7lSo1zI3OLtdLO41kPR9/kJTH4xJw+eZR3X7gHb5ribLj
 74nOWma0msG0iZ9mhsfCtErye//r+E1b/KdvOIXzXedFtuMW2zeZKYBEEyOVhei3tZ+f4d4HdBk
 ahX/3A2meW875ZrG/2Axz+Vvx4TX6LCc9YB00bmuHTwnrCrQsgQpzk4hqo8yxrcPI6VSiYzx920
 XSRDK9rdLMq0gYzu5OY1H2KADcM5L+iTqXwF6YylX8sjh+EPLH3uR00trdi5zuZC2kVpMbNwaMO
 uTbdOLMZbfigAu+W+gKvKE3jYQylAnn37It1QZeC3SHhXKICNUKg==
X-Received: by 2002:a17:903:3843:b0:2cb:ea0b:9164 with SMTP id
 d9443c01a7336-2ccbe3feba0mr70429385ad.6.1783464202589; 
 Tue, 07 Jul 2026 15:43:22 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:22 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 06/25] target/arm/kvm-rme: Initialize vCPU
Date: Tue,  7 Jul 2026 16:42:47 -0600
Message-ID: <20260707224306.1202330-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
the PC can also be set, and is ignored at runtime. KVM also accepts a
few system register changes during initial configuration, as returned by
KVM_GET_REG_LIST.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.h      |  3 +++
 target/arm/kvm-rme.c  |  9 ++++++++
 target/arm/kvm-stub.c |  5 ++++
 target/arm/kvm.c      | 54 +++++++++++++++++++++++++++++++++++++++++--
 target/arm/kvm_arm.h  | 10 ++++++++
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03a30afcbed1..c7927036360c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1055,6 +1055,9 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /* Realm Management Extension */
+    bool kvm_rme;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index b86b9d6a25cb..90c1d30ba24c 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -90,3 +90,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
     cgs->ready = true;
     return 0;
 }
+
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    if (!rme_guest) {
+        return;
+    }
+
+    cpu->kvm_rme = true;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index eec1ca3dd2e5..4ab6f08637d1 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -124,3 +124,8 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b609f29c11c6..4c212ed0c337 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2009,6 +2009,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
+    kvm_arm_rme_vcpu_init(cpu);
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
@@ -2163,6 +2165,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* The RME ABI only allows us to set 8 GPRs and the PC */
+    for (i = 0; i < 8; i++) {
+        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2274,7 +2299,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_put_core_regs(cs, errp);
+    if (cpu->kvm_rme) {
+        ret = kvm_arm_rme_put_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_put_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
@@ -2361,6 +2390,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    for (i = 0; i < 8; i++) {
+        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2472,7 +2518,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_get_core_regs(cs, errp);
+    if (cpu->kvm_rme) {
+        ret = kvm_arm_rme_get_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_get_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6d058b0e08a2..12ed1eee18b4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -249,4 +249,14 @@ char *kvm_print_register_name(uint64_t regidx);
  */
 int kvm_arm_rme_init(MachineState *ms, KVMState *s);
 
+/**
+ * kvm_arm_rme_vcpu_init
+ * @cs: the CPU
+ *
+ * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
+ * behave a little differently, for example most of their register state is
+ * hidden from the host.
+ */
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
+
 #endif
-- 
2.43.0


