Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0CAC27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 05:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJnR7-0008A0-AH; Wed, 19 Jun 2024 01:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sJnQz-00086x-7C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:00:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sJnQu-0002DW-Sj
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:00:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-705c739b878so428764b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 22:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718773231; x=1719378031;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnHosSMTlhyZy4/smUQmVXiKBF37sEAO5boId4LvkC4=;
 b=01grOxXvZ4QjyUPmU8rPBbU1luNUaQymAYHhPOmVzVI7IQR8zG/s9zynjrpugdurDO
 yX95c5NpkfMl5waQCx5UsuK1D5bDnm8bCAmVJF1cH0ApB8nyWVzePiQGpy7TGwcFNq6h
 RnalrwU3IvNMlsAqjIu4bNL3Znq5lUKj+APpvEWWvqPBNRm8bO9Y69AzGvOnt2nRD+QY
 NcilGRK9QBSIAPIHwoYoIJTn2i1a5VwRlTEiJzPTJV4U44usxi/scMtU0xXc6s4Z0y6N
 3h0e35aEZR8J60IC+5EtTQkLt6AF5r+tYt3XBM0+1hLPMrIvSfaUu0NZuBxp8ORne89K
 N98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718773231; x=1719378031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnHosSMTlhyZy4/smUQmVXiKBF37sEAO5boId4LvkC4=;
 b=uAA5zP0Q0TBIqogVThsw36VVBHWbCS95iKeN3t0Ur0LTol8gTbHHXnZL/yyFlrNeSb
 yuHggnXcI0rI5mnldPzpXyyXOP70IaOBgn7fkaTtlr+DAUwtrHMsI20Qixdoju9sPxCF
 +vxaGC/MrOjDqHRKgNdLtgnT7ty3udZVw6w3cXcHj0pt1un6aibfhKRhZVfmpc2ijVjr
 +UH3IbqR9JRoTPcJbGbJxdZocdHYqNrjnpH35vF0IBgSBURdU2Lr8hPWFbjcUVmrAU2O
 0g3feeu3bnsi9NneosKDVovmuwkmDsDo889YPUEnOj5w70SC6NP7k0/6BXWtchcDDuqE
 hxmQ==
X-Gm-Message-State: AOJu0YyGadQdnsELdYJBr3monBMnLrPqaCzhl44pYDhFhtFXvEGO7ib8
 8VhRyD1j5ccqH+Yg45O6TbGVKTLmTpwBDyfAdXrQd08AeXOlioRy75u2Ed9j4/lq0+OhST/3sHJ
 dpJQ=
X-Google-Smtp-Source: AGHT+IH+pD6pdddjXgKRvRm15zJ2fCm4wOHzm9P4Y5A1pJHZtGupGZ0FTYlkdIu+G+aSj8d3m5wyXQ==
X-Received: by 2002:a05:6a20:c31d:b0:1bc:bada:a9fd with SMTP id
 adf61e73a8af0-1bcbadab018mr1978857637.1.1718773230570; 
 Tue, 18 Jun 2024 22:00:30 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::2f17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fedcf36be7sm7457523a12.1.2024.06.18.22.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 22:00:29 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 linux-debuggers@vger.kernel.org
Subject: [PATCH 2/2] target/ppc/arch_dump: set prstatus pid to cpuid
Date: Tue, 18 Jun 2024 22:00:13 -0700
Message-ID: <ac09da04c8e6dd777945219815d1c53b02291b5b.1718771802.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718771802.git.osandov@osandov.com>
References: <cover.1718771802.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=osandov@osandov.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
 target/ppc/arch_dump.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index a8315659d9..78b4205319 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -47,9 +47,11 @@ struct PPCUserRegStruct {
 } QEMU_PACKED;
 
 struct PPCElfPrstatus {
-    char pad1[112];
+    char pad1[32];
+    uint32_t pid;
+    uint8_t pad2[76];
     struct PPCUserRegStruct pr_reg;
-    char pad2[40];
+    char pad3[40];
 } QEMU_PACKED;
 
 
@@ -96,7 +98,7 @@ typedef struct NoteFuncArg {
     DumpState *state;
 } NoteFuncArg;
 
-static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     reg_t cr;
@@ -109,6 +111,7 @@ static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
 
     prstatus = &note->contents.prstatus;
     memset(prstatus, 0, sizeof(*prstatus));
+    prstatus->pid = cpu_to_dump32(s, id);
     reg = &prstatus->pr_reg;
 
     for (i = 0; i < 32; i++) {
@@ -127,7 +130,7 @@ static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
     reg->ccr = cpu_to_dump_reg(s, cr);
 }
 
-static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     struct PPCElfFpregset  *fpregset;
@@ -146,7 +149,7 @@ static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
     fpregset->fpscr = cpu_to_dump_reg(s, cpu->env.fpscr);
 }
 
-static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     struct PPCElfVmxregset *vmxregset;
@@ -178,7 +181,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
     vmxregset->vscr.u32[3] = cpu_to_dump32(s, ppc_get_vscr(&cpu->env));
 }
 
-static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     int i;
     struct PPCElfVsxregset *vsxregset;
@@ -195,7 +198,7 @@ static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
     }
 }
 
-static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
+static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
 {
     struct PPCElfSperegset *speregset;
     Note *note = &arg->note;
@@ -211,7 +214,7 @@ static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
 
 static const struct NoteFuncDescStruct {
     int contents_size;
-    void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu);
+    void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu, int id);
 } note_func[] = {
     {sizeof_field(Note, contents.prstatus),  ppc_write_elf_prstatus},
     {sizeof_field(Note, contents.fpregset),  ppc_write_elf_fpregset},
@@ -282,7 +285,7 @@ static int ppc_write_all_elf_notes(const char *note_name,
         arg.note.hdr.n_descsz = cpu_to_dump32(s, nf->contents_size);
         strncpy(arg.note.name, note_name, sizeof(arg.note.name));
 
-        (*nf->note_contents_func)(&arg, cpu);
+        (*nf->note_contents_func)(&arg, cpu, id);
 
         note_size =
             sizeof(arg.note) - sizeof(arg.note.contents) + nf->contents_size;
-- 
2.45.2


