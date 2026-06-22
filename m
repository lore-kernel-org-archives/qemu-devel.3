Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54550CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhRG-0006Vg-Gq; Mon, 22 Jun 2026 12:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbhRF-0006VX-AL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbhRC-0005ls-TV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782145432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUf8Xg3Wl1nfER5KGL1ai1vi87qQ099gttOsuTRPKhw=;
 b=QrIxYmmjE4Pixk4ntYAtnHQtKkKULfYj8I/X/sYqUY3R0dzaWuM0GW+0hCh/G6KBwIEBOM
 /25oI9UVcViz9a+ekQ2/1oQo5FNIbu5s39lWs20PV7eOEJZV6wxeiHvCxR7eX3ld7mFl5b
 D+vYAXZ2683QMoPBznMYnmyAqlQu7PM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-38oaEeIePqWMJT-gx4IOqg-1; Mon, 22 Jun 2026 12:23:51 -0400
X-MC-Unique: 38oaEeIePqWMJT-gx4IOqg-1
X-Mimecast-MFC-AGG-ID: 38oaEeIePqWMJT-gx4IOqg_1782145431
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7e9dbc4039bso1151347b3.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782145431; x=1782750231; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xUf8Xg3Wl1nfER5KGL1ai1vi87qQ099gttOsuTRPKhw=;
 b=UbrUlrauOv5nKRq1Uc/P1E4f7kFhDiOlQQTst2qX0CD2YdWcDJwl+ej67POPnya3E0
 4SFUPcx5et6a6rs+MZsZiVkHMxx6008ii7iPtjLcH11o6f6JsqxZEd0Fs0Erp6r/4T7g
 6+qwFuznO9PS/ub/uIE2WeTJHToXSvrw1Bxg1Vz167MxuuTKeoCqIJG6H+sbIrEm54Ts
 u4l09c7dQnhkSn7e/CWeM9igNoY50XX4SyEpT7S6lBunnnv/fLhzqqWixMxXHPYlFc2j
 uYVWMWTOdX0LG1URSy6usJZ0tmobpIm1zURzk+93bXf0y3yUAEpA6VGfHqi91Ari3Ztf
 tVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782145431; x=1782750231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUf8Xg3Wl1nfER5KGL1ai1vi87qQ099gttOsuTRPKhw=;
 b=oFRzeSXAlTubpQh8O9AKRwpvae58PggXN+opEhRy5kEC5scpPAS79RK4/vGNTX1ONl
 xSKp4xFG9HvUyX2QdVNslHfc1tRi0dgb4FfXDLyhIphrPldOAyAEwsWvcyfOp71zrlXW
 4khbux3NeMdG/qJw4i5wbYCN8ifKotkitk53GxGnfQdFtPk7QEyLprI6H1NGSr+FFgKm
 Fm80+KpxKX+Ri81rhUxKE4xwbqkuTLGXLqH+38SypCnHc8X2p2yXUb2pUlyABXjLOqWB
 zBxaQw2tGB06cp0xfd9LrjJrAriy4GkDNTJRQe1a2TeCibqoJuo/NiOmMkY5USHSmSyU
 DhAw==
X-Gm-Message-State: AOJu0Yw5aCVF7XwJSLT3G+R6tCryCa7W3B8Cra7EnLcRDNjs47FbMMrN
 QOwzeUnn2P6oVDduLhoZemieAi7CCIMdNjrDn9i2IBMFFzV0n5E9ErMm2slChIgMZxDQPwFWXZZ
 H+ea2ZwPVV1ifqt/sg5LNFSsza7rhDUG7bcTnmnLF+XLwQnYdLSeGCH+T
X-Gm-Gg: AfdE7cm/VQSq+9RYCMpmOclZfUmNkL8hjemjXllCDrhi/aaS8LQgNzmS0Fuc5cU/DG3
 PTxoSSEKj6PMHUX/PDFJt6KctsNzObnSu6iL6a4c1pTZr2aI3rEtkAu8v/ZG4kknpTAXbRL0GUn
 TsexxB7FSNZuf7Lj+u0NjtqYTPwH2ZuYiyDsnRLPbYiOBRPXlyMBMfX5jTDQFlvoxOh56tvMMLl
 4lSajDW2J/v8O4pne7wZgzekZfVO8/x3fXM6Km4OKj7XcMCZz8IaAtLTcXRD09zzC9Psh4diQBH
 oOGU1ZWRStzmJvglk3Czq9KS7VdYpc6VmJtoJLhM/IuCCb2GMOHRzg/u+KFZDtzWuwQSAxDZ77O
 VSZhU
X-Received: by 2002:a05:690c:288:b0:7e1:e496:ad86 with SMTP id
 00721157ae682-80671832828mr2526957b3.12.1782145430545; 
 Mon, 22 Jun 2026 09:23:50 -0700 (PDT)
X-Received: by 2002:a05:690c:288:b0:7e1:e496:ad86 with SMTP id
 00721157ae682-80671832828mr2526297b3.12.1782145429850; 
 Mon, 22 Jun 2026 09:23:49 -0700 (PDT)
Received: from x1.local ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df823ab84esm98799516d6.37.2026.06.22.09.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 09:23:48 -0700 (PDT)
Date: Mon, 22 Jun 2026 12:23:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 1/5] migration: add RAM Block fields and helpers for
 fast snapshot load
Message-ID: <ajlhiEZ4TdBFvdMu@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618032010.88755-2-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 18, 2026 at 08:50:06AM +0530, Aadeshveer Singh wrote:
> Add two fields per RAMBlock:
> 
> - nonzeropages: Mirrors the mapped-ram bitmap for storing which pages
>   are present in file and which are zero.
> - pending_bmap: Bitmap to store internal state of which pages have been
>   read by some thread to ensure coordination between threads.
> 
> Both fields are allocated and initialized in ram_load_setup and freed in
> ram_load_cleanup. nonzeropages is populated in parse_ramblock_mapped_ram
> eliminating the use of a temporary bitmap.
> 
> Change ram_load() to load using ram_load_precopy() in case of fast
> snapshot load.
> 
> Also add migrate_fast_snapshot_load() returning true when both
> postcopy-ram and mapped-ram capabilities are set.
> 
> Update qemu_get_buffer_at() to not set error to make it thread safe. All
> the callers of qemu_get_buffer_at(), take care of error handling.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  include/system/ramblock.h |  8 +++++
>  migration/options.c       |  5 ++++
>  migration/options.h       |  1 +
>  migration/qemu-file.c     | 10 +------
>  migration/ram.c           | 61 ++++++++++++++++++++++++++++++++-------
>  5 files changed, 65 insertions(+), 20 deletions(-)
> 
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index 4435f8d55f..73275d0459 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -60,6 +60,14 @@ struct RAMBlock {
>  
>      /* Bitmap of already received pages.  Only used on destination side. */
>      unsigned long *receivedmap;
> +    /* Bitmap of zero pages. Used for fast snapshot load. */
> +    unsigned long *nonzeropages;

We have file_bmap, only used on source for now.  I think we can safely
reuse it by caching the pointer allocated.

> +    /*
> +     * Bitmap for pages that are yet to be read from disk. It is required for
> +     * fault thread and eager thread to keep note of which pages are currently
> +     * being read. Used by fast snapshot load.
> +     */
> +    unsigned long *pending_bmap;

We have receivedmap right above, and it's always allocated on dest.  IIUC
we can directly use it.

It's also already set by uffd helpers, see qemu_ufd_copy_ioctl().
Currently it's a bit ugly put under a "if (!ret)"..  if you want you can
clean it up a bit.

There, we may want to skip page_requested or page_request_mutex operations
for file load because they're not necessary.

>  
>      /*
>       * bitmap to track already cleared dirty bitmap.  When the bit is
> diff --git a/migration/options.c b/migration/options.c
> index 5cbfd29099..5f80dd5b42 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -467,6 +467,11 @@ bool migrate_rdma(void)
>      return s->rdma_migration;
>  }
>  
> +bool migrate_fast_snapshot_load(void)
> +{
> +    return migrate_mapped_ram() && migrate_postcopy_ram();
> +}
> +
>  typedef enum WriteTrackingSupport {
>      WT_SUPPORT_UNKNOWN = 0,
>      WT_SUPPORT_ABSENT,
> diff --git a/migration/options.h b/migration/options.h
> index b46221998a..a81ca40d23 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -54,6 +54,7 @@ bool migrate_multifd_flush_after_each_section(void);
>  bool migrate_postcopy(void);
>  bool migrate_rdma(void);
>  bool migrate_tls(void);
> +bool migrate_fast_snapshot_load(void);
>  
>  /* capabilities helpers */
>  
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index d5a48115bd..602ece1b74 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -553,17 +553,9 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>  size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
>                            off_t pos)
>  {
> -    Error *err = NULL;
> -
> -    if (f->last_error) {
> -        return 0;
> -    }

Let's keep this line, this is thread-safe and if we have a prior error it
seems still reasonable to return immediately.  Then leave below one line
change to be a small separate patch would be nicer.

> -
> -    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
> -        qemu_file_set_error_obj(f, -EIO, err);
> +    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, NULL) < 0) {
>          return 0;
>      }
> -
>      return buflen;
>  }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index fc38ffbf8a..c2bacf3dfc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -252,6 +252,31 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
>      return ret;
>  }
>  
> +static void ramblock_non_zero_map_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb)
> +    {

Let's follow QEMU's coding style, see:

https://qemu-project.gitlab.io/qemu/devel/style.html#block-structure

So:

    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
        ...
    }

The other thing is, if we pre-allocate this bmap, then it might be wise to
double check this size suites what to be read later in the snapshot file
header, in parse_ramblock_mapped_ram().  We can fail the load immediately
if we found the size requested in header is larger than what is allocated
here (aka, max_length).

We have some length checks, like:

    if (length != block->used_length) {
        ret = qemu_ram_resize(block, length, &local_err);
        if (local_err) {
            error_report_err(local_err);
            return ret;
        }
    }

But I think that != isn't as safe.. we should likely check max_length
first.  This can also be a separate patch just to introduce the file_bmap
to RAMBlock, so that sync mapped-ram can already use it.

> +        assert(!rb->nonzeropages);
> +        size_t size = rb->max_length >> qemu_target_page_bits();
> +        rb->nonzeropages = bitmap_new(size);
> +    }
> +}
> +
> +static void ramblock_pending_bmap_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb)
> +    {

Similar indent issue, IIUC this function can be dropped after reusing
receivedmap.

> +        assert(!rb->pending_bmap);
> +        size_t size = rb->max_length >> qemu_target_page_bits();
> +        rb->pending_bmap = bitmap_new(size);
> +        bitmap_set(rb->pending_bmap, 0, size);
> +    }
> +}
> +
>  static void ramblock_recv_map_init(void)
>  {
>      RAMBlock *rb;
> @@ -3749,6 +3774,12 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
>      xbzrle_load_setup();
>      ramblock_recv_map_init();
> +    if (migrate_mapped_ram()) {
> +        ramblock_non_zero_map_init();
> +    }
> +    if (migrate_fast_snapshot_load()) {
> +        ramblock_pending_bmap_init();
> +    }
>  
>      return 0;
>  }
> @@ -3768,6 +3799,10 @@ static int ram_load_cleanup(void *opaque)
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          g_free(rb->receivedmap);
>          rb->receivedmap = NULL;
> +        g_free(rb->pending_bmap);
> +        rb->pending_bmap = NULL;
> +        g_free(rb->nonzeropages);
> +        rb->nonzeropages = NULL;

For new code, IMHO we can use g_clear_pointer().

>      }
>  
>      return 0;
> @@ -4102,7 +4137,7 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>              host = host_from_ram_block_offset(block, offset);
>              if (!host) {
>                  error_setg(errp, "page outside of ramblock %s range",
> -                           block->idstr);
> +                            block->idstr);

Looks like irrelevant line changes, let's try to not touch them if they're
not needed.

>                  return false;
>              }
>  
> @@ -4110,10 +4145,10 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>  
>              if (migrate_multifd()) {
>                  read = ram_load_multifd_pages(host, size,
> -                                              block->pages_offset + offset);
> +                                                block->pages_offset + offset);
>              } else {
>                  read = qemu_get_buffer_at(f, host, size,
> -                                          block->pages_offset + offset);
> +                                            block->pages_offset + offset);

Same here.

>              }
>  
>              if (!read) {
> @@ -4142,7 +4177,6 @@ err:
>  static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>                                        ram_addr_t length, Error **errp)
>  {
> -    g_autofree unsigned long *bitmap = NULL;
>      MappedRamHeader header;
>      size_t bitmap_size;
>      long num_pages;
> @@ -4174,15 +4208,18 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>      num_pages = length / header.page_size;
>      bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>  
> -    bitmap = g_malloc0(bitmap_size);
> -    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> +    if (qemu_get_buffer_at(f, (uint8_t *)block->nonzeropages, bitmap_size,
>                             header.bitmap_offset) != bitmap_size) {
>          error_setg(errp, "Error reading dirty bitmap");
>          return;
>      }
>  
> -    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
> -        return;
> +    if (!migrate_fast_snapshot_load()) {

Nitpick: when reaching here it must have mapped-ram enabled, we can
directly check migrate_postcopy_ram() here.

> +        /* Do not load RAM during setup for fast snapshot load */
> +        if (!read_ramblock_mapped_ram(f, block, num_pages, block->nonzeropages,
> +                                      errp)) {
> +            return;
> +        }
>      }
>  
>      /* Skip pages array */
> @@ -4460,9 +4497,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      static uint64_t seq_iter;
>      /*
>       * If system is running in postcopy mode, page inserts to host memory must
> -     * be atomic
> +     * be atomic. However, fast snapshot load uses the mapped ram precopy like
> +     * path to read block headers and populating bitmaps.
>       */
> -    bool postcopy_running = postcopy_is_running();
> +    bool load_using_postcopy =
> +        postcopy_is_running() && !migrate_fast_snapshot_load();

I think this change is correct, it's just that I believe it'll be hard to
follow for most readers.

Here, what you really need is to parse the ramblock headers only, it's just
that we used to have both steps (RAM setup + precopy) all processed in the
same ram_load_precopy() function, and here you want to leverage the "RAM
setup" phase only.

Maybe rename the bool to load_postcopy_pages?  That may help to explain why
in your case postcopy-ram=on but you don't set this bool to true: it's
because your case doesn't need to load any page in postcopy way.

Maybe something like this to be slightly more verbose:

  bool ram_should_load_postcopy_pages(void)
  {
      /* This is pure precopy, we don't need to load pages in postcopy way */
      if (!postcopy_is_running()) {
          return false;
      }

      /*
       * This is postcopy, but when with mapped-ram, pages are not loaded
       * in the migration stream here, but done separately in a thread eagerly
       * reading pages from the snapshot.  Here, we only need to read the
       * ram headers, reusing the precopy code.  TODO: when we have separate 
       * function to parse RAM headers we should switch to that.
       */
       if (migrate_mapped_ram()) {
           return false;
       }

       /*
        * Genuine network postcopy, we will load pages in this current stream
        * and they need to be done in postcopy way.
        */
       return true;
  }

  ...
  bool load_postcopy_pages = ram_expects_postcopy_pages();

Thanks,

>  
>      seq_iter++;
>  
> @@ -4478,7 +4517,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>       */
>      trace_ram_load_start();
>      WITH_RCU_READ_LOCK_GUARD() {
> -        if (postcopy_running) {
> +        if (load_using_postcopy) {
>              /*
>               * Note!  Here RAM_CHANNEL_PRECOPY is the precopy channel of
>               * postcopy migration, we have another RAM_CHANNEL_POSTCOPY to
> -- 
> 2.54.0
> 

-- 
Peter Xu


