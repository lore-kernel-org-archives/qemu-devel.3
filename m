Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6E0E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVabc-0007Lk-Sn; Wed, 08 Jan 2025 13:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <santiagorr@riseup.net>)
 id 1tVabb-0007Jf-6m
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:16:35 -0500
Received: from mx0.riseup.net ([198.252.153.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <santiagorr@riseup.net>)
 id 1tVabZ-00060k-13
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:16:34 -0500
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4YSx260dwXz9vwY;
 Wed,  8 Jan 2025 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1736360190; bh=6Uj4cuqgunc6cgs/RbOfR3NOJ7bPMqHAd3GM//XtUZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n7Rpvld75XZAQ8SJFSIaoeg/6MD5iCl6wNS6hiLK/B9VXZG2p07xds41sXaKaJkgG
 xxkIXQ2sLxZSfezJP9Iq8Mhv8I1AamNNROz0i+2/l40vN/X2+BdOOfNXIercaWHEaX
 ocaHr5dDM04E5IT2itytUgI2VmPr5i980pe9d7Vo=
X-Riseup-User-ID: AE90FDA70170E7728009D1981DFFB3C3F59629FF09A4F56223BE179F97DA5617
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YSx233XrhzJrR8;
 Wed,  8 Jan 2025 18:16:27 +0000 (UTC)
Date: Wed, 8 Jan 2025 13:16:24 -0500
From: Santiago Ruano =?iso-8859-1?Q?Rinc=F3n?= <santiagorr@riseup.net>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Chuhong Yuan <hslester96@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: Addressing CVE-2024-3446 in qemu versions shipped in debian
 bullseye and older
Message-ID: <Z37A-P6FyH5Vtbul@voleno>
References: <Z3MrCyX8tVQMPjz7@voleno>
 <5dc130c8-2084-4e6f-86e2-21427f08ab33@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9HUJWsIgoENKWyEG"
Content-Disposition: inline
In-Reply-To: <5dc130c8-2084-4e6f-86e2-21427f08ab33@redhat.com>
Received-SPF: pass client-ip=198.252.153.6; envelope-from=santiagorr@riseup.net;
 helo=mx0.riseup.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--9HUJWsIgoENKWyEG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El 02/01/25 a las 08:43, Thomas Huth escribi=F3:
> On 31/12/2024 00.21, Santiago Ruano Rinc=F3n wrote:
> > Hello there,
> >=20
> > (Please CC me since I am not subscribed to the QEMU devel list.)
> >=20
> > I am working on backporting some CVE fixes to old Debian versions
> > (bullseye and previous), and I would like to ask you some help to
> > confirm if QEMU in those debian releases is affected by CVE-2024-3446 or
> > not. This is QEMU 5.2, 3.1 and 2.8.
> >=20
> > On the 7.2 branch, the following four commits are required to fix
> > CVE-2024-3446:
> > https://gitlab.com/qemu-project/qemu/-/commit/e070e5e6748e3217028fa21aa=
30bb51f862368c8
> > https://gitlab.com/qemu-project/qemu/-/commit/6d37a308159766cb90ed745cf=
eb1880937b638ec
> > https://gitlab.com/qemu-project/qemu/-/commit/e7c2df3fd748a20a8b7a316d1=
86b3ac77551f159
> > https://gitlab.com/qemu-project/qemu/-/commit/7aaf5f7778de4d75a169ab193=
f08857eb28db3a4
> >=20
> > AFAICS, the qemu_bh_new calls were replaced with qemu_bh_new_guarded in
> > 7.2.6.
> >=20
> > Please note that 6d37a308159766cb90ed745cfeb1880937b638ec (and
> > ba28e0ff4d95b56dc334aac2730ab3651ffc3132) include this bug as reference:
> > https://bugs.launchpad.net/qemu/+bug/1888606. Could you please confirm
> > the CVE relates to the same issue?
> >=20
> > I am unable to reproduce the issue. I've tried the reproducer found at
> > 6d37a308 and the one from the ubuntu referenced bug. However comment #5
> > in the ubuntu bug mentions it was reproducible with QEMU 5.0, so I am
> > confused.
>=20
>  Hi!
>=20
> Just to double-check: Did you compile your QEMU with address sanitizer
> enabled? Otherwise you might not see the issue when running the reproduce=
r.

Hi, and thanks a lot for your answer!

Yes, I am building QEMU with address sanitizer enabled. I am getting
this only ASAN-related warning when running the reproducer:

=3D=3D8384=3D=3DWARNING: ASan doesn't fully support makecontext/swapcontext=
 functions and may produce false positives in some cases!

And by your message, I am assuming you are still able to reproduce it.
Please, correct me if I am wrong. I am giving another try to see if I
can get "better" results.

>=20
>  Thomas
>=20
>=20
> > To summarise: it OK to affirm QEMU 5.x and older is unaffected by
> > CVE-2024-3446?
> >=20
> > Thanks in advance, and happy new year!
> >=20
> >   -- Santiago
>=20

Thanks,

 -- Santiago

--9HUJWsIgoENKWyEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR+lHTq7mkJOyB6t2Un3j1FEEiG7wUCZ37A+AAKCRAn3j1FEEiG
7yoyAP4wZZGSLN8p/kDhncwg1eOUbxNthyrnAe/PNa//4030igEAoMaMcbjGfIHm
isQf2nlJ1rR7pwofgWihdgGFsMgxywY=
=vAcw
-----END PGP SIGNATURE-----

--9HUJWsIgoENKWyEG--

