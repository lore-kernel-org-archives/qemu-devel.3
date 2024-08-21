Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A44C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 19:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgrHM-0002OC-PA; Wed, 21 Aug 2024 15:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgrH8-0002NO-P9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 15:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgrGy-0006xV-Ip
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 15:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724269535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=seBGloLQq7rS5lyy6c/ceZR/dOdMaiMYGx60SdjS4cQ=;
 b=I07f/x0K9JQUcfUbmayGANUPA/vNXsMn6Mqgbv6v/BuTdVUbeS/RTcdB3OHfWTpFxgJMqC
 d/QAro3zvD3vLHX1GDAbSYUfRZ2kr0OtbvjWWHLkf+UuIew2qI4ZBr5uhXYy9YJ74EhQq1
 5QcQBSnaU86OCiSUwAO8iQ+Clhh5uxY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-BbSwWsZOOHitPXPN4tloWw-1; Wed, 21 Aug 2024 15:45:31 -0400
X-MC-Unique: BbSwWsZOOHitPXPN4tloWw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5daa93afe1bso101474eaf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 12:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724269531; x=1724874331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seBGloLQq7rS5lyy6c/ceZR/dOdMaiMYGx60SdjS4cQ=;
 b=rk5FG42oTE7C9ocDRSBBcVzToqUsr/susr7P34eOfqGb8Ury1P1QK2QsrkJSWklH/z
 Khc4CL+qoxXLF1CJNb356chH5jNyC62VIBjV8T5Otxk2JjzW3L1td2wafLIyK0qR9uld
 6OlVAd/0dLppr2Z0PWW/bmtuVL2jRaCC+bWKpyBdqlZFdnt273Ic5WS4L4KoHx7TBWQ+
 axRkQvuxrhCZiVr18ppfCvCSfqQ9VKCJc0sRLfxouJehaNYE8AOh4xchoDl525tAV+4a
 nhyDqro0RHdXcRTWZQVBliN4L58T+VREod7FY6CChEsWq1tLcpZO91d2mHg9LD9WN+0o
 d+Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdygJcckUVfsChhwnKR8melSLZx7EIS50dMoZZ6HUkgDbvPLZ5dB2lGtKSlqZWnZkdmC/TrH1Yhgk7@nongnu.org
X-Gm-Message-State: AOJu0Ywkm05raZq+Hlx08uvrA4WDSkSa16PCZuRe61f5Xe9F+L/OG7tH
 tSdICh3EImlzoLwUkzvXtEiAtpopt08tt8zHqJQs3PdlvMBWb4mEtu6oe7q793KtWTXgFAOJCmr
 vCiGAtXGEUf77gT728JVRj1LSmy+pWq7IM6Fc68H7Ul+/gzgPXccw
X-Received: by 2002:a05:6358:8096:b0:1b5:a0d5:cc10 with SMTP id
 e5c5f4694b2df-1b5a2675e56mr394825755d.7.1724269530668; 
 Wed, 21 Aug 2024 12:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQAma+3SMgtQmjR9lxTGzWmbESj3ipkZIB03aqRPqXJRPLRQdWV6RSocm9XMp59tiJxvAN1A==
X-Received: by 2002:a05:6358:8096:b0:1b5:a0d5:cc10 with SMTP id
 e5c5f4694b2df-1b5a2675e56mr394821755d.7.1724269530169; 
 Wed, 21 Aug 2024 12:45:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff051c1csm658941185a.43.2024.08.21.12.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 12:45:29 -0700 (PDT)
Date: Wed, 21 Aug 2024 15:45:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZsZD1t-imC0vVH6t@x1n>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
 <ZnrZ9W6WpvmDBpgv@x1n>
 <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com>
 <ZnsUnKZHtsMKQc_2@x1n>
 <3af67d66-075d-4162-916b-b407332042e2@oracle.com>
 <Znxg3jyYAfJQIHUB@x1n>
 <qo3ius6ts3zhon6xivwyfcib3ubhmga6d7r763v64xzblqnnjz@ki3sbi2vde55>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qo3ius6ts3zhon6xivwyfcib3ubhmga6d7r763v64xzblqnnjz@ki3sbi2vde55>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jul 26, 2024 at 12:41:57AM -0700, Elena Ufimtseva wrote:
> On Wed, Jun 26, 2024 at 02:41:34PM -0400, Peter Xu wrote:
> > On Wed, Jun 26, 2024 at 12:04:43PM +0100, Joao Martins wrote:
> > > Are you thinking in something specifically?
> > 
> > Not really. I don't think I have any idea on how to make it better,
> > unfortunately, but we did some measurement too quite some time ago and I
> > can share some below.
> 
> 
> Hello Peter
> 
> I apologize for such a long delay with the reply.

I apologize back.. :)

> 
> > 
> > > 
> > > Many "variables" affect this from the point we decide switchover, and at the
> > > worst (likely) case it means having qemu subsystems declare empirical values on
> > > how long it takes to suspend/resume/transfer-state to migration expected
> > > downtime prediction equation. Part of the reason that having headroom within
> > > downtime-limit was a simple 'catch-all' (from our PoV) in terms of
> > > maintainability while giving user something to fallback for characterizing its
> > > SLA.
> > 
> > Yes, I think this might be a way to go, by starting with something that can
> > catch all.
> 
> 
> Possibly the title "strict SLA" is not the best choice of
> words as it creates impression that the guarantees will be met.
> But essentially this switchover limit is a safeguard against the unknowns
> that can contribute to the downtime during the stop-copy and can be not
> that easy to account for (or even impossible due to hardware
> implementation or other issues).
> 
> To show what kind of statistics we see in our environments and what
> are the main contributors please see below.
> 
> Example 1: host migration, default downtime set to 300:
> 
> Checkpoints analysis:
> 
>   checkpoint=src-downtime-start -> checkpoint=src-vm-stopped:                   74244 (us)
>   checkpoint=src-vm-stopped -> checkpoint=src-iterable-saved:                   154493 (us)
>   checkpoint=src-iterable-saved -> checkpoint=src-non-iterable-saved:           4746 (us)
>   checkpoint=src-non-iterable-saved -> checkpoint=dst-precopy-loadvm-completed: 224981 (us)

This is the first cross-host time diff, I assume the two hosts are
synchronized and the time diff is pretty low.

I guess part like this is not accounted in the switchover decision by src
QEMU, with the hope that after src QEMU sent everything with the estimated
bandwidth the dest QEMU should have (mostly) loaded everything.

It might be interesting to know when this can grow much larger than we
expect.  More below..

>   checkpoint=dst-precopy-loadvm-completed -> checkpoint=dst-precopy-bh-enter:   36 (us)
>   checkpoint=dst-precopy-bh-enter -> checkpoint=dst-precopy-bh-announced:       7859 (us)
>   checkpoint=dst-precopy-bh-announced -> checkpoint=dst-precopy-bh-vm-started:  15995 (us)
>   checkpoint=dst-precopy-bh-vm-started -> checkpoint=src-downtime-end:          236 (us)
> 
> Iterable device analysis:
> 
>   Device SAVE of                                      ram:  0 took     151054 (us)
>   Device LOAD of                                      ram:  0 took     146855 (us)
>   Device SAVE of              0000:20:04.0:00.0:00.0/vfio:  0 took       2127 (us)
>   Device LOAD of              0000:20:04.0:00.0:00.0/vfio:  0 took     144202 (us)
> 
> Non-iterable device analysis:
> 
>   Device LOAD of              0000:20:04.0:00.0:00.0/vfio:  0 took      67470 (us)
>   Device LOAD of                         0000:00:01.0/vga:  0 took       7527 (us)
>   Device LOAD of                      0000:00:02.0/e1000e:  0 took       1715 (us)
>   Device LOAD of                              kvm-tpr-opt:  0 took       1697 (us)
>   Device LOAD of                  0000:00:03.0/virtio-blk:  0 took       1340 (us)
>   Device SAVE of                      0000:00:02.0/e1000e:  0 took       1036 (us)
>   Device LOAD of                         0000:00:00.0/mch:  0 took       1035 (us)
>   Device LOAD of         0000:20:04.0:00.0/pcie-root-port:  0 took        976 (us)
>   Device LOAD of                     0000:00:1f.0/ICH9LPC:  0 took        851 (us)
>   Device LOAD of                   0000:00:1f.2/ich9_ahci:  0 took        578 (us)
> 
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> decompress-error-check: on
> clear-bitmap-shift: 18
> Migration status: completed
> total time: 5927 ms
> downtime: 483 ms
> setup: 78 ms
> transferred ram: 883709 kbytes
> throughput: 1237.71 mbps
> remaining ram: 0 kbytes
> total ram: 33571656 kbytes
> duplicate: 8192488 pages
> skipped: 0 pages
> normal: 201300 pages
> normal bytes: 805200 kbytes
> dirty sync count: 3
> page size: 4 kbytes
> multifd bytes: 0 kbytes
> pages-per-second: 958776
> precopy ram: 480464 kbytes
> downtime ram: 398313 kbytes
> vfio device transferred: 4496 kbytes
> 
> Example 2: different system than above,  live migration over 100Gbit/s 
> connection and 2 vfio virtual functions (the guest has no workload and
> vfio devices are not engaged in VM and have same amount of data to live
> migrate).
> 
> Displayed outliers that are larger than 3 us.
> 
> Save:
> 252812@1721976657.700972:vmstate_downtime_checkpoint src-downtime-start
> 252812@1721976657.829180:vmstate_downtime_checkpoint src-vm-stopped
> 252812@1721976657.967987:vmstate_downtime_save type=iterable idstr=ram instance_id=0 downtime=138005
> 252812@1721976658.093218:vmstate_downtime_save type=iterable idstr=0000:00:02.0/vfio instance_id=0 downtime=125188
> 252812@1721976658.318101:vmstate_downtime_save type=iterable idstr=0000:00:03.0/vfio instance_id=0 downtime=224857
> 252812@1721976658.318125:vmstate_downtime_checkpoint src-iterable-saved
> ...
> 
> Load:
> 353062@1721976488.995582:vmstate_downtime_load type=iterable idstr=ram instance_id=0 downtime=117294
> 353062@1721976489.235227:vmstate_downtime_load type=iterable idstr=0000:00:02.0/vfio instance_id=0 downtime=239586
> 353062@1721976489.449736:vmstate_downtime_load type=iterable idstr=0000:00:03.0/vfio instance_id=0 downtime=214462
> 353062@1721976489.463260:vmstate_downtime_load type=non-iterable idstr=0000:00:01.0/vga instance_id=0 downtime=7522
> 353062@1721976489.575383:vmstate_downtime_load type=non-iterable idstr=0000:00:02.0/vfio instance_id=0 downtime=112113
> 353062@1721976489.686961:vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/vfio instance_id=0 downtime=111545
> ...
> 
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> decompress-error-check: on
> clear-bitmap-shift: 18
> Migration status: completed
> total time: 23510 ms
> downtime: 1018 ms
> setup: 380 ms
> transferred ram: 5317587 kbytes
> throughput: 1883.34 mbps
> remaining ram: 0 kbytes
> total ram: 209732424 kbytes
> duplicate: 51628634 pages
> skipped: 0 pages
> normal: 1159697 pages
> normal bytes: 4638788 kbytes
> dirty sync count: 4
> page size: 4 kbytes
> multifd bytes: 4653988 kbytes
> pages-per-second: 1150272
> precopy ram: 453652 kbytes
> downtime ram: 118 kbytes
> vfio device transferred: 209431 kbytes
> 
> As it can be seen from above, the downtime gets violated and the main
> contributors are vfio devices. Also it can very depending on the
> firmare version.

So have you figured out how VFIO affected this?  I thought VFIO will also
report pending information just like RAM, in ->state_pending_exact().

However I don't think such reports involves things like read()/write() over
the VFIO fds.  I assume that can be a major issue that won't be captured by
any form of pending data reports.  It might be useful to first identify /
verify this issue, then think about how to improve the estimation of
downtimes, e.g. by reporting "extra time" (in this case, the time to do
read() / write() from the device driver) needed for the final dump stage
for either iterative/non-iterative data.

> I have to note that in one of 10 tests, the ram downtime is being much
> larger and becomes then the outlier. This is being investigated
> currently.
> 
> This switchover overshoot is usually being reported as timed out queries.
> And to comment on precision, yes, this overshoot safeguard is not
> precise.
> In fact, the current implementation is not precise and has a granularity of the savevm_
> handlers as it would only check the downtime overshoot after it is being
> completed. Maybe this part can be improved by delegating to some of the known
> abusers to observe the downtime overshoot on its own.
> 
> > 
> > > Personally, I think there's a tiny bit disconnect between what the user
> > > desires when setting downtime-limit vs what it really does. downtime-limit right
> > > now looks to be best viewed as 'precopy-ram-downtime-limit' :)
> > 
> > That's fair to say indeed.. QEMU can try to do better on this, it's just
> > not yet straightforward to know how.
> 
> Could be that the better known part of the downtime (and predictable
> taken the bandwidth is accurate), i.e. currently what is downtime-limit, serve
> as a starting point and be named as ram-downtime-limit and everything
> else would have switchover allowance of downtime_limit - ram-downtime-limit?
> The correct value of ram-downtime-limit would take few iterations
> after dirty sync to get established.
> 
> I think that is somewhat similar to what Joao is thinking below in 1) and 2)?

I'm personally curious on whether you can nail the current issues down to
VFIO, and if so whether there can be something we can do already to improve
downtime estimation when VFIO is involved, irrelevant of the rest.

For a generic idea of improving downtime, I think as long as we stick with
downtime_limit parameter untouched (reflecting the total & max downtime),
then we can add some new ideas on top.

Thanks,

> 
> Thanks!
> 
> Elena
> > 
> > > Unless the accuracy work you're thinking is just having a better
> > > migration algorithm at obtaining the best possible downtime for
> > > outstanding-data/RAM *even if* downtime-limit is set at a high limit,
> > > like giving 1) a grace period in the beginning of migration post first
> > > dirty sync
> > 
> > Can you elaborate on this one a bit?
> 
> > 
> > > or 2) a measured value with continually incrementing target downtime
> > > limit until max downtime-limit set by user hits ... before defaulting to
> > > the current behaviour of migrating as soon as expected downtime is within
> > > the downtime-limit. As discussed in the last response, this could create
> > > the 'downtime headroom' for getting the enforcement/SLA better
> > > honored. Is this maybe your line of thinking?
> >
> 
> > Not what I was referring, but I think such logic existed for years, it was
> > just not implemented in QEMU.  I know at least OpenStack implemented
> > exactly that, where instead of keeping an internal smaller downtime_limit
> > and keep increasing that, OpenStack will keep adjusting downtime_limit
> > parameter from time to time, starting with a relatively low value.
> > 
> > That is also what I would suggest to most people who cares about downtime,
> > because QEMU does treat it pretty simple: if QEMU thinks it can switchover
> > within the downtime specified, QEMU will just do it, even if it's not the
> > best it can do.
> > 
> > Do you think such idea should be instead implemented in QEMU, too?  Note
> > that this will also be not about "making downtime accurate", but "reducing
> > downtime", it may depend on how we define downtime_limit in the context,
> > perhaps, where in OpenStack's case it simply won't directly feed that
> > parameter with the real max downtime the user allows.
> > 
> > Since that wasn't my original purpose, what I meant is simply see ways to
> > make downtime_limit accurate, and by analyzing the current downtimes (as
> > you mentioned, using the downtime tracepoints; and I'd say kudos to you on
> > suggesting that in a formal patch).
> > 
> > Here's something we collected by our QE team, for example, on a pretty
> > loaded system of 384 cores + 12TB:
> > 
> > Checkpoints analysis:
> > 
> >             downtime-start ->               vm-stopped:             267635.2 (us)
> >                 vm-stopped ->           iterable-saved:            3558506.2 (us)
> >             iterable-saved ->       non-iterable-saved:             270352.2 (us)
> >         non-iterable-saved ->             downtime-end:             144264.2 (us)
> >                                         total downtime:            4240758.0 (us)
> > 
> > Iterable device analysis:
> > 
> >   Device SAVE of                                      ram:  0 took    3470420 (us)
> > 
> > Non-iterable device analysis:
> > 
> >   Device SAVE of                                      cpu:121 took     118090 (us)
> >   Device SAVE of                                     apic:167 took       6899 (us)
> >   Device SAVE of                                      cpu:296 took       3795 (us)
> >   Device SAVE of             0000:00:02.2:00.0/virtio-blk:  0 took        638 (us)
> >   Device SAVE of                                      cpu:213 took        630 (us)
> >   Device SAVE of             0000:00:02.0:00.0/virtio-net:  0 took        534 (us)
> >   Device SAVE of                                      cpu:374 took        517 (us)
> >   Device SAVE of                                      cpu: 31 took        503 (us)
> >   Device SAVE of                                      cpu:346 took        497 (us)
> >   Device SAVE of             0000:00:02.0:00.1/virtio-net:  0 took        492 (us)
> >   (1341 vmsd omitted)
> > 
> > In this case we also see the SLA violations since we specified something
> > much lower than 4.2sec as downtime_limit.
> > 
> > This might not be a good example, as I think when capturing the traces we
> > used to still have the issue on inaccurate bw estimations, and that was why
> > I introduced switchover-bandwidth parameter, I wished after that the result
> > can be closer to downtime_limit but we never tried to test again.  I am not
> > sure either on whether that's the best way to address this.
> > 
> > But let's just ignore the iterable save() huge delays (which can be
> > explained, and hopefully will still be covered by downtime_limit
> > calculations when it can try to get closer to right), and we can also see
> > at least a few things we didn't account:
> > 
> >   - stop vm: 268ms
> >   - non-iterables: 270ms
> >   - dest load until complete: 144ms
> > 
> > For the last one, we did see another outlier where it can only be seen from
> > dest:
> > 
> > Non-iterable device analysis:
> > 
> >   Device LOAD of                              kvm-tpr-opt:  0 took     123976 (us)  <----- this one
> >   Device LOAD of              0000:00:02.0/pcie-root-port:  0 took       6362 (us)
> >   Device LOAD of             0000:00:02.0:00.0/virtio-net:  0 took       4583 (us)
> >   Device LOAD of             0000:00:02.0:00.1/virtio-net:  0 took       4440 (us)
> >   Device LOAD of                         0000:00:01.0/vga:  0 took       3740 (us)
> >   Device LOAD of                         0000:00:00.0/mch:  0 took       3557 (us)
> >   Device LOAD of             0000:00:02.2:00.0/virtio-blk:  0 took       3530 (us)
> >   Device LOAD of                   0000:00:02.1:00.0/xhci:  0 took       2712 (us)
> >   Device LOAD of              0000:00:02.1/pcie-root-port:  0 took       2046 (us)
> >   Device LOAD of              0000:00:02.2/pcie-root-port:  0 took       1890 (us)
> > 
> > So we found either cpu save() taking 100+ms, or kvm-tpr-opt load() taking
> > 100+ms.  None of them sounds normal, and I didn't look into them.
> >
> 
> 
> 
> > Now with a global ratio perhaps start to reflect "how much ratio of
> > downtime_limit should we account into data transfer", then we'll also need
> > to answer how the user should set that ratio value, and maybe there's a
> > sane way to calculate that by the VM setup?  I'm not sure, but those
> > questions may need to be answered together in the next post, so that such
> > parameter can be consumable.
> 
> > 
> > The answer doesn't need to be accurate, but I hope that can be based on
> > some similar analysis like above (where I didn't do it well; as I don't
> > think I looked into any of the issues, and maybe they're fix-able).  But
> > just to show what I meant.  It'll be also great when doing the analysis we
> > found issues fix-able, then it'll be great we fix the issues intead.
> > That's the part when I mentioned "I still prefer fixing downtime_limit
> > itself".
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> > 
> 

-- 
Peter Xu


