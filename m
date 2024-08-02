Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5786AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29p-0002NC-Uh; Fri, 02 Aug 2024 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29o-0002Hh-I5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:58:00 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29m-0004L2-IV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:58:00 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso128172139f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643077; x=1723247877;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38kVVXcpRVzigthSDk6irqa7cPAYSjq2c74UEfJaIlc=;
 b=NMvE/plYa7VzJNbc05CY0RaLBgBEz/JUxsswjNBfjsjKZBpuZj1su7ZYmf6M8uqr3V
 kccUIp7VtWkgFF71RoW/k6Suf0SnKxqZJXqt2QIEn6/FXdzLS+WGqEw40ltvt67VBlWU
 EodepFdJQ7kTezBLERpRKrauwoNCtYsS49rYSZKVQnGViUHQxc063EET17NQv9wWS1Q6
 eyrYLaD1ihRA/I1utSoERbj9dcrep3FgQmMcnXvqsFULNQTFVYnpfGH1zOhLmaIajIO4
 J8PHiHD+4/Nv3JhHL2nMVaedyQsc7FRb3F7GR9xl75UXtDDPP4UI6W/Q5/O9w9fjhVQN
 rE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643077; x=1723247877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38kVVXcpRVzigthSDk6irqa7cPAYSjq2c74UEfJaIlc=;
 b=OX0rFyBNWE7yBrw1JLnwzwPbyGoJJURtmoyPKGqTpaVMK12HI5AkamX0YxIFN2SLjo
 3FwAB1UyeMKrVZ7DfO5NjGG18YLPryZ6VPiqsQiMu+52pSKVIurq9bcQvYObdDYxqfu/
 lnhD8pWyB5qaN3vT00obXSZdAkfj71TZm87nYniZSSS76CV444IA4ZHeNoF2GeAeR5AD
 u73Xr05GkX05Asn2ARWhX2aLFGt2JVIPML/ZxJJe579PUu4GNFqTRWwGLdJwQPehWSrH
 jWkK2Fygat2jgcErwzZQwQq+JPscz18QmN0L1Pm4d8mj32KmC4BwN8hmZCCUTaOmHfT1
 d/DQ==
X-Gm-Message-State: AOJu0YwyPiSbplOKALAqORjAgC6V9iIRi5E5FfMSUUlpSL61x2Xvf475
 u18xFehUT+MsbDPxtbIz7bu/fz/EyvZUoLFT+t/Cv4c+dC527V6HH9A1nhnlub66GbjIy8kxmL7
 YmV0=
X-Google-Smtp-Source: AGHT+IFvfUBT+yr8mGnwlmG+vqVkKBTVuNRMPnfbSTRxMJG4HDzlJLXnTTGXpe52XCOXffW01XD/wg==
X-Received: by 2002:a5d:8e19:0:b0:806:3dac:5081 with SMTP id
 ca18e2360f4ac-81fd11321aemr415677139f.7.1722643077036; 
 Fri, 02 Aug 2024 16:57:57 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 17/17] bsd-user: copy linux-user target_mprotect impl
Date: Fri,  2 Aug 2024 17:56:17 -0600
Message-ID: <20240802235617.7971-18-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Now that we're closer to the linux-user target_mprotect code, go ahead
and grab the rest of the implementation. This moves from a stard, end
impl to a start, last which will allow last page mapping, etc. This also
moves to a more general algorithm. We're close enough that this jump
isn't so large, and doing it incrementally further has become too
much work for too little gain.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 138 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 48 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 3c48a188e88..a4de7674bec 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -60,6 +60,17 @@ void mmap_fork_end(int child)
         pthread_mutex_unlock(&mmap_mutex);
 }
 
+/*
+ * Map target protection mask to host. Identity on FreeBSD.
+ */
+static abi_ulong target_to_host_prot(abi_ulong prot)
+{
+    return (prot);
+}
+
+/* Helpful temporary #define to reduce diffs with linux-user mmap.c */
+#define trace_target_mprotect(start, len, target_prot)
+
 /*
  * Validate target prot bitmask.
  * Return the prot bitmask for the host in *HOST_PROT.
@@ -78,72 +89,103 @@ static int validate_prot_to_pageflags(int prot)
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
     int host_page_size = qemu_real_host_page_size();
-    abi_ulong end, host_start, host_end, addr;
-    int prot1, ret, page_flags;
-
-    qemu_log_mask(CPU_LOG_PAGE, "mprotect: start=0x" TARGET_ABI_FMT_lx
-                  " len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c\n", start, len,
-                  target_prot & PROT_READ ? 'r' : '-',
-                  target_prot & PROT_WRITE ? 'w' : '-',
-                  target_prot & PROT_EXEC ? 'x' : '-');
-    if ((start & ~TARGET_PAGE_MASK) != 0)
-        return -EINVAL;
+    abi_ulong starts[3];
+    abi_ulong lens[3];
+    int prots[3];
+    abi_ulong host_start, host_last, last;
+    int prot1, ret, page_flags, nranges;
+
+    trace_target_mprotect(start, len, target_prot);
+
+    if ((start & ~TARGET_PAGE_MASK) != 0) {
+        return -TARGET_EINVAL;
+    }
     page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         return -TARGET_EINVAL;
     }
-    len = TARGET_PAGE_ALIGN(len);
-    if (len == 0)
+    if (len == 0) {
         return 0;
+    }
+    len = TARGET_PAGE_ALIGN(len);
     if (!guest_range_valid_untagged(start, len)) {
-        return -ENOMEM;
+        return -TARGET_ENOMEM;
     }
-    target_prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
-    end = start + len;
 
-    mmap_lock();
+    last = start + len - 1;
     host_start = start & -host_page_size;
-    host_end = HOST_PAGE_ALIGN(end);
-    if (start > host_start) {
-        /* handle host page containing start */
+    host_last = ROUND_UP(last, host_page_size) - 1;
+    nranges = 0;
+
+    mmap_lock();
+
+    if (host_last - host_start < host_page_size) {
+        /* Single host page contains all guest pages: sum the prot. */
         prot1 = target_prot;
-        for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot1 |= page_get_flags(addr);
+        for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot1 |= page_get_flags(a);
+        }
+        for (abi_ulong a = last; a < host_last; a += TARGET_PAGE_SIZE) {
+            prot1 |= page_get_flags(a + 1);
         }
-        if (host_end == host_start + host_page_size) {
-            for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
-                prot1 |= page_get_flags(addr);
+        starts[nranges] = host_start;
+        lens[nranges] = host_page_size;
+        prots[nranges] = prot1;
+        nranges++;
+    } else {
+        if (host_start < start) {
+            /* Host page contains more than one guest page: sum the prot. */
+            prot1 = target_prot;
+            for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
+                prot1 |= page_get_flags(a);
+            }
+            /* If the resulting sum differs, create a new range. */
+            if (prot1 != target_prot) {
+                starts[nranges] = host_start;
+                lens[nranges] = host_page_size;
+                prots[nranges] = prot1;
+                nranges++;
+                host_start += host_page_size;
             }
-            end = host_end;
         }
-        ret = mprotect(g2h_untagged(host_start),
-                       host_page_size, prot1 & PAGE_RWX);
-        if (ret != 0)
-            goto error;
-        host_start += host_page_size;
-    }
-    if (end < host_end) {
-        prot1 = target_prot;
-        for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
-            prot1 |= page_get_flags(addr);
+
+        if (last < host_last) {
+            /* Host page contains more than one guest page: sum the prot. */
+            prot1 = target_prot;
+            for (abi_ulong a = last; a < host_last; a += TARGET_PAGE_SIZE) {
+                prot1 |= page_get_flags(a + 1);
+            }
+            /* If the resulting sum differs, create a new range. */
+            if (prot1 != target_prot) {
+                host_last -= host_page_size;
+                starts[nranges] = host_last + 1;
+                lens[nranges] = host_page_size;
+                prots[nranges] = prot1;
+                nranges++;
+            }
+        }
+
+        /* Create a range for the middle, if any remains. */
+        if (host_start < host_last) {
+            starts[nranges] = host_start;
+            lens[nranges] = host_last - host_start + 1;
+            prots[nranges] = target_prot;
+            nranges++;
         }
-        ret = mprotect(g2h_untagged(host_end - host_page_size),
-                       host_page_size, prot1 & PAGE_RWX);
-        if (ret != 0)
-            goto error;
-        host_end -= host_page_size;
     }
 
-    /* handle the pages in the middle */
-    if (host_start < host_end) {
-        ret = mprotect(g2h_untagged(host_start), host_end - host_start, target_prot);
-        if (ret != 0)
+    for (int i = 0; i < nranges; ++i) {
+        ret = mprotect(g2h_untagged(starts[i]), lens[i],
+                       target_to_host_prot(prots[i]));
+        if (ret != 0) {
             goto error;
+        }
     }
-    page_set_flags(start, start + len - 1, page_flags);
-    mmap_unlock();
-    return 0;
-error:
+
+    page_set_flags(start, last, page_flags);
+    ret = 0;
+
+ error:
     mmap_unlock();
     return ret;
 }
-- 
2.45.1


