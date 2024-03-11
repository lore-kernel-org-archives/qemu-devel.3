Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4237C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjg0G-0002rC-7b; Mon, 11 Mar 2024 09:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rjg0E-0002r3-Ql
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:47:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rjg0C-0001Od-Ms
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:47:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd922cbcc7so8335595ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1710164858; x=1710769658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRD4lzoNaOeNqbsIlf++4Qfp9O+9H+1BVdNtuHikfP4=;
 b=PuU6o9C+MXTJD5VDfyAvnWhEzmDdY/SIgerYtFlOmNEtbUr11Eyb7bEZGqmT7B04nn
 2RzKDKKyU8M02QRH7JcVtaKwNCGsUvu78mXcOoSi1AqbFIGW6PG6wPLkmnm70Mx8XRDd
 mAA4Lfl+s3plHxyFNZxEWcRN9Zy+/sziziAeeecR4oMOhgb42ftmLvRqsiSWj4zTTUaQ
 v8QgtQ4i5bwFaeyL956uML9xtLY8ajnPo1wjD2NP37W4k4xJli+LI7DZbF0GGOgmMWCH
 xngZxW8vv+/myfu+toPEJxDATIKf6w1eg4sBxtHUIQNS6tnDh0bGjGDqOzpi0yXSwuWV
 CQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710164858; x=1710769658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRD4lzoNaOeNqbsIlf++4Qfp9O+9H+1BVdNtuHikfP4=;
 b=oeOYrir3sToKdg9fiol7fSp5IL88my4FdAR8s6bsUjPXRjJm/oj8VUoD1nBnoPkDXr
 VIbBo1fFjckiWAsQG0OY2aWAKwEyEYhljJggcEJ4xiBJXXnf2mY63yFkdH04A05PMW58
 YKh4o0n2MDxYCfn6dZ//+myoRsyPwSgxlggBBcF3KaHw5Mb/PzIXngZXYS/9Q1Bt/cS8
 pE8mL5UK1lWCHU7F2Xi9qjSCEXAQFEb3JWFmvAszyVmCpyUt4YpN+PGYb2YT3DIY1EuJ
 +b0kSP21hiIWq+zPBQ2PSr80+L1FGXTCNlMiHbbHY538ov3xLKdc57i1lKruyYMVEdwU
 zwOw==
X-Gm-Message-State: AOJu0YzBmbW+ph2/N4vWh+PoYY6GFQXs6fnZzilJOBbBLSgz4AkROb/K
 1UubjRgS2+oiq88pR4/A2lFfYyhsN3KCAqZ1+gbQJwQMEAdCZ2HxXL51FWB6fUeSO9649NhsPiM
 F8umq3izI/snec5gbjTbDB6HOldlQlnZJ3d9j
X-Google-Smtp-Source: AGHT+IGaJC2mm/1fSxfuh2YWxtn9MkZvNlo/QxUB1TEN3k+8aJtX0vrHC2NHIJ6jh0JKwYpXbLkckStNT9lWDSUkmvQ=
X-Received: by 2002:a17:902:f683:b0:1dd:918d:33ae with SMTP id
 l3-20020a170902f68300b001dd918d33aemr4766497plg.60.1710164858484; Mon, 11 Mar
 2024 06:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
 <20240308111152.2856137-10-alistair.francis@wdc.com>
In-Reply-To: <20240308111152.2856137-10-alistair.francis@wdc.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 11 Mar 2024 14:47:27 +0100
Message-ID: <CAJ307EiYcXiiTKeZMgWYQNkZ2McOOOJYYGUMh1-CnuNoy7M0Gg@mail.gmail.com>
Subject: Re: [PULL 09/34] target/riscv: add remaining named features
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=chigot@adacore.com; helo=mail-pl1-x629.google.com
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

Hi Alistair,

Since this series, I'm getting warnings when using a CPU not
supporting the latest ISA, such as the SIFIVE_E series.
  | $ qemu-system-riscv32  -M sifive_e
  | qemu-system-riscv32: warning: disabling zic64b extension for hart
0x00000000 because privilege spec version does not match
  | qemu-system-riscv32: warning: disabling ziccamoa extension for
hart 0x00000000 because privilege spec version does not match

Those are always enabled during the initialization but
riscv_cpu_disable_priv_spec_isa_exts is detecting them as unsupported
by the CPU and thus disabling them.
However, are those extensions different from zicnptr and zihpm
extensions ? As they are not enabled by the same mean, I'm wondering
about that ? Or do we want to skip their ISA verification as well ?

Thanks,
Cl=C3=A9ment

On Fri, Mar 8, 2024 at 12:13=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Message-ID: <20240215223955.969568-4-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_cfg.h     |  6 ++++++
>  target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
>  target/riscv/tcg/tcg-cpu.c |  2 ++
>  3 files changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e68a4ddb92..be39870691 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -128,6 +128,12 @@ struct RISCVCPUConfig {
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
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f0cd408237..4c4fa79145 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -102,6 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
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
> @@ -110,6 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> @@ -173,8 +178,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
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
> @@ -1567,6 +1576,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
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
> @@ -1578,6 +1592,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_featu=
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
> @@ -2171,13 +2202,10 @@ static const PropertyInfo prop_marchid =3D {
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
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 2307999387..ea763abb31 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1315,6 +1315,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
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
> 2.44.0
>
>

