Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F201C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeh7-0006i3-9I; Thu, 15 Feb 2024 11:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1raeh6-0006hn-9s; Thu, 15 Feb 2024 11:34:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1raeh4-0000u3-ED; Thu, 15 Feb 2024 11:34:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AD77761351;
 Thu, 15 Feb 2024 16:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA93C433F1;
 Thu, 15 Feb 2024 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708014876;
 bh=byeTgDdq1/a+n5XW0NesRfgbMgGQVHNLPJin4IqxtnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IBaDD9DLVggZ6k/GohQAAf41SeylBZmaX/IcmAcSq/RtEPwgSDF2uYnWDW+H5Vze7
 cb5EaHjKxYDUsMh+JVUYTArJj5gaDHL7ZZiNgc34yQiX8yRGD//xEp7iOhAvvX15f6
 clxJRUXlcp+P/YlTT0y1v+7SRgpxU21WMAYDFF3Hjc09u1td602MCUm4g/8Bq0vn4P
 fBb5Vtxw9ylHoGO+XnwqShJ+hf7VJ4D+he2KivavB6pGZVQUctR27UXqr4EnumL1NT
 v/FlMcGkxLxkgrw2gwIIXtg3vDM7/KKdMQ1EZvlbn9zYksBSVXIKu6AN1HXyZu2vqJ
 WlqgIoMca7e0Q==
Date: Thu, 15 Feb 2024 16:34:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240215-overhear-paycheck-8c70c17bd151@spud>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
 <20240215-55440212b4d6cde9feab5d94@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aumy3XeCt8vTEnU+"
Content-Disposition: inline
In-Reply-To: <20240215-55440212b4d6cde9feab5d94@orel>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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


--aumy3XeCt8vTEnU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 03:26:18PM +0100, Andrew Jones wrote:
> On Thu, Feb 15, 2024 at 01:33:47PM +0000, Conor Dooley wrote:
> > On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza wrote:
> > > The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> > > until now, we were implying that they were available.
> > >=20
> > > We can't do this anymore since named features also has a riscv,isa
> > > entry. Let's add them to riscv_cpu_named_features[].
> > >=20
> > > Instead of adding one bool for each named feature that we'll always
> > > implement, i.e. can't be turned off, add a 'ext_always_enabled' bool =
in
> > > cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
> > > named features will point to it. This also means that KVM won't see
> > > these features as always enable, which is our intention.
> > >=20
> > > If any accelerator adds support to disable one of these features, we'=
ll
> > > have to promote them to regular extensions and allow users to disable=
 it
> > > via command line.
> > >=20
> > > After this patch, here's the riscv,isa from a buildroot using the
> > > 'rva22s64' CPU:
> >=20
> > Why does an "rva22s64" cpu have "zicclsm" in it? Isn't zicclsm only
> > present in "u" profiles?
>=20
> "s" profiles mandate all the "u" profile mandatory extensions. For example
> 6.2.2 says
>=20
> """
> The RVA22S64 mandatory unprivileged extensions include all the mandatory =
unprivileged
> extensions in RVA22U64.
> """

Doesn't that rule out emulating misaligned access in s-mode if you want
to be profile compliant?

> > >  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> > > rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrs=
e_
> > > zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> > > zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
> >=20
> > I want to raise my frustration with the crock we've been given here by
> > RVI. Any "named feature" that just creates a name for something that
> > already is assumed is completely useless, and DT property that is used
> > to communicate it's presence cannot be used - instead the property needs
> > to be inverted - indicating the absence of that named feature.
> >=20
> > Without the inversion, software that parses "riscv,isa" cannot make any
> > determination based on the absence of the property - it could be parsing
> > an old DT that does not have the property or it could be parsing the DT
> > of a system that does not support the extension.
>=20
> I'm guessing any platform which wants to advertise that it's compliant
> with a profile will update its hardware descriptions to ensure all the
> profile's mandatory extensions are presented. But, I think I understand
> your concern. If somebody is parsing the ISA string as way to determine
> if the platform is compliant with a profile, then they may get a false
> negative due to the ISA string missing a newly named feature.

Nah, you misunderstand me. I don't care at all about profiles or
checking for compliance with one. I'm only interested in how my software
can check that some feature is (or is not) supported. This creating a name
for something implicit business is not a problem in and of itself, but
putting then into "riscv,isa" is a pointless activity as it communicates
nothing.

> I'm not
> sure how much of a problem that will be in practice, though, since testing
> for profile compliance, just for the sake of it, doesn't seem very useful.
> Software really only needs to know which extensions are available and if
> it's an old feature that got newly named, then software likely already
> has another way of detecting it.

Right. That part is fine, but creating extensions for these things we
previously assumed present gives me the impression that creating systems
that do not support these features is valid. IFF that does happen,
removing the string from "riscv,isa" isn't going to be able to
communicate that the feature is unsupported. The commit message here
says:
> > > If any accelerator adds support to disable one of these features, we'=
ll
> > > have to promote them to regular extensions and allow users to disable=
 it
> > > via command line.

Which is part of what prompted me here, since they cannot be handled in
the same way that "regular extensions" are.

> > This is part of why I deprecated `riscv,isa`. It's the same problem as
> > with "zifencei" et al - does a system with `riscv,isa =3D "rv64imac"`
> > support fence.i?
>=20
> Yes, there's a handful of these messy things and the first profiles
> expose them since they're trying to define them. Fingers crossed that
> the next profiles won't have to name old features. FWIW, I at least
> don't see any "This is a new extension name for this feature" notes in
> the RVA23 profile.
>=20
> Thanks,
> drew

--aumy3XeCt8vTEnU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc49FAAKCRB4tDGHoIJi
0nAYAQCmUaLBp8TI0UwxQnX37P/aVNDgTgcMxz579Hkv9r0G2QD8DSttPpndorMm
Tzd7s6wwhRXg1KEAbFe/5evwQO3YYQ0=
=nH1U
-----END PGP SIGNATURE-----

--aumy3XeCt8vTEnU+--

