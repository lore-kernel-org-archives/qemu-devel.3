Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF2CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1l2R-0000aL-Az; Tue, 30 Apr 2024 06:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1l2O-0000Zl-7Y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:48:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1l2M-000059-I0
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:48:39 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516ef30b16eso6274355e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714474116; x=1715078916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Wxgct4ui4g9Wvlaph5wUmRgy7/1l6XnBwBGChAdhpQ=;
 b=xFJ/nKnhk+sX2wBeZcu52nbeYbHaOnJcPSGx6ed1xCGACwf2WxB1alTGSXLCyLZSxn
 jLVNIGaTcKHa+ZbKRHjXpKIJngAUS1vDh5pYewP0cVN+WHWdyLwz770ujpK9bzxJEvtU
 uJgiE5Wc0IM07/+cce4e1lqjHAIIM7LtYpcxhE/doeN+t/W+YM05w7wsuUW2aL3KivKl
 nxW1qZCVcokcjyfOlQkNn/8aM/5rZZyrzrrZLE8m2+fbzQplVbYvupqppcrwQg4crAcn
 nk0t8pEQPo0Ys0ZmkJc9f1fW6DhQ77hHB6iKObhrLt4XOXGreYOsWoUbdpkepCOmun7S
 j+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714474116; x=1715078916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Wxgct4ui4g9Wvlaph5wUmRgy7/1l6XnBwBGChAdhpQ=;
 b=ZvPlD9cs74wNe7WPD7jOAVfBWEuvKX+2zdpyMgkH7sXVMQCXudf6LEKq08oF4HA78d
 1XBnPNpmS4I5jQuT7THMlU6mqZv+IjaMJtQuQlCQsLW1OmL3ZwkwJRVqDXzMHrIxvXHT
 FLcXFNqKU+BzimUt+hyJpS3P0PdHpfPlaHk4244wVnrlXL7IjpQt1pDcz1hL/qW3VPiJ
 EL0/MnywfCqG3MICD/tr5f3unNdVvuUqO9XMhmirhDof1/Fi60Wa48mN/xJMxWPL4VsA
 p8a0XbinY3M5gh/BFS3Uws/QUSi5fERQLJJOMnmZnnewTb7ftm0Q3T4eGrOolB8u4yBg
 4Xuw==
X-Gm-Message-State: AOJu0YwvnCF3/3S0WK03cvE3wzPJK7n38ZDmSwa2afvOnBvx8KEZmICL
 +57OT3uIg6ZTLW/UoWy2fJqyd0KbMnZFTTM0yKKsB3Yq6t2PC2m9FQnudaL4FPbmWIjqqeRnudm
 NeVU=
X-Google-Smtp-Source: AGHT+IGQoOpJqicDWyy5U9V70HqdDhS29t193jreIciLmaVdvhCIP8tVDgL+Xclu10oX1SGK02xqcw==
X-Received: by 2002:a19:7014:0:b0:51a:c207:12b with SMTP id
 h20-20020a197014000000b0051ac207012bmr1396473lfc.37.1714474115990; 
 Tue, 30 Apr 2024 03:48:35 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c4f4900b0041bed36e23csm11452467wmq.39.2024.04.30.03.48.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 03:48:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] target/sh4: Fix ADDV opcode
Date: Tue, 30 Apr 2024 12:48:33 +0200
Message-ID: <20240430104833.69600-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

  ADDV Rm, Rn        Rn + Rm -> Rn, overflow -> T

But QEMU implementation was:

  ADDV Rm, Rn        Rn + Rm -> Rm, overflow -> T

Fix by filling the correct Rm register.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2317
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ebb6c901bf..4a1dd0d1f4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -714,7 +714,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B7_4), t0);
+            tcg_gen_mov_i32(REG(B11_8), t0);
         }
         return;
     case 0x2009: /* and Rm,Rn */
-- 
2.41.0


