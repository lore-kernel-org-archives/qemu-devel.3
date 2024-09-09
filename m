Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042BDECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sng3T-0004i5-Fi; Mon, 09 Sep 2024 11:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sng3P-0004X5-Dg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sng3N-0000fa-Nw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725894702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5lZdaoZoX9fM7sYQIgcpeQqv7PokUUvIv2qkRsyBHg=;
 b=evQymNC6NG86F4/ZucAXsJImPnQj1hj6DuBCdaQygmdKaOe8/Tjg2f2AKCQ+FbxzyoEfJN
 +WXmPD+eJMqmJV2Idecge5sTazrnXD6Z4+FtqU6/GmSkXZDnkUmlmTc5pT+0JbsUpBVC6B
 Kj0oAwsCAJ/tPaLdoq5wjlNmFrQ2Kwc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-JsrE8dTpOf2ym4Rl51KMuA-1; Mon, 09 Sep 2024 11:11:41 -0400
X-MC-Unique: JsrE8dTpOf2ym4Rl51KMuA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c366dfd540so57993506d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725894701; x=1726499501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5lZdaoZoX9fM7sYQIgcpeQqv7PokUUvIv2qkRsyBHg=;
 b=tk2PicyocflV8vOeKKt7698vzRgeOLIkMitQD+FggOuAhlzAE2AyuOasMEPMKsfslP
 5orU1+N5nYECT9QG+C0XH5iPtlX1CQ0ojTi0QWhyqx+E7Dg9CFAGpTdje+M0jqkdGEPh
 o4uMvlheQAqKvDgCSnhcve/3/+p9l8xhMP5jQ0yJBLtLgAf+3+ORiakmdk0AxMwL/dEb
 GGKminO2Cl98BU8rX78IvKCTy3z5GbzMnGSP6Fl6x1hk5J2ZKiWkmoQtlyH4LVT6ucI8
 Z90CGbI0G1BSPNvhgkzbFG0VA03hvyaAnM2CiynO7x02OGUkfx2VoDroocgHA0fSN1DJ
 iyPQ==
X-Gm-Message-State: AOJu0YyYWvqYViOpUjRIJKYLzbcMVfW2R8WcjjlutLwnVJ/6huKcK2q5
 5If+hRhfdxZrLDwe5Kzr82xjvOViOR5YgIfmVLXXIN9RqV6i3ZR3Z0k448jhwafkUCn8b3QZ6sz
 mWumxKQg14EuJOMn7bq1U53eOn19GkQnBltdiiuHNMz9GDnR6cemz
X-Received: by 2002:a05:6214:3186:b0:6c3:6bfc:77ba with SMTP id
 6a1803df08f44-6c528507144mr139762796d6.30.1725894700756; 
 Mon, 09 Sep 2024 08:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6IPc4ZhwHmXhAOxoQyob5MLBk1erIPIWqi5BgulNTpsyXLvzMm8mA7rFYKfeKDs8Zow3tbQ==
X-Received: by 2002:a05:6214:3186:b0:6c3:6bfc:77ba with SMTP id
 6a1803df08f44-6c528507144mr139762336d6.30.1725894700326; 
 Mon, 09 Sep 2024 08:11:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534787497sm21513796d6.140.2024.09.09.08.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 08:11:38 -0700 (PDT)
Date: Mon, 9 Sep 2024 11:11:36 -0400
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
Message-ID: <Zt8QKPZiw6BXgh-5@x1n>
References: <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
 <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
 <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com>
 <ZtnbD69EeXhR6FFc@x1n>
 <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com>
 <Ztn5CcxhzYR-SFfE@x1n>
 <c4eebbbd-00aa-4893-90f8-e6faeb08db90@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4eebbbd-00aa-4893-90f8-e6faeb08db90@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 09, 2024 at 03:52:39PM +0300, Avihai Horon wrote:
> 
> On 05/09/2024 21:31, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Sep 05, 2024 at 07:45:43PM +0300, Avihai Horon wrote:
> > > > Does it also mean then that the currently reported stop-size - precopy-size
> > > > will be very close to the constant non-iterable data size?
> > > It's not constant, while the VM is running it can change.
> > I wonder how heavy is VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl.
> > 
> > I just gave it a quick shot with a busy VM migrating and estimate() is
> > invoked only every ~100ms.
> > 
> > VFIO might be different, but I wonder whether we can fetch stop-size in
> > estimate() somehow, so it's still a pretty fast estimate() meanwhile we
> > avoid the rest of exact() calls (which are destined to be useless without
> > VFIO).
> > 
> > IIUC so far the estimate()/exact() was because ram sync is heavy when
> > exact().  When idle it's 80+ms now for 32G VM with current master (which
> > has a bug and I'm fixing it up [1]..), even if after the fix it's 3ms (I
> > think both numbers contain dirty bitmap sync for both vfio and kvm).  So in
> > that case maybe we can still try fetching stop-size only for both
> > estimate() and exact(), but only sync bitmap in exact().
> 
> IIUC, the end goal is to prevent migration thread spinning uselessly in
> pre-copy in such scenarios, right?
> If eventually we do call get stop-copy-size in estimate(), we will move the
> spinning from "exact() -> estimate() -> exact() -> estimate() ..." to
> "estimate() -> estimate() -> ...".
> If so, what benefit would we get from this? We only move the useless work to
> other place.

We can avoid exact() calls invoked for other vmstate handlers, e.g. RAM,
which can be much heavier and can require BQL during the slow process,
which can further block more vcpu operations during migration.

And as mentioned previously, VFIO is, AFAIK, the only handler that provide
different definitions of estimate() and exact(), which can be confusing,
and it's against the "estimate() is the fast-path" logic.

But I agree it's not fundamentally changing much..

> Shouldn't we directly go for the non precopy-able vs precopy-able report
> that you suggested?

Yep, I just thought the previous one would be much easier to achieve.  And
as you said, VFIO is still pretty special that the user will need manual
involvements anyway to specify e.g. very large downtimes, so this condition
shouldn't be a major case to happen.  Said that, if you have a solid idea
on this please feel free to go ahead directly with a complete solution.

Thanks,

-- 
Peter Xu


