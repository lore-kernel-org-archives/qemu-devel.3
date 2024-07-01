Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B26C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOKFv-0002Mp-5j; Mon, 01 Jul 2024 12:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sOKFt-0002MU-GG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:51:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sOKFr-0003QH-GO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:51:53 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f480624d0dso24874775ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1719852708; x=1720457508;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ss333L1lewI2JlN1RvnG00MSNSUd8UXjAr4poBt0YyU=;
 b=bx+49c8NyRdW2bkRFjEIIRtHXibKhsX1qcT9j+EZ8yyMLlKTeki24tlF51KDkcX963
 a8ssxDkY1jNzydkdOdO9RD2jPrmIANT8D2RjCvn8xzP0SRaQmwN/3seM+AIWGHl9exHc
 wTeJX1fzhk5qClN2C0mtiBJkmQNvioMFYTe0ZE+EvDwl1rKyej+BleCRppWX4IXpTeVV
 xFy7AzfqcS1rJKgD8sXFVM6gh6dvwhF8hFbznrI3cI4GP3k9NcIDQ7wTvY35i46TkEhL
 GcoBDLFPC/Ah0QRKZ62wwxrtbbcPC9P+8keluAl6rXkUbSUpaw4PZD+10e196Y/vcBHm
 8ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719852708; x=1720457508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ss333L1lewI2JlN1RvnG00MSNSUd8UXjAr4poBt0YyU=;
 b=c7IY8QtJLEmLaTf8CJfq3XWYjXdaajwP3pk7Qa481YHe+Uks0KWDWZJygsdIRVCAii
 TZiPFMGAFKLOjpOmjKiPzPX2HqczznPuZluCb8O9taqkBglY8ubIwgekkIRc3lRYJ27y
 /2Iyk0wkQxUuHUJ6OjOEi7YzamtMMiTkrIv7PDwOs/+9IYNm9yhRow2Fa+2v7iFXk7MR
 8lW+g648ap4hNBLyswP+2TsB4jBkYeOC2QZmPlNoStFamOADEQxoSciyFk8tsOYKV2M5
 T6zKYlwU0xSe9YAvfWUFXNFQI+LTzUY/hmNcvKs5dHkhGi/gF3EfFAnsBzn1yEew8O4w
 G9Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv/wa8ZXj8u8BO/AxiYT0nU5R5IHR3WXIZ38EPUHVrEjperp7UZdWa0I//2uwe716lIH+FPH4H8r+VY8tnEcDDoCl2Imw=
X-Gm-Message-State: AOJu0YyGDyfZsf8dtJE8UvgulE+YeFl8015HBr6p40y3nBBSiT6+puO+
 GccZcjcIViAdZrJ1HnhRtgNo90Fw2iwmLot+Ou1FL9O8G86iihRlIFtaaPfiH78=
X-Google-Smtp-Source: AGHT+IEeCeNbU0N+GSoKUyDqylycJz/Gk/0/VDRQsEoCG4v2G8kUxR2LmhmdU/5dI0rlQqP7cYVKhQ==
X-Received: by 2002:a17:902:f54c:b0:1f9:f99e:509c with SMTP id
 d9443c01a7336-1fadbc79b39mr62749045ad.23.1719852708208; 
 Mon, 01 Jul 2024 09:51:48 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::7:a5d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1569f0bsm66901025ad.216.2024.07.01.09.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:51:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] target/ppc/arch_dump: set prstatus pid to cpuid
Date: Mon,  1 Jul 2024 09:51:35 -0700
Message-ID: <3c3dd56b4e88b6863e971d72daae7c0324499712.1719852483.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=osandov@osandov.com; helo=mail-pl1-x62c.google.com
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

Every other architecture does this, and debuggers need it to be able to
identify which prstatus note corresponds to which CPU.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
This is v2 from my small series [1] making QEMU fill the pr_pid field of
the NT_PRSTATUS note consistently.

Changes from v1:

- Add comments explaning sizes of padding fields.

1: https://lore.kernel.org/qemu-devel/cover.1718771802.git.osandov@osandov.com/

 target/ppc/arch_dump.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index a8315659d9..ff93cac61e 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -47,9 +47,14 @@ struct PPCUserRegStruct {
 } QEMU_PACKED;
 
 struct PPCElfPrstatus {
-    char pad1[112];
+    char pad1[32]; /* 32 == offsetof(struct elf_prstatus, pr_pid) */
+    uint32_t pid;
+    char pad2[76]; /* 76 == offsetof(struct elf_prstatus, pr_reg) -
+                            offsetof(struct elf_prstatus, pr_ppid) */
     struct PPCUserRegStruct pr_reg;
-    char pad2[40];
+    char pad3[40]; /* 40 == sizeof(struct elf_prstatus) -
+		            offsetof(struct elf_prstatus, pr_reg) -
+			    sizeof(struct user_pt_regs) */
 } QEMU_PACKED;
 
 
@@ -96,7 +101,7 @@ typedef struct NoteFuncArg {
     DumpState *state;
 } NoteFuncArg;
 
-static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     reg_t cr;
@@ -109,6 +114,7 @@ static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
 
     prstatus = &note->contents.prstatus;
     memset(prstatus, 0, sizeof(*prstatus));
+    prstatus->pid = cpu_to_dump32(s, id);
     reg = &prstatus->pr_reg;
 
     for (i = 0; i < 32; i++) {
@@ -127,7 +133,7 @@ static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
     reg->ccr = cpu_to_dump_reg(s, cr);
 }
 
-static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     struct PPCElfFpregset  *fpregset;
@@ -146,7 +152,7 @@ static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
     fpregset->fpscr = cpu_to_dump_reg(s, cpu->env.fpscr);
 }
 
-static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     struct PPCElfVmxregset *vmxregset;
@@ -178,7 +184,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
     vmxregset->vscr.u32[3] = cpu_to_dump32(s, ppc_get_vscr(&cpu->env));
 }
 
-static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     struct PPCElfVsxregset *vsxregset;
@@ -195,7 +201,7 @@ static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
     }
 }
 
-static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     struct PPCElfSperegset *speregset;
     Note *note = &arg->note;
@@ -211,7 +217,7 @@ static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
 
 static const struct NoteFuncDescStruct {
     int contents_size;
-    void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu);
+    void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu, int id);
 } note_func[] = {
     {sizeof_field(Note, contents.prstatus),  ppc_write_elf_prstatus},
     {sizeof_field(Note, contents.fpregset),  ppc_write_elf_fpregset},
@@ -282,7 +288,7 @@ static int ppc_write_all_elf_notes(const char *note_name,
         arg.note.hdr.n_descsz = cpu_to_dump32(s, nf->contents_size);
         strncpy(arg.note.name, note_name, sizeof(arg.note.name));
 
-        (*nf->note_contents_func)(&arg, cpu);
+        (*nf->note_contents_func)(&arg, cpu, id);
 
         note_size =
             sizeof(arg.note) - sizeof(arg.note.contents) + nf->contents_size;
-- 
2.45.2


