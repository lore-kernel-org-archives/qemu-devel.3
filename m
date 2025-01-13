Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC1BE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 03:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXArt-0006Is-Qx; Sun, 12 Jan 2025 22:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXArr-0006IT-PP; Sun, 12 Jan 2025 22:11:55 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXArp-0004vZ-Kx; Sun, 12 Jan 2025 22:11:55 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5161d5b8650so1295983e0c.3; 
 Sun, 12 Jan 2025 19:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736737912; x=1737342712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbLjuDBWUZZt9A2JgtxbsMmDT/geREqoWMoo71BDNrg=;
 b=HR217AzTS4+iwxFGosHA5E+V8W4D1w1k0/UQIM+XhUa+KcpZY+S6tDjMSHEPkmPBVO
 tIsJlBGSoZs/jQgiIQVcg3e7hSfJ4zTO62cXXimP6kl7tvI7ZzMsGb+qkz951TPACRwP
 mxuwQvCyMKmDg8bPqSSyEf8FXNY//+Pg8UrgRFQwHPP19oHtyfjmBPkcE62oMrgX5PPW
 PwpIHmr9vjr6cvM45szjJ0UVHj9Ckx0klfoOOBLVQ7HYdv25FtvZP/xZhj4hhVOsI9TQ
 egfc59+n5dkfyqglK3bXX9gN2lWM5KCurvs0FA+qrOCnu0P6hUCKp9j2aMhVZpRvDjPc
 XSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736737912; x=1737342712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZbLjuDBWUZZt9A2JgtxbsMmDT/geREqoWMoo71BDNrg=;
 b=awuGIeOU//mIktaCe8xtHQ4iUsSTtNEj39gd2QLSNU98GfqAKfWFbPi5EduPB+JHvE
 aHNHzu5Hxy2qMb2+TCuMab0oXa7ZAV0N2x/lkc0TD4W9QQQIKJWmwr+epkz8lk01mHkm
 DW909gVupx9Ji8lfW6WRlFUokX1zRaWleT5PbEJJafXHthSklFdBaJfhY/kokptayPcG
 GFTkLM4SyN2Fc7UXO7wdh8g2Q7f4VDF5/r8tEPgG7Qa7CTZgK1e6hYnIJ8cTzCbDGV2Z
 uZrw3ls8X3dJ+I4h0cPDewWro8QmMTc8gqJQ54+JEyIbSdUJLFP/acWegJgEDMzmySmL
 fF7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn9jYVRb6PDTyiij+U5lAspbsOXRNiSnC0B0lZeUABqU6NPFfm2CAk4GPep5lYQfcWO0qsZWRUXqQP@nongnu.org
X-Gm-Message-State: AOJu0YybJwZJf+Vrt8C0/FkSeG9GtNaiMPfOUaZQqdf5jzry9rmFNLAd
 by7LXj5hoKpu42/Cc3mhJ5nou4KGQiK2OEkVdOfbgaNqpSTKVw4sJcKyKKdwtHqB2UIzCdzlqHi
 WX6iQo+ihbyZuhNTfS9iVUTMDPZk=
X-Gm-Gg: ASbGncvfLIeSH+p8isWdKq+Ib5mQwPYWyQ9txVa9VGXSss615x3oQwsmCGJo4HG2OlT
 MNUENjCoTeENRRlsoibkoeF+1f7voa7dqEOmXSqyAsm8msgpdEaoiKR77Svso3WqfKD4=
X-Google-Smtp-Source: AGHT+IEL6YjM2fCP3kjXAZHtEoPcZMozxHeFYAfWzoSP55LP4zcKawvkGnbqSnVGheU82kPJ7ZUFxkQ/WREOp//AvzM=
X-Received: by 2002:a05:6122:1acf:b0:516:24c4:963d with SMTP id
 71dfb90a1353d-51c6c4303e1mr16976426e0c.2.1736737912056; Sun, 12 Jan 2025
 19:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20241108110147.11178-1-jason.chien@sifive.com>
In-Reply-To: <20241108110147.11178-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 13:11:26 +1000
X-Gm-Features: AbW1kvZAI1NIlZGEPzDBArV7MfmKAUJHllFWgIkT3fINRjzfzhUMMIcgMTLqaNk
Message-ID: <CAKmqyKP1SbJ0Mtuyigb0mK+HaKeUAoCy+9xroBa8OY8-oGi_yA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: Introduce a translation tag for
 the page table cache
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Fri, Nov 8, 2024 at 9:03=E2=80=AFPM Jason Chien <jason.chien@sifive.com>=
 wrote:
>
> This commit introduces a translation tag to avoid invalidating an entry
> that should not be invalidated when IOMMU executes invalidation commands.
> E.g. IOTINVAL.VMA with GV=3D0, AV=3D0, PSCV=3D1 invalidates both a mappin=
g
> of single stage translation and a mapping of nested translation with
> the same PSCID, but only the former one should be invalidated.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 205 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 153 insertions(+), 52 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index ff9deefe37..ac6bbf91d6 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -64,8 +64,16 @@ struct RISCVIOMMUContext {
>      uint64_t msiptp;            /* MSI redirection page table pointer */
>  };
>
> +typedef enum RISCVIOMMUTransTag {
> +    RISCV_IOMMU_TRANS_TAG_BY,  /* Bypass */
> +    RISCV_IOMMU_TRANS_TAG_SS,  /* Single Stage */
> +    RISCV_IOMMU_TRANS_TAG_VG,  /* G-stage only */
> +    RISCV_IOMMU_TRANS_TAG_VN,  /* Nested translation */
> +} RISCVIOMMUTransTag;
> +
>  /* Address translation cache entry */
>  struct RISCVIOMMUEntry {
> +    RISCVIOMMUTransTag tag;     /* Translation Tag */
>      uint64_t iova:44;           /* IOVA Page Number */
>      uint64_t pscid:20;          /* Process Soft-Context identifier */
>      uint64_t phys:44;           /* Physical Page Number */
> @@ -1228,7 +1236,7 @@ static gboolean riscv_iommu_iot_equal(gconstpointer=
 v1, gconstpointer v2)
>      RISCVIOMMUEntry *t1 =3D (RISCVIOMMUEntry *) v1;
>      RISCVIOMMUEntry *t2 =3D (RISCVIOMMUEntry *) v2;
>      return t1->gscid =3D=3D t2->gscid && t1->pscid =3D=3D t2->pscid &&
> -           t1->iova =3D=3D t2->iova;
> +           t1->iova =3D=3D t2->iova && t1->tag =3D=3D t2->tag;
>  }
>
>  static guint riscv_iommu_iot_hash(gconstpointer v)
> @@ -1237,67 +1245,115 @@ static guint riscv_iommu_iot_hash(gconstpointer =
v)
>      return (guint)t->iova;
>  }
>
> -/* GV: 1 PSCV: 1 AV: 1 */
> +/* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
> +/* GV: 0 AV: 0 GVMA: 1 */
> +static
> +void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer da=
ta)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->tag =3D=3D arg->tag) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
> +static
> +void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointer =
data)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->tag =3D=3D arg->tag &&
> +        iot->pscid =3D=3D arg->pscid) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
> +static
> +void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer d=
ata)
> +{
> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->tag =3D=3D arg->tag &&
> +        iot->iova =3D=3D arg->iova) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
>  static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer valu=
e,
>                                               gpointer data)
>  {
>      RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
>      RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> -    if (iot->gscid =3D=3D arg->gscid &&
> +    if (iot->tag =3D=3D arg->tag &&
>          iot->pscid =3D=3D arg->pscid &&
>          iot->iova =3D=3D arg->iova) {
>          iot->perm =3D IOMMU_NONE;
>      }
>  }
>
> -/* GV: 1 PSCV: 1 AV: 0 */
> -static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
> -                                        gpointer data)
> +/* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
> +/* GV: 1 AV: 0 GVMA: 1 */
> +static
> +void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointer =
data)
>  {
>      RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
>      RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> -    if (iot->gscid =3D=3D arg->gscid &&
> -        iot->pscid =3D=3D arg->pscid) {
> +    if (iot->tag =3D=3D arg->tag &&
> +        iot->gscid =3D=3D arg->gscid) {
>          iot->perm =3D IOMMU_NONE;
>      }
>  }
>
> -/* GV: 1 GVMA: 1 */
> -static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer value=
,
> -                                            gpointer data)
> +/* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
> +static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer val=
ue,
> +                                              gpointer data)
>  {
>      RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
>      RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> -    if (iot->gscid =3D=3D arg->gscid) {
> -        /* simplified cache, no GPA matching */
> +    if (iot->tag =3D=3D arg->tag &&
> +        iot->gscid =3D=3D arg->gscid &&
> +        iot->pscid =3D=3D arg->pscid) {
>          iot->perm =3D IOMMU_NONE;
>      }
>  }
>
> -/* GV: 1 GVMA: 0 */
> -static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
> -                                        gpointer data)
> +/* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
> +/* GV: 1 AV: 1 GVMA: 1 */
> +static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer valu=
e,
> +                                             gpointer data)
>  {
>      RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
>      RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> -    if (iot->gscid =3D=3D arg->gscid) {
> +    if (iot->tag =3D=3D arg->tag &&
> +        iot->gscid =3D=3D arg->gscid &&
> +        iot->iova =3D=3D arg->iova) {
>          iot->perm =3D IOMMU_NONE;
>      }
>  }
>
> -/* GV: 0 */
> -static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,
> -                                      gpointer data)
> +/* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
> +static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointe=
r value,
> +                                                   gpointer data)
>  {
>      RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> -    iot->perm =3D IOMMU_NONE;
> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> +    if (iot->tag =3D=3D arg->tag &&
> +        iot->gscid =3D=3D arg->gscid &&
> +        iot->pscid =3D=3D arg->pscid &&
> +        iot->iova =3D=3D arg->iova) {
> +        iot->perm =3D IOMMU_NONE;
> +    }
>  }
>
>  /* caller should keep ref-count for iot_cache object */
>  static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
> -    GHashTable *iot_cache, hwaddr iova)
> +    GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
>  {
>      RISCVIOMMUEntry key =3D {
> +        .tag   =3D transtag,
>          .gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
>          .pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
>          .iova  =3D PPN_DOWN(iova),
> @@ -1323,10 +1379,11 @@ static void riscv_iommu_iot_update(RISCVIOMMUStat=
e *s,
>  }
>
>  static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
> -    uint32_t gscid, uint32_t pscid, hwaddr iova)
> +    uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag tran=
stag)
>  {
>      GHashTable *iot_cache;
>      RISCVIOMMUEntry key =3D {
> +        .tag =3D transtag,
>          .gscid =3D gscid,
>          .pscid =3D pscid,
>          .iova  =3D PPN_DOWN(iova),
> @@ -1337,9 +1394,24 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState =
*s, GHFunc func,
>      g_hash_table_unref(iot_cache);
>  }
>
> +static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ct=
x)
> +{
> +    uint64_t satp =3D get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    uint64_t gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    if (satp =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE) {
> +        return (gatp =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
> +            RISCV_IOMMU_TRANS_TAG_BY : RISCV_IOMMU_TRANS_TAG_VG;
> +    } else {
> +        return (gatp =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
> +            RISCV_IOMMU_TRANS_TAG_SS : RISCV_IOMMU_TRANS_TAG_VN;
> +    }
> +}
> +
>  static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
>      IOMMUTLBEntry *iotlb, bool enable_cache)
>  {
> +    RISCVIOMMUTransTag transtag =3D riscv_iommu_get_transtag(ctx);
>      RISCVIOMMUEntry *iot;
>      IOMMUAccessFlags perm;
>      bool enable_pid;
> @@ -1365,7 +1437,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>          }
>      }
>
> -    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
> +    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag=
);
>      perm =3D iot ? iot->perm : IOMMU_NONE;
>      if (perm !=3D IOMMU_NONE) {
>          iotlb->translated_addr =3D PPN_PHYS(iot->phys);
> @@ -1396,6 +1468,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>          iot->gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID=
);
>          iot->pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
>          iot->perm =3D iotlb->perm;
> +        iot->tag =3D transtag;
>          riscv_iommu_iot_update(s, iot_cache, iot);
>      }
>
> @@ -1603,44 +1676,72 @@ static void riscv_iommu_process_cq_tail(RISCVIOMM=
UState *s)
>
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
>                               RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> -            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> +        {
> +            bool gv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
> +            bool av =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
> +            bool pscv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)=
;
> +            uint32_t gscid =3D get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> +            uint32_t pscid =3D get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID);
> +            hwaddr iova =3D (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> +
> +            if (pscv) {
>                  /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=3D=
 1 */
>                  goto cmd_ill;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> -                /* invalidate all cache mappings */
> -                func =3D riscv_iommu_iot_inval_all;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> -                /* invalidate cache matching GSCID */
> -                func =3D riscv_iommu_iot_inval_gscid;
> -            } else {
> -                /* invalidate cache matching GSCID and ADDR (GPA) */
> -                func =3D riscv_iommu_iot_inval_gscid_gpa;
>              }
> -            riscv_iommu_iot_inval(s, func,
> -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0=
,
> -                cmd.dword1 << 2 & TARGET_PAGE_MASK);
> +
> +            func =3D riscv_iommu_iot_inval_all;
> +
> +            if (gv) {
> +                func =3D (av) ? riscv_iommu_iot_inval_gscid_iova :
> +                              riscv_iommu_iot_inval_gscid;
> +            }
> +
> +            riscv_iommu_iot_inval(
> +                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
> +
> +            riscv_iommu_iot_inval(
> +                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
>              break;
> +        }
>
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
>                               RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> -            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> -                /* invalidate all cache mappings, simplified model */
> -                func =3D riscv_iommu_iot_inval_all;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
> -                /* invalidate cache matching GSCID, simplified model */
> -                func =3D riscv_iommu_iot_inval_gscid;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> -                /* invalidate cache matching GSCID and PSCID */
> -                func =3D riscv_iommu_iot_inval_pscid;
> +        {
> +            bool gv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
> +            bool av =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
> +            bool pscv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)=
;
> +            uint32_t gscid =3D get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> +            uint32_t pscid =3D get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID);
> +            hwaddr iova =3D (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> +            RISCVIOMMUTransTag transtag;
> +
> +            if (gv) {
> +                transtag =3D RISCV_IOMMU_TRANS_TAG_VN;
> +                if (pscv) {
> +                    func =3D (av) ? riscv_iommu_iot_inval_gscid_pscid_io=
va :
> +                                  riscv_iommu_iot_inval_gscid_pscid;
> +                } else {
> +                    func =3D (av) ? riscv_iommu_iot_inval_gscid_iova :
> +                                  riscv_iommu_iot_inval_gscid;
> +                }
>              } else {
> -                /* invalidate cache matching GSCID and PSCID and ADDR (I=
OVA) */
> -                func =3D riscv_iommu_iot_inval_pscid_iova;
> +                transtag =3D RISCV_IOMMU_TRANS_TAG_SS;
> +                if (pscv) {
> +                    func =3D (av) ? riscv_iommu_iot_inval_pscid_iova :
> +                                  riscv_iommu_iot_inval_pscid;
> +                } else {
> +                    func =3D (av) ? riscv_iommu_iot_inval_iova :
> +                                  riscv_iommu_iot_inval_all;
> +                }
>              }
> -            riscv_iommu_iot_inval(s, func,
> -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
> -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
> -                cmd.dword1 << 2 & TARGET_PAGE_MASK);
> +
> +            riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag)=
;
>              break;
> +        }
>
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
>                               RISCV_IOMMU_CMD_IODIR_OPCODE):
> --
> 2.43.2
>
>

