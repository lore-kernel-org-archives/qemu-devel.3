Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978FDC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFc-0001R1-EG; Wed, 19 Aug 2026 01:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PsSEagcKCjUaRTbpcZXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--jackyli.bounces.google.com>)
 id 1wwQg1-0005zh-K1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:53 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PsSEagcKCjUaRTbpcZXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--jackyli.bounces.google.com>)
 id 1wwQfx-0007LP-0T
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:50 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-84f7002f9afso276424b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085887; x=1787690687; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PQq0Bm6wEPPaaVqXBMNHqZK4usIK/j6tgDNzvWv82vs=;
 b=YgbZrx2oAhW7uDFtnYc7orJPUsahuCXTMM6VKJpMnGbPWvguvIvCvZnHfoDpVL2Hl8
 cMdHNCBYqmqf5W1SY3jAwb70NTadGIWr0CkTD+O2gyCT7+eUsV9pBHg5S0k9hFLTvVut
 HMBxjMRGCI2v9FkrfObPOtDbzA+fnmUFEl8PM3J7wIDC8g4anKMvZfTg3bieV9772LAH
 SSf3Far5OIptyUdqLMbsKyjaQfTYA4Y9x+hZ2gHHKtRRIvnCjTxTgn7CT1iZcZSwVfFm
 pnS8sQGOI/TCWqqo7dDGQ8wg3Yavf1d99KEYOttBELjml0Yvv/l4Wq9J70e7sxiCRSbq
 zZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085887; x=1787690687;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQq0Bm6wEPPaaVqXBMNHqZK4usIK/j6tgDNzvWv82vs=;
 b=ByZF0ne4Y5hQgn0UMV8QzZaOmzSjRd8sCtwnlZia8/mdu6+xdHGTs3gQ97UY+qJGfL
 AGedRmUPnS4mgZTSgXYonapi+ALh7biNNqNiLBX0g1tzgN64FE5Ao16MUFGLjoh1nZmf
 cy3r6vrFlXtfQ1nELNw+0ePUNR9LE3oo3PIHAAiUw0rJfV89T613a5uuRmSxaNd21Wow
 bMOojyXELuvaKifN4KU8iQaQvAmgLy90rGNZS6l+b6Ko8sdRdXxHNAdoC8AbRFFCR3NA
 oS0RYfgUuiquueHAV4w0hc2KoODYZb1oy+o6wKk3O4Uyf+Nkry5aNL2IX9uGCGaTgU+y
 pi5A==
X-Gm-Message-State: AOJu0YzXCCb70dO7zoWtBgp9urDXXGVZ7oGP4I8tU7pieFUEX/Jp8+o7
 h4Ye/hvTjKbq5111FlBiv8hqVpPEk0RidO7eWB0+FFIfjcbjzFWjPAvHY2xyMFD0boToxNy/RdY
 eAN/cOUbIteAyN2fh5J+mKsFcaSaCrV6UR3zJYlevnUuAE4UwECtLZ8oRO49pc3QNp9qOvMXZ0f
 LQzazFPTNmyRL/8oMvCmKEYx/lU8ROsb21RJ4Ehz0=
X-Received: from pfbim15.prod.google.com ([2002:a05:6a00:8d8f:b0:84e:46f:f15e])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e19:b0:847:97a4:d6b3
 with SMTP id d2e1a72fcca58-851cd8346efmr1708280b3a.16.1787085886501; Tue, 18
 Aug 2026 13:44:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:18 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-4-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 4/6] kvm: Lock guest RAMBlocks via PKRU during host
 userspace execution
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, 
 Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=3PsSEagcKCjUaRTbpcZXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--jackyli.bounces.google.com;
 helo=mail-pf1-x446.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:09 -0400
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

Protect guest RAMBlocks from host-side speculative execution attacks by
locking and unlocking the guest memory protection key before and after
`KVM_RUN`.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 accel/kvm/kvm-all.c       |  7 ++++++-
 include/exec/cpu-common.h |  2 ++
 system/physmem.c          |  6 +++++-
 util/pkey.c               | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a8..ae395cd374 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -19,6 +19,7 @@
 
 #include <linux/kvm.h>
 
+#include "exec/cpu-common.h"
 #include "qemu/atomic.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -3666,7 +3667,11 @@ int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
 
     trace_kvm_vcpu_ioctl(cpu->cpu_index, type, arg);
     accel_cpu_ioctl_begin(cpu);
-    ret = ioctl(cpu->kvm_fd, type, arg);
+    if (type == KVM_RUN) {
+        ret = qemu_pkey_kvm_run(cpu->kvm_fd, arg);
+    } else {
+        ret = ioctl(cpu->kvm_fd, type, arg);
+    }
     accel_cpu_ioctl_end(cpu);
     if (ret == -1) {
         ret = -errno;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 28399088f6..90047128de 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -114,4 +114,6 @@ static inline CPUState *env_cpu(CPUArchState *env)
 
 void qemu_init_guest_memory_pkey(void);
 int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot);
+void qemu_reset_pkey_with_ibpb(void);
+int qemu_pkey_kvm_run(int fd, void *arg);
 #endif /* CPU_COMMON_H */
diff --git a/system/physmem.c b/system/physmem.c
index 9f5a0f194c..c7101f6841 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2755,7 +2755,11 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                     1, lock, is_write);
     }
 
-    return ramblock_ptr(block, addr);
+    void *ptr = ramblock_ptr(block, addr);
+    if (ptr) {
+        qemu_reset_pkey_with_ibpb();
+    }
+    return ptr;
 }
 
 /*
diff --git a/util/pkey.c b/util/pkey.c
index 0151714f32..2e42da7d9c 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -117,17 +117,62 @@ __attribute__((target("pku"))) int qemu_pkey_mprotect_guest_memory(void *addr,
     return pkey_mprotect(addr, len, prot, pkey);
 }
 
+__attribute__((target("pku"))) void qemu_reset_pkey_with_ibpb(void)
+{
+    int pkey = guest_memory_pkey;
+    if (pkey == -1) {
+        return;
+    }
+    if (inline_pkey_get(pkey) == 0) {
+        return;
+    }
+
+    /* IBPB */
+    prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0,
+                0);
+
+    inline_pkey_set(pkey, 0);
+}
+
+__attribute__((target("pku"))) int qemu_pkey_kvm_run(int fd, void *arg)
+{
+    int pkey = guest_memory_pkey;
+    if (pkey == -1) {
+        return ioctl(fd, KVM_RUN, arg);
+    }
+
+    assert(pkey >= 0 && pkey < KEY_COUNT);
+
+    inline_pkey_set(pkey, 0);
+
+    intptr_t ret = local_syscall3(__NR_ioctl, fd, KVM_RUN, (intptr_t)arg);
+
+    inline_pkey_set(pkey, PKEY_DISABLE_ACCESS);
+
+    if (ret < 0) {
+        errno = -ret;
+        ret = -1;
+    }
+    return (int)ret;
+}
+
 #else
 /* Dummy implementations for all other configurations (non-x86_64 Linux, */
 /* Windows, macOS, etc.) */
 #if defined(CONFIG_LINUX)
 #include <linux/kvm.h>
 #include <sys/ioctl.h>
+
+int qemu_pkey_kvm_run(int fd, void *arg)
+{ return ioctl(fd, KVM_RUN, arg); }
 #endif
 
 void qemu_init_guest_memory_pkey(void)
 {}
 
+void qemu_reset_pkey_with_ibpb(void)
+{}
+
 int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot)
 {
     return 0;

-- 
2.55.0.737.g08866a6d13-goog


