Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B38C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJTP-0006in-I7; Mon, 18 Mar 2024 16:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmJTK-0006ee-2q
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:20:41 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmJTD-0000kz-I7
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:20:35 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-430ccb3d65eso10442791cf.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710793230; x=1711398030; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWaOEUQtX0eUqbn2wjO3PWIXcfVldvSXSDCM5unRgyg=;
 b=mVKvIVE4XNWQSuwt9VQQ/WFqoTW7/lUZFjTxa7FoQguCKMZ8cdGeh6MRD89dwwmOkQ
 fBW3+oYzLsPYReymG8jO2SXUNLd3L/yNHCB4MShENL1/A8gzwbqQ/gbgYSRISv8cKx9p
 U79p+bOBIhE+ibRdA3OZsvN6xiN6UdeaZZiJKHpCJoMd7/5yw9jA8A8cJc0aGpKZSHnq
 wRqjcacrET666d3YeQA9qMowYweIBf/qV+l1CKuqSKhuPS2MfmlsG/ysInyt/Tqc8UdM
 bsqPT7qA2SA1YNb8PQuCwS8x9vwJSVaUcX54D5Bf0CxeF2hMBiO+kVdNbZrNAa9U4dEq
 MeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710793230; x=1711398030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWaOEUQtX0eUqbn2wjO3PWIXcfVldvSXSDCM5unRgyg=;
 b=r1j1j+2VnV6pgOpqQHslWSq0hLHpw6uXxJy8qkt4Y7vJmqafELBJWdkfrcm8+drzHG
 N3K87A3BARdby9XxxPKkfGUallt/byEZqBa1bdwtjRXbOlEK0xNRQCCcGNfSikNkDsmG
 27kEpkCz+f71Ho7INymz/HLyX7uEx899H+VKvE5uXkKsobMuOezzHdJTQ+zuIcZLehsA
 F2cUoM1iJeglZcENTY/nL/yxhQc0RpZPJcN35fLZScz1EmJJXDGO0MwAfYjflbwOVrEq
 9QOTQmztCxeqAELz56U9pYEEOlzHjLHwpf6O/bkVx2PGiYmLG5o8vkNHh96XEt/84o0o
 DVfA==
X-Gm-Message-State: AOJu0YzzNaLKMdzrRaXvdZRq5xHSvPAhUqeUvleGEGXQloNWMRr6DfeZ
 6mdUrMPC/lrf6qUYb9AimLg/CmagxWPZuwIJnlL6Ew/z8RDupGZnnnBrB/Hi/jsZKFt/NYZJ7fR
 qyANjFFJzEh8a8IuC2q/XZmNrpoI=
X-Google-Smtp-Source: AGHT+IESf9y0QNBYg8rUR7eC/pHwVn0vGBpZzLiMe+QyF4ceUt0NjGzKi63WwFM3yBxUw4KC1Rry0IBwu8ZzIjfo8Fg=
X-Received: by 2002:a05:622a:11c2:b0:430:e567:ee0a with SMTP id
 n2-20020a05622a11c200b00430e567ee0amr364052qtk.68.1710793230325; Mon, 18 Mar
 2024 13:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240318182330.96738-1-berrange@redhat.com>
 <20240318182330.96738-4-berrange@redhat.com>
In-Reply-To: <20240318182330.96738-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Mar 2024 00:20:18 +0400
Message-ID: <CAJ+F1CLgjRuzBFeBneDmy0j_ZObhYc+xxueyA8k7RHYd+wckeg@mail.gmail.com>
Subject: Re: [PATCH 3/3 for 9.0] Revert "chardev: use a child source for qio
 input source"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Mon, Mar 18, 2024 at 10:25=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> This reverts commit a7077b8e354d90fec26c2921aa2dea85b90dff90,
> and add comments to explain why child sources cannot be used.
>
> When a GSource is added as a child of another GSource, if its
> 'prepare' function indicates readiness, then the parent's
> 'prepare' function will never be run. The io_watch_poll_prepare
> absolutely *must* be run on every iteration of the main loop,
> to ensure that the chardev backend doesn't feed data to the
> frontend that it is unable to consume.
>
> At the time a7077b8e354d90fec26c2921aa2dea85b90dff90 was made,
> all the child GSource impls were relying on poll'ing an FD,
> so their 'prepare' functions would never indicate readiness
> ahead of poll() being invoked. So the buggy behaviour was
> not noticed and lay dormant.
>
> Relatively recently the QIOChannelTLS impl introduced a
> level 2 child GSource, which checks with GNUTLS whether it
> has cached any data that was decoded but not yet consumed:
>
>   commit ffda5db65aef42266a5053a4be34515106c4c7ee
>   Author: Antoine Damhet <antoine.damhet@shadow.tech>
>   Date:   Tue Nov 15 15:23:29 2022 +0100
>
>     io/channel-tls: fix handling of bigger read buffers
>
>     Since the TLS backend can read more data from the underlying QIOChann=
el
>     we introduce a minimal child GSource to notify if we still have more
>     data available to be read.
>
>     Signed-off-by: Antoine Damhet <antoine.damhet@shadow.tech>
>     Signed-off-by: Charles Frey <charles.frey@shadow.tech>
>     Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> With this, it is now quite common for the 'prepare' function
> on a QIOChannelTLS GSource to indicate immediate readiness,
> bypassing the parent GSource 'prepare' function. IOW, the
> critical 'io_watch_poll_prepare' is being skipped on some
> iterations of the main loop. As a result chardev frontend
> asserts are now being triggered as they are fed data they
> are not ready to consume.
>
> A reproducer is as follows:
>
>  * In terminal 1 run a GNUTLS *echo* server
>
>    $ gnutls-serv --echo \
>                  --x509cafile ca-cert.pem \
>                  --x509keyfile server-key.pem \
>                  --x509certfile server-cert.pem \
>                  -p 9000
>
>  * In terminal 2 run a QEMU guest
>
>    $ qemu-system-s390x \
>        -nodefaults \
>        -display none \
>        -object tls-creds-x509,id=3Dtls0,dir=3D$PWD,endpoint=3Dclient \
>        -chardev socket,id=3Dcon0,host=3Dlocalhost,port=3D9000,tls-creds=
=3Dtls0 \
>        -device sclpconsole,chardev=3Dcon0 \
>        -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2
>
> After the previous patch revert, but before this patch revert,
> this scenario will crash:
>
>   qemu-system-s390x: ../hw/char/sclpconsole.c:73: chr_read: Assertion
>   `size <=3D SIZE_BUFFER_VT220 - scon->iov_data_len' failed.
>
> This assert indicates that 'tcp_chr_read' was called without
> 'tcp_chr_read_poll' having first been checked for ability to
> receive more data
>
> QEMU's use of a 'prepare' function to create/delete another
> GSource is rather a hack and not normally the kind of thing that
> is expected to be done by a GSource. There is no mechanism to
> force GLib to always run the 'prepare' function of a parent
> GSource. The best option is to simply not use the child source
> concept, and go back to the functional approach previously
> relied on.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-io.c | 55 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 5 deletions(-)
>
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index 4451128cba..3c725f530b 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -33,6 +33,7 @@ typedef struct IOWatchPoll {
>      IOCanReadHandler *fd_can_read;
>      GSourceFunc fd_read;
>      void *opaque;
> +    GMainContext *context;
>  } IOWatchPoll;
>
>  static IOWatchPoll *io_watch_poll_from_source(GSource *source)
> @@ -50,28 +51,58 @@ static gboolean io_watch_poll_prepare(GSource *source=
,
>          return FALSE;
>      }
>
> +    /*
> +     * We do not register the QIOChannel watch as a child GSource.
> +     * The 'prepare' function on the parent GSource will be
> +     * skipped if a child GSource's 'prepare' function indicates
> +     * readiness. We need this prepare function be guaranteed

argh, indeed

I suppose the child 'prepare' could be changed to always return FALSE,
but that would be hackish too

> +     * to run on *every* iteration of the main loop, because
> +     * it is critical to ensure we remove the QIOChannel watch
> +     * if 'fd_can_read' indicates the frontend cannot receive
> +     * more data.
> +     */
>      if (now_active) {
>          iwp->src =3D qio_channel_create_watch(
>              iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
>          g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL)=
;
> -        g_source_add_child_source(source, iwp->src);
> -        g_source_unref(iwp->src);
> +        g_source_attach(iwp->src, iwp->context);
>      } else {
> -        g_source_remove_child_source(source, iwp->src);
> +        g_source_destroy(iwp->src);
> +        g_source_unref(iwp->src);
>          iwp->src =3D NULL;
>      }
>      return FALSE;
>  }
>
> +static gboolean io_watch_poll_check(GSource *source)
> +{
> +    return FALSE;
> +}
> +
>  static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc call=
back,
>                                         gpointer user_data)
>  {
> -    return G_SOURCE_CONTINUE;
> +    abort();
> +}
> +
> +static void io_watch_poll_finalize(GSource *source)
> +{
> +    /* Due to a glib bug, removing the last reference to a source
> +     * inside a finalize callback causes recursive locking (and a
> +     * deadlock).  This is not a problem inside other callbacks,
> +     * including dispatch callbacks, so we call io_remove_watch_poll
> +     * to remove this source.  At this point, iwp->src must
> +     * be NULL, or we would leak it.
> +     */
> +    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
> +    assert(iwp->src =3D=3D NULL);
>  }
>
>  static GSourceFuncs io_watch_poll_funcs =3D {
>      .prepare =3D io_watch_poll_prepare,
> +    .check =3D io_watch_poll_check,
>      .dispatch =3D io_watch_poll_dispatch,
> +    .finalize =3D io_watch_poll_finalize,
>  };
>
>  GSource *io_add_watch_poll(Chardev *chr,
> @@ -91,6 +122,7 @@ GSource *io_add_watch_poll(Chardev *chr,
>      iwp->ioc =3D ioc;
>      iwp->fd_read =3D (GSourceFunc) fd_read;
>      iwp->src =3D NULL;
> +    iwp->context =3D context;
>
>      name =3D g_strdup_printf("chardev-iowatch-%s", chr->label);
>      g_source_set_name((GSource *)iwp, name);
> @@ -101,10 +133,23 @@ GSource *io_add_watch_poll(Chardev *chr,
>      return (GSource *)iwp;
>  }
>
> +static void io_remove_watch_poll(GSource *source)
> +{
> +    IOWatchPoll *iwp;
> +
> +    iwp =3D io_watch_poll_from_source(source);
> +    if (iwp->src) {
> +        g_source_destroy(iwp->src);
> +        g_source_unref(iwp->src);
> +        iwp->src =3D NULL;
> +    }
> +    g_source_destroy(&iwp->parent);
> +}
> +
>  void remove_fd_in_watch(Chardev *chr)
>  {
>      if (chr->gsource) {
> -        g_source_destroy(chr->gsource);
> +        io_remove_watch_poll(chr->gsource);
>          chr->gsource =3D NULL;
>      }
>  }
> --
> 2.43.0
>
>



Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

