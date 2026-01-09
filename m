Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF691D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56t-0004nl-Af; Fri, 09 Jan 2026 00:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56p-0004gK-D6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56n-0003ke-Sj
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so2402296b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936744; x=1768541544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoKrriVmMrbjJDHf1DVQarNvxXMmC4IuPbT/CIGrkZg=;
 b=lpGSL5qZEyIyEORjl/Q7OjJ2KxT72kuG9f2xMZrCABAONZxmTbKgZTOcMtyVVLsdiJ
 w6m6LESCOXq0Wv79ut+hnqPT86PYFEC12uk79+V848QCtY7gNPKelyPZhfWoC8m/JHD4
 cYHPbptyNldraks55PWT6eqmCioWRzXfyqdJGqM1dWE2khq2igKCQvmSCZ0bEp6X/F3R
 HlKrkGKIdrJEnyVI+kq1ghAKivsDI5kCwzsphUC4JhKEn80j+X38n1zaA8q01AsMOATt
 Lh7+laBkmFtLSs626KiZI7sQBjkw3LweWRS1ghkud6MDCcxdbyvg3LE5OlplxM021fmu
 UuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936744; x=1768541544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GoKrriVmMrbjJDHf1DVQarNvxXMmC4IuPbT/CIGrkZg=;
 b=blkboRx0aMfHL3ogjaf1F/wBaKIQsLuZ9qD3zTCUzxuIcq80lMv4tSJGIikF2oWXYT
 J3UfxwJdO2RYCkPqbQ3oiQPyrTyPr8AUiP/uXn2a2mRvb89g/UGxF6xhkoibZAsCzL0/
 ubHTLfsCJnp/vR3dfAuhqsi/yQywi7UhBcQ8VvlAFld5MGnnskE5rhqChR6aZLQrBqVH
 QCVrShguvT2RgxjZoL2u7pGL47ymteR5EvM7UlnoCnFW/P5k1MjsCa2qLV8tuy2DmANd
 7Ie8cGpPZn1HeD4C5gpgrK80bLpgGHv1hG/jFbBrWdytT9wRD578UyRQmDCE9Lp6nn0N
 mPRg==
X-Gm-Message-State: AOJu0YyKSwj6LW5aZyVXAKpwpUdr+BWyOo0CZsyyvyXPw4rb+XcZdVgX
 8gnTw+l1wd7GH7J8lFIVfCo05EEsf8wk6LmaN4JSw0grDcHyMU5s8KGRS0g7haHYf5WC0W9PTPg
 2YlWw
X-Gm-Gg: AY/fxX6qGkO155EEYX2hUdkayqWVoZwQDOw7HttscyqLwwpn4TGixNO2cwOIN6XJTmX
 njFVvYTzG5mKlxYs0wj/KcN2M/AjsdkNMWVxN4nLgVVYTbh2pJttho6ca+GRVbGpAiVoLz3FIkP
 V2ZPidjEIqUxeTFZVPhdX7qSkQdCiGKtXNSSSl794J7caDKh6kPqt8MbwKDG/M1MNPO0J1ruFRf
 yxK436UIcgwaORTvVF5Sq+YPXwogqsAD9xlu5YCed17IZjmw0Ic7k95PlN94xWYYaV2E1G1gRfp
 GvxXai/Iy2sFYiJMVv8xmzcozxItB/S8TEGopMGMHZ22/8mJAAJ0/7Kwe+pxRrVBZvIQW+6ht/i
 3b0Vkgb+c4+4oMGYqtDcW6B7TFFzGBjQhtI/9Uw3KzkKIQLe0fPgpi7JUWTYSKdQp7EzrU6YPkK
 /BS07/DTe8LXxme/jR3J8jF2ZdjvvjhMk+UY6cyXvHSGKVKG5poc4SrBwPrx7b9p/b62coa2IUo
 o8=
X-Google-Smtp-Source: AGHT+IFfYEHdzbLbfnFof5hEo7fHzUQRCi+UwgjfLMSBbXBNjgQbHCFwJfbRF+aPSYr3k57kESQ2kw==
X-Received: by 2002:a05:6a20:4308:b0:366:14b2:30e with SMTP id
 adf61e73a8af0-3898f9cd7ddmr9042046637.65.1767936744430; 
 Thu, 08 Jan 2026 21:32:24 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 23/29] target/arm/tcg/translate: extract helper64 info in
 translate-a64
Date: Thu,  8 Jan 2026 21:31:52 -0800
Message-ID: <20260109053158.2800705-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Thanks to HAS_HELPER64 mechanism, we can now move helper info generation
to a translate-a64 for 64 bits helper.
This allows to get rid of TARGET_AARCH64 in translate.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 +++++++
 target/arm/tcg/translate.c     | 9 ---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b7a8e94b937..fed2eb18f13 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,13 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
+#define HAS_HELPER64
+#include "exec/helper-proto.h"
+
+#define HELPER_H "helper64.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_gcspr[4];
 static TCGv_i64 cpu_pc;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 5c496f42c55..ec4358ba402 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -26,9 +26,6 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
-#ifdef TARGET_AARCH64
-#define HAS_HELPER64
-#endif
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
 
@@ -36,12 +33,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#ifdef TARGET_AARCH64
-#define HELPER_H "helper64.h"
-#include "exec/helper-info.c.inc"
-#undef  HELPER_H
-#endif
-
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
-- 
2.47.3


