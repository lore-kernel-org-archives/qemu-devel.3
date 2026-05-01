Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17747CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 16:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIqSW-0005Na-G8; Fri, 01 May 2026 12:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1wIqST-0005NL-C9
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:11:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1wIqSQ-0002al-O7
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:11:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso21435115e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777651873; x=1778256673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMEWKSQ/RSCozoHhOpqRI+VRHQvtonijjlfJLhN4XF4=;
 b=ovKndJjVgUZaMOg564zx+CFQMlsAPFIge4vk4uaud9cKahDJ9t1Zo7kjbrRTbKyCrt
 AChtJM45bPaPMoqDUKvGju+v0V4Wn3g3X/ke8Vwadr8/K+sc38C9N1TXd7JXl5xABxnB
 0b8PbIyS618gW/A0R7ouuZ+pyDm27UxMdDKf7oRkEisV6BUm8AvFax88mBIv6bGkZIm5
 pBXtMT4CV6NAOBqQe4uCY9cprMvexvalc2ByhpJPJXA8AOylQHf9jrkn2VIUUi7W+k5x
 nIR5AeEmV88ev5L3jooMsx95o57COh/D33B+U0qwU4U89SUCNyD7Rn5Ouz8vyhP9I8TG
 6XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777651873; x=1778256673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMEWKSQ/RSCozoHhOpqRI+VRHQvtonijjlfJLhN4XF4=;
 b=injgRaA7uic4yX/eWCf/UWzSztueGxhHiSiv4aEZly0F0ktRp7dw442W2dscr0l5nZ
 +6uQvuZ7T2LCuOJrsd2tpaRwCZFjSYvXKFp1nFNiuoWf0p0/t6uN53I2Qd+f4Bnauq8I
 /RCvkTbKgolSgfa/joaurqR4rs0G2yIHW2q4rTSw7joSGxMzKxEvA8Tw7+jYXn31j4KW
 GRjMEI516octz2FdHx/kBenEkjf0xlomUe1v/PmTpWYZMLLJGIidJkJRhIIYO8AHhgAH
 bG+JHw1xuUzH1PqRKK5CXwO0J6y4nxcGM4WSBTdGmMZIPGy9TL6PQ7Y56d2U2xDamv8D
 t8rw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8pDOEEVRg0gMiZjGiuDRza9pYCTtttJZKdpLrPdmG5E1wYUWpyHE9RauWEQsDiMtVjHvKLFQs6vHY@nongnu.org
X-Gm-Message-State: AOJu0YyHaFn4mYyK7vry7EcNhOVy21W1qCHSMC6ZQ3218kH3OR/XZlLJ
 5PpRm2hlGCiriR61wBMO99Ot4DFPnKpL/R2ojeP1OBsWx75/UQ+ch4bB
X-Gm-Gg: AeBDieufly32OyqSH4UNx2m7Q2b629TewjxyBYToTR6l+JcrwLHDk0VSsAjdku1YQYU
 r+opJ41a/XjKcT8cweG3Tb3lZ5F5ccsSQvEcoibKGM0w/gLR7SdClSC0VrWNv/dmw9Tn4AJzKJN
 UVVLxfaeQkX0Vqteo00lUFTloMSyC4W3YVMzlFsWUVtXwrDaJ2lw0nCSdR14xqI1VD1ranhssUM
 yvjr5zCbAseH7HI7DBUICCk/47TIuk4WcuuzaeSg9RlOJyZ4sa4z0vCLVxFxMhXP1s212lvpe4E
 +g+5Cxk4MTKTIkxPlm0c0UGvDIt/ny+MBq5BSDv0b/T/yy85Pov6CVHQwJPsEQ5Z6NOuQIvjvTM
 1hepNbxRP7mP/7QBRQn7deh44Hmr+icKkDsO0bPaYJZyBP2zOGDBVqrMwupJK8b5VjhM4lRSx/3
 Xlx+dVB4dLUr6jyVl7P0lsvfbluxrBQLwLBU2EeShjwfssXcpm+w4QbysYRGlR592Sj2YThbJR
X-Received: by 2002:a05:600c:4a9f:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48a95627aa2mr13849645e9.24.1777651872701; 
 Fri, 01 May 2026 09:11:12 -0700 (PDT)
Received: from ST.. ([196.221.137.242]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm109156315e9.0.2026.05.01.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:11:11 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
To: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
Date: Fri,  1 May 2026 19:11:06 +0300
Message-Id: <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=mohamedaymanworkspace@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The bsd-user implementation previously cached host page size and mask
in global variables (qemu_host_page_size and qemu_host_page_mask),
which duplicated information already available through
qemu_real_host_page_size().

This introduced unnecessary global state and potential inconsistencies
if the host page size is queried or changes during initialization.

Replace all usages of qemu_host_page_size and qemu_host_page_mask with
HOST_PAGE_SIZE and HOST_PAGE_MASK macros defined as:

  MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)

This preserves the original behavior where the effective host page size
is the maximum of the real host page size and the target page size,
which matters on targets like aarch64 with 16K pages running on an
amd64 host with 4K pages.

This also opens the way for renaming qemu_real_host_page_size() to
qemu_host_page_size() now that the bsd-user globals no longer occupy
that name.

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 bsd-user/elfload.c |  25 ++---------
 bsd-user/main.c    |  14 ++-----
 bsd-user/mmap.c    | 102 ++++++++++++++++-----------------------------
 bsd-user/qemu.h    |  10 ++---
 4 files changed, 46 insertions(+), 105 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 3bca0cc9ed..00250fc3c1 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -192,14 +192,14 @@ static void setup_arg_pages(struct bsd_binprm *bprm, struct image_info *info,
      */
     size = target_dflssiz;
     stack_base = TARGET_USRSTACK - size;
-    addr = target_mmap(stack_base , size + qemu_host_page_size,
+    addr = target_mmap(stack_base , size + HOST_PAGE_SIZE,
             PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
     if (addr == -1) {
         perror("stk mmap");
         exit(-1);
     }
     /* we reserve one extra page at the top of the stack as guard */
-    target_mprotect(addr + size, qemu_host_page_size, PROT_NONE);
+    target_mprotect(addr + size, HOST_PAGE_SIZE, PROT_NONE);
 
     target_stksiz = size;
     target_stkbas = addr;
@@ -239,27 +239,10 @@ static void padzero(abi_ulong elf_bss, abi_ulong last_bss)
         return;
     }
 
-    /*
-     * XXX: this is really a hack : if the real host page size is
-     * smaller than the target page size, some pages after the end
-     * of the file may not be mapped. A better fix would be to
-     * patch target_mmap(), but it is more complicated as the file
-     * size must be known.
-     */
-    if (qemu_real_host_page_size() < qemu_host_page_size) {
-        abi_ulong end_addr, end_addr1;
-        end_addr1 = REAL_HOST_PAGE_ALIGN(elf_bss);
-        end_addr = HOST_PAGE_ALIGN(elf_bss);
-        if (end_addr1 < end_addr) {
-            mmap((void *)g2h_untagged(end_addr1), end_addr - end_addr1,
-                 PROT_READ | PROT_WRITE | PROT_EXEC,
-                 MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0);
-        }
-    }
 
-    nbyte = elf_bss & (qemu_host_page_size - 1);
+    nbyte = elf_bss & (HOST_PAGE_SIZE - 1);
     if (nbyte) {
-        nbyte = qemu_host_page_size - nbyte;
+        nbyte = HOST_PAGE_SIZE - nbyte;
         do {
             /* FIXME - what to do if put_user() fails? */
             put_user_u8(0, elf_bss);
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c327..3f5141e794 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -54,11 +54,6 @@
 #include "target_arch_cpu.h"
 
 
-/*
- * TODO: Remove these and rely only on qemu_real_host_page_size().
- */
-uintptr_t qemu_host_page_size;
-intptr_t qemu_host_page_mask;
 
 static bool opt_one_insn_per_tb;
 static unsigned long opt_tb_size;
@@ -302,8 +297,6 @@ int main(int argc, char **argv)
         (void) envlist_setenv(envlist, *wrk);
     }
 
-    qemu_host_page_size = getpagesize();
-    qemu_host_page_size = MAX(qemu_host_page_size, TARGET_PAGE_SIZE);
 
     cpu_model = NULL;
 
@@ -405,7 +398,6 @@ int main(int argc, char **argv)
         }
     }
 
-    qemu_host_page_mask = -qemu_host_page_size;
 
     /* init debug */
     {
@@ -452,7 +444,7 @@ int main(int argc, char **argv)
 
     cpu_type = parse_cpu_option(cpu_model);
 
-    /* init tcg before creating CPUs and to get qemu_host_page_size */
+    /* init tcg before creating CPUs */
     {
         AccelState *accel = current_accel();
         AccelClass *ac = ACCEL_GET_CLASS(accel);
@@ -534,7 +526,7 @@ int main(int argc, char **argv)
      * proper page alignment for guest_base.
      */
     if (have_guest_base) {
-        if (guest_base & ~qemu_host_page_mask) {
+        if (guest_base & ~HOST_PAGE_MASK) {
             error_report("Selected guest base not host page aligned");
             exit(1);
         }
@@ -573,7 +565,7 @@ int main(int argc, char **argv)
         /* Ensure that mmap_next_start is within range. */
         if (reserved_va <= mmap_next_start) {
             mmap_next_start = (reserved_va / 4 * 3)
-                              & TARGET_PAGE_MASK & qemu_host_page_mask;
+                              & TARGET_PAGE_MASK & HOST_PAGE_MASK;
         }
     }
 
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index fe77eceb48..59c70083a4 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -84,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         return 0;
 
     mmap_lock();
-    host_start = start & qemu_host_page_mask;
+    host_start = start & HOST_PAGE_MASK;
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
@@ -92,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
-        if (host_end == host_start + qemu_host_page_size) {
+        if (host_end == host_start + HOST_PAGE_SIZE) {
             for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
                 prot1 |= page_get_flags(addr);
             }
             end = host_end;
         }
         ret = mprotect(g2h_untagged(host_start),
-                       qemu_host_page_size, prot1 & PAGE_RWX);
+                       HOST_PAGE_SIZE, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
-        host_start += qemu_host_page_size;
+        host_start += HOST_PAGE_SIZE;
     }
     if (end < host_end) {
         prot1 = prot;
         for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
-        ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, prot1 & PAGE_RWX);
+        ret = mprotect(g2h_untagged(host_end - HOST_PAGE_SIZE),
+                       HOST_PAGE_SIZE, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
-        host_end -= qemu_host_page_size;
+        host_end -= HOST_PAGE_SIZE;
     }
 
     /* handle the pages in the middle */
@@ -193,7 +193,7 @@ static int mmap_frag(abi_ulong real_start,
     void *host_start;
     int prot1, prot_new;
 
-    real_end = real_start + qemu_host_page_size;
+    real_end = real_start + HOST_PAGE_SIZE;
     host_start = g2h_untagged(real_start);
 
     /* get the protection of the target pages outside the mapping */
@@ -205,7 +205,7 @@ static int mmap_frag(abi_ulong real_start,
 
     if (prot1 == 0) {
         /* no page was there, so we allocate one. See also above. */
-        void *p = mmap(host_start, qemu_host_page_size, prot,
+        void *p = mmap(host_start, HOST_PAGE_SIZE, prot,
                        flags | ((fd != -1) ? MAP_ANON : 0), -1, 0);
         if (p == MAP_FAILED)
             return -1;
@@ -223,7 +223,7 @@ static int mmap_frag(abi_ulong real_start,
 
         /* adjust protection to be able to read */
         if (!(prot1 & PROT_WRITE))
-            mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE);
+            mprotect(host_start, HOST_PAGE_SIZE, prot1 | PROT_WRITE);
 
         /* read the corresponding file data */
         if (!mmap_pread(fd, g2h_untagged(start), end - start, offset, true)) {
@@ -232,10 +232,10 @@ static int mmap_frag(abi_ulong real_start,
 
         /* put final protection */
         if (prot_new != (prot1 | PROT_WRITE))
-            mprotect(host_start, qemu_host_page_size, prot_new);
+            mprotect(host_start, HOST_PAGE_SIZE, prot_new);
     } else {
         if (prot_new != prot1) {
-            mprotect(host_start, qemu_host_page_size, prot_new);
+            mprotect(host_start, HOST_PAGE_SIZE, prot_new);
         }
         if (prot_new & PROT_WRITE) {
             memset(g2h_untagged(start), 0, end - start);
@@ -289,7 +289,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment)
     if (start == 0) {
         start = mmap_next_start;
     } else {
-        start &= qemu_host_page_mask;
+        start &= HOST_PAGE_MASK;
     }
 
     size = HOST_PAGE_ALIGN(size);
@@ -297,7 +297,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment)
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size,
             (alignment != 0 ? 1 << alignment :
-             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
+             MAX(HOST_PAGE_SIZE, TARGET_PAGE_SIZE)));
     }
 
     addr = start;
@@ -478,8 +478,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         goto fail;
     }
 
-    real_start = start & qemu_host_page_mask;
-    host_offset = offset & qemu_host_page_mask;
+    real_start = start & HOST_PAGE_MASK;
+    host_offset = offset & HOST_PAGE_MASK;
 
     /*
      * If the user is asking for the kernel to find a location, do that
@@ -498,38 +498,6 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
     }
 
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
-
-    if ((qemu_real_host_page_size() < qemu_host_page_size) && fd != -1) {
-        struct stat sb;
-
-        if (fstat(fd, &sb) == -1) {
-            goto fail;
-        }
-
-        /* Are we trying to create a map beyond EOF?.  */
-        if (offset + len > sb.st_size) {
-            /*
-             * If so, truncate the file map at eof aligned with
-             * the hosts real pagesize. Additional anonymous maps
-             * will be created beyond EOF.
-             */
-            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
-        }
-    }
-
     if (!(flags & MAP_FIXED)) {
         unsigned long host_start;
         void *p;
@@ -539,8 +507,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
 
         /*
          * Note: we prefer to control the mapping address. It is
-         * especially important if qemu_host_page_size >
-         * qemu_real_host_page_size
+         * especially important if HOST_PAGE_SIZE >
+         * TARGET_PAGE_SIZE
          */
         p = mmap(g2h_untagged(start), host_len, prot,
                  flags | MAP_FIXED | ((fd != -1) ? MAP_ANON : 0), -1, 0);
@@ -581,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
          * aligned, so we read it
          */
         if (fd != -1 &&
-            (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
+            (offset & ~HOST_PAGE_MASK) != (start & ~HOST_PAGE_MASK)) {
             /*
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
@@ -614,7 +582,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
 
         /* handle the start of the mapping */
         if (start > real_start) {
-            if (real_end == real_start + qemu_host_page_size) {
+            if (real_end == real_start + HOST_PAGE_SIZE) {
                 /* one single host page */
                 ret = mmap_frag(real_start, start, end,
                                 prot, flags, fd, offset);
@@ -622,21 +590,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                     goto fail;
                 goto the_end1;
             }
-            ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
+            ret = mmap_frag(real_start, start, real_start + HOST_PAGE_SIZE,
                             prot, flags, fd, offset);
             if (ret == -1)
                 goto fail;
-            real_start += qemu_host_page_size;
+            real_start += HOST_PAGE_SIZE;
         }
         /* handle the end of the mapping */
         if (end < real_end) {
-            ret = mmap_frag(real_end - qemu_host_page_size,
-                            real_end - qemu_host_page_size, end,
+            ret = mmap_frag(real_end - HOST_PAGE_SIZE,
+                            real_end - HOST_PAGE_SIZE, end,
                             prot, flags, fd,
-                            offset + real_end - qemu_host_page_size - start);
+                            offset + real_end - HOST_PAGE_SIZE - start);
             if (ret == -1)
                 goto fail;
-            real_end -= qemu_host_page_size;
+            real_end -= HOST_PAGE_SIZE;
         }
 
         /* map the middle (easier) */
@@ -676,7 +644,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
     abi_ulong end;
     int prot;
 
-    real_start = start & qemu_host_page_mask;
+    real_start = start & HOST_PAGE_MASK;
     real_end = HOST_PAGE_ALIGN(start + size);
     end = start + size;
     if (start > real_start) {
@@ -685,14 +653,14 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
         for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(addr);
         }
-        if (real_end == real_start + qemu_host_page_size) {
+        if (real_end == real_start + HOST_PAGE_SIZE) {
             for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
                 prot |= page_get_flags(addr);
             }
             end = real_end;
         }
         if (prot != 0) {
-            real_start += qemu_host_page_size;
+            real_start += HOST_PAGE_SIZE;
         }
     }
     if (end < real_end) {
@@ -701,7 +669,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
             prot |= page_get_flags(addr);
         }
         if (prot != 0) {
-            real_end -= qemu_host_page_size;
+            real_end -= HOST_PAGE_SIZE;
         }
     }
     if (real_start != real_end) {
@@ -727,7 +695,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
         return -EINVAL;
     mmap_lock();
     end = start + len;
-    real_start = start & qemu_host_page_mask;
+    real_start = start & HOST_PAGE_MASK;
     real_end = HOST_PAGE_ALIGN(end);
 
     if (start > real_start) {
@@ -736,14 +704,14 @@ int target_munmap(abi_ulong start, abi_ulong len)
         for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(addr);
         }
-        if (real_end == real_start + qemu_host_page_size) {
+        if (real_end == real_start + HOST_PAGE_SIZE) {
             for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
                 prot |= page_get_flags(addr);
             }
             end = real_end;
         }
         if (prot != 0)
-            real_start += qemu_host_page_size;
+            real_start += HOST_PAGE_SIZE;
     }
     if (end < real_end) {
         prot = 0;
@@ -751,7 +719,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
             prot |= page_get_flags(addr);
         }
         if (prot != 0)
-            real_end -= qemu_host_page_size;
+            real_end -= HOST_PAGE_SIZE;
     }
 
     ret = 0;
@@ -784,6 +752,6 @@ int target_msync(abi_ulong start, abi_ulong len, int flags)
     if (end == start)
         return 0;
 
-    start &= qemu_host_page_mask;
+    start &= HOST_PAGE_MASK;
     return msync(g2h_untagged(start), end - start, flags);
 }
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index b0b2c249fb..7553ac154c 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -44,12 +44,10 @@ extern char **environ;
 #include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
-/*
- * TODO: Remove these and rely only on qemu_real_host_page_size().
- */
-extern uintptr_t qemu_host_page_size;
-extern intptr_t qemu_host_page_mask;
-#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+
+#define HOST_PAGE_SIZE        MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)
+#define HOST_PAGE_MASK        ((intptr_t)~(HOST_PAGE_SIZE - 1))
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)
 
 /*
  * This struct is used to hold certain information about the image.  Basically,
-- 
2.34.1


