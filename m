Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42FBC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Ncn-00029i-HU; Fri, 10 May 2024 06:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5Ncj-000269-N4
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:37:10 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5Ncg-0005wW-D9
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:37:09 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51f60817e34so2249850e87.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715337424; x=1715942224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1ERe2a4ZdYlLHtyCtVpcWiVDz8X6SUGQnhe54IYJD4=;
 b=J/rqPQ36Hxo9WRBl550iY2JmuxqSdtINs1cbYKUSZGly2bgkaZ7rriArXrL+f8sK6P
 ELYbZf1noBTEP76mHpwZHE/GD9sVWhqEd+nopPR7NqWKL+hswHqJmN2D6Y28TdvJ2hTP
 46sbL1a3MqxgSlXG242srHyvdTp9W7WUvZiDKvRyaxNbE2HBZ2udrP9UOE1odt9CjRfO
 uIIh7/PvSLdw1pE60Ph8nHbGFdOac9KFzA7B09bt065QqKa2khmoAKAUKslI6V6icXJa
 NDcczU8qDeVabAeEJQnm8CLuCpP9i1MmvYKWUTHLqWezLGxT1QARkyCoNg4LwhNvlIV/
 H/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715337424; x=1715942224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1ERe2a4ZdYlLHtyCtVpcWiVDz8X6SUGQnhe54IYJD4=;
 b=TV16rX15HVCfPwe9XbDf2OoFni0EpxYHlWi2r35M7wOEZl0wiakmY8eBQ4SGlbCExw
 L7xy+LJoNSERSwaq241vvMEzm9gQAQV6G1bE8JwSW7taCtHY5nVzIRn25OEr5u1uua/k
 2fuez6XY3b6aGKIfLu0Y+J+SgSfIkDZ4VYOfo7w2ZsBoKrU/b8oEdurNoIllgMu+k8p6
 2FMRpLZfK1CsCC2t1yaINcGtEYziZA+4E925jLsRxPRAQD9c4r3wsgOzM/UMqws5QZH8
 21NZLtX1ChlsbZ+YO0N7lu9Ji9ZYxY/v0XOGyRDx6c8FVudQqJdJX0MyRxxKQBqV6maE
 Jo4w==
X-Gm-Message-State: AOJu0Yz9z/iGc5rfJ9bwVyPKXIZm7OdwE0t22PcMerQzKEy2oxlGuTiZ
 N7FkyNKxJoXuEXoMsL0fjzDoH1hQ+/AOPCQ8I7nk073bWAWDKg5boqWfWUFbohvKLrEMsKlmIg6
 NAD4+l5lUGk/H1VDY2I15EBD94TWtokXlRDpZlmtPIrxJqNOJ1Y1XPIQPPXVMYKu1ZvGTORBB/C
 EP7NpSY9fgWMXjcA9J56/nqUKdeZAnM6TGZbUEDj3pwA==
X-Google-Smtp-Source: AGHT+IHmzLoutOKxZvanGC7sAYkRnxrPVzH69ctU6C+O8ogsoOnCmXxkc7Ipsgw+MlJ4y2PzrZ334w==
X-Received: by 2002:a05:6512:245:b0:519:2c84:2405 with SMTP id
 2adb3069b0e04-5220fe78a2emr1318941e87.44.1715337423348; 
 Fri, 10 May 2024 03:37:03 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f38d86a8sm636316e87.188.2024.05.10.03.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:37:03 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2e45c0a8360so18748511fa.3; 
 Fri, 10 May 2024 03:37:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUHAJFwoO2ktqsHolBtk/HH1ntCHmfidajzxQUaqqvDIrcL10M/XaG9tJwg/Sj5DJuvjT2yNq54X2j0V6NggtWsbw/6DPk=
X-Received: by 2002:a2e:f12:0:b0:2dc:d2c5:ed0 with SMTP id
 38308e7fff4ca-2e51ff4d522mr12790701fa.12.1715337422577; 
 Fri, 10 May 2024 03:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-10-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-10-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 May 2024 18:36:51 +0800
X-Gmail-Original-Message-ID: <CANzO1D1Rk6S9RKqVkuFoHrK4tswvr61z0584s+unokcmRdmiog@mail.gmail.com>
Message-ID: <CANzO1D1Rk6S9RKqVkuFoHrK4tswvr61z0584s+unokcmRdmiog@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] hw/riscv/riscv-iommu: add s-stage and g-stage
 support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Daniel,

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:09=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Add support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage
> (sv32x4, sv39x4, sv48x4, sv57x4 caps). Most of the work is done in the
> riscv_iommu_spa_fetch() function that now has to consider how many
> translation stages we need to walk the page table.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/riscv-iommu-bits.h |  11 ++
>  hw/riscv/riscv-iommu.c      | 282 ++++++++++++++++++++++++++++++++++--
>  hw/riscv/riscv-iommu.h      |   2 +
>  3 files changed, 286 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 8e80b1e52a..9d645d69ea 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -71,6 +71,14 @@ struct riscv_iommu_pq_record {
>  /* 5.3 IOMMU Capabilities (64bits) */
>  #define RISCV_IOMMU_REG_CAP             0x0000
>  #define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
> +#define RISCV_IOMMU_CAP_SV32            BIT_ULL(8)
> +#define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
> +#define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
> +#define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
> +#define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
> +#define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> +#define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>  #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> @@ -79,6 +87,7 @@ struct riscv_iommu_pq_record {
>
>  /* 5.4 Features control register (32bits) */
>  #define RISCV_IOMMU_REG_FCTL            0x0008
> +#define RISCV_IOMMU_FCTL_GXL            BIT(2)
>
>  /* 5.5 Device-directory-table pointer (64bits) */
>  #define RISCV_IOMMU_REG_DDTP            0x0010
> @@ -195,6 +204,8 @@ struct riscv_iommu_dc {
>  #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
>  #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
>  #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
> +#define RISCV_IOMMU_DC_TC_GADE          BIT_ULL(7)
> +#define RISCV_IOMMU_DC_TC_SADE          BIT_ULL(8)
>  #define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
>  #define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 0b93146327..03a610fa75 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -58,6 +58,8 @@ struct RISCVIOMMUContext {
>      uint64_t __rfu:20;          /* reserved */
>      uint64_t tc;                /* Translation Control */
>      uint64_t ta;                /* Translation Attributes */
> +    uint64_t satp;              /* S-Stage address translation and prote=
ction */
> +    uint64_t gatp;              /* G-Stage address translation and prote=
ction */
>      uint64_t msi_addr_mask;     /* MSI filtering - address mask */
>      uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
>      uint64_t msiptp;            /* MSI redirection page table pointer */
> @@ -194,12 +196,46 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
>      return true;
>  }
>
> -/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
> +/*
> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> + *
> + * Note: Code is based on get_physical_address() from target/riscv/cpu_h=
elper.c
> + * Both implementation can be merged into single helper function in futu=
re.
> + * Keeping them separate for now, as error reporting and flow specifics =
are
> + * sufficiently different for separate implementation.
> + *
> + * @s        : IOMMU Device State
> + * @ctx      : Translation context for device id and process address spa=
ce id.
> + * @iotlb    : translation data: physical address and access mode.
> + * @gpa      : provided IOVA is a guest physical address, use G-Stage on=
ly.
> + * @return   : success or fault cause code.
> + */
>  static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
> -    IOMMUTLBEntry *iotlb)
> +    IOMMUTLBEntry *iotlb, bool gpa)
>  {
> +    dma_addr_t addr, base;
> +    uint64_t satp, gatp, pte;
> +    bool en_s, en_g;
> +    struct {
> +        unsigned char step;
> +        unsigned char levels;
> +        unsigned char ptidxbits;
> +        unsigned char ptesize;
> +    } sc[2];
> +    /* Translation stage phase */
> +    enum {
> +        S_STAGE =3D 0,
> +        G_STAGE =3D 1,
> +    } pass;
> +
> +    satp =3D get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    en_s =3D satp !=3D RISCV_IOMMU_DC_FSC_MODE_BARE && !gpa;
> +    en_g =3D gatp !=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> +
>      /* Early check for MSI address match when IOVA =3D=3D GPA */
> -    if (iotlb->perm & IOMMU_WO &&
> +    if (!en_s && (iotlb->perm & IOMMU_WO) &&

I'm wondering do we need to check "en_s" for MSI writes?

IOMMU spec Section 2.3.3. Process to translate addresses of MSIs says:
"Determine if the address A is an access to a virtual interrupt file
as specified in Section 2.1.3.6."

and Section 2.1.3.6 says:

"An incoming memory access made by a device is recognized as
an access to a virtual interrupt file if the destination guest physical pag=
e
matches the supplied address pattern in all bit positions that are zeros
in the supplied address mask. In detail, a memory access to
guest physical address A is recognized as an access to a virtual
interrupt file=E2=80=99s
memory-mapped page if:
(A >> 12) & ~msi_addr_mask =3D (msi_addr_pattern & ~msi_addr_mask)"

Is checking the address pattern sufficient enough to determine
the address is an MSI to a virtual interrupt file?

>          riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>          iotlb->target_as =3D &s->trap_as;
>          iotlb->translated_addr =3D iotlb->iova;
> @@ -208,11 +244,196 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
>      }
>
>      /* Exit early for pass-through mode. */
> -    iotlb->translated_addr =3D iotlb->iova;
> -    iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> -    /* Allow R/W in pass-through mode */
> -    iotlb->perm =3D IOMMU_RW;
> -    return 0;
> +    if (!(en_s || en_g)) {
> +        iotlb->translated_addr =3D iotlb->iova;
> +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        /* Allow R/W in pass-through mode */
> +        iotlb->perm =3D IOMMU_RW;
> +        return 0;
> +    }
> +
> +    /* S/G translation parameters. */
> +    for (pass =3D 0; pass < 2; pass++) {
> +        uint32_t sv_mode;
> +
> +        sc[pass].step =3D 0;
> +        if (pass ? (s->fctl & RISCV_IOMMU_FCTL_GXL) :
> +            (ctx->tc & RISCV_IOMMU_DC_TC_SXL)) {
> +            /* 32bit mode for GXL/SXL =3D=3D 1 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    =3D 0;
> +                sc[pass].ptidxbits =3D 0;
> +                sc[pass].ptesize   =3D 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV32X4 : RISCV_IOMMU_=
CAP_SV32;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 2;
> +                sc[pass].ptidxbits =3D 10;
> +                sc[pass].ptesize   =3D 4;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        } else {
> +            /* 64bit mode for GXL/SXL =3D=3D 0 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    =3D 0;
> +                sc[pass].ptidxbits =3D 0;
> +                sc[pass].ptesize   =3D 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV39X4 : RISCV_IOMMU_=
CAP_SV39;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 3;
> +                sc[pass].ptidxbits =3D 9;
> +                sc[pass].ptesize   =3D 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV48X4 : RISCV_IOMMU_=
CAP_SV48;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 4;
> +                sc[pass].ptidxbits =3D 9;
> +                sc[pass].ptesize   =3D 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV57X4 : RISCV_IOMMU_=
CAP_SV57;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 5;
> +                sc[pass].ptidxbits =3D 9;
> +                sc[pass].ptesize   =3D 8;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        }
> +    };
> +
> +    /* S/G stages translation tables root pointers */
> +    gatp =3D PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    satp =3D PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    addr =3D (en_s && en_g) ? satp : iotlb->iova;
> +    base =3D en_g ? gatp : satp;
> +    pass =3D en_g ? G_STAGE : S_STAGE;
> +
> +    do {
> +        const unsigned widened =3D (pass && !sc[pass].step) ? 2 : 0;
> +        const unsigned va_bits =3D widened + sc[pass].ptidxbits;
> +        const unsigned va_skip =3D TARGET_PAGE_BITS + sc[pass].ptidxbits=
 *
> +                                 (sc[pass].levels - 1 - sc[pass].step);
> +        const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr =3D base + idx * sc[pass].ptesize;
> +        const bool ade =3D
> +            ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC=
_SADE);
> +
> +        /* Address range check before first level lookup */
> +        if (!sc[pass].step) {
> +            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) - 1=
;
> +            if ((addr & va_mask) !=3D addr) {
> +                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (dma_memory_read(s->target_as, pte_addr, &pte,
> +                sc[pass].ptesize, MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK)=
 {
> +            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FA=
ULT
> +                                            : RISCV_IOMMU_FQ_CAUSE_RD_FA=
ULT;
> +        }
> +
> +        if (sc[pass].ptesize =3D=3D 4) {
> +            pte =3D (uint64_t) le32_to_cpu(*((uint32_t *)&pte));
> +        } else {
> +            pte =3D le64_to_cpu(pte);
> +        }
> +
> +        sc[pass].step++;
> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> +
> +        if (!(pte & PTE_V)) {
> +            break;                /* Invalid PTE */
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            base =3D PPN_PHYS(ppn); /* Inner PTE, continue walking */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D PTE_W) {
> +            break;                /* Reserved leaf PTE flags: PTE_W */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE_X=
)) {
> +            break;                /* Reserved leaf PTE flags: PTE_W + PT=
E_X */
> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +            break;                /* Misaligned PPN */
> +        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
> +            break;                /* Read access check failed */
> +        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
> +            break;                /* Write access check failed */
> +        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
> +            break;                /* Access bit not set */
> +        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +            break;                /* Dirty bit not set */
> +        } else {
> +            /* Leaf PTE, translation completed. */
> +            sc[pass].step =3D sc[pass].levels;
> +            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            /* Update address mask based on smallest translation granula=
rity */
> +            iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> +            /* Continue with S-Stage translation? */
> +            if (pass && sc[0].step !=3D sc[0].levels) {

Replace 0 with S_STAGE?

> +                pass =3D S_STAGE;
> +                addr =3D iotlb->iova;
> +                continue;
> +            }

May I ask under which case we will continue to walk the S-stage translation
after leaf PTE is found?

I thought the translation combinations are:
S-stage (i.e. Single-stage translation)
G-stage (i.e. G-stage only translation)
S-stage -> G-stage (i.e. Nested translation)

> +            /* Translation phase completed (GPA or SPA) */
> +            iotlb->translated_addr =3D base;
> +            iotlb->perm =3D (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : =
IOMMU_WO)
> +                                                         : IOMMU_RO;
> +
> +            /* Check MSI GPA address match */
> +            if (pass =3D=3D S_STAGE && (iotlb->perm & IOMMU_WO) &&
> +                riscv_iommu_msi_check(s, ctx, base)) {
> +                /* Trap MSI writes and return GPA address. */
> +                iotlb->target_as =3D &s->trap_as;
> +                iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +                return 0;
> +            }
> +
> +            /* Continue with G-Stage translation? */
> +            if (!pass && en_g) {
> +                pass =3D G_STAGE;
> +                addr =3D base;
> +                base =3D gatp;
> +                sc[pass].step =3D 0;
> +                continue;
> +            }
> +
> +            return 0;
> +        }
> +
> +        if (sc[pass].step =3D=3D sc[pass].levels) {
> +            break; /* Can't find leaf PTE */
> +        }
> +
> +        /* Continue with G-Stage translation? */
> +        if (!pass && en_g) {
> +            pass =3D G_STAGE;
> +            addr =3D base;
> +            base =3D gatp;
> +            sc[pass].step =3D 0;
> +        }

Will this if condition ever be executed?

For S-stage -> G-stage (i.e. Nested translation),
G-stage translation should be continued by
the S-stage Leaf PTE's if condition above?

> +    } while (1);
> +
> +    return (iotlb->perm & IOMMU_WO) ?
> +                (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
> +                (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S);
>  }
>
>  /* Redirect MSI write for given GPA. */
> @@ -351,6 +572,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx)
>
>      case RISCV_IOMMU_DDTP_MODE_BARE:
>          /* mock up pass-through translation context */
> +        ctx->gatp =3D set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
> +            RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
> +        ctx->satp =3D set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
> +            RISCV_IOMMU_DC_FSC_MODE_BARE);
>          ctx->tc =3D RISCV_IOMMU_DC_TC_V;
>          ctx->ta =3D 0;
>          ctx->msiptp =3D 0;
> @@ -424,6 +649,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>
>      /* Set translation context. */
>      ctx->tc =3D le64_to_cpu(dc.tc);
> +    ctx->gatp =3D le64_to_cpu(dc.iohgatp);
> +    ctx->satp =3D le64_to_cpu(dc.fsc);
>      ctx->ta =3D le64_to_cpu(dc.ta);
>      ctx->msiptp =3D le64_to_cpu(dc.msiptp);
>      ctx->msi_addr_mask =3D le64_to_cpu(dc.msi_addr_mask);
> @@ -433,14 +660,38 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>          return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
>      }
>
> +    /* FSC field checks */
> +    mode =3D get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
> +    addr =3D PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_DC_FSC_PPN));
> +
> +    if (mode =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE) {
> +        /* No S-Stage translation, done. */
> +        return 0;
> +    }
> +
>      if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
>          if (ctx->pasid !=3D RISCV_IOMMU_NOPASID) {
>              /* PASID is disabled */
>              return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
>          }
> +        if (mode > RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57) {
> +            /* Invalid translation mode */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +        }
>          return 0;
>      }
>
> +    if (ctx->pasid =3D=3D RISCV_IOMMU_NOPASID) {
> +        if (!(ctx->tc & RISCV_IOMMU_DC_TC_DPE)) {
> +            /* No default PASID enabled, set BARE mode */
> +            ctx->satp =3D 0ULL;
> +            return 0;
> +        } else {
> +            /* Use default PASID #0 */
> +            ctx->pasid =3D 0;

How do we differentiate between the default PASID: 0
and RISCV_IOMMU_NOPASID?

Regards,
Frank Chang

> +        }
> +    }
> +
>      /* FSC.TC.PDTV enabled */
>      if (mode > RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20) {
>          /* Invalid PDTP.MODE */
> @@ -474,6 +725,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>
>      /* Use FSC and TA from process directory entry. */
>      ctx->ta =3D le64_to_cpu(dc.ta);
> +    ctx->satp =3D le64_to_cpu(dc.fsc);
>
>      return 0;
>  }
> @@ -710,6 +962,7 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVI=
OMMUContext *ctx,
>      GHashTable *iot_cache, hwaddr iova)
>  {
>      RISCVIOMMUEntry key =3D {
> +        .gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
>          .pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
>          .iova  =3D PPN_DOWN(iova),
>      };
> @@ -779,7 +1032,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>      }
>
>      /* Translate using device directory / page table information. */
> -    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
> +    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb, false);
>
>      if (!fault && iotlb->target_as =3D=3D &s->trap_as) {
>          /* Do not cache trapped MSI translations */
> @@ -790,6 +1043,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>          iot =3D g_new0(RISCVIOMMUEntry, 1);
>          iot->iova =3D PPN_DOWN(iotlb->iova);
>          iot->phys =3D PPN_DOWN(iotlb->translated_addr);
> +        iot->gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID=
);
>          iot->pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
>          iot->perm =3D iotlb->perm;
>          riscv_iommu_iot_update(s, iot_cache, iot);
> @@ -1394,6 +1648,14 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>      if (s->enable_msi) {
>          s->cap |=3D RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
>      }
> +    if (s->enable_s_stage) {
> +        s->cap |=3D RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
> +                  RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
> +    }
> +    if (s->enable_g_stage) {
> +        s->cap |=3D RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
> +    }
>      /* Report QEMU target physical address space limits */
>      s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
>                         TARGET_PHYS_ADDR_SPACE_BITS);
> @@ -1504,6 +1766,8 @@ static Property riscv_iommu_properties[] =3D {
>          LIMIT_CACHE_IOT),
>      DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>      DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
> +    DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
> +    DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
>      DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
>          TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index eea2123686..9b33fb97ef 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -38,6 +38,8 @@ struct RISCVIOMMUState {
>
>      bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled)=
 */
>      bool enable_msi;      /* Enable MSI remapping */
> +    bool enable_s_stage;  /* Enable S/VS-Stage translation */
> +    bool enable_g_stage;  /* Enable G-Stage translation */
>
>      /* IOMMU Internal State */
>      uint64_t ddtp;        /* Validated Device Directory Tree Root Pointe=
r */
> --
> 2.43.2
>
>

