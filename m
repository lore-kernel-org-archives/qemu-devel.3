Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E37E7718D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJhA-0000U5-CZ; Thu, 19 Dec 2024 11:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOJh2-0000TG-Kj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOJh1-0000oM-0f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734626886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EItUpOlPqmr3nU661wORxb/VGtmQG1PbYDpUcuC08uQ=;
 b=hsam78Ldted5N0kSuZdUwn/uf0a1nShcKWpL7x1wbvZVfl+5+1ebZ/SYUY/XkkbgdULIxS
 5etAR/bRMLMqPJaS6IkIPsm6lPNV807WWVLPggeqXhcE37iI0BKH0eLMKacect3ImvQCPA
 nLq6VCWDqzIO1ZUoNvF+X0fO04yg4zY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-XobKkIEaPo-hXAPsd5aAAw-1; Thu,
 19 Dec 2024 11:48:04 -0500
X-MC-Unique: XobKkIEaPo-hXAPsd5aAAw-1
X-Mimecast-MFC-AGG-ID: XobKkIEaPo-hXAPsd5aAAw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F30F1956086; Thu, 19 Dec 2024 16:48:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC7181953953; Thu, 19 Dec 2024 16:48:02 +0000 (UTC)
Date: Thu, 19 Dec 2024 07:32:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
Message-ID: <20241219123213.GA692742@fedora>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q7H7AVznsKd9CwNQ"
Content-Disposition: inline
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Q7H7AVznsKd9CwNQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabiano,
Please take a look at this CI failure:

>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x UBSAN_OPTI=
ONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktra=
ce=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OPTIONS=3D=
halt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1=
 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 PYTH=
ON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/pyvenv/b=
in/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage=
-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-pro=
ject/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3awx_3/=
0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
Traceback (most recent call last):
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scrip=
ts/analyze-migration.py", line 688, in <module>
    dump.read(dump_memory =3D args.memory)
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scrip=
ts/analyze-migration.py", line 625, in read
    section.read()
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scrip=
ts/analyze-migration.py", line 461, in read
    field['data'] =3D reader(field, self.file)
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scrip=
ts/analyze-migration.py", line 434, in __init__
    for field in self.desc['struct']['fields']:
KeyError: 'fields'
warning: fd: migration to a file is deprecated. Use file: instead.
warning: fd: migration to a file is deprecated. Use file: instead.
**
ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret =3D=3D=
 0): (1 =3D=3D 0)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190

If you find this pull request caused the failure, please send a new
revision. Otherwise please let me know so we can continue to
investigate.

Thanks,
Stefan

--Q7H7AVznsKd9CwNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdkEk0ACgkQnKSrs4Gr
c8h2DQf/bBPkqwfHPnC6r44lfoHjp0G+mrrDEWvknsCXaVGw8LmoC9+sCpyS1Cun
lcR57+qBlfyAkKGNXO/L9yF6u+jse4K+IUCuRGeW6XiCxPZA65hkXACutO+wDleY
+9a1c58IU+G25M7qxc5MRARSANrV4IMgfNroZunHNvIWCv60EqKh3h6qi98tWqVF
ZHj9W1Me3QQN9fzthzzr7LJuVZfTKy0lLsykW/VJ5M/81XVwviNMsHsbNpHfLf1/
Tyn3bGFvK94H5Qcn/Ts7WwBYJd/8CY2LCe8GY28AWXY261WFn8OXa5pFFh8udKS5
z+aG/YErQweBPT+1jf+84WR6k1CXZg==
=xe41
-----END PGP SIGNATURE-----

--Q7H7AVznsKd9CwNQ--


