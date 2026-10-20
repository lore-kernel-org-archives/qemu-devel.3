Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E0606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=kDw0Rlv0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFPf-0001cY-Fo; Tue, 20 Oct 2026 15:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJFPX-0001cC-Cm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:22:11 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJFPU-0007fX-DK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:22:10 -0400
Message-ID: <ccf9cdff5f8775d92501d33373aedc7ba353bd2c.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792524124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6fb9FYcrLXmjz258pwdzhE63t5RvZIaOVjRd6aMniw=;
 b=kDw0Rlv0vZ4OzXlwnsB2acmMiI9JjjFWpnXUHKffP6PMWH7Lgs5/RUC/0W+NZ6FzrRVzxN
 bYqniM8F3AB3XITJmynTHRMu0xMmtYpuwlyA7UEmWePMVlYtg0kAopfX4vjLW4amgJ+Mfp
 jrPVjYMuGbAEOj4cHueqvFdLfQH57iI=
Subject: Re: [PATCH 2/7] target/sparc: Return CFR when crypto feature is
 enabled
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Tue, 20 Oct 2026 21:22:02 +0200
In-Reply-To: <77e977bb-f559-4023-b996-b1ae81cb74cc@oss.qualcomm.com>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-3-stian@itx.no>
 <77e977bb-f559-4023-b996-b1ae81cb74cc@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-zcgaPAZo+Nceygl2eCRx"
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-zcgaPAZo+Nceygl2eCRx
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, 2026-10-20 at 20:58 +0200, Philippe Mathieu-Daud=E9 wrote:
> On 20/10/26 16:55, Stian Halseth wrote:
> > ASR 26 returns a Compatibility Feature Register (CFR) when the
> > crypto feature is on.=A0 Without the crypto feature, a read keeps
> > strand status as before.
> >=20
> > Reports AES, SHA1, SHA256, SHA512, CRC32C.
>=20
> IIUC to keep the series bisectable, this patch should be
> re-ordered *after* the "Add FOO instruction" ones, otherwise:
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>
>=20

Thanks for the review!

You're right, and I'll move this patch after the instructions patches
in v2, with your Reviewed-By.

I'll hold off v2 for a couple of days to allow more reviewers to
respond.

/Stian

--=-zcgaPAZo+Nceygl2eCRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCate/WgAKCRDoeAEuJe36
Vo/4AP45sX5QH4MrxwraKryn82rcU+rBTIXvgmTEgy/jyr+wXQD+OXrtxPLeydRg
Mu3RnZTLg4Y159QE6kaGDEPukFB/jgM=
=jQ3L
-----END PGP SIGNATURE-----

--=-zcgaPAZo+Nceygl2eCRx--

