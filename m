Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBCDEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKZ-0002CQ-Ro; Mon, 23 Feb 2026 12:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKY-00027Q-9y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKV-0000Bu-RM
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so36480915e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866162; x=1772470962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cuGfpXqHYLjAz/e03DHfMF0KD4B4dSvsbR1oBLz0niE=;
 b=daXtnGVe/jTmdaKKipNh1JLTEZw7KdnqU/LFWsdz09Luf2qr4UX1fjtZ4BfxqofO2v
 DMy2TEHKRXmBNmDuKGM/7VQXRiaAYOIu4JIGb9BkT76PaiEq5CrVdr5qRFKIrnKdxTgF
 OsBS1LK2oM56HarAxE88Z+8WvWALwiRvEWxTkLKVWhJNI2VS806QSBX3eY1v+ttc/2EM
 q83bikdksbMH/3Nj3ii+wO6FyNXMGuccfkvPJrVyZd32zDei8rpk+9f1Jkl0XZHhPjcz
 JVil6eEquLxzPVOMK7+9aNkfuPEFVhYKYrhlIb5fdG/JSUl565ygqOAPWTZIFX0UTWtd
 CMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866162; x=1772470962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cuGfpXqHYLjAz/e03DHfMF0KD4B4dSvsbR1oBLz0niE=;
 b=pLCxHCPg+jNUoPmVtF+spZhC7iqkDcFv4LwLxYa9O/GexRJ4/bIHzA8ssEevn++JYf
 8zme0WdgIvvy3fx70EjCuX1qcfu4d+sTHpwA26RjBg2BjO4EGyNGIEZVbRkvtvFFvZwh
 awVlFxpSpk7RaTwWa0dnNx3uD6RhNu+2tHEHV1Nqjmk+fXSUdWqcTLE25HapWQ/srpZx
 6/+SkoZu2qdTTEfUFcz9znhsvHzzEBLnEp8eSR1Uu9xT+0CUy9BvlfOW9VZI7kz91tTW
 HNoa98El2sFeVEKQ6REM5uFkkfSnpveWmfH0h0yTDYRiSyniQUXDAJpsLiCmKwuVI8te
 fOXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU50FJPJ1+As6nIAtUqIxj6v8V+Pb1xCOOvDbJPAgu0gIfbVAN5ABq8rSm1vUGKqXFmKSsQZ/Opn9/I@nongnu.org
X-Gm-Message-State: AOJu0YwLf22VIgllDxghxjhe3VQbqkO1rV7NnW0Hg3B4xClT7nBgAKST
 gu8CZDra5gMvfzLuoUlRNtIPwrmFcnvTnpp/tVz3VHdrbIAf2cjOgmp7/nfmWG3focDb0Ha4jv+
 BYQtV
X-Gm-Gg: AZuq6aLMmT+H2Ygw8eBJu5dLYhE0D5sajeLYOO+v5SNpaGnAPsUl3rNfeUxm1ZqLSAc
 x13C6fGcKacpOeHVOj+ZgLMTpeKkqDC2t1tKpZ6eFwxOSzEAIKbSLlbv5h1THBCimVDBCi1mJh8
 Pa3yzYaZ4ZmVnW+BaTQRxDSOEar6A8mmt9qAwBgKOWVR1rvOwocMpVWjjqg7pvVTT3uaeI11G80
 d3LnHrpDU9lgE9nmB1R5ZAnDHKjh2tzplolY6IQtzBBnFVUnbq9i+Mscz7dopo5a/opM/r4C0ro
 /JWmqv+/IfdI+wrOSNXflWPE73xUgxekQVd3lJRGZMH+hRlh68tkdp08oDvbG6l6j3hgnuPcv9H
 xVw5ESnujIxvtlzHOAZxeN8wCrl+I+SK9XlhEdvKfx3OsmIe6PlDs8qnYOEJfnMp2oPTJNLdqo5
 uqqMCafFp1PR8AOgiyiJOUZ0eDIjJxcsIYe3wgTgvvdwivZ/5rlrblB5kXcI+VI/oA+4je6m7pV
 6wFgshGWLFnRj//o9zCn4RGeMq1+V4=
X-Received: by 2002:a05:600c:1989:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-483a94c99admr175465385e9.9.1771866162121; 
 Mon, 23 Feb 2026 09:02:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 24/65] hw/intc/arm_gicv5: Implement gicv5_request_config()
Date: Mon, 23 Feb 2026 17:01:31 +0000
Message-ID: <20260223170212.441276-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
 hw/intc/arm_gicv5.c                | 92 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_stream.h | 24 ++++++++
 3 files changed, 117 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 4d99200122..51b25775c4 100644
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
@@ -684,6 +697,85 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
     put_l2_iste(cs, cfg, &h);
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
+     * corresponding fields in the ICC_ICSR_EL1 register, so we need to
+     * extract and deposit them individually.
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
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint64_t icsr;
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
+                      "read config of a virtual interrupt\n");
+        return R_ICSR_F_MASK;
+    }
+    if (type == GICV5_SPI) {
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
+    cfg = &s->phys_lpi_config[domain];
+
+    icsr = l2_iste_to_icsr(cs, cfg, id);
+    trace_gicv5_request_config(domain_name[domain], inttype_name(type),
+                               virtual, id, icsr);
+    return icsr;
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
index db0e3e01c6..1f00e8ffff 100644
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
+ * interface RequestConfig command from CPUIF to IRS and the RequestConfigAck
+ * reply to it.
+ *
+ * In the real stream protocol, the RequestConfigAck packet has the same
+ * information as the register but in a different order; we use the register
+ * order, not the packet order, so we don't need to unpack and repack in
+ * the cpuif.
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


