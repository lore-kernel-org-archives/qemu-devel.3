Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05C2C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wltI5-0004Nv-Q1; Mon, 20 Jul 2026 15:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltI4-0004Na-Ur
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltI1-0006K5-LX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784574271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySK18dgzTHtWxiDjDaDq29rI44XrWKYBinHmfat6lY0=;
 b=bodMlZQNsUzP5GOLrkMrznp1RAiHZ1qNbny7S3QmY+jLKyzzbuNbyHuSSUk3BMPxwOBRY+
 CMogpE/ny7lAmIvd8EivrJyVeUHUjiDRksZW7dq3ymYkzgcUX3GI2BTOe5HyvOFMbOh86j
 546vkgYuFH6D34PbzUzziI11ir6/W84=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-LZ1Y6DOOPYGW3l8CIy26ow-1; Mon, 20 Jul 2026 15:04:29 -0400
X-MC-Unique: LZ1Y6DOOPYGW3l8CIy26ow-1
X-Mimecast-MFC-AGG-ID: LZ1Y6DOOPYGW3l8CIy26ow_1784574268
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92d1cae5740so985010585a.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784574268; x=1785179068; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ySK18dgzTHtWxiDjDaDq29rI44XrWKYBinHmfat6lY0=;
 b=SF7RbE80yyuC/eKURSq5foUIxhBIcK9JNCF+AeHORsVwgzYcpI6waQVYERwixvcchO
 LHwSfS+vhkluj0viGoSbHFrOP7w3fSG0iJ+APJK22wja8taaxoU4DL69C3dBFk/HFAtU
 l5jmdF6GlmTfQTcBpGWcHpt4YE1kzrdM60/u4bdA66ykLqcpJdyHDR4G+7u8euwSpW1M
 giQDCJuRFOgvErK3Q21EUPLo/STS7lg84K13up/k6cIb9AdaYEM5BqWvW8IUp69FHZXS
 nMYIoBhEQWYTlo6yJ5uidQEGcthYPlwmuzgTnUvxeWI9zrJHoGPHJPksIOTRNF0WC3uJ
 kFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784574268; x=1785179068;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ySK18dgzTHtWxiDjDaDq29rI44XrWKYBinHmfat6lY0=;
 b=OsNBipMh/La7AZiBNEQ4pD6v8ww4+igXfC9XRWUWBfHlOWK5YRccD1wuWp1CTLQmOn
 SEKRRHwvnG0uw4yrfGUDwGsNW2qxo+0FvKNFYd6BSxlDlfIX3+mmgELC+JowqDGRV7uZ
 8s3v2+2dhMdaSzGxJuzQ8qM/vxwfk+Einm7lCliUQaWjmK0BFjtq2g4Bur1QTSlTFTTR
 SykcJf+OR50x/9s1yecdCuAMwHaKbKW8YrlA3Et2bMykKmP1mUA6oLER0Kkc8kFXwdgJ
 rbYW0NRC1cRP2hxuq0RUV+gRmJQFvk0eF0wYlYvETYU9+sivxoQFG5aI5ywhWrZ2giQd
 Eefg==
X-Gm-Message-State: AOJu0Yx9cgZacZVAfXrHXpSFZbe5AoOz2Vq/IANTxdB4WYbsE3G+x9Et
 TlMoO2LhsxJ7RmvsQj0EfzU+kxM1rHSd8AE1ZK2HYbx4QBt2PdkojrKCyGcBs7t3DbRutzlWmgS
 DsInODddE7Vt+vMquMHcyHf8wamwe/OYGNA29G2heBp6ZNcBW5uzkPjqb
X-Gm-Gg: AfdE7clpCEYuvpWfziRnU1XDPe2XxrjSWh0Az2Q0kWW0xk8hQqrfutEcUcNCLXpS49H
 O3qd/G/9lIE3OlUrXcaBYlKkyO2ZY7LG5yk9kC+Op9PP0IJfJeo+xVd9QdXYe+tX6HWxHLEoLDl
 c7IWxz1xwsBCrp+lmi0YoeLpn2ibUmzV2vA2xSa1fMRqKb//gYYAir57E6k0YRjLT3/G3U7AWb9
 ghBT6aV5irM2bDVEJoFrS7CMys0xpw7DirfCGJCFU6FFtDh16bnKkm/Ie0aPbgB8s1IQAWbgPBM
 rb2N2hbp4exboalqtSXwMFMUFAksDXolJVMgGlSzQfaMEsgRZ1lxDVys49vFh8j1L43j/Kr13bD
 KdynWkhPuxK98CyUuMLIitJPEIbWANtYgk+YYMJoTIQrxb0wXH44vckcCWo8=
X-Received: by 2002:a05:620a:d85:b0:92e:745c:6c59 with SMTP id
 af79cd13be357-930b416ec02mr1584930685a.55.1784574268375; 
 Mon, 20 Jul 2026 12:04:28 -0700 (PDT)
X-Received: by 2002:a05:620a:d85:b0:92e:745c:6c59 with SMTP id
 af79cd13be357-930b416ec02mr1584925485a.55.1784574267681; 
 Mon, 20 Jul 2026 12:04:27 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52dd3easm916076985a.3.2026.07.20.12.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:04:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:04:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 07/11] migration: add support for fault thread to load
 pages from disk
Message-ID: <al5xOKr1-8e-6iML@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-8-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-8-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:43PM +0530, Aadeshveer Singh wrote:
> In fast snapshot load, we would like to serve faults as soon as possible
> hence loading pages directly instead of requesting a source
> 
> Add postcopy_mapped_ram_load_page() function which serves single page
> fault by reading the snapshot file. It uses bitmap_test_and_clear_atomic
> on pending_bmap to coordinate between threads so each page is loaded
> exactly once. Non-zero pages are read using qemu_get_buffer_at into a
> temporary page (for loading page atomically), which is then placed using
> postcopy_place_page. Zero pages are placed directly using
> postcopy_place_page_zero.
> 
> Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> instead of requesting source in case of fast snapshot load. to_src_file
> check is bypassed in fast snapshot load case as there is no source.
> 
> Call try_mark_postcopy_blocktime_begin on every page fault to support
> postcopy-blocktime.
> 
> Allocate another channel in postcopy_temp_pages_setup(like the preempt
> case), for both the fault thread and eager thread to load pages
> independently.
> 
> Add function ramblock_file_bitmap_page_is_nonzero() which searches a
> range of bits corresponding to a page for a set bit. This is just a bit
> check for normal pages but for hugepages it checks the range to see if
> any part of page is non zero.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 121 +++++++++++++++++++++++++++++++++------
>  migration/ram.c          |  11 +++-
>  migration/ram.h          |   2 +
>  3 files changed, 116 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 2e2c9fae10..723070b5cd 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -949,6 +949,68 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                         pagesize);
>  }
>  
> +/**
> + * postcopy_mapped_ram_load_page() - Load a page to given host address.
> + * @mis: Migration Incoming State.
> + * @rb: RAMBlock from where page is loaded.
> + * @rb_offset: Offset of page in RAMBlock.
> + * @haddr: Base of page where to load in page.
> + * @channel: Used to identify between threads and use corresponding temp.
> + * @errp: Set error in case of failure
> + *
> + * Load a page from RAMBlock at offset at given host address. Used by postcopy
> + * ram fault thread and eager thread in fast snapshot load case.
> + *
> + * Return: True on success.
> + */
> +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> +                                          RAMBlock *rb, ram_addr_t rb_offset,
> +                                          uint64_t haddr, int channel,
> +                                          Error **errp)
> +{
> +    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
> +    size_t page;
> +    size_t read;
> +
> +    page = rb_offset / qemu_ram_pagesize(rb);
> +
> +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> +        if (ramblock_file_bitmap_page_is_nonzero(rb, page)) {

I discussed this part previously I think, but maybe not with details.  This
is fine but it is less optimal in two things:

- It relies on the mapped-ram pre-fill all zero pages to be zeros in the
  image, otherwise if you see a huge page having some but not all non-zero
  page, it'll fallback to always copy from image, then we start to read
  data from "zero page" ranges, which we never do before (in vanilla
  mapped-ram logic, we always skip ranges that represent zero pages).

- It is slightly less efficient, because we need to copy the zeros from the
  image even if we know they're zeros

IIUC it's better to loop over all guest pages on this specific host page
when preparing the place_source buffer, then do a one-shot place page.

NOTE: I believe in all paths you touched, you assumed host psize is always
>= guest psize.  Just to mention it's actually possible to have host psize
< guest psize. One case is ARM64 using 4K host psize to emulate 64K guest
psize.  But that's less of a problem; normally production users rarely use
such setup, IIUC, so I think we can put it aside for now (however I believe
migration core should work with such setup right now in general). But if
you can take that into account it'll be even better.

> +            /*
> +             * This can happen concurrently, but it's thread-safe because
> +             * qemu_get_buffer_at() is thread-safe, and the caller will be using
> +             * different temporary buffers.
> +             */
> +            read = qemu_get_buffer_at(mis->from_src_file, place_source,
> +                                      qemu_ram_pagesize(rb),
> +                                      rb->pages_offset + rb_offset, errp);
> +
> +            if (read != qemu_ram_pagesize(rb)) {
> +                error_prepend(errp, "Could not read page %zu from RAM Block %s",
> +                              page, rb->idstr);
> +                return false;
> +            }
> +
> +            if (postcopy_place_page(mis, (void *)haddr, place_source, rb)) {
> +                error_setg(errp,
> +                           "Failed to place page %zu from RAM Block %s at "
> +                           "address %" PRIu64,
> +                           page, rb->idstr, haddr);
> +                return false;
> +            }
> +        } else {
> +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> +                error_setg(errp,
> +                           "Failed to place zero page %zu from RAM Block %s at "
> +                           "address %" PRIu64,
> +                           page, rb->idstr, haddr);
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  /*
>   * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
>   * also optional: when zero is provided, the fault accounting will be ignored.
> @@ -1310,6 +1372,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
>      int ret;
>      size_t index;
>      RAMBlock *rb = NULL;
> +    Error *local_err = NULL;
>  
>      trace_postcopy_ram_fault_thread_entry();
>      rcu_register_thread();
> @@ -1351,11 +1414,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
>              break;
>          }
>  
> -        if (!mis->to_src_file) {
> +        if (!migrate_mapped_ram() && !mis->to_src_file) {
>              /*
> -             * Possibly someone tells us that the return path is
> -             * broken already using the event. We should hold until
> -             * the channel is rebuilt.
> +             * Possibly someone tells us that the return path is broken already
> +             * using the event. We should hold until the channel is rebuilt.
> +             * Fast snapshot load doesn't support pause and recover, because
> +             * it's not necessary: we can fail right away when QEMU just booted
> +             * with nothing to lose.
>               */
>              postcopy_pause_fault_thread(mis);
>          }
> @@ -1418,18 +1483,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
>                                                  qemu_ram_get_idstr(rb),
>                                                  rb_offset,
>                                                  msg.arg.pagefault.feat.ptid);
> +
> +            if (migrate_mapped_ram()) {
> +                /* Load page directly in case of fast snapshot load */
> +
> +                uintptr_t aligned = (uintptr_t)ROUND_DOWN(
> +                    msg.arg.pagefault.address, qemu_ram_pagesize(rb));
> +
> +                if (try_mark_postcopy_blocktime_begin(
> +                        mis, rb, rb_offset, (uintptr_t)aligned,
> +                        msg.arg.pagefault.feat.ptid)) {
> +                    if (!postcopy_mapped_ram_load_page(
> +                            mis, rb, rb_offset, aligned, RAM_CHANNEL_POSTCOPY,
> +                            &local_err)) {
> +                        error_report_err(local_err);
> +                        break;
> +                    }
> +                }
> +            } else {
>  retry:
> -            /*
> -             * Send the request to the source - we want to request one
> -             * of our host page sizes (which is >= TPS)
> -             */
> -            ret = postcopy_request_page(mis, rb, rb_offset,
> -                                        msg.arg.pagefault.address,
> -                                        msg.arg.pagefault.feat.ptid);
> -            if (ret) {
> -                /* May be network failure, try to wait for recovery */
> -                postcopy_pause_fault_thread(mis);
> -                goto retry;
> +                /*
> +                 * Send the request to the source - we want to request one
> +                 * of our host page sizes (which is >= TPS)
> +                 */
> +                ret = postcopy_request_page(mis, rb, rb_offset,
> +                                            msg.arg.pagefault.address,
> +                                            msg.arg.pagefault.feat.ptid);
> +                if (ret) {
> +                    /* May be network failure, try to wait for recovery */
> +                    postcopy_pause_fault_thread(mis);
> +                    goto retry;
> +                }
>              }
>          }
>  
> @@ -1501,8 +1585,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
>      unsigned i, channels;
>      void *temp_page;
>  
> -    if (migrate_postcopy_preempt()) {
> -        /* If preemption enabled, need extra channel for urgent requests */
> +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> +        /*
> +         * If preemption enabled or it is fast snapshot load, need extra channel
> +         * for urgent requests/faults
> +         */
>          mis->postcopy_channels = RAM_CHANNEL_MAX;
>      } else {
>          /* Both precopy/postcopy on the same channel */
> diff --git a/migration/ram.c b/migration/ram.c
> index 330fceaa43..4ab8e0e750 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -269,12 +269,21 @@ static void ramblock_pending_bmap_init(void)
>  
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          assert(!rb->pending_bmap);
> -        size_t size = rb->max_length >> qemu_target_page_bits();
> +        size_t size = rb->max_length / qemu_ram_pagesize(rb);

Oh here is the change..  let's move this to that patch directly (or squash
three patches).

Other than that this patch looks good.

Thanks,

>          rb->pending_bmap = bitmap_new(size);
>          bitmap_set(rb->pending_bmap, 0, size);
>      }
>  }
>  
> +bool ramblock_file_bitmap_page_is_nonzero(RAMBlock *rb, uint64_t page_idx)
> +{
> +    int page_bits = qemu_ram_pagesize(rb) / qemu_target_page_size();
> +    uint64_t bmap_page_start = page_idx * page_bits;
> +    uint64_t bmap_page_end = bmap_page_start + page_bits;
> +    return find_next_bit(rb->file_bmap, bmap_page_end, bmap_page_start) !=
> +           bmap_page_end;
> +}
> +
>  static void ramblock_recv_map_init(void)
>  {
>      RAMBlock *rb;
> diff --git a/migration/ram.h b/migration/ram.h
> index 41697a7599..7e2eac58d3 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -95,6 +95,8 @@ void ram_handle_zero(void *host, uint64_t size);
>  void ram_transferred_add(uint64_t bytes);
>  void ram_release_page(const char *rbname, uint64_t offset);
>  
> +bool ramblock_file_bitmap_page_is_nonzero(RAMBlock *rb, uint64_t page_idx);
> +
>  int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
>  bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
> -- 
> 2.55.0
> 

-- 
Peter Xu


