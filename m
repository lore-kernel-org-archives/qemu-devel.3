Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F3CCE8E8A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 15:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3zdS-0004Cv-Eo; Thu, 24 Oct 2024 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1t3zdL-0004CQ-Ho; Thu, 24 Oct 2024 11:20:20 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1t3zdI-000738-Ss; Thu, 24 Oct 2024 11:20:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5A48F5C2B7F;
 Thu, 24 Oct 2024 15:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19EEC4CEC7;
 Thu, 24 Oct 2024 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729783206;
 bh=3TbR8lpUWwJBVJiIt/FKFgQHFi9qU9nIesmEKsA/KOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FPYwyKQNVOtCiBCkwRHb/2+qxK3E8TR119n68QGgubfZGX4w2bOwnNnr+SvZdOhLw
 lX9k2sfN75s7g9OTxLDALSpns7o+Czk7uVGPqKp6zTcU6TJAPHebWydF43cY+7COLc
 idFLAxAWsuZuA5UK3kTpc65+fa8lbkwNI0uAL+vC4qVJmMMkHOCBqCh33LW/d4HU66
 i93a2n/jMcHhrMaNuObhMksKreEIiZ2H152JDA1dQI1ecOxh928/lNq0zfyzMC6ojH
 pdsuh0RMPJJONGAJDsjD8+iRV4d3rUy9xI47mxh0uxAYORR6XzOEebadfME4SS7pdU
 QrMVaRsypHmPQ==
Date: Thu, 24 Oct 2024 16:20:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] hw/riscv: Support different address-cells for initrd
Message-ID: <20241024-prism-hermit-ce5876051ade@spud>
References: <20241021040942.400-1-jim.shu@sifive.com>
 <20241021040942.400-3-jim.shu@sifive.com>
 <25ae806f-38de-425f-8590-1c605d93197d@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NigxtOl6hvhv0Un6"
Content-Disposition: inline
In-Reply-To: <25ae806f-38de-425f-8590-1c605d93197d@ventanamicro.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--NigxtOl6hvhv0Un6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 04:30:11PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 10/21/24 1:09 AM, Jim Shu wrote:
> > The cells of 'initrd-start/end' should follow the '#address-cell'.
> > QEMU API could support 1 and 2 cells.
> >=20
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   hw/riscv/boot.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index ad45bd7a6a..76b099c696 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -182,6 +182,7 @@ static void riscv_load_initrd(MachineState *machine=
, uint64_t kernel_entry)
> >       void *fdt =3D machine->fdt;
> >       hwaddr start, end;
> >       ssize_t size;
> > +    uint32_t acells;
> >       g_assert(filename !=3D NULL);
> > @@ -209,9 +210,18 @@ static void riscv_load_initrd(MachineState *machin=
e, uint64_t kernel_entry)
> >       /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
> >       if (fdt) {
> > +        acells =3D qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
> > +                                       NULL, NULL);
> > +        if (acells =3D=3D 0) {
> > +            error_report("dtb file invalid (#address-cells 0)");
> > +            exit(1);
> > +        }
> > +
> >           end =3D start + size;
> > -        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", sta=
rt);
> > -        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
> > +        qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-sta=
rt",
> > +                                     acells, start);
> > +        qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-end=
",
> > +                                     acells, end);
> >       }
>=20
> Is this a legal format for linux,initrd-start and linux,initrd-end?
>=20
> This link:
>=20
> https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt
>=20
> Defines both attributes as:
>=20
> "These properties hold the physical start and end address of an initrd th=
at's
> loaded by the bootloader."
>=20
> So I'm not sure if this format you're using here is valid.

Looks like my input isn't really required here anymore, but I think
these two are actually identical in how they appear in the blob. Don't
see much reason to change it.

--NigxtOl6hvhv0Un6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxplkgAKCRB4tDGHoIJi
0vRjAQD99ywMkzfiIdAvTFpr1wkNtbJajH3543+aO6KVThSbMwEA75flZuoq1BUX
JXzVaowZhMdUZmfsHyGHFzdDddSB6Q4=
=IT9X
-----END PGP SIGNATURE-----

--NigxtOl6hvhv0Un6--

