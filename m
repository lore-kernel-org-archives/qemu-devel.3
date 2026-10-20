Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E7606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sx2SUMg9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7K9-0004g9-3W; Tue, 20 Oct 2026 06:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jk-0004HF-IC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JY-0004M8-7C
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so917722f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493006; x=1793097806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XaCIspnOiGUcI2BoHO8g5A8hP2lh454sdkCiT2j/ODo=;
 b=Sx2SUMg95c/MQuCE2y3KSOn1ySYbwFIHLcQAJP89Zs7MlH4aV6cycUrGnB3E8Wfwaj
 GHcVS2ltquv+xz8iLB6IcHs29nw6Aq9/6owebnMzEJSBuN+aLRWqgj6v6OAmXltuM/1s
 oYQSp2retdaHkSfqANykQftu58GJe1bcc+hVZ+6SjQYZ7RvbcTUQj4NSv1vOjZjoyka4
 1WsHkx+lQi8IDe91wFaJ2DIp7LV/BxYjk7vIkoNMQ+h8rGOSnkKTIgepMK1Q/qt+FgSl
 F6RI3PRM7n5wLd44Vkzbg3P82KLU7E1uxwRiizTE0OnWb++hKac1WayzsWmXNRjpo2Zp
 ooxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493006; x=1793097806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XaCIspnOiGUcI2BoHO8g5A8hP2lh454sdkCiT2j/ODo=;
 b=detaGck5l/2pgtI0LqJSthaSY0tQttBIsDDMI2SKYfCITO1EnymUc26fVilIImj3eG
 Ef8TxIu+WFrPABvxuDryyUcK0SA2WiSKUGF1ZwVGXn7GZqcchdt9s1GpQTw+gIiKY3f5
 fPPjN7jaVMkCbI77ZIBgpsAra9po39KcfDjh84IsWfIoUZenoLPwNhGFoEltM+ZPvOyH
 FLoSGwX3uj4mzfsq+TM/NoEntokk/XaKbkeHDgc9SqH3BZKoFwKLkzPJDVfCT6xb11u6
 VXm7d2qQsu7QgLkHs+cqMsQUvLwoLlnk2W0vg5m1/4zrwph///RMVuxMHchS3cyak5iV
 kn7w==
X-Gm-Message-State: AFq9FYINBx4HEJIOZKEWR+dm9FBfQs/ReL0oCkp0p5xAmc8lABUbqDVl
 foBKV9zBJINbL7E0QkRSCA3VlXg+kQM7SIVuiJskDL0ndycWSx6NeQu+bYjBbiVUrsI=
X-Gm-Gg: AYBFou2KDu2lA9Du55T6J2oXuL++jQek5Gxn7JFTeVgvAfqqQ7w3KaZVk9ou85zegfr
 /XQcCNjQM8ScZ6XNws7E/v/1kUEWpk9KArET8GbKqLgVbAWLlagjGkom9x3TElwQa3ap36xw2k8
 LG1TNEiFulR9A9vG0tsQCI7H465owCBCJ+UV1EcsgvUnCuhYds67nMnyx/uibW3wpW/et4Zqmma
 xfUJL3sEbshyD2OTUZPgkl4WGhSKp8xrUSm+1XU5gsdIRmK+heEZx/1cMOa3e948MDnYjBmHZYM
 lszm4il4L7XfgIadpgEISSM7r56eDNGSf4oBpv+UtcEAkJIlRa1NGeLV4gHwo0PWlCxOy+GowCE
 KDblljoyXm18v5dLc8RGr+s8ljKWq+4+/UfqazZHeZipBdJDnhy3sBuvw9xjqbF5waeskNWg4iy
 i8jt0YHmnlZKklFCfVP7K0HHucgL5Rs2/8uD7RddIwBuYxuglDuM5gd94ryzFyBnZd43qLG0j8g
 NWsoLzs
X-Received: by 2002:adf:e001:0:10b0:48d:f876:f370 with SMTP id
 ffacd0b85a97d-48e1bdf80a0mr4553512f8f.48.1792493006379; 
 Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm5176611f8f.35.2026.10.20.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 871EE5FB54;
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
Subject: [PATCH 09/23] accel/kvm: port kvm_arch_post_run to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:03 +0100
Message-ID: <20261020104320.3686723-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Again not all arches do something for this so default to set
MEMTXATTRS_UNSPECIFIED for any potential MMIO we might handle next.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 8 ++++++++
 include/system/kvm.h        | 2 --
 target/i386/kvm/kvm_i386.h  | 1 +
 accel/kvm/kvm-all.c         | 6 +++++-
 target/arm/kvm.c            | 3 ++-
 target/i386/kvm/kvm-cpu.c   | 1 +
 target/i386/kvm/kvm.c       | 2 +-
 target/loongarch/kvm/kvm.c  | 5 -----
 target/ppc/kvm.c            | 5 -----
 target/riscv/kvm/kvm-cpu.c  | 5 -----
 target/s390x/kvm/kvm.c      | 5 -----
 11 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 2c04fa5adf5..e74081eb133 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -23,9 +23,17 @@ struct kvm_run;
  *           that need to inject pending events (e.g. x86 NMI/SMI) or verify
  *           injected exceptions (e.g. ARM external data aborts).
  *           May be NULL if the target does not require pre-run handling.
+ * @post_run: Optional callback executed immediately after the KVM_RUN ioctl
+ *            returns in the vCPU thread loop. Used by architectures to
+ *            inspect or process hardware registers/flags (e.g. x86 APIC/TPR
+ *            or ARM timer interrupt synchronization) and return the
+ *            #MemTxAttrs to use for handling MMIO exits.
+ *            May be NULL if the target does not require post-run handling,
+ *            in which case MEMTXATTRS_UNSPECIFIED is assumed.
  */
 typedef struct KVMCPUOps {
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
+    MemTxAttrs (*post_run)(CPUState *cpu, struct kvm_run *run);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index e9d7b86ea4a..82785d37600 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -333,8 +333,6 @@ extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
 
 void kvm_arch_accel_class_init(ObjectClass *oc);
 
-MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run);
-
 int kvm_arch_handle_exit(CPUState *cpu, struct kvm_run *run);
 
 int kvm_arch_process_async_events(CPUState *cpu);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 218ae8f09ce..6fb1da6a40c 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -34,6 +34,7 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
+MemTxAttrs x86_kvm_post_run(CPUState *cpu, struct kvm_run *run);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4dca5467f4a..41229774068 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3500,7 +3500,11 @@ int kvm_cpu_exec(CPUState *cpu)
          * as true, cpu->exit_request will always read as true.
          */
 
-        attrs = kvm_arch_post_run(cpu, run);
+        if (ops->post_run) {
+            attrs = ops->post_run(cpu, run);
+        } else {
+            attrs = MEMTXATTRS_UNSPECIFIED;
+        }
 
 #ifdef KVM_HAVE_MCE_INJECTION
         if (unlikely(have_sigbus_pending)) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4475fd1a9d9..d5f9b7c088c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1404,7 +1404,7 @@ static void arm_kvm_pre_run(CPUState *cs, struct kvm_run *run)
     }
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
+static MemTxAttrs arm_kvm_post_run(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu;
     uint32_t switched_level;
@@ -2667,6 +2667,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 
 static const KVMCPUOps arm_kvm_cpu_ops = {
     .pre_run = arm_kvm_pre_run,
+    .post_run = arm_kvm_post_run,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index eab5ab46d45..64af85cd113 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -236,6 +236,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
     .pre_run = x86_kvm_pre_run,
+    .post_run = x86_kvm_post_run,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e9bcda70dac..a1b91d502f0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5995,7 +5995,7 @@ static void kvm_rate_limit_on_bus_lock(void)
     }
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run)
+MemTxAttrs x86_kvm_post_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index b8fb2094062..192538c0aa9 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1517,11 +1517,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return cs->halted;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 17b16e33881..5ef4722cd6f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1336,11 +1336,6 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
     return 0;
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return cs->halted;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8575e673811..9580b6c1b20 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1640,11 +1640,6 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 {
     return true;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 827816e5b98..ad1145c4ec1 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -984,11 +984,6 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
     }
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return cs->halted;
-- 
2.47.3


