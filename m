Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00917C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reV86-0006xs-N7; Mon, 26 Feb 2024 02:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reV84-0006nF-PI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:10:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reV82-0005BR-LH
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708931421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTr3PSRdXXnSJdb2dwgpBCAsYecK5RoqZiZw2csi6JE=;
 b=MPFcs97wl4LiqBq1I3WRY+MPLTR60c/SlYgbGnBbVQ3nj6pOILTlCo6dH6STJP1ZMfzcqY
 1Ft4f5GinMeZD0UGGXGN7L8ri1+Ll+MZXANdUpg/JZTweP6PwvLRtxIZcFZaf/AvW0CGhZ
 WRBkUz7L0/KwrDOB05xFJKK3twAjcok=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-vv32stCvPWK7B7g1D_aHpg-1; Mon, 26 Feb 2024 02:10:18 -0500
X-MC-Unique: vv32stCvPWK7B7g1D_aHpg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so1300625a12.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708931418; x=1709536218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTr3PSRdXXnSJdb2dwgpBCAsYecK5RoqZiZw2csi6JE=;
 b=UbbJIyY5QGx0hCdK7N/M54LaGxIhrESODFKB6sfEnHQVVxJEbBId38lFXnaE26TXCL
 aLfJXqQTsdIMJ3nM9T5jflLca8yXjVaLMKyzmEY6ljLjlePAmT7oBkkc00lfQSSNmJTd
 XFTZa6ZOAAmkJalmXpYkbEK70YOEQWq11aY6gkHXZVKbdAeR8KUQksUPCgRRYt1mCD2N
 vmyqO3MQyL37E7R1/O2zt+1VTAZRFt4PnufrrcVbJ0OmBtDycmz6eT5vvnAS/mE3EM80
 mGhDg/p3lKtmW+2M4ZC8LmaUmvmF+4Og8ToX+oe8Eb0uSdqq/uxTAW8cpn/aYQNpYHBV
 fkrQ==
X-Gm-Message-State: AOJu0Yy96apo9PgX6OfxXqkcjjFcVZL+X4lLmrSofecHabMkMb4bjKZA
 YyF2+EgqHFQ4i6C7ZDbOfUu3bPoo0G0gDWsi3+TPU0vgU1xY/9eHSoMV8wE4tIJIMzZr7EZG1DK
 6qazcjRMlWidb2kfq+bRF46GS6lWff9eePmglBPlhlFg1vo3gwLzE
X-Received: by 2002:a05:6a00:2985:b0:6e5:355a:1270 with SMTP id
 cj5-20020a056a00298500b006e5355a1270mr770663pfb.2.1708931417257; 
 Sun, 25 Feb 2024 23:10:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4VEyra6S+PTK6cjPLfCsO/QUYTdgkHFVpi9fomvstGjd3XvcqCUxcfVCi+E3Tg5sgNHktDA==
X-Received: by 2002:a05:6a00:2985:b0:6e5:355a:1270 with SMTP id
 cj5-20020a056a00298500b006e5355a1270mr770651pfb.2.1708931416886; 
 Sun, 25 Feb 2024 23:10:16 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r5-20020aa79ec5000000b006e37814cb11sm3129205pfq.4.2024.02.25.23.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 23:10:16 -0800 (PST)
Date: Mon, 26 Feb 2024 15:10:10 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 20/34] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <Zdw5UmOYQM-8KBBK@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-21-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-21-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:24PM -0300, Fabiano Rosas wrote:
> Allow multifd to open file-backed channels. This will be used when
> enabling the fixed-ram migration stream format which expects a
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
>  migration/file.c    | 40 ++++++++++++++++++++++++++++++++++++++--
>  migration/file.h    |  5 +++++
>  migration/multifd.c | 27 ++++++++++++++++++++++-----
>  migration/multifd.h |  2 ++
>  4 files changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 22d052a71f..ac9f6ae40a 100644
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
> @@ -37,6 +42,34 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>      return 0;
>  }
>  
> +int file_send_channel_destroy(QIOChannel *ioc)
> +{
> +    if (ioc) {
> +        qio_channel_close(ioc, NULL);
> +    }
> +    g_free(outgoing_args.fname);
> +    outgoing_args.fname = NULL;
> +
> +    return 0;
> +}
> +
> +bool file_send_channel_create(gpointer opaque, Error **errp)
> +{
> +    QIOChannelFile *ioc;
> +    int flags = O_WRONLY;
> +
> +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> +    if (!ioc) {
> +        return false;
> +    }
> +
> +    if (!multifd_channel_connect(opaque, QIO_CHANNEL(ioc), errp)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void file_start_outgoing_migration(MigrationState *s,
>                                     FileMigrationArgs *file_args, Error **errp)
>  {
> @@ -44,15 +77,18 @@ void file_start_outgoing_migration(MigrationState *s,
>      g_autofree char *filename = g_strdup(file_args->filename);
>      uint64_t offset = file_args->offset;
>      QIOChannel *ioc;
> +    int flags = O_CREAT | O_TRUNC | O_WRONLY;
> +    mode_t mode = 0660;
>  
>      trace_migration_file_outgoing(filename);
>  
> -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> -                                     0600, errp);
> +    fioc = qio_channel_file_new_path(filename, flags, mode, errp);

This change seems irrelevant, could be squashed into the previous patch
when introduced?

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
> index 37d6a08bfc..90794b494b 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -9,10 +9,15 @@
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
> +
> +bool file_send_channel_create(gpointer opaque, Error **errp);
> +int file_send_channel_destroy(QIOChannel *ioc);
>  #endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 45a0c7aaa8..507b497d52 100644
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
> @@ -680,6 +682,9 @@ static void multifd_send_terminate_threads(void)
>  
>  static int multifd_send_channel_destroy(QIOChannel *send)
>  {
> +    if (!multifd_use_packets()) {
> +        return file_send_channel_destroy(send);
> +    }
>      return socket_send_channel_destroy(send);
>  }
>  
> @@ -959,9 +964,8 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>      return true;
>  }
>  
> -static bool multifd_channel_connect(MultiFDSendParams *p,
> -                                    QIOChannel *ioc,
> -                                    Error **errp)
> +bool multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc,
> +                             Error **errp)
>  {
>      qio_channel_set_delay(ioc, false);
>  
> @@ -1031,9 +1035,14 @@ out:
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
> @@ -1082,7 +1091,15 @@ bool multifd_send_setup(void)
>          p->page_size = qemu_target_page_size();
>          p->page_count = page_count;
>          p->write_flags = 0;
> -        multifd_new_send_channel_create(p);
> +
> +        if (!multifd_new_send_channel_create(p, &local_err)) {
> +            /*
> +             * File channel creation is synchronous, we don't need the
> +             * semaphore below, it's safe to return now.
> +             */
> +            assert(migrate_fixed_ram());

This comment and assert() is slightly confusing to me.  Drop them?

IMHO it's always safe to directly return here, the channels_created sem
will be destroyed later anyway so the number shouldn't matter.

And as I commented in the other email, IMHO it's cleaner we also post that
sem in file_send_channel_create().

> +            return -1;
> +        }
>      }
>  
>      if (use_packets) {
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 19188815a3..135f6ed098 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -228,5 +228,7 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>      p->iovs_num++;
>  }
>  
> +bool multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc,
> +                             Error **errp);
>  
>  #endif
> -- 
> 2.35.3
> 

-- 
Peter Xu


