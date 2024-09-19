Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B211CE8D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGPF-0006rE-Kn; Thu, 19 Sep 2024 08:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srGP3-0006oo-Mc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:36:59 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srGP0-0004nz-M6
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Q6m3NCYE3jxQPicAKqLpKAZLySS52BSZuYFoOf81QUg=; b=bIWpG5wsmmNGHzsu
 31YbYwUFTqUcFjuUK0OuA0cdyJlW1NOI0jP60fP7wmhjuPrR9wSHYj6M5qK5gfNHa1mb7Hjxlw/yG
 XVsDrTBmmXmqZ+jLfAVrpWnKk5zDoVGbBHoWWGyHXF1i81lWgs+SOKoXPuO+6qJ6zRLBweF6/RpUj
 gR7ZauJH4eqdUy1kLiIEu4froASJQic5RekJf2M6oOSyp5bXnJ0TrZg3pwLjMXalZ6aKh68iHOHCo
 nH0xNJcDDAmel0wAlqZgRfPG+ZRox0eUnzOb8DC+sQbBCzTabMtWkSZncdYVvHxHJXRfC5CB0/y60
 /vcLr9tH4lEaHPXD5Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1srGOy-006PuI-08;
 Thu, 19 Sep 2024 12:36:52 +0000
Date: Thu, 19 Sep 2024 12:36:51 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io/channel-socket: Remove unused
 qio_channel_socket_dgram_async
Message-ID: <Zuwa41q2L7F6j3mF@gallifrey>
References: <20240919000034.485744-1-dave@treblig.org>
 <ZuwWANORpHFw4L9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuwWANORpHFw4L9e@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:33:01 up 133 days, 23:47,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Sep 19, 2024 at 01:00:34AM +0100, dave@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > 
> > qio_channel_socket_dgram_async has been unused since it was originally
> > added in 2015.
> > 
> > Remove it.
> 
> This was knowingly added as unused, since the QIO channel APIs
> were intended to be providing an general purpose interface that
> was anticipating future development. On the one hand it hasn't
> been used in 9 years, but on the other hand removing it makes
> the API inconsistent since we provide sync+async variants of
> every API.

Yeh that's fair enough; there's a big variation in approaches
to deadcode, some people are absolute on it, some people would
rather keep the consistency.
See the kernel thread at:
   https://lore.kernel.org/lkml/ZugliLgw5VFb9yau@gallifrey/

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >  include/io/channel-socket.h | 29 --------------------
> >  io/channel-socket.c         | 54 -------------------------------------
> >  io/trace-events             |  1 -
> >  3 files changed, 84 deletions(-)
> > 
> > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > index ab15577d38..6c858cc6b5 100644
> > --- a/include/io/channel-socket.h
> > +++ b/include/io/channel-socket.h
> > @@ -182,35 +182,6 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
> >                                    SocketAddress *remoteAddr,
> >                                    Error **errp);
> >  
> > -/**
> > - * qio_channel_socket_dgram_async:
> > - * @ioc: the socket channel object
> > - * @localAddr: the address to local bind address
> > - * @remoteAddr: the address to remote peer address
> > - * @callback: the function to invoke on completion
> > - * @opaque: user data to pass to @callback
> > - * @destroy: the function to free @opaque
> > - * @context: the context to run the async task. If %NULL, the default
> > - *           context will be used.
> > - *
> > - * Attempt to initialize a datagram socket bound to
> > - * @localAddr and communicating with peer @remoteAddr.
> > - * This method will run in the background so the caller
> > - * will regain execution control immediately. The function
> > - * @callback will be invoked on completion or failure.
> > - * The @localAddr and @remoteAddr parameters will be copied,
> > - * so may be freed as soon as this function returns without
> > - * waiting for completion.
> > - */
> > -void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
> > -                                    SocketAddress *localAddr,
> > -                                    SocketAddress *remoteAddr,
> > -                                    QIOTaskFunc callback,
> > -                                    gpointer opaque,
> > -                                    GDestroyNotify destroy,
> > -                                    GMainContext *context);
> > -
> > -
> >  /**
> >   * qio_channel_socket_get_local_address:
> >   * @ioc: the socket channel object
> > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > index 608bcf066e..2282e7a549 100644
> > --- a/io/channel-socket.c
> > +++ b/io/channel-socket.c
> > @@ -319,60 +319,6 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
> >  }
> >  
> >  
> > -struct QIOChannelSocketDGramWorkerData {
> > -    SocketAddress *localAddr;
> > -    SocketAddress *remoteAddr;
> > -};
> > -
> > -
> > -static void qio_channel_socket_dgram_worker_free(gpointer opaque)
> > -{
> > -    struct QIOChannelSocketDGramWorkerData *data = opaque;
> > -    qapi_free_SocketAddress(data->localAddr);
> > -    qapi_free_SocketAddress(data->remoteAddr);
> > -    g_free(data);
> > -}
> > -
> > -static void qio_channel_socket_dgram_worker(QIOTask *task,
> > -                                            gpointer opaque)
> > -{
> > -    QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
> > -    struct QIOChannelSocketDGramWorkerData *data = opaque;
> > -    Error *err = NULL;
> > -
> > -    /* socket_dgram() blocks in DNS lookups, so we must use a thread */
> > -    qio_channel_socket_dgram_sync(ioc, data->localAddr,
> > -                                  data->remoteAddr, &err);
> > -
> > -    qio_task_set_error(task, err);
> > -}
> > -
> > -
> > -void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
> > -                                    SocketAddress *localAddr,
> > -                                    SocketAddress *remoteAddr,
> > -                                    QIOTaskFunc callback,
> > -                                    gpointer opaque,
> > -                                    GDestroyNotify destroy,
> > -                                    GMainContext *context)
> > -{
> > -    QIOTask *task = qio_task_new(
> > -        OBJECT(ioc), callback, opaque, destroy);
> > -    struct QIOChannelSocketDGramWorkerData *data = g_new0(
> > -        struct QIOChannelSocketDGramWorkerData, 1);
> > -
> > -    data->localAddr = QAPI_CLONE(SocketAddress, localAddr);
> > -    data->remoteAddr = QAPI_CLONE(SocketAddress, remoteAddr);
> > -
> > -    trace_qio_channel_socket_dgram_async(ioc, localAddr, remoteAddr);
> > -    qio_task_run_in_thread(task,
> > -                           qio_channel_socket_dgram_worker,
> > -                           data,
> > -                           qio_channel_socket_dgram_worker_free,
> > -                           context);
> > -}
> > -
> > -
> >  QIOChannelSocket *
> >  qio_channel_socket_accept(QIOChannelSocket *ioc,
> >                            Error **errp)
> > diff --git a/io/trace-events b/io/trace-events
> > index d4c0f84a9a..5d0d4358db 100644
> > --- a/io/trace-events
> > +++ b/io/trace-events
> > @@ -25,7 +25,6 @@ qio_channel_socket_listen_async(void *ioc, void *addr, int num) "Socket listen a
> >  qio_channel_socket_listen_fail(void *ioc) "Socket listen fail ioc=%p"
> >  qio_channel_socket_listen_complete(void *ioc, int fd) "Socket listen complete ioc=%p fd=%d"
> >  qio_channel_socket_dgram_sync(void *ioc, void *localAddr, void *remoteAddr) "Socket dgram sync ioc=%p localAddr=%p remoteAddr=%p"
> > -qio_channel_socket_dgram_async(void *ioc, void *localAddr, void *remoteAddr) "Socket dgram async ioc=%p localAddr=%p remoteAddr=%p"
> >  qio_channel_socket_dgram_fail(void *ioc) "Socket dgram fail ioc=%p"
> >  qio_channel_socket_dgram_complete(void *ioc, int fd) "Socket dgram complete ioc=%p fd=%d"
> >  qio_channel_socket_accept(void *ioc) "Socket accept start ioc=%p"
> > -- 
> > 2.46.0
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

