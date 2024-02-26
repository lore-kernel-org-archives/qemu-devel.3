Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C017C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reW2t-00081n-Mj; Mon, 26 Feb 2024 03:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reW2r-00081H-Hg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:09:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reW2p-0002Da-CB
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708934942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ZegQToPDmkWLS3PLXDH01RRUmEKyHvAo3iyuHAT6kY=;
 b=PhKOd1QK6UPUWmD98/BTKsvs+ZNROQgcwIMewq2lkY8Fd/Q5gDh6q5hjV1Hk5p6a0YFUs7
 8xpsXhpdcuN1tkD2pVw9QvmUJgoi+/OHNRRufip6lYX73WYuJ/8qAUwo7uj6A3+DLvrBTE
 nWYLGIy6rvUIK2mciidmj978te0+rE4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-VdIBnXbzOx2P_K9UCmH2LA-1; Mon, 26 Feb 2024 03:08:59 -0500
X-MC-Unique: VdIBnXbzOx2P_K9UCmH2LA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so714485a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934938; x=1709539738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZegQToPDmkWLS3PLXDH01RRUmEKyHvAo3iyuHAT6kY=;
 b=oxJ7Ra9LgE2l8lbTLTMfAt9ncVH59qzjq/D6hNrl2zFMjxLue3/bF0c6/dKXrvHZpO
 csGAwOb96D8CpVaEVgtOsYUJUFpABiWxtMsX4Eb3OU73KP+9hnJoEaS8IGIOsa4HcuhF
 qtV4WHCAfeLc+kTLUtgVJM0O2dFv166OUVB9iiqsq0ebN8TQLEPWe38Lqjbhwv4FpLsA
 bSb4qxDfvlHpvg3vXb606lJF0weSLBfC2YD0gFopKwkaF8WRpCGpHbL6C3oe8XkNhpsP
 8SUrF/fSH66AtfjdJ5NtkCjjEdsnlJlFtdIoVftzCSMtC4L12X8gHO4sRGEFplieAhuz
 O3Nw==
X-Gm-Message-State: AOJu0YwFJuwj0Dsr6jaec72vAFxgUYNBhCWB9JemrY8q6mbUkvNR7UX+
 wi0LZ0JyKwX+bBFVfH8LMkYUQPXjVJLewXvwgh3RrM2RPdyP7C+zHDbVCbdRVn3FjHnithAXrrs
 r63KGPCa57wjhAXs3IfV+Vr+HHxggKNuR5+a9Nx7LNlqSaOeNX0kT
X-Received: by 2002:a05:6a21:a5a4:b0:1a0:eac3:a1af with SMTP id
 gd36-20020a056a21a5a400b001a0eac3a1afmr8044212pzc.4.1708934938508; 
 Mon, 26 Feb 2024 00:08:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCoOPCpN24v0ROFA95ZpBz3tIjtDgPqv2Ghshymu97k2EHf2lTsZHb0IWosRA91lq5mYkuiQ==
X-Received: by 2002:a05:6a21:a5a4:b0:1a0:eac3:a1af with SMTP id
 gd36-20020a056a21a5a400b001a0eac3a1afmr8044200pzc.4.1708934938071; 
 Mon, 26 Feb 2024 00:08:58 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 li13-20020a170903294d00b001dba98889a3sm3399244plb.71.2024.02.26.00.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:08:57 -0800 (PST)
Date: Mon, 26 Feb 2024 16:08:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 23/34] migration/multifd: Support outgoing fixed-ram
 stream format
Message-ID: <ZdxHE70QYbs5MHM4@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-24-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-24-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Tue, Feb 20, 2024 at 07:41:27PM -0300, Fabiano Rosas wrote:
> The new fixed-ram stream format uses a file transport and puts ram
> pages in the migration file at their respective offsets and can be
> done in parallel by using the pwritev system call which takes iovecs
> and an offset.
> 
> Add support to enabling the new format along with multifd to make use
> of the threading and page handling already in place.
> 
> This requires multifd to stop sending headers and leaving the stream
> format to the fixed-ram code. When it comes time to write the data, we
> need to call a version of qio_channel_write that can take an offset.
> 
> Usage on HMP is:
> 
> (qemu) stop
> (qemu) migrate_set_capability multifd on
> (qemu) migrate_set_capability fixed-ram on
> (qemu) migrate_set_parameter max-bandwidth 0
> (qemu) migrate_set_parameter multifd-channels 8
> (qemu) migrate file:migfile
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Some nitpicks below.

> ---
>  include/qemu/bitops.h | 13 ++++++++++++
>  migration/file.c      | 47 +++++++++++++++++++++++++++++++++++++++++++
>  migration/file.h      |  2 ++
>  migration/migration.c | 12 ++++++-----
>  migration/multifd.c   | 24 ++++++++++++++++++++--
>  migration/options.c   | 14 +++++++------
>  migration/ram.c       | 17 +++++++++++++---
>  migration/ram.h       |  1 +
>  8 files changed, 114 insertions(+), 16 deletions(-)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index cb3526d1f4..2c0a2fe751 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -67,6 +67,19 @@ static inline void clear_bit(long nr, unsigned long *addr)
>      *p &= ~mask;
>  }
>  
> +/**
> + * clear_bit_atomic - Clears a bit in memory atomically
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + */
> +static inline void clear_bit_atomic(long nr, unsigned long *addr)
> +{
> +    unsigned long mask = BIT_MASK(nr);
> +    unsigned long *p = addr + BIT_WORD(nr);
> +
> +    return qatomic_and(p, ~mask);
> +}
> +
>  /**
>   * change_bit - Toggle a bit in memory
>   * @nr: Bit to change
> diff --git a/migration/file.c b/migration/file.c
> index a186dc592a..94e8e08363 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -148,3 +148,50 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>          error_setg(errp, "Error creating migration incoming channel");
>      }
>  }
> +
> +int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
> +                            int niov, RAMBlock *block, Error **errp)
> +{
> +    ssize_t ret = -1;
> +    int i, slice_idx, slice_num;
> +    uintptr_t base, next, offset;
> +    size_t len;
> +
> +    slice_idx = 0;
> +    slice_num = 1;
> +
> +    /*
> +     * If the iov array doesn't have contiguous elements, we need to
> +     * split it in slices because we only have one file offset for the
> +     * whole iov. Do this here so callers don't need to break the iov
> +     * array themselves.
> +     */
> +    for (i = 0; i < niov; i++, slice_num++) {
> +        base = (uintptr_t) iov[i].iov_base;
> +
> +        if (i != niov - 1) {
> +            len = iov[i].iov_len;
> +            next = (uintptr_t) iov[i + 1].iov_base;
> +
> +            if (base + len == next) {
> +                continue;
> +            }
> +        }
> +
> +        /*
> +         * Use the offset of the first element of the segment that
> +         * we're sending.
> +         */
> +        offset = (uintptr_t) iov[slice_idx].iov_base - (uintptr_t) block->host;

Wanna do a sanity check over offset v.s. block->used_length?

> +        ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
> +                                  block->pages_offset + offset, errp);
> +        if (ret < 0) {
> +            break;
> +        }
> +
> +        slice_idx += slice_num;
> +        slice_num = 0;
> +    }
> +
> +    return (ret < 0) ? -1 : 0;

IMHO we don't need to hide the negative ret, hence:

  return (ret < 0) ? ret : 0;

> +}
> diff --git a/migration/file.h b/migration/file.h
> index 90794b494b..390dcc6821 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -20,4 +20,6 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
>  
>  bool file_send_channel_create(gpointer opaque, Error **errp);
>  int file_send_channel_destroy(QIOChannel *ioc);
> +int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
> +                            int niov, RAMBlock *block, Error **errp);
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index e2218b9de7..32b291a282 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -134,12 +134,14 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>          SocketAddress *saddr = &addr->u.socket;
>  
> -        return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> -               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> -               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
> +        return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> +                saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> +                saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> +        return migrate_fixed_ram();
> +    } else {
> +        return false;
>      }
> -
> -    return false;
>  }
>  
>  static bool migration_needs_seekable_channel(void)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index cb5f4fb3e0..b251c58ec2 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -105,6 +105,17 @@ static bool multifd_use_packets(void)
>      return !migrate_fixed_ram();
>  }
>  
> +static void multifd_set_file_bitmap(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +
> +    assert(pages->block);
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i]);
> +    }
> +}
> +
>  /* Multifd without compression */
>  
>  /**
> @@ -181,6 +192,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>                  return -1;
>              }
>          }
> +    } else {
> +        multifd_set_file_bitmap(p);

PS: if you liked my other proposal, you can move this to the entry when
handing migrate_fixed_ram().

>      }
>  
>      return 0;
> @@ -860,8 +873,15 @@ static void *multifd_send_thread(void *opaque)
>                  break;
>              }
>  
> -            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
> -                                              0, p->write_flags, &local_err);
> +            if (migrate_fixed_ram()) {
> +                ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
> +                                              p->pages->block, &local_err);
> +            } else {
> +                ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
> +                                                  NULL, 0, p->write_flags,
> +                                                  &local_err);
> +            }
> +
>              if (ret != 0) {
>                  break;
>              }
> diff --git a/migration/options.c b/migration/options.c
> index 4909e5c72a..bfcd2d7132 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -654,12 +654,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_FIXED_RAM]) {
> -        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -            error_setg(errp,
> -                       "Fixed-ram migration is incompatible with multifd");
> -            return false;
> -        }
> -
>          if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
>              error_setg(errp,
>                         "Fixed-ram migration is incompatible with xbzrle");
> @@ -1252,6 +1246,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      }
>  #endif
>  
> +    if (migrate_fixed_ram() &&
> +        ((params->has_multifd_compression && params->multifd_compression) ||
> +         (params->tls_creds && *params->tls_creds))) {

migrate_tls()?

> +        error_setg(errp,
> +                   "Fixed-ram only available for non-compressed non-TLS multifd migration");
> +        return false;
> +    }

IIUC this could miss the case where one can set tls creds _before_ enable
fixed-ram cap?

We can also check both places but I always think it awkward to duplicates.

For cross-(cap+param) checks maybe we can use migrate_prepare()?

> +
>      if (params->has_x_vcpu_dirty_limit_period &&
>          (params->x_vcpu_dirty_limit_period < 1 ||
>           params->x_vcpu_dirty_limit_period > 1000)) {
> diff --git a/migration/ram.c b/migration/ram.c
> index c7050f6f68..ad540ae9ce 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1149,7 +1149,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>  
>      if (migrate_fixed_ram()) {
>          /* zero pages are not transferred with fixed-ram */
> -        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->file_bmap);
> +        clear_bit_atomic(offset >> TARGET_PAGE_BITS, pss->block->file_bmap);
>          return 1;
>      }
>  
> @@ -2445,8 +2445,6 @@ static void ram_save_cleanup(void *opaque)
>          block->clear_bmap = NULL;
>          g_free(block->bmap);
>          block->bmap = NULL;
> -        g_free(block->file_bmap);
> -        block->file_bmap = NULL;
>      }
>  
>      xbzrle_cleanup();
> @@ -3135,9 +3133,22 @@ static void ram_save_file_bmap(QEMUFile *f)
>          qemu_put_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
>                             block->bitmap_offset);
>          ram_transferred_add(bitmap_size);
> +
> +        /*
> +         * Free the bitmap here to catch any synchronization issues
> +         * with multifd channels. No channels should be sending pages
> +         * after we've written the bitmap to file.
> +         */
> +        g_free(block->file_bmap);
> +        block->file_bmap = NULL;
>      }
>  }
>  
> +void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset)
> +{
> +    set_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
> +}
> +
>  /**
>   * ram_save_iterate: iterative stage for migration
>   *
> diff --git a/migration/ram.h b/migration/ram.h
> index 9b937a446b..b9ac0da587 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -75,6 +75,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
>  bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
>  void postcopy_preempt_shutdown_file(MigrationState *s);
>  void *postcopy_preempt_thread(void *opaque);
> +void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset);
>  
>  /* ram cache */
>  int colo_init_ram_cache(void);
> -- 
> 2.35.3
> 

-- 
Peter Xu


