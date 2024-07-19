Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2E6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUsVk-0007MU-Ey; Fri, 19 Jul 2024 14:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sUsVf-0007Jt-Iq
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:39:16 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sUsVd-0002iB-Ej
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:39:15 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d437791affso1206408eaf.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1721414351; x=1722019151;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6+IprsaKpefCknIaW7VK1tGAz8xILFc9C8VmC1QsepM=;
 b=Y5KMhRIZ8HSQnLSEwFTpJTeHfsfYXa+YrXxxqL/+hhw+TfdCLUPjJLH5L3O7nN9jC0
 JCcBk7F9pvHR7jVJhiDllJ3oXS2LQNA6w+K1Qpza8xIbk4UDd/JkV6ZEtfu3ei9pBSCA
 RUoTVnDosQ1+YoE4umOpUzktBsQnaM8s9r795SergxjJtKejRZE7OhJheaVKZvPxSIoM
 C5CCEqizpDODdwsRIPTkQWzSbqyirSE7WmvZc0Af9ZLbaltNMeD/g2S3xF30ffKm7EJd
 ssg2oiA+NiWco9NquMA67Xpir7Kuu4qWisuq+jXdLt7w8sXIoVLgUZ1MgrsJP9eGkUQO
 gIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721414351; x=1722019151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6+IprsaKpefCknIaW7VK1tGAz8xILFc9C8VmC1QsepM=;
 b=NKoYwvmy5JlICWS8tTb4IYBSodiMll9jVASBwiGF6gco0rt0/EjmmOVbATSc82IBx8
 SpaYy4Ig0Au6rTs/YQVkAXdq0t88wodQT1/EV1TaUzmNB57tAlMj+OhCOT8hLU3No45i
 cDS7A6nAKl7FDZRSdtTCWPU9qxZ29QFMZ8QyZnvkwYXttoU3VFdIo/QQoc20AACrWOtG
 WFGlDujNCSRmT/mLjEdSsB8rpeR2839vSLMjJ+l3+sOzTlp8aDt1bjhWgWpbMFYI3NfX
 4QcAGF2OYIutEQTipZbG7eg7Y1mOMde8Y3g39SoqpmWdIj7sb2hHsS0V3WxzwNjIQUJY
 0V+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW88DdbPIZr20sN/TqPJ/9eyXqrDcE6SgnyMW/qqoCv5Y05ZlkzW1Gl+H620l+FHrpYzw3iIzTGusB/HsVYZKxjsuZeKT8=
X-Gm-Message-State: AOJu0YycE4h+FZO8u+VlD1tfPZbprQG+ddXebNN7SNsMLn+dk/7nn+lK
 C0Tgh+jezqQTy0C/UNiBf+odNRF6js7gQHMPXv1pjv7aP/s93HsXwUAMnoCYhdg=
X-Google-Smtp-Source: AGHT+IGU5pwlvTfvI2AhrxWiUt3fXb7sM3kpFCNjn3ax/IzFAS6y5dOUXUl+RFgJ8CZaeY0YioXPqg==
X-Received: by 2002:a05:6870:fb92:b0:25e:bd3d:635e with SMTP id
 586e51a60fabf-26121399c6fmr597765fac.13.1721414351522; 
 Fri, 19 Jul 2024 11:39:11 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::7:5d79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff4b1db8sm1496612b3a.65.2024.07.19.11.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 11:39:11 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 RESEND] target/ppc/arch_dump: set prstatus pid to cpuid
Date: Fri, 19 Jul 2024 11:39:05 -0700
Message-ID: <f0f588e8a85ab88763337015a77e544dd756d2ac.1721414214.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=osandov@osandov.com; helo=mail-oo1-xc2f.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
Resend of [1]. No changes other than adding Thomas's Reviewed-by.

Thanks,
Omar

1: https://lore.kernel.org/qemu-devel/3c3dd56b4e88b6863e971d72daae7c0324499712.1719852483.git.osandov@osandov.com/

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


