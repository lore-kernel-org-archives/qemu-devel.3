Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0D5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjiR-0006ZJ-IU; Fri, 04 Jul 2025 12:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjiN-0006Ym-8v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:56:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjiK-0000Ez-5R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:56:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so12445335e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751648198; x=1752252998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ad8SnT1cTuIC4lkjk0LMOdTFwc31GHfx2RXFXWvncE=;
 b=XBIxAfosq4oVUCK6wTvw7IMh6iD0IqXKeT0VuL4QYD8UxKJWIZMxiHmff8jL3ncdpH
 NvUxxy2s9FN6tt5ouvPfS/wsi+h+bQiETkhKQfsMknQ31rx1J0T20fjir6xdB+YjqOdh
 QRJKsda7jTTdUPNKAv9BBlIfRSsLVb4cr20d2nWCpfvJHzs/2Z5lrQnfcTDJD4ZR/vSZ
 27D+kPwHfJdYNOsb/f1XBjLQ7ZzzSZtAKsdWnpCBTlRxkoRRbr6Z6BLDPBvJo0TtXiuT
 HgVoq0fFmJsIGc6Yz8kFNDWdMp507W3h8mSmnB5apxp6CL85u7VsN+XmtJFF28nQ05yY
 Juhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648198; x=1752252998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ad8SnT1cTuIC4lkjk0LMOdTFwc31GHfx2RXFXWvncE=;
 b=vnmIdkxQcIdzoUhuEYx6UJ74CrZSlHa26nh78cg001pE8MkiQRz5uyC0qk8KDNRDa9
 eoF+zf74e+Nx2Js2kvUSTQssqCMrpVkU3i8OK3ZZQlQMp8gqkUAUuZMfkGBSr3vGNiCN
 VsqkSAJPEnpK0IsV56nTbIRA0hoPD8K6IIwCEwIe5biNd22kMBeDLyqjpGBzcIWkgD7N
 Njj+fqjxBx58Qhbo3YSrNWW635HmVE0TnG7KnJd4EuK9hoOvBDRZumwOWBYIXnoKJOh0
 XIj30po4zsZN98YvIVVyucUmmCCwblKHI00umivIGDrC615YNwl5T/4cAqzZQ3ytEzUT
 /pHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh2eg1esyaAqckV6ec/gpd3Z46rMWSGLvAFuuZuGIYAShAJv9uR6E3IiqaRLeac09tOahnlUck0hFn@nongnu.org
X-Gm-Message-State: AOJu0Yw1G2IRS3AHCe6E3SojmdhbLf7jLV2/NRv1beHa43x6KbBWtvNZ
 UghVnTVilCTcZBlJsu0850d5DndrgL447nSH4SYNQwNdovNHpRqrkiDzGx0r3TCRnTSJIdMNayN
 zIslI
X-Gm-Gg: ASbGncvkHdLQQBOu1svpqwivLFtCblbqTYSOTNV5Ff+Om2doec2yR48srCBQ6hOj8gc
 /2NbayIxptynSxzQREdMBvpDNpSEe9hneb1WEKcClSMzfZ6y04DmYsYTBXBpnlGadgwlH5gJ8b7
 fLlNmz6gIMUu/aD19Nns5DB8nLi39MHVOy0YaauXltaVMIc9gU9vsCM90qDQI/dP/8w9FArnQXU
 GbotIgFoDR5LdirJgeTNg4z/W27kUlNHDLF0UF4lvqWSDeGeg6QPuOTJxYJSfnUZlWk26Le3+Kv
 2pZ25mToh129toQDjP2AlCQ/Sak9k36VZj9xvf169RXc4HJGe6BcSEql/Jl6p0nDC1qV
X-Google-Smtp-Source: AGHT+IHnHDR/VIVMoQALFSh/PS/T6XoSTZH1pJYtKLXVqTF5AcGxsOGQZHuuAbNHwQ9+pWFidImrAQ==
X-Received: by 2002:a5d:64cc:0:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3b49703162fmr2471625f8f.28.1751648198248; 
 Fri, 04 Jul 2025 09:56:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba54sm2884168f8f.8.2025.07.04.09.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:56:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Don't enforce NSE,NS check for EL3->EL3 returns
Date: Fri,  4 Jul 2025 17:56:36 +0100
Message-ID: <20250704165636.261888-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In the Arm ARM, rule R_TYTWB that defines illegal exception return cases
includes the case:
 If FEAT_RME is implemented, then if SCR_EL3.{NSE, NS} is {1, 0}, an
 exception return from EL3 to a lower Exception level

Our implementation of this check fails to check that the
return is to a lower exception level, so it will incorrectly fire on
EL3->EL3 exception returns.

Fix the check condition. This requires us to move it further
down in the function to a point where we know the new_el value.

Fixes: 35aa6715ddcd9 ("target/arm: Catch illegal-exception-return from EL3 with bad NSE/NS")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3016
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 4f618ae390e..cb02cee51b2 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -656,15 +656,6 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         spsr &= ~PSTATE_SS;
     }
 
-    /*
-     * FEAT_RME forbids return from EL3 with an invalid security state.
-     * We don't need an explicit check for FEAT_RME here because we enforce
-     * in scr_write() that you can't set the NSE bit without it.
-     */
-    if (cur_el == 3 && (env->cp15.scr_el3 & (SCR_NS | SCR_NSE)) == SCR_NSE) {
-        goto illegal_return;
-    }
-
     new_el = el_from_spsr(spsr);
     if (new_el == -1) {
         goto illegal_return;
@@ -676,6 +667,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    /*
+     * FEAT_RME forbids return from EL3 to a lower exception level
+     * with an invalid security state.
+     * We don't need an explicit check for FEAT_RME here because we enforce
+     * in scr_write() that you can't set the NSE bit without it.
+     */
+    if (cur_el == 3 && new_el < 3 &&
+        (env->cp15.scr_el3 & (SCR_NS | SCR_NSE)) == SCR_NSE) {
+        goto illegal_return;
+    }
+
     if (new_el != 0 && arm_el_is_aa64(env, new_el) != return_to_aa64) {
         /* Return to an EL which is configured for a different register width */
         goto illegal_return;
-- 
2.43.0


