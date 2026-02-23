Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F9FEC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZLr-0003GB-P8; Mon, 23 Feb 2026 12:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKt-0002c6-Lr
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKp-0000L5-Tp
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:06 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48372efa020so36383155e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866182; x=1772470982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ql6fahb1YltIi8mgBYLkHjOatO6N+TZVhiuUzf/mLDc=;
 b=vlP3V6FUUmd3cqMQ4sudGhk8XsUACjJT7HjTRSijf25hVBKRbtOfHZemMk2aOvvjNQ
 hkGTpbzEe2C+80jAtOMPDsd1Xa5jv66/ry6v/h+F/1io3sH99VjmXZJU4FwPOU4hBXwU
 ECHusfZJHyH1XO/zPP8KMVg6XEecMSvJsZLOUr5btCOgWac8WCgTjmrKuBZg/kEF4p3U
 +NsXZm8tqJVrkEwuP5mrSjY3W7/xnOpUQMSIaTJW9Gnqn9DqP5gfapbHhEF5nuvL64Re
 c8GWDwgj+5j6u+j9qExGw7w/do/OysN+wBOP+wOwYl4A0IFfWR9CdTk2OyARMqhzwqSN
 AliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866182; x=1772470982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ql6fahb1YltIi8mgBYLkHjOatO6N+TZVhiuUzf/mLDc=;
 b=M+0aofhwyQCpjrcma3Gpxju+/xtimiOzceZP3N4LryXI0nbiYxU/W72UDkuhSUkjnZ
 klYIXz+P774clbW8Rgjm7H73iojZ7zQfff8vwdWV10dHASpsE5UTb6sUTi6XrB9YphmN
 jZoZRbi4yzObcA0+mH8OoekCR3cuvjq3bWR8oYy04MxOe/aupFhsB3HvzNXOqnsynexy
 i6d4MPvTrnqaTeJCaUroHHLIYaUxsVZCO9oNWrWeT8dt4SjhRryKLB+L/nVRX3tdsTzH
 0d5t1PSGv9saQde4verWAWWjXHoQdLPI1ZzGJpXfDTAcUJrVcoT+FLDBEAmZqQavuH3b
 9p8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Mu4YrllvCfRWPWdED08uPAkq4boUA3cU16SzPEKXfV2kq4WM3hGmN1fD15KJlcy5exHuRWticxbM@nongnu.org
X-Gm-Message-State: AOJu0YxshR090t6ltmMXO3wOC4B2FPP8hK8lk+L1kK2+WN4yHlxWaIkV
 Rvc5BuJ3xFKVPgNPxGTmVeygnrzbZXALDoeU1lhpGvq6z3b9nZ3bMYxcKaksJ0AM898=
X-Gm-Gg: AZuq6aIcAbFVoeFQ4za6bWeFT2KS5PF/fZOUwBpqF9ZUYDzMiGMLcp53IkUfDfsL58o
 v4pet7uoj239yAXWeZUXXnJlprq2reAbAFg1KiIKnNWMbTxhlsZ9u7B+bXsAfh3GTEFXH2LVSQS
 lUjKcXV3V346+xiwtftmGzjGTNWXK4VCf2xMhq5xllMyD/mpaN20M057OO5DzMmRGvn/9Ir0vC7
 U/RnstNR+NSXe7Vmz6mjGwVxiI5Qr6huyWakmJdVcYDxPtYIcF6nmwtekRhjGTwKMdPozxyqoOa
 kPY2Kadxrc2e8QoPZ9mx2dnZUnUyKFMHr2P+2Na3OvdJhJinCkAS9a+xI2f4OpHk9q5nhDJmhOC
 590rHGg+ihnuKEO2gt2UiBZBagBO1wHTzEHJ7W2wmte4cUC2gnjmn2AA1i7AbnKooMjQcpDCYxy
 bQLkTi46qFPU0yghjB+RoeWdrkRh5m6M5xphAvDpgbuVNqHknCWRP85x9BVqcoRMgBkPDhI5xK4
 Pq8Jm1juSTxb0QVtO232aO8pK3X9wA=
X-Received: by 2002:a05:600c:4f94:b0:47e:e20e:bbb0 with SMTP id
 5b1f17b1804b1-483a95eb33cmr150706765e9.6.1771866182179; 
 Mon, 23 Feb 2026 09:03:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 42/65] hw/intc/arm_gicv5: Calculate HPPI in the IRS
Date: Mon, 23 Feb 2026 17:01:49 +0000
Message-ID: <20260223170212.441276-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The IRS is required to present the highest priority pending interrupt
that it has for each domain for each cpu interface.  We implement
this in the irs_recalc_hppi() function, which we call at every point
where some relevant IRS state changes.

This function calls gicv5_forward_interrupt() to do the equivalent of
the GICv5 stream protocol Forward and Recall commands.  For the
moment we simply record the HPPI on the CPU interface side without
trying to process it; the handling of the HPPI in the cpuif will be
added in subsequent commits.

There are some cases where we could skip doing the full HPPI
recalculation, e.g.  when the guest changes the config of an
interrupt that is disabled; we expect that the guest will only do
interrupt config at startup, so we don't attempt to optimise this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 202 +++++++++++++++++++++++++++++
 hw/intc/trace-events               |   2 +
 include/hw/intc/arm_gicv5.h        |   3 +
 include/hw/intc/arm_gicv5_stream.h |  24 ++++
 target/arm/tcg/gicv5-cpuif.c       |   9 ++
 5 files changed, 240 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 30368998d3..070d414d67 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -376,6 +376,157 @@ static MemTxAttrs irs_txattrs(GICv5Common *cs, GICv5Domain domain)
     };
 }
 
+/* Data we need to pass through to lpi_cache_get_hppi() */
+typedef struct GetHPPIUserData {
+    GICv5PendingIrq *best;
+    uint32_t iaffid;
+} GetHPPIUserData;
+
+static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
+{
+    uint64_t id = GPOINTER_TO_INT(key);
+    uint64_t l2_iste = *(uint64_t *)value;
+    uint32_t prio, iaffid;
+    GetHPPIUserData *ud = user_data;
+
+    if ((l2_iste & (R_L2_ISTE_PENDING_MASK | R_L2_ISTE_ACTIVE_MASK | R_L2_ISTE_ENABLE_MASK))
+        != (R_L2_ISTE_PENDING_MASK | R_L2_ISTE_ENABLE_MASK)) {
+        return;
+    }
+    prio = FIELD_EX32(l2_iste, L2_ISTE, PRIORITY);
+    iaffid = FIELD_EX32(l2_iste, L2_ISTE, IAFFID);
+    if (iaffid == ud->iaffid && prio < ud->best->prio) {
+        id = FIELD_DP32(id, INTID, TYPE, GICV5_LPI);
+        ud->best->intid = id;
+        ud->best->prio = prio;
+    }
+}
+
+static int irs_cpuidx_from_iaffid(GICv5Common *cs, uint32_t iaffid)
+{
+    for (int i = 0; i < cs->num_cpus; i++) {
+        if (cs->cpu_iaffids[i] == iaffid) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static void irs_recalc_hppi(GICv5 *s, GICv5Domain domain, uint32_t iaffid)
+{
+    /*
+     * Recalculate the highest priority pending interrupt for the
+     * specified domain and cpuif.
+     * HPPI candidates must be pending, inactive and enabled.
+     */
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    int cpuidx = irs_cpuidx_from_iaffid(cs, iaffid);
+    ARMCPU *cpu = cpuidx >= 0 ? cs->cpus[cpuidx] : NULL;
+    GICv5PendingIrq best;
+
+    best.intid = 0;
+    best.prio = PRIO_IDLE;
+
+    if (!cpu) {
+        /* Nothing happens for iaffids targeting nonexistent CPUs */
+        trace_gicv5_irs_recalc_hppi_fail(domain_name[domain], iaffid,
+                                         "IAFFID doesn't match any CPU");
+        return;
+    }
+
+    if (!FIELD_EX32(cs->irs_cr0[domain], IRS_CR0, IRSEN)) {
+        /* When the IRS is disabled we don't forward HPPIs */
+        trace_gicv5_irs_recalc_hppi_fail(domain_name[domain], iaffid,
+                                         "IRS_CR0.IRSEN is zero");
+        return;
+    }
+
+    if (s->phys_lpi_config[domain].valid) {
+        GetHPPIUserData ud;
+
+        ud.best = &best;
+        ud.iaffid = iaffid;
+        g_hash_table_foreach(s->phys_lpi_config[domain].lpi_cache,
+                             lpi_cache_get_hppi, &ud);
+    }
+
+    /*
+     * OPT: consider also caching the SPI interrupt information,
+     * similarly to how we handle LPIs, if iterating through the
+     * whole SPI array every time is too expensive.
+     */
+    for (int i = 0; i < cs->spi_irs_range; i++) {
+        GICv5SPIState *spi = &cs->spi[i];
+
+        if (spi->active || !spi->pending || !spi->enabled) {
+            continue;
+        }
+        if (spi->domain != domain || spi->iaffid != iaffid) {
+            continue;
+        }
+        if (spi->priority < best.prio) {
+            uint32_t intid = 0;
+            intid = FIELD_DP32(intid, INTID, ID, i);
+            intid = FIELD_DP32(intid, INTID, TYPE, GICV5_SPI);
+            best.intid = intid;
+            best.prio = spi->priority;
+        }
+    }
+
+    trace_gicv5_irs_recalc_hppi(domain_name[domain], iaffid,
+                                best.intid, best.prio);
+
+    s->hppi[domain][cpuidx] = best;
+    /*
+     * Now present the HPPI to the cpuif. In the real hardware
+     * stream protocol, the connection between IRS and cpuif is
+     * asynchronous, and so both ends track their idea of the
+     * current HPPI, with a back-and-forth sequence so they stay
+     * in sync and more interaction when the cpuif resets.
+     * For QEMU, we are strictly synchronous and the cpuif asking
+     * the IRS for data is a cheap function call, so we simplify this:
+     *  - the IRS knows what the current HPPI is
+     *  - s->hppi[][] is a cache we can recalculate
+     *  - the IRS merely tells the cpuif "something changed", and
+     *    the cpuif asks for the current HPPI when it needs it
+     *  - the cpuif does not cache the HPPI on its end
+     */
+    gicv5_forward_interrupt(cpu, domain);
+}
+
+static void irs_recalc_hppi_all_cpus(GICv5 *s, GICv5Domain domain)
+{
+    /*
+     * Recalculate the HPPI for every CPU for this domain.
+     * This is not as efficient as it could be because we will
+     * scan through the LPI cached hash table and the SPI array
+     * for each CPU rather than doing a single combined scan,
+     * but we only need to do this very rarely, when the guest
+     * enables or disables the IST, so we implement this the simple way.
+     */
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    for (int i = 0; i < cs->num_cpus; i++) {
+        irs_recalc_hppi(s, domain, cs->cpu_iaffids[i]);
+    }
+}
+
+static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
+{
+    /*
+     * The IRS was just disabled -- we must recall any pending
+     * HPPIs we have sent to the CPU interfaces. For us this means
+     * that we clear our cached HPPI data and tell the cpuif
+     * that it has changed.
+     */
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    for (int i = 0; i < cs->num_cpus; i++) {
+        s->hppi[domain][i].intid = 0;
+        s->hppi[domain][i].prio = PRIO_IDLE;
+        gicv5_forward_interrupt(cs->cpus[i], domain);
+    }
+}
+
 static hwaddr l1_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
                            uint32_t id)
 {
@@ -582,6 +733,7 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
     GICv5 *s = ARM_GICV5(cs);
     uint32_t *l2_iste_p;
     L2_ISTE_Handle h;
+    uint32_t iaffid;
 
     trace_gicv5_set_priority(domain_name[domain], inttype_name(type), virtual,
                              id, priority);
@@ -603,6 +755,7 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
         }
 
         spi->priority = priority;
+        irs_recalc_hppi(s, domain, spi->iaffid);
         return;
     }
     if (type != GICV5_LPI) {
@@ -616,7 +769,10 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
         return;
     }
     *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PRIORITY, priority);
+    iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
     put_l2_iste(cs, cfg, &h);
+
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
@@ -627,6 +783,7 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
     GICv5 *s = ARM_GICV5(cs);
     uint32_t *l2_iste_p;
     L2_ISTE_Handle h;
+    uint32_t iaffid;
 
     trace_gicv5_set_enabled(domain_name[domain], inttype_name(type), virtual,
                             id, enabled);
@@ -645,6 +802,7 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
         }
 
         spi->enabled = true;
+        irs_recalc_hppi(s, domain, spi->iaffid);
         return;
     }
     if (type != GICV5_LPI) {
@@ -658,7 +816,9 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
         return;
     }
     *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ENABLE, enabled);
+    iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
     put_l2_iste(cs, cfg, &h);
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 void gicv5_set_pending(GICv5Common *cs, uint32_t id,
@@ -669,6 +829,7 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id,
     GICv5 *s = ARM_GICV5(cs);
     uint32_t *l2_iste_p;
     L2_ISTE_Handle h;
+    uint32_t iaffid;
 
     trace_gicv5_set_pending(domain_name[domain], inttype_name(type), virtual,
                             id, pending);
@@ -687,6 +848,7 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id,
         }
 
         spi->pending = true;
+        irs_recalc_hppi(s, domain, spi->iaffid);
         return;
     }
     if (type != GICV5_LPI) {
@@ -700,7 +862,9 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id,
         return;
     }
     *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, pending);
+    iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
     put_l2_iste(cs, cfg, &h);
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 void gicv5_set_handling(GICv5Common *cs, uint32_t id,
@@ -752,6 +916,7 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
     GICv5 *s = ARM_GICV5(cs);
     uint32_t *l2_iste_p;
     L2_ISTE_Handle h;
+    uint32_t old_iaffid;
 
     trace_gicv5_set_target(domain_name[domain], inttype_name(type), virtual,
                            id, iaffid, irm);
@@ -778,7 +943,10 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
             return;
         }
 
+        old_iaffid = spi->iaffid;
         spi->iaffid = iaffid;
+        irs_recalc_hppi(s, domain, old_iaffid);
+        irs_recalc_hppi(s, domain, iaffid);
         return;
     }
     if (type != GICV5_LPI) {
@@ -795,8 +963,12 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
      * For QEMU we do not implement 1-of-N routing, and so L2_ISTE.IRM is RES0.
      * We never read it, and we can skip explicitly writing it to zero here.
      */
+    old_iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
     *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, IAFFID, iaffid);
     put_l2_iste(cs, cfg, &h);
+
+    irs_recalc_hppi(s, domain, old_iaffid);
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 static uint64_t l2_iste_to_icsr(GICv5Common *cs, const GICv5ISTConfig *cfg,
@@ -907,6 +1079,12 @@ static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     if (res != MEMTX_OK) {
         goto txfail;
     }
+    /*
+     * It's CONSTRAINED UNPREDICTABLE to make an L2 IST valid
+     * when some of its entries have Pending already set, so we don't
+     * need to go through looking for Pending bits and pulling them
+     * into the cache, and we don't need to recalc our HPPI.
+     */
     return;
 
 txfail:
@@ -964,6 +1142,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
                                                IRS_IST_BASER, VALID, valid);
         s->phys_lpi_config[domain].valid = false;
         trace_gicv5_ist_invalid(domain_name[domain]);
+        irs_recalc_hppi_all_cpus(s, domain);
         return;
     }
     cs->irs_ist_baser[domain] = value;
@@ -1033,6 +1212,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         cfg->valid = true;
         trace_gicv5_ist_valid(domain_name[domain], cfg->base, cfg->id_bits,
                               cfg->l2_idx_bits, cfg->istsz, cfg->structure);
+        irs_recalc_hppi_all_cpus(s, domain);
     }
 }
 
@@ -1186,6 +1366,11 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR0:
         /* Enabling is instantaneous for us so IDLE is always 1 */
         *data = cs->irs_cr0[domain] | R_IRS_CR0_IDLE_MASK;
+        if (FIELD_EX32(cs->irs_cr0[domain], IRS_CR0, IRSEN)) {
+            irs_recalc_hppi_all_cpus(s, domain);
+        } else {
+            irs_recall_hppis(s, domain);
+        }
         return true;
     case A_IRS_CR1:
         *data = cs->irs_cr1[domain];
@@ -1274,6 +1459,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                 } else if (spi->level) {
                     spi->pending = false;
                 }
+                irs_recalc_hppi(s, spi->domain, spi->iaffid);
             }
         }
         return true;
@@ -1283,7 +1469,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
             /* this is RAZ/WI except for the EL3 domain */
             GICv5SPIState *spi = spi_for_selr(cs, domain);
             if (spi) {
+                GICv5Domain old_domain = spi->domain;
                 spi->domain = FIELD_EX32(data, IRS_SPI_DOMAINR, DOMAIN);
+                if (spi->domain != old_domain) {
+                    irs_recalc_hppi(s, old_domain, spi->iaffid);
+                    irs_recalc_hppi(s, spi->domain, spi->iaffid);
+                }
             }
         }
         return true;
@@ -1294,6 +1485,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
 
         if (spi) {
             spi_sample(spi);
+            irs_recalc_hppi(s, spi->domain, spi->iaffid);
         }
         trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
         return true;
@@ -1480,6 +1672,7 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
 {
     /* These irqs are all SPIs; the INTID is irq + s->spi_base */
     GICv5Common *cs = ARM_GICV5_COMMON(opaque);
+    GICv5 *s = ARM_GICV5(cs);
     uint32_t spi_id = irq + cs->spi_base;
     GICv5SPIState *spi = gicv5_raw_spi_state(cs, spi_id);
 
@@ -1492,6 +1685,8 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
     spi->level = level;
     spi_sample(spi);
     trace_gicv5_spi_state(spi_id, spi->level, spi->pending, spi->active);
+
+    irs_recalc_hppi(s, spi->domain, spi->iaffid);
 }
 
 static void gicv5_reset_hold(Object *obj, ResetType type)
@@ -1573,6 +1768,7 @@ static void gicv5_set_idregs(GICv5Common *cs)
 
 static void gicv5_realize(DeviceState *dev, Error **errp)
 {
+    GICv5 *s = ARM_GICV5(dev);
     GICv5Common *cs = ARM_GICV5_COMMON(dev);
     GICv5Class *gc = ARM_GICV5_GET_CLASS(dev);
     Error *migration_blocker = NULL;
@@ -1600,6 +1796,12 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
 
     gicv5_set_idregs(cs);
     gicv5_common_init_irqs_and_mmio(cs, gicv5_set_spi, config_frame_ops);
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        if (gicv5_domain_implemented(cs, i)) {
+            s->hppi[i] = g_new0(GICv5PendingIrq, cs->num_cpus);
+        }
+    }
 }
 
 static void gicv5_init(Object *obj)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 4c55af2780..6475ba5959 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -242,6 +242,8 @@ gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
+gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
+gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index fb13de0d01..b8baf003ad 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -37,6 +37,9 @@ struct GICv5 {
 
     /* This is the info from IRS_IST_BASER and IRS_IST_CFGR */
     GICv5ISTConfig phys_lpi_config[NUM_GICV5_DOMAINS];
+
+    /* We cache the HPPI for each CPU for each domain here */
+    GICv5PendingIrq *hppi[NUM_GICV5_DOMAINS];
 };
 
 struct GICv5Class {
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 7b5477c7f1..13b343504d 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -151,4 +151,28 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
 uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
                               GICv5IntType type, bool virtual);
 
+/**
+ * gicv5_forward_interrupt
+ * @cpu: CPU interface to forward interrupt to
+ * @domain: domain this interrupt is for
+ *
+ * Tell the CPU interface that the highest priority pending interrupt
+ * that the IRS has available for it has changed.
+ * This is the equivalent of the stream protocol's Forward packet,
+ * and also of its Recall packet.
+ *
+ * The stream protocol makes this asynchronous, allowing two
+ * Forward packets to be in flight and requiring an acknowledge,
+ * because the cpuif might be about to activate the previous
+ * forwarded interrupt while we are trying to tell it about a new
+ * one. But for QEMU we hold the BQL, so we know the vcpu might be
+ * executing guest code but it cannot be in the middle of changing
+ * cpuif state. So we can just synchronously tell it that a new
+ * HPPI exists (which might cause it to assert IRQ or FIQ to itself);
+ * this works as if the cpuif gave us a Release for the old HPPI.
+ * The cpuif will ask the IRS for the HPPI info via a function
+ * call, so we do not need to pass it across here.
+ */
+void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
+
 #endif
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 48cf14b4d0..2f6827dc13 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -157,6 +157,15 @@ static void gic_recalc_ppi_hppi(CPUARMState *env)
     }
 }
 
+void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain)
+{
+    /*
+     * For now, we do nothing. Later we will recalculate the overall
+     * HPPI by combining the IRS HPPI with the PPI HPPI, and possibly
+     * signal IRQ/FIQ.
+     */
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-- 
2.43.0


