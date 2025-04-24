Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62C6C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmt-0005Ll-RL; Wed, 23 Apr 2025 20:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmq-0005HR-SC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmo-0004Lu-I7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso508972b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455793; x=1746060593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eyx3jHfuOzS1kFXjXoFUhMf/lfjFavDcf4Lxs2+4npE=;
 b=wu4DiSML04lIJGNqAcbMcL7AiRAui/A7+jMIWhW/GbdfiEof8e3yqjE4tGzDUGonx2
 84MueCu9+yuqTCmWLCdUj8THGIdWbXn9o4xoaWAbbwAUggPo2rELSDb2DpX6vrryu7xU
 GTmtQTqOl23v95kPBBD+mlLNk6DANfgX4/tDeOP14lNleEwVdiljgb2nz3PJAVLevhyM
 JiLNlQDG2v00tRHKIcTn25R2N/bDgT9gOiS8zdeldKsbZzmdd1CpxswazuQaTi2lGrx0
 d1vJPltJenqxoY3i74S5vddMkSUcJk4WUjnl06xIvrwdEDlZgIp0EMfSCHc/lLjH1MOR
 QAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455793; x=1746060593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eyx3jHfuOzS1kFXjXoFUhMf/lfjFavDcf4Lxs2+4npE=;
 b=ZQHvA+bWFwTKVYLFtydz2iZKzBhhi7puSX1qbzH41mIVjlUTt5ghCl33mP2Q8r3QBG
 3Yvlb6HHp4wPUUman5A7mgFfZ6edXcrvDxe+psT5pxYuv3nmv+BZfM5kCluMRMYWv0i7
 ft2OvGotx36j0odj+CdMTKzad20jIJsLOSFT1b18V4TvCY6LXuN9EQ+6hhg6ANmlFV5P
 EB9ZRPm6AVYcfvMkfurS3R2Qlo5LqsVeYTd5hme/9324sKpDFE/7s8vITsmfyCh8XxbJ
 kII7zd+FhpZ2IwVFcPKZAqNEZaOodDdECNxGea9pANMkZzCoGCJTaD2IfziokJg+ZAWY
 j+Ug==
X-Gm-Message-State: AOJu0YxvF/dpnSj1i1mf26X4hxORzWDAeOU+JLyyxLygmPjVu5XVh5Qa
 yLf1wgJSNHb5v0jzteRH9pQ7lusAlLJMPP0JdFKYq4wZ5Tjx9PDA2X1zSO0ACmYEVQS+yJQhVLc
 Q
X-Gm-Gg: ASbGncuM6LVZp3EYnJFX0qUmgB/ABprkk1/57f6/0lSYF82D2nV/2NKiEnfFIvLtlFQ
 NuGC/UKX/+6Gl5kAo+t4OsoOEgvLrp3H6U+DsxErWLWNd6LH8Cmkul2dmBBoEEYFnogxf24kV7n
 0OEKhlXFWVN9ihO01ma2FEvuEnJmvuoLa9C0d7pp3a46g1K3HPd+vbq2YCFPPX0fHfWu4mTIuQr
 9++jlyoetGGhVbTbFuco1tkdQpoUz9KK8UNZq2wnPC7iHycKTrv4/ZaDw1zGRFVZJnzQsGmAgQX
 +pUszrHFy8XQui/MM3pO7oLSoPJg0rMqa0KtM2jzt3Gu3e4Sg6hGPwSLWuNjW0UreVXGoQESs3f
 W277b5EsJsQ==
X-Google-Smtp-Source: AGHT+IEutKO8IzaHBK4MJiYC8oEf9PCKsrCxgVHBc4s7cjic2O52ySXfJi/qXPTn9VMIHqjSxL7N+Q==
X-Received: by 2002:a05:6a00:6c98:b0:737:cd8:2484 with SMTP id
 d2e1a72fcca58-73e267e25dfmr660317b3a.6.1745455793159; 
 Wed, 23 Apr 2025 17:49:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 023/148] include/exec: Split out cpu-ldst-common.h
Date: Wed, 23 Apr 2025 17:47:28 -0700
Message-ID: <20250424004934.598783-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Split out the *_mmu api, which no longer uses
target specific argument types.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-ldst-common.h | 122 +++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h        | 108 +----------------------------
 2 files changed, 123 insertions(+), 107 deletions(-)
 create mode 100644 include/exec/cpu-ldst-common.h

diff --git a/include/exec/cpu-ldst-common.h b/include/exec/cpu-ldst-common.h
new file mode 100644
index 0000000000..c46a6ade5d
--- /dev/null
+++ b/include/exec/cpu-ldst-common.h
@@ -0,0 +1,122 @@
+/*
+ * Software MMU support
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef CPU_LDST_COMMON_H
+#define CPU_LDST_COMMON_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+#include "exec/memopidx.h"
+#include "exec/vaddr.h"
+#include "exec/mmu-access-type.h"
+#include "qemu/int128.h"
+
+uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
+
+void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
+                  MemOpIdx oi, uintptr_t ra);
+
+uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
+                                 uint32_t cmpv, uint32_t newv,
+                                 MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
+                                    uint64_t cmpv, uint64_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
+                                    uint64_t cmpv, uint64_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+
+#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
+TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
+    (CPUArchState *env, vaddr addr, TYPE val,   \
+     MemOpIdx oi, uintptr_t retaddr);
+
+#ifdef CONFIG_ATOMIC64
+#define GEN_ATOMIC_HELPER_ALL(NAME)          \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
+#else
+#define GEN_ATOMIC_HELPER_ALL(NAME)          \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
+#endif
+
+GEN_ATOMIC_HELPER_ALL(fetch_add)
+GEN_ATOMIC_HELPER_ALL(fetch_sub)
+GEN_ATOMIC_HELPER_ALL(fetch_and)
+GEN_ATOMIC_HELPER_ALL(fetch_or)
+GEN_ATOMIC_HELPER_ALL(fetch_xor)
+GEN_ATOMIC_HELPER_ALL(fetch_smin)
+GEN_ATOMIC_HELPER_ALL(fetch_umin)
+GEN_ATOMIC_HELPER_ALL(fetch_smax)
+GEN_ATOMIC_HELPER_ALL(fetch_umax)
+
+GEN_ATOMIC_HELPER_ALL(add_fetch)
+GEN_ATOMIC_HELPER_ALL(sub_fetch)
+GEN_ATOMIC_HELPER_ALL(and_fetch)
+GEN_ATOMIC_HELPER_ALL(or_fetch)
+GEN_ATOMIC_HELPER_ALL(xor_fetch)
+GEN_ATOMIC_HELPER_ALL(smin_fetch)
+GEN_ATOMIC_HELPER_ALL(umin_fetch)
+GEN_ATOMIC_HELPER_ALL(smax_fetch)
+GEN_ATOMIC_HELPER_ALL(umax_fetch)
+
+GEN_ATOMIC_HELPER_ALL(xchg)
+
+#undef GEN_ATOMIC_HELPER_ALL
+#undef GEN_ATOMIC_HELPER
+
+Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
+                                  Int128 cmpv, Int128 newv,
+                                  MemOpIdx oi, uintptr_t retaddr);
+Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
+                                  Int128 cmpv, Int128 newv,
+                                  MemOpIdx oi, uintptr_t retaddr);
+
+uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
+                         MemOpIdx oi, uintptr_t ra);
+uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
+                          MemOpIdx oi, uintptr_t ra);
+uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
+                          MemOpIdx oi, uintptr_t ra);
+uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
+                          MemOpIdx oi, uintptr_t ra);
+
+#endif /* CPU_LDST_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index ddd8e0cf48..1fbdbe59ae 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -66,11 +66,8 @@
 #error Can only include this header with TCG
 #endif
 
-#include "exec/memopidx.h"
-#include "exec/vaddr.h"
+#include "exec/cpu-ldst-common.h"
 #include "exec/abi_ptr.h"
-#include "exec/mmu-access-type.h"
-#include "qemu/int128.h"
 
 #if defined(CONFIG_USER_ONLY)
 #include "user/guest-host.h"
@@ -157,100 +154,6 @@ void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
 void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
                           int mmu_idx, uintptr_t ra);
 
-uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
-
-void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
-                  MemOpIdx oi, uintptr_t ra);
-
-uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
-                                 uint32_t cmpv, uint32_t newv,
-                                 MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint64_t cmpv, uint64_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint64_t cmpv, uint64_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-
-#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
-TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
-    (CPUArchState *env, vaddr addr, TYPE val, \
-     MemOpIdx oi, uintptr_t retaddr);
-
-#ifdef CONFIG_ATOMIC64
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
-#else
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
-#endif
-
-GEN_ATOMIC_HELPER_ALL(fetch_add)
-GEN_ATOMIC_HELPER_ALL(fetch_sub)
-GEN_ATOMIC_HELPER_ALL(fetch_and)
-GEN_ATOMIC_HELPER_ALL(fetch_or)
-GEN_ATOMIC_HELPER_ALL(fetch_xor)
-GEN_ATOMIC_HELPER_ALL(fetch_smin)
-GEN_ATOMIC_HELPER_ALL(fetch_umin)
-GEN_ATOMIC_HELPER_ALL(fetch_smax)
-GEN_ATOMIC_HELPER_ALL(fetch_umax)
-
-GEN_ATOMIC_HELPER_ALL(add_fetch)
-GEN_ATOMIC_HELPER_ALL(sub_fetch)
-GEN_ATOMIC_HELPER_ALL(and_fetch)
-GEN_ATOMIC_HELPER_ALL(or_fetch)
-GEN_ATOMIC_HELPER_ALL(xor_fetch)
-GEN_ATOMIC_HELPER_ALL(smin_fetch)
-GEN_ATOMIC_HELPER_ALL(umin_fetch)
-GEN_ATOMIC_HELPER_ALL(smax_fetch)
-GEN_ATOMIC_HELPER_ALL(umax_fetch)
-
-GEN_ATOMIC_HELPER_ALL(xchg)
-
-#undef GEN_ATOMIC_HELPER_ALL
-#undef GEN_ATOMIC_HELPER
-
-Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
-                                  Int128 cmpv, Int128 newv,
-                                  MemOpIdx oi, uintptr_t retaddr);
-Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
-                                  Int128 cmpv, Int128 newv,
-                                  MemOpIdx oi, uintptr_t retaddr);
-
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -297,15 +200,6 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 
-uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
-                         MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
-                          MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
-                          MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
-                          MemOpIdx oi, uintptr_t ra);
-
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
-- 
2.43.0


