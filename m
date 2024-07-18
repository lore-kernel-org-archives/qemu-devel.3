Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926DFC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 04:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUJ6g-0001YK-8z; Thu, 18 Jul 2024 00:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUJ6e-0001WF-PC; Thu, 18 Jul 2024 00:51:04 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUJ6c-0002iO-N8; Thu, 18 Jul 2024 00:51:04 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4f2faade55dso146321e0c.1; 
 Wed, 17 Jul 2024 21:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721278261; x=1721883061; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VaeAXH++LsyZoLIancDxKU/QewEo+PlKC/xoI4d489U=;
 b=VgW+t7A5L6KDAMNlj0GlnkioWgC95INdV1mG/AOJTfVeLqNPt8t2WR2yNtXtwIaYEm
 BOYQtn556ZhK/S39JhVYbwmgCt81j4PBI4o/WFQxvpmBYt6EWHc91Dqk9EONnDFidw51
 SS7kRQVvXTFyMPW7RlaJ/ce6d3Qk/v3av0BYoq8YdsBhejpD5XvN2rfP71lS9NHGHf74
 3PzJbMBvnP0xlQx34d/2sV1hzws0QljWcPQxrpJjwWZ8Lp4Nx2Zs38Gnz9V0vDLxss/P
 eA3tqONVbMU2PQCeBUp8qb5PlzfNjnioI2OvUhC7g/0eOeMFDnqzzY1AVQugKYjiJZUs
 s16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721278261; x=1721883061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaeAXH++LsyZoLIancDxKU/QewEo+PlKC/xoI4d489U=;
 b=hrEXDYzgDxBs1rWZ05RdzStBqhR5t72fLsMfymeow8Vx4m+xC08medFRlrDrB3FtiK
 Bvs/y/iAMUJO6dNwkmETJ4/Hkv+YzJhl7++Y0/0Ke4C0R6zdBqxADJmcPkOSjJTzMSCj
 KFVhoXyABhGVMaSH9du0ztIEg9fWLFQP+4RKtGyChLwPfDmg1kR1r3xyYuV3CC+uDQ4W
 v8CAIVNrEckPYXM3RP1XhpVrce3cesQqJ0uL2G1iqvjkhK/VtFE4xL53nQ1oiGncLG3Z
 ULhhhU/tpAThl0pqpDy1XnNZOrYr3/CNqCiANmNai/b6r0A4dtCzYtWsD/5NLsmrfq3J
 2YmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLiw+Unj1gbbllvTu2gXfH+0LhPuEJ76VzZ3CT+InODkYMHL37ravdEQI7OKkVVLd/5pnnYxwBGIY6d5kjTaZWGa3Jfjs=
X-Gm-Message-State: AOJu0Ywn1qNqgy9kPCNda4uEe/TnERiSltc02UevGrI+jToNKVu3mW7s
 Rmj7pvA5ONzXNPl7JWLIYhFZ1aH1Bw/xJqNiXWSrLDobq52oLTnLe9+/R3zBzDKIdpa5sx2b7tR
 hsrf3PAKamdcENuTPSVtLqPO/0E8=
X-Google-Smtp-Source: AGHT+IHTp1S0kQJZJvgFlbqs6kcIVD6uFfoqlfxrO44/NZbxygw3NbXXaV6LaR1BohKLzQSTN4uB4IiJ7VAI5hEoH0g=
X-Received: by 2002:a05:6102:504f:b0:48f:dbf3:b42c with SMTP id
 ada2fe7eead31-4915991d0aamr4841220137.17.1721278261099; Wed, 17 Jul 2024
 21:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-9-dbarboza@ventanamicro.com>
In-Reply-To: <20240708173501.426225-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 18 Jul 2024 14:50:35 +1000
Message-ID: <CAKmqyKMT=HfGJArVD6qW30B7HhD+oONU3Xb+rPNR+hf8VoeGeg@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] hw/riscv/riscv-iommu: add Address Translation
 Cache (IOATC)
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, frank.chang@sifive.com, tjeznach@rivosinc.com, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Tue, Jul 9, 2024 at 3:38=E2=80=AFAM Daniel Henrique Barboza
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 199 ++++++++++++++++++++++++++++++++++++++++-
>  hw/riscv/riscv-iommu.h |   3 +
>  2 files changed, 198 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 5faa76a904..76728baa77 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -65,6 +65,16 @@ struct RISCVIOMMUContext {
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
>  /* IOMMU index for transactions without process_id specified. */
>  #define RISCV_IOMMU_NOPROCID 0
>
> @@ -1130,13 +1140,130 @@ static AddressSpace *riscv_iommu_space(RISCVIOMM=
UState *s, uint32_t devid)
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
> +        .gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
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
> +    qemu_mutex_lock(&s->iot_lock);
> +    if (g_hash_table_size(s->iot_cache) >=3D s->iot_limit) {
> +        iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
> +                                          g_free, NULL);
> +        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
> +    }
> +    g_hash_table_add(iot_cache, iot);
> +    qemu_mutex_unlock(&s->iot_lock);
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
> +    qemu_mutex_lock(&s->iot_lock);
> +    g_hash_table_foreach(iot_cache, func, &key);
> +    qemu_mutex_unlock(&s->iot_lock);
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
>      bool enable_pid;
>      bool enable_pri;
> +    GHashTable *iot_cache;
>      int fault;
>
> +    iot_cache =3D g_hash_table_ref(s->iot_cache);
>      /*
>       * TC[32] is reserved for custom extensions, used here to temporaril=
y
>       * enable automatic page-request generation for ATS queries.
> @@ -1144,9 +1271,39 @@ static int riscv_iommu_translate(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
>      enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
>      enable_pid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>
> +    qemu_mutex_lock(&s->iot_lock);
> +    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
> +    qemu_mutex_unlock(&s->iot_lock);
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
> +        iot->gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID=
);
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
>          if (enable_pid) {
> @@ -1286,13 +1443,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMM=
UState *s)
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
> @@ -1801,6 +1985,10 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>                                           g_free, NULL);
>      qemu_mutex_init(&s->ctx_lock);
>
> +    s->iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
> +                                         g_free, NULL);
> +    qemu_mutex_init(&s->iot_lock);
> +
>      s->iommus.le_next =3D NULL;
>      s->iommus.le_prev =3D NULL;
>      QLIST_INIT(&s->spaces);
> @@ -1813,6 +2001,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>      RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
>
>      qemu_mutex_destroy(&s->core_lock);
> +    g_hash_table_unref(s->iot_cache);
>      g_hash_table_unref(s->ctx_cache);
>  }
>
> @@ -1820,6 +2009,8 @@ static Property riscv_iommu_properties[] =3D {
>      DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>          RISCV_IOMMU_SPEC_DOT_VER),
>      DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> +    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
> +        LIMIT_CACHE_IOT),
>      DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>      DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>      DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
> @@ -1874,7 +2065,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_tran=
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
> index a3f858d978..0594e654f9 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -71,6 +71,9 @@ struct RISCVIOMMUState {
>
>      GHashTable *ctx_cache;          /* Device translation Context Cache =
*/
>      QemuMutex ctx_lock;      /* Device translation Cache update lock */
> +    GHashTable *iot_cache;          /* IO Translated Address Cache */
> +    QemuMutex iot_lock;      /* IO TLB Cache update lock */
> +    unsigned iot_limit;             /* IO Translation Cache size limit *=
/
>
>      /* MMIO Hardware Interface */
>      MemoryRegion regs_mr;
> --
> 2.45.2
>
>

