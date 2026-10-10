Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8B3CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFRDb-0001il-Qb; Sat, 10 Oct 2026 03:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDX-0001cp-8s
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:10:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDV-0001CS-Mw
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:10:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so3757435e9.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791616200; x=1792221000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VHCB9DX8tcxfGGEoMgC60hBr/Ih8fWzh/Zex2K4jIpc=;
 b=wPeEy/QYIyMViDuqF5A1Qb1/ZUB4RA8IYyU6dZEZ7XroOm4uOY5G3oN9+EIOY0kgQV
 i/872qIsT0dgqQ1aeKqfOhyaYY7qajJ7BTRji1EG3hgtExVmhoes7x6ciif7+551ixu9
 Lc3AjybkMelo83q0qxpdj2tuq3ENGobGRuxyujRhO/Opg4bMBXtsBKIaO3L79KmGUgZ2
 M00QVTsfdnvZzKhXYcbC3R6N4KdrYjVbXFxK0uXHshRdnId0/7FPerUUvl0JrzW3JoCh
 SKroweip9y6DCAVUJ8Px3DdhRK5bGWy114sSAR3A586MxhrIZzCR/d8XE0UGLkUf4iro
 mqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791616200; x=1792221000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VHCB9DX8tcxfGGEoMgC60hBr/Ih8fWzh/Zex2K4jIpc=;
 b=HLxGxFH6MAeW/DVv9jWiziDbUwcI0nmkqpaN0eWF8McUJWbigHv5qVFhx3cVAtuhLI
 Tc+zCBH9SJdkI408ge2pHXAIGbezwcwApTvTi5UW1Qg3m+cUujceRo3aQk2szE8txtiu
 rKrEIAWHuEoVfvgg1fhcKShzggDK2FwZhkes+Fek71E5N0lWNXHnkJvfOcGa5fTmt5HZ
 gHUh9tqDPZtnMNKwgtV671RFzseazAbDQJ2bGvrOZBwsqtfDOoS/hVlKewKCzVeWvzV7
 u2jNr6g3Sxpte+UyQdY+lKUu0V4XKIrc+tFgUeuk7EDraqhsI6lpJZmS4HjUVzL+XWtf
 QNjQ==
X-Gm-Message-State: AFq9FYKm9moBtHkJ8/OpOgi7xPb4bSQhO3eGXGlCX/gnDy1te7z1ccm9
 wkG4BP7RPfDfRExfjrGBkU0rRaGcQL57GIlhlLb56r8kyke8sNv7q9uXW5LXpjmWT3xKxkKBrja
 CzSLg7jw=
X-Gm-Gg: AYBFou2JLj288DbjQS/YNH+QB3gfue/t1EI2T9LfPRNspzjsZLAhI1xc3VbLzQC1HWM
 jvPaStvbWVFdLcd0swMIFbizM5InM9NP2LXKpCcisjxTSQ5pN9qVrKH7xMd7+3HzWTYcU6i7mgQ
 VZZucq29GkzckXNkZf2LYSLJKBqYURWrxHCFdb8QF2YOUP6Gx0gx0HtzT3QpfqYlx4Mozo7Heh0
 SteSV3Rdy0Gg0QBMe5CyQ1M58eGNx99xpMfuwX5qyvSK3l1fBhwDxFjeljLgE80DmdmkQbmffwY
 P+FYzJYHsN5gCpjbSXhfd9XOaO2lsom0WuFIwnWOD2uVtfNFZWkzuXrw4uQJnIWUvc/kSBEcDrz
 E6H0B38JrJXqtZ2HJt2Jr4+5ahikjEvvxlHtdYJlAalzubhtWgdmatDMnL6s6WJetZp1/b8zVMu
 e89eWKNAlgvjK29OlrRQMW1yzRZ2VldWJkatnJaOK/fm7Hl8rJM1iewioTwtXHmF/ksmvR7cZRv
 rN3H6FlYA2rK0FCq7+ppg==
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id
 5b1f17b1804b1-4a18e4a8ca6mr73389155e9.12.1791616199835; 
 Sat, 10 Oct 2026 00:09:59 -0700 (PDT)
Received: from stoup.local ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm7662252f8f.36.2026.10.10.00.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 00:09:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 5/6] target/arm: Implement SCR_EL3.TID5
Date: Sat, 10 Oct 2026 09:09:51 +0200
Message-ID: <20261010070952.323466-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010070952.323466-1-richard.henderson@linaro.org>
References: <20261010070952.323466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae1b8a57617..1d78b14eaa0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5669,8 +5669,21 @@ static const ARMCPRegInfo dcpodp_reg[] = {
 static CPAccessResult access_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID5) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID5) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
-- 
2.53.0


