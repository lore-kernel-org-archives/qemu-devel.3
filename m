Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E4C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tAn-0007YX-8P; Thu, 24 Apr 2025 05:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAe-0007WE-LI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAc-0002YR-Jo
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39efc1365e4so368275f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488020; x=1746092820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3lVw6KIn3D7NgOMBRI5zDO2652ucdToVqyJMqAEbX4=;
 b=LO7zEWLJvVtjHKL0ymERPQbHviZOBLX4NXN+PlNHYfa1cMX32ot8aGoYyPUtno9q3K
 OxnYLTk5HSlSYsgWntF8pb4xWTUeLOz+ewfbGi1yV6Z3BFOXmkdswhApn3LWUBy6ErVQ
 253uJo1f2+dxdL/UhOflMVulsp1vBg2sPlyO2sWWkRiRbLjxKiLIEKseymNcgR7EN4LS
 kkocb+/+kMMEPzJ8ksjKkXE3zMIQRQONoPigK+TfDkIeY28z85pMFd1Kkpxix3l9k0+E
 FOdNUTm+b6xMHDe7Qt/lHG7xSX0cQ5Lq1dmEOGdEpaKjYaR80/W6bTFxIkbuv24Ma3Xw
 YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488020; x=1746092820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3lVw6KIn3D7NgOMBRI5zDO2652ucdToVqyJMqAEbX4=;
 b=Lw0r42VSqzUVMqkSIBmHoKFnnCZGhqAGhz18pw4UQg2rbCuSl+VTTEOy8U0GnEVVF2
 EzRLBcgOnmnGOlB8vDes7eZNfDp7kllJH+CiRj0wytpTkrYnoelAGmTQnFkaIxCL4vCc
 +o0p8ZLwkkWYIxgYfNRyvKCKMhSfDenpzpjKV3lWnBAtuRPeDgK5QXW0R6HjCZRkj8A1
 bshKqBOydpFgUKucyrbtvR+OCM0n4OK67BS3SON9+I3vWpPPSJCa21Z2yJzlhjuxVIfV
 9qi4yoiHmr4AOvK4BgaIPGKL3y6Dp/KxuNjFgwFHIOC+2mioGoTU97D82yszasZXYaI2
 dBBA==
X-Gm-Message-State: AOJu0Yw59LfdQCkU37nO8KiuXQJvVthV4JaiEs7Za62PaFskAzHBNiXn
 CtElizN87tPUxXZ2LtvAydeBkTZVX7oncwsR5PXetRM4nepr8HW+2Kk4oVxcDj9sOnK9pDXlGFz
 T
X-Gm-Gg: ASbGncvhi7WIa/uMVaKKIss0EDPPEzyDrAg9+dr1Y5WDctD3nSEPsD8qE2oQmKVBEp/
 1HStOVpL4YQm/T6CnVYXTfYpHUxgAp9HILHb4hB/qAeW/58OjMD3mf/stNtwWwXG+PRNawiq1ZS
 dYBkpPXmlKnlAqHI1+OVwIJhVU9XgLq/KAJULnxew7JlOypn3rFu5HXoL7QTDGLd4j6Dk3AX3TL
 259YSnf0iNkw4DYpvFZC2yjNU37IReAydzxFBWCtjc8keRHg7exIwlBLRMIC/WXwcx3tFyz38eJ
 5IqplVpujxbtCwJ4IAExJzhc+4R4QNN9Ok5/wINIWurmPcM3o2sOsO3RxD9fewCvB+VhENDubrW
 Tmnvn9Iofil/XUZAwuXCl
X-Google-Smtp-Source: AGHT+IF+oHwXYMRIxHw9avi8J3TubSpFtsC76No60lXwv1b4iv66vl4y591LdlxNA7c6cpreOe3E2w==
X-Received: by 2002:a5d:6dac:0:b0:391:4999:776c with SMTP id
 ffacd0b85a97d-3a06cfa854bmr1551620f8f.40.1745488020527; 
 Thu, 24 Apr 2025 02:47:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d532aa9sm1535181f8f.68.2025.04.24.02.46.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:46:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/13] accel/tcg: Use vaddr for walk_memory_regions callback
Date: Thu, 24 Apr 2025 11:46:41 +0200
Message-ID: <20250424094653.35932-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use vaddr instead of target_ulong.  At the same time,
use int instead of unsigned long for flags, to match
page_set_flags().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424011918.599958-13-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/user/page-protection.h |  5 ++---
 accel/tcg/user-exec.c          | 10 +++++-----
 linux-user/elfload.c           | 19 +++++++++----------
 linux-user/syscall.c           |  8 ++++----
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 1de72e31e68..8f0b769b134 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -14,6 +14,7 @@
 
 #include "cpu-param.h"
 #include "exec/target_long.h"
+#include "exec/vaddr.h"
 #include "exec/translation-block.h"
 
 int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc);
@@ -88,9 +89,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
 __attribute__((returns_nonnull))
 void *page_get_target_data(target_ulong address);
 
-typedef int (*walk_memory_regions_fn)(void *, target_ulong,
-                                      target_ulong, unsigned long);
-
+typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
 int walk_memory_regions(void *, walk_memory_regions_fn);
 
 void page_dump(FILE *f);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 17e3be337f5..25d86567e70 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -199,13 +199,13 @@ int walk_memory_regions(void *priv, walk_memory_regions_fn fn)
     return rc;
 }
 
-static int dump_region(void *priv, target_ulong start,
-                       target_ulong end, unsigned long prot)
+static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 {
-    FILE *f = (FILE *)priv;
+    FILE *f = opaque;
 
-    fprintf(f, TARGET_FMT_lx"-"TARGET_FMT_lx" "TARGET_FMT_lx" %c%c%c\n",
-            start, end, end - start,
+    fprintf(f, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+            " " TARGET_ABI_FMT_ptr " %c%c%c\n",
+            (abi_ptr)start, (abi_ptr)end, (abi_ptr)(end - start),
             ((prot & PAGE_READ) ? 'r' : '-'),
             ((prot & PAGE_WRITE) ? 'w' : '-'),
             ((prot & PAGE_EXEC) ? 'x' : '-'));
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7519b6bcda3..e281745e485 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4044,8 +4044,7 @@ static inline void bswap_note(struct elf_note *en) { }
 /*
  * Calculate file (dump) size of given memory region.
  */
-static size_t vma_dump_size(target_ulong start, target_ulong end,
-                            unsigned long flags)
+static size_t vma_dump_size(vaddr start, vaddr end, int flags)
 {
     /* The area must be readable. */
     if (!(flags & PAGE_READ)) {
@@ -4238,8 +4237,8 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
-static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_page_unprotect_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
         size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
@@ -4260,8 +4259,8 @@ typedef struct {
     size_t size;
 } CountAndSizeRegions;
 
-static int wmr_count_and_size_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_count_and_size_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     CountAndSizeRegions *css = opaque;
 
@@ -4275,8 +4274,8 @@ typedef struct {
     off_t offset;
 } FillRegionPhdr;
 
-static int wmr_fill_region_phdr(void *opaque, target_ulong start,
-                                target_ulong end, unsigned long flags)
+static int wmr_fill_region_phdr(void *opaque, vaddr start,
+                                vaddr end, int flags)
 {
     FillRegionPhdr *d = opaque;
     struct elf_phdr *phdr = d->phdr;
@@ -4298,8 +4297,8 @@ static int wmr_fill_region_phdr(void *opaque, target_ulong start,
     return 0;
 }
 
-static int wmr_write_region(void *opaque, target_ulong start,
-                            target_ulong end, unsigned long flags)
+static int wmr_write_region(void *opaque, vaddr start,
+                            vaddr end, int flags)
 {
     int fd = *(int *)opaque;
     size_t size = vma_dump_size(start, end, flags);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5826ac3adbb..23b901b7133 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8135,8 +8135,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
  * Callback for walk_memory_regions, when read_self_maps() fails.
  * Proceed without the benefit of host /proc/self/maps cross-check.
  */
-static int open_self_maps_3(void *opaque, target_ulong guest_start,
-                            target_ulong guest_end, unsigned long flags)
+static int open_self_maps_3(void *opaque, vaddr guest_start,
+                            vaddr guest_end, int flags)
 {
     static const MapInfo mi = { .is_priv = true };
 
@@ -8147,8 +8147,8 @@ static int open_self_maps_3(void *opaque, target_ulong guest_start,
 /*
  * Callback for walk_memory_regions, when read_self_maps() succeeds.
  */
-static int open_self_maps_2(void *opaque, target_ulong guest_start,
-                            target_ulong guest_end, unsigned long flags)
+static int open_self_maps_2(void *opaque, vaddr guest_start,
+                            vaddr guest_end, int flags)
 {
     const struct open_self_maps_data *d = opaque;
     uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
-- 
2.47.1


