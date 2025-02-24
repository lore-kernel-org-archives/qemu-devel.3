Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9811CC021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOYr-00076h-88; Sun, 23 Feb 2025 21:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOYl-000766-9E; Sun, 23 Feb 2025 21:51:08 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOYW-0000RY-5a; Sun, 23 Feb 2025 21:50:57 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4be75b2bbceso1358184137.1; 
 Sun, 23 Feb 2025 18:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740365450; x=1740970250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gljU5+/MICubOqQzFeJyL/Hg/2BWvIR3UdAEdy4wVwE=;
 b=ZhQy24mmWj7684iC9VbomWa8hQVYsTb67ldUQpg6pBfFkfTL/121WgVraQA0dGNDO+
 a1CSBVI1T1XQoO3dQx20ocN7TwrIUAEiSBWXWyeZ9RqqRvBJbMOlxVi5XHYJIFuyWx9x
 ZyufE0CIHoWSceU1sIB6XuMbLXwPHzQQuycgnCX09iqbNLHOrpYpxWotSeY7R4retMVM
 vZaxcchbQzajS8cw6PqAV6u/sBwjZfatuhTK0yJ3vHsgOadJWreHcdrqPxSYz+jtEjD+
 yl+hMhpo3Jj4gIwY+HvR5y5TUJbmPzf2ZmEq5FMuCajfn/sPSs26wY7/LEbbVj9a6XJ5
 tdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740365450; x=1740970250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gljU5+/MICubOqQzFeJyL/Hg/2BWvIR3UdAEdy4wVwE=;
 b=GAg+59RykcdJTzlM4JCYHHgAnmlAKu1TTsNVBwmZNvG8OTgcYm/kBJjk3++H60Kd6P
 SnC+NK//CH/5VTzZPwGh9A3v+o5j9anzHEyITR054iXFAda9F7k2Goc3AGsqj4AXZu/R
 YsT89wU2wsNtl3ygaANlD9U+YyYprnG/vq2YnEEkzUuFADwQ9fScxtl8kCJf3pjCGHq6
 ByRH5z/qfxBrOo6M33RGozU7G0abURvP3WPfremC2l4Oh9+vh7wimvlh5XE/UovaDYPA
 TXHXTQIqxUa80TLV4oQu77zOB3Mm5jK9LT+5/zF3bOPo1t+SQdYKYuIUi+dXu2L0MY1H
 1tQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIy65u3ZzDvi2SqlqWaYHseSL/r2oFxjFdb/54FYLqFLQxyRwu8xnrSlf9dQRS6BJlug0b/BpnMefP@nongnu.org
X-Gm-Message-State: AOJu0YzXZyb0D9Vsvl9BKJl8FnoJmhG6cKRXvLhRth8wg0w6Es8hjwDn
 VShy6lfYKviqO/oIyaUXU1ycYl7MLicHNMUjF6dRXj+jmRvDYC+R5r6LOz0q7vWqIxkefVyzfyh
 sHRFX/IC9lBYEwJPBB91qwLFjYto=
X-Gm-Gg: ASbGncuEp1v7/L2rfs+IVCzcYCC+cPF2Nd1f367S+s173Zvj6qPH5lxjOyFCWKEq46U
 832ueVa3kJwxjhreXTyJOeERG+3XUjm93Y6XshKL/X+FnQxsZJFshX3tSrHiTMYrbsdbdDmoZF1
 x+49PUQyhUyOlg8YmGVyMV+q3ImvAEPCbqLdEa
X-Google-Smtp-Source: AGHT+IEgNjXQ23GtjThXFcLXtNPuJ+iAbpjAXmIKsu/ZqzHMlyb1PPlFW0cVSRJVWSKkVggnCSDW/27oRd/7EvMR8XI=
X-Received: by 2002:a05:6102:2b96:b0:4bb:4c52:6730 with SMTP id
 ada2fe7eead31-4bfc27ed544mr5666238137.12.1740365450370; Sun, 23 Feb 2025
 18:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-5-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 12:50:24 +1000
X-Gm-Features: AWEUYZnNeRG59nH6JPbf9shkEjN6vdLfJ-AY0vY64gfJMne_ziwua98QuwMF5dw
Message-ID: <CAKmqyKP9Rm0LVPMS4WDxYB-Rm=+Angf9He3ph2xAbZyVDF5rGQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 04/11] hw/riscv/riscv-iommu: add
 riscv_iommu_hpm_incr_ctr()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Thu, Dec 5, 2024 at 11:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> This function will increment a specific counter, generating an interrupt
> when an overflow occurs.
>
> Some extra changes in riscv-iommu.c  were required to add this new
> helper in riscv-iommu-hpm.c:
>
> - RISCVIOMMUContext was moved to riscv-iommu.h, making it visible in
>   riscv-iommu-hpm.c;
>
> - riscv_iommu_notify() is now public.
>
> No behavior change is made since HPM support is not being advertised
> yet.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 114 +++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h |   2 +
>  hw/riscv/riscv-iommu.c     |  43 +++++++++-----
>  hw/riscv/riscv-iommu.h     |  18 ++++++
>  4 files changed, 162 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 5833ab8956..8eca5ee17e 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -52,3 +52,117 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s=
)
>      return (ctr_val + get_cycles() - ctr_prev) |
>          (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
>  }
> +
> +static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t ctr_idx)
> +{
> +    const uint32_t off =3D ctr_idx << 3;
> +    uint64_t cntr_val;
> +
> +    cntr_val =3D ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + of=
f]);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val =
+ 1);
> +
> +    /* Handle the overflow scenario. */
> +    if (cntr_val =3D=3D UINT64_MAX) {
> +        /*
> +         * Generate interrupt only if OF bit is clear. +1 to offset the =
cycle
> +         * register OF bit.
> +         */
> +        const uint32_t ovf =3D
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IOCOUNTOVF,
> +                                  BIT(ctr_idx + 1), 0);
> +        if (!get_field(ovf, BIT(ctr_idx + 1))) {
> +            riscv_iommu_reg_mod64(s,
> +                                  RISCV_IOMMU_REG_IOHPMEVT_BASE + off,
> +                                  RISCV_IOMMU_IOHPMEVT_OF,
> +                                  0);
> +            riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
> +        }
> +    }
> +}
> +
> +void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx=
,
> +                              unsigned event_id)
> +{
> +    const uint32_t inhibit =3D riscv_iommu_reg_get32(
> +        s, RISCV_IOMMU_REG_IOCOUNTINH);
> +    uint32_t did_gscid;
> +    uint32_t pid_pscid;
> +    uint32_t ctr_idx;
> +    gpointer value;
> +    uint32_t ctrs;
> +    uint64_t evt;
> +
> +    if (!(s->cap & RISCV_IOMMU_CAP_HPM)) {
> +        return;
> +    }
> +
> +    value =3D g_hash_table_lookup(s->hpm_event_ctr_map,
> +                                GUINT_TO_POINTER(event_id));
> +    if (value =3D=3D NULL) {
> +        return;
> +    }
> +
> +    for (ctrs =3D GPOINTER_TO_UINT(value); ctrs !=3D 0; ctrs &=3D ctrs -=
 1) {
> +        ctr_idx =3D ctz32(ctrs);
> +        if (get_field(inhibit, BIT(ctr_idx + 1))) {
> +            continue;
> +        }
> +
> +        evt =3D riscv_iommu_reg_get64(s,
> +            RISCV_IOMMU_REG_IOHPMEVT_BASE + (ctr_idx << 3));
> +
> +        /*
> +         * It's quite possible that event ID has been changed in counter
> +         * but hashtable hasn't been updated yet. We don't want to incre=
ment
> +         * counter for the old event ID.
> +         */
> +        if (event_id !=3D get_field(evt, RISCV_IOMMU_IOHPMEVT_EVENT_ID))=
 {
> +            continue;
> +        }
> +
> +        if (get_field(evt, RISCV_IOMMU_IOHPMEVT_IDT)) {
> +            did_gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GS=
CID);
> +            pid_pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
> +        } else {
> +            did_gscid =3D ctx->devid;
> +            pid_pscid =3D ctx->process_id;
> +        }
> +
> +        if (get_field(evt, RISCV_IOMMU_IOHPMEVT_PV_PSCV)) {
> +            /*
> +             * If the transaction does not have a valid process_id, coun=
ter
> +             * increments if device_id matches DID_GSCID. If the transac=
tion
> +             * has a valid process_id, counter increments if device_id
> +             * matches DID_GSCID and process_id matches PID_PSCID. See
> +             * IOMMU Specification, Chapter 5.23. Performance-monitoring
> +             * event selector.
> +             */
> +            if (ctx->process_id &&
> +                get_field(evt, RISCV_IOMMU_IOHPMEVT_PID_PSCID) !=3D pid_=
pscid) {
> +                continue;
> +            }
> +        }
> +
> +        if (get_field(evt, RISCV_IOMMU_IOHPMEVT_DV_GSCV)) {
> +            uint32_t mask =3D ~0;
> +
> +            if (get_field(evt, RISCV_IOMMU_IOHPMEVT_DMASK)) {
> +                /*
> +                 * 1001 1011   mask =3D GSCID
> +                 * 0000 0111   mask =3D mask ^ (mask + 1)
> +                 * 1111 1000   mask =3D ~mask;
> +                 */
> +                mask =3D get_field(evt, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
> +                mask =3D mask ^ (mask + 1);
> +                mask =3D ~mask;
> +            }
> +
> +            if ((get_field(evt, RISCV_IOMMU_IOHPMEVT_DID_GSCID) & mask) =
!=3D
> +                (did_gscid & mask)) {
> +                continue;
> +            }
> +        }
> +
> +        hpm_incr_ctr(s, ctr_idx);
> +    }
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> index 231c110ff2..411d869dce 100644
> --- a/hw/riscv/riscv-iommu-hpm.h
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -23,5 +23,7 @@
>  #include "hw/riscv/riscv-iommu.h"
>
>  uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
> +void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx=
,
> +                              unsigned event_id);
>
>  #endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 01df25418c..5ce0d24359 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -39,7 +39,6 @@
>  #define PPN_PHYS(ppn)                 ((ppn) << TARGET_PAGE_BITS)
>  #define PPN_DOWN(phy)                 ((phy) >> TARGET_PAGE_BITS)
>
> -typedef struct RISCVIOMMUContext RISCVIOMMUContext;
>  typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
>
>  /* Device assigned I/O address space */
> @@ -52,19 +51,6 @@ struct RISCVIOMMUSpace {
>      QLIST_ENTRY(RISCVIOMMUSpace) list;
>  };
>
> -/* Device translation context state. */
> -struct RISCVIOMMUContext {
> -    uint64_t devid:24;          /* Requester Id, AKA device_id */
> -    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
> -    uint64_t tc;                /* Translation Control */
> -    uint64_t ta;                /* Translation Attributes */
> -    uint64_t satp;              /* S-Stage address translation and prote=
ction */
> -    uint64_t gatp;              /* G-Stage address translation and prote=
ction */
> -    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> -    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> -    uint64_t msiptp;            /* MSI redirection page table pointer */
> -};
> -
>  /* Address translation cache entry */
>  struct RISCVIOMMUEntry {
>      uint64_t iova:44;           /* IOVA Page Number */
> @@ -93,7 +79,7 @@ static uint8_t riscv_iommu_get_icvec_vector(uint32_t ic=
vec, uint32_t vec_type)
>      }
>  }
>
> -static void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
> +void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
>  {
>      uint32_t ipsr, icvec, vector;
>
> @@ -415,6 +401,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>              }
>          }
>
> +
> +        if (pass =3D=3D S_STAGE) {
> +            riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_S_VS_W=
ALKS);
> +        } else {
> +            riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_G_WALK=
S);
> +        }
> +
>          /* Read page table entry */
>          if (sc[pass].ptesize =3D=3D 4) {
>              uint32_t pte32 =3D 0;
> @@ -933,6 +926,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>
>      /* Device directory tree walk */
>      for (; depth-- > 0; ) {
> +        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_DD_WALK);
>          /*
>           * Select device id index bits based on device directory tree le=
vel
>           * and device context format.
> @@ -960,6 +954,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>          addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
>      }
>
> +    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_DD_WALK);
> +
>      /* index into device context entry page */
>      addr |=3D (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
>
> @@ -1025,6 +1021,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>      }
>
>      for (depth =3D mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0;=
 ) {
> +        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
> +
>          /*
>           * Select process id index bits based on process directory tree
>           * level. See IOMMU Specification, 2.2. Process-Directory-Table.
> @@ -1042,6 +1040,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>          addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
>      }
>
> +    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
> +
>      /* Leaf entry in PDT */
>      addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
>      if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2=
,
> @@ -1347,6 +1347,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>      GHashTable *iot_cache;
>      int fault;
>
> +    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
> +
>      iot_cache =3D g_hash_table_ref(s->iot_cache);
>      /*
>       * TC[32] is reserved for custom extensions, used here to temporaril=
y
> @@ -1357,6 +1359,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>
>      /* Check for ATS request. */
>      if (iotlb->perm =3D=3D IOMMU_NONE) {
> +        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_ATS_RQ);
>          /* Check if ATS is disabled. */
>          if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
>              enable_pri =3D false;
> @@ -1375,6 +1378,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>          goto done;
>      }
>
> +    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
> +
>      /* Translate using device directory / page table information. */
>      fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
>
> @@ -2274,6 +2279,10 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>      memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_op=
s, s,
>              "riscv-iommu-trap", ~0ULL);
>      address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
> +
> +    if (s->cap & RISCV_IOMMU_CAP_HPM) {
> +        s->hpm_event_ctr_map =3D g_hash_table_new(g_direct_hash, g_direc=
t_equal);
> +    }
>  }
>
>  static void riscv_iommu_unrealize(DeviceState *dev)
> @@ -2282,6 +2291,10 @@ static void riscv_iommu_unrealize(DeviceState *dev=
)
>
>      g_hash_table_unref(s->iot_cache);
>      g_hash_table_unref(s->ctx_cache);
> +
> +    if (s->cap & RISCV_IOMMU_CAP_HPM) {
> +        g_hash_table_unref(s->hpm_event_ctr_map);
> +    }
>  }
>
>  void riscv_iommu_reset(RISCVIOMMUState *s)
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 380f7e81d1..a21ab51491 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -90,12 +90,30 @@ struct RISCVIOMMUState {
>      /* HPM cycle counter */
>      uint64_t hpmcycle_val;      /* Current value of cycle register */
>      uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clo=
ck */
> +
> +    /* HPM event counters */
> +    GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
>  };
>
>  void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>           Error **errp);
>  void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mo=
de);
>  void riscv_iommu_reset(RISCVIOMMUState *s);
> +void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
> +
> +typedef struct RISCVIOMMUContext RISCVIOMMUContext;
> +/* Device translation context state. */
> +struct RISCVIOMMUContext {
> +    uint64_t devid:24;          /* Requester Id, AKA device_id */
> +    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
> +    uint64_t tc;                /* Translation Control */
> +    uint64_t ta;                /* Translation Attributes */
> +    uint64_t satp;              /* S-Stage address translation and prote=
ction */
> +    uint64_t gatp;              /* G-Stage address translation and prote=
ction */
> +    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> +    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> +    uint64_t msiptp;            /* MSI redirection page table pointer */
> +};
>
>  /* private helpers */
>
> --
> 2.47.1
>
>

