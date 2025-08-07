Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66133C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 08:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujwA5-0003Iw-V5; Thu, 07 Aug 2025 04:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1ujwA3-0003D6-CK; Thu, 07 Aug 2025 04:39:43 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1ujwA1-0000FZ-9W; Thu, 07 Aug 2025 04:39:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 86DAA61416;
 Thu,  7 Aug 2025 08:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA1DC4CEEB;
 Thu,  7 Aug 2025 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754555976;
 bh=Jse1gpWHluJy41BzNaPv/FyMKFrtWkgI7QPflwXaAH4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gcrk1f0EdiKfg3AxP7AMWpwWp3KDNCx/6ITkLlXTnTZIAuQiiyUygT6x2gj0gu3GK
 1RaTUupY4OYV9T8C/xyhwqtTqtyHiVjAAjpYfUFcje8Tw+CxxRs4Nuy4A2W9/Be555
 tcYqaTQ06FNGRQNX3E78c5z8O2Sjywc1FAGWH0hDNIN1Dz6OPLdPbjaMKfY+f4csrB
 p/NeMteBKWEol7dmfUa/QUqMVREoNXCYdC7ytuuc4WHlgZhs3SihyDegrcIpGWPUEU
 evujIJ+feXMBwBa680EPFWPAUY2V6HLeZgAUvnOGf0wGTzZnntRk/3hxBvHjFGLR3l
 Xkrz1O9vlouXw==
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so4760895e9.1; 
 Thu, 07 Aug 2025 01:39:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVShQSKbj3QSr+cvxHylDPq22d48XfL+G3H8WLERESlzBfySBQvGPjOhSpbKHXVM39YIRxbYVhfs07freA=@nongnu.org,
 AJvYcCVgdlwbql1Yx0oGq2PGA7OIK41oNNtiHevkqEV377TgOXcnob1HIab46dCme15VEKVAtvIAZ6/x6br9@nongnu.org,
 AJvYcCW+269g6dLnVEnlErTND6BepAfNyAPiLjQLGYmlzFc1/2bj5l/hj6jkQ1CdIno+wWUHR7rxVjB8uqPAvw==@nongnu.org
X-Gm-Message-State: AOJu0YzEEodpQrnK4mwI220l9IXPYv+pGrQwEneJIkrtOmyISfmD2Rey
 JHOQDZ8QQbnX+72LogDyoV6GjpegUPG4gnRQUcPxJnuIW9z5Xf1ZHYQ9oqeNvKL9K6UZWI4gsZp
 F96eK+OiVga0GR8//+WPWbsl8uEaFopg=
X-Google-Smtp-Source: AGHT+IFpO3KMXWWaBdbB5hauDbUX/Cx9x4/r3GKnvRwm92GWtdHGPtvd2E5MOi3IvJJ6XanddB2iwiLx3WNU5e01SVs=
X-Received: by 2002:a05:600c:1548:b0:458:c002:6888 with SMTP id
 5b1f17b1804b1-459e7136631mr45793875e9.32.1754555974791; Thu, 07 Aug 2025
 01:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250804171238.354493-1-guoren@kernel.org>
 <524ac37c-cdd3-4010-aba9-9dacfdd123cc@lanxincomputing.com>
In-Reply-To: <524ac37c-cdd3-4010-aba9-9dacfdd123cc@lanxincomputing.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 7 Aug 2025 16:39:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTmZ1M=zJm6jx17PgU+na7Ckr_SnAxgbcPKfumzrLZC9Q@mail.gmail.com>
X-Gm-Features: Ac12FXylUlwrUbrzoDdD7K2o4KHrk8nbGyXV5V6EZ7dhE478-k2X58ImqRzCG7k
Message-ID: <CAJF2gTTmZ1M=zJm6jx17PgU+na7Ckr_SnAxgbcPKfumzrLZC9Q@mail.gmail.com>
Subject: Re: [PATCH V2] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
To: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 alistair.francis@wdc.com, seb@rivosinc.com, tjeznach@rivosinc.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=guoren@kernel.org; helo=tor.source.kernel.org
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

On Wed, Aug 6, 2025 at 4:58=E2=80=AFPM Nutty Liu <liujingqi@lanxincomputing=
.com> wrote:
>
> On 8/5/2025 1:12 AM, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > Current implementation is wrong when iohgatp !=3D bare. The RISC-V
> > IOMMU specification has defined that the PDT is based on GPA, not
> > SPA. So this patch fixes the problem, making PDT walk correctly
> > when the G-stage table walk is enabled.
> >
> > Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> > Cc: qemu-stable@nongnu.org
> > Cc: Sebastien Boeuf <seb@rivosinc.com>
> > Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> > Changes in V2:
> >   - Remove nested param to make patch clearer.
> >
> >   hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 139 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index 96a7fbdefcf3..ded3f7b2fdce 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -866,6 +866,143 @@ static bool riscv_iommu_validate_process_ctx(RISC=
VIOMMUState *s,
> >       return true;
> >   }
> >
> > +/**
> > + * pdt_memory_read: PDT wrapper of dma_memory_read.
> > + *
> > + * @s: IOMMU Device State
> > + * @ctx: Device Translation Context with devid and pasid set
> > + * @addr: address within that address space
> > + * @buf: buffer with the data transferred
> > + * @len: length of the data transferred
> > + * @attrs: memory transaction attributes
> > + */
> > +static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
> > +                                   RISCVIOMMUContext *ctx,
> > +                                   dma_addr_t addr,
> > +                                   void *buf, dma_addr_t len,
> > +                                   MemTxAttrs attrs)
> > +{
> > +    uint64_t gatp_mode, pte;
> > +    struct {
> > +        unsigned char step;
> > +        unsigned char levels;
> > +        unsigned char ptidxbits;
> > +        unsigned char ptesize;
> > +    } sc;
> > +    MemTxResult ret;
> > +    dma_addr_t base =3D addr;
> > +
> > +    /* G stages translation mode */
> > +    gatp_mode =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> > +    if (gatp_mode =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE)
> > +        goto out;
> > +
> > +    /* G stages translation tables root pointer */
> > +    base =3D PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD))=
;
> > +
> > +    /* Start at step 0 */
> > +    sc.step =3D 0;
> > +
> > +    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
> > +        /* 32bit mode for GXL =3D=3D 1 */
> > +        switch (gatp_mode) {
> > +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> > +            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
> > +                return MEMTX_ACCESS_ERROR;
> > +            }
> > +            sc.levels    =3D 2;
> > +            sc.ptidxbits =3D 10;
> > +            sc.ptesize   =3D 4;
> > +            break;
> > +        default:
> > +            return MEMTX_ACCESS_ERROR;
> > +        }
> > +    } else {
> > +        /* 64bit mode for GXL =3D=3D 0 */
> > +        switch (gatp_mode) {
> > +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> > +            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
> > +                return MEMTX_ACCESS_ERROR;
> > +            }
> > +            sc.levels    =3D 3;
> > +            sc.ptidxbits =3D 9;
> > +            sc.ptesize   =3D 8;
> > +            break;
> > +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> > +            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
> > +                return MEMTX_ACCESS_ERROR;
> > +            }
> > +            sc.levels    =3D 4;
> > +            sc.ptidxbits =3D 9;
> > +            sc.ptesize   =3D 8;
> > +            break;
> > +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> > +            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
> > +                return MEMTX_ACCESS_ERROR;
> > +            }
> > +            sc.levels    =3D 5;
> > +            sc.ptidxbits =3D 9;
> > +            sc.ptesize   =3D 8;
> > +            break;
> > +        default:
> > +            return MEMTX_ACCESS_ERROR;
> > +        }
> > +    }
> How about moving the variables of 'gatp_mode', 'base' and 'sc' out of
> this wrapper function ?
> Since all of them are the same except for 'sc.step' during the traversal
> of PDT.
This is a fixup patch, so I want to make the wrapper function handle
all the necessary tasks to minimize the impact on other code.
And the detection of them is low-cost, so no need to complicate the
coding convention.

>
> Otherwise,
> Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Thx.

>
> Thanks,
> Nutty
> > +
> > +    do {
> > +        const unsigned va_bits =3D (sc.step ? 0 : 2) + sc.ptidxbits;
> > +        const unsigned va_skip =3D TARGET_PAGE_BITS + sc.ptidxbits *
> > +                                 (sc.levels - 1 - sc.step);
> > +        const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1=
);
> > +        const dma_addr_t pte_addr =3D base + idx * sc.ptesize;
> > +
> > +        /* Address range check before first level lookup */
> > +        if (!sc.step) {
> > +            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) -=
 1;
> > +            if ((addr & va_mask) !=3D addr) {
> > +                return MEMTX_ACCESS_ERROR;
> > +            }
> > +        }
> > +
> > +        /* Read page table entry */
> > +        if (sc.ptesize =3D=3D 4) {
> > +            uint32_t pte32 =3D 0;
> > +            ret =3D ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
> > +            pte =3D pte32;
> > +        } else {
> > +            ret =3D ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
> > +        }
> > +        if (ret !=3D MEMTX_OK)
> > +            return ret;
> > +
> > +        sc.step++;
> > +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> > +
> > +        if (!(pte & PTE_V)) {
> > +            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
> > +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D PTE_W) {
> > +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE=
_W */
> > +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE=
_X)) {
> > +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE=
_W + PTE_X */
> > +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1))=
 {
> > +            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
> > +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> > +            base =3D PPN_PHYS(ppn); /* Inner PTE, continue walking */
> > +        } else {
> > +            /* Leaf PTE, translation completed. */
> > +            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> > +            break;
> > +        }
> > +
> > +        if (sc.step =3D=3D sc.levels) {
> > +            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
> > +        }
> > +    } while (1);
> > +
> > +out:
> > +    return dma_memory_read(s->target_as, base, buf, len, attrs);
> > +}
> > +
> >   /*
> >    * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
> >    *
> > @@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState =
*s, RISCVIOMMUContext *ctx)
> >            */
> >           const int split =3D depth * 9 + 8;
> >           addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MA=
SK;
> > -        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> > +        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
> >                               MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> >               return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> >           }
> > @@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState =
*s, RISCVIOMMUContext *ctx)
> >
> >       /* Leaf entry in PDT */
> >       addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> > -    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) *=
 2,
> > +    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
> >                           MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> >           return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> >       }



--=20
Best Regards
 Guo Ren

