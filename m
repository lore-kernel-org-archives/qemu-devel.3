Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83425C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvQ-0007gf-Fr; Thu, 22 Feb 2024 15:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvO-0007f9-NN
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:10 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvM-0002kt-P2
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:10 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dba94f9201so2033125ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634647; x=1709239447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4UwZkIS26PhKHP+iY1jWw6KRSEUK2Dc0FNGbwDM3y4=;
 b=vYcoB7I+svat1gp4rABqsuXPL7k+lOamSGb8G5j4P25bOA9yiZv8V1cKvbpRcz7+I3
 OVGgN+t7VUvMWtjICIH57xLuN30mv+PQRGgNCjkUFHkwl4pIxST2qOSTZcgvD6QxUjiS
 QCUV6fY1HgJ2QKvMMfO0Kvq/lThYiGkbUsnJmun4N72SYnVaT5TwOzrfWpGP4EZYqduJ
 e/vVL7TdF2WKzQB5jwuNyXdeIgB//2zajH9YA4wnbzBf3jUkusym84FvcwmFKUmcgiAu
 bUninxD2ghcTbD4n/Kt7olQkjX4smCSdWmhUvO7XXIvhruJp+kSNELsgm7Ap0uO9KST+
 IJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634647; x=1709239447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4UwZkIS26PhKHP+iY1jWw6KRSEUK2Dc0FNGbwDM3y4=;
 b=HUXX2vDcaWOJ4x+aNHm5VBCC9BuXd/XEV5CgLLD1UqvBi7JMGTGeRKrgUsYzx8BvhL
 5HQSCMMjZN7jQHZ/PiMIOG26mZd2JLSxo4eFY5rOTXtpqdywYbgPF5bycBFXohsZZ3fu
 0reK+aCMU3udl4m4dOGU7924y8YWK24Fp5CwXvTHCe1I4hrDPpafsDdvG/xI3QyFNrPx
 kWiOazmf8M5clQZusteW7cBf47sHlf4nuSim1j6YWRfKR29Lk0UNlLaUMNZ960JRkESh
 Gten/gwqNmby1QdauBJCxAcgeQZhB93EKH2HKu6peLxkdLchT/PLvn8W6nXhIDTrV3A1
 oedw==
X-Gm-Message-State: AOJu0Yyml2BX/GucMrDSo4hZLQDdXQaupQXqLHRn6y8ekP/VaO530XmI
 EtzPOsqL2oFSbyXFMq85tD4EftZCM6aiSEpySUKIkhg9I/RS7bCFT97MmT9NVeBqi8tTODiJIrJ
 R
X-Google-Smtp-Source: AGHT+IF+l4iOQG0U0BFS83Mb/VCge+6IS/YLjeVIjqf6v3eoetL/Z/MNs5oCnM3RhCKyYqWuOsBAVQ==
X-Received: by 2002:a17:902:ecc1:b0:1dc:673:1932 with SMTP id
 a1-20020a170902ecc100b001dc06731932mr13462931plh.38.1708634647523; 
 Thu, 22 Feb 2024 12:44:07 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 27/39] linux-user: Split out mmap_h_lt_g
Date: Thu, 22 Feb 2024 10:43:11 -1000
Message-Id: <20240222204323.268539-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Work much harder to get alignment and mapping beyond the end
of the file correct.  Both of which are excercised by our
test-mmap for alpha (8k pages) on any 4k page host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-23-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 184 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 153 insertions(+), 31 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d3556bcc14..ff8f9f7ed0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -569,6 +569,156 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
     return mmap_end(start, last, start, last, flags, page_flags);
 }
 
+/*
+ * Special case host page size < target page size.
+ *
+ * The two special cases are increased guest alignment, and mapping
+ * past the end of a file.
+ *
+ * When mapping files into a memory area larger than the file,
+ * accesses to pages beyond the file size will cause a SIGBUS.
+ *
+ * For example, if mmaping a file of 100 bytes on a host with 4K
+ * pages emulating a target with 8K pages, the target expects to
+ * be able to access the first 8K. But the host will trap us on
+ * any access beyond 4K.
+ *
+ * When emulating a target with a larger page-size than the hosts,
+ * we may need to truncate file maps at EOF and add extra anonymous
+ * pages up to the targets page boundary.
+ *
+ * This workaround only works for files that do not change.
+ * If the file is later extended (e.g. ftruncate), the SIGBUS
+ * vanishes and the proper behaviour is that changes within the
+ * anon page should be reflected in the file.
+ *
+ * However, this case is rather common with executable images,
+ * so the workaround is important for even trivial tests, whereas
+ * the mmap of of a file being extended is less common.
+ */
+static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
+                            int mmap_flags, int page_flags, int fd,
+                            off_t offset, int host_page_size)
+{
+    void *p, *want_p = g2h_untagged(start);
+    off_t fileend_adj = 0;
+    int flags = mmap_flags;
+    abi_ulong last, pass_last;
+
+    if (!(flags & MAP_ANONYMOUS)) {
+        struct stat sb;
+
+        if (fstat(fd, &sb) == -1) {
+            return -1;
+        }
+        if (offset >= sb.st_size) {
+            /*
+             * The entire map is beyond the end of the file.
+             * Transform it to an anonymous mapping.
+             */
+            flags |= MAP_ANONYMOUS;
+            fd = -1;
+            offset = 0;
+        } else if (offset + len > sb.st_size) {
+            /*
+             * A portion of the map is beyond the end of the file.
+             * Truncate the file portion of the allocation.
+             */
+            fileend_adj = offset + len - sb.st_size;
+        }
+    }
+
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (fileend_adj) {
+            p = mmap(want_p, len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
+        } else {
+            p = mmap(want_p, len, host_prot, flags, fd, offset);
+        }
+        if (p != want_p) {
+            if (p != MAP_FAILED) {
+                /* Host does not support MAP_FIXED_NOREPLACE: emulate. */
+                do_munmap(p, len);
+                errno = EEXIST;
+            }
+            return -1;
+        }
+
+        if (fileend_adj) {
+            void *t = mmap(p, len - fileend_adj, host_prot,
+                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
+                           fd, offset);
+
+            if (t == MAP_FAILED) {
+                int save_errno = errno;
+
+                /*
+                 * We failed a map over the top of the successful anonymous
+                 * mapping above. The only failure mode is running out of VMAs,
+                 * and there's nothing that we can do to detect that earlier.
+                 * If we have replaced an existing mapping with MAP_FIXED,
+                 * then we cannot properly recover.  It's a coin toss whether
+                 * it would be better to exit or continue here.
+                 */
+                if (!(flags & MAP_FIXED_NOREPLACE) &&
+                    !page_check_range_empty(start, start + len - 1)) {
+                    qemu_log("QEMU target_mmap late failure: %s",
+                             strerror(save_errno));
+                }
+
+                do_munmap(want_p, len);
+                errno = save_errno;
+                return -1;
+            }
+        }
+    } else {
+        size_t host_len, part_len;
+
+        /*
+         * Take care to align the host memory.  Perform a larger anonymous
+         * allocation and extract the aligned portion.  Remap the file on
+         * top of that.
+         */
+        host_len = len + TARGET_PAGE_SIZE - host_page_size;
+        p = mmap(want_p, host_len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
+        if (p == MAP_FAILED) {
+            return -1;
+        }
+
+        part_len = (uintptr_t)p & (TARGET_PAGE_SIZE - 1);
+        if (part_len) {
+            part_len = TARGET_PAGE_SIZE - part_len;
+            do_munmap(p, part_len);
+            p += part_len;
+            host_len -= part_len;
+        }
+        if (len < host_len) {
+            do_munmap(p + len, host_len - len);
+        }
+
+        if (!(flags & MAP_ANONYMOUS)) {
+            void *t = mmap(p, len - fileend_adj, host_prot,
+                           flags | MAP_FIXED, fd, offset);
+
+            if (t == MAP_FAILED) {
+                int save_errno = errno;
+                do_munmap(p, len);
+                errno = save_errno;
+                return -1;
+            }
+        }
+
+        start = h2g(p);
+    }
+
+    last = start + len - 1;
+    if (fileend_adj) {
+        pass_last = ROUND_UP(last - fileend_adj, host_page_size) - 1;
+    } else {
+        pass_last = last;
+    }
+    return mmap_end(start, last, start, pass_last, mmap_flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -613,37 +763,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     if (host_page_size == TARGET_PAGE_SIZE) {
         return mmap_h_eq_g(start, len, host_prot, flags,
                            page_flags, fd, offset);
-    }
-
-    /*
-     * When mapping files into a memory area larger than the file, accesses
-     * to pages beyond the file size will cause a SIGBUS.
-     *
-     * For example, if mmaping a file of 100 bytes on a host with 4K pages
-     * emulating a target with 8K pages, the target expects to be able to
-     * access the first 8K. But the host will trap us on any access beyond
-     * 4K.
-     *
-     * When emulating a target with a larger page-size than the hosts, we
-     * may need to truncate file maps at EOF and add extra anonymous pages
-     * up to the targets page boundary.
-     */
-    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
-        struct stat sb;
-
-        if (fstat(fd, &sb) == -1) {
-            return -1;
-        }
-
-        /* Are we trying to create a map beyond EOF?.  */
-        if (offset + len > sb.st_size) {
-            /*
-             * If so, truncate the file map at eof aligned with
-             * the hosts real pagesize. Additional anonymous maps
-             * will be created beyond EOF.
-             */
-            len = ROUND_UP(sb.st_size - offset, host_page_size);
-        }
+    } else if (host_page_size < TARGET_PAGE_SIZE) {
+        return mmap_h_lt_g(start, len, host_prot, flags,
+                           page_flags, fd, offset, host_page_size);
     }
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-- 
2.34.1


