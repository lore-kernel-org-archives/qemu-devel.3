Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7769606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZYbadzpO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7K0-0004Sz-Iy; Tue, 20 Oct 2026 06:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jj-0004Gs-Pr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JY-0004Ld-2T
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so38013115e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493006; x=1793097806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7E+F5w0u+AqmY/EykrNZQYWdzxIQe74/AVCrqp8rKyo=;
 b=ZYbadzpO0Pdaeg3af6Tr6Ks9D7nG59Ksbl0DQ/+Aj3SQpp7fStPAvCyX4RErPnxstK
 22kjkFnjuUFI+xGJbetQcosZDGw8zdRuZ6jBaGuyjmcvcSJcht0UV94t/FTVCTPQpAdY
 xXR8ww8MjDmUE/jtQOSR62pAGUUpXQIuSTrK3prR5+Xp+kAyEfHDvtLDbcMUzdwOaLFz
 TreWm1efQA96hev0fJRd4TaNMP7LreaCPWUX2C+ibkKBAAHk3N415zQG/BylDWsg31bA
 eFbcFN6tnzX7iFje/g8KrWa1LzB2rmnESTUpXk/gVF97vIEmcmwPgIJRX2BvCPGd38gw
 lYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493006; x=1793097806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7E+F5w0u+AqmY/EykrNZQYWdzxIQe74/AVCrqp8rKyo=;
 b=kP2Neum95FM3Ex6aJrVk+YI0cJkCpl48gjixZSxrSQQs+rnrDe3J5up2Ver1D/L+I9
 59G3luHOY0nWRP7J9sfLt4iethibdtSvIoMQN+R+MOI4P7YI87sOg+YNhvXjPFm0uLx+
 GIuenR81t+kflhRBOtyEOOwj9MO7AUAZs3QRAyUfo5C7ONZg9idB0uboW3ITaUG0TA2h
 Pnk13Y0VlYP74ltiWvTGSY8dOAXd+cuo15OpL1xDvUGOJjDfIfFMvwMLiAHwsWIwg1He
 chILE0Cjvh9fx/HNOMeZf/lLsz0zF24eRIZbpcTpELQkrTatAcko482uHBF8shwBX2dp
 +ujQ==
X-Gm-Message-State: AFq9FYIdpN8JDDxuf9xV01QlqnEh//nb0iiLGET6Erh/8ZXkrFFOQOvg
 zMg/MjzA0pMuoZCPJsqA2HLPW3efSoNgAEz7FCPRpRjVmc3kwrjG9HwK4gGKQnJlS8Q=
X-Gm-Gg: AYBFou29lvR8usGPseNvO03iLOj8ZANBYjlkNZvE61K40jO4s+8gEckTEuNzCHdbdSo
 BFe0ReS1oEMhvj/WiM4byt7dgMh0K1VmjmtwxxXa8DTQmYPYICUa7p9CwBWtiQWetzS+q0Tjmbq
 hfX1JH97KtLUKy7ihXGx6dDDlTVr8Ez32mtOdbrQZB92peMU7HZRoDD7JAGpF8K/syRF4KdesgK
 XyQmlJH9Mg4PvBMGBj4FOZ7wlsihlF8d7q5FcNkMN7i4v8E4sOKfK4roCu+Qz1y6bWxI1JCViE5
 34yN0EQ9k49M6pxMewWFhRxz4AhmL9RPoQpwXvektK/IuZEwfA+A/hKseXV1eb+5L17gOaOQwFa
 2O9DQwQsv1nwVdvtSA5K0HeWUaArcgzeiAoWsbZgJLdSMOeW5fVbxefyQgGrL7dQDp7nJFhIW3i
 GFWGzRVo+HtKH9+C/PBYdpKav6UWx4l1ISXLJ/n90rMZL8vqGdbsSa2xyt3Hp7Zxsrup7hrg==
X-Received: by 2002:a05:600c:138a:b0:4a0:1c94:7042 with SMTP id
 5b1f17b1804b1-4a1d7600338mr226292235e9.8.1792493005839; 
 Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2e8daffsm64233405e9.4.2026.10.20.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C26265FC8D;
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
Subject: [PATCH 10/23] accel/kvm: port kvm_arch_handle_exit to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:04 +0100
Message-ID: <20261020104320.3686723-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

This is the first mandatory operation although currently none of our
x86 tests trip up this handling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 6 ++++++
 include/system/kvm.h        | 2 --
 target/i386/kvm/kvm_i386.h  | 1 +
 accel/kvm/kvm-all.c         | 4 ++--
 target/arm/kvm.c            | 3 ++-
 target/i386/kvm/kvm-cpu.c   | 1 +
 target/i386/kvm/kvm.c       | 2 +-
 target/loongarch/kvm/kvm.c  | 3 ++-
 target/ppc/kvm.c            | 3 ++-
 target/riscv/kvm/kvm-cpu.c  | 3 ++-
 target/s390x/kvm/kvm.c      | 3 ++-
 11 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index e74081eb133..8b2aabd3c2f 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -30,10 +30,16 @@ struct kvm_run;
  *            #MemTxAttrs to use for handling MMIO exits.
  *            May be NULL if the target does not require post-run handling,
  *            in which case MEMTXATTRS_UNSPECIFIED is assumed.
+ * @handle_exit: Mandatory callback executed to handle target-specific VM
+ *               exits from KVM_RUN that are not handled by common KVM code
+ *               (or unhandled sub-cases of KVM_EXIT_SYSTEM_EVENT).
+ *               Returns 0 to continue execution, or an EXCP_* code (or negative
+ *               error code) to exit the CPU execution loop.
  */
 typedef struct KVMCPUOps {
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
     MemTxAttrs (*post_run)(CPUState *cpu, struct kvm_run *run);
+    int (*handle_exit)(CPUState *cpu, struct kvm_run *run);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 82785d37600..82d18d79dc0 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -333,8 +333,6 @@ extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
 
 void kvm_arch_accel_class_init(ObjectClass *oc);
 
-int kvm_arch_handle_exit(CPUState *cpu, struct kvm_run *run);
-
 int kvm_arch_process_async_events(CPUState *cpu);
 
 int kvm_arch_get_registers(CPUState *cpu, Error **errp);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 6fb1da6a40c..5bcc9b51214 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -35,6 +35,7 @@ int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
 MemTxAttrs x86_kvm_post_run(CPUState *cpu, struct kvm_run *run);
+int x86_kvm_handle_exit(CPUState *cs, struct kvm_run *run);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 41229774068..33fa47bddf0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3616,7 +3616,7 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = 0;
                 break;
             default:
-                ret = kvm_arch_handle_exit(cpu, run);
+                ret = ops->handle_exit(cpu, run);
                 break;
             }
             break;
@@ -3634,7 +3634,7 @@ int kvm_cpu_exec(CPUState *cpu)
                                      run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
             break;
         default:
-            ret = kvm_arch_handle_exit(cpu, run);
+            ret = ops->handle_exit(cpu, run);
             break;
         }
     } while (ret == 0);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d5f9b7c088c..914f8e3b089 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1590,7 +1590,7 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+static int arm_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     int ret = 0;
@@ -2668,6 +2668,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 static const KVMCPUOps arm_kvm_cpu_ops = {
     .pre_run = arm_kvm_pre_run,
     .post_run = arm_kvm_post_run,
+    .handle_exit = arm_kvm_handle_exit,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 64af85cd113..6b75eb038e1 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -237,6 +237,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 static const KVMCPUOps x86_kvm_cpu_ops = {
     .pre_run = x86_kvm_pre_run,
     .post_run = x86_kvm_post_run,
+    .handle_exit = x86_kvm_handle_exit,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a1b91d502f0..dfc70eac3db 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6529,7 +6529,7 @@ static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
 
 #define VMX_INVALID_GUEST_STATE 0x80000021
 
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+int x86_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     X86CPU *cpu = X86_CPU(cs);
     uint64_t code;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 192538c0aa9..b23031007c2 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1590,7 +1590,7 @@ static bool kvm_loongarch_handle_debug(CPUState *cs, struct kvm_run *run)
     return false;
 }
 
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+static int loongarch_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
@@ -1643,6 +1643,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps loongarch_kvm_cpu_ops = {
+    .handle_exit = loongarch_kvm_handle_exit,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5ef4722cd6f..25aaefd7649 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1653,7 +1653,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     return DEBUG_RETURN_GUEST;
 }
 
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+static int ppc_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
@@ -3073,6 +3073,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps ppc_kvm_cpu_ops = {
+    .handle_exit = ppc_kvm_handle_exit,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9580b6c1b20..8944961a939 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1787,7 +1787,7 @@ static bool kvm_riscv_handle_debug(CPUState *cs)
     return false;
 }
 
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+static int riscv_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
     switch (run->exit_reason) {
@@ -2188,6 +2188,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 }
 
 static const KVMCPUOps riscv_kvm_cpu_ops = {
+    .handle_exit = riscv_kvm_handle_exit,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ad1145c4ec1..967706a87e1 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1904,7 +1904,7 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
     return ret;
 }
 
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+static int s390x_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     S390CPU *cpu = S390_CPU(cs);
     int ret = 0;
@@ -2650,6 +2650,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps s390x_kvm_cpu_ops = {
+    .handle_exit = s390x_kvm_handle_exit,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-- 
2.47.3


