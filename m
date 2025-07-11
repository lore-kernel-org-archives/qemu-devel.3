Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F369EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDv9-0007SN-QC; Fri, 11 Jul 2025 09:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu4-0004X2-Q3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtz-00039U-Kk
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4530921461aso13857985e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240898; x=1752845698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJpsUbLyNcANLnSnQf19yaGPSwfDJstWb2tmsgZQyko=;
 b=vs42TLur7bsCJ9TEnof0/QViBZ4EA24rw9mnoV8GIx72kwyiyZMHZqV9U9hG1+14Dn
 L52ne2bq7cIJK7X07jDfh2dmlL6WNqxcTjihMU0OKviqW+JappwrU3T9D8e4ATR0YPHO
 2Z1bRU7NZodcAwO0j+u81gLPDF6EJaF0jZST5nCPSlwsJ2D2dX8veFPuWd/VnIGyRHo1
 rilmdUlTqZNvQk12PLICVwJ+d2WPfznu+KeRxIb1eQei4PRX3sECJ1JsZZMW8weK8Ijn
 pqRXanS98nSZbR28uxJr0wTBRK0d2NflHSVRQGU/U5f0h/JjhfOnYn3iQxmUvrtUo03B
 t5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240898; x=1752845698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJpsUbLyNcANLnSnQf19yaGPSwfDJstWb2tmsgZQyko=;
 b=RQZnYcYvl81GN1vlwrw6hMh9CoesUD3aaISc8iqQAWt6NmY4Fowg5WN7w0ATdP3faV
 FhoqzlwMIf5NZuk3mMI57R0RRxZBmKRLa5ekuZnxf/dCcRpPfMKxVch9Ak/6GLODICTY
 X5GxID5hxn2tDPk49ZjhhUEN/W48u3Chj6n2/5yxXw1wo6vTj911fpzatuKCtEWVoGOw
 ++RZBnoEjyD9vJCKnWcQ7CDxcjmvC/ZDmagnXa8DCxKG0WU8sGbf/T+c0viwn7/RLMcl
 /di3fDZ78e3mc+/guWqi83DjKwkplrPUd3yr/DCMGlxmHn83b5PqJYyqy1YrARY3xB8r
 9KEA==
X-Gm-Message-State: AOJu0Yy3tLrIn32bWYCG0D45ohQJTUclicbPZ9di4gK7dBgyEIumTklA
 3WO6RWmDRcIRDojAqz4qPiNwyTEjmqQMzgVIhsvZKhF1sbt748KxHe2DjMW2vfbZOMu/bMwoUu2
 0F/DJ
X-Gm-Gg: ASbGncsNr1a/Z7R5cEjav5wtLa4/CiR9EpoGmFO5fJwDQliStO3y4ala1lF5CaLNejQ
 UTgnb4tSDJIgc1cVAIL3O86mrarSQt3njWeRTGWW8WCK5NkZkZQShWV0v7IDqqIij8y8rzXAvsJ
 V8BBA/mOs2fxrMGTXkPi/1xymJHhA4Gc/C92niGUvLuy4NBxhz9+1xqlWRzaeVng6aguR/lvnpm
 sE/kUng76oUVJVwe4Qcut+qxe0BoA1FiayHUTCg9WLHjlcbt7Rt+V7iJ/8r5aU29Ckcmk0uw1nI
 1a8XSUFo9lnBoEhL5G83D+Vcyfqk1zzQP9ubKukJ1VZ4qyFm4IbtNCQsPByOWZJK5ewEmKIujIY
 Ws5cWplng4SsQmBL+n1/yWv9IkqdD
X-Google-Smtp-Source: AGHT+IHmDjd6IBufunn+VXUbW45gEy2L5kG1BIp/bGnrz4HrD/HhnppUFhmPn2QSvyKnWtzFwDWHpg==
X-Received: by 2002:a05:600c:3d8f:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-45565edca7emr21236675e9.28.1752240897891; 
 Fri, 11 Jul 2025 06:34:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/36] target/arm: Don't enforce NSE,
 NS check for EL3->EL3 returns
Date: Fri, 11 Jul 2025 14:34:18 +0100
Message-ID: <20250711133429.1423030-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704165636.261888-1-peter.maydell@linaro.org
---
 target/arm/tcg/helper-a64.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index c66d521278c..71c6c44ee8a 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -658,15 +658,6 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
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
@@ -678,6 +669,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
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


