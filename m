Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43074CD040C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcsCU-0006zS-Or; Mon, 05 Jan 2026 16:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcsCC-0006sj-Qj
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcsC9-0003KQ-Kf
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767648776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSSc59fxgc5HGjI2LepX1n6UZ8AcK7mhXHzRfLYtaYk=;
 b=CtV3PSRE74A5RgKI+huaRMy68V/HgixdTRJvOH0LXlwKl8tKMY2xxzI6Jvhx0nz9VsLnxr
 bLtiNNq9UqZWsFAcxV59w3nowA0FZwFIbFlx89qMXmrQMAGHbDQDTdLlFnPf+zXNxA/5aN
 57VNDSQO5DafChftgnKcdxaNl/3X750=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-BROIpU5cPOWZnMa4CjLDag-1; Mon, 05 Jan 2026 16:32:54 -0500
X-MC-Unique: BROIpU5cPOWZnMa4CjLDag-1
X-Mimecast-MFC-AGG-ID: BROIpU5cPOWZnMa4CjLDag_1767648774
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a3a4af701so8858676d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767648774; x=1768253574; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qSSc59fxgc5HGjI2LepX1n6UZ8AcK7mhXHzRfLYtaYk=;
 b=VLFQZ4zO8MB1sDzZRGMTp2NAjKZ8U2JENx4W1tKxmeoefs9Good8tGy5OCwoahKiVr
 t0/1mtw5TsZL1K0fjsFwYtdF3UrJWU44fvnoQjMmzCHqUtigoKXL7wjHjwcXxYIhg/iY
 qkTVxaLZaLWJA/QM6osDo+DWUHcNhs/kwwDNxCpCPZ6ODPj6PV13TEEmv6gSK1n2PHyO
 hw8yHepSciLVD99EmHSc3G7FG75mh9rGj2WGoWqMj6O/me7T+cv8NuqungsLGKQGNj8A
 aYMa8EFXZ+at107qon1u8W8cZiGjN+9utK2ZdiAVn2MSJSQvgd9BfuEn6QvWQCi4X3vR
 kf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767648774; x=1768253574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSSc59fxgc5HGjI2LepX1n6UZ8AcK7mhXHzRfLYtaYk=;
 b=iQEr0+cdMEawwqJoRtLlE3dsflugSXEBSqi1ExY6lv+aTdpynEj7jolX+fCEuONUue
 qxylS3AIzrwtgA3zr3ut4ZEgP//s4RPRQ+aUF9mCQr7oGI/s1xqeOYvhSG+31WoHszlS
 VPai0YNIS64L2CAvCiJvCmWrRv6Z6SEAnTlnwVhP7TceM+Iul3wnKPEDTVl2fMmVy7ya
 2kCNgBCmMySi0oi3Kcdays0uai7OxmDwjyl40qG8On0D0Ab6v0TgTYKyDLTzhtB6L1V+
 Y7VBpSIYh6DPB9G0DpK1BzjXlHYUZ7vMLk648R4yG2r4rOMr8uqoVwbhfoEBPPCAg9TP
 Ehow==
X-Gm-Message-State: AOJu0YzOvA7Wqz9kWCleG/y2R7yz1achC4JC5BKOxn/4XgaDJyWr8OKW
 iwLSKXPinJNW1wek7BjzUpH5WseSRXYpUqGk0hltBkmkzkgPY2UI60ACOighKU9Q5UEpqQErPCR
 qjZ3V6dZIvklXB8e7fdkYvwDL2vTG/Bez3yZFNtBl7D9YqyEkOMrIVD3P
X-Gm-Gg: AY/fxX47v8mKrQgZEXgW0SVn1Y4Ysd3vac5/wL3HHvQoJJ0JLxrhXOmPOoP0ibJgUdd
 XkoAuPCmbVQ+GFdUjI/MoEp79cwf9sAUUwAPHvmoLgfuia+9/iYIDew/rp45hy2p1jVdbnlqRZ3
 T5jzW4+r+d/xvCp1PZteLV87cGkPKxSbUcMWL2dHocjFGrGBKD1hh2dPcKYhDVatKhw51mDgsmb
 K3YKpRYItj+SsGIdClm2GKF3qWAuzmekOcNnwJ/TC+PlLbO12BNuMb1f4KUjRWeDd4YLW3GBoij
 XCjHVBZ6sNmzWDBwXxkDW2DAg6IVN4VE8ACXkvM5kwVBkDO1CL16bvStCdyjRwyJ6UO0aO5iYw/
 JCZM=
X-Received: by 2002:a05:6214:3a09:b0:88f:dac4:8c3a with SMTP id
 6a1803df08f44-89075ed1c2emr14777546d6.52.1767648774034; 
 Mon, 05 Jan 2026 13:32:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGonjnr3BbkUjMnhGPRx6LJX8Syji+Y+/0Mvx5VsAl0qY0HcF3DqMyT0aqKfo/SbD3k8go/hg==
X-Received: by 2002:a05:6214:3a09:b0:88f:dac4:8c3a with SMTP id
 6a1803df08f44-89075ed1c2emr14777126d6.52.1767648773434; 
 Mon, 05 Jan 2026 13:32:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e35dbfsm1366281cf.19.2026.01.05.13.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:32:53 -0800 (PST)
Date: Mon, 5 Jan 2026 16:32:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2 25/25] migration/channel: Centralize calling
 migration_channel_connect_outgoing
Message-ID: <aVwuA3I6pPszg2SL@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-26-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-26-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05, 2026 at 04:06:42PM -0300, Fabiano Rosas wrote:
> Make the synchronous calls evident by not hiding the call to
> migration_channel_connect_outgoing() in the transport code. Have those
> functions return and call the function at the upper level.
> 
> This helps with navigation: the transport code returns the ioc,
> there's no need to look into them when browsing the code.
> 
> It also allows RDMA in the source side to use the same path as the
> rest of the transports.
> 
> While here, document the async calls which are the exception.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One question inline.

> ---
>  migration/channel.c | 28 ++++++++++++++++++++++++----
>  migration/exec.c    |  8 ++++----
>  migration/exec.h    |  5 ++++-
>  migration/fd.c      | 13 +++++++------
>  migration/fd.h      |  7 +++++--
>  migration/file.c    | 18 ++++++++++--------
>  migration/file.h    |  5 +++--
>  migration/rdma.c    | 11 +++++------
>  migration/rdma.h    |  4 ++--
>  9 files changed, 64 insertions(+), 35 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 6bb2077274..a8516837cf 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -37,26 +37,40 @@
>  void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
>                                  Error **errp)
>  {
> +    g_autoptr(QIOChannel) ioc = NULL;
> +
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>          SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>              saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>              saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>              socket_connect_outgoing(s, saddr, errp);
> +            /*
> +             * async: after the socket is connected, calls
> +             * migration_channel_connect_outgoing() directly.
> +             */
> +            return;
> +
>          } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> -            fd_connect_outgoing(s, saddr->u.fd.str, errp);
> +            ioc = fd_connect_outgoing(s, saddr->u.fd.str, errp);
>          }
>  #ifdef CONFIG_RDMA
>      } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_connect_outgoing(s, &addr->u.rdma, errp);
> +        ioc = rdma_connect_outgoing(s, &addr->u.rdma, errp);
>  #endif
>      } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_connect_outgoing(s, addr->u.exec.args, errp);
> +        ioc = exec_connect_outgoing(s, addr->u.exec.args, errp);
>      } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> -        file_connect_outgoing(s, &addr->u.file, errp);
> +        ioc = file_connect_outgoing(s, &addr->u.file, errp);
>      } else {
>          error_setg(errp, "uri is not a valid migration protocol");
>      }
> +
> +    if (ioc) {
> +        migration_channel_connect_outgoing(s, ioc);
> +    }
> +
> +    return;
>  }
>  
>  void migration_connect_incoming(MigrationAddress *addr, Error **errp)
> @@ -81,6 +95,12 @@ void migration_connect_incoming(MigrationAddress *addr, Error **errp)
>      } else {
>          error_setg(errp, "unknown migration protocol");
>      }
> +
> +    /*
> +     * async: the above routines all wait for the incoming connection
> +     * and call back to migration_channel_process_incoming() to start
> +     * the migration.
> +     */
>  }
>  
>  bool migration_has_main_and_multifd_channels(void)
> diff --git a/migration/exec.c b/migration/exec.c
> index c3085e803e..a1a7ede3b4 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -40,7 +40,8 @@ const char *exec_get_cmd_path(void)
>  }
>  #endif
>  
> -void exec_connect_outgoing(MigrationState *s, strList *command, Error **errp)
> +QIOChannel *exec_connect_outgoing(MigrationState *s, strList *command,
> +                                  Error **errp)
>  {
>      QIOChannel *ioc = NULL;
>      g_auto(GStrv) argv = strv_from_str_list(command);
> @@ -50,12 +51,11 @@ void exec_connect_outgoing(MigrationState *s, strList *command, Error **errp)
>      trace_migration_exec_outgoing(new_command);
>      ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
>      if (!ioc) {
> -        return;
> +        return NULL;
>      }
>  
>      qio_channel_set_name(ioc, "migration-exec-outgoing");
> -    migration_channel_connect_outgoing(s, ioc);
> -    object_unref(OBJECT(ioc));
> +    return ioc;
>  }
>  
>  static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/exec.h b/migration/exec.h
> index e7e8e475ac..3e39270dce 100644
> --- a/migration/exec.h
> +++ b/migration/exec.h
> @@ -20,10 +20,13 @@
>  #ifndef QEMU_MIGRATION_EXEC_H
>  #define QEMU_MIGRATION_EXEC_H
>  
> +#include "io/channel.h"
> +
>  #ifdef WIN32
>  const char *exec_get_cmd_path(void);
>  #endif
>  void exec_connect_incoming(strList *host_port, Error **errp);
>  
> -void exec_connect_outgoing(MigrationState *s, strList *host_port, Error **errp);
> +QIOChannel *exec_connect_outgoing(MigrationState *s, strList *host_port,
> +                                  Error **errp);
>  #endif
> diff --git a/migration/fd.c b/migration/fd.c
> index b689426ad4..bbf380d1a0 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -49,12 +49,13 @@ static bool migration_fd_valid(int fd)
>      return false;
>  }
>  
> -void fd_connect_outgoing(MigrationState *s, const char *fdname, Error **errp)
> +QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
> +                                Error **errp)
>  {
> -    QIOChannel *ioc;
> +    QIOChannel *ioc = NULL;
>      int fd = monitor_get_fd(monitor_cur(), fdname, errp);
>      if (fd == -1) {
> -        return;
> +        goto out;
>      }
>  
>      if (!migration_fd_valid(fd)) {
> @@ -66,12 +67,12 @@ void fd_connect_outgoing(MigrationState *s, const char *fdname, Error **errp)
>      ioc = qio_channel_new_fd(fd, errp);
>      if (!ioc) {
>          close(fd);
> -        return;
> +        goto out;
>      }
>  
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
> -    migration_channel_connect_outgoing(s, ioc);
> -    object_unref(OBJECT(ioc));
> +out:
> +    return ioc;
>  }
>  
>  static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/fd.h b/migration/fd.h
> index 7211629270..ce0b751273 100644
> --- a/migration/fd.h
> +++ b/migration/fd.h
> @@ -16,8 +16,11 @@
>  
>  #ifndef QEMU_MIGRATION_FD_H
>  #define QEMU_MIGRATION_FD_H
> +
> +#include "io/channel.h"
> +
>  void fd_connect_incoming(const char *fdname, Error **errp);
>  
> -void fd_connect_outgoing(MigrationState *s, const char *fdname,
> -                         Error **errp);
> +QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
> +                                Error **errp);
>  #endif
> diff --git a/migration/file.c b/migration/file.c
> index b7b0fb5194..5618aced49 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -93,36 +93,38 @@ out:
>      return ret;
>  }
>  
> -void file_connect_outgoing(MigrationState *s,
> -                           FileMigrationArgs *file_args, Error **errp)
> +QIOChannel *file_connect_outgoing(MigrationState *s,
> +                                  FileMigrationArgs *file_args, Error **errp)
>  {
> -    g_autoptr(QIOChannelFile) fioc = NULL;
> +    QIOChannelFile *fioc = NULL;
>      g_autofree char *filename = g_strdup(file_args->filename);
>      uint64_t offset = file_args->offset;
> -    QIOChannel *ioc;
> +    QIOChannel *ioc = NULL;
>  
>      trace_migration_file_outgoing(filename);
>  
>      fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY, 0600, errp);
>      if (!fioc) {
> -        return;
> +        goto out;
>      }
>  
>      if (ftruncate(fioc->fd, offset)) {
>          error_setg_errno(errp, errno,
>                           "failed to truncate migration file to offset %" PRIx64,
>                           offset);
> -        return;
> +        goto out;
>      }
>  
>      outgoing_args.fname = g_strdup(filename);
>  
>      ioc = QIO_CHANNEL(fioc);
>      if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> -        return;
> +        ioc = NULL;
> +        goto out;
>      }
>      qio_channel_set_name(ioc, "migration-file-outgoing");
> -    migration_channel_connect_outgoing(s, ioc);
> +out:
> +    return ioc;
>  }
>  
>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/file.h b/migration/file.h
> index 9b1e874bb7..5936c64fea 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -9,14 +9,15 @@
>  #define QEMU_MIGRATION_FILE_H
>  
>  #include "qapi/qapi-types-migration.h"
> +#include "io/channel.h"
>  #include "io/task.h"
>  #include "channel.h"
>  #include "multifd.h"
>  
>  void file_connect_incoming(FileMigrationArgs *file_args, Error **errp);
>  
> -void file_connect_outgoing(MigrationState *s,
> -                           FileMigrationArgs *file_args, Error **errp);
> +QIOChannel *file_connect_outgoing(MigrationState *s,
> +                                  FileMigrationArgs *file_args, Error **errp);
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
>  void file_cleanup_outgoing_migration(void);
>  bool file_send_channel_create(gpointer opaque, Error **errp);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 582e0651d4..66bc337b6b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3934,8 +3934,8 @@ err:
>      g_free(rdma);
>  }
>  
> -void rdma_connect_outgoing(void *opaque,
> -                           InetSocketAddress *host_port, Error **errp)
> +QIOChannel *rdma_connect_outgoing(void *opaque,
> +                                  InetSocketAddress *host_port, Error **errp)
>  {
>      MigrationState *s = opaque;
>      RDMAContext *rdma_return_path = NULL;
> @@ -3945,7 +3945,7 @@ void rdma_connect_outgoing(void *opaque,
>      /* Avoid ram_block_discard_disable(), cannot change during migration. */
>      if (ram_block_discard_is_required()) {
>          error_setg(errp, "RDMA: cannot disable RAM discard");
> -        return;
> +        return NULL;
>      }
>  
>      rdma = qemu_rdma_data_init(host_port, errp);
> @@ -3995,12 +3995,11 @@ void rdma_connect_outgoing(void *opaque,
>      trace_rdma_connect_outgoing_after_rdma_connect();
>  
>      s->rdma_migration = true;
> -    migration_outgoing_setup(rdma_new_output(rdma));
> -    migration_start_outgoing(s);

migration_channel_connect_outgoing() does two more things:

- check for migrate_channel_requires_tls_upgrade()
- migration_ioc_register_yank()

The latter is probably fine because rdma iochannel doesn't support
.shutdown() API.

The former... may not be relevant to this patch, but anyway I wonder if
it'll always be better to fail a QMP migrate command when RDMA is used with
TLS, in migration_capabilities_and_transport_compatible().  It can be a
separate small patch rather than reposting this wholeset.

> -    return;
> +    return rdma_new_output(rdma);
>  return_path_err:
>      qemu_rdma_cleanup(rdma);
>  err:
>      g_free(rdma);
>      g_free(rdma_return_path);
> +    return NULL;
>  }
> diff --git a/migration/rdma.h b/migration/rdma.h
> index 170c25cf44..8a6515f130 100644
> --- a/migration/rdma.h
> +++ b/migration/rdma.h
> @@ -21,8 +21,8 @@
>  
>  #include "system/memory.h"
>  
> -void rdma_connect_outgoing(void *opaque, InetSocketAddress *host_port,
> -                           Error **errp);
> +QIOChannel *rdma_connect_outgoing(void *opaque, InetSocketAddress *host_port,
> +                                  Error **errp);
>  
>  void rdma_connect_incoming(InetSocketAddress *host_port, Error **errp);
>  
> -- 
> 2.51.0
> 

-- 
Peter Xu


