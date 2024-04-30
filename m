Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2422C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mGG-0007fW-6X; Tue, 30 Apr 2024 08:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mGB-0007eh-2U
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:06:59 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mG8-0006Sz-6K
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:06:58 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so701509466b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714478813; x=1715083613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uTQRceNnn6uCHAOc357hIl651YqkYlEsO+7VBE6zFf8=;
 b=N4bL5BSnFzf4XCWJAQMBx/U9jge7EIqnHzA65yc2bmNfEkPb9ienwQLuqeX3s3uG1g
 JNGcAdLnoEyRJ4H96LkJpGPMnTtXAoTdXX+LHUcoy+bYDTtMmyphlsz3ewUgZ4s9Qj4r
 0oiYRghmxEnZ71Kvg7PmRsIk+duqUHfVwZZwqZnfaGvi/86i8n4qxkwxRMSjcBIgAvA/
 LCTZXAfUkQDXVb+aKI8z5DB7rz0+ue4UIjYnWUplZcZqgBTVNKQYLvRnuiiQ6b6V8R2/
 YycQGCPUMNDl5tz90w0svLCS0nMZDMKto+EKwaUYa4I9k0QyuLrgQMXrxh1rKSPemxE3
 vpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714478813; x=1715083613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTQRceNnn6uCHAOc357hIl651YqkYlEsO+7VBE6zFf8=;
 b=FlbkIUeBY21Bmr57lRu85HAM5WTcG/dS0dwWIyMFYwLbbE/nmsmfw12kI/ZgGsDyd1
 mKx1e9LVInAQRboH4vrQA6vOCHHk6o9TIe9vnryRoXRrX/rwS9K29DEdg7Lif45RL5c1
 JDQcEuSnLdy9CaajmHyVhzrKkyhNSHj7HBmTzkl6OfoNBI3zg6iykYnXjQTiA8kuuvzl
 IA1H3wK1Q1ftH7LeVr/8iPgj0y1elTwp2BwoHwY6Mdy+TmXoTrPx5NN/N+zMk91/W5bU
 +hxp1wVN3p81h05n6KWkmd62UoiKmZElgJv1Sk2oP5UrQ5X2LlVuNUknhI1gLjE6HcvO
 R2tQ==
X-Gm-Message-State: AOJu0Ywjr1fXsgMGnjheqGraE2ufLd39muqrlZ7G+zf1WWD/FzkoYp9Z
 S1YQWI1X0ZcXogOKkWkF+lgOVQOfraSgd787gh1d8m7M8kxetTZ7F5w/T2lgrPExJGeXlaPOk1q
 e
X-Google-Smtp-Source: AGHT+IGgzum9bjnMaeAd1tUH53yqqYi6a1KDSF1q6goq+JNCWCMwiM1GRzQ/4jc+MgaMqjEJR8ytzQ==
X-Received: by 2002:a17:906:3b0f:b0:a55:b3d8:a0c8 with SMTP id
 g15-20020a1709063b0f00b00a55b3d8a0c8mr9282216ejf.42.1714478813085; 
 Tue, 30 Apr 2024 05:06:53 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 gx20-20020a1709068a5400b00a5885a7cb8csm8295656ejc.119.2024.04.30.05.06.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:06:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paul Cercueil <paul@crapouillou.net>
Subject: [RFC PATCH] target/sh4: Fix SUBV opcode
Date: Tue, 30 Apr 2024 14:06:50 +0200
Message-ID: <20240430120650.70539-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The documentation says:

  SUBV Rm, Rn        Rn - Rm -> Rn, underflow -> T

While correctly performing the substraction, the underflow
is not detected.

While we can check the high xored bit for overflow, for
underflow we need to check the xored value is not negative.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2318
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4a1dd0d1f4..1c48d8ebea 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -937,7 +937,7 @@ static void _decode_opc(DisasContext * ctx)
             t2 = tcg_temp_new();
             tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
             tcg_gen_and_i32(t1, t1, t2);
-            tcg_gen_shri_i32(cpu_sr_t, t1, 31);
+            tcg_gen_setcondi_i32(TCG_COND_GE, cpu_sr_t, t1, 0);
             tcg_gen_mov_i32(REG(B11_8), t0);
         }
         return;
-- 
2.41.0


