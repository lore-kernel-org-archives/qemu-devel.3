Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFB4C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SdC-0007AD-EL; Mon, 29 Apr 2024 11:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Sd9-0007A0-58
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Sd7-0003Lp-0r
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714403359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mKt5jzEbbSiglLZhVSO3oTI/ygX2hmZR8bmO3nGfMM=;
 b=I4dt12eMHoNKlG6RPv+JYJvdMANiL9scTlhRW0B4I/VUCxZqZCY0rl/5oBNRRkW+6255u/
 bV05DjLlUAhCH/PtnUqNSSxwu+FLzlEbhgrwtFDb0lFAd9hR3v8vATBDrANeyyqgFg3h/g
 9M2CaOSlJRVDvdbWGaQD9gYwKd/5vBA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-z63mKroGNR2eooIt2cwh5g-1; Mon, 29 Apr 2024 11:09:17 -0400
X-MC-Unique: z63mKroGNR2eooIt2cwh5g-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1eac3994b6bso6753735ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714403356; x=1715008156;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+mKt5jzEbbSiglLZhVSO3oTI/ygX2hmZR8bmO3nGfMM=;
 b=j87IqwTqhraMkT42pOdgRNbOhYN5qrn2EL+q7xfbEsWxk9F0yiTWWRHriiHrZo3icJ
 ligUvUTv5UYP0FRRlRCN0KMk/QwJNMiQogHMEqszrM+4uecWvrjPLy5jBqzaHK3ec6F4
 XrqTEkVTJhlx4n4ioh9kFjWSsUOZlNtGWfG6MQx+nkbK0ZIIueMfigq96Xkvm2NUxaYu
 C5b6nF77p/jHLlcY1VQ49jUvsHreMJmFte/Ewgo37NsLmewUrOAeM2kbyh6zor/XlNgu
 Ln0ZY/xGKZKAaGNnSA3yNruHpwxffB00kly0713daafSGTG+pP7YEF+i3LyoqWqmJIWG
 usjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Mjo3Q6P1qIwJwGzLFen2g0JyYCearkCAvfuiZmIJCPuum8qoNPvrW61k/0dEuJvdPKbsqzwKTqDOUNJZJrKKPc4SzZs=
X-Gm-Message-State: AOJu0YyjMasKebON/pv0AtEIrXL7wmaMfGHOed76CLCuO/3fVsxs7NVW
 IqqU+K2YY1DW9W8RgJTrI3axZwP68KJfy0F1cutG55zmsL5nJyCrOwPjRZ5y81EVKrrkJk7jmA8
 ukrE1y3KNLH/5srC3kNHJqVpbgDsvgN71aVYqfqTxe+BX8aguoSYC
X-Received: by 2002:a17:903:1110:b0:1e0:c91b:b950 with SMTP id
 n16-20020a170903111000b001e0c91bb950mr12910435plh.5.1714403355750; 
 Mon, 29 Apr 2024 08:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUwQENSMgPhX0ZAql37wr3Xg3Sf8KbHd6xdDzjnqag8WxEDWNz0asX0j3Yo8MeElE4FMFn+w==
X-Received: by 2002:a17:903:1110:b0:1e0:c91b:b950 with SMTP id
 n16-20020a170903111000b001e0c91bb950mr12910379plh.5.1714403354915; 
 Mon, 29 Apr 2024 08:09:14 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j7-20020a170902da8700b001e0bbd8d0b0sm20425798plx.189.2024.04.29.08.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 08:09:14 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:09:10 -0400
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
Message-ID: <Zi-4FmjXv-gx7JH_@x1n>
References: <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com>
 <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
 <Zig3vebacR4SfJLh@x1n>
 <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Apr 26, 2024 at 07:34:09PM +0200, Maciej S. Szmigiero wrote:
> On 24.04.2024 00:35, Peter Xu wrote:
> > On Wed, Apr 24, 2024 at 12:25:08AM +0200, Maciej S. Szmigiero wrote:
> > > On 24.04.2024 00:20, Peter Xu wrote:
> > > > On Tue, Apr 23, 2024 at 06:15:35PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 19.04.2024 17:31, Peter Xu wrote:
> > > > > > On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
> > > > > > > > On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > I think one of the reasons for these results is that mixed (RAM + device
> > > > > > > > > state) multifd channels participate in the RAM sync process
> > > > > > > > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > > > > > > > 
> > > > > > > > Firstly, I'm wondering whether we can have better names for these new
> > > > > > > > hooks.  Currently (only comment on the async* stuff):
> > > > > > > > 
> > > > > > > >      - complete_precopy_async
> > > > > > > >      - complete_precopy
> > > > > > > >      - complete_precopy_async_wait
> > > > > > > > 
> > > > > > > > But perhaps better:
> > > > > > > > 
> > > > > > > >      - complete_precopy_begin
> > > > > > > >      - complete_precopy
> > > > > > > >      - complete_precopy_end
> > > > > > > > 
> > > > > > > > ?
> > > > > > > > 
> > > > > > > > As I don't see why the device must do something with async in such hook.
> > > > > > > > To me it's more like you're splitting one process into multiple, then
> > > > > > > > begin/end sounds more generic.
> > > > > > > > 
> > > > > > > > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > > > > > > > into >1 phases too. For example, I would be curious whether the performance
> > > > > > > > will go back to normal if we offloading multifd_send_sync_main() into the
> > > > > > > > complete_precopy_end(), because we really only need one shot of that, and I
> > > > > > > > am quite surprised it already greatly affects VFIO dumping its own things.
> > > > > > > > 
> > > > > > > > I would even ask one step further as what Dan was asking: have you thought
> > > > > > > > about dumping VFIO states via multifd even during iterations?  Would that
> > > > > > > > help even more than this series (which IIUC only helps during the blackout
> > > > > > > > phase)?
> > > > > > > 
> > > > > > > To dump during RAM iteration, the VFIO device will need to have
> > > > > > > dirty tracking and iterate on its state, because the guest CPUs
> > > > > > > will still be running potentially changing VFIO state. That seems
> > > > > > > impractical in the general case.
> > > > > > 
> > > > > > We already do such interations in vfio_save_iterate()?
> > > > > > 
> > > > > > My understanding is the recent VFIO work is based on the fact that the VFIO
> > > > > > device can track device state changes more or less (besides being able to
> > > > > > save/load full states).  E.g. I still remember in our QE tests some old
> > > > > > devices report much more dirty pages than expected during the iterations
> > > > > > when we were looking into such issue that a huge amount of dirty pages
> > > > > > reported.  But newer models seem to have fixed that and report much less.
> > > > > > 
> > > > > > That issue was about GPU not NICs, though, and IIUC a major portion of such
> > > > > > tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
> > > > > > maybe they work differently.
> > > > > 
> > > > > The device which this series was developed against (Mellanox ConnectX-7)
> > > > > is already transferring its live state before the VM gets stopped (via
> > > > > save_live_iterate SaveVMHandler).
> > > > > 
> > > > > It's just that in addition to the live state it has more than 400 MiB
> > > > > of state that cannot be transferred while the VM is still running.
> > > > > And that fact hurts a lot with respect to the migration downtime.
> > > > > 
> > > > > AFAIK it's a very similar story for (some) GPUs.
> > > > 
> > > > So during iteration phase VFIO cannot yet leverage the multifd channels
> > > > when with this series, am I right?
> > > 
> > > That's right.
> > > 
> > > > Is it possible to extend that use case too?
> > > 
> > > I guess so, but since this phase (iteration while the VM is still
> > > running) doesn't impact downtime it is much less critical.
> > 
> > But it affects the bandwidth, e.g. even with multifd enabled, the device
> > iteration data will still bottleneck at ~15Gbps on a common system setup
> > the best case, even if the hosts are 100Gbps direct connected.  Would that
> > be a concern in the future too, or it's known problem and it won't be fixed
> > anyway?
> 
> I think any improvements to the migration performance are good, even if
> they don't impact downtime.
> 
> It's just that this patch set focuses on the downtime phase as the more
> critical thing.
> 
> After this gets improved there's no reason why not to look at improving
> performance of the VM live phase too if it brings sensible improvements.
> 
> > I remember Avihai used to have plan to look into similar issues, I hope
> > this is exactly what he is looking for.  Otherwise changing migration
> > protocol from time to time is cumbersome; we always need to provide a flag
> > to make sure old systems migrates in the old ways, new systems run the new
> > ways, and for such a relatively major change I'd want to double check on
> > how far away we can support offload VFIO iterations data to multifd.
> 
> The device state transfer is indicated by a new flag in the multifd
> header (MULTIFD_FLAG_DEVICE_STATE).
> 
> If we are to use multifd channels for VM live phase transfers these
> could simply re-use the same flag type.

Right, and that's also my major purpose of such request to consider both
issues.

If supporting iterators can be easy on top of this, I am thinking whether
we should do this in one shot.  The problem is even if the flag type can be
reused, old/new qemu binaries may not be compatible and may not migrate
well when:

  - The old qemu only supports the downtime optimizations
  - The new qemu supports both downtime + iteration optimizations

IIUC, at least the device threads are currently created only at the end of
migration when switching over for the downtime-only optimization (aka, this
series).  Then it means it won't be compatible with a new QEMU as the
threads there will need to be created before iteration starts to take
iteration data.  So I believe we'll need yet another flag to tune the
behavior of such, one for each optimizations (downtime v.s. data during
iterations).  If they work mostly similarly, I want to avoid two flags.
It'll be chaos for user to see such similar flags and they'll be pretty
confusing.

If possible, I wish we can spend some time looking into that if they're so
close, and if it's low hanging fruit when on top of this series, maybe we
can consider doing that in one shot.

Thanks,

-- 
Peter Xu


