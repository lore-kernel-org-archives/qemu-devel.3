Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1C606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=Uh6mkPXW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN5Ge-0006Gz-Fy; Sat, 31 Oct 2026 05:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xN5GW-0006GX-VP
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 05:20:46 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xN5GU-0005kP-Uc
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 05:20:44 -0400
Message-ID: <8170d39d7d913357e7b971005cf6deeb1cf4d8d8.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1793438432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylK6dLdoVWkIYqbwcp0vFxEoZz+rVEkpb6Vq9Rz1z40=;
 b=Uh6mkPXWcaGe1i72mh4U1gBkgsKLVDUyohTDWotm6zMgiT+V5qBUa9vXGF1eINcNnR2BNb
 d74nVrm26wC78jeZJeisWrHlsGA+9chE2UqZfUHFTUBKzLee3+71+BvC+xAeXN/Df8avmc
 dERwZ6LsOAAORvJCd3rDMOsUm8iti1o=
Subject: Re: [PATCH] hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg
From: Stian Halseth <stian@itx.no>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 10:20:30 +0100
In-Reply-To: <ca0df428-9726-4b36-938f-cd3678aec697@ilande.co.uk>
References: <20261028190729.1941434-1-stian@itx.no>
 <ca0df428-9726-4b36-938f-cd3678aec697@ilande.co.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-vTnyAZc2g6BHQ2Uzzhkx"
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


--=-vTnyAZc2g6BHQ2Uzzhkx
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mark,


On Sat, 2026-10-31 at 09:06 +0000, Mark Cave-Ayland wrote:
>=20
> I wonder if we need to make it more obvious via the property name that th=
is
> is something that is not present on real hardware? As a lot of people use
> QEMU for testing SPARC installations, we should make sure that people
> understand this property is not expected to be present outside of an
> emulated environment.
>=20

Good point. I'll rename the property to "qemu,hwcap-list". That should foll=
ow
the usual vendor prefix for non-standard OF properties. I will also change =
the
OpenBIOS and kernel side to match.=A0

I'm working on some other patches now, so I plan to ship this right away.

> > +static void fw_cfg_build_hwcap_list(FWCfgState *fw_cfg, SPARCCPU *cpu)
> > +{
> > +=A0=A0=A0 static const struct {
> > +=A0=A0=A0=A0=A0=A0=A0 uint32_t mask;
> > +=A0=A0=A0=A0=A0=A0=A0 const char *name;
> > +=A0=A0=A0 } capabilities[] =3D {
> > +=A0=A0=A0=A0=A0=A0=A0 { 0, "popc" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_FSMULD, "fsmuld" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_VIS1, "vis" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_VIS2, "vis2" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_FMAF, "fmaf" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_VIS3, "vis3" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_IMA, "ima" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_CRYPTO, "aes" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_CRYPTO, "sha1" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_CRYPTO, "sha256" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_CRYPTO, "sha512" },
> > +=A0=A0=A0=A0=A0=A0=A0 { CPU_FEATURE_CRYPTO, "crc32c" },
> > +=A0=A0=A0 };
>=20
> For the existing CPU features we have a direct mapping between the featur=
e
> and the name, but for crypto it is split into individual instruction grou=
ps.
> Presumably this is because the crypto instruction implementation is
> incomplete?


The split itself comes from the hwcap-list format. A T4 lists each
group separately (aes, des, md5, sha256, crc32c and so on), and Linux
matches those names, with each driver then checking its CFR bit.

And yes, QEMU implements only some of the T4 groups: AES, SHA-1/256/512
and CRC32C. The list names exactly those, so it agrees with the CFR
value QEMU returns. I'll add a comment saying so in v2.

Thanks a lot for the review!

/Stian

--=-vTnyAZc2g6BHQ2Uzzhkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCauWy3gAKCRDoeAEuJe36
VupVAP43OVS8GrwDuhr74EDb7daQ8BEByWjl8s8gS2/g219sbQEA39kNoVFlwp5E
ALwg5g6L+nxgktRJ49MF3lOLVABJLgA=
=1WfV
-----END PGP SIGNATURE-----

--=-vTnyAZc2g6BHQ2Uzzhkx--

