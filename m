Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6001C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUj-0000eL-ED; Mon, 31 Aug 2026 23:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUa-0000cb-Qe
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:00 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUX-0004M0-NP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:00 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-856114a8247so4741047b3.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234537; x=1788839337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HOjRzfQpe3kE34Y2l5KyKrR2biv2SpLqm7CIXewxRtU=;
 b=s3WaxJXVR4vZx+CvsTI7De9GD0E//SP/jRfU13QYcpm4X5yuwIGTzFrQ/DXmkQa1MI
 OWEH2eU4dPdg5c9UkMsIsGtFCGSioLG9N006CsIcBkW34J3K6cFzNdXEeKIBuo0p7kEA
 FY7biKsnpdwMe+SpG6+Wh4fnnTu+HybHB1i9Q5jSYF2QRDOAdUklQ0+hCET8Mb7PUTzk
 8CT/1N2ThloWqQmQynKGkKgNFDjj+jeFp3FlUcwq1ox733eNLhpPJ/YDDJngdJh+pweH
 Q07IEZ1daBctrMYQPKrkccYn8MDfa1TwUG22OBMiCC8o65B6AqoG6V5wgYmrIm/vxJ66
 aOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234537; x=1788839337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HOjRzfQpe3kE34Y2l5KyKrR2biv2SpLqm7CIXewxRtU=;
 b=cchsepQ/8DpQDYZwp9QPhGvz+ECyVmypwOk4UoFZd17QEHikVdQ5u2uOuY4cXy4Vgv
 ojEGxHDaVhEddpoL0XC1K54/C/0rpii0bxE53rjS/ZNpH4fLG50y6GUwOUuP903AbEzt
 9ZPoA6t9KYLNqO2eOvI8OTDE6/I8kt/SUnhaR2SHc0IdCdwVURJkWBhfaP9HDJvNCtEO
 /o1bHdCK8HnQ5LgQTyvkmFi0vaDfI4Ea9WKJMEJ0Mp6Jt2trpZxr6BeARBDyd1o2WtUw
 9wNuo/LP8A+7qgBGSOMSuO+KZJ6dXm+ga/hHcr3kDTbYnkTDDG2CgpiUsJV/Oii3k6Tr
 ga9w==
X-Gm-Message-State: AFuF++lWc9H5AJ0kKW5yPSFDYoc3TatB55FL9zTlCDTgfmD9jl8FUMf/
 8H6YhYPOazhR+V1flM3IvC3c/4yUo4xfrsL/MONGHp13eInyBV0wM1o3Lo+Ogg==
X-Gm-Gg: AYBFou2CWdcSely8u4O7I/vDmy+Su/ThhCTE43LDPAE5RJVjh86f6SqHVbtYayB2VSh
 IJ1ya/3bNg3gHBc7i3KhvGnAniXxpNHlTB+Ys1C4gucYaAuqhhgmmuEDfGKGGNhZ2y93fr4JqLq
 iNSSNvmpP8j0XpW2lzRJdd5jUbgO2JtH9WOqG+jHVyYP90YZb82zI19OGBguIFeJ/lWRYpURmdf
 8I8P02GiUY79Z4PybPrsU1pS69jJS6+6F4QvUqfUYdbiiyMGgLQUxa3jXeROvc4FMYR3Y28TZRj
 99w1sBQVvVIl7ZJbYTW5YI8B31pTaEiMu+/GYtVjsuyBZZVQsI3gW++B3cOFV2bbIV2NXy8uR1A
 5g+y0Js7GwDA7r3/5xWfvvWRZkGdvzNk4a0WgeZ2rF6vLdLl3FuC0rT0FyGqL03dXHqIup0/Fzo
 h4M/F9DQJKyQ5ZTKE/s1FPxqq4xlWUbq35YfAJrvX6Cg5x0/tAb6IsrSrQsrxhs2Se7FFZMo9cZ
 Qpv2FumenRWMCCQ+zuajtCkRvLiuPJPq7XMN2XG
X-Received: by 2002:a05:690c:386:b0:855:2d6d:2db5 with SMTP id
 00721157ae682-85d69e03e9cmr118514477b3.12.1788234531581; 
 Mon, 31 Aug 2026 20:48:51 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e66f9a5d8sm66385787b3.41.2026.08.31.20.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:49 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 4/9] tcg: add tcg_gen_goto_jc_{i32,i64,tl}()
Date: Mon, 31 Aug 2026 23:48:03 -0400
Message-ID: <20260901034808.3524945-5-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
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

tcg_gen_lookup_and_goto_ptr() takes no arguments and emits a call to
helper_lookup_tb_ptr(), which recovers the destination PC from env by
calling back into the target through TCGCPUOps::get_tb_cpu_state(). At
translation time the caller often already has the destination PC in a temp,
and knows the flags, cflags and cs_base any destination it may reach has to
match, because they are the ones the block being generated was translated
with. A later patch uses that to look the destination up inline.

But it is not something every caller of tcg_gen_lookup_and_goto_ptr() can
promise, and the promise is subtle. target/arm has

        case DISAS_UPDATE_NOCHAIN:
            gen_update_pc(dc, curr_insn_len(dc));
            /* fall through */
        case DISAS_JUMP:
            gen_goto_ptr();
            break;

where DISAS_JUMP could make the promise and DISAS_UPDATE_NOCHAIN could not,
because it is there precisely because the state changed. Two call sites,
one line apart, on opposite sides of the contract.

So add a second entry point rather than growing an argument on the first.
tcg_gen_lookup_and_goto_ptr() keeps today's meaning and today's signature:
dispatch, and let the helper work out where. tcg_gen_goto_jc_*() means
dispatch to the destination that env already describes, and takes the pc as
proof that the caller knows which one that is. Targets migrate one call
site at a time, and a call site that cannot promise simply does not move.

The contract is:

  - @pc holds exactly what get_tb_cpu_state() reports as the destination pc.
  - The flags and cs_base it reports are the ones this block was translated
    with, which is what lets them be constants in the generated code.

--enable-debug-tcg checks all three against get_tb_cpu_state() at run time,
via a new helper_goto_jc_check(). That turns a mistake into an assertion at
the offending call site instead of a block that runs with someone else's
flags.

Five targets have a call site whose pc temp is that key by construction, and
are migrated here: alpha, loongarch, mips, ppc and s390x. Nothing else
changes; the generated code does not change either, since goto_jc still
emits the same helper call for now.

For six targets the TB pc is derived and passing the pc temp would be wrong:
avr's TB pc is the word address doubled, i386's is eip before segmentation,
riscv masks it to 32 bits when xl is MXL_RV32, hppa derives it from the IAQ,
hexagon adjusts it inside a hardware loop, and sparc puts npc in cs_base.
The remaining seven -- arm, m68k, microblaze, or1k, rx, sh4 and tricore --
have call sites that look like they could move, but I have not convinced
myself of the contract for them and have nothing to test them with. Each is
a one-line change for whoever wants it, and debug-tcg will say if it is
wrong.

The i32 and i64 forms are separate functions, with a _tl alias in tcg-op.h,
as for most everything else. A translator built for more than one value of
TARGET_LONG_BITS cannot include tcg-op.h and calls the sized form directly,
which is what s390x does here.

Neither form takes the TranslationBlock: tcg_ctx->gen_tb is the block being
generated, the same one tcg_gen_goto_tb() and tcg_gen_lookup_and_goto_ptr()
already read, so there is no way for a caller to pass the wrong one.

v4: Split out of "tcg: probe the TB jump cache inline instead of calling a
    helper", which did the API change and the inline probe in one patch.
    Requested by Richard Henderson.

v5: Add a new interface rather than growing an argument on
    tcg_gen_lookup_and_goto_ptr(), and check the contract under
    --enable-debug-tcg. Requested by Richard Henderson, who named it
    tcg_gen_goto_jc_*(); the DISAS_UPDATE_NOCHAIN example above is his.

v5: Define _i32 and _i64 entry points with a _tl alias in tcg-op.h, rather
    than one entry point taking a TCGTemp. Requested by Richard Henderson:
    as targets migrate to single-binary, code is built once and stops
    relying on TARGET_LONG_BITS, so the TCGTemp split was the wrong shape.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec.c                          | 27 +++++++++
 accel/tcg/tcg-runtime.h                       |  4 ++
 include/tcg/tcg-op-common.h                   | 20 +++++++
 include/tcg/tcg-op.h                          |  2 +
 target/alpha/translate.c                      |  4 +-
 .../tcg/insn_trans/trans_branch.c.inc         |  2 +-
 target/loongarch/tcg/translate.c              |  4 +-
 target/mips/tcg/nanomips_translate.c.inc      |  2 +-
 target/mips/tcg/translate.c                   |  6 +-
 target/ppc/translate.c                        |  4 +-
 target/s390x/tcg/translate.c                  |  4 +-
 tcg/tcg-op.c                                  | 59 +++++++++++++++++--
 12 files changed, 119 insertions(+), 19 deletions(-)

diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index 148e0f583e..ca90a77a7b 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -407,6 +407,33 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     return tb->tc.ptr;
 }
 
+#ifdef CONFIG_DEBUG_TCG
+/**
+ * helper_goto_jc_check: check the contract of tcg_gen_goto_jc_*()
+ * @env: current cpu state
+ * @pc: the destination pc the caller passed at translation time
+ * @flags: the flags the dispatching block was translated with
+ * @cs_base: the cs_base the dispatching block was translated with
+ *
+ * A goto_jc looks the destination up on the caller's @pc with the flags and
+ * cs_base of the block doing the dispatching, so all three have to be what
+ * get_tb_cpu_state() reports by the time the dispatch runs.  That is a
+ * property of the translator, not of the generated code, so check it here
+ * rather than leaving a target that gets it wrong to be debugged as a block
+ * running with someone else's flags.
+ */
+void HELPER(goto_jc_check)(CPUArchState *env, uint64_t pc, uint64_t flags,
+                           uint64_t cs_base)
+{
+    CPUState *cpu = env_cpu(env);
+    TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
+
+    assert(s.pc == pc);
+    assert(s.flags == flags);
+    assert(s.cs_base == cs_base);
+}
+#endif
+
 /* Return the current PC from CPU, which may be cached in TB. */
 static vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
diff --git ./accel/tcg/tcg-runtime.h ./accel/tcg/tcg-runtime.h
index 0b832176b3..ec99170698 100644
--- ./accel/tcg/tcg-runtime.h
+++ ./accel/tcg/tcg-runtime.h
@@ -22,6 +22,10 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
+#ifdef CONFIG_DEBUG_TCG
+DEF_HELPER_FLAGS_4(goto_jc_check, TCG_CALL_NO_WG_SE, void, env, i64, i64, i64)
+#endif
+
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
 #ifndef IN_HELPER_PROTO
diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
index 9b321f959c..4f334faaaa 100644
--- ./include/tcg/tcg-op-common.h
+++ ./include/tcg/tcg-op-common.h
@@ -85,6 +85,26 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
+/**
+ * tcg_gen_goto_jc_i32() - dispatch to the destination TB via the jump cache
+ * tcg_gen_goto_jc_i64() - dispatch to the destination TB via the jump cache
+ * @pc: temp holding the destination guest PC
+ *
+ * As tcg_gen_lookup_and_goto_ptr(), but the caller states where the
+ * dispatch is going, which allows the lookup to be done inline.
+ *
+ * The contract is that when this runs, the CPU state must already be
+ * exactly the destination's: @pc must hold what get_tb_cpu_state() would
+ * report as the destination pc, and the flags and cs_base it would report
+ * must be the ones the block being generated was translated with.  A
+ * translator that has not finished updating the state, or whose pc is
+ * derived rather than being the lookup key -- avr's word address, i386's
+ * eip before segmentation -- must use tcg_gen_lookup_and_goto_ptr()
+ * instead.  --enable-debug-tcg checks the contract at runtime.
+ */
+void tcg_gen_goto_jc_i32(TCGv_i32 pc);
+void tcg_gen_goto_jc_i64(TCGv_i64 pc);
+
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
diff --git ./include/tcg/tcg-op.h ./include/tcg/tcg-op.h
index 3721164236..cd4794d745 100644
--- ./include/tcg/tcg-op.h
+++ ./include/tcg/tcg-op.h
@@ -38,6 +38,7 @@ typedef TCGv_i32 TCGv;
 #define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
+#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i32
 #elif TARGET_LONG_BITS == 64
 typedef TCGv_i64 TCGv;
 #define tcg_temp_new() tcg_temp_new_i64()
@@ -45,6 +46,7 @@ typedef TCGv_i64 TCGv;
 #define tcgv_tl_temp tcgv_i64_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
+#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i64
 #else
 #error Unhandled TARGET_LONG_BITS value
 #endif
diff --git ./target/alpha/translate.c ./target/alpha/translate.c
index c66e3f9c14..8318487cd8 100644
--- ./target/alpha/translate.c
+++ ./target/alpha/translate.c
@@ -449,7 +449,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_pc);
     }
 }
 
@@ -2917,7 +2917,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_pc_disp(ctx, cpu_pc, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_pc);
         break;
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
diff --git ./target/loongarch/tcg/insn_trans/trans_branch.c.inc ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
index da07778658..d4318dfa43 100644
--- ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -27,7 +27,7 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
     tcg_gen_mov_tl(cpu_pc, addr);
     tcg_gen_movi_tl(dest, make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_set_gpr(a->rd, dest, EXT_NONE);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_goto_jc_tl(cpu_pc);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
diff --git ./target/loongarch/tcg/translate.c ./target/loongarch/tcg/translate.c
index 124dce6269..6ac0c3773a 100644
--- ./target/loongarch/tcg/translate.c
+++ ./target/loongarch/tcg/translate.c
@@ -111,7 +111,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_pc);
     }
 }
 
@@ -311,7 +311,7 @@ static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_pc);
         break;
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
diff --git ./target/mips/tcg/nanomips_translate.c.inc ./target/mips/tcg/nanomips_translate.c.inc
index 4b0b01ba37..106f49990d 100644
--- ./target/mips/tcg/nanomips_translate.c.inc
+++ ./target/mips/tcg/nanomips_translate.c.inc
@@ -2406,7 +2406,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
 
     /* unconditional branch to register */
     tcg_gen_mov_tl(cpu_PC, btarget);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_goto_jc_tl(cpu_PC);
 }
 
 /* nanoMIPS Branches */
diff --git ./target/mips/tcg/translate.c ./target/mips/tcg/translate.c
index e3467d1525..dea1ba4c1e 100644
--- ./target/mips/tcg/translate.c
+++ ./target/mips/tcg/translate.c
@@ -4374,7 +4374,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_save_pc(dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_PC);
     }
 }
 
@@ -11014,7 +11014,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             } else {
                 tcg_gen_mov_tl(cpu_PC, btarget);
             }
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_goto_jc_tl(cpu_PC);
             break;
         default:
             LOG_DISAS("unknown branch 0x%x\n", proc_hflags);
@@ -15244,7 +15244,7 @@ static void mips_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         gen_save_pc(ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_PC);
         break;
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
diff --git ./target/ppc/translate.c ./target/ppc/translate.c
index 06ed2adf10..21e21102fc 100644
--- ./target/ppc/translate.c
+++ ./target/ppc/translate.c
@@ -3664,7 +3664,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_nip);
     }
 }
 
@@ -6690,7 +6690,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_nip);
         break;
 
     case DISAS_EXIT_UPDATE:
diff --git ./target/s390x/tcg/translate.c ./target/s390x/tcg/translate.c
index 1b6023168b..906951c7df 100644
--- ./target/s390x/tcg/translate.c
+++ ./target/s390x/tcg/translate.c
@@ -1162,7 +1162,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         tcg_gen_goto_tb(0);
         tcg_gen_exit_tb(s->base.tb, 0);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_i64(psw_addr);
     }
 
     gen_set_label(lab);
@@ -6477,7 +6477,7 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (dc->exit_to_mainloop) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_goto_jc_i64(psw_addr);
         }
         break;
     default:
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index 28d3b2a847..a2f35359fe 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2715,18 +2715,65 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
+static void gen_lookup_tb_ptr_and_goto(void)
+{
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+    tcg_temp_free_ptr(ptr);
+}
+
 void tcg_gen_lookup_and_goto_ptr(void)
 {
-    TCGv_ptr ptr;
-
     if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
         tcg_gen_exit_tb(NULL, 0);
         return;
     }
 
     plugin_gen_disable_mem_helpers();
-    ptr = tcg_temp_ebb_new_ptr();
-    gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-    tcg_temp_free_ptr(ptr);
+    gen_lookup_tb_ptr_and_goto();
+}
+
+/*
+ * The common half of tcg_gen_goto_jc_i32() and tcg_gen_goto_jc_i64().  @pc
+ * is widened to i64 because the jump cache is keyed on a vaddr; for a
+ * 32-bit guest PC that is its zero extension.
+ */
+static void gen_goto_jc(TCGv_i64 pc)
+{
+    const TranslationBlock *tb = tcg_ctx->gen_tb;
+
+    if (tb->cflags & CF_NO_GOTO_PTR) {
+        tcg_gen_exit_tb(NULL, 0);
+        return;
+    }
+
+    plugin_gen_disable_mem_helpers();
+
+#ifdef CONFIG_DEBUG_TCG
+    /*
+     * The caller has asserted that env already describes the destination.
+     * Check it, rather than leaving a target that gets it wrong to be
+     * debugged as a block that runs with someone else's flags.
+     */
+    gen_helper_goto_jc_check(tcg_env, pc, tcg_constant_i64(tb->flags),
+                             tcg_constant_i64(tb->cs_base));
+#endif
+
+    gen_lookup_tb_ptr_and_goto();
+}
+
+void tcg_gen_goto_jc_i64(TCGv_i64 pc)
+{
+    gen_goto_jc(pc);
+}
+
+void tcg_gen_goto_jc_i32(TCGv_i32 pc)
+{
+    TCGv_i64 pc64 = tcg_temp_ebb_new_i64();
+
+    tcg_gen_extu_i32_i64(pc64, pc);
+    gen_goto_jc(pc64);
+    tcg_temp_free_i64(pc64);
 }
-- 
2.54.0


