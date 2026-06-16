Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CB6CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDT-0005UM-Q0; Tue, 16 Jun 2026 17:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDT-0005Tn-1A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:03 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDR-0007NW-0i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:02 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36bdb11bf8bso2695511a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644860; x=1782249660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YN2uB8XdweVGWyv07bBqrl8d9cn1yplQr12lD04JdBM=;
 b=nLP+M/X/nPy0YfCvZvDe3XC7D6u5hisw90VRNKybksNYEQlMjZCaSGea8dJ583ghrT
 IDaUa/0BwlEfl2fNOqssCVnFTvl1tO9XsNg/gFsStMUFinaaiRwF1yGHpBwMZidYEeH3
 e8r7bN/j7Rgd+bvNyC2LLKTLI/2EXNPIqczNgFSbl8vqFFXyf4i5DBulx9OanlqLN1dn
 K48lVCxqMpjBTL8wgKNEr8/T5ZxxdreEQdbYB1jYiZ32INxFM0VMFY7Wxw9vb6glrDWo
 jheqP4UTDIclyrIVuNymZX62tsFzs8wR7hhq21yhLcmC7fYGWBRez94Xu6bAqC0GTGQ5
 k1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644860; x=1782249660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YN2uB8XdweVGWyv07bBqrl8d9cn1yplQr12lD04JdBM=;
 b=EF5qcWjAwILtKemyOFAuUkopmPGxEc/PEGDDqRRhvb3FxbFTrVVPogShfSHN2MfC2O
 tECsqONeCJnplpkXpNiYaKRGyLbJuywGbZ8niej6AKUhfv1dOGb5hEhHd1x7+7XSulK0
 elDZoCaDykMuwE5poFAX3LHzsk9Sbc0w65/WhbNdoz+JJxhihpP20qnDKM813zfrDTZf
 R2bFizVhduoHtst7yCzuwQmOO81JshU6lyAUhGwDSUi/XUmetKdgfIGNcQBeBwb4lKp3
 SlPWkx+D3e1VowA7fyeYaUQWFjtxTS41HuhGW4AwzyxdpQLgijYjAQQYP6xKspadoKYr
 u5ww==
X-Gm-Message-State: AOJu0YzgFkaLQMYNA/v1lD8CfOkxuBb3dZOY2402bxCi8iGlnezTFN36
 C0AAzCiPhC0sH4pbiXE8p1WXonBYkP4uZWkMgYsIyEjy9gy93p01RWn+U1dIBXMabXID7lH152l
 VuadN
X-Gm-Gg: Acq92OEgd90ok8yqNoNV63zsEuQaov/S+bHm8UAy2+HU6hQRFix/X7thxy1KQvZ9R8F
 bJ1eBXrZKaRZax7xzu2nxxXW1rhvuMR+FfwjqnGLdhgd5jHgsDyjNVvhOyMp9yb5/AQ1c7PXJJc
 l+GFpFLGS7MDB4OG8T4KQNav1JQVabbY7UEGlKO0MxK8vEElp37iniHwqwQYjQNHvNivu32AGOt
 1n5RkAfPRn0vuk/yp5iU4MgvC4lbEhhZHYyLUKwDGG3m2klD+QVJqaqtZ5cB1g0gpvKx4pRhl0m
 l8/mpJr0m7aTTv/11a+ayCgiPt/zIfjZgGUrMQeCO+4C7fYjJRwQQeDUbJy/OsHFjafYl6nmTIC
 Jz/Phux5OJtLd9yRR3lkmPimHBmRQUv0EwkbIiwx1+2UasazzCj9lI8R5oLCPM7dAlVZqeyGbHp
 9FEn64aimX/AXPvriGaMijcZkM++pKw0HH0L+64gUBOuzsIY0htXwbkZC0RgrJ
X-Received: by 2002:a17:90b:2e42:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-37c936d5a17mr1086274a91.21.1781644859454; 
 Tue, 16 Jun 2026 14:20:59 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:20:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/13] linux-user: Pass image_range to probe_guest_base
Date: Tue, 16 Jun 2026 14:20:45 -0700
Message-ID: <20260616212055.334466-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
index 960847fda7..8545ac9695 100644
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


