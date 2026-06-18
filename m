Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EACD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqZ-0004DU-7f; Thu, 18 Jun 2026 15:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq5-0003tR-50
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIpv-0007rq-Lt
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso9304645ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812536; x=1782417336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzkybTZWtVoB/GJCCBnPGnkb1gszSpW1xZ4P0TVnmog=;
 b=PIcLbZIcEBdvSzsSsHyu2zb6y/2voDhpDJ00Gmnh4WqeznYpKo20cNdRW+QPTWfmy0
 UClQgz1HbdTa40EaGkb8cVziex01sLDq9hHQ5N0yip3//TS7OHwDJa8Sjmz1pmrErO8z
 EH+JOHn6SfM2fq2/dsN11m6z1ToqGwPzo0b2xcIzKdtH4WVtvLlWpxjsZwR5QJpXjBP8
 F23M2DIBpmninxd5ZOL1DtzBQ90Ih9wwvf4YGcvmcXDPv5BNHm7ACLK0cBuKufneiWyn
 zVNd+hN0fpeG+c+Tuf+FqzxrNW70nc/8acuJYBWt8A2s5j7iLl4+QevCcYCnBwxG5d3I
 WsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812536; x=1782417336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nzkybTZWtVoB/GJCCBnPGnkb1gszSpW1xZ4P0TVnmog=;
 b=ecFgjtLlvlJZVLyeEa8EpBHWsLZ2vR9DLDnjvfSFmwtikNGLPYx7cAAdxGoz21r5Jf
 sLvQlVvpZXhEGdVeB35IxXQAvJ8jCfir50CBvJI1nRcilToI4fcBCwa/eFNBwOLurYy6
 dFMrzOAUZreKnP3aG/ZxOaUkaTxsmSP5XvFsjmKNnmLsEWoHt3Plupedkit8LpCTMFQ9
 MLK7pEA8PR3DJ1I2tV4grPAoB+sOQRpqpeBgU/6RThrkGhWKJXQ3dqxRq5k+oX711ulv
 cwayKm8I49z1Q0RqRWvMNGGEJDNW0ix+tYbJ9jMTIyiWs2QQmAjfglF8a1FKthRJ7898
 za1g==
X-Gm-Message-State: AOJu0YyQ73aYPm71T7TDvnTWlQVJv0E2W1U/ZkCWneMskfzRyiijsNmf
 EPoI9gtPYTb4xkLWfmfR94/TCVI63vzLY9SZTKNm6JhyDz8hH8hOQuFughISUsJvptkavS4vKYh
 2TQck
X-Gm-Gg: AfdE7cl+oCLsOe9kmiPMJyrtAJ0NNZz5r3iZ/5lGEEuBJC30/Hhbti3PoylNUyx2YOP
 2+SP39iukWuYUtHPCBI3kGBjqxAczaBn7lt/rPLjYCxsLaSbS9t6kJ1ypViB43TeAOD1d7typGn
 2J+k+Xjt9yN7/GeZZKuzW4/5wVchAmtFSl0CmoHdKXl1LExHR/R7D0qJiqzd2weoWdgnmngXSac
 ll1vv+xcarwZgLrqCqTUsbz0o8qiqSV8M3Z8o17s7PVNteWaYXx3jYrxt8dQymrGlxFUkjxkL8e
 SqVgzD8tHC2ehrvrE5UaDglNoDox0vt8yKbKF6WpCVaYnqRKBMjlcDAXwIsEMiWxJkxi0n+scg+
 2PCXXvyYIgML16sNv8p6LWwJgDtB9uKflv1lJYm/h0G1lnYdk10i5L1pMqG8Qf5taMZMyz7eHsz
 XRoszzQDsGMofkuGXMuIP4m5EtmaSoyaOb6Gyq11tqFIX/kZPOdg==
X-Received: by 2002:a17:902:db0e:b0:2b2:ec46:dfed with SMTP id
 d9443c01a7336-2c718ff3fdcmr6936645ad.31.1781812536158; 
 Thu, 18 Jun 2026 12:55:36 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/13] linux-user: Use PGBRange for commpage
Date: Thu, 18 Jun 2026 12:55:11 -0700
Message-ID: <20260618195520.589907-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


