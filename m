Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB2CE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 16:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsk4k-0004nU-Qg; Wed, 18 Feb 2026 11:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsk4Q-0004ks-GV
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsk4N-00066i-8k
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771430789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y6YAo/tlN7ihe2ZWw6hNN7aw08rMrq4RnG/+v9spZP4=;
 b=MD6a9QzQdkh/7SqOdZ9aSPwvFzOBbCMIhUzfq/fdnsZ/O5wJMDW9kxjpREXjkBDvUyQI8S
 7UOu0JyLGzxUnevSlRTWBYYnDZkEqTYH9mzLftyNhMBTIpR5jEz0sRY98Q3z+8jb1ZeGzh
 wPEb8zS5WIQU2FZykIVuN3RhXsYpVCA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-8VrmrDD3M8Sp6_bAWz99ag-1; Wed,
 18 Feb 2026 11:06:25 -0500
X-MC-Unique: 8VrmrDD3M8Sp6_bAWz99ag-1
X-Mimecast-MFC-AGG-ID: 8VrmrDD3M8Sp6_bAWz99ag_1771430784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E384F18001E6; Wed, 18 Feb 2026 16:06:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C55F1956095; Wed, 18 Feb 2026 16:06:22 +0000 (UTC)
Date: Wed, 18 Feb 2026 11:06:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, fam@euphon.net, Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH 1/2] fdmon-io_uring: notify main loop when SQEs are queued
Message-ID: <20260218160621.GB587447@fedora>
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk>
 <aY9Lj1BTVRCFyfic@redhat.com>
 <c32915a9-33a2-47c5-a91b-27f01147918f@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vBXPLNwNVf0F8BKt"
Content-Disposition: inline
In-Reply-To: <c32915a9-33a2-47c5-a91b-27f01147918f@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--vBXPLNwNVf0F8BKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 10:57:02AM +0100, Fiona Ebner wrote:
> Am 13.02.26 um 5:05 PM schrieb Kevin Wolf:
> > Am 13.02.2026 um 15:26 hat Jens Axboe geschrieben:
> >> When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs the
> >> block I/O coroutine inline on the vCPU thread because
> >> qemu_get_current_aio_context() returns the main AioContext when BQL is
> >> held. The coroutine calls luring_co_submit() which queues an SQE via
> >> fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only happens
> >> in gsource_prepare() on the main loop thread.
> >=20
> > Ouch! Yes, looks like we completely missed I/O submitted in vCPU threads
> > in the recent changes (or I guess worker threads in theory, but I don't
> > think there any that actually make use of aio_add_sqe()).
> >=20
> >> Since the coroutine ran inline (not via aio_co_schedule()), no BH is
> >> scheduled and aio_notify() is never called. The main loop remains asle=
ep
> >> in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitted unt=
il
> >> the next timer fires.
> >>
> >> Fix this by calling aio_notify() after queuing the SQE. This wakes the
> >> main loop via the eventfd so it can run gsource_prepare() and submit t=
he
> >> pending SQE promptly.
> >>
> >> This is a generic fix that benefits all devices using aio=3Dio_uring.
> >> Without it, AHCI/SATA devices see MUCH worse I/O latency since they use
> >> MMIO (not ioeventfd like virtio) and have no other mechanism to wake t=
he
> >> main loop after queuing block I/O.
> >>
> >> This is usually a bit hard to detect, as it also relies on the ppoll
> >> loop not waking up for other activity, and micro benchmarks tend not to
> >> see it because they don't have any real processing time. With a
> >> synthetic test case that has a few usleep() to simulate processing of
> >> read data, it's very noticeable. The below example reads 128MB with
> >> O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay before
> >> each batch submit, and a 1ms delay after processing each completion.
> >> Running it on /dev/sda yields:
> >>
> >> time sudo ./iotest /dev/sda
> >>
> >> ________________________________________________________
> >> Executed in   25.76 secs      fish           external
> >>    usr time    6.19 millis  783.00 micros    5.41 millis
> >>    sys time   12.43 millis  642.00 micros   11.79 millis
> >>
> >> while on a virtio-blk or NVMe device we get:
> >>
> >> time sudo ./iotest /dev/vdb
> >>
> >> ________________________________________________________
> >> Executed in    1.25 secs      fish           external
> >>    usr time    1.40 millis    0.30 millis    1.10 millis
> >>    sys time   17.61 millis    1.43 millis   16.18 millis
> >>
> >> time sudo ./iotest /dev/nvme0n1
> >>
> >> ________________________________________________________
> >> Executed in    1.26 secs      fish           external
> >>    usr time    6.11 millis    0.52 millis    5.59 millis
> >>    sys time   13.94 millis    1.50 millis   12.43 millis
> >>
> >> where the latter are consistent. If we run the same test but keep the
> >> socket for the ssh connection active by having activity there, then
> >> the sda test looks as follows:
> >>
> >> time sudo ./iotest /dev/sda
> >>
> >> ________________________________________________________
> >> Executed in    1.23 secs      fish           external
> >>    usr time    2.70 millis   39.00 micros    2.66 millis
> >>    sys time    4.97 millis  977.00 micros    3.99 millis
> >>
> >> as now the ppoll loop is woken all the time anyway.
> >>
> >> After this fix, on an idle system:
> >>
> >> time sudo ./iotest /dev/sda
> >>
> >> ________________________________________________________
> >> Executed in    1.30 secs      fish           external
> >>    usr time    2.14 millis    0.14 millis    2.00 millis
> >>    sys time   16.93 millis    1.16 millis   15.76 millis
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  util/fdmon-io_uring.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> >> index d0b56127c670..96392876b490 100644
> >> --- a/util/fdmon-io_uring.c
> >> +++ b/util/fdmon-io_uring.c
> >> @@ -181,6 +181,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ct=
x,
> >> =20
> >>      trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, s=
qe->off,
> >>                                   cqe_handler);
> >> +
> >> +    /*
> >> +     * Wake the main loop if it is sleeping in ppoll().  When a vCPU =
thread
> >> +     * runs a coroutine inline (holding BQL), it queues SQEs here but=
 the
> >> +     * actual io_uring_submit() only happens in gsource_prepare().  W=
ithout
> >> +     * this notify, ppoll() can sleep up to 499ms before submitting.
> >> +     */
> >> +    aio_notify(ctx);
> >>  }
> >=20
> > Makes sense to me.
> >=20
> > At first I wondered if we should use defer_call() for the aio_notify()
> > to batch the submission, but of course holding the BQL will already take
> > care of that. And in iothreads where there is no BQL, the aio_notify()
> > shouldn't make a difference anyway because we're already in the right
> > thread.
> >=20
> > I suppose the other variation could be have another io_uring_enter()
> > call here (but then probably really through defer_call()) to avoid
> > waiting for another CPU to submit the request in its main loop. But I
> > don't really have an intuition if that would make things better or worse
> > in the common case.

It's possible to call io_uring_enter(). QEMU currently doesn't use
IORING_SETUP_SINGLE_ISSUER, so it's okay for multiple threads to call
io_uring_enter() on the same io_uring fd.

I experimented with IORING_SETUP_SINGLE_ISSUER (as well as
IORING_SETUP_COOP_TASKRUN and IORING_SETUP_TASKRUN_FLAG) in the past and
didn't measure a performance improvement:
https://lore.kernel.org/qemu-devel/20250724204702.576637-1-stefanha@redhat.=
com/

Jens, any advice regarding these flags?

Stefan

--vBXPLNwNVf0F8BKt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmV430ACgkQnKSrs4Gr
c8haQwf/aShXaiTzr4NGtpxhPq9mKU8vboZq1bjHELaYma164VfrtVbwwICPTN2c
feirgSOGLMdRIeehbqTjgmAbnkJE3DXxWD3GdtKEOmCLguJM7d7wtJxipKTbRpuD
liaDQRu91pIbPLnG7264hPo4s3O8jwwdifPjDHkU2cCQXlwm9poPr/jDzusM+LKJ
hlAzaWL5OXnYxtyukmlOJzZdObpyF6Z9KFxdX+RRa37vWp82ASorPfwoGzINFJIF
lGIgqY/6u+NI1VWgV8iocJz3+yPQ0S5OJ8GwYKRLyArbaK7cXUfn0pgEjnbaUkl5
x8uQtjfVRRzdpktUIRlzYy/JQWYKoA==
=CSuE
-----END PGP SIGNATURE-----

--vBXPLNwNVf0F8BKt--


