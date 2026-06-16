Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9439CCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDW-0005Vd-7M; Tue, 16 Jun 2026 17:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDU-0005UQ-2n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:04 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDS-0007Nw-1F
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:03 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36dd65b95f2so263361a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644861; x=1782249661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMembm/8oQ4J8GII9mrD41iXnXEtNJ+PeDf000ugFAw=;
 b=NMhbdPDbxGFO3vzqjob2twaE2PdVkXQiUOP/rQKCbIVVjUAY0AD7H3FwJ1bkJHZkTY
 668G6fHZtAfIbZjPgwWvgZ9jcs17m71xs7upxjd3s+kT+ZssLq5s2fFzlcru0sXTcA9T
 uWz04cZc7GFiQ3x1LwTdJOKdfOIPWjoccsi7gaSrud/tNi5aPxMW0yEWOnq5/g3Lzenx
 +cnC/AHZKfG7VrgIjmGyLtnzj8NVEkB970v3RpzD9TLFhaEdS3oLPf7vbT1afEhfuAJV
 FeLqmKQ0pe1FZPd8OViAMWNG/8QssGuf5/bmXNB3SvGMb41MSdH677r/z+XqmxmvDu6x
 aGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644861; x=1782249661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMembm/8oQ4J8GII9mrD41iXnXEtNJ+PeDf000ugFAw=;
 b=n4VSsrF7Epx+eajhL4qQHG9pY7PwlaMwAfoQriTzboSDZvnVtf2/cJhPqEALnkRixp
 JQS1b4kZ3u7kFYCgaP3h1cMVQkRpm061VyM0zNKYOnkJVp+b48COFFF9oZuMfvByjH9J
 4/t86FVrwnEkNbzcwbBoZ86g//fMDiXD8VWeGcrJu6nm1fNuxoUdPXRbe84Vz3UIJVKT
 /Mi9kdzZVPGqsERznjNolbYY9UoeZhoOIEB8rf91OjJSVYJsAUDXWNyCt9Qd6Ds5YnGA
 DmsUzxU4Wm1uMl0GYo8mB2uvlDnRFQcpOtPnp7B1YVI9xAICPL31CGKAgelbSbpepGBj
 o0qw==
X-Gm-Message-State: AOJu0Yy7DXsTVDm49JEmRorLUdus3eOBxlVV4V4KmonC7CPzMENfeGQ+
 nh9sZ/bAgnAbMPfpydQ/RqMWuJ2dKxKQVKnos3TiOHrdjpkx1Vb/QGXe8n9R6d/YfiuQ/l7tX8F
 8R1V7
X-Gm-Gg: AfdE7cm3jV1riZHoocSSeJdqiYONuNDUMc6Y94gGkKbw+uMDB7+eNC0F6ZkjC6J0TgB
 YfLqguSkQ8glYV4LuL2NMiWE8TYjCX+K3+U3NiMB4wDJVR1jAff1Opd84oNToVwLVXpZAsj/CHV
 JFC4JEbPkLyI8MOcGrcWpcUiHjKBzsdTDcQrawvtnqWkoNN06LxnehIdu6Vg+PeER36N1Mm5gm6
 S1fQ5JrwIetlkJx0CLUKDbbAGI3WuLyNmjWJqO32bgxhKNAu+6CYNNarL7PVUUXqtvNbY2gL17p
 8Za7kLroBIYwDBPJxBzT4lzY2kbvF/0a8FetruzxlC8HsqpMxqcLb/JFuwaJnx9fkY7hYCDFkdS
 E6QyvAsMJy0b5oMEPyUN8Xzr/aZw0GThjf2lQtukg/Y0XKJ4kaCch6VNmKAwg/5F22xZjrJ76vg
 oRaHHcVrizHz9ZltkWILyHpRsL6OfTDXdJLSR1nC91pJ8aF+NXspxbeW/GE5zc/f8BVUf3aTQ=
X-Received: by 2002:a17:90b:4d84:b0:35f:b9f1:fded with SMTP id
 98e67ed59e1d1-37ca7299f23mr233355a91.12.1781644860513; 
 Tue, 16 Jun 2026 14:21:00 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:20:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/13] linux-user: Use PGBRange for commpage
Date: Tue, 16 Jun 2026 14:20:46 -0700
Message-ID: <20260616212055.334466-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
index fef61022a3..3c2ccf289c 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -219,7 +219,7 @@ bool init_guest_commpage(void)
         return true;
     }
 
-    commpage = HI_COMMPAGE & -host_page_size;
+    commpage = COMMPAGE & -host_page_size;
     want = g2h_untagged(commpage);
     addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
                 MAP_ANONYMOUS | MAP_PRIVATE |
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8545ac9695..d0605e33d4 100644
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
index 3354e1b840..3bfe93ada8 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -35,7 +35,7 @@ bool init_guest_commpage(void)
     if (!reserved_va) {
         void *want, *addr;
 
-        want = g2h_untagged(LO_COMMPAGE);
+        want = g2h_untagged(COMMPAGE);
         addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
         if (addr == MAP_FAILED) {
@@ -54,7 +54,7 @@ bool init_guest_commpage(void)
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


