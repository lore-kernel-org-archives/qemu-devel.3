Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441FAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 23:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sakm3-0005Pa-4V; Sun, 04 Aug 2024 19:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakm1-0005Nt-7t; Sun, 04 Aug 2024 19:36:25 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1saklz-0007QU-Gs; Sun, 04 Aug 2024 19:36:24 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4f6c136a947so4793609e0c.1; 
 Sun, 04 Aug 2024 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722814582; x=1723419382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4Fqz7GflwC48N2EPig8eDfn4YNO1mRLGCW7ttQUafI=;
 b=F3gfmU46hdXvuHiF35qAdlRrIdjF0Dd5GLsUt8GyVVd37h353lXE+u/4o1fOd//RgD
 fW/a8CQrNKLfZJtH1T4VWK4Zxvzttt5pC1F/upjzeJPyl0D6B2+pLiLqzmdDujSw2Gkd
 +klVWfpAbs1ySvzib7/lrj0nCFPICIltXkf3ZGsGW4B3gHUspds18tIDEtoOZXmsBbmF
 0QBLwc59kmsMNchpyI4799CwqSMHugFiR1i17fjEiYiQAiI8NTMibmzgqOJ3zX1Fjq+J
 9tT3pj+Op4onCuEHcydf8YnfV1zrfMPh2NWglGko6aalZ2zZD5KLEMbnrFwQKLAISMoB
 jYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722814582; x=1723419382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4Fqz7GflwC48N2EPig8eDfn4YNO1mRLGCW7ttQUafI=;
 b=A+bcmi8VLtVYSHeXKRNmyGCxWd9Q6pvjTH0vUQfSB3JaEL6wZ0jdlYNR3mNrncZ3pm
 TeXbWcT9wnKC7lCMJ5FuoUAxKxJ3Xn7Nxf7ZU+prqZIoYK/4dfDTS9tM1TnOcLyGB/6D
 gmRbBMsAYjxJAp83nuTqRB5Z2r1bSaZO0meKw1MP8OD9QynP6eBCG483a+XuZFKgcmNS
 UHNb4MB4EvSLSNkCFNNBmV+fDSNYvwhXSWzPaecs7C0JOYFCDOjumLcNEjuo4mm1xeJN
 xy/f4ceFLd/0MfPz8i8dxVwxCNVQSzgex7zpAzagpaV2zQy2MXL1QXi7uMvPAR1GKNvq
 he8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW04qm7MqDtnHYWikxktWVZ7D3k0GoPiUU5lZ5tbwJRKrm9hq3I61+HYWCzM+s2OH9Moaj4Z+1TAKyVaSpfR2cZV74fmRQ=
X-Gm-Message-State: AOJu0Yw/2Dd8ATyaXQ5S4P5HFhWQuh+QoHM0TmUqPJGAU+yvZNyCluEw
 L3OeMdlYlmIfv3ziLmKMGk8zhVXCINDOXaT7r+Py7DG4G1fc5md0CwNVJX0a0BMCPg99R0RUiYp
 jZCy4mEUKS22vcEwYY4s/8sw+jQo=
X-Google-Smtp-Source: AGHT+IFk5unkDZvw6H/Z6a5QkSsMOWzBG+dp1IiDpl0kYJU8yIR8A1CIXK1vNaLX6ssKLPrY1lm9fQOhKOjB2hV5HF0=
X-Received: by 2002:a05:6122:da0:b0:4f5:28e3:5a5a with SMTP id
 71dfb90a1353d-4f89ff61d67mr11494871e0c.4.1722814581949; Sun, 04 Aug 2024
 16:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-11-dbarboza@ventanamicro.com>
In-Reply-To: <20240801154334.1009852-11-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:35:56 +1000
Message-ID: <CAKmqyKNf31ZvtFFqpqN-h__YZ-6kg7W15MBY1Anx=V+UBSP4aA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 v6 10/12] hw/riscv/riscv-iommu: add DBG support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 ajones@ventanamicro.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Fri, Aug 2, 2024 at 1:47=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
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
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 17 +++++++++++
>  hw/riscv/riscv-iommu.c      | 59 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index da6fb603aa..9d59c5c78d 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -82,6 +82,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> +#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
>  #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
>  #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
>  #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
> @@ -184,6 +185,22 @@ enum {
>      RISCV_IOMMU_INTR_COUNT
>  };
>
> +/* 5.24 Translation request IOVA (64bits) */
> +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> +
> +/* 5.25 Translation request control (64bits) */
> +#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
> +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
> +#define RISCV_IOMMU_TR_REQ_CTL_NW       BIT_ULL(3)
> +#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
> +
> +/* 5.26 Translation request response (64bits) */
> +#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
> +#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
> +#define RISCV_IOMMU_TR_RESPONSE_S       BIT_ULL(9)
> +#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
> +
>  /* 5.27 Interrupt cause to vector (64bits) */
>  #define RISCV_IOMMU_REG_ICVEC            0x02F8
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d127838ef8..bf90cea674 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1756,6 +1756,50 @@ static void riscv_iommu_process_icvec_update(RISCV=
IOMMUState *s)
>                      riscv_iommu_get_icvec_vector(icvec, RISCV_IOMMU_INTR=
_PQ));
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
> +            .perm =3D ctrl & RISCV_IOMMU_TR_REQ_CTL_NW ? IOMMU_RO : IOMM=
U_RW,
> +            .addr_mask =3D ~0,
> +            .target_as =3D NULL,
> +        };
> +        int fault =3D riscv_iommu_translate(s, ctx, &iotlb, false);
> +        if (fault) {
> +            iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault)=
 << 10);
> +        } else {
> +            iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
> +            iova >>=3D TARGET_PAGE_BITS;
> +            iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
> +
> +            /* We do not support superpages (> 4kbs) for now */
> +            iova &=3D ~RISCV_IOMMU_TR_RESPONSE_S;
> +        }
> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
> +    }
> +
> +    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
> +        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
> +    riscv_iommu_ctx_put(s, ref);
> +}
> +
>  typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
>
>  static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
> @@ -1883,6 +1927,12 @@ static MemTxResult riscv_iommu_mmio_write(void *op=
aque, hwaddr addr,
>
>          return MEMTX_OK;
>
> +    case RISCV_IOMMU_REG_TR_REQ_CTL:
> +        process_fn =3D riscv_iommu_process_dbg;
> +        regb =3D RISCV_IOMMU_REG_TR_REQ_CTL;
> +        busy =3D RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
> +        break;
> +
>      default:
>          break;
>      }
> @@ -2055,6 +2105,9 @@ static void riscv_iommu_realize(DeviceState *dev, E=
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
> @@ -2111,6 +2164,12 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>      stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
>      stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
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
> 2.45.2
>
>

