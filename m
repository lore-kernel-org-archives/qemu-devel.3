Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7938FE9D3F3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMF-0004QK-72; Thu, 05 Feb 2026 23:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDME-0004Pw-1s
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:14 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDMC-0003Vk-0V
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:13 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso153007b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351730; x=1770956530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZQOTv1ZWaw7/m+ukhNnjzXfOk5Em/QF1TWzcoaJze0=;
 b=gF0BLRdVMWm6JoHAZAgM7LzfFyrf191SU27o013BhJua9CUCWSqqGiLNHWmmjC8kAk
 8bKkV307sNX8xFkBw4NDwP37+Mrrs6WoMqMoSeyW9q7KFxvympKCm7d0cKPxrDm3uKxs
 rl6vKyIaw+hbg7zkWmrTKBfkyalcIzwlfWDOJunX/sH32O1MSY/srdkagRBhr1TgknEo
 /H+PwzCaPD0Md8UTrMx5jnriagAWIFo6apTGu4aRVVDFadrZd2n7fK+BJ3M8PmaZNkw3
 IP1h5owl/+ow+eW+auEhAuT2e48mXdIZMrvo+PrZKCIzGWYHqojJLo8gmnBDSpdupQiL
 sJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351730; x=1770956530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZQOTv1ZWaw7/m+ukhNnjzXfOk5Em/QF1TWzcoaJze0=;
 b=NGkoKiK5zusYfqnYad0sMZtZ0Q76Eh22pVxEn/CIWaDWLCj0wqIFw8jMs/zYtg33N8
 OfofDisW2aIr/2TwUhIViRD7xAHgPDhv0h9AF4RrvXgMRwWxH/1o0KQtL2+0z5JiS2vW
 Jqp5l5b5MFBbPVF//lVkhKJsRtwvnCkluzypIk0P+GUv3viDDmt0YGzVWSLjrY3X0Oxt
 SjlzM1PTidyU4sIiHipinnMlWXYma6/CSQeoGHG3VFrcm1kgVW0r3zVV5WyFVWR2Wx26
 0dqGtjcyTN91IzI+GbWw5qlabP4YSVVjDLlNcqF2IvUdP/hXSEFXqQmk9eRt2YaB334I
 9bmA==
X-Gm-Message-State: AOJu0YzEokzYt2pKiaX4Nb5omT02HAR6q98zp7GksRQ02Yvs5ZeoK6oS
 VymexaWJ4FO+DJnQ0eKSjZsnWIyamgasMy2wJ70EoS777viQ8oEu9uxB3HksJPNf4hV3qdUsmDk
 F2Q45fOM=
X-Gm-Gg: AZuq6aJ7AJ0THzjamUudWmkq5J5rlbCnXAykG/h1/J49zEtZ/LJAK/xdyBZPmfkPcpD
 7MTFTCziGu7jm/mWRJPuVQDHkcyrNenSjK4cef9919nviKp1uC7az0Wmy74hg8YkQbDVyMSR/FF
 2MDLPOT6ynVjKDMHjh+apXdHxvVdpWWqE/uWIGGCgCjVmF7R2+bPnpZAZQAEfOGOfCMOax9moFi
 74WWJ1PUkY6z/kqARt6coxfLTrR6ssOo0w3IR8HJEmoILv4wIWWcxIZj2feJjkIBm2/qkAJmD3d
 /LtPaKwqdbBUAsmkffdWx01MeI5dxYzm+h7kUFnab5/K3V5FptOa2+4IUngSNaTIw4RahiPUNDo
 7jDgqshLRYpb3ZaAhpAzyXxDGMPuJYzKIn8mYr9W23twsYMFtWhMPCrBlQ8JEkFjYkwaidVhGlo
 MUt66yba5MYRheG2Tc/F/3R1htpwmx3KctrQGYh8XnJq1P/Of/UoQK2Lll7GWPbBIM
X-Received: by 2002:a05:6a00:240b:b0:823:1094:2458 with SMTP id
 d2e1a72fcca58-824413c12b8mr1285493b3a.0.1770351730491; 
 Thu, 05 Feb 2026 20:22:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 12/12] target/arm/tcg/translate.h: replace target_long with
 int64_t
Date: Thu,  5 Feb 2026 20:21:50 -0800
Message-ID: <20260206042150.912578-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x442.google.com
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

target_long is used to represent a pc diff. Checked all call sites to
make sure we were already passing signed values, so extending works as
expected.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 2c8358dd7fa..1f455e4c434 100644
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
index 982c83ef42a..42b2785fb06 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -250,12 +250,12 @@ static inline int get_a32_user_mem_index(DisasContext *s)
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
@@ -735,7 +735,7 @@ void gen_set_condexec(DisasContext *s)
     }
 }
 
-void gen_update_pc(DisasContext *s, target_long diff)
+void gen_update_pc(DisasContext *s, int64_t diff)
 {
     gen_pc_plus_diff(s, cpu_R[15], diff);
     s->pc_save = s->pc_curr + diff;
@@ -1055,7 +1055,7 @@ static void gen_exception(int excp, uint32_t syndrome)
                                        tcg_constant_i32(syndrome));
 }
 
-static void gen_exception_insn_el_v(DisasContext *s, target_long pc_diff,
+static void gen_exception_insn_el_v(DisasContext *s, int64_t pc_diff,
                                     int excp, uint32_t syn, TCGv_i32 tcg_el)
 {
     if (s->aarch64) {
@@ -1068,14 +1068,14 @@ static void gen_exception_insn_el_v(DisasContext *s, target_long pc_diff,
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
@@ -1310,7 +1310,7 @@ static void gen_goto_ptr(void)
  * cpu_loop_exec. Any live exit_requests will be processed as we
  * enter the next TB.
  */
-static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
+static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
 {
     if (translator_use_goto_tb(&s->base, s->pc_curr + diff)) {
         /*
@@ -1337,7 +1337,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
 }
 
 /* Jump, specifying which TB number to use if we gen_goto_tb() */
-static void gen_jmp_tb(DisasContext *s, target_long diff, int tbno)
+static void gen_jmp_tb(DisasContext *s, int64_t diff, int tbno)
 {
     if (unlikely(s->ss_active)) {
         /* An indirect jump so that we still trigger the debug exception.  */
@@ -1380,7 +1380,7 @@ static void gen_jmp_tb(DisasContext *s, target_long diff, int tbno)
     }
 }
 
-static inline void gen_jmp(DisasContext *s, target_long diff)
+static inline void gen_jmp(DisasContext *s, int64_t diff)
 {
     gen_jmp_tb(s, diff, 0);
 }
-- 
2.47.3


