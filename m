Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC74C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 20:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYt2Z-00085A-Ot; Tue, 30 Jul 2024 16:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYt2O-00084b-4e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 16:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYt2L-0000Gd-8Q
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 16:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722369691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8K1TaNBoX+jhfa3go3EN2Owhn8lFqZoBJUJfyL8Zak=;
 b=hfp551auy9djcT8JrvrzJOrst6dVFjgo0OyPY82thFq6FGAqFFNclspC7rLDhAD0BhmxNR
 Q39s3DCP5SFD4cR/gxTccrmsBYdb8xN7791Jopwv92usnm9Y/WqiA0iol2ESuJJZviMEOY
 wnVpQcyE3zUX37Lt0s5ssyQZ94oKIko=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-50asXalqOXWZOhrFpYm7KQ-1; Tue, 30 Jul 2024 16:01:29 -0400
X-MC-Unique: 50asXalqOXWZOhrFpYm7KQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b798c6b850so6113996d6.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722369688; x=1722974488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8K1TaNBoX+jhfa3go3EN2Owhn8lFqZoBJUJfyL8Zak=;
 b=J0/7EToKMLRT3aIG5RFdEVYoSCE09u4Rhd4V9zEBd1p0ZGOUnFxH+J2wyKDFZ6VIY5
 FodtAg87XziEPkZaJRQsmHfwj7ipraIMB77yteR/Dxfsn7w4RTTrcKATlsHDbbkc3E5Y
 WXb1irHUjixMW54HFTcVDo9usJVUSLhh4DwLbrW3E7Rxf4fAvZVkvpsqPhy6Ai7RuEyU
 6bx3q2pIHvNSda80EH9K4u5XlL+v7A8es83QNmM8Ckr/gSm/MXkORNwEZiCc6eBWTJRw
 FkMhyzWNdNgJ1748q1gakh2A+gEed4yANA/Ndq/o/o7DbnPMzGGWge/AfQfAZfztt29+
 0rfg==
X-Gm-Message-State: AOJu0YySgaUXkYPaboJG+T9Gl/eWyusF6XgcOWkTouZuMHs5tIJGG6rD
 nElR7UJmZv7NixDll9/Kth+G5Fapl2i3DiOyAQ2h89O6jpnyAc/d74utd7rCBApsbuUlF4yMm3F
 8VsZarSdoPRbjYWaEhI5lwZD8ZRy8Eytwi1alyZdM3Iogt1FZ9iH82RGgx4Be
X-Received: by 2002:ad4:5d6e:0:b0:6b7:586c:2cf9 with SMTP id
 6a1803df08f44-6bb3e37aa7bmr142680116d6.8.1722369687966; 
 Tue, 30 Jul 2024 13:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5wel2ot2ASFjSxe24Oc1EKVoZVVpBs5pzKsV+tI8KUF7KUawPTX/vTE5VGde0sJisEQ5hNg==
X-Received: by 2002:ad4:5d6e:0:b0:6b7:586c:2cf9 with SMTP id
 6a1803df08f44-6bb3e37aa7bmr142679896d6.8.1722369687479; 
 Tue, 30 Jul 2024 13:01:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44fe814edc4sm53517781cf.28.2024.07.30.13.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 13:01:22 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:01:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Refine the convergence detection
Message-ID: <ZqlGjaleFHdnJUZy@x1n>
References: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 24, 2024 at 07:39:29PM +0800, Hyman Huang wrote:
> Currently, the convergence algorithm determines that the migration
> cannot converge according to the following principle:
> The dirty pages generated in current iteration exceed a specific
> percentage (throttle-trigger-threshold, 50 by default) of the number
> of transmissions. Let's refer to this criteria as the
> "transmission speed," If this criteria is met more than or equal to
> twice (dirty_rate_high_cnt >= 2), the throttle percentage needs to
> be increased.
> 
> In most cases, above implementation is appropriate. However, for a
> VM with a huge memory and high memory overload, each iteration is

When you're talking about huge memory, I do agree the current throttle
logic doesn't look like to scale, because migration_trigger_throttle() is
only called for each iteration, so it won't be invoked for a long time if
one iteration can take a long time.

I wonder whether you considered fixing that for a huge VM case in some way,
so that we may need to pay for the sync overhead more, but maybe the
throttle logic can still get scheduled from time to time.

E.g., on a 10TB system with even a 100Gbps network, one iteration can take:

  10TB / ~10GB/s = ~1000 seconds = ~17min

It means migration_trigger_throttle() will only be invoked once every 17
mins.

> time-consuming. The VM's computing performance may be throttled at
> a high percentage and last for a long time due to the repeated
> confirmation behavior. Which may be intolerable for some
> computationally sensitive software in the VM. The refinement is for
> this scenario.
> 
> As the comment mentioned in the migration_trigger_throttle function,
> in order to avoid erroneous detection, the original algorithm confirms
> the criteria repeatedly. Put differently, once the detection become
> more reliable, it does not need to be confirmed twice.
> 
> In the refinement, in order to make the detection more accurate, we
> introduce another criteria, called the "valid transmission ratio"
> to determine the migration convergence. The "valid transmission ratio"
> is the ratio of bytes_xfer_period and bytes_dirty_period, which
> actually describe the migration efficiency.
> 
> When the algorithm repeatedly detects that the current iteration
> "valid transmission ratio" is lower than the previous iteration,
> the algorithm determines that the migration cannot converge.
> 
> For the "transmission speed" and "valid transmission ratio", if one
> of the two criteria is met, the penalty percentage would be increased.
> This saves the time of the entire iteration and therefore reduces
> the time of VM performance degradation.
> 
> In conclusion, this refinement significantly reduces the processing
> time required for the throttle percentage step to its maximum while
> the VM is under a high memory load.
> 
> The following are test environment:
> ----------------------------------------------------------------------
> a. Test tool:
> guestperf
> 
> Refer to the following link to see details:
> https://github.com/qemu/qemu/tree/master/tests/migration/guestperf
> 
> b. Test VM scale:
> CPU: 10; Memory: 28GB

Isn't 28GB not a huge VM at all?  It'll be nice to know exactly what's the
problem behind first.  So are we talking about "real huge VM"s (I'd say at
least a few hundreds GBs), or "28GB VMs" (mostly.. every VM QEMU invokes)?

> 
> c. Average bandwidth between source and destination for migration:
> 1.53 Gbits/sec
> ----------------------------------------------------------------------
> All the supplementary test data shown as follows are basing on
> above test environment.
> 
> We use stress tool contained in the initrd-stress.img to update
> ramsize MB on every CPU in guest, refer to the following link to
> see the source code:
> https://github.com/qemu/qemu/blob/master/tests/migration/stress.c
> 
> We run the following command to compare our refined QEMU with the
> original QEMU:
> 
> $ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40 \
> --binary $(path_to_qemu-kvm) \
> --dst-host $(destination_ip) \
> --transport tcp --kernel $(path_to_vmlinuz) \
> --initrd $(path_to_initrd-stress.img) \
> --auto-converge \
> --auto-converge-step 10 \
> --max-iters 40

So this is for aut-converge.  How's the dirty limit solution?  I am
surprised you switched to the old one.  Does it mean that auto-converge is
better in some cases?

> 
> The following data shows the migration test results with an increase in
> stress, ignoring the title row, the odd rows show the unrefined QEMU
> test data, and the even rows show the refined QEMU test data:
> 
> |---------+--------+-----------+--------------+------------+------------|
> | ramsize | sucess | totaltime | downtime(ms) | iterations | switchover |
> | (MB)    |        | (ms)      | (ms)         |            | throttle   |
> |         |        |           |              |            | percent    |
> |---------+--------+-----------+--------------+------------+------------|
> |     350 |    yes |    170285 |          399 |         23 |         99 |
> |     350 |    yes |     85962 |          412 |         24 |         70 |
> |     350 |    yes |    176305 |          199 |         20 |         99 |
> |     350 |    yes |     66729 |          321 |         11 |         40 |
> |     400 |    yes |    183042 |          469 |         21 |         99 |
> |     400 |    yes |     77225 |          421 |         10 |         30 |
> |     400 |    yes |    183641 |          866 |         27 |         99 |
> |     400 |    yes |     59796 |          479 |         15 |         50 |
> |     450 |    yes |    165881 |          820 |         21 |         99 |
> |     450 |    yes |     87930 |          368 |         20 |         90 |
> |     450 |    yes |    195448 |          452 |         23 |         99 |
> |     450 |    yes |     70394 |          295 |          6 |         20 |
> |     500 |    yes |    112587 |          471 |         19 |         99 |
> |     500 |    yes |     57401 |          299 |          5 |         30 |
> |     500 |    yes |    110683 |          657 |         21 |         99 |
> |     500 |    yes |     69949 |          649 |          8 |         40 |
> |     600 |    yes |    111036 |          324 |         23 |         99 |
> |     600 |    yes |     63455 |          346 |          4 |         20 |
> |     600 |    yes |    126667 |          426 |         20 |         99 |
> |     600 |    yes |    101024 |          643 |         20 |         99 |
> |    1000 |    yes |    296216 |          660 |         23 |         99 |
> |    1000 |    yes |    106915 |          468 |         16 |         99 |
> |    1000 |     no |    300000 |              |            |            |
> |    1000 |    yes |    125819 |          824 |         17 |         99 |
> |    1200 |     no |    300000 |              |            |            |
> |    1200 |    yes |    127379 |          664 |         14 |         90 |
> |    1200 |     no |    300000 |              |            |            |
> |    1200 |    yes |     67086 |          793 |         11 |         50 |
> |---------+--------+-----------+--------------+------------+------------|
> 
> To summarize the data above, any data that implies negative optimization
> does not appear, and morover, the throttle algorithm seems to become more
> responsive to dirty rate increases due to the refined detection.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/ram.c        | 48 +++++++++++++++++++++++++++++++++++++++---
>  migration/trace-events |  1 +
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index edec1a2d07..18b2d422b5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -414,6 +414,17 @@ struct RAMState {
>       * RAM migration.
>       */
>      unsigned int postcopy_bmap_sync_requested;
> +
> +    /*
> +     * Ratio of bytes_dirty_period and bytes_xfer_period in the last
> +     * iteration
> +     */
> +    uint64_t dirty_ratio_pct;
> +    /*
> +     * How many times is the most recent iteration dirty ratio is
> +     * higher than previous one
> +     */
> +    int dirty_ratio_high_cnt;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -1013,6 +1024,32 @@ static void migration_dirty_limit_guest(void)
>      trace_migration_dirty_limit_guest(quota_dirtyrate);
>  }
>  
> +static bool migration_dirty_ratio_unexpected(RAMState *rs)
> +{
> +    uint64_t threshold = migrate_throttle_trigger_threshold();
> +    uint64_t bytes_xfer_period =
> +        migration_transferred_bytes() - rs->bytes_xfer_prev;
> +    uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
> +    uint64_t prev, curr;
> +
> +    /* Skip the first iterations since it isn't helpful */
> +    if (stat64_get(&mig_stats.dirty_sync_count) == 1 || !bytes_xfer_period) {
> +        return false;
> +    }
> +
> +    curr = 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
> +
> +    prev = rs->dirty_ratio_pct;
> +    rs->dirty_ratio_pct = curr;
> +
> +    if (prev == 0 || curr <= threshold) {
> +        return false;
> +    }
> +
> +    trace_dirty_ratio_pct(curr, prev);
> +    return curr >= prev;
> +}
> +
>  static void migration_trigger_throttle(RAMState *rs)
>  {
>      uint64_t threshold = migrate_throttle_trigger_threshold();
> @@ -1028,9 +1065,14 @@ static void migration_trigger_throttle(RAMState *rs)
>       * we were in this routine reaches the threshold. If that happens
>       * twice, start or increase throttling.
>       */
> -    if ((bytes_dirty_period > bytes_dirty_threshold) &&
> -        (++rs->dirty_rate_high_cnt >= 2)) {
> -        rs->dirty_rate_high_cnt = 0;
> +    if ((migration_dirty_ratio_unexpected(rs) &&
> +         (++rs->dirty_ratio_high_cnt >= 2)) ||
> +        ((bytes_dirty_period > bytes_dirty_threshold) &&
> +         (++rs->dirty_rate_high_cnt >= 2))) {

I'm afraid this is a mess.

Now it's (A||B) and any condition can trigger this throttle logic.  Both A
& B make decisions on merely the same parameters.  It's totally
unpredictable to me on how these cnts bumps, and not readable.

What I kind of see how this could make migration shorter is that now either
A or B can trigger the throttle, so it triggered in a faster pace than
before.  E.g. IIUC if we drop dirty_rate_high_cnt completely it'll also
achieve similar thing at least in guestperf tests.

Have you considered what I mentioned above that may make auto converge work
better with "real huge VM"s (by allowing sync >1 times for each iteration),
or have you considered postcopy?

Thanks,

> +        rs->dirty_rate_high_cnt =
> +            rs->dirty_rate_high_cnt >= 2 ? 0 : rs->dirty_rate_high_cnt;
> +        rs->dirty_ratio_high_cnt =
> +            rs->dirty_ratio_high_cnt >= 2 ? 0 : rs->dirty_ratio_high_cnt;
>          if (migrate_auto_converge()) {
>              trace_migration_throttle();
>              mig_throttle_guest_down(bytes_dirty_period,
> diff --git a/migration/trace-events b/migration/trace-events
> index 0b7c3324fb..654c52c5e4 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
>  qemu_file_fclose(void) ""
>  
>  # ram.c
> +dirty_ratio_pct(uint64_t cur, uint64_t prev) "current ratio: %" PRIu64 " previous ratio: %" PRIu64
>  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
>  get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
>  migration_bitmap_sync_start(void) ""
> -- 
> 2.39.1
> 

-- 
Peter Xu


