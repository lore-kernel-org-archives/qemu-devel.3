Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A5BC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJU-0003QP-9t; Sat, 02 Aug 2025 19:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJP-00037J-BE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:47 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJN-0001BR-9P
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:46 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-433f43f0012so260181b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176004; x=1754780804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wzCvIZrc8oCNQOp0LEKf8glJh+GHBNdljJm8N5U6qvw=;
 b=I4PVeEHoDGySDb/093LxvnsxJLHjqYhYvihk9kko+iFfbbIa3JnRIKg3VmKOFsJr95
 m7MYa0HvmrcXfPtjQplN43MQ65xUFtLDamPPrFE8fH/4pZAqKbr0envjtnCbK/Rw8FE/
 5AgG2mkSQ1r4+3/i/sOmswY6YSWgc/NDnac0MnB8rrXgoYWiT0GpthLrHWau8347RKVM
 sumG1p6jq8nmXIU97CELgKUh690nLvkg8zyZohyb70Cc4yCQzpP2/f6CZP6WuqPRzcWM
 WMNzjtVLwSptEeiHWa8o+LafzkZHgkyB2kNyZg5b7jiqfMUVHrsf+Z40gpJr+NQvts2z
 HR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176004; x=1754780804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzCvIZrc8oCNQOp0LEKf8glJh+GHBNdljJm8N5U6qvw=;
 b=CCB2KxH5qIuxzP5il81aAP76yJ+SyVyrn3TInb8CUgfcuijXetDxvn2XnENgH3DSOU
 tyEgKl8WLPQzXrDzgESzC8tc48+KcpzG3TdL711lZjqVnhRo/RLefEdPTN412IJmnNUa
 nHPitjL/fMkrMd7o1NnjE6S/uPQT/S2Ea8dq1bsDSvOpdOAdFesnx82O870GvO6c3MtP
 b+q1dpHIKlpQlhZLDEE89L3KCGQtNuXMUkzcgUyWMWBwKdPHn09UoqwQUlINgcLfFQVI
 otIGpe27yDcvKk5c/NcaYkZ8X5wciGVfpjYBHXPDxTmTZSWrr1WonmUwz3blIgfXnoym
 3Tlg==
X-Gm-Message-State: AOJu0YzYD9zENhqGpuNG/htunY8ZlbHQDoLvNAmZYA4n4tjXOEft37hf
 UuUf1TJIuF7dISA6GwvsDVl5olqjZheBbp76OprMPnSERVUqxFhCq7dI6FfqXJbEAb0O7nVM114
 wgZqkO0A=
X-Gm-Gg: ASbGncsJEQcZO6c0Z8NzclRwLxlMQlRabHBdqCxnjr9tZwN1CXJchtlSAuhf69fvZrz
 3Ec5OsObZGDAMUTVY7xCoT1mwQIqD93w7sSUwxyMUwn+SNvuJhplS8m9sSKPFM4gwYRuBoSvNwf
 pNWIMycuiDj52OxsVX9SUhuYzxEfZ1DEkYQ/LO7GCaTBYme25OiUCBcCqhQR8OYdra3eH78yDTG
 lTA4ZVCnGC9jb8CDJZO3g1BZYjaTYPNM+PbF5NvBcOZYQqbg9s+p7qz6paICYP99qNnC4He5oMc
 1mddSPp1pj4fx7hVi6iCdcGe4LKnqvH7QdZ/S0VUL23cPkfiBFg+7aAiVHL7TlutugHxEp3r60k
 dBQoMZbNxkf5dLfX3Yoo6jmd7I1VWFrUjgtRaVz7V1u2fyH8lNw8xj9X0F46QDuQ=
X-Google-Smtp-Source: AGHT+IE6bmudApkMwXRm9ryQIDblB1/xahcPM/XUEMeHRZMIOF5SSnXP8+KpEMM9etSB5c6OK9vH2w==
X-Received: by 2002:a05:6808:1782:b0:41c:9345:3ab9 with SMTP id
 5614622812f47-433f0238b05mr3180518b6e.15.1754176004086; 
 Sat, 02 Aug 2025 16:06:44 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/95] linux-user/i386: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:50 +1000
Message-ID: <20250802230459.412251-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.
Temporarily introduce HAVE_INIT_MAIN_THREAD during conversion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h          |  1 +
 linux-user/elfload.c       | 29 +++++------------------
 linux-user/i386/cpu_loop.c | 48 +++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 0c3cfe93a1..8a9500d4f4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -361,5 +361,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 typedef struct target_pt_regs target_pt_regs;
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+void init_main_thread(CPUState *cs, struct image_info *info);
 
 #endif /* QEMU_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6fce74f45a..89f3972253 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -149,17 +149,12 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
+#define HAVE_INIT_MAIN_THREAD
+
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
-{
-    regs->rax = 0;
-    regs->rsp = infop->start_stack;
-    regs->rip = infop->entry;
-}
-
 #define ELF_NREG    27
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -237,22 +232,6 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->esp = infop->start_stack;
-    regs->eip = infop->entry;
-
-    /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program
-       starts %edx contains a pointer to a function which might be
-       registered using `atexit'.  This provides a mean for the
-       dynamic linker to call DT_FINI functions for shared libraries
-       that have been loaded before the code runs.
-
-       A value of 0 tells we have no such handler.  */
-    regs->edx = 0;
-}
-
 #define ELF_NREG    17
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -3621,8 +3600,12 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
 void do_init_main_thread(CPUState *cs, struct image_info *infop)
 {
+#ifdef HAVE_INIT_MAIN_THREAD
+    init_main_thread(cs, infop);
+#else
     target_pt_regs regs = { };
 
     init_thread(&regs, infop);
     target_cpu_copy_regs(cpu_env(cs), &regs);
+#endif
 }
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index d96d5553fa..7b2d8b03d8 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -331,11 +331,10 @@ static void target_cpu_free(void *obj)
     g_free(obj);
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cpu, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
+    CPUArchState *env = cpu_env(cpu);
     bool is64 = (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) != 0;
-    int i;
 
     OBJECT(cpu)->free = target_cpu_free;
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
@@ -361,28 +360,25 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     /* flags setup : we activate the IRQs by default as in user mode */
     env->eflags |= IF_MASK;
 
-    /* linux register setup */
-#ifndef TARGET_ABI32
-    env->regs[R_EAX] = regs->rax;
-    env->regs[R_EBX] = regs->rbx;
-    env->regs[R_ECX] = regs->rcx;
-    env->regs[R_EDX] = regs->rdx;
-    env->regs[R_ESI] = regs->rsi;
-    env->regs[R_EDI] = regs->rdi;
-    env->regs[R_EBP] = regs->rbp;
-    env->regs[R_ESP] = regs->rsp;
-    env->eip = regs->rip;
-#else
-    env->regs[R_EAX] = regs->eax;
-    env->regs[R_EBX] = regs->ebx;
-    env->regs[R_ECX] = regs->ecx;
-    env->regs[R_EDX] = regs->edx;
-    env->regs[R_ESI] = regs->esi;
-    env->regs[R_EDI] = regs->edi;
-    env->regs[R_EBP] = regs->ebp;
-    env->regs[R_ESP] = regs->esp;
-    env->eip = regs->eip;
-#endif
+    /*
+     * Linux register setup.
+     *
+     * SVR4/i386 ABI (pages 3-31, 3-32) says that when the program
+     * starts %edx contains a pointer to a function which might be
+     * registered using `atexit'.  This provides a mean for the
+     * dynamic linker to call DT_FINI functions for shared libraries
+     * that have been loaded before the code runs.
+     * A value of 0 tells we have no such handler.
+     *
+     * This applies to x86_64 as well as i386.
+     *
+     * That said, the kernel's ELF_PLAT_INIT simply zeros all of the general
+     * registers.  Note that x86_cpu_reset_hold will set %edx to cpuid_version;
+     * clear all general registers defensively.
+     */
+    memset(env->regs, 0, sizeof(env->regs));
+    env->regs[R_ESP] = info->start_stack;
+    env->eip = info->entry;
 
     /* linux interrupt setup */
 #ifndef TARGET_ABI32
@@ -394,7 +390,7 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
                                 PROT_READ|PROT_WRITE,
                                 MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
     idt_table = g2h_untagged(env->idt.base);
-    for (i = 0; i < 20; i++) {
+    for (int i = 0; i < 20; i++) {
         set_idt(i, 0, is64);
     }
     set_idt(3, 3, is64);
-- 
2.43.0


