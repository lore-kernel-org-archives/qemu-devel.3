Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A71EB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzub2-00074N-6e; Tue, 10 Mar 2026 06:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzub0-00073t-9r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuay-0005og-OT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso34091725e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139547; x=1773744347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sz4Zj3xRZlzSb5pL9wYtWvSc/eh/YqpNHjaGsP/aUlo=;
 b=Ep/aIq7etFVg/h9ecFnQL0cotCoc27CH9oL34hCx2XT4MlV155roP877iM+KCV7Iqi
 FnjSlizwt4UkmMyKcbJ/gRxJflS+LGs2VwfU5UAu/WzrG6UsITc7vIBu/QQW9W+sthox
 nlRJXM+iIzD8mzjXImxezCIXwHHyUGATb4naGpcPW44NxLR0AC21nw/1C8k0SVFY6fhe
 rXujN5bJjFNV7pjggPniTdMUh78KuqDo29uAEGz/r/Bl/pM+qb+Cz+ozm+bn1Od1F/eu
 NTflyXo0zsheG/uR3OAUUPdWMRgh6lkVI5Yz+D3bD87CduuqEu5BIe3lsP64sEXwVDXG
 /fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139547; x=1773744347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sz4Zj3xRZlzSb5pL9wYtWvSc/eh/YqpNHjaGsP/aUlo=;
 b=mMt0OOzQ4t46gCK6sh5JXWaTATO/vpsG1I0he0Q/ksg77rs4jRynahsKR7SZCEnEbX
 B2993HTNTvQWMHsyDhKqh9ZaxVYPDkUAXegCXl0V5KtX5SVjr+GOQALzhWAa5htXhCns
 XnbWEHP1FMwkNtdsTsMsd0Jdq9Zr9WGuBdattUacxt8h9dm0qKERFATJQmzOjCcWvdn6
 3uLNHhyiI1L+usFlpf/dy+84REMNsGIGp8G3ooEHupJaEmv+Ta+5S+tkmzSGewx1OHmY
 dVgOric2mF3smYC+iXYPu+aFBp5oWou5nKI4ksSpUeG+4pHajvrZKWPkou1j2659sXC7
 EDgg==
X-Gm-Message-State: AOJu0Yxz24SP96AZsF6urCVMVp9QJUSoPviQda+G2GVyF1Jae1U7ZuPc
 wKLfaNZlZegAguIivH/yi3wPbx2TEOBTr0iuiQNYBs+8lQ4unSoLPfZRU1ezPjg99JpzLqN8lop
 43hWPKxE=
X-Gm-Gg: ATEYQzzkB6iX5vx8Kn4Ll0DOtmUsRP1/xJpNyYCvISs8XqLqr7cRlkCfpavcNB1InUc
 xa0rGX23pBWdXDZT/1WSot6yT1+EkIeK14q3Gr25GBbaw71u25I3gwxn4/mj9ifQOyDXPeljs9d
 xb2SqrNAz+j2wl9AnkPca8B9cKnjIWWEUJ8eFi3/eeGdpytG0nsu/Fzsl2xejR+EtXaVUFo8a4U
 j1dmLGb7ATyhKOm8in94Pm65k0DOurN7ylQ2E5ilyP8tqUf0LuuQhBXhMHoAYVOz4K7E5tkPLYb
 OJDYnU7jTa23PRoMVQk4W+/ICccJqML8oohiSx/2nGdeYPK5s/YAG3Ob5x2WA9zQAAVPLUVz2am
 crdp4jvvPhH3g53t40KtADjJwviM4gRIVjt0IdbdaIOvHeq+Rm7drL+NSvCe8+b7g1b49+TXV6V
 k7ZRnaq1N78nlthCUBKFNvHuzGS7/C43GmDNKZvGlbPIp/KZ/fWd31L+ErdgQ+JDPI4CnuEjTr
X-Received: by 2002:a05:600c:350a:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-48542782901mr41600815e9.6.1773139546824; 
 Tue, 10 Mar 2026 03:45:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ad1e4esm67752005e9.8.2026.03.10.03.45.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] tcg: Add tcg_op_imm_match
Date: Tue, 10 Mar 2026 11:45:00 +0100
Message-ID: <20260310104511.12670-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Create a function to test whether the second operand of a
binary operation allows a given immediate.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[rth: Split out from a larger patch; keep the declaration internal.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260303010833.1115741-6-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-internal.h |  5 +++++
 tcg/tcg.c          | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 26156846120..c0997ab2243 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -100,4 +100,9 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
                            TCGOpcode, TCGType, unsigned nargs);
 
+/*
+ * For a binary opcode OP, return true if the second input operand allows IMM.
+ */
+bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
+
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3111e1f4265..2ca44766f64 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3387,11 +3387,9 @@ static void process_constraint_sets(void)
     }
 }
 
-static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type,
+                                          unsigned flags)
 {
-    TCGOpcode opc = op->opc;
-    TCGType type = TCGOP_TYPE(op);
-    unsigned flags = TCGOP_FLAGS(op);
     const TCGOpDef *def = &tcg_op_defs[opc];
     const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
@@ -3418,6 +3416,21 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     return all_cts[con_set];
 }
 
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    return op_args_ct(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
+}
+
+bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
+{
+    const TCGArgConstraint *args_ct = op_args_ct(opc, type, 0);
+    const TCGOpDef *def = &tcg_op_defs[opc];
+
+    tcg_debug_assert(def->nb_oargs == 1);
+    tcg_debug_assert(def->nb_iargs == 2);
+    return tcg_target_const_match(imm, args_ct[2].ct, type, 0, 0);
+}
+
 static void remove_label_use(TCGOp *op, int idx)
 {
     TCGLabel *label = arg_label(op->args[idx]);
-- 
2.53.0


