Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13188CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11X-0003oA-CY; Thu, 07 May 2026 11:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11V-0003gs-5Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11T-0003t2-6Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0046078so8994265e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169142; x=1778773942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XWvtC2A1U9sZwo3Oui0OOqt++IM3K1g6IS43RbM676I=;
 b=vpvNX45G9rBdR6sUJdeww0fqEnvlzq8Hh6i7qYhyGcYdc83gZdXdPguNelwC8NHMy6
 RdivmgUG/hxxh+xHDT+aQzlC7JIFCxzkUiRpFk7nlcuAcHOkd87SD9gehA2cDPCfW5Cp
 JUmQYSnlbg9TEkUIckqxKJi8kvIElZxOdVKcoV6HkgzXABTQSB3THeje7ntcA0arGWil
 DEr0PoEFqHqTvrMfQSDVGec6v1niBE5U/toQwcDRppAiDCZU455PfouT72/2nrNdKcJc
 Nvq4ZjIg/NfS+gf77E7gPkiEUx1fbRn+fXisjpxbq4RAikx6aS83RVzNWemjYaWIT14r
 sTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169142; x=1778773942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XWvtC2A1U9sZwo3Oui0OOqt++IM3K1g6IS43RbM676I=;
 b=mrjbcoIMXleo1oaAygqJdxgtoBTqBDxTM5QO1ukPplNm68Toxujh8WR0zvjEMaHm7G
 mV2TZa5enmj/zBWCTp0AMJ/8i7j0pJhhlY0lDSDNxGSVZaZa1VYAnS3Tw8mqjF4GztTC
 jHAdEBgaNhteQWyGuJEyKfwrSMuP6GHexObArsVBygf8+ZdgipKivwMSMdi0n2aPH5VJ
 PqlBU3N/FHTT6XFoLsYoMK4K5OAvXE4JFgjsms81Whlw4kotZN50VfHFfolZ3GI3ZWET
 AD3cdYCfEQgAYdKL4cZMLpZXRLJoj9ZZ47R5awBz77/90ELsj2UHr2RLf7OV2/2RjId0
 V8hA==
X-Gm-Message-State: AOJu0YwvyndELoek3TF4N3DjfjbOu6yoQgS8UC3pHjEU8x9zL8O9s0n9
 Y3HAb076bSj5REuLyhIf1F0sFrWIXlYAL+yYYao3JmhnfSqwgGZtl5mpOvWrkcYrt4lXw2sLatT
 FVjAp
X-Gm-Gg: AeBDiesJJXf21Y5pv5g9waJCHICA9+OJcRkvR8B1s6LS58WuhvsaG/dKE6A0pWQWVIm
 iwCpUv77ZhUFPV24aJW2UnG06D9qhcSQoZuZgWwNsLO+87DuIBhbbsh/2yRo9HEt5vRgt+UOIMC
 pX7J5OteUUu6FZHPExTFzzi2qd87N4/jHDN9XKda3XQX2oQG7V8NFnDRu8TqCEJS4PdQ1tVRmBF
 dgK2WiWB7jaf7t2Tp0XDIJapOCHYWOPnOxGPk7LVadImUBmOsUlGqUh/2QqOFHit2CuZmDp24I1
 bR5hJBe/JWoxZ1UlPgX2QeN/jgqrcuMu6KbjK86Cf+ySXFZQKxr5rAzLQKH4mVvrdFcT3DeBVk8
 22nqX8/bGKxzMaz2sSftv6gRof+uO/hJ1yamVahvd/yz+l1UBYRHQ6xAcE622kEhq1AzdXzY6fu
 2lWJFnn7qg4yPtlOOWvwRHfj2RuuzQ9BettyTFtrvd79fAO1YzZlvZLU2+2tz34hdw8mYV/hdkt
 fQKzVHVhXmQmLNFDYNv2gJBg1S1U1P0E2NvAA5Mig==
X-Received: by 2002:a05:600d:8451:b0:487:219e:42d with SMTP id
 5b1f17b1804b1-48e53f33f08mr91178025e9.11.1778169141308; 
 Thu, 07 May 2026 08:52:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/67] hw/intc/arm_gicv5: Implement gicv5_request_config()
Date: Thu,  7 May 2026 16:51:12 +0100
Message-ID: <20260507155154.1886557-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Implement the gicv5_request_config() function, which corresponds to
the RequestConfig command and its RequestConfigAck reply.

We provide read_l2_iste() as a separate function to keep the "access
the in-guest-memory data structure" layer separate from the "operate
on the L2_ISTE values" layer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-26-peter.maydell@linaro.org
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


