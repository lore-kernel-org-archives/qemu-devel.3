Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C88CD6E73
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 14:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYfO-00029q-Cm; Thu, 13 Nov 2025 09:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vJYfJ-000284-H5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vJYfG-0002kl-Oi
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763045470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VOtcdoqEc+WgC+7YZusdnHi/iVsfFWIv3oXbzAwR/64=;
 b=WN98P/f4PIzdWPH3YtoS+pPP2htwHJVliEN0ySwCyTnEvuCjVNwCr8KeXCATgLuMC2PKUt
 0Vnylqc7Us/xxfmbgkMkw+KEul6absK6TBPddu9KAW0N1WBon4nRaZNCVtHgN+EgxbBKtL
 QU4gmFqtZ54qzhahrGLVZsGv4qjoV54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-hdkqpjccNLCSkxvZ2PmJPw-1; Thu,
 13 Nov 2025 09:51:06 -0500
X-MC-Unique: hdkqpjccNLCSkxvZ2PmJPw-1
X-Mimecast-MFC-AGG-ID: hdkqpjccNLCSkxvZ2PmJPw_1763045465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F41719560A5; Thu, 13 Nov 2025 14:51:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.177])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03E181800451; Thu, 13 Nov 2025 14:51:03 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:51:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: Re: [PATCH v6 00/15] aio: add the aio_add_sqe() io_uring API
Message-ID: <20251113145102.GA189474@fedora>
References: <20251104022933.618123-1-stefanha@redhat.com>
 <8ce36148-47a0-463f-9af6-669c69c8b575@tls.msk.ru>
 <aRXeAENqCj1sN7_2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pyiK2YIvmpARaygQ"
Content-Disposition: inline
In-Reply-To: <aRXeAENqCj1sN7_2@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--pyiK2YIvmpARaygQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 02:32:48PM +0100, Kevin Wolf wrote:
> Am 13.11.2025 um 09:27 hat Michael Tokarev geschrieben:
> > On 11/4/25 05:29, Stefan Hajnoczi wrote:
> > ..
> > > This patch series contains io_uring improvements:
> > >=20
> > > 1. Support the glib event loop in fdmon-io_uring.
> > >     - aio-posix: fix race between io_uring CQE and AioHandler deletion
> > >     - aio-posix: keep polling enabled with fdmon-io_uring.c
> > >     - tests/unit: skip test-nested-aio-poll with io_uring
> > >     - aio-posix: integrate fdmon into glib event loop
> > >=20
> > > 2. Enable fdmon-io_uring on hosts where io_uring is available at runt=
ime.
> > >     Otherwise continue using ppoll(2) or epoll(7).
> > >     - aio: remove aio_context_use_g_source()
> > >=20
> > > 3. Add the new aio_add_sqe() API for submitting io_uring requests in =
the QEMU
> > >     event loop.
> > >     - aio: free AioContext when aio_context_new() fails
> > >     - aio: add errp argument to aio_context_setup()
> > >     - aio-posix: gracefully handle io_uring_queue_init() failure
> > >     - aio-posix: add aio_add_sqe() API for user-defined io_uring requ=
ests
> > >     - aio-posix: avoid EventNotifier for cqe_handler_bh
> > >=20
> > > 4. Use aio_add_sqe() in block/io_uring.c instead of creating a dedica=
ted
> > >     io_uring context for --blockdev aio=3Dio_uring. This simplifies t=
he code,
> > >     reduces the number of file descriptors, and demonstrates the aio_=
add_sqe()
> > >     API.
> > >     - block/io_uring: use aio_add_sqe()
> > >     - block/io_uring: use non-vectored read/write when possible
> > >=20
> > > The highlight is aio_add_sqe(), which is needed for the FUSE-over-io_=
uring
> > > Google Summer of Code project and other future QEMU features that nat=
ively use
> > > Linux io_uring functionality.
> > ..> Stefan Hajnoczi (15):
> > >    aio-posix: fix race between io_uring CQE and AioHandler deletion
> > >    aio-posix: fix fdmon-io_uring.c timeout stack variable lifetime
> > >    aio-posix: fix spurious return from ->wait() due to signals
> > >    aio-posix: keep polling enabled with fdmon-io_uring.c
> > >    tests/unit: skip test-nested-aio-poll with io_uring
> > >    aio-posix: integrate fdmon into glib event loop
> > >    aio: remove aio_context_use_g_source()
> > >    aio: free AioContext when aio_context_new() fails
> > >    aio: add errp argument to aio_context_setup()
> > >    aio-posix: gracefully handle io_uring_queue_init() failure
> > >    aio-posix: unindent fdmon_io_uring_destroy()
> > >    aio-posix: add fdmon_ops->dispatch()
> > >    aio-posix: add aio_add_sqe() API for user-defined io_uring requests
> > >    block/io_uring: use aio_add_sqe()
> > >    block/io_uring: use non-vectored read/write when possible
> >=20
> > Is there anything in there which should go to qemu-stable?
> >=20
> > From the descriptions of a few changes it feels like something should.
>=20
> fdmon-io_uring has effectively been dead code since commit ba607ca (and
> until patch 7 in this series). The commit message of that commit makes
> it sounds like there are cases where GSource is not enabled, but there
> really aren't.
>=20
> You may want to pick patch 2 anyway because it's a use after free and
> may effectively hang QEMU (by using far too large timeouts), but from
> what I can tell, without downstream code changes, you won't ever run
> this code in relevant stable releases. QEMU 5.0 was the only release
> that had it enabled before.

Right, the fixes are for dead code (until re-enabled by this patch
series). There is no practical benefit to backporting them.

Stefan

--pyiK2YIvmpARaygQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkV8FYACgkQnKSrs4Gr
c8gqegf/d5KheLZIE79QwW9K5pL6bFHzDdBBseM0ZrNV8bBOPBGwYAHHUkDl4z1o
PIhk/yQyKYe8RQ0NCtd+RTaVZcpiWStLum3BosPNVLwFjzVZP9dZ1kI3FWMO9gNu
2kj8Z2N3Qh3k+o0xrZFFZYUKccZkIfTXx66Ul10znttasabUMTBM7xFc/+FNzeUl
DzncABxxIwQtSJ3n7G6OMrYQk8dILREEzrwKqxycuVUV7h3cVcTdoEtfTcLWE3xA
pjnaojIKlM3Igql9nRTtRtlXYoNQ5PxA30/xpG2TXYwNtiednT9tUfk1HtEANX6W
RgcBYf74UzBra1/wBvgzOb+V3rev0w==
=VB9C
-----END PGP SIGNATURE-----

--pyiK2YIvmpARaygQ--


