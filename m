Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203A5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCnQr-0000sc-BV; Thu, 30 May 2024 17:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCnQp-0000sM-5A
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCnQn-0008NF-5C
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717104928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGk2CD6bOnT/Y70P3TBm9qy5rPMkzd64vG0dcrmZIPU=;
 b=iKEnMNNRpR2wmnf/ZpmkS4tEx0jnhVfmw5aFvKkSokvfTwhxWygTtyBl63naj1XtkdGe0B
 iEs8f3x8uU4cUw12kG5+Rx84Hi5Vjux3Xzl7UxhaQR18COpAOkaI848DBhMLZtwgHJXQ4o
 29gH2mfkHHB8oN/F7ZAXyrCn6doT0xc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-ChKcPztpPvSLhgKMRCM9Xg-1; Thu, 30 May 2024 17:35:26 -0400
X-MC-Unique: ChKcPztpPvSLhgKMRCM9Xg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ae84cc4a67so116696d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717104926; x=1717709726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGk2CD6bOnT/Y70P3TBm9qy5rPMkzd64vG0dcrmZIPU=;
 b=oEzJdgRH8BBThNW6v57TZMdGiJatHUCeB7MruZJOeC5k2EfzeZ9r13Qa9qhwWl+kJV
 N1nmn87tLGzGiCM/pstMqCgnEeVDwGird6o5rLYI3ENi8W9YG4Cg/K2gxTHFb7oXwnrZ
 uVYV1fKzL8ZCsl40EUTsOMNWHYvBChZ4I21kFZzAzfthErPpM81pXF0i7t60sb93mA15
 Nq0XUrwvTrs9yIjGo1mOm9hmhtb3cn5nxnr/g6ZQoajVy5WbpZ7GkT31EkrkXRQ9+d/R
 4ZVc66IeGn0ct6C+y2vMoJB9MV1mJ+kBRZBpTWDPHydN5T9HlDrIgyQZlnbBwhH1CjeZ
 AVNw==
X-Gm-Message-State: AOJu0YwLHnyIObArD3XM3oARP81VsU1R175bW/m7rhqPlK6fJnkc+dMc
 kO8yrGvSPrLB87EPC1nxzcJ/fAl3YDiviKdCdg8R5J4JihNtyYEdCQ7EJa6v7pQMkaN+5gT3RH7
 j55161NwqrNcgD6cD28vmgv1XIvwXv0o2QEREoIWrD7aqP06Ixr8k
X-Received: by 2002:ad4:5b84:0:b0:69b:1c6d:9a64 with SMTP id
 6a1803df08f44-6aecd7368efmr1269336d6.4.1717104925913; 
 Thu, 30 May 2024 14:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt5SukgRHzzBA8Ivw17goYUgkaQzeckp0YvC+418cZ8nWw6VV75J+t+uIV7VZFO3xL2SGmzg==
X-Received: by 2002:ad4:5b84:0:b0:69b:1c6d:9a64 with SMTP id
 6a1803df08f44-6aecd7368efmr1268966d6.4.1717104925303; 
 Thu, 30 May 2024 14:35:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a73fa69sm1889556d6.19.2024.05.30.14.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 14:35:24 -0700 (PDT)
Date: Thu, 30 May 2024 17:35:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 11/18] migration/multifd: Add direct-io support
Message-ID: <ZljxGhSFhMFKt584@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 23, 2024 at 04:05:41PM -0300, Fabiano Rosas wrote:
> When multifd is used along with mapped-ram, we can take benefit of a
> filesystem that supports the O_DIRECT flag and perform direct I/O in
> the multifd threads. This brings a significant performance improvement
> because direct-io writes bypass the page cache which would otherwise
> be thrashed by the multifd data which is unlikely to be needed again
> in a short period of time.
> 
> To be able to use a multifd channel opened with O_DIRECT, we must
> ensure that a certain aligment is used. Filesystems usually require a
> block-size alignment for direct I/O. The way to achieve this is by
> enabling the mapped-ram feature, which already aligns its I/O properly
> (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).
> 
> By setting O_DIRECT on the multifd channels, all writes to the same
> file descriptor need to be aligned as well, even the ones that come
> from outside multifd, such as the QEMUFile I/O from the main migration
> code. This makes it impossible to use the same file descriptor for the
> QEMUFile and for the multifd channels. The various flags and metadata
> written by the main migration code will always be unaligned by virtue
> of their small size. To workaround this issue, we'll require a second
> file descriptor to be used exclusively for direct I/O.
> 
> The second file descriptor can be obtained by QEMU by re-opening the
> migration file (already possible), or by being provided by the user or
> management application (support to be added in future patches).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c      | 31 ++++++++++++++++++++++++++-----
>  migration/file.h      |  1 -
>  migration/migration.c | 23 +++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index ba5b5c44ff..ac4d206492 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -50,12 +50,31 @@ void file_cleanup_outgoing_migration(void)
>      outgoing_args.fname = NULL;
>  }
>  
> +static void file_enable_direct_io(int *flags)
> +{
> +#ifdef O_DIRECT
> +    if (migrate_direct_io()) {
> +        *flags |= O_DIRECT;
> +    }
> +#else
> +    /* it should have been rejected when setting the parameter */
> +    g_assert_not_reached();
> +#endif
> +}
> +
>  bool file_send_channel_create(gpointer opaque, Error **errp)
>  {
>      QIOChannelFile *ioc;
>      int flags = O_WRONLY;
>      bool ret = true;
>  
> +    /*
> +     * Attempt to enable O_DIRECT for the secondary channels. These
> +     * are used for sending ram pages and writes should be guaranteed
> +     * to be aligned to at least page size.
> +     */
> +    file_enable_direct_io(&flags);

Call this only if enabled?  That looks clearer, IMHO:

       if (migrate_direct_io()) {
           file_enable_direct_io(&flags);
       }

Then:

static void file_enable_direct_io(int *flags)
{
#ifdef O_DIRECT
    *flags |= O_DIRECT;
#else
    /* it should have been rejected when setting the parameter */
    g_assert_not_reached();
#endif
}

If you remember we have similar multifd calls, and I hoped all multifd
functions are only invoked when multifd is enabled first.  Same thing.

> +
>      ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
>      if (!ioc) {
>          ret = false;
> @@ -116,21 +135,23 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
>      return G_SOURCE_REMOVE;
>  }
>  
> -void file_create_incoming_channels(QIOChannel *ioc, Error **errp)
> +static void file_create_incoming_channels(QIOChannel *ioc, char *filename,
> +                                          Error **errp)
>  {
> -    int i, fd, channels = 1;
> +    int i, channels = 1;
>      g_autofree QIOChannel **iocs = NULL;
> +    int flags = O_RDONLY;
>  
>      if (migrate_multifd()) {
>          channels += migrate_multifd_channels();
> +        file_enable_direct_io(&flags);

Same here.

Other than that looks good.

Thanks,

>      }
>  
>      iocs = g_new0(QIOChannel *, channels);
> -    fd = QIO_CHANNEL_FILE(ioc)->fd;
>      iocs[0] = ioc;
>  
>      for (i = 1; i < channels; i++) {
> -        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
> +        QIOChannelFile *fioc = qio_channel_file_new_path(filename, flags, 0, errp);
>  
>          if (!fioc) {
>              while (i) {
> @@ -170,7 +191,7 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>          return;
>      }
>  
> -    file_create_incoming_channels(QIO_CHANNEL(fioc), errp);
> +    file_create_incoming_channels(QIO_CHANNEL(fioc), filename, errp);
>  }
>  
>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
> diff --git a/migration/file.h b/migration/file.h
> index 7699c04677..9f71e87f74 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -20,7 +20,6 @@ void file_start_outgoing_migration(MigrationState *s,
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
>  void file_cleanup_outgoing_migration(void);
>  bool file_send_channel_create(gpointer opaque, Error **errp);
> -void file_create_incoming_channels(QIOChannel *ioc, Error **errp);
>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>                              int niov, RAMBlock *block, Error **errp);
>  int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
> diff --git a/migration/migration.c b/migration/migration.c
> index e1b269624c..e03c80b3aa 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -155,6 +155,16 @@ static bool migration_needs_seekable_channel(void)
>      return migrate_mapped_ram();
>  }
>  
> +static bool migration_needs_extra_fds(void)
> +{
> +    /*
> +     * When doing direct-io, multifd requires two different,
> +     * non-duplicated file descriptors so we can use one of them for
> +     * unaligned IO.
> +     */
> +    return migrate_multifd() && migrate_direct_io();
> +}
> +
>  static bool transport_supports_seeking(MigrationAddress *addr)
>  {
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> @@ -164,6 +174,12 @@ static bool transport_supports_seeking(MigrationAddress *addr)
>      return false;
>  }
>  
> +static bool transport_supports_extra_fds(MigrationAddress *addr)
> +{
> +    /* file: works because QEMU can open it multiple times */
> +    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
> +}
> +
>  static bool
>  migration_channels_and_transport_compatible(MigrationAddress *addr,
>                                              Error **errp)
> @@ -180,6 +196,13 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>          return false;
>      }
>  
> +    if (migration_needs_extra_fds() &&
> +        !transport_supports_extra_fds(addr)) {
> +        error_setg(errp,
> +                   "Migration requires a transport that allows for extra fds (e.g. file)");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> -- 
> 2.35.3
> 
> 

-- 
Peter Xu


