Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF6BC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 04:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTFY-0000mK-45; Wed, 14 Feb 2024 23:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTFV-0000lU-JC; Wed, 14 Feb 2024 23:21:25 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTFT-0006bx-QT; Wed, 14 Feb 2024 23:21:25 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d5fce59261so299627241.3; 
 Wed, 14 Feb 2024 20:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707970882; x=1708575682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mX1xFGE5bonQx1Rh1BMmI45pqnyLX/I+ng3Mihv0sN0=;
 b=NWMAjL7nXCIMw27zoxIEC5zpMXdd1k1kRoqasPbrKQiRm6RPU3YrkM+rfE1qF7Wy0t
 nuJuhLWM04df6MDiU/OjkO0AJZ2Gywbm18Qi0I5kmTlP+qtcqpjiW1lQBWWfztSHSvZy
 b9Lb3+W0ttyj0yLOmvBmf4V3EwgFMY1SbI5sI4Gf+vZhzN7jzmyTESqX0MYxmhMeRXIJ
 m4ymuwJhRRmFPnMK+1nNlBKu8cTm2+pXWSQk9e63Z8zN0qHHzMO+6ptKjmp/MsvKjoJF
 TjAxg1N3U2ldOHaVpCgjTVG7bY4JQS78VWDXcpVYW51/qLytATIPDjyRwG9ZerCLXIKR
 f0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707970882; x=1708575682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mX1xFGE5bonQx1Rh1BMmI45pqnyLX/I+ng3Mihv0sN0=;
 b=uM18XCCFa3FjT6eDTAYwAk9nakbKEQ6kqe88hN65P/4rUAfMxuYy9juQ3GnzJLaggm
 GRXJFx+YGS3l+cPJZLzi+dPHDBwVl/ai6vmeeizCldyxpwIJ2AOEp+337C7FJZRa55JI
 Aj1TF3cY1Jz45q+4pkMlERccIc+4kd/TRfU3N3dpfsYvsrx5A/dV+c/BeF5USPTf2IND
 jn45V5bfxXr56rdBqptWhvOwCwBuJfD8O2lZW+Fik+sUAMEzIE8NVV4tVpKb3TdpmUiZ
 51f7S7qNw35RmHij0lgHK+Z1xi76cF1DR52W9qn7d9mZU7JOxI62f8DfL8I2lB5wSdiv
 5N6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVjeE0Q6PhyhcCNBpyzp/zXTAsGc/40E32xTf09NkR3L6TF0y3Twffmlo52gQJvZ9Xg3ekjUzD9Zy7XSRde6/7BuUV0gI=
X-Gm-Message-State: AOJu0YzJX/Xz5kasmdroaNa6gvIVm+yWAr0oKxZsC4/jR6LjdS/f4Vdl
 qinVfs59PRPOf4M8nKAVpkdmL0OHH6UGqYeOe5UBGwvBNJfCrbgIJGnXtA1wS+myri315X6GxVh
 nuNfDjrr4yYJyG42Out2vlPkLxJ4=
X-Google-Smtp-Source: AGHT+IF4T1MijZnWCvxIzFrwq9lgNLr0LeTk4HhLPlXpXGXi6yM08cXej2iD0Dnhm1L08ok393wXp3tfxgDtVCKo38A=
X-Received: by 2002:a1f:e084:0:b0:4bd:5743:5b7f with SMTP id
 x126-20020a1fe084000000b004bd57435b7fmr425563vkg.13.1707970882339; Wed, 14
 Feb 2024 20:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240202152154.773253-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 14:20:56 +1000
Message-ID: <CAKmqyKOnw+0oFTe+EorKXvi+51rrkagXNOwqfYJN10ZYaCH2Xg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Feb 3, 2024 at 1:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> until now, we were implying that they were available.
>
> We can't do this anymore since named features also has a riscv,isa
> entry. Let's add them to riscv_cpu_named_features[].
>
> Instead of adding one bool for each named feature that we'll always
> implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
> cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
> named features will point to it. This also means that KVM won't see
> these features as always enable, which is our intention.
>
> If any accelerator adds support to disable one of these features, we'll
> have to promote them to regular extensions and allow users to disable it
> via command line.
>
> After this patch, here's the riscv,isa from a buildroot using the
> 'rva22s64' CPU:
>
>  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
>  target/riscv/cpu_cfg.h     |  6 ++++++
>  target/riscv/tcg/tcg-cpu.c |  2 ++
>  3 files changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 28d3cfa8ce..94843c4f6e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>      ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled=
),
> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled)=
,
> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled)=
,
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> @@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> @@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled)=
,
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_ena=
bled),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled)=
,
> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled)=
,
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1512,6 +1521,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +#define ALWAYS_ENABLED_FEATURE(_name) \
> +    {.name =3D _name, \
> +     .offset =3D CPU_CFG_OFFSET(ext_always_enabled), \
> +     .enabled =3D true}
> +
>  /*
>   * 'Named features' is the name we give to extensions that we
>   * don't want to expose to users. They are either immutable
> @@ -1523,6 +1537,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_featu=
res[] =3D {
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>
> +    /*
> +     * cache-related extensions that are always enabled
> +     * in TCG since QEMU RISC-V does not have a cache
> +     * model.
> +     */
> +    ALWAYS_ENABLED_FEATURE("za64rs"),
> +    ALWAYS_ENABLED_FEATURE("ziccif"),
> +    ALWAYS_ENABLED_FEATURE("ziccrse"),
> +    ALWAYS_ENABLED_FEATURE("ziccamoa"),
> +    ALWAYS_ENABLED_FEATURE("zicclsm"),
> +    ALWAYS_ENABLED_FEATURE("ssccptr"),
> +
> +    /* Other named features that TCG always implements */
> +    ALWAYS_ENABLED_FEATURE("sstvecd"),
> +    ALWAYS_ENABLED_FEATURE("sstvala"),
> +    ALWAYS_ENABLED_FEATURE("sscounterenw"),
> +
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -2116,13 +2147,10 @@ static const PropertyInfo prop_marchid =3D {
>  };
>
>  /*
> - * RVA22U64 defines some 'named features' or 'synthetic extensions'
> - * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
> - * and Zicclsm. We do not implement caching in QEMU so we'll consider
> - * all these named features as always enabled.
> - *
> - * There's no riscv,isa update for them (nor for zic64b, despite it
> - * having a cfg offset) at this moment.
> + * RVA22U64 defines some 'named features' that are cache
> + * related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
> + * and Zicclsm. They are always implemented in TCG and
> + * doesn't need to be manually enabled by the profile.
>   */
>  static RISCVCPUProfile RVA22U64 =3D {
>      .parent =3D NULL,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 698f926ab1..c5049ec664 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -126,6 +126,12 @@ struct RISCVCPUConfig {
>      bool ext_svade;
>      bool ext_zic64b;
>
> +    /*
> +     * Always 'true' boolean for named features
> +     * TCG always implement/can't be disabled.
> +     */
> +    bool ext_always_enabled;
> +
>      /* Vendor-specific custom extensions */
>      bool ext_xtheadba;
>      bool ext_xtheadbb;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 90861cc065..673097c6e4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1347,6 +1347,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
s)
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      Object *obj =3D OBJECT(cpu);
>
> +    cpu->cfg.ext_always_enabled =3D true;
> +
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      riscv_cpu_add_user_properties(obj);
> --
> 2.43.0
>
>

