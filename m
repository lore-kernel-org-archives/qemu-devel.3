Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0905F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtZ-0006NW-LH; Thu, 23 Apr 2026 06:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtT-0006Kx-JF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtR-00021S-N9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so84330235e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938564; x=1777543364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZccPFvcO82NBuIb5FyKP7ybA1UGUY8lGMxG8AvShMo=;
 b=xQXkSTjlRSX3Ig+30zlGkn8NplPyxbPe6HZ4O7m2Z+bszr8UXzR/Hxd85eXt03SWSj
 JKnIsi0Cmurhrr95oIxIJPqQgP7xoUcnL2lpV2sT+K+pw8FrG6ACVVACa6vfkY4wYKG+
 +8TlqLUVeqYfsHgJSOTdLl32M55dk4BRhgL4+2XovCQI5Pj9V2MA6T1mpMFvxFAPT2g2
 PVk/3/Gai1eTwZZYrWbcWQcmTE9JinH7NnjJqiFedi3X6tVi8JnwEUOJNVFCfZknrs56
 3BDnfK2+UXyI/TpjvNsZ3bsdSiZTQdMFuFv8jBpquUGD4xs9xxYIkKZrwXmUAa9xNqWD
 iZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938564; x=1777543364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mZccPFvcO82NBuIb5FyKP7ybA1UGUY8lGMxG8AvShMo=;
 b=pIigpe3STIRcfv/3Y3hy181NRNr1YuLki6JUETByBW73hhg9OgjpQIzC+tqyOfuaTZ
 5dLIkUZPRvNZj/oAX31M4D5JD1pIInrXVGBw4ig30KZZaRg2iA9IpTZIKDLIBs/AbEmA
 JOXAPld/fjvScJtIoxf8OgA4JFYomVVACXkkv47apKB7p2yhZ6o0qjwhnbg5ujZaKF7z
 RXg16ljBMgwNQ5DTV9+WHqEetHwTo2r9v7E5FBUhz1gGVkyQdodU0g/no6Vh7t8tdGtl
 pKJnQm+k/iUpLCcq8k58hyye6B+aJ58emjw+VVQ5PVwERCqnRwA4GMH0YpjqG67jenC0
 rcsQ==
X-Gm-Message-State: AOJu0YwSgJLHPrv2w0/kd7vOsIDsdpGN88I2WxFacMsfWlpfki8SHaX0
 sWABoKtACvESOZqgle/Su+tzNc/b9Rlkb/WllaS6LP95A/e5Z56zD+cqYGTuZtADqgsRAg3ktU/
 xKO+C
X-Gm-Gg: AeBDiets+bCQ36bVTlTSquXCise8e4SyJ2CvO9aXpQyPEjJIge44ZMr+2mhnJoh3MUW
 qRYmuNHm9pkDd3e/iKciD4Rx4Rhle/2Smbw/AjcUHg2tjTNBIHQCVJPT4FOvnepH9+ZRyyZ7EYc
 5pqMFtkbVbrN2G6OdWPkpNpEgRuOA42x4FO2NIGCEke7nzFOikdUPkXxEI8W9HOAcJ7a7x0xtDT
 J+eWJj0IWCBZn/4rgUaEBe3zEfBzduoDr2nSD9LiFLw5V4asLQYztc+6B10MKd7sAEWpOlor+0J
 UaK7iMeRCsuFDb+PTowg4BxmKIwqATLauh6vIfqFypPDIHiAU8/u1vYKQSWJjcjcJ3QMPnzyJBo
 hIzwuH2SBgB00qVtLOzRLPMLru2sjJb7Yxt7fin8/GICPxaTquDOwloMUs/o6uwRiKaEQJglZiC
 amYzWYQXzWa9bwqpIDvs6fTXOa4Afrpi/rJKt5GyKAoinHnMjawnXdQ0pQhdzWXbfnvUQyDwZpf
 ZZqf/dOCFnf5dBWIlPT2abePZpCkLcnqWSH3L26tQ==
X-Received: by 2002:a05:600c:c4a8:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48a52ee579dmr213178735e9.11.1776938564126; 
 Thu, 23 Apr 2026 03:02:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/59] target/arm/tcg/translate.h: remove tcg-op-gvec.h include
Date: Thu, 23 Apr 2026 11:01:42 +0100
Message-ID: <20260423100229.2941820-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-4-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b..e28eac54af 100644
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
2.43.0


