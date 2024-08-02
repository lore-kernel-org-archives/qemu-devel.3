Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BD3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29m-00028R-Eg; Fri, 02 Aug 2024 19:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29i-0001v3-UY
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:55 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29h-0004Ig-5W
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:54 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-816ca307407so312545839f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643071; x=1723247871;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjbYI1GPGe/HLcBnpiBAspcHBUxaAboZV8ZlqCzZd1k=;
 b=IZe76LRgTSdEyrt0fwGPQr/goaaKWizEQ41962lMp5dhGcdPvcDY3/RBCBlokgP5L6
 yGf406QpWu/rG9kjWQ9mCE3K1Bl/VMjR+hsiPFUC9boUqGLrCa/XffZ/dg+1t9VeBDA/
 IiHMjzAykLAQT2NAF+gCh7z4EXViPDtwV/bQeEWZoxOyUPioHpqTOpFQEID6+R7Av7yQ
 8quYXB7vJ7Jps5r+fhir79cf3rgfub2ODjCA9/PBu3BJze9aI3LwHJttj80mTlYpQYb9
 hWOfFCnl7lRe86kBDQ2rYAyXa83Itv1TsuQE1PoZZGUaCLS4HAw3xYBO0TszYN6Mgome
 gjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643071; x=1723247871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjbYI1GPGe/HLcBnpiBAspcHBUxaAboZV8ZlqCzZd1k=;
 b=itn4VR1B/Bmt2jWVZbdK2QSAEHnrRrIxVILzo1z0C2XNHhYdhKePCNp8zmquut3HIZ
 Vm8787g3W7JFWIjoQrY2YQfhX82UF5TQ4d7HFLjO+veo1BHbdAaTl+d1J1GHol7wncfL
 KfMo92e+txRsWQlqh8cLURKDg1CExH5U2wtAIIWwPVgO3vDHRR/0+beaiyWxiaZ6GvOx
 0J15gvutJDNQLVm2bkcHptCNh/cvUhi8j3mFGl6CZ8SaZNoDvcPgaSaVEelYTsexnwur
 xjye4Ri8l8HjplkcsBNLohFe1J5MzjUuMs3TTnKDl+8iXkD0ZNoTWcu1LoSy16xaP3gI
 RSdA==
X-Gm-Message-State: AOJu0Yzk1umj4KBO/B7RpCLukOuwGoK1lZMPmTHjA4KMkMP70vsxJMPk
 sQsJHxNomLFwe/Pynvl6OW+ekD+4kUAf2rJSqxORMny3yMfrDDUa8yk+B+2nX3jur1zrueMz8Jo
 urOM=
X-Google-Smtp-Source: AGHT+IGMEnGvMZZf/FOf0oDjclI6BfkucF5WiUzCWNtQV5GP906acktYZ3lTS76EuIDskNQ5F4kgBQ==
X-Received: by 2002:a05:6602:3fcb:b0:7f7:d2c7:3b7a with SMTP id
 ca18e2360f4ac-81fd42b7b96mr624313039f.0.1722643071078; 
 Fri, 02 Aug 2024 16:57:51 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 11/17] bsd-user: Replace set_brk and padzero with zerobss from
 linux-user
Date: Fri,  2 Aug 2024 17:56:11 -0600
Message-ID: <20240802235617.7971-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd31.google.com
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

The zero_bss interface from linux-user is much better at doing this. Use
it in preference to set_brk (badly named) and padzero. These both have
issues with the new variable page size code, so it's best to just retire
them and reuse the code from linux-user. Also start to use the error
reporting code that linux-user uses to give better error messages on
failure.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/elfload.c | 110 +++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index dba03f17465..0a2f2379c93 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -22,6 +22,7 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "qemu/path.h"
+#include "qapi/error.h"
 
 static abi_ulong target_auxents;   /* Where the AUX entries are in target */
 static size_t target_auxents_sz;   /* Size of AUX entries including AT_NULL */
@@ -210,62 +211,63 @@ static void setup_arg_pages(struct bsd_binprm *bprm, struct image_info *info,
     }
 }
 
-static void set_brk(abi_ulong start, abi_ulong end)
+/**
+ * zero_bss:
+ *
+ * Map and zero the bss.  We need to explicitly zero any fractional pages
+ * after the data section (i.e. bss).  Return false on mapping failure.
+ */
+static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
+                     int prot, Error **errp)
 {
-    /* page-align the start and end addresses... */
-    start = HOST_PAGE_ALIGN(start);
-    end = HOST_PAGE_ALIGN(end);
-    if (end <= start) {
-        return;
-    }
-    if (target_mmap(start, end - start, PROT_READ | PROT_WRITE | PROT_EXEC,
-        MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) == -1) {
-        perror("cannot mmap brk");
-        exit(-1);
+    abi_ulong align_bss;
+
+    /* We only expect writable bss; the code segment shouldn't need this. */
+    if (!(prot & PROT_WRITE)) {
+        error_setg(errp, "PT_LOAD with non-writable bss");
+        return false;
     }
-}
 
+    align_bss = TARGET_PAGE_ALIGN(start_bss);
+    end_bss = TARGET_PAGE_ALIGN(end_bss);
 
-/*
- * We need to explicitly zero any fractional pages after the data
- * section (i.e. bss).  This would contain the junk from the file that
- * should not be in memory.
- */
-static void padzero(abi_ulong elf_bss, abi_ulong last_bss)
-{
-    abi_ulong nbyte;
+    if (start_bss < align_bss) {
+        int flags = page_get_flags(start_bss);
 
-    if (elf_bss >= last_bss) {
-        return;
-    }
+        if (!(flags & PAGE_RWX)) {
+            /*
+             * The whole address space of the executable was reserved
+             * at the start, therefore all pages will be VALID.
+             * But assuming there are no PROT_NONE PT_LOAD segments,
+             * a PROT_NONE page means no data all bss, and we can
+             * simply extend the new anon mapping back to the start
+             * of the page of bss.
+             */
+            align_bss -= TARGET_PAGE_SIZE;
+        } else {
+            /*
+             * The start of the bss shares a page with something.
+             * The only thing that we expect is the data section,
+             * which would already be marked writable.
+             * Overlapping the RX code segment seems malformed.
+             */
+            if (!(flags & PAGE_WRITE)) {
+                error_setg(errp, "PT_LOAD with bss overlapping "
+                           "non-writable page");
+                return false;
+            }
 
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
+            /* The page is already mapped and writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         }
     }
-
-    nbyte = elf_bss & (qemu_host_page_size - 1);
-    if (nbyte) {
-        nbyte = qemu_host_page_size - nbyte;
-        do {
-            /* FIXME - what to do if put_user() fails? */
-            put_user_u8(0, elf_bss);
-            elf_bss++;
-        } while (--nbyte);
+    if (align_bss < end_bss &&
+        target_mmap(align_bss, end_bss - align_bss, prot,
+                    MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) == -1) {
+        error_setg_errno(errp, errno, "Error mapping bss");
+        return false;
     }
+    return true;
 }
 
 static abi_ulong load_elf_interp(const char *elf_interpreter,
@@ -535,6 +537,7 @@ load_elf_sections(const char *image_name, const struct elfhdr *hdr,
     abi_ulong baddr;
     int i;
     bool first;
+    Error *err = NULL;
 
     /*
      * Now we do a little grungy work by mmaping the ELF image into
@@ -579,12 +582,10 @@ load_elf_sections(const char *image_name, const struct elfhdr *hdr,
             start_bss = rbase + elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
             end_bss = rbase + elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
 
-            /*
-             * Calling set_brk effectively mmaps the pages that we need for the
-             * bss and break sections.
-             */
-            set_brk(start_bss, end_bss);
-            padzero(start_bss, end_bss);
+            if (start_bss < end_bss &&
+                !zero_bss(start_bss, end_bss, elf_prot, &err)) {
+                goto exit_errmsg;
+            }
         }
 
         if (first) {
@@ -597,6 +598,9 @@ load_elf_sections(const char *image_name, const struct elfhdr *hdr,
         *baddrp = baddr;
     }
     return 0;
+exit_errmsg:
+    error_reportf_err(err, "%s: ", image_name);
+    exit(-1);
 }
 
 int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info)
-- 
2.45.1


