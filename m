Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A8606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=JnaL33IM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1jQ-0003lO-Ee; Wed, 28 Oct 2026 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xM1jL-0003kw-R5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:22:08 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xM1jJ-0002oc-AJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:22:07 -0400
Message-ID: <c968085fc1c6f5788bea0100792a7b33bd02b15f.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1793186514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ikKvpHiFjdXmf593ZxIu6PhIe/Sw9d+rHzPiFl6kEdA=;
 b=JnaL33IMQk0eoum0JkPhU137mZuaKEYXn8TCfUD5XjTbJYpUqb3NeV7JmNalJv8FkcfgGz
 r2D7pXyMpWFjL6yOn3dDqv5B8j8DEG3e/1fClJh724tM64Ibgfwim99UeA8SmYJl5SvyD3
 dyHgN+mGTcg7fxj8jNI6M2KSYSi7E0c=
Subject: Re: [PATCH 1/2] target/sparc: Model block-initializing stores
From: Stian Halseth <stian@itx.no>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>, Helge Deller
 <deller@gmx.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric
 Biggers <ebiggers@kernel.org>
Date: Wed, 28 Oct 2026 12:21:52 +0100
In-Reply-To: <c7703ab2-55c0-4279-81a5-961752f1ab94@linaro.org>
References: <20261023114303.576319-1-stian@itx.no>
 <20261023114303.576319-2-stian@itx.no>
 <c7703ab2-55c0-4279-81a5-961752f1ab94@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-/5JknJppk/wga+yPdFoh"
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


--=-/5JknJppk/wga+yPdFoh
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, 2026-10-28 at 05:51 -0500, Richard Henderson wrote:

>=20
> tcg_gen_brcondi_tl(TCG_COND_TSTNE, addr, 31, skip);

Thanks, adopting in v2.

> You don't need to store to offset 0, because...
> ... that's done here.

Yes, for stxa and stdfa, but stba/stha/stwa with the same ASIs also reach
gen_blkinit_zero() through gen_st_asi().

I tested on the T4, and those zero the rest of the first doubleword
as well (v =3D stored byte, 0 =3D zeroed, one 32-byte block):

  stba off=3D0:  v0000000000000000000000000000000
  stha off=3D0:  vv000000000000000000000000000000
  stwa off=3D0:  vvvv0000000000000000000000000000

So v2 skips offset 0 only for 8-byte stores.

Thanks for the review!

/Stian


--=-/5JknJppk/wga+yPdFoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCauHa0AAKCRDoeAEuJe36
VtjaAP0dqeXLagbY+FWwNtvGySixQNp/9ShgwvduPi8yhJ0vvwEAv6BXFvAKv86Y
fuYzUowc6yqlW4lO7obJQ4iAYmnSQAk=
=dN6O
-----END PGP SIGNATURE-----

--=-/5JknJppk/wga+yPdFoh--

