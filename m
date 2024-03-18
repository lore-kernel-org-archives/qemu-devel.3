Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B5BC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 12:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCZQ-0001Tj-90; Mon, 18 Mar 2024 08:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmCZN-0001TD-Nb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmCZL-0006zE-Fn
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PUo/387A7bIZnJHF/bPSbFk4N/+iMXb4foU5KSecSTY=;
 b=Wl/4fl0ONtGOTzFYmlNGhmnMdd6jffMpx+val+jITbc1zoHSiYsUGGxFv7iATf3R8dWKiP
 WAVmaUcScs0KENSpzVsfqiLZikibu3T6d473cfv1bkAT5sJNa18n7YX/BIfw1IyT3hhAWW
 j8JLHkAMamhGoaTMcmll2dw0SEU6VbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-BhgUt5fHOgKIwsCJEbFY4Q-1; Mon, 18 Mar 2024 08:58:16 -0400
X-MC-Unique: BhgUt5fHOgKIwsCJEbFY4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47BFD101A523;
 Mon, 18 Mar 2024 12:58:16 +0000 (UTC)
Received: from localhost (unknown [10.39.194.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FFFE1C060A4;
 Mon, 18 Mar 2024 12:58:15 +0000 (UTC)
Date: Mon, 18 Mar 2024 08:58:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 aliang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0] mirror: Don't call job_pause_point() under graph
 lock
Message-ID: <20240318125804.GA908758@fedora>
References: <20240313153000.33121-1-kwolf@redhat.com>
 <20240314142939.GE611723@fedora> <Zfgnb1b1IHhFYpHr@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cDpUfw8PCnHUNmDZ"
Content-Disposition: inline
In-Reply-To: <Zfgnb1b1IHhFYpHr@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--cDpUfw8PCnHUNmDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 12:37:19PM +0100, Kevin Wolf wrote:
> Am 14.03.2024 um 15:29 hat Stefan Hajnoczi geschrieben:
> > On Wed, Mar 13, 2024 at 04:30:00PM +0100, Kevin Wolf wrote:
> > > Calling job_pause_point() while holding the graph reader lock
> > > potentially results in a deadlock: bdrv_graph_wrlock() first drains
> > > everything, including the mirror job, which pauses it. The job is only
> > > unpaused at the end of the drain section, which is when the graph wri=
ter
> > > lock has been successfully taken. However, if the job happens to be
> > > paused at a pause point where it still holds the reader lock, the wri=
ter
> > > lock can't be taken as long as the job is still paused.
> > >=20
> > > Mark job_pause_point() as GRAPH_UNLOCKED and fix mirror accordingly.
> > >=20
> > > Cc: qemu-stable@nongnu.org
> > > Buglink: https://issues.redhat.com/browse/RHEL-28125
> > > Fixes: 004915a96a7a40e942ac85e6d22518cbcd283506
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  include/qemu/job.h |  2 +-
> > >  block/mirror.c     | 10 ++++++----
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/include/qemu/job.h b/include/qemu/job.h
> > > index 9ea98b5927..2b873f2576 100644
> > > --- a/include/qemu/job.h
> > > +++ b/include/qemu/job.h
> > > @@ -483,7 +483,7 @@ void job_enter(Job *job);
> > >   *
> > >   * Called with job_mutex *not* held.
> > >   */
> > > -void coroutine_fn job_pause_point(Job *job);
> > > +void coroutine_fn GRAPH_UNLOCKED job_pause_point(Job *job);
> > > =20
> > >  /**
> > >   * @job: The job that calls the function.
> > > diff --git a/block/mirror.c b/block/mirror.c
> > > index 5145eb53e1..1bdce3b657 100644
> > > --- a/block/mirror.c
> > > +++ b/block/mirror.c
> > > @@ -479,9 +479,9 @@ static unsigned mirror_perform(MirrorBlockJob *s,=
 int64_t offset,
> > >      return bytes_handled;
> > >  }
> > > =20
> > > -static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJo=
b *s)
> > > +static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlock=
Job *s)
> > >  {
> > > -    BlockDriverState *source =3D s->mirror_top_bs->backing->bs;
> > > +    BlockDriverState *source;
> > >      MirrorOp *pseudo_op;
> > >      int64_t offset;
> > >      /* At least the first dirty chunk is mirrored in one iteration. =
*/
> > > @@ -489,6 +489,10 @@ static void coroutine_fn GRAPH_RDLOCK mirror_ite=
ration(MirrorBlockJob *s)
> > >      bool write_zeroes_ok =3D bdrv_can_write_zeroes_with_unmap(blk_bs=
(s->target));
> > >      int max_io_bytes =3D MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYT=
ES);
> > > =20
> > > +    bdrv_graph_co_rdlock();
> > > +    source =3D s->mirror_top_bs->backing->bs;
> >=20
> > Is bdrv_ref(source) needed here so that source cannot go away if someone
> > else write locks the graph and removes it? Or maybe something else
> > protects against that. Either way, please add a comment that explains
> > why this is safe.
>=20
> We didn't even get to looking at this level of detail with the graph
> locking work. We probably should, but this is not the only place in
> mirror we need to look at then. Commit 004915a9 just took the lazy path
> of taking the lock for the whole function, and it turns out that this
> was wrong and causes deadlocks, so I'm reverting it and replacing it
> with what other parts of the code do - the minimal thing to let it
> compile.
>=20
> I think we already own a reference, we do a block_job_add_bdrv() in
> mirror_start_job(). But once it changes, we have a reference to the
> wrong node. So it looks to me that mirror has a problem with a changing
> source node that is more fundamental than graph locking in one specific
> function because it stores BDS pointers in its state.
>=20
> Active commit already freezes the backing chain between mirror_top_bs
> and target, maybe other mirror jobs need to freeze the link between
> mirror_top_bs and source at least.
>=20
> So I agree that it might be worth looking into this more, but I consider
> it unrelated to this patch. We just go back to the state in which it has
> always been before 8.2 (which might contain a latent bug that apparently
> never triggered in practice) to fix a regression that we do see in
> practice.
>=20
> Kevin

Okay:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cDpUfw8PCnHUNmDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX4OlwACgkQnKSrs4Gr
c8jg7Af/YbjDiPD5AOztYnsJwkdz0ktmPm9qbKnAAc/kvHEbkUXJSLJKlUW6Lt73
yUjUb6/In/8htWHmg8Kdhy2B3MExbf0zCUWo8GxJiaAdlwY5lR86Ttsjf0V7NyVX
TeZ0PS4ugvJTFLeUZMDJF4YzdPgcqtdxEde1cWcRTL+T2eecsVF30KJqRc9qZgFJ
LRRNUDg+YHW27nzqFxSuGTBdSs72paDe3SU2JxeATi7TuuytgXK0Hw4wzTioytC4
FOk4zIi7+wLH1VbA/3VnWcHw2jiFNru0e6IeqHKJNMBwR1PuJSTQD1KoHm7G7Iu5
qxSvaOD3AG9jFlrL2j1sgJVOSmRlCQ==
=i5os
-----END PGP SIGNATURE-----

--cDpUfw8PCnHUNmDZ--


