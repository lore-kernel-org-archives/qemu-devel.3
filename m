Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40464606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=R3QIiQWF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFnW-0007gF-G1; Tue, 20 Oct 2026 15:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJFnS-0007fJ-Ey
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:46:55 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJFnP-0001Cm-3m
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:46:53 -0400
Message-ID: <fecad49283ff57b564078da5a415455e1005669e.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792525609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNYv4BSiTDXfOC3IiceMtsyfkGp5MxNfdf0wBwVuWuY=;
 b=R3QIiQWFcvX8jG3Ho5xXx4L2hWZOASPYekJmLA/o2QCXwO8VLkr3Jyc39/v+MCpyXpP3VL
 2rqr4q//FJMw6hrfj0/HFAeeedQbp2ZusVpPn4EAnRK3WrGGxMOlZQcUQu2dt+mO1i8lvL
 qPZc8+R8o9ezLpzY5HOiPFDIWSFIrcU=
Subject: Re: [PATCH 3/7] target/sparc: Add the eight AES round instructions
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Tue, 20 Oct 2026 21:46:48 +0200
In-Reply-To: <372f00d6-35ac-4a8d-84ac-ce329dd90ae7@oss.qualcomm.com>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-4-stian@itx.no>
 <e6017bc0-22b7-4caf-932b-f9bc64687b78@oss.qualcomm.com>
 <372f00d6-35ac-4a8d-84ac-ce329dd90ae7@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-7nh5V1o7T3yOFEKK3Ykd"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-7nh5V1o7T3yOFEKK3Ykd
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-20 at 21:39 +0200, Philippe Mathieu-Daud=E9 wrote:
> On 20/10/26 21:30, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >=20
> > On 20/10/26 16:55, Stian Halseth wrote:
> > > Implement the eight AES round instructions by using QEMU's shared
> > > crypto/aes-round.h, gated behind the crypto CPU feature:
> > > - AES_EROUND01/23 and last variants
> > > - AES_DROUND01/23 and last variants
> > >=20
> > > Based on OSA (Oracle SPARC Architecture) 2011, section 7.3:
> > > AES Cryptographic Operations (4 operand)
> > >=20
> > > Signed-off-by: Stian Halseth <stian@itx.no>
> > > ---
> > > =A0 target/sparc/crypto_helper.c | 85
> > > ++++++++++++++++++++++++++++++++++++
> > > =A0 target/sparc/helper.h=A0=A0=A0=A0=A0=A0=A0 |=A0 8 ++++
> > > =A0 target/sparc/insns.decode=A0=A0=A0 |=A0 9 ++++
> > > =A0 target/sparc/meson.build=A0=A0=A0=A0 |=A0 2 +-
> > > =A0 target/sparc/translate.c=A0=A0=A0=A0 | 16 +++++++
> > > =A0 5 files changed, 119 insertions(+), 1 deletion(-)
> > > =A0 create mode 100644 target/sparc/crypto_helper.c
> >=20
> > Could we add tests (in tests/tcg, following commit 57b484e2d23
> > "target/riscv: fix RV32 fixed counter accesses" which uses the
> > debian-all-test-cross image -- where gcc-sparc64-linux-gnu is
> > available)? Actually we could put them in tests/tcg/multiarch/
> > as generic AES tests.
>=20
> (Can be done later, on top, not a blocking comment).
>=20

Noted, then I will make a v2 based on initial feedback first, then test
as a follow up.

/Stian

--=-7nh5V1o7T3yOFEKK3Ykd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatfFKAAKCRDoeAEuJe36
Vpm7AQCGb+SPZFk6MwxHQ6ZSBnk7JMyzokRWjcTqsCE0utUR2wEAhxXI8k5gPXAh
PqRIwWAJltApvp0md/fCya4jC4gXgAY=
=RVT/
-----END PGP SIGNATURE-----

--=-7nh5V1o7T3yOFEKK3Ykd--

