Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A5C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWPX-0003MC-Ha; Wed, 28 Feb 2024 21:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWPW-0003M2-0N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWPR-0001DT-Tx
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709174672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOlx7FXw0lRrEAl+TnkREdIr88nZ8cYZxGJm5kEPDFQ=;
 b=dC3ClSw+Qft9AppYCfgFeVFcKHBSKK6IrgcDOrgFE2mKU8DVT2jkAk/1IZOLQca1QSURhq
 VUNT+/bU72CvrPF123oDoDYAEDcy1OSbL6vS3xKzzhkBQRcm5BowqEfLC9Pm1fv5O90k7y
 29EWSPRWbXVjH1GhEPe0DAXrikwFi4A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-YDke8Df_OIqZiB0FR4cOaQ-1; Wed, 28 Feb 2024 21:44:30 -0500
X-MC-Unique: YDke8Df_OIqZiB0FR4cOaQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso152709a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709174669; x=1709779469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOlx7FXw0lRrEAl+TnkREdIr88nZ8cYZxGJm5kEPDFQ=;
 b=Y3hQ0q2qO4zFZUFZiWewG80tVUdQVD8P6ATKqYedS+g+/lWj9KcG8ybNynObLlKKbo
 LTOm8taBVg/YP9HWWJrEcwKsfVMI5PtUU+45HafIoTBC/v82FDGFVIKYFDMCMaqtv3P1
 LGpoYBKlFQrO7Atsv0Lbka7a2LakrDlgSzg/G3aBN3Aw1dyAq4lvcekcZfY2KaX74uYX
 Q5mOFcGnoGZEMiDglJ4unrKdESD1ncittkzEH8Qxgqnk4Hw0d+5wc/BphRXy1kxmd9cO
 310hQ3lKeggQF/4at6H/VswP97ETiUAqHxPPZRBzM2jVC3T75TvYuq86+10jBMFxVVxn
 nZCw==
X-Gm-Message-State: AOJu0YwRQskVbTCSOf3v/Dxj4vwKjU00cOv5+Hio1noysuEfJ3cCOG56
 secFuYmfRIHTFIXLuD0WfPZMhPCe6C7LMPi8U/eArrpDvKl/7jZU6lwyXhXfdVNt8mCYw/dAIn/
 Z+ulKzz9KQfqX+p5xJPMRZfY7TD8B6hExClLwBC9mR2BV3LLQnUvA
X-Received: by 2002:a17:902:ee03:b0:1dc:82bc:c072 with SMTP id
 z3-20020a170902ee0300b001dc82bcc072mr809416plb.1.1709174669075; 
 Wed, 28 Feb 2024 18:44:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAi8iw1WuKS2CwQPIMUvir/AQ8bnGQwKoeY9KnOklCM5OK3/J5UyBBOa/KBVCap/V9QuTfpg==
X-Received: by 2002:a17:902:ee03:b0:1dc:82bc:c072 with SMTP id
 z3-20020a170902ee0300b001dc82bcc072mr809404plb.1.1709174668704; 
 Wed, 28 Feb 2024 18:44:28 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z18-20020a170903019200b001d8be6d1ec4sm167637plg.39.2024.02.28.18.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 18:44:28 -0800 (PST)
Date: Thu, 29 Feb 2024 10:44:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 17/23] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <Zd_vhfonAX5gIcJl@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:21:21PM -0300, Fabiano Rosas wrote:
> Allow multifd to open file-backed channels. This will be used when
> enabling the mapped-ram migration stream format which expects a
> seekable transport.
> 
> The QIOChannel read and write methods will use the preadv/pwritev
> versions which don't update the file offset at each call so we can
> reuse the fd without re-opening for every channel.
> 
> Contrary to the socket migration, the file migration doesn't need an
> asynchronous channel creation process, so expose
> multifd_channel_connect() and call it directly.
> 
> Note that this is just setup code and multifd cannot yet make use of
> the file channels.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - moved flags change to another patch
> - removed channels_created assert
> ---
>  migration/file.c    | 41 +++++++++++++++++++++++++++++++++++++++--
>  migration/file.h    |  4 ++++
>  migration/multifd.c | 18 +++++++++++++++---
>  migration/multifd.h |  1 +
>  4 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 22d052a71f..83328a7a1b 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -12,12 +12,17 @@
>  #include "channel.h"
>  #include "file.h"
>  #include "migration.h"
> +#include "multifd.h"
>  #include "io/channel-file.h"
>  #include "io/channel-util.h"
>  #include "trace.h"
>  
>  #define OFFSET_OPTION ",offset="
>  
> +static struct FileOutgoingArgs {
> +    char *fname;
> +} outgoing_args;
> +
>  /* Remove the offset option from @filespec and return it in @offsetp. */
>  
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> @@ -37,6 +42,36 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>      return 0;
>  }
>  
> +void file_cleanup_outgoing_migration(void)
> +{
> +    g_free(outgoing_args.fname);
> +    outgoing_args.fname = NULL;
> +}
> +
> +bool file_send_channel_create(gpointer opaque, Error **errp)
> +{
> +    QIOChannelFile *ioc;
> +    int flags = O_WRONLY;
> +    bool ret = true;
> +
> +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> +    if (!ioc) {
> +        ret = false;
> +        goto out;
> +    }
> +
> +    multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
> +
> +out:
> +    /*
> +     * File channel creation is synchronous. However posting this
> +     * semaphore here is simpler than adding a special case.
> +     */
> +    multifd_send_channel_created();
> +
> +    return ret;
> +}
> +
>  void file_start_outgoing_migration(MigrationState *s,
>                                     FileMigrationArgs *file_args, Error **errp)
>  {
> @@ -47,12 +82,14 @@ void file_start_outgoing_migration(MigrationState *s,
>  
>      trace_migration_file_outgoing(filename);
>  
> -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> -                                     0600, errp);
> +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_TRUNC | O_WRONLY,
> +                                     0660, errp);

It seems this is still leftover?

>      if (!fioc) {
>          return;
>      }
>  
> +    outgoing_args.fname = g_strdup(filename);
> +
>      ioc = QIO_CHANNEL(fioc);
>      if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
>          return;
> diff --git a/migration/file.h b/migration/file.h
> index 37d6a08bfc..4577f9efdd 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -9,10 +9,14 @@
>  #define QEMU_MIGRATION_FILE_H
>  
>  #include "qapi/qapi-types-migration.h"
> +#include "io/task.h"
> +#include "channel.h"
>  
>  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
>  
>  void file_start_outgoing_migration(MigrationState *s,
>                                     FileMigrationArgs *file_args, Error **errp);
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
> +void file_cleanup_outgoing_migration(void);
> +bool file_send_channel_create(gpointer opaque, Error **errp);
>  #endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3574fd3953..f155223303 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -17,6 +17,7 @@
>  #include "exec/ramblock.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "file.h"
>  #include "ram.h"
>  #include "migration.h"
>  #include "migration-stats.h"
> @@ -28,6 +29,7 @@
>  #include "threadinfo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
> +#include "io/channel-file.h"
>  #include "io/channel-socket.h"
>  #include "yank_functions.h"
>  
> @@ -694,6 +696,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>  {
>      if (p->c) {
>          migration_ioc_unregister_yank(p->c);
> +        qio_channel_close(p->c, NULL);

s/NULL/&error_abort/?

>          object_unref(OBJECT(p->c));
>          p->c = NULL;
>      }
> @@ -715,6 +718,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>  
>  static void multifd_send_cleanup_state(void)
>  {
> +    file_cleanup_outgoing_migration();
>      socket_cleanup_outgoing_migration();
>      qemu_sem_destroy(&multifd_send_state->channels_created);
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
> @@ -977,7 +981,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>      return true;
>  }
>  
> -static void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
> +void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
>  {
>      qio_channel_set_delay(ioc, false);
>  
> @@ -1045,9 +1049,14 @@ out:
>      error_free(local_err);
>  }
>  
> -static void multifd_new_send_channel_create(gpointer opaque)
> +static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
>  {
> +    if (!multifd_use_packets()) {
> +        return file_send_channel_create(opaque, errp);
> +    }
> +
>      socket_send_channel_create(multifd_new_send_channel_async, opaque);
> +    return true;
>  }
>  
>  bool multifd_send_setup(void)
> @@ -1096,7 +1105,10 @@ bool multifd_send_setup(void)
>          p->page_size = qemu_target_page_size();
>          p->page_count = page_count;
>          p->write_flags = 0;
> -        multifd_new_send_channel_create(p);
> +
> +        if (!multifd_new_send_channel_create(p, &local_err)) {
> +            return -1;

"-1" is unfortunately a "true"!..

> +        }
>      }
>  
>      /*
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 1d8bbaf96b..db8887f088 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -227,5 +227,6 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>      p->iovs_num++;
>  }
>  
> +void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
>  
>  #endif
> -- 
> 2.35.3
> 

-- 
Peter Xu


