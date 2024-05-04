Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E30C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HUB-00024X-Cn; Sat, 04 May 2024 11:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU8-00022k-Oe
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU7-0006Ey-2g
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f44881ad9eso503299b3a.3
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837173; x=1715441973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbgTvqZXx0oV/4QT5gXHywIupzMDjszkzNiZiQWIETo=;
 b=erh5dysrkgPPdSQhwPB6/rL9zUmMaxNFvNmF66mS8e4AM+EOCXfpERBnhRwE1NdepG
 qiPNWZTfwej+JQUOHL/io3dFhzylJkwwPV5xgtwrUVMVkUxkzgyI9q6JzgAjEj69Btng
 hMOaVB7x+LeLD8dtSbfQcPOh4z4oRihxH+r2TQpZu/TSh+ytfvoRcOp9iXNqLMDb/3pN
 N2ePRAoBXELbaXPGUOxKO9evFmmuvcDBv95z5QbpKFfu4RyrSlV2JsPnRawAwedqBmRg
 KVR6prNCYJowCd9AjOyMwG9Wao8RKdozvV3ByQWaMu0Tr06xLnOmz40FIfg+fefPFQBU
 raCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837173; x=1715441973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbgTvqZXx0oV/4QT5gXHywIupzMDjszkzNiZiQWIETo=;
 b=mw16f3JNapHTeoWLNxgr07ADQGq9/pio2a2/mZEVKdaFdGBDLn+DcxzrBbz7Z9/oDk
 FaxiteEAKJWeQMFxWb+tvATQz8f+n5pIk09aapfiwLU3tQwHL+CjsGKO5m3HFG7IkTr9
 B3rMzqzlM7S3uoEPi1mMVBPNIiVeC88U/VFWVIgcpBe9ecHBGEhoK2rRrqQpeMLIGvB8
 +z9/vzaETjxY+CmrBCjD0up0Z6mBrcrK+LLptkgSbyOr20B1KJyhz8VKqm6EHturKBW1
 9tAQx8xLSmP5hh9EXk6PFXviB5Ffgij9lxSgltP4fI/K7vV0iwPTtInTUNqtReEs1Qmn
 Wk4A==
X-Gm-Message-State: AOJu0YxlzVDZdz5ueCJNfW/9bYNOM91GcX7aTVbecYvH8r57fMbVmC1F
 7RCwQYmZP73OcqD5HqhBFalRM63vUjpvGME4vg7T4I5hWBjRbDbCPAQdyQ9zaKyHvtNQnr0KbeV
 k
X-Google-Smtp-Source: AGHT+IEcrE7LZvmWqm/4nV6TT0eMMT9SUnkl/thjmXYfBhhC5YcFa8gi3FuELyGTaSMAjpxhIx3j0Q==
X-Received: by 2002:a05:6a21:164a:b0:1af:997d:1788 with SMTP id
 no10-20020a056a21164a00b001af997d1788mr1216910pzb.44.1714837173623; 
 Sat, 04 May 2024 08:39:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/9] target/alpha: Simplify gen_bcond_internal()
Date: Sat,  4 May 2024 08:39:23 -0700
Message-Id: <20240504153926.357845-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Richard Henderson explained on IRC:

  bcond_internal() used to insist that both branch
  destination and branch fallthrough are use_goto_tb;
  if not, we'd use movcond to compute an indirect jump.
  But it's perfectly fine for e.g. the branch fallthrough
  to use_goto_tb, and the branch destination to use
  an indirect branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 4/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-7-philmd@linaro.org>
---
 target/alpha/translate.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 41151f002e..b7b94cc378 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -461,23 +461,22 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
     uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
-
+    tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
+    if (use_goto_tb(ctx, ctx->base.pc_next)) {
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         tcg_gen_exit_tb(ctx->base.tb, 0);
-
-        gen_set_label(lab_true);
+    } else {
+        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+        tcg_gen_lookup_and_goto_ptr();
+    }
+    gen_set_label(lab_true);
+    if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(1);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 1);
     } else {
-        TCGv_i64 i = tcg_constant_i64(imm);
-        TCGv_i64 d = tcg_constant_i64(dest);
-        TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
-
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
+        tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_lookup_and_goto_ptr();
     }
 
-- 
2.34.1


