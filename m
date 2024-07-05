Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1150C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPbGW-0006GS-0Z; Fri, 05 Jul 2024 01:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sPbGM-0006Eh-I3; Fri, 05 Jul 2024 01:13:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sPbGI-0007E8-6S; Fri, 05 Jul 2024 01:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1720156407;
 bh=Es05opL6NCwVISqJnW8ww6pBM4ovE4rXiF+NyGUervM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cq8mB6ndvCXT4JvdkjweUc3x3wFLcbZGO/nES3+1enQocQdlArH7B4jHsQ9HIHc7l
 xwkWSfwqO7FfjpZGRNI6L10ki4vhoak+8cyjy1pl1NLPUVFH711XZ84L5/Mgc/WcVd
 gA3lCOjVdoYe6L2PHYqRr+nCF/CtFekAGvcg5rdQ+6+bixH+YZAtoNGNAOapbnSj00
 yA+SdrS/BELtLxyKx8csyAY3RcrFzcQHT7M9Fsb769X7VyV4r7K3yo5vuiEIfUVcDP
 II3JvJ3pqjd37RxES/xAh/igjGM/IfUeWwTbLVrMAQTczOu2ENoPnRAEAsxc8mTdq9
 bLteU5z9Fhvhw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4WFhVv4sckz4wxx; Fri,  5 Jul 2024 15:13:27 +1000 (AEST)
Date: Fri, 5 Jul 2024 15:12:26 +1000
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
Message-ID: <ZoeAutfGIAaNEFBC@zatzit>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HLduzy4ZHa21Gd5V"
Content-Disposition: inline
In-Reply-To: <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com>
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


--HLduzy4ZHa21Gd5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
> On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> > On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.i=
d.au> wrote:
> > > > >
> > > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> > > > > > >
> > > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > > >
> > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > ---
> > > > > > >  hw/ppc/vof.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > > --- a/hw/ppc/vof.c
> > > > > > > +++ b/hw/ppc/vof.c
> > > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void =
*fdt, GArray *claimed, uint64_t base)
> > > > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> > > > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (=
ac + sc));
> > > > > > >      if (sc =3D=3D 2) {
> > > > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + si=
zeof(uint32_t) * ac));
> > > > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * =
ac);
> > > > > > >      } else {
> > > > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + si=
zeof(uint32_t) * ac));
> > > > > > >      }
> > > > > >
> > > > > > I did wonder if there was a better way to do what this is doing,
> > > > > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > > > > provide one.
> > > > >
> > > > > libfdt does provide unaligned access helpers (fdt32_ld() etc.), b=
ut
> > > > > not an automatic aligned-or-unaligned helper.   Maybe we should a=
dd that?
> > > >
> > > > fdt32_ld() and friends only do the "load from this bit of memory"
> > > > part, which we already have QEMU utility functions for (and which
> > > > are this patch uses).
> > > >
> > > > This particular bit of code is dealing with an fdt property ("memor=
y")
> > > > that is an array of (address, size) tuples where address and size
> > > > can independently be either 32 or 64 bits, and it wants the
> > > > size value of tuple 0. So the missing functionality is something at
> > > > a higher level than fdt32_ld() which would let you say "give me
> > > > tuple N field X" with some way to specify the tuple layout. (Which
> > > > is an awkward kind of API to write in C.)
> > > >
> > > > Slightly less general, but for this case we could perhaps have
> > > > something like the getprop equivalent of qemu_fdt_setprop_sized_cel=
ls():
> > > >
> > > >   uint64_t value_array[2];
> > > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_arra=
y,
> > > >                                ac, sc);
> > > >   /*
> > > >    * fills in value_array[0] with address, value_array[1] with size,
> > > >    * probably barfs if the varargs-list of cell-sizes doesn't
> > > >    * cover the whole property, similar to the current assert on
> > > >    * proplen.
> > > >    */
> > > >   mem0_end =3D value_array[0];
> > >=20
> > > Since 4/8 byte cells are most common and size is probably
> > > normally known, what about something simpler to start with?
> >
> > Hrm, I don't think this helps much.  As Peter points out the actual
> > load isn't really the issue, it's locating the right spot for it.
>=20
> I don't really see why that's a problem, it's just a pointer
> addition - base + fdt_address_cells * 4. The problem was in

This is harder if #address-cells and #size-cells are different, or if
you're parsing ranges and #address-cells is different between parent
and child node.

> the memory access (yes it's fixed with the patch but you could
> add a general libfdt way to do it).

Huh.. well I'm getting different impressions of what the problem
actually is from what I initially read versus Peter Maydell's
comments, so I don't really know what to think.

If it's just the load then fdt32_ld() etc. already exist.  Or is it
really such a hot path that unconditionally handling unaligned
accesses isn't tenable?

> Some fancy function like above could be used, But is it really
> worth implementing such a thing for this?
>=20
> Thanks,
> Nick
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--HLduzy4ZHa21Gd5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmaHgLYACgkQzQJF27ox
2Ge78A/+KlARNMyaeSYlWWUbltXuz3jdQ27/YRfYLtk0mpV9NXUORBpRTlisM4tu
JH0n+r6Nw0L+bNwayp0Ovuy5Oo56tGLsmCb6wm4BIkL5Rb05JPbCTF8+gH9JKcbK
thAvl0wkoQGrE45icCFjv32W0kdhNjmZYV376+VscHpFsl1C0XpFPzpmU0QkDOZT
v04bGGX9Hda4iK7FdaA7F8KTNfx4sy55htF+Uz4bK88beQF6iuwlSE+Cdr3evd8E
LwmLla2gkNwJ9oY3yBXP64k0PnzmQuCyLaGBv/gdG46yTSzsprsMn2ZwaZEUiwrk
LWaFVAOR9Zi+0x0dHhEAF/lZ24KseLxzjog6rsclpFm3YzwFcwcnBBErek8F0YEj
luUtigc/O84ZbiVotf34RGG8tr3fAzYHtqDHs5fyqX00XV2RrR+XgF+xEePPY2W0
Q6qfjKvUv48iAajZqbrzdX4G9qMuZQwUHV42ow/Gd9d85K2oeEJ24SK8x5Kzf/Bs
5KEtoWxw7RD0KZjSfvCwNn2vCVPhTf7Kbhftc+PySeRoU5TgbAsKk3coocae2nZH
pg5WN8X7qBW0P9mdmg/ymebeHxZ6C46SsdKemdX8Xg0AuUpecxoDQ6MMdxdBf9tS
vxBSR71sDLBm/MwjHCMvLqwzRM/gWOQslRSbG+ghQC6i/mGUSC0=
=befY
-----END PGP SIGNATURE-----

--HLduzy4ZHa21Gd5V--

