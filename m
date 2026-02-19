Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67000E9A050
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvFR-00005V-A5; Wed, 18 Feb 2026 23:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvFC-0008RA-0l
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:27 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF9-0001Gz-3m
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:25 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2aae146b604so3195915ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473742; x=1772078542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BtQ7bhjPsJSS0UXCY2rgGt0bRWuOuYRQy8L3yquKrE=;
 b=LoXMNpzPxvDC9KGDG9dinsRqJ3w0wujX7SrV/wwMCcLXk3U/w9asuWRzpWyf6eHFHG
 GPS7QizDxVCaZOwi5AVLHizuf8T82A1FGdQhFjMNXla4d3Xv4EONiulSKE0JcIXSZgDz
 tYfSvYdwEvAFN7dSc3DIa9DrMUJTBlu39tgsQB89V6N00NHxW7MkuAGbzQRxaZufupud
 Ap55Pwwpy1F67Kme5ULTNblYJndiPvYDBYiRuCpNP6GXVbxb3svQpL4WuIXDotXXk8r7
 2HjW0WJKfr0wAA29tszyq1OuLZaUN5sqkwQGXLaRbb/II+91CcDnN7cQvtGb6/nb7zIa
 3L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473742; x=1772078542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BtQ7bhjPsJSS0UXCY2rgGt0bRWuOuYRQy8L3yquKrE=;
 b=m1YjBB/IvQzSsv/cuxlqbo1icABCbjczcorDL1nt2zJ1I7E0xdxQ4z5f/Bxcp2Bhs3
 vwupsvAvY3nFo0oKwCOQB+Vkkg3AyG14ueOOiWkORVtolSbFD8QIl57x0brz4NPZipq4
 J4+GsyCHf/brnVKsg1LigxGuwLxy0GYMoLSV3A21HbuTxURPXGJ62u4HS7VkWX9gbtXE
 Zw9AX2pWKNqfe/vkBJI5avxUwdwONRrnx/Jej0qNqksnECCGVCfiRD3TKL2TKfJ7L5k9
 F6ZYEZsE9xn88wLESvNuP9o6my6Tq+5l8h2vyjqZvb5vluI3OcRIJ61LU53wIDgvOR9e
 Q1xw==
X-Gm-Message-State: AOJu0YzTEWSRrjdVCyxjRyWhMQuRRZOj0Ozp5Fo97vld/gSa2clHbTTc
 0EDZ3su/rrwWyag7wrSafc9FjSdQD7dW5z1Mc+pveBtGyNB7RTnXaZPFobRs4HjJBIkCSnjKZR+
 jn+H7098=
X-Gm-Gg: AZuq6aIS2yIpeNdnP988ZI+31xUTPsG2ekBILRtTwZ0S2cRZI61P61QppUnKlpIRsp9
 JJs3x7FS3uoAioyW31CTOyLuPy3FUnJYd9WL4kyC8tTHzzanlNUrJ1z4oBCWbxKpOKFiQwg7BOL
 gcqEu+GFWikN7xU8Kh+y4AHP4EYRyvDhtMor6wMf+iHUana2NSg6nNKEhkfaIaxUQ9YEI7+5xjI
 gpYM1pf3/rYEK2ddLYIqbsKIqz24AgNW/r8d7iOG7X8l56Pi5yjXUEnZqz9WKZBEtv03LQFMjsi
 VplomsqdY03bbLadx2PZ/pj3YFaD8FsU+vKx62hgpapwF3wqPIVkZMcQvYMAK1z7srUepoVKL3b
 J/WQe90txL21JYfJUzQjjEWHeDwjUFX2bEvJEmBO6RlPIC5J7fcuvl6vUvczXn/aKZK8k5h2dhN
 GZtatjLW6+6bXrlWT5vgMcTzQECLAVF5O/1shGrfmP5tQaaVCi0UD1pyah6N5vxkHi2sWo3b5rO
 Pnj
X-Received: by 2002:a17:903:198b:b0:2aa:f0d6:bf3b with SMTP id
 d9443c01a7336-2ab4d09b924mr182971155ad.53.1771473741589; 
 Wed, 18 Feb 2026 20:02:21 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 13/14] target/arm/tcg/translate.h: replace target_long with
 int64_t
Date: Wed, 18 Feb 2026 20:01:49 -0800
Message-ID: <20260219040150.2098396-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x644.google.com
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

Use vaddr for pc_curr and pc_save.

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
index 2c8358dd7fa..3e3094a463e 100644
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
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 3f57006f9df..f9d1b8897d2 100644
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
-- 
2.47.3


