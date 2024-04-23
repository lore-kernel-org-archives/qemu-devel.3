Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79901C10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOjx-0005VW-Eg; Tue, 23 Apr 2024 18:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOjv-0005Em-20
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOjs-0005fv-Ol
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmyL6OelpGAgbRLV/gLwXGJtGL8wOKtXlogwc0HDeqE=;
 b=C5pdNpjnjE77rgoUMwRd77RH5BjPaTj/Fd7x/7FmK8Bz9DjPlO+nA4ao4pequCg+/5MKpT
 Iyh3ELo2gpyNlt5Tcc+up1eVckVObSkQWNTKez1GYgL/mzDF26lelGLwQL5E6zGZ3AP9N5
 etdGmh3BWQphwEckd/X2h40tysitO6Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-0VwfsgP-M3-EWDJ0AoOa1Q-1; Tue, 23 Apr 2024 18:35:45 -0400
X-MC-Unique: 0VwfsgP-M3-EWDJ0AoOa1Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a01116b273so18944086d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911745; x=1714516545;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmyL6OelpGAgbRLV/gLwXGJtGL8wOKtXlogwc0HDeqE=;
 b=HWeOasVn6fIMMpNDifud/q+1McVotNxahpEEv9t7/YVKlBcevPQoufFlnGIYvx8MbR
 5GK9FRfmFQI6YJbiTtilUoPL2gOtaE3OBdT7nIFQqCUB3PYQgSWFOIg0Ef3Jwbq3+sNI
 uIHSsFMeDZ7Bvo9zQ2v3udiFQYvkVi14+slzQOJqBD5S6re2QTzIDrPcBTw7HfBQsgIO
 Q4PvFwl/SbPdtoRCUEm7frGijicJ57YAX1M5yYO5brgGAbaA6UKihRHvzj47Nin5OuFe
 hkwYebuPoi0mliPN/5EdIHykIwfKHK5ASkiYLeeEQaONhWY38wjLgM5xVFuNT4dXuOLQ
 YwSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlpV/e0IcxYCpzGWOZYwqwW8zZqtL+/MKCk3t9BJXkvYBM2KM8jdW/7tKe6wh7n+0TK+Cj2W05Bjr91lfdziQiDPa+spg=
X-Gm-Message-State: AOJu0Ywvg9vB6PLBFlxhk+XjhrUEleHzbsS6+55jU7VXwmHrcX3N/whs
 zV5kmILuB9/OZefxaSwVO8PqVZhn0d4jK7wQyiZ1pG+u7OGYg/QkR1KPsF+uVNmYFKfNO1ljLwe
 J5sizz/JNlxFlMdEa40GPMzFbHa7wuEiz7rGwxpJ8v4n0WcmsfVCD
X-Received: by 2002:a05:6214:21ac:b0:699:2d88:744f with SMTP id
 t12-20020a05621421ac00b006992d88744fmr771860qvc.4.1713911744397; 
 Tue, 23 Apr 2024 15:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo2KEIDy0iM0DnJFXnBHTYto7375h+A3TbcvNJY4Y1nIwZdlnziTBot6UaUF+y+F+CpyaaQQ==
X-Received: by 2002:a05:6214:21ac:b0:699:2d88:744f with SMTP id
 t12-20020a05621421ac00b006992d88744fmr771840qvc.4.1713911743966; 
 Tue, 23 Apr 2024 15:35:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 v18-20020a0cdd92000000b0069b7deb02dasm5467842qvk.117.2024.04.23.15.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:35:43 -0700 (PDT)
Date: Tue, 23 Apr 2024 18:35:41 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Zig3vebacR4SfJLh@x1n>
References: <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com>
 <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 24, 2024 at 12:25:08AM +0200, Maciej S. Szmigiero wrote:
> On 24.04.2024 00:20, Peter Xu wrote:
> > On Tue, Apr 23, 2024 at 06:15:35PM +0200, Maciej S. Szmigiero wrote:
> > > On 19.04.2024 17:31, Peter Xu wrote:
> > > > On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
> > > > > On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
> > > > > > On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > I think one of the reasons for these results is that mixed (RAM + device
> > > > > > > state) multifd channels participate in the RAM sync process
> > > > > > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > > > > > 
> > > > > > Firstly, I'm wondering whether we can have better names for these new
> > > > > > hooks.  Currently (only comment on the async* stuff):
> > > > > > 
> > > > > >     - complete_precopy_async
> > > > > >     - complete_precopy
> > > > > >     - complete_precopy_async_wait
> > > > > > 
> > > > > > But perhaps better:
> > > > > > 
> > > > > >     - complete_precopy_begin
> > > > > >     - complete_precopy
> > > > > >     - complete_precopy_end
> > > > > > 
> > > > > > ?
> > > > > > 
> > > > > > As I don't see why the device must do something with async in such hook.
> > > > > > To me it's more like you're splitting one process into multiple, then
> > > > > > begin/end sounds more generic.
> > > > > > 
> > > > > > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > > > > > into >1 phases too. For example, I would be curious whether the performance
> > > > > > will go back to normal if we offloading multifd_send_sync_main() into the
> > > > > > complete_precopy_end(), because we really only need one shot of that, and I
> > > > > > am quite surprised it already greatly affects VFIO dumping its own things.
> > > > > > 
> > > > > > I would even ask one step further as what Dan was asking: have you thought
> > > > > > about dumping VFIO states via multifd even during iterations?  Would that
> > > > > > help even more than this series (which IIUC only helps during the blackout
> > > > > > phase)?
> > > > > 
> > > > > To dump during RAM iteration, the VFIO device will need to have
> > > > > dirty tracking and iterate on its state, because the guest CPUs
> > > > > will still be running potentially changing VFIO state. That seems
> > > > > impractical in the general case.
> > > > 
> > > > We already do such interations in vfio_save_iterate()?
> > > > 
> > > > My understanding is the recent VFIO work is based on the fact that the VFIO
> > > > device can track device state changes more or less (besides being able to
> > > > save/load full states).  E.g. I still remember in our QE tests some old
> > > > devices report much more dirty pages than expected during the iterations
> > > > when we were looking into such issue that a huge amount of dirty pages
> > > > reported.  But newer models seem to have fixed that and report much less.
> > > > 
> > > > That issue was about GPU not NICs, though, and IIUC a major portion of such
> > > > tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
> > > > maybe they work differently.
> > > 
> > > The device which this series was developed against (Mellanox ConnectX-7)
> > > is already transferring its live state before the VM gets stopped (via
> > > save_live_iterate SaveVMHandler).
> > > 
> > > It's just that in addition to the live state it has more than 400 MiB
> > > of state that cannot be transferred while the VM is still running.
> > > And that fact hurts a lot with respect to the migration downtime.
> > > 
> > > AFAIK it's a very similar story for (some) GPUs.
> > 
> > So during iteration phase VFIO cannot yet leverage the multifd channels
> > when with this series, am I right?
> 
> That's right.
> 
> > Is it possible to extend that use case too?
> 
> I guess so, but since this phase (iteration while the VM is still
> running) doesn't impact downtime it is much less critical.

But it affects the bandwidth, e.g. even with multifd enabled, the device
iteration data will still bottleneck at ~15Gbps on a common system setup
the best case, even if the hosts are 100Gbps direct connected.  Would that
be a concern in the future too, or it's known problem and it won't be fixed
anyway?

I remember Avihai used to have plan to look into similar issues, I hope
this is exactly what he is looking for.  Otherwise changing migration
protocol from time to time is cumbersome; we always need to provide a flag
to make sure old systems migrates in the old ways, new systems run the new
ways, and for such a relatively major change I'd want to double check on
how far away we can support offload VFIO iterations data to multifd.

Thanks,

-- 
Peter Xu


