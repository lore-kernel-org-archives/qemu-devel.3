Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7828C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ic-0004U9-C6; Thu, 25 Jul 2024 19:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ia-0004Cz-0z; Thu, 25 Jul 2024 19:55:04 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IY-0000aw-4b; Thu, 25 Jul 2024 19:55:03 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso313868a91.2; 
 Thu, 25 Jul 2024 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951700; x=1722556500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaTaKDTXNh3V2EaFkWYN7OVGHBwhKJU9StJXUF+pwj4=;
 b=kZ2tC/jxH4XmMfZR45cROqIgbfTaALJdLA25eqfiM9BuqTcYcCd7FzdOsV5dLPH39f
 ZN4QO6In8AXQ6yP/Byft/pAuwLa/UJ2Ad2Pc7iZrLsXtoMt2l8R684KrK9NsW4AAFUnY
 +ubA0O1JcYkE9XZzb9IgmqhcVDEGlnEl4RquBA8RfdHdYjsTnWVK5ZStKYyghugoltMV
 ftyWGux1swzOa9BfiiK5dF/nMjnpZyEyEn1QLYzzAyVZDfjxU6eeujzvKPFLBcBhd3EG
 54oHtQlTmEmMiGmP7BjLpd1QVPLX6dt7DwySP89uIwtuNYEzQPbmJr9aF51FiWnniAsq
 dAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951700; x=1722556500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaTaKDTXNh3V2EaFkWYN7OVGHBwhKJU9StJXUF+pwj4=;
 b=TBhwkr/QAtv8rF1JO8SyVySci82eMs/oqnH2USTI+1EYLt6LZeDv551YQMNIRdy422
 mZib6o1ZQv8ChKzW6N9LdYbytPKlITxrXFbAaicSSeDdr6fVK8z4QAqmJypoLSQCXzVg
 E3z6OEmx/a8I2jlvsYtc3DAr6Ll8MdMjNqcsL4o6TbU2q92yBJCoriAwItc/4ExNviFA
 m8904Gzghs0ejmPpogEqmPFdCKTw6WzD943523Se0+ZUIXaFfy9jCE6CGi4DJRkr8RCB
 ORNkjHTTR6puobBbXdHtYGlrI9r+W3+NYEKJnV722TNc5jvVcBk1tgLjhDOwH8xcMMQm
 pfAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZTTvFAx1Q4C3ArXz4xJ9fxw+B/QXO16sC+fKNbkXT5gL4FLBaUHsxub78Mp8+FqnfUaA6SC7x6Saekj8cFev5QBAM
X-Gm-Message-State: AOJu0YzQ2XKiCeYT1bLqEOOOLmv/ijPGUtRzOK0Cbyx90mvgPnjnqj3T
 V+xaDCRsIxYyTD1VEuK2tpNfOC0tIu6hNZvzvqunoUb/kiJo3hz+1Sxhjg==
X-Google-Smtp-Source: AGHT+IFWw0MfBFMtUZGkdksWwz/535MMiVdYvKsit/rOOyx1vQvZYnQysyODGVtbflZypaE/FJBEZg==
X-Received: by 2002:a17:90a:5d8a:b0:2c9:7fba:d895 with SMTP id
 98e67ed59e1d1-2cf2ec03a51mr3983846a91.38.1721951700040; 
 Thu, 25 Jul 2024 16:55:00 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 08/96] target/ppc/arch_dump: set prstatus pid to cpuid
Date: Fri, 26 Jul 2024 09:52:41 +1000
Message-ID: <20240725235410.451624-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Omar Sandoval <osandov@osandov.com>

Every other architecture does this, and debuggers need it to be able to
identify which prstatus note corresponds to which CPU.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/arch_dump.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index a8315659d9..f45474133a 100644
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
+                            offsetof(struct elf_prstatus, pr_reg) -
+                            sizeof(struct user_pt_regs) */
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


