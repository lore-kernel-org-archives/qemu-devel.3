Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB9C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Nz6-0001ow-EB; Fri, 10 May 2024 07:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5Nz5-0001ml-3y
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:00:15 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5Nz2-0003v1-UK
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:00:14 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e3f6166e4aso33273511fa.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715338810; x=1715943610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpeOm48j53BUc67iX63S9jDDV9eKw+UtGgz2JVrkul8=;
 b=SxpT7hHuLWYexwd9V0wi1vMQfi048dxclEVyuzj49qZXnPHUnrqJ4rYXVNs3HjQC9D
 q24wLdt8Ydz1RhF5PztJG+R6+XezRGoLbelh6bz7nxD4Rs68tQGmRzObMhGxg2fSSJin
 Tdr/A39+m+v71cYLbPfg/HsWV/D1UKCFfVb2kHuMX0Pg9BldR6sxTGzM9GrIdgG8tSUt
 cjhazypTn5hdTknt4yXGao4l78FGrE7L5qsX0nYkTGm3Wzu1SRyJ/wzNUKjjIshxI/RZ
 /u0SgKrQEzzh60jITBSloCA61U5e9u/S4CZlAEEVu9rj3Tzb/ps4VZAaBGW2FNCqTQno
 LK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338810; x=1715943610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpeOm48j53BUc67iX63S9jDDV9eKw+UtGgz2JVrkul8=;
 b=lIu9kdXsm945qplS7Gow//XP6VQDwZs/M79Wxr4xes5I5TbMxNX9RnUUD4waA7bRLt
 72ERl689UBzvAGbLLCOxAx729ENsWKaVg/W9gvLGalz76XUongTcbtk2fz/U8H+/Z3xg
 LJUGmly94THEAymGoRLfqfvWaCWZsk/g0CkSDngOZELJ8CYYmp9n9PxWj4S0Ytw/MzdE
 axvl2i1/AhRjn7DQZZICgPXnyb5Nno+m0RvY6rxdonoK+idA5ZZoYm11x9HqD4KzF3KK
 xjYVTmMjFKQw46ksNfZNePEFL2KBsRXJ41UkfY8uhMSko1sutW9NJ3nk2tYggbxbMjIJ
 Cs+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYsfKSov483V7ExqpjCGSiCcEcfcDrluW5yShog866q6CRNtRVKBRReyIp6b2kWBIguYCGY6FwI5cVi6oIKCrhV//o/H8=
X-Gm-Message-State: AOJu0YxZKRbOHoQmVoF4PCHdvQq3NMMd68lLpcc+jWyliXl7wWixxPxV
 8uE4gdi5zHpJxVswkmzRq9A3YBnnHwwRTclYmgIwePDJNnOrcHy68eYQgs3mDsCPEf432T/QREH
 oBnDYTM8EBigLsOpaxM0yV3sD5I+M1O62VBY5901gnTZcBEqsC8Yrlk8yVfMepdDiQ5s0zwEuZm
 YjeaDuhzvBrUQqcieUX8p44o1if48dXJJ85ScIAGeb/w==
X-Google-Smtp-Source: AGHT+IF3LSEe1wVZYkq7OeGTJ19enUpJQYjiwog0OB5WMZ1bCbZZxzPPZNukEu40uBHt5lno7aI/ig==
X-Received: by 2002:a2e:808e:0:b0:2da:7cd1:3f1f with SMTP id
 38308e7fff4ca-2e52039e2b7mr17144471fa.52.1715338809877; 
 Fri, 10 May 2024 04:00:09 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com.
 [209.85.208.169]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d0ce2f86sm4900471fa.44.2024.05.10.04.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 04:00:09 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2e1fa1f1d9bso33940411fa.0; 
 Fri, 10 May 2024 04:00:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVcRWgOtsTnbCAFWxiBD8UZeJs4SBUnhTi8zMbbkiHoURlHBiW6BuxnjmzeqG0UkoAtAcHrc2HN0yJo8qo1AmTSqyN5QqPhaIhLoh6tcul1fhihFF7ZJK7Vsq6lHA==
X-Received: by 2002:a05:651c:23a:b0:2e1:a747:532d with SMTP id
 38308e7fff4ca-2e51fc36328mr20002641fa.8.1715338808867; Fri, 10 May 2024
 04:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-12-dbarboza@ventanamicro.com>
 <CANzO1D0ywHs+Juv9_qavykxCDiUsuk6tebObfSAyRbgW-WhGJA@mail.gmail.com>
 <e3eba1d7-35d7-4ecd-8443-320cbebc2bc3@ventanamicro.com>
In-Reply-To: <e3eba1d7-35d7-4ecd-8443-320cbebc2bc3@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 May 2024 18:59:57 +0800
X-Gmail-Original-Message-ID: <CANzO1D2n_ko7FtYDBc5hBTP8yhS4m=zQJ=N4OTD6Bda20Mpp0w@mail.gmail.com>
Message-ID: <CANzO1D2n_ko7FtYDBc5hBTP8yhS4m=zQJ=N4OTD6Bda20Mpp0w@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] hw/riscv/riscv-iommu: add DBG support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Frank Chang <frank.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com, 
 tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x22b.google.com
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
5=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi Frank,
>
> On 5/6/24 01:09, Frank Chang wrote:
> > Hi Daniel,
> >
> > Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=
=B9=B43=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:05=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >>
> >> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> >>
> >> DBG support adds three additional registers: tr_req_iova, tr_req_ctl a=
nd
> >> tr_response.
> >>
> >> The DBG cap is always enabled. No on/off toggle is provided for it.
> >>
> >> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> ---
> >>   hw/riscv/riscv-iommu-bits.h | 20 +++++++++++++
> >>   hw/riscv/riscv-iommu.c      | 57 +++++++++++++++++++++++++++++++++++=
+-
> >>   2 files changed, 76 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> >> index 0994f5ce48..b3f92411bb 100644
> >> --- a/hw/riscv/riscv-iommu-bits.h
> >> +++ b/hw/riscv/riscv-iommu-bits.h
> >> @@ -83,6 +83,7 @@ struct riscv_iommu_pq_record {
> >>   #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
> >>   #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
> >>   #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> >> +#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
> >>   #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
> >>   #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
> >>
> >> @@ -177,6 +178,25 @@ enum {
> >>       RISCV_IOMMU_INTR_COUNT
> >>   };
> >>
> >> +#define RISCV_IOMMU_IPSR_CIP            BIT(RISCV_IOMMU_INTR_CQ)
> >> +#define RISCV_IOMMU_IPSR_FIP            BIT(RISCV_IOMMU_INTR_FQ)
> >> +#define RISCV_IOMMU_IPSR_PMIP           BIT(RISCV_IOMMU_INTR_PM)
> >> +#define RISCV_IOMMU_IPSR_PIP            BIT(RISCV_IOMMU_INTR_PQ)
> >
> > These are not related to the DBG.
> >
> >> +
> >> +/* 5.24 Translation request IOVA (64bits) */
> >> +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> >> +
> >> +/* 5.25 Translation request control (64bits) */
> >> +#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
> >> +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
> >> +#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
> >> +#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
> >> +
> >> +/* 5.26 Translation request response (64bits) */
> >> +#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
> >> +#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
> >> +#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
> >> +
> >>   /* 5.27 Interrupt cause to vector (64bits) */
> >>   #define RISCV_IOMMU_REG_IVEC            0x02F8
> >>
> >> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> >> index 7af5929b10..1fa1286d07 100644
> >> --- a/hw/riscv/riscv-iommu.c
> >> +++ b/hw/riscv/riscv-iommu.c
> >> @@ -1457,6 +1457,46 @@ static void riscv_iommu_process_pq_control(RISC=
VIOMMUState *s)
> >>       riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_c=
lr);
> >>   }
> >>
> >> +static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
> >> +{
> >> +    uint64_t iova =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ=
_IOVA);
> >> +    uint64_t ctrl =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ=
_CTL);
> >> +    unsigned devid =3D get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
> >> +    unsigned pid =3D get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
> >> +    RISCVIOMMUContext *ctx;
> >> +    void *ref;
> >> +
> >> +    if (!(ctrl & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY)) {
> >> +        return;
> >> +    }
> >> +
> >> +    ctx =3D riscv_iommu_ctx(s, devid, pid, &ref);
> >> +    if (ctx =3D=3D NULL) {
> >> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
> >> +                                 RISCV_IOMMU_TR_RESPONSE_FAULT |
> >> +                                 (RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED <=
< 10));
> >> +    } else {
> >> +        IOMMUTLBEntry iotlb =3D {
> >> +            .iova =3D iova,
> >> +            .perm =3D IOMMU_NONE,
> >
> > .perm should honor tr_req_ctl.[Exe|Nw]
> >
> >> +            .addr_mask =3D ~0,
> >> +            .target_as =3D NULL,
> >> +        };
> >> +        int fault =3D riscv_iommu_translate(s, ctx, &iotlb, false);
> >> +        if (fault) {
> >> +            iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fau=
lt) << 10);
> >> +        } else {
> >> +            iova =3D ((iotlb.translated_addr & ~iotlb.addr_mask) >> 2=
) &
> >
> > For 4-KB page, we should right-shift 12 bits.
> >
> >> +                RISCV_IOMMU_TR_RESPONSE_PPN;
> >
> > It's possible that the translation is not 4-KB page (i.e. superpage),
> > which we should set tr_response.S
> > and encode translation range size in tr_response.PPN.
>
> At this moment this emulation doesn't support superpages, at least from m=
y
> understanding. Tomasz is welcome to correct me if I'm wrong. I'll explict=
ly
> set tr_response.S to 0 here to make it clearer.
>
> The idea here IIUC is to, in the future, merge the IOMMU translation look=
up code
> with the existing lookup code we have (cpu_helper.c, get_physical_address=
()), and
> with that the IOMMU will end up supporting both super-pages and svnapot.

I see, thanks for the explanation.

Regards,
Frank Chang

>
>
>
> Thanks,
>
> Daniel
>
>
> >
> > Regards,
> > Frank Chang
> >
> >> +        }
> >> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
> >> +    }
> >> +
> >> +    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
> >> +        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
> >> +    riscv_iommu_ctx_put(s, ref);
> >> +}
> >> +
> >>   /* Core IOMMU execution activation */
> >>   enum {
> >>       RISCV_IOMMU_EXEC_DDTP,
> >> @@ -1502,7 +1542,7 @@ static void *riscv_iommu_core_proc(void* arg)
> >>               /* NOP */
> >>               break;
> >>           case BIT(RISCV_IOMMU_EXEC_TR_REQUEST):
> >> -            /* DBG support not implemented yet */
> >> +            riscv_iommu_process_dbg(s);
> >>               break;
> >>           }
> >>           exec &=3D ~mask;
> >> @@ -1574,6 +1614,12 @@ static MemTxResult riscv_iommu_mmio_write(void =
*opaque, hwaddr addr,
> >>           exec =3D BIT(RISCV_IOMMU_EXEC_PQCSR);
> >>           busy =3D RISCV_IOMMU_PQCSR_BUSY;
> >>           break;
> >> +
> >> +    case RISCV_IOMMU_REG_TR_REQ_CTL:
> >> +        exec =3D BIT(RISCV_IOMMU_EXEC_TR_REQUEST);
> >> +        regb =3D RISCV_IOMMU_REG_TR_REQ_CTL;
> >> +        busy =3D RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
> >> +        break;
> >>       }
> >>
> >>       /*
> >> @@ -1746,6 +1792,9 @@ static void riscv_iommu_realize(DeviceState *dev=
, Error **errp)
> >>           s->cap |=3D RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 =
|
> >>                     RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
> >>       }
> >> +    /* Enable translation debug interface */
> >> +    s->cap |=3D RISCV_IOMMU_CAP_DBG;
> >> +
> >>       /* Report QEMU target physical address space limits */
> >>       s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> >>                          TARGET_PHYS_ADDR_SPACE_BITS);
> >> @@ -1800,6 +1849,12 @@ static void riscv_iommu_realize(DeviceState *de=
v, Error **errp)
> >>       stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
> >>       stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
> >>       stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
> >> +    /* If debug registers enabled. */
> >> +    if (s->cap & RISCV_IOMMU_CAP_DBG) {
> >> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
> >> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_CTL],
> >> +            RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
> >> +    }
> >>
> >>       /* Memory region for downstream access, if specified. */
> >>       if (s->target_mr) {
> >> --
> >> 2.43.2
> >>
> >>
>

