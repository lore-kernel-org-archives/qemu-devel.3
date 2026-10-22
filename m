Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B4606A338
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=g3zhdLVO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzug-0001rv-Hb; Thu, 22 Oct 2026 17:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJzub-0001rZ-Ot
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:01:21 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJzuZ-0002Jp-Uv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:01:21 -0400
Message-ID: <585e3bd76ec086f46e345b1ad8504f10c486ed7c.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792702877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMDT708S+TaxgG/Fi5UDtJPaM6XxMs2BRwkl0g6ezy0=;
 b=g3zhdLVOOGeOqtB6JEx5HaD8nP6lBu16S95TVySgfWJJIQaQxsMjvOd+ZOwRyowBQmo3iQ
 sOnQT8l1om/3IWnmwsQoyGKIt1I2S322lzefbkSX6yvlp3oaDPCYYOs2j3ys5FJxIPi7OC
 7wyq6joIqycj62ledoN1kHagEvRFCvU=
Subject: Re: [PATCH v3 6/8] target/sparc: Add the SHA instructions
From: Stian Halseth <stian@itx.no>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>, Helge Deller
 <deller@gmx.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric
 Biggers <ebiggers@kernel.org>
Date: Thu, 22 Oct 2026 23:01:16 +0200
In-Reply-To: <31719eb4-deff-4217-93c0-e205dd7b170b@ilande.co.uk>
References: <20261022070059.3861291-1-stian@itx.no>
 <20261022070059.3861291-7-stian@itx.no>
 <31719eb4-deff-4217-93c0-e205dd7b170b@ilande.co.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-xbvbcNg2NisiDEjdDE4O"
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


--=-xbvbcNg2NisiDEjdDE4O
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 2026-10-22 at 21:58 +0100, Mark Cave-Ayland wrote:
>=20
> > +/* SHA helpers update fixed registers in the lower FPR bank. */
> > +static bool do_sha(DisasContext *dc, void (*func)(TCGv_env))
> > +{
> > +=A0=A0=A0 if (gen_trap_ifnofpu(dc)) {
> > +=A0=A0=A0=A0=A0=A0=A0 return true;
> > +=A0=A0=A0 }
>=20
> Same question here about presence of FPU.
>=20

Awaiting your reply to the same question in patch 5.


Thanks for taking the time to review my patches!

/Stian

--=-xbvbcNg2NisiDEjdDE4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatp5nAAKCRDoeAEuJe36
VrTpAQDzCCzLVptUgAMxVa5cVE3gQScNjzjS8kMehUlWgo92tgD+O2mmc2dpUIfT
96iLPcEsHmIrYB/YEQicWg2OxJpLugI=
=OX7r
-----END PGP SIGNATURE-----

--=-xbvbcNg2NisiDEjdDE4O--

