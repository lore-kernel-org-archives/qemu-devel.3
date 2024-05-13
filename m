Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E899AC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QR3-00055U-9x; Mon, 13 May 2024 03:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPT-0002va-Ho
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPM-0001P4-MK
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4201986d60aso1691605e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586459; x=1716191259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eissEZfbvjUIHa56B6rsG+Z6yFq1Hi6OaQz39ftd2Uo=;
 b=LxL1L+H4S2RpDxUjJja6TLbyCztXkC3qwWwxzuKB73g4lo8X9mTSypA5wsSLETMPi9
 CsADXBrl1lv8w2DOctLn1qbaz6itZlmmrHqmGWCQCk+f61Gh9rKN2nJUK4RzdbK1voFg
 Wy/4xLY1iNM3IcuXyj3vOaE8Jtlb8IgKKK7nAcQdymMnjaY1z24zXrm8uZSZCeEMdtJY
 EpVVGTwglvSHlZV/RA3MO+Udlx8CSGOs0RnAcExf9EtNkkylkihbK4QastpUiiXL35nZ
 f71XyYXytlfOInjyulmi97Jy+dq8kLsIaXBToL4j8JX602e3r+Qy1tVNkGTNy6L+GKEs
 DMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586459; x=1716191259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eissEZfbvjUIHa56B6rsG+Z6yFq1Hi6OaQz39ftd2Uo=;
 b=C+g/oHjO8rorzzyCzZrmrsgoHiKHfjshK11ZOrC7rVKnJD1YT5EURqKzzyoPmr4sN/
 SWUuzoDqAYwBbi2/JClJmHjmOJKPUlx01fzyW/F8AvG7KhtncLfKfmCJgbsxvTBk9Ha4
 9I+NupyiAS8lqzUT5endRSYQfXZPmS80zkn5AMqyrpFLFsSWymaqfegU65y0iQnglHjJ
 KqRxzqvAhKMFEMa83b08VNsBHAcC0WAPj43QSk2Xs4xKki4/V5By6CcTwGDXnCvoFAUO
 RfhFmyTpk8oSTpZA+ZnwiGgpjz6opoNSBFWB4PgmQ1Qu/+PSWP+C92OtwZPyNbK+I8ia
 4yfQ==
X-Gm-Message-State: AOJu0YyncHZFBLzkA0+HrEmQlBlsfBKBRsofPuCwYeS1PMd5SjFyewTX
 WPoom102tdbSo51/nhFv/nzSmfXYjiHO4f/jwFIIFMxKK2cxmkgZeSkJbkdWDzGS8BDuySTGWwt
 Mh5s=
X-Google-Smtp-Source: AGHT+IGCdJp+xDsX05a+9USjxle47vdjubtLXJ5KYLdk5cDHbvjE0rPa2OoHltvlkBMIEPXM9zonjQ==
X-Received: by 2002:a7b:c4da:0:b0:41e:1f78:314d with SMTP id
 5b1f17b1804b1-41feab42b5emr63487715e9.24.1715586459326; 
 Mon, 13 May 2024 00:47:39 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 28/45] target/hppa: Introduce DisasDelayException
Date: Mon, 13 May 2024 09:47:00 +0200
Message-Id: <20240513074717.130949-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Allow an exception to be emitted at the end of the TranslationBlock,
leaving only the conditional branch inline.  Use it for simple
exception instructions like break, which happen to be nullified.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 60 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e06c14dd15..e75e7e5b54 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -51,6 +51,17 @@ typedef struct DisasIAQE {
     int64_t disp;
 } DisasIAQE;
 
+typedef struct DisasDelayException {
+    struct DisasDelayException *next;
+    TCGLabel *lab;
+    uint32_t insn;
+    bool set_iir;
+    int8_t set_n;
+    uint8_t excp;
+    /* Saved state at parent insn. */
+    DisasIAQE iaq_f, iaq_b;
+} DisasDelayException;
+
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
@@ -66,6 +77,7 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
+    DisasDelayException *delay_excp_list;
     TCGv_i64 zero;
 
     uint32_t insn;
@@ -683,13 +695,38 @@ static void gen_excp(DisasContext *ctx, int exception)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
+static DisasDelayException *delay_excp(DisasContext *ctx, uint8_t excp)
+{
+    DisasDelayException *e = tcg_malloc(sizeof(DisasDelayException));
+
+    memset(e, 0, sizeof(*e));
+    e->next = ctx->delay_excp_list;
+    ctx->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    e->insn = ctx->insn;
+    e->set_iir = true;
+    e->set_n = ctx->psw_n_nonzero ? 0 : -1;
+    e->excp = excp;
+    e->iaq_f = ctx->iaq_f;
+    e->iaq_b = ctx->iaq_b;
+
+    return e;
+}
+
 static bool gen_excp_iir(DisasContext *ctx, int exc)
 {
-    nullify_over(ctx);
-    tcg_gen_st_i64(tcg_constant_i64(ctx->insn),
-                   tcg_env, offsetof(CPUHPPAState, cr[CR_IIR]));
-    gen_excp(ctx, exc);
-    return nullify_end(ctx);
+    if (ctx->null_cond.c == TCG_COND_NEVER) {
+        tcg_gen_st_i64(tcg_constant_i64(ctx->insn),
+                       tcg_env, offsetof(CPUHPPAState, cr[CR_IIR]));
+        gen_excp(ctx, exc);
+    } else {
+        DisasDelayException *e = delay_excp(ctx, exc);
+        tcg_gen_brcond_i64(tcg_invert_cond(ctx->null_cond.c),
+                           ctx->null_cond.a0, ctx->null_cond.a1, e->lab);
+        ctx->null_cond = cond_make_f();
+    }
+    return true;
 }
 
 static bool gen_illegal(DisasContext *ctx)
@@ -4696,6 +4733,19 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     default:
         g_assert_not_reached();
     }
+
+    for (DisasDelayException *e = ctx->delay_excp_list; e ; e = e->next) {
+        gen_set_label(e->lab);
+        if (e->set_n >= 0) {
+            tcg_gen_movi_i64(cpu_psw_n, e->set_n);
+        }
+        if (e->set_iir) {
+            tcg_gen_st_i64(tcg_constant_i64(e->insn), tcg_env,
+                           offsetof(CPUHPPAState, cr[CR_IIR]));
+        }
+        install_iaq_entries(ctx, &e->iaq_f, &e->iaq_b);
+        gen_excp_1(e->excp);
+    }
 }
 
 static void hppa_tr_disas_log(const DisasContextBase *dcbase,
-- 
2.34.1


