Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF55C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7klO-0003rW-99; Wed, 23 Apr 2025 20:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7klK-0003pz-9A
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:48:22 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7klI-0004FJ-Jq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:48:21 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-528ce9731dbso181443e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455699; x=1746060499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IG5N1pqLx9B8Z9xeqc0VH1mfeolX8GiqFT9Oc6Bz+8=;
 b=N483Iu2DrxcukrbqqUJorNyXlrMSjOvjwyOm5yQadxxzDRffK68a7Bbfo1yade+GHF
 YAqh+giK/fcJvmZdJ2C0ANvx5Y0ZolvH0jk2dZMeOd1JvgUSgrriB4yXdg7BckXJA62S
 tvX2H5EagoffPzfKdRG/0sqzWn+t+1kaYGN5OtSW3lkAbsy8FWrP1mDZS58O1rwMagLd
 sAZOrHOR/USVUqnq/alCS3aVgJojmbYQtnov+wNpjnwSOe3VRjPzrN5ePWjNFaEozPMm
 ricQwIZZ61Zwt7dpz3WcUoriu1p10zMFlGMP9jE7r6kmQq6W6ZuAdNE3IkdzQNOJnOD1
 KZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455699; x=1746060499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IG5N1pqLx9B8Z9xeqc0VH1mfeolX8GiqFT9Oc6Bz+8=;
 b=fQ6VHp58+hjg6Rpv502/H4ZAg6ZC5d1Rs0rZND/YkkcfQYN06qqOFR1dMDOArBtubv
 UFT2xxM1n4YF1X4iatZY6sQ2WWo0fZ/4RJipDNZwWwJ/JgmWJO2Cp84UcT92rJeHSSbe
 VVwvdR3tz+lZAWTouKnoNrRITfkCBI5vpSqPIbQ1RP+deHayxzrZakBT46+7n9ExkOkE
 lGT0NYGDE8SDVBrQEt7o3rGIOsvaEL5dMoO9bgdMNHdNl8cNnOLwhZRMfl4NpaSZb92P
 ss0X5TtPwT4DpG4GVZaa1F3YtL4T27fkVFUaa/pNZrO10/94cPGX62x44d8/Piq4BWf0
 dB9g==
X-Gm-Message-State: AOJu0Yz24Y4UWc9RO35xhVYBoMz++BFgBy3Q0wZqdGijTRdFqJcbfQdY
 eo+08HMVBR6a9+iSO/xDNxF8oWIPXOHUtId3zIlBSd8+jIgFzH7qDi/oQqcbhIKIEmw1iQmIl5Z
 UP08jL8dgig2VLj5kIHQFquBStks=
X-Gm-Gg: ASbGncu2XMQHGTK9s6yTy5g2z7L46KH9QPKPcHKTS/FSyd1lTWaEzg/VCs4njdIZB+z
 p7yZKM/mmo2G9sISWtJhpbch83wT1+n6Me8LW6OwSieCOblyfJAkWbDXKDHumTstNPpw4CJ+U1N
 jqxQPTTPMTUzWLMubmwT1X/8AcNsWAxY16vtKjBu8MIWHnnl7ZlfzwijvUEancfD0=
X-Google-Smtp-Source: AGHT+IEVJy6wyLb22Z8uLU/hqh7aNmKMYo1xuBt3zmLzYH3CQmWd0THGuUA9QqLgAXj5u/q69ftRjkWXprAqePYfu/w=
X-Received: by 2002:a05:6102:508c:b0:4c4:e0e0:f7bd with SMTP id
 ada2fe7eead31-4d38ebed43cmr978226137.19.1745455698990; Wed, 23 Apr 2025
 17:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-27-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-27-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:47:53 +1000
X-Gm-Features: ATxdqUFrcQj01QgVollwty9Pd52qoK6tTZMxdSH6PzcVFGw3YyDYU6b3UCCyQDA
Message-ID: <CAKmqyKN-yXysNXB7gj_Xo3rCAzNhy9p695O+YZu=Pipkm9eTJw@mail.gmail.com>
Subject: Re: [PATCH 26/27] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Sun, Apr 6, 2025 at 5:04=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 80 +++++++++++++---------------------------------
>  1 file changed, 23 insertions(+), 57 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e4d8ddf5a2..0a3a0343087 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -441,16 +441,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is=
_32_bit)
>      g_assert_not_reached();
>  }
>
> -static void __attribute__((unused))
> -set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
> -{
> -    bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
> -    const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> -
> -    assert(valid_vm[satp_mode]);
> -    cpu->cfg.max_satp_mode =3D satp_mode;
> -}
> -
>  static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
>  {
>      bool rv32 =3D riscv_cpu_is_32bit(cpu);
> @@ -499,38 +489,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
, const RISCVCSR *csr_list)
>  }
>  #endif
>
> -#if defined(TARGET_RISCV64)
> -
> -static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_12_0;
> -
> -    /* Enable ISA extensions */
> -    cpu->cfg.ext_zbc =3D true;
> -    cpu->cfg.ext_zbkb =3D true;
> -    cpu->cfg.ext_zbkc =3D true;
> -    cpu->cfg.ext_zbkx =3D true;
> -    cpu->cfg.ext_zknd =3D true;
> -    cpu->cfg.ext_zkne =3D true;
> -    cpu->cfg.ext_zknh =3D true;
> -    cpu->cfg.ext_zksed =3D true;
> -    cpu->cfg.ext_zksh =3D true;
> -    cpu->cfg.ext_svinval =3D true;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> -#endif
> -}
> -
> -#endif /* !TARGET_RISCV64 */
> -
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> @@ -2895,19 +2853,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>  }
>  #endif
>
> -#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
> -        .instance_init =3D (initfn),                          \
> -        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
> -             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .cfg.max_satp_mode =3D -1,                       \
> -        }),                                                 \
> -    }
> -
>  #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3207,8 +3152,29 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_SV48,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
> -                                                 MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_C=
PU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVB | RVS | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +
> +        /* ISA extensions */
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbkb =3D true,
> +        .cfg.ext_zbkc =3D true,
> +        .cfg.ext_zbkx =3D true,
> +        .cfg.ext_zknd =3D true,
> +        .cfg.ext_zkne =3D true,
> +        .cfg.ext_zknh =3D true,
> +        .cfg.ext_zksed =3D true,
> +        .cfg.ext_zksh =3D true,
> +        .cfg.ext_svinval =3D true,
> +
> +        .cfg.mmu =3D true,
> +        .cfg.pmp =3D true,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV39,
> +    ),
> +
>  #ifdef CONFIG_TCG
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
> --
> 2.49.0
>

