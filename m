Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35FCCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAA-00022Q-18; Thu, 04 Apr 2024 19:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsW9z-0001zA-Cw
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsW9w-0007hK-SC
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso1141310a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271975; x=1712876775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK1v+EiguMoYRGbIEG8BvH+kU+PSbAC8gTglH1oJQN4=;
 b=YUHvzM7Fp4AY4HEEPmkT80jDSpOTwkZHWs5BK7Ifh5Y/Qx7dcxEhtEmm3zIOzFomqE
 2RZBO9cTP1ykK3CCQveyjXxAWij0BiP6lSRkg18jel3RaoPylNuhvKUGPb+54qhPnIZI
 Nd8E+4WygAPqCkcumBwre/iXBKH0wCo/i3B/gZqz3tqpFw19rHPDXBgY7PuZJVHgZ/qi
 ISMt3n/KxazpgYgyZeCyHKM9lmHSIG29fzGbWgLzb9ydLyYIupytMra/QRjWzjEOH7lf
 1tK5zbw1fUaw/wVjpnMkS/LKCOKZ7PL45q7ab5hJzeGvSM+zUC1LpZ+ge0jXsjo4wP9/
 wj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271975; x=1712876775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uK1v+EiguMoYRGbIEG8BvH+kU+PSbAC8gTglH1oJQN4=;
 b=JTV4+vOpYIXtcZah1iYHZOmfowWaxvgpO/97CM2fAp+4yACMyp3Zh/cAcQY5LhxFpG
 6cf6GQSmMMcsjU/vIWYRc5+Eg2Pb0occvMdabsU0w0SBGi2/rFKCq/6u5RjuIiNtyep9
 jYT9jkCA4hqAamXywXz2Ha/HrIT20GUm96t9YeC0lIGfdNQFc9+2Yz/6owfrSsQKm9Xi
 aLJQXlBYgyBf8w5X+tGzyFMTI/bMTFUxHT/AGuElW4Xk/KlRHGl5YIWd+B9uIQs+Hlgr
 iXxIa8vKSl2ACN9ndTq4Op3u5ZUBNIaQohUMy1W/emVbYvq3WHjzfomFXpVABggxpEac
 NmQA==
X-Gm-Message-State: AOJu0YxuJaaWWeaHQLpWY0DuM2c8WIkHMENaVDqhY86qs6PZT5TLt/El
 MyTDJgHgXgP6tWlCQeyYdMS6Atdh6HLVIjhol2S5mYMj3UYq5GTz44NZ7ReYgNo9w3YpJWAl2UL
 x
X-Google-Smtp-Source: AGHT+IEkjx8WSEsbHTbpNI2ceyxzn89QLcL+5u0+PLdHHz+W7m3ndbwZgc8NoIJmQh+MRjmpNM0ysA==
X-Received: by 2002:a17:90b:90f:b0:2a1:fe2c:75e9 with SMTP id
 bo15-20020a17090b090f00b002a1fe2c75e9mr3840524pjb.42.1712271975071; 
 Thu, 04 Apr 2024 16:06:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/21] tcg: Add TCGContext.emit_before_op
Date: Thu,  4 Apr 2024 13:05:51 -1000
Message-Id: <20240404230611.21231-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


