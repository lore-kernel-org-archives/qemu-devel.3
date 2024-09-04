Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E704CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 13:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpjj-0008Jk-6w; Wed, 04 Sep 2024 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slpjT-0007OT-9n
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slpjR-0000tO-Bz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725455233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NTFi6cU9Ua3KeHBZbluTmrh0ksUU7mWFhoh1C/+DyA8=;
 b=CliNdMes8lcSdaP3QlNkOayUjtvqMfdMSQyJbYvMwOhLJ9iiTd2yEBPbsYLgFx0LzfZ0Wt
 /5K9oSZ7sKjO4gEZd/tRnNsrBCr/HSYzcVK3hklWoAm1nT+XbcU4UT5Sj6vi7nzQKMoWxY
 LOz5TLx0IugkR5+2vQWlySixsF2mb40=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-a79G2Ie1ObOFXT7Ojh8JSA-1; Wed, 04 Sep 2024 09:00:10 -0400
X-MC-Unique: a79G2Ie1ObOFXT7Ojh8JSA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-457c4ded23cso44035591cf.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 06:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725454809; x=1726059609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTFi6cU9Ua3KeHBZbluTmrh0ksUU7mWFhoh1C/+DyA8=;
 b=KzkZ9UFM65WX8KkMVORkssmlutxDteKnGo5RLae39WJ2sngLztXOpgnzIqK4FouHeT
 WTIyJttQlMtIi1fsu/R8Vm4nYrEN8+X5hGtRq5hEXtLlVCpfC7aFyXQf4iHH14tHaRIr
 OY8R8Jl9Uk5JXwBu9/LRkH7W6OUHqknHzBtqTaTEk91/q208Sl08fvnXrO6EBkF8T9GB
 L06zBJxqMHepsKWzbUjeyg8T4kGZL0hBUGmDeH5MNTj17PfnUmbttPBhIzEagONxfzOo
 G4xrkRSXKHDIKJoIFKTM3IsQ+3HlgFiDus1zSz3he4ifHp9zr8vVBhv5GtE0mLTv+2hI
 E2Hw==
X-Gm-Message-State: AOJu0YwCWBTBvIEkd3Nckb5l7AQSmkqHjbfB+MLCGhX1wUmGSi9leutf
 ixYVhM4fBUJsiWIdU7W5YhjrIxA3Ba0YZk3NUJJqNZaBDpIDdUr946rvZyno4L3r1NxcMLH1Ohn
 rziGYZ2LB3AJI6fYw23rea31ZIhkU4MrZcuqKGT+04gQUgliD0LYP
X-Received: by 2002:a05:622a:1f92:b0:453:1e40:d538 with SMTP id
 d75a77b69052e-45719dd466cmr155694771cf.38.1725454809473; 
 Wed, 04 Sep 2024 06:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxaIBjuI2GmHCe/lspA2+ytNzx+Ez9ifOY1CaqHUDXlEF+1CCLHSvL1pYDkdV/yEKGB3Bg0Q==
X-Received: by 2002:a05:622a:1f92:b0:453:1e40:d538 with SMTP id
 d75a77b69052e-45719dd466cmr155694011cf.38.1725454808735; 
 Wed, 04 Sep 2024 06:00:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cd1f66sm58728561cf.44.2024.09.04.06.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 06:00:08 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:00:05 -0400
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
Message-ID: <ZthZ1aW_JmO3V9dr@x1n>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230216143630.25610-9-avihaih@nvidia.com>
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

Hello, Avihai,

Reviving this thread just to discuss one issue below..

On Thu, Feb 16, 2023 at 04:36:27PM +0200, Avihai Horon wrote:
> +/*
> + * Migration size of VFIO devices can be as little as a few KBs or as big as
> + * many GBs. This value should be big enough to cover the worst case.
> + */
> +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
> +
> +/*
> + * Only exact function is implemented and not estimate function. The reason is
> + * that during pre-copy phase of migration the estimate function is called
> + * repeatedly while pending RAM size is over the threshold, thus migration
> + * can't converge and querying the VFIO device pending data size is useless.
> + */
> +static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> +                                     uint64_t *can_postcopy)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
> +
> +    /*
> +     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
> +     * reported so downtime limit won't be violated.
> +     */
> +    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> +    *must_precopy += stop_copy_size;

Is this the chunk of data only can be copied during VM stopped?  If so, I
wonder why it's reported as "must precopy" if we know precopy won't ever
move them..

The issue is if with such reporting (and now in latest master branch we do
have the precopy size too, which was reported both in exact() and
estimate()), we can observe weird reports like this:

23411@1725380798968696657 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
23411@1725380799050766000 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
23411@1725380799050896975 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
23411@1725380799138657103 migrate_pending_exact exact pending size 21040144384 (pre = 21040144384 post=0)
23411@1725380799140166709 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
23411@1725380799217246861 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
23411@1725380799217384969 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
23411@1725380799305147722 migrate_pending_exact exact pending size 21039976448 (pre = 21039976448 post=0)
23411@1725380799306639956 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
23411@1725380799385118245 migrate_pending_exact exact pending size 21038796800 (pre = 21038796800 post=0)
23411@1725380799385709382 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)

So estimate() keeps reporting zero but the exact() reports much larger, and
it keeps spinning like this.  I think that's not how it was designed to be
used..

Does this stop copy size change for a VFIO device or not?

IIUC, we may want some other mechanism to report stop copy size for a
device, rather than reporting it with the current exact()/estimate() api.
That's, per my undertanding, only used for iterable data, while
stop-copy-size may not fall into that category if so.

> +
> +    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> +                                   stop_copy_size);
> +}

-- 
Peter Xu


