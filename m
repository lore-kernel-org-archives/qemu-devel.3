Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F4AC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHJI-0000aY-Rb; Wed, 31 Jan 2024 15:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rVHJF-0000a6-Lg
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rVHJD-0001in-Ac
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706733346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gvBlz0fOyKmawdbi3b4axtr4WSUgFrGY3pXc9IjyCE=;
 b=ArsW/yBnnnZZG5hNLltUTocbUyJOjUeAbUixg+WINKVM+vpQ6BlirA4ExwI4fAzrtyNAu3
 OhEOnaxmvyS3xXNjBssB0OOuBoqPRa0IxJrMyIVH1r1lRji6bDXeNuPY1xrHAR4VDF2iAx
 2/PgAW52I7CA84qFUkhZuCZpxQTLCr4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-5JnX10NNMVywcwPYIl2n8w-1; Wed,
 31 Jan 2024 15:35:40 -0500
X-MC-Unique: 5JnX10NNMVywcwPYIl2n8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012DE29AA2C3;
 Wed, 31 Jan 2024 20:35:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73B382166B31;
 Wed, 31 Jan 2024 20:35:39 +0000 (UTC)
Date: Wed, 31 Jan 2024 15:35:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <20240131203537.GC396296@fedora>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
 <ZbOxI9Ar-YDn51Z0@redhat.com>
 <4c4173f2-b8fc-4c6f-88e1-8c31c4411837@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tuppfXptz9SgFWCy"
Content-Disposition: inline
In-Reply-To: <4c4173f2-b8fc-4c6f-88e1-8c31c4411837@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--tuppfXptz9SgFWCy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 04:24:49PM +0100, Hanna Czenczek wrote:
> On 26.01.24 14:18, Kevin Wolf wrote:
> > Am 25.01.2024 um 18:32 hat Hanna Czenczek geschrieben:
> > > On 23.01.24 18:10, Kevin Wolf wrote:
> > > > Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
> > > > > On 21.12.23 22:23, Kevin Wolf wrote:
> > > > > > From: Stefan Hajnoczi<stefanha@redhat.com>
> > > > > >=20
> > > > > > Stop depending on the AioContext lock and instead access
> > > > > > SCSIDevice->requests from only one thread at a time:
> > > > > > - When the VM is running only the BlockBackend's AioContext may=
 access
> > > > > >      the requests list.
> > > > > > - When the VM is stopped only the main loop may access the requ=
ests
> > > > > >      list.
> > > > > >=20
> > > > > > These constraints protect the requests list without the need fo=
r locking
> > > > > > in the I/O code path.
> > > > > >=20
> > > > > > Note that multiple IOThreads are not supported yet because the =
code
> > > > > > assumes all SCSIRequests are executed from a single AioContext.=
 Leave
> > > > > > that as future work.
> > > > > >=20
> > > > > > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > > > > > Reviewed-by: Eric Blake<eblake@redhat.com>
> > > > > > Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
> > > > > > Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> > > > > > ---
> > > > > >     include/hw/scsi/scsi.h |   7 +-
> > > > > >     hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++--=
-----------
> > > > > >     2 files changed, 131 insertions(+), 57 deletions(-)
> > > > > My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now =
breaks more
> > > > > often because of this commit than because of the original bug, i.=
e. when
> > > > > repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-h=
d device,
> > > > > this tends to happen when unplugging the scsi-hd:
>=20
> Note: We (on issues.redhat.com) have a separate report that seems to be
> concerning this very problem: https://issues.redhat.com/browse/RHEL-19381
>=20
> > > > > {"execute":"device_del","arguments":{"id":"stg0"}}
> > > > > {"return": {}}
> > > > > qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_co=
ntext:
> > > > > Assertion `ctx =3D=3D blk->ctx' failed.
> > > [...]
> > >=20
> > > > > I don=E2=80=99t know anything about the problem yet, but as usual=
, I like
> > > > > speculation and discovering how wrong I was later on, so one thin=
g I came
> > > > > across that=E2=80=99s funny about virtio-scsi is that requests ca=
n happen even while
> > > > > a disk is being attached or detached.=C2=A0 That is, Linux seems =
to probe all
> > > > > LUNs when a new virtio-scsi device is being attached, and it won=
=E2=80=99t stop just
> > > > > because a disk is being attached or removed.=C2=A0 So maybe that=
=E2=80=99s part of the
> > > > > problem, that we get a request while the BB is being detached, and
> > > > > temporarily in an inconsistent state (BDS context differs from BB=
 context).
> > > > I don't know anything about the problem either, but since you alrea=
dy
> > > > speculated about the cause, let me speculate about the solution:
> > > > Can we hold the graph writer lock for the tran_commit() call in
> > > > bdrv_try_change_aio_context()? And of course take the reader lock f=
or
> > > > blk_get_aio_context(), but that should be completely unproblematic.
> > > Actually, now that completely unproblematic part is giving me trouble=
=2E=C2=A0 I
> > > wanted to just put a graph lock into blk_get_aio_context() (making it=
 a
> > > coroutine with a wrapper)
> > Which is the first thing I neglected and already not great. We have
> > calls of blk_get_aio_context() in the SCSI I/O path, and creating a
> > coroutine and doing at least two context switches simply for this call
> > is a lot of overhead...
> >=20
> > > but callers of blk_get_aio_context() generally assume the context is
> > > going to stay the BB=E2=80=99s context for as long as their AioContex=
t *
> > > variable is in scope.
> > I'm not so sure about that. And taking another step back, I'm actually
> > also not sure how much it still matters now that they can submit I/O
> > from any thread.
>=20
> That=E2=80=99s my impression, too, but =E2=80=9Cnot sure=E2=80=9D doesn=
=E2=80=99t feel great. :)
> scsi_device_for_each_req_async_bh() specifically double-checks whether it=
=E2=80=99s
> still in the right context before invoking the specified function, so it
> seems there was some intention to continue to run in the context associat=
ed
> with the BB.
>=20
> (Not judging whether that intent makes sense or not, yet.)
>=20
> > Maybe the correct solution is to remove the assertion from
> > blk_get_aio_context() and just always return blk->ctx. If it's in the
> > middle of a change, you'll either get the old one or the new one. Either
> > one is fine to submit I/O from, and if you care about changes for other
> > reasons (like SCSI does), then you need explicit code to protect it
> > anyway (which SCSI apparently has, but it doesn't work).
>=20
> I think most callers do just assume the BB stays in the context they got
> (without any proof, admittedly), but I agree that under re-evaluation, it
> probably doesn=E2=80=99t actually matter to them, really. And yes, basica=
lly, if the
> caller doesn=E2=80=99t need to take a lock because it doesn=E2=80=99t rea=
lly matter whether
> blk->ctx changes while its still using the old value, blk_get_aio_context=
()
> in turn doesn=E2=80=99t need to double-check blk->ctx against the root no=
de=E2=80=99s
> context either, and nobody needs a lock.
>=20
> So I agree, it=E2=80=99s on the caller to protect against a potentially c=
hanging
> context, blk_get_aio_context() should just return blk->ctx and not check
> against the root node.
>=20
> (On a tangent: blk_drain() is a caller of blk_get_aio_context(), and it
> polls that context.=C2=A0 Why does it need to poll that context specifica=
lly when
> requests may be in any context?=C2=A0 Is it because if there are requests=
 in the
> main thread, we must poll that, but otherwise it=E2=80=99s fine to poll a=
ny thread,
> and we can only have requests in the main thread if that=E2=80=99s the BB=
=E2=80=99s
> context?)
>=20
> > > I was tempted to think callers know what happens to the BB they pass
> > > to blk_get_aio_context(), and it won=E2=80=99t change contexts so eas=
ily, but
> > > then I remembered this is exactly what happens in this case; we run
> > > scsi_device_for_each_req_async_bh() in one thread (which calls
> > > blk_get_aio_context()), and in the other, we change the BB=E2=80=99s =
context.
> > Let's think a bit more about scsi_device_for_each_req_async()
> > specifically. This is a function that runs in the main thread. Nothing
> > will change any AioContext assignment if it doesn't call it. It wants to
> > make sure that scsi_device_for_each_req_async_bh() is called in the
> > same AioContext where the virtqueue is processed, so it schedules a BH
> > and waits for it.
>=20
> I don=E2=80=99t quite follow, it doesn=E2=80=99t wait for the BH.=C2=A0 I=
t uses
> aio_bh_schedule_oneshot(), not aio_wait_bh_oneshot().=C2=A0 While you=E2=
=80=99re right
> that if it did wait, the BB context might still change, in practice we
> wouldn=E2=80=99t have the problem at hand because the caller is actually =
the one to
> change the context, concurrently while the BH is running.
>=20
> > Waiting for it means running a nested event loop that could do anything,
> > including changing AioContexts. So this is what needs the locking, not
> > the blk_get_aio_context() call in scsi_device_for_each_req_async_bh().
> > If we lock before the nested event loop and unlock in the BH, the check
> > in the BH can become an assertion. (It is important that we unlock in
> > the BH rather than after waiting because if something takes the writer
> > lock, we need to unlock during the nested event loop of bdrv_wrlock() to
> > avoid a deadlock.)
> >=20
> > And spawning a coroutine for this looks a lot more acceptable because
> > it's on a slow path anyway.
> >=20
> > In fact, we probably don't technically need a coroutine to take the
> > reader lock here. We can have a new graph lock function that asserts
> > that there is no writer (we know because we're running in the main loop)
> > and then atomically increments the reader count. But maybe that already
> > complicates things again...
>=20
> So as far as I understand we can=E2=80=99t just use aio_wait_bh_oneshot()=
 and wrap
> it in bdrv_graph_rd{,un}lock_main_loop(), because that doesn=E2=80=99t ac=
tually lock
> the graph.=C2=A0 I feel like adding a new graph lock function for this qu=
ite
> highly specific case could be dangerous, because it seems easy to use the
> wrong way.
>=20
> Just having a trampoline coroutine to call bdrv_graph_co_rd{,un}lock() se=
ems
> simple enough and reasonable here (not a hot path).=C2=A0 Can we have that
> coroutine then use aio_wait_bh_oneshot() with the existing _bh function, =
or
> should that be made a coroutine, too?

There is a reason for running in the context associated with the BB: the
virtio-scsi code assumes all request processing happens in the BB's
AioContext. The SCSI request list and other SCSI emulation code is not
thread-safe!

The invariant is that SCSI request processing must only happen in one
AioContext. Other parts of QEMU may perform block I/O from other
AioContexts because they don't run SCSI emulation for this device.

Stefan

--tuppfXptz9SgFWCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW6rxkACgkQnKSrs4Gr
c8hlPQf9GLROlU7zNY9At2mNXLeIqf773C+PCptI8B+HofgpXK/ejvXz4+3F4fHp
yFpNaYOdKYIE9JUeORvR4rvGENiZareHB5a2Vk32cJAgB8SNSsqIcbDvf9VxqoQT
YGoCMth0iEB8bcIAYGXgA2Fi+5byEpbTonebu7v4u7aIWacj4qGKgja7wZ4svmqC
QZKW+yyodCMvBD2bww7jT5RQL81HkgjNKLfRe5oaA97G7Cy+JrXkUQctxHXwnOWF
PBYPmEpazSjI53uU1REj2r0UrbHKuow30nIvvMJSyjpejsDE59FtQusivO+lszne
0rKGJ+k8tAJyNZ0XDhSHpdSaqa6/3Q==
=E/HN
-----END PGP SIGNATURE-----

--tuppfXptz9SgFWCy--


