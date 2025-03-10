Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AC6C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 19:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1triY6-0003ph-Ih; Mon, 10 Mar 2025 15:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1triXx-0003op-5d
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 15:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1triXu-0004rQ-KG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 15:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741633932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b85ZEHYSbq8JZLOmn7bdeImz7K0kuutIZ0nl1LUMAkw=;
 b=QZzQl+pRor0xEInbfCDZmV0qp6vEEIcl4B8KMX/2MsVTwv5+NlJ/O7o6KN5XZzCjolC/xk
 Lah95xsQMi9uh80jEEMhcZCUBS2CehLJhi3tVEIh/jA2rdWrrPhxKtSgINFctk7qdaHkUM
 wd7F3kC4RfL69h5TSYu+JeR07qXbfvs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-HvPH0nSAPxWtiZMJEwACUA-1; Mon, 10 Mar 2025 15:12:09 -0400
X-MC-Unique: HvPH0nSAPxWtiZMJEwACUA-1
X-Mimecast-MFC-AGG-ID: HvPH0nSAPxWtiZMJEwACUA_1741633929
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c24bb4f502so866036185a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 12:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741633929; x=1742238729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b85ZEHYSbq8JZLOmn7bdeImz7K0kuutIZ0nl1LUMAkw=;
 b=Dt75bfe9lL4qvWPwsmJcJcUz4Kf8sSlCDhknPTkOQC5J0YzRcWOOvUGf2kQQ4bnB25
 09iYKByQ5q03Ft5kfID3angob9vR5KT+EB7wjhm2jr/dy7VU8IV039C10+/+KAjAJmEd
 f+m7qFWSrrAMOSOqlDXid9e4f01bzqfeKtnI/WPJnw3/MmPnC1uOVhTJMzLyV3g2sGpj
 1tTlGLbUOTuLsN47h6S3t+0BN6IZV8GdLXmmu5AjaWcaSJOM+dX6XbKB8aICFAUxey7z
 /HZWVUnk6A3uQkxPdqxXpS6ct4lhz/LzGlB4vRvYJXhCfEMw5kyPky1PTxuu0u4EIJDj
 PEqA==
X-Gm-Message-State: AOJu0Yw2CgjzJsZj+Fd8CTHmg/uba4TQX32KXTWWqyt6vYRfxpTffW3v
 Iubeo3xqpj7IplLvUknezmqA8skjxrJ88eiKqMy+WX/8He/DpY0ygU+LasyKR26Xt4DTSVXDNgv
 /r35PTBmqyHncYkpZJCSI6rs/75TFLnGikbfC4B4AkjBRUOhOlbw4
X-Gm-Gg: ASbGnctD4fbLh4Z2gAkvZf8NaINsJc50Cs8K7ScGmadetQFmZFWmxsI0BEt+vL9MikP
 KOu1Ol4R4znlrBUIsm1LTVZ7i/mRB9Kmy9Zsxv0S+L6Hv3/l4L2LDaxHEyRRJqz7g8jwA+vtmci
 IC6jM/lDQIYU4XaBs+zuDao4JIU8GT69o3h/vpRrEQK7lDn5K5xo/Atxaf3u4j1xhK/In5uzjXl
 kG+tn6nRWNVRC13vzqsChK7pGJSZXHtyYLCm5eHOMpxbNvTXMXElFnQSjr6krD4KWjJxrUGRAZr
 obINHr8=
X-Received: by 2002:a05:620a:6503:b0:7c5:4a3a:bc07 with SMTP id
 af79cd13be357-7c54a3abf56mr1012575185a.5.1741633929217; 
 Mon, 10 Mar 2025 12:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYq0tyY1x58WlikPD2s2zfgey5EDDi4UHA//9LvXFWNZ/HrEP4BkRahLIuiGW3HZ3dHnHxaQ==
X-Received: by 2002:a05:620a:6503:b0:7c5:4a3a:bc07 with SMTP id
 af79cd13be357-7c54a3abf56mr1012571685a.5.1741633928796; 
 Mon, 10 Mar 2025 12:12:08 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5564bffefsm185956385a.39.2025.03.10.12.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 12:12:08 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:12:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Manish Mishra <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, berrange@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z885hS6QmGOZYj7N@x1.local>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310011500.240782-1-manish.mishra@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 09, 2025 at 09:15:00PM -0400, Manish Mishra wrote:
> We allocate extra metadata SKBs in case of a zerocopy send. This metadata
> memory is accounted for in the OPTMEM limit. If there is any error while
> sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
> queued in the socket error queue. This error queue is freed when userspace
> reads it.
> 
> Usually, if there are continuous failures, we merge the metadata into a single
> SKB and free another one. As a result, it never exceeds the OPTMEM limit.
> However, if there is any out-of-order processing or intermittent zerocopy
> failures, this error chain can grow significantly, exhausting the OPTMEM limit.
> As a result, all new sendmsg requests fail to allocate any new SKB, leading to
> an ENOBUF error. Depending on the amount of data queued before the flush
> (i.e., large live migration iterations), even large OPTMEM limits are prone to
> failure.
> 
> To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> we flush the error queue and retry once more.
> 
> Additionally, this patch removes the dirty_sync_missed_zero_copy migration
> stat. This stat is not used anywhere and does not seem useful. Removing it
> simplifies the patch.

IMHO it's still useful, it's just that if it's for debugging purpose, it's
optional to expose it via QAPI.  Then if without exposing it to upper
layer, it can simplify the change this patch wanted to introduce.  We can
still keep it a tracepoint.

Meanwhile, please consider spliting the patch into two:

  - Removal of dirty_sync_missed_zero_copy, we need to copy QAPI
    maintainers for this one.  We can add a tracepoint altogether.

  - The real work for the workaround on the flush

> 
> V2:
>   1. Removed the dirty_sync_missed_zero_copy migration stat.
>   2. Made the call to qio_channel_socket_flush_internal() from
>      qio_channel_socket_writev() non-blocking.
> 
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> ---
>  include/io/channel.h           |  3 +-
>  io/channel-socket.c            | 57 ++++++++++++++++++++++++----------
>  migration/migration-hmp-cmds.c |  5 ---
>  migration/migration-stats.h    |  5 ---
>  migration/migration.c          |  2 --
>  migration/multifd.c            |  3 --
>  6 files changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 62b657109c..c393764ab7 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -980,8 +980,7 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
>   * If not implemented, acts as a no-op, and returns 0.
>   *
>   * Returns -1 if any error is found,
> - *          1 if every send failed to use zero copy.
> - *          0 otherwise.
> + *          0 on success.
>   */
>  
>  int qio_channel_flush(QIOChannel *ioc,
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..0f2a5c2b5f 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -37,6 +37,12 @@
>  
>  #define SOCKET_MAX_FDS 16
>  
> +#ifdef QEMU_MSG_ZEROCOPY
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             bool block,
> +                                             Error **errp);
> +#endif
> +
>  SocketAddress *
>  qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                       Error **errp)
> @@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>      size_t fdsize = sizeof(int) * nfds;
>      struct cmsghdr *cmsg;
>      int sflags = 0;
> +    bool zero_copy_flush_pending = TRUE;

I'd call it zerocopy_flush_once = FALSE.  "pending" may imply it needs to
be done at some point, but it's not always needed, afaict.  It's a throttle
that "if try it we should try no more than once" - logically speaking there
must be no concurrent writters to the same iochannel, it means if it's
about fallback messages eating up the optmem limit, one flush should always
work, or it must be some other real errors that we need to report, hence
"once".

I think we should also add a rich comment above the variable or the code
below to explain the issue.  It might make the code more readable too
without looking into git history.

>  
>      memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>  
> @@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>              goto retry;
>          case ENOBUFS:
>              if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> -                error_setg_errno(errp, errno,
> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> -                return -1;
> +                if (zero_copy_flush_pending) {
> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
> +                    if (ret < 0) {
> +                        error_setg_errno(errp, errno,
> +                                         "Zerocopy flush failed");
> +                        return -1;
> +                    }
> +                    zero_copy_flush_pending = FALSE;
> +                    goto retry;
> +                } else {
> +                    error_setg_errno(errp, errno,
> +                                     "Process can't lock enough memory for "
> +                                     "using MSG_ZEROCOPY");
> +                    return -1;
> +                }
>              }
>              break;
>          }
> @@ -725,8 +744,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>  
>  
>  #ifdef QEMU_MSG_ZEROCOPY
> -static int qio_channel_socket_flush(QIOChannel *ioc,
> -                                    Error **errp)
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             bool block,
> +                                             Error **errp)
>  {
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>      struct msghdr msg = {};
> @@ -734,7 +754,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>      struct cmsghdr *cm;
>      char control[CMSG_SPACE(sizeof(*serr))];
>      int received;
> -    int ret;
>  
>      if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>          return 0;
> @@ -744,16 +763,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>      msg.msg_controllen = sizeof(control);
>      memset(control, 0, sizeof(control));
>  
> -    ret = 1;
> -
>      while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
>          received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
>          if (received < 0) {
>              switch (errno) {
>              case EAGAIN:
> -                /* Nothing on errqueue, wait until something is available */
> -                qio_channel_wait(ioc, G_IO_ERR);
> -                continue;
> +                if (block) {
> +                    /* Nothing on errqueue, wait until something is
> +                     * available.
> +                     */
> +                    qio_channel_wait(ioc, G_IO_ERR);
> +                    continue;
> +                }
> +                return 0;
>              case EINTR:
>                  continue;
>              default:
> @@ -790,14 +812,15 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>  
>          /* No errors, count successfully finished sendmsg()*/
>          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> -
> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            ret = 0;
> -        }

We could attach a tracepoint to not lose the debug-ability showing whether
zerocopy is working or got falled back.

>      }
>  
> -    return ret;
> +    return 0;
> +}
> +
> +static int qio_channel_socket_flush(QIOChannel *ioc,
> +                                    Error **errp)
> +{
> +    return qio_channel_socket_flush_internal(ioc, true, errp);
>  }
>  
>  #endif /* QEMU_MSG_ZEROCOPY */
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 49c26daed3..4533ce91ae 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -138,11 +138,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>              monitor_printf(mon, "postcopy ram: %" PRIu64 " kbytes\n",
>                             info->ram->postcopy_bytes >> 10);
>          }
> -        if (info->ram->dirty_sync_missed_zero_copy) {
> -            monitor_printf(mon,
> -                           "Zero-copy-send fallbacks happened: %" PRIu64 " times\n",
> -                           info->ram->dirty_sync_missed_zero_copy);
> -        }
>      }
>  
>      if (info->xbzrle_cache) {
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 05290ade76..80a3d4be93 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -50,11 +50,6 @@ typedef struct {
>       * Number of times we have synchronized guest bitmaps.
>       */
>      Stat64 dirty_sync_count;
> -    /*
> -     * Number of times zero copy failed to send any page using zero
> -     * copy.
> -     */
> -    Stat64 dirty_sync_missed_zero_copy;
>      /*
>       * Number of bytes sent at migration completion stage while the
>       * guest is stopped.
> diff --git a/migration/migration.c b/migration/migration.c
> index 1833cfe358..2ab19ca858 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1231,8 +1231,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->mbps = s->mbps;
>      info->ram->dirty_sync_count =
>          stat64_get(&mig_stats.dirty_sync_count);
> -    info->ram->dirty_sync_missed_zero_copy =
> -        stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
>      info->ram->postcopy_requests =
>          stat64_get(&mig_stats.postcopy_requests);
>      info->ram->page_size = page_size;
> diff --git a/migration/multifd.c b/migration/multifd.c
> index dfb5189f0e..ee6b2d3cba 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -607,9 +607,6 @@ static int multifd_zero_copy_flush(QIOChannel *c)
>          error_report_err(err);
>          return -1;
>      }
> -    if (ret == 1) {
> -        stat64_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
> -    }

If we want to remove this, we need to remove the variable in QAPI too.

# @dirty-sync-missed-zero-copy: Number of times dirty RAM
#     synchronization could not avoid copying dirty pages.  This is
#     between 0 and @dirty-sync-count * @multifd-channels.  (since
#     7.1)

Personally I'd remove it directly, but others may not always agree... in
this case, the safe approach is to mark it deprecate and update this in
docs/about/deprecated.rst.  Then you can leave it to us to finally remove
this entry (or send another patch after two qemu releases).

Thanks,

>  
>      return ret;
>  }
> -- 
> 2.43.0
> 

-- 
Peter Xu


