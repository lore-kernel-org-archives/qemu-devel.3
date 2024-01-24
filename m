Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20497C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSddF-0002mS-3v; Wed, 24 Jan 2024 08:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1rSdd7-0002fk-Rg
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:49:27 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1rSdd4-0004HS-VQ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:49:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E615161D44;
 Wed, 24 Jan 2024 13:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DE3C433F1;
 Wed, 24 Jan 2024 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706104156;
 bh=Hbu03H2eAZDQJTRnpJ27e4m4VHvK8aE2vA+Htsf4E9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ptHY/JzywnyvN9r+npERvLBahgBT4/pIA/blCBOR97dm8dzkFS2GFjgupEw3+tOHg
 4u82NO6U+bKbIuDUjX4+2DG0/A2ZC0FKgFrOKZzi2xYcsakq4J64Kh3lkwNVusc9Tf
 J1jmajD6+qHxJp75axllpZEnYAnWSS5LCpJ6+i1cv13HPHKmB1aGx4AJxGqakikIB0
 t+b58TcoA9mkhyyT7ImjGVaiUAWOp0tF1ScQYiTnM5INZt9vjyv/neX5G+cLYSbtyy
 ZfcbSO1JhlmAip992eitkBFyJMxZHuZXtoLI9LM4K7bh6lRZ3sBG+/H5wxEdS9pzJp
 LiAMKXvUBYOpg==
Date: Wed, 24 Jan 2024 13:49:12 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: qemu riscv, thead c906, Linux boot regression
Message-ID: <20240124-disarm-couch-bb8b96b62898@spud>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
 <20240124-sliceable-atom-c87a10922d4b@spud>
 <871qa6yi8h.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mtHz7+QrxFH7I2eq"
Content-Disposition: inline
In-Reply-To: <871qa6yi8h.fsf@all.your.base.are.belong.to.us>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=conor@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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


--mtHz7+QrxFH7I2eq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 02:27:10PM +0100, Bj=F6rn T=F6pel wrote:
> Conor Dooley <conor@kernel.org> writes:
>=20
> > On Wed, Jan 24, 2024 at 01:49:51PM +0100, Bj=F6rn T=F6pel wrote:
> >> Hi!
> >>=20
> >> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized th=
at
> >> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
> >> ("target/riscv/cpu.c: restrict 'marchid' value")
> >>=20
> >> Reverting that commit, or the hack below solves the boot issue:
> >>=20
> >> --8<--
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index 8cbfc7e781ad..e18596c8a55a 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
> >>      cpu->cfg.ext_xtheadsync =3D true;
> >> =20
> >>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
> >> +    cpu->cfg.marchid =3D ((QEMU_VERSION_MAJOR << 16) |
> >> +                        (QEMU_VERSION_MINOR << 8)  |
> >> +                        (QEMU_VERSION_MICRO));
> >>  #ifndef CONFIG_USER_ONLY
> >>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> >>  #endif
> >> --8<--
> >>=20
> >> I'm unsure what the correct qemu way of adding a default value is,
> >> or if c906 should have a proper marchid.
> >
> > The "correct" marchid/mimpid values for the c906 are zero.
>=20
> Ok! Thanks for clearing that up for me.
>=20
> > I haven't looked into the code at all, so I am "assuming" that it is
> > being zero intialised at present. Linux applies the errata fixups for
> > the c906 when archid and impid are both zero - so your patch will avoid
> > these fixups being applied.
>=20
> I'm also assuming 0, -- will double-check. Hmm, that means that the
> *previous* marchid was incorrect (pre d6a427e2c0b2).
>=20
> > Do you think that perhaps the emulation in QEMU does not support what
> > the kernel uses once then errata fixups are enabled?
>=20
> Did a quick look at the c906 "in_asm,int" logs:
>=20
> | 0x80201040:  12000073          sfence.vma              zero,zero
> | 0x80201044:  18051073          csrrw                   zero,satp,a0
> |=20
> | riscv_cpu_do_interrupt: hart:0, async:0, cause:000000000000000c, epc:0x=
0000000080201048, tval:0x0000000080201048, desc=3Dexec_page_fault
> | riscv_cpu_do_interrupt: hart:0, async:0, cause:000000000000000c, epc:0x=
ffffffff80001048, tval:0xffffffff80001048, desc=3Dexec_page_fault
> | ...cont forever
>=20
> So it looks like we're tripping over the page tables, when we're turning
> on paging.
>=20
> Hmm, maybe it's not qemu, but the c906 that has been broken for a while?

I didn't know what you mean by "not qemu, but the c906", so I went and
boot tested my d1 nezha. On today's next (6.8.0-rc1-next-20240124) it
booted into my initramfs with no problems. Obivously though my config is
unlikely to match yours, but that seems like a core thing that should be
hit regardless of config.
So perhaps this is a c906-in-QEMU problem? Lacking emulation for
something the kernel uses perhaps? I know nothing about the capabilities
of its emulation in QEMU, so I am of no help.

Cheers,
Conor.

>=20
> I'll disable it temporarily from CI anyhow, and will continue digging.
>=20
>=20
> Thanks for the pointers/clarifications, Conor!
> Bj=F6rn
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--mtHz7+QrxFH7I2eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbEVWAAKCRB4tDGHoIJi
0ssbAQDUibEblOKMmRO73UIweV16Yt0iOJZksiLIcDl55I33QQEA+83TMPm1lYZV
VYsbjILAHOezIJ7QGzQwyTAq6oQvUAM=
=Y6P5
-----END PGP SIGNATURE-----

--mtHz7+QrxFH7I2eq--

