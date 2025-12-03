Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4029D15DBA
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqPN-0000J7-NF; Wed, 03 Dec 2025 12:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vQqPL-0000IZ-Hr; Wed, 03 Dec 2025 12:12:52 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vQqPI-0001Da-I8; Wed, 03 Dec 2025 12:12:51 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 797CE601DC;
 Wed,  3 Dec 2025 17:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512D0C4CEF5;
 Wed,  3 Dec 2025 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764781957;
 bh=3WTRkf3GlSqgtBAy33D1bjFm0iWySG+dnJSaVu5FUKU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aefp2B0znl8oor2pXVOjMkKexyjvMUUIEzGXsEffXJd5yjDJxjVyVtPZGxoXC1JSi
 mHJ5NRFejXNTpDQSgcipmNbwLzymGoNu0VWwFfEsrE1HrO3Esxh5X0+CAzUacCg3cw
 9fhRlcV/JoCmFZa5TnTaU0L3JNriualD77PGwG4kxj0xad5j9KeJ70Y7CHdnL9EOOZ
 w601nEBMI/ns1sgtlSU2x04GImpSe15cbiVxTSFdPPrn4sGIqLjGsDaxICgqFuj1eb
 Ss8y6OT5Wemp6gJUtjJ2WGlT4ANmCarbzTKfivKb6iN8vvzMCp/xeBnxKi4u/uAvz5
 aHowihTFe6s0g==
Date: Wed, 3 Dec 2025 17:12:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Chao Liu <chao.liu@zevorn.cn>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com,
 npiggin@gmail.com, ebiggers@kernel.org, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, chao.liu@openatom.club,
 hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH v1 1/5] target/riscv: add thead-c908 cpu support
Message-ID: <20251203-squiggle-gentile-f27af704359e@spud>
References: <cover.1764493931.git.chao.liu@zevorn.cn>
 <c27edc69ea6642f645d5e194bd5d4cd71e812841.1764493931.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QmpobU8mUIFLByX1"
Content-Disposition: inline
In-Reply-To: <c27edc69ea6642f645d5e194bd5d4cd71e812841.1764493931.git.chao.liu@zevorn.cn>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--QmpobU8mUIFLByX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 05:21:06PM +0800, Chao Liu wrote:
> The C908 processor is based on the RV64GCB[V] instruction
> set, compatible to RVA22 Profile and implements the XIE
> (XuanTie Instruction Extension) technology.
>=20
> Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
> Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/cpu-qom.h |   2 +
>  target/riscv/cpu.c     |  43 +++++
>  target/riscv/th_csr.c  | 380 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 424 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..1ddb5a6a6c 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -52,6 +52,8 @@
>  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
>  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
>  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
> +#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c908")
> +#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v=
")
>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..202ff130ee 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3091,6 +3091,49 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
> =20
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +
> +        /* ISA extensions */
> +        .cfg.ext_xtheadba =3D true,
> +        .cfg.ext_xtheadbb =3D true,
> +        .cfg.ext_xtheadbs =3D true,
> +        .cfg.ext_xtheadcmo =3D true,
> +        .cfg.ext_xtheadcondmov =3D true,
> +        .cfg.ext_xtheadmac =3D true,
> +        .cfg.ext_xtheadmemidx =3D true,
> +        .cfg.ext_xtheadmempair =3D true,
> +        .cfg.ext_xtheadsync =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_zkt =3D true,
> +        .cfg.ext_zbkc =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zihintpause =3D true,
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zfh =3D true,
> +        .cfg.ext_xtheadfmv =3D true,
> +        .cfg.ext_xtheadfmemidx =3D true,
> +        .cfg.pmp =3D true,

I think Svpbmt is missing here, both it and the T-Head MAEE stuff are
supported on the k230. What I will end up merging into mainline for the
k230 uses Svpbmt instead of MAEE.

--QmpobU8mUIFLByX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTBvfwAKCRB4tDGHoIJi
0mwkAQCdXFE/VA2Ft19HOaDYpYuCAtnqGLlW+vsbpVHwZYSuGAD/TYIvaeQ+5TOa
MDnZgxFPlyjxMCqRYdDvaJUb4rDcyg0=
=ozIv
-----END PGP SIGNATURE-----

--QmpobU8mUIFLByX1--

