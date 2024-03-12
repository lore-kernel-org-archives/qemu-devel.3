Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27163C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk19H-0002hk-9T; Tue, 12 Mar 2024 08:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk19F-0002h8-3u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk19D-0004NG-Dw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710246142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1TrsS63/GuJdDadYK/qxP8WCJIjzco38BVY2vEHLgw=;
 b=Tpa/kwD4x+Wm2J/vFh24AhCcEfglMsr6SCHnZteY1skS9mt/k8cahIAabfVdMG14f5GgaG
 EBSfeyw48C1pFSuAeeQhCyHVwCx6UcTYL6X+U1FTfEzYYndmkoBXFjX3GgHzWs41ijGLGJ
 Qk/nm0SHDIgoyLshvpzpedKYS0ttfUw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253--m_ZTNDbO66IQH1cHHNYsA-1; Tue, 12 Mar 2024 08:22:20 -0400
X-MC-Unique: -m_ZTNDbO66IQH1cHHNYsA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78315f4f5c2so187735585a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246140; x=1710850940;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1TrsS63/GuJdDadYK/qxP8WCJIjzco38BVY2vEHLgw=;
 b=PgLv0zJuC81ExOWGt5IQCIn12z+ZVRfthYE58f4wXw6icya9L9IE9OWdMqZGQeu5Hc
 ADU1zjW0u0YRq0y/VHYiMS6ToNrBeSrKZ1YeOkZEt3n5/KJzwPiic1/0qWPy/9D23MfK
 m950wNgdrNDu2oTJ4QGrQyr20sseeldGHt2cI15yVJIXJdHK7cIp54PXGkI7evVcjSwZ
 eYXr033XkDOQhJ8sVVvEwKfVi1Od6D/zIg5O007K4svz6FrvAkUucH7yrErAbErZqO8h
 F6dPBZYmC6EuEGtchHDK0PH9H+wlIV4POYERXVdLMf/U8tZlsLFqJRaj/fVKmReeDHRb
 U95A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPaGScIPuU3glYc2xS++GF3TmFKSdE7mGC7FSP7DPlV4Tyi5AbDpCw/A3tTjz2vw9wRVSxc0ZjYw4aQSUT4+XHfqVDNsg=
X-Gm-Message-State: AOJu0YxOGIAJUv0YEmY1aHKw5i4fu8PCcE3c2hiR4ODGpdMmUVbGNTw6
 wbumgY6LNRBDvKd13lOnQKC1SQeS4ZmZXdY1gCL9gvqggsv/3b2pNdao1X0qJwUcUzFiJpk+7bT
 +hQZzpFSvI28iiybrRi7P9xWkEmXMuCRu8/2P+PYaeEioSjIOpp7i
X-Received: by 2002:a05:620a:400b:b0:788:4f31:1a9d with SMTP id
 h11-20020a05620a400b00b007884f311a9dmr1815964qko.1.1710246140228; 
 Tue, 12 Mar 2024 05:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8STbKKUwxHEoOYbHHiLFNAb0DbfBqDCnuhsmZpN7pTTiqnmtYftUUtNTSv+1kKnYiJb5BOA==
X-Received: by 2002:a05:620a:400b:b0:788:4f31:1a9d with SMTP id
 h11-20020a05620a400b00b007884f311a9dmr1815947qko.1.1710246139846; 
 Tue, 12 Mar 2024 05:22:19 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f18-20020a05620a12f200b007882915ca34sm3631627qkl.40.2024.03.12.05.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:22:19 -0700 (PDT)
Date: Tue, 12 Mar 2024 08:22:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] migration: Fix error handling after dup in file
 migration
Message-ID: <ZfBI-hPZefpW1Y1p@x1n>
References: <20240311233335.17299-1-farosas@suse.de>
 <20240311233335.17299-3-farosas@suse.de>
 <ZfAnJjka5KHR1Mnu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfAnJjka5KHR1Mnu@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Mar 12, 2024 at 09:57:58AM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 11, 2024 at 08:33:35PM -0300, Fabiano Rosas wrote:
> > The file migration code was allowing a possible -1 from a failed call
> > to dup() to propagate into the new QIOFileChannel::fd before checking
> > for validity. Coverity doesn't like that, possibly due to the the
> > lseek(-1, ...) call that would ensue before returning from the channel
> > creation routine.
> > 
> > Use the newly introduced qio_channel_file_dupfd() to properly check
> > the return of dup() before proceeding.
> > 
> > Fixes: CID 1539961
> > Fixes: CID 1539965
> > Fixes: CID 1539960
> > Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
> > Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/fd.c   |  9 ++++-----
> >  migration/file.c | 14 +++++++-------
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/migration/fd.c b/migration/fd.c
> > index d4ae72d132..4e2a63a73d 100644
> > --- a/migration/fd.c
> > +++ b/migration/fd.c
> > @@ -80,6 +80,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
> >  void fd_start_incoming_migration(const char *fdname, Error **errp)
> >  {
> >      QIOChannel *ioc;
> > +    QIOChannelFile *fioc;
> >      int fd = monitor_fd_param(monitor_cur(), fdname, errp);
> >      if (fd == -1) {
> >          return;
> > @@ -103,15 +104,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
> >          int channels = migrate_multifd_channels();
> >  
> >          while (channels--) {
> > -            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));
> > -
> > -            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
> > -                error_setg(errp, "Failed to duplicate fd %d", fd);
> > +            fioc = qio_channel_file_new_dupfd(fd, errp);
> > +            if (!fioc) {
> >                  return;
> >              }
> >  
> >              qio_channel_set_name(ioc, "migration-fd-incoming");
> > -            qio_channel_add_watch_full(ioc, G_IO_IN,
> > +            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
> >                                         fd_accept_incoming_migration,
> >                                         NULL, NULL,
> >                                         g_main_context_get_thread_default());
> 
> Nothing is free'ing the already created channels, if this while()
> loop fails on the 2nd or later iterations.
> 
> > diff --git a/migration/file.c b/migration/file.c
> > index 164b079966..d458f48269 100644
> > --- a/migration/file.c
> > +++ b/migration/file.c
> > @@ -58,12 +58,13 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
> >      int fd = fd_args_get_fd();
> >  
> >      if (fd && fd != -1) {
> > -        ioc = qio_channel_file_new_fd(dup(fd));
> > +        ioc = qio_channel_file_new_dupfd(fd, errp);
> >      } else {
> >          ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> > -        if (!ioc) {
> > -            goto out;
> > -        }
> > +    }
> > +
> > +    if (!ioc) {
> > +        goto out;
> >      }
> >  
> >      multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
> > @@ -147,10 +148,9 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
> >                                     NULL, NULL,
> >                                     g_main_context_get_thread_default());
> >  
> > -        fioc = qio_channel_file_new_fd(dup(fioc->fd));
> > +        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
> >  
> > -        if (!fioc || fioc->fd == -1) {
> > -            error_setg(errp, "Error creating migration incoming channel");
> > +        if (!fioc) {
> >              break;
> >          }
> >      } while (++i < channels);
> 
> Again, nothing is free'ing when the loops fails on 2nd or later
> iterations.

For this one, I think it constantly leak one IOC even if no failure
triggers..

> 
> So a weak
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> on the basis that it fixes the bugs that it claims to fix, but there
> are more bugs that still need fixing here.

For the other issue, Fabiano - I think there's one easy way to workaround
and avoid bothering with "how to remove a registered IO watch" is we create
the IOCs in a loop first, register the IO watches only if all succeeded.

I'll queue the series first to fix the reported issue.

Thanks,

-- 
Peter Xu


