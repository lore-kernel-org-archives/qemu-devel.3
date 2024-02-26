Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B00C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVoJ-0007uG-WC; Mon, 26 Feb 2024 02:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reVoI-0007tr-9E
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reVoG-0007Zm-Hx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708934039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hk7dSEBryHIDCofaYXYpeWn4dS5T/dFcicxkPJYXiCg=;
 b=ZYGwfkXOtKZPayzWmfVmpqji5Bz1ghMrBJHeNM0vku+Hxht6z5b6fqLuIlPEUSdwhKZdqJ
 z+8+SmMx5dNEehJ0rT4Mozl/8wmCwt1JRs1YhasvraD6OjlS69rycjRvt9SISvSOJnK/jT
 8GajvI4VuY5rUboz74qR0nuydC8fi2g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-hdsKY_t0MSa8D9uelmCCwg-1; Mon, 26 Feb 2024 02:53:57 -0500
X-MC-Unique: hdsKY_t0MSa8D9uelmCCwg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso1310537a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934036; x=1709538836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk7dSEBryHIDCofaYXYpeWn4dS5T/dFcicxkPJYXiCg=;
 b=pkaBma6Z7nOlY0ZSZbq8QNt9wbmgfEEHckePNAnCQOXchKx0CyC734NsThgQEHhAbP
 kjlff/VhW2ibNCMCVs0mP6tetvkgkDPqPXT4asivQzKuHzaIxjBCTAnFNjXESRWevncq
 iRc7fBO5t+7ZYyvm9J7brMVWx4+q3XuDp4QtuebTyHN158wicU6qsDRZPLcMdjTHxejW
 kk93sbJKTqMvPpPmjB6kVI3h3pqFAGBJqhNW4htr/mD3XvfCkltkqkbvS5mmG6FDvE4I
 XZRihyt68gIgMRq4rxY74f6QQ0mIsyqF0TQqCpcPHMWY7n2depbVWGAookt2uliptOyw
 /SEg==
X-Gm-Message-State: AOJu0YyQsUn5nGdsZ6hZz3KFLU97j01kgmwEl8k/WSOYx5ZK1cZ9xhO2
 kLaGXmvtuAO8yJoIKA99yN7t8vtq2nY0I1nT2RRjkliofm4bqPyV0yvNYWxrWitS3/DJUXjJIPA
 YsEeWRi3VGr1DGBGp7gHI8/WfxDIQUNjLwy7TFHXpjlQCmGB4JXZ4OZ0rVFr6tj8=
X-Received: by 2002:a05:6a00:2d14:b0:6e4:fe18:9528 with SMTP id
 fa20-20020a056a002d1400b006e4fe189528mr6317715pfb.3.1708934035774; 
 Sun, 25 Feb 2024 23:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSL8tpeuDH9HwSNUyKOitxN5Chk2+9m3IAdUUuRXln7CBcHZRNzPLO6nhRx/T60Qon2MFv9g==
X-Received: by 2002:a05:6a00:2d14:b0:6e4:fe18:9528 with SMTP id
 fa20-20020a056a002d1400b006e4fe189528mr6317705pfb.3.1708934035417; 
 Sun, 25 Feb 2024 23:53:55 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t14-20020a056a0021ce00b006e04ca18c2bsm3382871pfj.196.2024.02.25.23.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 23:53:55 -0800 (PST)
Date: Mon, 26 Feb 2024 15:53:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 21/34] migration/multifd: Add incoming QIOChannelFile
 support
Message-ID: <ZdxDjLo4HuI8xC9M@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-22-farosas@suse.de> <Zdw_AuH7bO1zleN0@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zdw_AuH7bO1zleN0@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Feb 26, 2024 at 03:34:26PM +0800, Peter Xu wrote:
> On Tue, Feb 20, 2024 at 07:41:25PM -0300, Fabiano Rosas wrote:
> > On the receiving side we don't need to differentiate between main
> > channel and threads, so whichever channel is defined first gets to be
> > the main one. And since there are no packets, use the atomic channel
> > count to index into the params array.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/file.c      | 34 ++++++++++++++++++++++++++--------
> >  migration/migration.c |  3 ++-
> >  migration/multifd.c   |  3 +--
> >  3 files changed, 29 insertions(+), 11 deletions(-)
> > 
> > diff --git a/migration/file.c b/migration/file.c
> > index ac9f6ae40a..a186dc592a 100644
> > --- a/migration/file.c
> > +++ b/migration/file.c
> > @@ -8,6 +8,7 @@
> >  #include "qemu/osdep.h"
> >  #include "exec/ramblock.h"
> >  #include "qemu/cutils.h"
> > +#include "qemu/error-report.h"
> >  #include "qapi/error.h"
> >  #include "channel.h"
> >  #include "file.h"
> > @@ -15,6 +16,7 @@
> >  #include "multifd.h"
> >  #include "io/channel-file.h"
> >  #include "io/channel-util.h"
> > +#include "options.h"
> >  #include "trace.h"
> >  
> >  #define OFFSET_OPTION ",offset="
> > @@ -111,7 +113,8 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
> >      g_autofree char *filename = g_strdup(file_args->filename);
> >      QIOChannelFile *fioc = NULL;
> >      uint64_t offset = file_args->offset;
> > -    QIOChannel *ioc;
> > +    int channels = 1;
> > +    int i = 0, fd;
> >  
> >      trace_migration_file_incoming(filename);
> >  
> > @@ -120,13 +123,28 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
> >          return;
> >      }
> >  
> > -    ioc = QIO_CHANNEL(fioc);
> > -    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> > +    if (offset &&
> > +        qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
> >          return;
> >      }
> > -    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
> > -    qio_channel_add_watch_full(ioc, G_IO_IN,
> > -                               file_accept_incoming_migration,
> > -                               NULL, NULL,
> > -                               g_main_context_get_thread_default());
> > +
> > +    if (migrate_multifd()) {
> > +        channels += migrate_multifd_channels();
> > +    }
> > +
> > +    fd = fioc->fd;
> > +
> > +    do {
> > +        QIOChannel *ioc = QIO_CHANNEL(fioc);
> > +
> > +        qio_channel_set_name(ioc, "migration-file-incoming");
> > +        qio_channel_add_watch_full(ioc, G_IO_IN,
> > +                                   file_accept_incoming_migration,
> > +                                   NULL, NULL,
> > +                                   g_main_context_get_thread_default());
> > +    } while (++i < channels && (fioc = qio_channel_file_new_fd(fd)));
> 
> Note that reusing fd here has similar risk in the future that one iochannel
> can affect the other, as potentially all shares the same fd underneath; I
> think it's the same as "two qemufile v.s. one iochannel" issue that we're
> fighting recently.
> 
> IIUC the clean case is still that we open one fd for each iochannel.  Or
> e.g. as long as one iochannel close() its fd, it immediately invalidates
> all the rest iochannels on something like use-after-free of that fd index;
> any fd operates races with another fd being opened concurrently.
> 
> Maybe we can already use a loop of qio_channel_file_new_path()?  OS should
> already cached the dentry etc. so I assume the following ones should be
> super fast?  Or there's other complexities that I didn't aware?

Or simply use dup()?

> 
> > +
> > +    if (!fioc) {
> > +        error_setg(errp, "Error creating migration incoming channel");
> > +    }
> >  }
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 16da269847..e2218b9de7 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -896,7 +896,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> >      uint32_t channel_magic = 0;
> >      int ret = 0;
> >  
> > -    if (migrate_multifd() && !migrate_postcopy_ram() &&
> > +    if (migrate_multifd() && !migrate_fixed_ram() &&
> > +        !migrate_postcopy_ram() &&
> >          qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> >          /*
> >           * With multiple channels, it is possible that we receive channels
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 507b497d52..cb5f4fb3e0 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -1520,8 +1520,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
> >          }
> >          trace_multifd_recv_new_channel(id);
> >      } else {
> > -        /* next patch gives this a meaningful value */
> > -        id = 0;
> > +        id = qatomic_read(&multifd_recv_state->count);
> >      }
> >  
> >      p = &multifd_recv_state->params[id];
> > -- 
> > 2.35.3
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


