Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G/IxP/rJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagh-0002Sx-A0; Tue, 27 Oct 2026 02:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagQ-0002CT-NO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:20 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagN-0008CG-7S
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:17 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3acb512a7a0so2029718a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082554; x=1793687354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NIWNypVkMU9k6dJSZfJNTMSemmbL5/YCvZILO/l55LQ=;
 b=G/IxP/rJMdO6wTkzSOaqs6K3VRFVWBbMslkz8/YOKDFiH5Obt5AkNxZ9mRSBpmHvuB
 MBXCCkrqgDbCCXMlmEI3XF6nDUgW7YvpENOvJXf7FE0USZLdZ88ZPdVAhrFcfWYOxVyd
 P4JZ66y8t9FN1+P+1amTJDoCFgnQDxKlwwtAcwCQ4Q3WLy4Ta1z+p8rhJao6sDhsX93M
 u4Ng/wukhUiQUat+yrEW2uXXL3BrFmRVQ1xZsxsZLLXZhdt+ZNSS6dgCd9smUJhwgc1v
 wLHB2uDMXcjYT5mYYXBrgLZRQgiBH1ZkSXwF4W/k2hg0ygF2HphT0qIaZy5yxf/vb9RT
 fhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082554; x=1793687354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NIWNypVkMU9k6dJSZfJNTMSemmbL5/YCvZILO/l55LQ=;
 b=mtzpvU7fjuqjVuIt//1EyvyBTKcpJ44ZaA8hTorYSLTYEFn8mZYi4GKs1i9d7Jhiat
 /V1YBkygn6jE28v7J5HMIT/1RaLxOqlPB2I7+jTFwOl7aD1s2/j7icZxCvKEgSpUa+Dv
 WrZ9arQyaqJSR58XVz3juIoqZ0QYG6vV1DOn3GGVfuoRA6KeANM5sOL+asT0YOcNd7VX
 7h1VIj7N7hxURxVVFqB5qhyAQqchz/fqa6+//GwmzuMzoy+rhGyDwKp3wfhWBuU/bg7W
 jUZku/yVD4/zU8TJiQE3V2E+kcEs3jNu83E6vQMtLAY7IORRy/63DDk5HHwi9mjNMwfn
 uD/A==
X-Gm-Message-State: AFq9FYKmz34OfyIzaMcgCkzkHTUgNta1fZG4vREYxzaMGLbwHf/N7NFS
 nh6aru7OSXAGlwbx82uwaCYqJyWtEHfwTn8SqPF3CRJajPuSx+IDLN4oOH2+TA==
X-Gm-Gg: AYBFou1ETTsVHkIBOVx8k8og1Yb9YwXNE2MIJAe/ngOb8xSdGj/DV97DQvNSsSzrS1C
 xl3OaIAKhhhxBHHxtEuFGNjNbHCpSRER8Oc0/WPvla1QSY8Enkvp4LAam2CRhkgJINnSjnY3QEx
 E2b/WJ5a2avrvSh8ugTZYE0am4K/rKtCVnjlDrkxdVedHtD4sGKZZyf7HTOTFX8xPVRXTMEI7s4
 ncSSqLnMJeECoSwiizhiKJsE1TmZ9TCd3yBy8LXevRrNBWoqAC3BIBly5B6Lo4vGNwgowQlPRnV
 rRl39eIYUVE4e73YbqhrvLnXNUHkqDYW2n+e06kiow5qLtHEv2vkS4UNvK5gadx50IX4NDJ8gkE
 jfsoaQh2yGOX2/09yo0GaSd108FZ08tyXsOx5z5qvFJIzf86ANe4WrxPwFT+UXa0j8hkqC1Zyk4
 2hjZf4bBOp/LMQ/n7s8sCg2IOI+jGCNOPv/Fb1xrnpLM5La9T4MRTDPW6/xv96O7x+735XXM+SX
 mqiFFjujxE3SCwPFO+wD1D95Vsjga+N3OoKGFjEkv/Twk8C94cdeczSOfVKjJDoNmgL3cVDeTwm
 kn50wMs/GoAikEBaB2I=
X-Received: by 2002:a17:90b:4a81:b0:3a7:cffb:8b96 with SMTP id
 98e67ed59e1d1-3adea9da8fbmr7090314a91.18.1793082553884; 
 Mon, 26 Oct 2026 23:29:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/29] hw/riscv/riscv-iommu: serialize IOATC accesses
Date: Tue, 27 Oct 2026 16:27:54 +1000
Message-ID: <20261027062808.1995205-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

The IOATC currently keeps references to the hash table while cached
entries are being used. The following change will remove matching
entries during invalidation, which requires cached entry lifetime to be
protected explicitly.

Add an iot_lock to serialize IOATC lookup, update, invalidation, and
reset operations. Copy the fields needed by the translation path while
holding the lock, then release it before updating the IOMMUTLBEntry.

Keep the page-table walk outside the critical section so the lock is not
held across potentially expensive memory accesses.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261017144533.15610-1-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h |  1 +
 hw/riscv/riscv-iommu.c | 53 ++++++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 7c470ba084a0..403d10b32139 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -73,6 +73,7 @@ struct RISCVIOMMUState {
 
     GHashTable *iot_cache;          /* IO Translated Address Cache */
     unsigned iot_limit;             /* IO Translation Cache size limit */
+    QemuMutex iot_lock;
 
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 866f49cc39aa..2ac479ee5038 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1682,7 +1682,7 @@ static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
     }
 }
 
-/* caller should keep ref-count for iot_cache object */
+/* caller must hold iot_lock */
 static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
@@ -1695,27 +1695,26 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     return g_hash_table_lookup(iot_cache, &key);
 }
 
-/* caller should keep ref-count for iot_cache object */
-static void riscv_iommu_iot_update(RISCVIOMMUState *s,
-    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
+/* caller must hold iot_lock */
+static void riscv_iommu_iot_update(RISCVIOMMUState *s, RISCVIOMMUEntry *iot)
 {
     if (!s->iot_limit) {
         return;
     }
 
     if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
-        iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
-                                          riscv_iommu_iot_equal,
-                                          g_free, NULL);
-        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+        GHashTable *old_cache = s->iot_cache;
+        s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                             riscv_iommu_iot_equal,
+                                             g_free, NULL);
+        g_hash_table_unref(old_cache);
     }
-    g_hash_table_add(iot_cache, iot);
+    g_hash_table_add(s->iot_cache, iot);
 }
 
 static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
     uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
-    GHashTable *iot_cache;
     RISCVIOMMUEntry key = {
         .tag = transtag,
         .gscid = gscid,
@@ -1723,9 +1722,9 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
         .iova  = PPN_DOWN(iova),
     };
 
-    iot_cache = g_hash_table_ref(s->iot_cache);
-    g_hash_table_foreach(iot_cache, func, &key);
-    g_hash_table_unref(iot_cache);
+    qemu_mutex_lock(&s->iot_lock);
+    g_hash_table_foreach(s->iot_cache, func, &key);
+    qemu_mutex_unlock(&s->iot_lock);
 }
 
 static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ctx)
@@ -1747,15 +1746,14 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 {
     RISCVIOMMUTransTag transtag = riscv_iommu_get_transtag(ctx);
     RISCVIOMMUEntry *iot;
-    IOMMUAccessFlags perm;
+    IOMMUAccessFlags perm = IOMMU_NONE;
     bool enable_pid;
     bool enable_pri;
-    GHashTable *iot_cache;
+    hwaddr phys = 0;
     int fault;
 
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
-    iot_cache = g_hash_table_ref(s->iot_cache);
     enable_pri = (iotlb->perm == IOMMU_NONE) &&
                  (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
@@ -1771,10 +1769,15 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     }
 
-    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
-    perm = iot ? iot->perm : IOMMU_NONE;
+    qemu_mutex_lock(&s->iot_lock);
+    iot = riscv_iommu_iot_lookup(ctx, s->iot_cache, iotlb->iova, transtag);
+    if (iot) {
+        perm = iot->perm;
+        phys = iot->phys;
+    }
+    qemu_mutex_unlock(&s->iot_lock);
     if (perm != IOMMU_NONE) {
-        iotlb->translated_addr = PPN_PHYS(iot->phys);
+        iotlb->translated_addr = PPN_PHYS(phys);
         iotlb->addr_mask = ~TARGET_PAGE_MASK;
         iotlb->perm = perm;
         fault = 0;
@@ -1805,12 +1808,12 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
         iot->perm = iotlb->perm;
         iot->tag = transtag;
-        riscv_iommu_iot_update(s, iot_cache, iot);
+        qemu_mutex_lock(&s->iot_lock);
+        riscv_iommu_iot_update(s, iot);
+        qemu_mutex_unlock(&s->iot_lock);
     }
 
 done:
-    g_hash_table_unref(iot_cache);
-
     if (enable_pri && fault) {
         struct riscv_iommu_pq_record pr = {0};
         if (enable_pid) {
@@ -2674,6 +2677,7 @@ static void riscv_iommu_instance_init(Object *obj)
     s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
                                          riscv_iommu_iot_equal,
                                          g_free, NULL);
+    qemu_mutex_init(&s->iot_lock);
 
     s->iommus.le_next = NULL;
     s->iommus.le_prev = NULL;
@@ -2690,6 +2694,8 @@ static void riscv_iommu_instance_finalize(Object *obj)
 
     g_hash_table_unref(s->ctx_cache);
     g_hash_table_unref(s->iot_cache);
+
+    qemu_mutex_destroy(&s->iot_lock);
 }
 
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
@@ -2850,7 +2856,10 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
     riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_IPSR, 0);
 
     g_hash_table_remove_all(s->ctx_cache);
+
+    qemu_mutex_lock(&s->iot_lock);
     g_hash_table_remove_all(s->iot_cache);
+    qemu_mutex_unlock(&s->iot_lock);
 }
 
 static const Property riscv_iommu_properties[] = {
-- 
2.55.0


