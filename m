Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=FV+oQzRc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0Rw-0008C9-CB; Thu, 22 Oct 2026 17:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xK0Rt-0008Bi-RO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:35:46 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xK0Rq-0005i5-QF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:35:45 -0400
Message-ID: <1fd05452f9af78f9d54546b752a389fe384c2939.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792704939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnZHlahvPqV2sdR5rmJwiXjVMg34qe7f9XS8SOX6db4=;
 b=FV+oQzRciZEfg64aysx8v5WO2MZeOsPYWWqtU7SUwDqSlMk/dsnkC/d6Kh2ZHhXiMVRloY
 EbXqbCIR5HLijpQDoJyuhDHH4eeP7rl5+DvpcSolcbGfCxmRKINwm7wDtmFtPfKEwwENbE
 5a2Bli7kib1plqv5e8mWsJuYhmHxXnc=
Subject: Re: [PATCH v3 7/8] target/sparc: Allow block-init stores when the
 CPU has the crypto feature
From: Stian Halseth <stian@itx.no>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>, Helge Deller
 <deller@gmx.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric
 Biggers <ebiggers@kernel.org>
Date: Thu, 22 Oct 2026 23:35:38 +0200
In-Reply-To: <6dd0a00a-eeb6-4680-b1e5-a2518b604fdc@ilande.co.uk>
References: <20261022070059.3861291-1-stian@itx.no>
 <20261022070059.3861291-8-stian@itx.no>
 <6dd0a00a-eeb6-4680-b1e5-a2518b604fdc@ilande.co.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-LGcg5IcASBBYlmlMIthk"
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


--=-LGcg5IcASBBYlmlMIthk
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 2026-10-22 at 22:01 +0100, Mark Cave-Ayland wrote:
>=20
>=20
> Hmmm. Feels like we're getting a bit blurred here between the crypto
> feature and other sun4v features, however I think we're just going to
> have to go with this for now.=A0

Yes. The approach was discussed on the list. As Richard mentioned,
ideally the sun4v platform could be used, but since it's incomplete, it
would require a lot of work.

> Presumably no other interesting ASIs have showed up in your tests so
> far?
>=20

Thanks for the review, but your question made me think about openssl,
and I found a real problem that I didn't see before. Please don't apply
7/8 and 8/8.

On real hardware, a store to ASI 0xe2 at an aligned address also zeroes
the rest of the block. I measured it: the T4 zeroes the 32-byte block,
the M7 the whole 64-byte line. Other offsets are plain stores.

glibc's niagara4 memset depends on this. For zeroing it only stores
two of every eight words and lets the hardware clear the rest. QEMU
does a plain 8-byte store, so with 7/8 and 8/8 a memset(p, 0, n) of
more than about 120 bytes leaves stale data behind. OpenSSL from a
Gentoo stage3 crashes at startup because of it. So 7/8 only turns
the SIGILL into silent corruption.

And then I found a second gap..!
QEMU rejects the FP form (stda %f, 0xe2), which OpenSSL's T4 AES code
uses for large buffers. OpenSSL probes the CFR itself rather than
AT_HWCAP, so with only 1-6 and -cpu ...,+vis3,+crypto, AES-CBC/CTR on
large inputs gets SIGILL. SHA and the other instructions work fine with
OpenSSL.

My suggestion: 1-6 can go in as Philippe proposed, since the feature
is opt-in. I'll withdraw 7/8 and 8/8 and send a separate series that
models block-init stores properly (integer and FP, zero-fill as on the
T4), with the hwcap patch on top. I have a memset/memcpy test that
passes natively on the T4 and catches this, so that series will come
with better testing.

Sorry for the churn, and thanks for asking the right question.

/Stian

--=-LGcg5IcASBBYlmlMIthk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatqBqgAKCRDoeAEuJe36
VnoqAQDdsdNuWtsJq9eIqXEvyZxT9RPWPYtnOACeT9z4G4ixKwEAhR9Znj36x3yY
A6gUGo5XLm+uuMlW+50O7xsM7Y3c5QQ=
=ygRf
-----END PGP SIGNATURE-----

--=-LGcg5IcASBBYlmlMIthk--

