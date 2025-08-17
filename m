Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30206CA0EE4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Aug 2025 13:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1undTp-0001I0-CE; Sun, 17 Aug 2025 09:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1undTn-0001Hs-Be
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 09:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1undTi-0005IZ-Ki
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755437475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdUgV+Om+7kKKcml77EkHFe+tBzMSY0Zl9CAWFTba7Y=;
 b=aL/Jcb7FNsF6YWbntFqNCphDrLattUWkRfhpg47c94JTrQUL3wMDZJD18UJtukuPzC7DFC
 wUSSuVKKSE1B8DeH9nfC7s5gO4hR4F6vqf/b84wEqBdmhlHww//lTivYQ69uk0OfwzWZVH
 B3Imj0Vm6xAi8OPjCBIUwpIkzF+2hrw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-2nNEvL2lNMiK5Y-pKfUSaQ-1; Sun,
 17 Aug 2025 09:31:08 -0400
X-MC-Unique: 2nNEvL2lNMiK5Y-pKfUSaQ-1
X-Mimecast-MFC-AGG-ID: 2nNEvL2lNMiK5Y-pKfUSaQ_1755437467
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88CA2180047F; Sun, 17 Aug 2025 13:31:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2DC81800446; Sun, 17 Aug 2025 13:31:06 +0000 (UTC)
Date: Sun, 17 Aug 2025 09:31:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for
 MicroMIPS and MIPS16e ASEs
Message-ID: <20250817133105.GA320336@fedora>
References: <20250814070650.78657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qeFv8pXADlVwLoeV"
Content-Disposition: inline
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--qeFv8pXADlVwLoeV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 09:06:47AM +0200, Philippe Mathieu-Daud=E9 wrote:
> We weren't parsing MIPS ASE in the ELF header, so couldn't
> automatically pick an appropriate CPU.
>=20
> Since we'll have a rc4, I propose these sensible patches
> for 10.1, but both ASEs are available since 15 years in QEMU,
> so this isn't something broken since the latest release, and
> I don't mind holding it for 10.2.

Starting from -rc3 onwards I prefer to merge only release blockers.
Other bug fixes should wait for the next release because non-essential
fixes might introduce issues that cause the release schedule to slip.

Thanks,
Stefan

>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (3):
>   elf: Add EF_MIPS_ARCH_ASE definitions
>   linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
>   linux-user/mips: Select M14Kc CPU to run microMIPS binaries
>=20
>  include/elf.h                | 7 +++++++
>  linux-user/mips/target_elf.h | 6 ++++++
>  2 files changed, 13 insertions(+)
>=20
> --=20
> 2.49.0
>=20
>=20

--qeFv8pXADlVwLoeV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmih2ZkACgkQnKSrs4Gr
c8hDTQgAmYKbJ1jcIwY+/mX3spOY5wmo+noo64nCnfvSGCJFYrrreBzBGiVZR4cC
NjvRUPx7OdKm2zXacb+9Du6Xk9k2V8Qb7YyuladiQiIV5y1fxnVYpu1cLOYm58O3
YyziIRwnm9zt5dEui5kb9zgi3aUnF6G5nIgzgNaWzesh1MlKPHaSA6fsJb/MPKTT
Uh6CVk3SKlMJ0eXQAYU9LRrnyXTGOmr2SMAJ6cYf5mDhdTy6iM0cWQgt9feg7ELG
wEI29cpN1g1ZhmevHr218vEXwvIKJcIaDTO00QZH+liQDo4NK/UoJeD71KdUxh+H
iQH8NPDmrPGKUzQaOMbgrTl7xhpmkA==
=0Zfu
-----END PGP SIGNATURE-----

--qeFv8pXADlVwLoeV--


