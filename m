Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79123CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Lso-0001pO-If; Thu, 16 Oct 2025 07:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1v9Lsm-0001pD-9m
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:10:56 -0400
Received: from woodpecker.gentoo.org ([140.211.166.183] helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1v9Lsj-0006x4-1Q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:10:55 -0400
Received: from kona.localnet (pc1012350290.uni-regensburg.de [132.199.97.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dilfridge)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 74626340FF9;
 Thu, 16 Oct 2025 11:10:43 +0000 (UTC)
From: "Andreas K. Huettel" <dilfridge@gentoo.org>
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [EXT] Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
Date: Thu, 16 Oct 2025 13:10:32 +0200
Message-ID: <6361025.mvXUDI8C0e@kona>
Organization: Gentoo Linux
In-Reply-To: <5bdf4bb4-1439-4c46-bd7e-082e72949217@linaro.org>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
 <5bdf4bb4-1439-4c46-bd7e-082e72949217@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16320024.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=140.211.166.183;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--nextPart16320024.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Andreas K. Huettel" <dilfridge@gentoo.org>
Date: Thu, 16 Oct 2025 13:10:32 +0200
Message-ID: <6361025.mvXUDI8C0e@kona>
Organization: Gentoo Linux
In-Reply-To: <5bdf4bb4-1439-4c46-bd7e-082e72949217@linaro.org>
MIME-Version: 1.0

Am Donnerstag, 16. Oktober 2025, 10:49:56 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Philippe Mathieu-Daud=C3=A9:
> On 9/10/25 22:51, Gabriel Brookman wrote:
> > For the fmpyadd instruction on the hppa architecture, there is a bit
> > used to specify whether the instruction is operating on a 32 bit or 64
> > bit floating point register. For most instructions, such a bit is 0 when
> > operating on the smaller register and 1 when operating on the larger
> > register. However, according to page 6-57 of the PA-RISC 1.1 Architectu=
re
> > and Instruction Set Reference Manual, this convention is reversed for t=
he
> > fmpyadd instruction specifically, meaning the bit is 1 for operations on
> > 32 bit registers and 0 for 64 bit registers. Previously, QEMU decoded
> > this operation as operating on the other size of register, leading to
> > bugs when translating the fmpyadd instruction. This patch fixes that
> > issue.
> >=20
> > Reported-by: Andreas H=C3=BCttel <andreas.huettel@ur.de>
> > Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3096
> > ---
> > Hi all,
> >=20
> > This patch fixes the decoding of the fmpyadd instruction on the hppa
> > target, which uses an inverted bit convention to select between
> > 32-bit and 64-bit floating-point registers. The issue was reported by
> > Andreas H=C3=BCttel after observing incorrect behavior when running real
> > binaries under that target. He kindly submitted a minimal reproducer
> > which I was able to use to debug the issue. I used this reproducer
> > to verify correct operation after my fix.
> >=20
> > Thanks,
> > Gabriel
> >=20
> > Reported-by: Andreas H=C3=BCttel
> > ---
> >   target/hppa/insns.decode | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Patch queued (including doc refs Andreas added).
>=20

Thank you all!=20

Will eventually help a lot here
https://www.gentoo.org/downloads/#hppa
(which is right now still blocked by an unrelated python bug)


=2D-=20
Andreas K. H=C3=BCttel
dilfridge@gentoo.org
Gentoo Linux developer
(council, toolchain, base-system, perl, libreoffice)

=2D-=20
PD Dr. Andreas K. Huettel
Institute for Experimental and Applied Physics
University of Regensburg
93040 Regensburg
Germany

tel. +49 151 241 67748 (mobile)
tel. +49 941 943 1618 (office)
e-mail andreas.huettel@ur.de
https://www.akhuettel.de/
https://www.akhuettel.de/group/
--nextPart16320024.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAABCgB9FiEE/Rnm0xsZLuTcY+rT3CsWIV7VQSoFAmjw0qhfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZE
MTlFNkQzMUIxOTJFRTREQzYzRUFEM0RDMkIxNjIxNUVENTQxMkEACgkQ3CsWIV7V
QSqxFQ//dZU4k5y/dj1UT+PNdBXsx4POEhW1mYbnwQHS/in21b40HmTD1ospqtn6
TXN+mJJqC5vrWMjdc4brVAajoojCs0MJDv+0SDsXF6qDtShmzbE7TyrrcP9LP90h
rH0MXg6h7Nv6WB7v2hSwRyFe15j6PQf76i+3cuVXDYjMAjD/x0GTV7DvBq6d0RFy
z4idJloXaohOPM5UVgxb1bxdZjn048y6gzGR0DwkJ8L8362N8kajcpkKKhvt+YXt
t8PnHGrDA5lwbqTTC89dqcmsRMiOKlTE2O7EchCKXalQipvxuiEkG5Yt2B9SvhMZ
L1+GJ5icJodjme1MDG4mQRQyPlyQxcfZikTec37hoJisxWuQ4j8suF5cl29GMba/
H7e0+AKCfS0L77PG1NMfkiJDfqGmViXBE8hdQhedBTXfDq/pbKdPSdX1Np4/k3Qw
Ij5fUXoYm9yk2+A9SGbEQlNRYvwj0vqKgl+oq6ak5KlylyhkwIY++KfMEgcjZenm
WGdQn9yRM59WUlcCYMT9sPmkecjbXIsNbfE9Tuk4I3PEubJie0y/01rHR5WaIi3e
62RvXuxldOnAiMVI22O0QPfXQcR63Lk1rfYMfFZqY9UGWDOmLFEgPHU6vL9zHHb0
PaLqY0VAEMAkGGof3k509+TPYzRBE7mzh5XcsH8wzgtZBbIiMoU=
=unnL
-----END PGP SIGNATURE-----

--nextPart16320024.O9o76ZdvQC--




