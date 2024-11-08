Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF7D5E15D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 11:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Mku-0004MR-6t; Fri, 08 Nov 2024 06:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1t9Mks-0004Ly-3A
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:02:18 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1t9Mkq-00084j-3N
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:02:17 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2113da91b53so14843205ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731063734; x=1731668534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeSbn0LJeQDv1RfCtf32+AAaPrnTC09h3RcD1t76Wew=;
 b=Lb3iwx35DgSWTCzxXMJ1eCKcvkmJmZwGD2pcgp4aAf+nJps/3Tv+a/wKJmgaI11DrS
 xH2cC8sl5nU18/7yM531PsGtKisH4oq2DaVgQVMk8zXJftejN7vr+pYSvR8cxUciWFj1
 cUIPrGaW1HFQHYSOn/hEB9PC+agyQbdQp1pAskPMQ9eduhoRbi/Vq6+SEFVor0NmSY13
 Z8x9wAyPnb24xcY8ogOHKvX4yNt3ExbCfxcQaVXMZSp4gmTDOaWzIsM0/7tWLI6/O8tH
 FNPRrakRCjDTQdcLqdVu2AMF7D7y6Sg4ODH9oF9DAYk5GnsLaLHk9vCynSHOo3/8ypam
 KZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731063734; x=1731668534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeSbn0LJeQDv1RfCtf32+AAaPrnTC09h3RcD1t76Wew=;
 b=FXSD9F423DPgdPXR9Lqrx88d8AakqMoWLexdO7naNT1LH5dI7c6gl3ePm8xvwWwVSK
 DqtK9qx7ye+6mM4JCdvJUKRrM8KXCKhIRhLX8zeH+HjHkDgVcBaINLbek/7HSQ8n29Ik
 dn3r5RDNJeQtf4ChDLc3gHchc2Gek5b9QZ0WfLO3RR/JaUog5VkXyWFAsaj/7HS94/6d
 beypml9d9kTbqAriJJeg66OIRpvwYxBGt5mz4gAM9ohP+VevIEFqJM09TzjfUe081QMg
 k0ADF2gTM8maW1TCJID0IREGP/Kzl29UUQtBrO1SXDxPPLCrmY9fjiEiMFTLxkWApw81
 JjxA==
X-Gm-Message-State: AOJu0YyzECS6LOq889im1Lh4vxL5ILj1SBU2YpnzHt+xE/BoUCHpxrF7
 ngdn76aYcqA2FlKgSZTAmdztEH2i7URQSeVOovel0iRc7X/kt2yuIxrJCuR17Mxm+QRLpZ1Zmbx
 27nN8F2VSghOje9wH5visuzhbEPq25cMqzyNqCtiktsaoc/Ilnv/8c6uSch18iXtX4/YdV2MWgc
 hI1KOyYMHv8Hm3csaLXF8I4H7aYY1id78dhy3lkNs=
X-Google-Smtp-Source: AGHT+IFdaAIjYMzcemnuoyf6qt0DVNM3SqMMFplACqdsY4rxqdSq1I8Xi4nArKjRhsgqib7BHfHVnA==
X-Received: by 2002:a17:903:110c:b0:211:6b37:7e66 with SMTP id
 d9443c01a7336-21183d1b72cmr27884905ad.17.1731063733934; 
 Fri, 08 Nov 2024 03:02:13 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e41651sm27649905ad.134.2024.11.08.03.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 03:02:13 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: Introduce a translation tag for the
 page table cache
Date: Fri,  8 Nov 2024 19:01:47 +0800
Message-ID: <20241108110147.11178-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x634.google.com
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

This commit introduces a translation tag to avoid invalidating an entry
that should not be invalidated when IOMMU executes invalidation commands.
E.g. IOTINVAL.VMA with GV=0, AV=0, PSCV=1 invalidates both a mapping
of single stage translation and a mapping of nested translation with
the same PSCID, but only the former one should be invalidated.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/riscv/riscv-iommu.c | 205 ++++++++++++++++++++++++++++++-----------
 1 file changed, 153 insertions(+), 52 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index ff9deefe37..ac6bbf91d6 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -64,8 +64,16 @@ struct RISCVIOMMUContext {
     uint64_t msiptp;            /* MSI redirection page table pointer */
 };
 
+typedef enum RISCVIOMMUTransTag {
+    RISCV_IOMMU_TRANS_TAG_BY,  /* Bypass */
+    RISCV_IOMMU_TRANS_TAG_SS,  /* Single Stage */
+    RISCV_IOMMU_TRANS_TAG_VG,  /* G-stage only */
+    RISCV_IOMMU_TRANS_TAG_VN,  /* Nested translation */
+} RISCVIOMMUTransTag;
+
 /* Address translation cache entry */
 struct RISCVIOMMUEntry {
+    RISCVIOMMUTransTag tag;     /* Translation Tag */
     uint64_t iova:44;           /* IOVA Page Number */
     uint64_t pscid:20;          /* Process Soft-Context identifier */
     uint64_t phys:44;           /* Physical Page Number */
@@ -1228,7 +1236,7 @@ static gboolean riscv_iommu_iot_equal(gconstpointer v1, gconstpointer v2)
     RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
     RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
     return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
-           t1->iova == t2->iova;
+           t1->iova == t2->iova && t1->tag == t2->tag;
 }
 
 static guint riscv_iommu_iot_hash(gconstpointer v)
@@ -1237,67 +1245,115 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
     return (guint)t->iova;
 }
 
-/* GV: 1 PSCV: 1 AV: 1 */
+/* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
+/* GV: 0 AV: 0 GVMA: 1 */
+static
+void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->tag == arg->tag) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
+static
+void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->tag == arg->tag &&
+        iot->pscid == arg->pscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
+static
+void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->tag == arg->tag &&
+        iot->iova == arg->iova) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
 static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
                                              gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->gscid == arg->gscid &&
+    if (iot->tag == arg->tag &&
         iot->pscid == arg->pscid &&
         iot->iova == arg->iova) {
         iot->perm = IOMMU_NONE;
     }
 }
 
-/* GV: 1 PSCV: 1 AV: 0 */
-static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
-                                        gpointer data)
+/* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
+/* GV: 1 AV: 0 GVMA: 1 */
+static
+void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->gscid == arg->gscid &&
-        iot->pscid == arg->pscid) {
+    if (iot->tag == arg->tag &&
+        iot->gscid == arg->gscid) {
         iot->perm = IOMMU_NONE;
     }
 }
 
-/* GV: 1 GVMA: 1 */
-static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer value,
-                                            gpointer data)
+/* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
+static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer value,
+                                              gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->gscid == arg->gscid) {
-        /* simplified cache, no GPA matching */
+    if (iot->tag == arg->tag &&
+        iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid) {
         iot->perm = IOMMU_NONE;
     }
 }
 
-/* GV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
-                                        gpointer data)
+/* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
+/* GV: 1 AV: 1 GVMA: 1 */
+static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer value,
+                                             gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->gscid == arg->gscid) {
+    if (iot->tag == arg->tag &&
+        iot->gscid == arg->gscid &&
+        iot->iova == arg->iova) {
         iot->perm = IOMMU_NONE;
     }
 }
 
-/* GV: 0 */
-static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,
-                                      gpointer data)
+/* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
+static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
+                                                   gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
-    iot->perm = IOMMU_NONE;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->tag == arg->tag &&
+        iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid &&
+        iot->iova == arg->iova) {
+        iot->perm = IOMMU_NONE;
+    }
 }
 
 /* caller should keep ref-count for iot_cache object */
 static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
-    GHashTable *iot_cache, hwaddr iova)
+    GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
     RISCVIOMMUEntry key = {
+        .tag   = transtag,
         .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
         .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
         .iova  = PPN_DOWN(iova),
@@ -1323,10 +1379,11 @@ static void riscv_iommu_iot_update(RISCVIOMMUState *s,
 }
 
 static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
-    uint32_t gscid, uint32_t pscid, hwaddr iova)
+    uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
     GHashTable *iot_cache;
     RISCVIOMMUEntry key = {
+        .tag = transtag,
         .gscid = gscid,
         .pscid = pscid,
         .iova  = PPN_DOWN(iova),
@@ -1337,9 +1394,24 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
     g_hash_table_unref(iot_cache);
 }
 
+static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ctx)
+{
+    uint64_t satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
+    uint64_t gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
+
+    if (satp == RISCV_IOMMU_DC_FSC_MODE_BARE) {
+        return (gatp == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
+            RISCV_IOMMU_TRANS_TAG_BY : RISCV_IOMMU_TRANS_TAG_VG;
+    } else {
+        return (gatp == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
+            RISCV_IOMMU_TRANS_TAG_SS : RISCV_IOMMU_TRANS_TAG_VN;
+    }
+}
+
 static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb, bool enable_cache)
 {
+    RISCVIOMMUTransTag transtag = riscv_iommu_get_transtag(ctx);
     RISCVIOMMUEntry *iot;
     IOMMUAccessFlags perm;
     bool enable_pid;
@@ -1365,7 +1437,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     }
 
-    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
+    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
     perm = iot ? iot->perm : IOMMU_NONE;
     if (perm != IOMMU_NONE) {
         iotlb->translated_addr = PPN_PHYS(iot->phys);
@@ -1396,6 +1468,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
         iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
         iot->perm = iotlb->perm;
+        iot->tag = transtag;
         riscv_iommu_iot_update(s, iot_cache, iot);
     }
 
@@ -1603,44 +1676,72 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
                              RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
-            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
+        {
+            bool gv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
+            bool av = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
+            bool pscv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV);
+            uint32_t gscid = get_field(cmd.dword0,
+                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID);
+            uint32_t pscid = get_field(cmd.dword0,
+                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID);
+            hwaddr iova = (cmd.dword1 << 2) & TARGET_PAGE_MASK;
+
+            if (pscv) {
                 /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
                 goto cmd_ill;
-            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
-                /* invalidate all cache mappings */
-                func = riscv_iommu_iot_inval_all;
-            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
-                /* invalidate cache matching GSCID */
-                func = riscv_iommu_iot_inval_gscid;
-            } else {
-                /* invalidate cache matching GSCID and ADDR (GPA) */
-                func = riscv_iommu_iot_inval_gscid_gpa;
             }
-            riscv_iommu_iot_inval(s, func,
-                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
-                cmd.dword1 << 2 & TARGET_PAGE_MASK);
+
+            func = riscv_iommu_iot_inval_all;
+
+            if (gv) {
+                func = (av) ? riscv_iommu_iot_inval_gscid_iova :
+                              riscv_iommu_iot_inval_gscid;
+            }
+
+            riscv_iommu_iot_inval(
+                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
+
+            riscv_iommu_iot_inval(
+                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
             break;
+        }
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
                              RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
-            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
-                /* invalidate all cache mappings, simplified model */
-                func = riscv_iommu_iot_inval_all;
-            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
-                /* invalidate cache matching GSCID, simplified model */
-                func = riscv_iommu_iot_inval_gscid;
-            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
-                /* invalidate cache matching GSCID and PSCID */
-                func = riscv_iommu_iot_inval_pscid;
+        {
+            bool gv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
+            bool av = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
+            bool pscv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV);
+            uint32_t gscid = get_field(cmd.dword0,
+                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID);
+            uint32_t pscid = get_field(cmd.dword0,
+                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID);
+            hwaddr iova = (cmd.dword1 << 2) & TARGET_PAGE_MASK;
+            RISCVIOMMUTransTag transtag;
+
+            if (gv) {
+                transtag = RISCV_IOMMU_TRANS_TAG_VN;
+                if (pscv) {
+                    func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
+                                  riscv_iommu_iot_inval_gscid_pscid;
+                } else {
+                    func = (av) ? riscv_iommu_iot_inval_gscid_iova :
+                                  riscv_iommu_iot_inval_gscid;
+                }
             } else {
-                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
-                func = riscv_iommu_iot_inval_pscid_iova;
+                transtag = RISCV_IOMMU_TRANS_TAG_SS;
+                if (pscv) {
+                    func = (av) ? riscv_iommu_iot_inval_pscid_iova :
+                                  riscv_iommu_iot_inval_pscid;
+                } else {
+                    func = (av) ? riscv_iommu_iot_inval_iova :
+                                  riscv_iommu_iot_inval_all;
+                }
             }
-            riscv_iommu_iot_inval(s, func,
-                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
-                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
-                cmd.dword1 << 2 & TARGET_PAGE_MASK);
+
+            riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag);
             break;
+        }
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
                              RISCV_IOMMU_CMD_IODIR_OPCODE):
-- 
2.43.2


