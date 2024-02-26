Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F5EC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWPp-0004i7-QU; Mon, 26 Feb 2024 03:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWOE-0003EA-KQ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWO9-0005oJ-7Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708936262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehh8HHa4YTzAiuwVe91iFBopB2xrbqyhg7LBE0nMtA8=;
 b=aGLh3pUO8S+JO225fNulIALl8fQXd061dCHe58EFvzoZPZzYOG6VQ7pNGV5MzBz5oHwIih
 XVHeG1JUSnA9ApA4bxQJZo7HRIF7kmKl4A1XlxvT1dwZ019GbPqXRwC8gMwseL2ygB3kxX
 m2ES53bA4fGrbtRnOzGF/vHZOujvQ+8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-V7u_BN4wM4ah23FwvdVC1g-1; Mon, 26 Feb 2024 03:31:01 -0500
X-MC-Unique: V7u_BN4wM4ah23FwvdVC1g-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so1325750a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936260; x=1709541060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehh8HHa4YTzAiuwVe91iFBopB2xrbqyhg7LBE0nMtA8=;
 b=M+REs5THhkCwO3UfpWesn3z9nc5PAQCv6EcmbdUtllt3BwGh7qiuDjBkH88OaDzZnb
 iG6uBaia8Vh0hm1+4xNHtN1KGa/xBo7xetm2t2YwOh5j/iXDIcQIRZ5rSdXX/0dSB5iG
 F/qKyHfxU7PO7nIOSM/NN4FoZNb2AqDDXAy5BF+IhTp91NxhHp8YWlx9LSwFFdmt2/o6
 yoJRUx+YGuLGwWSa7wYhxeyzbGCf0dw+icxatg5HBvCJiunnuqDcvwQOjRtwR7dlxpMy
 NbXUOJYdbRa5mwsPukUaXvzcAVPT5S81EzVr0JLqEOnzaeZ/fFVCB0rxM3C94jvCmqtj
 OHdg==
X-Gm-Message-State: AOJu0Yz+5bzZ0pCCoj7u5txSSyb2VZQqgDQzczWBGRixU/yw78QZ6p9I
 JYXZ1s21GR/bMouYdEarskv1cAZaq9POt6icfVdj4sbbu3k+X78vNfUhagRnbyONXJLnkc4b4Nn
 ZroOpuV6XpH3FizDARdcWMylQ8m4orjmtCxCJXk72kW4fzkdH4iG+
X-Received: by 2002:aa7:8011:0:b0:6e4:68fa:f1ff with SMTP id
 j17-20020aa78011000000b006e468faf1ffmr7974078pfi.0.1708936259743; 
 Mon, 26 Feb 2024 00:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4HpUO6egqVP9+3FmXdzD5p23y1LmTykhnrWUF9zwWAbG/FzQyG3JNeC/lAd1EKJ4iPPPo0A==
X-Received: by 2002:aa7:8011:0:b0:6e4:68fa:f1ff with SMTP id
 j17-20020aa78011000000b006e468faf1ffmr7974057pfi.0.1708936259275; 
 Mon, 26 Feb 2024 00:30:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jw8-20020a056a00928800b006e4e4c80e3fsm2935842pfb.29.2024.02.26.00.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:58 -0800 (PST)
Date: Mon, 26 Feb 2024 16:30:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 24/34] migration/multifd: Support incoming fixed-ram
 stream format
Message-ID: <ZdxMPMjNu929JrQP@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-25-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-25-farosas@suse.de>
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

On Tue, Feb 20, 2024 at 07:41:28PM -0300, Fabiano Rosas wrote:
> For the incoming fixed-ram migration we need to read the ramblock
> headers, get the pages bitmap and send the host address of each
> non-zero page to the multifd channel thread for writing.
> 
> Usage on HMP is:
> 
> (qemu) migrate_set_capability multifd on
> (qemu) migrate_set_capability fixed-ram on
> (qemu) migrate_incoming file:migfile
> 
> (the ram.h include needs to move because we've been previously relying
> on it being included from migration.c. Now file.h will start including
> multifd.h before migration.o is processed)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c    | 25 ++++++++++++++++++++++++-
>  migration/file.h    |  2 ++
>  migration/multifd.c | 34 ++++++++++++++++++++++++++++++----
>  migration/multifd.h |  2 ++
>  migration/ram.c     | 36 +++++++++++++++++++++++++++++++++---
>  5 files changed, 91 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 94e8e08363..1a18e608fc 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -13,7 +13,6 @@
>  #include "channel.h"
>  #include "file.h"
>  #include "migration.h"
> -#include "multifd.h"
>  #include "io/channel-file.h"
>  #include "io/channel-util.h"
>  #include "options.h"
> @@ -195,3 +194,27 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>  
>      return (ret < 0) ? -1 : 0;
>  }
> +
> +int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
> +{
> +    MultiFDRecvData *data = p->data;
> +    size_t ret;
> +    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +
> +    if (flags != MULTIFD_FLAG_NOCOMP) {
> +        error_setg(errp, "multifd %u: flags received %x flags expected %x",
> +                   p->id, flags, MULTIFD_FLAG_NOCOMP);
> +        return -1;
> +    }

This chunk can be dropped?  There's no packet in fixed-ram, this check is
no-op only because MULTIFD_FLAG_NOCOMP==0, iiuc.

The check should be done OTOH to make sure fixed-ram don't run together
with any multifd compressions enabled.  I remember we discussed this
before.  Is it still missing?  Note that multifd compression has its own
parameter (rather than the COMPRESS capability), it should be a check
against migrate_multifd_compression()==MULTIFD_COMPRESSION_NONE.

> +
> +    ret = qio_channel_pread(p->c, (char *) data->opaque,
> +                            data->size, data->file_offset, errp);
> +    if (ret != data->size) {
> +        error_prepend(errp,
> +                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
> +                      p->id, ret, data->size);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> diff --git a/migration/file.h b/migration/file.h
> index 390dcc6821..9fe8af73fc 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -11,6 +11,7 @@
>  #include "qapi/qapi-types-migration.h"
>  #include "io/task.h"
>  #include "channel.h"
> +#include "multifd.h"
>  
>  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
>  
> @@ -22,4 +23,5 @@ bool file_send_channel_create(gpointer opaque, Error **errp);
>  int file_send_channel_destroy(QIOChannel *ioc);
>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>                              int niov, RAMBlock *block, Error **errp);
> +int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
>  #endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b251c58ec2..a0202b5661 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -18,7 +18,6 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "file.h"
> -#include "ram.h"
>  #include "migration.h"
>  #include "migration-stats.h"
>  #include "socket.h"
> @@ -251,9 +250,9 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
>              p->iov[i].iov_len = p->page_size;
>          }
>          return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
> +    } else {
> +        return multifd_file_recv_data(p, errp);
>      }
> -
> -    return 0;
>  }
>  
>  static MultiFDMethods multifd_nocomp_ops = {
> @@ -1317,13 +1316,40 @@ void multifd_recv_cleanup(void)
>      multifd_recv_cleanup_state();
>  }
>  
> +
> +/*
> + * Wait until all channels have finished receiving data. Once this
> + * function returns, cleanup routines are safe to run.
> + */
> +static void multifd_file_recv_sync(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        trace_multifd_recv_sync_main_wait(p->id);
> +
> +        qemu_sem_post(&p->sem);
> +
> +        trace_multifd_recv_sync_main_signal(p->id);
> +        qemu_sem_wait(&p->sem_sync);
> +    }
> +    return;
> +}
> +
>  void multifd_recv_sync_main(void)
>  {
>      int i;
>  
> -    if (!migrate_multifd() || !multifd_use_packets()) {
> +    if (!migrate_multifd()) {
>          return;
>      }
> +
> +    if (!multifd_use_packets()) {
> +        return multifd_file_recv_sync();
> +    }
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 135f6ed098..8f89199721 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -13,6 +13,8 @@
>  #ifndef QEMU_MIGRATION_MULTIFD_H
>  #define QEMU_MIGRATION_MULTIFD_H
>  
> +#include "ram.h"
> +
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  
>  bool multifd_send_setup(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index ad540ae9ce..826ac745a0 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -111,6 +111,7 @@
>   * pages region in the migration file at a time.
>   */
>  #define FIXED_RAM_LOAD_BUF_SIZE 0x100000
> +#define FIXED_RAM_MULTIFD_LOAD_BUF_SIZE 0x100000
>  
>  XBZRLECacheStats xbzrle_counters;
>  
> @@ -3950,6 +3951,27 @@ void colo_flush_ram_cache(void)
>      trace_colo_flush_ram_cache_end();
>  }
>  
> +static size_t ram_load_multifd_pages(void *host_addr, size_t size,
> +                                     uint64_t offset)
> +{
> +    MultiFDRecvData *data = multifd_get_recv_data();
> +
> +    /*
> +     * Pointing the opaque directly to the host buffer, no
> +     * preprocessing needed.
> +     */
> +    data->opaque = host_addr;
> +

nit: unneeded newline?  There's a similar one in send side.  I'd drop the
comment altogether as it's not extremely helpful.  Maybe we can directly
use data->host_addr already (as it always reads chunk into a host buffer)?

> +    data->file_offset = offset;
> +    data->size = size;
> +
> +    if (!multifd_recv()) {
> +        return 0;
> +    }
> +
> +    return size;
> +}
> +
>  static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>                                      long num_pages, unsigned long *bitmap,
>                                      Error **errp)
> @@ -3959,6 +3981,8 @@ static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>      ram_addr_t offset;
>      void *host;
>      size_t read, unread, size;
> +    size_t buf_size = (migrate_multifd() ? FIXED_RAM_MULTIFD_LOAD_BUF_SIZE :
> +                       FIXED_RAM_LOAD_BUF_SIZE);

Are they the same?  Maybe we don't need the new one until we want to make
it different?

>  
>      for (set_bit_idx = find_first_bit(bitmap, num_pages);
>           set_bit_idx < num_pages;
> @@ -3977,10 +4001,16 @@ static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>                  return false;
>              }
>  
> -            size = MIN(unread, FIXED_RAM_LOAD_BUF_SIZE);
> +            size = MIN(unread, buf_size);
> +
> +            if (migrate_multifd()) {
> +                read = ram_load_multifd_pages(host, size,
> +                                              block->pages_offset + offset);
> +            } else {
> +                read = qemu_get_buffer_at(f, host, size,
> +                                          block->pages_offset + offset);
> +            }
>  
> -            read = qemu_get_buffer_at(f, host, size,
> -                                      block->pages_offset + offset);
>              if (!read) {
>                  goto err;
>              }
> -- 
> 2.35.3
> 

-- 
Peter Xu


