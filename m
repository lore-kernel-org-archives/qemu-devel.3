Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDEAC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2Vc-0006Zl-2J; Tue, 27 Feb 2024 13:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Va-0006ZP-1W
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:54 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VX-0001VN-GQ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:53 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c19bc08f96so2645611b6e.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059730; x=1709664530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPZgpp/cCi7t1E47Pxo1jS8aeNgwNI8GgVuo9d5SLyc=;
 b=D1czXhJ6QU+VZohBRAcyBBcPjE1DJEf8IiKz+Ng2jlX2W2ixIU3JhM2sIlUk5i4qLQ
 QmrDib3d5eE2lf/jRJoE6y/uKvtode5pZRsBbJgm6bXqCu3L6gRvNcOaK8wDf7i/yB2/
 zfevhoFt6iQgj43+QFRrWUaZLeI/JIla8y59w2FImSyIysMWanM3Sk3O+SpJn8ujOyK9
 fL8YleYkFhPOXqrvhiOXe8SUq2PSXePAPjlbVWNGHUw2CFPK7c1O0cVBTjpW5zIhLei5
 mWZNFP1ItJrmZuUw89zEtp9hyZaoIw/Kv0n1UT/hdrd7qKU8T1Fpgc9BTSqLFerLRpcn
 dMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059730; x=1709664530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPZgpp/cCi7t1E47Pxo1jS8aeNgwNI8GgVuo9d5SLyc=;
 b=NEhNg4yZU6S+d84zjNJdcxXToP4Jd/thF0cfLAo/7+IgYGiMJJc+xGNTs3fHnm4Lun
 DhX+ewprJTPESHtKOC03yC013Z+ZY/zLg3rpjQNCWNl13BaZ36/TmLiiW0Z6txG1Xini
 xCjiMVNusURhMy4i54uCfAWRcy6avlhYRNnJzCLOoukfVQTeA0OjgGIJoCPPQ6jrwmcL
 1KhbN1ADSMOHoxzdeHwl+cXpBdpPxe8Xzs0+xt8zCgWeaseSBYazOuoDlJRRKnWl8SRE
 mgM1D2OYVXWD9Fjz2NIBQJ5lZcFyMU7C/LfF05jdXA5b3gOykoIhDY1zvJ+6V8bW/2TI
 BECg==
X-Gm-Message-State: AOJu0YwV+YCdTexgsc9Q7EzfEfK2PsCTjWNS5Znde4N+jse1XyuTTUvm
 jOqSrYM6oZmbfXtbthqjGl88dkhWU2J9HAYT0KjQnL2ODqpsRM8tA5V9qHHSHCcENOG4v+KaSEr
 w
X-Google-Smtp-Source: AGHT+IFZJ5s1qna3W00Ikj4U3dZqN1eIIEqd1xMGOKz3hqlWzcwfzAWLqMhdV9dBKEhgfM64aGxIdw==
X-Received: by 2002:a05:6808:1143:b0:3c1:9a60:9248 with SMTP id
 u3-20020a056808114300b003c19a609248mr3180500oiu.14.1709059730367; 
 Tue, 27 Feb 2024 10:48:50 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 10/14] linux-user/elfload: Write corefile elf header in one
 block
Date: Tue, 27 Feb 2024 08:48:29 -1000
Message-Id: <20240227184833.193836-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Fixes a bug in which write_note() wrote namesz_rounded
and datasz_rounded bytes, even though name and data
pointers contain only the unrounded number of bytes.

Instead of many small writes, allocate a block to contain all
of the elf headers and all of the notes.  Copy the data into the
block piecemeal and the write it to the file as a chunk.
This also avoids the need to lseek forward for alignment.
---
 linux-user/elfload.c | 410 ++++++++++++-------------------------------
 1 file changed, 113 insertions(+), 297 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bad01bd2ef..b8d07d8054 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4002,18 +4002,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * Example for ARM target is provided in this file.
  */
 
-/* An ELF note in memory */
-struct memelfnote {
-    const char *name;
-    size_t     namesz;
-    size_t     namesz_rounded;
-    int        type;
-    size_t     datasz;
-    size_t     datasz_rounded;
-    void       *data;
-    size_t     notesz;
-};
-
 struct target_elf_siginfo {
     abi_int    si_signo; /* signal number */
     abi_int    si_code;  /* extra code */
@@ -4053,40 +4041,6 @@ struct target_elf_prpsinfo {
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-/* Here is the structure in which status of each thread is captured. */
-struct elf_thread_status {
-    QTAILQ_ENTRY(elf_thread_status)  ets_link;
-    struct target_elf_prstatus prstatus;   /* NT_PRSTATUS */
-#if 0
-    elf_fpregset_t fpu;             /* NT_PRFPREG */
-    struct task_struct *thread;
-    elf_fpxregset_t xfpu;           /* ELF_CORE_XFPREG_TYPE */
-#endif
-    struct memelfnote notes[1];
-    int num_notes;
-};
-
-#define NUMNOTES 3
-
-struct elf_note_info {
-    struct memelfnote notes[NUMNOTES];
-    struct target_elf_prstatus prstatus;  /* NT_PRSTATUS */
-    struct target_elf_prpsinfo psinfo;    /* NT_PRPSINFO */
-
-    QTAILQ_HEAD(, elf_thread_status) thread_list;
-#if 0
-    /*
-     * Current version of ELF coredump doesn't support
-     * dumping fp regs etc.
-     */
-    elf_fpregset_t *fpu;
-    elf_fpxregset_t *xfpu;
-    int thread_status_size;
-#endif
-    int notes_size;
-    int numnote;
-};
-
 struct vm_area_struct {
     target_ulong   vma_start;  /* start vaddr of memory region */
     target_ulong   vma_end;    /* end vaddr of memory region */
@@ -4110,22 +4064,6 @@ static abi_ulong vma_dump_size(const struct vm_area_struct *);
 static int vma_walker(void *priv, target_ulong start, target_ulong end,
                       unsigned long flags);
 
-static void fill_elf_header(struct elfhdr *, int, uint16_t, uint32_t);
-static void fill_note(struct memelfnote *, const char *, int,
-                      unsigned int, void *);
-static void fill_prstatus(struct target_elf_prstatus *, const TaskState *, int);
-static int fill_psinfo(struct target_elf_prpsinfo *, const TaskState *);
-static void fill_auxv_note(struct memelfnote *, const TaskState *);
-static void fill_elf_note_phdr(struct elf_phdr *, int, off_t);
-static size_t note_size(const struct memelfnote *);
-static void free_note_info(struct elf_note_info *);
-static void fill_note_info(struct elf_note_info *, int, const CPUArchState *);
-static void fill_thread_info(struct elf_note_info *, const CPUArchState *);
-
-static int dump_write(int, const void *, size_t);
-static int write_note(struct memelfnote *, int);
-static int write_note_info(struct elf_note_info *, int);
-
 #ifdef BSWAP_NEEDED
 static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 {
@@ -4280,35 +4218,32 @@ static size_t size_note(const char *name, size_t datasz)
     return sizeof(struct elf_note) + namesz + datasz;
 }
 
-static void fill_note(struct memelfnote *note, const char *name, int type,
-                      unsigned int sz, void *data)
+static void *fill_note(void **pptr, int type, const char *name, size_t datasz)
 {
-    unsigned int namesz;
+    void *ptr = *pptr;
+    struct elf_note *n = ptr;
+    size_t namesz = strlen(name) + 1;
 
-    namesz = strlen(name) + 1;
-    note->name = name;
-    note->namesz = namesz;
-    note->namesz_rounded = roundup(namesz, sizeof (int32_t));
-    note->type = type;
-    note->datasz = sz;
-    note->datasz_rounded = roundup(sz, sizeof (int32_t));
+    n->n_namesz = namesz;
+    n->n_descsz = datasz;
+    n->n_type = type;
+    bswap_note(n);
 
-    note->data = data;
+    ptr += sizeof(*n);
+    memcpy(ptr, name, namesz);
 
-    /*
-     * We calculate rounded up note size here as specified by
-     * ELF document.
-     */
-    note->notesz = sizeof (struct elf_note) +
-        note->namesz_rounded + note->datasz_rounded;
+    namesz = ROUND_UP(namesz, 4);
+    datasz = ROUND_UP(datasz, 4);
+
+    *pptr = ptr + namesz + datasz;
+    return ptr + namesz;
 }
 
 static void fill_elf_header(struct elfhdr *elf, int segs, uint16_t machine,
                             uint32_t flags)
 {
-    (void) memset(elf, 0, sizeof(*elf));
+    memcpy(elf->e_ident, ELFMAG, SELFMAG);
 
-    (void) memcpy(elf->e_ident, ELFMAG, SELFMAG);
     elf->e_ident[EI_CLASS] = ELF_CLASS;
     elf->e_ident[EI_DATA] = ELF_DATA;
     elf->e_ident[EI_VERSION] = EV_CURRENT;
@@ -4326,95 +4261,79 @@ static void fill_elf_header(struct elfhdr *elf, int segs, uint16_t machine,
     bswap_ehdr(elf);
 }
 
-static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t offset)
+static void fill_elf_note_phdr(struct elf_phdr *phdr, size_t sz, off_t offset)
 {
     phdr->p_type = PT_NOTE;
     phdr->p_offset = offset;
-    phdr->p_vaddr = 0;
-    phdr->p_paddr = 0;
     phdr->p_filesz = sz;
-    phdr->p_memsz = 0;
-    phdr->p_flags = 0;
-    phdr->p_align = 0;
 
     bswap_phdr(phdr, 1);
 }
 
-static size_t note_size(const struct memelfnote *note)
+static void fill_prstatus_note(void *data, const TaskState *ts,
+                               CPUState *cpu, int signr)
 {
-    return (note->notesz);
+    /*
+     * Because note memory is only aligned to 4, and target_elf_prstatus
+     * may well have higher alignment requirements, fill locally and
+     * memcpy to the destination afterward.
+     */
+    struct target_elf_prstatus prstatus = {
+        .pr_info.si_signo = signr,
+        .pr_cursig = signr,
+        .pr_pid = ts->ts_tid,
+        .pr_ppid = getppid(),
+        .pr_pgrp = getpgrp(),
+        .pr_sid = getsid(0),
+    };
+
+    elf_core_copy_regs(&prstatus.pr_reg, cpu_env(cpu));
+    bswap_prstatus(&prstatus);
+    memcpy(data, &prstatus, sizeof(prstatus));
 }
 
-static void fill_prstatus(struct target_elf_prstatus *prstatus,
-                          const TaskState *ts, int signr)
-{
-    (void) memset(prstatus, 0, sizeof (*prstatus));
-    prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
-    prstatus->pr_pid = ts->ts_tid;
-    prstatus->pr_ppid = getppid();
-    prstatus->pr_pgrp = getpgrp();
-    prstatus->pr_sid = getsid(0);
-
-    bswap_prstatus(prstatus);
-}
-
-static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)
+static void fill_prpsinfo_note(void *data, const TaskState *ts)
 {
+    /*
+     * Because note memory is only aligned to 4, and target_elf_prpsinfo
+     * may well have higher alignment requirements, fill locally and
+     * memcpy to the destination afterward.
+     */
+    struct target_elf_prpsinfo psinfo;
     char *base_filename;
-    unsigned int i, len;
-
-    (void) memset(psinfo, 0, sizeof (*psinfo));
+    size_t len;
 
     len = ts->info->env_strings - ts->info->arg_strings;
-    if (len >= ELF_PRARGSZ)
-        len = ELF_PRARGSZ - 1;
-    if (copy_from_user(&psinfo->pr_psargs, ts->info->arg_strings, len)) {
-        return -EFAULT;
+    len = MIN(len, ELF_PRARGSZ);
+    memcpy(&psinfo.pr_psargs, g2h_untagged(ts->info->arg_strings), len);
+    for (size_t i = 0; i < len; i++) {
+        if (psinfo.pr_psargs[i] == 0) {
+            psinfo.pr_psargs[i] = ' ';
+        }
     }
-    for (i = 0; i < len; i++)
-        if (psinfo->pr_psargs[i] == 0)
-            psinfo->pr_psargs[i] = ' ';
-    psinfo->pr_psargs[len] = 0;
 
-    psinfo->pr_pid = getpid();
-    psinfo->pr_ppid = getppid();
-    psinfo->pr_pgrp = getpgrp();
-    psinfo->pr_sid = getsid(0);
-    psinfo->pr_uid = getuid();
-    psinfo->pr_gid = getgid();
+    psinfo.pr_pid = getpid();
+    psinfo.pr_ppid = getppid();
+    psinfo.pr_pgrp = getpgrp();
+    psinfo.pr_sid = getsid(0);
+    psinfo.pr_uid = getuid();
+    psinfo.pr_gid = getgid();
 
     base_filename = g_path_get_basename(ts->bprm->filename);
     /*
      * Using strncpy here is fine: at max-length,
      * this field is not NUL-terminated.
      */
-    (void) strncpy(psinfo->pr_fname, base_filename,
-                   sizeof(psinfo->pr_fname));
-
+    strncpy(psinfo.pr_fname, base_filename, sizeof(psinfo.pr_fname));
     g_free(base_filename);
-    bswap_psinfo(psinfo);
-    return (0);
+
+    bswap_psinfo(&psinfo);
+    memcpy(data, &psinfo, sizeof(psinfo));
 }
 
-static void fill_auxv_note(struct memelfnote *note, const TaskState *ts)
+static void fill_auxv_note(void *data, const TaskState *ts)
 {
-    elf_addr_t auxv = (elf_addr_t)ts->info->saved_auxv;
-    elf_addr_t orig_auxv = auxv;
-    void *ptr;
-    int len = ts->info->auxv_len;
-
-    /*
-     * Auxiliary vector is stored in target process stack.  It contains
-     * {type, value} pairs that we need to dump into note.  This is not
-     * strictly necessary but we do it here for sake of completeness.
-     */
-
-    /* read in whole auxv vector and copy it to memelfnote */
-    ptr = lock_user(VERIFY_READ, orig_auxv, len, 0);
-    if (ptr != NULL) {
-        fill_note(note, "CORE", NT_AUXV, len, ptr);
-        unlock_user(ptr, auxv, len);
-    }
+    memcpy(data, g2h_untagged(ts->info->saved_auxv), ts->info->auxv_len);
 }
 
 /*
@@ -4462,111 +4381,6 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
-static int write_note(struct memelfnote *men, int fd)
-{
-    struct elf_note en;
-
-    en.n_namesz = men->namesz;
-    en.n_type = men->type;
-    en.n_descsz = men->datasz;
-
-    bswap_note(&en);
-
-    if (dump_write(fd, &en, sizeof(en)) != 0)
-        return (-1);
-    if (dump_write(fd, men->name, men->namesz_rounded) != 0)
-        return (-1);
-    if (dump_write(fd, men->data, men->datasz_rounded) != 0)
-        return (-1);
-
-    return (0);
-}
-
-static void fill_thread_info(struct elf_note_info *info, const CPUArchState *env)
-{
-    CPUState *cpu = env_cpu((CPUArchState *)env);
-    TaskState *ts = (TaskState *)cpu->opaque;
-    struct elf_thread_status *ets;
-
-    ets = g_malloc0(sizeof (*ets));
-    ets->num_notes = 1; /* only prstatus is dumped */
-    fill_prstatus(&ets->prstatus, ts, 0);
-    elf_core_copy_regs(&ets->prstatus.pr_reg, env);
-    fill_note(&ets->notes[0], "CORE", NT_PRSTATUS, sizeof (ets->prstatus),
-              &ets->prstatus);
-
-    QTAILQ_INSERT_TAIL(&info->thread_list, ets, ets_link);
-
-    info->notes_size += note_size(&ets->notes[0]);
-}
-
-static void fill_note_info(struct elf_note_info *info,
-                           int signr, const CPUArchState *env)
-{
-    CPUState *cpu = env_cpu((CPUArchState *)env);
-    TaskState *ts = (TaskState *)cpu->opaque;
-
-    memset(info, 0, sizeof (*info));
-    QTAILQ_INIT(&info->thread_list);
-
-    /*
-     * First fill in status (and registers) of current thread
-     * including process info & aux vector.
-     */
-    fill_prstatus(&info->prstatus, ts, signr);
-    elf_core_copy_regs(&info->prstatus.pr_reg, env);
-    fill_note(&info->notes[0], "CORE", NT_PRSTATUS,
-              sizeof(info->prstatus), &info->prstatus);
-    fill_psinfo(&info->psinfo, ts);
-    fill_note(&info->notes[1], "CORE", NT_PRPSINFO,
-              sizeof(info->psinfo), &info->psinfo);
-    fill_auxv_note(&info->notes[2], ts);
-    info->numnote = 3;
-
-    info->notes_size = 0;
-    for (int i = 0; i < info->numnote; i++) {
-        info->notes_size += note_size(&info->notes[i]);
-    }
-
-    /* read and fill status of all threads */
-    CPU_FOREACH(cpu) {
-        if (cpu == thread_cpu) {
-            continue;
-        }
-        fill_thread_info(info, cpu_env(cpu));
-    }
-}
-
-static void free_note_info(struct elf_note_info *info)
-{
-    struct elf_thread_status *ets;
-
-    while (!QTAILQ_EMPTY(&info->thread_list)) {
-        ets = QTAILQ_FIRST(&info->thread_list);
-        QTAILQ_REMOVE(&info->thread_list, ets, ets_link);
-        g_free(ets);
-    }
-}
-
-static int write_note_info(struct elf_note_info *info, int fd)
-{
-    struct elf_thread_status *ets;
-    int i, error = 0;
-
-    /* write prstatus, psinfo and auxv for current thread */
-    for (i = 0; i < info->numnote; i++)
-        if ((error = write_note(&info->notes[i], fd)) != 0)
-            return (error);
-
-    /* write prstatus for each thread */
-    QTAILQ_FOREACH(ets, &info->thread_list, ets_link) {
-        if ((error = write_note(&ets->notes[0], fd)) != 0)
-            return (error);
-    }
-
-    return (0);
-}
-
 /*
  * Write out ELF coredump.
  *
@@ -4615,14 +4429,13 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     const CPUState *cpu = env_cpu((CPUArchState *)env);
     const TaskState *ts = (const TaskState *)cpu->opaque;
     struct vm_area_struct *vma;
-    struct elf_note_info info;
-    struct elfhdr elf;
-    struct elf_phdr phdr;
     struct rlimit dumpsize;
     struct mm_struct mm;
     off_t offset, note_offset, data_offset;
+    size_t note_size;
     int segs, cpus, ret;
     int fd = -1;
+    CPUState *cpu_iter;
 
     if (prctl(PR_GET_DUMPABLE) == 0) {
         return 0;
@@ -4644,7 +4457,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     segs = vma_get_mapping_count(&mm);
 
     cpus = 0;
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH(cpu_iter) {
         cpus++;
     }
 
@@ -4655,6 +4468,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     offset += size_note("CORE", ts->info->auxv_len);
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
+    note_size = offset - note_offset;
     offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
     data_offset = offset;
 
@@ -4678,61 +4492,64 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     }
 
     /*
-     * Construct valid coredump ELF header.  We also
-     * add one more segment for notes.
+     * There is a fair amount of alignment padding within the notes
+     * as well as preceeding the process memory.  Allocate a zeroed
+     * block to hold it all.  Write all of the headers directly into
+     * this buffer and then write it out as a block.
      */
-    fill_elf_header(&elf, segs + 1, ELF_MACHINE, 0);
-    if (dump_write(fd, &elf, sizeof (elf)) != 0)
-        goto out;
+    {
+        g_autofree void *header = g_malloc0(data_offset);
+        void *hptr, *dptr;
 
-    /* fill in the in-memory version of notes */
-    fill_note_info(&info, signr, env);
+        /* Create elf file header. */
+        hptr = header;
+        fill_elf_header(hptr, segs + 1, ELF_MACHINE, 0);
+        hptr += sizeof(struct elfhdr);
 
-    /* write out notes program header */
-    fill_elf_note_phdr(&phdr, info.notes_size, note_offset);
+        /* Create elf program headers. */
+        fill_elf_note_phdr(hptr, note_size, note_offset);
+        hptr += sizeof(struct elf_phdr);
 
-    if (dump_write(fd, &phdr, sizeof (phdr)) != 0)
-        goto out;
+        offset = data_offset;
+        for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
+            struct elf_phdr *phdr = hptr;
 
-    /*
-     * Write program headers for memory regions mapped in
-     * the target process.
-     */
-    offset = data_offset;
-    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
-        (void) memset(&phdr, 0, sizeof (phdr));
+            phdr->p_type = PT_LOAD;
+            phdr->p_offset = offset;
+            phdr->p_vaddr = vma->vma_start;
+            phdr->p_paddr = 0;
+            phdr->p_filesz = vma_dump_size(vma);
+            offset += phdr->p_filesz;
+            phdr->p_memsz = vma->vma_end - vma->vma_start;
+            phdr->p_flags = (vma->vma_flags & PROT_READ ? PF_R : 0)
+                          | (vma->vma_flags & PROT_WRITE ? PF_W : 0)
+                          | (vma->vma_flags & PROT_EXEC ? PF_X : 0);
+            phdr->p_align = ELF_EXEC_PAGESIZE;
 
-        phdr.p_type = PT_LOAD;
-        phdr.p_offset = offset;
-        phdr.p_vaddr = vma->vma_start;
-        phdr.p_paddr = 0;
-        phdr.p_filesz = vma_dump_size(vma);
-        offset += phdr.p_filesz;
-        phdr.p_memsz = vma->vma_end - vma->vma_start;
-        phdr.p_flags = vma->vma_flags & PROT_READ ? PF_R : 0;
-        if (vma->vma_flags & PROT_WRITE)
-            phdr.p_flags |= PF_W;
-        if (vma->vma_flags & PROT_EXEC)
-            phdr.p_flags |= PF_X;
-        phdr.p_align = ELF_EXEC_PAGESIZE;
+            bswap_phdr(phdr, 1);
+            hptr += sizeof(struct elf_phdr);
+        }
 
-        bswap_phdr(&phdr, 1);
-        if (dump_write(fd, &phdr, sizeof(phdr)) != 0) {
+        /* Create the notes. */
+        dptr = fill_note(&hptr, NT_AUXV, "CORE", ts->info->auxv_len);
+        fill_auxv_note(dptr, ts);
+
+        dptr = fill_note(&hptr, NT_PRPSINFO, "CORE",
+                         sizeof(struct target_elf_prpsinfo));
+        fill_prpsinfo_note(dptr, ts);
+
+        CPU_FOREACH(cpu_iter) {
+            dptr = fill_note(&hptr, NT_PRSTATUS, "CORE",
+                             sizeof(struct target_elf_prstatus));
+            fill_prstatus_note(dptr, ts, cpu_iter,
+                               cpu_iter == cpu ? signr : 0);
+        }
+
+        if (dump_write(fd, header, data_offset) < 0) {
             goto out;
         }
     }
 
-    /*
-     * Next we write notes just after program headers.  No
-     * alignment needed here.
-     */
-    if (write_note_info(&info, fd) < 0)
-        goto out;
-
-    /* align data to page boundary */
-    if (lseek(fd, data_offset, SEEK_SET) != data_offset)
-        goto out;
-
     /*
      * Finally we can dump process memory into corefile as well.
      */
@@ -4768,7 +4585,6 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     ret = -errno;
     mmap_unlock();
     cpu_list_unlock();
-    free_note_info(&info);
     vma_delete(&mm);
     close(fd);
     return ret;
-- 
2.34.1


