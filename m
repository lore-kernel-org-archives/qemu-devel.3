Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA84C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 21:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj25N-0006GK-M3; Sun, 12 Jul 2026 17:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wj25L-0006G2-7e; Sun, 12 Jul 2026 17:51:39 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wj25J-000062-L1; Sun, 12 Jul 2026 17:51:38 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54F32408F4;
 Sun, 12 Jul 2026 21:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C24A1F000E9;
 Sun, 12 Jul 2026 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783893095;
 bh=A9n1BEpWhqHpYygTsFwbnOybhz0/906mV3g0e3Z6UNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c1bjYv5AuKPfuiSrDn2P+JabgyyQpzqhIJdOIKL0Q/QhjguV0U2d5jSD3TkFjmIR6
 HZ9YVELJU7NRBh+8otaBXYYgAiduKxheYwqhF5n3rIM1WFS4VVBa6uxlbkrZkUrcDI
 W5Q1DbKvGqPSAPGuddrdKBQbTlVmXF0W+4LS1mKuu9ulFOK0GxbbKXYOYZ/WpMrWoi
 M6t9PpbhwnABJiITDogQyT11p9ZFZdCPL0wzx/0lwIXScenzVl+xXutxpTRRdMPbyK
 3HfIFqrpCWD1DQAUQwIF9+uyoSfx06PUzwP4tC3brtAYzdjhwEyVd2pRqyT9Tyy6dn
 afohbeNEtCEmg==
Date: Sun, 12 Jul 2026 22:51:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
Message-ID: <20260712-prodigal-subscribe-759f57ab6d4e@spud>
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
 <CAEUhbmXaA6wpyUeVGL4Vn-zaP9LBFfmpTuWxDB=aMaXez_p=1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qbYE7kE2imTRRLTU"
Content-Disposition: inline
In-Reply-To: <CAEUhbmXaA6wpyUeVGL4Vn-zaP9LBFfmpTuWxDB=aMaXez_p=1w@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--qbYE7kE2imTRRLTU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 07:04:14PM +0800, Bin Meng wrote:
> On Fri, Jul 10, 2026 at 7:44=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
> > maintainers, 2025-01-28) removed the only M:, but left S: Supported.
> > This makes no sense.  Downgrade to S: Orphan.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 576ef6fff5..aa2df9cbe3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
> >
> >  Microchip PolarFire SoC Icicle Kit
> >  L: qemu-riscv@nongnu.org
> > -S: Supported
> > +S: Orphan
> >  F: docs/system/riscv/microchip-icicle-kit.rst
> >  F: hw/riscv/microchip_pfsoc.c
> >  F: hw/char/mchp_pfsoc_mmuart.c
> > --
>=20
> I plan to send a patch series to resurrect PolarFire SoC support.

What does this resurrection constitute? The files aren't gone anywhere
(yet, at least), so I take it you mean you'll be actively working on the
platform?

--qbYE7kE2imTRRLTU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalQMYwAKCRB4tDGHoIJi
0vl3AP9n83nAGcfTZQz2iK/Etu7xjYtgg0G0FAtxrDLQVC+BogD/fvgTh/zUgSqf
KgtTh/5sFATDdxI3Op8fd4FDlYjLRQ8=
=bque
-----END PGP SIGNATURE-----

--qbYE7kE2imTRRLTU--

