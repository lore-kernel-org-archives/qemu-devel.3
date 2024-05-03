Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1587C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nDp-0000z7-AS; Fri, 03 May 2024 03:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDm-0000wf-Sv
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDl-0001LE-7p
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so82474965e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720839; x=1715325639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmOXXany6+IF+Zg4vOVkLGyHudTW6xzwKpcd61mzXPc=;
 b=KXtEPrDaLdNsdS4xRfcIeGSoV1/0gfrDpiEpLR1UxbonZ4n6/DK0ar5eHMTyFo96BV
 GwBMa7FWkVvw3JGBCsEjmxryZVFMiPBImKKqbMoc7N5bZDpBNNiiwBZ4QGP6Mhy6FG3E
 rwD9cN3AukfIYS0VtbFGSauGrZm1d0kE0W724cRteGQFu+3SqnLV0Ul6wzLpvfVA0PmJ
 M02+Sdr6XuADRhqYcteqYF9S3Edpj/nn4BFqjYUEbwTwXEQfhNqxoUH+qwktNJtyPz+S
 DJ33xuk3rF71V6Nj6ZUdCoTjm1CsnNYGS8r+OqaAFSIbkzmXZHuuFDvlfvVOZG9mtZy+
 DYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720839; x=1715325639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmOXXany6+IF+Zg4vOVkLGyHudTW6xzwKpcd61mzXPc=;
 b=DsNms7MM6iN03DYITMjUD8//AheRNc2bP5dcQWsMBnaROPvvRVkIxzjGS0KE/s9G95
 qvWjeZ+fY6qD+co5No7eLPsGSjjDvWB/yQk6fyD6qTgVUPrV+KVhaYpRPvXff7AoGoz7
 sddym8dw/Rn4lnQQJu4vt10AUUOkg2EtYXhWsISkNjOn9AF/GnUA5YJRBkx5AXBrmy49
 Jxv+VnmtZNns9m8MI0AyV9SNYu8R7TPveiy5vQ8ZotbmHE/jSURCFHXpoT/25VuTonEw
 0XEZomQkgUFdFEYQ0dZ9RdamrJIbJ585URbcFP6LKy93gQUXrrwkK4mpSgVo5BCl8A41
 Cz/g==
X-Gm-Message-State: AOJu0YxYv1fx0lBPMEn6NJv6YWk8JKGI/aGIm2oJYyvyzaGh1uVPoHyI
 /qvQGE1vg46piu+5XDW5aqYeK8XYbKn9p4BBejqd6AFbf7hK/84mnDXsUSW3B3BGhQO3eKIRjAr
 Y
X-Google-Smtp-Source: AGHT+IGv6Lwzgra0IE536D99r5Yv97/84GJYar6x9gTDvjtvgWu3XBvq8cnYeXjx1RG8fPsdpMVcsg==
X-Received: by 2002:a05:600c:3507:b0:41b:eaf2:f7e6 with SMTP id
 h7-20020a05600c350700b0041beaf2f7e6mr1896677wmq.2.1714720839289; 
 Fri, 03 May 2024 00:20:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 fl24-20020a05600c0b9800b00418916f5848sm4572133wmb.43.2024.05.03.00.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] target/alpha: Inline DISAS_PC_UPDATED and return
 DISAS_NORETURN
Date: Fri,  3 May 2024 09:20:08 +0200
Message-ID: <20240503072014.24751-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

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
2.41.0


