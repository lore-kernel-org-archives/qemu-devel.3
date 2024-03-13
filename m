Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B000C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQ1F-0006ye-J7; Wed, 13 Mar 2024 10:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkQ1D-0006yV-1V
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkQ1A-0002hP-Ql
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710341743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYC1WH+kdjnHqoL/LI/qrpooZJ0VEh1SEDJpnyAIG2U=;
 b=WDbvvFukQPjDuqY9ZmFpYoqudUiTvkZLFg6MqE4kD+gazmA+6KSacizKfEju7Gr9YiZ4yp
 117c7lBBNxdL3aRIWfTfDkIuGHCVZEnyY3o+6ieUvo+TqL+2kFKpnfB7Hh+7Mk4oAuD/np
 3UfL8ghWJ6oUZ+TAd3riaY6JFw5fwgU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-opN7LhqiPKW5_07VxntdyQ-1; Wed, 13 Mar 2024 10:55:41 -0400
X-MC-Unique: opN7LhqiPKW5_07VxntdyQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69120b349c9so1700506d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 07:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710341741; x=1710946541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYC1WH+kdjnHqoL/LI/qrpooZJ0VEh1SEDJpnyAIG2U=;
 b=YEijQMSjiSrF1Xp7/NhgB2Z3bavp35mn4jDzTnweKDzBlzApzguaRhzH90oWHrR2f8
 AQSNcvoomHUM7Wuj8cQ5Cr/MB+tYh75HMUM/H/5s742P8xeu8bqnUVSUy6gEM079C0p+
 +qvdRURfXPjNVQWeay0+nslYtjeYhI2J/IAwfGq05G64m0wxCjZGweNSRLky7U35AGPA
 MiZsG9xzFKAlYfJA70t0/bwymqRurYA/YpYa0uT4iqDW2cn1lDNvJU6SVzTtwlbfX5ch
 QLDoI+w65k+4M6qerCEIURs47yELMM07K0qm4E2pTbQMfD6Foq7dsSX/WJRVjVd5Ny6s
 4Jjw==
X-Gm-Message-State: AOJu0YxChZPLpMPD4voETgERnyZrbEfhEv3BgjyEzdWBOpx9kKJpUwLL
 ERVIGiMT1EsA3CRbmlyJJqFhR3pmio5c5GaNU4Csme8hf4FmF612ps3mxtiE2OpUMWSOtZZsB1Q
 n1D0GFGzZQAqiX9sMRv4qXquk0uJKRHmFEmj4IJb7DCF0gNYYECUK
X-Received: by 2002:ad4:5a46:0:b0:690:d848:5223 with SMTP id
 ej6-20020ad45a46000000b00690d8485223mr4797568qvb.1.1710341741315; 
 Wed, 13 Mar 2024 07:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNINP8YByk1Yyqn40M8W1jnSuWJfc0bkXH8YEzcSeNFHUP/RyOQDWCC40y1GYM24jRbgaKbw==
X-Received: by 2002:ad4:5a46:0:b0:690:d848:5223 with SMTP id
 ej6-20020ad45a46000000b00690d8485223mr4797551qvb.1.1710341740822; 
 Wed, 13 Mar 2024 07:55:40 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 l4-20020a0cd6c4000000b00690dd47a41csm2313625qvi.86.2024.03.13.07.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 07:55:40 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:55:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH] migration: Fix iocs leaks during file and fd migration
Message-ID: <ZfG-apnNAky0e5yw@x1n>
References: <20240313135018.28079-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313135018.28079-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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

On Wed, Mar 13, 2024 at 10:50:18AM -0300, Fabiano Rosas wrote:
> The memory for the io channels is being leaked in three different ways
> during file migration:
> 
> 1) if the offset check fails we never drop the ioc reference;
> 
> 2) if multifd is not enabled, we allocate an extra channel for no
>    reason;

This leak should also happen even if multifd enabled; it just always leak
one unconditionally..

> 
> 3) if multifd is enabled but channel creation fails when calling
>    dup(), we leave the previous channels around along with the glib
>    polling;
> 
> Fix all issues by restructuring the code to first allocate the
> channels and only register the watches when all channels have been
> created.
> 
> The file and fd migrations can share this code because both are backed
> by the file migration infrastructure.
> 
> Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
> Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> based-on: https://gitlab.com/peterx/migration-stable

Invalid link. :)

I am not sure whether patchew will understand this even if the link is
correct, but I hope!

> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1211909831
> ---
>  migration/fd.c   | 28 +++-------------------
>  migration/file.c | 62 +++++++++++++++++++++++++++++++-----------------
>  migration/file.h |  3 +++
>  3 files changed, 46 insertions(+), 47 deletions(-)
> 
> diff --git a/migration/fd.c b/migration/fd.c
> index 4e2a63a73d..b74a3eb8c8 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -18,6 +18,7 @@
>  #include "qapi/error.h"
>  #include "channel.h"
>  #include "fd.h"
> +#include "file.h"
>  #include "migration.h"
>  #include "monitor/monitor.h"
>  #include "io/channel-file.h"
> @@ -68,19 +69,9 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      object_unref(OBJECT(ioc));
>  }
>  
> -static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
> -                                             GIOCondition condition,
> -                                             gpointer opaque)
> -{
> -    migration_channel_process_incoming(ioc);
> -    object_unref(OBJECT(ioc));
> -    return G_SOURCE_REMOVE;
> -}
> -
>  void fd_start_incoming_migration(const char *fdname, Error **errp)
>  {
>      QIOChannel *ioc;
> -    QIOChannelFile *fioc;
>      int fd = monitor_fd_param(monitor_cur(), fdname, errp);
>      if (fd == -1) {
>          return;
> @@ -96,24 +87,11 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>  
>      qio_channel_set_name(ioc, "migration-fd-incoming");
>      qio_channel_add_watch_full(ioc, G_IO_IN,
> -                               fd_accept_incoming_migration,
> +                               file_accept_incoming_migration,
>                                 NULL, NULL,
>                                 g_main_context_get_thread_default());

Mostly correct, but IIUC we'll still leak this main io watch if below
failed, similar issue for file path below.  We may need to manage all IOCs
including the main one.

>  
>      if (migrate_multifd()) {
> -        int channels = migrate_multifd_channels();
> -
> -        while (channels--) {
> -            fioc = qio_channel_file_new_dupfd(fd, errp);
> -            if (!fioc) {
> -                return;
> -            }
> -
> -            qio_channel_set_name(ioc, "migration-fd-incoming");
> -            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
> -                                       fd_accept_incoming_migration,
> -                                       NULL, NULL,
> -                                       g_main_context_get_thread_default());
> -        }
> +        file_recv_channels_create(fd, errp);
>      }
>  }
> diff --git a/migration/file.c b/migration/file.c
> index e56c5eb0a5..bb264115eb 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -106,22 +106,48 @@ void file_start_outgoing_migration(MigrationState *s,
>      migration_channel_connect(s, ioc, NULL, NULL);
>  }
>  
> -static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> -                                               GIOCondition condition,
> -                                               gpointer opaque)
> +gboolean file_accept_incoming_migration(QIOChannel *ioc, GIOCondition condition,
> +                                        gpointer opaque)
>  {
>      migration_channel_process_incoming(ioc);
>      object_unref(OBJECT(ioc));
>      return G_SOURCE_REMOVE;
>  }
>  
> +void file_recv_channels_create(int fd, Error **errp)
> +{
> +    int i, channels = migrate_multifd_channels();
> +    g_autofree QIOChannelFile **fiocs = g_new0(QIOChannelFile *, channels);
> +
> +    for (i = 0; i < channels; i++) {
> +        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
> +
> +        if (!fioc) {
> +            while (i) {
> +                object_unref(fiocs[--i]);
> +            }
> +            return;
> +        }
> +
> +        fiocs[i] = fioc;
> +    }
> +
> +    for (i = 0; i < channels; i++) {
> +        QIOChannelFile *fioc = fiocs[i];
> +
> +        qio_channel_set_name(QIO_CHANNEL(fioc), "migration-file-incoming");
> +        qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
> +                                   file_accept_incoming_migration,
> +                                   NULL, NULL,
> +                                   g_main_context_get_thread_default());
> +    }
> +}
> +
>  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>  {
>      g_autofree char *filename = g_strdup(file_args->filename);
>      QIOChannelFile *fioc = NULL;
>      uint64_t offset = file_args->offset;
> -    int channels = 1;
> -    int i = 0;
>  
>      trace_migration_file_incoming(filename);
>  
> @@ -132,28 +158,20 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>  
>      if (offset &&
>          qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
> +        object_unref(OBJECT(fioc));
>          return;
>      }
>  
> +    qio_channel_set_name(QIO_CHANNEL(fioc), "migration-file-incoming");
> +    qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
> +                               file_accept_incoming_migration,
> +                               NULL, NULL,
> +                               g_main_context_get_thread_default());
> +
> +
>      if (migrate_multifd()) {
> -        channels += migrate_multifd_channels();
> +        file_recv_channels_create(fioc->fd, errp);
>      }
> -
> -    do {
> -        QIOChannel *ioc = QIO_CHANNEL(fioc);
> -
> -        qio_channel_set_name(ioc, "migration-file-incoming");
> -        qio_channel_add_watch_full(ioc, G_IO_IN,
> -                                   file_accept_incoming_migration,
> -                                   NULL, NULL,
> -                                   g_main_context_get_thread_default());
> -
> -        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
> -
> -        if (!fioc) {
> -            break;
> -        }
> -    } while (++i < channels);
>  }
>  
>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
> diff --git a/migration/file.h b/migration/file.h
> index 9f71e87f74..940122db0f 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -20,6 +20,9 @@ void file_start_outgoing_migration(MigrationState *s,
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
>  void file_cleanup_outgoing_migration(void);
>  bool file_send_channel_create(gpointer opaque, Error **errp);
> +void file_recv_channels_create(int fd, Error **errp);
> +gboolean file_accept_incoming_migration(QIOChannel *ioc, GIOCondition condition,
> +                                        gpointer opaque);
>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>                              int niov, RAMBlock *block, Error **errp);
>  int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
> -- 
> 2.35.3
> 

-- 
Peter Xu


