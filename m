Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EAAC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5oA8-0000ZZ-UY; Sun, 13 Sep 2026 13:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1x5oA3-0000ZI-D2
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 13:38:39 -0400
Received: from mail-lr2-x10.google.com ([2a00:1450:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1x5o9z-0000A4-8W
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 13:38:38 -0400
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a35a64530bso10529151fa.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789321112; x=1789925912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5SzuX8hK34l8gqGT4pU8KBZ1ewmKJHiG2PYYQdg6vOE=;
 b=r7RnwSwVxQGs2O/VSKfrSTvU1v9Tb3rvVw9Cy+rQOku5I7uYNkg06wcxogSJ+E/l/b
 TvGAXISIrqF/+Nws1V0BOLOY5hdZ8+cp1bkrQn2NYRSzQ6RsvOVDYRoY8UtM/L6E2yE0
 WAOQ6hURBeAhJ/e0XbWuo0zjrhhgGaw2W/f+oJNinBmMdwmGobq06C24yYRwORwLdXYd
 zQm8IOQ33qOQ/iQcbyj+Yi4mhRhty/hKnJYpHLplbNOUGdULeux0Gk2nrv1NHZcG+l3c
 os2zF5SBrDGPD5J5If2J4oEBYCjJoUV2gr16H6Y88kUnIooYV2jTnrLAoCnONG5deSMH
 hFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789321112; x=1789925912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5SzuX8hK34l8gqGT4pU8KBZ1ewmKJHiG2PYYQdg6vOE=;
 b=W6981pUysHCmcPtEXXUy9eAVgqRVgEdpZANaatzh0226caucG2S1SPIFRxqiYFlqWv
 H4EoyJpoSaqLDgWgwIyBSxA/r1j/sLIUMjg4MEzsmDvr28/UJQGkStQ6G65qC+bfeAfF
 xqwTPjmCl8iUsJCQF+CIONMjnGUtUFF2H6Ljot/JxWRHhl5s1H+HBOumIe1uNieN3QpO
 b01nlRXgNR0rb1mf95mC8rrzFlQnmaXMeo6BZcBVOmHMNo3Eeig+R17poGNAZDS/KVRm
 x/K0umod9Fa6QTCCGlZq8AdqIXuzE1bVI+a6bU+W+koTvM8m3rAGw34BpajSjPyE0BcY
 +Grg==
X-Gm-Message-State: AFuF++nzdFvHZLmknwQHIihCMmn+aWeoyTU6GGvSSA0D+QrYQehOBGyJ
 jzxo6/YtBkbliT4hKO9O9HuBMqA+rJcIAAUxizQzQ7RBJy1D2gF91AT8p8/HcaOI
X-Gm-Gg: AYBFou0hIrYGmi23cY4gsUDTjS7KSYZB1kBFOCRTviVpKgvD8Akn+F4qKauIa7CZTFU
 2IS3T/PtBfJMII4ED/kRByQngQd/irYi8PA4IGjTasCMiqJ46jOFhICZNyeW2edImSGtWKUrNrl
 Ml1JimYkEz0DjT6LwNFnajGqiD1D2yAFgFmQ1M3I+dGN2jUVIIqkR4/oCQ6SUM9lqAbR48jm6f5
 +dP1bIugNF2ecpvS1nnzS2XXml7cJiVzV+JQSWN4HA6rcoEnoH3icWTOtpMo+QnTTxSrj0hDFu7
 l5paVf5JKT7NiAUk4CWoeEb64bCe1VhKqpXigYjMExcDANcg/fNqSoNChVzIFMdBhNh2VDss+lq
 +uc/5QpDbIpjFpjbOX3DoBGro5rt4LZjbizlw5MLE72+KTSzb+DObxYMkLhFy6nkQF8wTvW7w7g
 y2NdwQEJi+J3SfZY/7V0C0aL/w85/LQXdjvraeWYz6fe1xjxiBmIWkbQT3r+xthYWVZzy4BYkBp
 JbraW6pIuAxFghbt7mg63XWbGSY5V1qOhuyBTgMwRU5BwMGgWBnEaUjZUvMXP8W9tsMYTEQOUdy
 ZkAn
X-Received: by 2002:a2e:bea1:0:b0:3a3:74b9:8a7c with SMTP id
 38308e7fff4ca-3a5b382d649mr9569701fa.21.1789321111582; 
 Sun, 13 Sep 2026 10:38:31 -0700 (PDT)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a334c571sm21190241fa.27.2026.09.13.10.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 10:38:31 -0700 (PDT)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, richard.henderson@linaro.org,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH] target/i386: fix EFLAGS reads in TCG plugin callbacks
Date: Sun, 13 Sep 2026 20:38:01 +0300
Message-ID: <20260913173801.96942-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:38::10;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lr2-x10.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The plugin register API reads env->eflags through the gdbstub.
During TCG execution, arithmetic flags are kept in the lazy CC state
and DF in env->df, so this can return incorrect EFLAGS values.

Add eflags_in_tcg, set on TCG entry and cleared on exit, to select
cpu_compute_eflags() while the flags are split. Also synchronize cc_op
with gen_update_cc_op() before instruction callbacks when plugins are
enabled, since the current value may still be in the translator context.

Outside TCG execution, keep reading env->eflags, which holds the
complete flags. Unconditional reconstruction can use stale lazy state
and break GDB readback: in testing, writing 0x0202 through GDB was
followed by a readback of 0x0203.

Richard Henderson previously proposed EFLAGS reconstruction and cc_op
synchronization for i386 plugin register reads.

Link: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1047061.html
Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 target/i386/cpu.h           | 1 +
 target/i386/gdbstub.c       | 3 +++
 target/i386/tcg/tcg-cpu.c   | 2 ++
 target/i386/tcg/translate.c | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9ce8ca0038..b3b4528ea7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2347,6 +2347,7 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUX86State env;
+    bool eflags_in_tcg;
     VMChangeStateEntry *vmsentry;
 
     uint64_t ucode_rev;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 5c5fa72721..e636ca0f4a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -151,6 +151,9 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         case IDX_IP_REG:
             return gdb_get_reg(env, mem_buf, env->eip);
         case IDX_FLAGS_REG:
+            if (cpu->eflags_in_tcg) {
+                return gdb_get_reg32(mem_buf, cpu_compute_eflags(env));
+            }
             return gdb_get_reg32(mem_buf, env->eflags);
 
         case IDX_SEG_REGS:
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b..2402608fe9 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -38,6 +38,7 @@ static void x86_cpu_exec_enter(CPUState *cs)
     env->df = 1 - (2 * ((env->eflags >> 10) & 1));
     CC_OP = CC_OP_EFLAGS;
     env->eflags &= ~(DF_MASK | CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+    cpu->eflags_in_tcg = true;
 }
 
 static void x86_cpu_exec_exit(CPUState *cs)
@@ -46,6 +47,7 @@ static void x86_cpu_exec_exit(CPUState *cs)
     CPUX86State *env = &cpu->env;
 
     env->eflags = cpu_compute_eflags(env);
+    cpu->eflags_in_tcg = false;
 }
 
 static TCGTBCPUState x86_get_tb_cpu_state(CPUState *cs)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb..c469d74efe 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3483,6 +3483,9 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    if (dcbase->plugin_enabled) {
+        gen_update_cc_op(dc);
+    }
     dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {

base-commit: 257bf4f160c50ca8c4ebd603f519f5c786013fb7
-- 
2.55.0


