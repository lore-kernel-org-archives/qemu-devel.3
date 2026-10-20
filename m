Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8460A2613
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rereew3z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7MD-0007dO-QO; Tue, 20 Oct 2026 06:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7K5-0004ea-Cu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:44:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jh-0004Su-Uv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:44:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso21476645e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493016; x=1793097816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d8sAo4RHPko4hi2qqkKFKsivhsO5nInc2hxbjXJGN8Q=;
 b=Rereew3zk7nbq1e011lhNNyHP3+BpssnertXAM5/QgUYAXUerG9LcFsQ0hx8sjsOT3
 k1eTGXdgp0x60+rqOsoXL0bsCHAktIolDYO6PYqan1uJJM2dnAdjP+MYYOGsgcbVsJj6
 rMhA7VMguNjSVNR0XeEqmT9Y+V0B1xn78TS8Vtl52qKSA3i0fgvV3q0QmDBLXnXVicLK
 d2zwuBsuZiGF8pOyqbvTtwTmerj3eaC7sA7j6zacTGneZb2X2cA6VxP3e1IrmOolZjJn
 3e2h/iEiW1YWB7uU0YEIHMoNUKCphmkUx2PI7mStYqqVfo7rSCINeLXRpRBDMM9eBLlK
 /Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493016; x=1793097816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d8sAo4RHPko4hi2qqkKFKsivhsO5nInc2hxbjXJGN8Q=;
 b=0QsgrsnBYy3wpN/plEh0CYoMWEICPZ/4aDEsk7YJx2Uw9WG1yyUzDDBJl35OT66m3/
 iyAk7AstyZYKoNo2hF8IMXwK1H4Lj7bYWHwsW4u/ia29mhOFEp6oNW8WzAnSqt+cA42L
 n6A9+gIPbJ5IROjOZpQM4e4NQ/rjbSt9yhE7hucdWUE5wE6Lt0wCKHnSoz+xFcarSVgD
 XD4DE4mUyBo7WPSCgk6Q1UMJN/CXnJReBLgA0E2NDTgGoZHqP0g022o/VKzRpq9SdxCD
 giUlRZS7mOE2+AXk8QQ7QXLNdmZ4jHN1YbZ1tBDn0gCLotBGEYkdO2Bg2352xXaM2fNB
 6tCw==
X-Gm-Message-State: AFq9FYIhu7o4jK7YU3DneWliJ7et4kMvQZJMVFNwBoGSh0AUqKyfiaG4
 xEzle3+i94Qq0pNHiRjWALQ3+np7qPd7L4IyChai9IKr4q9O6BVn/Po1JWaYGwG4Q5M=
X-Gm-Gg: AYBFou0d/vxgz2IZrt8iRY1NyN/UikVnu/nD+MnquWqxLn9kBccjTi94U8OQ7PrsAnw
 +pjxFOF6bzjWdVP7JC+EyTfucwvKTlqiJjAHRClhncRrGpjkPRkaKvD8h8iYPQsaxAqCz+AT0Zz
 Wr3S81PjxdADk9yW+l6hk/eV3g8IAzj51l88uRHpNgFzYDlvvokgyMo6Ckr9JcgASeyYG2bJ2ob
 iMywy9l4FRzd/4NtmCJopUN7h1my2HthslffRV3l3d7cY62GjY15XtAAIUh0tP7tmccE6Sb7i0l
 LFiVGN8p2WuJ4h7YFl0aczf4y714p5QD8bcl5y6n2in6MNbScwDNTJDzToCzwmJ1uShnFQr56gq
 KOum9hRns+4H8bfiNSYsOSAHVfTmtFc+g33bMODuIecSEUr83SRUK7ghXjRBxEiKVHE4L0oyOfg
 6ZTOQd5YO+r5/7lDgpxgF3tElLht/7g0uImytjFqTHvJXaAc02phyJ8Lxs928bqNhsKGKTZA==
X-Received: by 2002:a05:600d:82c5:b0:4a1:e575:33dd with SMTP id
 5b1f17b1804b1-4a1e57533efmr143324095e9.18.1792493016088; 
 Tue, 20 Oct 2026 03:43:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cc809csm64726835e9.8.2026.10.20.03.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C5355FED7;
 Tue, 20 Oct 2026 11:43:24 +0100 (BST)
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
Subject: [PATCH 20/23] accel/kvm: port kvm_arch_stop_on_emulation_error to
 KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:14 +0100
Message-ID: <20261020104320.3686723-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Really only x86 is doing much complicated, everyone else defaults to
stop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 7 +++++++
 include/system/kvm.h        | 2 --
 target/i386/kvm/kvm_i386.h  | 1 +
 accel/kvm/kvm-all.c         | 8 +++++++-
 target/arm/kvm.c            | 5 -----
 target/i386/kvm/kvm-cpu.c   | 1 +
 target/i386/kvm/kvm.c       | 2 +-
 target/loongarch/kvm/kvm.c  | 5 -----
 target/ppc/kvm.c            | 5 -----
 target/riscv/kvm/kvm-cpu.c  | 5 -----
 target/s390x/kvm/kvm.c      | 5 -----
 11 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 23a83eee6ed..c2ae74f2b87 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -95,6 +95,12 @@ struct kvm_run;
  *                        Returns 0 on success, or a negative errno on failure.
  * @remove_all_hw_breakpoints: Optional callback to remove all architecture-
  *                             specific hardware breakpoints and watchpoints.
+ * @stop_on_emulation_error: Optional callback executed when KVM encounters an
+ *                           internal emulation failure (such as
+ *                           KVM_INTERNAL_ERROR_EMULATION) to decide whether
+ *                           execution should stop.
+ *                           Returns true to stop the VM, or false to dump state
+ *                           and continue. If NULL, defaults to true.
  */
 typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
@@ -115,6 +121,7 @@ typedef struct KVMCPUOps {
     int (*remove_hw_breakpoint)(CPUState *cpu, vaddr addr, vaddr len,
                                 GdbBreakpointType type);
     void (*remove_all_hw_breakpoints)(CPUState *cpu);
+    bool (*stop_on_emulation_error)(CPUState *cpu);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 1a52e7e5261..719ae1c71fb 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -387,8 +387,6 @@ struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
 
 int kvm_sw_breakpoints_active(CPUState *cpu);
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
-
 int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 #define kvm_vm_enable_cap(s, capability, cap_flags, ...)             \
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index e2ae601100c..9d4be604443 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -51,6 +51,7 @@ int x86_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
 int x86_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
                                  GdbBreakpointType type);
 void x86_kvm_remove_all_hw_breakpoints(CPUState *cs);
+bool x86_kvm_stop_on_emulation_error(CPUState *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5b96fac513e..62ebb3458c8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3183,8 +3183,14 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
                 i, (uint64_t)run->internal.data[i]);
     }
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
+        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+        bool stop = true;
+
         fprintf(stderr, "emulation failure\n");
-        if (!kvm_arch_stop_on_emulation_error(cpu)) {
+        if (ops && ops->stop_on_emulation_error) {
+            stop = ops->stop_on_emulation_error(cpu);
+        }
+        if (!stop) {
             cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
             return EXCP_INTERRUPT;
         }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5c0ccfc11cd..ed99699098c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1609,11 +1609,6 @@ static int arm_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    return true;
-}
-
 /**
  * kvm_arm_hw_debug_active:
  * @cpu: ARMCPU
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index baaee0c7e71..c9340183eaf 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -251,6 +251,7 @@ static const KVMCPUOps x86_kvm_cpu_ops = {
     .insert_hw_breakpoint = x86_kvm_insert_hw_breakpoint,
     .remove_hw_breakpoint = x86_kvm_remove_hw_breakpoint,
     .remove_all_hw_breakpoints = x86_kvm_remove_all_hw_breakpoints,
+    .stop_on_emulation_error = x86_kvm_stop_on_emulation_error,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 78c06a07bd6..e419af944cb 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6661,7 +6661,7 @@ int x86_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
+bool x86_kvm_stop_on_emulation_error(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index b15f60bd2c3..fd0f3a82a6b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1513,11 +1513,6 @@ static int loongarch_kvm_process_async_events(CPUState *cs)
     return cs->halted;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    return true;
-}
-
 static void loongarch_kvm_update_guest_debug(CPUState *cpu,
                                              struct kvm_guest_debug *dbg)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 548bf3e00ad..f5f2f82a4d8 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2840,11 +2840,6 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
     return 0;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
-{
-    return true;
-}
-
 void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index aeb049c0c71..6a88fe761c0 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1621,11 +1621,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    return true;
-}
-
 static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ccdc85900ba..e0373d05515 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1935,11 +1935,6 @@ static int s390x_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
-{
-    return true;
-}
-
 void kvm_s390_enable_css_support(S390CPU *cpu)
 {
     int r;
-- 
2.47.3


