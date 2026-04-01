Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E873B107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8184-0006eI-PR; Wed, 01 Apr 2026 15:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817p-0006Tk-3o
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817k-0002yi-8r
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:11 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so35939a91.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071266; x=1775676066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=JF3umuXq9eHqDKKeVc/k3IX3AnkKlVoIV6H/LAfjgiPp9NeOUHP2/Bg34srX3poBIC
 OcqSwZFuDR8jJERWhYlEG99dhaftBrg50VNVfcKP3uS+TBoIpjJWLNt89ewVKiaS/7mR
 JmN8MqRfv+g13ST95KDPMAZd7UGdfx8njCE/YEaQNYwJFUGO1mOw25jbXjNJG6V2YlRU
 LWi+dH2WrYUPCoTUEcqp9Ubcyj7N52DlPNuWY0jfC6NdSOmphZtdUPbRy1JuVd6MiGo/
 VZaSv5g5oxia0qxTzdUqgf6GZzB8j7duOD1w21sM2QKd8uHrDpdjfjQ9bymEtX9szo2q
 4A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071266; x=1775676066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=DdIczmy/y3FN+dTGPbvlRJevTaGdUu/Z3LDlTl3GkIBvpGzzh502mUbMBtuVUehiaF
 hjB4upyp5kZ0BQFdehpbfuCJw/F3Zh/W3qFL92yZBRjV3IXMf3A7Qt1sKOKqiIUHgW7V
 yhcnakPxJT8H4FTLsq0bDC259mMSQpC7wE2qNoGLZQB4D8g/Bq7syBVAd5CQfJwXc5hA
 mGSpfnGYNiEtpMD7oqR4BjIhqZb3sqIBtjfTKP/P+Rjv6uP0OxAjXvEONHipUnK54iXj
 FE31thZnqTBAS/7Phnq+hdryFN5L/uvxIS/eniUbSiFWWaSaDfd3yyGYUN33JU1NVoR3
 POiA==
X-Gm-Message-State: AOJu0YwcL57Viv+mzG2zxcXV8uTpWGBnY7usblqRd67IxXgiNijrZMZE
 dLVtyotrrAoG6JG6ilmCpntJwTvIkDFaXegXe0Ih/S5ew9/EsEv1RNhjt/zc+jMgDt1MK120Rlu
 kZAQxUD7oVw==
X-Gm-Gg: ATEYQzwq1slcMO4hKZL0RDXhTawZmaFd3qTp5ts28vb4sarStwWmezH8WJzMpHIUB8I
 Pn8P9ehXcXB2P8lZTpADWjdKxm3hVgWi0dk3zFec8EGBP+0jLCosLiq/4Ci2G+ssYr7aYWLY848
 +3O1HkACm6hDq9GTPlvDU1mNHY4VlpnaaYjGoqX4WuPwUnsmGeeZudSw6/S3WTt48PYHvHqmNqf
 Q2F6a+rOCU35uJ0iPvd+R2/Fyokcz5TpL/+Sjsu/dwR5TuovFGgX08UzwAtsXOtvGN7GHuHils/
 sGbzsDsQp6h60x8+0OTCAaz/tehyj+FFIx/DD3uy5AZHUws0So1O7zQYGagqFzNctc6x+wPmhRh
 HZgAjKVlen8X6jn5SUnKfSdizZRUoj6F+LcUiOJRPvUlv5K1VaRzpzLeq+7YHdYkWMTgSLU39mY
 HRKSmAotx1cy+ltsjV1yPkwCzq6KsCovJAHTurV4OvyMgGtUsGZFA3b+H5XOpPKtPOY5Wn/Q3vp
 iEo
X-Received: by 2002:a17:90b:4e88:b0:35d:a2aa:3b05 with SMTP id
 98e67ed59e1d1-35dc6e7ab50mr4264387a91.5.1775071266223; 
 Wed, 01 Apr 2026 12:21:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 02/12] target/arm/translate.h: remove tcg-op.h include
Date: Wed,  1 Apr 2026 12:20:47 -0700
Message-ID: <20260401192057.1182724-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


