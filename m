Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3C606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=SU1nXYMS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQ3t-0007VM-9m; Wed, 21 Oct 2026 02:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQ3q-0007V7-C4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:44:30 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQ3o-0005Nn-6u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:44:30 -0400
Message-ID: <4cbd0143a8e6322d4f0305b5b1a8799bd1a1925b.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792565064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TsKkqTVhwdQO9VGUuaZ22LartnjUQzKBtVO2/TyxF0s=;
 b=SU1nXYMSvZjMAKkEtZLDuPUGwYmQXGMU1RWctsqp/OBz6W64dTKcKummJ6Ona5nCly8vKx
 eR0umhpfWkUs0GMttFW/lEdkowoZgEg05B893+GJr8hz9YkkLqwJx6O2lIrnBguhGV+l5i
 hF9lNVW/0y2EVNkfWQpOHzTvZuo1xlM=
Subject: Re: [PATCH 6/7] target/sparc: Add the SHA instructions
From: Stian Halseth <stian@itx.no>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Wed, 21 Oct 2026 08:44:23 +0200
In-Reply-To: <b622b220-b7d8-483a-9c7c-06cf7da22997@oss.qualcomm.com>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-7-stian@itx.no>
 <dcdb1452-5196-4edf-aaee-cb032f581526@oss.qualcomm.com>
 <b622b220-b7d8-483a-9c7c-06cf7da22997@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-4yK11F4d824dXYypzw/W"
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


--=-4yK11F4d824dXYypzw/W
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, 2026-10-21 at 06:30 +0200, Philippe Mathieu-Daud=E9 wrote:
> >=20
> >=20
> > Hmm you set TCG_CALL_NO_RWG but the helper do read env->fpr[].
> > While benign in practice because fpr[] aren't tracked as global
> > TCG regs, the correct declaration is using no flag at all:
> >=20
> > DEF_HELPER_1(sha1, void, env)
> > DEF_HELPER_1(sha256, void, env)
> > DEF_HELPER_1(sha512, void, env)
>=20
> I apologize I was wrong, your patch is correct: fpr[] is not
> a TCG global. I'm having some confusion with TCG_CALL_NO_RWG.
>=20

I came to the same conclusion. Both work, and I opted to keep the
current v1's declaration for now.

v2 is ready and tested. No other comments so far, so sending it.

/Stian

--=-4yK11F4d824dXYypzw/W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCathfRwAKCRDoeAEuJe36
VsnEAQCiu3Sj1+ghhnj0IdNF/6qWHlafZLIJTU0LJkepJbdDcQEAiX6pWP22F+Q4
s9WBxW23wZyC6Iov3p5e9R9vikqGiAw=
=nAwZ
-----END PGP SIGNATURE-----

--=-4yK11F4d824dXYypzw/W--

