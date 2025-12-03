Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446ABD15DBA
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqPy-0000S9-Fd; Wed, 03 Dec 2025 12:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vQqPw-0000R0-Dv; Wed, 03 Dec 2025 12:13:28 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vQqPu-0001KS-Vu; Wed, 03 Dec 2025 12:13:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A462601D7;
 Wed,  3 Dec 2025 17:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A7FC4CEF5;
 Wed,  3 Dec 2025 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764782005;
 bh=QKosJsJ+PH1IpgVJCD8295w/GhmwIEZwbIOQEDWHzGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Eu18b5qzoEzaOrS6fzT7V7VJCZPiFHgUWv1UJiRUeZyBb/iURpBK29DHFkGnKryf6
 VgALdzBzpn8zaPofzAG+GuuSB4MaOFIvN3Vizc5rfQ9KkfzREQnIvJzA2Uuh34+ptf
 NKNoCSH0G6wYp+huL5qgUUMYZIDSEyXKAbM4a/CUPuKIYlHmXl6kqwoWwagpQwYpTZ
 WuaIn+3Qeww0ZsN8f3XaUv/ttBaLSJkY68scrkZ6dvO1+EeEaPNgGKq3zWnGk62cmx
 vKriZH5NGxYIHDNVqVXYUTt7zsP36L3oFpZ0M3PMjcCBIRk0/gbkRxsnoRUF8vDZ2E
 FPEEdGrNimxLg==
Date: Wed, 3 Dec 2025 17:13:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Chao Liu <chao.liu@zevorn.cn>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com,
 npiggin@gmail.com, ebiggers@kernel.org, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, chao.liu@openatom.club,
 hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH v1 1/5] target/riscv: add thead-c908 cpu support
Message-ID: <20251203-huskiness-manhandle-6925834ee8f0@spud>
References: <cover.1764493931.git.chao.liu@zevorn.cn>
 <c27edc69ea6642f645d5e194bd5d4cd71e812841.1764493931.git.chao.liu@zevorn.cn>
 <20251203-squiggle-gentile-f27af704359e@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9zPvfdW1oYB+IMLu"
Content-Disposition: inline
In-Reply-To: <20251203-squiggle-gentile-f27af704359e@spud>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=conor@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--9zPvfdW1oYB+IMLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 05:12:37PM +0000, Conor Dooley wrote:
> On Sun, Nov 30, 2025 at 05:21:06PM +0800, Chao Liu wrote:
> > The C908 processor is based on the RV64GCB[V] instruction
> > set, compatible to RVA22 Profile and implements the XIE
> > (XuanTie Instruction Extension) technology.
> >=20
> > Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
> > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > ---
> >  target/riscv/cpu-qom.h |   2 +
> >  target/riscv/cpu.c     |  43 +++++
> >  target/riscv/th_csr.c  | 380 ++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 424 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> > index 75f4e43408..1ddb5a6a6c 100644
> > --- a/target/riscv/cpu-qom.h
> > +++ b/target/riscv/cpu-qom.h
> > @@ -52,6 +52,8 @@
> >  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u3=
4")
> >  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u5=
4")
> >  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c90=
6")
> > +#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c90=
8")
> > +#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c90=
8v")
> >  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1=
")
> >  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalo=
n")
> >  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan=
-nanhu")
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index d055ddf462..202ff130ee 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -3091,6 +3091,49 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
> >  #endif
> >      ),
> > =20
> > +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
> > +        .misa_mxl_max =3D MXL_RV64,
> > +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> > +        .priv_spec =3D PRIV_VERSION_1_12_0,
> > +
> > +        /* ISA extensions */
> > +        .cfg.ext_xtheadba =3D true,
> > +        .cfg.ext_xtheadbb =3D true,
> > +        .cfg.ext_xtheadbs =3D true,
> > +        .cfg.ext_xtheadcmo =3D true,
> > +        .cfg.ext_xtheadcondmov =3D true,
> > +        .cfg.ext_xtheadmac =3D true,
> > +        .cfg.ext_xtheadmemidx =3D true,
> > +        .cfg.ext_xtheadmempair =3D true,
> > +        .cfg.ext_xtheadsync =3D true,
> > +        .cfg.ext_zba =3D true,
> > +        .cfg.ext_zbb =3D true,
> > +        .cfg.ext_zbc =3D true,
> > +        .cfg.ext_zbs =3D true,
> > +        .cfg.ext_zkt =3D true,
> > +        .cfg.ext_zbkc =3D true,
> > +        .cfg.ext_zicsr =3D true,
> > +        .cfg.ext_zifencei =3D true,
> > +        .cfg.ext_zihintpause =3D true,
> > +        .cfg.ext_zicbom =3D true,
> > +        .cfg.ext_zicboz =3D true,
> > +        .cfg.ext_zfh =3D true,
> > +        .cfg.ext_xtheadfmv =3D true,
> > +        .cfg.ext_xtheadfmemidx =3D true,
> > +        .cfg.pmp =3D true,
>=20
> I think Svpbmt is missing here, both it and the T-Head MAEE stuff are
> supported on the k230. What I will end up merging into mainline for the

Whoops, should have specified that I meant the mainline linux kernel.

> k230 uses Svpbmt instead of MAEE.



--9zPvfdW1oYB+IMLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTBvrwAKCRB4tDGHoIJi
0uQsAQDkLHPMMB5L5s4oVzRTZPzszpJNt/inp+mD1gl7ujOF/QEAjIoZarqjBsd6
zHEAs6iZ1eKMs+axCE39/NM+keabugQ=
=+iFv
-----END PGP SIGNATURE-----

--9zPvfdW1oYB+IMLu--

