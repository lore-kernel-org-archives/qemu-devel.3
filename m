Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64687C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSd4F-0004Xe-A2; Wed, 24 Jan 2024 08:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1rSd4A-0004XI-0O
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:13:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1rSd48-0004q5-EZ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:13:17 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C059E61D2D;
 Wed, 24 Jan 2024 13:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0589C433F1;
 Wed, 24 Jan 2024 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706101994;
 bh=KGeZvlAqiPq+tIJnrTOUt/sJCpygyPMHbqd2idZAwa8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Byu477HZlSIFcbqSozjxnoNGiIStzdaoUwlqBIPvBghMziwQ3To0TtuU5PDPu47Qe
 cGgvlRrYwDNvmPNGkeKdrgf452ysWpKfyl+XUtfv7mUcmP7T8X896SIY2yHGXPr2/1
 ZwatBMeO2MEgp6b79QkvSUqbVYBYNenfGvGVVnAwL6aAyTNIWKqeTERPAb7gWONcqU
 xd5wgPey5RVQVbgM8DiOaaiuNcOtPxLt4eZztMvvqGTgsUVFM7ipJJI1Ty5FVVUxnt
 s4hGv6zcQlgkUk2pYjM7Xe7pHjXy30CNIt6FAhue6XKWyiQlYWAyeuz4RC/CWWU4WG
 Fkd3OBZvXtFUg==
Date: Wed, 24 Jan 2024 13:13:10 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: qemu riscv, thead c906, Linux boot regression
Message-ID: <20240124-sliceable-atom-c87a10922d4b@spud>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="50gCHqVI7AApEjFm"
Content-Disposition: inline
In-Reply-To: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--50gCHqVI7AApEjFm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 01:49:51PM +0100, Bj=F6rn T=F6pel wrote:
> Hi!
>=20
> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
> ("target/riscv/cpu.c: restrict 'marchid' value")
>=20
> Reverting that commit, or the hack below solves the boot issue:
>=20
> --8<--
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781ad..e18596c8a55a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>      cpu->cfg.ext_xtheadsync =3D true;
> =20
>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
> +    cpu->cfg.marchid =3D ((QEMU_VERSION_MAJOR << 16) |
> +                        (QEMU_VERSION_MINOR << 8)  |
> +                        (QEMU_VERSION_MICRO));
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>  #endif
> --8<--
>=20
> I'm unsure what the correct qemu way of adding a default value is,
> or if c906 should have a proper marchid.

The "correct" marchid/mimpid values for the c906 are zero.

I haven't looked into the code at all, so I am "assuming" that it is
being zero intialised at present. Linux applies the errata fixups for
the c906 when archid and impid are both zero - so your patch will avoid
these fixups being applied.
Do you think that perhaps the emulation in QEMU does not support what
the kernel uses once then errata fixups are enabled?

>=20
> Maybe Christoph or Zhiwei can answer?
>=20
> qemu command-line:
> qemu-system-riscv64 -nodefaults -nographic -machine virt,acpi=3Doff \
>    -cpu thead-c906 ...
>=20
>=20
> Thanks,
> Bj=F6rn
>=20

--50gCHqVI7AApEjFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbEM5gAKCRB4tDGHoIJi
0pdeAQDubx/QpNR/H7YLx9BAU3JO3EpMscsk9nuvi9pbRDm0IAEA0HpPoxl00Yh8
+8Jk59KPWEYS/6r5QgUGDUnNUM5I+QE=
=oxK+
-----END PGP SIGNATURE-----

--50gCHqVI7AApEjFm--

