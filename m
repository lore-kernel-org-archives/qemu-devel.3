Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB60CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11o-0004n1-PM; Thu, 07 May 2026 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11n-0004ZQ-0Y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11j-0003yE-DT
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b150559bso8032615e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169158; x=1778773958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xqC42QqeAJ1FUP4DDssazelQjVzwech+QR4/L/J9pFg=;
 b=Ef8nfe7TifnzC9UhH+MO/C/CCbYX4+mkpabK/DBeUSJXQnsgD5DhzEpFdRTe8elEsr
 E4GwKYFAYPnf4f7X5DIvpq2ro42YyYVOqZhzOuC3VGxUJcktE1ZfXFye1TqgAVAvD1g+
 5KOLke4LbQoYfNnD7rCXBJ7xpMxvNc0bhzHLzfO2/HCP9bA2n4cMfNauOBHyPi9EquUf
 Jq07zJuSKN+s1rf2oD/EiHYOv3DlBJhRrtpGwS47GetgOXqvV18qmpz+xjG7WahrhvRk
 LJm7pibs3/Emn7y6d0ekMYFI/lLG13BEgda1ZQr7vsj9Jiltr7uWV62od8B5CW3sSzi6
 TsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169158; x=1778773958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xqC42QqeAJ1FUP4DDssazelQjVzwech+QR4/L/J9pFg=;
 b=PUGtA+Hm0rZ5ZooEt+AIr37ZQ1SYB9AC9C1B6EVDy9hrpFdpd+INsVF+3R/pHlPVUt
 OraA3msY8ZfC/UoWs4TD07d919sPjmZEUlFYI0rnXkf8TlgvGohN3H8awP9hwyWHmpT/
 G3GjUhJb4Y3XZEx/CXs3mPOnObe5s95OMZZPL16FrybIY2l5RAASETebicv0bHUqbhFn
 fqCZ0PBzPUUtiQispCp1EBgba1ZKGL1XcPSsbHhLv2HPX0OiWGBBtWbk5VKWJBSbOvO8
 ERV5Hxx1ImCuuYZk9QVLM8ZsIrODGIKypCo+kdM0/039Tr6FVdFT3lzI5AsZQJfJSeK2
 AHXg==
X-Gm-Message-State: AOJu0Yzs/nQAgKlT/oMPYBmfCnoyCjripDfpsRUbPiBNfkHwuSHGD3yd
 swc8np/tcRqhFdjURHzbVONCXIEk5kcGFEsJKVKKquIzZoDRJTg9mWLtGrOiLeu171lcCB6QCNv
 fsgPs
X-Gm-Gg: AeBDietgkMLd1HxfJ72QBTZMb3OJIdKUSx8NBHMidDnLl8DJXiH1xsAUYCgxLDrnmXY
 wjAuqqR74C7deYAlPCipHGBbzeXRuZR2iGYAvyBPzPz9iZk8TpCC2aryjYYGDYl8gbs1sbAKkia
 RrinksljLaozSgYjqBJ+jHls3rDa+8PKEF7DHRQQjY8+ntlSijezJmjlUy2TVSIE3w/G2nP6I4s
 Wy2BwlB5YyNxSzJPOU8VU1X4FllLqIL9aq9pLFon3gLgVSun1Iqu3+4K4VZpjLiLhHdkX+TaXbW
 0BzNP4FLSeYDcoyvMJ8dNf9BzGG3S159rB2Lqye5wjvE5nqo0DwhH0PZe2eGo2imkTtSLzg9bIm
 yJPozXcN+YHAh/jmEuRIhvxrAFmDnjfhZIT2AoZmZgdF40p+k3244oxRrvHopnBuPheT94Nzeye
 r3sELBy0+CD4l2ke/Hq2x+ji0vUeM9b4EIGntQVWrvfatchDSXWAoLZxzA9qIIt0RRpV+zEYTxc
 iAlc438M6NUdwX3Lzj8k6AfleBt6sk=
X-Received: by 2002:a05:600c:3e8d:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48e51f40b12mr147894075e9.22.1778169157455; 
 Thu, 07 May 2026 08:52:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/67] hw/intc/arm_gicv5: Calculate HPPI in the IRS
Date: Thu,  7 May 2026 16:51:30 +0100
Message-ID: <20260507155154.1886557-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-44-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 202 +++++++++++++++++++++++++++++
 hw/intc/trace-events               |   2 +
 include/hw/intc/arm_gicv5.h        |   3 +
 include/hw/intc/arm_gicv5_stream.h |  24 ++++
 target/arm/tcg/gicv5-cpuif.c       |   9 ++
 5 files changed, 240 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 989492d4b6..12cbf9c51e 100644
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
+     * specified domain and cpuif.  HPPI candidates must be pending,
+     * inactive and enabled.
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
+     * similarly to how we handle LPIs, if iterating through the whole
+     * SPI array every time is too expensive.
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
+     * Now present the HPPI to the cpuif. In the real hardware stream
+     * protocol, the connection between IRS and cpuif is asynchronous,
+     * and so both ends track their idea of the current HPPI, with a
+     * back-and-forth sequence so they stay in sync and more
+     * interaction when the cpuif resets.  For QEMU, we are strictly
+     * synchronous and the cpuif asking the IRS for data is a cheap
+     * function call, so we simplify this:
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
+     * Recalculate the HPPI for every CPU for this domain.  This is
+     * not as efficient as it could be because we will scan through
+     * the LPI cached hash table and the SPI array for each CPU rather
+     * than doing a single combined scan, but we only need to do this
+     * very rarely, when the guest enables or disables the IST, so we
+     * implement this the simple way.
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
+     * The IRS was just disabled -- we must recall any pending HPPIs
+     * we have sent to the CPU interfaces. For us this means that we
+     * clear our cached HPPI data and tell the cpuif that it has
+     * changed.
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
@@ -575,6 +726,7 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual)
 {
     GICv5 *s = ARM_GICV5(cs);
+    uint32_t iaffid;
 
     trace_gicv5_set_priority(domain_name[domain], inttype_name(type), virtual,
                              id, priority);
@@ -598,6 +750,7 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
             return;
         }
         *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PRIORITY, priority);
+        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
         put_l2_iste(cs, cfg, &h);
         break;
     }
@@ -612,6 +765,7 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
         }
 
         spi->priority = priority;
+        iaffid = spi->iaffid;
         break;
     }
     default:
@@ -619,12 +773,15 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                       "priority of bad interrupt type %d\n", type);
         return;
     }
+
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
                        GICv5Domain domain, GICv5IntType type, bool virtual)
 {
     GICv5 *s = ARM_GICV5(cs);
+    uint32_t iaffid;
 
     trace_gicv5_set_enabled(domain_name[domain], inttype_name(type), virtual,
                             id, enabled);
@@ -645,6 +802,7 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
             return;
         }
         *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ENABLE, enabled);
+        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
         put_l2_iste(cs, cfg, &h);
         break;
     }
@@ -659,6 +817,7 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
         }
 
         spi->enabled = true;
+        iaffid = spi->iaffid;
         break;
     }
     default:
@@ -666,12 +825,15 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
                       "enable state of bad interrupt type %d\n", type);
         return;
     }
+
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
                        GICv5Domain domain, GICv5IntType type, bool virtual)
 {
     GICv5 *s = ARM_GICV5(cs);
+    uint32_t iaffid;
 
     trace_gicv5_set_pending(domain_name[domain], inttype_name(type), virtual,
                             id, pending);
@@ -692,6 +854,7 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
             return;
         }
         *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, pending);
+        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
         put_l2_iste(cs, cfg, &h);
         break;
     }
@@ -706,6 +869,7 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
         }
 
         spi->pending = true;
+        iaffid = spi->iaffid;
         break;
     }
     default:
@@ -713,6 +877,8 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
                       "pending state of bad interrupt type %d\n", type);
         return;
     }
+
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 void gicv5_set_handling(GICv5Common *cs, uint32_t id,
@@ -767,6 +933,7 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
                       GICv5IntType type, bool virtual)
 {
     GICv5 *s = ARM_GICV5(cs);
+    uint32_t old_iaffid;
 
     trace_gicv5_set_target(domain_name[domain], inttype_name(type), virtual,
                            id, iaffid, irm);
@@ -800,6 +967,7 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
          * L2_ISTE.IRM is RES0.  We never read it, and we can skip
          * explicitly writing it to zero here.
          */
+        old_iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
         *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, IAFFID, iaffid);
         put_l2_iste(cs, cfg, &h);
         break;
@@ -814,6 +982,7 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
             return;
         }
 
+        old_iaffid = spi->iaffid;
         spi->iaffid = iaffid;
         break;
     }
@@ -822,6 +991,9 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
                       "target of bad interrupt type %d\n", type);
         return;
     }
+
+    irs_recalc_hppi(s, domain, old_iaffid);
+    irs_recalc_hppi(s, domain, iaffid);
 }
 
 static uint64_t l2_iste_to_icsr(GICv5Common *cs, const GICv5ISTConfig *cfg,
@@ -942,6 +1114,12 @@ static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     if (res != MEMTX_OK) {
         goto txfail;
     }
+    /*
+     * It's CONSTRAINED UNPREDICTABLE to make an L2 IST valid when
+     * some of its entries have Pending already set, so we don't need
+     * to go through looking for Pending bits and pulling them into
+     * the cache, and we don't need to recalc our HPPI.
+     */
     return;
 
 txfail:
@@ -999,6 +1177,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
                                                IRS_IST_BASER, VALID, valid);
         s->phys_lpi_config[domain].valid = false;
         trace_gicv5_ist_invalid(domain_name[domain]);
+        irs_recalc_hppi_all_cpus(s, domain);
         return;
     }
     cs->irs_ist_baser[domain] = value;
@@ -1068,6 +1247,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         cfg->valid = true;
         trace_gicv5_ist_valid(domain_name[domain], cfg->base, cfg->id_bits,
                               cfg->l2_idx_bits, cfg->istsz, cfg->structure);
+        irs_recalc_hppi_all_cpus(s, domain);
     }
 }
 
@@ -1223,6 +1403,11 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
@@ -1311,6 +1496,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                 } else if (spi->level) {
                     spi->pending = false;
                 }
+                irs_recalc_hppi(s, spi->domain, spi->iaffid);
             }
         }
         return true;
@@ -1320,7 +1506,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
@@ -1331,6 +1522,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
 
         if (spi) {
             spi_sample(spi);
+            irs_recalc_hppi(s, spi->domain, spi->iaffid);
         }
         trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
         return true;
@@ -1499,6 +1691,7 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
 {
     /* These irqs are all SPIs; the INTID is irq + s->spi_base */
     GICv5Common *cs = ARM_GICV5_COMMON(opaque);
+    GICv5 *s = ARM_GICV5(cs);
     uint32_t spi_id = irq + cs->spi_base;
     GICv5SPIState *spi = gicv5_raw_spi_state(cs, spi_id);
 
@@ -1511,6 +1704,8 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
     spi->level = level;
     spi_sample(spi);
     trace_gicv5_spi_state(spi_id, spi->level, spi->pending, spi->active);
+
+    irs_recalc_hppi(s, spi->domain, spi->iaffid);
 }
 
 static void gicv5_reset_hold(Object *obj, ResetType type)
@@ -1591,6 +1786,7 @@ static void gicv5_set_idregs(GICv5Common *cs)
 
 static void gicv5_realize(DeviceState *dev, Error **errp)
 {
+    GICv5 *s = ARM_GICV5(dev);
     GICv5Common *cs = ARM_GICV5_COMMON(dev);
     GICv5Class *gc = ARM_GICV5_GET_CLASS(dev);
     Error *migration_blocker = NULL;
@@ -1618,6 +1814,12 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
 
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
index 136b6339ee..60c470b84c 100644
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
+ * that the IRS has available for it has changed.  This is the
+ * equivalent of the stream protocol's Forward packet, and also of its
+ * Recall packet.
+ *
+ * The stream protocol makes this asynchronous, allowing two Forward
+ * packets to be in flight and requiring an acknowledge, because the
+ * cpuif might be about to activate the previous forwarded interrupt
+ * while we are trying to tell it about a new one. But for QEMU we
+ * hold the BQL, so we know the vcpu might be executing guest code but
+ * it cannot be in the middle of changing cpuif state. So we can just
+ * synchronously tell it that a new HPPI exists (which might cause it
+ * to assert IRQ or FIQ to itself); this works as if the cpuif gave us
+ * a Release for the old HPPI.  The cpuif will ask the IRS for the
+ * HPPI info via a function call, so we do not need to pass it across
+ * here.
+ */
+void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
+
 #endif
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 80bb1cd391..e6f21d53b6 100644
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


