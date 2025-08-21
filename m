Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB7CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5iu-0005k5-EO; Thu, 21 Aug 2025 09:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up5is-0005jb-F2
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up5iq-0001pB-0Y
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755784373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tCRm9jJP/48n9oGwebzoMb+7M+UO9hhJTgsWD3dj+0=;
 b=dKjmR34bbM4OFiCFfRiWyqm9upsjnZ1PxUqniz9/AXJOkCIg6XvUaJzHpXB3dRKpKS5Evz
 zu+QsWw7y0ZBdaC0Hi1CH3cSigUaDcB5utaR112BZoKYVzDhYlDHozijtgxD77ba3Q7+fp
 dCD2kxAhxo8GffecOv7S1YJiY/y1c10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-VH5LgNPsNS23ez6cirWjCg-1; Thu,
 21 Aug 2025 09:52:51 -0400
X-MC-Unique: VH5LgNPsNS23ez6cirWjCg-1
X-Mimecast-MFC-AGG-ID: VH5LgNPsNS23ez6cirWjCg_1755784370
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D1BB18002A1; Thu, 21 Aug 2025 13:52:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92E8B19560B0; Thu, 21 Aug 2025 13:52:49 +0000 (UTC)
Date: Thu, 21 Aug 2025 09:52:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: snek testsuite breaks in 10.1 for qemu-system-arm on armhf
Message-ID: <20250821135248.GA6045@fedora>
References: <CAATJJ0K6coKjwwmkzaWP7dzQHLsEoL3rkU95T69rxZ6fdbnXqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BL/YzKFqh22+iaYY"
Content-Disposition: inline
In-Reply-To: <CAATJJ0K6coKjwwmkzaWP7dzQHLsEoL3rkU95T69rxZ6fdbnXqg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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


--BL/YzKFqh22+iaYY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 02:52:46PM +0200, Christian Ehrhardt wrote:
> Hi,
> Debian and Ubuntu run the self tests of snek as integration tests like:
>=20
> `make SNEK_NATIVE=3D/usr/bin/snek SNEK_ARM=3D/usr/share/snek/snek-arm
> SNEK_RISCV=3D/usr/share/snek/snek-riscv -C test check`
>=20
> Those tests recently generated signal by failing in the arm emulation
> tests with `qemu-system-arm` - full log [1].
>=20
> ```
> 224s Running test pass-precedence.py.
> 224s     pass python3
> 224s     pass snek
> 224s pass-precedence.py:72 Syntax error at "".
> 224s     ***************** snek-arm fail *********************
> 224s     pass snek-riscv
> ```
>=20
> 14 tests failed, but all with quite similar signatures.
>=20
> But that only happens when executed on armhf, the other host
> architectures are all happy [2].
>=20
> I've separated the test and ran a git bisect on qemu 10.0 -> 10.1 as
> somewhere here is the trigger.
> That worked fine and identified this change [3].

CCing Richard Henderson since this was bisected to the following commit:

commit cf4905c03135f1181e86c618426f8d6c703b38c0
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Sun Jan 12 20:29:41 2025 -0800

    tcg: Convert deposit to TCGOutOpDeposit

>=20
> I must admit, I was able to debug it until here, but I can't see how
> these snek test failures could be caused by that change.
> And yes - arm emulation on an armhf platform isn't the most common scenar=
io.

QEMU v10.1.0-rc4 has been tagged and the final QEMU v10.1.0 release is
scheduled for Tuesday, August 26th. I think a fix for this issue can go
through the -stable tree and be released as part of QEMU v10.1.1 since
the number of users affected appears to be small. Please let me know if
you disagree.

Thanks,
Stefan

>=20
> I can't predict if there is anything wrong in snek which now is
> treated differently by qemu to trigger this or if snek is all fine and
> qemu broken something - Therefore I've also reported it to snek [4].
>=20
> The tracking of the initial finding in Ubuntu is here if you want to
> see more about how this commit was identified [5].
>=20
> [1]: https://autopkgtest.ubuntu.com/results/autopkgtest-questing/questing=
/armhf/s/snek/20250818_045020_246a4@/log.gz
> [2]: https://autopkgtest.ubuntu.com/packages/s/snek
> [3]: https://salsa.debian.org/qemu-team/qemu/-/commit/cf4905c03135f1181e8=
6c618426f8d6c703b38c0
> [4]: https://github.com/keith-packard/snek/issues/103
> [5]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2121124
>=20
> --=20
> Christian Ehrhardt
> Director of Engineering, Ubuntu Server
> Canonical Ltd
>=20

--BL/YzKFqh22+iaYY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAminJK8ACgkQnKSrs4Gr
c8gieQgAos4xukxyaHcil/JH3dyji6wAAFL5ZIKy4+yzwY4eaddoN7APVLhb7nxL
26NYE7XREdM93Gn+JXHjmhGHevo72zXCQ3lJOixbmUUWuIE0Kh6LgylMQOqhvoOD
CEEvx8kuJ2FOfKVpQTAYMrnKtVL2jGMt42mSejgzPcUWFDGoVjDz+vjJlD/DQniE
0fWgK3plw7kmVS7kmDK14EfX6vy0yvsv/foLUAs2DsWxcRQNhZt9A76b//VjxoIT
ikopsBPjwFO5qvXQPyYdX6APjClEBLIQap8CCNeaPFZSl4k5iOor/7CdT2yji2Tr
hV4KUYirSGHGxnK6FmS0GTnUOj2low==
=3QFC
-----END PGP SIGNATURE-----

--BL/YzKFqh22+iaYY--


