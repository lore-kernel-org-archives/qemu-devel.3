Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=CxHqsR1s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzov-0000gd-51; Thu, 22 Oct 2026 16:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJzoi-0000cr-Hx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:55:18 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJzog-0001ud-Fo
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:55:16 -0400
Message-ID: <03d991dc43d5c7bc91a0bee350a11bdd8e499fa9.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792702511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XExquRDY2OoULnAynotVJuwv32yfwUvFK0ZepE2QJxo=;
 b=CxHqsR1sC2lC2GcKDTh28j6neB6XYCAjyCfKjkz9GHOOkDvRpG9xsDKZozVdQvPs8YPVyq
 GtW0S27bker3O4BBC0x4g+IDbqLOvQrX8nVZ9R5S/xxp0ROgwrKtH8mAvqRmqsGPzTADhP
 LXCmSK+DcIGuTx+8vI3p6AmZby0rWi8=
Subject: Re: [PATCH v3 4/8] target/sparc: Add the AES key expansion
 instructions
From: Stian Halseth <stian@itx.no>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>, Helge Deller
 <deller@gmx.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric
 Biggers <ebiggers@kernel.org>
Date: Thu, 22 Oct 2026 22:55:09 +0200
In-Reply-To: <b31c544d-b369-4d42-918e-ddafda444d78@ilande.co.uk>
References: <20261022070059.3861291-1-stian@itx.no>
 <20261022070059.3861291-5-stian@itx.no>
 <b31c544d-b369-4d42-918e-ddafda444d78@ilande.co.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-ty6ClDllgInIWC3A5du2"
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


--=-ty6ClDllgInIWC3A5du2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 2026-10-22 at 21:43 +0100, Mark Cave-Ayland wrote:
>=20
> Please can we match the existing style in translate.c and remove the
> indent here?

Noted for v4.

>=20
> > +=A0=A0=A0=A0=A0=A0=A0 TCGv_i64 dst, src1, src2;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0 if (!avail_CRYPTO(dc)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
> > +=A0=A0=A0=A0=A0=A0=A0 }
> > +=A0=A0=A0=A0=A0=A0=A0 if (gen_trap_ifnofpu(dc)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;
> > +=A0=A0=A0=A0=A0=A0=A0 }
>=20
> Question: is it possible for a 64-bit CPU not to have a FPU? Even
> more so, one with=20
> the crypto extensions present? I wonder if gen_trap_ifnofpu() isn't
> needed here.

Not to my knowledge, but the gen_trap_ifnofpu() is checking if FPU is
enabled, not if it's present. Every sparc64 CPU has an FPU, but it can
be switched off. It's mentioned in the OSA 2011 spec.


/Stian


--=-ty6ClDllgInIWC3A5du2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatp4LgAKCRDoeAEuJe36
Vji9AP9rc3XK2RyxbKIOTUWURorG6fEePsTlHMxo1iICtS0OSQEA4yL105EzxTlX
UdU6wBPlBksAK3XjrLTSdoz9CrIj/Ak=
=vJFe
-----END PGP SIGNATURE-----

--=-ty6ClDllgInIWC3A5du2--

