Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F24C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGd-0004oB-IH; Wed, 23 Apr 2025 21:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFU-0002pK-LW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFR-0007Ae-U1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so318241b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457568; x=1746062368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i6eTTqBVbqJi5x+I+UsZ0X40LcCyAdkFjFwlBMbt3Is=;
 b=WYTzcwtKFcsb6wrB5x1Ydih0QzZl9bFpWXYHC6bxZDQxGLF+es6aWl0lDjlqSa6YVs
 w2Dwq9w/lK4QKxNazrKv98vP9gyg3MlT2QIrZEd8YMZl9NNbHUgNuUyTyQJ56X0MwhPW
 3+bvWWz1cMiMJ/xLjz9RC1nrx0FyghKAz/TcRnHYKWoXm2cQlqR6l1rwAn5Ip9GezWDb
 kw8UnzHqhpKkTTykw34kj4GiSYvQQEQDaJgSij6wY8Hm94NtMb+QlUZUiGbR5Bf/cGAe
 EjidkkTe2l8jlcS7yC0SMwi/aAQuhxAUqiAONT+/k3iyo3WTBYwG/45mRm5zvEj63JpF
 LIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457568; x=1746062368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i6eTTqBVbqJi5x+I+UsZ0X40LcCyAdkFjFwlBMbt3Is=;
 b=draUHzlEg/zzCbFeNM3nuM0E8DZeS8Y2/XuVr2S8i7GYJVRxbawSTCRhEWk/Znhhs2
 9hj4ICQj5rCs3QQhka5WNbvDtZ9eguN4HE1Wha6IekVyFgDDnpMGpyxvtBdcpckHNqUs
 dMRRnOk3AQlfR90bm8J0RxEI/JDOJiZKX2Bxy922DHMBnMZ7VsWk/bk3NIfpN3CL/2wJ
 1qamCqAI4duOeyvVPC+W59wrGLj5dczYdRCL3HFjpp8THBM9kZTg1G4gKhZ9w7bLjcEs
 ItyUiHO41Gos1qlfygmGyuhyMAvjjTcQYokSQxExuZYYGxVFxRu4dfESK+WxYtkkkjAk
 n49w==
X-Gm-Message-State: AOJu0YwK0MFJXsatjJRKVQzfpYgp3ihwOefd8CJvZRjh6PJUokQ+o/xP
 vNAZSUcS2E0tKN3xk7mXJiceoF5IHDdcIXafAgFuGVTbF78Y4it/kK03aKJIPPHl03ntO8EQ8QH
 o
X-Gm-Gg: ASbGncvZkLRrbQRucs91s+CSvh5yQ5SNS7g3JVfI+2U6rYBXYyvgL4O+KDWJ5KfJq50
 PWto1NZmUt+64ycG5kUzdyZr6ARe6VfHlPeM/SNkJEg6rCmXBkAkcQiTozpGL2I8oIXtjMiEX23
 I8pOgp0uZCDetrChf5bCJRGBJxSz1Yo5QG4Wcfb0UWmfeaoQghx0B/gIPg5K2gcXOjQNXYSaY/f
 sp4BFnx3yb3wHKeOI3AdsqMXHbyTefPHJMRQRysk1tHPZTW+MjuAgEw5jOtAV9yY4L0gQzWSn2+
 0mQw69E5KDJETvEhU0JJpQ/68jD836AvXeB42tcN8Ps+pPrj+7V9gVmmQHSRw1NGmR2obya3Iv4
 =
X-Google-Smtp-Source: AGHT+IGC/w6Zx8gIC+jkZwRyIvXoMf3P2erqziz4m/xL1A9FOjdF4sYO915RFukXml0lZ3cHMgMY6A==
X-Received: by 2002:a05:6a00:b8d:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-73e2461d7f1mr961414b3a.9.1745457567748; 
 Wed, 23 Apr 2025 18:19:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/15] accel/tcg: Use vaddr in user/page-protection.h
Date: Wed, 23 Apr 2025 18:19:16 -0700
Message-ID: <20250424011918.599958-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/page-protection.h | 18 ++++++------
 accel/tcg/user-exec.c          | 51 ++++++++++++++++------------------
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 55aa05ce24..86143212fd 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -12,13 +12,12 @@
 #error Cannot include this header from system emulation
 #endif
 
-#include "cpu-param.h"
-#include "exec/target_long.h"
+#include "exec/vaddr.h"
 #include "exec/translation-block.h"
 
 int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc);
 
-int page_get_flags(target_ulong address);
+int page_get_flags(vaddr address);
 
 /**
  * page_set_flags:
@@ -31,9 +30,9 @@ int page_get_flags(target_ulong address);
  * The flag PAGE_WRITE_ORG is positioned automatically depending
  * on PAGE_WRITE.  The mmap_lock should already be held.
  */
-void page_set_flags(target_ulong start, target_ulong last, int flags);
+void page_set_flags(vaddr start, vaddr last, int flags);
 
-void page_reset_target_data(target_ulong start, target_ulong last);
+void page_reset_target_data(vaddr start, vaddr last);
 
 /**
  * page_check_range
@@ -45,7 +44,7 @@ void page_reset_target_data(target_ulong start, target_ulong last);
  * Return false if any page is unmapped.  Thus testing flags == 0 is
  * equivalent to testing for flags == PAGE_VALID.
  */
-bool page_check_range(target_ulong start, target_ulong last, int flags);
+bool page_check_range(vaddr start, vaddr last, int flags);
 
 /**
  * page_check_range_empty:
@@ -57,7 +56,7 @@ bool page_check_range(target_ulong start, target_ulong last, int flags);
  * The memory lock must be held so that the caller will can ensure
  * the result stays true until a new mapping can be installed.
  */
-bool page_check_range_empty(target_ulong start, target_ulong last);
+bool page_check_range_empty(vaddr start, vaddr last);
 
 /**
  * page_find_range_empty
@@ -71,8 +70,7 @@ bool page_check_range_empty(target_ulong start, target_ulong last);
  * The memory lock must be held, as the caller will want to ensure
  * the returned range stays empty until a new mapping can be installed.
  */
-target_ulong page_find_range_empty(target_ulong min, target_ulong max,
-                                   target_ulong len, target_ulong align);
+vaddr page_find_range_empty(vaddr min, vaddr max, vaddr len, vaddr align);
 
 /**
  * page_get_target_data(address)
@@ -86,7 +84,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
  * e.g. with the munmap system call.
  */
 __attribute__((returns_nonnull))
-void *page_get_target_data(target_ulong address);
+void *page_get_target_data(vaddr address);
 
 typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
 int walk_memory_regions(void *, walk_memory_regions_fn);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 25d86567e7..43d005e24e 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -161,7 +161,7 @@ typedef struct PageFlagsNode {
 
 static IntervalTreeRoot pageflags_root;
 
-static PageFlagsNode *pageflags_find(target_ulong start, target_ulong last)
+static PageFlagsNode *pageflags_find(vaddr start, vaddr last)
 {
     IntervalTreeNode *n;
 
@@ -169,8 +169,7 @@ static PageFlagsNode *pageflags_find(target_ulong start, target_ulong last)
     return n ? container_of(n, PageFlagsNode, itree) : NULL;
 }
 
-static PageFlagsNode *pageflags_next(PageFlagsNode *p, target_ulong start,
-                                     target_ulong last)
+static PageFlagsNode *pageflags_next(PageFlagsNode *p, vaddr start, vaddr last)
 {
     IntervalTreeNode *n;
 
@@ -215,14 +214,14 @@ static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 /* dump memory mappings */
 void page_dump(FILE *f)
 {
-    const int length = sizeof(target_ulong) * 2;
+    const int length = sizeof(abi_ptr) * 2;
 
     fprintf(f, "%-*s %-*s %-*s %s\n",
             length, "start", length, "end", length, "size", "prot");
     walk_memory_regions(f, dump_region);
 }
 
-int page_get_flags(target_ulong address)
+int page_get_flags(vaddr address)
 {
     PageFlagsNode *p = pageflags_find(address, address);
 
@@ -245,7 +244,7 @@ int page_get_flags(target_ulong address)
 }
 
 /* A subroutine of page_set_flags: insert a new node for [start,last]. */
-static void pageflags_create(target_ulong start, target_ulong last, int flags)
+static void pageflags_create(vaddr start, vaddr last, int flags)
 {
     PageFlagsNode *p = g_new(PageFlagsNode, 1);
 
@@ -256,13 +255,13 @@ static void pageflags_create(target_ulong start, target_ulong last, int flags)
 }
 
 /* A subroutine of page_set_flags: remove everything in [start,last]. */
-static bool pageflags_unset(target_ulong start, target_ulong last)
+static bool pageflags_unset(vaddr start, vaddr last)
 {
     bool inval_tb = false;
 
     while (true) {
         PageFlagsNode *p = pageflags_find(start, last);
-        target_ulong p_last;
+        vaddr p_last;
 
         if (!p) {
             break;
@@ -301,8 +300,7 @@ static bool pageflags_unset(target_ulong start, target_ulong last)
  * A subroutine of page_set_flags: nothing overlaps [start,last],
  * but check adjacent mappings and maybe merge into a single range.
  */
-static void pageflags_create_merge(target_ulong start, target_ulong last,
-                                   int flags)
+static void pageflags_create_merge(vaddr start, vaddr last, int flags)
 {
     PageFlagsNode *next = NULL, *prev = NULL;
 
@@ -353,11 +351,11 @@ static void pageflags_create_merge(target_ulong start, target_ulong last,
 #define PAGE_STICKY  (PAGE_ANON | PAGE_PASSTHROUGH | PAGE_TARGET_STICKY)
 
 /* A subroutine of page_set_flags: add flags to [start,last]. */
-static bool pageflags_set_clear(target_ulong start, target_ulong last,
+static bool pageflags_set_clear(vaddr start, vaddr last,
                                 int set_flags, int clear_flags)
 {
     PageFlagsNode *p;
-    target_ulong p_start, p_last;
+    vaddr p_start, p_last;
     int p_flags, merge_flags;
     bool inval_tb = false;
 
@@ -492,7 +490,7 @@ static bool pageflags_set_clear(target_ulong start, target_ulong last,
     return inval_tb;
 }
 
-void page_set_flags(target_ulong start, target_ulong last, int flags)
+void page_set_flags(vaddr start, vaddr last, int flags)
 {
     bool reset = false;
     bool inval_tb = false;
@@ -532,9 +530,9 @@ void page_set_flags(target_ulong start, target_ulong last, int flags)
     }
 }
 
-bool page_check_range(target_ulong start, target_ulong len, int flags)
+bool page_check_range(vaddr start, vaddr len, int flags)
 {
-    target_ulong last;
+    vaddr last;
     int locked;  /* tri-state: =0: unlocked, +1: global, -1: local */
     bool ret;
 
@@ -610,17 +608,16 @@ bool page_check_range(target_ulong start, target_ulong len, int flags)
     return ret;
 }
 
-bool page_check_range_empty(target_ulong start, target_ulong last)
+bool page_check_range_empty(vaddr start, vaddr last)
 {
     assert(last >= start);
     assert_memory_lock();
     return pageflags_find(start, last) == NULL;
 }
 
-target_ulong page_find_range_empty(target_ulong min, target_ulong max,
-                                   target_ulong len, target_ulong align)
+vaddr page_find_range_empty(vaddr min, vaddr max, vaddr len, vaddr align)
 {
-    target_ulong len_m1, align_m1;
+    vaddr len_m1, align_m1;
 
     assert(min <= max);
     assert(max <= GUEST_ADDR_MAX);
@@ -661,7 +658,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
 void tb_lock_page0(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-    target_ulong start, last;
+    vaddr start, last;
     int host_page_size = qemu_real_host_page_size();
     int prot;
 
@@ -740,7 +737,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
         }
     } else {
         int host_page_size = qemu_real_host_page_size();
-        target_ulong start, len, i;
+        vaddr start, len, i;
         int prot;
 
         if (host_page_size <= TARGET_PAGE_SIZE) {
@@ -756,7 +753,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
             prot = 0;
 
             for (i = 0; i < len; i += TARGET_PAGE_SIZE) {
-                target_ulong addr = start + i;
+                vaddr addr = start + i;
 
                 p = pageflags_find(addr, addr);
                 if (p) {
@@ -883,7 +880,7 @@ typedef struct TargetPageDataNode {
 
 static IntervalTreeRoot targetdata_root;
 
-void page_reset_target_data(target_ulong start, target_ulong last)
+void page_reset_target_data(vaddr start, vaddr last)
 {
     IntervalTreeNode *n, *next;
 
@@ -897,7 +894,7 @@ void page_reset_target_data(target_ulong start, target_ulong last)
          n != NULL;
          n = next,
          next = next ? interval_tree_iter_next(n, start, last) : NULL) {
-        target_ulong n_start, n_last, p_ofs, p_len;
+        vaddr n_start, n_last, p_ofs, p_len;
         TargetPageDataNode *t = container_of(n, TargetPageDataNode, itree);
 
         if (n->start >= start && n->last <= last) {
@@ -921,11 +918,11 @@ void page_reset_target_data(target_ulong start, target_ulong last)
     }
 }
 
-void *page_get_target_data(target_ulong address)
+void *page_get_target_data(vaddr address)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
-    target_ulong page, region, p_ofs;
+    vaddr page, region, p_ofs;
 
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
@@ -956,7 +953,7 @@ void *page_get_target_data(target_ulong address)
     return t->data + p_ofs * TARGET_PAGE_DATA_SIZE;
 }
 #else
-void page_reset_target_data(target_ulong start, target_ulong last) { }
+void page_reset_target_data(vaddr start, vaddr last) { }
 #endif /* TARGET_PAGE_DATA_SIZE */
 
 /* The system-mode versions of these helpers are in cputlb.c.  */
-- 
2.43.0


