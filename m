Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC49EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabsO-0002YW-RC; Thu, 15 Feb 2024 08:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rabsN-0002YI-BC; Thu, 15 Feb 2024 08:34:07 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rabsL-00066W-1U; Thu, 15 Feb 2024 08:34:07 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CD72ECE1C45;
 Thu, 15 Feb 2024 13:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321ECC433C7;
 Thu, 15 Feb 2024 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708004032;
 bh=vDKvHA0fZvEF4E+kXTAcypF9TGRc2II6L3v5Twr2twY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KCEbJ09f+F3ImpcFaw1JmN7JOnKTQhTIGA/8wiq5uDqc7IBSTNHwlOJmwK8qmqZG7
 6BdQ1kOgdqS5wgfnPIeGYtH5pcnabdTgpY+pudfGrPi2vVhcq1BNVixyIosviE1MF6
 PzI7EWvMkARvdsmmye5rSfFOFGnZzgQ2PsxFVC8dl3reMam4K73Fl0EDQncBZGRDGc
 sTRWuGaJ7HejqsIW9NBS1il8Yhmc0vtr5PX5W+ijOFco7UYDqGYVQ6HbklqgYrc+/E
 5hmAehZGJmwazFnjGLm6FLiGa5ow9yFh8vQy+jc8wC7r0Q6lhSNnLFNY3GJqHtwaJO
 Tw1on2XvaHNWw==
Date: Thu, 15 Feb 2024 13:33:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240215-alkaline-saturday-275cd8e3aa39@spud>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sE4UzVSkIPWAEx/7"
Content-Disposition: inline
In-Reply-To: <20240202152154.773253-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=conor@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--sE4UzVSkIPWAEx/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza wrote:
> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> until now, we were implying that they were available.
>=20
> We can't do this anymore since named features also has a riscv,isa
> entry. Let's add them to riscv_cpu_named_features[].
>=20
> Instead of adding one bool for each named feature that we'll always
> implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
> cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
> named features will point to it. This also means that KVM won't see
> these features as always enable, which is our intention.
>=20
> If any accelerator adds support to disable one of these features, we'll
> have to promote them to regular extensions and allow users to disable it
> via command line.
>=20
> After this patch, here's the riscv,isa from a buildroot using the
> 'rva22s64' CPU:

Why does an "rva22s64" cpu have "zicclsm" in it? Isn't zicclsm only
present in "u" profiles?

>  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#

I want to raise my frustration with the crock we've been given here by
RVI. Any "named feature" that just creates a name for something that
already is assumed is completely useless, and DT property that is used
to communicate it's presence cannot be used - instead the property needs
to be inverted - indicating the absence of that named feature.

Without the inversion, software that parses "riscv,isa" cannot make any
determination based on the absence of the property - it could be parsing
an old DT that does not have the property or it could be parsing the DT
of a system that does not support the extension.

This is part of why I deprecated `riscv,isa`. It's the same problem as
with "zifencei" et al - does a system with `riscv,isa =3D "rv64imac"`
support fence.i?

Cheers,
Conor.

>=20
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
>  target/riscv/cpu_cfg.h     |  6 ++++++
>  target/riscv/tcg/tcg-cpu.c |  2 ++
>  3 files changed, 43 insertions(+), 7 deletions(-)
>=20
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
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled),
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
> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_ena=
bled),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1512,6 +1521,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
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
> =20
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
> =20
> @@ -2116,13 +2147,10 @@ static const PropertyInfo prop_marchid =3D {
>  };
> =20
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
> =20
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
> =20
> +    cpu->cfg.ext_always_enabled =3D true;
> +
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      riscv_cpu_add_user_properties(obj);
> --=20
> 2.43.0
>=20
>=20

--sE4UzVSkIPWAEx/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc4SuwAKCRB4tDGHoIJi
0ox7AP4k1a1Ayw/O7pHVZcK+gA6rAgE9THhtycdjvw69aPClmwEA/od2X3l6fS5+
JhwfRBpABx2SZUdKPdoL69JhnhYxvQk=
=0yxB
-----END PGP SIGNATURE-----

--sE4UzVSkIPWAEx/7--

