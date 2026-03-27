Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BEB10F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJD-0006jE-Fw; Fri, 27 Mar 2026 12:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ3-0006eZ-B4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AIz-00038V-IP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so11092105ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629897; x=1775234697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jE9dWySPWaDpusKqPLgrQj/rUnbESAV94dTG6aMNmPU=;
 b=Dzxb8WoyXaj2u9iHMP5djNLm9SKxQpNrpexH7wcLCnAx03r7AXfqjdDlQUq7ubCbvb
 9sIzbI2Nx4LFepeYq4nFwqi3JLa6f5cQ9A78AtkFr5bFPqU2RdyLcndRMgsoWHIVRiJw
 fi9o8x98dlaIW0Xhg1w/OTYOzGrkDlkXyPU3zKDrPUVVIOd1NvuizmkgeMdYqtRAOeyN
 JnZbjiTyLI8WSYo4zj+0UABLfg68JarSzk0VAcwWy/SjGNwQhyYnl9lZnAbPjScJIey4
 YPGBL/Xh1DQqbDfIQ/VX6IaslrZOD+xYBReB10suvHHgYGKgyKADHxSS65ZgxDIXlX5+
 fsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629897; x=1775234697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jE9dWySPWaDpusKqPLgrQj/rUnbESAV94dTG6aMNmPU=;
 b=IuPjtquG82D32PbWubav106P2iBVk37+ZCBoosQS6n3cPu9lwwajtPdtQHNx66+OnI
 23vFJxtKURIuyjGrwDOML7mA908EdSqLTgVQBlTNVg/qLET3c0rJwA0nHIjEGYC6fYWi
 hEg5nl7LQdPOD8NioURqk0CT+wybGu61vq3BuiLFjkEujTGn3zTuYHIYPyuPTZpfGvoL
 j4FSEYPOc0gh0jTeOmcNBO2kY+pL4rKyESJu8NQOnLRTRkP6wQWU2eicMzXSNBTdN22h
 v5s8r+wqgY9tk97kiuvESIionJkhIQ+ZbwMgKdRO8egv6rnFT0VT3ChBUgrBsctlNJXf
 k/BA==
X-Gm-Message-State: AOJu0Yx3AQfL5YYM8AJ8aSxvVT5yo67e9PAdPfjBXEJOIOcMUil259eA
 nTgxVnOLmJYdJ195O+7iuNi7aaNB+gD7tzL4G5rbfeEKfO64BHRRC+AGTCh2Uc2R06gaRcgVsh8
 Fe7Iw8/k=
X-Gm-Gg: ATEYQzzIjWK3xVVRqejxgq9Gu/fFeMErUWOc18K3y0ddGGDcswZMEI2MsTmVC2MmkY1
 KkWtPf97XVoxYpINDAPibd0Xls9zOWgdjz8cWirjLUkA+2gMi/aLbnizOPh3zU5CuEvMWYBwYwZ
 bX2nHiMcRAHhdslYZyUe9fG0G8tXHt3MleLJkBH6cIRVlGNlyEkkT6/JJxYGhFuTQDh45UE2ocQ
 XzFRKZ9vyuLPwhdtklN5LFK4fokY8+e30EXIIdeo/qZcw0nRxofgsbogys41dhBsapSLxgEYCoh
 4hs2ffj7XXT4C2gUa60ej08XVs6NO/jC1npK2HcEtPia/MnLAD2wp6IRPEYfTvLenFEMHEIgvEg
 K5Hn9VKhy46CEATOo4zMXjSYRA8lTkiYuQkuQRGzNU1prBz8whZDBY3ZJRGgTEaBDoEFK5jOWqL
 IF1LHEE2nb41vt9Q/FbgSUKKHDUgsqS6jLh0D5pgp7swzivlKSqdhxeH2M5P8BFl3AXaQ+Dg3zM
 FmO
X-Received: by 2002:a17:903:2405:b0:2b0:afbe:4e14 with SMTP id
 d9443c01a7336-2b0cdcf7f99mr33635725ad.40.1774629897270; 
 Fri, 27 Mar 2026 09:44:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:44:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/12] target/arm/translate.h: remove tcg-op.h include
Date: Fri, 27 Mar 2026 09:44:39 -0700
Message-ID: <20260327164449.596767-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Include tcg-op-common.h instead, and include target specific tcg-op.h in
files needing it. This intermediate step allows to clean up every file
(TCGv, tcg_gen.*_tl.*) in separate commits.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h     | 2 +-
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463e..6d52606f9b7 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,7 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "cpu.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..35ad7530c4b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51f..08254b088ed 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 
 /*
  * Include the generated decoder.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bace3fda1a..aa7d72a35ef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d2..56ef1e0eb59 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,6 +22,7 @@
 
 #include "translate.h"
 #include "translate-a32.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-- 
2.47.3


