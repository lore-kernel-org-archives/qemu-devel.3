Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74865C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 04:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3pfW-0004XK-SU; Mon, 06 May 2024 00:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s3pfQ-0004Wu-SF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:09:32 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s3pfO-0003qh-Lr
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:09:32 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f40b5e059so1753069e87.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 21:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1714968566; x=1715573366; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9SuWRYpKUVtMCPb2hrJa6wlHec+1WVJMgVteK90KIU=;
 b=aXxuikdJVugwpW+fCKQf/0HbHMkHOlXl8kMhQTE1rcrE7fhRuruC+jgz/UUm/PIeKM
 Ql42rEUgU13Bto7PDS6q9OM5pJ/5HRLYcqWZJWR5Ycf3pBZeob50DJzW4pxcGGtfVTds
 Q1NsUtdwbu80+njs8ITSrGNIucyq//hyjBchZFZThllc3zJrOW8ovDKgRYk/8/OV91LJ
 mOUbMEiEz+NpHbDpdEV5u+gqg/tN6PS7pcYsZ5ieTtHoICrI0W85xpsI5hncNorDbQJb
 9pF+6E6ZFzzLEaeilWAvVPp/d2Bl2u2xNHE0y/o9YVCXkA0/G4iOX7T/2cCV7w+yOhHh
 qZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714968566; x=1715573366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9SuWRYpKUVtMCPb2hrJa6wlHec+1WVJMgVteK90KIU=;
 b=a64z1+BOCWKuErlEqtGTVYfymax8pnoQw6Q3Kggq4wbp8lHRyyY3z+ZryYA/BHGGED
 k44Plfv1uAnNo4CbKCUIiuB0sL/YE5E92zVTbxetJmDtGRpN+jK04iIQVd6ZSuNSm+L5
 7urjA81MhrClcJCRjJrU9hoooQMNZvwmASfWVL/ZutMLBYGeRHlVoNDGNOX7ENaBddEg
 Dlu0Rk9BJmm4+rUlmhqP8Ad5b+mcho8pY0nvCvxNm7UUiD9jAoHrk14fjOQKfaP4sSQy
 YmtuyKtT4AJlIY68n4ecxi9sQTMZGAsJwZ/VyN3hGwVYLHSu41lq4AYYXYJIZ2XKEMdA
 F3Dw==
X-Gm-Message-State: AOJu0YyIp5BINKZV/rs8YtxG9h9Fr8GmM5pDD7BR2WS7jczc8arMrJ7a
 k7o22bO4UwF/w7PX1YC2kYUn04PjI1A1v/ASb8cnGAfZMSZUuWv5RlKO8xSMlMKsdWT7S9Si6fg
 kGkWJAqn7UPqreAnIPAuuzdkz1oDw4E38w1ikgXEj+hHJai3VbxJ9T5JbxnMFSJufWS8gMxpPRt
 xlwRbzuTIVsBvL6Uc5J36cSPiiSY3Bd/lwkdnZpW1m8A==
X-Google-Smtp-Source: AGHT+IGyGByzbTJkkDfLYY7K32JExNhxtmfPKlP7hKyFC4a4J4VVtdNUGekGHct0W8cLY0t4+Ghh/w==
X-Received: by 2002:a19:6454:0:b0:51e:eac7:d69b with SMTP id
 b20-20020a196454000000b0051eeac7d69bmr6106877lfj.27.1714968566072; 
 Sun, 05 May 2024 21:09:26 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174]) by smtp.gmail.com with ESMTPSA id
 q4-20020a19a404000000b00516c1fa74e3sm1456900lfc.207.2024.05.05.21.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 21:09:25 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so20039871fa.2; 
 Sun, 05 May 2024 21:09:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXu25dPxQPll4SBPumTMjd0zNWpIJwglzHjoZfvDoTuch90xnaav42kiF58Y/+9xrSwURwyzd3oODmVtG+QE3nvh2gP3XA=
X-Received: by 2002:a2e:b601:0:b0:2e1:18d:7497 with SMTP id
 r1-20020a2eb601000000b002e1018d7497mr5806301ljn.7.1714968565421; Sun, 05 May
 2024 21:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-12-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-12-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 6 May 2024 12:09:14 +0800
X-Gmail-Original-Message-ID: <CANzO1D0ywHs+Juv9_qavykxCDiUsuk6tebObfSAyRbgW-WhGJA@mail.gmail.com>
Message-ID: <CANzO1D0ywHs+Juv9_qavykxCDiUsuk6tebObfSAyRbgW-WhGJA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] hw/riscv/riscv-iommu: add DBG support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x133.google.com
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
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> DBG support adds three additional registers: tr_req_iova, tr_req_ctl and
> tr_response.
>
> The DBG cap is always enabled. No on/off toggle is provided for it.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/riscv-iommu-bits.h | 20 +++++++++++++
>  hw/riscv/riscv-iommu.c      | 57 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 0994f5ce48..b3f92411bb 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -83,6 +83,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>  #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> +#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
>  #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
>  #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
>
> @@ -177,6 +178,25 @@ enum {
>      RISCV_IOMMU_INTR_COUNT
>  };
>
> +#define RISCV_IOMMU_IPSR_CIP            BIT(RISCV_IOMMU_INTR_CQ)
> +#define RISCV_IOMMU_IPSR_FIP            BIT(RISCV_IOMMU_INTR_FQ)
> +#define RISCV_IOMMU_IPSR_PMIP           BIT(RISCV_IOMMU_INTR_PM)
> +#define RISCV_IOMMU_IPSR_PIP            BIT(RISCV_IOMMU_INTR_PQ)

These are not related to the DBG.

> +
> +/* 5.24 Translation request IOVA (64bits) */
> +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> +
> +/* 5.25 Translation request control (64bits) */
> +#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
> +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
> +#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
> +
> +/* 5.26 Translation request response (64bits) */
> +#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
> +#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
> +#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
> +
>  /* 5.27 Interrupt cause to vector (64bits) */
>  #define RISCV_IOMMU_REG_IVEC            0x02F8
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 7af5929b10..1fa1286d07 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1457,6 +1457,46 @@ static void riscv_iommu_process_pq_control(RISCVIO=
MMUState *s)
>      riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
>  }
>
> +static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
> +{
> +    uint64_t iova =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_IO=
VA);
> +    uint64_t ctrl =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CT=
L);
> +    unsigned devid =3D get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
> +    unsigned pid =3D get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
> +    RISCVIOMMUContext *ctx;
> +    void *ref;
> +
> +    if (!(ctrl & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY)) {
> +        return;
> +    }
> +
> +    ctx =3D riscv_iommu_ctx(s, devid, pid, &ref);
> +    if (ctx =3D=3D NULL) {
> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
> +                                 RISCV_IOMMU_TR_RESPONSE_FAULT |
> +                                 (RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED << 1=
0));
> +    } else {
> +        IOMMUTLBEntry iotlb =3D {
> +            .iova =3D iova,
> +            .perm =3D IOMMU_NONE,

.perm should honor tr_req_ctl.[Exe|Nw]

> +            .addr_mask =3D ~0,
> +            .target_as =3D NULL,
> +        };
> +        int fault =3D riscv_iommu_translate(s, ctx, &iotlb, false);
> +        if (fault) {
> +            iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault)=
 << 10);
> +        } else {
> +            iova =3D ((iotlb.translated_addr & ~iotlb.addr_mask) >> 2) &

For 4-KB page, we should right-shift 12 bits.

> +                RISCV_IOMMU_TR_RESPONSE_PPN;

It's possible that the translation is not 4-KB page (i.e. superpage),
which we should set tr_response.S
and encode translation range size in tr_response.PPN.

Regards,
Frank Chang

> +        }
> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
> +    }
> +
> +    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
> +        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
> +    riscv_iommu_ctx_put(s, ref);
> +}
> +
>  /* Core IOMMU execution activation */
>  enum {
>      RISCV_IOMMU_EXEC_DDTP,
> @@ -1502,7 +1542,7 @@ static void *riscv_iommu_core_proc(void* arg)
>              /* NOP */
>              break;
>          case BIT(RISCV_IOMMU_EXEC_TR_REQUEST):
> -            /* DBG support not implemented yet */
> +            riscv_iommu_process_dbg(s);
>              break;
>          }
>          exec &=3D ~mask;
> @@ -1574,6 +1614,12 @@ static MemTxResult riscv_iommu_mmio_write(void *op=
aque, hwaddr addr,
>          exec =3D BIT(RISCV_IOMMU_EXEC_PQCSR);
>          busy =3D RISCV_IOMMU_PQCSR_BUSY;
>          break;
> +
> +    case RISCV_IOMMU_REG_TR_REQ_CTL:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_TR_REQUEST);
> +        regb =3D RISCV_IOMMU_REG_TR_REQ_CTL;
> +        busy =3D RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
> +        break;
>      }
>
>      /*
> @@ -1746,6 +1792,9 @@ static void riscv_iommu_realize(DeviceState *dev, E=
rror **errp)
>          s->cap |=3D RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
>                    RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
>      }
> +    /* Enable translation debug interface */
> +    s->cap |=3D RISCV_IOMMU_CAP_DBG;
> +
>      /* Report QEMU target physical address space limits */
>      s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
>                         TARGET_PHYS_ADDR_SPACE_BITS);
> @@ -1800,6 +1849,12 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>      stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
>      stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
>      stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
> +    /* If debug registers enabled. */
> +    if (s->cap & RISCV_IOMMU_CAP_DBG) {
> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_CTL],
> +            RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
> +    }
>
>      /* Memory region for downstream access, if specified. */
>      if (s->target_mr) {
> --
> 2.43.2
>
>

