Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35941CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2WN-0008TQ-QT; Thu, 23 Oct 2025 17:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WM-0008Sx-1D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WK-0004QP-2I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761253610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uscu6oPg7KNB7QeagaC76ZLpTepZr3ELkLMH3LoU8xs=;
 b=F92xOEEgf5/8k5XUeIyDAQc/Rc414k6MDP1pXUyXqmWFd6z3ZkjnjAodjlsZ4JuYpN4Kui
 dNmEqUBgu15KlKmGnRqNrEI0urqAN1gaONS6FS8WScTPNtkL0arXTFhjCO8YcErUpeZsva
 qNoEF+j3fSZEuqYmNNpqXRUQi6ir4uQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-2IIqj-bMMjq_57gGZTs3XA-1; Thu,
 23 Oct 2025 17:06:46 -0400
X-MC-Unique: 2IIqj-bMMjq_57gGZTs3XA-1
X-Mimecast-MFC-AGG-ID: 2IIqj-bMMjq_57gGZTs3XA_1761253605
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB9C18002DD; Thu, 23 Oct 2025 21:06:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CD031955F01; Thu, 23 Oct 2025 21:06:44 +0000 (UTC)
Date: Thu, 23 Oct 2025 15:43:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 05/12] aio: remove aio_context_use_g_source()
Message-ID: <20251023194306.GA62080@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-6-stefanha@redhat.com>
 <aOfY8TgysdujAL-l@redhat.com> <aOfp6I_v6N3dc-YB@redhat.com>
 <20251021191033.GB4837@fedora> <aPidpOuudtn6hlAm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2hO0Kzqwb5+Ba2Pj"
Content-Disposition: inline
In-Reply-To: <aPidpOuudtn6hlAm@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--2hO0Kzqwb5+Ba2Pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:02:28AM +0200, Kevin Wolf wrote:
> Am 21.10.2025 um 21:10 hat Stefan Hajnoczi geschrieben:
> > On Thu, Oct 09, 2025 at 06:59:20PM +0200, Kevin Wolf wrote:
> > > Am 09.10.2025 um 17:46 hat Kevin Wolf geschrieben:
> > > > Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > > > > There is no need for aio_context_use_g_source() now that epoll(7)=
 and
> > > > > io_uring(7) file descriptor monitoring works with the glib event =
loop.
> > > > > AioContext doesn't need to be notified that GSource is being used.
> > > > >=20
> > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > > >=20
> > > > We should probably mention in the commit message that this causes t=
he
> > > > default fdmon on Linux to change from poll to io_uring. It's a small
> > > > code change, but it makes QEMU use a completely different code path=
 by
> > > > default.
> > >=20
> > > Just to make sure, I ran 'make check' after this patch and it's faili=
ng
> > > for me:
> > >=20
> > >  10/401 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test             =
       TIMEOUT        150.02s   killed by signal 15 SIGTERM
> > > 133/401 qemu:unit / test-aio                                         =
       TIMEOUT         30.01s   killed by signal 15 SIGTERM
> > > 137/401 qemu:unit / test-bdrv-drain                                  =
       TIMEOUT         30.01s   killed by signal 15 SIGTERM
> > > 142/401 qemu:unit / test-block-iothread                              =
       TIMEOUT         30.01s   killed by signal 15 SIGTERM
> > > 192/401 qemu:doc+rust / rust-bql-rs-doctests                         =
       FAIL             0.84s   exit status 101
> > > 311/401 qemu:block / io-qcow2-267                                    =
       ERROR            3.20s   exit status 1
> > > 321/401 qemu:block / io-qcow2-copy-before-write                      =
       TIMEOUT        180.01s   killed by signal 15 SIGTERM
> > >=20
> > > Some of them look unrelated, but I have confirmed that the three unit
> > > tests still pass before this patch (and still hang after the complete
> > > series).
> >=20
> > I can't reproduce these failures, regardless of whether sysctl
> > kernel.io_uring_disabled is 0 or 1.
> >=20
> > Can you launch the unit tests from your terminal and post the output?
> >=20
> >   $ cd qemu
> >   $ build/tests/unit/test-aio
>=20
> TAP version 14
> # random seed: R02S48dcdde28634143f18bad3947c52d334
> 1..27
> # Start of aio tests
> # Start of bh tests
> ok 1 /aio/bh/schedule
> ok 2 /aio/bh/schedule10
> ok 3 /aio/bh/cancel
> ok 4 /aio/bh/delete
> ok 5 /aio/bh/flush
> # Start of callback-delete tests
> ok 6 /aio/bh/callback-delete/one
> ok 7 /aio/bh/callback-delete/many
> # End of callback-delete tests
> # End of bh tests
> # Start of event tests
> ok 8 /aio/event/add-remove
> ok 9 /aio/event/wait
> ok 10 /aio/event/flush
> # Start of wait tests
> ok 11 /aio/event/wait/no-flush-cb
> # End of wait tests
> # End of event tests
> # Start of timer tests
>=20
> >   $ build/tests/unit/test-bdrv-drain
>=20
> TAP version 14
> # random seed: R02S7d6ba0fc81d5b90d323813d680a30644
> 1..30
> # Start of bdrv-drain tests
> ok 1 /bdrv-drain/nested
> ok 2 /bdrv-drain/set_aio_context
> # Start of driver-cb tests
>=20
>=20
> >   $ build/tests/unit/test-block-iothread
>=20
> TAP version 14
> # random seed: R02Sf81baf68887daa9b86be5c72b99df589
> 1..22
> # Start of sync-op tests
> ok 1 /sync-op/pread
> ok 2 /sync-op/pwrite
> ok 3 /sync-op/preadv
> ok 4 /sync-op/pwritev
> ok 5 /sync-op/preadv_part
> ok 6 /sync-op/pwritev_part
> ok 7 /sync-op/pwrite_compressed
> ok 8 /sync-op/pwrite_zeroes
> ok 9 /sync-op/load_vmstate
> ok 10 /sync-op/save_vmstate
> ok 11 /sync-op/pdiscard
> ok 12 /sync-op/truncate
> ok 13 /sync-op/block_status
> ok 14 /sync-op/flush
> ok 15 /sync-op/check
> ok 16 /sync-op/activate
> # End of sync-op tests
> # Start of attach tests
>=20
> > That will show exactly which sub-test case is hanging.
> > Other information that might help: your host kernel version and liburing
> > version.
>=20
> This is a F42 system.
>=20
> kernel-6.16.12-200.fc42.x86_64
> liburing-2.9-1.fc42.x86_64
>=20
> If you can't reproduce or find a hypothesis what's happening, I can try
> to debug one of the hanging processes.

Unfortunately I haven't been able to reproduce it on my system. It's
a F42 machine with the same package versions as your machine.

The test-aio timer tests look like good candidates for debugging. It is
likely that the test is either getting to an infinite do {} while
(!aio_poll(ctx, false)) loop or to an aio_poll(ctx, true) call that
hangs.

Thanks for your help with debugging!

Stefan

--2hO0Kzqwb5+Ba2Pj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj6hUoACgkQnKSrs4Gr
c8jlFAf+PX49R4GzTHcdbTvAOZZiYpk4iSaEsLhlfqy3sLjb6aZSgL9thV6CeYEK
MbUG5AXeMqayp341+cL5/JuTmr2RspMhxj8RavdGChpU7xvXIZ2JvE5Fzstf7fVS
hrWyQO11GKxm2+3Z1Ar+xpikACl10Yq5cRqrvU/vekQS29IbVYuklLdlPMyJTMbL
OyMUV+xos4QNxG6dmZovd1z3ty78HIl4wAhgYa1qVDRcziVH1a8SSaC9ReLhOMBj
NmeAW0FOxPiNfhOxH6LYPWZ7IYqoJyDaAuTGVmQTbtJdhK/fXcovepfAOLOcAc8A
wtmmG0nCg5ZEfo9CkMAV7B3AAf+Q0w==
=KCYW
-----END PGP SIGNATURE-----

--2hO0Kzqwb5+Ba2Pj--


