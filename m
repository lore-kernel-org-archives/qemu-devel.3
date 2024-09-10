Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92438EE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8L8-0002Vi-EX; Tue, 10 Sep 2024 17:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8L6-0002OK-K4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:23:56 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8L4-0001w4-Vf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:23:56 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d50b3a924bso1829397a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726003433; x=1726608233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01lwJ9Gr+H9sJT+0AX6EZ1yccgfrQ4/iKAP835gU7Qo=;
 b=CtmDFd6qjY1Mja0exxyRFH4UkugAF9rVC5oLiTERgDb8P71Wr1Ez0jQEIFvx4AL4eS
 QTi8TfEb1myi51AuHHMk+3UVhZnMfeJhWr5/GIi705qxkDGkEe+DQ7dp/Dbe2Eig2Yku
 MaB2wc/sGzC1c5Kf07PIc+JXoAkTGwxjJppHXsNX+lS6m3NeOu4GI+QlkgSs2vIycv1P
 emQ3KV0fmmX171qHZIaCIsezNifdKVPYFDD654c6XsTmshWpNzZLQJW7x5svFNsMIXio
 dhsk7QZ1n5pI0H+Xnfu1JNEt2EBV4IaCpp0xpcG5U+8u8JmhwafJz4wlwdBf0YWn0W5+
 /eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003433; x=1726608233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01lwJ9Gr+H9sJT+0AX6EZ1yccgfrQ4/iKAP835gU7Qo=;
 b=brFBfx99thdCm21//E+u5fm1ZrCmGPc37helRRa0EEQM2Wvtqx6Ippiy8tnz6bCJj4
 NoIcqCy9x5s7L1nq/g+R8OlDOQJYcKS6bQnK3KFZtg3RiajqOnGTcj1blAYdXZARPqz0
 Xl3N8uZFX6f1ziNjbnVECl03o2NduJ+4boeSY3fBt0S6ZAKQoCcoN9x/DivQxuLV2/Eb
 6jWNYHi/HbtDcRtyJbpj7eFyweQPjXYEYxz9TXY2S6jnbupWsT+ocpnKxbdmWZC7v6p2
 f8OtXUTGWZHlToiRxEp2hwxGsRG2lhusKjpcGs/kSVpjFxOMAhfrUAtsXTc/IvN2q3F8
 VHAw==
X-Gm-Message-State: AOJu0YwgEnxWH91/ijAxfszw44s7YIJyt8AHFp1X9MK2qYwKuiUhS01J
 S7l9JaHZ7qkD7Vd3M39QvhX2/b+xT1RgeFvU27erigBmN5Pcgn/Lm5OYcz6J5Fj/MP+9e5LMiVz
 e
X-Google-Smtp-Source: AGHT+IFf1jyzgIiahqVM3Nh+0TqgHqHzy4KcXphuaLAGvu0vufWKBeMHGmS1nzB9OK9fm1BbLT1kxA==
X-Received: by 2002:a05:6a21:4581:b0:1cf:287a:414e with SMTP id
 adf61e73a8af0-1cf5e0322f5mr2888823637.1.1726003433453; 
 Tue, 10 Sep 2024 14:23:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d825ba616bsm6089661a12.93.2024.09.10.14.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:23:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 1/2] tcg: Return TCGOp from tcg_gen_op[1-6]
Date: Tue, 10 Sep 2024 14:23:50 -0700
Message-ID: <20240910212351.977753-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910212351.977753-1-richard.henderson@linaro.org>
References: <20240910212351.977753-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 12 ++++++------
 tcg/tcg-op.c       | 23 +++++++++++++++--------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 52103f4164..8099248076 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -92,12 +92,12 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
  */
 TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
 
-void tcg_gen_op1(TCGOpcode, TCGArg);
-void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
-void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op1(TCGOpcode, TCGArg);
+TCGOp *tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
+TCGOp *tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index eff3728622..28c41b37a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -37,38 +37,43 @@
  */
 #define NI  __attribute__((noinline))
 
-void NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
+TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
     TCGOp *op = tcg_emit_op(opc, 1);
     op->args[0] = a1;
+    return op;
 }
 
-void NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
+TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
     TCGOp *op = tcg_emit_op(opc, 2);
     op->args[0] = a1;
     op->args[1] = a2;
+    return op;
 }
 
-void NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
+TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
 {
     TCGOp *op = tcg_emit_op(opc, 3);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
+    return op;
 }
 
-void NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
+TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
+                       TCGArg a3, TCGArg a4)
 {
     TCGOp *op = tcg_emit_op(opc, 4);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
     op->args[3] = a4;
+    return op;
 }
 
-void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                     TCGArg a4, TCGArg a5)
+TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
+                       TCGArg a3, TCGArg a4, TCGArg a5)
 {
     TCGOp *op = tcg_emit_op(opc, 5);
     op->args[0] = a1;
@@ -76,10 +81,11 @@ void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
     op->args[2] = a3;
     op->args[3] = a4;
     op->args[4] = a5;
+    return op;
 }
 
-void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                     TCGArg a4, TCGArg a5, TCGArg a6)
+TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
+                       TCGArg a4, TCGArg a5, TCGArg a6)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
     op->args[0] = a1;
@@ -88,6 +94,7 @@ void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
     op->args[3] = a4;
     op->args[4] = a5;
     op->args[5] = a6;
+    return op;
 }
 
 /*
-- 
2.43.0


