Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9271EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQRd-0007fS-6Y; Fri, 06 Feb 2026 13:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRb-0007eY-2W
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRZ-00051j-IL
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso22901565e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402035; x=1771006835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LK8trtLyNSo6IVxA5K1xN9ZysZ5E29etqSmlwZuT3o=;
 b=IejTbvmOCvoeR42qu/4/nqy1biOabP4LhpoM6o7VgdF8DrsJfnj6tXF2HmUIzzHhDQ
 bjViroWWDF2TwcO8yhoeWH1rMKt+V/2/ApXeFFhYEgli+Bj5S8o7a2WcSymw4+/aFw36
 no/RyBazh9d9uCUmQ6abmaF/sMdCx2wSmiiljX/Gn54WqUSKWltP5PWTtsPSkzH7naVh
 yY8uJNHDQHGrgc9oFb1018ohBX1jKIdVQrzt0NvwPHaWBf+l5PverVBazp0cml7gk4fR
 bvr6f7cs01ZH7UpIUucTr+Euol9LXVyNrKVXI9hKr5Tt/7nwJqEbDao0814G/UFF40no
 3zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402035; x=1771006835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2LK8trtLyNSo6IVxA5K1xN9ZysZ5E29etqSmlwZuT3o=;
 b=n1xWBGuRR7yqO3sLy4A0EOBsMkTwthhSZm/5lT0K9wWZoqR0ZEDiegT9juvJL7yB9f
 /yY+lkottFGpKtg9nkCFjWoI5+l0TTBUCpWlfHHAsBE+JqRyv4XJt7D5Gjo57Q9NYhcK
 r9MLFzM5UtB4vff3hoEyWhlHCdpfxiZ3ylNYEnSLZUuuUBS5/r+CSnerpZJPNQYZ47Ym
 ET5yFyMskCVe018sIMmyXgq98zf9yJ6QTQ8YmjyLjOG4FaJOSKNgRcQi5hd/fOJT6aeF
 ext0XaSxhgNU0yhPhCPq2b6LsK7WGPsNICxeIWmyzeFcG2cp80eIgLW7PkfjjfEWd4px
 d/og==
X-Gm-Message-State: AOJu0YwQWOMTlEbhCTJaUUFfXVAuzA21ykF8cTq94fCPXMOyh3iK/kfz
 j2FF440EOES9EbSXCNRaB1Yo+j0r+tYwo0JT2Qf5/i8u9tI3qEJHw7oadcibHHUFzTseI6Hu+J1
 GiiywIRY=
X-Gm-Gg: AZuq6aKPseaMjZ6zKNoA8Y6Q8dI99vpsSKngKmEXPC7k9bAHjFPvfJgwkOv//x2RbB0
 NdD4/ecqWEqTE452iknSRVR0pRuw1vM7Us4bWewGO+tUpzpkR4PL5RrgdACofJx4sKutgfLo+QN
 vmklKle7sGzH5tQ9K1y/THtpzFmGky7lTvdg38CgnwSK8+UVX+97JS93hJroYbNffbLEI6mhuOQ
 IYnuScApVvqqnTisFBHP6RzRfxBsDPyLsnJRK4Cmg1tkIGPbN+GdYhlEunnRlxQyBuLxtpg37FU
 spMfRZ6tI5owWICG9iMDggei8uIFNTt4rOTzv0FZMFfiZcunBuU3QH5lgmjuPczipL/qUrD+JUM
 Td1lVHgJED4oQX6Nz/C64JdqEOLjKKGZSXKJErsyvkUfdlZXp0UXvYjVLIqqhd0uSTRKUQwDczs
 Fa+ZQwD3ikPY4DqH2BRBIjI53I9OfzQiwxhTcaSeK/njoHr/TKH3rO00cpZcld
X-Received: by 2002:a05:600c:34d1:b0:47e:e952:86ca with SMTP id
 5b1f17b1804b1-483201db075mr47622395e9.2.1770402035115; 
 Fri, 06 Feb 2026 10:20:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483207286bcsm63253465e9.12.2026.02.06.10.20.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/10] target/s390x: Un-inline KVM Protected Virtualization
 stubs
Date: Fri,  6 Feb 2026 19:19:48 +0100
Message-ID: <20260206181953.18683-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

By removing the target-specific 'CONFIG_KVM' definition this
header can be used by files in meson common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/kvm/pv.h    | 27 ------------
 target/s390x/kvm/stubs.c | 94 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 27 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index e266fc3d545..ea4b4ec3403 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -20,7 +20,6 @@ struct S390PVResponse {
     uint16_t rc;
 };
 
-#ifdef CONFIG_KVM
 bool s390_is_pv(void);
 int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
@@ -43,31 +42,5 @@ int kvm_s390_dump_init(void);
 int kvm_s390_dump_cpu(S390CPU *cpu, void *buff);
 int kvm_s390_dump_mem_state(uint64_t addr, size_t len, void *dest);
 int kvm_s390_dump_completion_data(void *buff);
-#else /* CONFIG_KVM */
-static inline bool s390_is_pv(void) { return false; }
-static inline int s390_pv_query_info(void) { return 0; }
-static inline int s390_pv_vm_enable(void) { return 0; }
-static inline void s390_pv_vm_disable(void) {}
-static inline bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms) { return false; }
-static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
-                                        struct S390PVResponse *pv_resp,
-                                        Error **errp) { return 0; }
-static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
-                                 struct S390PVResponse *pv_resp) { return 0; }
-static inline void s390_pv_prep_reset(void) {}
-static inline int s390_pv_verify(struct S390PVResponse *pv_resp) { return 0; }
-static inline void s390_pv_unshare(void) {}
-static inline void s390_pv_inject_reset_error(CPUState *cs,
-                                              struct S390PVResponse pv_resp) {};
-static inline uint64_t kvm_s390_pv_dmp_get_size_cpu(void) { return 0; }
-static inline uint64_t kvm_s390_pv_dmp_get_size_mem_state(void) { return 0; }
-static inline uint64_t kvm_s390_pv_dmp_get_size_completion_data(void) { return 0; }
-static inline bool kvm_s390_pv_info_basic_valid(void) { return false; }
-static inline int kvm_s390_dump_init(void) { return 0; }
-static inline int kvm_s390_dump_cpu(S390CPU *cpu, void *buff) { return 0; }
-static inline int kvm_s390_dump_mem_state(uint64_t addr, size_t len,
-                                          void *dest) { return 0; }
-static inline int kvm_s390_dump_completion_data(void *buff) { return 0; }
-#endif /* CONFIG_KVM */
 
 #endif /* HW_S390_PV_H */
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 5fd63b9a7e3..046e1f922b7 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -5,8 +5,102 @@
 #include "qemu/osdep.h"
 
 #include "kvm_s390x.h"
+#include "target/s390x/kvm/pv.h"
 
 int kvm_s390_get_protected_dump(void)
 {
     return false;
 }
+
+bool s390_is_pv(void)
+{
+    return false;
+}
+
+int s390_pv_query_info(void)
+{
+    return 0;
+}
+
+int s390_pv_vm_enable(void)
+{
+    return 0;
+}
+
+void s390_pv_vm_disable(void)
+{
+}
+
+bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
+{
+    return false;
+}
+
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          struct S390PVResponse *pv_resp, Error **errp)
+{
+    return 0;
+}
+
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
+                   struct S390PVResponse *pv_resp)
+{
+    return 0;
+}
+
+void s390_pv_prep_reset(void)
+{
+}
+
+int s390_pv_verify(struct S390PVResponse *pv_resp)
+{
+    return 0;
+}
+
+void s390_pv_unshare(void)
+{
+}
+
+void s390_pv_inject_reset_error(CPUState *cs, struct S390PVResponse pv_resp)
+{
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_cpu(void)
+{
+    return 0;
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_mem_state(void)
+{
+    return 0;
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_completion_data(void)
+{
+    return 0;
+}
+
+bool kvm_s390_pv_info_basic_valid(void)
+{
+    return false;
+}
+
+int kvm_s390_dump_init(void)
+{
+    return 0;
+}
+
+int kvm_s390_dump_cpu(S390CPU *cpu, void *buff)
+{
+    return 0;
+}
+
+int kvm_s390_dump_mem_state(uint64_t addr, size_t len, void *dest)
+{
+    return 0;
+}
+
+int kvm_s390_dump_completion_data(void *buff)
+{
+    return 0;
+}
-- 
2.52.0


