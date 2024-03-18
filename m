Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CF8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBJA-00046P-UM; Mon, 18 Mar 2024 07:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBJ7-00045w-9I
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBJ5-0008LJ-GB
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710761849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vd2Q8R6AkqPDkimVCcMopMBJ+KPuSmcuQmAbLY7Rd20=;
 b=TH4u5qkSB1+hDjIu8VR3ynTzFH8RGDU/m3i7ITB7KSKHJzQVm4wCjqRt9EGOTwfOF8EY9I
 pmWdSbySfCtsgr9vk5bAkPWu1ds5leokKFIvDYVwyX4m8YrQ+cdw4sSqc6oPSAAoT53QYj
 NsIEV+RxOEvLu+g6o4VrMLJmxi2yL5Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-kGuUj7tcOoWpWjlY0zzogQ-1; Mon,
 18 Mar 2024 07:37:25 -0400
X-MC-Unique: kGuUj7tcOoWpWjlY0zzogQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E9FC3C0D7B8;
 Mon, 18 Mar 2024 11:37:25 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 527C82024517;
 Mon, 18 Mar 2024 11:37:23 +0000 (UTC)
Date: Mon, 18 Mar 2024 12:37:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 aliang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0] mirror: Don't call job_pause_point() under graph
 lock
Message-ID: <Zfgnb1b1IHhFYpHr@redhat.com>
References: <20240313153000.33121-1-kwolf@redhat.com>
 <20240314142939.GE611723@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mDodqK/kkrs5Jo9k"
Content-Disposition: inline
In-Reply-To: <20240314142939.GE611723@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--mDodqK/kkrs5Jo9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.03.2024 um 15:29 hat Stefan Hajnoczi geschrieben:
> On Wed, Mar 13, 2024 at 04:30:00PM +0100, Kevin Wolf wrote:
> > Calling job_pause_point() while holding the graph reader lock
> > potentially results in a deadlock: bdrv_graph_wrlock() first drains
> > everything, including the mirror job, which pauses it. The job is only
> > unpaused at the end of the drain section, which is when the graph writer
> > lock has been successfully taken. However, if the job happens to be
> > paused at a pause point where it still holds the reader lock, the writer
> > lock can't be taken as long as the job is still paused.
> >=20
> > Mark job_pause_point() as GRAPH_UNLOCKED and fix mirror accordingly.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Buglink: https://issues.redhat.com/browse/RHEL-28125
> > Fixes: 004915a96a7a40e942ac85e6d22518cbcd283506
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/qemu/job.h |  2 +-
> >  block/mirror.c     | 10 ++++++----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/qemu/job.h b/include/qemu/job.h
> > index 9ea98b5927..2b873f2576 100644
> > --- a/include/qemu/job.h
> > +++ b/include/qemu/job.h
> > @@ -483,7 +483,7 @@ void job_enter(Job *job);
> >   *
> >   * Called with job_mutex *not* held.
> >   */
> > -void coroutine_fn job_pause_point(Job *job);
> > +void coroutine_fn GRAPH_UNLOCKED job_pause_point(Job *job);
> > =20
> >  /**
> >   * @job: The job that calls the function.
> > diff --git a/block/mirror.c b/block/mirror.c
> > index 5145eb53e1..1bdce3b657 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -479,9 +479,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, i=
nt64_t offset,
> >      return bytes_handled;
> >  }
> > =20
> > -static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob =
*s)
> > +static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJo=
b *s)
> >  {
> > -    BlockDriverState *source =3D s->mirror_top_bs->backing->bs;
> > +    BlockDriverState *source;
> >      MirrorOp *pseudo_op;
> >      int64_t offset;
> >      /* At least the first dirty chunk is mirrored in one iteration. */
> > @@ -489,6 +489,10 @@ static void coroutine_fn GRAPH_RDLOCK mirror_itera=
tion(MirrorBlockJob *s)
> >      bool write_zeroes_ok =3D bdrv_can_write_zeroes_with_unmap(blk_bs(s=
->target));
> >      int max_io_bytes =3D MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES=
);
> > =20
> > +    bdrv_graph_co_rdlock();
> > +    source =3D s->mirror_top_bs->backing->bs;
>=20
> Is bdrv_ref(source) needed here so that source cannot go away if someone
> else write locks the graph and removes it? Or maybe something else
> protects against that. Either way, please add a comment that explains
> why this is safe.

We didn't even get to looking at this level of detail with the graph
locking work. We probably should, but this is not the only place in
mirror we need to look at then. Commit 004915a9 just took the lazy path
of taking the lock for the whole function, and it turns out that this
was wrong and causes deadlocks, so I'm reverting it and replacing it
with what other parts of the code do - the minimal thing to let it
compile.

I think we already own a reference, we do a block_job_add_bdrv() in
mirror_start_job(). But once it changes, we have a reference to the
wrong node. So it looks to me that mirror has a problem with a changing
source node that is more fundamental than graph locking in one specific
function because it stores BDS pointers in its state.

Active commit already freezes the backing chain between mirror_top_bs
and target, maybe other mirror jobs need to freeze the link between
mirror_top_bs and source at least.

So I agree that it might be worth looking into this more, but I consider
it unrelated to this patch. We just go back to the state in which it has
always been before 8.2 (which might contain a latent bug that apparently
never triggered in practice) to fix a regression that we do see in
practice.

Kevin

--mDodqK/kkrs5Jo9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmX4J24ACgkQfwmycsiP
L9ba4A//YHOaSj595lzeDnRbuoZGUHRx2B6vZxbPL3ziUpGGS5WHQBobLNQDDXDb
CVXb7C0nFRjxyzwP3hFMjne+OLdBppUnd1clOX/4bbO/aYyy+sjhul/p3NAt05by
3GApa72GYfjJbAyWP3HPMElf610X8rJkPeox8gUew5eEXg7Jt0Yw2/7Z1yhf46TX
VowOUinKM2ss86ua18Hik6IGF57CTANF9cXmquENmHr+gKeiZA8vowPDgf/pfQMi
khaZWYZoKPYop9iBL8ibIYkXVDzMHhCH2FgFPauElq4a0F1PoX5IU6laKCJ62HnD
/Gdc4m2S+Ow7XiD24TsjSZ0RmMg4fk+6P0ZMMkyI+K0xfkeXQWjhOOdJ6QdXhDW1
oPxZZVa7gKwSgmcxA1BeqwIG1F++qd3wA3U3kBBQnpDmmWWn8DeNsy6FHH9yRn45
0RhdjN37m39Pe6oGFbqo2tYq8H3F2FbF+lu8+TDC0LcGeXRLDEiIVhOmIjCNwOK6
zb8TRTh/LZGE7px8jJVVQ3VFduytXkN2rcnTQQ5blFzU79+4ogtjDtnNw/UIEYb/
5a9q5honeCVowmwzQykcZO36eqwEhbOTMh+xYuZkdkKHzY2eBYBuKpy9fQf6DD7t
2RGgQftrSy9KPQnD6/42CBhJkujI8SqvmWMNCP/U2jxuZEL0EYw=
=y7qm
-----END PGP SIGNATURE-----

--mDodqK/kkrs5Jo9k--


