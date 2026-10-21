Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058B606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=VTUg/DiB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRcE-0007m1-BQ; Wed, 21 Oct 2026 04:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>)
 id 1xJRcB-0007lh-6B; Wed, 21 Oct 2026 04:24:03 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>)
 id 1xJRc8-00083b-Mg; Wed, 21 Oct 2026 04:24:02 -0400
Message-ID: <ea87bcf45ea0f243887d9c0e78fce175795aa58d.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792571036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISWWj11fiXyKJn3Av8CQWWsk3q/pNaR0p/3W2UXWKus=;
 b=VTUg/DiBqwfdHfogs/jJ2lKctBVjt75uXgAwwUvhSSbu42yiNxIDX2a+Rhi8MUTRjwYbxp
 aepA6J9DnOz0qwFk03plPtqr0zsPwtHjtHFbbmTcr8eYXBcxSyS7JN1V4COP8tghZa4L+W
 u0IrfC7fZea+Y337QS9dfIA/2P5UfmE=
Subject: Re: [PATCH v2 4/7] target/sparc: Add the AES key expansion
 instructions
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>,  qemu-riscv <qemu-riscv@nongnu.org>
Date: Wed, 21 Oct 2026 10:23:54 +0200
In-Reply-To: <145a7086-d9eb-4cf0-a162-b3a44d51e9e6@oss.qualcomm.com>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-5-stian@itx.no>
 <145a7086-d9eb-4cf0-a162-b3a44d51e9e6@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-XI4VePBxJXN7qzlotdbQ"
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


--=-XI4VePBxJXN7qzlotdbQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, 2026-10-21 at 09:26 +0200, Philippe Mathieu-Daud=E9 wrote:
> > +/* Combine the transformed word with the two words in rs1. */
> > +static uint64_t aes_kexpand(uint64_t rs1, uint32_t t)
> > +{
> > +=A0=A0=A0 uint32_t hi =3D (rs1 >> 32) ^ t;
> > +=A0=A0=A0 uint32_t lo =3D (uint32_t)rs1 ^ hi;
> > +
> > +=A0=A0=A0 return ((uint64_t)hi << 32) | lo;
>=20
> Alternatively:
>=20
> =A0=A0=A0=A0=A0=A0=A0 return deposit64(lo, 32, 32, hi);

Will be adopted in v3.

>=20
> > +}
> > +
> > +/* Apply the AES S-box to each byte, preserving byte positions. */
> > +static uint32_t aes_subword(uint32_t x)
> > +{
> > +=A0=A0=A0 return ((uint32_t)AES_sbox[x >> 24] << 24) |
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ((uint32_t)AES_sbox[(x >> 16) & 0xff] <=
< 16) |
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ((uint32_t)AES_sbox[(x >> 8) & 0xff] <<=
 8) |
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (uint32_t)AES_sbox[x & 0xff];
> > +}
>=20
> We could move that method to include/crypto/aes.h and re-use
> it in RISCV's vaeskf1_vi / vaeskf2_vi helpers.

Yes, makes sense. I would prefer to do it in a follow-up that also
converts the RISC-V helpers. Keeping this SPARC-only.

>=20
> > +
> > +/*
> > + * AES Cryptographic Operations 4-operand (Section 7.3)
> > + * AES key expansion with RotWord, SubWord, and RCON.
> > + */
> > +uint64_t helper_aes_kexpand1(uint64_t rs1, uint64_t rs2, uint32_t
> > imm)
> > +{
> > +=A0=A0=A0 static const uint8_t rcon[10] =3D {
> > +=A0=A0=A0=A0=A0=A0=A0 0x01, 0x02, 0x04, 0x08, 0x10,
> > +=A0=A0=A0=A0=A0=A0=A0 0x20, 0x40, 0x80, 0x1b, 0x36,
>=20
> This table is also used by RISCV aes64ks1i, vaeskf1_vi, and
> vaeskf2_vi,
> so we could add a common const uint8_t AES_rcon[10] in
> include/crypto/aes.h:

Same for this one. If you'd rather have it in this series, I can add it
as a preparatory patch in v3.


/Stian


--=-XI4VePBxJXN7qzlotdbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCath2mgAKCRDoeAEuJe36
VqXYAQC6+W8hbry5GrghNvvXppBZyKOCAJvD0yeFVsYivqFTsgEAvHmxo/LJiNzN
dBr8hdLiU8oxYpkPsqBpo/p4s53e6ws=
=fq7k
-----END PGP SIGNATURE-----

--=-XI4VePBxJXN7qzlotdbQ--

