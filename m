Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B04C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvI-0007XR-00; Thu, 22 Feb 2024 15:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvE-0007PE-KU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvC-0002ie-Hs
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dbf1fe91fcso492055ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634637; x=1709239437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48MAJNKY8itF/Uvxdy9leMjwL6Lq94BoHatvMOlA6tE=;
 b=XwPez6m+ao/Dw3QS8JcMSGkKzWjx80/oQytGgHK2J8BKZCgdKCbfxy0wRwfhaW/7rb
 npoKdNIVCu99riSQPSfVw7TpU5sYyPVp21CnhwLSv5ey+7h6m07sCqWM3o2nm3/UP+l7
 cTcXDTar9xuTD7fFUHIo3lup8nYAxiQxxsLugOJFYfikkkHMmMRc3wkvEZBSou6q/ONu
 UWeOtIT8VpbD3Fn04nfAjPwv7qgNks1rY4BHEyPr/DlgNVl7+1ltgGYHNvIg/aTtUHfn
 qZuqjlFtGFKXb+xm+p7JhAqFbs+vdl07ml+vRPOI56++OSf9RoCR/AHkb/J6OeDzpJLL
 6e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634637; x=1709239437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48MAJNKY8itF/Uvxdy9leMjwL6Lq94BoHatvMOlA6tE=;
 b=Nq7b5AqhHGge51l/gUT319TDu4rlUOJELp8pcNM3uaGF/jSqepywHAFx5P1GpPx4Te
 mpH7aTeEPPVq1SyE3PcF1XbuUmG+fCJIa8tBg3k1q4G0/Dqyo8BazwTUWl67hs2cep9V
 YCTj+Qmiemp71r58/p3dazCBL41X5JYnxHGNJyDUk3KMDJfFnHChHh+McXgA1PvA0itR
 r6LsY4EfsFGvdOupQymvdS5i/VS1tUFoW0OkF1wCMzE9mW9/Q746LCvrO099etMYfzmw
 8ygfZdPwIZoAeEW2iJB8JV3Aljtp7MWBUV3DNpNeX1mOLZxX1sQEC7ki9STiOwZQk/3B
 Vq1Q==
X-Gm-Message-State: AOJu0Yz5ig/oNgwy5gV6u8Qxmr1Y3Tjp4B9ZKzg4WDqI0ed/1BuYgEc6
 Atknpl4vBmQuQbSwvtPVa6R8noy/dEFQP9oKPMetZs2r/buJd3iYFRIWF4BF/5ABuT//KqpKZZ6
 0
X-Google-Smtp-Source: AGHT+IFf3ay4fTeQQSa0LltVzFNHuf0JrjYlLsxRzEJl9iCH8bCvqOz/5ikRRAUH88sejUUxG1MHig==
X-Received: by 2002:a17:903:286:b0:1db:c743:4687 with SMTP id
 j6-20020a170903028600b001dbc7434687mr19867029plr.1.1708634637332; 
 Thu, 22 Feb 2024 12:43:57 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 20/39] linux-user: Move some mmap checks outside the lock
Date: Thu, 22 Feb 2024 10:43:04 -1000
Message-Id: <20240222204323.268539-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Basic validation of operands does not require the lock.
Hoist them from target_mmap__locked back into target_mmap.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-18-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 107 +++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4c3cc65aa..fbaea832c5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -491,52 +491,14 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 }
 
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
-                                    int target_prot, int flags,
+                                    int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
-    int page_flags;
     off_t host_offset;
 
-    if (!len) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    page_flags = validate_prot_to_pageflags(target_prot);
-    if (!page_flags) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /* Also check for overflows... */
-    len = TARGET_PAGE_ALIGN(len);
-    if (!len) {
-        errno = ENOMEM;
-        return -1;
-    }
-
-    if (offset & ~TARGET_PAGE_MASK) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /*
-     * If we're mapping shared memory, ensure we generate code for parallel
-     * execution and flush old translations.  This will work up to the level
-     * supported by the host -- anything that requires EXCP_ATOMIC will not
-     * be atomic with respect to an external process.
-     */
-    if (flags & MAP_SHARED) {
-        CPUState *cpu = thread_cpu;
-        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-            cpu->tcg_cflags |= CF_PARALLEL;
-            tb_flush(cpu);
-        }
-    }
-
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
 
@@ -616,23 +578,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         passthrough_start = start;
         passthrough_last = last;
     } else {
-        if (start & ~TARGET_PAGE_MASK) {
-            errno = EINVAL;
-            return -1;
-        }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
 
-        /*
-         * Test if requested memory area fits target address space
-         * It can fail only on 64-bit host with 32-bit target.
-         * On any other target/host host mmap() handles this error correctly.
-         */
-        if (last < start || !guest_range_valid_untagged(start, len)) {
-            errno = ENOMEM;
-            return -1;
-        }
-
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
@@ -778,13 +726,64 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
     abi_long ret;
+    int page_flags;
 
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
+
+    if (!len) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    page_flags = validate_prot_to_pageflags(target_prot);
+    if (!page_flags) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    /* Also check for overflows... */
+    len = TARGET_PAGE_ALIGN(len);
+    if (!len || len != (size_t)len) {
+        errno = ENOMEM;
+        return -1;
+    }
+
+    if (offset & ~TARGET_PAGE_MASK) {
+        errno = EINVAL;
+        return -1;
+    }
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (start & ~TARGET_PAGE_MASK) {
+            errno = EINVAL;
+            return -1;
+        }
+        if (!guest_range_valid_untagged(start, len)) {
+            errno = ENOMEM;
+            return -1;
+        }
+    }
+
     mmap_lock();
 
-    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+    ret = target_mmap__locked(start, len, target_prot, flags,
+                              page_flags, fd, offset);
 
     mmap_unlock();
+
+    /*
+     * If we're mapping shared memory, ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if (ret != -1 && (flags & MAP_TYPE) != MAP_PRIVATE) {
+        CPUState *cpu = thread_cpu;
+        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
+            cpu->tcg_cflags |= CF_PARALLEL;
+            tb_flush(cpu);
+        }
+    }
+
     return ret;
 }
 
-- 
2.34.1


