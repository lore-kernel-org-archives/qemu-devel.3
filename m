Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704C8EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZM5-0004ME-Un; Mon, 23 Feb 2026 12:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL5-0002l6-2s
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKz-0000Nw-2Z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:15 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso52101915e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866190; x=1772470990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=61PvnFSHrTc5AGGW4jO3OHip56G19MgkDyLY5pjuMnQ=;
 b=jjtGQOjPufAbM4bdmGwbUKIa8VuxXenOEacOerySz7EH2cnmyRg6HekyDf7gVET9yV
 opQCPGNwYxC5kJYewChKbXr4rjjqENHjJWfTi3L3w4S2JjOHpRjMhg+3klj1RswhDAOW
 aPGiU06c2Z/U5ABbaQjSeHTVLQ9xDwM4tdakWe7aTCLAufQ5X+pELflOJiFpYfefNcwz
 +WXAk/sZfnD1sSMzZSJKslC418HsK9ztgjP9mAR2Ayz2PITfPs+yE2TjV/H5/tl7FnK3
 Q+Kfk9NGeHtrJnWsf+TavSCxVx762EGE/uUEs0by5HSyx/dofswPfuyt77Uo/ngGUTsL
 z2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866190; x=1772470990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=61PvnFSHrTc5AGGW4jO3OHip56G19MgkDyLY5pjuMnQ=;
 b=J2sx4YDw7Di483zbMoI4uyFNmvB6HmgfXUKiXN95Vi2zWgdCNOWrsUxM+LAm2NqYL3
 rhfN6UECtz7D6hqRFlUCLj59HIvKTE2pVRJ/q2MHKoym+FQGrOUnh41EG3Y0FJ6C5tho
 /O7UM8I4WyObX2X9SoV+WbRlTEprYlNZFKT/fn7WPk7rCQJ428oKGiKslzauz9XbDFao
 N2YdD6nVGe9WrkIkouO9ghEfL3oGWNs7n5mqfnpl7rky6LZ9rhbd1k3KGuvZkJFbCUpb
 6UKKBUGtu3mMPO9OTeJuMlnkjVVKrKW7cmrQZFH9O+Hnjzc0lI8y/auH0BREmbYZLui/
 vQsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYS1x3vw42q1bZw/xfR6XV3nhfcuOIpzpUQ7r3gQNLru2mOjLXXxU/x7++n/kDD+T1uck0renSRVU@nongnu.org
X-Gm-Message-State: AOJu0YzLuLKyKE+X8ymK8JRfMQ4Y15mQSJzg1KUStnCAJ10JidYyIT4P
 Vo6LWgisk0mi5iYWI6k/XFF6S/6nfsjZY7+/+g8z3awBoi47Nf0CEaZRurHF1aBVORSEmH1m28n
 j3KNq
X-Gm-Gg: AZuq6aLcX+OGXeZOnSidOFCd6EmxAlBvXo0YvfsFUyIvyTG2SePTM+aof55PsLbpiIw
 dFvTJlClwtJwcRZ5gUa6OpkRNI0w198v5Q8xrKF3+aHinjwc/1lCmegngeWMpUao10V/wzpE6bI
 YQ5csjj9XwEIiepwEmxFwae3bU79mleWYYYeZHTle4RMjFcxPXylFWs6N7kYWCDx8G8SnK+xL6J
 LpYLQf1ust6KOYw53keOR8K00PiwsS2milYAkYcXFcI2DhP6PjagfFIWe1TWf9WrSHiRaURF7PL
 30phplnuMExcVnl9u4BSdbaL+cQJjLyljmN8V91Mx7g5k8m+q7ZBWoqIJs8TOHIp6aTVoqqw88Z
 z8SXNePmx/PweJb4DJ8sYuE7FTmdzwpEH5ipKyTAVDVK7myV066g5E+XGjGO1Gnbx/85AnFE7mF
 WsoIE/51426+7+nILe8UGjwQ/jTvQllLn0flpg+oRZpjgVo2orPTqDgSoL0BC9jDbm+4ypBq0hA
 Yw+8yUUsYmkgTBG5L4wK/oSSGZSFas=
X-Received: by 2002:a05:600c:8b63:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-483a9637833mr144580555e9.29.1771866189893; 
 Mon, 23 Feb 2026 09:03:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 49/65] hw/intc/arm_gicv5: Implement Deactivate command
Date: Mon, 23 Feb 2026 17:01:56 +0000
Message-ID: <20260223170212.441276-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Implement the equivalent of the GICv5 stream protocol's Deactivate
command, which lets the cpuif tell the IRS to deactivate the
specified interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 46 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_stream.h | 14 +++++++++
 3 files changed, 61 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 6636a66976..0509a958ff 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1113,6 +1113,52 @@ void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     irs_recalc_hppi(s, domain, iaffid);
 }
 
+void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                      GICv5IntType type, bool virtual)
+{
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
+    uint32_t iaffid;
+
+    trace_gicv5_deactivate(domain_name[domain], inttype_name(type), virtual, id);
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
+                      "deactivate a virtual interrupt\n");
+        return;
+    }
+    if (type == GICV5_SPI) {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
+                          "deactivate unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->active = false;
+        irs_recalc_hppi(s, domain, spi->iaffid);
+        return;
+    }
+    if (type != GICV5_LPI) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
+                      "deactivate bad interrupt type %d\n", type);
+        return;
+    }
+    cfg = &s->phys_lpi_config[domain];
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return;
+    }
+    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ACTIVE, false);
+    iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
+    put_l2_iste(cs, cfg, &h);
+
+    irs_recalc_hppi(s, domain, iaffid);
+}
+
 static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 636c598970..c6696f0e0a 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -242,6 +242,7 @@ gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
 gicv5_activate(const char *domain, const char *type, bool virtual, uint32_t id) "GICv5 IRS Activate %s %s virtual:%d ID %u"
+gicv5_deactivate(const char *domain, const char *type, bool virtual, uint32_t id) "GICv5 IRS Deactivate %s %s virtual:%d ID %u"
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 7adb53c86d..f6783cc6b5 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -212,4 +212,18 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
                                uint32_t iaffid);
 
+/**
+ * gicv5_deactivate
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Deactivate the specified interrupt. There is no report back
+ * of success/failure to the CPUIF in the protocol.
+ */
+void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                      GICv5IntType type, bool virtual);
+
 #endif
-- 
2.43.0


