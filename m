Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C70CD60D06
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 01:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDCwm-0006E0-KM; Mon, 18 Nov 2024 20:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCwk-0006Dp-J0; Mon, 18 Nov 2024 20:22:26 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCwg-00042x-W5; Mon, 18 Nov 2024 20:22:25 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5139cd0032cso1544793e0c.2; 
 Mon, 18 Nov 2024 17:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731979341; x=1732584141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSUxYEcsdJymGJRb3JtZ/g6XJGuEiJRC9f9A+rXGNQs=;
 b=lg9P18cLj/YT781MR1Lw6Lq4Qvz5PZvOe39FEtMkGkJk8+4Q8wm2uy/1tX//N3xQbG
 GDK+PEowGKFHADiNm3XaLtzTHEbwIaZTqRK3uEJQZSmuvgBpyIlLzq35wK9jQM/eLvgp
 BwesQatpy9tHRqHz0R/Kdl1TefHFpXkl6fa8K4jfskmS/09XYj1bGdbuZxdJ/bHKf/gN
 brkqKw8J6HsI432PoFD4i6rE5iJJRGRVspKOVMT8ZLTqUH9L7xUD722TBqVpZHrnPbon
 Q9dqS58/cEVvmbQoRghCgYFu9L16MZ96jbAWNoXLubw8bUu1I5RF4zXp6Ic8DDlIv9IX
 IFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731979341; x=1732584141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSUxYEcsdJymGJRb3JtZ/g6XJGuEiJRC9f9A+rXGNQs=;
 b=k7q8sGJQkmXhb0xEzqZM5upF3BkpVYd89D1Bb2uRnbMZydNUQwbZEWOSdrLwF25NqY
 SHW0jG2wZdDPzB5MDOlJS2CbG+8xiSiwVyWK+NLFm+fiFZbOingqAozq0AYrP+ziLedY
 Hu8xnvxoA6RUoSFy4G2dG2dPNAEaHr7yzAhRB7H7FnwtoXhbthQzygC5LH9SuAokQNTa
 +3Ra6lHH2Ee4Xyymn6Ebk6QytgB6Pswb8Oc8fvppa+KHZuQuNpIxkzEw6Gx7unkwsRjS
 pZ+//zpPnIe+1BP6Ic4CjS82Q//+EvAkz1litxFAbdnfGOSoBAJQqXR6wOosJb0PsQ1Y
 iOLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5U5iWfnhInW236N2SfXpqVojwR5a99x+oYoszc/jRqnhSoXDihezEjljKDl6vcOuw/66Z9y5uyJsU@nongnu.org
X-Gm-Message-State: AOJu0YxSOvGLUpa9ORJ0F1++J98SxUi5pbShwJpAcRyza/CmFk6PVz8C
 j0jVFTcHFOyVifOGTX1zxMFZ0Qby1GOhNadSOoFWuoH4EgQxSHKt0xu2OjzUwYL7pua3K+mt/zF
 Ay+WBK/P/ZLgX2NQRcXDevIkY4AE=
X-Google-Smtp-Source: AGHT+IEL8RjJwFa0r2rLh2m790tLK2LhDBsrut7yEGOx2OyYhHGe1oK9TwmQI3iqVLAKW3uL9UbuzizVOQ1Ny8NIdFw=
X-Received: by 2002:a05:6122:1d07:b0:50d:66e1:826c with SMTP id
 71dfb90a1353d-514781e023bmr14484488e0c.11.1731979340893; Mon, 18 Nov 2024
 17:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
 <20241106133407.604587-2-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 11:21:54 +1000
Message-ID: <CAKmqyKMgsqdSf7gSGAL=ctcDiBN2Ltzt4sCE6SUswtxzx8q88g@mail.gmail.com>
Subject: Re: [PATCH for-10.0 1/7] hw/riscv/riscv-iommu.c: add
 riscv_iommu_instance_init()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Wed, Nov 6, 2024 at 11:38=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Move all the static initializion of the device to an init() function,
> leaving only the dynamic initialization to be done during realize.
>
> With this change s->cap is initialized with RISCV_IOMMU_CAP_DBG during
> init(), and realize() will increment s->cap with the extra caps.
>
> This will allow callers to add IOMMU capabilities before the
> realization.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 71 +++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index feb650549a..1893584028 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2096,11 +2096,48 @@ static const MemoryRegionOps riscv_iommu_trap_ops=
 =3D {
>      }
>  };
>
> +static void riscv_iommu_instance_init(Object *obj)
> +{
> +    RISCVIOMMUState *s =3D RISCV_IOMMU(obj);
> +
> +    /* Enable translation debug interface */
> +    s->cap =3D RISCV_IOMMU_CAP_DBG;
> +
> +    /* Report QEMU target physical address space limits */
> +    s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> +                       TARGET_PHYS_ADDR_SPACE_BITS);
> +
> +    /* TODO: method to report supported PID bits */
> +    s->pid_bits =3D 8; /* restricted to size of MemTxAttrs.pid */
> +    s->cap |=3D RISCV_IOMMU_CAP_PD8;
> +
> +    /* register storage */
> +    s->regs_rw =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_ro =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_wc =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +
> +     /* Mark all registers read-only */
> +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
> +
> +    /* Device translation context cache */
> +    s->ctx_cache =3D g_hash_table_new_full(riscv_iommu_ctx_hash,
> +                                         riscv_iommu_ctx_equal,
> +                                         g_free, NULL);
> +
> +    s->iot_cache =3D g_hash_table_new_full(riscv_iommu_iot_hash,
> +                                         riscv_iommu_iot_equal,
> +                                         g_free, NULL);
> +
> +    s->iommus.le_next =3D NULL;
> +    s->iommus.le_prev =3D NULL;
> +    QLIST_INIT(&s->spaces);
> +}
> +
>  static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
>
> -    s->cap =3D s->version & RISCV_IOMMU_CAP_VERSION;
> +    s->cap |=3D s->version & RISCV_IOMMU_CAP_VERSION;
>      if (s->enable_msi) {
>          s->cap |=3D RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
>      }
> @@ -2115,29 +2152,11 @@ static void riscv_iommu_realize(DeviceState *dev,=
 Error **errp)
>          s->cap |=3D RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
>                    RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
>      }
> -    /* Enable translation debug interface */
> -    s->cap |=3D RISCV_IOMMU_CAP_DBG;
> -
> -    /* Report QEMU target physical address space limits */
> -    s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> -                       TARGET_PHYS_ADDR_SPACE_BITS);
> -
> -    /* TODO: method to report supported PID bits */
> -    s->pid_bits =3D 8; /* restricted to size of MemTxAttrs.pid */
> -    s->cap |=3D RISCV_IOMMU_CAP_PD8;
>
>      /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrou=
gh) */
>      s->ddtp =3D set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
>                          RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MOD=
E_BARE);
>
> -    /* register storage */
> -    s->regs_rw =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> -    s->regs_ro =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> -    s->regs_wc =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> -
> -     /* Mark all registers read-only */
> -    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
> -
>      /*
>       * Register complete MMIO space, including MSI/PBA registers.
>       * Note, PCIDevice implementation will add overlapping MR for MSI/PB=
A,
> @@ -2195,19 +2214,6 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>      memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_op=
s, s,
>              "riscv-iommu-trap", ~0ULL);
>      address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
> -
> -    /* Device translation context cache */
> -    s->ctx_cache =3D g_hash_table_new_full(riscv_iommu_ctx_hash,
> -                                         riscv_iommu_ctx_equal,
> -                                         g_free, NULL);
> -
> -    s->iot_cache =3D g_hash_table_new_full(riscv_iommu_iot_hash,
> -                                         riscv_iommu_iot_equal,
> -                                         g_free, NULL);
> -
> -    s->iommus.le_next =3D NULL;
> -    s->iommus.le_prev =3D NULL;
> -    QLIST_INIT(&s->spaces);
>  }
>
>  static void riscv_iommu_unrealize(DeviceState *dev)
> @@ -2249,6 +2255,7 @@ static const TypeInfo riscv_iommu_info =3D {
>      .name =3D TYPE_RISCV_IOMMU,
>      .parent =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(RISCVIOMMUState),
> +    .instance_init =3D riscv_iommu_instance_init,
>      .class_init =3D riscv_iommu_class_init,
>  };
>
> --
> 2.45.2
>
>

