Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B294C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7z2-00072H-7V; Thu, 05 Jun 2025 06:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1uN7yx-00071p-Ej; Thu, 05 Jun 2025 06:37:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1uN7yt-0006J4-GD; Thu, 05 Jun 2025 06:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202504; t=1749119866;
 bh=Tj5KctCSZIr2LNWvH32eyOQ999psYpoMjtGr3Wzgcdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WV7hSN7nUTGeM4XbaRvUMC5hOiJZO1Q5QuwEoZJQbtDL77i8jBrdpiVt6sd+KaBdO
 81RZiAiXdAWg+GILGwlje+RTTENntn4o0N8t39/TUEoyXE4jimolhDoRjHrOZOxUdn
 U0ii6Ev/ymdRQ4dt2rKzHd7PmW1zZEzpNjnzYxsCk/2Royv4XQLjv6a1pD7t4pVM9K
 AHV688wzHqnzCL5LR/IB0XY/QI7vK59hUrBk5VmvY+td9hmYRCoKKs6bH0iCqQHR86
 AX/MroEJWxxFUW6WvTUuSuWcbMIJzT9EocSbxsje0EndnD3R9F9+3kx4CYBIFD+49U
 iMDGle8niyLAw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4bCgrV4Jp3z4x8S; Thu,  5 Jun 2025 20:37:46 +1000 (AEST)
Date: Thu, 5 Jun 2025 20:25:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Development <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
Subject: Re: ppc kvm: support of 64K guest page size with 4K host pagesize?
Message-ID: <aEFwmU8PRo_SxV4T@zatzit>
References: <0392df3f-c9fc-4372-a131-f0a7c3313c9c@tls.msk.ru>
 <58abce8b-c5c2-4fd1-a32c-2d887445097d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="psDoopDHYiFMTMaf"
Content-Disposition: inline
In-Reply-To: <58abce8b-c5c2-4fd1-a32c-2d887445097d@redhat.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--psDoopDHYiFMTMaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 08:52:44AM +0200, Thomas Huth wrote:
> On 05/06/2025 08.34, Michael Tokarev wrote:
> > There's a bug report filed in debian against qemu,
> > https://bugs.debian.org/1107288 - saying kvm on ppc does not
> > work on debian (anymore) due to qemu requesting unrealistic
> > (non-existing) page size of 64K on a host which only has 4K.
> >=20
> > I don't know much about PPC, - what's the issue here? Should
> > qemu use the same page size for kvm as on the host?
>=20
> Looking at
>=20
>  https://gitlab.com/qemu-project/qemu/-/commit/2309832afdaf8d6451ebc2e81b=
ace8eb8ea41293
>=20
> it seems like this was done on purpose? David, do you remember why
> auto-detecting was not a good idea here?

Because the available page sizes are guest visible.  So if we
auto-detected, guests could be silently migration-incompatible with
the same command line.

> Anyway, seems like there is a hpt-max-page-size property that could be us=
ed
> to set the value manually - maybe you could suggest that to the user as a
> work-around?

Yes, that's what you'll need to do.  We set the default to 64kiB
pages, since at that point 64kiB was the default for all major host
distros, and guests benefit significantly from being able to use 64kiB
pages.  If you want guests compatible with 4kiB page hosts, you need
to use this parameter.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--psDoopDHYiFMTMaf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmhBcIgACgkQzQJF27ox
2GdOxQ/4i9kmeJehEEu95OUHkP3nGFHtc7m57ZyvwJtf8K3OSLmLqc2gL+szxBs2
9Ub+VLizJg4IKhnZ5Ve8JBYjhNRjLRxzUumG60faaUyrbLlfRtfKUTG+XxGu6E9G
Pld/1dqPcORp7VIB9PLcdsvUOFkHrVgD4ZFUiVcz1T+fVsKIb1L2XWaIo3GAudrv
7lpGkTuw1QCLv4IsyTSnjsydwquZvEdgW4iWYHMBvGWh9h9sy+NZoD9tLUxl/rQ8
WemuLc/nMHsteNx4miqW6aL+ImHJV8INq9EZT2aGgr6BL9t9wjPrbKNm2Cca7y4H
QG4reLcFnCqU5lbtqbZRIFVV3GgPMEBxxiN62c0kOoOeBB66PST6LrCm+FYKjXwq
rJlrtsPDZ5NZbr4kPOiSE0kBRs8R7pi45YQunsJWXQ8kDulGx3QgzZ3Lh/gOPIpz
7/lICXuNwsvX+qu2ruFSAdHHLZv41teWNiYusNj9DgTTC/TUhURIyFsEGvy3/1a7
vu+OzGK7+i8HpLYWgTmk6EiOPNmAWwEeaUU1tcXmfUM5ZfMqwDNqd+Xu+g5wzK77
FxFpfseBMrlAElnZw/+cq+xiR7kwGEzhkEwICHMcc5dp3LjpLHLCroCBnoqvQJka
NS09MvSDsNHs/0xqxlTWG/Ja2jULfQzT4HAP0Iovq+j8W0tGQA==
=SWHi
-----END PGP SIGNATURE-----

--psDoopDHYiFMTMaf--

