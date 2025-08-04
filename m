Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06BBC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0Op-00033L-33; Mon, 04 Aug 2025 14:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1uiyru-0006Ki-2H; Mon, 04 Aug 2025 13:21:10 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1uiyrr-0002zd-Or; Mon, 04 Aug 2025 13:21:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id CE381A55AC0;
 Mon,  4 Aug 2025 17:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD25C4CEF0;
 Mon,  4 Aug 2025 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754328057;
 bh=/O94JxY0PWBN10GfLeccl4/F0n+V5sp/rtGnumMSR8w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DiW7wr8XwdtJyK/6/dp3KtVv3n5FkkVaRwHHV4i3Njf7ffKiRG8Jht2qA1cAZjHh6
 pKbdah/NLSOPT+GLP94JRrDNWKkI6I6ZhJZBoO1ZfcVkY51vvjy9D57FqsDpQlQ8US
 SR4HwhBSxBEmJLgf+tOGY2X4UPgT1o3vSMvkZlEAifOnQKwIQFSsg7ndw6R5+XwYLn
 cbRlluChytZI8WZ4oruxZ7iVUEw+sUyaofIIwvob2o7LokPZjAgcXc5VqGyh59wwQJ
 tU7IIjYkIFswURMmvryKyn0IktoogXOUb2EA+U3Xrs6Xy7ANUOf5dJCu50eZmdGpzH
 JcfY6xxJ5y1PA==
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so9413225e9.2; 
 Mon, 04 Aug 2025 10:20:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtT0fihQQDqy8WuWAkZL5fm0HGLre09Xvja+kOrV456gT4WJ5hHjHXmzwRV3QEAZ+SSZycy6v3aGjVCJY=@nongnu.org,
 AJvYcCW3iGnQ3qUrNbF87gB0UIEY670XpgqbGRywaH+OtLwqffXJivmhBeXBsJhihbuUzjqLO1YHibTZDsUi@nongnu.org
X-Gm-Message-State: AOJu0Ywsr40O9kFdy49WjcYIgArAdX9i94Z/TwbYyJggdh/EU76ff1+5
 oyVbVhPaXN+8gdrJz2CKe5FrVvaNpMIp30kH54piFjbKdpZCMVczCHef2Grzvzfl8X3bdbdy6hc
 jeh49iZDdn6Jab4Mpf8FNX/VN9bgFqAk=
X-Google-Smtp-Source: AGHT+IEj9VpRULkoKJD8J7ftFr6vjet+abO2j4+ipUhwuvRstLUuaMF06JX8nPMWzSimX+VV6apGd66FUPk+VJ+pGvI=
X-Received: by 2002:a05:600c:4445:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-458b6b421efmr68825025e9.24.1754328055956; Mon, 04 Aug 2025
 10:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250803044338.4098505-1-guoren@kernel.org>
In-Reply-To: <20250803044338.4098505-1-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 5 Aug 2025 01:20:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR5rOgt-4F0hF3R0yxQ9BUsLUH2wYkV36zEnXTVs8af=g@mail.gmail.com>
X-Gm-Features: Ac12FXyGlP3YtH2uZ5MRl_v2B-OYfl7bX1VHzi0tauDvOavxdrLKBdRmu4oLMr0
Message-ID: <CAJF2gTR5rOgt-4F0hF3R0yxQ9BUsLUH2wYkV36zEnXTVs8af=g@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
To: zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 alistair.francis@wdc.com, seb@rivosinc.com, tjeznach@rivosinc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=guoren@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update V2 for cleaner modification, less code influence:
https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00738.html

On Sun, Aug 3, 2025 at 12:47=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Current implementation is wrong when iohgatp !=3D bare. The RISC-V
> IOMMU specification has defined that the PDT is based on GPA, not
> SPA. So this patch fixes the problem, making PDT walk correctly
> when the G-stage table walk is enabled.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Cc: qemu-stable@nongnu.org
> Cc: Sebastien Boeuf <seb@rivosinc.com>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  hw/riscv/riscv-iommu.c | 148 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 96a7fbdefcf3..c4dccc9e5c5d 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -866,6 +866,145 @@ static bool riscv_iommu_validate_process_ctx(RISCVI=
OMMUState *s,
>      return true;
>  }
>
> +/**
> + * pdt_memory_read: PDT wrapper of dma_memory_read.
> + *
> + * @s: IOMMU Device State
> + * @ctx: Device Translation Context with devid and pasid set
> + * nested: Add G-stage translation or not
> + * @addr: address within that address space
> + * @buf: buffer with the data transferred
> + * @len: length of the data transferred
> + * @attrs: memory transaction attributes
> + */
> +static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
> +                                   RISCVIOMMUContext *ctx, bool nested,
> +                                   dma_addr_t addr,
> +                                   void *buf, dma_addr_t len,
> +                                   MemTxAttrs attrs)
> +{
> +    uint64_t gatp_mode, pte;
> +    struct {
> +        unsigned char step;
> +        unsigned char levels;
> +        unsigned char ptidxbits;
> +        unsigned char ptesize;
> +    } sc;
> +    MemTxResult ret;
> +    dma_addr_t base =3D addr;
> +
> +    if (!nested)
> +        goto out;
> +
> +    /* G stages translation mode */
> +    gatp_mode =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    /* G stages translation tables root pointer */
> +    base =3D PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +
> +    /* Start at step 0 */
> +    sc.step =3D 0;
> +
> +    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
> +        /* 32bit mode for GXL =3D=3D 1 */
> +        switch (gatp_mode) {
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 2;
> +            sc.ptidxbits =3D 10;
> +            sc.ptesize   =3D 4;
> +            break;
> +        default:
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +    } else {
> +        /* 64bit mode for GXL =3D=3D 0 */
> +        switch (gatp_mode) {
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 3;
> +            sc.ptidxbits =3D 9;
> +            sc.ptesize   =3D 8;
> +            break;
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 4;
> +            sc.ptidxbits =3D 9;
> +            sc.ptesize   =3D 8;
> +            break;
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 5;
> +            sc.ptidxbits =3D 9;
> +            sc.ptesize   =3D 8;
> +            break;
> +        default:
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +    }
> +
> +    do {
> +        const unsigned va_bits =3D (sc.step ? 0 : 2) + sc.ptidxbits;
> +        const unsigned va_skip =3D TARGET_PAGE_BITS + sc.ptidxbits *
> +                                 (sc.levels - 1 - sc.step);
> +        const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr =3D base + idx * sc.ptesize;
> +
> +        /* Address range check before first level lookup */
> +        if (!sc.step) {
> +            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) - 1=
;
> +            if ((addr & va_mask) !=3D addr) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (sc.ptesize =3D=3D 4) {
> +            uint32_t pte32 =3D 0;
> +            ret =3D ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
> +            pte =3D pte32;
> +        } else {
> +            ret =3D ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
> +        }
> +        if (ret !=3D MEMTX_OK)
> +            return ret;
> +
> +        sc.step++;
> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> +
> +        if (!(pte & PTE_V)) {
> +            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D PTE_W) {
> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W=
 */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE_X=
)) {
> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W=
 + PTE_X */
> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            base =3D PPN_PHYS(ppn); /* Inner PTE, continue walking */
> +        } else {
> +            /* Leaf PTE, translation completed. */
> +            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            break;
> +        }
> +
> +        if (sc.step =3D=3D sc.levels) {
> +            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
> +        }
> +    } while (1);
> +
> +out:
> +    return dma_memory_read(s->target_as, base, buf, len, attrs);
> +}
> +
>  /*
>   * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
>   *
> @@ -884,6 +1023,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx)
>      const size_t dc_len =3D sizeof(dc) >> dc_fmt;
>      int depth;
>      uint64_t de;
> +    bool pdt_nested =3D false;
>
>      switch (mode) {
>      case RISCV_IOMMU_DDTP_MODE_OFF:
> @@ -1029,6 +1169,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx)
>          return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
>      }
>
> +    /* Detect nested PDT walk */
> +    pdt_nested =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD) !=3D
> +                 RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> +
>      for (depth =3D mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0;=
 ) {
>          riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
>
> @@ -1038,7 +1182,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>           */
>          const int split =3D depth * 9 + 8;
>          addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
> -        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +        if (pdt_memory_read(s, ctx, pdt_nested, addr, &de, sizeof(de),
>                              MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>              return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>          }
> @@ -1053,7 +1197,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>
>      /* Leaf entry in PDT */
>      addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> -    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2=
,
> +    if (pdt_memory_read(s, ctx, pdt_nested, addr, &dc.ta, sizeof(uint64_=
t) * 2,
>                          MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>          return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>      }
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren

