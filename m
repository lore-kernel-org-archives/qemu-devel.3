Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889B6CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQj4-000089-AG; Mon, 12 Jan 2026 17:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQj3-00007b-A8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQj1-0002Vs-Mb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso41468915e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258166; x=1768862966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PoEtvG5/yuE7pWbdVg5nKxn7IMPZ6cy8Zjq1xhUHx6E=;
 b=zhBI1Qw/ogxmxEZZSwEhNrFVOxE/0x3ZJGJ4frar+92XjG94NTG6Ap6N6s9Sh/HOu4
 y1mhw31tb0AQm8MVgoeTfgF0TVqcd46b6Z5/6dE0L+mk+KtKKMDFqlcO0ATXGxdKr4Pu
 QB449VVGdFdztPChkNPH/ihE2GgIuZTKaKJU4Y5dTTI/SZejwHa+qOQEQXsNCiGGfPQ5
 +nDnkyWYsMwqILXvHbPf0bOLlJumGt6Bdip0Vlk0kI21NnP1RSbn0WlIALRfRxe4UuSW
 atWREEY+ZebYOk3ZRc9AbIvA3HsAS8c1hbSsEVMlNnRij8xh0dOy0q3c4dicoLnlAPMx
 zxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258166; x=1768862966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PoEtvG5/yuE7pWbdVg5nKxn7IMPZ6cy8Zjq1xhUHx6E=;
 b=KFRxV8dxZX6r3eT4JpPuMAcZpPRpLgLYtR/iBIjeZKfRJgkXzLXK+m3ULPDpBbqM0J
 b+dzhwV6JT5FkF48URZIwA04XymN/QcbxsCqxkEHqqoGS9rGy6dKf8e5MVL2wufW04/b
 N0+szUbKivT4fv+TYpsvTQ9vkTHNXz5eKWqfKdHsJI33Mf+xEjTptVPGaq7temSuShtY
 PWM9VBV49+nKxMoTUN9fNDwjZry7adJiFNxcOAfRlnZoJWvTI6ftXLuR9VRx++fJ7FyF
 Pvw/U1c9r/B5WsWPquw7oo2Uwx/6DQDKoa0DuQAFXPGB8TPcX+oVW+Mv8xp+QddUqCex
 7M6Q==
X-Gm-Message-State: AOJu0Yz1e1zOVY3juAu2u7AIzxNPly4uI5JL/4djKjAjk/FBi7wIt5P8
 ORzGlMAX9bYYihTCCoDJDf19PiXEce1NsNKj2M/ixMUgD/dgnX5BzGNraDhlDCuZYFfuH7lI7KF
 oqeKSVZo=
X-Gm-Gg: AY/fxX60RHpINzFzcMr0PqcLBx+8hF8kB8CYMvRPO5BHa7EmD6yLZS53uozlbAfpUry
 SA/PdRDP5f6GXaHYqVjjdCAtAcmi8ELyZluapHE05BKq/UtYW1NKrSr/zZzZVl6qGXzmfUYdjYF
 4HOuHTdErCzp3GRJWFmRz6iQ4Ls2g5VZdAwnR1IyK+w+qfQtfoY2T/kTs63r2bapE9uk7iqmehM
 FNW1PSpMJ1QKYQr94+nqQgx9n74tX1c7+cfa+QUvR2b5Rt73A9DG8YjOqb7qXLfcittz4dZz1r2
 0U5xVCIh4eMySqocz9mLJYKnB9OP1qQHobRXONF6tGQOqzXbtjKJsGsTSVnySpIrw/wh4cBhoGD
 rZadaQ9fNMG+vwH3BEURZ6t57GFasA5gDi/gDseCH9MBPRggu1CJQBXXrv2SdQg++2PqeNjTeN3
 ltQP8WeDAiVOZwWoo2aSkpnwos16kzw11zzyGsfVeN6zfsp/U4Ueqhrga6EQux
X-Google-Smtp-Source: AGHT+IG90xwllp5XQQ2DX1m8UYfjK/tTdm9V5OpjHGVq47iR/okARkLPZEyDwTOS/VpjkJhlBsJ0XQ==
X-Received: by 2002:a05:600c:468e:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-47d84b1862cmr247289455e9.13.1768258165790; 
 Mon, 12 Jan 2026 14:49:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f686sm372222685e9.3.2026.01.12.14.49.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/61] tests/qtest: Remove unnecessary 'qemu/bswap.h' include
Date: Mon, 12 Jan 2026 23:47:59 +0100
Message-ID: <20260112224857.42068-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

None of these files use API declared in "qemu/bswap.h",
remove the unnecessary inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109164742.58041-2-philmd@linaro.org>
---
 tests/qtest/pnv-xive2-common.h     | 1 -
 tests/qtest/aspeed_smc-test.c      | 1 -
 tests/qtest/ast2700-smc-test.c     | 1 -
 tests/qtest/libqos/fw_cfg.c        | 1 -
 tests/qtest/libqos/i2c-omap.c      | 1 -
 tests/qtest/pnv-spi-seeprom-test.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
index 2077c05ebc7..3b842274243 100644
--- a/tests/qtest/pnv-xive2-common.h
+++ b/tests/qtest/pnv-xive2-common.h
@@ -15,7 +15,6 @@
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
-#include "qemu/bswap.h"
 #include "hw/intc/pnv_xive2_regs.h"
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 50a87e62500..39af1df0ed7 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
 #include "aspeed-smc-utils.h"
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index 62d538d8a3a..33fc47230ee 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -7,7 +7,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
 #include "aspeed-smc-utils.h"
diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 0ab3959171b..8611f648c14 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -17,7 +17,6 @@
 #include "malloc-pc.h"
 #include "libqos-malloc.h"
 #include "../libqtest.h"
-#include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
 
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
diff --git a/tests/qtest/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-omap.c
index 6f98f54820b..71f70c64f85 100644
--- a/tests/qtest/libqos/i2c-omap.c
+++ b/tests/qtest/libqos/i2c-omap.c
@@ -10,7 +10,6 @@
 #include "i2c.h"
 
 
-#include "qemu/bswap.h"
 #include "../libqtest.h"
 
 enum OMAPI2CRegisters {
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 8033261758b..44e0b92730b 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -7,7 +7,6 @@
  */
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qemu/bswap.h"
 #include "hw/ssi/pnv_spi_regs.h"
 #include "pnv-xscom.h"
 
-- 
2.52.0


