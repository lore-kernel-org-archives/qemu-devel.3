Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A02C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razpU-00044M-OE; Fri, 16 Feb 2024 10:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1razpS-00040w-2h; Fri, 16 Feb 2024 10:08:42 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1razpQ-0001kk-Ay; Fri, 16 Feb 2024 10:08:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4E1C260C6C;
 Fri, 16 Feb 2024 15:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA336C433C7;
 Fri, 16 Feb 2024 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708096110;
 bh=gCnaKCztZ+aD+uXJOWghdDjln68u/ZHD9+aTBKnA/dM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kemfZ1ZlyFQnDqhz3jpdtiEnY01a60TAAJ5RTL2fjmcecdl+WK/FZAuQ0R57elesE
 aa+XYHkriMQ1g0UseCHLTrVm6Pb/Eeed2CYatXu+xqrsmRV6dib7t/RiYKEiRyjhky
 /GCVBBQFa24jALguttMI8XUwOzin4PCOZ5keDaO/er4IeTVz96e0fEvBFt1Gs/TPFu
 xkhZW2ZzEG0wHIIPQqL1zXh5Kea98PQvKQzgl0xE1mS5z9Znw4LtHcH6Zmfl4PLj7E
 k1ZWFSs6d7DOw7bhy/7pltuDYmZy5kvqONzzetjTCK8mmt++i6cnYR0PUMTICyV7eB
 isFW4Y5hdSeyA==
Date: Fri, 16 Feb 2024 15:08:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240216-fabulous-eraser-ffc4c2ed080f@spud>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
 <20240215-55440212b4d6cde9feab5d94@orel>
 <20240215-overhear-paycheck-8c70c17bd151@spud>
 <20240215-8e556e6029ee11ee7317db8b@orel>
 <20240215-landfall-clamp-34ce9760d4cd@spud>
 <CAKmqyKPy8C9fz2c7RMnFL1bG1XHZf9kdduGOjgTGP+O6PB_fSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R32YE83afCNpLIxc"
Content-Disposition: inline
In-Reply-To: <CAKmqyKPy8C9fz2c7RMnFL1bG1XHZf9kdduGOjgTGP+O6PB_fSg@mail.gmail.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=conor@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
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


--R32YE83afCNpLIxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > No they can't. For a "regular extension" you populate the DT with the
> > extension. For these extensions it has to put negated properties in the
> > DT, otherwise it is incorrectly describing the hardware it is emulating.
> > That is handling them differently in my book! If QEMU generates an
> > incorrect DT representation of the hardware it is emulating, that's a
> > QEMU bug.
>=20
> QEMU listing the extensions that it supports seems to me to be the
> correct approach.
>=20
> It's clunky that the list of "extensions" are constantly changing.
> There isn't much we can do about that from a QEMU perspective though.
>=20
> Listing the hardware and what it supports is the job of the DT.
>=20
> I see your concern about what happens if the "extensions" are disabled
> though. Realislity they probably never will be.

Yeah, it's something we can sweep under the rug unless/until someone
wants to disable these things.

> > > Linux or whatever software consuming
> > > the hardware descriptions may want to distrust the absence of newly
> > > named feature extensions and do their own checks, but that's not QEMU=
's
> > > concern.
> >
> > Software should be able to trust that the DT describes the system
> > correctly. I can only speak for Linux here, but validating the DT is not
> > the job of the running kernel - it should be a correct description.
>=20
> AFAIK the DT is correct. We are describing the hardware within the
> scope of the DT spec.
>=20
> If a new node exists that describes what the hardware does not support
> we can update to support that as well.

It won't be a new node property, it'll just be negated properties - eg
riscv,isa-extensions =3D ..., "no-zicclsm";
That's what I mean when I say that these will not be able to be treated
in the same way as any other extension, but it only applies iff someone
wants to disable them. This isn't just a QEMU problem, but QEMU is the
bleeding edge of "hardware" support, so it's cropping up here first (or
maybe only :))

> > > Actually, being able to disable these newly named features allows
> > > Linux and other software to test how they behave when the feature goes
> > > away.
> >
> > That's helpful sure, but it doesn't absolve QEMU of having to correctly
> > generate a DT.
>=20
> I'm pretty sure there isn't anything for us to do differently here
> right? It's just a bad situation that we are trying to support.

Until someone wants to turn them off, you can avoid doing anything
differently, just like this amazing ascii art I found:

                _,-\/-,_
                \      /
                 \_.._/
               _,/    \,_
              / \      / \
             ,\  )    (  /,
             (__/ .''. \__)
                \,_||   /
                |  ||\ |
                | /|| \|
                () || ()
                // || ||
               //  || ||
              //   || ||
             //    || /\
 -- '' -'-' ^^'    )( '^^-- '' -'-'   miK
                  (=3D=3D)
                   `~`

Hopefully posting ostriches on the QEMU list isn't grounds for a ban,
Conor.

--R32YE83afCNpLIxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc96aQAKCRB4tDGHoIJi
0nJNAQCNPVcftYNWpE3Q7HB6nixeHO3Ew9afcv+enPMmEsuxXQEAnUYcqY9fWGvL
jwEXGpinzCh+0UGEE+cSxUxM+DEpLAg=
=Ma6n
-----END PGP SIGNATURE-----

--R32YE83afCNpLIxc--

