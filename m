Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75936CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBN6-0004mT-Ev; Fri, 09 Oct 2026 10:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBH6-0003Ur-10
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:47 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBH1-0007zt-US
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:39 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5bcbb82dbadso4059326e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791554914; x=1792159714; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmasiWDHokpTxAYFq7EtqMBhrRWY6Yp/YR8Vpb+J6Mk=;
 b=k04bB1bJ4hjnqbCwzWCROpeCBco3QhH1ikeDRhsf5mzJrgxi1RUfz+EdzPKExn9IV8
 9RMY/1N5nGM406TZ5eiC23iiCpuhwEsX2u0olePZFSsJQmFRwWpt4wgDaLR3NN5iKjLe
 3AKK3/oN0pENS8M2MiEjLV/AYj7lBAczy/uL38ntNYoXbrOwkCa5Jn7wXzuyghGTTKJr
 xntc9St+TvMjPmVGQloK3UNgc7eHrc7ci6bWCt4l1DNkEesSkj3vf7ynucCiIom2rclK
 gYfnOACPSJyIQKyH4Dnby7tHP403dFx1n0Uctw4yjIV4lbuJ8WAqRWbwLCp20rnNNBYL
 txCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791554914; x=1792159714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YmasiWDHokpTxAYFq7EtqMBhrRWY6Yp/YR8Vpb+J6Mk=;
 b=jk3MqgwFW4QOe2E5GKrBU3qBOxrPwvGNl82c/cpWn7QdBosJFEIqv+CqPgrmHE9nxv
 LB3GXQfjIjfkhIiUjbeaedSFTW02e96Oo330Zf3K17qB31UC1NbnyyjwbwX+dM8SKZNh
 euHhExh8esPSoCFWLjjj4zL1OaS4W17YcSHuEFeWmLNdIJru12Jgi95gTi8jw8cHRpDg
 YCvZA0ONhZfWzN4R7d2W4+t1qORGEX1IF1Nha3Sedlp2dr5XftQ4n12bh2Om+P9FNtzt
 RyFiPwJ1Yzd/0BEthoRAzkOEYvp7QGqybaRpuNR2r2XzSi/+lo+jCjS4YeDmOqmv7Wjs
 NPUA==
X-Gm-Message-State: AFq9FYIewE2JksmAp83/+spKjgIDdWjmh8wbVQlxM1WWrC7HliJaD+PH
 OXFN4xH4MYNn6+wntAM2cnbeH/3ROmGOEUcNlMx+GLSV75sYRqgrXRfzxX202NDQgoA=
X-Gm-Gg: AYBFou0nAQKLBnqowosfzZMYIzSoRIUS32XR0t5631WWgLxruQf+AXkhpbAywGQSL38
 2+41fuMW5Ygn4Qc1PWYgxm8NpnyBed3y7Xi/x3rM5hxWnywcodrvyqcCkHJ0E622iVJqNP8b+VG
 /2UqaAGGj8BA+oNlQ+3oskIRGbs+DFLXGKOsr3Y/m/mMQUciSQc2TW+iQGfNNBGh9ZUv10P6ocx
 fbidr5XlW4zrngZ63huJAb2GM6KZxc7gRhI4vCxZw5KwjZdJtaKCUdjk87VBTy1KHu0I0tvNuN7
 IlslMjVIQKe6a+kQqBwYz0X1bWCQ7tXfGA8tCaEl4pMdAkbvL8npvzu9UzPPZ31ONqmEVGhHvST
 iZAJjTvRjDifN974nKFOgMTPu9uPJ5jmVLtFje1J/ZxHcRdwlKEbIxEQCwnqMwgBWWwAfcOSanr
 5UuZcezgi2FeiX2iM5bbPHnRVfn8cTw1TDzzCbLOvhp/L3MO+j0BLW3KLqo6AHXR3qo/Z/XaIZm
 BdjadOGXjIqf7/45KmvjSrXDOLicdmOxj2NEdnxdSJn/ffn
X-Received: by 2002:a05:6512:110e:b0:5bc:c447:abe with SMTP id
 2adb3069b0e04-5bcde6c9f20mr874796e87.25.1791554913999; 
 Fri, 09 Oct 2026 07:08:33 -0700 (PDT)
Received: from localhost (broadband-5-228-114-10.ip.moscow.rt.ru.
 [5.228.114.10]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddeced0bsm658820e87.83.2026.10.09.07.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:08:33 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 09 Oct 2026 17:03:06 +0300
Subject: [PATCH 5/6] hw/riscv, target/riscv: support initial N-trace filtering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-upstream-ntrace_filter-v1-5-8f061c9b24da@gmail.com>
References: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
In-Reply-To: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Alexei Filippov <halip0503@gmail.com>, 
 Grigoriy Bereznyakov <gregoriy93.gb@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16951;
 i=antikostya2@gmail.com; h=from:subject:message-id;
 bh=XewiYyTAUTfzV7L6+/1sQn06Jf6ZmUCGa/wbBHMzzcY=;
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqyPQWgECmCeD5obJ+y6YwTP4T+9iIw4oIHPGhh
 FgJYAhpS1SJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCasj0FgAKCRBIiqVupVDe
 dqhgD/9fVYs/Luo+T2t9fUIjtewjzakvBmsDqk3OZL/Qzu9d2Y0KJ8Fn0mVr65RmzfStbqjPLpM
 jXekqPZZcVNaLQ4GBLM+bJ4SVBpDZcO5HvzcUS8FuRNvOj+oIsF7MVKvYJXfyjwNlM7F7S43SUD
 pC8r7tFFWgDWc4gnLqBHJi2R2FPTBHPpVovMguojCmg/gYAwgzKz/VEkwwFxNsgx97Gl1DmoU48
 6Zi9WWY7xENDsAXgvtFklIWjdTx+RkFbli+NqqUC8Fdi2tZkKoTqdrq/Mw3j8CoNL+I05Sx4Q/g
 8FPb17uJupsYhlylg2PiCsnm+701mvxUlRVzLdnZT3kY2OHFRDx8UT+aa9v/AeKr3A/pOf6AAtE
 QAG6rMz0tKon6ozJOZOnw9OzpFDYOgfyJCvgB+udCLbvNqgS5DEVPfGBewj/TE5mLLffN+mhoNy
 1gmaC2EWrs/K2fZcGMKINUYzaQHx51UnxNGPT1ia8Ehs+aR/z5vdiyWZ4F9M9JJIlE+gD+GTyOl
 Tlyh28J9U/gv4em+2IUcb2uQSiDZMj1th5CqvDefexdL6FQyvB4lDa+8g5h+Qw93czkNV8w7UKD
 NRsCO6KN/EHeFdVEOi2mmI3lD0MSH5AP+tLU1lS1Oce7jea/r7DKh6UOEjVnY4ONVeUbirFI1ao
 +1J5PWMCUmY5+WA==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x131.google.com
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

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
Signed-off-by: Bereznyakov Grigoriy <gregoriy93.gb@gmail.com>
---
 hw/riscv/trace-encoder.c    | 209 +++++++++++++++++++++++++++++++++++++++++---
 hw/riscv/trace-encoder.h    |   7 +-
 target/riscv/cpu_helper.c   |   8 +-
 target/riscv/op_helper.c    |   6 +-
 target/riscv/trace_helper.c |  11 ++-
 5 files changed, 222 insertions(+), 19 deletions(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index e3286400b0..e42c92d03a 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -416,9 +416,13 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
         te->trace_next_insn = false;
 
         if (te->ntrace) {
-            uint32_t inst_len = get_inst_len_at(env->pc);
-            trencoder_send_prog_trace_correlation(OBJECT(te), env->pc, inst_len,
-                                                  CORRELATION_TRACE_DISABLED);
+            if (trencoder_filters_match(te, INSTRUCTION_FILTERING,
+                                        env->pc, env->pc)) {
+                uint32_t inst_len = get_inst_len_at(env->pc);
+                trencoder_send_prog_trace_correlation(OBJECT(te), env->pc,
+                                                      inst_len,
+                                                      CORRELATION_TRACE_DISABLED);
+            }
         }
 
         te->trace_running = false;
@@ -442,7 +446,10 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
              * like E-Trace. So we need to send message here, instead of
              * using te->trace_next_insn
              */
-            trencoder_send_prog_trace_sync(OBJECT(te), env->pc);
+            if (trencoder_filters_match(te, INSTRUCTION_FILTERING,
+                                        env->pc, env->pc)) {
+                trencoder_send_prog_trace_sync(OBJECT(te), env->pc);
+            }
         } else {
             te->trace_next_insn = true;
         }
@@ -1002,13 +1009,32 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     bool is_branch_taken;
 
     if (trencoder->ntrace) {
-        trencoder_send_indirect_branch_hist(
-                trencoder,
-                trencoder->pending_branch_trace.source_pc,
-                get_inst_len_at(trencoder->pending_branch_trace.source_pc),
-                trencoder->pending_branch_trace.target_pc,
-                trencoder->pending_branch_trace.type);
-        return;
+        if (trencoder->filter_state == PROG_TRACE_SYNC_PENDING) {
+            if (trencoder_filters_match(trencoder, INSTRUCTION_FILTERING,
+                                        pc, pc)) {
+                trencoder_send_prog_trace_sync(OBJECT(trencoder), pc);
+                return;
+            }
+        }
+
+        if (trencoder->filter_state == PROG_TRACE_CORRELATION_PENDING) {
+            if (!trencoder_filters_match(trencoder, INSTRUCTION_FILTERING,
+                                        pc, pc)) {
+                trencoder_send_prog_trace_correlation(OBJECT(trencoder),
+                        trencoder->pending_branch_trace.source_pc,
+                        get_inst_len_at(trencoder->pending_branch_trace.source_pc),
+                        CORRELATION_TRACE_DISABLED);
+                return;
+            }
+
+            trencoder_send_indirect_branch_hist(
+                    trencoder,
+                    trencoder->pending_branch_trace.source_pc,
+                    get_inst_len_at(trencoder->pending_branch_trace.source_pc),
+                    trencoder->pending_branch_trace.target_pc,
+                    trencoder->pending_branch_trace.type);
+            return;
+        }
     }
 
     if (trencoder->updiscon_pending) {
@@ -1029,6 +1055,146 @@ static uint64_t rv_ntrace_encode_faddr(uint64_t pc)
     return pc >> 1ul;
 }
 
+void riscv_trencoder_set_filter_exec_state(CPURISCVState *env, FilterExecutionState state)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->trencoder) {
+        return;
+    }
+
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    te->exec_state = state;
+}
+
+static uint64_t xcause_as_bitmask(TraceEncoder *te, TracePrivLevel priv, bool *async)
+{
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
+
+    uint64_t xcause = priv == PRV_M ? env->mcause : env->scause;
+    uint64_t mxlen = 16 << riscv_cpu_mxl(env);
+
+    /* extract interrupt bit from cause value */
+    *async = xcause >> (mxlen - 1);
+
+    /* remove interrupt bit from cause value */
+    xcause &= ~BIT(mxlen - 1);
+
+    /* convert cause index to bitmask */
+    xcause = 1 << xcause;
+
+    return xcause;
+}
+
+static bool trencoder_ntrace_filter_match(TraceEncoder *te, FiltersInfo *filter,
+                                          TracePrivLevel priv)
+{
+    /* If filter disabled - act like we do not filter anything */
+    if (!filter->enabled) {
+        return true;
+    }
+
+    if (filter->match_priv) {
+        if (!(filter->match_choice_priv & (1 << priv))) {
+            return false;
+        }
+    }
+
+    if (filter->match_ecause) {
+        /* VU, VS, D modes are not supported by now */
+        bool async = false;
+        uint64_t xcause_bit = xcause_as_bitmask(te, priv, &async);
+        if (!async && (!(filter->match_choice_ecause & xcause_bit) ||
+                        te->exec_state != EXCPTION_EXEC)) {
+            return false;
+        }
+    }
+
+    if (filter->match_int) {
+        /* RISC-V-Trace-Control-Interface Table25:
+         * When trTeFilterMatchInterrupt field for filter #i is set,
+         * match itype of 2 or 1 depending on whether this bit is 1
+         * or 0 respectively.
+         * itype 2 == Interrupt
+         * itype 1 == Exception
+         */
+        if (filter->match_value_int) {
+            if (te->exec_state != INTERRUPT_EXEC) {
+                return false;
+            }
+        } else {
+            if (te->exec_state != EXCPTION_EXEC) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
+static bool trencoder_ntrace_filters_match(TraceEncoder *te, FilteringType type,
+                                           TracePrivLevel priv, hwaddr pc)
+{
+    uint16_t mask = te->inst_filters_mask;
+
+    /* Only Instruction Filtering supported for now */
+    g_assert(!type);
+
+    for (int i = 0; i < ARRAY_SIZE(te->filters_info); i++) {
+        if (mask & BIT(i)) {
+            /* Accorfing to RISC-V Trace Control Interface spec 1.0 chapter 6.3,
+             * if more than one bit set in trTeInstFilters than condition inside
+             * filters applies as logical AND but between filters as logical OR.
+             */
+            if (!trencoder_ntrace_filter_match(te, &te->filters_info[i], priv)) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
+/* Return falue determine we should or shouldn't emit message */
+bool trencoder_filters_match(TraceEncoder *te, FilteringType type,
+                             hwaddr curr_pc, hwaddr target_pc)
+{
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
+
+    if (!te->trace_running) {
+        return false;
+    }
+
+    if (te->ntrace) {
+
+        if (trencoder_ntrace_filters_match(te, type, env->priv, curr_pc)) {
+            return true;
+        }
+
+        /* We split Filter state into 3 states, so:
+         * IDLE_FILTER when no trace messages should be emitted,
+         * PROG_TRACE_SYNC_PENDING when control flow changes, system state changes
+         * and we should check does we realy need to start tracing on source pc
+         * (from where control flow changes) and target_pc(to where we change control
+         * flow).
+         * PROG_TRACE_CORRELATION_PENDING its state means that tracing already started
+         * and we should check, does a control flow disable trace or not.
+         */
+        if (target_pc != curr_pc && te->filter_state == IDLE_FILTER) {
+            te->filter_state = PROG_TRACE_SYNC_PENDING;
+            te->trace_next_insn = true;
+        }
+
+        return false;
+    }
+
+    /* Only N-trace filtering supported by now */
+    return true;
+}
+
 void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -1050,6 +1216,8 @@ void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
     trencoder->last_icnt_reset = pc;
     trencoder->icnt_accumulated = 0;
 
+    trencoder->filter_state = PROG_TRACE_CORRELATION_PENDING;
+
     if (ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, CONTEXT)) {
         trencoder_send_ownership_msg(trencoder, FORMAT_SYNC_HCONTEXT,
                                      trencoder->cpu->env.priv);
@@ -1168,6 +1336,8 @@ void trencoder_send_prog_trace_correlation(Object *trencoder_obj, uint64_t pc,
                                                                 src_msg, src_width);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
+
+    trencoder->filter_state = IDLE_FILTER;
 }
 
 void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
@@ -1179,6 +1349,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (!trencoder_filters_match(trencoder, INSTRUCTION_FILTERING,
+                                 curr_pc, target_pc)) {
+        return;
+    }
+
     if (trencoder->ntrace) {
         trencoder->pending_branch_trace.type = is_interrupt ? BTYPE_INTERRUPT :
                                                               BTYPE_EXCEPTION;
@@ -1227,6 +1402,11 @@ void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
 {
     TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
 
+    if (!trencoder_filters_match(te, INSTRUCTION_FILTERING, pc,
+                                 pc + offset)) {
+        return;
+    }
+
     if (te->ntrace && taken != BRANCH_NOT_TAKEN) {
             uint64_t icnt = (pc + insn_len - te->last_icnt_reset) / 2;
             te->icnt_accumulated += icnt;
@@ -1269,7 +1449,7 @@ static void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 }
 
 void trencoder_trace_priv_change(Object *trencoder_obj, hwaddr curr_pc,
-                                 uint8_t newpiv)
+                                 hwaddr target_pc, uint8_t newpiv)
 {
     if (!trencoder_obj) {
         return;
@@ -1282,6 +1462,11 @@ void trencoder_trace_priv_change(Object *trencoder_obj, hwaddr curr_pc,
         return;
     }
 
+    if (!trencoder_filters_match(trencoder, INSTRUCTION_FILTERING,
+                                 curr_pc, target_pc)) {
+        return;
+    }
+
     if (trencoder->ntrace && ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, CONTEXT)) {
         trencoder_send_ownership_msg(trencoder, FORMAT_PRIV_CHANGE, newpiv);
     } else if (!trencoder->ntrace) {
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index f4196e7208..e3f813062a 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -146,7 +146,7 @@ void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
                                uint64_t target_pc, uint32_t ecause,
                                bool is_interrupt, uint64_t tval);
 void trencoder_trace_priv_change(Object *trencoder_obj, hwaddr curr_pc,
-                                 uint8_t newpiv);
+                                 hwaddr target_pc, uint8_t newpiv);
 void trencoder_report_updiscon(Object *trencoder_obj);
 void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
                              uint64_t insn_len, uint64_t offset,
@@ -154,4 +154,9 @@ void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
 void trencoder_send_ownership_msg(TraceEncoder *trencoder,
                                   NTraceOwnershipFormat value, uint8_t newpiv);
 void trencoder_send_ownership_scontext_msg(Object *trencoder_obj);
+bool trencoder_filters_match(TraceEncoder *te, FilteringType type,
+                             hwaddr curr_pc, hwaddr target_pc);
+void riscv_trencoder_set_filter_exec_state(CPURISCVState *env,
+                                           FilterExecutionState state);
+
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8aac23b400..7ae68c0400 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2377,9 +2377,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         if (cpu->trencoder && TRACE_ENCODER(cpu->trencoder)->trace_running) {
             trencoder_trace_trap_insn(cpu->trencoder, env->sepc, env->pc,
                                       env->scause, async, env->stval);
+            riscv_trencoder_set_filter_exec_state(env, async ?
+                                                  INTERRUPT_EXEC : EXCPTION_EXEC);
         }
 
-        trencoder_trace_priv_change(cpu->trencoder, env->sepc, PRV_S);
+        trencoder_trace_priv_change(cpu->trencoder, env->sepc, env->pc, PRV_S);
         riscv_cpu_set_mode(env, PRV_S, virt);
 
         src = env->sepc;
@@ -2470,9 +2472,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         if (cpu->trencoder && TRACE_ENCODER(cpu->trencoder)->trace_running) {
             trencoder_trace_trap_insn(cpu->trencoder, env->mepc, env->pc,
                                       env->mcause, async, env->mtval);
+            riscv_trencoder_set_filter_exec_state(env, async ?
+                                                  INTERRUPT_EXEC : EXCPTION_EXEC);
         }
 
-        trencoder_trace_priv_change(cpu->trencoder, env->mepc, PRV_M);
+        trencoder_trace_priv_change(cpu->trencoder, env->mepc, env->pc, PRV_M);
         riscv_cpu_set_mode(env, PRV_M, virt);
         src = env->mepc;
     }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index ded6d79193..5171d1dc31 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -353,7 +353,7 @@ target_ulong helper_sret(CPURISCVState *env)
         }
     }
 
-    trencoder_trace_priv_change(cpu->trencoder, env->pc, prev_priv);
+    trencoder_trace_priv_change(cpu->trencoder, env->pc, retpc, prev_priv);
     helper_trace_indirect_branch(env, env->pc, retpc);
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
@@ -370,6 +370,7 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_ctr_add_entry(env, env->pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
                             src_priv, src_virt);
     }
+    riscv_trencoder_set_filter_exec_state(env, DEFAULT_EXEC);
 
     return retpc;
 }
@@ -444,7 +445,7 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_cpu_swap_hypervisor_regs(env);
     }
 
-    trencoder_trace_priv_change(cpu->trencoder, env->pc, prev_priv);
+    trencoder_trace_priv_change(cpu->trencoder, env->pc, retpc, prev_priv);
     helper_trace_indirect_branch(env, env->pc, retpc);
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
     /*
@@ -460,6 +461,7 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_ctr_add_entry(env, env->pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
                             PRV_M, false);
     }
+    riscv_trencoder_set_filter_exec_state(env, DEFAULT_EXEC);
 
     return retpc;
 }
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index af36c01a02..b0c91ecedc 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -55,11 +55,18 @@ void helper_trace_indirect_branch(CPURISCVState *env, target_ulong curr_pc,
     RISCVCPU *cpu = env_archcpu(env);
     TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
 
+    if (!te) {
+        return;
+    }
+
     if (te->ntrace) {
+        if (trencoder_filters_match(te, INSTRUCTION_FILTERING,
+                                    curr_pc, target_pc)) {
             te->pending_branch_trace.target_pc = target_pc;
             te->pending_branch_trace.source_pc = curr_pc;
             te->pending_branch_trace.type = BTYPE_CONTROL_FLOW;
             te->trace_next_insn = true;
+        }
     }
 }
 
@@ -81,8 +88,8 @@ void helper_trace_branch(CPURISCVState *env, target_ulong pc,
     return;
 }
 
-void helper_trace_indirect_branch(CPURISCVState *env, hwaddr curr_pc,
-                                  hwaddr target_pc)
+void helper_trace_indirect_branch(CPURISCVState *env, target_ulong curr_pc,
+                                  target_ulong target_pc)
 {
     return;
 }

-- 
2.43.0


