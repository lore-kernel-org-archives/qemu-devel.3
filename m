Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCF9C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kGb-0000oM-I4; Wed, 23 Apr 2025 20:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kGO-0000ni-Nq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:16:25 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kGM-0000xv-MP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:16:24 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86feb848764so205649241.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745453781; x=1746058581; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOvF/VS2zXg8Y9EreBhPaeLLLZikIRoOsn2o69moYjo=;
 b=XW1s9iEGpnBPug9dSdsKorD2ZI3LEOZIOawUNWdn3bS5gpwgU8xFL6wcoc8yanWY1b
 Ss9tOl2+mBvGMkR1fQ8MwksF7pMnNZNXihBhi66DWi3KIbSD9jjJkXs3fj3JWDR9nJmL
 0X/c7POobdtYpGYYGRVvGBHC/s385yprj/kjM3Euo8w0DO9d5vrLS8kEilWvJkNdKKug
 WiQpaK4UkHz3Zhg+HzsnRABuzMMbeJwOmNX0afTqjpRWJr498AqJJ9Mj9yvrUJwjM601
 b6edx8A70JMfmCeOfW5j5960glYVwaok0yIHTozN/1yDmnOKXbx+NfIxhcu7WeiLoAiH
 Qa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745453781; x=1746058581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOvF/VS2zXg8Y9EreBhPaeLLLZikIRoOsn2o69moYjo=;
 b=FtWqpP6aoMrD9Us2TO0bYPCdyPyxRnBkV70dMhlYuHSd0LbUFKOL0reffAHHvdXBeT
 KdVZ479SstatHuSggihR7EE5jpU43fk+8y4Iw0C0JoZP7XZL9QObNnf1H9TVYVCCgY4T
 yMFmPZOUIvOlfVYACgIwLKicleXJ6C8OVVOnR6QDhvBplPXpswuSreoqcc9U+u6ucTV4
 mq8vaeFNrIkUI2APN8rgcRxCG5FiXc1RwFQxLvpfo6jLAUZYaaCXZizZ+ZfPMYeR9bmy
 yZufG1R4fMElrhGS4OtHYJwcodLIylkpjJV9NTXYe6DqbyzKukksDjq5ckZBVVWhxiZb
 KG2g==
X-Gm-Message-State: AOJu0Yx47L+WAvolq1B7PkmR1YTscTF1qKhhyTMLYFy618g5r5QsNU4F
 OPCVkJQ5q2wtxc7xcB3aBJBDeWprBG4kru4GBV2mZZr3xOypYrDU1rJMHTf9AjWwabN4HsGAA+p
 NqLYXQnNiY67uJIGN9RYCkG3U0cc=
X-Gm-Gg: ASbGncvyAkISvEYrmS+vPEhE/DMSh7IaqOLHpm3D6W+XfsXWbbh3pGXEoTNfhms4r7F
 7WJ8kVuTdtaF0lAmmYvdZtiCcnleUSqRsSQeHNzWZHe5bE4j7Av3cFtcnfkZtMgn43UpfZLXXFH
 WlWBP1Vr+wxLHy2uFS8cY+Bxwts0040aOwEd6DHl5K5yTR/YTHbcs3Ysm4NtRfTEw=
X-Google-Smtp-Source: AGHT+IFhalpJeZdcW9E9jBKqb6CZ2QVxuoqkwo68XBpBStmm5Zs5y9AObeRQ+BldUONgWM3AwAEUTBRNeQf8RtDJqDc=
X-Received: by 2002:a05:6102:15a2:b0:4c4:f128:3abb with SMTP id
 ada2fe7eead31-4d38f4e785emr920741137.25.1745453781468; Wed, 23 Apr 2025
 17:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-18-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-18-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:15:55 +1000
X-Gm-Features: ATxdqUHdYhp4MVpc8zgVj_3u1ADBkPpy1YTtK1luf5g0Pc4_PVmhVWKrIu87Gac
Message-ID: <CAKmqyKN+Cefk1DZo9iBSQMq9wGWPUMSMxOE+hdVVzUGs-4rQyw@mail.gmail.com>
Subject: Re: [PATCH 17/27] target/riscv: convert dynamic CPU models to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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
>  target/riscv/cpu.c | 113 ++++++++++++---------------------------------
>  1 file changed, 30 insertions(+), 83 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2ea203d97b7..73c815d22e9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -486,38 +486,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>
> -static void riscv_max_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj),
> -        riscv_cpu_mxl(&RISCV_CPU(obj)->env) =3D=3D MXL_RV32 ?
> -        VM_1_10_SV32 : VM_1_10_SV57);
> -#endif
> -}
> -
>  #if defined(TARGET_RISCV64)
> -static void rv64_base_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    /* Set latest version of privileged specification */
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> -#endif
> -}
> -
>  static void rv64_sifive_u_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> @@ -718,43 +687,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *o=
bj)
>  #endif
>  }
>
> -#ifdef CONFIG_TCG
> -static void rv128_base_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    /* Set latest version of privileged specification */
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> -#endif
> -}
> -#endif /* CONFIG_TCG */
> -
>  #endif /* !TARGET_RISCV64 */
>
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>
> -static void rv32_base_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    /* Set latest version of privileged specification */
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
> -#endif
> -}
> -
>  static void rv32_sifive_u_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> @@ -3172,19 +3109,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>  }
>  #endif
>
> -#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
> -        .instance_init =3D (initfn),                          \
> -        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
> -             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .cfg.max_satp_mode =3D -1,                       \
> -        }),                                                 \
> -    }
> -
>  #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3241,7 +3165,12 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .class_base_init =3D riscv_cpu_class_base_init,
>      },
>
> -    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
> +        .cfg.mmu =3D true,
> +        .cfg.pmp =3D true,
> +        .priv_spec =3D PRIV_VERSION_LATEST,
> +    ),
> +
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
>          /*
> @@ -3269,15 +3198,23 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>  #endif
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
>  #if defined(TARGET_RISCV32)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cp=
u_init),
> +        .misa_mxl_max =3D MXL_RV32,
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
>  #elif defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cp=
u_init),
> +        .misa_mxl_max =3D MXL_RV64,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
>  #endif
> +    ),
>
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
> +        .misa_mxl_max =3D MXL_RV32,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_=
e_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_=
nommu_cpu_init),
> @@ -3294,11 +3231,18 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>  #endif
>
>  #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
> +        .misa_mxl_max =3D MXL_RV32,
> +    ),
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +        .misa_mxl_max =3D MXL_RV64,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_=
u_cpu_init),
> @@ -3308,7 +3252,10 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
>  #ifdef CONFIG_TCG
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +        .misa_mxl_max =3D MXL_RV128,
> +    ),
>  #endif /* CONFIG_TCG */
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
>          .misa_mxl_max =3D MXL_RV64,
> --
> 2.49.0
>

