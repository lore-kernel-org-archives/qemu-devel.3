Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB1C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahtN-0000m0-5Y; Thu, 15 Feb 2024 14:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rahtK-0000lm-0q; Thu, 15 Feb 2024 14:59:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rahtI-0002fL-2Q; Thu, 15 Feb 2024 14:59:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3E84061DDD;
 Thu, 15 Feb 2024 19:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDABC433F1;
 Thu, 15 Feb 2024 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708027165;
 bh=fEumsLCTkeyuNmwrUdb3Lea6c4J3u1qZcZTeEDo8Cu8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tDYUdadX8bneJctjDDWVlBpbGaQ6qRLwvb2mXb/zfX6VWYRrWTjVzJZAhuHkqntJG
 MzbqgLFAdSeWKjDQ7IEDHGHcmXIIF5+DpyhvQquu8We99r/KUZRaVQ5k9XayEqm2ej
 Ou9ozUM1p+9QnilFOZ0CV933Xz9y9y10y4I1gai4KKo9DYiyWC7HzQ4YHcBFKXdVIh
 zk9SBfANWG659E23e17rQpFoCGsLrm/YF3gvcbfa5b1uJLgNXLlF9ndifHE3w+y7Al
 3sMtryj045zfoFTA4PrnWRPAebXKBcKPAGXG+Yod8nkyror/F/xyTzU8biX/DDTFd2
 Jt8WU/2vN0xQQ==
Date: Thu, 15 Feb 2024 19:59:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240215-landfall-clamp-34ce9760d4cd@spud>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
 <20240215-55440212b4d6cde9feab5d94@orel>
 <20240215-overhear-paycheck-8c70c17bd151@spud>
 <20240215-8e556e6029ee11ee7317db8b@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fafYqRJv5bUOxB7s"
Content-Disposition: inline
In-Reply-To: <20240215-8e556e6029ee11ee7317db8b@orel>
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


--fafYqRJv5bUOxB7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 08:11:45PM +0100, Andrew Jones wrote:
> On Thu, Feb 15, 2024 at 04:34:32PM +0000, Conor Dooley wrote:
> > On Thu, Feb 15, 2024 at 03:26:18PM +0100, Andrew Jones wrote:
> > > On Thu, Feb 15, 2024 at 01:33:47PM +0000, Conor Dooley wrote:
> > > > On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza w=
rote:
> > > > > The RVA22U64 and RVA22S64 profiles mandates certain extensions th=
at,
> > > > > until now, we were implying that they were available.
> > > > >=20
> > > > > We can't do this anymore since named features also has a riscv,isa
> > > > > entry. Let's add them to riscv_cpu_named_features[].
> > > > >=20
> > > > > Instead of adding one bool for each named feature that we'll alwa=
ys
> > > > > implement, i.e. can't be turned off, add a 'ext_always_enabled' b=
ool in
> > > > > cpu->cfg. This bool will be set to 'true' in TCG accel init, and =
all
> > > > > named features will point to it. This also means that KVM won't s=
ee
> > > > > these features as always enable, which is our intention.
> > > > >=20
> > > > > If any accelerator adds support to disable one of these features,=
 we'll
> > > > > have to promote them to regular extensions and allow users to dis=
able it
> > > > > via command line.
> > > > >=20
> > > > > After this patch, here's the riscv,isa from a buildroot using the
> > > > > 'rva22s64' CPU:
> > > >=20
> > > > Why does an "rva22s64" cpu have "zicclsm" in it? Isn't zicclsm only
> > > > present in "u" profiles?
> > >=20
> > > "s" profiles mandate all the "u" profile mandatory extensions. For ex=
ample
> > > 6.2.2 says
> > >=20
> > > """
> > > The RVA22S64 mandatory unprivileged extensions include all the mandat=
ory unprivileged
> > > extensions in RVA22U64.
> > > """
> >=20
> > Doesn't that rule out emulating misaligned access in s-mode if you want
> > to be profile compliant?
>=20
> That's how I interpret it, but I'll defer to a profile spec author, or
> at least to somebody more confident of their spec interpretation skills.

Hmm, actually it doesn't. Your firmware just needs to _also_ implement
it. So your OS kernel could test whether or not the misaligned access
performance is beans and then choose to emulate misaligned access
itself. Not ideal, but better than I thought.

> > > > >  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> > > > > rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_zi=
ccrse_
> > > > > zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba=
_zbb_
> > > > > zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
> > > >=20
> > > > I want to raise my frustration with the crock we've been given here=
 by
> > > > RVI. Any "named feature" that just creates a name for something that
> > > > already is assumed is completely useless, and DT property that is u=
sed
> > > > to communicate it's presence cannot be used - instead the property =
needs
> > > > to be inverted - indicating the absence of that named feature.
> > > >=20
> > > > Without the inversion, software that parses "riscv,isa" cannot make=
 any
> > > > determination based on the absence of the property - it could be pa=
rsing
> > > > an old DT that does not have the property or it could be parsing th=
e DT
> > > > of a system that does not support the extension.
> > >=20
> > > I'm guessing any platform which wants to advertise that it's compliant
> > > with a profile will update its hardware descriptions to ensure all the
> > > profile's mandatory extensions are presented. But, I think I understa=
nd
> > > your concern. If somebody is parsing the ISA string as way to determi=
ne
> > > if the platform is compliant with a profile, then they may get a false
> > > negative due to the ISA string missing a newly named feature.
> >=20
> > Nah, you misunderstand me. I don't care at all about profiles or
> > checking for compliance with one. I'm only interested in how my software
> > can check that some feature is (or is not) supported. This creating a n=
ame
> > for something implicit business is not a problem in and of itself, but
> > putting then into "riscv,isa" is a pointless activity as it communicates
> > nothing.
> >=20
> > > I'm not
> > > sure how much of a problem that will be in practice, though, since te=
sting
> > > for profile compliance, just for the sake of it, doesn't seem very us=
eful.
> > > Software really only needs to know which extensions are available and=
 if
> > > it's an old feature that got newly named, then software likely already
> > > has another way of detecting it.
> >=20
> > Right. That part is fine, but creating extensions for these things we
> > previously assumed present gives me the impression that creating systems
> > that do not support these features is valid. IFF that does happen,
> > removing the string from "riscv,isa" isn't going to be able to
> > communicate that the feature is unsupported.
>=20
> Ah, now I think I understand the concern. The new names might as well be
> ignored because the absence of the names in the hardware descriptions is
> ambiguous.

Correct.

> I guess I'd encourage software that has a role in advertising
> features to use the new names when it has detected the feature or assumes
> the feature is present (and presumably wouldn't be running if its
> assumption was wrong). If, for example, Linux puts a new name in
> /proc/cpuinfo after detecting or assuming the feature's presence, then it
> no longer matters that the hardware description had it or not from the
> perspective of the /proc/cpuinfo consumer (assuming they're aware of which
> kernel version they need). With these types of fixups and enough time,
> then hopefully most of the software ecosystem will able to live in
> ignorant bliss.

Yeah, that's effectively what we have to do. I started doing that for
zifencei/zicsr in Linux and it should be done for anything else like
this going forwards.

> > The commit message here
> > says:
> > > > > If any accelerator adds support to disable one of these features,=
 we'll
> > > > > have to promote them to regular extensions and allow users to dis=
able it
> > > > > via command line.
> >=20
> > Which is part of what prompted me here, since they cannot be handled in
> > the same way that "regular extensions" are.
> >
>=20
> From QEMU's perspective, they can.

No they can't. For a "regular extension" you populate the DT with the
extension. For these extensions it has to put negated properties in the
DT, otherwise it is incorrectly describing the hardware it is emulating.
That is handling them differently in my book! If QEMU generates an
incorrect DT representation of the hardware it is emulating, that's a
QEMU bug.

> Linux or whatever software consuming
> the hardware descriptions may want to distrust the absence of newly
> named feature extensions and do their own checks, but that's not QEMU's
> concern.

Software should be able to trust that the DT describes the system
correctly. I can only speak for Linux here, but validating the DT is not
the job of the running kernel - it should be a correct description.

> Actually, being able to disable these newly named features allows
> Linux and other software to test how they behave when the feature goes
> away.

That's helpful sure, but it doesn't absolve QEMU of having to correctly
generate a DT.

Thanks,
Conor.

--fafYqRJv5bUOxB7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5tGQAKCRB4tDGHoIJi
0kBiAP0RrBniPMsTit5E1kEhzcJTWi8cPLPwYa2I3VgzMDsnsQD9G7LqRRnseV7/
2852nwgi4wt7ya+PkhReHSafHAG5sgs=
=VK7h
-----END PGP SIGNATURE-----

--fafYqRJv5bUOxB7s--

