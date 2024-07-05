Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B86C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYMU-0006cU-Gk; Thu, 04 Jul 2024 22:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sPYMT-0006bz-1A; Thu, 04 Jul 2024 22:07:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sPYMP-0000GC-EF; Thu, 04 Jul 2024 22:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1720145250;
 bh=1L4XNRnFgvSO0mJFB4QWcl9+pd+/N//pdHt1Q5HdMHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jegd3oM/gZsRRCHVMulno5blpXrJaXZEpAfSu9EIgdZH1UHIK7tCrJPi/NjWVQUPM
 rsoQ+PsbnHFwbDmhc/6Ge2KcSAbTOVFE/NL6m2phLAxUWBJdn7icMbLPP7oBYJBhjU
 DzUNqFWiTTvQJBQdfnXhlfhuLZo1QVzQOwDw+NYceCtih+FPJX7IdYZhWY490dW5ic
 MVcncqrKfU2apF6TaY8IQ1abp6ivEOyBJeoVDpvys1z0yAWT6ewzU/dz0UzJcAbFxN
 Femv7CmhHrGQ8cIUUNSNQTfZXoa/Wk9qWPR1f6+5c2bsrSlYDYOoeditHCP8nrBqK5
 b/8nlp9htyvxQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4WFcNL69Srz4wnx; Fri,  5 Jul 2024 12:07:30 +1000 (AEST)
Date: Fri, 5 Jul 2024 11:41:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
Message-ID: <ZodPOTAcLo1XF4MB@zatzit>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ji4OZ74Eg4G6xax6"
Content-Disposition: inline
In-Reply-To: <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
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


--ji4OZ74Eg4G6xax6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >
> > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.c=
om> wrote:
> > > > >
> > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > >
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > ---
> > > > >  hw/ppc/vof.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > --- a/hw/ppc/vof.c
> > > > > +++ b/hw/ppc/vof.c
> > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt=
, GArray *claimed, uint64_t base)
> > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac +=
 sc));
> > > > >      if (sc =3D=3D 2) {
> > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof=
(uint32_t) * ac));
> > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> > > > >      } else {
> > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof=
(uint32_t) * ac));
> > > > >      }
> > > >
> > > > I did wonder if there was a better way to do what this is doing,
> > > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > > provide one.
> > >
> > > libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> > > not an automatic aligned-or-unaligned helper.   Maybe we should add t=
hat?
> >
> > fdt32_ld() and friends only do the "load from this bit of memory"
> > part, which we already have QEMU utility functions for (and which
> > are this patch uses).
> >
> > This particular bit of code is dealing with an fdt property ("memory")
> > that is an array of (address, size) tuples where address and size
> > can independently be either 32 or 64 bits, and it wants the
> > size value of tuple 0. So the missing functionality is something at
> > a higher level than fdt32_ld() which would let you say "give me
> > tuple N field X" with some way to specify the tuple layout. (Which
> > is an awkward kind of API to write in C.)
> >
> > Slightly less general, but for this case we could perhaps have
> > something like the getprop equivalent of qemu_fdt_setprop_sized_cells():
> >
> >   uint64_t value_array[2];
> >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
> >                                ac, sc);
> >   /*
> >    * fills in value_array[0] with address, value_array[1] with size,
> >    * probably barfs if the varargs-list of cell-sizes doesn't
> >    * cover the whole property, similar to the current assert on
> >    * proplen.
> >    */
> >   mem0_end =3D value_array[0];
>=20
> Since 4/8 byte cells are most common and size is probably
> normally known, what about something simpler to start with?

Hrm, I don't think this helps much.  As Peter points out the actual
load isn't really the issue, it's locating the right spot for it.

>=20
> Thanks,
> Nick
>=20
> ---
> diff --git a/libfdt/libfdt.h b/libfdt/libfdt.h
> index 0677fea..c4b6355 100644
> --- a/libfdt/libfdt.h
> +++ b/libfdt/libfdt.h
> @@ -148,6 +148,15 @@ static inline uint32_t fdt32_ld(const fdt32_t *p)
>  		| bp[3];
>  }
> =20
> +/*
> + * Load the value from a 32-bit cell of a property. Cells are 32-bit ali=
gned
> + * so can use a single load.
> + */
> +static inline uint32_t fdt32_ld_prop(const fdt32_t *p)
> +{
> +	return fdt32_to_cpu(*p);
> +}
> +
>  static inline void fdt32_st(void *property, uint32_t value)
>  {
>  	uint8_t *bp =3D (uint8_t *)property;
> @@ -172,6 +181,18 @@ static inline uint64_t fdt64_ld(const fdt64_t *p)
>  		| bp[7];
>  }
> =20
> +/*
> + * Load the value from a 64-bit cell of a property. Cells are 32-bit ali=
gned
> + * so can use two loads.
> + */
> +static inline uint64_t fdt64_ld_prop(const fdt64_t *p)
> +{
> +	const fdt64_t *_p =3D p;
> +
> +	return ((uint64_t)fdt32_to_cpu(_p[0]) << 32)
> +		| fdt32_to_cpu(_p[1]);
> +}
> +
>  static inline void fdt64_st(void *property, uint64_t value)
>  {
>  	uint8_t *bp =3D (uint8_t *)property;
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--ji4OZ74Eg4G6xax6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmaHTzgACgkQzQJF27ox
2GfIVQ//buJxQREoyNhlOkJ3HcOChDv3x5gjNg5SEXyhw1jF4RsBu7SSq/jeykVj
R5JuvuCa66IDJN+1uXW5nuzh18Qg8NXhIpz6QHXkMA6/H4sKBCNszdgNRNrFAwbJ
zHM80m1xT4k+sbE9GKRUTgDB3SD+DdpG7t6BJ7lh04z3u8q/ryOj1F3Nl41jJjmX
PASCAbhiv9/NcK84Nk2vh80PxYbiaA//6f/ae5kCaOiOKYEnuoIObgS130NSqxh6
oPN+x9+Ki4TpMRA6AbGJ+IrNt/4u+OMcOS2gOGYayJE/S7dCrDC/0bWSUAlizQUN
G38GzjYJsEoqWJIcVTrmRMGIKOd0BKaNevbU1N/sNxDJbIHhiINf2o3h6JksMVP/
d0xIUFVwEhDtEoGZhQDd77ojBU6SuD74hwMdi/k5ZujLNHNJEe1BPahn5Obirhor
aROKY9wARRSF8LrWC2t7c29VL5EsFxo0KM280wsxYOObforuxOxuxJuEkPBQ68tB
srwVhaYWIwAyn/VU4LZm0OhJbsB30/g5s5MZDAnv612Hndwl6qnwwKH6MObu+aKs
ghfDZOj/7ckVshyj5l1HMrDc90wCv2Oaufer0znrMgFr02Wy4ywHddNmropN6WzH
Ok0t7dJHBP5S08GuR/pi3ciP8/lBnoAHL+KTYR5Sdc173YDDNBI=
=BQnL
-----END PGP SIGNATURE-----

--ji4OZ74Eg4G6xax6--

