Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D2C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 03:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNOaW-0005yC-Mk; Fri, 28 Jun 2024 23:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sNOaS-0005xh-Dl; Fri, 28 Jun 2024 23:17:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sNOaP-0000SE-4a; Fri, 28 Jun 2024 23:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1719631022;
 bh=svsz9t9l6BV8IaHz/hbrUKKdWyTODCgzFcZwMdPR3NM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nGzrmb4Y8eKyI3J97FCeyqE4Trqh/zZ5zBUdKmw8A+kF1XxkCCZp5O/D5YdO3apjr
 UcuRYwmwJIliX+jFxArkzpjzFHw/oeH+zXr2LNQLrG38DmDw9FhelwljY0fIDLffO7
 MGYOKsE72WKdAAXEz3WsT9oi0BTFlVpJWCLtPe11TvHBaVHUmzTT0t1tZW29bLhXSm
 ar8j6rGRiwSB6niB3pPXH49L/Rbk8+ZQMu/GAKc7WFKnyykcBdYqGfANShFF00cHEK
 7oEZ11zEmRJ7VGchnE14JkhzBSwz9hKVfA5awaD9IyHaHYoXU1YdhXhhAX4rcfw+vL
 IPMHXCSKRNCEw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4W9yCL4PbJz4wcp; Sat, 29 Jun 2024 13:17:02 +1000 (AEST)
Date: Sat, 29 Jun 2024 13:16:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
Message-ID: <Zn98p6CUV0KnIo50@zatzit>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uByDBBz2VfSWi6Io"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--uByDBBz2VfSWi6Io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> wr=
ote:
> >
> > FDT properties are aligned by 4 bytes, not 8 bytes.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  hw/ppc/vof.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > index e3b430a81f4f..b5b6514d79fc 100644
> > --- a/hw/ppc/vof.c
> > +++ b/hw/ppc/vof.c
> > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArr=
ay *claimed, uint64_t base)
> >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac + sc));
> >      if (sc =3D=3D 2) {
> > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint3=
2_t) * ac));
> > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> >      } else {
> >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint3=
2_t) * ac));
> >      }
>=20
> I did wonder if there was a better way to do what this is doing,
> but neither we (in system/device_tree.c) nor libfdt seem to
> provide one.

libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
not an automatic aligned-or-unaligned helper.   Maybe we should add that?

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--uByDBBz2VfSWi6Io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmZ/fKEACgkQzQJF27ox
2Gf9tQ/+Ojar9AtFdH8w3RzmJOKc9vULAiIp89cew+c/GVW836yu1WO52ER00aca
9xoVPSSytcpcUnp35kjR2LC2nrihUvU7ZqZL+U/VkaoR9hE+BGArv2GsxzrIhOZk
C3cl4+5wd5OI0EfGqiR+FQRY70uLHxEqAdIlafltavle+uWBFhcRViLqXopFwCn6
KmF+wShrFmYAxrv16CMFKZq+cdT/8y/PptO+GyIxwwAHEO9/8Wm14dKDIX4sOWmU
qDUA76v5TRy7TX6EEP26YsfQMEtVHWNYtBplQRvjfHXMckR4E0zAYPoyWYKkE4Ah
Sr0vVdKUgx3Jhnv17h6lhcizhPB5HRvbgoUBnAvbkT1nzWU3a/q1Ccyf+8/Xn+eY
5+0kpNdYVk5XRbLHutsQcw1ZVMI8wSHUMoeBsRip35M46cVM7/m/RbKBN4HDQNcu
tMUL9YFbf1tzwb9jgIGw/+MX5z+iatj7oVJ9oJvCaVkJ/rh6IHvzoWtnucJ+Ipej
wP/Ih3DFMFyFfewZDo51XlEqRiwoFidoc/fuDUTvvqoCcNOqhqzOBtvvAEKKk06t
VMUQmBbB6O9SeAL3jBeltfZ/tHM0TDUW0o04QUUsVe9UjGI+koqippjB54kRQTTE
ALpGdZkOmglWg306F/G3/lbdmmqv7yHH216yhzAeTm3vi+no8eM=
=dqPa
-----END PGP SIGNATURE-----

--uByDBBz2VfSWi6Io--

