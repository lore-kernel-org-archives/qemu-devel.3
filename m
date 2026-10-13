Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428CCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8g-00083q-NM; Tue, 13 Oct 2026 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4U-0001OA-Ff
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4S-0008GO-7P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so2932235e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880875; x=1792485675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sNKQ4kUhrMvPbIMfWxjETlhbpb5yOXnbWk+XZZ+a7WQ=;
 b=CiUcMv5wDfv2dtmzHwXzH06IIxhSLZaIIF2YXhHS0AaqdWN+WfrhLDJIWvG8zb/I9o
 o3edqvxnlRKq4ASPApyFyBXp9hM2zobmaOUrZ+x43chDOrx6IR+DUTBEbzcmZPP75YfD
 0+TgCWOSDgjLxZp3jO+GEahrpyrFWRRSMk67llOCXvgPjzkvYU+MjSu0E5rv5qGPY8Qd
 SHK5y/wyU7Zr6zq2dmNaf87NqtPCJSuldN5PeEmbbGYs9ShL6R9V0IWCuLa6in3TNP7a
 4wJlQWGNz/AlEXNppuSQW5KheaGr1ml595cFDW1eoyIqRBIX5nqk75uvg109W3QIeTyM
 wyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880875; x=1792485675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sNKQ4kUhrMvPbIMfWxjETlhbpb5yOXnbWk+XZZ+a7WQ=;
 b=odIOxzCBrT4m2l7asJZRa/Qxaa9muvZqbBvfwRPuGzr7guQjT9701Ef41k/TIhBdp1
 kG5f54n+vVFqz+XJnzoqnGLLimJfX5Pd2IMqz4RgTx9WKi7omkjPqVILspDd3FTm4xG1
 jNSWQvALlUl6jJNGK0RY7jKF075dDFEsioRhT9NWCJV7jw8e+xKxWF3akiAQoB6njXnV
 gPN7l3gr/rHYrtIVDQJqQz/AlI3wFeWhOE0i2GYkBUHrFtImW1z2hD97ZDtqBv6nNmJK
 YociK1imiEqlw91PMMu1+a3o8eaD0OmKWR4TbJWHqGzGN2Wk4MlxVfv1ZufJBDq2OO8N
 ofpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+ZOgQ1CRhSt2GmnpVVtCYEH7jfdJuL8hJoaaQEdtRKDK0qOEupdMohFUG7DdPrTVfCC2/QVXTg68c@nongnu.org
X-Gm-Message-State: AFq9FYLd6twev18N/r9L9KYusalJ7l5KSsn5kQPkdHd5g2TQBUKpmSTg
 072XZ3BVFJ02yQuPTkKj+SIOnH7L7LvXGj2jtOe/HKzKXf0QO8aGdAwGluMNx6HZxFlfhGJY901
 yH4cV0qo=
X-Gm-Gg: AYBFou2Ykj4lVvQce56TEglrq4nGc11vYZvMPGu0XGFYBP88KAOH7jKq+747FJ+ELbB
 Nzz286yyPRa8uh4JrBVJkTf3dcauUM/kM/EuhRXv+CpWuvTD3YqkUZySa4Su4b9CU/38sCrmwhA
 iBFcetSSgyiLt03Xn05Y8hwMX5mZHNRhBOMkW5ErZY9IrrqTVEmcdpE2L0T+Dn3BqtOaiGhQgb9
 K4TteN0Ze1DR+BTO9SVsHBHgM84PenNDMWQjJwktYDS88rC4T8olDnBbd06KC4NFkwMGZLiRGdH
 3ZH85+U2OyIYGV1tJRl9TgO490dzNcULDHHgZ08+wJaQvEm+ppMO6W9OyrAIhLakiQSyAVl8xgK
 I5/eC3ajwcfwcREeGBuoC3VbANr4CxTADmG2t8NNh2WvEZgnufy/+wIcVdqcXqllt4WrRnwbwxn
 wGvKxW4ZCLqJnxMNLo4GG/0/SGnnTNcImZX36kz6jTegKmJRUySMzqej41NFdFfN7Y+DYO+VA/q
 dcpoCvG1NLtb1vAB2A1uCnYvZ72vyLZ4FS6aW92wcuNo3Y2/myAGfwzIqwaC3Sjx7YwP/MF3zBC
 r9nHzUSLaQ76bQ==
X-Received: by 2002:a05:600c:5493:b0:4a1:78da:d271 with SMTP id
 5b1f17b1804b1-4a18e4ee976mr259096555e9.30.1791880874767; 
 Tue, 13 Oct 2026 01:41:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 77/86] hw/intc/arm_gicv5: Implement irs_recalc_vhppi()
Date: Tue, 13 Oct 2026 09:39:24 +0100
Message-ID: <20261013083933.1024405-78-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Recalculate the highest priority pending virtual interrupt for a
specified (VM, VPE) when we're called for interrupt state changes.
Because vSPIs and vLPIs are both stored in ISTs, we can reuse our
existing lpi_cache_get_hppi() function by making it take an extra
type argument for which kind of interrupt it is working on.

The logic for generating a doorbell interrupt if necessary for
a non-resident VPE will be added in a later commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
 hw/intc/trace-events |  2 ++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 8f4d44b2b37..b4dbe7ce3e7 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -29,6 +29,7 @@ typedef struct VMTE VMTE;
 typedef struct VPE {
     VMTE *vmte;
     hwaddr vped_addr;
+    GICv5PendingIrq vhppi; /* vHPPI candidate, if any */
     uint32_t cpuidx; /* CPU we're currently resident on */
     uint32_t db_intid; /* doorbell interrupt ID */
     uint8_t dbpm; /* doorbell priority mask */
@@ -192,6 +193,7 @@ static MemTxAttrs irs_txattrs(GICv5Common *cs, GICv5Domain domain)
 typedef struct GetHPPIUserData {
     GICv5PendingIrq *best;
     uint32_t iaffid;
+    GICv5IntType type;
 } GetHPPIUserData;
 
 static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
@@ -208,7 +210,7 @@ static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
     prio = FIELD_EX32(l2_iste, L2_ISTE, PRIORITY);
     iaffid = FIELD_EX32(l2_iste, L2_ISTE, IAFFID);
     if (iaffid == ud->iaffid && prio < ud->best->prio) {
-        id = FIELD_DP32(id, INTID, TYPE, GICV5_LPI);
+        id = FIELD_DP32(id, INTID, TYPE, ud->type);
         ud->best->intid = id;
         ud->best->prio = prio;
     }
@@ -257,6 +259,7 @@ static void irs_recalc_hppi(GICv5 *s, GICv5Domain domain, uint32_t iaffid)
 
         ud.best = &best;
         ud.iaffid = iaffid;
+        ud.type = GICV5_LPI;
         g_hash_table_foreach(s->phys_lpi_config[domain].lpi_cache,
                              lpi_cache_get_hppi, &ud);
     }
@@ -572,9 +575,42 @@ static void irs_recalc_vhppi(GICv5 *s, VMTE *vmte, uint32_t iaffid)
     /*
      * Recalculate the highest priority pending virtual interrupt for
      * the specified VM and vCPU.
-     *
-     * TODO: we will implement this in a future commit.
      */
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5PendingIrq best = GICV5_PENDING_IRQ_NONE;
+    GetHPPIUserData ud;
+    VPE *vpe = vpe_for_vpeid(vmte, iaffid);
+
+    if (!vpe) {
+        trace_gicv5_irs_recalc_vhppi_fail(domain_name[vmte->domain],
+                                          vmte->vmid, iaffid,
+                                          "IAFFID doesn't match valid VPEID");
+        return;
+    }
+
+    ud.best = &best;
+    ud.iaffid = iaffid;
+    if (vmte->lpi_ist.valid) {
+        ud.type = GICV5_LPI;
+        g_hash_table_foreach(vmte->lpi_ist.lpi_cache, lpi_cache_get_hppi, &ud);
+    }
+    if (vmte->spi_ist.valid) {
+        ud.type = GICV5_SPI;
+        g_hash_table_foreach(vmte->spi_ist.lpi_cache, lpi_cache_get_hppi, &ud);
+    }
+
+    trace_gicv5_irs_recalc_vhppi(domain_name[vmte->domain], vmte->vmid,
+                                 iaffid, best.intid, best.prio);
+
+    vpe->vhppi = best;
+
+    if (FIELD_EX32(cs->irs_cr0[vmte->domain], IRS_CR0, IRSEN) &&
+        vpe->vhppi.prio != PRIO_IDLE && vpe->resident) {
+        /* R_VBPZM: tell the PE about this vHPPI */
+        gicv5_forward_interrupt(cs->cpus[vpe->cpuidx], vmte->domain, true);
+    }
+
+    /* TODO: we may need to generate a doorbell interrupt. */
 }
 
 static const GICv5ISTConfig *ist_for_vint(GICv5 *s,
@@ -1473,6 +1509,7 @@ static void init_vpe_from_vpete(VPE *vpe, VMTE *vmte, uint64_t vpete)
         vpe->vped_addr &= ~MAKE_64BIT_MASK(0, QEMU_GICV5_VPED_SZ);
         /* Doorbell settings always start invalid */
         vpe->db_valid = false;
+        vpe->vhppi = GICV5_PENDING_IRQ_NONE;
     }
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 6d646eacaeb..963fd75c13e 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -246,6 +246,8 @@ gicv5_deactivate(const char *domain, const char *type, bool virtual, uint32_t id
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
+gicv5_irs_recalc_vhppi_fail(const char *domain, uint32_t vmid, uint32_t iaffid, const char *reason) "GICv5 IRS %s VMID %u IAFFID %u: no HPPI: %s"
+gicv5_irs_recalc_vhppi(const char *domain, uint32_t vmid, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s VMID %u IAFFID %u: new HPPI ID 0x%x prio %u"
 gicv5_vmt_valid(const char *domain, uint64_t base, uint8_t vm_id_bits, bool structure) "GICv5 IRS %s VM table now valid: base 0x%" PRIx64 " vm_id_bits %u 2-level %d"
 gicv5_vmt_invalid(const char *domain) "GICv5 IRS %s VM table no longer valid"
 gicv5_vmap_l2_vmtr(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u now valid"
-- 
2.43.0


