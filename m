Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74094C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE5-0004MS-49; Fri, 10 Jul 2026 19:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDl-0004Gm-Sh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:27 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDi-00031Z-L3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3817f800c8bso1305500a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724481; x=1784329281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iMmGtXArXD5wJPTCUg8MlX7wVAnWOwS1dPzc7EU4sSg=;
 b=IdSU1aT+6HPWYx6mZIFLV7HvNdPDiM4czyIKlz6dpdLpgzxEcxJSQkBzUyNO5iDTyO
 35F42SkBtBpjHUvM/qxknLAzHSHqWGD6Q4v/TJlsxm1PCW7SekEp+31N1Q7ldMvtRTG1
 9AtFWfIXIOPQk1fSDaj9ZlceokODamBuj7en7uu5h2RbjJ8lzUfTcMu5dobpasTnrgbJ
 v1iQW7CMfm6kssThhA/7g2DqHsHk1B/3Y/QUO4zDP5SH3JOb/4QX7KC/GKvTqDM0nTRu
 BWtL2oouuYbO0QxIWwv4gSz3roOlO3LJtr8vuA1WO7UgJeERjrtU9MDmqdgpVrSLODaL
 eCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724481; x=1784329281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMmGtXArXD5wJPTCUg8MlX7wVAnWOwS1dPzc7EU4sSg=;
 b=PP+6zo6/dcx0p1CdEvNuvanLLqcTkB9KhVb6E5K8I82gMePV31NyMPkPc57pyGlaxK
 h5Z/dAwRGmxh318yWEiocJI1TNTlzjbz2/V81Ndy9sbGwjM8S/QBd2zY87YJL8LAD6Ae
 3YomuZfcn/C0cAHb1CK1dDso63nFAx0qNhZzW87nl5WEOe6iz9oK6FxJO3nTTLCp0jBb
 aUCBnbQxnCKR6OIyok1y36XFfoc69rRdj7Fvvy7DqOZUdtdAhbGbl+bfrFupdhbRetry
 /jf/kyGk9KXdqmDeXXipT7JW5zSvprTKZLVKVfCecA3EnOd2c88nmr/lgB/m/vSoahaU
 Dm1g==
X-Gm-Message-State: AOJu0Yy+CdT5nyr//iEZIRx8g1xW0PcJjUnOm/NtXRgIO0ajzCZA7VaU
 x7IJDHhWuxZGm8UD1X60q5rEoJqhaDieSxEjlC/HxNAjf2MghGzwscJts92zMTvpjVwtpnx6Ecj
 Ot4jT
X-Gm-Gg: AfdE7cmXz8116c8kMJsx9IPTqf20njoVeafBdHW2LQQm08JS8ey2Yj3z31nAeuU0k4i
 0b0dcExV/YbGLgKw4RZpexW0xT77IYaOV1OfJgO4ObJ15A45VbHHLQfbikhUsed/Vb3aGurECPA
 2+q2UwR+XJLR9u/dcYHx5ftpICjUtrSnHiDUnjvxODCVswW6wXmQ7riQcyyPN7WcCqtoi3kxB4L
 HuDslKg6KAsNezUlJV5tNUPuxsJKXywvIztGRPURq5PlX2gjCNQFRYaEX5bxtsBy0IUuBrLp0/W
 ZCEOBXVQGxIuLuY0nk93GEAChVjlNpVhpu+i/02VCJ4sHC7ECwn0PHJLMUfz0YSyIpeiofrDvvf
 tqcUhxsCx4N5KBD8EEHFbzg+Ho253Re2DS39QTKWnOZbs9OZtriKSlafrHjQZiBLiYEI/9vSWTs
 ipkDLdfjHg0UEZ0CJJzw==
X-Received: by 2002:a17:90b:562e:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-38dc761b1f9mr763280a91.1.1783724481052; 
 Fri, 10 Jul 2026 16:01:21 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/13] linux-user: Use PGBRange for commpage
Date: Fri, 10 Jul 2026 16:01:08 -0700
Message-ID: <20260710230116.900171-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This simplifies check for no commpage to a NULL pointer
check, rather than reserved values for LO_COMMPAGE and
HI_COMMPAGE.

Unify {LO,HI}_COMMPAGE into a single COMMPAGE define.

Acked-by: Warner Losh <imp@bsdimp.com>
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h  |  2 +-
 linux-user/hppa/target_elf.h |  2 +-
 linux-user/arm/elfload.c     |  2 +-
 linux-user/elfload.c         | 64 ++++++++++++++----------------------
 linux-user/hppa/elfload.c    |  4 +--
 5 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 12cdc8e5a7..531b486bf9 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -20,7 +20,7 @@
 #define HAVE_ELF_CORE_DUMP      1
 #define HAVE_VDSO_IMAGE_INFO    1
 
-#define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
+#define COMMPAGE                ((intptr_t)0xffff0f00u)
 
 /*
  * See linux kernel: arch/arm/include/asm/elf.h, where
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index e1c5033242..22547b1437 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -34,7 +34,7 @@ typedef struct target_elf_gregset_t {
     abi_ulong pad[16];     /* pad to 80 elements                 [64..79] */
 } target_elf_gregset_t;
 
-#define LO_COMMPAGE             0
+#define COMMPAGE                0
 #define STACK_GROWS_DOWN        0
 #define STACK_ALIGNMENT         64
 #define VDSO_HEADER             "vdso.c.inc"
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 13b589ea2c..ce69bf0542 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -220,7 +220,7 @@ bool init_guest_commpage(void)
         return true;
     }
 
-    commpage = HI_COMMPAGE & -host_page_size;
+    commpage = COMMPAGE & -host_page_size;
     want = g2h_untagged(commpage);
     addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
                 MAP_ANONYMOUS | MAP_PRIVATE |
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 19d2bad581..557ed20dbf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -757,17 +757,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     return sp;
 }
 
-#if defined(HI_COMMPAGE)
-#define LO_COMMPAGE -1
-#elif defined(LO_COMMPAGE)
-#define HI_COMMPAGE 0
-#else
-#define HI_COMMPAGE 0
-#define LO_COMMPAGE -1
-#ifndef HAVE_GUEST_COMMPAGE
+#if !defined(COMMPAGE) && !defined(HAVE_GUEST_COMMPAGE)
 bool init_guest_commpage(void) { return true; }
 #endif
-#endif
 
 /**
  * pgb_try_mmap:
@@ -853,7 +845,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
  * Fill in @ga with the image, COMMPAGE and NULL page.
  */
 static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
-                         bool try_identity)
+                         const PGBRange *commpage_range, bool try_identity)
 {
     int n;
 
@@ -862,7 +854,7 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
      * we may not be able to use the identity map.
      */
     if (try_identity) {
-        if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
+        if (commpage_range && commpage_range->lo < mmap_min_addr) {
             return false;
         }
         if (image_range && image_range->lo < mmap_min_addr) {
@@ -877,14 +869,10 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
         ga->bounds[n].lo = try_identity ? mmap_min_addr : 0;
         ga->bounds[n].hi = reserved_va;
         n++;
-        /* LO_COMMPAGE and NULL handled by reserving from 0. */
+        /* Low COMMPAGE and NULL handled by reserving from 0. */
     } else {
-        /* Add any LO_COMMPAGE or NULL page. */
-        if (LO_COMMPAGE != -1) {
-            ga->bounds[n].lo = 0;
-            ga->bounds[n].hi = LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
-            n++;
-        } else if (!try_identity) {
+        /* Add any low COMMPAGE or NULL page. */
+        if (!try_identity || (commpage_range && commpage_range->lo == 0)) {
             ga->bounds[n].lo = 0;
             ga->bounds[n].hi = TARGET_PAGE_SIZE - 1;
             n++;
@@ -896,23 +884,13 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
         }
     }
 
-    /*
-     * Temporarily disable
-     *   "comparison is always false due to limited range of data type"
-     * due to comparison between unsigned and (possible) 0.
-     */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wtype-limits"
-
-    /* Add any HI_COMMPAGE not covered by reserved_va. */
-    if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n].lo = HI_COMMPAGE & qemu_real_host_page_mask();
-        ga->bounds[n].hi = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
+    /* Add any high COMMPAGE not covered by reserved_va. */
+    if (commpage_range && reserved_va < commpage_range->hi) {
+        ga->bounds[n].lo = commpage_range->lo & qemu_real_host_page_mask();
+        ga->bounds[n].hi = commpage_range->hi;
         n++;
     }
 
-#pragma GCC diagnostic pop
-
     ga->nbounds = n;
     return true;
 }
@@ -926,7 +904,7 @@ static void pgb_fail_in_use(const char *image_name)
 }
 
 static void pgb_fixed(const char *image_name, const PGBRange *image_range,
-                      uintptr_t align)
+                      const PGBRange *commpage_range, uintptr_t align)
 {
     PGBAddrs ga;
     uintptr_t brk = (uintptr_t)sbrk(0);
@@ -938,7 +916,7 @@ static void pgb_fixed(const char *image_name, const PGBRange *image_range,
         exit(EXIT_FAILURE);
     }
 
-    if (!pgb_addr_set(&ga, image_range, !guest_base)
+    if (!pgb_addr_set(&ga, image_range, commpage_range, !guest_base)
         || !pgb_try_mmap_set(&ga, guest_base, brk)) {
         pgb_fail_in_use(image_name);
     }
@@ -1024,14 +1002,14 @@ static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
 }
 
 static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
-                        uintptr_t align)
+                        const PGBRange *commpage_range, uintptr_t align)
 {
     IntervalTreeRoot *root;
     uintptr_t brk, ret;
     PGBAddrs ga;
 
     /* Try the identity map first. */
-    if (pgb_addr_set(&ga, image_range, true)) {
+    if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
         brk = (uintptr_t)sbrk(0);
         if (pgb_try_mmap_set(&ga, 0, brk)) {
             guest_base = 0;
@@ -1043,7 +1021,7 @@ static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
      * Rebuild the address set for non-identity map.
      * This differs in the mapping of the guest NULL page.
      */
-    pgb_addr_set(&ga, image_range, false);
+    pgb_addr_set(&ga, image_range, commpage_range, false);
 
     root = read_self_maps();
 
@@ -1084,6 +1062,14 @@ static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
 
 void probe_guest_base(const char *image_name, const PGBRange *image_range)
 {
+#ifdef COMMPAGE
+    const PGBRange * const commpage_range = &(PGBRange){
+        COMMPAGE, COMMPAGE + TARGET_PAGE_SIZE - 1
+    };
+#else
+    const PGBRange * const commpage_range = NULL;
+#endif
+
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
     uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
@@ -1096,9 +1082,9 @@ void probe_guest_base(const char *image_name, const PGBRange *image_range)
     }
 
     if (have_guest_base) {
-        pgb_fixed(image_name, image_range, align);
+        pgb_fixed(image_name, image_range, commpage_range, align);
     } else {
-        pgb_dynamic(image_name, image_range, align);
+        pgb_dynamic(image_name, image_range, commpage_range, align);
     }
 
     /* Reserve and initialize the commpage. */
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 2ebb9924f1..ff4301b2ed 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -36,7 +36,7 @@ bool init_guest_commpage(void)
     if (!reserved_va) {
         void *want, *addr;
 
-        want = g2h_untagged(LO_COMMPAGE);
+        want = g2h_untagged(COMMPAGE);
         addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
         if (addr == MAP_FAILED) {
@@ -55,7 +55,7 @@ bool init_guest_commpage(void)
      * and implement syscalls.  Here, simply mark the page executable.
      * Special case the entry points during translation (see do_page_zero).
      */
-    page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
+    page_set_flags(COMMPAGE, COMMPAGE | ~TARGET_PAGE_MASK,
                    PAGE_EXEC | PAGE_VALID, PAGE_VALID);
     return true;
 }
-- 
2.43.0


