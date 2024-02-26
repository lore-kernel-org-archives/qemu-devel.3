Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6A8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWUS-00047X-SA; Mon, 26 Feb 2024 03:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWUQ-00044H-Jb
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWUO-0006oD-Vy
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708936651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYoViIQxuYsoGw8nG94ne08EEqz/c1kGvIogAb4+D1o=;
 b=VT8Gr/cWP5rWiPfEF6MYoMv4lVcDs8HkRqtItJkGOVso5I3Graa1ClLyIgAKs+nbscGalB
 jb2YCiLIa3XkQeENbM0NxccRODcOt0L4Z9xGS4jiD1H9YkcMBboEMswwnSO0pIo25o7CY8
 fufWyfwVRm2i2aC0sAMZZzBOEmZKJ5U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-FjkK29cCPwqaf59KKcqv1A-1; Mon, 26 Feb 2024 03:37:30 -0500
X-MC-Unique: FjkK29cCPwqaf59KKcqv1A-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc90a15eeeso1007065ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936649; x=1709541449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYoViIQxuYsoGw8nG94ne08EEqz/c1kGvIogAb4+D1o=;
 b=D/1TiBBd6x6z/tnK0kqHVrVJt3s9w4T9lgRwGWaULsL7I7iZdqN3sHu43bDlsxQu2x
 ZdIG9xjY49S4oWBqKfQgxgfxD1OBSjFDD92TJVljPp3gxu2ZVCxD3izfW3EgoW2EPp5D
 ZyzeGixPc1VwKeeiSVQte/8AIZ5pdHGpxrJfxgKjMKH0jebUg7iuA8xsSz5jGyb4r6kq
 q7gltCv2zexg+37MZpy0pylXuY4PBhaWefpR1wdAIjBTA4IpOzIB7S7uWBpH0BIaXCuj
 aLp6d1IzL+8w9l4ZnIm2YX9lM5JuK1EulTz3jmz2M7REatXHP775THfAUrh8t1EgIkcl
 voYQ==
X-Gm-Message-State: AOJu0YzuVTgl+Afm4Do5ppDD0yoA7ddokX8LpHfoIkSDWnbA6bF+j7zD
 cQEplNdxk9Fj/EUI3VS3SKcavi85oWF/clSaN9nS1OgXxqg6f2k8yhhphn5+2RTOd5z3vpkPh+M
 tAFR32tIeLpOsD+3/2jjRNl0U9KZRDJDmQfp+o9I8uGL+QeY3IcrS
X-Received: by 2002:a17:902:c184:b0:1dc:2be8:f61a with SMTP id
 d4-20020a170902c18400b001dc2be8f61amr7229477pld.2.1708936649227; 
 Mon, 26 Feb 2024 00:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTa/9oEtuxBrekKtZSPTLXJGl6DsT81aOB7ml1uHMGHA9GZG/R06V/4CStfRK9ENHbSMV0fQ==
X-Received: by 2002:a17:902:c184:b0:1dc:2be8:f61a with SMTP id
 d4-20020a170902c18400b001dc2be8f61amr7229461pld.2.1708936648814; 
 Mon, 26 Feb 2024 00:37:28 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x2-20020a170902b40200b001db9c3d6506sm3380033plr.209.2024.02.26.00.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:37:28 -0800 (PST)
Date: Mon, 26 Feb 2024 16:37:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 25/34] migration/multifd: Add fixed-ram support to fd:
 URI
Message-ID: <ZdxNwX-eqtmbZNac@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-26-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-26-farosas@suse.de>
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

On Tue, Feb 20, 2024 at 07:41:29PM -0300, Fabiano Rosas wrote:
> If we receive a file descriptor that points to a regular file, there's
> nothing stopping us from doing multifd migration with fixed-ram to
> that file.
> 
> Enable the fd: URI to work with multifd + fixed-ram.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/fd.c        | 30 ++++++++++++++++++++++++++++++
>  migration/fd.h        |  1 +
>  migration/file.c      | 12 +++++++++---
>  migration/migration.c |  4 ++++
>  4 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/fd.c b/migration/fd.c
> index 0eb677dcae..b7e4d071a4 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -19,14 +19,28 @@
>  #include "fd.h"
>  #include "migration.h"
>  #include "monitor/monitor.h"
> +#include "io/channel-file.h"
>  #include "io/channel-util.h"
> +#include "options.h"
>  #include "trace.h"
>  
>  
> +static struct FdOutgoingArgs {
> +    int fd;
> +} outgoing_args;
> +
> +int fd_args_get_fd(void)
> +{
> +    return outgoing_args.fd;
> +}
> +
>  void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
>  {
>      QIOChannel *ioc;
>      int fd = monitor_get_fd(monitor_cur(), fdname, errp);
> +
> +    outgoing_args.fd = -1;

I suggest we either drop this, or close() it before releasing; basically
each fd reference holds a real fd index would be easier, IMHO.

Also, we'd want to free the fd (by closing it) just like we free
outgoing_args.fname?  Otherwise if a fd is passed in, who is responsible to
close it and release the fd resource?

> +
>      if (fd == -1) {
>          return;
>      }
> @@ -38,6 +52,8 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>          return;
>      }
>  
> +    outgoing_args.fd = fd;

If agree with above, then dup(fd) here.

> +
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
>      migration_channel_connect(s, ioc, NULL, NULL);
>      object_unref(OBJECT(ioc));
> @@ -73,4 +89,18 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>                                 fd_accept_incoming_migration,
>                                 NULL, NULL,
>                                 g_main_context_get_thread_default());
> +
> +    if (migrate_multifd()) {
> +        int channels = migrate_multifd_channels();
> +
> +        while (channels--) {
> +            ioc = QIO_CHANNEL(qio_channel_file_new_fd(fd));

dup(fd)?

> +
> +            qio_channel_set_name(ioc, "migration-fd-incoming");
> +            qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                       fd_accept_incoming_migration,
> +                                       NULL, NULL,
> +                                       g_main_context_get_thread_default());
> +        }
> +    }
>  }
> diff --git a/migration/fd.h b/migration/fd.h
> index b901bc014e..1be980c130 100644
> --- a/migration/fd.h
> +++ b/migration/fd.h
> @@ -20,4 +20,5 @@ void fd_start_incoming_migration(const char *fdname, Error **errp);
>  
>  void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
>                                   Error **errp);
> +int fd_args_get_fd(void);
>  #endif
> diff --git a/migration/file.c b/migration/file.c
> index 1a18e608fc..27ccfc6a1d 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -11,6 +11,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "channel.h"
> +#include "fd.h"
>  #include "file.h"
>  #include "migration.h"
>  #include "io/channel-file.h"
> @@ -58,10 +59,15 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
>  {
>      QIOChannelFile *ioc;
>      int flags = O_WRONLY;
> +    int fd = fd_args_get_fd();
>  
> -    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> -    if (!ioc) {
> -        return false;
> +    if (fd && fd != -1) {
> +        ioc = qio_channel_file_new_fd(fd);
> +    } else {
> +        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> +        if (!ioc) {
> +            return false;
> +        }
>      }
>  
>      if (!multifd_channel_connect(opaque, QIO_CHANNEL(ioc), errp)) {
> diff --git a/migration/migration.c b/migration/migration.c
> index 32b291a282..ce7e6f5065 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -134,6 +134,10 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>          SocketAddress *saddr = &addr->u.socket;
>  
> +        if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> +            return migrate_fixed_ram();
> +        }
> +
>          return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>                  saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>                  saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
> -- 
> 2.35.3
> 

-- 
Peter Xu


