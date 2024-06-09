Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929E1C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 09:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGEZ1-0007rs-66; Sun, 09 Jun 2024 05:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGEYx-0007rU-Gl
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 05:10:07 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGEYv-00026Q-Gx
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 05:10:07 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eabd22d441so55733101fa.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717924203; x=1718529003; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG2GMcL4HaU0pfX9p0QfNncQIFJDq/B4ZfPwDBxmIrs=;
 b=UGm67k1Xcx5t29Xlu8W9eIMc/wbZ7s1nlRDq0jVFLMbdBJhmLbZ2ru0kqVTej18tSi
 kBXmB/f/IeANSeJks4bc/6ikv0R5/YSEfucvX5/HU9DJ3g0eoT6HvhtPA8jY/A/ZOx+Y
 BU+FHa4O8xZTA8fk4wGGkilL/hOs1JeUHF+LdZd8lHuJm0gdt4QYTbt+W16zbw8Rz+ru
 rp7wYMJYqn3TzvIt1X+p3+Vizas3gp8SiIk6lLc/13SYgG+9OOVmbcQObjUKC6lxwN80
 XfWMiFDGaU1VJNfCVnBidEuSYAibaiKDWf2DxBjviZyB2xZe3zBSvvgoAW1i2jBovyCb
 Yaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717924203; x=1718529003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG2GMcL4HaU0pfX9p0QfNncQIFJDq/B4ZfPwDBxmIrs=;
 b=E3HG4lUFau0Gv7S6wI9tBcBx8fylaTpTua2PJ6KhE5huEg9f0zOV5uyUOrgD67wHKq
 zcxk4buMKJkmvidtEHKv0sGe92r7BOnrMxg1UAphII5Yvs4x1YivK6Q0KWW0UxzywgaU
 7KhICNeEO9zra749leckIJQwAU4XTI0cdHGwp8fcGQeXy8TI/uH+5XudSC3VBYjrDlCi
 L397Pqz4RrHQB1oJ38LK75dPl8nK9jp3f338W7wl7uqALTg0aJxlwlUJHQIu0LGHmWvO
 wW3W5o/uS6aDgbW4FeVnD6hmlBykiH+p5FjXMOlGpDa3vw2NGuvvjjQ8Hoc4d59pnwr3
 rGXQ==
X-Gm-Message-State: AOJu0YwKM6li7ksH5PoWiI7TwvpVyp6xQwr+TI0QAs4+U75SiSGv4X88
 twuBfTSoRCmB0PB6LlqtJGhjEJUCoDbc3SQVk5GEeNv3bxB8nO4pHGlTaBwk3aXz/TwCfvUj/sD
 ebYmXlPBi7nWzTcIgqXSVodCP56cQZ0Z35F5NwTTGXXt3cSH/wWVEhOD/GC2aluzszSo6ZrkN+9
 oT8wTU99QLstUzBMY6hzWNA6HLBWO3mkrX/Of/9MHLhw==
X-Google-Smtp-Source: AGHT+IEMegAXMYrTJxf9PV/04aZa0vHllJGUuK0ar7VGiM1gvVcDSCswrLnc36+am+tbL0v0EeIlIA==
X-Received: by 2002:a2e:9bd8:0:b0:2eb:dc5f:52f with SMTP id
 38308e7fff4ca-2ebdc5f07fcmr14976701fa.16.1717924203219; 
 Sun, 09 Jun 2024 02:10:03 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com.
 [209.85.167.52]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2eaea4235a9sm7342911fa.8.2024.06.09.02.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 02:10:03 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-52c82101407so1225444e87.3; 
 Sun, 09 Jun 2024 02:10:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUsCLjYi0LCSnZyX3R7C0hyCEIRMCn5SPwrgUMnqFyhrUT8ZNV1PDT4oswiTSlvJ5+EfNoFbyyjcBBee4T9aMHjLvmce4g=
X-Received: by 2002:a05:6512:20cd:b0:52c:8214:ae36 with SMTP id
 2adb3069b0e04-52c8214ae8dmr1664877e87.69.1717924202319; Sun, 09 Jun 2024
 02:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-12-dbarboza@ventanamicro.com>
In-Reply-To: <20240523173955.1940072-12-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Sun, 9 Jun 2024 17:09:51 +0800
X-Gmail-Original-Message-ID: <CANzO1D1+YgdoK3GMar_PnZEySBJMBdTyJGeZjwy_FFspanmm5Q@mail.gmail.com>
Message-ID: <CANzO1D1+YgdoK3GMar_PnZEySBJMBdTyJGeZjwy_FFspanmm5Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] hw/riscv/riscv-iommu: add DBG support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, tjeznach@rivosinc.com, ajones@ventanamicro.com, 
 frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
5=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:42=E5=AF=AB=E9=
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
>  hw/riscv/riscv-iommu-bits.h | 17 +++++++++++
>  hw/riscv/riscv-iommu.c      | 59 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index e253b29b16..f143c4a926 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -84,6 +84,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> +#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
>  #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
>  #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
>  #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
> @@ -185,6 +186,22 @@ enum {
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
>  #define RISCV_IOMMU_REG_IVEC            0x02F8
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 3516b82081..52f0851895 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1655,6 +1655,50 @@ static void riscv_iommu_process_pq_control(RISCVIO=
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
> @@ -1778,6 +1822,12 @@ static MemTxResult riscv_iommu_mmio_write(void *op=
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
> @@ -1950,6 +2000,9 @@ static void riscv_iommu_realize(DeviceState *dev, E=
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
> @@ -2004,6 +2057,12 @@ static void riscv_iommu_realize(DeviceState *dev, =
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
> 2.44.0
>
>

