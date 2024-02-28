Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA65BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 10:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfH0s-0007at-3D; Wed, 28 Feb 2024 05:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfH0q-0007ae-Is
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 05:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfH0o-0006HR-Hc
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 05:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709115485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58374UtBnefPNsEv8F3I4x79IWmOtoX7xoZKaHGdZLM=;
 b=fH2Qm+ycEZ1XP8lhNSaXnYvQVraqQw6FaC+iWUCBmtV2MueAyIb47gSFE2GVQzsftBACfX
 PnsRlRmbxmjDQxPP2OV28rAG8MT1Tv5RQG15HSEUy5BFTXUF0c+iKiYjXF96VXZxE5sPN4
 88mXDDCuC1cDPJVWrb5PaKAPHtFVMfI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-ar4cjSWePRKPZR4P9AvVhQ-1; Wed, 28 Feb 2024 05:18:03 -0500
X-MC-Unique: ar4cjSWePRKPZR4P9AvVhQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6e488dfc2dbso2026132a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 02:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709115483; x=1709720283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58374UtBnefPNsEv8F3I4x79IWmOtoX7xoZKaHGdZLM=;
 b=wqZg15Q/MKH7tyMMw1DT0zCotvScPdJ/vh5e9+l2SbYR50XqrJIVqa1NARgI565cPa
 olXUfNR6MwBN4RAWtAveXMXMT7cBkYucZ7kofESbWInkx6LICCRv2X8IEr5WZf9biKsT
 RfY7BCVBlEzsWMmqyMPeo8nazEQdYSdodqMprtLZeKNiHF9NINqvgjZWjcsfk/n0hvbj
 f5D5sJ8ZMky7m70+udyiVOMxGYbM+pAxq32u6+fwLxqSgcI5gwQ8jyPqynfogdpyodAR
 Tzb2HqGAPs12ve8FEDyb5L89iXa4OwYk6YgbZ2bro02eaExsIxQQvrvRpJbJVkKFN6aV
 XN2A==
X-Gm-Message-State: AOJu0YyL2sXHNY+DhrFljMj+phXy9XpLtfdVkksAWh/gn6PxkVfuQt3+
 bm30fIzT6wuO3S1xMIFfcD5nG2b0WIqo8+di4kv1kM43xzhdJXcePxxonNMTGFmSKmyggbV9ln4
 Q9sTiaezkty5Iq6/BPR6Pm8179+hmwbz9ZJ1f0bahFxS5kNMJrywg
X-Received: by 2002:a05:6820:c04:b0:5a0:2cbe:43dd with SMTP id
 eh4-20020a0568200c0400b005a02cbe43ddmr11709892oob.1.1709115482976; 
 Wed, 28 Feb 2024 02:18:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExG0P6czo3DOD8Sy2RkUYg7u1Jj7wMmRs/fHWeY1Kyu4EsHpzpMxkwqTWU4NVUcQLq04uF9A==
X-Received: by 2002:a05:6820:c04:b0:5a0:2cbe:43dd with SMTP id
 eh4-20020a0568200c0400b005a02cbe43ddmr11709879oob.1.1709115482656; 
 Wed, 28 Feb 2024 02:18:02 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r3-20020aa78443000000b006e4f1e6f145sm7496788pfn.33.2024.02.28.02.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:18:02 -0800 (PST)
Date: Wed, 28 Feb 2024 18:17:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Message-ID: <Zd8IUJErmhDYIiXR@x1n>
References: <20240222155627.14563-1-avihaih@nvidia.com> <Zd2SPGPVhW80b1Hu@x1n>
 <f7fb1999-4400-446b-812d-184fa502627f@nvidia.com>
 <Zd6iw9dBhW6wKNxx@x1n>
 <f882db98-10e3-4c95-9ff9-1ab9a0c145ba@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f882db98-10e3-4c95-9ff9-1ab9a0c145ba@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 28, 2024 at 11:39:52AM +0200, Avihai Horon wrote:
> 
> On 28/02/2024 5:04, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Feb 28, 2024 at 02:00:26AM +0200, Avihai Horon wrote:
> > > On 27/02/2024 9:41, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Thu, Feb 22, 2024 at 05:56:27PM +0200, Avihai Horon wrote:
> > > > > Currently, migration code serializes device data sending during pre-copy
> > > > > iterative phase. As noted in the code comment, this is done to prevent
> > > > > faster changing device from sending its data over and over.
> > > > Frankly speaking I don't understand the rational behind 90697be889 ("live
> > > > migration: Serialize vmstate saving in stage 2").  I don't even think I
> > > > noticed this logic before even if I worked on migration for a few years...
> > > > 
> > > > I was thinking all devices should always get its chance to run for some
> > > > period during iterations.  Do you know the reasoning behind?  And I must
> > > > confess I also know little on block migration, which seems to be relevant
> > > > to this change.  Anyway, I also copy Jan just in case he'll be able to chim
> > > > in.
> > > I am not 100% sure either, but I can guess:
> > > This commit is pretty old (dates to 2009), so maybe back then the only
> > > iterative devices were block devices and RAM.
> > > Block devices didn't change as fast as RAM (and were probably much bigger
> > > than RAM), so it made sense to send them first and only then send RAM, which
> > > changed constantly.
> > Makes sense.  For some reason I read it the other way round previously.
> > 
> > > > If there is a fast changing device, even if we don't proceed with other
> > > > device iterators and we stick with the current one, assuming it can finally
> > > > finish dumping all data, but then we'll proceed with other devices and the
> > > > fast changing device can again accumulate dirty information?
> > > I guess this logic only makes sense for the case where we only have block
> > > devices and a RAM device, because the block devices wouldn't change that
> > > much?
> > > 
> > > > > However, with switchover-ack capability enabled, this behavior can be
> > > > > problematic and may prevent migration from converging. The problem lies
> > > > > in the fact that an earlier device may never finish sending its data and
> > > > > thus block other devices from sending theirs.
> > > > Yes, this is a problem.
> > > > 
> > > > > This bug was observed in several VFIO migration scenarios where some
> > > > > workload on the VM prevented RAM from ever reaching a hard zero, not
> > > > > allowing VFIO initial pre-copy data to be sent, and thus destination
> > > > > could not ack switchover. Note that the same scenario, but without
> > > > > switchover-ack, would converge.
> > > > > 
> > > > > Fix it by not serializing device data sending during pre-copy iterative
> > > > > phase if switchover was not acked yet.
> > > > I am still not fully convinced that it's even legal that one device can
> > > > consume all iterator's bandwidth, ignoring the rest..  Though again it's
> > > > not about this patch, but about commit 90697be889.
> > > Yes, I agree. As I wrote above, maybe this was valid back then when the only
> > > iterative devices were block and RAM.
> > > 
> > > > I'm thinking whether we should allow each device to have its own portion of
> > > > chance to push data for each call to qemu_savevm_state_iterate(),
> > > > irrelevant of vfio's switchover-ack capability.
> > > I wasn't sure for 100% why we have this logic in the first place, so I wrote
> > > my patch as little invasive as possible, keeping migration behavior as is
> > > (except for switchover-ack).
> > > But I tend to agree with you for three reasons:
> > > 
> > > 1. I think block migration is deprecated (see commits 66db46ca83b8,
> > > 40101f320d6b and 8846b5bfca76).
> > > Instead, users are instructed to use blockdev-mirror and co. [1]. If I'm not
> > > mistaken, this operates using a different infrastructure than migration.
> > > So this logic is not relevant anymore.
> > > 
> > > 2. As you pointed out earlier, the fast changing device can accumulate dirty
> > > data over and over. VFIO devices come after RAM, so this logic doesn't
> > > achieve its goal in this case (we may sync fast changing RAM over and over).
> > > 
> > > 3. My fix in this patch won't solve a similar problem that could happen,
> > > where a VFIO device with a lot of pre-copy data (not necessarily initial
> > > data) may never be able to send it, thus not realizing the full potential of
> > > pre-copy for VFIO.
> > > (I personally have not encountered this problem yet, but maybe it can happen
> > > with a vGPU).
> > Thanks for a summary.
> > 
> > > 
> > > If you agree, I can send a v2 that simply removes this logic and gives every
> > > device an equal chance to send its data (like Joao showed) with some
> > > explanation why we do it.
> > Let's see whether others have an opinion, but to me I think we can give it
> > a shot.  In that case we can "break" in the previous "ret < 0" check
> > already.
> 
> Sure.
> So I will wait some more and may send v2 next week, if no special feedback
> is received.
> 
> > 
> > One more thing to mention is then I think we need to calculate the case of
> > "all iterators returned 1" (aka, "all completes") scenario.  With the old
> > check it is guaranteed if the loop iterates over all iterators then all
> > iterators have completed.  Now we allow ret==0 to keep iterating, then the
> > check needs to be done explicitly.
> > 
> > In general, it could be something like:
> > 
> >    all_done = 1;
> >    loop {
> >      ...
> >      ret = se->ops->save_live_iterate(f, se->opaque);
> >      if (ret < 0) {
> >        /* error handling.. */
> >        ...
> >        break;
> >      } else if (ret == 0) {
> >        all_done = 0;
> >      }
> >    }
> >    return all_done;
> 
> Yes, this looks good.
> 
> > > We could also give RAM precedence over other devices only during the first
> > > iteration of sending RAM (i.e., only until first dirty sync), but I don't
> > > know how much benefit this would give.
> > That sounds a bit tricky.  We can leave that for later until justified to
> > be anything useful.
> 
> I agree.
> 
> > 
> > Now when I checked VFIO code I found that VFIO still may have two issues:
> > 
> > ====
> > 1) VFIO doesn't yet respect migration_rate_exceeded()
> > 
> > That's the knob we use to limit send throughput when user specified the bw
> > to be something not zero, then throttling will apply.  Currently it seems
> > VFIO always sends limited data per iteration - a little bit more than
> > 1MB-ish?
> 
> Correct.
> 
> >    I'm mostly only looking at VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE,
> > which seems fine, because in qemu_savevm_state_iterate() there's one more
> > migration_rate_exceeded() check anyway:
> > 
> >          if (migration_rate_exceeded(f)) {
> >              return 0;
> >          }
> > 
> > However it may be good that VFIO will also use migration_rate_exceeded()
> > inside the iterator (before we can have some better way to do throttling..).
> 
> You mean that you want to add a migration_rate_exceeded() check inside
> vfio_save_iterate() before we send any data?
> E.g.:
> 
> static int vfio_save_iterate(QEMUFile *f, void *opaque)
> {
>     VFIODevice *vbasedev = opaque;
>     VFIOMigration *migration = vbasedev->migration;
>     ssize_t data_size;
> 
> +   if (migration_rate_exceeded()) {
> +       // return early
> +   }
> 
>     data_size = vfio_save_block(f, migration);
>     if (data_size < 0) {
>         return data_size;
>     }
> 
> Or check migration_rate_exceeded() not only here, but also during sending of
> the 1MB buffer (inside vfio_save_block())?
> 
> Either way, I think this would only complicate things for no real benefit:
> even if we do exceed BW, it would only be by 1MB max, and IMHO this
> shouldn't make any real difference.

So far with the ~1MB guard it shouldn't matter a huge deal indeed.  But
please keep that in mind in case in the future VFIO can iterate much more
than that, because the current 1MB limitation came from nowhere, afaict..
so I won't be surprised either if someday someone thinks it's a good idea
to send more than that, keep ignoring migration_rate_exceeded().

If you think worthwhile, maybe we can add a comment in vfio_save_iterate()
explaining why migration_rate_exceeded() is not necessary so far, so that
anyone in the future will be aware of its existance.

> 
> > 
> > 2) vfio_save_iterate() always return 1
> > 
> > IIUC right now "1" means "all data is sent"?  But that seems not true for
> > VFIO if returned 1 every time.
> > 
> > I think it's not a major issue, e.g. the main migration routine even
> > ignored the retval of qemu_savevm_state_iterate(), the rest VFIO data
> > should rely on the upcoming loops over ->save_live_complete_precopy().
> > 
> > However I think it could already break bg_migration_iteration_run() as it
> > doesn't do that (it stores device state _before_ normal iterators).  But I
> > agree bg-snapshot is never ready with VFIO anyway and the feature itself is
> > probably still flaky, so not a major concern.  Just want to raise it up
> > when we're there.
> 
> Sure.
> I think this "always return 1" in vfio_save_iterate() was a small hack to
> avoid one VFIO device blocking the others due to qemu_savevm_state_iterate()
> serialization behavior.
> Now with the serialization removed, I can add a patch that changes the
> "always return 1" to a proper return value based on remaining data left.

Sounds good.

> 
> > ====
> > 
> > Besides all above, I think we are just still not good enough to do proper
> > bandwidth provisioning over the iterators if the max-bandwidth is set
> > pretty low: even with above change to allow iterators to proceed with
> > ret==0, we can also hit the case where RAM is very busy, it consumes all
> > bandwidth, and migration_rate_exceeded() reported true, then VFIO will be
> > skipped again as it's after RAM iterators.  We may at least want to
> > remember the last time we iterated here, and then for the next iteration we
> > go with the handler next to it.  But that should not happen with high /
> > unlimited bandwidth setup, and can be another story.
> 
> Indeed.
> As you said, I think it's more of a problem with low BW. If it's fine by
> you, this can be addressed later if we see real scenarios encountering this
> situation.

Sure.

Thanks,

-- 
Peter Xu


