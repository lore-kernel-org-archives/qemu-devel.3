Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5630C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgA-000777-3c; Mon, 29 Jun 2026 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfk-0006xZ-Jb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:09 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfh-0007SF-LE
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:08 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1733158f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734463; x=1783339263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NEwrFTmw2uYqFCPwKBfqshoz5JAjsjRtgyEC9s0QvTU=;
 b=ye/okTO7NPXjKXURowz/3W2TN/58p/jutYeEYSeooxvUbLG6dhN/7aJQTBqYgh6Z1u
 lBQUbCD8qCNI5HBTO/OAcj4bSbuGTB5+j+wBX8JbHc/tKkqCDtzHb4qgM7sBqWEZeQUM
 19GsTQuW74kPW3Hiy8L1ftnTQZdC0UnFmDNvmkp1/MPLNOv4IgirQDRkxPQTWn+6kHo/
 KlWtq0eWPSYYVya4QjfK1C35nQuAw5P75EDn72FIISZ7KnsjHqJoLzXS6aNAkhYkvZl0
 peLa7aXwrlRdcZ+dH+vmReWy0fmsZqaWT4Hfa/if0e23GSOvQSgpWvepCWW5r+RjPLZx
 II9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734463; x=1783339263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NEwrFTmw2uYqFCPwKBfqshoz5JAjsjRtgyEC9s0QvTU=;
 b=BJl0xpZ3l8VKuNF6Q8spPVvL0+qaNxJZ5rL6PIqaxd0TXZlvFobDn+l6Frv1dbPEQz
 DAYgNb93/8gA5oaQgA5wPgHblr2ZeZSdvFAUdsuayCVWiV33/aB8E4t5mYl5rGmDw9Zq
 Pdv45043t+2uZG9cIaic6m0zcL08/K6UCI4nkAdi+BHKbGp6epeAJVSvejGpBNneSCTx
 wsVs6OF81AKM8vH8gHLG0h+KI2XVEIXeJT9PeGjm0OYwwo50oMO1Wilr8XHmJiyWJV2f
 lufhQEDpkbVea42Zfs8RsXJwCFbR1VLdLFA+V57tx2deuu0dkyv5MjYWEKnqPfz4bxxV
 tFwQ==
X-Gm-Message-State: AOJu0YyQ3Xn9MA9bhwnhzE0EBnBqu2ueZ9OzF/WHDQDHcG/EvhF2lW5l
 TLb373ShYnPTrVr4dum2fBirDwhPP/jYTgDj5Xd4MpP5nUQNOqMryeGyAUhtgdP9z6/ozddfF1L
 UG49s
X-Gm-Gg: AfdE7ck7nbOIjrmTHyWYQta6c0hGn0jIisnn5iUBNByPRb618rHk5phBK+SxIlbO9Ve
 ySXToKVkEHkgfA967noPJA+C+2SmvNrVqEgrunPao6YVY/TqC0xTJ9ooMe13/o33lLImaAR6rFr
 hvsYDInL6oln8CYsDctBahjEQGvxiFibNPCpDarUx/cSqSVig98pMNnK3zRkaY0VMw81vzmFX89
 nDaNG3DSAn03cml5sMb6ysNCpnH9xmm1iCZDE6UKcREYGmAAnXDRq6D89njCgPnTrh5QTjFPnyq
 WdzUvpaBonSx2cSgZWNP3+mWMyVtqRvG7Jrx1XM8JAcLWdaNBV1XgJmqGv0gKBVB0UpmH3QPiC7
 Mw4T78xuzwxT0gcgLEQDj/5biztxMmryxNvzVJ0uW20HdrB8uDaIGPzEVWzAAIf7HlI2oO1Ll3q
 av+dDB5KSvv7+hkA2Eyb+6ni4ndr63RZ7lTQ7VXz9+1N6dlD23FhbXEP0dTJSbAsT3NynxWGRoE
 q+jBlgQ3gwTX/zjdhKcog==
X-Received: by 2002:a05:6000:41fb:b0:472:f8b5:aaca with SMTP id
 ffacd0b85a97d-472f8b5ad11mr8132840f8f.15.1782734463001; 
 Mon, 29 Jun 2026 05:01:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/54] target/arm/cpu-features.h: x-rme now means GPC3
Date: Mon, 29 Jun 2026 13:00:06 +0100
Message-ID: <20260629120032.1645265-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e9eda8fbf1..a5734446dd 100644
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


