Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C74BCD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGc-0000bd-3f; Tue, 09 Apr 2024 15:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGa-0000av-Px
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGZ-0004ee-4I
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e3c9300c65so34837365ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691382; x=1713296182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHgrMBfJl0EWko+KOSUm9E0b6yMA9Veb8odtrLbxwoY=;
 b=IEqn9q4mI7uGEEJ8Bwg0zenUgpV5E8P3xggkUB6+c0qc/04iha6C7W0R1PC6Ac7tjZ
 aAZQiNKmSdOFVoGEU+jUeRqcrq4RGu2/c51hc86oyEYt+PhODRBNzt80A9q79a+tNlbe
 DNmeFvRe8s7dzsx3/4itAWIzNv9caW9J6/YZGW7SUl2KEo6brYUk4SkGuhN5qK2m0M0u
 O5VsheCPWSRau8ePLnQB7+i4QcKBZ1crrF8xRqCxcNEnAe8HDgNv1TnSxSKEE6m7nsE/
 sPmdgvCKXCPMJF7tzIYbAEm93yasvU3hu7Kyo06kzqbtacB56156/LT4dkr5K+bfO8YG
 JpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691382; x=1713296182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHgrMBfJl0EWko+KOSUm9E0b6yMA9Veb8odtrLbxwoY=;
 b=F1mla7Qmk++vjGB+eSfh2TIzpInReSzpvSHKZX2XPHfqPhQsslOz8+0OFSfubbfTLx
 Yv+Gayj78hlfoNp4L1IxAtvL+lmAbgjUu3likIh+KYpdvLCfqqViQ0lQKV7tGTkpOKiF
 w9C+XFlEBTogUNuPizLI+VHpQ+N4w+R3VRyfsAghsaLidGwKD7bYeqzfnfOoKBpFA8g/
 l2+mMK7sb/NWDfQXYHGOq97t3uZ/LuMLIWxmU7KW1LZ0KeJ3K/tjYZ9pm2QpeEfe63wZ
 Hw+JNX3T2Yl7+VpBX6rKUu5zlOgSNqkomlDJ/DwBsEdNNBCAQNxwDd9wc9CpGFACtNH7
 FjCg==
X-Gm-Message-State: AOJu0Yx6oRUARM5Tpany3MU4rV83orT7XjdNFWm0rMAkbyrwsw5aAmYc
 jvJhA6RkQWpyvx3jMrv1AmM+QfQVg7TI4j181dw4IN0fmEKYTzCBhu5rOqOKAQIwZBITg/oqPb1
 /
X-Google-Smtp-Source: AGHT+IH6TxCz3cdypLbClYrbnLudYiz+8L23oa+aPM2OS8LOkXk7abRJ6KYaSLr5IFJ82xOzi2GVYw==
X-Received: by 2002:a17:903:41ce:b0:1e3:e081:d29b with SMTP id
 u14-20020a17090341ce00b001e3e081d29bmr808905ple.45.1712691381899; 
 Tue, 09 Apr 2024 12:36:21 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?J=C3=B8rgen=20Hansen?= <Jorgen.Hansen@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 11/20] tcg: Add TCGContext.emit_before_op
Date: Tue,  9 Apr 2024 09:35:54 -1000
Message-Id: <20240409193603.1703216-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Tested-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


