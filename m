Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3E5C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqex-0001Oo-8y; Fri, 19 Apr 2024 12:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqed-0001Ay-Qq
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-000160-RQ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34665dd7744so1422888f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542389; x=1714147189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwLE1XkqbTWykZyFGjxxFRV6aZ7S9m/Sx/51Il4WLdA=;
 b=rUIjr+5yjfYtv+8Gpl+82atXgLO7jI7FFFfE+zYeJMwQYCEfTE7dsHvyUj4t8Ti4BH
 kI/drmjMnMyvNJqJUiZVNJiA1EKIRTZibxqlaJTC1NyUP/wJBHbnKE+DR+nD3ObqoDOQ
 fPkUxwohD870k+hs7SnSQ1ZNcpWAELrEtgwyyuBaGhoEc1pHskCm5uTyk2gasI5DBZIr
 bzm+4I3mEmusJgSMXHvUv4QGe1cvmkYmgcSCfgcZZvM98Z5xlJArFn2T08mgjn8MqXE5
 O9tzBCJQFvPzo1EGIRczFmh0VEfa+BLcUf3CePIWrqiEC7FcDvZUk/Po33OLiCgzJ+M3
 nnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542389; x=1714147189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwLE1XkqbTWykZyFGjxxFRV6aZ7S9m/Sx/51Il4WLdA=;
 b=h7NJaN2u2PPpxrOFG6EccC0UiE2g3+R4XtjYPJZW1RUJ9b+gxy9OD9ky+zT2CAQBrP
 FGIBaJTLPn3/xpzxDaZSR4NNNlzD6vPVPdPv7ciLfebUSYCYAKNvyg/goPmAFuU2E2QE
 sLLMrw22gLMPh2AwMqQAeXOeoEodmeWHTNeBwX1mbl5xKCd4iTnmj8SAXMhmREm8b6ob
 FM8X4bQqzmQv6WL+a2ZB4Hx7GG3Szi0VnvXK16/+uCEzjP9XfD6bE6DiHPovKHUwyDLW
 tXF+Cyb416wenKGHmKV3a46MUWEAj/cdGx+f1LGXDuWckdkj+I61DSmIgzVbhtHI0sSx
 gFBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmbLFo0ANZhKfMEB+85Y5rJUn1Jy1fkaQJh7031bVTjo+57bp7g/c8aZ7Hpt/+8i/PDOch8pVG15dbj6MB76WE0Fic3C0=
X-Gm-Message-State: AOJu0YweSWcdxuYhlZ3q6QgD7/vUg500aQChrVEWJ22C8c9PZKi29vMB
 GV6++fr68jXJVOuQW7LX6TmWTK04zQR6ow9vohTt0kq5wKKVNnlgPHTiK/o8Vn8=
X-Google-Smtp-Source: AGHT+IHS0L5Lujp82y+sqaO4BTWg9DjNFxI+SKshLzHu9CH18UI8obwKTQQYCL3Od25ds4fcgbtbBg==
X-Received: by 2002:a05:6000:a8c:b0:349:9b7f:8df3 with SMTP id
 dh12-20020a0560000a8c00b003499b7f8df3mr1687174wrb.40.1713542389606; 
 Fri, 19 Apr 2024 08:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 04/22] target/arm/kvm-rme: Initialize realm
Date: Fri, 19 Apr 2024 16:56:52 +0100
Message-ID: <20240419155709.318866-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42f.google.com
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

The machine code calls kvm_arm_rme_vm_type() to get the VM flag and KVM
calls kvm_arm_rme_init() to issue KVM hypercalls:

* create the realm descriptor,
* load images into Realm RAM (in another patch),
* finalize the REC (vCPU) after the registers are reset,
* activate the realm at the end, at which point the realm is sealed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2:
* Use g_assert_not_reached() in stubs
* Init from kvm_arch_init() rather than hw/arm/virt
* Cache rme_guest
---
 target/arm/kvm_arm.h |  16 +++++++
 target/arm/kvm-rme.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     |   7 ++-
 3 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc7..8e2d90c265 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -203,6 +203,8 @@ int kvm_arm_vgic_probe(void);
 void kvm_arm_pmu_init(ARMCPU *cpu);
 void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq);
 
+int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature);
+
 /**
  * kvm_arm_pvtime_init:
  * @cpu: ARMCPU
@@ -214,6 +216,11 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+int kvm_arm_rme_init(MachineState *ms);
+int kvm_arm_rme_vm_type(MachineState *ms);
+
+bool kvm_arm_rme_enabled(void);
+
 #else
 
 /*
@@ -283,6 +290,15 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+static inline int kvm_arm_rme_init(MachineState *ms)
+{
+    g_assert_not_reached();
+}
+
+static inline int kvm_arm_rme_vm_type(MachineState *ms)
+{
+    g_assert_not_reached();
+}
 #endif
 
 #endif
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 960dd75608..23ac2d32d4 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -23,14 +23,115 @@ struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
 };
 
+static RmeGuest *rme_guest;
+
+bool kvm_arm_rme_enabled(void)
+{
+    return !!rme_guest;
+}
+
+static int rme_create_rd(Error **errp)
+{
+    int ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                                KVM_CAP_ARM_RME_CREATE_RD);
+
+    if (ret) {
+        error_setg_errno(errp, -ret, "RME: failed to create Realm Descriptor");
+    }
+    return ret;
+}
+
+static void rme_vm_state_change(void *opaque, bool running, RunState state)
+{
+    int ret;
+    CPUState *cs;
+
+    if (!running) {
+        return;
+    }
+
+    ret = rme_create_rd(&error_abort);
+    if (ret) {
+        return;
+    }
+
+    /*
+     * Now that do_cpu_reset() initialized the boot PC and
+     * kvm_cpu_synchronize_post_reset() registered it, we can finalize the REC.
+     */
+    CPU_FOREACH(cs) {
+        ret = kvm_arm_vcpu_finalize(ARM_CPU(cs), KVM_ARM_VCPU_REC);
+        if (ret) {
+            error_report("RME: failed to finalize vCPU: %s", strerror(-ret));
+            exit(1);
+        }
+    }
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_ACTIVATE_REALM);
+    if (ret) {
+        error_report("RME: failed to activate realm: %s", strerror(-ret));
+        exit(1);
+    }
+}
+
+int kvm_arm_rme_init(MachineState *ms)
+{
+    static Error *rme_mig_blocker;
+    ConfidentialGuestSupport *cgs = ms->cgs;
+
+    if (!rme_guest) {
+        return 0;
+    }
+
+    if (!cgs) {
+        error_report("missing -machine confidential-guest-support parameter");
+        return -EINVAL;
+    }
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_RME)) {
+        return -ENODEV;
+    }
+
+    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
+    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
+
+    /*
+     * The realm activation is done last, when the VM starts, after all images
+     * have been loaded and all vcpus finalized.
+     */
+    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
+
+    cgs->ready = true;
+    return 0;
+}
+
+int kvm_arm_rme_vm_type(MachineState *ms)
+{
+    if (rme_guest) {
+        return KVM_VM_TYPE_ARM_REALM;
+    }
+    return 0;
+}
+
 static void rme_guest_class_init(ObjectClass *oc, void *data)
 {
 }
 
+static void rme_guest_instance_init(Object *obj)
+{
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
+}
+
 static const TypeInfo rme_guest_info = {
     .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
     .name = TYPE_RME_GUEST,
     .instance_size = sizeof(struct RmeGuest),
+    .instance_init = rme_guest_instance_init,
     .class_init = rme_guest_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a5673241e5..b00077c1a5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -93,7 +93,7 @@ static int kvm_arm_vcpu_init(ARMCPU *cpu)
  *
  * Returns: 0 if success else < 0 error code
  */
-static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
+int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 {
     return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_FINALIZE, &feature);
 }
@@ -608,6 +608,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
+    ret = kvm_arm_rme_init(ms);
+    if (ret) {
+        error_report("Failed to enable RME: %s", strerror(-ret));
+    }
+
     return ret;
 }
 
-- 
2.44.0


