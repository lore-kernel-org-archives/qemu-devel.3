Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F04CD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsgJ-0003pk-IP; Wed, 04 Sep 2024 12:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slsgD-0002vF-62
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slsgA-0002O8-QY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725466580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yjvVdaCKp/cHkf/5evnSeHUSGPMrlt8w2c4AH5U6j0Y=;
 b=XaVGtNRh6B6amuYk6h3txDvTvQSkAha5AXBooOTE5KwCSs6QpeTtEcdrVvSZX5k7DgTVu8
 /0A57gM3herD5eC9qWmpsmSgFmSdjylSi8Dqg1bSC5WaU2NDdJumlF9Hpbuz+yO965J8+6
 RAhCQLBxHcQsgM3jfviZC1oZ8NT5cEI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-l2AAhZxFNha7QlpHs-KHVQ-1; Wed, 04 Sep 2024 12:16:18 -0400
X-MC-Unique: l2AAhZxFNha7QlpHs-KHVQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-457d015a9d2so52113781cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466578; x=1726071378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjvVdaCKp/cHkf/5evnSeHUSGPMrlt8w2c4AH5U6j0Y=;
 b=JdrPqHs1H3Ltr8CQUIaH6bSDDWprwnM2zYZ/2I0JzFD+d40FbLqwzk6qxPShw62B9h
 qNQHmWBdGZ4YQxqHIoadN9TEOw/6xieGnLrnn1pvCOT1nOP+PaZvLXpFmdGJwC71EAvP
 Hd7EpwR3jzBInpiAp2+sJizdTSkMMOwXJljZOsr0sYvfnJw1QqjDwp23zt+rBmmO0tcC
 kzm3AFTAJ+7C6NsVLSgdQYg9BscCEVEHGGBIVPsoGKbbtOMSQOxIvwZ/UX2Qs5YSNiVV
 eOR0xPlaLn2HMCbTzCqbDV9OG14Tehzwe1qdXjg+QCZnmKAJqnUGigW63LsYSOdv54Un
 bpzw==
X-Gm-Message-State: AOJu0YxIEMnZDj3loO4yVsF/20kf7icWD9Lwy+rcJSpJwMp5MjoMmQPZ
 9ujVncvs/BDcb8oDTNISJaWQ7usQ+KkN58sThfiPs5FBPBHB2zTK1PP3IFAfdZaP28zTDsXI/JA
 egh/LhNQrxCsFwH7MshOiU+8pMMQpVagwj2NN36cdw28YQ7lA6qzh
X-Received: by 2002:a05:622a:408b:b0:455:9ee:fe60 with SMTP id
 d75a77b69052e-4567f4e2ba9mr287172141cf.8.1725466577890; 
 Wed, 04 Sep 2024 09:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxUyN87y+vIO22XdSuScOjrZMfVSmPoRDEnISvNx/WwjpYObYAXlxyK5oi3qzTWTqCzaG6RQ==
X-Received: by 2002:a05:622a:408b:b0:455:9ee:fe60 with SMTP id
 d75a77b69052e-4567f4e2ba9mr287171691cf.8.1725466577165; 
 Wed, 04 Sep 2024 09:16:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c82a52sm59718781cf.16.2024.09.04.09.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:16:16 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:16:13 -0400
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
Message-ID: <ZtiHzQHJ4PgWc21e@x1n>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 04, 2024 at 06:41:03PM +0300, Avihai Horon wrote:
> 
> On 04/09/2024 16:00, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hello, Avihai,
> > 
> > Reviving this thread just to discuss one issue below..
> > 
> > On Thu, Feb 16, 2023 at 04:36:27PM +0200, Avihai Horon wrote:
> > > +/*
> > > + * Migration size of VFIO devices can be as little as a few KBs or as big as
> > > + * many GBs. This value should be big enough to cover the worst case.
> > > + */
> > > +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
> > > +
> > > +/*
> > > + * Only exact function is implemented and not estimate function. The reason is
> > > + * that during pre-copy phase of migration the estimate function is called
> > > + * repeatedly while pending RAM size is over the threshold, thus migration
> > > + * can't converge and querying the VFIO device pending data size is useless.
> > > + */
> > > +static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> > > +                                     uint64_t *can_postcopy)
> > > +{
> > > +    VFIODevice *vbasedev = opaque;
> > > +    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
> > > +
> > > +    /*
> > > +     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
> > > +     * reported so downtime limit won't be violated.
> > > +     */
> > > +    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> > > +    *must_precopy += stop_copy_size;
> > Is this the chunk of data only can be copied during VM stopped?  If so, I
> > wonder why it's reported as "must precopy" if we know precopy won't ever
> > move them..
> 
> A VFIO device that doesn't support precopy will send this data only when VM
> is stopped.
> A VFIO device that supports precopy may or may not send this data (or part
> of it) during precopy, and it depends on the specific VFIO device.
> 
> According to state_pending_{estimate,exact} documentation, must_precopy is
> the amount of data that must be migrated before target starts, and indeed
> this VFIO data must be migrated before target starts.

Correct.  It's just that estimate/exact API will be more suitable when the
exact() gets the report closer to estimate(), while the estimate() is only
a fast-path of exact().  It'll cause some chaos like this if it doesn't do
as so.

Since we have discussion elsewhere on the fact that we currently ignore
non-iterative device states during migration decides to switchover, I was
wondering when reply on whether this stop-size could be the first thing
that will start to provide such non-iterable pending data.  But that might
indeed need more thoughts, at least we may want to collect more outliers of
non-iterative device states outside VFIO that can cause downtime to be too
large.

> 
> > 
> > The issue is if with such reporting (and now in latest master branch we do
> > have the precopy size too, which was reported both in exact() and
> > estimate()), we can observe weird reports like this:
> > 
> > 23411@1725380798968696657 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > 23411@1725380799050766000 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
> > 23411@1725380799050896975 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > 23411@1725380799138657103 migrate_pending_exact exact pending size 21040144384 (pre = 21040144384 post=0)
> > 23411@1725380799140166709 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > 23411@1725380799217246861 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
> > 23411@1725380799217384969 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > 23411@1725380799305147722 migrate_pending_exact exact pending size 21039976448 (pre = 21039976448 post=0)
> > 23411@1725380799306639956 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > 23411@1725380799385118245 migrate_pending_exact exact pending size 21038796800 (pre = 21038796800 post=0)
> > 23411@1725380799385709382 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> > 
> > So estimate() keeps reporting zero but the exact() reports much larger, and
> > it keeps spinning like this.  I think that's not how it was designed to be
> > used..
> 
> It keeps spinning and migration doesn't converge?
> If so, configuring a higher downtime limit or the avail-switchover-bandwidth
> parameter may solve it.

Yes, this is the only way to go, but it's a separate issue on reportings of
estimate()/exact().  More below.

> 
> > 
> > Does this stop copy size change for a VFIO device or not?
> 
> It depends on the specific VFIO device.
> If the device supports precopy and all (or part) of its data is
> precopy-able, then stopcopy size will change.
> Besides that, the amount of resources currently used by the VFIO device can
> also affect the stopcopy size, and it may increase or decrease as resources
> are created or destroyed.

I see, thanks.

> 
> > IIUC, we may want some other mechanism to report stop copy size for a
> > device, rather than reporting it with the current exact()/estimate() api.
> > That's, per my undertanding, only used for iterable data, while
> > stop-copy-size may not fall into that category if so.
> 
> The above situation is caused by the fact that VFIO data may not be fully
> precopy-able (as opposed to RAM data).
> I don't think reporting the stop-copy-size in a different API will help the
> above situation -- we would still have to take stop-copy-size into account
> before converging, to not violate downtime.

It will help some other situation, though.

One issue with above freqeunt estimate()/exact() call is that QEMU will go
into madness loop thinking "we're close" and "we're far away from converge"
even if the reality is "we're far away". The bad side effect is when this
loop happens it'll not only affect VFIO but also other devices (e.g. KVM,
vhost, etc.) so we'll do high overhead sync() in an extremely frequent
manner.  IMHO they're totally a waste of resource, because all the rest of
the modules are following the default rules of estimate()/exact().

One simple but efficient fix for VFIO, IMHO, is at least VFIO should also
cache the stop-size internally and report in estimate(), e.g.:

/* Give an estimate of the amount left to be transferred,
 * the result is split into the amount for units that can and
 * for units that can't do postcopy.
 */
void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                        uint64_t *can_postcopy)
{
}

If it's justified that the stop-size to be reported in exact(), it should
also be reported in estimate() per the comment above.  It should also fall
into precopy category in this case.

Then with that we should avoid calling exact() frequently for not only VFIO
but also others (especially, KVM GET_DIRTY_LOG / CLEAR_DIRTY_LOG ioctls),
then we know it won't converge anyway without the help of tuning downtime
upper, or adjust avail-switchover-bandwidth.

This may improve situation but still leave one other issue, that IIUC even
with above change and even if we can avoid sync dirty bitmap frequently,
the migration thread can still spinning 100% calling estimate() and keep
seeing data (which is not iterable...).  For the longer term we may still
need to report non-iterable stop-size in another way so QEMU knows that
iterate() over all the VMState registers won't help in this case, so it
should go into sleep without eating the cores.  I hope that explains why I
think a new API should be still needed for the long run.

Thanks,

-- 
Peter Xu


