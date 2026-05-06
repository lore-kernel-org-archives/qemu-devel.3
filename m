Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD0FCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjI-0000n0-Ae; Wed, 06 May 2026 09:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjC-0000jJ-1E
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjA-0007o1-He
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so2249169f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075750; x=1778680550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KNWJ8dWRU6iG55iUFloHSqRc4Fii/SCqlZWk2VESoKY=;
 b=ZQIEje4ssp40lbbWr/p5KFLTmXs0kv7PraBQUi8xAcUjDV7A4KJb8Imba4oEyGmtEw
 uoudi5i6v1hfsvK4iNsiVRzIhQEl1w4018seR21nrUknQFI15MBY5Vi30y+Ff6OGDV8O
 iwPTOX3yLaFVWYzVHjd9Uwxke+/GSDUB7A/dMTjtJpMscgi+xKDmvPlqHFES2+oYpJor
 U1XcHfPlOwftCrMFwclEUaqtnmFVHXUIzYBC0UGca7VwnhXg4dZ3sH25yf0Kit4k7msj
 dRYZA9huq0CRfivMpK8GtzDSH+4YOLj0vNcthpFSaW6OGwJ56EATC7Tybb3iDhtjLl0S
 Gb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075750; x=1778680550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KNWJ8dWRU6iG55iUFloHSqRc4Fii/SCqlZWk2VESoKY=;
 b=QUOhG1ciuCiXdIG8vO7jrK7V3wDdQn3/2IyM55zYKvJPVKUP2MX9KLgW/sYLFqSpB3
 CXR6OB33wDmV5+rerk5tHJGfam4nZyNUwqcP4bvOzZ7084cB8vegpqsGMeNbXkf5ATwq
 YQ3+goK3JFi1FjbB6YNWl3sWz628rOL4L+mhp8xMNUoaUe3OO5NA2KgPvdaOlHob3SsO
 /AzmYP9jwsKP97Zu872xpxdvyWc06aMSCh5FHxUEMpGrObSAmOwbSdNayfD9vqVXE/9w
 B05LAgw60DqlvG6GjoZh8g3WyHROLFSmliB5DgVMVlNy1UFcSYcDCtxNveAulqyNYBjM
 /MCw==
X-Gm-Message-State: AOJu0YxJYlfVG263TwL2t+8oDveR7lKMZsu3fHmDfSvN0oNJJ9j2vTXY
 3ERd6EGNsSpv/RXovPcG8lW6B5ag83gqLKiaLc+Ul7icjbSuEgI61bp9etTBnFNGdgePJc9r8l4
 t+J0H2CI=
X-Gm-Gg: AeBDieud5EoDTycmVvMcbz38aIomlAJjnQ0MxA2akwPKsDnL+j+axyAGbisu2yNZkIj
 mkx4qg/L7PENFgyLaxSa8gPMUBCrr/dI3Pi20DbBHhgPqGcVYsH4rVNwwkfJJhr+vLNmAL+IKTC
 zAAxIbNGdS0KEkEa+T9Aq7zjjoELaB8P9Zcz/X8AUxHAxQn7bsZ6cyP7B4QZ6Rxzj47SdMS+k1T
 h0BA+RaqO+HPhXiio1XJx3spAkpBM9Z+kECNWp0b4pNfOcdVMgXk/H+MxSCz2jJm2tR5EJ1Odgj
 wLa2YlvkEDE59vZuH/P+LzPFNs8sm7yBLZjz8BkH/zC5kT3oMQ95taKjJnPwpJrHiij5DgIJEP0
 ICaSfF9aS2KPWpVo54EWWgX7W6vBLp4FY/KXpXdyZYP86lWR9hSov9lie/7tYHht2JWy+i0iLkl
 XVCc5Hh7+faYBX/c/UvYTwn7v7VF4rXwlbEMxmr42Lu9F48CWCOq4Rr2limBeA/zhLg0k+RfF/J
 jXz05KLboQ=
X-Received: by 2002:a05:6000:2207:b0:43d:7dc2:b655 with SMTP id
 ffacd0b85a97d-4515ad767c3mr6386799f8f.15.1778075749809; 
 Wed, 06 May 2026 06:55:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960973sm12626626f8f.30.2026.05.06.06.55.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:55:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 003/110] target/xtensa: Restrict inclusion of 'exec/cpu-defs.h'
 header
Date: Wed,  6 May 2026 15:53:35 +0200
Message-ID: <20260506135524.20617-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Not all files including "target/xtensa/cpu.h" require the
"exec/cpu-defs.h": only 'cpu.c'. Restrict to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-7-philmd@linaro.org>
---
 target/xtensa/cpu.h | 1 -
 target/xtensa/cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 22192924841..dfd2ceab7cf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -31,7 +31,6 @@
 #include "cpu-qom.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/core/clock.h"
 #include "xtensa-isa.h"
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index eebf40559bc..31429ec2f87 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/cpu-defs.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
 #include "qemu/module.h"
-- 
2.53.0


