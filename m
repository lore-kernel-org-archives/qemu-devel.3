Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E877C52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbNJQ-0004OU-9F; Tue, 06 Aug 2024 12:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sbNJG-0004NL-3e
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sbNJA-0008OE-9z
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722962707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsC5zrfUfyUrhYlSJPayGE89YZJe9yxItwoHYl/ta9E=;
 b=PDGbYFeEw5SgB8muQCFyFoi9De6gJmkNHDK2GdPE1UFsbEF5Vq7KGagR2l+YvR7cmCvsbL
 nRAAZnQYIZgLHndqypAGwNZtDxMbIOZw388Bs5f2IQxnJZv1bVND30qN/foufKiZhcmS71
 3jxVZKkMW+NViAZ2JeayTluIhqAkKu0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-IEWcLAxDMSijcdRNfiNVsg-1; Tue, 06 Aug 2024 12:45:06 -0400
X-MC-Unique: IEWcLAxDMSijcdRNfiNVsg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b7ad98c1f8so2599456d6.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 09:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722962706; x=1723567506;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsC5zrfUfyUrhYlSJPayGE89YZJe9yxItwoHYl/ta9E=;
 b=HXOas5fMZHZIQ5PsPGRsnZhKOUquH2j51YbOze33OSRk3ud+aru1DgLWRqqCAjIS/V
 8moPZdGSAXXYwSb1xX9oyx2qdkDZ1dd10/7uHWp8hbnW4ElBIxc7lnajshGO3rFj5EJN
 1KPZdjOlBbW+LaN5egHCDbOm+lOxpXPynsjSzPxi5aKUD+5EprOAGpJd5yti0DzvDxxp
 dFj7XXQ+hP/CLLLbASkec2eBAV5mbllQFrgfdWNtY3hfMTEpwIaVf0oxdwT11kj5oBtN
 OP06LqkFlWJ6YNO3wyjZWhSuxphIul4CBEamt53kcF64vI3nCdzvWwFIrMiOGqLqbltd
 cQEA==
X-Gm-Message-State: AOJu0YwZgo/idTli6KUQmpNKdk2RHzIhqcdQXWtw/dSFbufMM1Et7Ebb
 Yn0Woqu7K55NCmPu1SyIItnV3lQDwwx3CPpcsEtN6VAAOkyb5DJlephxo2/jHzhYSr8Of7qTU5/
 sejnhNv503aSoDQBindHNpcvVwWkTvmk7lfGflopcBida+xlvI5XJ
X-Received: by 2002:a05:6214:1943:b0:6bb:3ac9:3274 with SMTP id
 6a1803df08f44-6bb983f1166mr118886026d6.4.1722962705582; 
 Tue, 06 Aug 2024 09:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsByf8DbPp6oIvIBBv/AIpAGPizlN6c6tTUZ7N2LLG2bgSB0nZkAWmFPWfgUxPBUKU7Gz9XQ==
X-Received: by 2002:a05:6214:1943:b0:6bb:3ac9:3274 with SMTP id
 6a1803df08f44-6bb983f1166mr118885886d6.4.1722962705094; 
 Tue, 06 Aug 2024 09:45:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c797670sm48220516d6.47.2024.08.06.09.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 09:45:04 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:45:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Refine the convergence detection
Message-ID: <ZrJTDhyRdjEL9VTV@x1n>
References: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
 <ZqlGjaleFHdnJUZy@x1n>
 <CAK9dgmbkKPDTYv0i1jpASgTR5iN+_4+DrZUxo5VxQF3NdZewaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmbkKPDTYv0i1jpASgTR5iN+_4+DrZUxo5VxQF3NdZewaQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Aug 05, 2024 at 03:03:27PM +0800, Yong Huang wrote:
> Sorry for the late reply.
> 
> On Wed, Jul 31, 2024 at 4:01 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Jul 24, 2024 at 07:39:29PM +0800, Hyman Huang wrote:
> > > Currently, the convergence algorithm determines that the migration
> > > cannot converge according to the following principle:
> > > The dirty pages generated in current iteration exceed a specific
> > > percentage (throttle-trigger-threshold, 50 by default) of the number
> > > of transmissions. Let's refer to this criteria as the
> > > "transmission speed," If this criteria is met more than or equal to
> > > twice (dirty_rate_high_cnt >= 2), the throttle percentage needs to
> > > be increased.
> > >
> > > In most cases, above implementation is appropriate. However, for a
> > > VM with a huge memory and high memory overload, each iteration is
> >
> > When you're talking about huge memory, I do agree the current throttle
> > logic doesn't look like to scale, because migration_trigger_throttle() is
> > only called for each iteration, so it won't be invoked for a long time if
> > one iteration can take a long time.
> >
> > I wonder whether you considered fixing that for a huge VM case in some way,
> > so that we may need to pay for the sync overhead more, but maybe the
> > throttle logic can still get scheduled from time to time.
> 
> 
> > E.g., on a 10TB system with even a 100Gbps network, one iteration can take:
> >
> >   10TB / ~10GB/s = ~1000 seconds = ~17min
> >
> > It means migration_trigger_throttle() will only be invoked once every 17
> > mins.
> 
> 
> Agree, and another case, VM is at a high dirty rate when migrating,
> similarly making the iteration take a long time.
> 
> 
> > > time-consuming. The VM's computing performance may be throttled at
> > > a high percentage and last for a long time due to the repeated
> > > confirmation behavior. Which may be intolerable for some
> > > computationally sensitive software in the VM. The refinement is for
> > > this scenario.
> > >
> > > As the comment mentioned in the migration_trigger_throttle function,
> > > in order to avoid erroneous detection, the original algorithm confirms
> > > the criteria repeatedly. Put differently, once the detection become
> > > more reliable, it does not need to be confirmed twice.
> > >
> > > In the refinement, in order to make the detection more accurate, we
> > > introduce another criteria, called the "valid transmission ratio"
> > > to determine the migration convergence. The "valid transmission ratio"
> > > is the ratio of bytes_xfer_period and bytes_dirty_period, which
> > > actually describe the migration efficiency.
> > >
> > > When the algorithm repeatedly detects that the current iteration
> > > "valid transmission ratio" is lower than the previous iteration,
> > > the algorithm determines that the migration cannot converge.
> > >
> > > For the "transmission speed" and "valid transmission ratio", if one
> > > of the two criteria is met, the penalty percentage would be increased.
> > > This saves the time of the entire iteration and therefore reduces
> > > the time of VM performance degradation.
> > >
> > > In conclusion, this refinement significantly reduces the processing
> > > time required for the throttle percentage step to its maximum while
> > > the VM is under a high memory load.
> > >
> > > The following are test environment:
> > > ----------------------------------------------------------------------
> > > a. Test tool:
> > > guestperf
> > >
> > > Refer to the following link to see details:
> > > https://github.com/qemu/qemu/tree/master/tests/migration/guestperf
> > >
> > > b. Test VM scale:
> > > CPU: 10; Memory: 28GB
> >
> > Isn't 28GB not a huge VM at all?  It'll be nice to know exactly what's the
> > problem behind first.  So are we talking about "real huge VM"s (I'd say at
> > least a few hundreds GBs), or "28GB VMs" (mostly.. every VM QEMU invokes)?
> >
> > >
> > > c. Average bandwidth between source and destination for migration:
> > > 1.53 Gbits/sec
> > > ----------------------------------------------------------------------
> > > All the supplementary test data shown as follows are basing on
> > > above test environment.
> > >
> > > We use stress tool contained in the initrd-stress.img to update
> > > ramsize MB on every CPU in guest, refer to the following link to
> > > see the source code:
> > > https://github.com/qemu/qemu/blob/master/tests/migration/stress.c
> > >
> > > We run the following command to compare our refined QEMU with the
> > > original QEMU:
> > >
> > > $ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40 \
> > > --binary $(path_to_qemu-kvm) \
> > > --dst-host $(destination_ip) \
> > > --transport tcp --kernel $(path_to_vmlinuz) \
> > > --initrd $(path_to_initrd-stress.img) \
> > > --auto-converge \
> > > --auto-converge-step 10 \
> > > --max-iters 40
> >
> > So this is for aut-converge.  How's the dirty limit solution?  I am
> >
> 
> This patch is a general solution, not just for auto-convergence, here
> I missed the dirty limit test case, i'll post the dirty limit test result
> in the next version.
> 
> 
> > surprised you switched to the old one.  Does it mean that auto-converge is
> > better in some cases?
> >
> 
> Since for non-x86 hardware platforms, auto-converge is still the only
> solution
> to throttle the guest.  It still reap the benefits from this patch.

ARM should have that too now, if that's what you're talking about.

Said that, for quite some time I was wondering whether upstream should be
focused on some solution that will work out for convergence, where I
ultimately chose postcopy.  That's also why I was asking whether you
considered postcopy.

It'll be more focused for everyone if we can have one major solution over
this problem rather than spreading the energy over a few.

> 
> 
> >
> > >
> > > The following data shows the migration test results with an increase in
> > > stress, ignoring the title row, the odd rows show the unrefined QEMU
> > > test data, and the even rows show the refined QEMU test data:
> > >
> > > |---------+--------+-----------+--------------+------------+------------|
> > > | ramsize | sucess | totaltime | downtime(ms) | iterations | switchover |
> > > | (MB)    |        | (ms)      | (ms)         |            | throttle   |
> > > |         |        |           |              |            | percent    |
> > > |---------+--------+-----------+--------------+------------+------------|
> > > |     350 |    yes |    170285 |          399 |         23 |         99 |
> > > |     350 |    yes |     85962 |          412 |         24 |         70 |
> > > |     350 |    yes |    176305 |          199 |         20 |         99 |
> > > |     350 |    yes |     66729 |          321 |         11 |         40 |
> > > |     400 |    yes |    183042 |          469 |         21 |         99 |
> > > |     400 |    yes |     77225 |          421 |         10 |         30 |
> > > |     400 |    yes |    183641 |          866 |         27 |         99 |
> > > |     400 |    yes |     59796 |          479 |         15 |         50 |
> > > |     450 |    yes |    165881 |          820 |         21 |         99 |
> > > |     450 |    yes |     87930 |          368 |         20 |         90 |
> > > |     450 |    yes |    195448 |          452 |         23 |         99 |
> > > |     450 |    yes |     70394 |          295 |          6 |         20 |
> > > |     500 |    yes |    112587 |          471 |         19 |         99 |
> > > |     500 |    yes |     57401 |          299 |          5 |         30 |
> > > |     500 |    yes |    110683 |          657 |         21 |         99 |
> > > |     500 |    yes |     69949 |          649 |          8 |         40 |
> > > |     600 |    yes |    111036 |          324 |         23 |         99 |
> > > |     600 |    yes |     63455 |          346 |          4 |         20 |
> > > |     600 |    yes |    126667 |          426 |         20 |         99 |
> > > |     600 |    yes |    101024 |          643 |         20 |         99 |
> > > |    1000 |    yes |    296216 |          660 |         23 |         99 |
> > > |    1000 |    yes |    106915 |          468 |         16 |         99 |
> > > |    1000 |     no |    300000 |              |            |            |
> > > |    1000 |    yes |    125819 |          824 |         17 |         99 |
> > > |    1200 |     no |    300000 |              |            |            |
> > > |    1200 |    yes |    127379 |          664 |         14 |         90 |
> > > |    1200 |     no |    300000 |              |            |            |
> > > |    1200 |    yes |     67086 |          793 |         11 |         50 |
> > > |---------+--------+-----------+--------------+------------+------------|
> > >
> > > To summarize the data above, any data that implies negative optimization
> > > does not appear, and morover, the throttle algorithm seems to become more
> > > responsive to dirty rate increases due to the refined detection.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > ---
> > >  migration/ram.c        | 48 +++++++++++++++++++++++++++++++++++++++---
> > >  migration/trace-events |  1 +
> > >  2 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index edec1a2d07..18b2d422b5 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -414,6 +414,17 @@ struct RAMState {
> > >       * RAM migration.
> > >       */
> > >      unsigned int postcopy_bmap_sync_requested;
> > > +
> > > +    /*
> > > +     * Ratio of bytes_dirty_period and bytes_xfer_period in the last
> > > +     * iteration
> > > +     */
> > > +    uint64_t dirty_ratio_pct;
> > > +    /*
> > > +     * How many times is the most recent iteration dirty ratio is
> > > +     * higher than previous one
> > > +     */
> > > +    int dirty_ratio_high_cnt;
> > >  };
> > >  typedef struct RAMState RAMState;
> > >
> > > @@ -1013,6 +1024,32 @@ static void migration_dirty_limit_guest(void)
> > >      trace_migration_dirty_limit_guest(quota_dirtyrate);
> > >  }
> > >
> > > +static bool migration_dirty_ratio_unexpected(RAMState *rs)
> > > +{
> > > +    uint64_t threshold = migrate_throttle_trigger_threshold();
> > > +    uint64_t bytes_xfer_period =
> > > +        migration_transferred_bytes() - rs->bytes_xfer_prev;
> > > +    uint64_t bytes_dirty_period = rs->num_dirty_pages_period *
> > TARGET_PAGE_SIZE;
> > > +    uint64_t prev, curr;
> > > +
> > > +    /* Skip the first iterations since it isn't helpful */
> > > +    if (stat64_get(&mig_stats.dirty_sync_count) == 1 ||
> > !bytes_xfer_period) {
> > > +        return false;
> > > +    }
> > > +
> > > +    curr = 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
> > > +
> > > +    prev = rs->dirty_ratio_pct;
> > > +    rs->dirty_ratio_pct = curr;
> > > +
> > > +    if (prev == 0 || curr <= threshold) {
> > > +        return false;
> > > +    }
> > > +
> > > +    trace_dirty_ratio_pct(curr, prev);
> > > +    return curr >= prev;
> > > +}
> > > +
> > >  static void migration_trigger_throttle(RAMState *rs)
> > >  {
> > >      uint64_t threshold = migrate_throttle_trigger_threshold();
> > > @@ -1028,9 +1065,14 @@ static void migration_trigger_throttle(RAMState
> > *rs)
> > >       * we were in this routine reaches the threshold. If that happens
> > >       * twice, start or increase throttling.
> > >       */
> > > -    if ((bytes_dirty_period > bytes_dirty_threshold) &&
> > > -        (++rs->dirty_rate_high_cnt >= 2)) {
> > > -        rs->dirty_rate_high_cnt = 0;
> > > +    if ((migration_dirty_ratio_unexpected(rs) &&
> > > +         (++rs->dirty_ratio_high_cnt >= 2)) ||
> > > +        ((bytes_dirty_period > bytes_dirty_threshold) &&
> > > +         (++rs->dirty_rate_high_cnt >= 2))) {
> >
> > I'm afraid this is a mess.
> >
> > Now it's (A||B) and any condition can trigger this throttle logic.  Both A
> > & B make decisions on merely the same parameters.  It's totally
> > unpredictable to me on how these cnts bumps, and not readable.
> >
> 
> Indeed, this is not readable. How about introducing a migration capability
> like "precise-detection" to make this patch backward-compatible?

If we want to do some change here anyway, I'd think it better we do it in
the best form rather than keep adding caps.

For now "stick with postcopy" is still one way to go, but not sure whether
it applies in your setup.  Otherwise I'd consider we sync more for huge
VMs.  I mean "throttle only for each sync, sync for each iteration" may
make sense in the old days, but perhaps not anymore.  That sound like the
real root cause of this issue.

> 
> 
> >
> > What I kind of see how this could make migration shorter is that now either
> > A or B can trigger the throttle, so it triggered in a faster pace than
> > before.  E.g. IIUC if we drop dirty_rate_high_cnt completely it'll also
> > achieve similar thing at least in guestperf tests.
> >
> 
> Yes !  I get it, and what my original idea is to drop the
> dirty_rate_high_cnt.
> 
> As we mentioned above: migration needs to pay for the sync overhead more
> once a VM is configured with huge memory or running at a high dirty rate.
> 
> Dropping the dirty_rate_high_cnt will make the iteration take less time
> in above cases.  I think this is feasible since there is no other reasons to
> retain the  dirty_rate_high_cnt once we make the detection precise,
> let me know if i missed something.
> 
> 
> >
> > Have you considered what I mentioned above that may make auto converge work
> > better with "real huge VM"s (by allowing sync >1 times for each iteration),
> > or have you considered postcopy?
> >
> 
> Yes, IMHO, this is another refinement direction for the auto-converge, we'll
> try this and keep communication with upstream once it gets progress.

Thanks,

-- 
Peter Xu


