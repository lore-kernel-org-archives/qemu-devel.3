Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC953CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11c-0003yx-N6; Thu, 07 May 2026 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11a-0003vI-4y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11Y-0003uw-Dv
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so6671665e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169147; x=1778773947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2WJFdhjP1M6ypRwymI96woMtmQVRg2bYuGrvWFMPWrg=;
 b=of7u7piGmLJkZJh4E/XDpNoV4Rcd+FNQFc1D0gbk6lLzIRLWDd1psaCS8oA8T8+0Ly
 BQVIGEbLbTnKbHS38VdEBLm/l1QYa1duaPCNVABihZbW8tAR3/pyAz43P4UQuLQbwQjX
 x5xhS6WxH9ARTkLJjkw0J3f/JCJbDbH+knzX8JRZ+tews1xEERYERzQ44iq2rP02vzgQ
 G4NHBtPRwb2Sa5trJRywj/J8SwbFiPFjlTfoI4qjH3Beu2Sc3OKE18xq4dRPi7wcel/+
 hG83cpv85G4Uzi8dNrOr4AlDdFzbRO5Y0HqXKtzuoqjsalceeEpjDil5+NqicKKIDmr3
 aivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169147; x=1778773947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2WJFdhjP1M6ypRwymI96woMtmQVRg2bYuGrvWFMPWrg=;
 b=e8mY0T0jTqL0e1Zjyag06PlTnQ+S8n0ZXP/aPofoNaJ2jI8z43XsS9tog7wLOa3pZd
 uqtDLV0D6OKnagVzZqWmjImYUswJAVrvZt3VGIb0zB/RQWpYn1fdQpRFizPz1VhlobXN
 PYKUaAMKbGi0BhvLYe43Em5KyTWu3hUiLrbENolrDHsz8XhsBeGgFs0Tw8RYfOGTMlxQ
 otc4MPqJjPTboBiKYFWtJuOrdgJhDKsR7jFPFYsVa9lNHAal/hOy64xEk442tSbDavSq
 OYBmcWte69AoHD5wITD5SCraQ9FcGW0iWiH3utnHg/nyYOhAIQSGPpgtkxGl024dQx4N
 2+xg==
X-Gm-Message-State: AOJu0YyQ3gpbLiqmIGTOdC+tccZ5isSPHc+GJ6TCInOTnlYyP3NQ6kyD
 8o8FcSvm4g+yrS6nXes8E21cE4AC4Vldt9aOAbYptXP+wlT+yzuthAHFidyVm+yHalwaFQO3XQF
 CLvgl
X-Gm-Gg: AeBDievkhNoqdZIHjn5L/dAG1WCU92vKYPXanGDTumABm6L87H/W9CiRG4A42qvjdvy
 7zB8fRAEtndf+HHtPvv0SzqoXs0R+tjc/+W6n6nldr1mZ78LzjH9UaMF+2bi9L3RJTXbNuNGM7l
 cmhzACo+RQvtbN22TxRpJgSZMaU2gKepBR5e37Zx0yYd4xrNZyGBU/d5SnO33pGoLCx8bwN1piA
 rhKZHtpRSt3vvbN60J+shwnpBz4dC/xjKoEVoOZyI2UE73m4m1G1IbWOPuodmDARBxK16Ytl2MD
 Y9U1Z5NgQ8OavV+Zrg7l7xFDWYOJeSiUdWzgnte7xMJ+hxlRvwpO7h2rSkHlbl5V9jSHyKYM1/9
 SAzS5fPeTsiF2fCrfpsXThiiHMOLDtjmrxOWdI9rIPo4qbb0LDDw+T4O3Y2dtrYKwH5u8yLcvaT
 CtqEY+mMM3jvfX0VCBx4pBm/DheHsFnBQzPYLjr+LrH8FdF9k9yK/BBuXNRkgv47B4tDVrWJ6nx
 BK86p1GqiR9aM3NTG5QAaaXbjz+aoE=
X-Received: by 2002:a05:600c:a10d:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48e51e1f013mr107815895e9.11.1778169146847; 
 Thu, 07 May 2026 08:52:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/67] hw/intc/arm_gicv5: Implement IRS_PE_{CR0, SELR, STATUSR}
Date: Thu,  7 May 2026 16:51:18 +0100
Message-ID: <20260507155154.1886557-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The IRS_PE_CR0, IRS_PE_SELR, IRS_PE_STATUSR registers allow software
to set and query per-CPU config.  Software writes the AFFID of a CPU
to IRS_PE_SELR, and can then read and write the 1ofN config for that
CPU to IRS_PE_CR0, and read the CPU's online status from
IRS_PE_STATUSR.

For QEMU, we do not implement 1-of-N interrupt routing, so IRS_PE_CR0
can be RAZ/WI.  Our CPUs are always online and selecting a new one
via SELR is instantaneous, so IRS_PE_STATUSR will return either
ONLINE | V | IDLE if a valid AFFID was written to SELR, or just IDLE
if an invalid AFFID was written.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-32-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 39 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  1 +
 include/hw/intc/arm_gicv5_common.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7b0d9e16c4..a95a9dc16b 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -968,6 +968,21 @@ static void spi_sample(GICv5SPIState *spi)
     }
 }
 
+static bool irs_pe_selr_valid(GICv5Common *cs, GICv5Domain domain)
+{
+    /*
+     * Return true if IRS_PE_SELR has a valid AFFID in it. We don't
+     * expect the guest to do this except perhaps once at startup, so
+     * do a simple linear scan through the cpu_iaffids array.
+     */
+    for (int i = 0; i < cs->num_cpu_iaffids; i++) {
+        if (cs->irs_pe_selr[domain] == cs->cpu_iaffids[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
@@ -1091,6 +1106,24 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         /* Sync is a no-op for QEMU: we are always IDLE */
         *data = R_IRS_SYNC_STATUSR_IDLE_MASK;
         return true;
+    case A_IRS_PE_SELR:
+        *data = cs->irs_pe_selr[domain];
+        return true;
+    case A_IRS_PE_CR0:
+        /* We don't implement 1ofN, so this is RAZ/WI for us */
+        *data = 0;
+        return true;
+    case A_IRS_PE_STATUSR:
+        /*
+         * Our CPUs are always online, so we're really just reporting
+         * whether the guest wrote a valid AFFID to IRS_PE_SELR
+         */
+        v = R_IRS_PE_STATUSR_IDLE_MASK;
+        if (irs_pe_selr_valid(cs, domain)) {
+            v |= R_IRS_PE_STATUSR_V_MASK | R_IRS_PE_STATUSR_ONLINE_MASK;
+        }
+        *data = v;
+        return true;
     }
 
     return false;
@@ -1179,6 +1212,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_SYNCR:
         /* Sync is a no-op for QEMU: ignore write */
         return true;
+    case A_IRS_PE_SELR:
+        cs->irs_pe_selr[domain] = data;
+        return true;
+    case A_IRS_PE_CR0:
+        /* We don't implement 1ofN, so this is RAZ/WI for us */
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 69622e41c0..180fe338a4 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -66,6 +66,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
     memset(cs->irs_cr0, 0, sizeof(cs->irs_cr0));
     memset(cs->irs_cr1, 0, sizeof(cs->irs_cr1));
+    memset(cs->irs_pe_selr, 0, sizeof(cs->irs_pe_selr));
 
     if (cs->spi) {
         GICv5Domain mp_domain;
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index f259d2d642..59ac1c3880 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -88,6 +88,7 @@ struct GICv5Common {
     uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
     uint32_t irs_cr0[NUM_GICV5_DOMAINS];
     uint32_t irs_cr1[NUM_GICV5_DOMAINS];
+    uint32_t irs_pe_selr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


