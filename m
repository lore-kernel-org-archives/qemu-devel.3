Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFF3CAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srG54-0006q9-Fg; Thu, 19 Sep 2024 08:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1srG52-0006gR-0F
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1srG4z-0002GK-2r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726748171;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=o58K5GI+VaaqRnubFcJdWBXta9qkPoT1tfxSokreLeI=;
 b=Om7n+6hh4zxYndLY1kuJj1DQn9tuwOPR/WQBExI8P6/Xx1LCX/EBhkGnRqWFHiYrZ9iuxy
 b9f1tbdJLsRq2VIEhkYm6WfOnb4/viOKkDBh5rfu+2n4NigtQLozDASMbH2IIT3o4Q6EHp
 odshuyWfxI22xGNblEKR+VK7B5T3jFs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-2zSlATGSOEaI8bR52KOZKQ-1; Thu,
 19 Sep 2024 08:16:06 -0400
X-MC-Unique: 2zSlATGSOEaI8bR52KOZKQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F26A51954B1B; Thu, 19 Sep 2024 12:16:04 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.100])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B29330001A1; Thu, 19 Sep 2024 12:16:03 +0000 (UTC)
Date: Thu, 19 Sep 2024 14:16:00 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dave@treblig.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io/channel-socket: Remove unused
 qio_channel_socket_dgram_async
Message-ID: <ZuwWANORpHFw4L9e@redhat.com>
References: <20240919000034.485744-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919000034.485744-1-dave@treblig.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 19, 2024 at 01:00:34AM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> qio_channel_socket_dgram_async has been unused since it was originally
> added in 2015.
> 
> Remove it.

This was knowingly added as unused, since the QIO channel APIs
were intended to be providing an general purpose interface that
was anticipating future development. On the one hand it hasn't
been used in 9 years, but on the other hand removing it makes
the API inconsistent since we provide sync+async variants of
every API.

> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  include/io/channel-socket.h | 29 --------------------
>  io/channel-socket.c         | 54 -------------------------------------
>  io/trace-events             |  1 -
>  3 files changed, 84 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index ab15577d38..6c858cc6b5 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -182,35 +182,6 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
>                                    SocketAddress *remoteAddr,
>                                    Error **errp);
>  
> -/**
> - * qio_channel_socket_dgram_async:
> - * @ioc: the socket channel object
> - * @localAddr: the address to local bind address
> - * @remoteAddr: the address to remote peer address
> - * @callback: the function to invoke on completion
> - * @opaque: user data to pass to @callback
> - * @destroy: the function to free @opaque
> - * @context: the context to run the async task. If %NULL, the default
> - *           context will be used.
> - *
> - * Attempt to initialize a datagram socket bound to
> - * @localAddr and communicating with peer @remoteAddr.
> - * This method will run in the background so the caller
> - * will regain execution control immediately. The function
> - * @callback will be invoked on completion or failure.
> - * The @localAddr and @remoteAddr parameters will be copied,
> - * so may be freed as soon as this function returns without
> - * waiting for completion.
> - */
> -void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
> -                                    SocketAddress *localAddr,
> -                                    SocketAddress *remoteAddr,
> -                                    QIOTaskFunc callback,
> -                                    gpointer opaque,
> -                                    GDestroyNotify destroy,
> -                                    GMainContext *context);
> -
> -
>  /**
>   * qio_channel_socket_get_local_address:
>   * @ioc: the socket channel object
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..2282e7a549 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -319,60 +319,6 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
>  }
>  
>  
> -struct QIOChannelSocketDGramWorkerData {
> -    SocketAddress *localAddr;
> -    SocketAddress *remoteAddr;
> -};
> -
> -
> -static void qio_channel_socket_dgram_worker_free(gpointer opaque)
> -{
> -    struct QIOChannelSocketDGramWorkerData *data = opaque;
> -    qapi_free_SocketAddress(data->localAddr);
> -    qapi_free_SocketAddress(data->remoteAddr);
> -    g_free(data);
> -}
> -
> -static void qio_channel_socket_dgram_worker(QIOTask *task,
> -                                            gpointer opaque)
> -{
> -    QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
> -    struct QIOChannelSocketDGramWorkerData *data = opaque;
> -    Error *err = NULL;
> -
> -    /* socket_dgram() blocks in DNS lookups, so we must use a thread */
> -    qio_channel_socket_dgram_sync(ioc, data->localAddr,
> -                                  data->remoteAddr, &err);
> -
> -    qio_task_set_error(task, err);
> -}
> -
> -
> -void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
> -                                    SocketAddress *localAddr,
> -                                    SocketAddress *remoteAddr,
> -                                    QIOTaskFunc callback,
> -                                    gpointer opaque,
> -                                    GDestroyNotify destroy,
> -                                    GMainContext *context)
> -{
> -    QIOTask *task = qio_task_new(
> -        OBJECT(ioc), callback, opaque, destroy);
> -    struct QIOChannelSocketDGramWorkerData *data = g_new0(
> -        struct QIOChannelSocketDGramWorkerData, 1);
> -
> -    data->localAddr = QAPI_CLONE(SocketAddress, localAddr);
> -    data->remoteAddr = QAPI_CLONE(SocketAddress, remoteAddr);
> -
> -    trace_qio_channel_socket_dgram_async(ioc, localAddr, remoteAddr);
> -    qio_task_run_in_thread(task,
> -                           qio_channel_socket_dgram_worker,
> -                           data,
> -                           qio_channel_socket_dgram_worker_free,
> -                           context);
> -}
> -
> -
>  QIOChannelSocket *
>  qio_channel_socket_accept(QIOChannelSocket *ioc,
>                            Error **errp)
> diff --git a/io/trace-events b/io/trace-events
> index d4c0f84a9a..5d0d4358db 100644
> --- a/io/trace-events
> +++ b/io/trace-events
> @@ -25,7 +25,6 @@ qio_channel_socket_listen_async(void *ioc, void *addr, int num) "Socket listen a
>  qio_channel_socket_listen_fail(void *ioc) "Socket listen fail ioc=%p"
>  qio_channel_socket_listen_complete(void *ioc, int fd) "Socket listen complete ioc=%p fd=%d"
>  qio_channel_socket_dgram_sync(void *ioc, void *localAddr, void *remoteAddr) "Socket dgram sync ioc=%p localAddr=%p remoteAddr=%p"
> -qio_channel_socket_dgram_async(void *ioc, void *localAddr, void *remoteAddr) "Socket dgram async ioc=%p localAddr=%p remoteAddr=%p"
>  qio_channel_socket_dgram_fail(void *ioc) "Socket dgram fail ioc=%p"
>  qio_channel_socket_dgram_complete(void *ioc, int fd) "Socket dgram complete ioc=%p fd=%d"
>  qio_channel_socket_accept(void *ioc) "Socket accept start ioc=%p"
> -- 
> 2.46.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


