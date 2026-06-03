Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8665BCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqId-0000cx-4v; Wed, 03 Jun 2026 14:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIT-0000YK-JD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIQ-0003aA-RA
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so5209120f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780511189; x=1781115989; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GaugsB0+qDsm5JZJtlzVYavpFIe0k85NXYxUoHgAR7Q=;
 b=fOvAWmQEQe7mcdjGVF7tzN69ubX9GBd1IU6DzFoMILhiw8hRYatmniAoGuzf0OTeia
 lJ2Bm6+9ZKk72rU8l3Fs9WO23/A13NUD9B9mm6+fYSaH3HgnZYTay5U2W6OH2hRnsC5v
 /ejsCsGxnuEVlkj0DP5t6Oi7mnjiT3DI5R22N84STiElMwjcBmrz5sFw+qrKRmLB0wGD
 9gL6i7EmbK/pLM74mRNKj/Kh1OLkIMQ/+IiNdskisD8QaTgyh8vPzN7hJYF6s7Qd+gFv
 f80Qk0rKiWpS0pztTfl7HWSkZGSNK4xJZbwpf7IDhMO2v8BlYHAIDhKPyBCGEIcJHSqr
 m5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511189; x=1781115989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GaugsB0+qDsm5JZJtlzVYavpFIe0k85NXYxUoHgAR7Q=;
 b=Mf/W1c7eCJJ5lcqwuzHOSpaEWsPdqqNwSZ21fEAARIVBJryoD8NkcwNUMfvFpBNn7q
 cgnXBp9JYU0G4ZFd59Uz/5Q0aeOGf2B0AIetH9GvpnHyNPau4J8WxENqocRrj8QO4HBv
 /fEjwSX+EXn1x12i9bJNL63wIkoNWnKjYTaTxPki5wso6KwmBRbsBn6Wz1+CvzcSTYmY
 Kt3Ke4BLBJqG0Sj3RKmgeZizCCTefYra8WLL/McbD92swB6nFLij/x+cAk2jQdtFIjh+
 VBrUEtUzPDaqklMXr/Zh9QohJXBHFjhEVjGW9Qqvw3aZre9SbxaK7oHvZidb6elh0ZJM
 ynVQ==
X-Gm-Message-State: AOJu0Yy5xbgTcjHMsasQ5BOcsoXN5Muv4tryo6djsJ+kjXMnN0KC3Phe
 NZaE0Z1i/b8f/f7bfO8pwRtm1DWXxNT7Jx5D7/UO1eCeif/f9P89bfaIlWJIU3LvF8Y=
X-Gm-Gg: Acq92OHpvZBz/NLZ50g4Bx2h0SHUrmsPu3Z1enG28X3hbBxhC4XkxK8mSrmDjQLwzKq
 9NFd+JWTV79QTz/cSIAdaJKziwmFWN8QoxiUPMk4khDL0l7WYBcdgsfS9IQdTQUdhV1Bw3TWYCo
 kjc1rJSnZsGnyNB2JM9IihW98j6s+ZCYLTAPSyCe4ajNZ3zJr0et4FmPBg0jXz8riUGO7AgFgnc
 i0jsjtWlakyQF4EPzwG3o9uPizZJLoidknL/MdPSxigV8WNqlPcqbmLy6jX2RoR0h8881C9yzpa
 ohep0vlws9hfuY16KEEZ6tNOQ4T4asXpuEKN1EQm72IrQptEyhwg5pHE96QbpXp239yR4FHDUgY
 16SE0nAPFPd0L6P0w+d6b+AQ595pFddeQBTzhHR056ZQ4xarI4nsuruXK/lURvWbkCJo6GjI7FF
 a2z3WbuB6ueIK95iatMsc20anIjD9TrtGkDLwmtQ==
X-Received: by 2002:adf:fdcd:0:b0:45e:f2bd:2b17 with SMTP id
 ffacd0b85a97d-4602182d6e5mr5425566f8f.21.1780511188877; 
 Wed, 03 Jun 2026 11:26:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d530:6a6b:58a7:e220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm9793127f8f.13.2026.06.03.11.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:26:28 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 03 Jun 2026 19:26:23 +0100
Subject: [PATCH v2 4/6] target/arm/cpu-features.h: x-rme now means GPC3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-jmac-gpc3b-v2-4-115c51936962@linaro.org>
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
In-Reply-To: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1a4f50486d..2d87cc5668 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    /* Enable FEAT_RME_GPC2 */
-    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
+    /* Enable FEAT_RME_GPC3 */
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,

-- 
2.43.0


