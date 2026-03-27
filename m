Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D6A10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C3-0006nR-AK; Fri, 27 Mar 2026 07:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bx-0006gX-NJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bv-0007yC-Fn
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so18687375e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610246; x=1775215046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpR31boHFrDIOvEfT0ZIVwsIEVw9EEegLZSAQPBvMFc=;
 b=BqguwpEnLEBI9Fn1Va7HgOM9555THo9ldjumgnEPOry8w60VnvZRYcM8tMaVyw1fMf
 rO3aqS/j8+Fb3Q8V7c604txgesrULCBe9EPFmaCqP+6euFpN/FZyelIXhV00KlM7/fy2
 S0kjDATPdpYaPGlbCihw3NqLwKcPUrc1blqS0mXuAQxa/62ODBlzRNY9vqGm7b1Ly63Y
 aov20Dpw9nJef/UnP5XqShA2K9T6d7XHC6O+OtRp+uLQ7mKvJ5rjowEw0Fdl7r9SI6XC
 SM2YzFPHDWGK6aOYorFKmR0efTpBLfUc9pOEs0ZwOGgaISFFHL3PAJVkmm8yUI/VIW+1
 JIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610246; x=1775215046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JpR31boHFrDIOvEfT0ZIVwsIEVw9EEegLZSAQPBvMFc=;
 b=nKoNQBZwBdfO1mHMmwjZJv9t+AEMaefhw1yiq++1rHA5KS97+jiP3DEo5M6TMoER7T
 IeNHuvRDFYitntFa+2rh++5dBo2FBtg9nrX99jIzmQv56h3tLgNmVvOo1EQ43D/IS8qO
 YtbQRWQFAoK538MB2692jXrWkdaac1rYo3RfuXKxASLE4Trpp4+MBm/ceNSHonFOXWO3
 16X3GOdWO8/PjbUFhqXx/N+lQKoAtiZZwVw3UCIk5Mevk+qG+0JO4K20re3dYoePK3NB
 FdXh46RZIuE5BGP1eoO1CM3Tv62wUjMbXsk6v4aATSTzlUnYiPIXeuDA+lkQX69My9y4
 pBiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbtsctMZK4weW+BKiCUk3nfgL4lJqxkZ2B+re4kMaltUEXMq3YNeEmfELFbFfM60jIx+C7fvilKw8l@nongnu.org
X-Gm-Message-State: AOJu0YxQKWZSaZIlGV/4HRYuMiLAFCRCUmg+qsaFWJZuaJijgidUwmdM
 /rDtPYedWMCONqlvTZY9QVh7rtGEKs1t+nvSv42nScxLxoG2fViAH44tUxKV035nfcU=
X-Gm-Gg: ATEYQzxY/HAU0toKmnHIrxp80A3yiuU1EIVOkax5wqTHcVtL3o1vFRbOtxN9Wz92nP5
 6wIyLB5thKL/kEFvR/apIvvacQbXnPjho6lvEgf4Psko6oZK1n3FboJ2zSv+cbgvLS25JaVRGio
 cxIi+qYkb9kA6ZfwNf4mCwCBQThM6y7a5+Qr7yvJ+NT9iryHxk0yGSzfMA9zNpaXUnMWWs5uNMO
 TCRkOhFQGw91cvgD6Yhc+2haULyr8wLadwf7FvvIBz66HmdiwZiwGxnRmD57H3YfuFLC/tZyA3p
 a538ZgWP/jEoh/K2Wx9/I1VNrw8Faxlhy8YvvvAC/hDYvhr2cGHcjrBSE6/5ei9M500uKvxUSDr
 cNVidvwewUskX+ZVTNTGT5qDErqNwg/O4ZKGHhEcqxRGdwgyOf1IIJegqC7qQ1xVvN5przI8x8X
 35S+5IMBuMr9gLn+2YUlPBn70Q8zUefSwB7LnDYOV7enBY4TmWOMKKxeWeZzzi0lK7CBbo+2Kzl
 /FwjEjQYrZ11g0oiqCMsQ5tgcRQyjo=
X-Received: by 2002:a05:600c:46c5:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48727ef0bcemr34056815e9.10.1774610245870; 
 Fri, 27 Mar 2026 04:17:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 25/65] hw/intc/arm_gicv5: Implement gicv5_request_config()
Date: Fri, 27 Mar 2026 11:16:20 +0000
Message-ID: <20260327111700.795099-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the gicv5_request_config() function, which corresponds to
the RequestConfig command and its RequestConfigAck reply.

We provide read_l2_iste() as a separate function to keep the "access
the in-guest-memory data structure" layer separate from the "operate
on the L2_ISTE values" layer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 102 +++++++++++++++++++++++++++++
 hw/intc/trace-events               |   1 +
 include/hw/intc/arm_gicv5_stream.h |  24 +++++++
 3 files changed, 127 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 9ca1826253..04d4391ae5 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -297,6 +297,19 @@ FIELD(L2_ISTE, HWU, 9, 2)
 FIELD(L2_ISTE, PRIORITY, 11, 5)
 FIELD(L2_ISTE, IAFFID, 16, 16)
 
+/*
+ * Format used for gicv5_request_config() return value, which matches
+ * the ICC_ICSR_EL1 bit layout.
+ */
+FIELD(ICSR, F, 0, 1)
+FIELD(ICSR, ENABLED, 1, 1)
+FIELD(ICSR, PENDING, 2, 1)
+FIELD(ICSR, IRM, 3, 1)
+FIELD(ICSR, ACTIVE, 4, 1)
+FIELD(ICSR, HM, 5, 1)
+FIELD(ICSR, PRIORITY, 11, 5)
+FIELD(ICSR, IAFFID, 32, 16)
+
 static MemTxAttrs irs_txattrs(GICv5Common *cs, GICv5Domain domain)
 {
     /*
@@ -713,6 +726,95 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
     }
 }
 
+static uint64_t l2_iste_to_icsr(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                                uint32_t id)
+{
+    uint64_t icsr = 0;
+    const uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
+
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return R_ICSR_F_MASK;
+    }
+
+    /*
+     * The field locations in the L2 ISTE do not line up with the
+     * corresponding fields in the ICC_ICSR_EL1 register, so we need
+     * to extract and deposit them individually.
+     */
+    icsr = FIELD_DP64(icsr, ICSR, F, 0);
+    icsr = FIELD_DP64(icsr, ICSR, ENABLED, FIELD_EX32(*l2_iste_p, L2_ISTE, ENABLE));
+    icsr = FIELD_DP64(icsr, ICSR, PENDING, FIELD_EX32(*l2_iste_p, L2_ISTE, PENDING));
+    icsr = FIELD_DP64(icsr, ICSR, IRM, FIELD_EX32(*l2_iste_p, L2_ISTE, IRM));
+    icsr = FIELD_DP64(icsr, ICSR, ACTIVE, FIELD_EX32(*l2_iste_p, L2_ISTE, ACTIVE));
+    icsr = FIELD_DP64(icsr, ICSR, HM, FIELD_EX32(*l2_iste_p, L2_ISTE, HM));
+    icsr = FIELD_DP64(icsr, ICSR, PRIORITY, FIELD_EX32(*l2_iste_p, L2_ISTE, PRIORITY));
+    icsr = FIELD_DP64(icsr, ICSR, IAFFID, FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID));
+
+    return icsr;
+}
+
+static uint64_t spi_state_to_icsr(GICv5SPIState *spi)
+{
+    uint64_t icsr = 0;
+
+    icsr = FIELD_DP64(icsr, ICSR, F, 0);
+    icsr = FIELD_DP64(icsr, ICSR, ENABLED, spi->enabled);
+    icsr = FIELD_DP64(icsr, ICSR, PENDING, spi->pending);
+    icsr = FIELD_DP64(icsr, ICSR, IRM, spi->irm);
+    icsr = FIELD_DP64(icsr, ICSR, ACTIVE, spi->active);
+    icsr = FIELD_DP64(icsr, ICSR, HM, spi->hm);
+    icsr = FIELD_DP64(icsr, ICSR, PRIORITY, spi->priority);
+    icsr = FIELD_DP64(icsr, ICSR, IAFFID, spi->iaffid);
+
+    return icsr;
+}
+
+uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                              GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+    uint64_t icsr;
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
+                      "read config of a virtual interrupt\n");
+        return R_ICSR_F_MASK;
+    }
+
+    switch (type) {
+    case GICV5_LPI:
+    {
+        const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+
+        icsr = l2_iste_to_icsr(cs, cfg, id);
+        trace_gicv5_request_config(domain_name[domain], inttype_name(type),
+                                   virtual, id, icsr);
+        return icsr;
+    }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
+                          "read config of unreachable SPI %d\n", id);
+            return R_ICSR_F_MASK;
+        }
+
+        icsr = spi_state_to_icsr(spi);
+        trace_gicv5_request_config(domain_name[domain], inttype_name(type),
+                                   virtual, id, icsr);
+        return icsr;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
+                      "read config of bad interrupt type %d\n", type);
+        return R_ICSR_F_MASK;
+    }
+}
+
 static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 37ca6e8e12..409935e15a 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -240,6 +240,7 @@ gicv5_set_enabled(const char *domain, const char *type, bool virtual, uint32_t i
 gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t id, bool pending) "GICv5 IRS SetPending %s %s virtual:%d ID %u pending %d"
 gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
+gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index af2e1851c2..670423fdad 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -126,4 +126,28 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
 void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
                       GICv5RoutingMode irm, GICv5Domain domain,
                       GICv5IntType type, bool virtual);
+
+/**
+ * gicv5_request_config
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @domain: interrupt domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Query the current configuration of an interrupt; matches stream
+ * interface RequestConfig command from CPUIF to IRS and the
+ * RequestConfigAck reply to it.
+ *
+ * In the real stream protocol, the RequestConfigAck packet has the
+ * same information as the register but in a different order; we use
+ * the register order, not the packet order, so we don't need to
+ * unpack and repack in the cpuif.
+ *
+ * Returns: the config of the interrupt, in the format used by
+ * ICC_ICSR_EL1.
+ */
+uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                              GICv5IntType type, bool virtual);
+
 #endif
-- 
2.43.0


