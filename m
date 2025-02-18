Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2223C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkG8I-0005dg-GI; Tue, 18 Feb 2025 00:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkG8F-0005d8-Th
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 00:26:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkG8D-0007oK-Kc
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 00:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739856411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUPK//D9Ljjy1m+eIH7lGh/bfFuM5HKiMsFhxgxXTW4=;
 b=LT7cpiKJ3zTEiZjz7WLYURfxZU6dgjuHijBEoXgYkpwfLGiY6x36nYPhYK7PA6z27xg9xZ
 6TgMsyH9eF5S9/jBTubJa3DxQ1Tdnliw7nnJ5qFG7huGXGrDoUe+ITMyPvQphE5Z6vethT
 6ZrzZ1a2Kss8tduaPsffBpMHSQm59aw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-qyC-pvbWNaOj0sK_YZA9eQ-1; Tue,
 18 Feb 2025 00:26:47 -0500
X-MC-Unique: qyC-pvbWNaOj0sK_YZA9eQ-1
X-Mimecast-MFC-AGG-ID: qyC-pvbWNaOj0sK_YZA9eQ_1739856406
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55FF4196E078; Tue, 18 Feb 2025 05:26:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.60])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11FBD1956094; Tue, 18 Feb 2025 05:26:44 +0000 (UTC)
Date: Tue, 18 Feb 2025 13:26:42 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] block/rbd: Do not use BDS's AioContext
Message-ID: <20250218052642.GC10767@fedora>
References: <20250212093238.32312-1-hreitz@redhat.com>
 <Z6yhczeIJ1XIej3M@redhat.com>
 <807a4908-d087-4c69-ba56-07c60545405e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DL/1+4ovpPWirJRJ"
Content-Disposition: inline
In-Reply-To: <807a4908-d087-4c69-ba56-07c60545405e@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--DL/1+4ovpPWirJRJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 03:27:26PM +0100, Hanna Czenczek wrote:
> On 12.02.25 14:26, Kevin Wolf wrote:
> > Am 12.02.2025 um 10:32 hat Hanna Czenczek geschrieben:
> > > RBD schedules the request completion code (qemu_rbd_finish_bh()) to r=
un
> > > in the BDS's AioContext.  The intent seems to be to run it in the same
> > > context that the original request coroutine ran in, i.e. the thread on
> > > whose stack the RBDTask object exists (see qemu_rbd_start_co()).
> > >=20
> > > However, with multiqueue, that thread is not necessarily the same as =
the
> > > BDS's AioContext.  Instead, we need to remember the actual AioContext
> > > and schedule the completion BH there.
> > >=20
> > > Buglink:https://issues.redhat.com/browse/RHEL-67115
> > Please add a short summary of what actually happens to the commit
> > message. I had to check the link to remember what the symptoms are.
>=20
> Sure.=C2=A0 The problem is, I don=E2=80=99t know exactly what=E2=80=99s g=
oing wrong (looked like
> a coroutine being rescheduled after it was already done), and I don=E2=80=
=99t know
> how this fixes it.
>=20
> > > Reported-by: Junyao Zhao<junzhao@redhat.com>
> > > Signed-off-by: Hanna Czenczek<hreitz@redhat.com>
> > > ---
> > > I think I could also drop RBDTask.ctx and just use
> > > `qemu_coroutine_get_aio_context(RBDTask.co)` instead, but this is the
> > > version of the patch that was tested and confirmed to fix the issue (I
> > > don't have a local reproducer), so I thought I'll post this first.
> > Did  you figure out why it even makes a difference in which thread
> > qemu_rbd_finish_bh() runs? For context:
> >=20
> >      static void qemu_rbd_finish_bh(void *opaque)
> >      {
> >          RBDTask *task =3D opaque;
> >          task->complete =3D true;
> >          aio_co_wake(task->co);
> >      }
> >=20
> > This looks as if it should be working in any thread, except maybe for a
> > missing barrier after updating task->complete - but I think the failure
> > mode for that would be a hang in qemu_rbd_start_co().
>=20
> Yes, I thought the same thing.=C2=A0 All I could imagine was that maybe r=
eading
> task->co returns the wrong result, but given how long ago that must have
> been set, it seems quite unlikely (to say the least).=C2=A0 In addition,
> qemu_rbd_completion_cb() already reads the object from a different thread,
> and that seems to work fine.
>=20
> Really, all I know is that the notion of a BDS=E2=80=99s AioContext no lo=
nger makes
> sense in a multiqueue I/O path, so this should be scheduled in the I/O=E2=
=80=99s
> AioContext (just conceptually speaking), and that this seems to fix the b=
ug.

Scheduling the BH directly in the task's AioContext should help
performance, so I think this patch makes sense irrespective of the bug.
Performance results would be needed to justify that though.

With regards to the bug, I'm also not sure where the issue lies. The
root cause needs to be understood so that we can be sure that this patch
is really a fix and not just papering over a bug that is still reachable
in other ways.

>=20
> > >   block/rbd.c | 10 ++++++----
> > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/block/rbd.c b/block/rbd.c
> > > index af984fb7db..9d4e0817e0 100644
> > > --- a/block/rbd.c
> > > +++ b/block/rbd.c
> > > @@ -102,7 +102,7 @@ typedef struct BDRVRBDState {
> > >   } BDRVRBDState;
> > >   typedef struct RBDTask {
> > > -    BlockDriverState *bs;
> > > +    AioContext *ctx;
> > >       Coroutine *co;
> > >       bool complete;
> > >       int64_t ret;
> > > @@ -1269,8 +1269,7 @@ static void qemu_rbd_completion_cb(rbd_completi=
on_t c, RBDTask *task)
> > >   {
> > >       task->ret =3D rbd_aio_get_return_value(c);
> > >       rbd_aio_release(c);
> > > -    aio_bh_schedule_oneshot(bdrv_get_aio_context(task->bs),
> > > -                            qemu_rbd_finish_bh, task);
> > > +    aio_bh_schedule_oneshot(task->ctx, qemu_rbd_finish_bh, task);
> > >   }
> > >   static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
> > > @@ -1281,7 +1280,10 @@ static int coroutine_fn qemu_rbd_start_co(Bloc=
kDriverState *bs,
> > >                                             RBDAIOCmd cmd)
> > >   {
> > >       BDRVRBDState *s =3D bs->opaque;
> > > -    RBDTask task =3D { .bs =3D bs, .co =3D qemu_coroutine_self() };
> > > +    RBDTask task =3D {
> > > +        .ctx =3D qemu_get_current_aio_context(),
> > > +        .co =3D qemu_coroutine_self(),
> > > +    };
> > >       rbd_completion_t c;
> > >       int r;
> > Nothing wrong I can see about the change, but I don't understand why it
> > fixes the problem.
>=20
> Me neither.=C2=A0 But if this patch had been part of one of the original
> multiqueue series (without pointing out the linked bug), would there have
> been any argument against it?
>=20
> Indeed it is a problem that I don=E2=80=99t understand what=E2=80=99s hap=
pening. But even
> more honestly, I=E2=80=99ll have to admit I can=E2=80=99t ever claim to u=
nderstand what=E2=80=99s
> happening in a multi-threaded asynchronous C environment; even more so wh=
en
> the reproducer is installing Windows on RBD.
>=20
> Hanna

--DL/1+4ovpPWirJRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0GhIACgkQnKSrs4Gr
c8h9OAf/T8aCZtPFKvTYVUwu/WOzn7FOjRM/FQBoc3yoBp9EGgrR57LG4PDWvaoU
iktWeG8lowYsrp3wWE3yvwKhNpUAJCBzMKHgykG6ZiAGBstRhKH8j7gaTv9Gzya+
xwTy3YY2ddWjFDwuNHlYBG9RsASqBUeM/zyeTE3vVWDLzioUYMAnWw+BAHlxFNXb
0j3EMBBMV/qe3ZqIVQ50w0V7Z8QIkNELLDh8yPYX/KwuL01PE3SA8wk5Oivkn8SG
PPUFmlO9MPINU2noLWPSXftuX0cCBow11dfyVrMhFP9rQVZ59kcmyPsMLMaMhDDr
+9QpqCMnG22X05wX2J04dwoUDcde3g==
=iRVr
-----END PGP SIGNATURE-----

--DL/1+4ovpPWirJRJ--


