Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719F60A263A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=myGnMmng
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7KC-0004lG-Od; Tue, 20 Oct 2026 06:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jm-0004Ho-9L
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JY-0004MZ-L3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso33845715e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493007; x=1793097807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pr/rnTmIAiW1szyi9rDm/oGmteEimjJL3z+DQYflDO4=;
 b=myGnMmngIZSiPfrNJjarnw6dnYxESdoBOH6OmjwuCw6BaiRyTf1/WSTcef+NvCL4d/
 CiM1mJFF/03ExWqpyOxy5tmvFtfnRLLwEgRFhCxDoqi4Qb7LQZFx7FsxWBGgos+u6/dJ
 AAKYtp8d13Hfs1VtgEv36KwVsLsxVfvFvoolczFmj90fpZwxs+mmtsuGCLjIM8J+jTgO
 UoKIarblad2G9jYWMKlsA7nlLs6U7EWkv+6YYO/OZ3fH3DW7i+k2AsIThuhjGRZlJYQ5
 lCdXsa9G7fnWF/YVLBdwuvDSRHAx4xzbu+oMU3HcE5lXzitGHVwg9SoUQ20+wqCn/P7J
 c/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493007; x=1793097807;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pr/rnTmIAiW1szyi9rDm/oGmteEimjJL3z+DQYflDO4=;
 b=Dice9NYjef0zyhWpid3Jpw10BjbrA88PsfkHkNWS02v/KF3uomMrhF/RMgzOin9H2/
 EdxkjXLxRRVlGnE/vd0g63TalmhDFYemLs3VsRGJPIm6eeeGqfWQrgPXbyKNAqnKTrlj
 Rjwjt5WRjm0X8rw1nPTneAbPkaohqC6clDEk0l2NEkguhK8+5ej3pxvgpx2NnIlRFBiF
 /e2Qcqsvqw1GoGGmaqZU5UWo3Oy666CdWQqhbMDdz+QQwu7dah4Nl5ZguiDlIzcGIMn5
 PWM4J0w3Mn64vE6mQW6k6BZTDCz7qjqapkT2L50tzj6jZQROnDxdup4yzo015QQYYUQV
 6Gpw==
X-Gm-Message-State: AFq9FYJY6WRxh5sfDGEcBFeVoS3RRe8QbgJW5SR2ZWor/QfEiOhmtYeQ
 s52CVjZ5KSoUH9981Iz5fSOpS2NZmaHhASSCitVOl2+a8u4HH4held6w6lLBWRRpvt4=
X-Gm-Gg: AYBFou30wcAaGlBadPLkGS9P+2MxiOGjVKF+LhL/2WHmd3XqlMvS+9rN/jotxPWfobq
 t8e77L0qQCdDzMQXAY3FGXX3QgRmJ4+QTHUFA5Sa8Wjw4ohoCmTy33KaDpc/SjGYsxVsja4QmS8
 0F10izbecpzkoxZm1FpnFZ/xwMapDPmMZ6XMbi72qRCO4cEN54sZGmqmIKi0IkfeGphR3/ij5Ll
 hkUnrtSFNSMOPhBMrIlg4j0b0IeWFv0bZ8iTAlEdi/t+p4LnX/0NfAtu/owD4ZwTQ0tIwA+RW/2
 OzdDAPJY5vZDoMaBCZaCyxyBFkglmdnhEmpi3xoDoppkOdJ7K/VGXL6HivwbIQws/9wizA/MGH5
 Y+d5ClR5lg4SB2jGl/47GhQuFr4ImBR+FdnNT+lF1SKLYgdEUiRq+/Vhq/isJK18wb71tx7APJV
 v5paMGtne5Tqz47So1ImRYL6P8ym9YwCDFf4Jnm/B1ppJ4xK5z88Wh6oiRE+XicNaR4vVsE5c=
X-Received: by 2002:a05:600c:8b43:b0:4a1:83f0:7c8a with SMTP id
 5b1f17b1804b1-4a1d75ad072mr215240945e9.1.1792493006718; 
 Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d1e8ebsm57351065e9.3.2026.10.20.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DE6B5FB4A;
 Tue, 20 Oct 2026 11:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Cornelia Huck <cohuck@redhat.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 08/23] accel/kvm: port kvm_arch_pre_run to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:02 +0100
Message-ID: <20261020104320.3686723-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port our first function. As a number of arches don't do anything at
this point they become nops and the call becomes optional.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 11 +++++++++++
 include/system/kvm.h        |  1 -
 target/i386/kvm/kvm_i386.h  |  1 +
 accel/kvm/kvm-all.c         |  7 ++++++-
 accel/tcg/cpu-exec.c        |  2 +-
 target/arm/kvm.c            |  3 ++-
 target/i386/kvm/kvm-cpu.c   |  1 +
 target/i386/kvm/kvm.c       |  2 +-
 target/loongarch/kvm/kvm.c  |  4 ----
 target/ppc/kvm.c            |  4 ----
 target/riscv/kvm/kvm-cpu.c  |  4 ----
 target/s390x/kvm/kvm.c      |  4 ----
 12 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 662d0c553c7..2c04fa5adf5 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -13,10 +13,19 @@
 #include "hw/core/cpu.h"
 #include "accel/accel-cpu-target.h"
 
+struct kvm_run;
+
 /**
  * struct KVMCPUOps - Target-specific per-vCPU operations for KVM
+ *
+ * @pre_run: Optional callback executed immediately prior to entering the
+ *           KVM_RUN ioctl in the vCPU thread loop. Used by architectures
+ *           that need to inject pending events (e.g. x86 NMI/SMI) or verify
+ *           injected exceptions (e.g. ARM external data aborts).
+ *           May be NULL if the target does not require pre-run handling.
  */
 typedef struct KVMCPUOps {
+    void (*pre_run)(CPUState *cpu, struct kvm_run *run);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
@@ -25,6 +34,8 @@ typedef struct KVMCPUOps {
  * struct KVMAccelCPUClass - KVM-specific accelerator CPU class
  *
  * @parent_class: The parent #AccelCPUClass
+ * @cpu_ops: Target-specific KVM operations table. Must be non-NULL when
+ *           KVM acceleration is initialized for the target CPU.
  */
 typedef struct KVMAccelCPUClass {
     AccelCPUClass parent_class;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index d29624034cb..e9d7b86ea4a 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -333,7 +333,6 @@ extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
 
 void kvm_arch_accel_class_init(ObjectClass *oc);
 
-void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run);
 MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run);
 
 int kvm_arch_handle_exit(CPUState *cpu, struct kvm_run *run);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2b653442f4d..218ae8f09ce 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,7 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
+void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db8fba53f33..4dca5467f4a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -55,6 +55,8 @@
 
 #include "hw/core/boards.h"
 #include "system/stats.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 /* This check must be after config-host.h is included */
 #ifdef CONFIG_EVENTFD
@@ -3451,6 +3453,7 @@ out_unref:
 
 int kvm_cpu_exec(CPUState *cpu)
 {
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
     struct kvm_run *run = cpu->kvm_run;
     int ret, run_ret;
 
@@ -3474,7 +3477,9 @@ int kvm_cpu_exec(CPUState *cpu)
             }
         }
 
-        kvm_arch_pre_run(cpu, run);
+        if (ops->pre_run) {
+            ops->pre_run(cpu, run);
+        }
         /* Corresponding store-release is in cpu_exit. */
         if (qatomic_load_acquire(&cpu->exit_request)) {
             trace_kvm_interrupt_exit_request();
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5b4bca5084f..4d2a0aefe89 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -758,7 +758,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
      * read interrupt_request and set exit_request on demand from the
-     * CPU thread; see kvm_arch_pre_run() for example.
+     * CPU thread; see KVMCPUOps::pre_run for example.
      */
     qatomic_store_release(&cpu->exit_request, true);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7a3c957c3a5..4475fd1a9d9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1377,7 +1377,7 @@ static bool kvm_arm_verify_ext_dabt_pending(ARMCPU *cpu)
     return false;
 }
 
-void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
+static void arm_kvm_pre_run(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -2666,6 +2666,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 }
 
 static const KVMCPUOps arm_kvm_cpu_ops = {
+    .pre_run = arm_kvm_pre_run,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9de107a18d5..eab5ab46d45 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -235,6 +235,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 }
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
+    .pre_run = x86_kvm_pre_run,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d71..e9bcda70dac 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5898,7 +5898,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
-void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
+void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4bc08f195ed..b8fb2094062 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1517,10 +1517,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
-void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
-{
-}
-
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
     return MEMTXATTRS_UNSPECIFIED;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8e9328beeb9..17b16e33881 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1336,10 +1336,6 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
     return 0;
 }
 
-void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
-{
-}
-
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
     return MEMTXATTRS_UNSPECIFIED;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b3fa0548c8a..8575e673811 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1640,10 +1640,6 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
-void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
-{
-}
-
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
     return MEMTXATTRS_UNSPECIFIED;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 69e49b7d151..827816e5b98 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -984,10 +984,6 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
     }
 }
 
-void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
-{
-}
-
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
     return MEMTXATTRS_UNSPECIFIED;
-- 
2.47.3


