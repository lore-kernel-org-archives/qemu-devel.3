Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AD6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKDs-0004Ij-JV; Fri, 10 Jul 2026 19:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDl-0004Gk-SS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:27 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDi-00031G-4Z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:24 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso1714310a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724480; x=1784329280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1fVycIgCYdKMeVMFCV1hVxJmqdm+sxkiY+un83hRjyQ=;
 b=Qf/1P4Tmiva3910jGrQ0KtF1LwCOoaFTW9GTDFyO1I6yBurmKjaIExpJm6ScN74wEk
 CsvX0Fz3O4laleZYxL5WrAs5GuDKtIWZtKHpTIR6oQhCdpBA7BwXs5/lAC37gn4IfmWR
 nvtBrJX5IEnmtJePeFzc0nAirylUHC6uWgUIAJ44CPx0REBX5GmkYhgVxjfM8UV+jy75
 SJtWtFCFtbDgZZfzo6++30A+6RXAkjhClv0NtEbQg0SkZOcMfoS+6nXfD+4TFUtcG45p
 AEvc9KMCcCMyE/pT5BZ3GyRFMNNcnUpXaC6sls/b6+FpViM1A4wU5lD0rsWZjgICK6X8
 UKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724480; x=1784329280;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1fVycIgCYdKMeVMFCV1hVxJmqdm+sxkiY+un83hRjyQ=;
 b=MgrnlPERPsdlmSNqZTAQ/GznydbqAIM86ya2OufhgTUEn8DTCvRSA+mhV2lR0LexdQ
 0Y93xK7me0EluqkTJkJi0OdCGZLu3hc2PlEAM+aOO5Me/aZB73Tx5xk2GuuX9kwtuffP
 vys3fiYfqhADLVElydejjCGPD3Q7HyfINrZ1G5EluWUhI/gsq/ayLMcZgTe74sVE7MXJ
 jdn5Kh8NZ39H15Nc/4z/Q1UfWoCxEEH4jYN5KPhQQeYqxRYUazGBepTFtko0DxxgEft1
 6C3TrLKth7hsOx3iKAAHjvYgS/ul1xr94QVA5+/MY3F9MPek71qnOabYEhcQhGCeExgs
 JVrw==
X-Gm-Message-State: AOJu0Yz3LkBRqUfqiOoluhuuWzByHfOxHXLWcdr8W4VaWpWlTE3tivXk
 bhHik0tyuqZv5U6xT3XCbn7VH5oixqwLZ3Rc94ofcKPNClm3T6Iq1Eqshfof5/u0xlUZBO35NDx
 XeqOP
X-Gm-Gg: AfdE7ckcPUsOaqZfG9OrZmSie6wAWMVHH4DjxHNvoBhPQYY69te1iZaPIH2BYWTxtar
 qQLlWeWx08wSGn9XkMhbwQ0dRb509vcLErfnAXhX6cQnyaHpdJcIRpsFv+gFKoDES9MqdEAQzzf
 sIeaKcBtQQYvX6Jx2SQy0lXyaEWlY15QrrCmaTZErK74YS/WlEkFTcp4Rz+OXtVLZOV+eULyXmN
 5ssVvRY3YTTwhqgSqngQa8hKqAmYJ3BpFsRhErBe7D5lambfYsgHeFxUioVgnGhW16CoE+O8Wvn
 2yktvt0fbduLQXB7Np6zi9wZ5NNARMoju0F1kXnxXI3Z2lQaijsvf6c2Hak5T/AadrZOEQB+RUL
 +H+QHZFlj5rr9OpeBWxeCXE7iGhVmhBAHcVr0SQQuaQydOpyxc6rT/PmsVAacQNzM4n4p0KuDpp
 KAhgNL/W3rEqMnI3MTHw==
X-Received: by 2002:a17:90b:4a90:b0:380:9504:9780 with SMTP id
 98e67ed59e1d1-38dc780f769mr802624a91.29.1783724480297; 
 Fri, 10 Jul 2026 16:01:20 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/13] linux-user: Pass image_range to probe_guest_base
Date: Fri, 10 Jul 2026 16:01:07 -0700
Message-ID: <20260710230116.900171-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Pass a PGBRange structure instead of separate guest_loaddr
and guest_hiaddr parameters.  This allows NULL to indicate
that the image is relocatable, so that image_range->lo == 0
is a valid fixed setting.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h | 13 ++++-------
 linux-user/elfload.c        | 46 +++++++++++++++++--------------------
 linux-user/flatload.c       |  2 +-
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index b04ca43f02..d7f346b0d0 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -83,24 +83,21 @@ typedef struct PGBRange {
 /**
  * probe_guest_base:
  * @image_name: the executable being loaded
- * @loaddr: the lowest fixed address within the executable
- * @hiaddr: the highest fixed address within the executable
+ * @image_range: the fixed addresses within the executable
  *
  * Creates the initial guest address space in the host memory space.
  *
- * If @loaddr == 0, then no address in the executable is fixed, i.e.
- * it is fully relocatable.  In that case @hiaddr is the size of the
- * executable minus one.
+ * If @image_range is NULL, then no address in the executable is fixed,
+ * i.e. it is fully relocatable.
  *
  * This function will not return if a valid value for guest_base
  * cannot be chosen.  On return, the executable loader can expect
  *
- *    target_mmap(loaddr, hiaddr - loaddr + 1, ...)
+ *    target_mmap(i->lo, i->hi - i->lo + 1, ...)
  *
  * to succeed.
  */
-void probe_guest_base(const char *image_name,
-                      abi_ulong loaddr, abi_ulong hiaddr);
+void probe_guest_base(const char *image_name, const PGBRange *image_range);
 
 /* syscall.c */
 int host_to_target_waitstatus(int status);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1367657d58..19d2bad581 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -847,14 +847,13 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
 /**
  * pgb_addr_set:
  * @ga: output set of guest addrs
- * @guest_loaddr: guest image low address
- * @guest_hiaddr: guest image high address
+ * @image_range: fixed guest image addresses
  * @identity: create for identity mapping
  *
  * Fill in @ga with the image, COMMPAGE and NULL page.
  */
-static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
-                         abi_ulong guest_hiaddr, bool try_identity)
+static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
+                         bool try_identity)
 {
     int n;
 
@@ -866,7 +865,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
         if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
             return false;
         }
-        if (guest_loaddr != 0 && guest_loaddr < mmap_min_addr) {
+        if (image_range && image_range->lo < mmap_min_addr) {
             return false;
         }
     }
@@ -892,10 +891,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
         }
 
         /* Add the guest image for ET_EXEC. */
-        if (guest_loaddr) {
-            ga->bounds[n].lo = guest_loaddr;
-            ga->bounds[n].hi = guest_hiaddr;
-            n++;
+        if (image_range) {
+            ga->bounds[n++] = *image_range;
         }
     }
 
@@ -928,8 +925,8 @@ static void pgb_fail_in_use(const char *image_name)
     exit(EXIT_FAILURE);
 }
 
-static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
-                      uintptr_t guest_hiaddr, uintptr_t align)
+static void pgb_fixed(const char *image_name, const PGBRange *image_range,
+                      uintptr_t align)
 {
     PGBAddrs ga;
     uintptr_t brk = (uintptr_t)sbrk(0);
@@ -941,7 +938,7 @@ static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
         exit(EXIT_FAILURE);
     }
 
-    if (!pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, !guest_base)
+    if (!pgb_addr_set(&ga, image_range, !guest_base)
         || !pgb_try_mmap_set(&ga, guest_base, brk)) {
         pgb_fail_in_use(image_name);
     }
@@ -1026,15 +1023,15 @@ static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
     return pgb_try_mmap_set(ga, base, brk) ? base : -1;
 }
 
-static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
-                        uintptr_t guest_hiaddr, uintptr_t align)
+static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
+                        uintptr_t align)
 {
     IntervalTreeRoot *root;
     uintptr_t brk, ret;
     PGBAddrs ga;
 
     /* Try the identity map first. */
-    if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
+    if (pgb_addr_set(&ga, image_range, true)) {
         brk = (uintptr_t)sbrk(0);
         if (pgb_try_mmap_set(&ga, 0, brk)) {
             guest_base = 0;
@@ -1046,7 +1043,7 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
      * Rebuild the address set for non-identity map.
      * This differs in the mapping of the guest NULL page.
      */
-    pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, false);
+    pgb_addr_set(&ga, image_range, false);
 
     root = read_self_maps();
 
@@ -1085,24 +1082,23 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     guest_base = ret;
 }
 
-void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
-                      abi_ulong guest_hiaddr)
+void probe_guest_base(const char *image_name, const PGBRange *image_range)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
     uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
-    if (reserved_va && guest_hiaddr > reserved_va) {
+    if (reserved_va && image_range && image_range->hi > reserved_va) {
         error_report("%s: requires more than reserved virtual "
-                     "address space (0x%" PRIx64 " > 0x%lx)",
-                     image_name, (uint64_t)guest_hiaddr, reserved_va);
+                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
+                     image_name, image_range->hi, reserved_va);
         exit(EXIT_FAILURE);
     }
 
     if (have_guest_base) {
-        pgb_fixed(image_name, guest_loaddr, guest_hiaddr, align);
+        pgb_fixed(image_name, image_range, align);
     } else {
-        pgb_dynamic(image_name, guest_loaddr, guest_hiaddr, align);
+        pgb_dynamic(image_name, image_range, align);
     }
 
     /* Reserve and initialize the commpage. */
@@ -1362,10 +1358,10 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Make sure that the low address does not conflict with
              * MMAP_MIN_ADDR or the QEMU application itself.
              */
-            probe_guest_base(image_name, range.lo, range.hi);
+            probe_guest_base(image_name, &range);
         } else {
             /* The binary is dynamic; we still need to select guest_base. */
-            probe_guest_base(image_name, 0, 0);
+            probe_guest_base(image_name, NULL);
 
             /*
              * Avoid collision with the loader by providing a different
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 8abdd2aef2..45d69040c6 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     /*
      * Allocate the address space.
      */
-    probe_guest_base(bprm->filename, 0, 0);
+    probe_guest_base(bprm->filename, NULL);
 
     /*
      * there are a couple of cases here,  the separate code/data
-- 
2.43.0


