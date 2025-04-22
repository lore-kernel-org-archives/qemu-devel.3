Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFEAC369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zh7-00089l-2j; Wed, 23 Apr 2025 08:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7Zh4-00087c-3V
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7Zh2-0006g6-Ed
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745413151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=oBrYJNriCXZk8J0CSJ2GnGEYfxno/8nVGIFpIelLlyM=;
 b=XUkcHmlCHkzLHaPL/RYhADj2T9Oq9koKNn9uKN8CBJbPGokW3RMy5jwdinConMpv9Wgw3E
 Se0tIyG4u6hVOquuIUmIgsg8OSt1nUdZwGDjhNV9NBEO3qRX3k7stIZsH1GObjpbMqJ3jC
 2RkdLOqXW+QO0tnX7elqInimfWOUtYU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-peV8sNK2OFGlYMUX9Kkfrw-1; Wed,
 23 Apr 2025 08:59:07 -0400
X-MC-Unique: peV8sNK2OFGlYMUX9Kkfrw-1
X-Mimecast-MFC-AGG-ID: peV8sNK2OFGlYMUX9Kkfrw_1745413147
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 935B51800370; Wed, 23 Apr 2025 12:59:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEDAD19560A3; Wed, 23 Apr 2025 12:59:05 +0000 (UTC)
Date: Tue, 22 Apr 2025 11:41:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Migration compatibility test broken on major version releases
Message-ID: <20250422154131.GA308586@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7xNKQKfrJ7sUr5g6"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.294, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--7xNKQKfrJ7sUr5g6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabiano,
The build-previous-qemu job does not work when a new major version is
released:
https://gitlab.com/qemu-project/qemu/-/jobs/9788294494

The previous version computation produces "v10.0.0" when testing:

  $ export QEMU_PREV_VERSION=3D"$(sed 's/\([0-9.]*\)\.[0-9]*/v=E2=90=81.0/'=
 VERSION)"
  $ git remote add upstream https://gitlab.com/qemu-project/qemu
  $ git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VE=
RSION
  warning: redirecting to https://gitlab.com/qemu-project/qemu.git/
  fatal: couldn't find remote ref refs/tags/v10.0.0

The CI job runs before the v10.0.0 tag is pushed to the repo. (The tag
is only pushed once tests have passed.)

Even if the tag was there and git fetch succeeded, the test would test
migration between v10.0.0 and v10.0.0, which doesn't seem to be the
purpose of the test.

Please adjust the test to handle this situation. For now I will re-run
the job after pushing the final tag (since it already passed for the
release candidate tag).

Thanks!

Stefan

--7xNKQKfrJ7sUr5g6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgHuKoACgkQnKSrs4Gr
c8ijEQf/UE+vJZsHp22gBf6GFLjHuHgZ9aYOTM7D4z5zTJjA1A/pO6Zk7qHbDah/
8/NEMU678FQ39lc+tCCZ44+a7BB+5Xz3atddvqFP9GH0TxOenai+2oj3znuMMoCu
ilCmdX9qkNzTV8L+qmj2VfL4QAl32v57kPlb9smEOEUsCYyCQyL1VMseYhPRlUNW
oLH4Eyfx+NepiSWjuzENOTDPXlaY/0GB+GTNVW6GmolUaTuQsyWmF2HPW5fpfWDC
V6DGpCA0sfeMbH2co1jO6NLkDeHM6YqwBc3i9rP7U83kks4wASwGJqvSoWKD5c03
pJntiU42iK23sJErly5mcwfgqXC1iQ==
=V6s8
-----END PGP SIGNATURE-----

--7xNKQKfrJ7sUr5g6--


