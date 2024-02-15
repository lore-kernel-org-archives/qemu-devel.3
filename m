Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B67C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 04:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raT1N-0005s2-4y; Wed, 14 Feb 2024 23:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raT1J-0005rl-QQ; Wed, 14 Feb 2024 23:06:46 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raT1H-0002Nq-LD; Wed, 14 Feb 2024 23:06:45 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4c127eb4d6dso36176e0c.1; 
 Wed, 14 Feb 2024 20:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707970001; x=1708574801; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXKvPkUy2xOH8dU6kdWZY0NoiiRiMyIJfOezre24jio=;
 b=T9qEG371RA+ON7uAfg01iwJCq5icGaZykyHbiNtw+O89yuke0s+I+A298UlMex7TIC
 Q0DAlJBLYe7Xn1tcn1edqPP3qebf74UV32uOVlTwiGzRl09NICXu3CEIMz0YSybUzIBq
 47W2WHH8h7Yik37qZXb91nz8dMVrK6aeJD4XzDlUosZth/02j4exIqzO5kjNbEiZWQG0
 4a4mb+sJRHowKZz4kS4Wmb9PVtkgd3XQwv41xNpeeQIoWpFZuX7wnmJ5mjUppBlNHKgr
 ZCWhFmgnAfBiLhoVGP411xePw1QHU459Oq2EldB8MNTiJw1MFYHyEYfbPitbT+mrOh3J
 0X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707970001; x=1708574801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXKvPkUy2xOH8dU6kdWZY0NoiiRiMyIJfOezre24jio=;
 b=e4QopXMiDGDLG52TxG5q/ygtMrHnF7LE2yIiADovmXZAQvq6pcMFFWfAM6e8CjwHpB
 pvgSve3MLzHHKHF8G1SZmlcx7UcfWlzuCKBhsnGqvzpYza1Ie+nqG1Jk10T5jIZ/pOHP
 gIJwBDZzvmLr8xFk0xOd1EUUDwUkLlCog/DwTz2I9bfuZxNaBiWRcHcnAzAuvMmRkquH
 esNfgfyClyFGwcRJVuv+A+hp1arSnqQYJ0UzcAG8myn/rIol0IdlM6Iy382G/brz7ON3
 bNVLr/7wClwB/Fw8ky5yxbaajCXMCsws2OxRsvdEf2EBmbSQ3LU5D0b+Hsslt4dOyd67
 3bzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrSJ9a8Jw9GkahPtIlKkl2/mUrHD3e/JFU4nryqXZwBDYsTUQJNbbK+FWsp6HLFywmxdxVg9mwTQNUN4sw2QUfVCsm/94=
X-Gm-Message-State: AOJu0YxOpi6ZdXs5sU1DigIuQXa5u1Pu7HBQu+xzxCx7pTmQhMbWhwnq
 DgTECXtSz7bhjUP/FeKu+4ZtkhPehZio2xEY+tVHKsX64omyks9X2OVKKGjnGAv90sa1GCRlMV5
 GdcyL8FukBVmi4N7WMnfdX6smWA8=
X-Google-Smtp-Source: AGHT+IHHrAm6JpG/hoD1UY2XEn9HS03UhNtfkX86+2jZZc2jGAUncnqCFnaH+3BSlfXOYIspqX54/R/oHnHCDu/rORc=
X-Received: by 2002:a1f:e782:0:b0:4c0:29f8:ab14 with SMTP id
 e124-20020a1fe782000000b004c029f8ab14mr390873vkh.4.1707970001134; Wed, 14 Feb
 2024 20:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20240126133101.61344-8-ajones@ventanamicro.com>
 <20240126133101.61344-10-ajones@ventanamicro.com>
In-Reply-To: <20240126133101.61344-10-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 14:06:15 +1000
Message-ID: <CAKmqyKNatUvFrg4tvt9NWwXj7j3=aMDnJ6yWB2f0OYBmA0QhUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/riscv: add riscv,isa to named features
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

Alistair

On Fri, Jan 26, 2024 at 11:32=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Further discussions after the introduction of rva22 support in QEMU
> revealed that what we've been calling 'named features' are actually
> regular extensions, with their respective riscv,isa DTs. This is
> clarified in [1]. [2] is a bug tracker asking for the profile spec to be
> less cryptic about it.
>
> As far as QEMU goes we understand extensions as something that the user
> can enable/disable in the command line. This isn't the case for named
> features, so we'll have to reach a middle ground.
>
> We'll keep our existing nomenclature 'named features' to refer to any
> extension that the user can't control in the command line. We'll also do
> the following:
>
> - 'svade' and 'zic64b' flags are renamed to 'ext_svade' and
>   'ext_zic64b'. 'ext_svade' and 'ext_zic64b' now have riscv,isa strings a=
nd
>   priv_spec versions;
>
> - skip name feature check in cpu_bump_multi_ext_priv_ver(). Now that
>   named features have a riscv,isa and an entry in isa_edata_arr[] we
>   don't need to gate the call to cpu_cfg_ext_get_min_version() anymore.
>
> [1] https://github.com/riscv/riscv-profiles/issues/121
> [2] https://github.com/riscv/riscv-profiles/issues/142
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 17 +++++++++++++----
>  target/riscv/cpu_cfg.h     |  6 ++++--
>  target/riscv/tcg/tcg-cpu.c | 16 ++++++----------
>  3 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 88e8cc868144..28d3cfa8ce59 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -97,6 +97,7 @@ bool riscv_cpu_option_set(const char *optname)
>   * instead.
>   */
>  const RISCVIsaExtData isa_edata_arr[] =3D {
> +    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
>      ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>      ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> @@ -171,6 +172,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> +    ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> @@ -1510,9 +1512,16 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +/*
> + * 'Named features' is the name we give to extensions that we
> + * don't want to expose to users. They are either immutable
> + * (always enabled/disable) or they'll vary depending on
> + * the resulting CPU state. They have riscv,isa strings
> + * and priv_ver like regular extensions.
> + */
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
> -    MULTI_EXT_CFG_BOOL("svade", svade, true),
> -    MULTI_EXT_CFG_BOOL("zic64b", zic64b, true),
> +    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
> +    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -2130,7 +2139,7 @@ static RISCVCPUProfile RVA22U64 =3D {
>          CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
>
>          /* mandatory named features for this profile */
> -        CPU_CFG_OFFSET(zic64b),
> +        CPU_CFG_OFFSET(ext_zic64b),
>
>          RISCV_PROFILE_EXT_LIST_END
>      }
> @@ -2161,7 +2170,7 @@ static RISCVCPUProfile RVA22S64 =3D {
>          CPU_CFG_OFFSET(ext_svinval),
>
>          /* rva22s64 named features */
> -        CPU_CFG_OFFSET(svade),
> +        CPU_CFG_OFFSET(ext_svade),
>
>          RISCV_PROFILE_EXT_LIST_END
>      }
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e241922f89c4..698f926ab1be 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -117,13 +117,15 @@ struct RISCVCPUConfig {
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
> -    bool svade;
> -    bool zic64b;
>
>      uint32_t mvendorid;
>      uint64_t marchid;
>      uint64_t mimpid;
>
> +    /* Named features  */
> +    bool ext_svade;
> +    bool ext_zic64b;
> +
>      /* Vendor-specific custom extensions */
>      bool ext_xtheadba;
>      bool ext_xtheadbb;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 88f92d1c7d2c..90861cc065e5 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -197,12 +197,12 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t e=
xt_offset)
>  static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_off=
set)
>  {
>      switch (feat_offset) {
> -    case CPU_CFG_OFFSET(zic64b):
> +    case CPU_CFG_OFFSET(ext_zic64b):
>          cpu->cfg.cbom_blocksize =3D 64;
>          cpu->cfg.cbop_blocksize =3D 64;
>          cpu->cfg.cboz_blocksize =3D 64;
>          break;
> -    case CPU_CFG_OFFSET(svade):
> +    case CPU_CFG_OFFSET(ext_svade):
>          cpu->cfg.ext_svadu =3D false;
>          break;
>      default:
> @@ -219,10 +219,6 @@ static void cpu_bump_multi_ext_priv_ver(CPURISCVStat=
e *env,
>          return;
>      }
>
> -    if (cpu_cfg_offset_is_named_feat(ext_offset)) {
> -        return;
> -    }
> -
>      ext_priv_ver =3D cpu_cfg_ext_get_min_version(ext_offset);
>
>      if (env->priv_ver < ext_priv_ver) {
> @@ -349,11 +345,11 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RI=
SCVCPU *cpu)
>
>  static void riscv_cpu_update_named_features(RISCVCPU *cpu)
>  {
> -    cpu->cfg.zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
> -                      cpu->cfg.cbop_blocksize =3D=3D 64 &&
> -                      cpu->cfg.cboz_blocksize =3D=3D 64;
> +    cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
> +                          cpu->cfg.cbop_blocksize =3D=3D 64 &&
> +                          cpu->cfg.cboz_blocksize =3D=3D 64;
>
> -    cpu->cfg.svade =3D !cpu->cfg.ext_svadu;
> +    cpu->cfg.ext_svade =3D !cpu->cfg.ext_svadu;
>  }
>
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> --
> 2.43.0
>
>

