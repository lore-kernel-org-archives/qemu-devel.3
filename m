Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A5DCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11b-0003xF-4k; Thu, 07 May 2026 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11Y-0003qT-0Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11W-0003u1-1I
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so6698875e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169144; x=1778773944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9kSvZPNJ/0h8DslXFM1DRCfgRBIyBkzr5YFk2QTNNLU=;
 b=Cw2inXfKMVymbsPbFniVCsUDweQ4iCrA0qxndeAhKnxnrykK17w7+PhDQbkMyiQ2SF
 2m0oJG4cqIHhgGOAQrPi6WpcCaLRs40IDl0Lm+LvUAnNoV0seufICA07xAxMkj4N6f6y
 xkZhJHvifOM91AUtkUSbmj8BmyqYhXN1DTdscy1Bs53D3ppQQGC7IvmgAjky6OSSAYkq
 l7f2z+efvbnCQ8CZo4/WPqdcD4FINAmabBXO3cHRQSEYVuufY4UMwodRSnkKLP27Bqsi
 VCY5r2yl8x4MUvxkSdzb6LNx4Fkx6OG92Aakkj5Z68BQMTM64ddnbZaug8JPEk3Zv2IK
 04bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169144; x=1778773944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9kSvZPNJ/0h8DslXFM1DRCfgRBIyBkzr5YFk2QTNNLU=;
 b=QoYkea9aSwPS4Kq5gQi86vTlTmF4WkWuiaeGhqehqaqKf+VHuEau3Z875h1eVWrdMH
 vwkqjNb/P3Vgp7SMihn36pSQZV4K2kvAKD5gRLHLVLSiWTGBlwI5FLX6lCxJRZ3Vh2ig
 CF5EFNyf//0lvWN85RZI4cNpnBQxjJFMM6aHceqk3tpbxjl5as6LmZuMlxaVs8fPBfHR
 XLFKZADVhTgpEFuqFCXUzsM3bTzPrQGg33/k/v99ZNtnTW+RO9vd9UwmswW2IgVx4dSd
 p8a/14C4uf3BoKpvE52gOKNTJUp1KXxC6H3TNvPcXQzwY1EMPzSlnqzUUJqkpHZ4QeLB
 Ajbg==
X-Gm-Message-State: AOJu0Ywur+qKg3HSh/4H444gU47gGdXKqCgEUCXk+OlqQX2sYVJjQ8un
 DLVZcM3B5afWlydgYM/QP5zGewYHNzNKmmyhIcMIiOp+L+dsEOXPXLau0WxLjk8IAlfUpdr3kkl
 8sFHN
X-Gm-Gg: AeBDiesWXgpMWx7/jsgGGzQB9WLnqEjpwAe7fhUgLo6r/tM4SXpQZmp0x/Sy5zJgb6w
 ubMPuqFkBK2S1DDqqKPTJuwfLb+obFHZqKP7MPoBmdVhNQ60lKHN1muLpYjpr3hfKpXBJ+/7jAo
 aoHqcsGln+UFS31uV0yNFar/70rfu1OwUmw+04u2j0JkUARa3WKBK3dW8rAf6fsL+2ADGrA2Y9r
 XV2iO+eSEuYcLKVWLHDPbq3+7N0dbWIAianwa0dwt51RPUZlg1cEAWRh29DbMtzqNYxWiz2MLYC
 HrRSFGpy9vdsrrVOwkEO7xjHH+UqDy/wcpt7po4GNm0hDRw7MJMwrnNNEMfwrhiO1TN+GRFmLhH
 fYdZ84fmHpX16D1C/cDu37CM1HyZH6y/0Obv6mGCByP4BwoxmTXA5QPZJl2TptuqPijeLIyVW0+
 /EIhaRY2yyx8/7b2AIcY28mn8Is2tw23U4U9EDAUdBI1GQEIminPpH9sCx9f901txugder+IRiO
 NsKVDELBnozJFxhbXmSAIcO6SGhxB5yiQMTdD9yKg==
X-Received: by 2002:a05:600d:10:b0:489:a4:e555 with SMTP id
 5b1f17b1804b1-48e51f36fc6mr114720755e9.21.1778169144187; 
 Thu, 07 May 2026 08:52:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/67] hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events
Date: Thu,  7 May 2026 16:51:15 +0100
Message-ID: <20260507155154.1886557-29-peter.maydell@linaro.org>
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

When an SPI irq line changes level, this causes what the spec
describes as SET_LEVEL, SET_EDGE or CLEAR events.  These also happen
when the trigger mode is reconfigured, or when software requests a
manual resample via the IRS_SPI_RESAMPLER register.

SET_LEVEL and SET_EDGE events make the interrupt pending, and update
its handler mode to match its trigger mode.  CLEAR events make the
interrupt no longer pending.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-29-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events |  1 +
 2 files changed, 60 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 6ff3a79745..bc887233f5 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -946,6 +946,28 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 }
 
+static void spi_sample(GICv5SPIState *spi)
+{
+    /*
+     * Sample the state of the SPI input line; this generates
+     * SET_EDGE, SET_LEVEL or CLEAR events which update the SPI's
+     * pending state and handling mode per R_HHKMN.  The logic is the
+     * same for "the input line changed" (R_QBXXV) and "software asked
+     * us to resample" (R_DMTFM).
+     */
+    if (spi->level) {
+        /*
+         * SET_LEVEL or SET_EDGE: interrupt becomes pending, and the
+         * handling mode is updated to match the trigger mode.
+         */
+        spi->pending = true;
+        spi->hm = spi->tm == GICV5_TRIGGER_EDGE ? GICV5_EDGE : GICV5_LEVEL;
+    } else if (spi->tm == GICV5_TRIGGER_LEVEL) {
+        /* falling edges only trigger a CLEAR event for level-triggered */
+        spi->pending = false;
+    }
+}
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
@@ -1096,7 +1118,24 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     {
         GICv5SPIState *spi = spi_for_selr(cs, domain);
         if (spi) {
+            GICv5TriggerMode old_tm = spi->tm;
             spi->tm = FIELD_EX32(data, IRS_SPI_CFGR, TM);
+            if (spi->tm != old_tm) {
+                /*
+                 * R_KBPXL: updates to SPI trigger mode can generate CLEAR or
+                 * SET_LEVEL events. This is not the same logic as spi_sample().
+                 */
+                if (spi->tm == GICV5_TRIGGER_LEVEL) {
+                    if (spi->level) {
+                        spi->pending = true;
+                        spi->hm = GICV5_LEVEL;
+                    } else {
+                        spi->pending = false;
+                    }
+                } else if (spi->level) {
+                    spi->pending = false;
+                }
+            }
         }
         return true;
     }
@@ -1109,6 +1148,17 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
             }
         }
         return true;
+    case A_IRS_SPI_RESAMPLER:
+    {
+        uint32_t id = FIELD_EX32(data, IRS_SPI_RESAMPLER, SPI_ID);
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (spi) {
+            spi_sample(spi);
+        }
+        trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
+        return true;
+    }
     }
 
     return false;
@@ -1259,8 +1309,17 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
     /* These irqs are all SPIs; the INTID is irq + s->spi_base */
     GICv5Common *cs = ARM_GICV5_COMMON(opaque);
     uint32_t spi_id = irq + cs->spi_base;
+    GICv5SPIState *spi = gicv5_raw_spi_state(cs, spi_id);
+
+    if (!spi || spi->level == level) {
+        return;
+    }
 
     trace_gicv5_spi(spi_id, level);
+
+    spi->level = level;
+    spi_sample(spi);
+    trace_gicv5_spi_state(spi_id, spi->level, spi->pending, spi->active);
 }
 
 static void gicv5_reset_hold(Object *obj, ResetType type)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 409935e15a..4c55af2780 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -241,6 +241,7 @@ gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t i
 gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
+gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
-- 
2.43.0


