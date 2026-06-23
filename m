Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D70CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4Y4-0002Dz-SZ; Tue, 23 Jun 2026 13:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wc4Y0-0002AU-FE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:04:30 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wc4Xy-0003KD-UW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:04:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-37d826e9811so118981a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782234265; x=1782839065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlzIbVxcAOU5tPVL2zqrsVyT/51HE3VKobCPOsDkikU=;
 b=dRRI3ttVcPLEDAChBUC+S2bvL0TzGnda35V321hl9j20pjeMeVC4+hgEAKse8C1EUN
 InzaXoutrOeNYarf3+mdmLiwWisfatQuC8mQ0nqwsrbLNuSj3aJGHyMB+MDBWPtxQkNM
 P4WuCOp3xo4jub+UVH+uTpMid9ZsZO6R4CkxzejRCULIpBvbUxEOpIJkujCgeCVfLSNM
 +WAU5V9casYI+K7TiU0NWQknbFSljdZ0mV4WYopLjKPoOdY4VJWrZlpSK6Pum+QLri4G
 2sXAZBExkqprjaXy0VcWqEn+5Xo51mRtpvHIyGpb7vHR3WTuDSB990k5j+HYOkF9uVIL
 aiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782234265; x=1782839065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlzIbVxcAOU5tPVL2zqrsVyT/51HE3VKobCPOsDkikU=;
 b=DHN2DTiXTeHwW9h4DB3L/AugtfcpxkcXMCjtdDELPP2WovmkeNzrvwwsnBbfriEA5i
 esgogtqWjWMGae0mFlOObo40s2v4w7tmBP9wKKTW4o3vt9snERfTpWNA2AAo4ytBE2Ut
 0axwJUdudFhFmQ8O/Z7Xz/gSZmzEO/x45ppohlW5UJMjffXKqfh5ofw/bVoduPv1Yjv/
 KyUNT+ben/oIcig5YnCLbo2ktGK0KQ+x2jtM5rWkFOwjTRhOEtm6Kmz/QzaPiTCa2Mx1
 tcypMbH47uc1RaoVXakbCM66VHOf5rxCwAbVoho+Qa8HCC81SzLsZxTkYUCD9y7GJ3AS
 Kl+w==
X-Gm-Message-State: AOJu0YxrfsRpeKoLMcYHLgVshgsYu4vBVe383WLAjcvHg40/us5PTSzw
 3Ss3C5+5xfFcA9YAjRD4hztDG3OJxLpvdgdU6JQHasVm5NRYbDSgo5CWvsL/QQQR
X-Gm-Gg: AfdE7cnuagW86OXg1uHdt5CrfTws87uJfVqLc6aNiDQlOuANvRS9wGJCx+7kkSmOeFU
 9Z57EB/mUYpZtq6Zp32cUuMut9fduDZ+iFHi9a0wSUnyEAhvcisLfhiXj8TtWAVIFwmzEwjX6MI
 or0Bqc1PUPiiG7BPwSd/AKJNPxQUBgxFUUZkFUMLI8m/36OVRUBrqcxEtVra068mvijQ6Nspmin
 Hij/btF+BCRTh2S/vk2KtmSnJrHqt7eVU3K2HidGLtESveBLfAVOp5JYyUY8h/uXmUJGMWGwX2+
 VBwrcevgIVN/7/ke9IoBLHQUXNvH+VekZ9tzL1BaplmjknMBy54mOnA56X9ZnNASV/wWBJ9oLSl
 T3JN0aFNTX2SWUhLCNl6UCxxPjeOE/CuWeEZZPwNgsNHmFHXrhYwwetoicCUKJXRdE8WETaJXct
 ijwskmwtdjMd5gV+eV9poR2I4MBwM=
X-Received: by 2002:a17:90a:d887:b0:367:bc89:546e with SMTP id
 98e67ed59e1d1-37dd173bc9dmr3605844a91.12.1782234265373; 
 Tue, 23 Jun 2026 10:04:25 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4f225870sm10242924a91.8.2026.06.23.10.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jun 2026 10:04:24 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, jack wang <163wangjack@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH 1/3] hw/misc/imx_ccm: Replace DPRINTF with trace events
Date: Wed, 24 Jun 2026 01:03:52 +0800
Message-ID: <20260623170354.43981-2-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623170354.43981-1-163wangjack@gmail.com>
References: <20260623170354.43981-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102e.google.com
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

---
 hw/misc/imx_ccm.c    | 18 +++---------------
 hw/misc/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/misc/imx_ccm.c b/hw/misc/imx_ccm.c
index 9403c5daa3..30b8aaab8e 100644
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
+    trace_imx_ccm_get_clock_frequency(clock,freq);
 
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


