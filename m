Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6DC25B5C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HU8-00022e-Be; Sat, 04 May 2024 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU7-00022Q-Kn
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU6-0006Ef-10
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ed012c1afbso4635635ad.1
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837173; x=1715441973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vY5Eou1jVTje6BF1WY7ML8aaACS2Ol4ajRC2WX0h/bw=;
 b=zm738Ekez1vsqoj2eIJcAYR4FiuHUSAfjXT3VKJY4kE3yfzl2et9TqyQ7ZY3Fl3cA6
 Na+SLQsGFS7W5fSQTpJEVLGWN23nbLj6dUZfrsiaH7XjWa4EsObImx73Q60c16aTGcpn
 XoqJT1VA522jMs0AG52Frc1qejKxGYBaI2dGA608rVoMJE7XFiIWHYD549+X+5U3Wnwn
 hnjhjylc2DPaBQgLJblu//tRqNnu/v0uVWVf0pur0uz5iAMKzSc337IQDYQh8dzAcI6Z
 dmtFwvF+OTyTUOkYiI129NepGh7xu8Hh5PybDmalfEss13knJoGDcUDLbPvyYi3Ah8SX
 dWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837173; x=1715441973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vY5Eou1jVTje6BF1WY7ML8aaACS2Ol4ajRC2WX0h/bw=;
 b=YntijcJf5iKjUOQGdDQCaLtRokSwDqXSs5udJHYuQHT64JD0pLxHASeMj8am9vMp9G
 f/bjJDTUibimNX3yIiyip+csMIEIYnpNsMYBOj0v/A08dov1pEFzW7uU6X6rZqxCi42F
 52rW/Ga5+0fi5O37KOOKRZJhejSsE5a4+I88YvzY5p8q2v5PcO3JV+0SA7rK+ZzjkV17
 FRR6gAwXMkd2az49AT/dxg3TIGLSdJxpjI5wwcHDkgsCkGO6Iv97jZKRBpNauJz+SddX
 RbyBMBTKU7Pn6OYDojVgdmsEyB3x78ivSSBk3VD5HluYzQAB0Ql3Urq1/7oT6kQTb9fM
 umhw==
X-Gm-Message-State: AOJu0YxfzD+ElFAxJGdeZr3RMWQxKqLBr6KHEIMbO2gb8WKJa7nuEb2G
 NwMnUBscVAslhAzB8lYSEjFqEOoyml+8mNzOt3ku1SlF3qexiCq+GckxnGD8mNqClBab3Hp73SS
 0
X-Google-Smtp-Source: AGHT+IGNf6AMSmVZURg5RaJkf/UMKL+2ohwbYq6HNNXoNFPoR/CClbz4qaCdMOBv44TMEbsZjICOKQ==
X-Received: by 2002:a17:902:f605:b0:1e8:682b:7f67 with SMTP id
 n5-20020a170902f60500b001e8682b7f67mr8654821plg.29.1714837172718; 
 Sat, 04 May 2024 08:39:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] target/alpha: Return DISAS_NORETURN once
Date: Sat,  4 May 2024 08:39:22 -0700
Message-Id: <20240504153926.357845-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Trivial change to make next commits easier to understand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 3/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-6-philmd@linaro.org>
---
 target/alpha/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 01914e7b56..41151f002e 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -447,12 +447,12 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 0);
-        return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_lookup_and_goto_ptr();
-        return DISAS_NORETURN;
     }
+
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
@@ -472,8 +472,6 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
         tcg_gen_goto_tb(1);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 1);
-
-        return DISAS_NORETURN;
     } else {
         TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
@@ -481,8 +479,9 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         tcg_gen_lookup_and_goto_ptr();
-        return DISAS_NORETURN;
     }
+
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-- 
2.34.1


