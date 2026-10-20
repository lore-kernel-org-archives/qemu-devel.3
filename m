Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC2606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=kwn4mt0Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJGlo-0002ph-0b; Tue, 20 Oct 2026 16:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJGlT-0002nb-Qn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:49:00 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJGlR-0006iv-Ei
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:48:55 -0400
Message-ID: <fccd38feddda29085cfce12466da9abd81cbc21c.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792529329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/07gytoGJUwnogtipGPDRcNrCzcPhU/WDU/EvuURPKI=;
 b=kwn4mt0Zsn8czzohK0+l9hHyI1rxAqmSv1O5hf/UhF1huB5bL0lj/FHY+AZpp6cVyL5gyC
 igQrSxrDxti6VDfRJNcGOD2lqMF34MH8CRCRu2doeJ06utlETDaqRVtLQ1QMALGu0rBFwt
 pSjSBGySayoGQSlfD5HYr1j49KmPoOc=
Subject: Re: [PATCH 1/7] target/sparc: Add crypto feature
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Tue, 20 Oct 2026 22:48:48 +0200
In-Reply-To: <a3fd0dac-c3df-4060-a621-89cf25893e91@oss.qualcomm.com>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-2-stian@itx.no>
 <a3fd0dac-c3df-4060-a621-89cf25893e91@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-gnTdh4jhctfPA2DsM2s0"
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


--=-gnTdh4jhctfPA2DsM2s0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, 2026-10-20 at 22:05 +0200, Philippe Mathieu-Daud=E9 wrote:
>=20
> Suggestion:
>=20
> =A0=A0 Add a "crypto" feature bit gating the OSA 2011 cryptographic
> =A0=A0 instructions (AES, SHA-1/256/512, CRC32C, CFR in ASR 26).
> =A0=A0 Off by default; no CPU model enables it yet; can be set
> =A0=A0 explicitly with "-cpu ...,+crypto". SPARC64 only.
>=20
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>

Thanks, I'll send a v2 with changes following this review.

Let me know if someone's in the middle of v1, and I can hold.

/Stian

--=-gnTdh4jhctfPA2DsM2s0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatfTsAAKCRDoeAEuJe36
VpOZAP4hYRTLEyRkPkEHPKaZ7HLNCTOEkN7n0pmqaVqzf9tq2QD8D/SBkawdF4Pq
zneqGyHzZJ9WI2kOEa9EdBFVxYsWOwI=
=pQTH
-----END PGP SIGNATURE-----

--=-gnTdh4jhctfPA2DsM2s0--

