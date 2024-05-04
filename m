Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E7C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HU8-00022f-EL; Sat, 04 May 2024 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU6-00022E-S4
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU5-0006EU-8d
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:34 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2b12b52fbe0so433244a91.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837172; x=1715441972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fi/ZQeRrecbB7BBaXRi3+3SwPGSOgsgXACvVx9J1knk=;
 b=uGpEVFSSEr8060cP509cO+f4sPuHs+61OeLKLcmndJaneWGPUcAcYvrjRXF+n7M2XK
 pO3EprLaXPujlCOdCUoD2qAiluaOjhhNebN28oEJ3C7qBagfIXb25nKc5DTqhg3fTiS9
 kh5EEDQdGkce/sD1hLtUoKrN2RdsuRJHANcg0g9Ur6hb8Wz/K5r8lbrcrnycZ2O2xNvg
 veTlY/eKbKSQCMINRzN8Pf9hyUcSNiXEDWyjZFTiA/KkYcMWo0e0730tL0ffXL9gCgtU
 VuNBhCJAj7M49IYzpxXlTlqyRXhAEHkp9kNDCoytSCwO1+ImiBIOpwO8q2J1vFdQTaxN
 JdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837172; x=1715441972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fi/ZQeRrecbB7BBaXRi3+3SwPGSOgsgXACvVx9J1knk=;
 b=hSI3C05QS4+fiCOgTxrvDk2eHTSlra8UotxkUyl+jcTkJi9aqUDY2tV4mkGiiOqiaE
 nqY3HkeUW4kgTOlyGgYg4b7fy8189/poGf7D8YP1P6nPCyZKR/H6SxxiLM4LU7G+12sJ
 90aNU3YQdjFuyw0OFYTgkeqa5rvCMkayF38ZB42toAJG0oGQokjRRDXkWa/VEWQkND43
 P3W2qoHg3tBGOFgxcV+zHpi/kKVlzyYZ/d0W3zOGm3w9nJcrMVU8EyBkSs9OFVXm4Xt3
 FBJDUus1Gr7IJOfiu8lTOzMQpWuwdUt+MiZJ6ItvuIVBWkiJ6InDA/NCO+OuGoIgigul
 fiWQ==
X-Gm-Message-State: AOJu0YxhNVmHRBm1NUGgXdQThyYv+hr0BVkeDNoueXbdBMpF2m1Omb7l
 zglpx99UDd1Wh4SbIgHBDtmc6LN3pA9FvTWRW0dhRBvgIaG7iZNEXHksv+IFe6T6zFPw0D5Ge7m
 0
X-Google-Smtp-Source: AGHT+IG/hzdw5QCUao4sdoXVF0FENHoiHnoJROWBIlnUDLQRv7rt+zJGfwwarl4+o9JEA9QkQg3AEQ==
X-Received: by 2002:a17:90b:684:b0:2b4:329e:e373 with SMTP id
 m4-20020a17090b068400b002b4329ee373mr5941195pjz.6.1714837171872; 
 Sat, 04 May 2024 08:39:31 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/9] target/alpha: Inline DISAS_PC_UPDATED and return
 DISAS_NORETURN
Date: Sat,  4 May 2024 08:39:21 -0700
Message-Id: <20240504153926.357845-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Inline DISAS_PC_UPDATED switch case from alpha_tr_tb_stop():

    switch (ctx->base.is_jmp) {
    ...
    case DISAS_PC_UPDATED:
        tcg_gen_lookup_and_goto_ptr();
        break;

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 2/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-5-philmd@linaro.org>
---
 target/alpha/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 9ad7bf6e5f..01914e7b56 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -450,7 +450,8 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
         return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
-        return DISAS_PC_UPDATED;
+        tcg_gen_lookup_and_goto_ptr();
+        return DISAS_NORETURN;
     }
 }
 
@@ -479,7 +480,8 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
         TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
 
         tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
-        return DISAS_PC_UPDATED;
+        tcg_gen_lookup_and_goto_ptr();
+        return DISAS_NORETURN;
     }
 }
 
-- 
2.34.1


