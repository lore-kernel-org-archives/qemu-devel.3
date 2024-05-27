Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2287C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZ6-000769-L8; Sun, 26 May 2024 20:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ0-00072a-SD
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:12 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOYu-0003Ze-KS
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:07 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d19e57c80fso1666735b6e.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771003; x=1717375803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQrV4UMaEBl22gT4Xij+bzAgjXuhBjByp/7UaStu/qs=;
 b=Hjf8t2TzS7HfCn3W4MkT5uTUQQkEASL3ORQm8fP/iNYIrSUN/FmlrLk4CbhyUT0SWd
 UNaE99sFYGOA/Tt9FktRzcFh3UcxqfoO9C7sEG8RukQjjMcUcL8z95GzcCiLn5/ULFcy
 JIV6JWNtAPpubrSVnuH8dVUiYqIwsc3m/rCQXan7sYWxxBeRP79bJr3HfSu08UHMMg70
 K0r9rGnvxrY3r3tM1Jj6SuP2jSsfSXgqTd2r0dZM9+6J27rq698q188sjFcsQUvQxvj0
 GuozBTS4sUAiiYEJgmwGMqiVnVZ5aEfnhaZr6P2zIjXR3CKmnSrh5QRI3yKFKJuomNZl
 sZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771003; x=1717375803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQrV4UMaEBl22gT4Xij+bzAgjXuhBjByp/7UaStu/qs=;
 b=GnxU3wjZhvAER4ux+Ezb7u4eXbRx22qynKfKEbwA/5iMu9PEjFwbaE2OXemyj+Vjcl
 cmQ1MmotH4fyZ4c8Nk3cSwdX5mV2C+kYWDyZXEDlCQSL+gRf4NvfB+SXFu0o4RqNWUQR
 QRdE95j+z4tcxoJ6wC9HgDlTCD2WO0wW+dvDsy0QI6NA8y3PPd/hBU6iOhlwNfVT/w+7
 CxvOLgH+bictrZkh/LxAsvIf3boh6qYI+7PhPZRxPu3v6Ts7G6q7llW8VSZdsTpEOlxW
 x4cR/Q0C0zLZhttQ5o/RWVo6IjxKHr5P+fslm/s70/3bdo/YXmO5YSnxax84118ZGh1S
 Mlcg==
X-Gm-Message-State: AOJu0Yyz983z5Nprg0pk03EgyS8Q1H7p93iOxXDweazTQNG/1n8bOzrg
 W4NUmqwZZGX+16SZT/xKbqUawNBO78cLjxdsqwSN2ZkiFx8a9BRei9zKgcV3xDqTmxGxbb6ctI2
 J
X-Google-Smtp-Source: AGHT+IHDrIobzXa8wXZ1pbgkcgMPfKLQ0jH2r7xPa6m/K5gjT+jYw7xa38L4D7359lvasNSTZpchmw==
X-Received: by 2002:a05:6808:144:b0:3c6:efde:7a45 with SMTP id
 5614622812f47-3d1a7a2dd0cmr8372080b6e.50.1716771003367; 
 Sun, 26 May 2024 17:50:03 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/28] target/i386: Add tcg/access.[ch]
Date: Sun, 26 May 2024 17:49:34 -0700
Message-Id: <20240527005001.642825-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Provide a method to amortize page lookup across large blocks.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/access.h    |  40 +++++++++
 target/i386/tcg/access.c    | 169 ++++++++++++++++++++++++++++++++++++
 target/i386/tcg/meson.build |   1 +
 3 files changed, 210 insertions(+)
 create mode 100644 target/i386/tcg/access.h
 create mode 100644 target/i386/tcg/access.c

diff --git a/target/i386/tcg/access.h b/target/i386/tcg/access.h
new file mode 100644
index 0000000000..d70808a3a3
--- /dev/null
+++ b/target/i386/tcg/access.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Access guest memory in blocks. */
+
+#ifndef X86_TCG_ACCESS_H
+#define X86_TCG_ACCESS_H
+
+/* An access covers at most sizeof(X86XSaveArea), at most 2 pages. */
+typedef struct X86Access {
+    target_ulong vaddr;
+    void *haddr1;
+    void *haddr2;
+    uint16_t size;
+    uint16_t size1;
+    /*
+     * If we can't access the host page directly, we'll have to do I/O access
+     * via ld/st helpers. These are internal details, so we store the rest
+     * to do the access here instead of passing it around in the helpers.
+     */
+    int mmu_idx;
+    CPUX86State *env;
+    uintptr_t ra;
+} X86Access;
+
+void access_prepare_mmu(X86Access *ret, CPUX86State *env,
+                        vaddr vaddr, unsigned size,
+                        MMUAccessType type, int mmu_idx, uintptr_t ra);
+void access_prepare(X86Access *ret, CPUX86State *env, vaddr vaddr,
+                    unsigned size, MMUAccessType type, uintptr_t ra);
+
+uint8_t  access_ldb(X86Access *ac, vaddr addr);
+uint16_t access_ldw(X86Access *ac, vaddr addr);
+uint32_t access_ldl(X86Access *ac, vaddr addr);
+uint64_t access_ldq(X86Access *ac, vaddr addr);
+
+void access_stb(X86Access *ac, vaddr addr, uint8_t val);
+void access_stw(X86Access *ac, vaddr addr, uint16_t val);
+void access_stl(X86Access *ac, vaddr addr, uint32_t val);
+void access_stq(X86Access *ac, vaddr addr, uint64_t val);
+
+#endif
diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
new file mode 100644
index 0000000000..56a1181ea5
--- /dev/null
+++ b/target/i386/tcg/access.c
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Access guest memory in blocks. */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
+#include "access.h"
+
+
+void access_prepare_mmu(X86Access *ret, CPUX86State *env,
+                        vaddr vaddr, unsigned size,
+                        MMUAccessType type, int mmu_idx, uintptr_t ra)
+{
+    int size1, size2;
+    void *haddr1, *haddr2;
+
+    assert(size > 0 && size <= TARGET_PAGE_SIZE);
+
+    size1 = MIN(size, -(vaddr | TARGET_PAGE_MASK)),
+    size2 = size - size1;
+
+    memset(ret, 0, sizeof(*ret));
+    ret->vaddr = vaddr;
+    ret->size = size;
+    ret->size1 = size1;
+    ret->mmu_idx = mmu_idx;
+    ret->env = env;
+    ret->ra = ra;
+
+    haddr1 = probe_access(env, vaddr, size1, type, mmu_idx, ra);
+    ret->haddr1 = haddr1;
+
+    if (unlikely(size2)) {
+        haddr2 = probe_access(env, vaddr + size1, size2, type, mmu_idx, ra);
+        if (haddr2 == haddr1 + size1) {
+            ret->size1 = size;
+        } else {
+#ifdef CONFIG_USER_ONLY
+            g_assert_not_reached();
+#else
+            ret->haddr2 = haddr2;
+#endif
+        }
+    }
+}
+
+void access_prepare(X86Access *ret, CPUX86State *env, vaddr vaddr,
+                    unsigned size, MMUAccessType type, uintptr_t ra)
+{
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    access_prepare_mmu(ret, env, vaddr, size, type, mmu_idx, ra);
+}
+
+static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
+{
+    vaddr offset = addr - ac->vaddr;
+
+    assert(addr >= ac->vaddr);
+
+#ifdef CONFIG_USER_ONLY
+    assert(offset <= ac->size1 - len);
+    return ac->haddr1 + offset;
+#else
+    if (likely(offset <= ac->size1 - len)) {
+        return ac->haddr1 + offset;
+    }
+    assert(offset <= ac->size - len);
+    /*
+     * If the address is not naturally aligned, it might span both pages.
+     * Only return ac->haddr2 if the area is entirely within the second page,
+     * otherwise fall back to slow accesses.
+     */
+    if (likely(offset >= ac->size1)) {
+        return ac->haddr2 + (offset - ac->size1);
+    }
+    return NULL;
+#endif
+}
+
+#ifdef CONFIG_USER_ONLY
+# define test_ptr(p)  true
+#else
+# define test_ptr(p)  likely(p)
+#endif
+
+uint8_t access_ldb(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint8_t));
+
+    if (test_ptr(p)) {
+        return ldub_p(p);
+    }
+    return cpu_ldub_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+uint16_t access_ldw(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint16_t));
+
+    if (test_ptr(p)) {
+        return lduw_le_p(p);
+    }
+    return cpu_lduw_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+uint32_t access_ldl(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint32_t));
+
+    if (test_ptr(p)) {
+        return ldl_le_p(p);
+    }
+    return cpu_ldl_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+uint64_t access_ldq(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint64_t));
+
+    if (test_ptr(p)) {
+        return ldq_le_p(p);
+    }
+    return cpu_ldq_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+void access_stb(X86Access *ac, vaddr addr, uint8_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint8_t));
+
+    if (test_ptr(p)) {
+        stb_p(p, val);
+    } else {
+        cpu_stb_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
+
+void access_stw(X86Access *ac, vaddr addr, uint16_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint16_t));
+
+    if (test_ptr(p)) {
+        stw_le_p(p, val);
+    } else {
+        cpu_stw_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
+
+void access_stl(X86Access *ac, vaddr addr, uint32_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint32_t));
+
+    if (test_ptr(p)) {
+        stl_le_p(p, val);
+    } else {
+        cpu_stl_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
+
+void access_stq(X86Access *ac, vaddr addr, uint64_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint64_t));
+
+    if (test_ptr(p)) {
+        stq_le_p(p, val);
+    } else {
+        cpu_stq_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
diff --git a/target/i386/tcg/meson.build b/target/i386/tcg/meson.build
index f9110e890c..1105b35d92 100644
--- a/target/i386/tcg/meson.build
+++ b/target/i386/tcg/meson.build
@@ -1,4 +1,5 @@
 i386_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'access.c',
   'bpt_helper.c',
   'cc_helper.c',
   'excp_helper.c',
-- 
2.34.1


