Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02378C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucY-0007XK-K3; Tue, 29 Jul 2025 20:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ5-0004i6-Iu
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:31 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ3-0004eH-PX
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:31 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76b0724d64bso92637b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833868; x=1754438668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=juYH+c/ClRU2NI+u8jrOit6393rsevQJwBnXFcRMCaY=;
 b=aQiOIR2IXaLBOkYWZ/xeimeXg1E90K+PrWJIp+4utCGIgjDDjRvRnqS4PPIoUw+qP0
 OdTQfv2RmqC72ImdBsgsi3kHjrFyxvhwkHPP4cpV/ZutPEGRBlBodbHokgo3alwmskxE
 PtIXreWIv5E585UDh2vx8eSIXOJ+9dXFwGAkDfDp/DGVBqIxjO+T8D2WKPWOAY9C4rkR
 HH2AODSOXWYdB11VkVzazyNgzkHa7blgWc80SYEdr4rM6s7lOxMjj8GKz4AsepbyfhjP
 OjlXGaBavcBcLv4+dj7lZTj4qgSGFkuNx7zoxP+tEDk/zpIU6UHk2Bte8EqT8gapXfIl
 AFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833868; x=1754438668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juYH+c/ClRU2NI+u8jrOit6393rsevQJwBnXFcRMCaY=;
 b=rdV8OBF3wAywkb12cC+VvWTndzZVo0SGeRZHmdc2E08xmvihZ7xIkSJK8eZadgpTT1
 cqeqEQuFSLriRpc7gvWF8vFiPL1Lv3BL10VAJ0m50uf8UHxzUxDjhVEUVZiKw/AUXdI1
 6WOOjAPTOwRno9lM5OEmBSI2kIAp42fZ9GoMWj6L2dF6C+c8KfRRx3GGX0dWT+YR9UKS
 JBZJ9VebR5EFqnTIfawo5apmdPqCb41ewsCtmniTC4+tsDLBieePYEhUQUdYwirZJ22c
 9CtEKkVgc7gzqMuyfiYt/UZs0qdXhcQHWcKxuIU6l1Kp3KC2tT7E8M3J2OiGkYxqddlA
 JB3g==
X-Gm-Message-State: AOJu0Yx6jftm8Sj9i7j0p0rYRuvsTDI+rlNsq9wugAFhRSdO/mlL3HE/
 /ZCMVAliLOmF8vNYvbnpWKtJnNQocjF5CuUUgRmx0LouMuTs3b8ywn8DkIWW8z++KUvSzU8UoRp
 O/5TQ
X-Gm-Gg: ASbGncs58IWZTbn39nYSIwAOn2UvL2T8Yjfax8L7k2WvBZC+E8IX8i6uLkMbX5upfN0
 MUPvxF/MkkaSDDGvkuAeTcZ2raR6IZAf0d9nk8KC2bjvg/Z4wqj15eZ6QmN1JHgenVmgZ6ZTLyt
 hXMijDuAPCaFfuoCVgRJdnhVzmSgj3xmb1B07foBcUn/0vP/ElFsqA9ewlcoY+Qzw4VOu/g7c8Y
 dkIaiPX5CUDAcb9qrCmRanDH9GQ54x3/I/6i6eJt669cHt0z6bRDCin2p3OmG/ebJKr9fwQ9RT4
 m7fVjtyYOPU4EVy7URDJ+UdFsmsyoEq0lSmjhqSCSGgC6FIL6Nr5mm7cIlUcjl/zYEyK8hTYiXW
 lmT0s5eHgL0vQSasgoZVrYG05CKw6FEkfQxBx9cu2DHGDQEJ+yRNlP+H8sx6clZDO3rz58aXxpz
 LCKEy6dG2kepNX8r5GeUtM
X-Google-Smtp-Source: AGHT+IE4EF2tUhdTcTyJGFmx7ukByZGbQiRYTMa2f+izIW5Nk4Z3c//A09N5Vq8Ae8RzeonJQVqb+g==
X-Received: by 2002:a05:6a00:844:b0:76a:6d2b:f22 with SMTP id
 d2e1a72fcca58-76ab0f1fcf0mr1744903b3a.6.1753833868370; 
 Tue, 29 Jul 2025 17:04:28 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/89] linux-user: Move init_guest_commpage to hppa/elfload.c
Date: Tue, 29 Jul 2025 13:59:30 -1000
Message-ID: <20250730000003.599084-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 linux-user/hppa/target_elf.h |  4 ++++
 linux-user/loader.h          |  2 --
 linux-user/elfload.c         | 32 --------------------------------
 linux-user/hppa/elfload.c    | 31 +++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 19cae8bd65..00dc2d6684 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -7,8 +7,12 @@
 
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
+
+#define LO_COMMPAGE  0
+
 static inline const char *cpu_get_model(uint32_t eflags)
 {
     return "hppa";
 }
+
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 28eebf2f0b..e6d02d186e 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,8 +102,6 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
-#if defined(TARGET_X86_64) || defined(TARGET_ARM)
 bool init_guest_commpage(void);
-#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 714b70757c..8ebde57fa5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -441,38 +441,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define LO_COMMPAGE  0
-
-static bool init_guest_commpage(void)
-{
-    /* If reserved_va, then we have already mapped 0 page on the host. */
-    if (!reserved_va) {
-        void *want, *addr;
-
-        want = g2h_untagged(LO_COMMPAGE);
-        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
-                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
-        if (addr == MAP_FAILED) {
-            perror("Allocating guest commpage");
-            exit(EXIT_FAILURE);
-        }
-        if (addr != want) {
-            return false;
-        }
-    }
-
-    /*
-     * On Linux, page zero is normally marked execute only + gateway.
-     * Normal read or write is supposed to fail (thus PROT_NONE above),
-     * but specific offsets have kernel code mapped to raise permissions
-     * and implement syscalls.  Here, simply mark the page executable.
-     * Special case the entry points during translation (see do_page_zero).
-     */
-    page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
-                   PAGE_EXEC | PAGE_VALID);
-    return true;
-}
-
 #endif /* TARGET_HPPA */
 
 #ifdef TARGET_XTENSA
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index ff0c2b862a..c7e1e3952a 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -3,9 +3,40 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_platform(CPUState *cs)
 {
     return "PARISC";
 }
+
+bool init_guest_commpage(void)
+{
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        void *want, *addr;
+
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
+    }
+
+    /*
+     * On Linux, page zero is normally marked execute only + gateway.
+     * Normal read or write is supposed to fail (thus PROT_NONE above),
+     * but specific offsets have kernel code mapped to raise permissions
+     * and implement syscalls.  Here, simply mark the page executable.
+     * Special case the entry points during translation (see do_page_zero).
+     */
+    page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
+                   PAGE_EXEC | PAGE_VALID);
+    return true;
+}
-- 
2.43.0


