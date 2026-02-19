Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9334CE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1NL-0007sW-MG; Thu, 19 Feb 2026 05:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mk-0007Md-Pb
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:38 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mi-00069l-NB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4833115090dso7659325e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497274; x=1772102074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xR5QBMtIJ7RHzFIkSy3EPbY45TMgkx+1i2QYsMhumRY=;
 b=AkV0c7/zegn53grst/XGE3n90qszGQRVmpnqCkDcAUZYus33ScooDq5j52c8Lx+lfR
 dYcpF+7kBI40TGWwrHE6Z1qNYNoJwcoHp5EK1FxoXlJN5pEMxvUfSNlIvLsO2iiPeKwk
 dNPErIxtU5Ejxia60qLxR/mBlciLbX6HWtF6JgEma3JqYkwKMpEN32YCUHI4yOACZg1C
 GH9l3qTgYRRfp17pqpislEvbXxD/bWsHZYmfwYKKDr1eoj1CEeyuylPNJJg6Uu+LZLNP
 pg0N+KDz+Tov2QXHRbg+HOP1AGc/PPEkL1xw4Ny6UF2sKhl69XWf4JTfYXABBRz+/4Ah
 zXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497274; x=1772102074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xR5QBMtIJ7RHzFIkSy3EPbY45TMgkx+1i2QYsMhumRY=;
 b=K3a3tAh+vO5FwgGsiRKmEaKHgbzw+qmVEEir+ik23v0s0Oji2haWHOv+WZBJPmruPf
 76hNsxwOCcB31Jmi/hLEpVo75s/IdhPnyGbyNRGfbrmOAMbGL6GN8lGGhVksbTi1mD/8
 Bl8xromEZQM+cQUn7tZ4gb8fj46gdHcB+IlrJUNBs74i90Jy8jLu0l4s+BoGA3f4ZAeC
 pXL0DuB9dAC8s+O2ZzIZ54y13P5rNRexNcTjrRpgTPYU8TxJJoYLHDEW4LpfuA94JgZq
 JLBOmiTonlwzckpDcXOPXtw6851RMqlXp/lai4gK4lghQraFotBOyQSmq5DSsBtvL6n+
 cApg==
X-Gm-Message-State: AOJu0YwQdzpgGaN9OO6qonyHS2w7LM6ZsNfqm/T6Z2jGhZyiRt2efb/d
 1bIgI96t2CdgE/+PNfo+NSImSvQi6OeuBvhxZkeQe0XyBEWXJAHdHx01VgSWRSR2P0Foub2ROnj
 +BGR2aes=
X-Gm-Gg: AZuq6aJY1eXbiHnO1X3T2sM5SbzeJ6hJCeKdNGrFYdk0tXtmLt8wwhGX92D6Kk2iwSI
 NS6ZfNFPn4ESTX3OeEaHqgUU8DtvdcPcViWTvT8YDP5hgKIhDQyl+MDWDQPx7KGiH1qGpAL+0un
 fQIU7iFevvgoYjE2qGun2KYu40bYD+88/EUpJRS0xs0cvEBU3/gIeLufDL8BeR854ZqJC7kFSHk
 mdMHGa+1baKMFJsYlM9ECg6pmEW/X4s+NvonlZsBjNA3Muidd6cmAf/dfSKhrLZjRorxDjJigzu
 X4x3K6Yek9bkKjgTyShsvmhGz9GeSJinsjl/za/GKDD5NIQHFg+HKs08jnZnlx/darygjjN/D5h
 t39NSLjP8fc+vQql1ubWzggGCrH60bvNlVbB5u4G9k47B4J0fnREkmOLqGOqNyDDlwKjept4set
 AMoNBCGb2a9SgvvuqLZ/JOBhyyp/4SitN4Xh/ZDhpW9VHCJRIanqKovjQ43aDzDgicwBTty9Aqn
 ZHOOAbtDp1XJ4G88C3AEDEhi42shrA=
X-Received: by 2002:a05:600c:8b26:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-48398a47222mr70596375e9.6.1771497274382; 
 Thu, 19 Feb 2026 02:34:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] target/arm/tcg/translate.h: replace target_long with
 int64_t
Date: Thu, 19 Feb 2026 10:34:04 +0000
Message-ID: <20260219103405.3793357-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

target_long is used to represent a pc diff. Checked all call sites to
make sure we were already passing signed values, so extending works as
expected.

Use vaddr for pc_curr and pc_save.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-14-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a32.h |  2 +-
 target/arm/tcg/translate.c     | 18 +++++++++---------
 target/arm/tcg/translate.h     | 12 ++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index 0b1fa57965..a8df364171 100644
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
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 3f57006f9d..f9d1b8897d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -253,12 +253,12 @@ static inline int get_a32_user_mem_index(DisasContext *s)
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
@@ -738,7 +738,7 @@ void gen_set_condexec(DisasContext *s)
     }
 }
 
-void gen_update_pc(DisasContext *s, target_long diff)
+void gen_update_pc(DisasContext *s, int64_t diff)
 {
     gen_pc_plus_diff(s, cpu_R[15], diff);
     s->pc_save = s->pc_curr + diff;
@@ -1058,7 +1058,7 @@ static void gen_exception(int excp, uint32_t syndrome)
                                        tcg_constant_i32(syndrome));
 }
 
-static void gen_exception_insn_el_v(DisasContext *s, target_long pc_diff,
+static void gen_exception_insn_el_v(DisasContext *s, int64_t pc_diff,
                                     int excp, uint32_t syn, TCGv_i32 tcg_el)
 {
     if (s->aarch64) {
@@ -1071,14 +1071,14 @@ static void gen_exception_insn_el_v(DisasContext *s, target_long pc_diff,
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
@@ -1313,7 +1313,7 @@ static void gen_goto_ptr(void)
  * cpu_loop_exec. Any live exit_requests will be processed as we
  * enter the next TB.
  */
-static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
+static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
 {
     if (translator_use_goto_tb(&s->base, s->pc_curr + diff)) {
         /*
@@ -1340,7 +1340,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
 }
 
 /* Jump, specifying which TB number to use if we gen_goto_tb() */
-static void gen_jmp_tb(DisasContext *s, target_long diff, int tbno)
+static void gen_jmp_tb(DisasContext *s, int64_t diff, int tbno)
 {
     if (unlikely(s->ss_active)) {
         /* An indirect jump so that we still trigger the debug exception.  */
@@ -1383,7 +1383,7 @@ static void gen_jmp_tb(DisasContext *s, target_long diff, int tbno)
     }
 }
 
-static inline void gen_jmp(DisasContext *s, target_long diff)
+static inline void gen_jmp(DisasContext *s, int64_t diff)
 {
     gen_jmp_tb(s, diff, 0);
 }
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 2c8358dd7f..3e3094a463 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -27,8 +27,8 @@ typedef struct DisasLabel {
 typedef struct DisasDelayException {
     struct DisasDelayException *next;
     TCGLabel *lab;
-    target_long pc_curr;
-    target_long pc_save;
+    vaddr pc_curr;
+    vaddr pc_save;
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
-- 
2.43.0


