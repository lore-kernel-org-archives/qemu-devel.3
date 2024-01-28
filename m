Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ECAC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0w-00059o-Tc; Sat, 27 Jan 2024 23:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0u-00058j-Qg
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:24 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0t-0004OC-2E
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:24 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so1351615a91.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417002; x=1707021802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfMhTQxwxgwjYRWhH0P+ZcfoxncjyISGzQ2K+4rTjEw=;
 b=T7y1ebxaIU/WGVJL0aecfKq+bcNOYUHaHSk/DfSC3zaIoFaglj0uSdOl05AtdTgTvI
 5iaOjEi0vimG2jYNlOac8go+brs0MsESjYmeLLL3TtWiGq8xk0ZLAiW8d3fODN5/+x1V
 WsrXElBk8qwZBT5Pyin0nGL8ragHJRxIu1JdY5rCxSY+wNiGTV+Cl6Ae9CZVxxoJZdnu
 dEhU55u/R6K32ElRvmzUOn6Bv8+5qma79YTXlbAW5Jvsd6Y1XbzROMBghto+Vt54qz3a
 RlUUhYSuByhU9BugpkWZX1RwCPQeMzfjKHu0gIAjeejIUr0Lhg1GLI9Rs2gscmh22DRx
 DZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417002; x=1707021802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfMhTQxwxgwjYRWhH0P+ZcfoxncjyISGzQ2K+4rTjEw=;
 b=j8Ku3xNgP1aBBGDmnsLsvFLFn9s5mDo11aorlq0jfKBxoXmWW1f7Q3h3Dw6rMihf1M
 rgvGsu9WehRqzGHvNyfcl0Xl5LvTtkcDlLQI1dOSMPdS3uYxW0ysW2LuvH47j/CUmTct
 6zBMx41Ovbey81Ixf1M3IR++MOb01FAGz+thPZV+pESTrJSZbFcdcEjvUU4nTaoMHpIi
 a4Rjzn9Ahowc7DqDg1Xq4caA2z48R3fgPv6Nb15aTs3Sw9CEMtiEwR5PbY8UVysy8geA
 xRlIRCbo7xlWJf2xcTWJA3S8Y4gY+hP3m+GT4sYbzWgjdV1WAXZiGec1pUHrWKmvzmMb
 ppig==
X-Gm-Message-State: AOJu0YyS5TPjP2SNIqrsSPB8u07QmsolK1KVreMPDSUvvvcmk90ATyVv
 Udbn1aI9jz8DyLYkwmJJI5Ng00dU7oUMSPa15+mdOuVTQ3h5iuNnvByj/s8Eer0FIHKKoHIkRfF
 9dY3J4g==
X-Google-Smtp-Source: AGHT+IFt+x+DQT2Oi6Fi2cZra8uEXcbNk4SD2wfKUGSSUS2B+/rqkiIQwYQzs3Z/1PxO9pzA2IASrQ==
X-Received: by 2002:a17:90a:b398:b0:290:f7a7:333d with SMTP id
 e24-20020a17090ab39800b00290f7a7333dmr1569016pjr.36.1706417001755; 
 Sat, 27 Jan 2024 20:43:21 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 25/33] accel/tcg: Un-inline icount_exit_request() for clarity
Date: Sun, 28 Jan 2024 14:42:05 +1000
Message-Id: <20240128044213.316480-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert packed logic to dumb icount_exit_request() helper.
No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240124101639.30056-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 950dad63cb..f2535a2991 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -777,6 +777,17 @@ static inline bool need_replay_interrupt(int interrupt_request)
 }
 #endif /* !CONFIG_USER_ONLY */
 
+static inline bool icount_exit_request(CPUState *cpu)
+{
+    if (!icount_enabled()) {
+        return false;
+    }
+    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
+        return false;
+    }
+    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+}
+
 static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
@@ -882,10 +893,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     }
 
     /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(qatomic_read(&cpu->exit_request))
-        || (icount_enabled()
-            && (cpu->cflags_next_tb == -1 || cpu->cflags_next_tb & CF_USE_ICOUNT)
-            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0)) {
+    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
-- 
2.34.1


