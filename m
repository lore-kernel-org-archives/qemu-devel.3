Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F703E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aO-0000ZV-Ib; Fri, 13 Dec 2024 12:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y5-0008MD-TJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:58 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xy-0001jO-Cj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso985782f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111226; x=1734716026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Tvdd/VSuAoXtZ7lXIE2S/8K11Z6fStvv2Pl+2QKZyA=;
 b=gwMvsFkVvQvGJ29VHbPGqKdBQkGHMmw/eDvdfFJf7vSd/Rl/uPTgMlIEHwIIDgPQjn
 Pruc5odOJI1itIqQ0sQklSKs2ek6/lqIsN/TAtXjHsC+WNfIdvIodTm7H9RbpTcg88J8
 nQVd/6nKA/6ychrbEKhigUmAiGXBEUEZGztm4ErEz0sQgbdzvdk73IrHJPjq3bUhlVSi
 A7X7jgS+JPHQUyvaDIDnT5buFVZz4dj31ov6WjCWDL0IquXvACTKMRJ0LSO95OnaLzwq
 Ju9BM5V3+v3LySIQ59lQ1eOMen9BhD7hNbZI6cIgYm1JtpbUtVUgvZ8VXDSG03M+HFw4
 fj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111226; x=1734716026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Tvdd/VSuAoXtZ7lXIE2S/8K11Z6fStvv2Pl+2QKZyA=;
 b=rrLeo2oSBhp5BlwgsWYDHvIfalYluUPGNRId3B96pOmf+5SnaDHyUmEQ/EkvikcCwn
 IUq8DfxB+gfSoh5ZGYMT7OQbx3/v2JGtg72N4VnYn1uuTB3l/8+vDBvKCLgZMlaFlBOo
 zbILYvp199p1GhKuQ0mT4pPjNHps96Mf+gbdL78+byzlMMFf4eUHKBR05twzAWgA0PW5
 iV/8BVz71g/DDfieh2rbGh9nWyAW6gNEa4t/ZV4wNEKOAiFYlPdIGh4un+azZIX4xfEo
 yQWeRPz8UJJxG9Sxopmp3h22JpvLkPTCyVMa8gt4aPpuoDgZv8K67sGiZoMM7V1acwFU
 Ejiw==
X-Gm-Message-State: AOJu0YzigqTunZOhHtGre5sSJBuHbh/eVxGYOxZgZJndmq2Sa2h/ZoK3
 OpM2GyBRGqYfLTqevX7lZVOS2oNamSUi6Oh4WwawuKdNUg8xnlgpCyEsDkHVZpqam4BYJ23+XPl
 F
X-Gm-Gg: ASbGncvCk5z0jRn8+JfRzufPF12sttJ9pMfK6cBoOH/ImuzxbvHdI4zDifrwdQ5nwd3
 i94mSTZuFeKhUfmxyfKcNm3CnFtWY0F5ud/lbtXyQskkDHkPjG6mhohkSO4L5ZTa9T051lnOj6o
 ZTh3/SuP/XDmjBuj5MQFi2PkLgvY3uUYXcEJzEaddH7lsP+AehUfdvqkkY/BNqeun4edLELP2pF
 K6jrHmNbegiv6lOh/ftf6jDsmYVmUkt5Uc8cbng9k0qmHKEGRY0Hbxb30BLkg==
X-Google-Smtp-Source: AGHT+IH6fxsdGwKlPeY4Ls4L1pFntrbASM4vE6guJs7aShbp4c5FtupMWuDHNaHRoIz4s5ezd3MESQ==
X-Received: by 2002:a5d:6d8f:0:b0:385:e43a:4dd8 with SMTP id
 ffacd0b85a97d-38880af1458mr2823540f8f.4.1734111226023; 
 Fri, 13 Dec 2024 09:33:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/85] target/arm: Use float_round_to_odd in
 helper_fcvtx_f64_to_f32
Date: Fri, 13 Dec 2024 17:32:14 +0000
Message-Id: <20241213173229.3308926-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Softfloat has native support for round-to-odd.  Use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241206031428.78634-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 28de7468cd1..fb6fe0fcaa9 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -408,23 +408,13 @@ float64 HELPER(frecpx_f64)(float64 a, void *fpstp)
 
 float32 HELPER(fcvtx_f64_to_f32)(float64 a, CPUARMState *env)
 {
-    /* Von Neumann rounding is implemented by using round-to-zero
-     * and then setting the LSB of the result if Inexact was raised.
-     */
     float32 r;
     float_status *fpst = &env->vfp.fp_status;
-    float_status tstat = *fpst;
-    int exflags;
+    int old = get_float_rounding_mode(fpst);
 
-    set_float_rounding_mode(float_round_to_zero, &tstat);
-    set_float_exception_flags(0, &tstat);
-    r = float64_to_float32(a, &tstat);
-    exflags = get_float_exception_flags(&tstat);
-    if (exflags & float_flag_inexact) {
-        r = make_float32(float32_val(r) | 1);
-    }
-    exflags |= get_float_exception_flags(fpst);
-    set_float_exception_flags(exflags, fpst);
+    set_float_rounding_mode(float_round_to_odd, fpst);
+    r = float64_to_float32(a, fpst);
+    set_float_rounding_mode(old, fpst);
     return r;
 }
 
-- 
2.34.1


