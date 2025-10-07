Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E209CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62s9-0006tR-RK; Tue, 07 Oct 2025 04:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62s7-0006sX-4H
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62s3-00021e-Ti
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so742900f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759824990; x=1760429790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSS/vO/urkPdDooJB2oeDa3yztjhJ4DM7WnJ6N8yGds=;
 b=PkHl96/USvcanLX7i2Kb6SS6JbhoMEv8OyIvET8IDMDpF+4mRmlgIdHaEv+X+onmPM
 MKmqHM2yvUPVEUKFpwOZX/J1i5QbU7PxMdMVaP49qIIQO5kl83jR8+by2du6zbmqYlvm
 /qbzhu3/tMXY8zonMsJ/b55F0QFtNV5N8j5gkylE50qGS55jdfEQ5pC0N+od4cqTI+cS
 I82nACRkZnRrN/DTKC7AQoJ/1B2OHeh4A4LqFgflN0Aw0hM/NX+FXK1IiaPPk0qFS5uA
 EAibNnCjwUXkcDhgljNLCd+ZXCklZQjpgIawZ3BpdOlsJFvApqpseEP1f/Z35MQ6mhIq
 CedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759824990; x=1760429790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PSS/vO/urkPdDooJB2oeDa3yztjhJ4DM7WnJ6N8yGds=;
 b=WlYAiRQvz5xYaYJ74kMk/XMb9YUxsE28/k/cxhWAhMrsvTagBiEYk3c6iqDhz5bB1t
 mX1xowADIV6qLAbw7f9nR+WIKhFimUlw2ceKjS7GS+/55CVMbBVw2Ln0bhwinnP+vtyA
 KC8EYW2CSaXdnSrJIs/Tz0EPQFrFCZOnpjQuyrs29WYZuShC3SZ83uWUmFYLl3crPNnQ
 +G70bW14CwUM8jO5sZOsLG1yigpED9EMYZTmlBEjgL+24AXTGOHSwTsu4Okr3VLhH9DY
 meUhp0Cz9JUT38UokJtav8KS79Zlo/Y9ZX+zJgVxelCd37KxBFA7igsAfN1O+xmSohgR
 IAmA==
X-Gm-Message-State: AOJu0YzjsC1kXR5znw1YrSFOB05piDOzQy/FmumhaAAQ5Jt/d+ybxGps
 ltNW5Q7LjtNHOCdjDOJoUotfowqaYBwGyF01RQpiIpMHuw2r0QjNh6pySiJlAuHb6A4bTZV3hzN
 8/aUSz/AtrA==
X-Gm-Gg: ASbGnctQdWwaUkqMffweCNMOmWO2ew7O2oLjR3pFCmFiX01EBnCAJQ4jU6xC0Kgx6B3
 y1kmpDhXfZFFj0aGo6ndK57KcpEC106lrMKnQYUd8jSYHdPxNNp37NK/P4QYZkC1ik8Vt9yPHMk
 m54hGoE0lH0auv/TAdtslH4k5e6/fg0OII5M2yF8PimqSaHt+nRq6nm7QO40xvXmzqLghnz1rqa
 61Yc6zatg/cxzp4mo4ZW5L89JwC2RFNVevA0mCYsUeXJ5Pk8SPWZdhQdsR/LukwweQWkEhlVuZJ
 OWy4xOjknRoN3VYlyKlt97V1ILyyXZUYYvoDtwMsnGZLSy8hDOiXMQf80AXfePW+McxRl8dGdlE
 VGUpSa3KRhXJzwpY0FX3oZMhnCu0oaknuIDfb4Qn/WsrWGBRDCdaDEkoOMbwLqAZop2jtUeP00H
 AUXLPGszRGRAS04G4i667AMCEW
X-Google-Smtp-Source: AGHT+IGRA6KPyvhxXtzYnOvTFtl5YLGs1n5NMaDQ4KBPLj2KKkceTTHa9sfY0JuyGZTIHGBzptzjJA==
X-Received: by 2002:a05:6000:609:b0:401:70eb:eec7 with SMTP id
 ffacd0b85a97d-425671bc76amr9419782f8f.43.1759824989839; 
 Tue, 07 Oct 2025 01:16:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm24090022f8f.27.2025.10.07.01.16.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 01:16:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] accel/kvm: Introduce KvmPutState enum
Date: Tue,  7 Oct 2025 10:16:15 +0200
Message-ID: <20251007081616.68442-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081616.68442-1-philmd@linaro.org>
References: <20251007081616.68442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Join the 3 KVM_PUT_*_STATE definitions in a single enum.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h       | 16 +++++++++-------
 target/i386/kvm/kvm.c      |  6 +++---
 target/loongarch/kvm/kvm.c |  4 ++--
 target/mips/kvm.c          |  6 +++---
 target/ppc/kvm.c           |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/s390x/kvm/kvm.c     |  2 +-
 7 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 4fc09e38910..8f9eecf044c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -340,14 +340,16 @@ int kvm_arch_process_async_events(CPUState *cpu);
 
 int kvm_arch_get_registers(CPUState *cpu, Error **errp);
 
-/* state subset only touched by the VCPU itself during runtime */
-#define KVM_PUT_RUNTIME_STATE   1
-/* state subset modified during VCPU reset */
-#define KVM_PUT_RESET_STATE     2
-/* full state set, modified during initialization or on vmload */
-#define KVM_PUT_FULL_STATE      3
+typedef enum kvm_put_state {
+    /* state subset only touched by the VCPU itself during runtime */
+    KVM_PUT_RUNTIME_STATE = 1,
+    /* state subset modified during VCPU reset */
+    KVM_PUT_RESET_STATE = 2,
+    /* full state set, modified during initialization or on vmload */
+    KVM_PUT_FULL_STATE = 3,
+} KvmPutState;
 
-int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp);
+int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 
 int kvm_arch_get_default_type(MachineState *ms);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6a3a1c1ed8e..d06f55938cd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3911,7 +3911,7 @@ static void kvm_init_msrs(X86CPU *cpu)
     assert(kvm_buf_set_msrs(cpu) == 0);
 }
 
-static int kvm_put_msrs(X86CPU *cpu, int level)
+static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
 {
     CPUX86State *env = &cpu->env;
     int i;
@@ -5031,7 +5031,7 @@ static int kvm_get_apic(X86CPU *cpu)
     return 0;
 }
 
-static int kvm_put_vcpu_events(X86CPU *cpu, int level)
+static int kvm_put_vcpu_events(X86CPU *cpu, KvmPutState level)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
@@ -5274,7 +5274,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 45292edcb1c..32cd7c5d003 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -325,7 +325,7 @@ static int kvm_loongarch_get_csr(CPUState *cs)
     return ret;
 }
 
-static int kvm_loongarch_put_csr(CPUState *cs, int level)
+static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
@@ -763,7 +763,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret;
     static int once;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 450947c3fa5..912cd5dfa0e 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -590,7 +590,7 @@ static void kvm_mips_update_state(void *opaque, bool running, RunState state)
     }
 }
 
-static int kvm_mips_put_fpu_registers(CPUState *cs, int level)
+static int kvm_mips_put_fpu_registers(CPUState *cs, KvmPutState level)
 {
     CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
@@ -749,7 +749,7 @@ static int kvm_mips_get_fpu_registers(CPUState *cs)
 }
 
 
-static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
+static int kvm_mips_put_cp0_registers(CPUState *cs, KvmPutState level)
 {
     CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
@@ -1177,7 +1177,7 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     CPUMIPSState *env = cpu_env(cs);
     struct kvm_regs regs;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2521ff65c6c..cd60893a17d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -907,7 +907,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_SREGS, &sregs);
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 187c2c9501e..75ca3fb9fd9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1369,7 +1369,7 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret = 0;
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 491cc5f9756..916dac1f14e 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -468,7 +468,7 @@ static int can_sync_regs(CPUState *cs, int regs)
 #define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
                                 KVM_SYNC_CRS | KVM_SYNC_PREFIX)
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     CPUS390XState *env = cpu_env(cs);
     struct kvm_fpu fpu = {};
-- 
2.51.0


