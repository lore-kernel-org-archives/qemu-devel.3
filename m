Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B7710FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8183-0006bh-Ay; Wed, 01 Apr 2026 15:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817p-0006Tg-1V
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:14 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817k-0002z4-Oa
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:12 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso46096a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071267; x=1775676067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=tY9Hl2U7vWEXOR7PfNP9P7WP/cAgKMTsP7vOCm4g8VXuakF0aqpP47dm6YKZnwfOVC
 yg7opHNi6eEy2p68RkFNYthyEoPnKw5KcTQqHgIihQDwZ6BIVaRGidMwvTRwwWn7s5z8
 SxqVaIaMDcd8fWrKQ0+RrGzgqldhzoYwRzFq4fAJzSzlkHMODxCJbgDCK8NInD2jejwU
 ap12+ZKvNdc3Ku8qRuWTBOL5PUBoFTM4EzCFZB6Y0COwJNF7zg7gZWi8uwLl2YEasb7x
 8rF6aToY6tN4rixY1BPpvU1QpchH2mqr/iH5nOXk5nRRDjyebNxjVSgSypIqiCCrphZh
 O2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071267; x=1775676067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=CCOUgSKepbRkhyRIuSb32vm8aEUX6dukdDd5EvxOn4/cb3SZ8hVidsoGHSg4a63QQQ
 lbmZLJ8ogJI7kii3hSnktE3PdEif4QuXrSaHCSz2J3CTRI66MgavkQiEg2ZcNihoHT1X
 9BZgt1mp/62eCiwbESy4g+kiSwmim0LyxcpzA8FhwFQFMuWIAVHBkQsr1enKTNsNkEEp
 1QCDnUd8cnozAo5qttbrq6C0OFcQEQ/IbM3OE9VdfsgCgBTCucsaXkmEy3jXABMcW48w
 JZ80N7Y1gE6sVw77gbog2p57ASYU+6ASFpBHNlLHitv9emRfwW/5pcnxkVg4UmA4XBaE
 c4mA==
X-Gm-Message-State: AOJu0YzBKGfIFzoWevoaBcnITpLLjU1I3GgUuHWScsR1PKpPRz0ldkfC
 uC8e8u3UU6GbHMgDN+LM6W/yn7h/5OGriiUIBALAX/enHDjPK4SpoNXpHCwsn+5BWwNiXxRqZml
 kV3lgAIMquA==
X-Gm-Gg: ATEYQzy7lNtkpHlC1mgcp3HeXugstZM5z/8/YgUnfH1BTd/ZaWOEgXf2jxrhAa52zEc
 Zq2FAGs/zdCADFk0nDkhAZRZ6SthA1XyjATMg2oBUQF45cberFeyaYrjB+ViShqGbqUsgo4pB4G
 dZ/iyHgYL9FYQZEGn5bZ7ho2/Xs2/hTzsBjrjmUKhea+srnnlrjUS01rw6lxwBPJCXCe0OxvV1/
 sX3XSXPoKSUvkwRbIDPszA1cvt5J6pjEOPi81Zv83LwpwNaBcDcFNn9ezH6TwvDEIla+9lIu59m
 Pbe958RkrjzNQAbFKvBzCYX4pGXvML9+ZTb79RueNueKlXGQ71/Ogvi/3lCjQ+OOt2YIULj5JQV
 aascPs6njjl19edeYw2p9D6TjzSAYpu51JcsHhkoPJ+JM7o2yCwwZ1PgpT7PID4qySTsP02U/BY
 sgn6zdFrMTXfom0Y/8Q01QTr6M7DDYdF8xI4gx6OKtLdqYlWgeJ1jWPPVIeR9qpXnWF6zYOqW7C
 T9o
X-Received: by 2002:a17:90a:c107:b0:35b:a656:a5fe with SMTP id
 98e67ed59e1d1-35dc6e77dcemr4163265a91.3.1775071267012; 
 Wed, 01 Apr 2026 12:21:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 03/12] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Wed,  1 Apr 2026 12:20:48 -0700
Message-ID: <20260401192057.1182724-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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


