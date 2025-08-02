Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3127BC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJW-0003gM-Hb; Sat, 02 Aug 2025 19:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJS-0003KT-El
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:51 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJQ-0001Bg-0w
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:49 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-610cbca60cdso1073571eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176007; x=1754780807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nDJp7tSOiwR5n19lwWeP5HE0v4ZTZzAZzXnPUcAToWY=;
 b=eXHkLm9WYqOO3ooJ4imsaYYkrxIG4hxSJObI3gRqsHkscwHV+iUuJWx7hFlcRXJcRh
 AwU3T8dn5eBCLR+zAPigOEHse4pQmsijT1F/kmd1vfC/aT4531kXGByPkAZrNgbXXa6m
 8xTh5fNuIIzyuNg4QsKZGc3kq8kBlcY91gOQWubj4m2EksqqUxel4/fyqWje0POuOUAx
 kNXwaE8lE14Rx4GihnckFyVlDBt0KSqMnix2mx6wS/o3QQfcLE4HvJJyS17Wv8M1nHtz
 /wAcXagzflod6cfo95gfYJ+Xl11WOKsATk/qYS2/DjH/qaE5H76XPJ2tcH6cyVQowB1q
 RPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176007; x=1754780807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDJp7tSOiwR5n19lwWeP5HE0v4ZTZzAZzXnPUcAToWY=;
 b=GCfRKJtK6VbJTr5SlTTxPEmLzVNQcQdO76xLgQu83XO5MpFS0rK0xQZSrfrafLUryZ
 txUR/gn2SIkrgfGdqKNHuOcKBUDKuAxyCE/b//8ZmD8Xabk/q9wnT8niVkqHAEejEVsn
 KPLcUeEyTLG4fXm8Ppt8djJkiX2U5EvGrkXV8QvQz3Tffa+PJrWwjct2r8qv9UgtEtZu
 cEIRURxVlrTwRblehcfM0ZwdcC7A6XMniRsrBC6+q2aWlXbZj0rNECmhcV2tRdjGd5pj
 TUnbur8u/Exwr4FgaiM4Xfk+EXzuqDWrNi1yndEmdCE6uH0Hjj4ogSJqbTD/8BRaC0kc
 TmQw==
X-Gm-Message-State: AOJu0YxR2dXuYmPhiUTiX6n+wCY2EGR08sc+ApjeU7TLxSGweYSUKwjB
 Bv7Zcrx1vu57bza8ra1jyMtGfSyBitMc1BY5HFVq74vJuLihLLE4dhPHrBuwaQuR6LZxRqp27Sx
 Lz/57Nok=
X-Gm-Gg: ASbGncuIkp84wp1GdYjecmKHyw206yCh5mXAttPmxKf3F7MtFNMyaIGL2cG60vo00ec
 7YeLqIH0Np0ubh3WAygdLfyZIPjhiAVNLEoZaF47R441KGKx6C3TLztJ10/FM0arWuasI4iw+4p
 3e07G0pctWJ29U09Ffacit+mjDwA5tN+gFM9K7WgILcJyIk5BdXhMX8+emNV7j7gupx1/3ZRam5
 YJgyh/I+J1quOCU+Bpb1MvoWSHvrSA7S/TpkL/lNWHoVW++fjuZ815FrBpj6cNBw040lzuWoa2E
 cKHBU56IGitUKgR2P1dXuIlL1JKxCgJzw2U7Emo7tx/jgacRqk72MFjjT0NHTHwZFswtJyP1N8P
 6xWsgOQlWXftmhd0SdAsYP8wWvLoZUuMiCacjeVu5gp3CLIu092kq
X-Google-Smtp-Source: AGHT+IE7ytutZWV9wx/shKQ2Hu9j1bSGR0SGaW5uu5Mfm+Maeyd48bEN2wdCJnL5Z6y3A4YrdkzEKA==
X-Received: by 2002:a05:6820:1e10:b0:619:a6c0:b30 with SMTP id
 006d021491bc7-619a6c012e1mr277704eaf.6.1754176006763; 
 Sat, 02 Aug 2025 16:06:46 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/95] linux-user/arm: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:51 +1000
Message-ID: <20250802230459.412251-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 52 +++++++++++++++++++++++++++++++--------
 linux-user/elfload.c      | 41 +-----------------------------
 2 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index e2b4099aa4..739e1607e3 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -480,21 +480,53 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUARMState *env = cpu_env(cs);
+    abi_ptr stack = info->start_stack;
+    abi_ptr entry = info->entry;
 
-    cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
-               CPSRWriteByInstr);
-    for(i = 0; i < 16; i++) {
-        env->regs[i] = regs->uregs[i];
+    cpsr_write(env, ARM_CPU_MODE_USR | (entry & 1 ? CPSR_T : 0),
+               CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
+
+    env->regs[15] = entry & 0xfffffffe;
+    env->regs[13] = stack;
+
+    /* FIXME - what to for failure of get_user()? */
+    get_user_ual(env->regs[2], stack + 8); /* envp */
+    get_user_ual(env->regs[1], stack + 4); /* envp */
+
+    /*
+     * Per the SVR4 ABI, r0 contains a pointer to a function to be
+     * registered with atexit.  A value of 0 means we have no such handler.
+     */
+    env->regs[0] = 0;
+
+    /* For uClinux PIC binaries.  */
+    /* XXX: Linux does this only on ARM with no MMU (do we care?) */
+    env->regs[10] = info->start_data;
+
+    /* Support ARM FDPIC.  */
+    if (info_is_fdpic(info)) {
+        /*
+         * As described in the ABI document, r7 points to the loadmap info
+         * prepared by the kernel. If an interpreter is needed, r8 points
+         * to the interpreter loadmap and r9 points to the interpreter
+         * PT_DYNAMIC info. If no interpreter is needed, r8 is zero, and
+         * r9 points to the main program PT_DYNAMIC info.
+         */
+        env->regs[7] = info->loadmap_addr;
+        if (info->interpreter_loadmap_addr) {
+            /* Executable is dynamically loaded.  */
+            env->regs[8] = info->interpreter_loadmap_addr;
+            env->regs[9] = info->interpreter_pt_dynamic_addr;
+        } else {
+            env->regs[8] = 0;
+            env->regs[9] = info->pt_dynamic_addr;
+        }
     }
 
     if (TARGET_BIG_ENDIAN) {
-        CPUState *cpu = env_cpu(env);
-        TaskState *ts = get_task_state(cpu);
-        struct image_info *info = ts->info;
-
         /* Enable BE8.  */
         if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
             && (info->elf_flags & EF_ARM_BE8)) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 89f3972253..9586873954 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -293,46 +293,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    abi_long stack = infop->start_stack;
-    memset(regs, 0, sizeof(*regs));
-
-    regs->uregs[16] = ARM_CPU_MODE_USR;
-    if (infop->entry & 1) {
-        regs->uregs[16] |= CPSR_T;
-    }
-    regs->uregs[15] = infop->entry & 0xfffffffe;
-    regs->uregs[13] = infop->start_stack;
-    /* FIXME - what to for failure of get_user()? */
-    get_user_ual(regs->uregs[2], stack + 8); /* envp */
-    get_user_ual(regs->uregs[1], stack + 4); /* envp */
-    /* XXX: it seems that r0 is zeroed after ! */
-    regs->uregs[0] = 0;
-    /* For uClinux PIC binaries.  */
-    /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
-    regs->uregs[10] = infop->start_data;
-
-    /* Support ARM FDPIC.  */
-    if (info_is_fdpic(infop)) {
-        /* As described in the ABI document, r7 points to the loadmap info
-         * prepared by the kernel. If an interpreter is needed, r8 points
-         * to the interpreter loadmap and r9 points to the interpreter
-         * PT_DYNAMIC info. If no interpreter is needed, r8 is zero, and
-         * r9 points to the main program PT_DYNAMIC info.
-         */
-        regs->uregs[7] = infop->loadmap_addr;
-        if (infop->interpreter_loadmap_addr) {
-            /* Executable is dynamically loaded.  */
-            regs->uregs[8] = infop->interpreter_loadmap_addr;
-            regs->uregs[9] = infop->interpreter_pt_dynamic_addr;
-        } else {
-            regs->uregs[8] = 0;
-            regs->uregs[9] = infop->pt_dynamic_addr;
-        }
-    }
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_NREG    18
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-- 
2.43.0


