Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0473AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2Vh-0006bp-9V; Tue, 27 Feb 2024 13:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Vf-0006at-3N
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:59 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Vc-0001W6-Df
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:58 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e435542d41so3144896b3a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059734; x=1709664534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVP5ZXMph2vIaMrgjNZyRxPQx2YhCwiWw0i2ONELss0=;
 b=jUonchxBXfrSUgZCvU/gMSmnrOX8R+aToUhjCvv+aKLMma35dd4WNy1SQnxbb+Yzoo
 wWroeel3cAnOVXDM7BnfNf0cyGlK1Hi0SDkC5MZbJr9DsaLwWre30wch95vhMpsTpOCO
 3K2RKSAPykzeVT8fp9jRujiKTfAXGEX2nsxpeZF/y3B//FHXz8j/wO8gNmahl5G6Yv/T
 QNWasrvLHjkoVXyVMeKOmGgBzU95PirffRSNB1y3aGLp5u2TsM9ReO9r5zpmI4XhqR0y
 Q3zKRctNZiESXfG0boE9xVgZrwJSVCD4k0Aman6UF2hm72vyQ1b762/ipjZZa8zOcpJ1
 czZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059734; x=1709664534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVP5ZXMph2vIaMrgjNZyRxPQx2YhCwiWw0i2ONELss0=;
 b=KcOcSykjbbjROfn6/uEpqFOLitB5EgC/0PfEGPwvKjP2Ih77lLfrEjCy4w2k+wyjCr
 0PxcoJqcpimo6kxHwDL0/XcAT35YGoo1QOLoWbRpthDVUzOLXu7YSIsHUAuz7lug8lqb
 4w1pv42WKGPMzAzehkYnkMq/UTqqvKrq59Ak2v8EtaJwD7NO0di5q7csy2UialsDFiSR
 q2/n3syh9nzlqpBNZT57+RiDDpzqC/Zl4GUuuE2Um2gm8/JovQwXQ7L/MxrxSLu2v9PA
 W5Fz+HrLoeZ6TWIsRH7KyFU6Fs6ZX0A6oXmYZ5rsJZ2N8x+8h5oqbLW/GcF/eorNlbxR
 +5Cw==
X-Gm-Message-State: AOJu0Yy19uirgv0wLdKEhsyG34MceaatDNysU5fBUEvNEwp2eYoiUO9O
 0jLL1qi1Tqy7IvrlvXNGOOJhQ43VLbV4n0sVcYUhqKjagJWB9yHt8Wb9qswFjsWnzoH3wMOAeGQ
 G
X-Google-Smtp-Source: AGHT+IG3YxJfLjCHbKg5/1vujJkbfQ9aeAmCAeauWlz6fvOGadlc+Qwdve8vlJFO42irzafhzJuPZw==
X-Received: by 2002:a05:6a00:1ac7:b0:6e4:d198:6d66 with SMTP id
 f7-20020a056a001ac700b006e4d1986d66mr13089692pfv.7.1709059734358; 
 Tue, 27 Feb 2024 10:48:54 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 13/14] linux-user/elfload: Rely on walk_memory_regions for vmas
Date: Tue, 27 Feb 2024 08:48:32 -1000
Message-Id: <20240227184833.193836-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Rather than creating new data structures for vma,
rely on the IntervalTree used by walk_memory_regions.

Use PAGE_* constants, per the page table api, rather
than PROT_* constants, per the mmap api.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 213 ++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 135 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 47b5ce3005..ae0abc4931 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4041,29 +4041,6 @@ struct target_elf_prpsinfo {
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-struct vm_area_struct {
-    target_ulong   vma_start;  /* start vaddr of memory region */
-    target_ulong   vma_end;    /* end vaddr of memory region */
-    abi_ulong      vma_flags;  /* protection etc. flags for the region */
-    QTAILQ_ENTRY(vm_area_struct) vma_link;
-};
-
-struct mm_struct {
-    QTAILQ_HEAD(, vm_area_struct) mm_mmap;
-    int mm_count;           /* number of mappings */
-};
-
-static void vma_init(struct mm_struct *);
-static void vma_delete(struct mm_struct *);
-static int vma_add_mapping(struct mm_struct *, target_ulong,
-                           target_ulong, abi_ulong);
-static int vma_get_mapping_count(const struct mm_struct *);
-static struct vm_area_struct *vma_first(const struct mm_struct *);
-static struct vm_area_struct *vma_next(struct vm_area_struct *);
-static abi_ulong vma_dump_size(const struct vm_area_struct *);
-static int vma_walker(void *priv, target_ulong start, target_ulong end,
-                      unsigned long flags);
-
 #ifdef BSWAP_NEEDED
 static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 {
@@ -4105,69 +4082,14 @@ static inline void bswap_psinfo(struct target_elf_prpsinfo *p) {}
 static inline void bswap_note(struct elf_note *en) { }
 #endif /* BSWAP_NEEDED */
 
-/*
- * Minimal support for linux memory regions.  These are needed
- * when we are finding out what memory exactly belongs to
- * emulated process.  No locks needed here, as long as
- * thread that received the signal is stopped.
- */
-
-static void vma_init(struct mm_struct *mm)
-{
-    mm->mm_count = 0;
-    QTAILQ_INIT(&mm->mm_mmap);
-}
-
-static void vma_delete(struct mm_struct *mm)
-{
-    struct vm_area_struct *vma;
-
-    while ((vma = vma_first(mm)) != NULL) {
-        QTAILQ_REMOVE(&mm->mm_mmap, vma, vma_link);
-        g_free(vma);
-    }
-}
-
-static int vma_add_mapping(struct mm_struct *mm, target_ulong start,
-                           target_ulong end, abi_ulong flags)
-{
-    struct vm_area_struct *vma;
-
-    if ((vma = g_malloc0(sizeof (*vma))) == NULL)
-        return (-1);
-
-    vma->vma_start = start;
-    vma->vma_end = end;
-    vma->vma_flags = flags;
-
-    QTAILQ_INSERT_TAIL(&mm->mm_mmap, vma, vma_link);
-    mm->mm_count++;
-
-    return (0);
-}
-
-static struct vm_area_struct *vma_first(const struct mm_struct *mm)
-{
-    return (QTAILQ_FIRST(&mm->mm_mmap));
-}
-
-static struct vm_area_struct *vma_next(struct vm_area_struct *vma)
-{
-    return (QTAILQ_NEXT(vma, vma_link));
-}
-
-static int vma_get_mapping_count(const struct mm_struct *mm)
-{
-    return (mm->mm_count);
-}
-
 /*
  * Calculate file (dump) size of given memory region.
  */
-static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
+static size_t vma_dump_size(target_ulong start, target_ulong end,
+                            unsigned long flags)
 {
     /* The area must be readable. */
-    if (!(vma->vma_flags & PROT_READ)) {
+    if (!(flags & PAGE_READ)) {
         return 0;
     }
 
@@ -4176,22 +4098,13 @@ static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
      * non-writable code that debugger can read directly from
      * target library etc. If there is no elf header, we dump it.
      */
-    if (!(vma->vma_flags & PROT_WRITE) &&
-        (vma->vma_flags & PROT_EXEC) &&
-        memcmp(g2h_untagged(vma->vma_start), ELFMAG, SELFMAG) == 0) {
+    if (!(flags & PAGE_WRITE_ORG) &&
+        (flags & PAGE_EXEC) &&
+        memcmp(g2h_untagged(start), ELFMAG, SELFMAG) == 0) {
         return 0;
     }
 
-    return vma->vma_end - vma->vma_start;
-}
-
-static int vma_walker(void *priv, target_ulong start, target_ulong end,
-                      unsigned long flags)
-{
-    struct mm_struct *mm = (struct mm_struct *)priv;
-
-    vma_add_mapping(mm, start, end, flags);
-    return (0);
+    return end - start;
 }
 
 static size_t size_note(const char *name, size_t datasz)
@@ -4367,6 +4280,61 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
+typedef struct {
+    unsigned count;
+    size_t size;
+} CountAndSizeRegions;
+
+static int wmr_count_and_size_regions(void *opaque, target_ulong start,
+                                      target_ulong end, unsigned long flags)
+{
+    CountAndSizeRegions *css = opaque;
+
+    css->count++;
+    css->size += vma_dump_size(start, end, flags);
+    return 0;
+}
+
+typedef struct {
+    struct elf_phdr *phdr;
+    off_t offset;
+} FillRegionPhdr;
+
+static int wmr_fill_region_phdr(void *opaque, target_ulong start,
+                                target_ulong end, unsigned long flags)
+{
+    FillRegionPhdr *d = opaque;
+    struct elf_phdr *phdr = d->phdr;
+
+    phdr->p_type = PT_LOAD;
+    phdr->p_vaddr = start;
+    phdr->p_paddr = 0;
+    phdr->p_filesz = vma_dump_size(start, end, flags);
+    phdr->p_offset = d->offset;
+    d->offset += phdr->p_filesz;
+    phdr->p_memsz = end - start;
+    phdr->p_flags = (flags & PAGE_READ ? PF_R : 0)
+                  | (flags & PAGE_WRITE_ORG ? PF_W : 0)
+                  | (flags & PAGE_EXEC ? PF_X : 0);
+    phdr->p_align = ELF_EXEC_PAGESIZE;
+
+    bswap_phdr(phdr, 1);
+    d->phdr = phdr + 1;
+    return 0;
+}
+
+static int wmr_write_region(void *opaque, target_ulong start,
+                            target_ulong end, unsigned long flags)
+{
+    int fd = *(int *)opaque;
+    size_t size = vma_dump_size(start, end, flags);
+
+    if (!size) {
+        return 0;
+    }
+    return dump_write(fd, g2h_untagged(start), size);
+}
+
 /*
  * Write out ELF coredump.
  *
@@ -4414,12 +4382,11 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 {
     const CPUState *cpu = env_cpu((CPUArchState *)env);
     const TaskState *ts = (const TaskState *)cpu->opaque;
-    struct vm_area_struct *vma;
     struct rlimit dumpsize;
-    struct mm_struct mm;
+    CountAndSizeRegions css;
     off_t offset, note_offset, data_offset;
     size_t note_size;
-    int segs, cpus, ret;
+    int cpus, ret;
     int fd = -1;
     CPUState *cpu_iter;
 
@@ -4438,9 +4405,8 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      * Walk through target process memory mappings and
      * set up structure containing this information.
      */
-    vma_init(&mm);
-    walk_memory_regions(&mm, vma_walker);
-    segs = vma_get_mapping_count(&mm);
+    memset(&css, 0, sizeof(css));
+    walk_memory_regions(&css, wmr_count_and_size_regions);
 
     cpus = 0;
     CPU_FOREACH(cpu_iter) {
@@ -4448,22 +4414,18 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     }
 
     offset = sizeof(struct elfhdr);
-    offset += (segs + 1) * sizeof(struct elf_phdr);
+    offset += (css.count + 1) * sizeof(struct elf_phdr);
     note_offset = offset;
 
     offset += size_note("CORE", ts->info->auxv_len);
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
     note_size = offset - note_offset;
-    offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
-    data_offset = offset;
-
-    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
-        offset += vma_dump_size(vma);
-    }
+    data_offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
 
     /* Do not dump if the corefile size exceeds the limit. */
-    if (dumpsize.rlim_cur != RLIM_INFINITY && dumpsize.rlim_cur < offset) {
+    if (dumpsize.rlim_cur != RLIM_INFINITY
+        && dumpsize.rlim_cur < data_offset + css.size) {
         errno = 0;
         goto out;
     }
@@ -4485,36 +4447,22 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      */
     {
         g_autofree void *header = g_malloc0(data_offset);
+        FillRegionPhdr frp;
         void *hptr, *dptr;
 
         /* Create elf file header. */
         hptr = header;
-        fill_elf_header(hptr, segs + 1, ELF_MACHINE, 0);
+        fill_elf_header(hptr, css.count + 1, ELF_MACHINE, 0);
         hptr += sizeof(struct elfhdr);
 
         /* Create elf program headers. */
         fill_elf_note_phdr(hptr, note_size, note_offset);
         hptr += sizeof(struct elf_phdr);
 
-        offset = data_offset;
-        for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
-            struct elf_phdr *phdr = hptr;
-
-            phdr->p_type = PT_LOAD;
-            phdr->p_offset = offset;
-            phdr->p_vaddr = vma->vma_start;
-            phdr->p_paddr = 0;
-            phdr->p_filesz = vma_dump_size(vma);
-            offset += phdr->p_filesz;
-            phdr->p_memsz = vma->vma_end - vma->vma_start;
-            phdr->p_flags = (vma->vma_flags & PROT_READ ? PF_R : 0)
-                          | (vma->vma_flags & PROT_WRITE ? PF_W : 0)
-                          | (vma->vma_flags & PROT_EXEC ? PF_X : 0);
-            phdr->p_align = ELF_EXEC_PAGESIZE;
-
-            bswap_phdr(phdr, 1);
-            hptr += sizeof(struct elf_phdr);
-        }
+        frp.phdr = hptr;
+        frp.offset = data_offset;
+        walk_memory_regions(&frp, wmr_fill_region_phdr);
+        hptr = frp.phdr;
 
         /* Create the notes. */
         dptr = fill_note(&hptr, NT_AUXV, "CORE", ts->info->auxv_len);
@@ -4539,12 +4487,8 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     /*
      * Finally write process memory into the corefile as well.
      */
-    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
-        size_t size = vma_dump_size(vma);
-
-        if (size && dump_write(fd, g2h_untagged(vma->vma_start), size) < 0) {
-            goto out;
-        }
+    if (walk_memory_regions(&fd, wmr_write_region) < 0) {
+        goto out;
     }
     errno = 0;
 
@@ -4552,7 +4496,6 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     ret = -errno;
     mmap_unlock();
     cpu_list_unlock();
-    vma_delete(&mm);
     close(fd);
     return ret;
 }
-- 
2.34.1


