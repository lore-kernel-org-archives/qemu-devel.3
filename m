Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42D9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR2-0000jz-TI; Tue, 25 Aug 2026 10:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2z-0002xM-FL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:41 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2x-0002CS-7S
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:41 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-39da69c5ba3so45438561fa.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667757; x=1788272557; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lkUluNV2oBOZMWT8utcTpItrALuOagR0psQYHiKAqsY=;
 b=PtzY+o0IC4CoL2jwO8I1kx2R8s0CKkveAntpBsmKIHAz/TZZZ+PR+C461h+uZPMECl
 AdE04g9wehlsKh7jbsKCibcg22LciYegyXfuVwUI/IYF7Bw3mfnRhbFn3L14Tjh3AU/Q
 1Hzud+WgeufpUtqMqCctTkeKgSWVzS0XCCU+Ob1fX+Xa36xHQdWV+A6L3K/s1XdeaSKi
 Mi1a1WOmBG5Mhy6qwr++lmmUTrCc2Qs/66D8B1u9RfrtTbpa+OGFIXeAS9sGDEi694EG
 +cVFp7DjKIOkfuoZL4R+9XIRflF7Qj8r5k1QPEuTKUHR4PWPevYKzAXKM6ClmM83tlkP
 GAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667757; x=1788272557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lkUluNV2oBOZMWT8utcTpItrALuOagR0psQYHiKAqsY=;
 b=HKC5pz95Z+1oLRbPiB2iFj/DPnqfb3S6BX+ZCpzYztxOVXFM8tnYDMh44OWnfzYCJD
 QGz0exxCDgqmMxxxGveGdFvxxuu4PRzFBHaWh1cxZSY2Xzs9iYmUJSzOqhPe0rYB/hLo
 CI8Ttwy/pSutPSFU/j1bi7vZXc2Ns+pWVFMkufDbH+YMgNCR80hmu3jc0QV4tEbZOdnJ
 7cDgFaCOg0EeBHUADjJ5MTMj6B0YjMo8VKSwEbTSqvRqVuAcLD1Nx+cYh2IEr17eFUVd
 AVXkLIYUtRAiEW7QbmwGvZdDLd4cVCuyQNJkrP5sxcE1t+8T+f1ryiEvP4TAh0VniYNY
 FfEw==
X-Gm-Message-State: AFuF++lueYNvUsGYgZziQMwCYT3RHUBVXvO5WLcwo/2J7A9OxlXtHWeF
 axxFIRs3jsI8jyUCWCNkcoRNxD6JJ50GLqihsCkfZO0ltsxhMHTUGb0k
X-Gm-Gg: AR+sD10zjtOayIcr+cqfFpGA2j8+VrgakjlrBHAIbxtja2lKEcBcQQuhN0WLwylhS6F
 RJOtggYjlidR05q23mo7e2BFhh3I8m9yeCTCyjHvQz/qeHHDMLoCMps4bRAXj7PnLz71gCSLBpV
 q1CXNSFsQ0axwnbyS5iZ/X+NvV50jxgb0OVtLfXvbQu+WbhLfncz2A93IeTFCLJ72A64oLSvjCI
 1QkLvUuTSRAzIviwRJjOZXKokMYSi95RFzlnNyqH3ueuhY1tMLOncnemd3LdOA9lYqLMyLN80NT
 /+f9L0gs4dNtW3rXQAnLUxS/f7xRU1xQIV+nyFnIYbsq0gwfdh3WctKG4WexfDxM/ZkuFshPdhW
 q1ZxTMIUao0O0TOolW7eErzVv1+N40eGt9JsYj+yxF4HeYN4WH3GYC/ST34n9RQ6Sqjp1cnlik6
 GIvcGJr9utekhzJzLUQ/aBf28q0rDX2g1tiwTDdTFoIuyO83K0W6hmzUWSmvfK2B+0a5vOE0iLO
 cL0N/l5eEm8gLj+m3jMD9K8Jz7eag==
X-Received: by 2002:a05:651c:15c2:10b0:39d:4014:12cb with SMTP id
 38308e7fff4ca-3a1ef4de3b7mr11342811fa.2.1787667757282; 
 Tue, 25 Aug 2026 07:22:37 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:35 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:29 +0300
Subject: [PATCH 05/13] hw/riscv/trace_encoder, target/riscv: add trace pc
 history logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-5-f8be2f40d2fd@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11565;
 i=antikostya2@gmail.com; h=from:subject:message-id;
 bh=tQPLREI/53AKXjUoF3cKDwmMM7hAtSQIl8EUVojg+Jo=;
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjFxjzaJLBJaYaNbovMEMxElezljNd2yLI1
 bSeFJjUNyyJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 dj1rD/9ourygV59DQfmyA32svfEgkshSVk+a7yG/6i4MReiG4MbWIHx6K3qP3fCBwH0oW3Hpw0A
 RXb5DrCtWlpnRCkmH6EQ6H63fd7MjpAFO7hi5rKa159T9Wt6RIEn+vnsWqS+E0zWyUZywcASYHX
 WUjKAp+OwZM+F6e6XeGwnVmUG9D2q+2CXKHDb6hg6R78gSwyIRSlGC3Lg/chayEz3mIYtzYOUj6
 7K49ELh8tSjOqU5434NmYNx3PZp8qtuTZW1FdKD9O1MXyJ3RjPcBBZ0bOmeVqgih2AMYgVM83n3
 MQk43kcRn9Y34E1TVPsDS4+zLxGnXaY2rWIXmym9NIcD3mdyPXHe8ZV/p+lhfOLvS+N4rtJSvPw
 eKhxKD05VeLfh7iddinMURoEvGhmXwBfjCCrdRgkJ4O48g9sTczA6+FQN0bDyEdrgWAnnGaXAYe
 6fbxy0GtNaPDTbnySzZM/N4oPoS8PUgiI/DcEFPKCmwhqVf7naCL6rh7MWh6jJx6Ex4fZv5wQ2c
 vhjfT+E6i2xnAct7wCwLcTw1t5dsOlD/zwaiHRvGXddZh+aYnowl0TJwehfAUGDDfM32tKBM9w+
 uALyHfaeI3s+8TZGaS1XBcWp58x6klI19Raf+mss8w/B2kbJR43Py+bwJfSqSiJF3wPZSpx7NF6
 V7fblEevsRG+NzA==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

Add new fields to TraceEncoder struct, to be used when sending messages,
that will be added in following commits:

 - last_addr_reported:
   a few N-Trace messages have field U-ADDR, that
   represents diff from last reported full pc address (F-ADDR field).
   This field tracks last reported full pc address (F-ADDR N-Trace field).

 - last_icnt_reset, icnt_accumulated:
   N-Trace requires to send I-CNT field in many messages,
   and this field represents number of retired instructions
   from last reported pc.
   We will track each executed branch and calculate pc-diff between
   previous branch to track I-CNT value.
   But there could be multiple branches before I-CNT report, so we will
   accumulate each pc-diff between consecutive branches in
   `icnt_accumulated` field.
   This pc-diff will be calculated as:
   `pc_before_branch + current_insn_len - last_icnt_reset`
   and we will update `last_icnt_reset` to `pc_after_branch`

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/trace-encoder.c                       | 19 +++++++++++++++++--
 hw/riscv/trace-encoder.h                       | 14 +++++++++++++-
 target/riscv/helper.h                          |  4 ++--
 target/riscv/insn_trans/trans_privileged.c.inc | 10 +++++-----
 target/riscv/insn_trans/trans_rvi.c.inc        | 15 +++------------
 target/riscv/trace_helper.c                    | 14 +++++++++-----
 target/riscv/translate.c                       | 19 +++++++++++++++++--
 7 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 703454c9b7..46501e4f03 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -262,6 +262,8 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
              * using te->trace_next_insn
              */
             trencoder_send_prog_trace_sync(OBJECT(te), env->pc);
+            te->last_icnt_reset = env->pc;
+            te->icnt_accumulated = 0;
         } else {
             te->trace_next_insn = true;
         }
@@ -543,6 +545,7 @@ void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
 
     g_assert(trencoder->ntrace);
 
+    trencoder->last_addr_reported = pc;
     msg_size = rv_ntrace_gen_encoded_prog_trace_sync_msg(msg, faddr);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
@@ -593,16 +596,28 @@ static void trencoder_send_branch_map(Object *trencoder_obj)
     trencoder_send_message_smem(te, msg, msg_size);
 }
 
-void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken)
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
+                             uint64_t insn_len, uint64_t offset,
+                             TraceBranchRes taken)
 {
     TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
 
+    if (te->ntrace && taken != BRANCH_NOT_TAKEN) {
+            te->icnt_accumulated += (pc + insn_len - te->last_icnt_reset) / 2;
+            te->last_icnt_reset = pc + offset;
+    }
+
+    if (taken == BRANCH_TAKEN_UNCONDITIONAL) {
+        /* do not update branch map if branch is unconditional */
+        return;
+    }
+
     /*
      * Note: the e-trace spec determines the value '1' for a
      * branch *not* taken. The helper API is using taken = 1
      * to be more intuitive when reading TCG code.
      */
-    if (!taken) {
+    if (taken == BRANCH_NOT_TAKEN) {
         te->branch_map = deposit32(te->branch_map, te->branches, 1, 1);
     }
 
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 96324d2b9a..6551ac77f9 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -46,8 +46,18 @@ struct TraceEncoder {
     bool trace_next_insn;
 
     bool ntrace;
+    uint64_t last_addr_reported;
+    uint64_t last_icnt_reset;
+    uint64_t icnt_accumulated;
 };
 
+typedef enum {
+    BRANCH_NOT_TAKEN           = 0,
+    BRANCH_TAKEN_CONDITIONAL   = 1,
+    BRANCH_TAKEN_UNCONDITIONAL = 2,
+} TraceBranchRes;
+
+
 #define TYPE_TRACE_ENCODER "trace-encoder"
 
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
@@ -60,6 +70,8 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 void trencoder_report_updiscon(Object *trencoder_obj);
-void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken);
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
+                             uint64_t insn_len, uint64_t offset,
+                             TraceBranchRes taken);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b1de064e17..dcf2b74cb6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,8 +131,8 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
-DEF_HELPER_1(trace_updiscon, void, env)
-DEF_HELPER_3(trace_branch, void, env, tl, int)
+DEF_HELPER_3(trace_updiscon, void, env, tl, tl)
+DEF_HELPER_5(trace_branch, void, env, tl, tl, tl, int)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 28089539d5..a3777b42e9 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -26,7 +26,7 @@
 
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
-    gen_trace_updiscon();
+    gen_trace_updiscon(ctx);
 
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
@@ -42,7 +42,7 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     uint32_t ebreak = 0;
     uint32_t post   = 0;
 
-    gen_trace_updiscon();
+    gen_trace_updiscon(ctx);
 
     /*
      * The RISC-V semihosting spec specifies the following
@@ -99,7 +99,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
-        gen_trace_updiscon();
+        gen_trace_updiscon(ctx);
 
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
@@ -119,7 +119,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
-    gen_trace_updiscon();
+    gen_trace_updiscon(ctx);
 
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
@@ -138,7 +138,7 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 #ifndef CONFIG_USER_ONLY
     REQUIRE_SMRNMI(ctx);
 
-    gen_trace_updiscon();
+    gen_trace_updiscon(ctx);
 
     decode_save_opc(ctx, 0);
     gen_helper_mnret(cpu_pc, tcg_env);
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ee29adbdeb..06fba108a8 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -183,7 +183,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
-    gen_trace_updiscon();
+    gen_trace_updiscon(ctx);
 
     lookup_and_goto_ptr(ctx);
 
@@ -268,15 +268,6 @@ static void gen_setcond_i128(TCGv rl, TCGv rh,
     tcg_gen_movi_tl(rh, 0);
 }
 
-static void gen_trace_branch(int taken)
-{
-    TCGLabel *skip = gen_new_label();
-
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
-    gen_helper_trace_branch(tcg_env, cpu_pc, tcg_constant_i32(taken));
-    gen_set_label(skip);
-}
-
 static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 {
     TCGLabel *l = gen_new_label();
@@ -308,14 +299,14 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     }
 #endif
 
-    gen_trace_branch(0);
+    gen_trace_branch(0, 0, 0);
 
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
     gen_set_label(l); /* branch taken */
 
-    gen_trace_branch(1);
+    gen_trace_branch(1, a->imm, ctx->cur_insn_len);
 
     if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
                                     ctx->priv_ver,
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index 9b43aeac09..f6201e2fb9 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -29,7 +29,8 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
     }
 }
 
-void helper_trace_updiscon(CPURISCVState *env)
+void helper_trace_updiscon(CPURISCVState *env, target_ulong curr_pc,
+                           target_ulong curr_inst_len)
 {
     RISCVCPU *cpu = env_archcpu(env);
     TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
@@ -42,11 +43,12 @@ void helper_trace_updiscon(CPURISCVState *env)
     }
 }
 
-void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+void helper_trace_branch(CPURISCVState *env, target_ulong pc,
+                         target_ulong insn_len, target_ulong offset, int taken)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
-    trencoder_report_branch(cpu->trencoder, pc, taken);
+    trencoder_report_branch(cpu->trencoder, pc, insn_len, offset, taken);
 }
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
@@ -54,12 +56,14 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
     return;
 }
 
-void helper_trace_updiscon(CPURISCVState *env)
+void helper_trace_updiscon(CPURISCVState *env, target_ulong pc,
+                           target_ulong curr_inst_len)
 {
     return;
 }
 
-void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+void helper_trace_branch(CPURISCVState *env, target_ulong pc,
+                         target_ulong insn_len, target_ulong offset, int taken)
 {
     return;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 26c7678cb9..781068ad84 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -617,12 +617,25 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
 }
 #endif
 
-static void gen_trace_updiscon(void)
+static void gen_trace_updiscon(DisasContext *ctx)
 {
     TCGLabel *skip = gen_new_label();
+    TCGv curr_pc = tcg_constant_tl(ctx->base.pc_next);
+    TCGv curr_inst_len = tcg_constant_tl(ctx->cur_insn_len);
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
-    gen_helper_trace_updiscon(tcg_env);
+    gen_helper_trace_updiscon(tcg_env, curr_pc, curr_inst_len);
+    gen_set_label(skip);
+}
+
+static void gen_trace_branch(int taken, target_ulong imm, target_ulong cur_insn_len)
+{
+    TCGLabel *skip = gen_new_label();
+    TCGv offset = tcg_constant_tl(imm);
+    TCGv insn_len = tcg_constant_tl(cur_insn_len);
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_branch(tcg_env, cpu_pc, insn_len, offset, tcg_constant_i32(taken));
     gen_set_label(skip);
 }
 
@@ -647,6 +660,8 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
         gen_ctr_jal(ctx, rd, imm);
     }
 #endif
+    const int BRANCH_TAKEN_UNCONDITIONAL = 2;
+    gen_trace_branch(BRANCH_TAKEN_UNCONDITIONAL, imm, ctx->cur_insn_len);
 
     gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
     gen_set_gpr(ctx, rd, succ_pc);

-- 
2.43.0


