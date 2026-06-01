Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3FACD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU80I-0003sy-5i; Mon, 01 Jun 2026 15:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU808-0003s8-0M
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU805-0001qf-PB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780340914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fjZ/J/GvaL5jBBfmoq4K4z/fgHuk67XFk+zURU98OG8=;
 b=SgO8vO1xZ3/CSknIAW2KUTiLRd10lDoK39MDOLCf8Dvg7oZHlO6T11VvF2UoFOlBUGNh/3
 DWl6iIir59WNWK5/mDacEGho3B0WGPqk8VwYYh2E3cyh5Lu7w7T2wedsj1/7oSTEifRFQW
 6vPT8gfhcBqIdFcOoQXnaxSRBXeFVcM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-fQlweIeQPyGxkFH0bsmUhw-1; Mon,
 01 Jun 2026 15:08:30 -0400
X-MC-Unique: fQlweIeQPyGxkFH0bsmUhw-1
X-Mimecast-MFC-AGG-ID: fQlweIeQPyGxkFH0bsmUhw_1780340910
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5E6C19560A1; Mon,  1 Jun 2026 19:08:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 631A71687; Mon,  1 Jun 2026 19:08:29 +0000 (UTC)
Date: Mon, 1 Jun 2026 15:08:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v1] qed: Don't try to drain during INMIGRATE
Message-ID: <20260601190828.GA469996@fedora>
References: <20260528135507.485-1-farosas@suse.de>
 <ahhzCjSY7zrbXFme@redhat.com> <87y0h3tfi2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AdWdSADfduN1x1q9"
Content-Disposition: inline
In-Reply-To: <87y0h3tfi2.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--AdWdSADfduN1x1q9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 06:01:57PM -0300, Fabiano Rosas wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 28.05.2026 um 15:55 hat Fabiano Rosas geschrieben:
> >> It's not possible to access the image file while there is an incoming
> >> migration in progress, the QEMU process doesn't hold any locks to the
> >> storage at this point so nodes are inactive. Attempting to drain leads
> >> to an assert at bdrv_co_write_req_prepare():
> >>=20
> >>    assert(!(bs->open_flags & BDRV_O_INACTIVE))
> >>=20
> >> The issue is reproducible by running iotest 181 on a host under cpu
> >> load. The migration must coincide with the header already containing
> >> the QED_F_NEED_CHECK flag.
> >>=20
> >> The sequence of events is as follows, with the respective call stacks
> >> referenced below:
> >>=20
> >> During block device init, bdrv_qed_attach_aio_context() starts the
> >> 'need_check' timer. The timer will not fire during incoming migration
> >> as it uses QEMU_CLOCK_VIRTUAL (to avoid this very issue, as the code
> >> comment indicates).                                                   =
(0)
> >>=20
> >> However, there's still bdrv_qed_drain_begin() which uses the fact that
> >> the timer is live to decide whether to start the
> >> qed_need_check_timer_entry() directly.                                =
(1)
> >>=20
> >> The qed_need_check_timer_entry() eventually calls into
> >> qed_write_header() -> bdrv_co_pwrite() leading to the assert.         =
(2)
> >>=20
> >> Since we don't have an API for checking if a timer is enabled, an
> >> alternative is to skip this logic whenever the runstate is
> >> INMIGRATE. This actually matches the setting of the BDRV_O_INACTIVE
> >> flag at blockdev.c.
> >
> > I'm not sure what you mean by "checking if a timer is enabled", because
> > bdrv_qed_drain_begin() has a timer_pending() check that sounds exactly
> > what you say doesn't exist.
> >
>=20
> Sorry, I meant to say checking if a *clock* is enabled.=20
>=20
> The code comment at qed_start_need_check_timer() says:
>=20
>     /* Use QEMU_CLOCK_VIRTUAL so we don't alter the image file while susp=
ended for
>      * migration.
>      */
>=20
> It seems to assume that since QEMU_CLOCK_VIRTUAL is disabled when vcpus
> are paused then the timer function will never execute while the image is
> inactive. If bdrv_qed_drain_begin() could check clock->enabled, then it
> would be under the same assumption.
>=20
> > But it's also not clear to me why s->need_check_timer is true on an
> > inactive image. I don't think this is supposed to be the case?
>=20
> bdrv_qed_do_open() reads the header during QEMU startup. Whatever is set
> in the header at that moment will be picked up, including
> QED_F_NEED_CHECK, which is what the code uses to determine the timer
> should be started.
>=20
> > It looks like qed is missing a .bdrv_inactivate implementation that
> > cancels the timer after flushing everything (including the header) to
> > disk.
> >
>=20
> Hmm, but bdrv_inactivate happens on the migration source. The
> destination machine could still start at any moment while the image is
> dirty and see the QED_F_NEED_CHECK flag. Even doing something on the
> destination machine wouldn't help I think given how early the crash
> happens.

bdrv_qed_do_open() has flags & BDRV_O_INACTIVE checks but not when it
calls bdrv_qed_attach_aio_context(). The destination could avoid
creating the timer when BDRV_O_INACTIVE is set. The existing
bdrv_qed_co_invalidate_cache() code will create the timer when
BDRV_O_INACTIVE is cleared via bdrv_activate().

Stefan

>=20
> >>=20
> >> The stacks:
> >>=20
> >> (0) =3D=3D issues timer_mod =3D=3D
> >>  #6  in qed_start_need_check_timer       at ../block/qed.c:340
> >>  #7  in bdrv_qed_attach_aio_context      at ../block/qed.c:373
> >>  #8  in bdrv_qed_do_open                 at ../block/qed.c:556
> >>  #9  in bdrv_qed_open_entry              at ../block/qed.c:582
> >>  #10 in coroutine_trampoline             at ../util/coroutine-ucontext=
=2Ec:175
> >>  #0  in qemu_coroutine_switch<+120>      at ../util/coroutine-ucontext=
=2Ec:321
> >>  #1  in qemu_aio_coroutine_enter<+356>   at ../util/qemu-coroutine.c:2=
93
> >>  #2  in aio_co_enter<+179>               at ../util/async.c:710
> >>  #3  in aio_co_wake<+53>                 at ../util/async.c:695
> >>  #4  in thread_pool_co_cb<+47>           at ../util/thread-pool.c:283
> >>  #5  in thread_pool_completion_bh<+241>  at ../util/thread-pool.c:202
> >>  #6  in aio_bh_call<+109>                at ../util/async.c:173
> >>  #7  in aio_bh_poll<+299>                at ../util/async.c:220
> >>  #8  in aio_poll<+690>                   at ../util/aio-posix.c:745
> >>  #9  in bdrv_qed_open<+392>              at ../block/qed.c:607
> >>  #10 in bdrv_open_driver<+327>           at ../block.c:1678
> >>  #11 in bdrv_open_common<+1619>          at ../block.c:2008
> >>  #12 in bdrv_open_inherit<+2556>         at ../block.c:4191
> >>  #13 in bdrv_open<+118>                  at ../block.c:4286
> >>  #14 in blk_new_open<+199>               at ../block/block-backend.c:4=
58
> >>  #15 in blockdev_init<+2011>             at ../blockdev.c:612
> >>  #16 in drive_new<+3008>                 at ../blockdev.c:1008
> >>  #17 in drive_init_func<+51>             at ../system/vl.c:662
> >>  #18 in qemu_opts_foreach<+227>          at ../util/qemu-option.c:1148
> >>  #19 in configure_blockdev<+350>         at ../system/vl.c:721
> >>  #20 in qemu_create_early_backends<+343> at ../system/vl.c:2076
> >>  #21 in qemu_init<+12483>                at ../system/vl.c:3778
> >>  #22 in main<+46>                        at ../system/main.c:71
> >>=20
> >> (1) =3D=3D sees timer_pending =3D=3D
> >>  #6  in bdrv_qed_drain_begin             at ../block/qed.c:391
> >>  #7  in bdrv_do_drained_begin            at ../block/io.c:366
> >>  #8  in bdrv_do_drained_begin_quiesce    at ../block/io.c:386
> >>  #9  in bdrv_child_cb_drained_begin      at ../block.c:1207
> >>  #10 in bdrv_parent_drained_begin_single at ../block/io.c:133
> >>  #11 in bdrv_parent_drained_begin        at ../block/io.c:64
> >>  #12 in bdrv_do_drained_begin            at ../block/io.c:364
> >>  #13 in bdrv_drained_begin               at ../block/io.c:393
> >>  #14 in blk_drain                        at ../block/block-backend.c:2=
101
> >>  #15 in blk_unref                        at ../block/block-backend.c:5=
44
> >>  #16 in bdrv_open_inherit                at ../block.c:4197
> >>  #17 in bdrv_open                        at ../block.c:4286
> >>  #18 in blk_new_open                     at ../block/block-backend.c:4=
58
> >>  #19 in blockdev_init                    at ../blockdev.c:612
> >>  #20 in drive_new                        at ../blockdev.c:1008
> >>  #21 in drive_init_func                  at ../system/vl.c:662
> >>  #22 in qemu_opts_foreach                at ../util/qemu-option.c:1148
> >>  #23 in configure_blockdev               at ../system/vl.c:721
> >>  #24 in qemu_create_early_backends       at ../system/vl.c:2076
> >>  #25 in qemu_init                        at ../system/vl.c:3778
> >>  #26 in main                             at ../system/main.c:71
> >>=20
> >> (2) =3D=3D crashes =3D=3D
> >>  #5  in __assert_fail (assertion=3D"!(bs->open_flags & BDRV_O_INACTIVE=
)", file=3D"../block/io.c", line=3D1977
> >>  #6  in bdrv_co_write_req_prepare  at ../block/io.c:1977
> >>  #7  in bdrv_aligned_pwritev       at ../block/io.c:2099
> >>  #8  in bdrv_co_pwritev_part       at ../block/io.c:2316
> >>  #9  in bdrv_co_pwritev            at ../block/io.c:2233
> >>  #10 in bdrv_co_pwrite             at ../include/block/block_int-io.h:=
77
> >>  #11 in qed_write_header           at ../block/qed.c:128
> >>  #12 in qed_need_check_timer       at ../block/qed.c:305
> >>  #13 in qed_need_check_timer_entry at ../block/qed.c:319
> >>=20
> >> Note that this issue is not exactly the same as what's been reported
> >> in Gitlab, but given how easily this reproduces, I imagine it has to
> >> be happening in that setup as well.
> >>=20
> >> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3515
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2557314306
> >> ---
> >>  block/qed.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>=20
> >> diff --git a/block/qed.c b/block/qed.c
> >> index da23a83d62..ccf32bb4ae 100644
> >> --- a/block/qed.c
> >> +++ b/block/qed.c
> >> @@ -21,6 +21,7 @@
> >>  #include "qemu/module.h"
> >>  #include "qemu/option.h"
> >>  #include "qemu/memalign.h"
> >> +#include "system/runstate.h"
> >>  #include "trace.h"
> >>  #include "qed.h"
> >>  #include "system/block-backend.h"
> >> @@ -373,6 +374,11 @@ static void bdrv_qed_drain_begin(BlockDriverState=
 *bs)
> >>  {
> >>      BDRVQEDState *s =3D bs->opaque;
> >> =20
> >> +    /* Nodes are inactive while waiting for an incoming migration. */
> >> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> >
> > If you're interested in whether the node is inactive, this is what you
> > should check. RUN_STATE_INMIGRATE is only one of the conditions in which
> > it might (but doesn't have to) be true. There is bdrv_is_inactive() to
> > check this.
> >
> > Of course, if we're fixing the root cause (that QED_F_NEED_CHECK and
> > s->need_check_timer are set on an inactive image), this hunk might not
> > be needed at all.
> >
> >> +        return;
> >> +    }
> >> +
> >>      /* Fire the timer immediately in order to start doing I/O as soon=
 as the
> >>       * header is flushed.
> >>       */
> >
> > Kevin
>=20

--AdWdSADfduN1x1q9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmod2KwACgkQnKSrs4Gr
c8iz3ggAieDoGw3xniK7RLaR+QP1uks5Y0bcvG2mUyV/ybazKAu0A61gEiEzbI9Z
LaesT4PCDDXPnKFPNwdtuidGQkSrk6khKyoCk24thwt+JgV+qyu/mIi0jFShqzrK
afp3JrNgojmolEGe8+dv+dd/qX4GI10UjH5SlAKIuQqooEOIrC9FN2ttZPGfKKM0
CUSjYRoRSxHPLrJDVkaMZIBajDvqAQk5zS1wS8nOOm/5JKUMDWkEDHd9+zXIGXE4
I5lAANbJkefetLArbgnW2EAxdenyZiZFLj/TGtaIf7f/Di+GStXiHGJdqpX7ObMf
P9bz1i8ETmXd9K+S+Nxg2LclQKL2Ew==
=XVpC
-----END PGP SIGNATURE-----

--AdWdSADfduN1x1q9--


