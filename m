Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E062CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoJL-0000xf-Hd; Wed, 03 Jun 2026 12:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJJ-0000xG-Mr
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:17 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJH-0001Xd-U7
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:17 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7e10f91425fso7187907b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503555; x=1781108355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gITAeosif5kRkIcLbpqcyElbkVQvax1dEs+EyVFp5Ic=;
 b=jnJfy98Z8YGobFZAcZMEiQJJ6iYXjJ9wNkv/0x0TL4pZfXeWSskU/vXV+TC4dMEsj+
 IsSIqX0m/L32HpHZTApUw4+EwQtSsrLm5X4gqSNVXwv82D+Z6P/fW0WqKJAEiP2i/9kG
 x4i8+fpobV9CbqnktqCqElBTzmM/Pbt6QGnTjDnL6/KMIp+jT3azDBsIOFIDGS4cput5
 eGafehZEujZEWivFZwz61o870CUtoPk4lgucwJ7oTkiHWLoVXSX4wsVpld2jsrANA6YR
 CKyxFGjjBjIcNfK7UoVLBTt6H7/LyaEO1XbCrXv+QV1Yx56oAtl8FZzn6s+y//vMPxJT
 GNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503555; x=1781108355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gITAeosif5kRkIcLbpqcyElbkVQvax1dEs+EyVFp5Ic=;
 b=Vq65EEzUtGWVMKcTQg2uPLOflh43FVPIt6gTCIgDuk2yK+UtCuWju4lxRSyw1Fod7/
 YO7hx+AD0Qaa2CnNABBH7p1vviMsh0qOJkLeU1CCmK8hUtJjcYHhJe5A+URRXZ8X5lxH
 woAdUppz6n4cRKNbCndFze5NkTC7U8Qn6/YCcwIFvOUqbxatsFLwgj2yyEY9WaTlr725
 op2DiXXr9f0jyPS2tUlZEPYlvJuELsjWhsn2p3eyE7BrdhXRxFP87VYAg41IVSGId5Sk
 5rbEjs5P8uza3nlW8Ko0IZp7Jr6ZvdImhVRjBKasJw3SyY6E+Bxq+oYu7R+E3To45wYg
 n5UQ==
X-Gm-Message-State: AOJu0YwpRHsDBthu8X43X4pkUFH/o8vDgr5SdGqGI6c3X8/xWBxqkZv4
 fkZi/bYwxeeY8evo5KgxCoXHED1J85ZsdpWg61+Ko5FVhBX22hrzhFibDrt1z/o9VWA=
X-Gm-Gg: Acq92OFHTD7i9R0XEEIh6C3Pml5laxrLGJ4GU5Vlk0z2apMbZaBhV5u5PRg2YlaOIdJ
 O8W7F3qmxupFyJEfhtXltskQeS8ug3y5kZ/Wouf3q22vDimOc1em/cFzeynWkGCQdeTPaLX+W35
 jpWoLkVFSBD2eSKbikU53XgXimo1AcOntqNxq3G9VugZvZVbjVh6iFz/JEClcL1TplhJTj5tpcj
 P8OOuUzJlPvI1QaDQDNEf03odz+OswJirrZ5t/jacs8RDnLAQSDBq++yml7g1X3zNHO8mhJL3z3
 Maritg/mdeFkQaunrf6HyJ9AVRgAnsO1fzBfbziCjseEP2VRV1f2EOY4QaKgcILFt6BXxpvE2+O
 MBHVArcv1wCPj94PbVObdeE/1cG3uUtMCQHf+Tl8R3gd7hbbAaCmcaQoh3MauFfi5xvfU5n8cuV
 ppb4+x0P86/JNDXvX7fD+mHxRXLm9IEuEWCQ==
X-Received: by 2002:a05:690c:e4ad:b0:7bd:73f3:7a58 with SMTP id
 00721157ae682-7eb8b17d4famr1088627b3.11.1780503554752; 
 Wed, 03 Jun 2026 09:19:14 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea23a97729sm19521747b3.36.2026.06.03.09.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:19:13 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4/4] linux-user/sparc: flush register windows before core dump
Date: Wed,  3 Jun 2026 12:18:52 -0400
Message-ID: <20260603161852.1831864-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603161852.1831864-1-mattst88@gmail.com>
References: <20260603161852.1831864-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Without this, only the crash frame's window is spilled to the
stack; all deeper call frames remain in the register file and
are absent from the core's memory segments. Stack unwinding
fails past the first DWARF step because the callers' register
save areas contain stale/garbage data.

The real kernel calls flush_all_user_windows() at the top of
do_coredump(). Mirror that via a weak target_flush_windows()
hook called from dump_core_and_abort(), with the SPARC override
calling the existing flush_windows() in cpu_loop.c.
---
 linux-user/signal-common.h    |  1 +
 linux-user/signal.c           |  9 ++++++++
 linux-user/sparc/cpu_loop.c   | 10 +++++++++
 linux-user/sparc/elfload.c    | 39 +++++++++++++++++++++++++++++------
 linux-user/sparc/target_elf.h | 17 +++++++++++----
 5 files changed, 66 insertions(+), 10 deletions(-)

diff --git ./linux-user/signal-common.h ./linux-user/signal-common.h
index 8a44714251..54df4ccfdb 100644
--- ./linux-user/signal-common.h
+++ ./linux-user/signal-common.h
@@ -62,6 +62,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUArchState *env);
 
+void target_flush_windows(CPUArchState *env);
 void process_pending_signals(CPUArchState *cpu_env);
 void signal_init(const char *rtsig_map);
 void queue_signal(CPUArchState *env, int sig, int si_type,
diff --git ./linux-user/signal.c ./linux-user/signal.c
index f0a22577e5..a7355fdeb8 100644
--- ./linux-user/signal.c
+++ ./linux-user/signal.c
@@ -502,6 +502,14 @@ void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo)
     info->si_value.sival_ptr = (void *)(long)sival_ptr;
 }
 
+/*
+ * Weak arch hook: flush all register windows to the guest stack before
+ * writing a core dump.  Required on SPARC where the register file holds
+ * multiple call-frames that have not been spilled to memory yet.
+ * Architectures without register windows leave this as a no-op.
+ */
+void __attribute__((weak)) target_flush_windows(CPUArchState *env) {}
+
 /* returns 1 if given signal should dump core if not handled */
 static int core_dump_signal(int sig)
 {
@@ -828,6 +836,7 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
 
     /* dump core if supported by target binary format */
     if (core_dump_signal(target_sig) && (ts->bprm->core_dump != NULL)) {
+        target_flush_windows(env);
         stop_all_tasks();
         core_dumped =
             ((*ts->bprm->core_dump)(target_sig, env) == 0);
diff --git ./linux-user/sparc/cpu_loop.c ./linux-user/sparc/cpu_loop.c
index ab633eeae3..2d16304c08 100644
--- ./linux-user/sparc/cpu_loop.c
+++ ./linux-user/sparc/cpu_loop.c
@@ -149,6 +149,16 @@ static void flush_windows(CPUSPARCState *env)
 #endif
 }
 
+/* Override the weak hook in linux-user/signal.c to flush all SPARC register
+ * windows to the guest stack before a core dump is written.  Without this,
+ * only the active window (captured in NT_PRSTATUS) ends up in memory; all
+ * deeper call frames remain in the register file and are absent from the
+ * core's memory segments, breaking stack unwind beyond one frame. */
+void target_flush_windows(CPUArchState *env)
+{
+    flush_windows((CPUSPARCState *)env);
+}
+
 static void next_instruction(CPUSPARCState *env)
 {
     env->pc = env->npc;
diff --git ./linux-user/sparc/elfload.c ./linux-user/sparc/elfload.c
index e6387ec891..181f1e00b5 100644
--- ./linux-user/sparc/elfload.c
+++ ./linux-user/sparc/elfload.c
@@ -12,16 +12,41 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
     CPUSPARCState *e = (CPUSPARCState *)env;
     int i;
 
+    memset(r, 0, sizeof(*r));
+
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    /* Linux kernel layout for sparc64 (arch/sparc/include/asm/elf_64.h):
+     *   [0..7]   G0-G7
+     *   [8..15]  O0-O7
+     *   [16..23] L0-L7
+     *   [24..31] I0-I7
+     *   [32]     TSTATE
+     *   [33]     TPC
+     *   [34]     TNPC
+     *   [35]     Y
+     */
     for (i = 0; i < 8; i++) {
-        r->regs[i]     = tswap64(env->gregs[i]);
-        r->regs[8 + i] = tswap64(env->regwptr[WREG_O0 + i]);
+        r->regs[i]      = tswap64(env->gregs[i]);
+        r->regs[8 + i]  = tswap64(env->regwptr[WREG_O0 + i]);
+        r->regs[16 + i] = tswap64(env->regwptr[WREG_L0 + i]);
+        r->regs[24 + i] = tswap64(env->regwptr[WREG_I0 + i]);
     }
-    r->regs[16] = tswap64(sparc64_tstate(e));
-    r->regs[17] = tswap64(env->pc);
-    r->regs[18] = tswap64(env->npc);
-    r->regs[19] = tswap64(env->y);
+    r->regs[32] = tswap64(sparc64_tstate(e));
+    r->regs[33] = tswap64(env->pc);
+    r->regs[34] = tswap64(env->npc);
+    r->regs[35] = tswap64(env->y);
 #else
+    /* Linux kernel layout for sparc32 (arch/sparc/include/asm/elf_32.h):
+     *   [0]      PSR
+     *   [1]      PC
+     *   [2]      NPC
+     *   [3]      Y
+     *   [4..11]  G0-G7
+     *   [12..19] O0-O7
+     *   [20..27] L0-L7
+     *   [28..35] I0-I7
+     *   [36..37] reserved (stack_check)
+     */
     r->regs[0] = tswap32(cpu_get_psr(e));
     r->regs[1] = tswap32(env->pc);
     r->regs[2] = tswap32(env->npc);
@@ -29,6 +54,8 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
     for (i = 0; i < 8; i++) {
         r->regs[4 + i]  = tswap32(env->gregs[i]);
         r->regs[12 + i] = tswap32(env->regwptr[WREG_O0 + i]);
+        r->regs[20 + i] = tswap32(env->regwptr[WREG_L0 + i]);
+        r->regs[28 + i] = tswap32(env->regwptr[WREG_I0 + i]);
     }
 #endif
 }
diff --git ./linux-user/sparc/target_elf.h ./linux-user/sparc/target_elf.h
index edb0b3103c..365af864b0 100644
--- ./linux-user/sparc/target_elf.h
+++ ./linux-user/sparc/target_elf.h
@@ -24,12 +24,21 @@
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
- * Matches the kernel's elf_gregset_t (ELF_NGREG = 20).
- * sparc32/sparc32plus: psr, pc, npc, y, u_regs[16] (g0-g7, o0-o7)
- * sparc64:             u_regs[16] (g0-g7, o0-o7), tstate, pc, npc, y
+ * Matches the kernel's elf_gregset_t.
+ *   sparc32/sparc32plus (ELF_NGREG = 38):
+ *     psr, pc, npc, y, u_regs[16] (g0-g7, o0-o7),
+ *     reg_window[16] (l0-l7, i0-i7), stack_check[2]
+ *   sparc64             (ELF_NGREG = 36):
+ *     u_regs[16] (g0-g7, o0-o7), reg_window[16] (l0-l7, i0-i7),
+ *     tstate, tpc, tnpc, y
  */
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+# define TARGET_ELF_NGREG       36
+#else
+# define TARGET_ELF_NGREG       38
+#endif
 typedef struct target_elf_gregset_t {
-    abi_ulong regs[20];
+    abi_ulong regs[TARGET_ELF_NGREG];
 } target_elf_gregset_t;
 
 #endif
-- 
2.53.0


