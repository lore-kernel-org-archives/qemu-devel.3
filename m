Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2579DC41513
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 09:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGEVc-0006SW-Jw; Sun, 09 Jun 2024 05:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGEVZ-0006Rk-MH
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 05:06:37 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGEVX-0001ab-CD
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 05:06:37 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e6f33150bcso38266431fa.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717923993; x=1718528793; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0awOdxG3B81S7PdIBI4Tu8tPRfGyccieIrVeaoqVeaw=;
 b=G3PacxT5d5XGGTqD7FT9PKaZ8t3NgYKiYxi+jUQMLswwiaBIsFoBdSRxgesoShWUiK
 WgFcP08QqrTNlanu4l021O9ihN45Qf5KaaDqNmdZK2O/6yLLq6nN8tv06xVs8GMVINdn
 RYXr8kA9FXJLphXPGitFy9Ga5z1cmBmzVZkpxgJsy7VlQDZdesyzv3QbwL//lCYH1JDc
 5XVOTzDftVAj22nhgNATTNUr70IYXcD97VhGHR88zMloRghSThHen4WXp4PXgbCQ0VUG
 LBtQpW5Li3ZJUjAZdWYMmhkJSZusZQmyjZqKSsgQf5RGZK5p9omKqFnMX9nrd5Wz1gv6
 i3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717923993; x=1718528793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0awOdxG3B81S7PdIBI4Tu8tPRfGyccieIrVeaoqVeaw=;
 b=ZnjZ9aCKn3rQGeHhmO+NVUDxFLtXqi7Ko16CXTt93hvHWivIO58AzrgZfJCX7np+bU
 Pym7HxTFfzgzDjh53ORa2KxfQe9N53LWMxw50JLKLO6nncumUc//ib/YkO13QgNy3RPj
 fsdwXfCSGQkGg8F/PxLZJyclzy5nEcSowhEqahdcJ2c5B6txL8Anh8i4W0Yf4Ntpvsv8
 yT02RZk0mU7QDKQJLmM3pzGcLlkA0zmA7oIMr4jH2FGWYE6FrXfWnk2o3LwPjH58goqA
 5ZdVfNJw3RG+MApDpDX7IX47PyxfQrY8CAtZ2QCckle2zX7Y18qW86pKffABjiJJA2tN
 IULg==
X-Gm-Message-State: AOJu0Ywob2mnpXzwzsgcvgP43IBRnTV36VtBsrRcsJTkiPPnb+tfONSk
 j4I3gAxWhz8ehPHMcjR3SDXtNo+WSzwhqPyCSwTYuCKXjulTjPamMi7fMMA9oNU4lcEKmB0+9t2
 ll6BxGsk2gC7OjpUs+tkZrj1CsgyEcup3WEQWYeEzZOvAeReHoOy/UM1SHLIpkBpEBJOjJFr1yM
 /q75AVo7vmZDU5T18eHVgEoUOhFD5NCwtOnmGY16+EyA==
X-Google-Smtp-Source: AGHT+IEGPGSBBYfwZP5BpbeLt47zQ+Z/wl2crUbagK68pMauhDahCJu1SNKtuXSMjj/q//gC/YHNZA==
X-Received: by 2002:a2e:9bd4:0:b0:2eb:dabb:f2b4 with SMTP id
 38308e7fff4ca-2ebdabbf60fmr13375061fa.32.1717923992842; 
 Sun, 09 Jun 2024 02:06:32 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2eb362e464fsm5984921fa.57.2024.06.09.02.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 02:06:32 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-52c7f7fdd24so1061550e87.1; 
 Sun, 09 Jun 2024 02:06:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUTXeshj8ZWE5wBPbMoqNh2ImofPKl2b1eEoKfcosbKx55w6MvYxu7LhXEqkjfDoX/3FdxbR7sZBC4BB5H0xJrB1UgS9hE=
X-Received: by 2002:a19:f713:0:b0:52b:be01:df75 with SMTP id
 2adb3069b0e04-52bbe01ecebmr3053115e87.55.1717923991838; Sun, 09 Jun 2024
 02:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-11-dbarboza@ventanamicro.com>
In-Reply-To: <20240523173955.1940072-11-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Sun, 9 Jun 2024 17:06:20 +0800
X-Gmail-Original-Message-ID: <CANzO1D06raV0VVJSfk3+3OnnicLeyNhr+_H6Y1uOw7405TvY-A@mail.gmail.com>
Message-ID: <CANzO1D06raV0VVJSfk3+3OnnicLeyNhr+_H6Y1uOw7405TvY-A@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] hw/riscv/riscv-iommu: add ATS support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, tjeznach@rivosinc.com, ajones@ventanamicro.com, 
 frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
5=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:41=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Add PCIe Address Translation Services (ATS) capabilities to the IOMMU.
> This will add support for ATS translation requests in Fault/Event
> queues, Page-request queue and IOATC invalidations.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/riscv-iommu-bits.h |  43 +++++++++++-
>  hw/riscv/riscv-iommu.c      | 129 +++++++++++++++++++++++++++++++++++-
>  hw/riscv/riscv-iommu.h      |   1 +
>  hw/riscv/trace-events       |   3 +
>  4 files changed, 173 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index a4def7b8ec..e253b29b16 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -81,6 +81,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>  #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
> +#define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
>  #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
> @@ -209,6 +210,7 @@ struct riscv_iommu_dc {
>
>  /* Translation control fields */
>  #define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
> +#define RISCV_IOMMU_DC_TC_EN_ATS        BIT_ULL(1)
>  #define RISCV_IOMMU_DC_TC_EN_PRI        BIT_ULL(2)
>  #define RISCV_IOMMU_DC_TC_T2GPA         BIT_ULL(3)
>  #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
> @@ -270,6 +272,20 @@ struct riscv_iommu_command {
>  #define RISCV_IOMMU_CMD_IODIR_DV        BIT_ULL(33)
>  #define RISCV_IOMMU_CMD_IODIR_DID       GENMASK_ULL(63, 40)
>
> +/* 3.1.4 I/O MMU PCIe ATS */
> +#define RISCV_IOMMU_CMD_ATS_OPCODE              4
> +#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL          0
> +#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR           1
> +#define RISCV_IOMMU_CMD_ATS_PID         GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_CMD_ATS_PV          BIT_ULL(32)
> +#define RISCV_IOMMU_CMD_ATS_DSV         BIT_ULL(33)
> +#define RISCV_IOMMU_CMD_ATS_RID         GENMASK_ULL(55, 40)
> +#define RISCV_IOMMU_CMD_ATS_DSEG        GENMASK_ULL(63, 56)
> +/* dword1 is the ATS payload, two different payload types for INVAL and =
PRGR */
> +
> +/* ATS.PRGR payload */
> +#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE      GENMASK_ULL(47, 44)
> +
>  enum riscv_iommu_dc_fsc_atp_modes {
>      RISCV_IOMMU_DC_FSC_MODE_BARE =3D 0,
>      RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 =3D 8,
> @@ -334,7 +350,32 @@ enum riscv_iommu_fq_ttypes {
>      RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH =3D 5,
>      RISCV_IOMMU_FQ_TTYPE_TADDR_RD =3D 6,
>      RISCV_IOMMU_FQ_TTYPE_TADDR_WR =3D 7,
> -    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 8,
> +    RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ =3D 8,
> +    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 9,
> +};
> +
> +/* Header fields */
> +#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
> +#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
> +#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
> +#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
> +
> +/* Payload fields */
> +#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
> +#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
> +#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
> +
> +
> +/*
> + * struct riscv_iommu_msi_pte - MSI Page Table Entry
> + */
> +struct riscv_iommu_msi_pte {
> +      uint64_t pte;
> +      uint64_t mrif_info;
>  };
>
>  /* Fields on pte */
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 11c418b548..3516b82081 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -641,6 +641,20 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOM=
MUState *s,
>                                              RISCVIOMMUContext *ctx)
>  {
>      uint32_t fsc_mode, msi_mode;
> +    uint64_t gatp;
> +
> +    if (!(s->cap & RISCV_IOMMU_CAP_ATS) &&
> +        (ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS ||
> +         ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI ||
> +         ctx->tc & RISCV_IOMMU_DC_TC_PRPR)) {
> +        return false;
> +    }
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS) &&
> +        (ctx->tc & RISCV_IOMMU_DC_TC_T2GPA ||
> +         ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI)) {
> +        return false;
> +    }
>
>      if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
>          ctx->tc & RISCV_IOMMU_DC_TC_PRPR) {
> @@ -661,6 +675,12 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOM=
MUState *s,
>          }
>      }
>
> +    gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_T2GPA &&
> +        gatp =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
> +        return false;
> +    }
> +
>      fsc_mode =3D get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
>
>      if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
> @@ -754,7 +774,12 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx)
>              RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
>          ctx->satp =3D set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
>              RISCV_IOMMU_DC_FSC_MODE_BARE);
> +
>          ctx->tc =3D RISCV_IOMMU_DC_TC_V;
> +        if (s->enable_ats) {
> +            ctx->tc |=3D RISCV_IOMMU_DC_TC_EN_ATS;
> +        }
> +
>          ctx->ta =3D 0;
>          ctx->msiptp =3D 0;
>          return 0;
> @@ -1191,6 +1216,16 @@ static int riscv_iommu_translate(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
>      enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
>      enable_pasid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>
> +    /* Check for ATS request. */
> +    if (iotlb->perm =3D=3D IOMMU_NONE) {
> +        /* Check if ATS is disabled. */
> +        if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
> +            enable_pri =3D false;
> +            fault =3D RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> +            goto done;
> +        }
> +    }
> +
>      iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
>      perm =3D iot ? iot->perm : IOMMU_NONE;
>      if (perm !=3D IOMMU_NONE) {
> @@ -1236,11 +1271,11 @@ done:
>      }
>
>      if (fault) {
> -        unsigned ttype;
> +        unsigned ttype =3D RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ;
>
>          if (iotlb->perm & IOMMU_RW) {
>              ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> -        } else {
> +        } else if (iotlb->perm & IOMMU_RO) {
>              ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
>          }
>
> @@ -1268,6 +1303,73 @@ static MemTxResult riscv_iommu_iofence(RISCVIOMMUS=
tate *s, bool notify,
>          MEMTXATTRS_UNSPECIFIED);
>  }
>
> +static void riscv_iommu_ats(RISCVIOMMUState *s,
> +    struct riscv_iommu_command *cmd, IOMMUNotifierFlag flag,
> +    IOMMUAccessFlags perm,
> +    void (*trace_fn)(const char *id))
> +{
> +    RISCVIOMMUSpace *as =3D NULL;
> +    IOMMUNotifier *n;
> +    IOMMUTLBEvent event;
> +    uint32_t pasid;
> +    uint32_t devid;
> +    const bool pv =3D cmd->dword0 & RISCV_IOMMU_CMD_ATS_PV;
> +
> +    if (cmd->dword0 & RISCV_IOMMU_CMD_ATS_DSV) {
> +        /* Use device segment and requester id */
> +        devid =3D get_field(cmd->dword0,
> +            RISCV_IOMMU_CMD_ATS_DSEG | RISCV_IOMMU_CMD_ATS_RID);
> +    } else {
> +        devid =3D get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_RID);
> +    }
> +
> +    pasid =3D get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
> +
> +    qemu_mutex_lock(&s->core_lock);
> +    QLIST_FOREACH(as, &s->spaces, list) {
> +        if (as->devid =3D=3D devid) {
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&s->core_lock);
> +
> +    if (!as || !as->notifier) {
> +        return;
> +    }
> +
> +    event.type =3D flag;
> +    event.entry.perm =3D perm;
> +    event.entry.target_as =3D s->target_as;
> +
> +    IOMMU_NOTIFIER_FOREACH(n, &as->iova_mr) {
> +        if (!pv || n->iommu_idx =3D=3D pasid) {
> +            event.entry.iova =3D n->start;
> +            event.entry.addr_mask =3D n->end - n->start;
> +            trace_fn(as->iova_mr.parent_obj.name);
> +            memory_region_notify_iommu_one(n, &event);
> +        }
> +    }
> +}
> +
> +static void riscv_iommu_ats_inval(RISCVIOMMUState *s,
> +    struct riscv_iommu_command *cmd)
> +{
> +    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_DEVIOTLB_UNMAP, IOMMU_=
NONE,
> +                           trace_riscv_iommu_ats_inval);
> +}
> +
> +static void riscv_iommu_ats_prgr(RISCVIOMMUState *s,
> +    struct riscv_iommu_command *cmd)
> +{
> +    unsigned resp_code =3D get_field(cmd->dword1,
> +                                   RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE);
> +
> +    /* Using the access flag to carry response code information */
> +    IOMMUAccessFlags perm =3D resp_code ? IOMMU_NONE : IOMMU_RW;
> +    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_MAP, perm,
> +                           trace_riscv_iommu_ats_prgr);
> +}
> +
>  static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
>  {
>      uint64_t old_ddtp =3D s->ddtp;
> @@ -1423,6 +1525,25 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMU=
State *s)
>                  get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
>              break;
>
> +        /* ATS commands */
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_INVAL,
> +                             RISCV_IOMMU_CMD_ATS_OPCODE):
> +            if (!s->enable_ats) {
> +                goto cmd_ill;
> +            }
> +
> +            riscv_iommu_ats_inval(s, &cmd);
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_PRGR,
> +                             RISCV_IOMMU_CMD_ATS_OPCODE):
> +            if (!s->enable_ats) {
> +                goto cmd_ill;
> +            }
> +
> +            riscv_iommu_ats_prgr(s, &cmd);
> +            break;
> +
>          default:
>          cmd_ill:
>              /* Invalid instruction, do not advance instruction index. */
> @@ -1818,6 +1939,9 @@ static void riscv_iommu_realize(DeviceState *dev, E=
rror **errp)
>      if (s->enable_msi) {
>          s->cap |=3D RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
>      }
> +    if (s->enable_ats) {
> +        s->cap |=3D RISCV_IOMMU_CAP_ATS;
> +    }
>      if (s->enable_s_stage) {
>          s->cap |=3D RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
>                    RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
> @@ -1925,6 +2049,7 @@ static Property riscv_iommu_properties[] =3D {
>      DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>          LIMIT_CACHE_IOT),
>      DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> +    DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
>      DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>      DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
>      DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index c24e3e4c16..26236c3cee 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -38,6 +38,7 @@ struct RISCVIOMMUState {
>
>      bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled)=
 */
>      bool enable_msi;      /* Enable MSI remapping */
> +    bool enable_ats;      /* Enable ATS support */
>      bool enable_s_stage;  /* Enable S/VS-Stage translation */
>      bool enable_g_stage;  /* Enable G-Stage translation */
>
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index 42a97caffa..4b486b6420 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -9,3 +9,6 @@ riscv_iommu_msi(const char *id, unsigned b, unsigned d, u=
nsigned f, uint64_t iov
>  riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%=
"PRIx64" 0x%"PRIx64
>  riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>  riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed=
"
> +riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
> +riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
> +riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group r=
esponse"
> --
> 2.44.0
>
>

