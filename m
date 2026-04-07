Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2DD10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXwx-0004xm-Iz; Wed, 08 Apr 2026 14:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAXwu-0003kp-6k
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:24 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoM-0000mN-TB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:20 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3585ec417f6so158008a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600537; x=1776205337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=Hj3V0QQHD3N0XMGhCmjFCEkDs0AbPASAohjqyhSGVkxVKmq+6erpGpTXkhq4z9WeVH
 nd5+13dLCPIFfWb04QV8+Is/3Vc8Pk3P+AeKEDyazTiwV85yxKkMrzyTJRQagrMohj53
 ybCjnqvT9fml5uwBsBGFHtmE2yfra3qeAGj5aYmjlz6BiT0rISZkIAg/o9vE3XR/pVIX
 WCnqXfyhV5k6DclHA+VoNk03s8V4b49TNfK2FW0BUd1QZ8TNmEPavK+xCaRfTuQvfdTB
 mNAhu6OvuZG42Gd2Q9r5ci1ZxHadXzGslGjtECnlhOeHnnvKc0j+9szg/GHe7A8zieYh
 DxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600537; x=1776205337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=HJUExc6+6LrlPxkdDRp+fFx8ke7B+I90d8jbxDwfd8/oKE/cfSJWdFxIToFq75WnrJ
 mdgiyUKBbyVu3iczd8V36vHnoFgxe/0CnLO/anSiDP7C2Y7dG9Dkj7MReYz95A1dz666
 lvtotuNrnMxddfVsFFqa5dUOx8SGz/nCYS6oJMGLV39RHiNWeHdUISuoDEILSCkLEjYr
 Mou7VsxieQ0YQF9vzu4QFJGVdVjdluOsYQQfs8KH5Qsqi4eVuIgeU26/Mr/PuMn4NhEX
 N9nMJWaFmTN0ca4xcZA5Z15UcxXW4nK4mA8VV474wSsiN97bu3oSeVPnH9MLxT05Dwav
 iQ9w==
X-Gm-Message-State: AOJu0Yzrt1Bxh7GRZWTJ/BIlj8yT7yBpwjZmT8IYadJtxUVQGQJDN4oE
 19Vplvf0NOd8lN820TtKpLU6+cvhBrauqwfYykn5jjZpAeArk7wTUgbPBCUIcLF5+esaXGma9aC
 IWd69xGI=
X-Gm-Gg: AeBDietuNSUKWCB+iEWa8cKtXy0V+44atpk9ZssFDUE7zAUg2HF8pAfqsONCEdJ96rw
 W8GjO+7J3ndj2262lcSkeN5cecAbDeNKNI7yhWZzo4270g2m+Ob/FJTQi2L43N90kzGpZ5XAUs/
 2zBpYVgCFcVnzcwX+6O+Gyl/TIU+ZKIU85iGdJzsMMZxR2Q3eXtv5zAToueewtih65HB0BThKJm
 4wOoQ1YaH5UnT0feAGdFTVBLNjQ8mxowl6iZr1OQ5UGFJTz/TZBRpoRaq/DTS/zuFT1BAf2P/C6
 P8BY1s9tsQ/WVEPfysnvsDCk5UOUzRkiTdZPiGjQ7YlPJbKDgie+nLehU2QDPoSSbeReakeGRRp
 fI/MwL3aRjqYXQkQq2xC4bwSfQCRC2Oen7eguoyPBAnT1zuIETYKuDTcQISQcsrtb/t8n/5oHc9
 h8jvC850XKk9MlLsXjvff4lr9bhHQ2UYw0vguS6n3VMjvrGAlsIzoWilkkNP1lGY04+p4UOouLD
 vJ7
X-Received: by 2002:a17:903:2c6:b0:2b0:be79:e521 with SMTP id
 d9443c01a7336-2b277e7eb3emr189565295ad.26.1775600537327; 
 Tue, 07 Apr 2026 15:22:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 03/21] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Tue,  7 Apr 2026 15:21:50 -0700
Message-ID: <20260407222208.271838-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


