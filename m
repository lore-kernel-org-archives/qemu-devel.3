Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF731FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdja-0005b6-41; Wed, 22 Apr 2026 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjI-0005M0-Gr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjF-0000oh-Hj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso58684535e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887960; x=1777492760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GhzRugtz7r81qjaHQWY+OM3VnH4PSBAPCVBp6m/BNPA=;
 b=tngnNYJ+C0GbdecNyzJcOOHnW1pSfMlib93dmfROIJd+aX5NhjgUH8Azu9sJYfBUEO
 mtgsZKGGN2gAOgsdb1yg5gcy2z9rHEDjdY569jLxFdw7DJUKmZDu7x6BSFQQ5mYQ7g1o
 GHGcn6LzlpDChmuuyMCV7wZXTSc8QBvr1Op+tLSw+/lE6114HcOl0IIsbvf/hvzgyvEl
 o2NUuObnZrGvneYKQ55twDftuL4PCqAqs4Y0Gx2nlNv1u9Ih1ZdmIEELCGRz/zlHFTg6
 ArqfEctccpt8GlP1wuy5MGfJ2je44sGpTCFum9XBvapToGPLPpyafAH8R6Ig4h3BIr8o
 0wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887960; x=1777492760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GhzRugtz7r81qjaHQWY+OM3VnH4PSBAPCVBp6m/BNPA=;
 b=F4Pk6jnwSio/6r94II988V0UMjbm+7buuhAQbFDMeNl66DWQne0FaX0zGqYOTPID7/
 QXzZo6DNMsVW+TwrYYmFO91JKgqE5iEI4ByKTqPW5K1AkzeuyE5zXybuTyVCn8+Biuue
 tXYe2AMt98oR2nhMqRlaOE1tVB3GkVGtK0/kE1rMO11xr6DrL+LxIw2VC77LipFaYXZ5
 whVerzqJorTasydblpKUNvzuPC9DLGBEET2P6/GzqM9zarwON3M/T0H8v9f1k8xoCFbO
 /yFVeW6+QERhY7LbFkD3yYXGi1kZ6RVwi9munGu9hm/bDUO614ubdp++p6ZRXpGzZ22C
 u7Qg==
X-Gm-Message-State: AOJu0YyjsSUwLfhumSSpXYeTc0zUKuUOp+yMW4GONhnfXSCa5z/wdv3Z
 BaM1n/kZfMroBGVgShbbP3m09ciaARJqOVQIB7n1kArPwpacYBHMEN4L84EsfaSl5Ot9rduOSzd
 GSdyn0UE=
X-Gm-Gg: AeBDieuFHlaibG87RCiCesDsWgc5SnoTZ5R40MOCBfuarWBA+1PfzJne37xQudYn7hy
 F8YqEJSyLh8Kc0woxrIIe3XqLAYa7dJD7nfOkk8rbbuFbTf6pXniUpKQh5bLTX4Zir6jHYfGAsX
 giZaH/So1MkGEH/zhQ2b77moMvMeTbw0OIcmofdwTrgt3jgePtV/HPI1YtILFsEOSFvpJXdWeGf
 9SW0jEk4C4K6XSb723fJ6kHganUSsZXipZveLE9+ahgFXRRAexjqsezwJZGwiz0QzD8kg8QFdBZ
 Iy13bxYKBS0NG+xPgEZxQSmczrsoHKHzD7HXd6bcOuukhqflyYTn22Fj3Ulk63NCDIN6oAJevrn
 bSzYnVIu7FEo7HFmLXVkIkmOWtmu707b3EH9Iku2XU60XXyvb138OrVvvwiqs/s9FAYTPNkXYhc
 G43KTxnNC2oSCretn3ar4FYtH4cpCOZoSn4/v2ZdHMj6NuKGST8of/pgaMGTK5YTtfAAzcaGUBY
 HYfM2MckZo=
X-Received: by 2002:a05:600c:8b2e:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-488fb7469b3mr364810015e9.4.1776887959755; 
 Wed, 22 Apr 2026 12:59:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm487553605e9.10.2026.04.22.12.59.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/48] hw/riscv: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:11 +0200
Message-ID: <20260422195746.88865-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-31-philmd@linaro.org>
---
 hw/misc/riscv_cmgcr.c           | 2 +-
 hw/misc/riscv_cpc.c             | 2 +-
 hw/riscv/microblaze-v-generic.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
index b0294e76635..ab9b6c7d878 100644
--- a/hw/misc/riscv_cmgcr.c
+++ b/hw/misc/riscv_cmgcr.c
@@ -20,7 +20,7 @@
 #include "hw/misc/riscv_cmgcr.h"
 #include "hw/core/qdev-properties.h"
 
-#include "cpu.h"
+#include "target/riscv/cpu.h"
 
 #define CM_RESET_VEC 0x1FC00000
 #define GCR_ADDRSPACE_SZ        0x8000
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index e04ccdf54fa..37fdd0b39ba 100644
--- a/hw/misc/riscv_cpc.c
+++ b/hw/misc/riscv_cpc.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/riscv/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d56b64792d7..b0494b1ac50 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/riscv/cpu.h"
 #include "hw/core/sysbus.h"
 #include "system/system.h"
 #include "net/net.h"
-- 
2.53.0


