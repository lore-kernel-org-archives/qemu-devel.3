Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B628606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yj+wSB6/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7L8-0005zH-Mq; Tue, 20 Oct 2026 06:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jt-0004MW-MQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jb-0004P4-Rl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1693243f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493010; x=1793097810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K7uFeQPHP03rH0C9IgKY7QD6JlgfGCjHU4q4ZdF6Xyo=;
 b=Yj+wSB6/oynVPFVCO+NQOqfRJZwUND9pyvqH3dmqSa0/dleOHMcQunS9aGuKPCZFG7
 M5US7fxeNcfvJXVXrpHkcVx9ESpv1D3zB2AaUom5a6sdvl1Ra4SouOSpk4T0o4E+yNZz
 wqFmu2yrA1HHMLmLz2pu5lTvP9BoC47D5kRpP8YTCct4Tg9g0Sg6MnVsiebRZnQt3GbJ
 5h+6YlyDxmnmGl2xeEo1o2IGxu7OZzWLvrCaMvTyvp28Mq8K9d1ZuqvTWYPeVYjyVLD1
 pBV1m1U6Irhu3tau3HOSR2NXUgNsFI6+J0R61i/WH0hAycejhBtk3U2/vv+q2DHy2SW0
 k1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493010; x=1793097810;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K7uFeQPHP03rH0C9IgKY7QD6JlgfGCjHU4q4ZdF6Xyo=;
 b=r2GK3qS6LcXw+wuYJNua+OSqKb9uQ/H4F7mB+PeNCnUsp5OcWDEiA/hTVpRKSsA8s6
 eI1AopYUnibE1UPJXqse/Rz+CcIwYPyH4YkiKV5mRwsx8MQyJ75jbNoDsjc1GRxnmkbb
 zTL9APxC1pyUc/5tVdnDyDdDWcBBKug60ygxkBgZpbxOLmalFekM6MMkKmExUzyjYkq3
 Dvjxi5vzDO59fUcfHb367Zx+whKpRMCGTC1K4zxrW1KAfhHi4+h4Gr/WGjjym3Gmd1lX
 M1+y9zrcjhsZTrFieJYHaPvAIMIthlKxsP2++FaV4fWdhd1W8NTb28XcuwakTyH/tL/h
 AEMA==
X-Gm-Message-State: AFq9FYIF5r7uSsb7YrBp7FtFFecyoWLDbvA0ov7AhDANHgqHnYMGBe4m
 xGYTOg7I45Z2ECQXKraNic0Qv0FtIFlCX4nuoyD6CADi63vxiTnbsobcOrXzVrbEh1U=
X-Gm-Gg: AYBFou2M3BAHAhu/DKE+8DGDN1x7t2m1p9cM0xGgc1fTIhfLkGG49n2Db1xevbUWC5i
 qZ/bMIDMdVztthFLqmi8o+7+ireALcfRAXrwDhjEQol7JLBmSIYp0fqFI9E7tW3VN4rV9AftToH
 SPOxV7LA1B+p1aITzp5a5xoNOKeVrG6yiUlrga4ho2xB/77EGJ+1W1ufFx0UMWY7LNIj6teOny5
 ZW5xksa7ghrXqKkb7MM4owRyczwzyh4CliMFjEflj/asLcV/bX55ZLTiIWwEBo46EwhVyUHItYA
 pYqYh+pWUBCBSZ5jRm3K2qLUA7nHPHshEUVV9NqxuoSeQ0rvRl7OaZzw1RIh/2ZK4UO2ZnleSqw
 DHYnOuFpOD6bQHhakS+ytUnlxfJdRw0A+8tvaKuf6+gnDeqOe2Ls1ZJryFkvjjougiXhNI0OO3J
 6ifKcaK0E0cIZurst2YpcW3bCQy2WHUhmtsnji6PZavnW/zXVgSlIN3NMM9eVregQFnk486w==
X-Received: by 2002:a05:6000:2c04:b0:48e:1f08:4f05 with SMTP id
 ffacd0b85a97d-48e1f08504emr4194817f8f.33.1792493009010; 
 Tue, 20 Oct 2026 03:43:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d818237sm5338996f8f.27.2026.10.20.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B82675FD54;
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
Subject: [PATCH 14/23] accel/kvm: port kvm_arch_init_vcpu to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:08 +0100
Message-ID: <20261020104320.3686723-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Every architecture needs to implement this. I did note that loongarch
references init_vcpu for feature detection but maybe that should be
moved to kvm_arch_pre_create_vcpu?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 4 ++++
 include/system/kvm.h        | 1 -
 target/i386/kvm/kvm_i386.h  | 1 +
 accel/kvm/kvm-all.c         | 8 ++++----
 target/arm/kvm.c            | 3 ++-
 target/i386/kvm/kvm-cpu.c   | 1 +
 target/i386/kvm/kvm.c       | 2 +-
 target/loongarch/cpu.c      | 8 ++++----
 target/loongarch/kvm/kvm.c  | 3 ++-
 target/ppc/kvm.c            | 3 ++-
 target/riscv/kvm/kvm-cpu.c  | 3 ++-
 target/s390x/kvm/kvm.c      | 3 ++-
 12 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 9b8a54253b1..23557a42ba7 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -25,6 +25,9 @@ struct kvm_run;
  *                   vCPUs are created (e.g. x86 PMU disable or TDX).
  *                   May be NULL if the target does not require pre-creation
  *                   handling.
+ * @init_vcpu: Mandatory callback executed to perform architecture-specific
+ *             initialization of a newly created KVM vCPU.
+ *             Returns 0 on success, or a negative errno on failure.
  * @get_registers: Mandatory callback to synchronize architecture-specific
  *                 vCPU register state from KVM into QEMU's CPUState.
  *                 Returns 0 on success, or a negative errno on failure.
@@ -61,6 +64,7 @@ struct kvm_run;
  */
 typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
+    int (*init_vcpu)(CPUState *cpu);
     int (*get_registers)(CPUState *cpu, Error **errp);
     int (*put_registers)(CPUState *cpu, KvmPutState level, Error **errp);
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 3b08eb4f5d0..a722f266dae 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -346,7 +346,6 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
-int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
 #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index b5dace5d3be..8af5a9dc0ef 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -34,6 +34,7 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp);
+int x86_kvm_init_vcpu(CPUState *cs);
 int x86_kvm_get_registers(CPUState *cs, Error **errp);
 int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dbd4cfc7c7a..d877edaa5e8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -510,10 +510,10 @@ static int kvm_rebind_vcpus(Error **errp)
             }
         }
 
-        ret = kvm_arch_init_vcpu(cpu);
+        ret = ops->init_vcpu(cpu);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
-                             "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                             "kvm_init_vcpu: init_vcpu failed (%lu)",
                              vcpu_id);
         }
 
@@ -760,10 +760,10 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
         }
     }
 
-    ret = kvm_arch_init_vcpu(cpu);
+    ret = ops->init_vcpu(cpu);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
-                         "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                         "kvm_init_vcpu: init_vcpu failed (%lu)",
                          kvm_arch_vcpu_id(cpu));
     }
     cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da6c3e0b3d3..b62f40623c3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1994,7 +1994,7 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
-int kvm_arch_init_vcpu(CPUState *cs)
+static int arm_kvm_init_vcpu(CPUState *cs)
 {
     int ret;
     uint64_t mpidr;
@@ -2656,6 +2656,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 }
 
 static const KVMCPUOps arm_kvm_cpu_ops = {
+    .init_vcpu = arm_kvm_init_vcpu,
     .get_registers = arm_kvm_get_registers,
     .put_registers = arm_kvm_put_registers,
     .pre_run = arm_kvm_pre_run,
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index e2cf42a126e..6c547f204f8 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -236,6 +236,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
     .pre_create_vcpu = x86_kvm_pre_create_vcpu,
+    .init_vcpu = x86_kvm_init_vcpu,
     .get_registers = x86_kvm_get_registers,
     .put_registers = x86_kvm_put_registers,
     .pre_run = x86_kvm_pre_run,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1c53b62a1f7..46b7e497aaf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2218,7 +2218,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int x86_kvm_init_vcpu(CPUState *cs)
 {
     struct {
         struct kvm_cpuid2 cpuid;
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..d8f54a5526c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -177,7 +177,7 @@ static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
     }
 
     if (kvm_enabled()) {
-        /* kvm feature detection in function kvm_arch_init_vcpu */
+        /* kvm feature detection in loongarch_kvm_init_vcpu */
         return;
     }
 
@@ -213,7 +213,7 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 
     if (kvm_enabled()) {
-        /* kvm feature detection in function kvm_arch_init_vcpu */
+        /* kvm feature detection in loongarch_kvm_init_vcpu */
         return;
     }
 
@@ -241,7 +241,7 @@ static void loongarch_set_msgint(Object *obj, bool value, Error **errp)
     cpu->msgint = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 
     if (kvm_enabled()) {
-        /* kvm feature detection in function kvm_arch_init_vcpu */
+        /* kvm feature detection in loongarch_kvm_init_vcpu */
         return;
     }
 
@@ -260,7 +260,7 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
     cpu->ptw = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 
     if (kvm_enabled()) {
-        /* kvm feature detection in function kvm_arch_init_vcpu */
+        /* kvm feature detection in loongarch_kvm_init_vcpu */
         return;
     }
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 9ce6e9e65b4..8f2ceb50a78 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1297,7 +1297,7 @@ static int kvm_cpu_check_misc_v1_1(CPUState *cs, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+static int loongarch_kvm_init_vcpu(CPUState *cs)
 {
     uint64_t val;
     int ret;
@@ -1639,6 +1639,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps loongarch_kvm_cpu_ops = {
+    .init_vcpu = loongarch_kvm_init_vcpu,
     .get_registers = loongarch_kvm_get_registers,
     .put_registers = loongarch_kvm_put_registers,
     .handle_exit = loongarch_kvm_handle_exit,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a2d2421dc2..075999b553a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -480,7 +480,7 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+static int ppc_kvm_init_vcpu(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *cenv = &cpu->env;
@@ -3068,6 +3068,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps ppc_kvm_cpu_ops = {
+    .init_vcpu = ppc_kvm_init_vcpu,
     .get_registers = ppc_kvm_get_registers,
     .put_registers = ppc_kvm_put_registers,
     .handle_exit = ppc_kvm_handle_exit,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cef9d90c66f..b202882a155 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1579,7 +1579,7 @@ static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
     return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+static int riscv_kvm_init_vcpu(CPUState *cs)
 {
     int ret = 0;
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -2179,6 +2179,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 }
 
 static const KVMCPUOps riscv_kvm_cpu_ops = {
+    .init_vcpu = riscv_kvm_init_vcpu,
     .get_registers = riscv_kvm_get_registers,
     .put_registers = riscv_kvm_put_registers,
     .handle_exit = riscv_kvm_handle_exit,
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 64020450dec..478b21a57fd 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -400,7 +400,7 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+static int s390x_kvm_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     S390CPU *cpu = S390_CPU(cs);
@@ -2646,6 +2646,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps s390x_kvm_cpu_ops = {
+    .init_vcpu = s390x_kvm_init_vcpu,
     .get_registers = s390x_kvm_get_registers,
     .put_registers = s390x_kvm_put_registers,
     .handle_exit = s390x_kvm_handle_exit,
-- 
2.47.3


