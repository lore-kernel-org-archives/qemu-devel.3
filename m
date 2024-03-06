Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F19C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWu-0005Wg-Qb; Wed, 06 Mar 2024 01:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWH-0004yZ-OG
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:51 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWC-0006GC-VI
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:48 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso5864835a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705561; x=1710310361;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W8pmybqo3MF49nkGilqwgGL/v4Pl4OfK1iEYauJ4N5w=;
 b=wVsq6u8oc6NUNWXuEgEq1/j6YWOpe3c0+zbtlLjhJlNuTQKWbw6NTK96h/CLM3yizH
 5nKoKNyUh2txKGUmmYf8WHJJQISMp7nLtul1hw8NObD451TNFrxVl6NceNBQieWn5Ucr
 J2siZHSY7cubgnpEBrfoRAzWrcMeAuv8XdWfWe8Zfq5+KpDBEVWZlsfZ9SNc69LZxHx0
 0/2kt0CwtYGz9J9L6U0vqiJH0MHlwBq0b+ChyDg1fEE5Xh5vXnCr3A63w1RE7CTFB2dI
 zBGI9VaOXhh2aPCf8wG+63yYrhWJvIXOMLI+NIdoownQXNiUPNbalzLYf59vMXQG5Lfb
 2fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705561; x=1710310361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8pmybqo3MF49nkGilqwgGL/v4Pl4OfK1iEYauJ4N5w=;
 b=H3cSdX6VG0Q8jH80i22CVCax1yzqHN6z7b4LLJc5ZKuqJRKNRt7f5a3RQ83tE3qmGR
 piSpG7f22EzCFDrD/px837njvUUrV5pp2GSwHZAaqGvyrtc2mIeZ9XKfTGiwpCZhRx3C
 im3COcJWH3je2tg6r+PNJLI1ipKqdRFxf4SP0fsKbWmkD7vt1ZLL3g6PiqNa5d6UT4JN
 y1jKngBgHNpZue0DwlfQeJR3I61+RZrNXNe4yQDzV3rAwZGpA6JC8MCSuGlXxEw14Xqi
 DfvblZBOV3B9nZXxusoe6rQDwyt14vBmKXhkjTR8o0PQ2/lfWJzVJrQQHlL2AzJSih/0
 MalQ==
X-Gm-Message-State: AOJu0YxfFCgL1V7vKT0wBWHGJGxrIfPziP9Eyj2qSzxaYjMxrSYwKDam
 qq7AnaYPssPzNxtWIUPsA2kc6+b5wTVXeDn27WMwVLVfj3AkkqbfnRqf76S71K8a7mYXT+jcnm8
 T
X-Google-Smtp-Source: AGHT+IH2Pt/6cnxJSv7PWdJ5qf0lZxp2QWbcyyKibXynKkQjhvQx7MzzFlVBIzSZqkJnkE0x8DcURw==
X-Received: by 2002:a05:6a20:729b:b0:1a1:4b3e:5ef1 with SMTP id
 o27-20020a056a20729b00b001a14b3e5ef1mr4653649pzk.26.1709705561056; 
 Tue, 05 Mar 2024 22:12:41 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 n4-20020a170902968400b001db8145a1a2sm11663587plp.274.2024.03.05.22.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:15 +0900
Subject: [PATCH v3 09/19] contrib/elf2dmp: Fix error reporting style in main.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-9-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/main.c | 63 +++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index cb28971789e4..c290781feb18 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -186,13 +186,13 @@ static void win_context_init_from_qemu_cpu_state(WinContext64 *ctx,
  * Finds paging-structure hierarchy base,
  * if previously set doesn't give access to kernel structures
  */
-static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
+static bool fix_dtb(struct va_space *vs, QEMU_Elf *qe)
 {
     /*
      * Firstly, test previously set DTB.
      */
     if (va_space_resolve(vs, SharedUserData)) {
-        return 0;
+        return true;
     }
 
     /*
@@ -206,7 +206,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
             va_space_set_dtb(vs, s->cr[3]);
             printf("DTB 0x%016"PRIx64" has been found from CPU #%zu"
                     " as system task CR3\n", vs->dtb, i);
-            return !(va_space_resolve(vs, SharedUserData));
+            return !!(va_space_resolve(vs, SharedUserData));
         }
     }
 
@@ -220,16 +220,16 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
         uint64_t *cr3 = va_space_resolve(vs, Prcb + 0x7000);
 
         if (!cr3) {
-            return 1;
+            return false;
         }
 
         va_space_set_dtb(vs, *cr3);
         printf("DirectoryTableBase = 0x%016"PRIx64" has been found from CPU #0"
                 " as interrupt handling CR3\n", vs->dtb);
-        return !(va_space_resolve(vs, SharedUserData));
+        return !!(va_space_resolve(vs, SharedUserData));
     }
 
-    return 1;
+    return true;
 }
 
 static void try_merge_runs(struct pa_space *ps,
@@ -268,9 +268,10 @@ static void try_merge_runs(struct pa_space *ps,
     }
 }
 
-static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
-        struct va_space *vs, uint64_t KdDebuggerDataBlock,
-        KDDEBUGGER_DATA64 *kdbg, uint64_t KdVersionBlock, int nr_cpus)
+static bool fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
+                        struct va_space *vs, uint64_t KdDebuggerDataBlock,
+                        KDDEBUGGER_DATA64 *kdbg, uint64_t KdVersionBlock,
+                        int nr_cpus)
 {
     uint32_t *suite_mask = va_space_resolve(vs, SharedUserData +
             KUSD_OFFSET_SUITE_MASK);
@@ -283,12 +284,12 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
     QEMU_BUILD_BUG_ON(KUSD_OFFSET_PRODUCT_TYPE >= ELF2DMP_PAGE_SIZE);
 
     if (!suite_mask || !product_type) {
-        return 1;
+        return false;
     }
 
     if (!va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
         eprintf("Failed to extract KdVersionBlock\n");
-        return 1;
+        return false;
     }
 
     h = (WinDumpHeader64) {
@@ -333,7 +334,7 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
 
     *hdr = h;
 
-    return 0;
+    return true;
 }
 
 /*
@@ -379,8 +380,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
     }
 }
 
-static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
-        void *entry, size_t size, struct va_space *vs)
+static bool pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
+                                  void *entry, size_t size, struct va_space *vs)
 {
     const char e_magic[2] = "MZ";
     const char Signature[4] = "PE\0\0";
@@ -393,38 +394,38 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
     QEMU_BUILD_BUG_ON(sizeof(*dos_hdr) >= ELF2DMP_PAGE_SIZE);
 
     if (memcmp(&dos_hdr->e_magic, e_magic, sizeof(e_magic))) {
-        return 1;
+        return false;
     }
 
     if (!va_space_rw(vs, base + dos_hdr->e_lfanew,
                      &nt_hdrs, sizeof(nt_hdrs), 0)) {
-        return 1;
+        return false;
     }
 
     if (memcmp(&nt_hdrs.Signature, Signature, sizeof(Signature)) ||
             file_hdr->Machine != 0x8664 || opt_hdr->Magic != 0x020b) {
-        return 1;
+        return false;
     }
 
     if (!va_space_rw(vs, base + data_dir[idx].VirtualAddress, entry, size, 0)) {
-        return 1;
+        return false;
     }
 
     printf("Data directory entry #%d: RVA = 0x%08"PRIx32"\n", idx,
             (uint32_t)data_dir[idx].VirtualAddress);
 
-    return 0;
+    return true;
 }
 
-static int write_dump(struct pa_space *ps,
-        WinDumpHeader64 *hdr, const char *name)
+static bool write_dump(struct pa_space *ps,
+                       WinDumpHeader64 *hdr, const char *name)
 {
     FILE *dmp_file = fopen(name, "wb");
     size_t i;
 
     if (!dmp_file) {
         eprintf("Failed to open output file \'%s\'\n", name);
-        return 1;
+        return false;
     }
 
     printf("Writing header to file...\n");
@@ -432,7 +433,7 @@ static int write_dump(struct pa_space *ps,
     if (fwrite(hdr, sizeof(*hdr), 1, dmp_file) != 1) {
         eprintf("Failed to write dump header\n");
         fclose(dmp_file);
-        return 1;
+        return false;
     }
 
     for (i = 0; i < ps->block_nr; i++) {
@@ -443,11 +444,11 @@ static int write_dump(struct pa_space *ps,
         if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
             eprintf("Failed to write block\n");
             fclose(dmp_file);
-            return 1;
+            return false;
         }
     }
 
-    return fclose(dmp_file);
+    return !fclose(dmp_file);
 }
 
 static bool pe_check_pdb_name(uint64_t base, void *start_addr,
@@ -457,8 +458,8 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     IMAGE_DEBUG_DIRECTORY debug_dir;
     char pdb_name[sizeof(PDB_NAME)];
 
-    if (pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
-                &debug_dir, sizeof(debug_dir), vs)) {
+    if (!pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
+                               &debug_dir, sizeof(debug_dir), vs)) {
         eprintf("Failed to get Debug Directory\n");
         return false;
     }
@@ -546,7 +547,7 @@ int main(int argc, char *argv[])
     printf("CPU #0 CR3 is 0x%016"PRIx64"\n", state->cr[3]);
 
     va_space_create(&vs, &ps, state->cr[3]);
-    if (fix_dtb(&vs, &qemu_elf)) {
+    if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
         goto out_elf;
     }
@@ -611,14 +612,14 @@ int main(int argc, char *argv[])
         goto out_pdb;
     }
 
-    if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
-            KdVersionBlock, qemu_elf.state_nr)) {
+    if (!fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
+                     KdVersionBlock, qemu_elf.state_nr)) {
         goto out_kdbg;
     }
 
     fill_context(kdbg, &vs, &qemu_elf);
 
-    if (write_dump(&ps, &header, argv[2])) {
+    if (!write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");
         goto out_kdbg;
     }

-- 
2.44.0


