Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA27C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kNR-00030A-HK; Wed, 23 Apr 2025 20:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kNP-0002wG-3n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:23:39 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kNN-0001iI-5x
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:23:38 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-528ce9731dbso176478e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745454215; x=1746059015; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCX+6rn8+4iMElYUvdBvVBvozb1SDvotDsiugpsEd9U=;
 b=aMH8+xDjCicropjSGD446aGJvJp9PBoRGj3NGp2UXfJQ2mxA7oFXEJQuEqsvhacR/W
 jknJQjH/yBnpCYAl5e8WH7e+spiGVo0jI9VCWbcgjcryptFta7z9XPrAQ1q5DMPUVcn4
 AUdoE5j9qYUhNq/M1cAcj0j1HPIGNuprW1lOoApErsXvBtVZUZPVDhGNqJd3emhY1Pbh
 zev9o8/ry22wggvX+Ay2D+lhu+DnAKv1nIycQyHTZaNsMa0a4AdboxLqJpQj02WzyDPu
 AlyhtacHJq/wq+4KmUKmN6W7xSe0gIyLfgTbEqVGiu6K5Qo7U6hhxmNKzgAGvtCXev2C
 kh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745454215; x=1746059015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCX+6rn8+4iMElYUvdBvVBvozb1SDvotDsiugpsEd9U=;
 b=L8/QI6/lCdIQ9Tvjd+xIUW6dRiEasfNsl7lbCi3lD9mb3XtdtxHHBfQ5OL/aeeTHPD
 lXWkYdm+uAPYgMEl1IhTzUL25SV2vUDsO15xRqRMfql+bGkZ5RAAsPgbGNsXDCFiqh+J
 EvdhlQtVjxFqVAKSDmg/bnw2/h8BbcdHGm2brJsJgX4CrtdcjKoo6EGt6LQHnTidi76c
 2asu1pwu2qh+R2pX9TCXz+NIgZNs/YDONfa0MwuQzIG7xWRyHtb2v8g3vGknB+M9OlZi
 U73boMnefUZtPmal6AYjN6JoMrx2eVy/oKOpwae4y690CRPr3voXW5rSqgStwhv0ttEa
 5fQw==
X-Gm-Message-State: AOJu0YxClnKUEom4z2fIAM0tHwz+oyFHhUyk/AyLZAky4TQ+7Ee0YGVP
 WXGj0ILuW3knV7EoSlwPUvVZ/aXxCrxQp+mS6Xlx9fROGMhX8Q13o91Uhthsb4rJ5dhYaq4Mz4n
 p72WiBP7/CH+S+1edZDsRFpfEK28=
X-Gm-Gg: ASbGncuC6pR0YyBORBZcKg/4ESILEPvfcAppYtStU2h3HymMIiq86AjMqMWwlE6/14T
 DSMRWPAW9WYbthhgjT9qgiRu6DCfauvMuZXvHb7dQRl107h22SQIob4w+e0oZlZC2P4ad15dLXS
 6YkevEMsf5lE4WvxPlKO4eiS89OobPhfijZPzIutRseg+BZU4XmGJY
X-Google-Smtp-Source: AGHT+IEaC5QkhaD26MVs2E4rbvdGAb99heDXYkbeGOtHKeyCNAiMDelwqsHNr6j1AT1nd3hrhBbTz4VX9QjCXNMeMGA=
X-Received: by 2002:a05:6102:1524:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4d38ebec5d7mr989745137.16.1745454215041; Wed, 23 Apr 2025
 17:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-20-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-20-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:23:09 +1000
X-Gm-Features: ATxdqUGaJhSWd3_qbo0Klgte4Mj6B96QFS6oi6Pu1y4SyRh_pPln2WtSi7ROrus
Message-ID: <CAKmqyKNkvpL5F6YOv9XfrCf3LB4wguUg6oAOY=pvLQFxQneSSw@mail.gmail.com>
Subject: Re: [PATCH 19/27] target/riscv: convert ibex CPU models to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e72ebdf206a..fe1edf3be97 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -691,28 +691,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.mmu =3D true;
>      cpu->cfg.pmp =3D true;
>  }
> -
> -static void rv32_ibex_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_12_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -    cpu->cfg.ext_smepmp =3D true;
> -
> -    cpu->cfg.ext_zba =3D true;
> -    cpu->cfg.ext_zbb =3D true;
> -    cpu->cfg.ext_zbc =3D true;
> -    cpu->cfg.ext_zbs =3D true;
> -}
>  #endif
>
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> @@ -3173,7 +3151,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV32,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVI | RVM | RVC | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +        .cfg.max_satp_mode =3D VM_1_10_MBARE,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.ext_smepmp =3D true,
> +
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true
> +    ),
> +
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
>          .misa_mxl_max =3D MXL_RV32
>      ),
> --
> 2.49.0
>

