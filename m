Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5717C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYvE-0004vX-Pd; Mon, 10 Jun 2024 02:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sGYvA-0004vA-B6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:54:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sGYv6-0002dy-4L
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:54:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a4d7ba501so5166769a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1718002456; x=1718607256; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RohwjZCcQ2VoeefkHmwjUTSRndbr6Yjwo1HKlsGwW4w=;
 b=FvvB13V/md8MKg+tfUAM54uH1BlA4vgUM2WVPWiMgPJaKAqmeNa3PLd9P1m705AmQd
 Ke784ZMJiwOO2RFoUtTaYq4xNMN+YvyTAmAgYF3ol+0lYrQIvoOcb52QBfpNqEthLTy5
 b+a8MBexZGHHRxHlbH7h66wTNOPr8TCkDX8XOxIY/MSJzF2CZ2J8j9fWeeRMbG61qYvp
 /yuQWu6OPhWjcTlEY31NQO/W6m11NF+cb5uqZkqgKj6JffHt7ykxLGKB4fd87RWvG37S
 b+inAu5/wws8Mmp+DJ6gtpUs5J2wglAtCp2LJkgUmGrzaaj0y/1x7k8Syy3Hqr0nbRDo
 RKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718002456; x=1718607256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RohwjZCcQ2VoeefkHmwjUTSRndbr6Yjwo1HKlsGwW4w=;
 b=hXoCmwTHyS5D2ukC5Y4SZMK2wqLzH9XVpkuhhnJK5SX2M5Yi/GOAndzsukwAgEoBWl
 +EUICQvBzmJm/pVYFqwcfIK43hxTIXW99hTcxsgBN+wD5J9QF91om7vcFPangnBPim5s
 c/qZBX4jJzkSGhUBJxjIvAdGM4wSHFHLlauil1iI7KXkPcMMC6m5dbcGJ8JRlGLXqK68
 qbAK8HZMUhv62ClFTOKNf6ZJ8mYaxmsfABmIVXL7Nt8Hqy3xXTsLcWblJTXTPiXOHdpk
 tb82bjDrkRYiCP4Qce4nGQSuw0tMyA4Nno4fRgsssSUrpS1IiPh4Jfcu4JhYz4qoAndN
 f0SQ==
X-Gm-Message-State: AOJu0YyQ2zAcBAW3qOKJWuV2RDuMtmAa/v9+hfGim84DN64teKrRPcOt
 2EgUebzo6tRr8ZxJClEEfBh76JA+LAPVlI1cwKZ62dpjWAX/TFz9YOPUSTfXTcfCNT58aSEhc6b
 woJQv8ilNoMutVArESMZTCRj5O+uxaNbGbT50DQ==
X-Google-Smtp-Source: AGHT+IFGEv6pjeyl9GfThLz6ywu5CzzLzbkAY6sDaL3skT4isTtxh/1eGTwksyT/4JTVIYsDwIBOLXofFAE1IfmNn9c=
X-Received: by 2002:a50:cdde:0:b0:57c:7151:2669 with SMTP id
 4fb4d7f45d1cf-57c71512b1fmr2381018a12.7.1718002455774; Sun, 09 Jun 2024
 23:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-3-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1717503252-51884-3-git-send-email-arei.gonglei@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 10 Jun 2024 08:54:03 +0200
Message-ID: <CAMGffE=a5iSvaD_Wikt+MJAKgN=i+oCsofaT5YYRtc2bgVUJVw@mail.gmail.com>
Subject: Re: [PATCH 2/6] io: add QIOChannelRDMA class
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com, 
 mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com, 
 berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com, 
 pbonzini@redhat.com, mst@redhat.com, xiexiangyou@huawei.com, 
 linux-rdma@vger.kernel.org, lixiao91@huawei.com, 
 Jialin Wang <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52a;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 4, 2024 at 2:14=E2=80=AFPM Gonglei <arei.gonglei@huawei.com> wr=
ote:
>
> From: Jialin Wang <wangjialin23@huawei.com>
>
> Implement a QIOChannelRDMA subclass that is based on the rsocket
> API (similar to socket API).
>
> Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  include/io/channel-rdma.h | 152 +++++++++++++
>  io/channel-rdma.c         | 437 ++++++++++++++++++++++++++++++++++++++
>  io/meson.build            |   1 +
>  io/trace-events           |  14 ++
>  4 files changed, 604 insertions(+)
>  create mode 100644 include/io/channel-rdma.h
>  create mode 100644 io/channel-rdma.c
>
> diff --git a/include/io/channel-rdma.h b/include/io/channel-rdma.h
> new file mode 100644
> index 0000000000..8cab2459e5
> --- /dev/null
> +++ b/include/io/channel-rdma.h
> @@ -0,0 +1,152 @@
> +/*
> + * QEMU I/O channels RDMA driver
> + *
> + * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *  Jialin Wang <wangjialin23@huawei.com>
> + *  Gonglei <arei.gonglei@huawei.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#ifndef QIO_CHANNEL_RDMA_H
> +#define QIO_CHANNEL_RDMA_H
> +
> +#include "io/channel.h"
> +#include "io/task.h"
> +#include "qemu/sockets.h"
> +#include "qom/object.h"
> +
> +#define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
> +OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelRDMA, QIO_CHANNEL_RDMA)
> +
> +/**
> + * QIOChannelRDMA:
> + *
> + * The QIOChannelRDMA object provides a channel implementation
> + * that discards all writes and returns EOF for all reads.
> + */
> +struct QIOChannelRDMA {
> +    QIOChannel parent;
> +    /* the rsocket fd */
> +    int fd;
> +
> +    struct sockaddr_storage localAddr;
> +    socklen_t localAddrLen;
> +    struct sockaddr_storage remoteAddr;
> +    socklen_t remoteAddrLen;
> +};
> +
> +/**
> + * qio_channel_rdma_new:
> + *
> + * Create a channel for performing I/O on a rdma
> + * connection, that is initially closed. After
> + * creating the rdma, it must be setup as a client
> + * connection or server.
> + *
> + * Returns: the rdma channel object
> + */
> +QIOChannelRDMA *qio_channel_rdma_new(void);
> +
> +/**
> + * qio_channel_rdma_connect_sync:
> + * @ioc: the rdma channel object
> + * @addr: the address to connect to
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Attempt to connect to the address @addr. This method
> + * will run in the foreground so the caller will not regain
> + * execution control until the connection is established or
> + * an error occurs.
> + */
> +int qio_channel_rdma_connect_sync(QIOChannelRDMA *ioc, InetSocketAddress=
 *addr,
> +                                  Error **errp);
> +
> +/**
> + * qio_channel_rdma_connect_async:
> + * @ioc: the rdma channel object
> + * @addr: the address to connect to
> + * @callback: the function to invoke on completion
> + * @opaque: user data to pass to @callback
> + * @destroy: the function to free @opaque
> + * @context: the context to run the async task. If %NULL, the default
> + *           context will be used.
> + *
> + * Attempt to connect to the address @addr. This method
> + * will run in the background so the caller will regain
> + * execution control immediately. The function @callback
> + * will be invoked on completion or failure. The @addr
> + * parameter will be copied, so may be freed as soon
> + * as this function returns without waiting for completion.
> + */
> +void qio_channel_rdma_connect_async(QIOChannelRDMA *ioc,
> +                                    InetSocketAddress *addr,
> +                                    QIOTaskFunc callback, gpointer opaqu=
e,
> +                                    GDestroyNotify destroy,
> +                                    GMainContext *context);
> +
> +/**
> + * qio_channel_rdma_listen_sync:
> + * @ioc: the rdma channel object
> + * @addr: the address to listen to
> + * @num: the expected amount of connections
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Attempt to listen to the address @addr. This method
> + * will run in the foreground so the caller will not regain
> + * execution control until the connection is established or
> + * an error occurs.
> + */
> +int qio_channel_rdma_listen_sync(QIOChannelRDMA *ioc, InetSocketAddress =
*addr,
> +                                 int num, Error **errp);
> +
> +/**
> + * qio_channel_rdma_listen_async:
> + * @ioc: the rdma channel object
> + * @addr: the address to listen to
> + * @num: the expected amount of connections
> + * @callback: the function to invoke on completion
> + * @opaque: user data to pass to @callback
> + * @destroy: the function to free @opaque
> + * @context: the context to run the async task. If %NULL, the default
> + *           context will be used.
> + *
> + * Attempt to listen to the address @addr. This method
> + * will run in the background so the caller will regain
> + * execution control immediately. The function @callback
> + * will be invoked on completion or failure. The @addr
> + * parameter will be copied, so may be freed as soon
> + * as this function returns without waiting for completion.
> + */
> +void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddres=
s *addr,
> +                                   int num, QIOTaskFunc callback,
> +                                   gpointer opaque, GDestroyNotify destr=
oy,
> +                                   GMainContext *context);
> +
> +/**
> + * qio_channel_rdma_accept:
> + * @ioc: the rdma channel object
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * If the rdma represents a server, then this accepts
> + * a new client connection. The returned channel will
> + * represent the connected client rdma.
> + *
> + * Returns: the new client channel, or NULL on error
> + */
> +QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *ioc, Error **err=
p);
> +
> +#endif /* QIO_CHANNEL_RDMA_H */
> diff --git a/io/channel-rdma.c b/io/channel-rdma.c
> new file mode 100644
> index 0000000000..92c362df52
> --- /dev/null
> +++ b/io/channel-rdma.c
> @@ -0,0 +1,437 @@
> +/*
> + * QEMU I/O channels RDMA driver
> + *
> + * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *  Jialin Wang <wangjialin23@huawei.com>
> + *  Gonglei <arei.gonglei@huawei.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "io/channel-rdma.h"
> +#include "io/channel.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-sockets.h"
> +#include "trace.h"
> +#include <errno.h>
> +#include <netdb.h>
> +#include <rdma/rsocket.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/eventfd.h>
> +#include <sys/poll.h>
> +#include <unistd.h>
> +
> +QIOChannelRDMA *qio_channel_rdma_new(void)
> +{
> +    QIOChannelRDMA *rioc;
> +    QIOChannel *ioc;
> +
> +    rioc =3D QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
> +    ioc =3D QIO_CHANNEL(rioc);
> +    qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> +
> +    trace_qio_channel_rdma_new(ioc);
> +
> +    return rioc;
> +}
> +
> +static int qio_channel_rdma_set_fd(QIOChannelRDMA *rioc, int fd, Error *=
*errp)
> +{
> +    if (rioc->fd !=3D -1) {
> +        error_setg(errp, "Socket is already open");
> +        return -1;
> +    }
> +
> +    rioc->fd =3D fd;
> +    rioc->remoteAddrLen =3D sizeof(rioc->remoteAddr);
> +    rioc->localAddrLen =3D sizeof(rioc->localAddr);
> +
> +    if (rgetpeername(fd, (struct sockaddr *)&rioc->remoteAddr,
> +                     &rioc->remoteAddrLen) < 0) {
> +        if (errno =3D=3D ENOTCONN) {
> +            memset(&rioc->remoteAddr, 0, sizeof(rioc->remoteAddr));
> +            rioc->remoteAddrLen =3D sizeof(rioc->remoteAddr);
> +        } else {
> +            error_setg_errno(errp, errno,
> +                             "Unable to query remote rsocket address");
> +            goto error;
> +        }
> +    }
> +
> +    if (rgetsockname(fd, (struct sockaddr *)&rioc->localAddr,
> +                     &rioc->localAddrLen) < 0) {
> +        error_setg_errno(errp, errno, "Unable to query local rsocket add=
ress");
> +        goto error;
> +    }
> +
> +    return 0;
> +
> +error:
> +    rioc->fd =3D -1; /* Let the caller close FD on failure */
> +    return -1;
> +}
> +
> +int qio_channel_rdma_connect_sync(QIOChannelRDMA *rioc, InetSocketAddres=
s *addr,
> +                                  Error **errp)
> +{
> +    int ret, fd =3D -1;
> +    struct rdma_addrinfo *ai;
> +
> +    trace_qio_channel_rdma_connect_sync(rioc, addr);
> +    ret =3D rdma_getaddrinfo(addr->host, addr->port, NULL, &ai);
> +    if (ret) {
> +        error_setg(errp, "Failed to rdma_getaddrinfo: %s", gai_strerror(=
ret));
> +        goto out;
> +    }
> +
> +    fd =3D rsocket(ai->ai_family, SOCK_STREAM, 0);
> +    if (fd < 0) {
> +        error_setg_errno(errp, errno, "Failed to create rsocket");
> +        goto out;
> +    }
> +    qemu_set_cloexec(fd);
> +
> +retry:
> +    ret =3D rconnect(fd, ai->ai_dst_addr, ai->ai_dst_len);
> +    if (ret) {
> +        if (errno =3D=3D EINTR) {
> +            goto retry;
> +        }
> +        error_setg_errno(errp, errno, "Failed to rconnect");
> +        goto out;
> +    }
> +
> +    trace_qio_channel_rdma_connect_complete(rioc, fd);
> +    ret =3D qio_channel_rdma_set_fd(rioc, fd, errp);
> +    if (ret) {
> +        goto out;
> +    }
> +
> +out:
> +    if (ret) {
> +        trace_qio_channel_rdma_connect_fail(rioc);
> +        if (fd >=3D 0) {
> +            rclose(fd);
> +        }
> +    }
> +    if (ai) {
> +        rdma_freeaddrinfo(ai);
> +    }
> +
> +    return ret;
> +}
> +
> +static void qio_channel_rdma_connect_worker(QIOTask *task, gpointer opaq=
ue)
> +{
> +    QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(qio_task_get_source(task));
> +    InetSocketAddress *addr =3D opaque;
> +    Error *err =3D NULL;
> +
> +    qio_channel_rdma_connect_sync(ioc, addr, &err);
> +
> +    qio_task_set_error(task, err);
> +}
> +
> +void qio_channel_rdma_connect_async(QIOChannelRDMA *ioc,
> +                                    InetSocketAddress *addr,
> +                                    QIOTaskFunc callback, gpointer opaqu=
e,
> +                                    GDestroyNotify destroy,
> +                                    GMainContext *context)
> +{
> +    QIOTask *task =3D qio_task_new(OBJECT(ioc), callback, opaque, destro=
y);
> +    InetSocketAddress *addrCopy;
> +
> +    addrCopy =3D QAPI_CLONE(InetSocketAddress, addr);
> +
> +    /* rdma_getaddrinfo() blocks in DNS lookups, so we must use a thread=
 */
> +    trace_qio_channel_rdma_connect_async(ioc, addr);
> +    qio_task_run_in_thread(task, qio_channel_rdma_connect_worker, addrCo=
py,
> +                           (GDestroyNotify)qapi_free_InetSocketAddress,
> +                           context);
> +}
> +
> +int qio_channel_rdma_listen_sync(QIOChannelRDMA *rioc, InetSocketAddress=
 *addr,
> +                                 int num, Error **errp)
> +{
> +    int ret, fd =3D -1;
> +    struct rdma_addrinfo *ai;
> +    struct rdma_addrinfo ai_hints =3D { 0 };
> +
> +    trace_qio_channel_rdma_listen_sync(rioc, addr, num);
> +    ai_hints.ai_port_space =3D RDMA_PS_TCP;
> +    ai_hints.ai_flags |=3D RAI_PASSIVE;
> +    ret =3D rdma_getaddrinfo(addr->host, addr->port, &ai_hints, &ai);
> +    if (ret) {
> +        error_setg(errp, "Failed to rdma_getaddrinfo: %s", gai_strerror(=
ret));
> +        goto out;
> +    }
> +
> +    fd =3D rsocket(ai->ai_family, SOCK_STREAM, 0);
> +    if (fd < 0) {
> +        error_setg_errno(errp, errno, "Failed to create rsocket");
> +        goto out;
> +    }
> +    qemu_set_cloexec(fd);
> +
> +    ret =3D rbind(fd, ai->ai_src_addr, ai->ai_src_len);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to rbind");
> +        goto out;
> +    }
> +
> +    ret =3D rlisten(fd, num);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to rlisten");
> +        goto out;
> +    }
> +
> +    ret =3D qio_channel_rdma_set_fd(rioc, fd, errp);
> +    if (ret) {
> +        goto out;
> +    }
> +
> +    qio_channel_set_feature(QIO_CHANNEL(rioc), QIO_CHANNEL_FEATURE_LISTE=
N);
> +    trace_qio_channel_rdma_listen_complete(rioc, fd);
> +
> +out:
> +    if (ret) {
> +        trace_qio_channel_rdma_listen_fail(rioc);
> +        if (fd >=3D 0) {
> +            rclose(fd);
> +        }
> +    }
> +    if (ai) {
> +        rdma_freeaddrinfo(ai);
> +    }
> +
> +    return ret;
> +}
> +
> +struct QIOChannelListenWorkerData {
> +    InetSocketAddress *addr;
> +    int num; /* amount of expected connections */
> +};
> +
> +static void qio_channel_listen_worker_free(gpointer opaque)
> +{
> +    struct QIOChannelListenWorkerData *data =3D opaque;
> +
> +    qapi_free_InetSocketAddress(data->addr);
> +    g_free(data);
> +}
> +
> +static void qio_channel_rdma_listen_worker(QIOTask *task, gpointer opaqu=
e)
> +{
> +    QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(qio_task_get_source(task));
> +    struct QIOChannelListenWorkerData *data =3D opaque;
> +    Error *err =3D NULL;
> +
> +    qio_channel_rdma_listen_sync(ioc, data->addr, data->num, &err);
> +
> +    qio_task_set_error(task, err);
> +}
> +
> +void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddres=
s *addr,
> +                                   int num, QIOTaskFunc callback,
> +                                   gpointer opaque, GDestroyNotify destr=
oy,
> +                                   GMainContext *context)
> +{
> +    QIOTask *task =3D qio_task_new(OBJECT(ioc), callback, opaque, destro=
y);
> +    struct QIOChannelListenWorkerData *data;
> +
> +    data =3D g_new0(struct QIOChannelListenWorkerData, 1);
> +    data->addr =3D QAPI_CLONE(InetSocketAddress, addr);
> +    data->num =3D num;
> +
> +    /* rdma_getaddrinfo() blocks in DNS lookups, so we must use a thread=
 */
> +    trace_qio_channel_rdma_listen_async(ioc, addr, num);
> +    qio_task_run_in_thread(task, qio_channel_rdma_listen_worker, data,
> +                           qio_channel_listen_worker_free, context);
> +}
> +
> +QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *rioc, Error **er=
rp)
> +{
> +    QIOChannelRDMA *cioc;
> +
> +    cioc =3D qio_channel_rdma_new();
> +    cioc->remoteAddrLen =3D sizeof(rioc->remoteAddr);
> +    cioc->localAddrLen =3D sizeof(rioc->localAddr);
> +
> +    trace_qio_channel_rdma_accept(rioc);
> +retry:
> +    cioc->fd =3D raccept(rioc->fd, (struct sockaddr *)&cioc->remoteAddr,
> +                       &cioc->remoteAddrLen);
> +    if (cioc->fd < 0) {
> +        if (errno =3D=3D EINTR) {
> +            goto retry;
> +        }
> +        error_setg_errno(errp, errno, "Unable to accept connection");
> +        goto error;
> +    }
> +    qemu_set_cloexec(cioc->fd);
> +
> +    if (rgetsockname(cioc->fd, (struct sockaddr *)&cioc->localAddr,
> +                     &cioc->localAddrLen) < 0) {
> +        error_setg_errno(errp, errno, "Unable to query local rsocket add=
ress");
> +        goto error;
> +    }
> +
> +    trace_qio_channel_rdma_accept_complete(rioc, cioc, cioc->fd);
> +    return cioc;
> +
> +error:
> +    trace_qio_channel_rdma_accept_fail(rioc);
> +    object_unref(OBJECT(cioc));
> +    return NULL;
> +}
> +
> +static void qio_channel_rdma_init(Object *obj)
> +{
> +    QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(obj);
> +    ioc->fd =3D -1;
> +}
> +
> +static void qio_channel_rdma_finalize(Object *obj)
> +{
> +    QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(obj);
> +
> +    if (ioc->fd !=3D -1) {
> +        rclose(ioc->fd);
> +        ioc->fd =3D -1;
> +    }
> +}
> +
> +static ssize_t qio_channel_rdma_readv(QIOChannel *ioc, const struct iove=
c *iov,
> +                                      size_t niov, int **fds G_GNUC_UNUS=
ED,
> +                                      size_t *nfds G_GNUC_UNUSED,
> +                                      int flags G_GNUC_UNUSED, Error **e=
rrp)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +    ssize_t ret;
> +
> +retry:
> +    ret =3D rreadv(rioc->fd, iov, niov);
> +    if (ret < 0) {
> +        if (errno =3D=3D EINTR) {
> +            goto retry;
> +        }
> +        error_setg_errno(errp, errno, "Unable to write to rsocket");
This is a typo. s/write/read.
> +        return -1;
> +    }
> +
> +    return ret;
> +}
> +
> +static ssize_t qio_channel_rdma_writev(QIOChannel *ioc, const struct iov=
ec *iov,
> +                                       size_t niov, int *fds G_GNUC_UNUS=
ED,
> +                                       size_t nfds G_GNUC_UNUSED,
> +                                       int flags G_GNUC_UNUSED, Error **=
errp)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +    ssize_t ret;
> +
> +retry:
> +    ret =3D rwritev(rioc->fd, iov, niov);
> +    if (ret <=3D 0) {
> +        if (errno =3D=3D EINTR) {
> +            goto retry;
> +        }
> +        error_setg_errno(errp, errno, "Unable to write to rsocket");
> +        return -1;
> +    }
> +
> +    return ret;
> +}
> +
> +static void qio_channel_rdma_set_delay(QIOChannel *ioc, bool enabled)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +    int v =3D enabled ? 0 : 1;
> +
> +    rsetsockopt(rioc->fd, IPPROTO_TCP, TCP_NODELAY, &v, sizeof(v));
> +}
> +
> +static int qio_channel_rdma_close(QIOChannel *ioc, Error **errp)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +
> +    if (rioc->fd !=3D -1) {
> +        rclose(rioc->fd);
> +        rioc->fd =3D -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int qio_channel_rdma_shutdown(QIOChannel *ioc, QIOChannelShutdown=
 how,
> +                                     Error **errp)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +    int sockhow;
> +
> +    switch (how) {
> +    case QIO_CHANNEL_SHUTDOWN_READ:
> +        sockhow =3D SHUT_RD;
> +        break;
> +    case QIO_CHANNEL_SHUTDOWN_WRITE:
> +        sockhow =3D SHUT_WR;
> +        break;
> +    case QIO_CHANNEL_SHUTDOWN_BOTH:
> +    default:
> +        sockhow =3D SHUT_RDWR;
> +        break;
> +    }
> +
> +    if (rshutdown(rioc->fd, sockhow) < 0) {
> +        error_setg_errno(errp, errno, "Unable to shutdown rsocket");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void qio_channel_rdma_class_init(ObjectClass *klass,
> +                                        void *class_data G_GNUC_UNUSED)
> +{
> +    QIOChannelClass *ioc_klass =3D QIO_CHANNEL_CLASS(klass);
> +
> +    ioc_klass->io_writev =3D qio_channel_rdma_writev;
> +    ioc_klass->io_readv =3D qio_channel_rdma_readv;
> +    ioc_klass->io_close =3D qio_channel_rdma_close;
> +    ioc_klass->io_shutdown =3D qio_channel_rdma_shutdown;
> +    ioc_klass->io_set_delay =3D qio_channel_rdma_set_delay;
> +}
> +
> +static const TypeInfo qio_channel_rdma_info =3D {
> +    .parent =3D TYPE_QIO_CHANNEL,
> +    .name =3D TYPE_QIO_CHANNEL_RDMA,
> +    .instance_size =3D sizeof(QIOChannelRDMA),
> +    .instance_init =3D qio_channel_rdma_init,
> +    .instance_finalize =3D qio_channel_rdma_finalize,
> +    .class_init =3D qio_channel_rdma_class_init,
> +};
> +
> +static void qio_channel_rdma_register_types(void)
> +{
> +    type_register_static(&qio_channel_rdma_info);
> +}
> +
> +type_init(qio_channel_rdma_register_types);
> diff --git a/io/meson.build b/io/meson.build
> index 283b9b2bdb..e0dbd5183f 100644
> --- a/io/meson.build
> +++ b/io/meson.build
> @@ -14,3 +14,4 @@ io_ss.add(files(
>    'net-listener.c',
>    'task.c',
>  ), gnutls)
> +io_ss.add(when: rdma, if_true: files('channel-rdma.c'))
> diff --git a/io/trace-events b/io/trace-events
> index d4c0f84a9a..33026a2224 100644
> --- a/io/trace-events
> +++ b/io/trace-events
> @@ -67,3 +67,17 @@ qio_channel_command_new_pid(void *ioc, int writefd, in=
t readfd, int pid) "Comman
>  qio_channel_command_new_spawn(void *ioc, const char *binary, int flags) =
"Command new spawn ioc=3D%p binary=3D%s flags=3D%d"
>  qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=3D%p pi=
d=3D%d"
>  qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Comma=
nd abort ioc=3D%p pid=3D%d ret=3D%d status=3D%d"
> +
> +# channel-rdma.c
> +qio_channel_rdma_new(void *ioc) "RDMA rsocket new ioc=3D%p"
> +qio_channel_rdma_connect_sync(void *ioc, void *addr) "RDMA rsocket conne=
ct sync ioc=3D%p addr=3D%p"
> +qio_channel_rdma_connect_async(void *ioc, void *addr) "RDMA rsocket conn=
ect async ioc=3D%p addr=3D%p"
> +qio_channel_rdma_connect_fail(void *ioc) "RDMA rsocket connect fail ioc=
=3D%p"
> +qio_channel_rdma_connect_complete(void *ioc, int fd) "RDMA rsocket conne=
ct complete ioc=3D%p fd=3D%d"
> +qio_channel_rdma_listen_sync(void *ioc, void *addr, int num) "RDMA rsock=
et listen sync ioc=3D%p addr=3D%p num=3D%d"
> +qio_channel_rdma_listen_fail(void *ioc) "RDMA rsocket listen fail ioc=3D=
%p"
> +qio_channel_rdma_listen_async(void *ioc, void *addr, int num) "RDMA rsoc=
ket listen async ioc=3D%p addr=3D%p num=3D%d"
> +qio_channel_rdma_listen_complete(void *ioc, int fd) "RDMA rsocket listen=
 complete ioc=3D%p fd=3D%d"
> +qio_channel_rdma_accept(void *ioc) "Socket accept start ioc=3D%p"
> +qio_channel_rdma_accept_fail(void *ioc) "RDMA rsocket accept fail ioc=3D=
%p"
> +qio_channel_rdma_accept_complete(void *ioc, void *cioc, int fd) "RDMA rs=
ocket accept complete ioc=3D%p cioc=3D%p fd=3D%d"
> --
> 2.43.0
>

