Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39B7C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SeV-0005qb-4N; Mon, 13 May 2024 06:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeS-0005p4-Ce; Mon, 13 May 2024 06:11:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeP-0006Nv-GH; Mon, 13 May 2024 06:11:23 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59cf8140d0so949491066b.3; 
 Mon, 13 May 2024 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715595078; x=1716199878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTlmaVG3MgnpSaFXvkPmHZXU1e4/64o+61NDr9XBH+I=;
 b=fCuckwRDkGQfaO9K9gx5XqdArWXie8DuDaskZdYur+Q/yb6utSjEyLwE5llW246Z/f
 30BAxoY7xkiTdBuimMDsWVrEKe4DjFCeoNBsVCrPT1zrVIWjtAVGfgLv3eNa7xnVd8Xa
 V/x4dAj9oEJDl+GqpBx0zxEBLIu7GoYIr7TOr5bXJp8wvgXbO639o9oxSr8kOmyuWF0V
 UdYItUr6qpIKO7W204OZSvXAh2rZU3FGFkLHd2CgZAaz8JSiaZrM5ASiFx1B5jV+VJQk
 lHxfVJDKaCGc04zheVo/VCntxyWMAlvyBDSzQ5xp2cFqiqBuCOTVbvl69Pe7uHBb0Zj5
 Jo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595078; x=1716199878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTlmaVG3MgnpSaFXvkPmHZXU1e4/64o+61NDr9XBH+I=;
 b=sm3Zaw4aieany1Q0HDUok9EWJo5nnLBQZ4TxA2qTf0IxaN4LALK+5A9CcQsMffcvL8
 4930tipKrv0nb/ZQKR4/Um/0w7pZ0hAYdL329Y/ZJbKzPCMQFvDi6PH/75RKlCsUDWvm
 guh/MWwt7aps9Tfvd3k2rs9ZFGmCCqkR4ZhEuXBNZ4ddouEEnRdLiNkx4bTjFrXwJcsZ
 Eiak4j4bj5ulL9++/bHsVmuxD7zAx01V1/kruCJwlmIWu+JzMNkk4aDh3YiJZhLkSr5Y
 ga43fuOB6ZdycI41IN/KA/BckzAIdmQUlSKwBmtBjykSHCdQkv2ocCw3tTudoI+2tzOp
 MCTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn2a1lPh1ZBRe31XvktuDHMo/wNxwRp9OXM1Yjhfw2hkFuMDeM+7gZlDCRPZe2PwbxTeaNKletmAPvDG6R0ZUtL4BCahXftLSaTWoHtEYUQZs6etzTI5JmzxUauA==
X-Gm-Message-State: AOJu0YxklvIvPK20h6WDToO0TCTyrGw113ax2RQ2M0N/sDl1RwfxILrl
 xkGQbq/PLjEqJmuqv51Cyoj6IHDrttX9aJS2HqDh6Qlvu5yYX5CRXPbHtA==
X-Google-Smtp-Source: AGHT+IE0sq4Bc5bd1ddt0NRyLXoW9wrni8vVjYMYdv5kwZlC1KR9GVjD5jR/+u099TPLyP3PSFAkCQ==
X-Received: by 2002:a17:906:4f08:b0:a58:725b:a021 with SMTP id
 a640c23a62f3a-a5a2d54c467mr522854066b.15.1715595078229; 
 Mon, 13 May 2024 03:11:18 -0700 (PDT)
Received: from archlinux.. (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d2asm574906666b.87.2024.05.13.03.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 03:11:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/3] hw/timer/imx_gpt: Convert DPRINTF to trace events
Date: Mon, 13 May 2024 12:11:07 +0200
Message-ID: <20240513101108.5237-3-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513101108.5237-1-shentey@gmail.com>
References: <20240513101108.5237-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/timer/imx_gpt.c    | 18 +++++-------------
 hw/timer/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index a8edaec867..3c3b044622 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -18,19 +18,12 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #ifndef DEBUG_IMX_GPT
 #define DEBUG_IMX_GPT 0
 #endif
 
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_GPT) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_GPT, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
-
 static const char *imx_gpt_reg_name(uint32_t reg)
 {
     switch (reg) {
@@ -145,7 +138,7 @@ static void imx_gpt_set_freq(IMXGPTState *s)
     s->freq = imx_ccm_get_clock_frequency(s->ccm,
                                           s->clocks[clksrc]) / (1 + s->pr);
 
-    DPRINTF("Setting clksrc %d to frequency %d\n", clksrc, s->freq);
+    trace_imx_gpt_set_freq(clksrc, s->freq);
 
     if (s->freq) {
         ptimer_set_freq(s->timer, s->freq);
@@ -317,7 +310,7 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    DPRINTF("(%s) = 0x%08x\n", imx_gpt_reg_name(offset >> 2), reg_value);
+    trace_imx_gpt_read(imx_gpt_reg_name(offset >> 2), reg_value);
 
     return reg_value;
 }
@@ -384,8 +377,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
     IMXGPTState *s = IMX_GPT(opaque);
     uint32_t oldreg;
 
-    DPRINTF("(%s, value = 0x%08x)\n", imx_gpt_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx_gpt_write(imx_gpt_reg_name(offset >> 2), (uint32_t)value);
 
     switch (offset >> 2) {
     case 0:
@@ -485,7 +477,7 @@ static void imx_gpt_timeout(void *opaque)
 {
     IMXGPTState *s = IMX_GPT(opaque);
 
-    DPRINTF("\n");
+    trace_imx_gpt_timeout();
 
     s->sr |= s->next_int;
     s->next_int = 0;
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index de769f4b71..c9bcc85455 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -49,6 +49,12 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# imx_gpt.c
+imx_gpt_set_freq(uint32_t clksrc, uint32_t freq) "Setting clksrc %d to %d Hz"
+imx_gpt_read(const char *name, uint32_t value) "%s -> 0x%08x"
+imx_gpt_write(const char *name, uint32_t value) "%s <- 0x%08x"
+imx_gpt_timeout(void) ""
+
 # npcm7xx_timer.c
 npcm7xx_timer_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
 npcm7xx_timer_write(const char *id, uint64_t offset, uint64_t value) "%s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
-- 
2.45.0


