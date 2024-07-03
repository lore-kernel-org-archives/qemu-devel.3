Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7CDC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP40N-0003MG-Oi; Wed, 03 Jul 2024 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP40A-0003Iv-Hk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:42 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP404-0005LX-UB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fa9ecfb321so36632635ad.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028553; x=1720633353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uNpnZst6srkdFxwP3aq1QH/I3J8LM6sXBaE+jLcP9o=;
 b=cwLUQGwmGsUr7KGTLaNztMTVoShhlxKFn64U/epIt/uOIyypKhmEUmPw4nrgLCKs35
 kxN33gFswPT4XQWqhhop1dXMn9/hOOFyRdIb7Gl+YQ18lqF3ZxBpY5HvcS1ifFDTl6Ld
 YXDv07NkP3OncY3KfWIzESPoGVOiOLBSMfV7aZOqCrwi5dTEC2czYGPIQn+xwZUflh+O
 NJ9EWhA9Scw5LFW3ZSlA1kiosdvnA+u9BKoVItiXQ7Ea/TjVXjouLQVoSfXy3NXqgYd9
 lh5U4uoER6LGB8IGcNdrOWEJT0Y4oODEJFntdNCOIeLLwNQKwbmwL8Ni5Reg5MzpdF2z
 iRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028553; x=1720633353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uNpnZst6srkdFxwP3aq1QH/I3J8LM6sXBaE+jLcP9o=;
 b=si6mn3kbXRQUvtIQkd79uBK7BEdZBPtQyAFXxka0CVNPs09mIwzEYImfTgqQLnRNZo
 9nDEhDjnQ5wV3KDOnrQjurM/g3C2S0jGTR9L2vr1PHx+d8icaIBHxmBdQ5Z2m2rLBhlF
 aHBErxZTqIujv22w9K8SYSKrIYdHaQssjr04Nqb8Woz/dmQt85MFdOl3A/njKGWa/xXt
 nNOaPF5up9LOdJR8uKE36ZyeW1q5TL9wmd0VEy2ew/AaHaLmzgg+2omwEBT21Pvh1oaY
 Ump4BCGicA5o4+L1hknM9bocxcQqBb5OQplijixUAh10JKDPdmNW5T0Ln6JLk6l45pRK
 Nu2w==
X-Gm-Message-State: AOJu0Yy8UYkJ0MyANYyHNjFWRINYuXn/wovsj6ilX/sxSb7RimkYrh8c
 vFi/U819RyqcejxWuAo12fSlm0M6DshGzmvppMGfRqJs9raer6VJkLgc6qyGwWBptx0ygg4ud7s
 q
X-Google-Smtp-Source: AGHT+IG5Nn+2lqja723x9RM3LjZRe2CriXgqfAFRZhNwf2Wjp6K26i+E970Q0kP98eY3fWmov8/9VA==
X-Received: by 2002:a17:90a:c7d7:b0:2c9:692e:7d6a with SMTP id
 98e67ed59e1d1-2c9692e81e7mr3516785a91.20.1720028552797; 
 Wed, 03 Jul 2024 10:42:32 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 5/7] util/cpuinfo-riscv: Support OpenBSD signal frame
Date: Wed,  3 Jul 2024 10:42:24 -0700
Message-Id: <20240703174226.2117169-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reported-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cpuinfo-riscv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 1236ee5fa4..7dcfbee2ab 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -13,7 +13,14 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 {
     /* Skip the faulty instruction */
     ucontext_t *uc = (ucontext_t *)data;
+
+#ifdef __linux__
     uc->uc_mcontext.__gregs[REG_PC] += 4;
+#elif defined(__OpenBSD__)
+    uc->sc_sepc += 4;
+#else
+# error Unsupported OS
+#endif
 
     got_sigill = 1;
 }
-- 
2.34.1


