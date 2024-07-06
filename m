Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA49C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 23:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQF7X-0005j9-JM; Sat, 06 Jul 2024 19:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sQF7T-0005hg-6B; Sat, 06 Jul 2024 19:47:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sQF7O-0004Dv-IE; Sat, 06 Jul 2024 19:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1720309611;
 bh=hoBiR0QZcrFvM8PEwcR16yP0cr3lHRqgJQW0hC/0rqM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DgHIJt3/Q2QrwlHZzBO64cC/dJ7kdeS/1+9pngwqLjtIaNUjjFoVUdbILkIhW6rUD
 mUhJDn0scb3zv2R9xb3Sx6TrGAodrynCfrRbEL0gDlMT4uX6xd6v/EKrd8v9zQQHrq
 4aqytBbZJbdvhutecutJiyerAylfPjrT+hTZbv+cp6NnMcHD8IPeASoztL2gxOA2Jo
 WrVrB4rAw4GenfwSQ8fhBZ9GEQAoHcHtQWfbYGxTHNfTqGj7VvMCTtNq/yyuhxd4Zx
 NPCo3n7TTBkKPKDCeFFNFFhqiRmWFn+BRqYEKG7E3CpGS0zv7G98zYc04o7vc4qSdp
 6rDdZ3jcvBw8Q==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4WGn9724Hlz4wnx; Sun,  7 Jul 2024 09:46:51 +1000 (AEST)
Date: Sun, 7 Jul 2024 09:46:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
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
Message-ID: <ZonXSmp9XZxl_HHp@zatzit>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
 <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Lswluh9zEMYp/L5i"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
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


--Lswluh9zEMYp/L5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2024 at 11:37:08AM +0100, Peter Maydell wrote:
> On Fri, 5 Jul 2024 at 06:13, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >
> > On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
> > > On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> > > > On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > > > > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > > > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbe=
ar.id.au> wrote:
> > > > > > >
> > > > > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > > > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> > > > > > > > >
> > > > > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > > > ---
> > > > > > > > >  hw/ppc/vof.c | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > > > > --- a/hw/ppc/vof.c
> > > > > > > > > +++ b/hw/ppc/vof.c
> > > > > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(v=
oid *fdt, GArray *claimed, uint64_t base)
> > > > > > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &prople=
n);
> > > > > > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t)=
 * (ac + sc));
> > > > > > > > >      if (sc =3D=3D 2) {
> > > > > > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg =
+ sizeof(uint32_t) * ac));
> > > > > > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t=
) * ac);
> > > > > > > > >      } else {
> > > > > > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg =
+ sizeof(uint32_t) * ac));
> > > > > > > > >      }
> > > > > > > >
> > > > > > > > I did wonder if there was a better way to do what this is d=
oing,
> > > > > > > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > > > > > > provide one.
> > > > > > >
> > > > > > > libfdt does provide unaligned access helpers (fdt32_ld() etc.=
), but
> > > > > > > not an automatic aligned-or-unaligned helper.   Maybe we shou=
ld add that?
> > > > > >
> > > > > > fdt32_ld() and friends only do the "load from this bit of memor=
y"
> > > > > > part, which we already have QEMU utility functions for (and whi=
ch
> > > > > > are this patch uses).
> > > > > >
> > > > > > This particular bit of code is dealing with an fdt property ("m=
emory")
> > > > > > that is an array of (address, size) tuples where address and si=
ze
> > > > > > can independently be either 32 or 64 bits, and it wants the
> > > > > > size value of tuple 0. So the missing functionality is somethin=
g at
> > > > > > a higher level than fdt32_ld() which would let you say "give me
> > > > > > tuple N field X" with some way to specify the tuple layout. (Wh=
ich
> > > > > > is an awkward kind of API to write in C.)
> > > > > >
> > > > > > Slightly less general, but for this case we could perhaps have
> > > > > > something like the getprop equivalent of qemu_fdt_setprop_sized=
_cells():
> > > > > >
> > > > > >   uint64_t value_array[2];
> > > > > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_=
array,
> > > > > >                                ac, sc);
> > > > > >   /*
> > > > > >    * fills in value_array[0] with address, value_array[1] with =
size,
> > > > > >    * probably barfs if the varargs-list of cell-sizes doesn't
> > > > > >    * cover the whole property, similar to the current assert on
> > > > > >    * proplen.
> > > > > >    */
> > > > > >   mem0_end =3D value_array[0];
> > > > >
> > > > > Since 4/8 byte cells are most common and size is probably
> > > > > normally known, what about something simpler to start with?
> > > >
> > > > Hrm, I don't think this helps much.  As Peter points out the actual
> > > > load isn't really the issue, it's locating the right spot for it.
> > >
> > > I don't really see why that's a problem, it's just a pointer
> > > addition - base + fdt_address_cells * 4. The problem was in
> >
> > This is harder if #address-cells and #size-cells are different, or if
> > you're parsing ranges and #address-cells is different between parent
> > and child node.
> >
> > > the memory access (yes it's fixed with the patch but you could
> > > add a general libfdt way to do it).
> >
> > Huh.. well I'm getting different impressions of what the problem
> > actually is from what I initially read versus Peter Maydell's
> > comments, so I don't really know what to think.
> >
> > If it's just the load then fdt32_ld() etc. already exist.  Or is it
> > really such a hot path that unconditionally handling unaligned
> > accesses isn't tenable?
>=20
> The specific problem here is that the code as written tries to
> cast a not-aligned-enough pointer to uint64_t* to do the load,
> which is UB.

Ah... and I'm assuming it's the cast itself which triggers the UB, not
just dereferencing it.  Which makes the interface of fdt32_ld()
etc. unusable for their intended purpose.  Well.. damn.  Now... how do
I fix it without breaking compatibility any more than I have to.

> The patch submitted fixes that, and personally I
> think it would be entirely fine to say that's all we need to do here.
>=20
> *If* we want to look at the broader question of "why is this
> code that's reading something out of an fdt having to do the
> pretty low-level action of getting the start address of the
> fdt property and then doing pointer arithmetic and then fishing
> a value out of it as a 64-bit unaligned load?" then we get into
> "do we want to provide a helper function that lets the caller
> say 'give me element X from tuple Y'?". But that seems like a
> lot of effort for what's basically a single callsite we would
> be tidying up...

I tend to agree.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--Lswluh9zEMYp/L5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmaJ1zsACgkQzQJF27ox
2GdDSQ/7BcKwoOwX+RhtyyexcYyv9Wn9LL2mbkjCSd8wmj0EoOfYk7Dgh8C7bOf6
6DsuO2fuvUPfv1218mibmvjdLBSwg7ABzDWpi09m18J8ecqG774gHgUAPWVxxFF1
oFT2LFQ0Kk5PPhmLYH/BHA873VTrQwky7baUcpsJfAwlvom4DVtXHTkIQlRpwDF+
CLx279pkzwreaXhdDLEf78mKp6F2V3/7CDYh7KlPjvZDKMuYc/WC4tQobqDW6ATM
jV6Y4woyNrnEBOOgi5dx9mkkB1rhWNaCc0w2CbUm65KnE2aph9twAh6NZqpx/XkZ
5nMpPgi9L4+pGRhBXA4Jjqu72GgPyAYCwJr/CcY1n8o4gcaeUrQGQ7csW7sMVTAf
lpqKLPYcaqiUNtuWbz98/VQbK7A+Xrrm9dH7oR+23YDkf5GD6bC3oKdxzPMtKwem
fH+Qp3GtFbkv6SwSF6k6GX+5DpFbyWIrnWkghXk3JQ1OBC4SNs/qAs3KB+o4WhWb
aMWL5bvP9yCZZd0/5YZaFRSBDBSKhUXAW7kpt0PSWFMwtGtcUXQ76qJYcKAZk0QK
9OKz14dxMXlTtSYYtHmXN5k9t3c6+RVM3aicCPSeU4FuYybG9nf7dQ8PzQNhyT/m
op2XHfuw85nrVu7NCmHyXSMYtNVRV7SD1ERf5Ee2AIcy5oFAiEc=
=5wvD
-----END PGP SIGNATURE-----

--Lswluh9zEMYp/L5i--

