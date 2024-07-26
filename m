Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB35C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 03:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXC0J-0002VC-5t; Thu, 25 Jul 2024 23:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sXC0F-0002U2-2D; Thu, 25 Jul 2024 23:52:24 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sXC0D-00019I-3w; Thu, 25 Jul 2024 23:52:22 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-83172682ab3so76746241.2; 
 Thu, 25 Jul 2024 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721965939; x=1722570739; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKxbYD1RESqjsJxCcqlyfiHCMXpypiiOAtkuPrkoJ9c=;
 b=WiMtLq2uH7M9jXk1gFbrJsKrG1E87t4caUjfZjkgu16BqlnV2ECmvDiWtf+ObxARYx
 JKgKjqT+z3hbQoWeCGoZYipEH48n7HsDWUJQwJI39pWaNET7d88Q/PRLEkaR+l5SE133
 l7+9S3WE0ulllAUm6XDPLyDlOQAHIOZ+pKiPuRspAn1Rx7DqdWNlKrFxtxbbvqDAcN1U
 4zD4jseYJzuzCUsLTKmnq89fk6+g3c4nSYP5pIVBA/JNqVFOPMroov8PHKWu6H0MGBDb
 3nqPavyDpF9aVL5WJbVLnfCO+et0MyxI4TCb42Qr8u3DRJNd2NXWe6QZC8vND4qqP1GK
 n4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721965939; x=1722570739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKxbYD1RESqjsJxCcqlyfiHCMXpypiiOAtkuPrkoJ9c=;
 b=nQTaLFF7ZAtTK6r0FcvDsDGpBx48HTVc7g/HLAgsAHoQo6N6DI6K26HSoXuVPBG6Ia
 fw2JGSnXeRoPNVIPwhZrd2kAHLfbd6a+vRA/D67OsctlvOF1uyfAX2aP3Cz1Furqzmk0
 FRhi2t8COtRsZ+tllgIpDpibLv0IdkJ5V+4tZyOcAJgVp7fGIx0r83e7AbJx+AtHx4Ai
 0SLvnCmX7zF56zxVshyv1BNLhi/02Rs/cqqvq16dRMnnSZNuJ/z2W3oXXGqaNbB+Ptvv
 lf1gJmDQ2pgFD/Q5oVwQlaOar0rZPW1O4CMEdb9yBIml7Pb7Z4/nHWysO940tyxGiaDO
 f5lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE/spoR6ekhHa6+E2PXFOmmGR4t/Kz0SqmU0z7ELLHrPIGdYixoslzDUXbVDvc5HK7dkqvK/VXUhL/jHE27+bg0nijYkg=
X-Gm-Message-State: AOJu0Yw+6Vdr63if6hdrJcVYoIKacVBXEGvH6L5YHzQ/tGHXhBHIjXFs
 KLmVfmYT0ehGbF+Z5cApYjC7KslG3RKGYXnr00Ba4VD/yLGGIVIvkT7uU26aq7ihtzQeYLYFDBt
 QCL2UzPiq67UH/22jnPw2o51UxfQ=
X-Google-Smtp-Source: AGHT+IEuzuu6yjjYUZXrsaf5ODcCuzWv7543eTSLR39Znwrf7mvFpC0D4asChdcB9qKk/rPcnCYmzr8G1r6J/VtVpXA=
X-Received: by 2002:a05:6102:54a1:b0:493:ddf6:7912 with SMTP id
 ada2fe7eead31-493ddf68087mr3893165137.22.1721965939003; Thu, 25 Jul 2024
 20:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240724130717.95629-1-philmd@linaro.org>
In-Reply-To: <20240724130717.95629-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2024 13:51:52 +1000
Message-ID: <CAKmqyKPOXsi8y7pjDsck2mCwS5rHZW3h-ByEiAEZ6gM8zjNQ-Q@mail.gmail.com>
Subject: Re: [PATCH-for-9.1] target/riscv: Remove the deprecated 'any' CPU type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 devel@lists.libvirt.org, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Jul 24, 2024 at 11:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The 'any' CPU is deprecated since commit f57d5f8004b
> ("target/riscv: deprecate the 'any' CPU type"). Users
> are better off using the default CPUs or the 'max' CPU.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/about/deprecated.rst       | 13 -------------
>  docs/about/removed-features.rst |  8 ++++++++
>  target/riscv/cpu-qom.h          |  1 -
>  target/riscv/cpu.c              | 28 ----------------------------
>  4 files changed, 8 insertions(+), 42 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 88f0f037865..0ac49b15b44 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -347,19 +347,6 @@ QEMU's ``vhost`` feature, which would eliminate the =
high latency costs under
>  which the 9p ``proxy`` backend currently suffers. However as of to date =
nobody
>  has indicated plans for such kind of reimplementation unfortunately.
>
> -RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The 'any' CPU type was introduced back in 2018 and has been around since=
 the
> -initial RISC-V QEMU port. Its usage has always been unclear: users don't=
 know
> -what to expect from a CPU called 'any', and in fact the CPU does not do =
anything
> -special that isn't already done by the default CPUs rv32/rv64.
> -
> -After the introduction of the 'max' CPU type, RISC-V now has a good cove=
rage
> -of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature co=
mplete
> -CPU for both 32 and 64 bit builds. Users are then discouraged to use the=
 'any'
> -CPU type starting in 8.2.
> -
>  RISC-V CPU properties which start with capital 'Z' (since 8.2)
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index fc7b28e6373..f3e9474a73e 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -850,6 +850,14 @@ The RISC-V no MMU cpus have been removed. The two CP=
Us: ``rv32imacu-nommu`` and
>  ``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be=
 specified
>  via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
>
> +RISC-V 'any' CPU type ``-cpu any`` (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The 'any' CPU type was introduced back in 2018 and was around since the
> +initial RISC-V QEMU port. Its usage was always been unclear: users don't=
 know
> +what to expect from a CPU called 'any', and in fact the CPU does not do =
anything
> +special that isn't already done by the default CPUs rv32/rv64.
> +
>  ``compat`` property of server class POWER CPUs (removed in 6.0)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 3670cfe6d9a..4464c0fd7a3 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -29,7 +29,6 @@
>  #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
>  #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
>
> -#define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
>  #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
>  #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>  #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3bac..4bda754b013 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -438,27 +438,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>
> -static void riscv_any_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVU)=
;
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj),
> -        riscv_cpu_mxl(&RISCV_CPU(obj)->env) =3D=3D MXL_RV32 ?
> -        VM_1_10_SV32 : VM_1_10_SV57);
> -#endif
> -
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void riscv_max_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> @@ -1161,11 +1140,6 @@ static void riscv_cpu_realize(DeviceState *dev, Er=
ror **errp)
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
>      Error *local_err =3D NULL;
>
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_ANY) !=3D NULL) =
{
> -        warn_report("The 'any' CPU is deprecated and will be "
> -                    "removed in the future.");
> -    }
> -
>      cpu_exec_realizefn(cs, &local_err);
>      if (local_err !=3D NULL) {
>          error_propagate(errp, local_err);
> @@ -2952,7 +2926,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .abstract =3D true,
>      },
>  #if defined(TARGET_RISCV32)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV32,  riscv_any_cp=
u_init),
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cp=
u_init),
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
> @@ -2962,7 +2935,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_c=
pu_init),
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_c=
pu_init),
>  #elif defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cp=
u_init),
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cp=
u_init),
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
> --
> 2.45.2
>
>

