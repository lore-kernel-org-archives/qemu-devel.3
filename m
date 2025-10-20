Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B9CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwBM-0006s8-Lv; Mon, 20 Oct 2025 16:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vAwBK-0006rs-OW
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vAwBI-0001p5-MQ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760990915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8H2YBg4RpzVgod1IJqChtMZFmqth9Lw7cDtNW9AKo9I=;
 b=Md/4wWMlqhV2zrVw2aHm02CXqnh5IDV4CWG1fwHDct7J1rds/2k68azGI/Eo5TaFSXUirL
 65z4pETKBDOAIqtBH38oEzg2UgKemlm8UjvRKcs8Tt55wYBzqOe4UPcBLvY2XM9Cj9za8G
 j0W9Te4jDoJ1iBkE36UFFq6GrF19uck=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-4FspADWxNo27nq5OhPkQgg-1; Mon,
 20 Oct 2025 16:08:33 -0400
X-MC-Unique: 4FspADWxNo27nq5OhPkQgg-1
X-Mimecast-MFC-AGG-ID: 4FspADWxNo27nq5OhPkQgg_1760990912
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BBFC195609F; Mon, 20 Oct 2025 20:08:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.188])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C937819560A2; Mon, 20 Oct 2025 20:08:30 +0000 (UTC)
Date: Mon, 20 Oct 2025 16:08:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 04/12] aio-posix: integrate fdmon into glib event loop
Message-ID: <20251020200829.GB119797@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-5-stefanha@redhat.com>
 <aOfT-zK_3XXM_9_8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Pj1gVbe/kX3coOg"
Content-Disposition: inline
In-Reply-To: <aOfT-zK_3XXM_9_8@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--6Pj1gVbe/kX3coOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 05:25:47PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > AioContext's glib integration only supports ppoll(2) file descriptor
> > monitoring. epoll(7) and io_uring(7) disable themselves and switch back
> > to ppoll(2) when the glib event loop is used. The main loop thread
> > cannot use epoll(7) or io_uring(7) because it always uses the glib event
> > loop.
> >=20
> > Future QEMU features may require io_uring(7). One example is uring_cmd
> > support in FUSE exports. Each feature could create its own io_uring(7)
> > context and integrate it into the event loop, but this is inefficient
> > due to extra syscalls. It would be more efficient to reuse the
> > AioContext's existing fdmon-io_uring.c io_uring(7) context because
> > fdmon-io_uring.c will already be active on systems where Linux io_uring
> > is available.
> >=20
> > In order to keep fdmon-io_uring.c's AioContext operational even when the
> > glib event loop is used, extend FDMonOps with an API similar to
> > GSourceFuncs so that file descriptor monitoring can integrate into the
> > glib event loop.
> >=20
> > A quick summary of the GSourceFuncs API:
> > - prepare() is called each event loop iteration before waiting for file
> >   descriptors and timers.
> > - check() is called to determine whether events are ready to be
> >   dispatched after waiting.
> > - dispatch() is called to process events.
> >=20
> > More details here: https://docs.gtk.org/glib/struct.SourceFuncs.html
> >=20
> > Move the ppoll(2)-specific code from aio-posix.c into fdmon-poll.c and
> > also implement epoll(7)- and io_uring(7)-specific file descriptor
> > monitoring code for glib event loops.
> >=20
> > Note that it's still faster to use aio_poll() rather than the glib event
> > loop since glib waits for file descriptor activity with ppoll(2) and
> > does not support adaptive polling. But at least epoll(7) and io_uring(7)
> > now work in glib event loops.
> >=20
> > Splitting this into multiple commits without temporarily breaking
> > AioContext proved difficult so this commit makes all the changes. The
> > next commit will remove the aio_context_use_g_source() API because it is
> > no longer needed.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> It looks to me like we get a lot of duplication between implementations
> of .wait and the new .gsource_* callbacks. We can probably clean this up
> later. In the meantime, we need to make sure that the implementations
> don't diverge.

Yes, glib's GSource and aio_poll() have different interfaces but end up
doing a lot of similar things.

> >  include/block/aio.h   | 36 ++++++++++++++++++
> >  util/aio-posix.h      |  5 +++
> >  tests/unit/test-aio.c |  7 +++-
> >  util/aio-posix.c      | 69 ++++++++-------------------------
> >  util/fdmon-epoll.c    | 52 ++++++++++++++++++++++---
> >  util/fdmon-io_uring.c | 44 +++++++++++++++++++++-
> >  util/fdmon-poll.c     | 88 ++++++++++++++++++++++++++++++++++++++++++-
> >  7 files changed, 239 insertions(+), 62 deletions(-)
>=20
> > +static void fdmon_epoll_gsource_dispatch(AioContext *ctx,
> > +                                         AioHandlerList *ready_list)
> > +{
> > +    AioHandler *node;
> > +    int ret;
> > +    struct epoll_event events[128];
> > +
> > +    /* Collect events and process them */
> > +    ret =3D epoll_wait(ctx->epollfd, events, ARRAY_SIZE(events), 0);
> > +    if (ret <=3D 0) {
> > +        return;
> > +    }
> > +    for (int i =3D 0; i < ret; i++) {
> > +        int ev =3D events[i].events;
> > +        int revents =3D (ev & EPOLLIN ? G_IO_IN : 0) |
> > +                      (ev & EPOLLOUT ? G_IO_OUT : 0) |
> > +                      (ev & EPOLLHUP ? G_IO_HUP : 0) |
> > +                      (ev & EPOLLERR ? G_IO_ERR : 0);
> > +
> > +        node =3D events[i].data.ptr;
> > +        aio_add_ready_handler(ready_list, node, revents);
> > +    }
> > +}
>=20
> Isn't this just fdmon_epoll_wait(ctx, ready_list, 0)?

Yes, it is. I'll reuse fdmon_epoll_wait() in the next patch series
revision.

>=20
> > @@ -97,11 +102,92 @@ static void fdmon_poll_update(AioContext *ctx,
> >                                AioHandler *old_node,
> >                                AioHandler *new_node)
> >  {
> > -    /* Do nothing, AioHandler already contains the state we'll need */
> > +    if (old_node && !new_node) {
> > +        /*
> > +         * If the GSource is in the process of being destroyed then
> > +         * g_source_remove_poll() causes an assertion failure.  Skip r=
emoval in
> > +         * that case, because glib cleans up its state during destruct=
ion
> > +         * anyway.
> > +         */
> > +        if (!g_source_is_destroyed(&ctx->source)) {
> > +            g_source_remove_poll(&ctx->source, &old_node->pfd);
> > +        }
> > +    }
> > +
> > +    if (!old_node && new_node) {
> > +        g_source_add_poll(&ctx->source, &new_node->pfd);
> > +    }
> > +}
>=20
> I think this changes the behaviour for the case where we update a node,
> i.e. old_node and new_node are both non-NULL. Previously we added the
> new node and removed the old one, now you're skipping this.
>=20
> Both are referring to the same file descriptor, but we're not passing
> an integer here but a pointer to a heap-allocated GPollFD (which is
> contined in the AioHandler). The next thing that happens in the caller
> is that we free old_node.
>=20
> Doesn't this cause use after free?

You are right. It should be just:

  if (old_node) { remove(); }
  if (new_node) { add(); }

>=20
> > +static void fdmon_poll_gsource_prepare(AioContext *ctx)
> > +{
> > +    /* Do nothing */
> > +}
> > +
> > +static bool fdmon_poll_gsource_check(AioContext *ctx)
> > +{
> > +    AioHandler *node;
> > +    bool result =3D false;
> > +
> > +    /*
> > +     * We have to walk very carefully in case aio_set_fd_handler is
> > +     * called while we're walking.
> > +     */
> > +    qemu_lockcnt_inc(&ctx->list_lock);
> > +
> > +    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> > +        int revents =3D node->pfd.revents & node->pfd.events;
> > +
> > +        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read=
) {
> > +            result =3D true;
> > +            break;
> > +        }
> > +        if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
> > +            result =3D true;
> > +            break;
> > +        }
> > +    }
> > +
> > +    qemu_lockcnt_dec(&ctx->list_lock);
> > +
> > +    return result;
> > +}
> > +
> > +static void fdmon_poll_gsource_dispatch(AioContext *ctx,
> > +                                        AioHandlerList *ready_list)
> > +{
> > +    AioHandler *node;
> > +
> > +    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> > +        int revents;
> > +
> > +        revents =3D node->pfd.revents & node->pfd.events;
> > +        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read=
) {
> > +            aio_add_ready_handler(ready_list, node, revents);
> > +        } else if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
> > +            aio_add_ready_handler(ready_list, node, revents);
> > +        }
>=20
> Why do we need these checks? Don't we already know that if an event is
> in node->pfd.events, there is a matching io_read/io_write callback, too?
> This is how aio_set_fd_handler() decides which events to monitor.
>=20
> If we do need them, why doesn't fdmon_poll_wait()?

fdmon_poll_wait() is fine, I'll take the same approach here.

--6Pj1gVbe/kX3coOg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj2lr0ACgkQnKSrs4Gr
c8j48Af/bHceCS6UBmbxEy1KOc1Y6nu29s3MLMumnnOF9/cLfGSjVtDr1Fzp9nkw
ytdDanzbgc8n+mcJJZp+P9czlMQmTvmiFGwwPzcpOdYYVj2rZqD7wF0Q4ACwbpwt
SiRqfKQaBcENBpC3mqXsp85Z7MmR9RoXf9LSrnge9umKjtXK9Hz9l8I3tD+s+uHO
Bu4P7WmgKdZm2kdq4jmIjPTku94+ESP4v19kOvVDNhIaYY1QEOHvgmGgwv2KZr3C
tSlBHOYr3fPCwg1SMaOSnIntoePPTufnTpvQ7+SzTbJ1V0ADOllwTMdvXel6w0f2
rAz0cp1IVuQdfOmRw/8xROwSQNFNjA==
=S861
-----END PGP SIGNATURE-----

--6Pj1gVbe/kX3coOg--


