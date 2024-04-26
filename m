Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAD4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVw-0002qX-K9; Fri, 26 Apr 2024 15:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVr-0002TA-Tq
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:40 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVo-0004nQ-Ss
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572242ed990so2774251a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160735; x=1714765535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1K8YiKF1aId8lywgtec1SE+/hOSGvJR5IQSEQZIayng=;
 b=ivfiCW9hgdA8Nl9aV1jfsO+g+9BR4000Df/iY/egOXKgRXsvAA33hc7VLVWSK9BJz1
 kvglLqeHVinuFNW40D4nFZ7elGjLmJLgo5wV4vRT/P32PF1JAoezpj36/+6R8XsTk6Ur
 phxXYuVu/2zWiZFeFnhxGRXwejfBrkL0wLECaud659mdE3UG7ofSSis0BgXT+GNWCtvi
 55VK+v2G2q6/9jtgJSWbL3x3e7UrKiuGJ8zUZSxHzsE/gHl2HIwRwA5O/HVAtf2ore8M
 KRHYRGygP8jXYNYiXIwy9JB3TeiGfq9e0aFg7qzO+4IPuj9AiHzgai2nqETMG9zwzVXe
 Rzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160735; x=1714765535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1K8YiKF1aId8lywgtec1SE+/hOSGvJR5IQSEQZIayng=;
 b=ENQx2554iIVre1rGoWJ+qAmf2uPcmVJEqZNVphPmbxrhQTRLiK/sabtIfGk4HdNjak
 H6teNO0wsJ9FWa1J4ePQ6DZu0JE2/3t2n+ig49Qe9xjgCslmfWibQtBZ5T0B2RBoEDHN
 BaGDyw+p+UIn8m2/bT+qotd9DU0lVXH2qL8H18WYahz/MvJis63IQBMxDXg54KKcINRw
 rZ7DwmY7j2xg7RCL14Kv+VkXRBpuH1kNW4oTBondSA4wJ8VWQt5agLX6Lxg0L9PUG/8b
 2bGZy5vNSv7mNDWuRxPGa2J2E7YfFM61FrruyWwkHjyHF+UGsOqAFG5/bZqpQ7GgH8Vd
 9ZFw==
X-Gm-Message-State: AOJu0YxdFVv2aFk2echIZLfrqpKUYVwIhshQs6tfWhNstoHyka0uxh45
 0t6am4NC5LPaZ61DyF+Drvd7PhKpVaYVgMJVXQdbWpqg/JB2BC0KF+ZutYLkgi+Vxs5E+jsDh1o
 8aOc=
X-Google-Smtp-Source: AGHT+IG/2Z9324IHHq49V3rjB75zC32hEfEKIBJS45GUBl9UIufcCPAkk+i00Rt33wQOKXS+OJYWpA==
X-Received: by 2002:a50:cd15:0:b0:56e:2e0:79d1 with SMTP id
 z21-20020a50cd15000000b0056e02e079d1mr2851870edi.4.1714160735082; 
 Fri, 26 Apr 2024 12:45:35 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 fk6-20020a056402398600b00571ba529bbasm10313860edb.44.2024.04.26.12.45.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 36/38] exec: Move CPUTLBEntry helpers to cputlb.c
Date: Fri, 26 Apr 2024 21:41:56 +0200
Message-ID: <20240426194200.43723-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

The following CPUTLBEntry helpers are only used in accel/tcg/cputlb.c:
  - tlb_index()
  - tlb_entry()
  - tlb_read_idx()
  - tlb_addr_write()

Move them to this file, allowing to remove the huge "cpu.h" header
inclusion from "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-13-philmd@linaro.org>
---
 include/exec/cpu_ldst.h | 55 -----------------------------------------
 accel/tcg/cputlb.c      | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 7d0a0412ad..11ba3778ba 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -70,7 +70,6 @@
 #include "exec/abi_ptr.h"
 #include "exec/mmu-access-type.h"
 #include "qemu/int128.h"
-#include "cpu.h"
 
 #if defined(CONFIG_USER_ONLY)
 
@@ -296,60 +295,6 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
-#if !defined(CONFIG_USER_ONLY)
-
-#include "tcg/oversized-guest.h"
-
-static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
-                                    MMUAccessType access_type)
-{
-    /* Do not rearrange the CPUTLBEntry structure members. */
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * sizeof(uint64_t));
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * sizeof(uint64_t));
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uint64_t));
-
-#if TARGET_LONG_BITS == 32
-    /* Use qatomic_read, in case of addr_write; only care about low bits. */
-    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
-    ptr += HOST_BIG_ENDIAN;
-    return qatomic_read(ptr);
-#else
-    const uint64_t *ptr = &entry->addr_idx[access_type];
-# if TCG_OVERSIZED_GUEST
-    return *ptr;
-# else
-    /* ofs might correspond to .addr_write, so use qatomic_read */
-    return qatomic_read(ptr);
-# endif
-#endif
-}
-
-static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
-{
-    return tlb_read_idx(entry, MMU_DATA_STORE);
-}
-
-/* Find the TLB index corresponding to the mmu_idx + address pair.  */
-static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
-                                  vaddr addr)
-{
-    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
-
-    return (addr >> TARGET_PAGE_BITS) & size_mask;
-}
-
-/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
-static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
-                                     vaddr addr)
-{
-    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
-}
-
-#endif /* !defined(CONFIG_USER_ONLY) */
-
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e16d02a62c..953c437ba9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -27,6 +27,9 @@
 #include "exec/tb-flush.h"
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "exec/mmu-access-type.h"
+#include "exec/tlb-common.h"
+#include "exec/vaddr.h"
 #include "tcg/tcg.h"
 #include "qemu/error-report.h"
 #include "exec/log.h"
@@ -95,6 +98,54 @@ static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
     return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
 }
 
+static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
+                                    MMUAccessType access_type)
+{
+    /* Do not rearrange the CPUTLBEntry structure members. */
+    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
+                      MMU_DATA_LOAD * sizeof(uint64_t));
+    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
+                      MMU_DATA_STORE * sizeof(uint64_t));
+    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
+                      MMU_INST_FETCH * sizeof(uint64_t));
+
+#if TARGET_LONG_BITS == 32
+    /* Use qatomic_read, in case of addr_write; only care about low bits. */
+    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
+    ptr += HOST_BIG_ENDIAN;
+    return qatomic_read(ptr);
+#else
+    const uint64_t *ptr = &entry->addr_idx[access_type];
+# if TCG_OVERSIZED_GUEST
+    return *ptr;
+# else
+    /* ofs might correspond to .addr_write, so use qatomic_read */
+    return qatomic_read(ptr);
+# endif
+#endif
+}
+
+static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
+{
+    return tlb_read_idx(entry, MMU_DATA_STORE);
+}
+
+/* Find the TLB index corresponding to the mmu_idx + address pair.  */
+static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
+                                  vaddr addr)
+{
+    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
+
+    return (addr >> TARGET_PAGE_BITS) & size_mask;
+}
+
+/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
+static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
+                                     vaddr addr)
+{
+    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
+}
+
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
                              size_t max_entries)
 {
-- 
2.41.0


