Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF84C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgU-0007mw-6b; Mon, 29 Jun 2026 08:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfw-000722-BX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfu-0007Zl-FX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so5782135e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734477; x=1783339277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ypN3/i7YqXJgMmeeqZEABskabQGp8rFqcVVtbknYAMU=;
 b=UNDYJUmW2vtVCYeJjoYoge1If1fSrBmpKbmFnn4VM6HuDnSo3j/6kFJrt/Obv2V36+
 Hb53BAZOOHiM/VIOgcJ/haEVZarZP9lSXqYv84y8NgAe0TWy5pujUVERqrhHfJZiFcFI
 e7udkQJ0aqsS3EOEUqfXyg0CmgYiMpZ5NWy81QI19Si/hTwHZd0+kL8k1+covy/7+nEB
 dCWMyl/Khg4Y9viSy62IKHdZRw8jXLSIzbUQoXh0tOKt20uSpzvEM3Q/4liXPK1R84lp
 vYlQ7oZFUpRa9K9DjsSIyHafEwYs3h0zjbdaggZGEC+HSjrAdbHJgoTdxjkk7uQTdLhV
 KjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734477; x=1783339277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ypN3/i7YqXJgMmeeqZEABskabQGp8rFqcVVtbknYAMU=;
 b=ZsM1kbOKq2gJaMVfMw3+KtIwPK7DhBraiexI8PqwUHjWUAJQU2KRISrG0qS4SQgW52
 9/7UUbpo/QsOfu2b9Sf4JIiHVNRzh4UXPgRJ6hs3ClpIxe4sqb1BLq45hYVm4T46F9xN
 B2otaMSWwE79xnzwb9w8jKiFxZgTnCOV4Qx4awFs0lKD4RUbKmp/S5dU65Eub+e4MVNl
 NBX5ZZSUJHYmFFMK/3Q9+z0yqIuZZgzhLE0NqlRUFfUg+P2Jckjldj6jcSXUUQoe3ipd
 kLwSmGHBT5mYDNTegXf/JlbbLK+2fxFTtaJpy78uoW0g1uz81OvtPjIY4++mfNZIN6cX
 oYiw==
X-Gm-Message-State: AOJu0YzbHCvljZNRvVPc9VR+dqrIwsAWuVPicPvPtm7j4nsiNHZHd155
 0zouSsB85nOHlaCR/znZab+CC+tvIIZ10lWhQXnKPrBLcGHAUVHuj0t5O+ntg4pco+sP2c+4wk2
 bJGDe
X-Gm-Gg: AfdE7clx1lbrCKm9prsoJcVj9LujsMFyIYPjWvKLrCViQOX12ODtPdlOYQz4TyuUPPR
 TD6V6tjX/8220WiBvtaeXUD6K/EglzcWS7iSBKsWIvCtIt+fcjpgwMj21v9YDMJKto/1SSCDfSX
 c2IAuAjnAw71aOWUVyZbS6PqrnOkcic3L5HdyUjCCx3bQ2plERVoUqfqDIAcRFY8gm7+Gn6IQKv
 75Znig4mh5JNUnlr1E38qRxI5pjjnFnwyVyiiCvxieSOOSYQsIZbi3LobUdUFo2WHOsOBGsw6Uf
 L6uaSmOsBliWv69EwUwOAxvKCQ6qyhFXkqVvZrRuLy8HoX1qygwfvwafMvbut9EOfOWB56KB9Zd
 qA/DWvrhcJbQZBtkws0ymaDyB9RMtExtC1HJ143wLMU1Shy6MeKGj+vZBLI/fNQwDYRFP7NraTR
 Hw+ZEvdDHw21+37zFvEsZVNy8PSDpMzTYHy0Xyh2wempvNvoQrg7kdSP8YyoytZ4u/9xSxUPLYK
 d1kDSJt1yibridwmUW8qQ==
X-Received: by 2002:a05:600c:5d4:b0:493:b240:6a8b with SMTP id
 5b1f17b1804b1-493b2406b47mr18915375e9.14.1782734476924; 
 Mon, 29 Jun 2026 05:01:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/54] target/arm: gate check on scr_el3 behind ARM_FEATURE_EL3
 check
Date: Mon, 29 Jun 2026 13:00:19 +0100
Message-ID: <20260629120032.1645265-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We shouldn't be reading SCR_EL3 unless ARM_FEATURE_EL3 is enabled, if
it is then we check SCR_ECVEN allows tweaking the offset.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260624124527.1018912-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f3281feaf..20165dbf48 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1413,10 +1413,10 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *ignored)
 
 static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
 {
-    if ((env->cp15.scr_el3 & SCR_ECVEN) &&
-        FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
-        arm_is_el2_enabled(env) &&
-        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+    if ((!arm_feature(env, ARM_FEATURE_EL3) || (env->cp15.scr_el3 & SCR_ECVEN))
+        && FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV)
+        && arm_is_el2_enabled(env)
+        && (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         return env->cp15.cntpoff_el2;
     }
     return 0;
-- 
2.43.0


