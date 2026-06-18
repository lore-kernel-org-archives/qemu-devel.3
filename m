Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D27ECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42M-0000tn-VN; Thu, 18 Jun 2026 00:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42H-0000r6-Iy
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:27 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42E-00044t-P4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37c5b9d42efso852523a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755641; x=1782360441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpNsYyWVmO6gKZzGAp86+C2RznIhc/M7mB9FSTXEfXA=;
 b=tw7FTZjAXZGJ9BxZkv1AvuAHnpHzgoj3rJQ7XCHYHvCmHQSHvT1P/yHreW3pb9dNm3
 HDGKOTONxMDPByQfewtcRSLW1GzW7OzD6AB8pHGopRyUuouG4s63bF3n4EyOrd/254MH
 JtHoH6sHGf5MRWXPqeQXHjkWuUu4qLUMcDAv3DR9w8pTwmxSZCxyaQGK5HvoIfk6gCNP
 jKEiU8rzAXN41N1XVfp0IJLURofi7DGzRxUHoZzoi6cEoqOJuKRTd06gHfh1XOiE0SPq
 c6in7rllG1I1W2kmAveGdjvJ9Yu8lvVwde2xeX8flK1fMy1LmH/AGLjniOY+NlEmyaw8
 2NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755641; x=1782360441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WpNsYyWVmO6gKZzGAp86+C2RznIhc/M7mB9FSTXEfXA=;
 b=Kh1gfI6o97O9FVqKgbb6FnJxYEXFCkeNxYwIZtYClXa83jMc+nITSBuy0Z47a5Ds2R
 MO4zfWKPLfejM+V+IJHOcPFHo3wkG3BtsmmciADJL16sJSTUNecQFW/yLTqqzXh97HKt
 7VimqRibh2hRFANNzSESflfvbNAwMXhJMrAS+n+uG8eVtw+yqLqR9zkdbFXnI2FlLTCn
 r4Z8A3BjAdFzGqrcUNbAGsIlqzOVwIpc9qDl5BgcezGp/qN5mWm4azXeA92KmYQVPRWH
 3PyHQ4+ls0DcJM1i/YfcoLQXgBnVwTgfNIOXCyE08DBlmgHgTioud6yav3ljT+MoukmQ
 YQrQ==
X-Gm-Message-State: AOJu0YxApmIGWWRKrFYizhcATSSjgeesIUuopSlbpdp97WifzTE4gpuF
 WDf5DwDMaei5FZ3450mPteRWoIfDDgFvxZ/JigobJnnKjyKZ8uySoEDKnM2q4qz7jKvolU2CAaZ
 YagKD
X-Gm-Gg: AfdE7ckwcw4SFtZC9AMZEqGPOQS15GZJkfHVFRQ1lAMuOVqvuLSle1TIpgh9BV3wDYu
 YUyUq4W2ZGirwtC70/f/at7hyslmOgaqXx+tcwxYnYquMgQvd0PnSSt4A7wPfoQqX4VbD7iazqn
 TSjFbP/556JxWkKCotAPcCs8Qu+8iWEWi35gQH/Uneu0lPZu8nDXLW3C4gYl37r66BRreficDHi
 w/ZnXEnYAlSu8U2U/JYyERTtNHsR/PcrjoSxVjwxAhxSBmDKoeUGvpmNgzAvd9M5EEX43+HCPX/
 kgEW21iVEYHVYERHlZnHB+4iSyQCtKo+vOyPU9wzkOJnW7tU3sgvzgF5zln+AcwchMoZM6O2BiT
 YJKxV9P5R63zcBSm2GbALhccBhvupnxdzz8UiD67dCnB07AIpxyxpWsmGHvotHfgSI9XYqr3LwR
 uvBEfXXvE261EJQZrIBGujEt1J2kEO0arNjWVarAKABi6Zoi2pXbAeoXdMuAAz
X-Received: by 2002:a17:90b:3846:b0:369:7491:7b24 with SMTP id
 98e67ed59e1d1-37cdbcc985dmr1759249a91.6.1781755641231; 
 Wed, 17 Jun 2026 21:07:21 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Dillon Sharlet <dsharlet@google.com>
Subject: [PATCH v2 1/8] target/arm: Enable SCTLR_EL1.EnFPM for user-only
Date: Wed, 17 Jun 2026 21:07:11 -0700
Message-ID: <20260618040718.572950-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We advertised linux-user support for FPMR without actually
enabling access to the register as the kernel must do.

Fixes: 2430d49a17c9 ("target/arm: Enable FEAT_FPMR for -cpu max")
Reported-by: Dillon Sharlet <dsharlet@google.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 419e0b3ed4..da93f24774 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -421,6 +421,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* Enable FEAT_FPMR */
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            env->cp15.sctlr_el[1] |= SCTLR_EnFPM;
+        }
         /* For Linux, GCSPR_EL0 is always readable. */
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             env->cp15.gcscr_el[0] = GCSCRE0_NTR;
-- 
2.43.0


