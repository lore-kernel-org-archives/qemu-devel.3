Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7016BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0qr-00046G-OG; Mon, 17 Feb 2025 08:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0qb-0003rc-Lz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:07:44 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0qZ-0004vA-Hy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:07:41 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso5291574a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797657; x=1740402457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJIia44DGrjZyTLCck3b7pQzZNSq4mcpp1g0jS1BWP4=;
 b=DxiiGDvG/5ByU23p9y4vixrCgoL7+Ys36YAH3YwTkpuHvstltWvOiXZSh2s8SpuZO6
 SXtbturKzolzmE6gfWqUiWEcq1EV5s7RuEx+w9TTJhzhL4WsaWWc6U4xDnbdFwXQ+xTG
 iOIfGLghwQcCVJCG033E/qOrJY93NYh1Ie3AxYVY2jlmr5nP0cqKmN07kIBxId6UEaLz
 TkFWluVdbjtGM5S01/SGOUAIZXVLGNmsahqtepUQjonbrMrA9z2bTk3wZtU6UGJEvNyK
 y7gpW4/HSjwaKRS6qRsm2Yy4ySz8clP97t4fqd5FMMfZf0Mc0XXq4/vdsV2b8lHtOgw1
 RIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797657; x=1740402457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJIia44DGrjZyTLCck3b7pQzZNSq4mcpp1g0jS1BWP4=;
 b=owxCnVuJoM8s236NeVmqRiK8psDiJAxySm9FLNXzwe5C1w7ALqsydD0CCo9oN6dwRv
 JfgZEgt78qHoxvCj+1lW1ZDDSIYWEJNjIiy4CgHNeD6qHgg4UJ6mGnbT6s+EiVPa2LCO
 lj8OO96WwgB9bP9sp9hhA9wLGMJNQQHo0FKNfMGmK12bULQVIVN+XGi5Ew3NEJMo8fMF
 Om0sKL7yEeaajxFZ0Q1OATVCH6JkNpcIZu85HeKAdxuX5KUgwHLrqGKht6wahNP4phxe
 hZAuCtXNtNAxn3rt6Lfu/UTDUAaGu0WcZRHUqYWaLDvNYZq6ZJ9ejHYfj6eCytFMpXXK
 UilA==
X-Gm-Message-State: AOJu0YxtkVTaEKYwGzdE3awWyS249d9OwPGrbWX/JvQnFhePgvxXR19G
 irZwhECJYhpVALSsQWGdP0hwy9eYTPYydBhvY7JtdVIHxQrxog0vgklr5WRJWkqoF/NdSVAl5KO
 sQpA=
X-Gm-Gg: ASbGncvJGKQWKYRt6bR13IdB5GXKtfADUp1iMonq/y+5t+V8S6V0za9Cx03+2V9v3jg
 sRSEzK2aTtq3uGsdhBCN23FS6sKDnReaWmiBDjEaBBWcGbf9Vgw5D0Ll/0Xdklks5OJkfuEWcmL
 zjRSmVln+wNLu1fuMsvmwImGBq/YZyAx6tyDOiNpOl3PfWhjLogkHc9FHh3JPmT+tx4TKDuB70d
 S7o9duyhrcqbiWTxZMVn09kjpCSSNQuAy1HSMcWf/JLgEplFYi12pGlBcFjoim9LbfMbMoQCcoz
 WTjOUoymCiZSkLx7vsNv8fFVoBnw8zz+RNe76Me0bJk=
X-Google-Smtp-Source: AGHT+IEIdYjO9G+dts1wVsvojDNY9xhxoX2XLKs3F1nGPDUr7F8qqHL6sN39GCj6ItrqoNQ5rCo/Ww==
X-Received: by 2002:a17:90b:3ec5:b0:2fa:20f4:d27a with SMTP id
 98e67ed59e1d1-2fc40d12e34mr16599021a91.7.1739797657466; 
 Mon, 17 Feb 2025 05:07:37 -0800 (PST)
Received: from localhost.localdomain ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596133sm71399385ad.259.2025.02.17.05.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Feb 2025 05:07:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] accel/tcg: Move cpu_memory_rw_debug() user implementation
 to user-exec.c
Date: Mon, 17 Feb 2025 14:06:10 +0100
Message-ID: <20250217130610.18313-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217130610.18313-1-philmd@linaro.org>
References: <20250217130610.18313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1029.google.com
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

cpu_memory_rw_debug() system implementation is defined in
system/physmem.c. Move the user one to accel/tcg/user-exec.c
to simplify cpu-target.c maintenance.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec.c | 80 ++++++++++++++++++++++++++++++++++++++
 cpu-target.c          | 90 +------------------------------------------
 2 files changed, 82 insertions(+), 88 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 9d53c9440ea..2322181b151 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
+#include "exec/vaddr.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
@@ -971,6 +972,85 @@ static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
     return ret;
 }
 
+/* physical memory access (slow version, mainly for debug) */
+int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
+                        void *ptr, size_t len, bool is_write)
+{
+    int flags;
+    vaddr l, page;
+    uint8_t *buf = ptr;
+    ssize_t written;
+    int ret = -1;
+    int fd = -1;
+
+    mmap_lock();
+
+    while (len > 0) {
+        page = addr & TARGET_PAGE_MASK;
+        l = (page + TARGET_PAGE_SIZE) - addr;
+        if (l > len) {
+            l = len;
+        }
+        flags = page_get_flags(page);
+        if (!(flags & PAGE_VALID)) {
+            goto out_close;
+        }
+        if (is_write) {
+            if (flags & PAGE_WRITE) {
+                memcpy(g2h(cpu, addr), buf, l);
+            } else {
+                /* Bypass the host page protection using ptrace. */
+                if (fd == -1) {
+                    fd = open("/proc/self/mem", O_WRONLY);
+                    if (fd == -1) {
+                        goto out;
+                    }
+                }
+                /*
+                 * If there is a TranslationBlock and we weren't bypassing the
+                 * host page protection, the memcpy() above would SEGV,
+                 * ultimately leading to page_unprotect(). So invalidate the
+                 * translations manually. Both invalidation and pwrite() must
+                 * be under mmap_lock() in order to prevent the creation of
+                 * another TranslationBlock in between.
+                 */
+                tb_invalidate_phys_range(addr, addr + l - 1);
+                written = pwrite(fd, buf, l,
+                                 (off_t)(uintptr_t)g2h_untagged(addr));
+                if (written != l) {
+                    goto out_close;
+                }
+            }
+        } else if (flags & PAGE_READ) {
+            memcpy(buf, g2h(cpu, addr), l);
+        } else {
+            /* Bypass the host page protection using ptrace. */
+            if (fd == -1) {
+                fd = open("/proc/self/mem", O_RDONLY);
+                if (fd == -1) {
+                    goto out;
+                }
+            }
+            if (pread(fd, buf, l,
+                      (off_t)(uintptr_t)g2h_untagged(addr)) != l) {
+                goto out_close;
+            }
+        }
+        len -= l;
+        buf += l;
+        addr += l;
+    }
+    ret = 0;
+out_close:
+    if (fd != -1) {
+        close(fd);
+    }
+out:
+    mmap_unlock();
+
+    return ret;
+}
+
 #include "ldst_atomicity.c.inc"
 
 static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
diff --git a/cpu-target.c b/cpu-target.c
index 3892ce12229..83688f1d508 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,18 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-
-#include "exec/target_page.h"
-#include "exec/page-protection.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "migration/vmstate.h"
-#ifdef CONFIG_USER_ONLY
-#include "qemu.h"
-#include "user/page-protection.h"
-#else
+#ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
@@ -43,11 +37,11 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
+#include "hw/core/cpu.h"
 
 #ifndef CONFIG_USER_ONLY
 static int cpu_common_post_load(void *opaque, int version_id)
@@ -367,86 +361,6 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     abort();
 }
 
-/* physical memory access (slow version, mainly for debug) */
-#if defined(CONFIG_USER_ONLY)
-int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                        void *ptr, size_t len, bool is_write)
-{
-    int flags;
-    vaddr l, page;
-    uint8_t *buf = ptr;
-    ssize_t written;
-    int ret = -1;
-    int fd = -1;
-
-    mmap_lock();
-
-    while (len > 0) {
-        page = addr & TARGET_PAGE_MASK;
-        l = (page + TARGET_PAGE_SIZE) - addr;
-        if (l > len)
-            l = len;
-        flags = page_get_flags(page);
-        if (!(flags & PAGE_VALID)) {
-            goto out_close;
-        }
-        if (is_write) {
-            if (flags & PAGE_WRITE) {
-                memcpy(g2h(cpu, addr), buf, l);
-            } else {
-                /* Bypass the host page protection using ptrace. */
-                if (fd == -1) {
-                    fd = open("/proc/self/mem", O_WRONLY);
-                    if (fd == -1) {
-                        goto out;
-                    }
-                }
-                /*
-                 * If there is a TranslationBlock and we weren't bypassing the
-                 * host page protection, the memcpy() above would SEGV,
-                 * ultimately leading to page_unprotect(). So invalidate the
-                 * translations manually. Both invalidation and pwrite() must
-                 * be under mmap_lock() in order to prevent the creation of
-                 * another TranslationBlock in between.
-                 */
-                tb_invalidate_phys_range(addr, addr + l - 1);
-                written = pwrite(fd, buf, l,
-                                 (off_t)(uintptr_t)g2h_untagged(addr));
-                if (written != l) {
-                    goto out_close;
-                }
-            }
-        } else if (flags & PAGE_READ) {
-            memcpy(buf, g2h(cpu, addr), l);
-        } else {
-            /* Bypass the host page protection using ptrace. */
-            if (fd == -1) {
-                fd = open("/proc/self/mem", O_RDONLY);
-                if (fd == -1) {
-                    goto out;
-                }
-            }
-            if (pread(fd, buf, l,
-                      (off_t)(uintptr_t)g2h_untagged(addr)) != l) {
-                goto out_close;
-            }
-        }
-        len -= l;
-        buf += l;
-        addr += l;
-    }
-    ret = 0;
-out_close:
-    if (fd != -1) {
-        close(fd);
-    }
-out:
-    mmap_unlock();
-
-    return ret;
-}
-#endif
-
 bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
-- 
2.47.1


