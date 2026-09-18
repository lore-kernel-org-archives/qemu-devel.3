Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DCC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MhK-0007IK-OX; Thu, 17 Sep 2026 20:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MhB-000795-Vy
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:18 -0400
Received: from mail-pz2-x15.google.com ([2607:f8b0:4864:3b::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mh8-0001Tn-99
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:17 -0400
Received: by mail-pz2-x15.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so88767a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692193; x=1790296993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFxsNUrfwL8GOMNQ0Kg8dOmf0IriTwuKtegSZ2mCLWM=;
 b=plgE2ihZQ66n2hs57Q8Dscbc50dNuoy23HZhWeafMdc2TZ8ecCtG49MqI5bVtsMLFn
 ASyJUHQF4hL7NVwYF2vBVNVebV8LiVW1pmuSaG5xgg68H4hOHYlrsksqyiMVmzjGzWXv
 hACqfnmjtd/yVvKZc07YjfXuMD+hXkZ28zXFjvoPOlg21F9U9uWLzsRleZJJRA1mi+VN
 mDOlOVeh2q/92SuYl6af/0K8XMux3zSHbSw2BnOCtO6DMqUtLAm+JnQZ9eFmv068kfwS
 DPu1UjEg7PKDDOgQzW/pXoehjKl/gTC4IPO1xv6MF70e5wtY/J1aXIVkL1hpCyG9stfh
 x1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692193; x=1790296993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFxsNUrfwL8GOMNQ0Kg8dOmf0IriTwuKtegSZ2mCLWM=;
 b=P1kgGbwlyWDT4x/pWY8FIZUjWlV/CVpXTFAXnzmS/4Qnbww2RwoH4PtiVZ3R0DzpkV
 FLENISvxN4nDVM+omjl5MzVQKypWjKIN/ELIQxUIb72iZg8bWeIcK04QpDwPzfO9cp8t
 Kgt3kcbIq9gUWk1CaS/s1FZLyJiFt/qZnsg0SUkCx6FWbuXf8rh5/BEA6EF+ThuQDP+0
 uB4mJ5Hn6ZzuXPB0KnYZVts7VXcJ+KuLy6mEjqF2gRqlB8AvOtruXuVlDo+DJidKmlSW
 Gy2Ab7MJ/3lEyWS+eh/syEAPh80Ic0EpAghbjkTQCn+TS0Niv9Jm7+Od7NL2TeZx1ysC
 dl0w==
X-Gm-Message-State: AFuF++mPjS+Szkj9BcvQOf6W0X+OSVCEnCk0cYBgFUao1YXnZhjtLABa
 hgHcon1tZCP9An6hn36XsjOOGkaciWhvw/Twj+O9jgvi0SpcpRSR9DSsbmQSrkAyiBY=
X-Gm-Gg: AYBFou083+qQEbj+pPvGnmZH2u3ANAtDS1Or8T+u3UbCzU9RPLGaH8b7ZI58+m7I86C
 tBXxR6tz6pagm5xauQsljfu6aJXgeGnWmVvWgV1/KA1QNVl+xEr6QVHvDGJsalEFwLB0fNFrw5+
 5J+j4svK3TzWDzbKzyh5NW2tNT93kfLvq6/imMo42ltksAkzbGfOzwnnD/wAgbK8C02qm4UoK1J
 rABct5G6HNdZgMffhfqehyq3qo0UHwxImMUIjDonxLp+iWS17X84psdkwKRT45Qt2HrgjKMNrjn
 8VpOPrwpA5pgeoAxXjYlv/8rQbZr8dwl3aD+ToBTDuGZGJTqCDevSQf9A5g4F3+lerFF05j1KBq
 jObPPEgQZ2Jsaj79yptif0bzUq9/KpuZIW2rlgfxkMMiSJbdHz9+hC68WOZXX0bardFzyGeDSne
 +Hzc2hKWKH9FUPwppapodjSFnwSqybLugh6fXHIhcf5VVW+Lelvol013sQp7KoMGbvsGOFjNePg
 /erbgDydp0GU4jBJHvXfup48zFyh62q
X-Received: by 2002:a05:6a20:cd95:b0:3dd:85a8:4c63 with SMTP id
 adf61e73a8af0-3dd8c5d24f8mr1153008637.42.1789692192626; 
 Thu, 17 Sep 2026 17:43:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:43:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 04/21] target/rx: convert raises to raise_excp
Date: Fri, 18 Sep 2026 08:42:06 +0800
Message-ID: <20260918004225.827-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::15;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x15.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Name guest trap numbers RX_EXCP_* in cpu.h. TCG loop codes such as
EXCP_INTERRUPT start at 0x10000. Translate privilege, illegal, BRK,
and INT through gen_helper_raise_excp. Prefix leftover TCG wait as
rx_wait, and drop unused raise_access_fault and the one-line
raise_exception wrapper. FPSW still exits with RX_EXCP_ACCESS.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/rx/cpu.h       | 13 ++++++++++++
 target/rx/helper.c    | 16 +++++++--------
 target/rx/helper.h    |  7 +------
 target/rx/op_helper.c | 46 +++----------------------------------------
 target/rx/translate.c | 19 ++++++++++--------
 5 files changed, 36 insertions(+), 65 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 64ba48a7329..233615c32dc 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -71,6 +71,19 @@ enum {
     NUM_REGS = 16,
 };
 
+/*
+ * Guest trap numbers in cs->exception_index. TCG loop codes such as
+ * EXCP_INTERRUPT start at 0x10000 in cpu-common.h and do not overlap these.
+ */
+enum {
+    RX_EXCP_PRIVILEGE_VIOLATION = 20,
+    RX_EXCP_ACCESS = 21,
+    RX_EXCP_ILLEGAL_INSTRUCTION = 23,
+    RX_EXCP_FPU = 25,
+    RX_EXCP_NMI = 30,
+    RX_EXCP_INT = 0x100,
+};
+
 typedef struct CPUArchState {
     /* CPU registers */
     uint32_t regs[NUM_REGS];    /* general registers */
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0f99279bbaa..2ebda733489 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -86,13 +86,13 @@ void rx_cpu_do_interrupt(CPUState *cs)
         env->isp -= 4;
         cpu_stl_le_data(env, env->isp, env->pc);
 
-        if (vec < 0x100) {
+        if (vec < RX_EXCP_INT) {
             env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         } else {
             env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
 
-        if (vec == 30) {
+        if (vec == RX_EXCP_NMI) {
             /* Non-maskable interrupt */
             qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         } else {
@@ -100,22 +100,22 @@ void rx_cpu_do_interrupt(CPUState *cs)
         }
 
         switch (vec) {
-        case 20:
+        case RX_EXCP_PRIVILEGE_VIOLATION:
             expname = "privilege violation";
             break;
-        case 21:
+        case RX_EXCP_ACCESS:
             expname = "access exception";
             break;
-        case 23:
+        case RX_EXCP_ILLEGAL_INSTRUCTION:
             expname = "illegal instruction";
             break;
-        case 25:
+        case RX_EXCP_FPU:
             expname = "fpu exception";
             break;
-        case 30:
+        case RX_EXCP_NMI:
             expname = "non-maskable interrupt";
             break;
-        case 0x100 ... 0x1ff:
+        case RX_EXCP_INT ... RX_EXCP_INT + 0xff:
             expname = "unconditional trap";
         }
         qemu_log_mask(CPU_LOG_INT, "exception 0x%02x [%s] raised\n",
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb71..1c749198b9b 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -1,9 +1,4 @@
-DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
-DEF_HELPER_1(raise_access_fault, noreturn, env)
-DEF_HELPER_1(raise_privilege_violation, noreturn, env)
-DEF_HELPER_1(wait, noreturn, env)
-DEF_HELPER_2(rxint, noreturn, env, i32)
-DEF_HELPER_1(rxbrk, noreturn, env)
+DEF_HELPER_1(rx_wait, noreturn, env)
 DEF_HELPER_3(fadd, f32, env, f32, f32)
 DEF_HELPER_3(fsub, f32, env, f32, f32)
 DEF_HELPER_3(fmul, f32, env, f32, f32)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e5..4ff61fb555b 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -25,10 +25,6 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
-static inline G_NORETURN
-void raise_exception(CPURXState *env, int index,
-                     uintptr_t retaddr);
-
 static void _set_psw(CPURXState *env, uint32_t psw, uint32_t rte)
 {
     uint32_t prev_u;
@@ -115,7 +111,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
         enable = FIELD_EX32(env->fpsw, FPSW, ENABLE);
         enable |= 1 << 5; /* CE always enabled */
         if (cause & enable) {
-            raise_exception(env, 21, retaddr);
+            cpu_loop_exit_excp(env_cpu(env), RX_EXCP_ACCESS, retaddr);
         }
     }
 }
@@ -419,48 +415,12 @@ uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-/* exception */
-static inline G_NORETURN
-void raise_exception(CPURXState *env, int index,
-                     uintptr_t retaddr)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = index;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-
-G_NORETURN void helper_raise_privilege_violation(CPURXState *env)
-{
-    raise_exception(env, 20, GETPC());
-}
-
-G_NORETURN void helper_raise_access_fault(CPURXState *env)
-{
-    raise_exception(env, 21, GETPC());
-}
-
-G_NORETURN void helper_raise_illegal_instruction(CPURXState *env)
-{
-    raise_exception(env, 23, GETPC());
-}
-
-G_NORETURN void helper_wait(CPURXState *env)
+G_NORETURN void helper_rx_wait(CPURXState *env)
 {
     CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     env->in_sleep = 1;
     env->psw_i = 1;
-    raise_exception(env, EXCP_HLT, 0);
-}
-
-G_NORETURN void helper_rxint(CPURXState *env, uint32_t vec)
-{
-    raise_exception(env, 0x100 + vec, 0);
-}
-
-G_NORETURN void helper_rxbrk(CPURXState *env)
-{
-    raise_exception(env, 0x100, 0);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 }
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710c..95c5fd4ac8c 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -245,7 +245,9 @@ static int is_privileged(DisasContext *ctx, int is_exception)
 {
     if (FIELD_EX32(ctx->tb_flags, PSW, PM)) {
         if (is_exception) {
-            gen_helper_raise_privilege_violation(tcg_env);
+            gen_helper_raise_excp(tcg_env,
+                                  tcg_constant_i32(RX_EXCP_PRIVILEGE_VIOLATION),
+                                  tcg_constant_i32(1));
         }
         return 0;
     } else {
@@ -2174,7 +2176,8 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
 static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 {
     tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxbrk(tcg_env);
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(RX_EXCP_INT),
+                          tcg_constant_i32(0));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -2182,12 +2185,10 @@ static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv_i32 vec;
-
     tcg_debug_assert(a->imm < 0x100);
-    vec = tcg_constant_i32(a->imm);
     tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxint(tcg_env, vec);
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(RX_EXCP_INT + a->imm),
+                          tcg_constant_i32(0));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -2197,7 +2198,7 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
 {
     if (is_privileged(ctx, 1)) {
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-        gen_helper_wait(tcg_env);
+        gen_helper_rx_wait(tcg_env);
     }
     return true;
 }
@@ -2228,7 +2229,9 @@ static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->pc = ctx->base.pc_next;
     insn = decode_load(ctx);
     if (!decode(ctx, insn)) {
-        gen_helper_raise_illegal_instruction(tcg_env);
+        gen_helper_raise_excp(tcg_env,
+                              tcg_constant_i32(RX_EXCP_ILLEGAL_INSTRUCTION),
+                              tcg_constant_i32(1));
     }
 }
 
-- 
2.52.0.windows.1


