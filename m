Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38A2CCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHl1-0007x7-19; Tue, 21 Oct 2025 15:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vBHky-0007vS-UL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vBHkw-00088O-DF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761073848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hp1AlwBKaosqt/AqfQMcdFj6nOyPI2+Y+tY/gtR5KxM=;
 b=bGBzHwVg+uRXzNLn3cjQKapmRfbxxc0RQA95bbVDVuIjfCCT6rCjWunKS/b9MO9v1mrYii
 LLgJsLTMsr9abUIOtpSmuDJXA5LDzvnNhm1m2kVnOLl3HBLmXprV4ZM//sxknqq/wKJbdz
 1JCgX2v0bJVW7o+pNzQvHp3d3EhyvBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-e_B5QE1ZPKiO04tO5vWlNg-1; Tue,
 21 Oct 2025 15:10:39 -0400
X-MC-Unique: e_B5QE1ZPKiO04tO5vWlNg-1
X-Mimecast-MFC-AGG-ID: e_B5QE1ZPKiO04tO5vWlNg_1761073836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1812C195609E; Tue, 21 Oct 2025 19:10:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0FC11800452; Tue, 21 Oct 2025 19:10:34 +0000 (UTC)
Date: Tue, 21 Oct 2025 15:10:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 05/12] aio: remove aio_context_use_g_source()
Message-ID: <20251021191033.GB4837@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-6-stefanha@redhat.com>
 <aOfY8TgysdujAL-l@redhat.com> <aOfp6I_v6N3dc-YB@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZI9TI34x7a45ZZUF"
Content-Disposition: inline
In-Reply-To: <aOfp6I_v6N3dc-YB@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ZI9TI34x7a45ZZUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:59:20PM +0200, Kevin Wolf wrote:
> Am 09.10.2025 um 17:46 hat Kevin Wolf geschrieben:
> > Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > > There is no need for aio_context_use_g_source() now that epoll(7) and
> > > io_uring(7) file descriptor monitoring works with the glib event loop.
> > > AioContext doesn't need to be notified that GSource is being used.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> >=20
> > We should probably mention in the commit message that this causes the
> > default fdmon on Linux to change from poll to io_uring. It's a small
> > code change, but it makes QEMU use a completely different code path by
> > default.
>=20
> Just to make sure, I ran 'make check' after this patch and it's failing
> for me:
>=20
>  10/401 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test                 =
   TIMEOUT        150.02s   killed by signal 15 SIGTERM
> 133/401 qemu:unit / test-aio                                             =
   TIMEOUT         30.01s   killed by signal 15 SIGTERM
> 137/401 qemu:unit / test-bdrv-drain                                      =
   TIMEOUT         30.01s   killed by signal 15 SIGTERM
> 142/401 qemu:unit / test-block-iothread                                  =
   TIMEOUT         30.01s   killed by signal 15 SIGTERM
> 192/401 qemu:doc+rust / rust-bql-rs-doctests                             =
   FAIL             0.84s   exit status 101
> 311/401 qemu:block / io-qcow2-267                                        =
   ERROR            3.20s   exit status 1
> 321/401 qemu:block / io-qcow2-copy-before-write                          =
   TIMEOUT        180.01s   killed by signal 15 SIGTERM
>=20
> Some of them look unrelated, but I have confirmed that the three unit
> tests still pass before this patch (and still hang after the complete
> series).

I can't reproduce these failures, regardless of whether sysctl
kernel.io_uring_disabled is 0 or 1.

Can you launch the unit tests from your terminal and post the output?

  $ cd qemu
  $ build/tests/unit/test-aio
  $ build/tests/unit/test-bdrv-drain
  $ build/tests/unit/test-block-iothread

That will show exactly which sub-test case is hanging.

Other information that might help: your host kernel version and liburing
version.

Thank you!

Stefan

--ZI9TI34x7a45ZZUF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj32qkACgkQnKSrs4Gr
c8gtvQf/US8d09joOpvBOMo2hlzX1sQWttutvUe1grHkYOBiSR3Wkz1Gc4GAeyUj
ke9P1gPPdvO01hTvds33blgyPWxZN8m5/YyZsrOWKN9PUMuu+RROe1qvGab4dXsc
HB7voaBQPdJFlUYccf3UtUOqbZPDRcljQpesau3RZkvNMuUqLhPDdrZO/R3bFdym
Xv5Dcj+ifH1ELPXN1/zyumiSR/9RnHcEu0u31ZyTaA8rhA5JOmmNSiL1+0mjdmVQ
BdadKeNIarlnwMuEej2zzoe/tZ5NL0n2wa55SiEzwwKu8Ox1U7afZsOpp4uJ/zuJ
8P3vviCH68f98gM51FPL6CO9LFpMpQ==
=YJ2h
-----END PGP SIGNATURE-----

--ZI9TI34x7a45ZZUF--


