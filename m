Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A60EA4FBA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWoJ-0004JP-19; Mon, 23 Feb 2026 09:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWnu-00049z-EN
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWns-0005X1-0G
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771856450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Cpp2uOtTuAerYkO3V2kjH5f8ubujF6oq4kL+eaS50s=;
 b=KRqsqob8urXgVIErg8P3m57dfFdrKIvBrUzHIbVPoMh6yXXLHU9EzbrE7Q3ZjySHnw9Rs4
 oPnTWVJqfh5JW0GMlg7LQ2ElAmXIpNi/7YnB8NpyFqmtogh1wskfnaXcBxLS8TePMu9OnK
 l6PAGaSOKGYaN8ISpV0S/56jdPjtRKo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-XvZxzZesP4G8IluxpSf9Tw-1; Mon,
 23 Feb 2026 09:20:46 -0500
X-MC-Unique: XvZxzZesP4G8IluxpSf9Tw-1
X-Mimecast-MFC-AGG-ID: XvZxzZesP4G8IluxpSf9Tw_1771856445
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A90FD18005B7; Mon, 23 Feb 2026 14:20:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E94730001BE; Mon, 23 Feb 2026 14:20:42 +0000 (UTC)
Date: Mon, 23 Feb 2026 08:53:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, fam@euphon.net
Subject: Re: [PATCH v2] aio-posix: notify main loop when SQEs are queued
Message-ID: <20260223135349.GA1162700@fedora>
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk>
 <aY9Lj1BTVRCFyfic@redhat.com>
 <c32915a9-33a2-47c5-a91b-27f01147918f@proxmox.com>
 <20260218161127.GC587447@fedora>
 <d729df1d-ba33-4cab-88c9-ba980cdaa37d@kernel.dk>
 <07d701b9-3039-4f9b-99a2-abeae51146a5@kernel.dk>
 <aZcw911iCiDHKWCp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oN9CSbfbIWir6E0A"
Content-Disposition: inline
In-Reply-To: <aZcw911iCiDHKWCp@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--oN9CSbfbIWir6E0A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 04:49:11PM +0100, Kevin Wolf wrote:
> Am 18.02.2026 um 17:41 hat Jens Axboe geschrieben:
> > On 2/18/26 9:19 AM, Jens Axboe wrote:
> > > On 2/18/26 9:11 AM, Stefan Hajnoczi wrote:
> > >> On Wed, Feb 18, 2026 at 10:57:02AM +0100, Fiona Ebner wrote:
> > >>> Am 13.02.26 um 5:05 PM schrieb Kevin Wolf:
> > >>>> Am 13.02.2026 um 15:26 hat Jens Axboe geschrieben:
> > >>>>> When a vCPU thread handles MMIO (holding BQL), aio_co_enter() run=
s the
> > >>>>> block I/O coroutine inline on the vCPU thread because
> > >>>>> qemu_get_current_aio_context() returns the main AioContext when B=
QL is
> > >>>>> held. The coroutine calls luring_co_submit() which queues an SQE =
via
> > >>>>> fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only h=
appens
> > >>>>> in gsource_prepare() on the main loop thread.
> > >>>>
> > >>>> Ouch! Yes, looks like we completely missed I/O submitted in vCPU t=
hreads
> > >>>> in the recent changes (or I guess worker threads in theory, but I =
don't
> > >>>> think there any that actually make use of aio_add_sqe()).
> > >>>>
> > >>>>> Since the coroutine ran inline (not via aio_co_schedule()), no BH=
 is
> > >>>>> scheduled and aio_notify() is never called. The main loop remains=
 asleep
> > >>>>> in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitte=
d until
> > >>>>> the next timer fires.
> > >>>>>
> > >>>>> Fix this by calling aio_notify() after queuing the SQE. This wake=
s the
> > >>>>> main loop via the eventfd so it can run gsource_prepare() and sub=
mit the
> > >>>>> pending SQE promptly.
> > >>>>>
> > >>>>> This is a generic fix that benefits all devices using aio=3Dio_ur=
ing.
> > >>>>> Without it, AHCI/SATA devices see MUCH worse I/O latency since th=
ey use
> > >>>>> MMIO (not ioeventfd like virtio) and have no other mechanism to w=
ake the
> > >>>>> main loop after queuing block I/O.
> > >>>>>
> > >>>>> This is usually a bit hard to detect, as it also relies on the pp=
oll
> > >>>>> loop not waking up for other activity, and micro benchmarks tend =
not to
> > >>>>> see it because they don't have any real processing time. With a
> > >>>>> synthetic test case that has a few usleep() to simulate processin=
g of
> > >>>>> read data, it's very noticeable. The below example reads 128MB wi=
th
> > >>>>> O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay be=
fore
> > >>>>> each batch submit, and a 1ms delay after processing each completi=
on.
> > >>>>> Running it on /dev/sda yields:
> > >>>>>
> > >>>>> time sudo ./iotest /dev/sda
> > >>>>>
> > >>>>> ________________________________________________________
> > >>>>> Executed in   25.76 secs      fish           external
> > >>>>>    usr time    6.19 millis  783.00 micros    5.41 millis
> > >>>>>    sys time   12.43 millis  642.00 micros   11.79 millis
> > >>>>>
> > >>>>> while on a virtio-blk or NVMe device we get:
> > >>>>>
> > >>>>> time sudo ./iotest /dev/vdb
> > >>>>>
> > >>>>> ________________________________________________________
> > >>>>> Executed in    1.25 secs      fish           external
> > >>>>>    usr time    1.40 millis    0.30 millis    1.10 millis
> > >>>>>    sys time   17.61 millis    1.43 millis   16.18 millis
> > >>>>>
> > >>>>> time sudo ./iotest /dev/nvme0n1
> > >>>>>
> > >>>>> ________________________________________________________
> > >>>>> Executed in    1.26 secs      fish           external
> > >>>>>    usr time    6.11 millis    0.52 millis    5.59 millis
> > >>>>>    sys time   13.94 millis    1.50 millis   12.43 millis
> > >>>>>
> > >>>>> where the latter are consistent. If we run the same test but keep=
 the
> > >>>>> socket for the ssh connection active by having activity there, th=
en
> > >>>>> the sda test looks as follows:
> > >>>>>
> > >>>>> time sudo ./iotest /dev/sda
> > >>>>>
> > >>>>> ________________________________________________________
> > >>>>> Executed in    1.23 secs      fish           external
> > >>>>>    usr time    2.70 millis   39.00 micros    2.66 millis
> > >>>>>    sys time    4.97 millis  977.00 micros    3.99 millis
> > >>>>>
> > >>>>> as now the ppoll loop is woken all the time anyway.
> > >>>>>
> > >>>>> After this fix, on an idle system:
> > >>>>>
> > >>>>> time sudo ./iotest /dev/sda
> > >>>>>
> > >>>>> ________________________________________________________
> > >>>>> Executed in    1.30 secs      fish           external
> > >>>>>    usr time    2.14 millis    0.14 millis    2.00 millis
> > >>>>>    sys time   16.93 millis    1.16 millis   15.76 millis
> > >>>>>
> > >>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >>>>> ---
> > >>>>>  util/fdmon-io_uring.c | 8 ++++++++
> > >>>>>  1 file changed, 8 insertions(+)
> > >>>>>
> > >>>>> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> > >>>>> index d0b56127c670..96392876b490 100644
> > >>>>> --- a/util/fdmon-io_uring.c
> > >>>>> +++ b/util/fdmon-io_uring.c
> > >>>>> @@ -181,6 +181,14 @@ static void fdmon_io_uring_add_sqe(AioContex=
t *ctx,
> > >>>>> =20
> > >>>>>      trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->=
fd, sqe->off,
> > >>>>>                                   cqe_handler);
> > >>>>> +
> > >>>>> +    /*
> > >>>>> +     * Wake the main loop if it is sleeping in ppoll().  When a =
vCPU thread
> > >>>>> +     * runs a coroutine inline (holding BQL), it queues SQEs her=
e but the
> > >>>>> +     * actual io_uring_submit() only happens in gsource_prepare(=
).  Without
> > >>>>> +     * this notify, ppoll() can sleep up to 499ms before submitt=
ing.
> > >>>>> +     */
> > >>>>> +    aio_notify(ctx);
> > >>>>>  }
> > >>>>
> > >>>> Makes sense to me.
> > >>>>
> > >>>> At first I wondered if we should use defer_call() for the aio_noti=
fy()
> > >>>> to batch the submission, but of course holding the BQL will alread=
y take
> > >>>> care of that. And in iothreads where there is no BQL, the aio_noti=
fy()
> > >>>> shouldn't make a difference anyway because we're already in the ri=
ght
> > >>>> thread.
> > >>>>
> > >>>> I suppose the other variation could be have another io_uring_enter=
()
> > >>>> call here (but then probably really through defer_call()) to avoid
> > >>>> waiting for another CPU to submit the request in its main loop. Bu=
t I
> > >>>> don't really have an intuition if that would make things better or=
 worse
> > >>>> in the common case.
> > >>>>
> > >>>> Fiona, does this fix your case, too?
> > >>>
> > >>> Yes, it does fix my issue [0] and the second patch gives another sm=
all
> > >>> improvement :)
> > >>>
> > >>> Would it be slightly cleaner to have aio_add_sqe() call aio_notify()
> > >>> itself? Since aio-posix.c calls downwards into fdmon-io_uring.c, it
> > >>> would feel nicer to me to not have fdmon-io_uring.c call "back up".=
 I
> > >>> guess it also depends on whether we expect another future fdmon
> > >>> implementation with .add_sqe() to also benefit from it.
> > >>
> > >> Calling aio_notify() from aio-posix.c:aio_add_sqe() sounds better to=
 me
> > >> because fdmon-io_uring.c has to be careful about calling aio_*() API=
s to
> > >> avoid loops.
> > >=20
> > > Would anyone care to make that edit? I'm on a plane and gone for a bi=
t,
> > > so won't get back to this for the next week. But I would love to see a
> > > fix go in, as this issue has been plaguing me with test timeouts for
> > > quite a while on the CI front. And seems like I'm not alone, if the
> > > patches fix Fiona's issues as well.
> >=20
> > Still on a plane but tested this one and it works for me too. Does seem
> > like a better approach, rather than stuff it in the fdmon part.
> >=20
> > Feel free to run with this one and also to update the commit message if
> > you want. Thanks!
> >=20
> >=20
> > commit a8a94e7a05964d470b8fba50c9d4769489c21752
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Fri Feb 13 06:52:14 2026 -0700
> >=20
> >     aio-posix: notify main loop when SQEs are queued
> >    =20
> >     When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs =
the
> >     block I/O coroutine inline on the vCPU thread because
> >     qemu_get_current_aio_context() returns the main AioContext when BQL=
 is
> >     held. The coroutine calls luring_co_submit() which queues an SQE via
> >     fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only hap=
pens
> >     in gsource_prepare() on the main loop thread.
> >    =20
> >     Since the coroutine ran inline (not via aio_co_schedule()), no BH is
> >     scheduled and aio_notify() is never called. The main loop remains a=
sleep
> >     in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitted =
until
> >     the next timer fires.
> >    =20
> >     Fix this by calling aio_notify() after queuing the SQE. This wakes =
the
> >     main loop via the eventfd so it can run gsource_prepare() and submi=
t the
> >     pending SQE promptly.
> >    =20
> >     This is a generic fix that benefits all devices using aio=3Dio_urin=
g.
> >     Without it, AHCI/SATA devices see MUCH worse I/O latency since they=
 use
> >     MMIO (not ioeventfd like virtio) and have no other mechanism to wak=
e the
> >     main loop after queuing block I/O.
> >    =20
> >     This is usually a bit hard to detect, as it also relies on the ppoll
> >     loop not waking up for other activity, and micro benchmarks tend no=
t to
> >     see it because they don't have any real processing time. With a
> >     synthetic test case that has a few usleep() to simulate processing =
of
> >     read data, it's very noticeable. The below example reads 128MB with
> >     O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay befo=
re
> >     each batch submit, and a 1ms delay after processing each completion.
> >     Running it on /dev/sda yields:
> >    =20
> >     time sudo ./iotest /dev/sda
> >    =20
> >     ________________________________________________________
> >     Executed in   25.76 secs      fish           external
> >        usr time    6.19 millis  783.00 micros    5.41 millis
> >        sys time   12.43 millis  642.00 micros   11.79 millis
> >    =20
> >     while on a virtio-blk or NVMe device we get:
> >    =20
> >     time sudo ./iotest /dev/vdb
> >    =20
> >     ________________________________________________________
> >     Executed in    1.25 secs      fish           external
> >        usr time    1.40 millis    0.30 millis    1.10 millis
> >        sys time   17.61 millis    1.43 millis   16.18 millis
> >    =20
> >     time sudo ./iotest /dev/nvme0n1
> >    =20
> >     ________________________________________________________
> >     Executed in    1.26 secs      fish           external
> >        usr time    6.11 millis    0.52 millis    5.59 millis
> >        sys time   13.94 millis    1.50 millis   12.43 millis
> >    =20
> >     where the latter are consistent. If we run the same test but keep t=
he
> >     socket for the ssh connection active by having activity there, then
> >     the sda test looks as follows:
> >    =20
> >     time sudo ./iotest /dev/sda
> >    =20
> >     ________________________________________________________
> >     Executed in    1.23 secs      fish           external
> >        usr time    2.70 millis   39.00 micros    2.66 millis
> >        sys time    4.97 millis  977.00 micros    3.99 millis
> >    =20
> >     as now the ppoll loop is woken all the time anyway.
> >    =20
> >     After this fix, on an idle system:
> >    =20
> >     time sudo ./iotest /dev/sda
> >    =20
> >     ________________________________________________________
> >     Executed in    1.30 secs      fish           external
> >        usr time    2.14 millis    0.14 millis    2.00 millis
> >        sys time   16.93 millis    1.16 millis   15.76 millis
> >    =20
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >=20
> > diff --git a/util/aio-posix.c b/util/aio-posix.c
> > index e24b955fd91a..8c7b3795c82d 100644
> > --- a/util/aio-posix.c
> > +++ b/util/aio-posix.c
> > @@ -813,5 +813,13 @@ void aio_add_sqe(void (*prep_sqe)(struct io_uring_=
sqe *sqe, void *opaque),
> >  {
> >      AioContext *ctx =3D qemu_get_current_aio_context();
> >      ctx->fdmon_ops->add_sqe(ctx, prep_sqe, opaque, cqe_handler);
> > +
> > +    /*
> > +     * Wake the main loop if it is sleeping in ppoll().  When a vCPU t=
hread
> > +     * runs a coroutine inline (holding BQL), it queues SQEs here but =
the
>=20
> I think the comment could even be more generic here. This is not
> specific to coroutines, but the scenario is just that a vCPU thread
> holding the BQL performs I/O.

Good idea, I generalized the comment when merging the patch.

Stefan

--oN9CSbfbIWir6E0A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmcW+0ACgkQnKSrs4Gr
c8jt0wgAsQ8OupU5OeTv1+MhURm4bN2XXaYOj/VqvFQQ5UMmopbnI9gjZJLf3GjM
qjebH+NwpLLfVnHjtbiajRcJdTsGZFRs/stjn0d/1MYF0UdzPfAvoEkFipjCCrKR
q5H9QwXVewiSszDv6hjn1e63+R5bek4N6ugbJ9HToV7iKTk0aWC3XUJtn8R4xVqz
8RceHvRmd+F3p49fZpPbf4HAvX6n08UBUeUGlCjs0gey+53bacEpVANn+SjU/qYL
G2PXkypYvInkBm+WMvp+9OY4LanTlOQYxt8UgSH8HIQ1bAKE9MIncf8IUIxNJRQ5
sOi6c2DdcaichNNmpolqaBHa5+d0Aw==
=7VGg
-----END PGP SIGNATURE-----

--oN9CSbfbIWir6E0A--


