Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBAAC30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYMW-0006dk-MQ; Thu, 04 Jul 2024 22:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sPYMT-0006c6-7s; Thu, 04 Jul 2024 22:07:45 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sPYMQ-0000GB-JE; Thu, 04 Jul 2024 22:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1720145250;
 bh=9TY8OzjLg5dvNEnqa/AJm+CxMGhLLtdC1z5QlJXJ2b8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dvP/ba2FWNY7KvBwc1eAMjbC/mrmrisKxfMMCbVAWjrmzxmj0amJZD6S3hKWBwUKa
 KpcXxFauaJ0ndBHU2lhKjAZqHVyMfOv3WKm7zen32PjP2iCU4hXcxuU7ydghIK6De0
 V62E/4/ztwtlDvHHfy6c2RSTWME60yB8Dtzjb91rf3oEuQL9gaGX4zoY8dxAAZgwca
 jC/6RTXC9svlGoKn9jDC4FG769HKcukIIcCHZ0C8hDbIuCZW4ndODdUjFuUK1uDQ0m
 RLPUvdziznFKsJaPINEDQL4QZnnu1gw4JNDRtMMSWEWucrIi7fsMNkLbTk+2/uUfX0
 Wp3wFy9t8rb7w==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4WFcNL62MHz4wbr; Fri,  5 Jul 2024 12:07:30 +1000 (AEST)
Date: Fri, 5 Jul 2024 11:33:17 +1000
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
Message-ID: <ZodNXYfKAy0CcaRt@zatzit>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0Injt77FYeqCm07l"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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


--0Injt77FYeqCm07l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:15:57PM +0100, Peter Maydell wrote:
> On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com=
> wrote:
> > > >
> > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > >
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > ---
> > > >  hw/ppc/vof.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > --- a/hw/ppc/vof.c
> > > > +++ b/hw/ppc/vof.c
> > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, =
GArray *claimed, uint64_t base)
> > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac + s=
c));
> > > >      if (sc =3D=3D 2) {
> > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(u=
int32_t) * ac));
> > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> > > >      } else {
> > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(u=
int32_t) * ac));
> > > >      }
> > >
> > > I did wonder if there was a better way to do what this is doing,
> > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > provide one.
> >
> > libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> > not an automatic aligned-or-unaligned helper.   Maybe we should add tha=
t?
>=20
> fdt32_ld() and friends only do the "load from this bit of memory"
> part, which we already have QEMU utility functions for (and which
> are this patch uses).
>=20
> This particular bit of code is dealing with an fdt property ("memory")
> that is an array of (address, size) tuples where address and size
> can independently be either 32 or 64 bits, and it wants the
> size value of tuple 0. So the missing functionality is something at
> a higher level than fdt32_ld() which would let you say "give me
> tuple N field X" with some way to specify the tuple layout. (Which
> is an awkward kind of API to write in C.)

Ah, right.  Yeah.. that's a pretty awkward API in C.

> Slightly less general, but for this case we could perhaps have
> something like the getprop equivalent of qemu_fdt_setprop_sized_cells():
>=20
>   uint64_t value_array[2];
>   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
>                                ac, sc);
>   /*
>    * fills in value_array[0] with address, value_array[1] with size,
>    * probably barfs if the varargs-list of cell-sizes doesn't
>    * cover the whole property, similar to the current assert on
>    * proplen.
>    */
>   mem0_end =3D value_array[0];

Seems reasonable to me.  The only other thought I had was something
like Python's struct.unpack() [0].  But your suggestion is probably
more natural in C.

[0] https://docs.python.org/3/library/struct.html#struct.unpack

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--0Injt77FYeqCm07l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmaHTVwACgkQzQJF27ox
2GcAUg/+NEM0aQR3ZiiUaW57idGniuDnFmcj10jKgu2NjaMrZb0mDNn3467xHMQK
CdZ8z8QPj6s7AqLAKdCzm5XQTL+UGvhT2cgX+C/WD2s7mFl0EKoCSxqQFw5Gjntz
fuYIo4zD1nbkpFn/Yr//rtPi9oFOp3LxIaITVZG3n7OZhbZkTPjRpkROEpmdONLx
AQcWOP1U9GXSkPJ23990kdekSiOh7zf8C7Wy3TSSHc4SA6KNcasuRdkr08B1044G
R21NmsbBKcLOKiidhedEsiI+m7ZVRC2toDahWC/ujHVXQeOtd6LjJn1N0bSLyewD
S26u7/t+n7cSM8mqwNmzMBCwK8PeGHhFnWlH/innBNmY1kHh66j7485+3MY1e5KX
A1dJk4hNOwKMV5zWhO+37TQM5Q8IUp+6S0N4zqbGfUgd6B7WZHMv3qoj0XFyi2PL
bWd53A5aQI09QUNt8hvoJ9oKwcwtjBoywCloL1Gg9PnPh+SSjT8BaWcwyfwr8IYQ
875N6CrxkXQ5wi3mUS2mAYR4X7BWil6vZ5cGYYTS+mi01Ac7Ly5kK5vYxwQMToPQ
HQt5E8mTrahcomHIWjpJwySUu9XNsFdFkUIGL2qROFU6TisX5G0Nx9Ks4C3fNlPM
QE06IYKrGJxXBjQ7yWJYJCInNrHKh7XVdcH44jXy+iQYRCOjuiY=
=NV6x
-----END PGP SIGNATURE-----

--0Injt77FYeqCm07l--

