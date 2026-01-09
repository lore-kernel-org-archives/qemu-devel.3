Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC99D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56n-0004Y7-8B; Fri, 09 Jan 2026 00:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56g-0004L2-PG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:18 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56e-0003iL-Vg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:18 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-34c1d98ba11so3097943a91.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936735; x=1768541535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReDSh/g/QefhJLgKVCumyq1vVF23Kv2avHVp7O/jn2s=;
 b=vi3mkwYevjo/rOb4KoFqe0xH7piv0jYFc8BoOHPbd+kaF6qPWjG5Nm48G06FfiG43X
 KlmYQ9BEa4cBdXNhgqFrpBas4HRJEHfXckGyBofm5ggiRT+8BJRyOQO3Vt4hIn6/dNuw
 oIVPOdMuoW7wg3wRWesFQzE+a2l7+9N21tAaAtu6O+RL5quLm3BBsMC1iVe2Ma/ks/3y
 irhuDsMSYmBrL8j4o6iobClyv3Ev7iWRp9rF1hViYn16H7hGt2DIHVfrjrAMd/HrY5jK
 SpD+RCeu53g1SAueWS7oUiAgkMqHWEwB7tyc7saU/lLz2YnI48hqXlZd8x8lm1tYbez7
 P5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936735; x=1768541535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ReDSh/g/QefhJLgKVCumyq1vVF23Kv2avHVp7O/jn2s=;
 b=h7C6CR4gzIEuoCy+gii07QLG3567guIPqh/unT7i+6TUTxU4f8q6ZHtUyZ7L+Z0800
 HSIS0TfA98LspH0pAVOdWr7io9WXzRqP8zrUDXX8d5QeJJhr45i/nXzoQEXKOCQPbrfT
 Dfagjak8kcNOOPNXhJE+gj64lNX4OH2iBOCqeSAm1SipwTfHCqAsCcnQp/Rd0pb1iuGv
 bVIKyLl776IByMwq97BMXube3/91XHzJgMd7jEkUAjHVFdKPxj4OjkDZEEervdpMoscB
 VKsqxyTts7eKxqwa6kRvUmAqq2xzWvyyffBYy2BXHEJqMfpAOiJtRtUVu9t+sFdQgdq/
 Quew==
X-Gm-Message-State: AOJu0Yx+zLkUknY2RavJu7H9lBYcMEb8BkM4ahcTDb/Ciwsq6fDPVZhp
 JI4IK2vb0/BOTk6jV3ylp/yX/a5nwUqOQLUCmiHM0eGrrltgcBphbT+uR3IeNP6wR2HAuVGU1eO
 Bcf3CKHI=
X-Gm-Gg: AY/fxX5l/ukOv+Joc4Btitl1J05MPiQqCS9xZZerO+rCPihLbnxQzOi3yON1DWMsr7C
 4oWayHB1oFsH+LGfLwbJL3ALTuwy2XPhhkNND/XaoNESvMQhsJip/VEFQYNPQ33NBwM/vPWkKAV
 46Gr49998aHdV113S+Vy9jj+XAqAZukk+LUAH0mUaxMEEiD82xUn6ETY43Bv8OFIbdWTqBLCkRB
 ToMJIVbay60wS0tkTxWWEAq4omtqlIkYY+tfnXxpviA47TV/9T75UdbOaKw7NggPBWM39t+zo9x
 D6FeMQXi+SDMfWG3UZe+7RmZUSWwR9xZt1XeAuU2YcM3ts9KuY1zfCqoBz/sSqIWBGmaTdHTfSh
 nXieaQPAtiqWq/BOUm7QOKXrDnzc/gBBiutPzkkorqNjVAUQx2BcoALlmbLOB/Ma0BGSyx7ClpW
 GQt1blh/8sHCsbkSwMsfThBeX2MVDSbD7TfoR75/YZ+srNTfM4fmi1Db9ecNgP0WTH
X-Google-Smtp-Source: AGHT+IGVT0BidnmsAqanzq/cfxNg9Fcyldud50uoO8e37gByGnF6xmebgHJ2sA+LXznAfQZGz+QR/g==
X-Received: by 2002:a17:90b:4f44:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-34f68d0bc39mr9152431a91.17.1767936735449; 
 Thu, 08 Jan 2026 21:32:15 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/29] target/arm/tcg/translate.h: replace target_long with
 int64_t
Date: Thu,  8 Jan 2026 21:31:40 -0800
Message-ID: <20260109053158.2800705-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1041.google.com
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

target_long is used to represent a pc diff. Checked all call sites to
make sure we were already passing signed values, so extending works as
expected.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-a32.h |  2 +-
 target/arm/tcg/translate.h     | 12 ++++++------
 target/arm/tcg/translate.c     | 18 +++++++++---------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index 0b1fa57965c..a8df364171b 100644
--- a/target/arm/tcg/translate-a32.h
+++ b/target/arm/tcg/translate-a32.h
@@ -40,7 +40,7 @@ void write_neon_element64(TCGv_i64 src, int reg, int ele, MemOp memop);
 TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs);
 void gen_set_cpsr(TCGv_i32 var, uint32_t mask);
 void gen_set_condexec(DisasContext *s);
-void gen_update_pc(DisasContext *s, target_long diff);
+void gen_update_pc(DisasContext *s, int64_t diff);
 void gen_lookup_tb(DisasContext *s);
 long vfp_reg_offset(bool dp, unsigned reg);
 long neon_full_reg_offset(unsigned reg);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 63f187d4150..12319c02080 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -27,8 +27,8 @@ typedef struct DisasLabel {
 typedef struct DisasDelayException {
     struct DisasDelayException *next;
     TCGLabel *lab;
-    target_long pc_curr;
-    target_long pc_save;
+    int64_t pc_curr;
+    int64_t pc_save;
     int condexec_mask;
     int condexec_cond;
     uint32_t excp;
@@ -359,14 +359,14 @@ static inline int curr_insn_len(DisasContext *s)
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_a64_update_pc(DisasContext *s, target_long diff);
+void gen_a64_update_pc(DisasContext *s, int64_t diff);
 extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
 {
 }
 
-static inline void gen_a64_update_pc(DisasContext *s, target_long diff)
+static inline void gen_a64_update_pc(DisasContext *s, int64_t diff)
 {
 }
 #endif
@@ -377,9 +377,9 @@ void arm_gen_test_cc(int cc, TCGLabel *label);
 MemOp pow2_align(unsigned i);
 void unallocated_encoding(DisasContext *s);
 void gen_exception_internal(int excp);
-void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
+void gen_exception_insn_el(DisasContext *s, int64_t pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
-void gen_exception_insn(DisasContext *s, target_long pc_diff,
+void gen_exception_insn(DisasContext *s, int64_t pc_diff,
                         int excp, uint32_t syn);
 TCGLabel *delay_exception_el(DisasContext *s, int excp,
                              uint32_t syn, uint32_t target_el);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 8988c852983..79b111a228b 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -262,12 +262,12 @@ static inline int get_a32_user_mem_index(DisasContext *s)
 }
 
 /* The pc_curr difference for an architectural jump. */
-static target_long jmp_diff(DisasContext *s, target_long diff)
+static int64_t jmp_diff(DisasContext *s, int64_t diff)
 {
     return diff + (s->thumb ? 4 : 8);
 }
 
-static void gen_pc_plus_diff(DisasContext *s, TCGv_i32 var, target_long diff)
+static void gen_pc_plus_diff(DisasContext *s, TCGv_i32 var, int64_t diff)
 {
     assert(s->pc_save != -1);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
@@ -747,7 +747,7 @@ void gen_set_condexec(DisasContext *s)
     }
 }
 
-void gen_update_pc(DisasContext *s, target_long diff)
+void gen_update_pc(DisasContext *s, int64_t diff)
 {
     gen_pc_plus_diff(s, cpu_R[15], diff);
     s->pc_save = s->pc_curr + diff;
@@ -1067,7 +1067,7 @@ static void gen_exception(int excp, uint32_t syndrome)
                                        tcg_constant_i32(syndrome));
 }
 
-static void gen_exception_insn_el_v(DisasContext *s, target_long pc_diff,
+static void gen_exception_insn_el_v(DisasContext *s, int64_t pc_diff,
                                     int excp, uint32_t syn, TCGv_i32 tcg_el)
 {
     if (s->aarch64) {
@@ -1080,14 +1080,14 @@ static void gen_exception_insn_el_v(DisasContext *s, target_long pc_diff,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
+void gen_exception_insn_el(DisasContext *s, int64_t pc_diff, int excp,
                            uint32_t syn, uint32_t target_el)
 {
     gen_exception_insn_el_v(s, pc_diff, excp, syn,
                             tcg_constant_i32(target_el));
 }
 
-void gen_exception_insn(DisasContext *s, target_long pc_diff,
+void gen_exception_insn(DisasContext *s, int64_t pc_diff,
                         int excp, uint32_t syn)
 {
     if (s->aarch64) {
@@ -1322,7 +1322,7 @@ static void gen_goto_ptr(void)
  * cpu_loop_exec. Any live exit_requests will be processed as we
  * enter the next TB.
  */
-static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
+static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
 {
     if (translator_use_goto_tb(&s->base, s->pc_curr + diff)) {
         /*
@@ -1349,7 +1349,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
 }
 
 /* Jump, specifying which TB number to use if we gen_goto_tb() */
-static void gen_jmp_tb(DisasContext *s, target_long diff, int tbno)
+static void gen_jmp_tb(DisasContext *s, int64_t diff, int tbno)
 {
     if (unlikely(s->ss_active)) {
         /* An indirect jump so that we still trigger the debug exception.  */
@@ -1392,7 +1392,7 @@ static void gen_jmp_tb(DisasContext *s, target_long diff, int tbno)
     }
 }
 
-static inline void gen_jmp(DisasContext *s, target_long diff)
+static inline void gen_jmp(DisasContext *s, int64_t diff)
 {
     gen_jmp_tb(s, diff, 0);
 }
-- 
2.47.3


