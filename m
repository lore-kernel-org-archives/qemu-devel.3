Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34F2C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 08:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujwDh-00033d-6b; Thu, 07 Aug 2025 04:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1ujwDa-0002zo-D8; Thu, 07 Aug 2025 04:43:22 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1ujwDS-0000lb-Ns; Thu, 07 Aug 2025 04:43:20 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E4F1741568;
 Thu,  7 Aug 2025 08:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E75C4CEEB;
 Thu,  7 Aug 2025 08:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754556191;
 bh=qJ+T35Ge/B2hduhYA70dZJIbygamkAzMaTKZDm5coa8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CmFfqKSOQqfHTaecfU+Cte/L8Wz6U+RDBaHo2s4CDfkN59Lk7nHwGK24uJnJPQcpT
 W07oyv4YgxiBz11K7EmwYrs8Wn9a7yhWcKi3dyBDLmUpxmM5PUvchGQPKM6Z1XE5pB
 DNRJUpniwLVB8fu9+RFpn3Ym5RSDOski6m3cGmacUtAJwhNSeRtzGYdshK6Pi/uPo7
 aHZfTTvB+v4KQNyciI67FcJ9GMuWxsvP/Llxl/7ZFRPv2RvP9CHJxzwOgZEsct2P5X
 bLOQ0xCXI1Pg11g7v3Mr4LIyzLZmD3nM4L1k+Vo1fMR+RNGvNyBY8EOWXM7/ZzXDSA
 rK1rjwVIBbZxA==
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so391467f8f.1; 
 Thu, 07 Aug 2025 01:43:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU7WvCkKQS9abL6YxDK8oWceFfJTPUDS+ICAihfjD26GwKmXbNKqtu/ji5wneW3MCITv9YiVZLsMBtP4w==@nongnu.org,
 AJvYcCUqq4jJ9tcI4uruzXyzW38n6yzvUWxVFi/dLNcG1sPsGOJSe8V0tYFUM2MPZKN2Y7Kj6MjsFk4J+gtk@nongnu.org,
 AJvYcCWMy9pruSQZhW+cyrhf+ushfaBCmEiddvOfeNPj/0RJtR68fmJ3s2MW+a7M0iDDUv4Gh7r6GaJu5P9aM5k=@nongnu.org
X-Gm-Message-State: AOJu0YwAPu5ZUZXfQzLjS/D1U0XA0VnyhqLVFCQD1h7MbzqoNbckkHkP
 lOn1k/ubhkhTEe9NuQpO9fEoX0WFzUm2fk/MbgtA5KpmPYGSLZTIO1dMPUIWuxDigp5v+Zpjrup
 UvbP+d1XcZ0/xXiLku+Ao5MwLx4r6cNQ=
X-Google-Smtp-Source: AGHT+IEh4053lsgfaFDG8eVLBD4tFvA3uTBvMOiq+bU55wd3iLaaFI8gUSyE7feTLaLtXUHkuwUqWOvu8TNBdblKok8=
X-Received: by 2002:a05:6000:4313:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3b8f41a7e20mr5198590f8f.3.1754556190367; Thu, 07 Aug 2025
 01:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250804171238.354493-1-guoren@kernel.org>
 <CADCiS9+FkT2pQCTOjm-=jbtwGVJqj7Rs-axdLUBg19H_BdgJdw@mail.gmail.com>
In-Reply-To: <CADCiS9+FkT2pQCTOjm-=jbtwGVJqj7Rs-axdLUBg19H_BdgJdw@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 7 Aug 2025 16:42:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRaGQ+eUPaKLsxppRPESN_nEsRebeTyadmM8uUaHgL06g@mail.gmail.com>
X-Gm-Features: Ac12FXxc4MxpJiAcLQX3UtT5X30zy3vYSh7HH08_Zc8dm0UJANZlB8Ns-M8oEdc
Message-ID: <CAJF2gTRaGQ+eUPaKLsxppRPESN_nEsRebeTyadmM8uUaHgL06g@mail.gmail.com>
Subject: Re: [PATCH V2] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
To: wei li <liwei1518@gmail.com>
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com, seb@rivosinc.com, 
 tjeznach@rivosinc.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31; envelope-from=guoren@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Aug 6, 2025 at 10:19=E2=80=AFPM wei li <liwei1518@gmail.com> wrote:
>
>
>
> <guoren@kernel.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=885=E6=97=A5=E5=91=A8=
=E4=BA=8C 01:12=E5=86=99=E9=81=93=EF=BC=9A
>>
>> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>>
>> Current implementation is wrong when iohgatp !=3D bare. The RISC-V
>> IOMMU specification has defined that the PDT is based on GPA, not
>> SPA. So this patch fixes the problem, making PDT walk correctly
>> when the G-stage table walk is enabled.
>>
>> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
>> Cc: qemu-stable@nongnu.org
>> Cc: Sebastien Boeuf <seb@rivosinc.com>
>> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>> ---
>> Changes in V2:
>>  - Remove nested param to make patch clearer.
>>
>>  hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 139 insertions(+), 2 deletions(-)
>>
> LGTM.
>
> "3.3.2. Process to locate the Process-context
>
> The device-context provides the PDT root page PPN (pdtp.ppn). When DC.ioh=
gatp.mode is not
>
> Bare, pdtp.PPN as well as pdte.PPN are Guest Physical Addresses (GPA) whi=
ch must be translated
>
> into Supervisor Physical Addresses (SPA) using the second-stage page tabl=
e pointed to by
>
> DC.iohgatp. The memory accesses to the PDT are treated as implicit read m=
emory accesses by the
>
> second-stage."
>
> Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Thanks for mentioning the spec words. I would add this quotation to
the commit log of the next version.

>
> Regards,
>
> Weiwei Li
>
>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index 96a7fbdefcf3..ded3f7b2fdce 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -866,6 +866,143 @@ static bool riscv_iommu_validate_process_ctx(RISCV=
IOMMUState *s,
>>      return true;
>>  }
>>
>> +/**
>> + * pdt_memory_read: PDT wrapper of dma_memory_read.
>> + *
>> + * @s: IOMMU Device State
>> + * @ctx: Device Translation Context with devid and pasid set
>> + * @addr: address within that address space
>> + * @buf: buffer with the data transferred
>> + * @len: length of the data transferred
>> + * @attrs: memory transaction attributes
>> + */
>> +static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
>> +                                   RISCVIOMMUContext *ctx,
>> +                                   dma_addr_t addr,
>> +                                   void *buf, dma_addr_t len,
>> +                                   MemTxAttrs attrs)
>> +{
>> +    uint64_t gatp_mode, pte;
>> +    struct {
>> +        unsigned char step;
>> +        unsigned char levels;
>> +        unsigned char ptidxbits;
>> +        unsigned char ptesize;
>> +    } sc;
>> +    MemTxResult ret;
>> +    dma_addr_t base =3D addr;
>> +
>> +    /* G stages translation mode */
>> +    gatp_mode =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
>> +    if (gatp_mode =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE)
>> +        goto out;
>> +
>> +    /* G stages translation tables root pointer */
>> +    base =3D PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
>> +
>> +    /* Start at step 0 */
>> +    sc.step =3D 0;
>> +
>> +    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
>> +        /* 32bit mode for GXL =3D=3D 1 */
>> +        switch (gatp_mode) {
>> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
>> +            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
>> +                return MEMTX_ACCESS_ERROR;
>> +            }
>> +            sc.levels    =3D 2;
>> +            sc.ptidxbits =3D 10;
>> +            sc.ptesize   =3D 4;
>> +            break;
>> +        default:
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +    } else {
>> +        /* 64bit mode for GXL =3D=3D 0 */
>> +        switch (gatp_mode) {
>> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
>> +            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
>> +                return MEMTX_ACCESS_ERROR;
>> +            }
>> +            sc.levels    =3D 3;
>> +            sc.ptidxbits =3D 9;
>> +            sc.ptesize   =3D 8;
>> +            break;
>> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
>> +            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
>> +                return MEMTX_ACCESS_ERROR;
>> +            }
>> +            sc.levels    =3D 4;
>> +            sc.ptidxbits =3D 9;
>> +            sc.ptesize   =3D 8;
>> +            break;
>> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
>> +            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
>> +                return MEMTX_ACCESS_ERROR;
>> +            }
>> +            sc.levels    =3D 5;
>> +            sc.ptidxbits =3D 9;
>> +            sc.ptesize   =3D 8;
>> +            break;
>> +        default:
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +    }
>> +
>> +    do {
>> +        const unsigned va_bits =3D (sc.step ? 0 : 2) + sc.ptidxbits;
>> +        const unsigned va_skip =3D TARGET_PAGE_BITS + sc.ptidxbits *
>> +                                 (sc.levels - 1 - sc.step);
>> +        const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1)=
;
>> +        const dma_addr_t pte_addr =3D base + idx * sc.ptesize;
>> +
>> +        /* Address range check before first level lookup */
>> +        if (!sc.step) {
>> +            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) - =
1;
>> +            if ((addr & va_mask) !=3D addr) {
>> +                return MEMTX_ACCESS_ERROR;
>> +            }
>> +        }
>> +
>> +        /* Read page table entry */
>> +        if (sc.ptesize =3D=3D 4) {
>> +            uint32_t pte32 =3D 0;
>> +            ret =3D ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
>> +            pte =3D pte32;
>> +        } else {
>> +            ret =3D ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
>> +        }
>> +        if (ret !=3D MEMTX_OK)
>> +            return ret;
>> +
>> +        sc.step++;
>> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
>> +
>> +        if (!(pte & PTE_V)) {
>> +            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
>> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D PTE_W) {
>> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_=
W */
>> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE_=
X)) {
>> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_=
W + PTE_X */
>> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) =
{
>> +            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
>> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>> +            base =3D PPN_PHYS(ppn); /* Inner PTE, continue walking */
>> +        } else {
>> +            /* Leaf PTE, translation completed. */
>> +            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
>> +            break;
>> +        }
>> +
>> +        if (sc.step =3D=3D sc.levels) {
>> +            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
>> +        }
>> +    } while (1);
>> +
>> +out:
>> +    return dma_memory_read(s->target_as, base, buf, len, attrs);
>> +}
>> +
>>  /*
>>   * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
>>   *
>> @@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx)
>>           */
>>          const int split =3D depth * 9 + 8;
>>          addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK=
;
>> -        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
>> +        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
>>                              MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>>              return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>>          }
>> @@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx)
>>
>>      /* Leaf entry in PDT */
>>      addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
>> -    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * =
2,
>> +    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
>>                          MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>>          return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>>      }
>> --
>> 2.40.1
>>


--=20
Best Regards
 Guo Ren

