Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A168C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPJ-0005rb-7U; Tue, 22 Apr 2025 15:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLc-0000XT-TK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:01 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLa-0006cU-1N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:00 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224019ad9edso79384125ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350316; x=1745955116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3MzC1SM8/P9FwN0GSrhaTCjx8/yGZnbGlkuu1GEQBw=;
 b=uoYTgjZQiGbphS8dgKp+O7XwTxeOOHkXQGaDJSgQWCJRGNMlWFwK250a5IvLfxQRcj
 GaDJiFyWGU4ApPK6++62JA5WK5wSxZUhYa1k8DQoTiR2mqgMabq9SIuM0VTC6QFjLgCD
 LtxcHLDZrQGfRKN19vyCVRudEb/IRgfK2HL9GEhpMX6t84rH+lEsq68gUtfyGvv4nh7T
 n2DDz4eEmONF1wc8HG60gbOkpd6JVKDG9SAasN+p3jgr5fc9n4tmuM/4JtwX0Av5S9y6
 H9XdF9rUoB2lcvpwPKIHvsxCAJcbrAKgCWkG56lSRLfvHI3V2CxqhBX46/iFNYDkVQBR
 hS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350316; x=1745955116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3MzC1SM8/P9FwN0GSrhaTCjx8/yGZnbGlkuu1GEQBw=;
 b=esb9d3G34EaV9aYEmWAfjgCO0HXV0FARweMf884c7gz4Zu+V6wJxdTmATGst+nhYvf
 s4NlGtmvwA246DQUgC5jzTcEZPUGvJvY46xmg5Cny4rmzrRxEG5Ebz3YzxOLXckFLLES
 LbDMxJejTynLmApP3QfA70uQ92z3TlK+xPViChFPMEksDKm4i/RpTczd9VAAwtTFra79
 vKADE568S8VPPiQTPW0uEY1dG7ZIqDl7eeUnHPNRx5mZgT4wYl4GGx3YWEzIN+P98d2E
 oXPK5/MoJqjk2AGXBO/I3Ddh/Rz2YuBKeikCMcTrsWz0XOKfBg9q6GGQEGdmzroQSOw7
 60JA==
X-Gm-Message-State: AOJu0YyJiH3zWZta12bVvf0u5Bd6JVXnRPi9hyS1Mr+k1JgZWbM7ddwm
 aF3oMltoGqQAL4iejzQoOzrhR7zXnh34cGWmGlGORkfLpTvibPD2PhpMBLJnDsadhlTCJa+FXLL
 P
X-Gm-Gg: ASbGncs6Yd4GTdYCotl9BsvfzFJLlZ8Ellt6P6WT4y5QZwSrZErittgFWdnHagX4o1/
 kGLkwPqVYj9DIGgWcSAIJ2trx7eUBfgkEAAbwy24FvPzwXi3F5Bhx5BRl+EHIinVx+SkKeb3JOo
 3OrNg2b9xyA3Y034J4IQHJUzClm1e5p4ApPNUHGYjEaYrwgppdHdBZvCpbKTqIvgBjm3R1pclrm
 5LE2Fb4TzBGR5zOzFJw5NfXjm6bUbebep5Sh4WEgjEQtjN7IVY+BLhylwqc9hKKRZQMlYfFxRdz
 hQlTIxMsXkmyJFiy5FU13bkgVWnV/25SaXc0QzC3avluuhpPoekxvmuwK3+HbNFNI+0MGasLnlI
 =
X-Google-Smtp-Source: AGHT+IEgjAGH/G1ykdDrixRlHejmh0ufMdRscNHAjfO8TRNToLrNz6aXNtbofRrXdJQ43Obo6t3EcQ==
X-Received: by 2002:a17:902:db01:b0:223:501c:7581 with SMTP id
 d9443c01a7336-22c535a4e39mr236434995ad.16.1745350316524; 
 Tue, 22 Apr 2025 12:31:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 054/147] include/hw/intc: Remove ifndef CONFIG_USER_ONLY from
 armv7m_nvic.h
Date: Tue, 22 Apr 2025 12:26:43 -0700
Message-ID: <20250422192819.302784-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.  The inlines
for user-only are unused.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 89fe8aedaa..7b9964fe7e 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
  * @secure: the security state to test
  * This corresponds to the pseudocode IsReqExecPriNeg().
  */
-#ifndef CONFIG_USER_ONLY
 bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
-#else
-static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
-{
-    return false;
-}
-#endif
-#ifndef CONFIG_USER_ONLY
 bool armv7m_nvic_can_take_pending_exception(NVICState *s);
-#else
-static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
-{
-    return true;
-}
-#endif
 
 #endif
-- 
2.43.0


