Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB0CC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 01:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcbF-0003Be-L0; Mon, 29 Jan 2024 20:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcb9-00037S-2u; Mon, 29 Jan 2024 20:07:35 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcb5-0006JT-He; Mon, 29 Jan 2024 20:07:34 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57bbso653369241.1; 
 Mon, 29 Jan 2024 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706576850; x=1707181650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxIR6OEGMEbKL8U+r+WD/8cvPu6yW/CWULi2X0C8L/Q=;
 b=KDYzaVCbC5bloh2PnLBfwI5PYPuUezwB0uNSoT/idhOO6aoXCG/ZoeNWv9bpELYlrs
 oOLhZM+/zD2GRbGbXT1gJ9YiSVyFTQsGiqhtILV9gVak09aZ3NCApAa/FbgDOrvQaLM8
 oWyUlRRt8M5nEJ3SO/PpbK84rhEwLUnIkeL66HXJTvijfUGv289/LGjojJ8aC1MUQGRZ
 2UegKNyjvyINEtpCRl5NK8UDNOB+r/ANU6bPpBD0swX9aPCFllv4Eiwuvpb1IoDNO4sm
 VeeET34rUSxSAR0/i5MIyRYCbW1igCZsrDzv/sGFKRZIYcxjB9Le6bM9UsH9nH8ilmeW
 HENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706576850; x=1707181650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxIR6OEGMEbKL8U+r+WD/8cvPu6yW/CWULi2X0C8L/Q=;
 b=H8B+4/r3dHUccV6uTQJtSWbTrSeqeAkDDX3GkPd/ih13P1mB8GsaW2gTtiFprZ8yqB
 flBnl18C08pjRihvGWYz42TdstNkuaBMKNp2/Nhn4B/ZC7vyU4TS1ZVtaeqmslwC814r
 iik4Zer/ns0jg/UZkeKdKjRSXDE81VjatrluDznPnzjEcR0sHHtkfMtwt9cEcBoMhuOz
 KL5j9aBhDWFdgb6Flsiemt4kgSrTIlRFEpPfwwwTDV1ulhLgd/ezvnSSTs+pDk5ZNVDU
 F5zZQDOnrMHNViBb6T7KfBoz4aHgC2zZ5PwE5r4hq3o6Z6giiPtYQNv3nmtx/5QWDP0G
 iU2g==
X-Gm-Message-State: AOJu0YxXHwp7g2OGIi+TGmbIXMgsyALthaBxn9cfMgVwJjlDPMNUml44
 jhWsq2taK04+ug4EAUtR0/vTC71ivL8nUGPtLIKmcXwiiJosfeLwfRkvkK0OT1KoqUx1a/OzfRL
 wmmLhI81f6RPWrXM57CrrLyE8LUE=
X-Google-Smtp-Source: AGHT+IFIMKbU2fayWGK8Pol0gYRLcL31PZY6bNfPRm81y3qB24gpqSmU6fTEjsBKABRt5FFIJ+Wiwnaz8QhKhrTQn5s=
X-Received: by 2002:a05:6102:3133:b0:46b:2bb:6936 with SMTP id
 f19-20020a056102313300b0046b02bb6936mr2731790vsh.33.1706576849693; Mon, 29
 Jan 2024 17:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
 <20240125195319.329181-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240125195319.329181-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 11:07:03 +1000
Message-ID: <CAKmqyKPqeZwfbJxONB1CA+vjFkJOrvVRZ=aN0rTFNUuZD_-Fow@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/riscv: add riscv,isa to named features
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Fri, Jan 26, 2024 at 6:55=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 17 +++++++++++++----
>  target/riscv/cpu_cfg.h     |  6 ++++--
>  target/riscv/tcg/tcg-cpu.c | 16 ++++++----------
>  3 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 88e8cc8681..28d3cfa8ce 100644
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
> index e241922f89..698f926ab1 100644
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
> index 88f92d1c7d..90861cc065 100644
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

