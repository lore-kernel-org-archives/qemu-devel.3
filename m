Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254E606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=I1sZfJIB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8In-0004bw-Su; Wed, 28 Oct 2026 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xM8Ij-0004bf-5c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:23:05 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xM8Ig-0002w6-FG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:23:04 -0400
Message-ID: <4173affc2593f5f5b432f6e2146ad33a25d924a0.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1793211778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgLHkDD3yhWgrvqGMfKGmIQhM0LeeOLjU1L3SFfbVYQ=;
 b=I1sZfJIBK4j0TqDjgiPCzMsPjgqmWEKQMD4bnoPX3fKlqPQtsQpYsz7myxqQxIr0ciARJM
 bjpRBVPePaYZHi0/tpo/ifFZf1ZTW4e9ZZNZYSkPk3njmEo08KOgEZ42MYPiR1FNPuDu5b
 zMhVbQJMjN0LPt6l6IrbYJ8KtcrEFD4=
Subject: Re: [PATCH v2 0/2] target/sparc: Block-init stores for the crypto
 feature
From: Stian Halseth <stian@itx.no>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Richard
 Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Laurent Vivier
 <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers <ebiggers@kernel.org>
Date: Wed, 28 Oct 2026 19:22:57 +0100
In-Reply-To: <20261028113816.1651212-1-stian@itx.no>
References: <20261028113816.1651212-1-stian@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-8aJCAho9U/gf3s60xYUD"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-8aJCAho9U/gf3s60xYUD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Would it be possible to get these two patches into your next sparc pull
request, before the soft freeze on Monday?

They complete the crypto series for linux-user, so it would be good to have
them in 11.2 together with patches 1-6.

Thanks!

/Stian


On Wed, 2026-10-28 at 12:38 +0100, Stian Halseth wrote:
> With the crypto feature, guests treat the CPU as a T4 or later. On those
> CPUs a block-initializing store (ASI 0xe2 and the other twin ASIs) to the
> start of a 32-byte block also zeroes the rest of the block. glibc's
> niagara4 memset and Linux's NG4memset depend on it, and OpenSSL's T4 AES
> code uses the FP form (stdfa). Patch 1 models this for both forms; patch
> 2 then reports HWCAP_SPARC_CRYPTO in linux-user.
>=20
> v2:
> - Test the alignment with TCG_COND_TSTNE (Richard)
> - Skip offset 0 for 8-byte stores, which write it themselves (Richard).
> =A0 stba/stha/stwa at offset 0 still zero it: a T4 zeroes the rest of the
> =A0 first doubleword for those too.
> - Rebased on master, now that the crypto instructions are in
>=20
> v1: https://lore.kernel.org/qemu-devel/20261023114303.576319-1-stian@itx.=
no/
>=20
> Stian Halseth (2):
> =A0 target/sparc: Model block-initializing stores
> =A0 linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto CPU feature
>=20
> =A0linux-user/sparc/elfload.c |=A0 1 +
> =A0target/sparc/translate.c=A0=A0 | 43 ++++++++++++++++++++++++++++++++++=
++--
> =A02 files changed, 42 insertions(+), 2 deletions(-)
>=20

--=-8aJCAho9U/gf3s60xYUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCauI9gQAKCRDoeAEuJe36
VqMXAP4pbfqEeLH0PE++lhP/aXmV7GhdRoGhZThUbhH0AFU10gEA6GTM+tZFBaXL
Fvxk4P4fFB/FmnsxXIdXK4R8dv6kGw8=
=MW6U
-----END PGP SIGNATURE-----

--=-8aJCAho9U/gf3s60xYUD--

