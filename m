Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3BD6AAF7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LTi-0000Mm-0z; Thu, 02 Apr 2026 13:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTd-0000IX-H9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTa-0000iC-DL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso10441755e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149500; x=1775754300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrVl5JuVN8G6WWTaySq76RqbM4pMpv5bVR911pKLKsw=;
 b=oe1WZe+5gzqaMXADc8KtuoB23FMizdORp2CUUvDOwj42M/tzMQ/1AZTLH37GL+ML3R
 hGlQKiZraAWGU1dtW85kDnfOaqtSmKszKs8ZozJifqgvmjp3yhkN325FdnfrOc3LsoSb
 34E9Eo+/yE8gclqHJj+CdNrV+EUVMsGjz244IJE9gq5cw76FRm7Myj3IC0C2CD6ZRdGC
 GguoPClxsqyxSsd3VZS1sEz36LBmZWlG0iiFmvsbslbmmW+CdeHu8VEw+yEt6J0MbQpt
 /Bd9F5jDoLMY/MP88VLSjT0CUGBoug6PUc8ntXPoD39GJSWbqszBgzNuafhVSFkS/uru
 JUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149500; x=1775754300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrVl5JuVN8G6WWTaySq76RqbM4pMpv5bVR911pKLKsw=;
 b=FNa7QpKmwQ2HLHhFS0RpcD84bFlvk4x1p06OQWAR4lATmaJDFk6bJpq8cgQBWDaIEe
 tuLj/b7cNSaBiQhWiHtCiyQZl/C2bDn4vp5mW8nIYZtjnL0NcmHbM6MWoNa5bbZEXyS3
 Mv4hXYlcSMNzxAQn2g5vtiCg6xLoyz1eEFcrsQOF8pdO0THlYxN7ccPlkRFWgeokxWiv
 aV/Ovmd23x3CV0CmPKq33h4jMNVb/6stnh0NIyYNFeQYGYWlLLc7kRC8yQyIAKttKJdu
 QM2IJJ7BNG2C3N/kYxnAPZOFt71ffISEIgFmPONdG7EZOwGllbFLxsfmC6+W7+OQDZua
 olzQ==
X-Gm-Message-State: AOJu0YxXTQovzucoryWVHsSiggFNWCZgZ7rF5UypGEiEUJ8tvro3tyLl
 EZlvJjJJkgDhFFRxXUXd1OFOHu36Mfm7Qkkilp2oJvg2g/ozbKAe6O2y3qWZd4ilEmHEhSJxPyT
 JcX7pHQ8=
X-Gm-Gg: ATEYQzwzT8p03W9NzFqL2t81q2NEkZ6wa0hpfAvSXkW9W86nRSrwBXBFeVA/A4YR+Gg
 6Yt0oT2GvSK7n5lnDrlds5oirE9XLLvNJj1HBEZuiqh1TEfd4N4/uc7U8H5ZLH1WfFqc94YfJWE
 2D08YwZTToZjMtQi1w3aBAoKeG/j0mtoE2PA650a2d5cR5Jum4C8x+eQhBHNUWr2MR/tbyFJ1i4
 qTMXaGam7qM7csURsnoqoGEapPOhMbk4jTly5XSORWHGiGoILa0oBZKzSIaL+IH2wtLrXtl+XPs
 DhrFoGIu16dnjybA6cNwn4COYRAYyw/y+T+3ha2MWPRIrXdBSkTopvbyNvzyGCqhQeZ1tBeL35O
 rd6c7X58x2ehcmt74xkHYOkL3iBXbNqTZVbYBxoKE8x4yxSx/ze1omglJ8Iy4KPMPePTq1quDQw
 bAsJKixx0EZq/u4Ve9UpJYNgtLBEd8ydSUwACC0cHrhDc0ra0ACGrQrYis+VgS/Ugk9awXqLP24
 sIH6hjRv7s=
X-Received: by 2002:a05:600c:19d0:b0:485:45fb:3472 with SMTP id
 5b1f17b1804b1-48883562172mr131175635e9.7.1775149499446; 
 Thu, 02 Apr 2026 10:04:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488980e3b55sm562915e9.8.2026.04.02.10.04.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:04:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Zhao Liu <zhao1.liu@intel.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.1 v2 3/9] accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
Date: Thu,  2 Apr 2026 19:04:28 +0200
Message-ID: <20260402170434.94783-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

All targets except MIPS have TARGET_KVM_HAVE_GUEST_DEBUG=y.
Declare the kvm_update_guest_debug() stub to MIPS and have
TARGET_KVM_HAVE_GUEST_DEBUG be the default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/aarch64-softmmu.mak     |  1 -
 configs/targets/i386-softmmu.mak        |  1 -
 configs/targets/loongarch64-softmmu.mak |  1 -
 configs/targets/ppc-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak       |  1 -
 configs/targets/riscv64-softmmu.mak     |  1 -
 configs/targets/s390x-softmmu.mak       |  1 -
 configs/targets/x86_64-softmmu.mak      |  1 -
 include/system/kvm.h                    |  7 -------
 include/system/kvm_int.h                |  2 --
 accel/kvm/kvm-accel-ops.c               |  4 ----
 accel/kvm/kvm-all.c                     | 13 ++-----------
 target/mips/kvm.c                       |  5 +++++
 13 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index d34aead41c4..6f60ca6505c 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 38a8f85201f..2eef68dc55e 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=i386
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-32bit.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 476407f9413..7e0b1ab5d05 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml loongarch-lsx.xml loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 867898bd47c..c47887f8992 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 10d7a2681e7..8c6dc84b821 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 5059c550480..e0d2c7032d6 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index e273075f1a9..699e5ced96f 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c7f8746b4f5..491173df466 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b5763a562d7..9b722ad931a 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -237,14 +237,7 @@ void kvm_irqchip_change_notify(void);
  * calling down to kvm_arch_update_guest_debug after the generic
  * fields have been set.
  */
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
-#else
-static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
-{
-    return -EINVAL;
-}
-#endif
 
 /* internal API */
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d..9d1d3fd3deb 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -113,9 +113,7 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
-#endif
     int max_nested_state_len;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..d4af6b416c3 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -85,12 +85,10 @@ static bool kvm_cpus_are_resettable(void)
     return !kvm_enabled() || !kvm_state->guest_state_protected;
 }
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static int kvm_update_guest_debug_ops(CPUState *cpu)
 {
     return kvm_update_guest_debug(cpu, 0);
 }
-#endif
 
 static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
@@ -105,13 +103,11 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
-#endif
 }
 
 static const TypeInfo kvm_accel_ops_type = {
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5df3fb90d88..91724b54cdf 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2920,9 +2920,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     s->sigmask_len = 8;
     accel_blocker_init();
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
-#endif
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
@@ -3033,23 +3031,19 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-#endif
 
     kvm_sstep_flags = 0;
     if (kvm_has_guest_debug) {
-        kvm_sstep_flags = SSTEP_ENABLE;
-
-#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
+        kvm_sstep_flags = SSTEP_ENABLE;
+
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
             kvm_sstep_flags |= SSTEP_NOIRQ;
         }
-#endif
     }
 
     kvm_state = s;
@@ -3782,7 +3776,6 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
@@ -3942,8 +3935,6 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
-#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
-
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a85e162409c..49bff68b137 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1262,6 +1262,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     abort();
 }
 
+int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
+{
+    return -EINVAL;
+}
+
 int kvm_arch_get_default_type(MachineState *machine)
 {
 #if defined(KVM_CAP_MIPS_VZ)
-- 
2.53.0


