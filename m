Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE0CCD194
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEJ-0005pZ-4J; Tue, 14 Oct 2025 09:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEA-0005aS-B5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fE4-00015X-D0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyuYNDptE1X3br74u8yj+JhbDubWHYMBwAIHGS1MK8M=;
 b=PJEpG+smihl5wyibnjtYEB5EfO6XTjB1IekiSr8KtzaL2uuj9HxHfrD8dk8dnODpcqSWmK
 v7u5QU0q2a4gqyKsd0mNIclI5AVD3+HY5eCbStIt53YRtm6tyRXzCaZD/QYVFzbJ81TDGp
 GJ3xpyp9zqb8TSejIKZAhZMkGAyBXAY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-TDxXBIdkMVSAAzPyVJJm6g-1; Tue, 14 Oct 2025 09:38:00 -0400
X-MC-Unique: TDxXBIdkMVSAAzPyVJJm6g-1
X-Mimecast-MFC-AGG-ID: TDxXBIdkMVSAAzPyVJJm6g_1760449080
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3e177893so38378185e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449079; x=1761053879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyuYNDptE1X3br74u8yj+JhbDubWHYMBwAIHGS1MK8M=;
 b=OiK5x6YSp0TZ/aMg4/kDoBdTWogiAHJ8BaO50j6GbuBi3xHnyN63wcw2BX/ri7cy/L
 MSPDmvJs0jw3TR1T43EGilaveF8TY4vr/wGDEyTOmNDVbP5BQ8yDKfUXyfmYS92lJVRC
 1zWMxEEJv4JB0e1tcqG38rERD6l6rAzEn8m56ZjVCKweSF62H3TWr8JGXTa87je4r/SN
 IbYXwuelZlpUt4DdfAY63BSPIkgbRKo/Pj8aVM2kSIayyLQLnQr5E4/aA84ZLRAwXy2J
 3ye/IeLiRInSmGwDiICyefpTAPoNY/xg9HPefpalSG5pMKn0thaH8wJtjlkFTzEHTNJL
 Ps8A==
X-Gm-Message-State: AOJu0YyneFElcuqKYEs8qIdzxUyeMvLAB2AVUOpoWOTQsU3OOzvuw1gm
 oEIvWbtZrOyrHvEBNGjWDbfyPpePG1eg1Wv6OzBzRe6HsucnEicsi/c960eix7/mG8hT2aSjHhN
 VEX+1bRt4MUF/9aLUMasnW3TC05Mq+W1KCwbi3OZM+97dG6WWKaJhmrHzbmFni6d4KYMaeBqq59
 9mT4uHaEH1JB2n4SRJZjdO2moUJ/BrlLV40OEIQnzI
X-Gm-Gg: ASbGncu8s3rNuX/ZK5xZ8+XpUJkJRN1aLY08nqRzGppASlfgplP5775JcwJvlBLkKiq
 jILrbYfBzNTTnk6E+ImZL9CrzTyQanp4SFGOXLF24QCtZO/XE9dMkdtQMWe4kBP2HrdREg3now/
 ip7ALoh/M9O0x8noGeYhmjj7oKZp+jqa8xdHw15vHs8oQQ7JT+FhPPqBxFN7SmdP7SEYElW+UGn
 gTdfotXTzD1bR2Qhxykt1jJcCSWyB6rVrL+/gIr1enRGiSpkj+PQM8toCUMTjvyqNUZc5rcphT+
 gPSXuokGMjFGrPuAwfgwgXP/9YMLyGd+Zn4T9EDkc0fZ7yEQyEPpvRrefFk62Ev1EGq9/cpOKWW
 xUtmINe6/u9zw54r745Fl9lEyqQuMIrvKUGmfMTA9HRs=
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46fa9a89444mr165533315e9.2.1760449078850; 
 Tue, 14 Oct 2025 06:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0mXnc7Uhl/zrYbfERjIBE+xu0/1nlV1pk5lPrIDIPhNddB18aN/evf7Txni5uVcOMYGZy1g==
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46fa9a89444mr165532995e9.2.1760449078338; 
 Tue, 14 Oct 2025 06:37:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ed61d31esm4699912f8f.52.2025.10.14.06.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 17/28] accel/kvm: Introduce KvmPutState enum
Date: Tue, 14 Oct 2025 15:37:02 +0200
Message-ID: <20251014133713.1103695-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Join the 3 KVM_PUT_*_STATE definitions in a single enum.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251008040715.81513-3-philmd@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h       | 16 +++++++++-------
 target/arm/kvm.c           |  2 +-
 target/i386/kvm/kvm.c      |  6 +++---
 target/loongarch/kvm/kvm.c |  4 ++--
 target/mips/kvm.c          |  6 +++---
 target/ppc/kvm.c           |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/s390x/kvm/kvm.c     |  2 +-
 8 files changed, 21 insertions(+), 19 deletions(-)

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
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4f769d69b38..0d57081e69f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2123,7 +2123,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e40e374b046..309f043373c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3924,7 +3924,7 @@ static void kvm_init_msrs(X86CPU *cpu)
     assert(kvm_buf_set_msrs(cpu) == 0);
 }
 
-static int kvm_put_msrs(X86CPU *cpu, int level)
+static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
 {
     CPUX86State *env = &cpu->env;
     int i;
@@ -5044,7 +5044,7 @@ static int kvm_get_apic(X86CPU *cpu)
     return 0;
 }
 
-static int kvm_put_vcpu_events(X86CPU *cpu, int level)
+static int kvm_put_vcpu_events(X86CPU *cpu, KvmPutState level)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
@@ -5287,7 +5287,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index e5ea2dba9da..4e4f4e79f64 100644
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


