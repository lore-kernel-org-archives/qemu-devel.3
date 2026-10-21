Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3693606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=OlyiU1I5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRhh-0000OH-Rg; Wed, 21 Oct 2026 04:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJRhb-0000Nl-MG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:29:41 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJRhZ-0008Sk-Gy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:29:38 -0400
Message-ID: <c9549a3342676bc9d70bf14c46400681b48a1d0a.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792571375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y5Ey1m30lriscKAqjahir6CA7oy3RS/J34EibD7vg50=;
 b=OlyiU1I5F6RB9Kg6F4HGSwsb7ZCxb3dsU8hwAIo7M+0qqtHmuRteOse49gV5WndVAtA9Dl
 qzjYHRx3ltL7x57LQDCg+q7WwXYsFSyxcTssAUWKLhuYF71sAiq79cAemgIeLwnLEuItoo
 1ZxYtGCFSIQMy33Ll0LFAg5khlQDVUc=
Subject: Re: [PATCH v2 6/7] target/sparc: Add the SHA instructions
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Wed, 21 Oct 2026 10:29:34 +0200
In-Reply-To: <fc4fe38e-d3f7-4d46-aad8-613df57d9260@oss.qualcomm.com>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-7-stian@itx.no>
 <fc4fe38e-d3f7-4d46-aad8-613df57d9260@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-NNOzor56CSahsmyKNzgN"
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


--=-NNOzor56CSahsmyKNzgN
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I agree with the suggested consolidation changes.

I'll send a cleanup series on top when this one lands, along with
suggested AES cleanup in patch 4.

Thanks again for the very fast handling on this :)

/Stian


On Wed, 2026-10-21 at 09:39 +0200, Philippe Mathieu-Daud=E9 wrote:
> On 21/10/26 08:46, Stian Halseth wrote:
> > Implement the SHA1, SHA256 and SHA512 instructions according
> > to OSA (Oracle SPARC Architecture) 2011 section 7.115,
> > using the algorithms defined in FIPS 180-4, and set the
> > SHA1/SHA256/SHA512 bits in the CFR.
> >=20
> > Read and update the fixed floating-point registers and mark the
> > lower FPR bank dirty. Share the SHA-2 Boolean functions between
> > the SHA256 and SHA512 helpers.
> >=20
> > Gated behind the crypto CPU feature and disabled for sparc32.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>
> > Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>
> > Signed-off-by: Stian Halseth <stian@itx.no>
> > ---
> > =A0 target/sparc/crypto_helper.c | 274
> > +++++++++++++++++++++++++++++++++++
> > =A0 target/sparc/helper.h=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +
> > =A0 target/sparc/insns.decode=A0=A0=A0 |=A0=A0 4 +
> > =A0 target/sparc/translate.c=A0=A0=A0=A0 |=A0 21 ++-
> > =A0 4 files changed, 302 insertions(+), 1 deletion(-)
>=20
>=20
> > +/*
> > + * Compress one SHA-1 block from f8-f23 into f0-f4.
> > + * Clear f5 to match SPARC M7 behavior.
> > + */
> > +void helper_sha1(CPUSPARCState *env)
> > +{
>=20
> Looking deeper, this is a dup of mips::octeon_sha1_transform()
> in target/mips/tcg/octeon_crypto.c.
>=20
> > +}
> > +
> > +/* SHA-2 Boolean functions. */
> > +static inline uint64_t sha_ch(uint64_t x, uint64_t y, uint64_t z)
> > +{
> > +=A0=A0=A0 return (x & y) ^ (~x & z);
> > +}
> > +
> > +static inline uint64_t sha_maj(uint64_t x, uint64_t y, uint64_t z)
> > +{
> > +=A0=A0=A0 return (x & y) ^ (x & z) ^ (y & z);
> > +}
> > +
> > +static const uint32_t sha256_k[64] =3D {
>=20
> Dup of s390x::K and mips::k.
> (target/s390x/tcg/cpacf_sha256.c)
>=20
> > +};
> > +
> > +static const uint64_t sha512_k[80] =3D {
>=20
> Dup of s390x::K and mips::k.
> (target/s390x/tcg/cpacf_sha512.c)
>=20
> > +};
> > +
> > +/* Compress 16 numeric message words into the supplied SHA-256
> > state. */
> > +static void sha256_compress(uint32_t state[8], const uint32_t
> > block[16])
> > +{
>=20
> Dup of s390x::sha256_bda() and mips::octeon_sha256_transform().
>=20
> Worth consolidate as include/crypto/sha-block.h
>=20
> > +}
> > +
> > +/* Compress 16 numeric message words into the supplied SHA-512
> > state. */
> > +static void sha512_compress(uint64_t state[8], const uint64_t
> > block[16])
> > +{
>=20
> Dup of s390x::sha512_bda() and mips::octeon_sha512_transform().
>=20
> > +}
> Since this commit is reviewed, let's do a consolidation cleanup on
> top.

--=-NNOzor56CSahsmyKNzgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCath37gAKCRDoeAEuJe36
VjGIAPsGT5xNNAFgWrsgflUC9FYseWa27LX7271KFOlyO5Xi1gEArRtUdLGzHAsC
TBL7fjVb2qg2kFEoMoN9vjwidlaHyAg=
=RzeN
-----END PGP SIGNATURE-----

--=-NNOzor56CSahsmyKNzgN--

