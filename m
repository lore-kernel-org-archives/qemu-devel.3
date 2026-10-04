Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2DECA5FDD
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 00:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDAA9-0005o7-B0; Sat, 03 Oct 2026 20:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1xDAA7-0005nn-DN; Sat, 03 Oct 2026 20:33:07 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1xDAA5-0008Aw-PC; Sat, 03 Oct 2026 20:33:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E863A60052;
 Sun,  4 Oct 2026 00:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA79D1F0089B;
 Sun,  4 Oct 2026 00:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791073976;
 bh=KUnC+v1tit3ic+7kD3Irb1IBTtSXcOIhW85EFAFNPO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mKafN40u1TMaFNZnQtI9+u0i59juVRS0fXK1Dd416xRh0yYU2J9rsXVEtH1y0qLOf
 auyzS28mh/Z+ODJoL8ChtbhG97+nk9AE/LIlpWqCH6XQEATwLyyQQYyiFt31CN/6eh
 pm3aEiQu8dyGAx8e0uWNjIDLSh9djYwWyfpG6XMm2GyZSoBeFRuMMIH9vDhfJH6bgc
 odKSOjPA2qG1LkOcEOlhJUNIanzFhdtZFX4ZC90S0QRz2TdOxxWUJ2shOCQDu0+Buj
 vIo+SA9Qt2d64yMczDURq5+3O1eW2YIK1h0C5KxB6p4o5y9N6pxiwF6JxeS0EdnAwI
 AH1xWv8r5/ReA==
Date: Sun, 4 Oct 2026 01:32:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 20/24] docs/system/riscv: Document Icicle Kit HSS boot
Message-ID: <20261004-proposal-aneurism-b0df79d008ee@spud>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-21-bin.meng@processmission.com>
 <20260930-disparity-announcer-a6bc30a7084c@wendy>
 <CAEUhbmXM_ZQSyRpjUmr83WBFLbasAQ410ybm=vR3TmpbP=4V0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u2SJ6KTrpz3VY4KF"
Content-Disposition: inline
In-Reply-To: <CAEUhbmXM_ZQSyRpjUmr83WBFLbasAQ410ybm=vR3TmpbP=4V0A@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--u2SJ6KTrpz3VY4KF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2026 at 11:16:27PM +0800, Bin Meng wrote:
> > > +Configure HSS for the ``mpfs-icicle-kit-es`` board using its default
> > > +configuration. QEMU provides the software-visible registers and dete=
rministic
> > > +status consumed by the HSS v2024.06 DDR initialization and training =
flow;
> > > +it does not model the electrical properties of DDR training. HSS req=
uires
> > > +the RISC-V bare-metal toolchain supplied by Microchip SoftConsole to=
 be
> > > +available in ``PATH``.  Build the tested HSS version with:
> >
> > What's the reason that this is using 2024.06 by the way? Why not use the
> > most recent release of the HSS?
>=20
> This is because the Buildroot v2026.05 release's defconfig for Icicle
> Kit board refers to v2024.06 version of
> 'microchip-hss-payload-generator' which is a tool from HSS, so I chose
> to use the same HSS source version to build the HSS to match the tools
> version.

If that's the rationale, I think this should be moved to using hte most
recent HSS release. The payload generator version is lagging because
there's not been any changes to the format of the input or output file
in the last two years.

--u2SJ6KTrpz3VY4KF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasGetAAKCRB4tDGHoIJi
0vzbAQDORyi9j505mR8eyaNEHEaa1gd74x7PzixP2qGgyBTYxAEAx4JxNVkjbZIM
JzvgnJlg9hrGR7BdkcRpu1I3epPZ/Q0=
=bUF6
-----END PGP SIGNATURE-----

--u2SJ6KTrpz3VY4KF--

