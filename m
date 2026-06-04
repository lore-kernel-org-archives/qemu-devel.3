Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FADCD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 00:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUvzR-0007Pu-R8; Wed, 03 Jun 2026 20:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUvzM-0007NE-Ap
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:31:13 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUvzK-0004XY-36
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:31:12 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66077e90382so192298d50.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780533069; x=1781137869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWXBs1pgY1eWN4UiVrFEyWZcC6RnRdpjRugiAxsO/VU=;
 b=c4Kxy+0XRfe3jlin1u7Cq9QsAHusg1yiiHU2w/X1SZXK7s2VKhSbQMb4gmlVEqdQ/G
 /irdn7gWsieUSNlJFTGir2rp0+wZXB2YDvEmSYhEspiIaeBu7otBM9E4BTJqpbm0p3t/
 DRnZfrff2CDqL6m1bLBj7Gk42brCp5YSUA235XOGHypRUiaaXStgyCpYL/DSwNrfoVF0
 e0Hk/5Vhfmy7E4ho+1nm017gzRKPw/kzEg6MKA9kRMv6XrOlocPR1gPK6w3JwiH4nMPw
 nu0/6xgqynx0lvS0/ktsPkHEy7KAhc1i28SN+qNjtl6sgcBfeAb/os7H2T1FdAX/1Ey8
 mIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780533069; x=1781137869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MWXBs1pgY1eWN4UiVrFEyWZcC6RnRdpjRugiAxsO/VU=;
 b=VY3rCaQba0ITcNOvT31zWkTDZrzt3zZjgi5NdxWO4GhH2g8dKMOHHRWOTYqLpwUzct
 Jj0THjDJ6WtIkbcMl/dr12O1gvo59Qa/jsRmk0QYRGcwZb8WhK4m0j+4CMKy9J5Unt1l
 H+XFt0JtFIDjYAoivJIgT7blZpEuK5MQfstcy+0HU8KfjCHCkCgiYuj99UUcTDr/0CEe
 KC6UtfAUmWv/+jw9Iwvn0Ywaq4eYOGBwwzrpRfzUEbK7XJ5Nd8S+9U3LVK+R7wv88ZcC
 KFEUywC0VDmVf6T7ZBcTppMmEiPA9IkAoICCSyNSL9g2MYI9Rprk0Q4pat2TXckvb+N1
 7Syw==
X-Gm-Message-State: AOJu0Yze0A9XtPmT8Qq5bicMxyM90oiMX+jIksE1nzmVwniTNvdaHsgF
 TH3abjFbuM7r1IMMaM7Fd19j18gS9Dz2JT7Iom0W4KLu088HhZiu3kRo+Kz1ZWmU
X-Gm-Gg: Acq92OGqSDtRnVVMtpW5/Xidu/RMQ0Si2YuuW1ML3c9/xmYr7567ERFjDJ1keJG9HdO
 0lT34UelPopBXbnmffziuJR+spKSL95KMUmEd4bZoc/R7NDZeuXpd/QFJyE27sVzN+Xc66PoGbb
 vvInGkvpcKzOY8z1qsh4fL+jQtRTP+DE0dxc9192Hv9QPFbIrR7a7SBD3v9NYJJi9JdiQ+bpDXg
 zga7Mafdba8UiF+V3EApGmMwp6pe2qr1GQCy054KxiesNVvQXITuvw2RRUPJVKX2YrmkV7oqdUM
 OOOdGzFslz15Pwhk1LRMtGuvr53MgQKfWbcSkDaL5L8/0fjJfiybJP8GpxNf9HaGNQFTHVxdbYg
 mQ9r0bmrT71tp8SoKu5SUsBJIHhRC/Diyepnx/W2swkJmJy6LF371rJEC0654bcqjErRueTmb9D
 5cAutt8khwiSVkczGFtHU/pVGTEPeD+DoCEA==
X-Received: by 2002:a05:690e:d8d:b0:656:7cd:98e4 with SMTP id
 956f58d0204a3-660dbbb0028mr5635790d50.16.1780533068532; 
 Wed, 03 Jun 2026 17:31:08 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d5ffc643sm2876132d50.9.2026.06.03.17.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:31:06 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 4/4] linux-user/sparc: flush register windows before core
 dump
Date: Wed,  3 Jun 2026 20:30:59 -0400
Message-ID: <20260604003059.2083625-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603161852.1831864-4-mattst88@gmail.com>
References: <20260603161852.1831864-4-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12f.google.com
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
 linux-user/elfload.c          |  9 ++++++++
 linux-user/sparc/cpu_loop.c   |  3 ++-
 linux-user/sparc/cpu_loop.h   |  7 +++++++
 linux-user/sparc/elfload.c    | 39 +++++++++++++++++++++++++++++------
 linux-user/sparc/target_elf.h | 17 +++++++++++----
 5 files changed, 64 insertions(+), 11 deletions(-)
 create mode 100644 linux-user/sparc/cpu_loop.h

diff --git ./linux-user/elfload.c ./linux-user/elfload.c
index f7625c0952..b05b8b0c6b 100644
--- ./linux-user/elfload.c
+++ ./linux-user/elfload.c
@@ -2445,6 +2445,9 @@ static int wmr_write_region(void *opaque, vaddr start,
  * handler (provided that target process haven't registered
  * handler for that) that does the dump when signal is received.
  */
+#ifdef TARGET_SPARC
+#include "sparc/cpu_loop.h"
+#endif
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
     const CPUState *cpu = env_cpu_const(env);
@@ -2468,6 +2471,12 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     cpu_list_lock();
     mmap_lock();
 
+#ifdef TARGET_SPARC
+    CPU_FOREACH(cpu_iter) {
+        flush_windows(cpu_env(cpu_iter));
+    }
+#endif
+
     /* By unprotecting, we merge vmas that might be split. */
     walk_memory_regions(NULL, wmr_page_unprotect_regions);
 
diff --git ./linux-user/sparc/cpu_loop.c ./linux-user/sparc/cpu_loop.c
index ab633eeae3..0aacda9448 100644
--- ./linux-user/sparc/cpu_loop.c
+++ ./linux-user/sparc/cpu_loop.c
@@ -22,6 +22,7 @@
 #include "user-internals.h"
 #include "user/cpu_loop.h"
 #include "signal-common.h"
+#include "sparc/cpu_loop.h"
 
 #define SPARC64_STACK_BIAS 2047
 
@@ -119,7 +120,7 @@ static void restore_window(CPUSPARCState *env)
 #endif
 }
 
-static void flush_windows(CPUSPARCState *env)
+void flush_windows(CPUSPARCState *env)
 {
     int offset, cwp1;
 
diff --git ./linux-user/sparc/cpu_loop.h ./linux-user/sparc/cpu_loop.h
new file mode 100644
index 0000000000..fb6e82d372
--- /dev/null
+++ ./linux-user/sparc/cpu_loop.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef SPARC_CPU_LOOP_H
+#define SPARC_CPU_LOOP_H
+
+void flush_windows(CPUSPARCState *env);
+
+#endif
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


