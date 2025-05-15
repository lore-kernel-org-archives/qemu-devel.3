Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAFBC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRPK-0004xR-Tc; Thu, 15 May 2025 01:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRPB-0004k9-0N
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:22 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRP8-0008W1-CG
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:15 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86feb84877aso131989241.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287912; x=1747892712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aml13uY5XHWNbto2zekqma9lFFAfQDjGHX3UEiFikmI=;
 b=P2PXxJGPcYLu3jg72grva9nF8P4LgPFL1n1eXolz0us7zWV8HkMtjcIN2kUEbBcq3U
 taWqGU9nKLsSrk4CynlDNq3qzNlOzsYrJ5noTn87zj9RqtZzhuYRVDPTEYs7Pkx7iP6a
 hOe+BNNNmYjfdsdpMkjOS8Ef1+fhcGzZQtRczIZ3/FEz8JOa+svpZT5Zmltp9iQi7WNQ
 rTOObXY/BpWtoc97D2vhiIT2kmQ8ErDVFQtEDnm+WzZjp3m5WOMg4ALXI29KXoSx9yK5
 e0fhV5Hr82NJl186KgN8RqwIAbQZPCs5VzBg+8Izh6clmfXj9f8XiJt+qf5BSJ0M0jzt
 sTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287912; x=1747892712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aml13uY5XHWNbto2zekqma9lFFAfQDjGHX3UEiFikmI=;
 b=vXGCc8V3vfs6iCL5wCr27/OOMan0wVIGjfv9oyApvgXBAlMkzPZRq5hizpH2+pXVim
 0HGSLaCTo1L9NRl8MH+5TaH870hhuBrYboe0SPeaIwhiMABO95mVCakJIKDqDvaFffuV
 rgoFLdnUpnXbfMQMweOWp/CEKtmYRl8PTN6BxPfUkLZ/G9SORJNUbKIZ7NVZw9K5OY0A
 m4SenaI+NYJaZZCqAYfpu9oiXmq1P5mu6ncF57os6PIlLjoGB5QBkcFFVsfzG1eTk624
 IVfLu8Kub37ASDl1Is24e4GJtYBFhxxkl6MqlcHg+TzZVSPP6f9TwXcC68UxTgYzMZDK
 5S4g==
X-Gm-Message-State: AOJu0YyPg48SzMQfriYlG2zf+8N9gkFSl1DHYaNQejGPocYPdHGEDn/m
 2riLMQVcFxb8nelvOdB4HE0iDvLW2hKQXEjJzu8BcL4figAOjPv1cJ0LGIw0t5/YYFTl3t6IZrD
 XSy8HV3e/XaMPMTjO6+Zf2K+1rjM=
X-Gm-Gg: ASbGncu4+SykeCOhBfFOfvLgT1cG3dP4Jj5i464gUXRw1YM90SXybMGhihibNiOWk4c
 b0+VsdUVRvMvp+BO8tptoewooh+jJJyG2omVuIpfIq6kjW/rCcRNhRJTeKGnjdKbqKhMm7Q/GIe
 HiUMhJBRi7tkVZlWptwfr4nGzNsHzl1L32luDAfAMR5bvOSp8ZODBYfx80nN3aG9on3C8iE2G+1
 w==
X-Google-Smtp-Source: AGHT+IEVBfJddNxtzMQ7gYWnNMJeaL4hx8P7ObMsnuRpZYCyPsFqE1sIbd7VY6+/M72VaM0Eiph9ndzW1eFXOVaqa9I=
X-Received: by 2002:a05:6102:4b0c:b0:4d7:9072:1873 with SMTP id
 ada2fe7eead31-4df9569d4e6mr848734137.24.1747287912429; Wed, 14 May 2025
 22:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-25-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-25-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:44:46 +1000
X-Gm-Features: AX0GCFt5uuiSLPuvrH4tYz-t2jvJTInsJLFg4ojx6j3lRZapY_Bw9191SoIORQk
Message-ID: <CAKmqyKMRWzW2xeE8_imP2Hw1z94KqtMUFfnr315=-169MP-bQg@mail.gmail.com>
Subject: Re: [PATCH 24/26] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
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
> index c884e09d869..f4d4abada75 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -440,16 +440,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is=
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
> @@ -498,38 +488,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
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
> @@ -2891,19 +2849,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>  }
>  #endif
>
> -#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
> -        .instance_init =3D (initfn),                          \
> -        .class_data =3D &(const RISCVCPUDef) {                \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
> -             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .cfg.max_satp_mode =3D -1,                       \
> -        },                                                  \
> -    }
> -
>  #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3203,8 +3148,29 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
> --
> 2.49.0
>

