Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB58CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXdZ-00030N-3B; Thu, 14 Aug 2025 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcr-0002H2-Ay
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcj-00059j-GZ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e2ebe86ecso1164279b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176643; x=1755781443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlJgHJEmHUYZe6YiGfVDRPRDT1LVN/rOSO+BbVvbmBY=;
 b=ouu7aC72THOs+DwBpub2fCgKW55+N/ig/vNByebe1Hj1YfZ+cI9YOogLmqxS2jKLQJ
 6ypOy1JWY2VOzBLY4dsdBniGz0iqG9g6j5E84vkaXwvl/qVjSCaaNsC1oKzJmDYFUmwn
 X8CFnQttZdxHYBrL245sZDxYTjb4S5teIwpDWlwgGV1nYcyHJLo7smHg9dkR8crGbFUi
 INe8xCqwqMAJQ+jjAvi4fVuzMRCGx+vJdEYseJZCstKoMc8qBuvqFpS9vndAOTNtl8f6
 k6RmlYfJwv+3NAaxlftSbI+dKTlUr45IREs8C1G2LyeeMfWh4+Ufh9fTEfo7cVBnqI98
 NzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176643; x=1755781443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlJgHJEmHUYZe6YiGfVDRPRDT1LVN/rOSO+BbVvbmBY=;
 b=re/vozfIFVhO6IGLVWznLdQens+bIjT3+xS5AWCmYp9V1W01McmgnBtpW2fBlB4xbt
 iSU6x8+JkCsDCf3G4rEwVrvclbxHW9LpUKx+BGTTgWl0TYQicOLH52iwC6B0ARJO58uY
 fRv5vy3kfAZ+agDLLG3icYl8YtRf3CrU8SsLcjzp5P3MCsaR2XauEL2/h748XGJqsekK
 wjV9kDuuy3wRcif/Y+i9WxBADK2/nYUQULgDfF1vPLkCiK3Q/vE45ESZwwi/E27cXLvt
 oFrMKIDZJOulrXXaXjVSUSa2FizPFXMvNd8MlQs95kbeNS9nja+cZSE7fLXWi8j09GMw
 K1ng==
X-Gm-Message-State: AOJu0Yzw+jiBiCSeAyKFXfOaFBa0yTkCMMS5XOdFXH63Udx25qKjNXEg
 Rte1BQ8bB/c6Oh9K3M1DvWNG7In+VBSrDVs1g3ylIhZkmVIjkf2B/6kAmla4ACX1NkoSA/MLHLg
 sUmAXMx0=
X-Gm-Gg: ASbGncv5kt6q5QJDmvlr1m7tqnAjkK/i+TKWEIvel3p/O3TPT3Tqdxr3DS3uhC95DUR
 TPXuRXR+gLrEivI6WcBxLIo1t5yZ7o7LmCVls9un2rziaetFDVbA5V44PSo+eTN8ylc5tPtddg6
 kXrEDkmnlVKzhCUaAduJScjISdSvma+20glZkwm7e7jAyLw0JAwu3hq9T1/6nAkNtyHrxMHE8f2
 deFryqLRD99RiMPdMOibOibajtkYrGXItbRhq65WPnBPZfqePIZnwqSPVY3BqMOPA87KG5uYgP0
 7ApV22kMDhZ7zOECBqUF14edL894i6C/1qg4QtmBfnyDmaEsYol42XTPnHxX3sWFhyC0qEdCvmd
 hB4+gST5dwDEcZkf+1cx+jwclMkSVCeK6+fbm2LqkYHCuW0U=
X-Google-Smtp-Source: AGHT+IHdz9z1AZIeiDbiBCSmPdmb0jtoHHdcEc3qz3/8wn3c7fQHIDhM8/3vpLiahSc5ynZHBl5SCw==
X-Received: by 2002:a05:6a20:939e:b0:23f:f96c:1197 with SMTP id
 adf61e73a8af0-240bd23bd4cmr5262022637.24.1755176643328; 
 Thu, 14 Aug 2025 06:04:03 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 54/85] target/arm: Introduce delay_exception{_el}
Date: Thu, 14 Aug 2025 22:57:21 +1000
Message-ID: <20250814125752.164107-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Add infrastructure to raise an exception out of line.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 20 +++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1479f5bf74..a40cbd4479 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -21,9 +21,25 @@ typedef struct DisasLabel {
     target_ulong pc_save;
 } DisasLabel;
 
+/*
+ * Emit an exception call out of line.
+ */
+typedef struct DisasDelayException {
+    struct DisasDelayException *next;
+    TCGLabel *lab;
+    target_long pc_curr;
+    target_long pc_save;
+    int condexec_mask;
+    int condexec_cond;
+    uint32_t excp;
+    uint32_t syn;
+    uint32_t target_el;
+} DisasDelayException;
+
 typedef struct DisasContext {
     DisasContextBase base;
     const ARMISARegisters *isar;
+    DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
     target_ulong pc_curr;
@@ -365,6 +381,10 @@ void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
 void gen_exception_insn(DisasContext *s, target_long pc_diff,
                         int excp, uint32_t syn);
+TCGLabel *delay_exception_el(DisasContext *s, int excp,
+                             uint32_t syn, uint32_t target_el);
+TCGLabel *delay_exception(DisasContext *s, int excp, uint32_t syn);
+void emit_delayed_exceptions(DisasContext *s);
 
 /* Return state of Alternate Half-precision flag, caller frees result */
 static inline TCGv_i32 get_ahp_flag(void)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index eaeafdf138..d803c10ac7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10411,6 +10411,8 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 const TranslatorOps aarch64_translator_ops = {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f7d6d8ce19..c4dd3a747c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1090,6 +1090,57 @@ void gen_exception_insn(DisasContext *s, target_long pc_diff,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+TCGLabel *delay_exception_el(DisasContext *s, int excp,
+                             uint32_t syn, uint32_t target_el)
+{
+    /* Use tcg_malloc for automatic release on longjmp out of translation. */
+    DisasDelayException *e = tcg_malloc(sizeof(DisasDelayException));
+
+    memset(e, 0, sizeof(*e));
+
+    /* Save enough of the current state to satisfy gen_exception_insn. */
+    e->pc_curr = s->pc_curr;
+    e->pc_save = s->pc_save;
+    if (!s->aarch64) {
+        e->condexec_cond = s->condexec_cond;
+        e->condexec_mask = s->condexec_mask;
+    }
+
+    e->excp = excp;
+    e->syn = syn;
+    e->target_el = target_el;
+
+    e->next = s->delay_excp_list;
+    s->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    return e->lab;
+}
+
+TCGLabel *delay_exception(DisasContext *s, int excp, uint32_t syn)
+{
+    return delay_exception_el(s, excp, syn, 0);
+}
+
+void emit_delayed_exceptions(DisasContext *s)
+{
+    for (DisasDelayException *e = s->delay_excp_list; e ; e = e->next) {
+        gen_set_label(e->lab);
+
+        /* Restore the insn state to satisfy gen_exception_insn. */
+        s->pc_curr = e->pc_curr;
+        s->pc_save = e->pc_save;
+        s->condexec_cond = e->condexec_cond;
+        s->condexec_mask = e->condexec_mask;
+
+        if (e->target_el) {
+            gen_exception_insn_el(s, 0, e->excp, e->syn, e->target_el);
+        } else {
+            gen_exception_insn(s, 0, e->excp, e->syn);
+        }
+    }
+}
+
 static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
 {
     gen_set_condexec(s);
@@ -8107,6 +8158,8 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, curr_insn_len(dc));
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 static const TranslatorOps arm_translator_ops = {
-- 
2.43.0


