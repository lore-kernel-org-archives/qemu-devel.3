Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67109C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 05:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm5Vr-0003Mp-2i; Mon, 18 Mar 2024 01:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm5VH-0003A0-VA; Mon, 18 Mar 2024 01:25:51 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm5VB-0002ik-S6; Mon, 18 Mar 2024 01:25:40 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7e0408f1c30so428374241.0; 
 Sun, 17 Mar 2024 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710739535; x=1711344335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BG6hiqRcQT/pzxqvqTGWpymgQ/fFYl8mu6Eomjip/Uk=;
 b=ICWZkSOsUqrCrOjR9ary18QbZ8Nyeh3IWvSdNRUrw77b11i0gJESaBBDErw/+tOg5I
 0GhcLwxBPKPfzjwAxb3QP7JUN2/NKy6e6s+6tL/q3f7veTuFnxAyzacY0IV1/TNo8GZY
 qvg0A6gDY2RNQ8bf7CfMuHLaDYPG4pYll6/ibGdCBOycmhT7gmtN3wyjJ4UDNNvxiQPd
 Q2vN3GlU01xsyFNd3W01tHWhRu+F2ibMc3bv6oi+L0VSiUwR+4b6u3/xG+6H2kNn6YbW
 eiUfx5W05eHraIduLVCq5VNhsqZILrcUmCBA6VjpWmoA5vpea3kn0+ZIoAd7NBRGO3Aa
 LTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710739535; x=1711344335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BG6hiqRcQT/pzxqvqTGWpymgQ/fFYl8mu6Eomjip/Uk=;
 b=pK/PaXzY409fkj1ivVw9Lxift0KQYQxc0wMxfsVpzvR4E4yA6H/N/QVY/96k1RKinf
 tRHgKt2rWFSfwFDT3YWdJraomBDi3YD0++cjDrg3o49GqQ02tgY0DEgeoMxxNgBuOhuC
 nb0i/g7k8omj/YPdq3SitTWlLxtVG76K9JH2hH3gs9V1k7ftTXVElgA0v1c2WcvO5Pn5
 wANNr5yO0fB4nkTTZSL19eZj+SZRpve9WNBjMnFDDyaTLCffgItM1MqvuursBB6CWE1p
 gnMfG5FRmkUHwdz9u0BygjipUL3AqvgvYpXUgSWGBXR7YQ6mnhGNRYzMHxgms6waW2nk
 lk+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOjNOOG5CzLubJY75LoLJryJzlewFqbwXwEIPg1wvt3Icg4ckZyObYz1eWvBE+Pi8RpnOoD+aOf46QRyd8RTDbNnQM7hA=
X-Gm-Message-State: AOJu0YxIYGaWxo/a9ZnIelc8o1Gmi5jJZwZjpNWYySzvRiKnxfr7R5IZ
 s/AO6IYYJ7fOpvLNmuVbWp8xY2FAbafZWAAJJn+1t+KMiFaiLlNgeqkGsoIqcwbRBEXbPz14qrS
 NOOA3j+wgGpoMFMxA9bH54Iv/Ooo=
X-Google-Smtp-Source: AGHT+IHUAtGoOVf+/rSdHSaE0CtLeJ/VNIFL9kfpc58wpvp5LciH+KNVj+IlQIGkxXNlIzyqj+ACd7TVGvHW3Y65A4w=
X-Received: by 2002:a67:ec58:0:b0:475:7680:6451 with SMTP id
 z24-20020a67ec58000000b0047576806451mr6923924vso.22.1710739535471; Sun, 17
 Mar 2024 22:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240312203214.350980-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240312203214.350980-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Mar 2024 15:25:09 +1000
Message-ID: <CAKmqyKNaiUQn_kAr494108yZok3KwuPhvkLh8Xjug9F_b85TQw@mail.gmail.com>
Subject: Re: [PATCH for-9.0] target/riscv: do not enable all named features by
 default
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Wed, Mar 13, 2024 at 6:33=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 3b8022269c added the capability of named features/profile
> extensions to be added in riscv,isa. To do that we had to assign priv
> versions for each one of them in isa_edata_arr[]. But this resulted in a
> side-effect: vendor CPUs that aren't running priv_version_latest started
> to experience warnings for these profile extensions [1]:
>
>   | $ qemu-system-riscv32  -M sifive_e
>   | qemu-system-riscv32: warning: disabling zic64b extension for hart
> 0x00000000 because privilege spec version does not match
>   | qemu-system-riscv32: warning: disabling ziccamoa extension for
> hart 0x00000000 because privilege spec version does not match
>
> This is benign as far as the CPU behavior is concerned since disabling
> both extensions is a no-op (aside from riscv,isa). But the warnings are
> unpleasant to deal with, especially because we're sending user warnings
> for extensions that users can't enable/disable.
>
> Instead of enabling all named features all the time, separate them by
> priv version. During finalize() time, after we decided which
> priv_version the CPU is running, enable/disable all the named extensions
> based on the priv spec chosen. This will be enough for a bug fix, but as
> a future work we should look into how we can name these extensions in a
> way that we don't need an explicit ext_name =3D> priv_ver as we're doing
> here.
>
> The named extensions being added in isa_edata_arr[] that will be
> enabled/disabled based solely on priv version can be removed from
> riscv_cpu_named_features[]. 'zic64b' is an extension that can be
> disabled based on block sizes so it'll retain its own flag and entry.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg02592.html
>
> Reported-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> Fixes: 3b8022269c ("target/riscv: add riscv,isa to named features")
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 40 +++++++++-----------------------------
>  target/riscv/cpu_cfg.h     |  8 +++++---
>  target/riscv/tcg/tcg-cpu.c | 14 ++++++++++---
>  3 files changed, 25 insertions(+), 37 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a48d30828..1da5417764 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -102,10 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>      ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> -    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled=
),
> -    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
> -    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled)=
,
> -    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled)=
,
> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> @@ -114,7 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> -    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> @@ -179,12 +179,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> -    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled)=
,
> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> -    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_ena=
bled),
> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> -    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled)=
,
> -    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled)=
,
> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1575,11 +1575,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> -#define ALWAYS_ENABLED_FEATURE(_name) \
> -    {.name =3D _name, \
> -     .offset =3D CPU_CFG_OFFSET(ext_always_enabled), \
> -     .enabled =3D true}
> -
>  /*
>   * 'Named features' is the name we give to extensions that we
>   * don't want to expose to users. They are either immutable
> @@ -1590,23 +1585,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>
> -    /*
> -     * cache-related extensions that are always enabled
> -     * in TCG since QEMU RISC-V does not have a cache
> -     * model.
> -     */
> -    ALWAYS_ENABLED_FEATURE("za64rs"),
> -    ALWAYS_ENABLED_FEATURE("ziccif"),
> -    ALWAYS_ENABLED_FEATURE("ziccrse"),
> -    ALWAYS_ENABLED_FEATURE("ziccamoa"),
> -    ALWAYS_ENABLED_FEATURE("zicclsm"),
> -    ALWAYS_ENABLED_FEATURE("ssccptr"),
> -
> -    /* Other named features that TCG always implements */
> -    ALWAYS_ENABLED_FEATURE("sstvecd"),
> -    ALWAYS_ENABLED_FEATURE("sstvala"),
> -    ALWAYS_ENABLED_FEATURE("sscounterenw"),
> -
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 2040b90da0..cb750154bd 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -130,10 +130,12 @@ struct RISCVCPUConfig {
>      bool ext_zic64b;
>
>      /*
> -     * Always 'true' boolean for named features
> -     * TCG always implement/can't be disabled.
> +     * Always 'true' booleans for named features
> +     * TCG always implement/can't be user disabled,
> +     * based on spec version.
>       */
> -    bool ext_always_enabled;
> +    bool has_priv_1_12;
> +    bool has_priv_1_11;
>
>      /* Vendor-specific custom extensions */
>      bool ext_xtheadba;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ab6db817db..63192ef54f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -315,9 +315,19 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RIS=
CVCPU *cpu)
>
>  static void riscv_cpu_update_named_features(RISCVCPU *cpu)
>  {
> +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_11_0) {
> +        cpu->cfg.has_priv_1_11 =3D true;
> +    }
> +
> +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_12_0) {
> +        cpu->cfg.has_priv_1_12 =3D true;
> +    }
> +
> +    /* zic64b is 1.12 or later */
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> -                          cpu->cfg.cboz_blocksize =3D=3D 64;
> +                          cpu->cfg.cboz_blocksize =3D=3D 64 &&
> +                          cpu->cfg.has_priv_1_12;
>  }
>
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> @@ -1316,8 +1326,6 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
s)
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      Object *obj =3D OBJECT(cpu);
>
> -    cpu->cfg.ext_always_enabled =3D true;
> -
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      riscv_cpu_add_user_properties(obj);
> --
> 2.43.2
>
>

