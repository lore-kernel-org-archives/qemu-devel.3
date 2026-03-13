Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC33106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vx7-00038a-Cy; Fri, 13 Mar 2026 02:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwt-0002br-TR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vws-0007Jq-Eq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439aa2f8ebaso1149615f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383076; x=1773987876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjwXG3HD3XpvP9/7oovhxigtc1Qpbauxdo4lRyshqBs=;
 b=GAQlD7xhqq4oFnu67iHqeiZrAzPmeCT/6s+tb3F+Rmn+L50CC7AJWPJYbYmYM4U1Go
 e3TJiUBUXar+yESCaYal2ycZIlk9JO+05cHVjJSbniwUy5RlufjX8uU6ZxmA3V5r7zWi
 9nyXoxZIZYbDceoce8QkGbQR5RexDyyQD9Ed15a3pV/e65UatIgFYV3FZplcHLNDu9MP
 3nbqTUWNrhAfxMuf3xntupJwu4iCsJu7Mx1aWThM3lEt10pZEEgWscgzaU/VQRp3ekPh
 ZVTzJeOokmo4wSjU0aV+bybFrvAoTJ4XxUfJ8bFzkVHbb0Vee3NyNGF/eTIzkDSMhENw
 Mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383076; x=1773987876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UjwXG3HD3XpvP9/7oovhxigtc1Qpbauxdo4lRyshqBs=;
 b=BSxS2cg3GdtZ09jR5MklG3+4G5+OBcVFkBUrxxdjd+MVPXhiMYRohPWH8J638TeEFN
 0y6OvQj5ToeAl1eFu6WRqfvRnsvK0nf59Dxdh8zOvJpQxQLW14YnecQmXet2SRJS2WtR
 MbMw7R48d+ta9IndLO5QP6hiLF9068N8SQbBoRGrv2F+1V4pOI7fOLBq7M5FfL8k+4yt
 kpqwyOU8onBa+PM7C6ngjdBsE9IAJ4tS3yB9uqinEPtzpZdPa000bdOAxnSJLYXzDMcK
 6nMhjyVxt4NDkYJ2Ef8xkD2UEteLhFQnHLOF56Pgqk5BznHx3EX8Ol7Pk3RmOUHAKDJj
 DdPQ==
X-Gm-Message-State: AOJu0Yz7M98/NFpSaxQiZdWj4GIMSJ7gp+w4IyoxPE1ClEssYrCbfxg7
 VxcqmMG7QSvo9wSvm909N++yak61Hgxu5+ZmkSGy5QFx+upnl/du7uG1htVhEmOtYNfoIyA2lxp
 U6tNXScI=
X-Gm-Gg: ATEYQzz3xGzSVw7JTBAJN/CmqHb0WOURhWJ3pqrxqB17ODeIF2PhXUx4IbhTG40haKN
 cwT0drBTRNMRJ2bWkgEXdpRkTMIeN8n5IowIlJiNXAUMMWymXMIkVsKG4wUlvEm1RBbYBhPKVfl
 NH7H2z8dbdKAU9VBO8yrBaMvPhzi7MRRoZq6y0k1LyLRKt9rE3fQLsIHfnyDUUCh42MsBYIqI/e
 1u0WwZz/p1TVVzEK3sRc3w3uNJtelMjMv7/yNOslTFhsT/+fGrCYN6Y1qJHpT7pTdhFuFrAyLGP
 Sp9DNw5/E7Pn/nAshss71i2hzdk2rfDLAGELm1sUfXiGESk/6IV2ZuyBXgXjNiZT3+8ZcDaMgKB
 41BHrg1hES8vpB8K8GMTDkXU+V7WuVkJIyhfgxsrpYotbP2ySCogwzPHiegZsJjJyHSSoKadW9Q
 rQijouj2YjgPk9stAl9wLE0WmEFu/ELVFqC0fmFG+P3SqPJvQRKejg0wdM4NPZ3BL0iSrNqRlc6
 aZclrMXCsTW9hTX
X-Received: by 2002:a05:6000:2583:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-43a04db18cfmr4041002f8f.28.1773383076471; 
 Thu, 12 Mar 2026 23:24:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1b22e7sm15158142f8f.16.2026.03.12.23.24.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 32/38] hw/sh4: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:48 +0100
Message-ID: <20260313062055.2188-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
---
 hw/intc/sh_intc.c | 2 +-
 hw/sh4/r2d.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 16e4b619d6d..0da82f9d5e0 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/sh4/cpu.h"
 #include "hw/sh4/sh_intc.h"
 #include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index acb3fe75a8b..99afe3618e8 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "cpu.h"
+#include "target/sh4/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/sh4/sh.h"
 #include "system/reset.h"
-- 
2.53.0


