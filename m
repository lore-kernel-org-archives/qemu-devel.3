Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48633C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQx-00013B-Kc; Tue, 22 Apr 2025 15:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLW-0000BL-K0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLU-0006as-At
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c3407a87aso84188125ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350310; x=1745955110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcw0j/NlWHHUFrSWrBThXyu3TLmFkd4CNoNN4KpSa40=;
 b=tRvwom6xp9qKY4ahcO1/L3Ry2UUWyv+xm8rP9Y/RXbp8yy+69llJ2ICrcRbQwa5SSQ
 TBSIU4hDHUEGWcJMan/hBPHXxCmi7P1ruuy/sGhjoFcSr5sJWm7K5MJFMCUcicPpKxkD
 ZkY/TWWqRV/+zSRm2u3nPSDiVkBXAN5gR4bCNB9r3H4/z238O1KhWqClKkt1hqlp91Lt
 e9Tv8qQNb1rGx+ePIIa5ZrPmoSy3hOECcsad89vQuZy8xqF/EtaQ2jt/WmzHMAIbvOKL
 SKrRh2+5YUK1rhOGNNOI/t+xGA1c+MuoM3DdMxKvlvSjN2LxJiA5XGERMuvjal9SSc73
 5lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350310; x=1745955110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcw0j/NlWHHUFrSWrBThXyu3TLmFkd4CNoNN4KpSa40=;
 b=ApqHQsrmC358OhdcS+D+FW09vCfexfK7V2eK/9QC5VUS6IRcMEbjmZ2LWZg/LghlFV
 7z4lr/bJoshLIRDVNb6txxvVeIKMKt1S5pT0tc9iUyvKSHOmYhaxei59X+QrDIbPWpO3
 mBT4aEUuhpc4O6hLRpa2JsvVTLiqytKuz1hbE4GxdTCZgB++NwtjQLVqgVh3Xi755rMH
 L9tKx7+W4VK2RP7HiDMCI/AyGha0KSfrotwlQzBWBQoCtW0xw8vnOX2ckhWiYXgUHYiI
 wJ1OLYwky10LmYWaxd2hk9vGTRHk1Dxw5WnA0ngXOeUyux1DnXTLVwu9w3jiLQ5R0W19
 IpYA==
X-Gm-Message-State: AOJu0Yy8TNLtj6Gi6p7EX/M/Dv/V0n4ZX3FA1AltFemja1wCWi8Xwj0f
 26zEqmzH9RDOZfD8GaiMSkE72X2zCPI8faFilKsxjPCY0Cq/nikPbJL7DDL09UJ2uDS1hX0ZZj5
 d
X-Gm-Gg: ASbGnctIaJ7jNR/8VCY6BFpU5LILc5uK8D4QfU6D+stdz/EZouOUgGCU5xlniCPKU8e
 ZavN+/hY/RVvJVqA/SzKgOGmygRA1LpVnb4z5mc2yFRxYZ54RQyYwH9WuS1wi2qRWnRRmOb5tVK
 SjpshKF21MD+EZYDt3zy0Iu8WK7Z4xCCkQFlfDi95RyMl9gJrtmgPRf/YqUkaQw6H/51qP6VrE3
 8u/Y+uriCnpkYB45VOIpnBYFsGZD+3bzwURug4e+vD0hsAOGxY6eGIqnMpKwb/XOWuj1am/ysxY
 6fHtktVswzxv0DWrReunFGB8saWbG/70A9AktldI12QZxTJ+Smc7Ti9DYKAbF/w3YSF0RNI1ch8
 =
X-Google-Smtp-Source: AGHT+IHDSorXWqj3xQPieB+lzrq2kREsklsVBoJeuSkit6cCLpo7Q6OgYjJh7bvT9yTYsCKaRwPl1Q==
X-Received: by 2002:a17:903:3bad:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22c5356798amr208685535ad.8.1745350310640; 
 Tue, 22 Apr 2025 12:31:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 045/147] target/xtensa: Restrict semihosting tests to system
 mode
Date: Tue, 22 Apr 2025 12:26:34 -0700
Message-ID: <20250422192819.302784-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

We do not set CONFIG_SEMIHOSTING in
configs/targets/xtensa*-linux-user.mak.

Do not raise SIGILL for user-only unconditionally.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f02cefde3..cb817b3119 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -35,14 +35,14 @@
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "semihosting/semihost.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
+#ifndef CONFIG_USER_ONLY
+#include "semihosting/semihost.h"
+#endif
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -2241,17 +2241,15 @@ static uint32_t test_exceptions_simcall(DisasContext *dc,
                                         const OpcodeArg arg[],
                                         const uint32_t par[])
 {
-    bool is_semi = semihosting_enabled(dc->cring != 0);
-#ifdef CONFIG_USER_ONLY
-    bool ill = true;
-#else
-    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
-    bool ill = dc->config->hw_version <= 250002 && !is_semi;
-#endif
-    if (ill || !is_semi) {
-        qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
+#ifndef CONFIG_USER_ONLY
+    if (semihosting_enabled(dc->cring != 0)) {
+        return 0;
     }
-    return ill ? XTENSA_OP_ILL : 0;
+#endif
+    qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
+
+    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
+    return dc->config->hw_version <= 250002 ? XTENSA_OP_ILL : 0;
 }
 
 static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],
-- 
2.43.0


