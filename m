Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABB3CDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmnQ-0005cA-93; Thu, 25 Jun 2026 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmnO-0005be-Cx
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmnM-0003mu-U8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:18 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c6b3f71648so971705ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782404355; x=1783009155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uI8qWvyl2Mgn+nLZPCFC1tyYQok17fDT7nBfLvBug6k=;
 b=qMseBr1yd0hTbm0ZVbaln3Euhkc9MQ7GfAN48TFFNBPmKGsQqU+L6nt5MmrtGsSjHS
 BEDR4elQyYNquP2H9pHmyoeLM88Y5gyjdoXhMFLbQZXin03B27YKnko9CanDWoqsuKRv
 WF5BhaXsAkvuyx/XGESX0Q/ZqEAvGkK19WOysstwq86h6TmK+dD2xIvwEUIiniNs8M2A
 cgc/zequ8zTu1F9BNGfVMUKSuw4yj3mRxeSCRkJM9oWJDtD2ukaJDcG8U14HKnp3vX5T
 WAlE9S2lYFtX6AGEbGoh3TGwM2s8UPKz3BnrjOViTGkwH7N0CkzUcjd+d7LKd2xnKJ9v
 rfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404355; x=1783009155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uI8qWvyl2Mgn+nLZPCFC1tyYQok17fDT7nBfLvBug6k=;
 b=ikvz0o4xWL5psrESZsH2YTJSXRk8oOjUhdMLiRxb51Y5em50eF1HIDj2hfGZSL5E0M
 icyaw9fooNgXn2yaBAINwrARqfoHTMZxlfk/PrwnwjApbbksQNiGrytBs0wbSRfkd8Cz
 QhcuExJhU+fY3EBDYcrcnlSTbdSdw5XjnXfD5oIidv/IX8Etadm/eAK8h1g/VreTD0Hq
 qCiY/1NdxFrunLhYzMVrWvFwKe62iniQIpRA3A0thP4mI5ABSnyzfUoKE/Xn6/nzBmIu
 aWP6uG2ndiEcacQh9+VRdxtXYjwhebmkdZw4yVpuX/JrnWMBNAF/cjAcqBmzU7KKaTq5
 xIbg==
X-Gm-Message-State: AOJu0YyGxHG6jjGKfqBJ5kLbjwJxUJkzr9LwU0neBPSva8X3Rz9CPGAM
 8Fog4lPemmJBFghUqac8EfJ4SD7Dfc+tz+mJJ8MAPUP5CXHcFtMO3xjP4KihNmKlhrM=
X-Gm-Gg: AfdE7ckR8jRcmPvn465OeetT3fPNvsYhHQ85A5aszPJ154K2h5eqCTEQz7jF3xm99YG
 UxWpjUkukvav5XBuFyFvr+O7NpPjBvtPz2WwOWn4Sw1lhHj1h4DKme0gyvI9Zd0gUHsrYk+5FXq
 XTfhuiOfbvxXH/JFg78LUQcMcT9Y9mByo2slS1UVQjP19UZN0kBQRLwRpoXzxa86hTeTgQvVgOK
 IwDcf7UfdpRvFfDbAgxzjApIQPiTfQR/C4uBQiqh5s53EfgGqS3jrQbfGZH7BhSWBkiNHRogQuk
 mzEUo6O/EQoBp1xbXyn6XDTIlmXax2Y1mFoskS18SwCmreffG8Ix/YWSou69kEWC4qRkTLO3Pbf
 7u+CvFwM5OT0nKfBj3YA2t0QQHV6x1gVE2P5DpFLyn/J9bnLz3dDi34dExLpNNdPSHp6oXquh7e
 8rEhOlCXEWdSrNotnRUh6WNdn7xM8=
X-Received: by 2002:a17:902:e744:b0:2c6:9758:9db2 with SMTP id
 d9443c01a7336-2c7fc9bfe23mr35411385ad.3.1782404355156; 
 Thu, 25 Jun 2026 09:19:15 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f64dc839sm22650235ad.68.2026.06.25.09.19.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 09:19:14 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: jack wang <163wangjack@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH v3 1/3] hw/misc/imx_ccm: Replace DPRINTF with trace events
Date: Fri, 26 Jun 2026 00:18:51 +0800
Message-ID: <20260625161855.5132-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: jack wang <163wangjack@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx_ccm.c    | 18 +++---------------
 hw/misc/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/misc/imx_ccm.c b/hw/misc/imx_ccm.c
index 9403c5daa3..b77e9561bb 100644
--- a/hw/misc/imx_ccm.c
+++ b/hw/misc/imx_ccm.c
@@ -14,18 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/module.h"
-
-#ifndef DEBUG_IMX_CCM
-#define DEBUG_IMX_CCM 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_CCM) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_CCM, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "hw/misc/trace.h"
 
 
 uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
@@ -37,7 +26,7 @@ uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
         freq = klass->get_clock_frequency(dev, clock);
     }
 
-    DPRINTF("(clock = %d) = %u\n", clock, freq);
+    trace_imx_ccm_get_clock_frequency(clock, freq);
 
     return freq;
 }
@@ -64,8 +53,7 @@ uint32_t imx_ccm_calc_pll(uint32_t pllreg, uint32_t base_freq)
     freq = ((2 * (base_freq >> 10) * (mfi * mfd + mfn)) /
             (mfd * pd)) << 10;
 
-    DPRINTF("(pllreg = 0x%08x, base_freq = %u) = %d\n", pllreg, base_freq,
-            freq);
+    trace_imx_ccm_calc_pll(pllreg, base_freq, freq);
 
     return freq;
 }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b88accc437..fdb4844045 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -237,6 +237,10 @@ iotkit_secctl_s_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit Sec
 iotkit_secctl_ns_read(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_ns_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs write: offset 0x%x data 0x%" PRIx64 " size %u"
 
+# imx_ccm.c
+imx_ccm_get_clock_frequency(uint32_t clock, uint32_t freq) "(clock = %u) = %u"
+imx_ccm_calc_pll(uint32_t pllreq, uint32_t base_freq, uint32_t freq) "(pllreg = 0x%08x, base_freq = %u) = %u"
+
 # imx6_ccm.c
 imx6_analog_get_periph_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u Hz"
-- 
2.53.0


