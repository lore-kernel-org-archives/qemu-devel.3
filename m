Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B5CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuXQ-0006nF-PO; Wed, 05 Jun 2024 13:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1sEuXN-0006kg-MU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:35:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1sEuXK-0006mF-MH
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:35:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-702621d8725so56872b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717608897; x=1718213697;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlOa1fd1Am6tmTNeZbxQ94sUldfrKKaaJOLSlsxhO1w=;
 b=zxW20aNmLf/3wmM2+oyZk/9jkeuRSZVkAnMG08vsnipCBeb1DaPoMYp8GXHZ55ld7x
 NtsTSZzmzqJa3LWPHgj/h4kNKGT1e6OTE7TCW4o7jqp4gCDvYsDiWXps1Gf4qRkoZ/S0
 +hDbuDUQgFsmj0v3Ryp8PVteVns425Zd00ft7OyBHtKzw9Bv1cCo4Cy7Hlzw5ZsNzgs3
 txgDvkvm/gVbikxB9ipI/i09TL6qkj4T3JyBUJfFRVCjWygdW/lXciNfHifLNAWGD0/J
 0fL053RBXBQDPnke2X543QWtUdkRCCNu3NEIYHKS475XXyA06SeAAcha5j2oF6viL4Gh
 orRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608897; x=1718213697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlOa1fd1Am6tmTNeZbxQ94sUldfrKKaaJOLSlsxhO1w=;
 b=KZFfarFbNv+ETdMad0IunQGvMzz+lPf+RAKl7sY97pzI1AWHGiOxWnkEsz5V3Q6ebn
 3T7EYHjlhO+VbJhCiDuu7YPWTv7+ga4RNsxJfW4ujPPp96zHCL9cMIg8CQAD42qtZ8PI
 DnlxgEyjy37Yh+kEm+MDy3H+WaZeTtTtCmtFeymiF66+1T9Yfw8wvqaC6sMmW2mDNaz0
 M4yI4gw8T8i9WVrCWeoaono4IxgCmPUYF28rDNBTiPL6w12FUm9k6UDq+9Lnv8hdtRX6
 1xUYKCBekkZM6E494yERiCO3DzYtYnhwwG8ifFmusUrhbBDcWF4QCCz1y2Fz8NpO2EYT
 OMdQ==
X-Gm-Message-State: AOJu0Yz/SXSUnnzx+3vi/IusPuA2sGGB4RqVoaXhYp/TuKLmf28KbtW/
 GuEIiE3ARkPNEphKr9MOnCeanoCbu/ffGHBkXam8YZkjt3fCaQUFz/WkdyAZiP5/WcRv2zrib3b
 tuPwfKcOCrSUrAWutKVePObPfNIeqBCracBnpbg==
X-Google-Smtp-Source: AGHT+IGmSKc1JqQHL1ybz4VbCOtOyY5Ktvat1zgdXStMRXtLOT3fqs4bIGVIKpO3nkbiiSH8fmgBmfo4eErn6oRptuw=
X-Received: by 2002:a05:6a21:193:b0:1b2:b60a:a425 with SMTP id
 adf61e73a8af0-1b2b713c70bmr3905443637.46.1717608896673; Wed, 05 Jun 2024
 10:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-9-dbarboza@ventanamicro.com>
In-Reply-To: <20240523173955.1940072-9-dbarboza@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 5 Jun 2024 10:34:45 -0700
Message-ID: <CAH2o1u79UaPJ4SGRV-GKaKHCxO68eq--xBxxSEfprbMWNz+qAg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] hw/riscv/riscv-iommu: add Address Translation
 Cache (IOATC)
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniel,

Thank you for your upstreaming work!

I've synchronized the private branch with v3 changes, and noticed
there is an important change missing in this patchset. We need
reader-writer lock around access to GLib.HashTable as it's not
MT-safe.  Diff added below, also available on github [1] branch
riscv_iommu_v4-rc1.

[1] link: https://github.com/tjeznach/qemu/tree/riscv_iommu_v4-rc1

Thanks!
- Tomasz Jeznach

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a27f56419a..75c5d645fc 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -991,7 +991,9 @@ static void riscv_iommu_ctx_inval(RISCVIOMMUState
*s, GHFunc func,
         .pasid =3D pasid,
     };
     ctx_cache =3D g_hash_table_ref(s->ctx_cache);
+    pthread_rwlock_wrlock(&s->ctx_lock);
     g_hash_table_foreach(ctx_cache, func, &key);
+    pthread_rwlock_unlock(&s->ctx_lock);
     g_hash_table_unref(ctx_cache);
 }

@@ -1007,26 +1009,31 @@ static RISCVIOMMUContext
*riscv_iommu_ctx(RISCVIOMMUState *s,
     };

     ctx_cache =3D g_hash_table_ref(s->ctx_cache);
+    pthread_rwlock_rdlock(&s->ctx_lock);
     ctx =3D g_hash_table_lookup(ctx_cache, &key);
+    pthread_rwlock_unlock(&s->ctx_lock);

     if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
         *ref =3D ctx_cache;
         return ctx;
     }

-    if (g_hash_table_size(s->ctx_cache) >=3D LIMIT_CACHE_CTX) {
-        ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
-                                          g_free, NULL);
-        g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
-    }
-
     ctx =3D g_new0(RISCVIOMMUContext, 1);
     ctx->devid =3D devid;
     ctx->pasid =3D pasid;

     int fault =3D riscv_iommu_ctx_fetch(s, ctx);
     if (!fault) {
+        pthread_rwlock_wrlock(&s->ctx_lock);
+        if (g_hash_table_size(ctx_cache) >=3D LIMIT_CACHE_CTX) {
+            g_hash_table_unref(ctx_cache);
+            ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
+                                              g_free, NULL);
+            g_hash_table_ref(ctx_cache);
+            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+        }
         g_hash_table_add(ctx_cache, ctx);
+        pthread_rwlock_unlock(&s->ctx_lock);
         *ref =3D ctx_cache;
         return ctx;
     }
@@ -1176,12 +1183,14 @@ static void riscv_iommu_iot_update(RISCVIOMMUState =
*s,
         return;
     }

+    pthread_rwlock_wrlock(&s->iot_lock);
     if (g_hash_table_size(s->iot_cache) >=3D s->iot_limit) {
         iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
                                           g_free, NULL);
         g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
     }
     g_hash_table_add(iot_cache, iot);
+    pthread_rwlock_unlock(&s->iot_lock);
 }

 static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
@@ -1195,7 +1204,9 @@ static void
riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
     };

     iot_cache =3D g_hash_table_ref(s->iot_cache);
+    pthread_rwlock_wrlock(&s->iot_lock);
     g_hash_table_foreach(iot_cache, func, &key);
+    pthread_rwlock_unlock(&s->iot_lock);
     g_hash_table_unref(iot_cache);
 }

@@ -1227,7 +1238,9 @@ static int riscv_iommu_translate(RISCVIOMMUState
*s, RISCVIOMMUContext *ctx,
         }
     }

+    pthread_rwlock_rdlock(&s->iot_lock);
     iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
+    pthread_rwlock_unlock(&s->iot_lock);
     perm =3D iot ? iot->perm : IOMMU_NONE;
     if (perm !=3D IOMMU_NONE) {
         iotlb->translated_addr =3D PPN_PHYS(iot->phys);
@@ -2085,6 +2098,8 @@ static void riscv_iommu_realize(DeviceState
*dev, Error **errp)
                                          g_free, NULL);
     s->iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
                                          g_free, NULL);
+    pthread_rwlock_init(&s->ctx_lock, NULL);
+    pthread_rwlock_init(&s->iot_lock, NULL);

     s->iommus.le_next =3D NULL;
     s->iommus.le_prev =3D NULL;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 26236c3cee..041b3b9e05 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -71,7 +71,9 @@ struct RISCVIOMMUState {
     MemoryRegion trap_mr;

     GHashTable *ctx_cache;          /* Device translation Context Cache */
+    pthread_rwlock_t ctx_lock;      /* Device translation Cache update loc=
k */
     GHashTable *iot_cache;          /* IO Translated Address Cache */
+    pthread_rwlock_t iot_lock;      /* IO TLB Cache update lock */
     unsigned iot_limit;             /* IO Translation Cache size limit */

     /* MMIO Hardware Interface */


On Thu, May 23, 2024 at 10:40=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU spec predicts that the IOMMU can use translation caches
> to hold entries from the DDT. This includes implementation for all cache
> commands that are marked as 'not implemented'.
>
> There are some artifacts included in the cache that predicts s-stage and
> g-stage elements, although we don't support it yet. We'll introduce them
> next.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/riscv/riscv-iommu.c | 189 ++++++++++++++++++++++++++++++++++++++++-
>  hw/riscv/riscv-iommu.h |   2 +
>  2 files changed, 187 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 39b4ff1405..abf6ae7726 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -63,6 +63,16 @@ struct RISCVIOMMUContext {
>      uint64_t msiptp;            /* MSI redirection page table pointer */
>  };
>
> +/* Address translation cache entry */
> +struct RISCVIOMMUEntry {
> +    uint64_t iova:44;           /* IOVA Page Number */
> +    uint64_t pscid:20;          /* Process Soft-Context identifier */
> +    uint64_t phys:44;           /* Physical Page Number */
> +    uint64_t gscid:16;          /* Guest Soft-Context identifier */
> +    uint64_t perm:2;            /* IOMMU_RW flags */
> +    uint64_t __rfu:2;
> +};
> +
>  /* IOMMU index for transactions without PASID specified. */
>  #define RISCV_IOMMU_NOPASID 0
>
> @@ -751,13 +761,125 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUS=
tate *s, uint32_t devid)
>      return &as->iova_as;
>  }
>
> +/* Translation Object cache support */
> +static gboolean __iot_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    RISCVIOMMUEntry *t1 =3D (RISCVIOMMUEntry *) v1;
> +    RISCVIOMMUEntry *t2 =3D (RISCVIOMMUEntry *) v2;
> +    return t1->gscid =3D=3D t2->gscid && t1->pscid =3D=3D t2->pscid &&
> +           t1->iova =3D=3D t2->iova;
> +}
> +
> +static guint __iot_hash(gconstpointer v)
> +{
> +    RISCVIOMMUEntry *t =3D (RISCVIOMMUEntry *) v;
> +    return (guint)t->iova;
> +}
> +
> +/* GV: 1 PSCV: 1 AV: 1 */
> +static void __iot_inval_pscid_iova(gpointer key, gpointer value, gpointe=
r data)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->gscid =3D=3D arg->gscid &&
> +        iot->pscid =3D=3D arg->pscid &&
> +        iot->iova =3D=3D arg->iova) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 1 PSCV: 1 AV: 0 */
> +static void __iot_inval_pscid(gpointer key, gpointer value, gpointer dat=
a)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->gscid =3D=3D arg->gscid &&
> +        iot->pscid =3D=3D arg->pscid) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 1 GVMA: 1 */
> +static void __iot_inval_gscid_gpa(gpointer key, gpointer value, gpointer=
 data)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->gscid =3D=3D arg->gscid) {
> +        /* simplified cache, no GPA matching */
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 1 GVMA: 0 */
> +static void __iot_inval_gscid(gpointer key, gpointer value, gpointer dat=
a)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->gscid =3D=3D arg->gscid) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 */
> +static void __iot_inval_all(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    iot->perm =3D IOMMU_NONE;
> +}
> +
> +/* caller should keep ref-count for iot_cache object */
> +static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
> +    GHashTable *iot_cache, hwaddr iova)
> +{
> +    RISCVIOMMUEntry key =3D {
> +        .pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
> +        .iova  =3D PPN_DOWN(iova),
> +    };
> +    return g_hash_table_lookup(iot_cache, &key);
> +}
> +
> +/* caller should keep ref-count for iot_cache object */
> +static void riscv_iommu_iot_update(RISCVIOMMUState *s,
> +    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
> +{
> +    if (!s->iot_limit) {
> +        return;
> +    }
> +
> +    if (g_hash_table_size(s->iot_cache) >=3D s->iot_limit) {
> +        iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
> +                                          g_free, NULL);
> +        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
> +    }
> +    g_hash_table_add(iot_cache, iot);
> +}
> +
> +static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
> +    uint32_t gscid, uint32_t pscid, hwaddr iova)
> +{
> +    GHashTable *iot_cache;
> +    RISCVIOMMUEntry key =3D {
> +        .gscid =3D gscid,
> +        .pscid =3D pscid,
> +        .iova  =3D PPN_DOWN(iova),
> +    };
> +
> +    iot_cache =3D g_hash_table_ref(s->iot_cache);
> +    g_hash_table_foreach(iot_cache, func, &key);
> +    g_hash_table_unref(iot_cache);
> +}
> +
>  static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
> -    IOMMUTLBEntry *iotlb)
> +    IOMMUTLBEntry *iotlb, bool enable_cache)
>  {
> +    RISCVIOMMUEntry *iot;
> +    IOMMUAccessFlags perm;
>      bool enable_pasid;
>      bool enable_pri;
> +    GHashTable *iot_cache;
>      int fault;
>
> +    iot_cache =3D g_hash_table_ref(s->iot_cache);
>      /*
>       * TC[32] is reserved for custom extensions, used here to temporaril=
y
>       * enable automatic page-request generation for ATS queries.
> @@ -765,9 +887,36 @@ static int riscv_iommu_translate(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>      enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
>      enable_pasid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>
> +    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
> +    perm =3D iot ? iot->perm : IOMMU_NONE;
> +    if (perm !=3D IOMMU_NONE) {
> +        iotlb->translated_addr =3D PPN_PHYS(iot->phys);
> +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        iotlb->perm =3D perm;
> +        fault =3D 0;
> +        goto done;
> +    }
> +
>      /* Translate using device directory / page table information. */
>      fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
>
> +    if (!fault && iotlb->target_as =3D=3D &s->trap_as) {
> +        /* Do not cache trapped MSI translations */
> +        goto done;
> +    }
> +
> +    if (!fault && iotlb->translated_addr !=3D iotlb->iova && enable_cach=
e) {
> +        iot =3D g_new0(RISCVIOMMUEntry, 1);
> +        iot->iova =3D PPN_DOWN(iotlb->iova);
> +        iot->phys =3D PPN_DOWN(iotlb->translated_addr);
> +        iot->pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
> +        iot->perm =3D iotlb->perm;
> +        riscv_iommu_iot_update(s, iot_cache, iot);
> +    }
> +
> +done:
> +    g_hash_table_unref(iot_cache);
> +
>      if (enable_pri && fault) {
>          struct riscv_iommu_pq_record pr =3D {0};
>          if (enable_pasid) {
> @@ -907,13 +1056,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMU=
State *s)
>              if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
>                  /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=3D=
 1 */
>                  goto cmd_ill;
> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> +                /* invalidate all cache mappings */
> +                func =3D __iot_inval_all;
> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> +                /* invalidate cache matching GSCID */
> +                func =3D __iot_inval_gscid;
> +            } else {
> +                /* invalidate cache matching GSCID and ADDR (GPA) */
> +                func =3D __iot_inval_gscid_gpa;
>              }
> -            /* translation cache not implemented yet */
> +            riscv_iommu_iot_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0=
,
> +                cmd.dword1 & TARGET_PAGE_MASK);
>              break;
>
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
>                               RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> -            /* translation cache not implemented yet */
> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> +                /* invalidate all cache mappings, simplified model */
> +                func =3D __iot_inval_all;
> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
> +                /* invalidate cache matching GSCID, simplified model */
> +                func =3D __iot_inval_gscid;
> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> +                /* invalidate cache matching GSCID and PSCID */
> +                func =3D __iot_inval_pscid;
> +            } else {
> +                /* invalidate cache matching GSCID and PSCID and ADDR (I=
OVA) */
> +                func =3D __iot_inval_pscid_iova;
> +            }
> +            riscv_iommu_iot_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
> +                cmd.dword1 & TARGET_PAGE_MASK);
>              break;
>
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
> @@ -1410,6 +1586,8 @@ static void riscv_iommu_realize(DeviceState *dev, E=
rror **errp)
>      /* Device translation context cache */
>      s->ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
>                                           g_free, NULL);
> +    s->iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
> +                                         g_free, NULL);
>
>      s->iommus.le_next =3D NULL;
>      s->iommus.le_prev =3D NULL;
> @@ -1423,6 +1601,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>      RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
>
>      qemu_mutex_destroy(&s->core_lock);
> +    g_hash_table_unref(s->iot_cache);
>      g_hash_table_unref(s->ctx_cache);
>  }
>
> @@ -1430,6 +1609,8 @@ static Property riscv_iommu_properties[] =3D {
>      DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>          RISCV_IOMMU_SPEC_DOT_VER),
>      DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> +    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
> +        LIMIT_CACHE_IOT),
>      DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>      DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>      DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
> @@ -1482,7 +1663,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_tran=
slate(
>          /* Translation disabled or invalid. */
>          iotlb.addr_mask =3D 0;
>          iotlb.perm =3D IOMMU_NONE;
> -    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
>          /* Translation disabled or fault reported. */
>          iotlb.addr_mask =3D 0;
>          iotlb.perm =3D IOMMU_NONE;
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 31d3907d33..3afee9f3e8 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -68,6 +68,8 @@ struct RISCVIOMMUState {
>      MemoryRegion trap_mr;
>
>      GHashTable *ctx_cache;          /* Device translation Context Cache =
*/
> +    GHashTable *iot_cache;          /* IO Translated Address Cache */
> +    unsigned iot_limit;             /* IO Translation Cache size limit *=
/
>
>      /* MMIO Hardware Interface */
>      MemoryRegion regs_mr;
> --
> 2.44.0
>

