Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5EBC54E55
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjG-0005KY-LY; Fri, 01 Mar 2024 23:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1O-0003fA-SM
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:34 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1M-0005eA-3P
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:30 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e432514155so1306496a34.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334626; x=1709939426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfmBcNvAQcjDLvj9qNkCIuvVr8sl09md9gL9eOBPbro=;
 b=GJdEvd3DRdAGObIHrYabwTLNvnZC6HmstotDodyiE9S1+GFR+o0YUl8QPp1Xa1b9Xk
 FZtqlR9sLCgPSib0hJYBZS3UHZ7zlye3tsxaxJC1av0AJbld7rBONoR6VWxh9ECsUG+1
 nMA+2SAUUos7FN1XPA0rdxUJSuCDTGpU0YTeDZFZGe0Lai0f3XTKWavFBur6zXiC6WSV
 9UFH16xms2NiIEsDSEi47AZh06+8uPESdBT8Xgrzshk5669+W8Qwf+U8QZOTM7g5PfPe
 D+SU3Xn4iSU4LppR8RdDW+8pgVYeV3BCbuTguPboF+gtr8/DMT8yWVlmgzG3TMzVoXTu
 ACQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334626; x=1709939426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfmBcNvAQcjDLvj9qNkCIuvVr8sl09md9gL9eOBPbro=;
 b=I128fUc9inhXYuF2maLUOiMCkf/gYanJ8zJWV9AWCOO04XAp9ditpQoGnirEYW7F+L
 y+pjg/NDKI5lxCBpqLtrn7OBX8a2GE6x6QVDc6D1iHBReUxITFkYK/wUhKVMdiPUcFGd
 95+sJWfsVPS3JwaUy8KpiOWhQG0ZiyfXSbTn666PiqxtDLhC/5szp4hkT4c2sNDLpwzU
 6cMXQu1fRK7lRM4xrSHRtQlJL+zh9I6L7jODmdxgbf5weQ7918oUvnNihFInQW03nPhX
 YOY1g9/tSOqAI6jpGKXBMybWqeWgVFzEZGqG4Y9eTRvKEEbwSvqXhNrpzYZwG7A2gmm5
 Cjng==
X-Gm-Message-State: AOJu0YxkEeBLKLRkejdvH+Sh2dlTYEW5caEc8B1cClbnAPt5fEBMB4/Q
 MFFDwSvxOBHbXzKcGN0PkBNXKJCan8Ci0by1rxv+g6g4AL66OHVQeVXbA6s0OyzenVTHl8Sa2G+
 v
X-Google-Smtp-Source: AGHT+IH3mAAmNz/KUWOiUTsEGM65ZWJjsHJSNlj+rgzk2qVAdImQLcEmO7pHAyEiPFrU4H/zatfKDg==
X-Received: by 2002:a05:6830:c7:b0:6e4:a6bd:d911 with SMTP id
 x7-20020a05683000c700b006e4a6bdd911mr3052460oto.15.1709334625953; 
 Fri, 01 Mar 2024 15:10:25 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 43/60] linux-user: Split out mmap_h_gt_g
Date: Fri,  1 Mar 2024 13:06:02 -1000
Message-Id: <20240301230619.661008-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-24-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 288 ++++++++++++++++++++++------------------------
 1 file changed, 139 insertions(+), 149 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index ff8f9f7ed0..82f4026283 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -282,7 +282,16 @@ static int do_munmap(void *addr, size_t len)
     return munmap(addr, len);
 }
 
-/* map an incomplete host page */
+/*
+ * Map an incomplete host page.
+ *
+ * Here be dragons.  This case will not work if there is an existing
+ * overlapping host page, which is file mapped, and for which the mapping
+ * is beyond the end of the file.  In that case, we will see SIGBUS when
+ * trying to write a portion of this page.
+ *
+ * FIXME: Work around this with a temporary signal handler and longjmp.
+ */
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
 {
@@ -719,19 +728,138 @@ static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
     return mmap_end(start, last, start, pass_last, mmap_flags, page_flags);
 }
 
+/*
+ * Special case host page size > target page size.
+ *
+ * The two special cases are address and file offsets that are valid
+ * for the guest that cannot be directly represented by the host.
+ */
+static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
+                            int target_prot, int host_prot,
+                            int flags, int page_flags, int fd,
+                            off_t offset, int host_page_size)
+{
+    void *p, *want_p = g2h_untagged(start);
+    off_t host_offset = offset & -host_page_size;
+    abi_ulong last, real_start, real_last;
+    bool misaligned_offset = false;
+    size_t host_len;
+
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        /*
+         * Adjust the offset to something representable on the host.
+         */
+        host_len = len + offset - host_offset;
+        p = mmap(want_p, host_len, host_prot, flags, fd, host_offset);
+        if (p == MAP_FAILED) {
+            return -1;
+        }
+
+        /* Update start to the file position at offset. */
+        p += offset - host_offset;
+
+        start = h2g(p);
+        last = start + len - 1;
+        return mmap_end(start, last, start, last, flags, page_flags);
+    }
+
+    if (!(flags & MAP_ANONYMOUS)) {
+        misaligned_offset = (start ^ offset) & (host_page_size - 1);
+
+        /*
+         * The fallback for misalignment is a private mapping + read.
+         * This carries none of semantics required of MAP_SHARED.
+         */
+        if (misaligned_offset && (flags & MAP_TYPE) != MAP_PRIVATE) {
+            errno = EINVAL;
+            return -1;
+        }
+    }
+
+    last = start + len - 1;
+    real_start = start & -host_page_size;
+    real_last = ROUND_UP(last, host_page_size) - 1;
+
+    /*
+     * Handle the start and end of the mapping.
+     */
+    if (real_start < start) {
+        abi_ulong real_page_last = real_start + host_page_size - 1;
+        if (last <= real_page_last) {
+            /* Entire allocation a subset of one host page. */
+            if (!mmap_frag(real_start, start, last, target_prot,
+                           flags, fd, offset)) {
+                return -1;
+            }
+            return mmap_end(start, last, -1, 0, flags, page_flags);
+        }
+
+        if (!mmap_frag(real_start, start, real_page_last, target_prot,
+                       flags, fd, offset)) {
+            return -1;
+        }
+        real_start = real_page_last + 1;
+    }
+
+    if (last < real_last) {
+        abi_ulong real_page_start = real_last - host_page_size + 1;
+        if (!mmap_frag(real_page_start, real_page_start, last,
+                       target_prot, flags, fd,
+                       offset + real_page_start - start)) {
+            return -1;
+        }
+        real_last = real_page_start - 1;
+    }
+
+    if (real_start > real_last) {
+        return mmap_end(start, last, -1, 0, flags, page_flags);
+    }
+
+    /*
+     * Handle the middle of the mapping.
+     */
+
+    host_len = real_last - real_start + 1;
+    want_p += real_start - start;
+
+    if (flags & MAP_ANONYMOUS) {
+        p = mmap(want_p, host_len, host_prot, flags, -1, 0);
+    } else if (!misaligned_offset) {
+        p = mmap(want_p, host_len, host_prot, flags, fd,
+                 offset + real_start - start);
+    } else {
+        p = mmap(want_p, host_len, host_prot | PROT_WRITE,
+                 flags | MAP_ANONYMOUS, -1, 0);
+    }
+    if (p != want_p) {
+        if (p != MAP_FAILED) {
+            do_munmap(p, host_len);
+            errno = EEXIST;
+        }
+        return -1;
+    }
+
+    if (misaligned_offset) {
+        /* TODO: The read could be short. */
+        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
+            do_munmap(p, host_len);
+            return -1;
+        }
+        if (!(host_prot & PROT_WRITE)) {
+            mprotect(p, host_len, host_prot);
+        }
+    }
+
+    return mmap_end(start, last, -1, 0, flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
-    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
-    abi_ulong passthrough_start = -1, passthrough_last = 0;
-    off_t host_offset;
     int host_prot;
 
-    real_start = start & -host_page_size;
-    host_offset = offset & -host_page_size;
-
     /*
      * For reserved_va, we are in full control of the allocation.
      * Find a suitable hole and convert to MAP_FIXED.
@@ -745,6 +873,8 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             }
             flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
         } else if (!(flags & MAP_FIXED)) {
+            abi_ulong real_start = start & -host_page_size;
+            off_t host_offset = offset & -host_page_size;
             size_t real_len = len + offset - host_offset;
             abi_ulong align = MAX(host_page_size, TARGET_PAGE_SIZE);
 
@@ -766,150 +896,10 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     } else if (host_page_size < TARGET_PAGE_SIZE) {
         return mmap_h_lt_g(start, len, host_prot, flags,
                            page_flags, fd, offset, host_page_size);
-    }
-
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        uintptr_t host_start;
-        void *p;
-
-        host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-
-        /* Note: we prefer to control the mapping address. */
-        p = mmap(g2h_untagged(start), host_len, host_prot,
-                 flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
-            return -1;
-        }
-        /* update start so that it points to the file position at 'offset' */
-        host_start = (uintptr_t)p;
-        if (!(flags & MAP_ANONYMOUS)) {
-            p = mmap(g2h_untagged(start), len, host_prot,
-                     flags | MAP_FIXED, fd, host_offset);
-            if (p == MAP_FAILED) {
-                do_munmap(g2h_untagged(start), host_len);
-                return -1;
-            }
-            host_start += offset - host_offset;
-        }
-        start = h2g(host_start);
-        last = start + len - 1;
-        passthrough_start = start;
-        passthrough_last = last;
     } else {
-        last = start + len - 1;
-        real_last = ROUND_UP(last, host_page_size) - 1;
-
-        if (flags & MAP_FIXED_NOREPLACE) {
-            /* Validate that the chosen range is empty. */
-            if (!page_check_range_empty(start, last)) {
-                errno = EEXIST;
-                return -1;
-            }
-
-            /*
-             * With reserved_va, the entire address space is mmaped in the
-             * host to ensure it isn't accidentally used for something else.
-             * We have just checked that the guest address is not mapped
-             * within the guest, but need to replace the host reservation.
-             *
-             * Without reserved_va, despite the guest address check above,
-             * keep MAP_FIXED_NOREPLACE so that the guest does not overwrite
-             * any host address mappings.
-             */
-            if (reserved_va) {
-                flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
-            }
-        }
-
-        /*
-         * worst case: we cannot map the file because the offset is not
-         * aligned, so we read it
-         */
-        if (!(flags & MAP_ANONYMOUS) &&
-            (offset & (host_page_size - 1)) != (start & (host_page_size - 1))) {
-            /*
-             * msync() won't work here, so we return an error if write is
-             * possible while it is a shared mapping
-             */
-            if ((flags & MAP_TYPE) == MAP_SHARED
-                && (target_prot & PROT_WRITE)) {
-                errno = EINVAL;
-                return -1;
-            }
-            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
-                                  (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
-                                  | MAP_PRIVATE | MAP_ANONYMOUS,
-                                  -1, 0);
-            if (retaddr == -1) {
-                return -1;
-            }
-            if (pread(fd, g2h_untagged(start), len, offset) == -1) {
-                return -1;
-            }
-            if (!(target_prot & PROT_WRITE)) {
-                ret = target_mprotect(start, len, target_prot);
-                assert(ret == 0);
-            }
-            return mmap_end(start, last, -1, 0, flags, page_flags);
-        }
-
-        /* handle the start of the mapping */
-        if (start > real_start) {
-            if (real_last == real_start + host_page_size - 1) {
-                /* one single host page */
-                if (!mmap_frag(real_start, start, last,
-                               target_prot, flags, fd, offset)) {
-                    return -1;
-                }
-                return mmap_end(start, last, -1, 0, flags, page_flags);
-            }
-            if (!mmap_frag(real_start, start,
-                           real_start + host_page_size - 1,
-                           target_prot, flags, fd, offset)) {
-                return -1;
-            }
-            real_start += host_page_size;
-        }
-        /* handle the end of the mapping */
-        if (last < real_last) {
-            abi_ulong real_page = real_last - host_page_size + 1;
-            if (!mmap_frag(real_page, real_page, last,
-                           target_prot, flags, fd,
-                           offset + real_page - start)) {
-                return -1;
-            }
-            real_last -= host_page_size;
-        }
-
-        /* map the middle (easier) */
-        if (real_start < real_last) {
-            void *p, *want_p;
-            off_t offset1;
-            size_t len1;
-
-            if (flags & MAP_ANONYMOUS) {
-                offset1 = 0;
-            } else {
-                offset1 = offset + real_start - start;
-            }
-            len1 = real_last - real_start + 1;
-            want_p = g2h_untagged(real_start);
-
-            p = mmap(want_p, len1, host_prot, flags, fd, offset1);
-            if (p != want_p) {
-                if (p != MAP_FAILED) {
-                    do_munmap(p, len1);
-                    errno = EEXIST;
-                }
-                return -1;
-            }
-            passthrough_start = real_start;
-            passthrough_last = real_last;
-        }
+        return mmap_h_gt_g(start, len, target_prot, host_prot, flags,
+                           page_flags, fd, offset, host_page_size);
     }
-    return mmap_end(start, last, passthrough_start, passthrough_last,
-                    flags, page_flags);
 }
 
 /* NOTE: all the constants are the HOST ones */
-- 
2.34.1


