Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5B8CD1292
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEap-0003M2-HF; Sat, 06 Apr 2024 18:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEan-0003LQ-1U
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:57 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEal-0006fI-Ft
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:56 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso88444b3a.1
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442774; x=1713047574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK1v+EiguMoYRGbIEG8BvH+kU+PSbAC8gTglH1oJQN4=;
 b=C4JMonpkumYVHLLy8PcAPHvlDkFbTuu4KReUjuHM2x06qsvQLQReyP2pHiBICV6V/w
 RSx2WE+ys6JuTFmPSmtlSKkRD163f/lSRLXSlB4XiinVyc0Tmeea3VZhbeGNL8DYNty0
 E+dOIQAq1Qx+w3mEa/i1MDPc//ebfMlDCKYrb7MDXmEwzpVYrJCVgozaPWHSKfocRqm0
 l98y7VQeTkfsHq9s1h2UeWkho5QfRUl/wL8nrWzqo9om0YyNUuNSA6btyK2jSs2q2V28
 EhTkyPcflkatkt6mElHp6rfTxj/6ql4THy3qKJ+rEHkyO6BUkPPZqyZyGvV1mqvFZ49I
 A1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442774; x=1713047574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uK1v+EiguMoYRGbIEG8BvH+kU+PSbAC8gTglH1oJQN4=;
 b=KLMZu4XQkqXqWTyyIG3h6AChobt9GqVq35g/ovZNMwl4HU4FRDnz35PtWfQ4w7snGv
 ZCbUPTf7w6Qk+TU0c+vkSKRF6ZKbNjPDj2irYJcHPTCoqOGI0wiIgGCj7xBmqn84YY4f
 dfFPjKy5ouZUmyv5h3I+QpvnlDJjHzXyRKAwMyaegXQ5I58J7N5GcRUnhXVXMybc6TkQ
 7h0YkG7Y2hinDfqS17CiIXvrf518jYjrsUj9xLuXASJXEHyCm7JL1pRTyfOQbGjOE+kW
 0kYBO5Jz5n3OowMCk1iXyoi6lodo/x+hpPzVNuWWr5can6JMxUm6KsfJq/TZaJ603ccd
 k10w==
X-Gm-Message-State: AOJu0Yy7uAKwb8dsO9U8QMKSc25g55Q7msu0fG1nYQkXfmNxSkDodwPY
 evobkhVFW75t6I+Wnh6MLTQOxjODaYaEriwZhZwsS8qPxFbbSaNKouAz+rV4RToN8UCrEofkK9O
 5
X-Google-Smtp-Source: AGHT+IH4KHGnntIWZ+1epoLd26bxOo7aYk4QCzq7PsjdzeFlPnpZnPzhBgELI5mCBj3KEO86RynA+g==
X-Received: by 2002:a17:90a:f683:b0:2a4:b04b:d204 with SMTP id
 cl3-20020a17090af68300b002a4b04bd204mr2799489pjb.7.1712442773854; 
 Sat, 06 Apr 2024 15:32:53 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/9] tcg: Add TCGContext.emit_before_op
Date: Sat,  6 Apr 2024 12:32:40 -1000
Message-Id: <20240406223248.502699-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Allow operations to be emitted via normal expanders
into the middle of the opcode stream.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  6 ++++++
 tcg/tcg.c         | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 451f3fec41..05a1912f8a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -553,6 +553,12 @@ struct TCGContext {
     QTAILQ_HEAD(, TCGOp) ops, free_ops;
     QSIMPLEQ_HEAD(, TCGLabel) labels;
 
+    /*
+     * When clear, new ops are added to the tail of @ops.
+     * When set, new ops are added in front of @emit_before_op.
+     */
+    TCGOp *emit_before_op;
+
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d6670237fb..0c0bb9d169 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1521,6 +1521,7 @@ void tcg_func_start(TCGContext *s)
 
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
+    s->emit_before_op = NULL;
     QSIMPLEQ_INIT(&s->labels);
 
     tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
@@ -2332,7 +2333,11 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
     op->args[pi++] = (uintptr_t)info;
     tcg_debug_assert(pi == total_args);
 
-    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    if (tcg_ctx->emit_before_op) {
+        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
+    } else {
+        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    }
 
     tcg_debug_assert(n_extend < ARRAY_SIZE(extend_free));
     for (i = 0; i < n_extend; ++i) {
@@ -3215,7 +3220,12 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
 {
     TCGOp *op = tcg_op_alloc(opc, nargs);
-    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+
+    if (tcg_ctx->emit_before_op) {
+        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
+    } else {
+        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    }
     return op;
 }
 
-- 
2.34.1


