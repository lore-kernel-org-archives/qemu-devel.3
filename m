Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83601C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBz9-00072i-0m; Fri, 01 Mar 2024 18:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByF-0005en-5X
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:15 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByC-0004Lu-Ei
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:14 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso1658993b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334431; x=1709939231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzBaOBmrgtVcZmBT0VJjVQXI2NhHPFgQ+IyeqJADkZ4=;
 b=nqRwtprsU6ucKX1BY/ZiFCW4V2tp2Rhm808w3vuMmFPX6yqAxWV3hpW6jAr60HT98q
 kIkDVLC9uByNUBigi1ayAU3mshD7pMnqEHrdmzyd5r87cIpnsW2DuT+1wMZuQSJvFkwD
 vy1uxRXiiLGgveKfZAW5/8PGwFdO8xc7BJX4OEzXBcq9E5+PqsYzL1AmC7jNIhqZYtpo
 kfVpV7yfVda7yr+YuEFwkGH0bQCLnHOZPQnuSdahkU7zTzEXUwejVlU2ClmMiSBfQrPC
 d+PHHrOyshDayLe+1UTL4BMUlD9F5FTJHgB5ZPIvEFZDrMiIpCm1gVm/MEXdAHgiHvrE
 6zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334431; x=1709939231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzBaOBmrgtVcZmBT0VJjVQXI2NhHPFgQ+IyeqJADkZ4=;
 b=WNA1YqM7UzeUtkR8z8T0K5ay8+F6jMFzjz02pgQiAMqzRSlydidp1QAnzcAJ1UgV6r
 fJf8CpZe1jclXg5HwtKB4HmGcMlZEZC8+p6FxiuWCd7xbidSFVtgEq/iV/18hW8CqYoL
 jcW2fplhXDwwLwDzWpFO8z8JVNrhPW48DeU3VdUUbaEhPORl6RBO1WcmItkTnfXorrfA
 3z6K3LjU2gwhlsqTe7uDyMrkCveTyJ1Jb5ZQgps1iE2f8SXLA0QLoVg9BMidUSVrCeNi
 +3OnxkT+3n8Nz4Ao3km66wzcdxiGDrwRrnhOCljceUSaxDWGn8gf9e0DeQG+lQwOlbfQ
 OvqA==
X-Gm-Message-State: AOJu0YyzkYpt6JisLKXaWXySYGMlKWTqBmYzVYfQlaXscipHXiTc91Cq
 EOsNFftII4ZfALOeHapBtYyNvM4pg8PigWt1DNKgBKlscRYKhFT4NrX9Pn+LAnwwrkAikIw1hzr
 F
X-Google-Smtp-Source: AGHT+IHJ7SaVD53Lje/Psjt2HCcY4rne9V4k8lvcwP4GyavmflQDYxkzqk5pU8CwMN3UTUZaapfsOA==
X-Received: by 2002:a17:902:a3ce:b0:1dc:6775:a350 with SMTP id
 q14-20020a170902a3ce00b001dc6775a350mr2496498plb.58.1709334431012; 
 Fri, 01 Mar 2024 15:07:11 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 34/60] linux-user: Split out target_mmap__locked
Date: Fri,  1 Mar 2024 13:05:53 -1000
Message-Id: <20240301230619.661008-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All "goto fail" may be transformed to "return -1".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-17-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 62 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d11f758d07..b4c3cc65aa 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -490,9 +490,9 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
-/* NOTE: all the constants are the HOST ones */
-abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
-                     int flags, int fd, off_t offset)
+static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
+                                    int target_prot, int flags,
+                                    int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
@@ -500,30 +500,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     int page_flags;
     off_t host_offset;
 
-    mmap_lock();
-    trace_target_mmap(start, len, target_prot, flags, fd, offset);
-
     if (!len) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     /* Also check for overflows... */
     len = TARGET_PAGE_ALIGN(len);
     if (!len) {
         errno = ENOMEM;
-        goto fail;
+        return -1;
     }
 
     if (offset & ~TARGET_PAGE_MASK) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     /*
@@ -553,7 +550,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
     }
 
@@ -574,7 +571,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         struct stat sb;
 
         if (fstat(fd, &sb) == -1) {
-            goto fail;
+            return -1;
         }
 
         /* Are we trying to create a map beyond EOF?.  */
@@ -601,7 +598,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
-            goto fail;
+            return -1;
         }
         /* update start so that it points to the file position at 'offset' */
         host_start = (uintptr_t)p;
@@ -610,7 +607,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h_untagged(start), host_len);
-                goto fail;
+                return -1;
             }
             host_start += offset - host_offset;
         }
@@ -621,7 +618,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     } else {
         if (start & ~TARGET_PAGE_MASK) {
             errno = EINVAL;
-            goto fail;
+            return -1;
         }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
@@ -633,14 +630,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          */
         if (last < start || !guest_range_valid_untagged(start, len)) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
 
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
                 errno = EEXIST;
-                goto fail;
+                return -1;
             }
 
             /*
@@ -671,17 +668,17 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if ((flags & MAP_TYPE) == MAP_SHARED
                 && (target_prot & PROT_WRITE)) {
                 errno = EINVAL;
-                goto fail;
+                return -1;
             }
             retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
                                   | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1) {
-                goto fail;
+                return -1;
             }
             if (pread(fd, g2h_untagged(start), len, offset) == -1) {
-                goto fail;
+                return -1;
             }
             if (!(target_prot & PROT_WRITE)) {
                 ret = target_mprotect(start, len, target_prot);
@@ -696,14 +693,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 /* one single host page */
                 if (!mmap_frag(real_start, start, last,
                                target_prot, flags, fd, offset)) {
-                    goto fail;
+                    return -1;
                 }
                 goto the_end1;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
                            target_prot, flags, fd, offset)) {
-                goto fail;
+                return -1;
             }
             real_start += host_page_size;
         }
@@ -713,7 +710,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
                            offset + real_page - start)) {
-                goto fail;
+                return -1;
             }
             real_last -= host_page_size;
         }
@@ -739,7 +736,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                     munmap(p, len1);
                     errno = EEXIST;
                 }
-                goto fail;
+                return -1;
             }
             passthrough_start = real_start;
             passthrough_last = real_last;
@@ -773,11 +770,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             qemu_log_unlock(f);
         }
     }
-    mmap_unlock();
     return start;
-fail:
+}
+
+/* NOTE: all the constants are the HOST ones */
+abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
+                     int flags, int fd, off_t offset)
+{
+    abi_long ret;
+
+    trace_target_mmap(start, len, target_prot, flags, fd, offset);
+    mmap_lock();
+
+    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+
     mmap_unlock();
-    return -1;
+    return ret;
 }
 
 static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


