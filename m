Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A1FCD5BCC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEEx-0006lr-Tw; Thu, 05 Sep 2024 11:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smEEt-0006kj-IG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smEEr-0003RU-Bg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725549454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raycb4CBXbmUUR/DJbY4Q6BWd1lUuygT6oLPF7BMFJ8=;
 b=dSyAGdkVZq1N4E6QLURe1dLRT9jeUT4aWCfBY9WMah1le9InPg40gUaxLVN5WhEa3xdieT
 TlWlpmjNwbFPzEKYC+cLsnXVy+m4o7T4ofeIceCXWvApkUARuOM54v/SiHUcRuwQ089wol
 QX/fxA2GOntqhVau3iAP483yshVcPsw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-UwYDNbo6Np2DEXg4fYjxww-1; Thu, 05 Sep 2024 11:17:28 -0400
X-MC-Unique: UwYDNbo6Np2DEXg4fYjxww-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4574542503fso16716331cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 08:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725549448; x=1726154248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raycb4CBXbmUUR/DJbY4Q6BWd1lUuygT6oLPF7BMFJ8=;
 b=EB+mJlwiToKUYCId7kUQ4jLw4RyROKUswSoFJjBowRxAsges1kxMhrZ6EJotjidWfV
 YIu/t98rtlJjWjRQukPEJnTjkIVuZel3DlOu4pf7TZwqNMFx25qYFJ0IsEYUfdOyMYBI
 FMXKdHBy9Vm4uf3YOv5V/4zO94KO9uEC9ixo6JSqXE1Ri3P++odSGSFgDcZ3pQS1sdKT
 6E8EfrcVAfJK3naooq67kH/vqG2bUXK+jlrTDzCyha1iC2bIWkaUoaZ+OeUqQUDS1jig
 U7NQXxoqi3Gg6cruMu16i61qyUCxWWPbHwapQKkkWdFdH4vIxYfN5OyCVu47RyfFMoTX
 vn3g==
X-Gm-Message-State: AOJu0YzOlhAKDdKgMJzCEWl3hfUbgMgYH1gESZZr6aPB2a7UU4u/gzqW
 FzoryR2d40pxcQC18d83IpslEMyIBXJAz980h/dXwO/ENOcNk3BEe5CdGcSBq7sTije+gHpD5A5
 z8OmfXWdWpbwdDGUHDBcS2TPgTCVBTHqL/vGGDRs12GG34XkRtF8z
X-Received: by 2002:a05:6214:568d:b0:6c5:120c:9009 with SMTP id
 6a1803df08f44-6c5120c9237mr103207576d6.45.1725549447973; 
 Thu, 05 Sep 2024 08:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi567yR1kpi5TMGgSwUl9DbhhWpAq9iIjwIUdZWRyhxW7h+oeqysASutV7TPk79vpsfOqpIg==
X-Received: by 2002:a05:6214:568d:b0:6c5:120c:9009 with SMTP id
 6a1803df08f44-6c5120c9237mr103207176d6.45.1725549447555; 
 Thu, 05 Sep 2024 08:17:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5202d9370sm8304986d6.57.2024.09.05.08.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 08:17:26 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:17:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
Message-ID: <ZtnLhW-2eo8hA7bQ@x1n>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
 <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Sep 05, 2024 at 02:41:09PM +0300, Avihai Horon wrote:
> 
> On 04/09/2024 19:16, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Sep 04, 2024 at 06:41:03PM +0300, Avihai Horon wrote:
> > > On 04/09/2024 16:00, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > Hello, Avihai,
> > > > 
> > > > Reviving this thread just to discuss one issue below..
> > > > 
> > > > On Thu, Feb 16, 2023 at 04:36:27PM +0200, Avihai Horon wrote:
> > > > > +/*
> > > > > + * Migration size of VFIO devices can be as little as a few KBs or as big as
> > > > > + * many GBs. This value should be big enough to cover the worst case.
> > > > > + */
> > > > > +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
> > > > > +
> > > > > +/*
> > > > > + * Only exact function is implemented and not estimate function. The reason is
> > > > > + * that during pre-copy phase of migration the estimate function is called
> > > > > + * repeatedly while pending RAM size is over the threshold, thus migration
> > > > > + * can't converge and querying the VFIO device pending data size is useless.
> > > > > + */
> > > > > +static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> > > > > +                                     uint64_t *can_postcopy)
> > > > > +{
> > > > > +    VFIODevice *vbasedev = opaque;
> > > > > +    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
> > > > > +
> > > > > +    /*
> > > > > +     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
> > > > > +     * reported so downtime limit won't be violated.
> > > > > +     */
> > > > > +    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> > > > > +    *must_precopy += stop_copy_size;
> > > > Is this the chunk of data only can be copied during VM stopped?  If so, I
> > > > wonder why it's reported as "must precopy" if we know precopy won't ever
> > > > move them..
> > > A VFIO device that doesn't support precopy will send this data only when VM
> > > is stopped.
> > > A VFIO device that supports precopy may or may not send this data (or part
> > > of it) during precopy, and it depends on the specific VFIO device.
> > > 
> > > According to state_pending_{estimate,exact} documentation, must_precopy is
> > > the amount of data that must be migrated before target starts, and indeed
> > > this VFIO data must be migrated before target starts.
> > Correct.  It's just that estimate/exact API will be more suitable when the
> > exact() gets the report closer to estimate(), while the estimate() is only
> > a fast-path of exact().  It'll cause some chaos like this if it doesn't do
> > as so.
> > 
> > Since we have discussion elsewhere on the fact that we currently ignore
> > non-iterative device states during migration decides to switchover, I was
> > wondering when reply on whether this stop-size could be the first thing
> > that will start to provide such non-iterable pending data.  But that might
> > indeed need more thoughts, at least we may want to collect more outliers of
> > non-iterative device states outside VFIO that can cause downtime to be too
> > large.
> 
> Ah, I see.
> 
> > 
> > > > The issue is if with such reporting (and now in latest master branch we do
> > > > have the precopy size too, which was reported both in exact() and
> > > > estimate()), we can observe weird reports like this:
> > > > 
> > > > 23411@1725380798968696657 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > > > 23411@1725380799050766000 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
> > > > 23411@1725380799050896975 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > > > 23411@1725380799138657103 migrate_pending_exact exact pending size 21040144384 (pre = 21040144384 post=0)
> > > > 23411@1725380799140166709 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > > > 23411@1725380799217246861 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
> > > > 23411@1725380799217384969 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > > > 23411@1725380799305147722 migrate_pending_exact exact pending size 21039976448 (pre = 21039976448 post=0)
> > > > 23411@1725380799306639956 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > > > 23411@1725380799385118245 migrate_pending_exact exact pending size 21038796800 (pre = 21038796800 post=0)
> > > > 23411@1725380799385709382 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > > > 
> > > > So estimate() keeps reporting zero but the exact() reports much larger, and
> > > > it keeps spinning like this.  I think that's not how it was designed to be
> > > > used..
> > > It keeps spinning and migration doesn't converge?
> > > If so, configuring a higher downtime limit or the avail-switchover-bandwidth
> > > parameter may solve it.
> > Yes, this is the only way to go, but it's a separate issue on reportings of
> > estimate()/exact().  More below.
> > 
> > > > Does this stop copy size change for a VFIO device or not?
> > > It depends on the specific VFIO device.
> > > If the device supports precopy and all (or part) of its data is
> > > precopy-able, then stopcopy size will change.
> > > Besides that, the amount of resources currently used by the VFIO device can
> > > also affect the stopcopy size, and it may increase or decrease as resources
> > > are created or destroyed.
> > I see, thanks.
> > 
> > > > IIUC, we may want some other mechanism to report stop copy size for a
> > > > device, rather than reporting it with the current exact()/estimate() api.
> > > > That's, per my undertanding, only used for iterable data, while
> > > > stop-copy-size may not fall into that category if so.
> > > The above situation is caused by the fact that VFIO data may not be fully
> > > precopy-able (as opposed to RAM data).
> > > I don't think reporting the stop-copy-size in a different API will help the
> > > above situation -- we would still have to take stop-copy-size into account
> > > before converging, to not violate downtime.
> > It will help some other situation, though.
> > 
> > One issue with above freqeunt estimate()/exact() call is that QEMU will go
> > into madness loop thinking "we're close" and "we're far away from converge"
> > even if the reality is "we're far away". The bad side effect is when this
> > loop happens it'll not only affect VFIO but also other devices (e.g. KVM,
> > vhost, etc.) so we'll do high overhead sync() in an extremely frequent
> > manner.  IMHO they're totally a waste of resource, because all the rest of
> > the modules are following the default rules of estimate()/exact().
> > 
> > One simple but efficient fix for VFIO, IMHO, is at least VFIO should also
> > cache the stop-size internally and report in estimate(), e.g.:
> > 
> > /* Give an estimate of the amount left to be transferred,
> >   * the result is split into the amount for units that can and
> >   * for units that can't do postcopy.
> >   */
> > void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> >                                          uint64_t *can_postcopy)
> > {
> > }
> > 
> > If it's justified that the stop-size to be reported in exact(), it should
> > also be reported in estimate() per the comment above.  It should also fall
> > into precopy category in this case.
> > 
> > Then with that we should avoid calling exact() frequently for not only VFIO
> > but also others (especially, KVM GET_DIRTY_LOG / CLEAR_DIRTY_LOG ioctls),
> > then we know it won't converge anyway without the help of tuning downtime
> > upper, or adjust avail-switchover-bandwidth.
> 
> Yes, it will solve this problem, but IIRC, the reason I didn't cache and
> return stop-copy-size in estimate from the first place was that it wasn't
> fully precopy-able, and that could cause some problems:
> Once we cache and report this size in estimate, it may not decrease anymore
> -- we can't send it during precopy and we might not be able to call get
> stop-copy-size again from the exact path (because estimate might now reach
> below the threshold).
> 
> For example, assume the threshold for convergence is 1GB.
> A VFIO device may report 2GB stop-copy-size (not precopy-able) in the
> beginning of the migration.
> If the VFIO device stop-copy-size changes in the middle of migration (e.g.,
> some of its resources are destroyed) and drops to 900MB, we will still see
> 2GB report in estimate.
> Only when calling the exact handler again we will get the updated 900MB
> value and be able to converge. But that won't happen, because estimate size
> will always be above the 1GB threshold.
> 
> We could prevent these situations and call the get stop-copy-size once every
> X seconds, but it feels a bit awkward.

IMHO the confusion is caused by an unclear definition of stop-size and
precopy-size in VFIO terms.

What I would hope is the stop-size reported should be constant and not be
affected by precopy process happening.  Whatever _can_ change at all should
be reported as precopy-size.

So I wonder why stop-size can change from a driver, and whether that can be
reported in a more predictable fashion.  Otherwise I see little point in
providing both stop-size and precopy-size, otherwise we'll always add them
up into VFIO's total pending-size.  The line on provision which data falls
into which bucket doesn't seem to be clear to me.

> 
> > 
> > This may improve situation but still leave one other issue, that IIUC even
> > with above change and even if we can avoid sync dirty bitmap frequently,
> > the migration thread can still spinning 100% calling estimate() and keep
> > seeing data (which is not iterable...).  For the longer term we may still
> > need to report non-iterable stop-size in another way so QEMU knows that
> > iterate() over all the VMState registers won't help in this case, so it
> > should go into sleep without eating the cores.  I hope that explains why I
> > think a new API should be still needed for the long run.
> 
> Yes, I get your point.
> But is the spinning case very common? AFAIU, if it happens, it may indicate
> some misconfiguration of the migration parameters.

Agreed.

It's just that our QE actively tests such migrations and there're always
weird and similar reports on cpu spinning, so it might be nice to still fix
it at some point.

This shouldn't be super urgent, indeed.  It's just that it can start to
make sense when we have other discussions where reporting non-iteratble
pending data might be pretty useful on its own as an idea.  It's just that
we need to figure out above on how VFIO can report predicatble stop-size in
the drivers, and I wonder whether the drivers can be fixed (without
breaking existing qemu; after all they currently always add both
counters..).

> 
> Anyway, I think your idea may fit VFIO, but still need to think about all
> the small details.

Thanks,

-- 
Peter Xu


