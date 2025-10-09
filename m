Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CFECCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yDo-0001K1-C0; Thu, 09 Oct 2025 17:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1v6yDk-0001JW-Mv
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:30:45 -0400
Received: from woodpecker.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]
 helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1v6yDi-0006ih-Ic
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:30:44 -0400
Received: from pinacolada.localnet (130-185-5-161.hsi.r-kom.net
 [130.185.5.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dilfridge)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 11574341042;
 Thu, 09 Oct 2025 21:30:28 +0000 (UTC)
From: "Andreas K. Huettel" <dilfridge@gentoo.org>
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [EXT] Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
Date: Thu, 09 Oct 2025 23:30:18 +0200
Message-ID: <10069660.lOV4Wx5bFT@pinacolada>
Organization: Gentoo Linux
In-Reply-To: <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
 <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8915427.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

--nextPart8915427.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Andreas K. Huettel" <dilfridge@gentoo.org>
Date: Thu, 09 Oct 2025 23:30:18 +0200
Message-ID: <10069660.lOV4Wx5bFT@pinacolada>
Organization: Gentoo Linux
In-Reply-To: <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
MIME-Version: 1.0

Am Donnerstag, 9. Oktober 2025, 23:23:33 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Richard Henderson:
> On 10/9/25 13:51, Gabriel Brookman wrote:
> > For the fmpyadd instruction on the hppa architecture, there is a bit
> > used to specify whether the instruction is operating on a 32 bit or 64
> > bit floating point register. For most instructions, such a bit is 0 when
> > operating on the smaller register and 1 when operating on the larger
> > register. However, according to page 6-57 of the PA-RISC 1.1 Architectu=
re
> > and Instruction Set Reference Manual,=20
>=20
> Annoyingly, page 6-57 doesn't actually mention the interpretation of the =
f bit at all.=20
> However, I can see how the H specifier is processed in gas, and the confi=
rmation of glibc=20
> fixes is nice.

1) I can confirm the patch makes the test case run correctly.

2) The doc is probably page 6-18 (fig. 6-8) and 6-19 (table 6-16), where th=
e=20
f field for FMPYADD and FMPYSUB is documented.=20


>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~
>=20


=2D-=20
PD Dr. Andreas K. Huettel
Institute for Experimental and Applied Physics
University of Regensburg
93040 Regensburg
Germany

tel. +49 151 241 67748 (mobile)
tel. +49 941 943 1618 (office)
fax +49 941 943 3196
e-mail andreas.huettel@ur.de
http://www.akhuettel.de/


=2D-=20
Andreas K. H=C3=BCttel
dilfridge@gentoo.org
Gentoo Linux developer
(council, toolchain, base-system, perl, libreoffice)
--nextPart8915427.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAABCgB9FiEE/Rnm0xsZLuTcY+rT3CsWIV7VQSoFAmjoKWpfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZE
MTlFNkQzMUIxOTJFRTREQzYzRUFEM0RDMkIxNjIxNUVENTQxMkEACgkQ3CsWIV7V
QSpZTQ//YgEENBivZCttUKKM/jDmz7XZGXgvTwCuYD1A3R58dJjZxaI4+SA8V6sL
BrTAh2LTAIccH4OtThd6B/7HCLqFB2rV7O9L5PgWuS+QUgTQs65BO9J0eQgwAszp
qDRuwUgnKZYNw2U235crHx/bxpqZUny46aJVlfcGjL5kHYYK4DzGYz2VkpVdRtEA
5RAHhox86K1NGdC5OU2qUZCs0ivbxpE9PTHbdssPZagU+7xZf8H3RUiI2bDUafyX
TnSgrhOqsCsbGxfdTpSzP8a+vtIg1O1BI5cY0wQT/10rISV9aTA3SHmsVk1+MULD
GEYOZIE0qnKdJp8A+UYf+hcT6AAFhipkzCWWwGhsq9i68+E/fxcZG1x+QXxkFv8A
H7CJ4x1hTIGRXKm0mqMU4GGIfrsYznWZK7UWvlHm1VHaCp7SXs1NAcwJI4yveZzw
/CMSxM7xE/QlulAlRuIMtUaJ4Biy5R2n/CD3h1MlzJF4OMz3vKLIr7/jrDtueiVo
/L6Y08eUnxVCa/L2dyqIrOroP7dpXnChLzYRHGlZ4r0nY22jwZSd3sjcpkcSBrCB
2yhD5sp/ljJf1SfA4Gpt1S34h+KBSZ/NKWF4eWv78JL/VynDMZsbGNI09VVVK+zt
f5+R25+FS8YX8AIz8mgP7EvWFgT32jCLe0alI654tQfCD29FAaY=
=v2xn
-----END PGP SIGNATURE-----

--nextPart8915427.31r3eYUQgx--




