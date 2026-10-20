Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D4606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u7CcBk93
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Ln-0006Xf-CR; Tue, 20 Oct 2026 06:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7K1-0004WF-Kn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jg-0004S3-Qp
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so18169045e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493015; x=1793097815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rlGqnDKcLdvQ6taSdMwsgc96SAB4pCJT2O+A8tIZZ9Y=;
 b=u7CcBk93x4RJ8AWxVURRqdB+X9squbTKatIQLAjlLbPzbkmhgxiCpt+lClXVkudtYw
 eNWbxJp+zUsjmcwx64Om0S/GlAln2biXE/sSEa8Q9jVanhSRoytM/JpNUgm1G7GUFsnf
 b/nF4/mojdryPI5K53EesZP5Va/ALTv3L51VAxKJQjJ+XKYiziP2EXx1li7prr3fQfyG
 y9kmS1hhVrdxZ0j/NcJaMLxZ4nwCoS8a04H1zpmt2PCDveaJREHsHXrn1YNG7fF05aMf
 2cRLa/NrH/nSInXxNzWb7FEnPOcZSF5LSau/izUiLDjFuAjVTE8ICnvMIA0MWBYj2zrQ
 bQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493015; x=1793097815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rlGqnDKcLdvQ6taSdMwsgc96SAB4pCJT2O+A8tIZZ9Y=;
 b=SJ2Ap4oItiZEtF48O8c689eOWhzi28r6WjhHDpv1R1dt48EeAPD7GDdnTlvCroTnql
 DxITHF6Chqs/cSTih/LEfeAsa/R/gfYnpuqmZja9tI3O6oR4IwN8cwCz0xLHCF6jkaQ8
 3O+qYWccBaAia4Pvejxg9B8jLwwOlS/BlQ4/WsO0x9/1SG4ho4TT23tEmMGNnWF6TfGR
 +5Ugl62A6unOoWMmflT3Kr44jp0uZdYgJ7QqDggdfk1gVW26PXdJFfSq3eKbyKA+kRg/
 ckwRS0J2+DP9RTCEAi7UzQGXD9ATc8qG745nx5jqZE4xc9OtlqwiwJFlt7FmqL14icnZ
 vrSg==
X-Gm-Message-State: AFq9FYLQjabbogVqbF04mSru280tctSjp6R6QpO2UJFZg46fzcttkVrK
 lIC+FtAyVpw81o77oBUf2x0eJTh6vCEj0gJVp5r3te92vwmTzzLYR/tqCfH/fCX3kzY=
X-Gm-Gg: AYBFou25H0ZUglulJPtekfDyLsGBG2I2s76DT0nYsQDs/QA3ToZbL5LyVO12zWhvyVK
 yHG6lDbUMO67yGJ6RuIHA+98lI/SXbrG0H7yskQhnbj1fPsszPpLv6WXqV0gbNXEu20Fh0Etz1x
 fE4gZ3WVXyE4/70xgmZXTIaZSyXmdT49m/KepQPsuySc1kjV7DgJGYaGyTHkX203Tb/lDFqJBh4
 lN0cw00Nq7TOiZT8qvsFTFDdFbYNPqn6+AsxAY1R51kcyoyhqktLAo6vkmdRa2bNcIk6hkF0Vc+
 UzIPIrq4kH6Q/yVnYuRRR7AqfPQO1XA4rvxESC1e0pz8q5TJDHnGr4MqJkQv1vdsaNnByf0gF9B
 O118cgtU1GrKvm8LpRjOrWTwFLWNHe6ZWvBQhuH7Xcni6pQSTeNDr77TR2ylneEuYipkZJ5twXc
 vCsXfJ7nJZUecEzfWomAnWw/atlm4OZ1f8Ww0SqM0Ndbjw8dRdy8ZYyAzfDkAW4mhFe56oLA==
X-Received: by 2002:a05:600c:4e11:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a1d75f24b4mr214465875e9.9.1792493015117; 
 Tue, 20 Oct 2026 03:43:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1df370381sm168472065e9.1.2026.10.20.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C7265FD52;
 Tue, 20 Oct 2026 11:43:22 +0100 (BST)
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
Subject: [PATCH 13/23] accel/kvm: port kvm_arch_pre_create_vcpu to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:07 +0100
Message-ID: <20261020104320.3686723-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Only x86 actually does anything for this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h |  7 +++++++
 include/system/kvm.h        |  1 -
 target/i386/kvm/kvm_i386.h  |  1 +
 accel/kvm/kvm-all.c         | 19 +++++++++++++------
 target/arm/kvm.c            |  5 -----
 target/i386/kvm/kvm-cpu.c   |  1 +
 target/i386/kvm/kvm.c       |  2 +-
 target/loongarch/kvm/kvm.c  |  5 -----
 target/ppc/kvm.c            |  5 -----
 target/riscv/kvm/kvm-cpu.c  |  5 -----
 target/s390x/kvm/kvm.c      |  5 -----
 11 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index b3f6b8e47b7..9b8a54253b1 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -19,6 +19,12 @@ struct kvm_run;
 /**
  * struct KVMCPUOps - Target-specific per-vCPU operations for KVM
  *
+ * @pre_create_vcpu: Optional callback executed before creating the KVM vCPU
+ *                   (via KVM_CREATE_VCPU). Used by architectures that need
+ *                   to configure VM-level capabilities or features before
+ *                   vCPUs are created (e.g. x86 PMU disable or TDX).
+ *                   May be NULL if the target does not require pre-creation
+ *                   handling.
  * @get_registers: Mandatory callback to synchronize architecture-specific
  *                 vCPU register state from KVM into QEMU's CPUState.
  *                 Returns 0 on success, or a negative errno on failure.
@@ -54,6 +60,7 @@ struct kvm_run;
  *                        processing before execution.
  */
 typedef struct KVMCPUOps {
+    int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
     int (*get_registers)(CPUState *cpu, Error **errp);
     int (*put_registers)(CPUState *cpu, KvmPutState level, Error **errp);
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b2d76f99df0..3b08eb4f5d0 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -346,7 +346,6 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2c92afc3320..b5dace5d3be 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,7 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
+int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp);
 int x86_kvm_get_registers(CPUState *cs, Error **errp);
 int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3de05bb8bb8..dbd4cfc7c7a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -460,6 +460,8 @@ static int kvm_rebind_vcpus(Error **errp)
     int kvm_fd, ret = 0;
 
     CPU_FOREACH(cpu) {
+        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+
         vcpu_id = kvm_arch_vcpu_id(cpu);
 
         if (cpu->kvm_fd) {
@@ -480,9 +482,11 @@ static int kvm_rebind_vcpus(Error **errp)
             goto err;
         }
 
-        ret = kvm_arch_pre_create_vcpu(cpu, errp);
-        if (ret < 0) {
-            goto err;
+        if (ops->pre_create_vcpu) {
+            ret = ops->pre_create_vcpu(cpu, errp);
+            if (ret < 0) {
+                goto err;
+            }
         }
 
         kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
@@ -723,14 +727,17 @@ static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp)
 
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
     KVMState *s = kvm_state;
     int ret;
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
-    ret = kvm_arch_pre_create_vcpu(cpu, errp);
-    if (ret < 0) {
-        goto err;
+    if (ops->pre_create_vcpu) {
+        ret = ops->pre_create_vcpu(cpu, errp);
+        if (ret < 0) {
+            goto err;
+        }
     }
 
     ret = kvm_create_vcpu(cpu);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ea8c4d02ee8..da6c3e0b3d3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1994,11 +1994,6 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 08308ef8a80..e2cf42a126e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -235,6 +235,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 }
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
+    .pre_create_vcpu = x86_kvm_pre_create_vcpu,
     .get_registers = x86_kvm_get_registers,
     .put_registers = x86_kvm_put_registers,
     .pre_run = x86_kvm_pre_run,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7ee6d3d4f38..1c53b62a1f7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2056,7 +2056,7 @@ full:
     abort();
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
     static bool first = true;
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 1e7565732e8..9ce6e9e65b4 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1297,11 +1297,6 @@ static int kvm_cpu_check_misc_v1_1(CPUState *cs, Error **errp)
     return 0;
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25f797cb2d8..8a2d2421dc2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -480,11 +480,6 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c38c07a563b..cef9d90c66f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1579,11 +1579,6 @@ static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
     return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index c85d286288b..64020450dec 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -400,11 +400,6 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
-- 
2.47.3


