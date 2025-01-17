Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD3C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNa-0000wU-2q; Fri, 17 Jan 2025 00:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNX-0000Z2-43
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNU-0006Cy-TZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso26356805ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093523; x=1737698323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Do6AjO363mpahoSyzZEmer+bg1C5rcKUN5LUlQeK8f8=;
 b=Sc2YNTrSTLUWRL/G9U9K9HJJuu2ryQB1CqPFUpN6zr5+DqQcllZ30BEsqYpbv4PwXP
 400b26MTZerqrcaWyx45t3c+50jzaEyYQeHSMJ6jw/XN4KsEqDKnvEp91xp/k+R07G0V
 V2vTcotjw8MeqxciKSzg8zT8D9gJ1QsqnwRENFHxtBNUhhTH8fzeArOuI0QdrfYqsJhQ
 ZGvho5GNtqC5tKIFC+Vt5aZn/WIEPeu1a8QuvYk5TFUhM/uCG/5QCwf937v76UqzpPf/
 aYvQ0HyZ5TyVuarsjWJT87lgWyxcfngkCzwTWs/YvXB9/UV7hn+dnKP9pLgIb7EhvVuL
 7kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093523; x=1737698323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Do6AjO363mpahoSyzZEmer+bg1C5rcKUN5LUlQeK8f8=;
 b=S16BbYkn+i9pteqyXEqEgciS1H5EdWGRedoTSI19/qygO8E4smtkGypREk2jhkXoDd
 9JY5s7Cpg47rXX6dFKixN8Osuuy3FWLurLxZRJk9snLoHkZwDmuQeCbaOoZDHqp8iwFp
 jziv730BRlockoD+tfPezQgVxbWvAzQZyYUdSGUrd4q5OrsNqBYJYLvdus4XEm/wQvOD
 Mq7SPpORm7onZKUf/STbuHcAEmtKOGt1TRSFier8JIgsrA9+Fxl/7dDDw+1Ys+ra7jrB
 Lzma+Nc+yPEk+6TfdklNh9uyR6Rn+Ap4OW6wigggZIGZghp4BLfhlKDmr+6hlUO/NM7i
 qHsw==
X-Gm-Message-State: AOJu0YxqLcB6/S5mABVApFfUXfSjGCHaIxn+bJHXpIi9ph8Z/CjtV1vX
 iSHmWlSV0s5I9Lqk1495rPCwSuKC0QdbCrvkToybL/HaU60aMQe7iyzm8A==
X-Gm-Gg: ASbGncuEAgRPOe3S6jCM7EZwHh4M7i0ar7wgp/kiro+l9qUgNUuilAHC9tTgc8JTIXP
 Fp8bkx4Di1pmXBRIQtZJpz4IGOHGFWBewY9r8T8Vs6rTMMFVreICn22bHOfeNSVU7PJpKIWJi4u
 gDQwt20YgTotJIQ+nkQyMGc7IBBY4lCAWn49bmDYziFikzwf7lWZI4ffF2YQTUH+GANqEvE7dtA
 H4Gmc59i6GUevscQmpP7aw7NmAuVU9qxEMRUY4ubr512HaHBeAK94ttE0T6zGUNNTTEZ48NCo0S
 ucqgEK1zAaRc3Y9Vbjcicu/TFqlZWGhw9zx545GjOZpJrn1ETNUQCBGbiBjI
X-Google-Smtp-Source: AGHT+IF2w/QPkBpI47m606F8CFdfdisIssckbCBpd5Bwb2Lt+WBXKZDfzdWWFsfSYOEwqnETTgM1AQ==
X-Received: by 2002:a17:902:da8d:b0:216:386e:dd8 with SMTP id
 d9443c01a7336-21c3540cd05mr21419115ad.17.1737093523359; 
 Thu, 16 Jan 2025 21:58:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/50] hw/riscv/riscv-iommu.c: Introduce a translation tag for
 the page table cache
Date: Fri, 17 Jan 2025 15:55:50 +1000
Message-ID: <20250117055552.108376-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Jason Chien <jason.chien@sifive.com>

This commit introduces a translation tag to avoid invalidating an entry
that should not be invalidated when IOMMU executes invalidation commands.
E.g. IOTINVAL.VMA with GV=0, AV=0, PSCV=1 invalidates both a mapping
of single stage translation and a mapping of nested translation with
the same PSCID, but only the former one should be invalidated.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241108110147.11178-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 205 ++++++++++++++++++++++++++++++-----------
 1 file changed, 153 insertions(+), 52 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 8bf920deab..e7568ca227 100644
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
@@ -1227,7 +1235,7 @@ static gboolean riscv_iommu_iot_equal(gconstpointer v1, gconstpointer v2)
     RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
     RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
     return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
-           t1->iova == t2->iova;
+           t1->iova == t2->iova && t1->tag == t2->tag;
 }
 
 static guint riscv_iommu_iot_hash(gconstpointer v)
@@ -1236,67 +1244,115 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
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
@@ -1322,10 +1378,11 @@ static void riscv_iommu_iot_update(RISCVIOMMUState *s,
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
@@ -1336,9 +1393,24 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
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
@@ -1364,7 +1436,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     }
 
-    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
+    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
     perm = iot ? iot->perm : IOMMU_NONE;
     if (perm != IOMMU_NONE) {
         iotlb->translated_addr = PPN_PHYS(iot->phys);
@@ -1395,6 +1467,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
         iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
         iot->perm = iotlb->perm;
+        iot->tag = transtag;
         riscv_iommu_iot_update(s, iot_cache, iot);
     }
 
@@ -1602,44 +1675,72 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
 
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
2.47.1


