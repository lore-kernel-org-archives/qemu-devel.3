Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BFECD129C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8K-00026p-Js; Mon, 08 Apr 2024 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8J-00026C-58
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:15 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8H-0003jS-Ib
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:14 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso3494366a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598609; x=1713203409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPbK/NhQe1+jKC23+AkIKSjI/CWiYdFRaJAq7oh1b28=;
 b=XHhQNqU+r4ZzMspwRKdTg6bRyA11cdq5IIHYuJA/PO/CgSFejOQ/v1bYbqSY8hg9iG
 24pXzG3RSe8LdGJK5So7DHidLY7y+SErAG7rJBa3SGeFTwGHm2kINxX5KZGls0i5VHoN
 vLby71Y1b7DnCf2co7ALE1iRH7jZbediGM4+Q1W60JZr0+7Al7xXqCu4gaVwpAZxpV9B
 lUq7OBZ3vXB2z6TP3ZZO7PVdgH7g/si/Jggm2S0enJDkhXL/O4XFXWQd4OBksfuAnzrJ
 xG6zAfCS3w051rItYdeBYgQUn9ofyV1fgOfjvLRkCXZV42sU2cMezLRymxRUfmWJtaz2
 gb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598609; x=1713203409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPbK/NhQe1+jKC23+AkIKSjI/CWiYdFRaJAq7oh1b28=;
 b=f303UYJ1SNlyo1LuLeUK5GwnnsPaH2pa/6KroYuBYffuaIwTVirmJEeBKpbN820tK5
 d7llg0IGF02fArpSW6em+IKCn4ToQaj2jsAw2vYOvfqrIWpOx1lJSET7PbV3VyJT3Iv/
 TVlfkc5ayAirIJRr90modqgCeDSrBTeWx0wZsI4glrXMl+tucnRGGo6kJHOE7kwP3YPh
 9M0UkuU/qVimFhmzyE1FUW+JX0qa8GBsHPIVhwkmQd4I+my7NZVinFJ7CHhQvUzTpAlj
 topHQuT/3C1w78kPUgXRqE6q4xTGYID+UbxsR6ZKcURfIk6CJwYzMP5hvidevIFrvFae
 ca3g==
X-Gm-Message-State: AOJu0Yx2xIIhFXHbI5mF8JwcaudiE0mQiPwt5hnM3Uvvv6WEZ5gi3gQi
 CZqOn4sGCDjF0gLdG96DQEYRxLAdFzi6TucBppeOkQqVNVsfteNd9SRhQS7bKdfazNvVv1wmjdX
 F
X-Google-Smtp-Source: AGHT+IHZ5iLGSVMmRQzPIlVv09kcMBabu8iUb64wVF4aBJlT3dSwtc9/Nu0B9bLtUoAzErwnBIvf6g==
X-Received: by 2002:a17:90a:e601:b0:2a5:222b:b776 with SMTP id
 j1-20020a17090ae60100b002a5222bb776mr3099303pjy.34.1712598608789; 
 Mon, 08 Apr 2024 10:50:08 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/35] target/riscv: Use insn_start from DisasContextBase
Date: Mon,  8 Apr 2024 07:49:19 -1000
Message-Id: <20240408174929.862917-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9d57089fcc..9ff09ebdb6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -115,8 +115,7 @@ typedef struct DisasContext {
     bool itrigger;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
-    /* TCG of the current insn_start */
-    TCGOp *insn_start;
+    bool insn_start_updated;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -207,9 +206,9 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 
 static void decode_save_opc(DisasContext *ctx)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 1, ctx->opcode);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
@@ -1224,7 +1223,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     tcg_gen_insn_start(pc_next, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.34.1


