Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D891BC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 21:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfzw-00015g-IM; Mon, 24 Feb 2025 16:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1tmfzr-00014m-Uy; Mon, 24 Feb 2025 16:28:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1tmfzp-0007Yt-NE; Mon, 24 Feb 2025 16:28:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 47ABD5C587E;
 Mon, 24 Feb 2025 21:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7254BC4CED6;
 Mon, 24 Feb 2025 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740432486;
 bh=+D+WFyVjBDCk8mvjOJUHIvKZrTaATWd2TnTdmtWsn+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CAlkiDJn/A3ahFkCB3IUYmx4cSr9U5HR/kgN6R5QqsdyFVwhZGmDUVHkFs/oKx2I9
 zFGwZXtyd5504D1i6RJ1wEDy/XMRIelEcuNttrsAGnr5bHA8w4O6Xwhhqvy1lmyS3b
 9TFJC4qrcAzgdLQ2BoX7c34e6Ik+ZpgCkL6k80FBde4rZrbCeSDTVbTcnOETsZNvJg
 Bivg/zRclS5pMxvv7DJJZWIqeUVo2J6KLUYKNeeUddtTgcijZ7SgO/WhZ/wNRUsARw
 IMeZWm2AD/y1fTvwzvGKRIrrI6V6CCDo8ZuuqBN/K/v5sXwwvmeW8yOlc+/XQUnd5s
 334PxPcX4DxLA==
Date: Mon, 24 Feb 2025 21:28:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Sebastian Huber <sebastian.huber@embedded-brains.de>,
 qemu-devel@nongnu.org, Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>, alistair.francis@wdc.com,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH 0/5] Improve Microchip Polarfire SoC customization
Message-ID: <20250224-ignition-afternoon-9d4996362813@spud>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250220-reggae-hardness-907e385516d8@spud>
 <CAKmqyKNex8vQuT3ArR3gePfGfeLCZbW0DxzD9dz8oNAODE8sbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oCUJ5cCTfKbjgqOZ"
Content-Disposition: inline
In-Reply-To: <CAKmqyKNex8vQuT3ArR3gePfGfeLCZbW0DxzD9dz8oNAODE8sbw@mail.gmail.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--oCUJ5cCTfKbjgqOZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 03:14:00PM +1000, Alistair Francis wrote:
> On Fri, Feb 21, 2025 at 4:31=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > +cc qemu-riscv, Alistar.
> >
> > On Fri, Feb 14, 2025 at 07:24:37AM +0100, Sebastian Huber wrote:
> > > Booting the microchip-icicle-kit machine using the latest PolarFire S=
oC
> > > Hart Software Services (HSS) no longer works since Qemu lacks support
> > > for several registers (clocks, DRAM controller). Also reading from the
> > > SDCard does not work currently.
> >
> > On that note, I think the inaccurate docs about polarfire should be
> > removed. There's a wiki page here with dead links, or links to things
> > that do not work anymore:
> > https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire=
_SoC_Icicle_Kit
> > I think the whole section should be removed, find it kinda odd that
> > there's a polarfire section but not for any other board. Either way,
> > it's talking about something that just does not work, the current HSS
> > and Yocto don't boot.
>=20
> The wiki is independent of the QEMU code base, so you can modify it. I
> agree that we should remove outdated/wrong information as it's very
> confusing to users.

I don't have an account to make the modification, any clue who has one
and can hook me up with one?

> > There's also a docs page here:
> > https://www.qemu.org/docs/master/system/riscv/microchip-icicle-kit.html
>=20
> That is generated from the QEMU codebase
> `docs/system/riscv/microchip-icicle-kit.rst` and should be updated,
> ideally with this patch set

Ye, I think so too.

> > that has a copy of the table your patch 4 modifies, that probably should
> > be updated to match your changes.
> >
> > In a similar vein to the wiki, it talks about the HSS and booting a
> > yocto wic image. I think those should be deleted since they don't work.

--oCUJ5cCTfKbjgqOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7zkYwAKCRB4tDGHoIJi
0jG6AP416IdNUIKPfSRwoJIbECDq6tO7Neh/MIDAM3nym8ItZwEAtHdu8QhPRhpp
qt/Gn1tnaT7bUssLu77fRN+Lq1WCSwE=
=6Mbk
-----END PGP SIGNATURE-----

--oCUJ5cCTfKbjgqOZ--

