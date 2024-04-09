Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656FCD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dZ-000364-Hw; Tue, 09 Apr 2024 01:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dV-00035A-SO
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dU-0005C7-2M
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6eced6fd98aso4607126b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638986; x=1713243786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=deMS08IZ066zxxT6J5vjnKajDpbmm9n8+soIwY3Yceg=;
 b=gBRzSrz/DD6bx2iyueT1CxiXKV1jclO3Is+m3/K3Rp1AgDxHj5PuwZmEQMRieDiEVK
 mdrTC7TfQvarCIWnWOgxHSjZKmCtV+xYF25gusVtxTW4jas6QbiQYoQ+9KjIwIMIXhep
 yMZieGAIkYrvUC6x36CZJA7P5B+P+dAWjv49KhYVcuE2fmQUv9pT8Uv3PhsVE4XUnfzD
 Z86r1B6SJ8p/1EZhyijSdDv9ZywQUjIfT6446FZh2TMe216z199wyR0wfLfazCIDa6QA
 kBZol09OB8KiPkrANjdSrZpV/ZdMasIxOhwF3kaLZav5IrNOxl8gqRR0xOTbp2pj+t/p
 Wkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638986; x=1713243786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=deMS08IZ066zxxT6J5vjnKajDpbmm9n8+soIwY3Yceg=;
 b=qlJGMXmoBpTMogxt6eBtmRBopcBj9lkmLo5BuS+IEAAt30K9Rp4lrCcUUh3wqAFOku
 HiqEWpDe4W5j8ooILwMKWEWSgs2BI7RBNMJSucv+dZK3GkgCZxvj86fub+6QEzyZtcwO
 rGke5ggikoMnD3tRRWbhlyMpKGqSGCZQUSQ9cLmdLRRsi4boXBXgyEqXB7JnXe2CqbqQ
 D0DCXPeCjhHBCDSX7q/qPUJluYssPZ1sYuFbcOlzPSrbjf8BEE2NCrY8kA5wOa48qAkc
 ZjpVXmPZ7lOhLSoIlMQID/VPWCHlgAgwAsBOXvBYdn0QARW2bn1cA/yAdoOyteJnHDcE
 iPYQ==
X-Gm-Message-State: AOJu0YwkvBu2RFLFf/nxmZIiRWGMoIDaUZuFncbRBrtF5nscaDsJYTEm
 7LIPhJFDFBlbIOIb4YkMtdWugMXbCEMBVCO9Mzo6x/A0Qrj9z+BaHPWQuF0932Z8U1/jwKs1TuA
 v
X-Google-Smtp-Source: AGHT+IEHpazKrfWYH9MkVgSZI3pQYi3Pvj5fcEsYFP0KcgXcXZF4K5EsHngCbbVN5zzcf1UviCgUqg==
X-Received: by 2002:a05:6a00:c85:b0:6ea:e009:1ae6 with SMTP id
 a5-20020a056a000c8500b006eae0091ae6mr14465230pfv.25.1712638986261; 
 Mon, 08 Apr 2024 22:03:06 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/28] target/i386: Add tcg/access.[ch]
Date: Mon,  8 Apr 2024 19:02:35 -1000
Message-Id: <20240409050302.1523277-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Provide a method to amortize page lookup across large blocks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/access.h    |  40 +++++++++
 target/i386/tcg/access.c    | 160 ++++++++++++++++++++++++++++++++++++
 target/i386/tcg/meson.build |   1 +
 3 files changed, 201 insertions(+)
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
index 0000000000..8b70f3244b
--- /dev/null
+++ b/target/i386/tcg/access.c
@@ -0,0 +1,160 @@
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
+            ret->haddr2 = haddr2;
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
+        return ac->haddr1;
+    }
+    assert(offset <= ac->size - len);
+    if (likely(offset >= ac->size1)) {
+        return ac->haddr2;
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


