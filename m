Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96354606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=m2h9GPgA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFmG-0007Kk-OM; Tue, 20 Oct 2026 15:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJFmC-0007KQ-B0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:45:36 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJFmA-0001A1-BK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:45:36 -0400
Message-ID: <962d5d463387cdc03f637f7fe09f8e68dc438bf6.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792525531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1DgD3AtruOYj5SoaD29++T7zdUotV5ZFpW/gldOmei4=;
 b=m2h9GPgADDqhpwsTRejMTWTwuc0h+SpbAcTrvgPpb91MmtfwgyEUUdFfh5q0ZNtYE49az5
 cbOruNERdl9xOgXRfWIZySBbRoz+20ssr4qQ/9RWM7Fi6JutQnuwCmjXnPhioOAuurL6ZI
 PpD6w3yHU22O4tSU0YtfnqQJtQgn2A8=
Subject: Re: [PATCH 3/7] target/sparc: Add the eight AES round instructions
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Tue, 20 Oct 2026 21:45:29 +0200
In-Reply-To: <e6017bc0-22b7-4caf-932b-f9bc64687b78@oss.qualcomm.com>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-4-stian@itx.no>
 <e6017bc0-22b7-4caf-932b-f9bc64687b78@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-/up5L9UcURgMS0zYG6Ra"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-/up5L9UcURgMS0zYG6Ra
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe, thanks again for reviewing.

On Tue, 2026-10-20 at 21:30 +0200, Philippe Mathieu-Daud=E9 wrote:
>=20
>=20
> Could we add tests (in tests/tcg, following commit 57b484e2d23
> "target/riscv: fix RV32 fixed counter accesses" which uses the
> debian-all-test-cross image -- where gcc-sparc64-linux-gnu is
> available)? Actually we could put them in tests/tcg/multiarch/
> as generic AES tests.
>=20

Sure. I'll start working on tests after fixing other stuff that comes
up during initial review.

> >=20
> > +/*
> > + * SPARC four-operand AES round (Section 7.3).
> > + * s2:s3 holds the state in big-endian order; half selects output
> > columns
> > + * 0-1 or 2-3, and key supplies their round key.=A0 dec selects
> > decryption;
> > + * last omits MixColumns/InvMixColumns.=A0 Return the selected 64-
> > bit half.
>=20
> Please document the non-obvious invariant:
>=20
> =A0 * Note all 64-bit values (state and key) hold AES bytes in big-
> endian
> =A0 * order, i.e. the most significant byte is the first state byte.

Noted for v2.

>=20
> > + */
> > +static uint64_t aes_round(uint64_t key, uint64_t s2, uint64_t s3,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 int half, bool dec, bool last)
> > +{
> > +=A0=A0=A0 AESState st, rk =3D { 0 }, r;
> > +=A0=A0=A0 const unsigned first =3D HOST_BIG_ENDIAN ? 0 : 1;
> > +=A0=A0=A0 const unsigned out =3D first ^ half;
> > +
> > +=A0=A0=A0 st.d[first] =3D s2;=A0=A0=A0=A0=A0=A0 /* columns 0-1 */
> > +=A0=A0=A0 st.d[first ^ 1] =3D s3;=A0=A0 /* columns 2-3 */
> > +=A0=A0=A0 rk.d[out] =3D key;
>=20
> Nitpicking, maybe zero the other half explicitly here instead of { 0
> }:
>=20
> =A0=A0=A0=A0=A0=A0=A0 rk.d[out ^ 1] =3D 0;

Noted for v2.


/Stian


--=-/up5L9UcURgMS0zYG6Ra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatfE2QAKCRDoeAEuJe36
VhcRAQCHaSpPJpu545YOa6vl5HxrOYEn6uxFwpWd3227AuATSAEA85SKC5Qi5N8b
P6f/21HK2Hy8i2DOnQZX+rM2dJ/91gg=
=y0w9
-----END PGP SIGNATURE-----

--=-/up5L9UcURgMS0zYG6Ra--

