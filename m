Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB52C25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oXv-0006WI-Bz; Tue, 30 Apr 2024 10:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1oXt-0006Vj-CJ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:33:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1oXr-0001jR-Gf
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:33:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso24401705e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714487600; x=1715092400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PuTyecA750ZIQlqesrmVLk05d5eM6TamqpN3e1baQF8=;
 b=rlr5GZUMU6HzXe4WY2ll1zD13efkBQ1IiB0hgrkW1U+zYYYS8druPCAqMYAZcWsJS5
 rioS4CWPjwLD87ayfd97ojkE3VgNd/GkvzzOYyRsOxfnzOi41ziorVVNjTkqTt7c0717
 RWF5Gyvz6xdot54J5T6N2T/ImPWIxtHZbaFwN4Ur+t8jqniGUvYZ/Z6Rp+AqN5NGsfH6
 kzud08djYDJPMOBpldUKXMCPiv+9TzJAd37aVRYuiMWfjX7W9DtwMmeXsU6J5h7OGtJd
 klEGCjJedHyW+TbnGvmLaiTlNqiinnjkpHWp1mgFESFVrBNeR39kvCIlyoMQpGdYk0qP
 WmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714487600; x=1715092400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuTyecA750ZIQlqesrmVLk05d5eM6TamqpN3e1baQF8=;
 b=fKAxNHPq9TT7/5tAR9wNe1SPVwO83s6E+ezuiExdrB2JhUYPGreIK51OzEPRFW8ufb
 i7/BIKmxY+6WwS+vDhiFSzRbAxok+gDRoprt5VwCEkS4xMps5ldcTRW64XLZMPx3JB4f
 hsqmu72j3zX1eeXxHjzg1u1RDr9aIRC4g7nnve2YJPjVoAVQgBk/1APlnEFrV87Ge7OZ
 s5VCIarbtSteOgWLtyP0Pk92nIWMeGVasXPtqPDe4reEA3L+7TZmlaJhQuA1bRd3IWmy
 t+sE2hTwZBgi3ciQGbR5W1s3zM+jp9Ww+ZV51Vqm+mWufEGx2o9edG4Fe7Gc+C7Aw4zb
 SgEw==
X-Gm-Message-State: AOJu0Yxwr+Qu63qggBE2ct24n7nFsMbuFXhzQS2P935+mRdvcDSdVl/b
 sx1wvarHITent8wXz+0TDKZuyjmg7DBkkzPoUX7KLFDI4Kzq61Bg0FzqxbGajH1UGFKIptATPUm
 +
X-Google-Smtp-Source: AGHT+IGMmpJjmdkvNWI9g+AjRGa4RsrGU0+u9JcDN9MEbqM5CHTuEbA7tNEuTOuJiDV/L9s/eC9kBw==
X-Received: by 2002:a05:600c:4f87:b0:418:3d59:c13a with SMTP id
 n7-20020a05600c4f8700b004183d59c13amr2788331wmq.9.1714487600436; 
 Tue, 30 Apr 2024 07:33:20 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c445100b0041c130520fbsm9939741wmn.46.2024.04.30.07.33.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 07:33:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] target/sh4: Fix SUBV opcode
Date: Tue, 30 Apr 2024 16:33:17 +0200
Message-ID: <20240430143317.75663-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The overflow / underflow can be calculated as:

  T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31

However we were using the incorrect:

  T = ((Rn ^ Rm) & (Result ^ Rm)) >> 31

Fix by using the Rn register instead of Rm.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2318
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4a1dd0d1f4..3e013b7c7c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -933,7 +933,7 @@ static void _decode_opc(DisasContext * ctx)
             t0 = tcg_temp_new();
             tcg_gen_sub_i32(t0, REG(B11_8), REG(B7_4));
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B7_4));
+            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
             tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
             tcg_gen_and_i32(t1, t1, t2);
-- 
2.41.0


