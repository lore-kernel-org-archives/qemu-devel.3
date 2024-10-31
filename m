Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AA3E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHy-0004sz-Is; Wed, 30 Oct 2024 23:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHj-00040P-ON
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:48 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHh-0004GJ-P9
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so5790935ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346944; x=1730951744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a5WXym0uMvacnKJc/Z+DFk0P/0EX7DJrZoRZjDmPR4=;
 b=QxfsvBmJptSXpaE+NNEowZaLDaDBcwg4GvL5c153Kc6O9FYkuT/P18VYGlIzjCd3oj
 5YY0rNjn64p+Z8SPiJ+aR9Lh4zqSzWkFdfonzTWtv5+R+XKeNwTjYIbQJsypX+/3qTKd
 VTzvREwZ8e4IUsd9rz9tUS9zwPVa6W9sNOSSJiLU9+HyDffu970zegD+sI1NeiBAnkfb
 YZd5Am4AzR3LHgQP3FNNJZeXo0MAEYYJk5YaEFeH5CAPZ6DmZ6yUsut51aRbiHvfzY7L
 b619v28cSDEPZgSP9lRhHJl+Z9LvF/FYtj3Kyyv7pW5v5O2kQ9gqG8tLXwnbdVQzFjOx
 vZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346944; x=1730951744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8a5WXym0uMvacnKJc/Z+DFk0P/0EX7DJrZoRZjDmPR4=;
 b=SqEFnxv3andSaYJ2lwjmHTUzLatFFO1jjqWJ79EKZ+e98k/NAJMFVUWgtYok6Z5Pd+
 llhX0/oDeQE9Cb7N6rk5bExRek+Q1NeSNvpDZqK/NpUXu3KsgyZtIpXPq7JjdAgKdrcb
 Sj50nDsSWXWk+Yv/8qKpvHrq0UmGCq3C0svLGJBA3ox4RNSoC9LHyVkZeCOGTZlNeaeA
 k+MKZRsHVsOezKyS/bksL6uc/g8bxBGORm+xHW6TPNLbJw18+U0Tou2gtpM/IV4OLs6I
 IqPI/fGEeMzHv3xBoAv3Poi822yUPyZ1QNjT5iKcAM2ZfenmGX0ehDS6+7x/ok5iExxD
 DJNw==
X-Gm-Message-State: AOJu0YxFbKhveLs6jbtBqX+DNwfGIg3nyWb8+pi/D0dEkPyzUE2jwJ0Y
 pLcZWfEr4CHbivLL//U6em3WogS1UdknwresMtiHPDoQRbzDJqMpjxbdntNH
X-Google-Smtp-Source: AGHT+IEuQMFL4kWzc52xJk/UKwIFpxM5/kg5/Amr1P/pIU+hID13pwKN/ZnAyD2/b2TqHUuDz3+esQ==
X-Received: by 2002:a17:903:124b:b0:20b:b455:eb4f with SMTP id
 d9443c01a7336-210c68d2932mr243898835ad.25.1730346944215; 
 Wed, 30 Oct 2024 20:55:44 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/50] hw/riscv/riscv-iommu: add Address Translation Cache
 (IOATC)
Date: Thu, 31 Oct 2024 13:53:11 +1000
Message-ID: <20241031035319.731906-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The RISC-V IOMMU spec predicts that the IOMMU can use translation caches
to hold entries from the DDT. This includes implementation for all cache
commands that are marked as 'not implemented'.

There are some artifacts included in the cache that predicts s-stage and
g-stage elements, although we don't support it yet. We'll introduce them
next.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241016204038.649340-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h |   3 +
 hw/riscv/riscv-iommu.c | 204 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index af3fcafc19..9f15f3b27f 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -69,6 +69,9 @@ struct RISCVIOMMUState {
 
     GHashTable *ctx_cache;          /* Device translation Context Cache */
 
+    GHashTable *iot_cache;          /* IO Translated Address Cache */
+    unsigned iot_limit;             /* IO Translation Cache size limit */
+
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
     uint8_t *regs_rw;  /* register state (user write) */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a727cb40db..7d291fa609 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -64,6 +64,15 @@ struct RISCVIOMMUContext {
     uint64_t msiptp;            /* MSI redirection page table pointer */
 };
 
+/* Address translation cache entry */
+struct RISCVIOMMUEntry {
+    uint64_t iova:44;           /* IOVA Page Number */
+    uint64_t pscid:20;          /* Process Soft-Context identifier */
+    uint64_t phys:44;           /* Physical Page Number */
+    uint64_t gscid:16;          /* Guest Soft-Context identifier */
+    uint64_t perm:2;            /* IOMMU_RW flags */
+};
+
 /* IOMMU index for transactions without process_id specified. */
 #define RISCV_IOMMU_NOPROCID 0
 
@@ -1154,13 +1163,132 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
     return &as->iova_as;
 }
 
+/* Translation Object cache support */
+static gboolean riscv_iommu_iot_equal(gconstpointer v1, gconstpointer v2)
+{
+    RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
+    RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
+    return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
+           t1->iova == t2->iova;
+}
+
+static guint riscv_iommu_iot_hash(gconstpointer v)
+{
+    RISCVIOMMUEntry *t = (RISCVIOMMUEntry *) v;
+    return (guint)t->iova;
+}
+
+/* GV: 1 PSCV: 1 AV: 1 */
+static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
+                                             gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid &&
+        iot->iova == arg->iova) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 PSCV: 1 AV: 0 */
+static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
+                                        gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 GVMA: 1 */
+static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer value,
+                                            gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        /* simplified cache, no GPA matching */
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 GVMA: 0 */
+static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
+                                        gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 */
+static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,
+                                      gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    iot->perm = IOMMU_NONE;
+}
+
+/* caller should keep ref-count for iot_cache object */
+static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
+    GHashTable *iot_cache, hwaddr iova)
+{
+    RISCVIOMMUEntry key = {
+        .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
+        .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
+        .iova  = PPN_DOWN(iova),
+    };
+    return g_hash_table_lookup(iot_cache, &key);
+}
+
+/* caller should keep ref-count for iot_cache object */
+static void riscv_iommu_iot_update(RISCVIOMMUState *s,
+    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
+{
+    if (!s->iot_limit) {
+        return;
+    }
+
+    if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
+        iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                          riscv_iommu_iot_equal,
+                                          g_free, NULL);
+        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+    }
+    g_hash_table_add(iot_cache, iot);
+}
+
+static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
+    uint32_t gscid, uint32_t pscid, hwaddr iova)
+{
+    GHashTable *iot_cache;
+    RISCVIOMMUEntry key = {
+        .gscid = gscid,
+        .pscid = pscid,
+        .iova  = PPN_DOWN(iova),
+    };
+
+    iot_cache = g_hash_table_ref(s->iot_cache);
+    g_hash_table_foreach(iot_cache, func, &key);
+    g_hash_table_unref(iot_cache);
+}
+
 static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb)
+    IOMMUTLBEntry *iotlb, bool enable_cache)
 {
+    RISCVIOMMUEntry *iot;
+    IOMMUAccessFlags perm;
     bool enable_pid;
     bool enable_pri;
+    GHashTable *iot_cache;
     int fault;
 
+    iot_cache = g_hash_table_ref(s->iot_cache);
     /*
      * TC[32] is reserved for custom extensions, used here to temporarily
      * enable automatic page-request generation for ATS queries.
@@ -1168,9 +1296,43 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
+    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
+    perm = iot ? iot->perm : IOMMU_NONE;
+    if (perm != IOMMU_NONE) {
+        iotlb->translated_addr = PPN_PHYS(iot->phys);
+        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        iotlb->perm = perm;
+        fault = 0;
+        goto done;
+    }
+
     /* Translate using device directory / page table information. */
     fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
 
+    if (!fault && iotlb->target_as == &s->trap_as) {
+        /* Do not cache trapped MSI translations */
+        goto done;
+    }
+
+    /*
+     * We made an implementation choice to not cache identity-mapped
+     * translations, as allowed by the specification, to avoid
+     * translation cache evictions for other devices sharing the
+     * IOMMU hardware model.
+     */
+    if (!fault && iotlb->translated_addr != iotlb->iova && enable_cache) {
+        iot = g_new0(RISCVIOMMUEntry, 1);
+        iot->iova = PPN_DOWN(iotlb->iova);
+        iot->phys = PPN_DOWN(iotlb->translated_addr);
+        iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
+        iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
+        iot->perm = iotlb->perm;
+        riscv_iommu_iot_update(s, iot_cache, iot);
+    }
+
+done:
+    g_hash_table_unref(iot_cache);
+
     if (enable_pri && fault) {
         struct riscv_iommu_pq_record pr = {0};
         if (enable_pid) {
@@ -1310,13 +1472,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
                 /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
                 goto cmd_ill;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings */
+                func = riscv_iommu_iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID */
+                func = riscv_iommu_iot_inval_gscid;
+            } else {
+                /* invalidate cache matching GSCID and ADDR (GPA) */
+                func = riscv_iommu_iot_inval_gscid_gpa;
             }
-            /* translation cache not implemented yet */
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
+                cmd.dword1 << 2 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
                              RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
-            /* translation cache not implemented yet */
+            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings, simplified model */
+                func = riscv_iommu_iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
+                /* invalidate cache matching GSCID, simplified model */
+                func = riscv_iommu_iot_inval_gscid;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID and PSCID */
+                func = riscv_iommu_iot_inval_pscid;
+            } else {
+                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
+                func = riscv_iommu_iot_inval_pscid_iova;
+            }
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
+                cmd.dword1 << 2 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
@@ -1831,6 +2020,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
                                          riscv_iommu_ctx_equal,
                                          g_free, NULL);
 
+    s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                         riscv_iommu_iot_equal,
+                                         g_free, NULL);
+
     s->iommus.le_next = NULL;
     s->iommus.le_prev = NULL;
     QLIST_INIT(&s->spaces);
@@ -1840,6 +2033,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    g_hash_table_unref(s->iot_cache);
     g_hash_table_unref(s->ctx_cache);
 }
 
@@ -1847,6 +2041,8 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
+    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
+        LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
@@ -1901,7 +2097,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-- 
2.47.0


