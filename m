Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30E2C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 17:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s42a2-0007hm-2D; Mon, 06 May 2024 13:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s42Zl-0007eM-NK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s42Zj-0007nf-CM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715018190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fedYap05wAOgminPR8mdhKJYI+JwjCgJErPhAlq8vbQ=;
 b=RhRtWIKhAb5mOZLqRjS3Qh0SfSvKYO9Iyd2+IMR/yfwibA9RHJLvPQuZRwZMZnBGz8/Yv0
 hOwqTrfFcjdioJ0yykx5pZQPebr+Lz/MOuWFTDDYuFiVPsW7ev9hjDoQZb2vdDaMVycQRB
 ZTpjxWbva4ln+Hs9NlVPi6opJNtZw0s=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-g8kd1asQM2Cmty0q1GaG_A-1; Mon, 06 May 2024 13:56:28 -0400
X-MC-Unique: g8kd1asQM2Cmty0q1GaG_A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c864bcd2b0so159238b6e.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 10:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715018188; x=1715622988;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fedYap05wAOgminPR8mdhKJYI+JwjCgJErPhAlq8vbQ=;
 b=AN4zAcNm7MINdqRLzvCxkw7i2j9s6DzZlEuqaAVyvuuVSnpycjrRvDKumIT8GqY/dC
 g9BB/zg52nxB7EVMXSyIfO7E3cyu1HkiUS2OpkhiciUERLYox8BY68hVGEnxe6B4/DCG
 dwF6GSqaKUaQPrkFp1Ctap7loOr1QQLTXWG6LMIGXzpvbKAYKkPHTODNYvKRtUBxgOWb
 e2B9LA+JZSSS3aNt/Z7ndLVTGC/hlIUe8eK8n3E3ZGR67kPTdITexzmolOkHzIOj7khh
 pBWrCYpRzwE6LtDHNflMRauzvGW25V064e1MVJG4Ff0KP0TG6fnjW6xcVaeveqeNxK9I
 Ms3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/YQqqdQYU//0AXNUqsFmcImFTuyRcfz5qDnwH+uHPy/NU/Ejp4PcSUhAcVGe1Ng7KDQuzvcrE8ScyN2ac+PBGo9CKbp8=
X-Gm-Message-State: AOJu0YyiWLEpJV4PgPUIAuiNQQarYaF0b6IQDJ88pXyt3GuFri4/FbIm
 mU05tZ9j/FpFAmHVMPMmSmf7u0PpkEmGliCPAteY0voTuILRAcwAA8dvqDzRwUVfp7v20VtGdSO
 9IuRza5owJxG8VUf5USre3gEcrqIrZD6tf/3CNuFj/EaJiJCc2KJq
X-Received: by 2002:a05:6808:1513:b0:3c8:3076:f54f with SMTP id
 u19-20020a056808151300b003c83076f54fmr14274842oiw.1.1715018187780; 
 Mon, 06 May 2024 10:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXzW+yQsD+sGNBvbPDwanVGb+hUyhJSQJx4pXw+2x4uHw1lcLsPOx4nV5wNv6tIbhHxzBvGQ==
X-Received: by 2002:a05:6808:1513:b0:3c8:3076:f54f with SMTP id
 u19-20020a056808151300b003c83076f54fmr14274804oiw.1.1715018186966; 
 Mon, 06 May 2024 10:56:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 l10-20020ad4444a000000b006a0f0a7f7c2sm3920486qvt.89.2024.05.06.10.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 10:56:26 -0700 (PDT)
Date: Mon, 6 May 2024 13:56:24 -0400
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
Message-ID: <ZjkZyP9Ty0TpTCTx@x1n>
References: <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com>
 <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
 <Zig3vebacR4SfJLh@x1n>
 <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
 <Zi-4FmjXv-gx7JH_@x1n>
 <fc0721e3-4932-40b8-a6eb-2584a475d8eb@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc0721e3-4932-40b8-a6eb-2584a475d8eb@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Mon, May 06, 2024 at 06:26:46PM +0200, Maciej S. Szmigiero wrote:
> On 29.04.2024 17:09, Peter Xu wrote:
> > On Fri, Apr 26, 2024 at 07:34:09PM +0200, Maciej S. Szmigiero wrote:
> > > On 24.04.2024 00:35, Peter Xu wrote:
> > > > On Wed, Apr 24, 2024 at 12:25:08AM +0200, Maciej S. Szmigiero wrote:
> > > > > On 24.04.2024 00:20, Peter Xu wrote:
> > > > > > On Tue, Apr 23, 2024 at 06:15:35PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > On 19.04.2024 17:31, Peter Xu wrote:
> > > > > > > > On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
> > > > > > > > > On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
> > > > > > > > > > On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > > > I think one of the reasons for these results is that mixed (RAM + device
> > > > > > > > > > > state) multifd channels participate in the RAM sync process
> > > > > > > > > > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > > > > > > > > > 
> > > > > > > > > > Firstly, I'm wondering whether we can have better names for these new
> > > > > > > > > > hooks.  Currently (only comment on the async* stuff):
> > > > > > > > > > 
> > > > > > > > > >       - complete_precopy_async
> > > > > > > > > >       - complete_precopy
> > > > > > > > > >       - complete_precopy_async_wait
> > > > > > > > > > 
> > > > > > > > > > But perhaps better:
> > > > > > > > > > 
> > > > > > > > > >       - complete_precopy_begin
> > > > > > > > > >       - complete_precopy
> > > > > > > > > >       - complete_precopy_end
> > > > > > > > > > 
> > > > > > > > > > ?
> > > > > > > > > > 
> > > > > > > > > > As I don't see why the device must do something with async in such hook.
> > > > > > > > > > To me it's more like you're splitting one process into multiple, then
> > > > > > > > > > begin/end sounds more generic.
> > > > > > > > > > 
> > > > > > > > > > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > > > > > > > > > into >1 phases too. For example, I would be curious whether the performance
> > > > > > > > > > will go back to normal if we offloading multifd_send_sync_main() into the
> > > > > > > > > > complete_precopy_end(), because we really only need one shot of that, and I
> > > > > > > > > > am quite surprised it already greatly affects VFIO dumping its own things.
> > > > > > > > > > 
> > > > > > > > > > I would even ask one step further as what Dan was asking: have you thought
> > > > > > > > > > about dumping VFIO states via multifd even during iterations?  Would that
> > > > > > > > > > help even more than this series (which IIUC only helps during the blackout
> > > > > > > > > > phase)?
> > > > > > > > > 
> > > > > > > > > To dump during RAM iteration, the VFIO device will need to have
> > > > > > > > > dirty tracking and iterate on its state, because the guest CPUs
> > > > > > > > > will still be running potentially changing VFIO state. That seems
> > > > > > > > > impractical in the general case.
> > > > > > > > 
> > > > > > > > We already do such interations in vfio_save_iterate()?
> > > > > > > > 
> > > > > > > > My understanding is the recent VFIO work is based on the fact that the VFIO
> > > > > > > > device can track device state changes more or less (besides being able to
> > > > > > > > save/load full states).  E.g. I still remember in our QE tests some old
> > > > > > > > devices report much more dirty pages than expected during the iterations
> > > > > > > > when we were looking into such issue that a huge amount of dirty pages
> > > > > > > > reported.  But newer models seem to have fixed that and report much less.
> > > > > > > > 
> > > > > > > > That issue was about GPU not NICs, though, and IIUC a major portion of such
> > > > > > > > tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
> > > > > > > > maybe they work differently.
> > > > > > > 
> > > > > > > The device which this series was developed against (Mellanox ConnectX-7)
> > > > > > > is already transferring its live state before the VM gets stopped (via
> > > > > > > save_live_iterate SaveVMHandler).
> > > > > > > 
> > > > > > > It's just that in addition to the live state it has more than 400 MiB
> > > > > > > of state that cannot be transferred while the VM is still running.
> > > > > > > And that fact hurts a lot with respect to the migration downtime.
> > > > > > > 
> > > > > > > AFAIK it's a very similar story for (some) GPUs.
> > > > > > 
> > > > > > So during iteration phase VFIO cannot yet leverage the multifd channels
> > > > > > when with this series, am I right?
> > > > > 
> > > > > That's right.
> > > > > 
> > > > > > Is it possible to extend that use case too?
> > > > > 
> > > > > I guess so, but since this phase (iteration while the VM is still
> > > > > running) doesn't impact downtime it is much less critical.
> > > > 
> > > > But it affects the bandwidth, e.g. even with multifd enabled, the device
> > > > iteration data will still bottleneck at ~15Gbps on a common system setup
> > > > the best case, even if the hosts are 100Gbps direct connected.  Would that
> > > > be a concern in the future too, or it's known problem and it won't be fixed
> > > > anyway?
> > > 
> > > I think any improvements to the migration performance are good, even if
> > > they don't impact downtime.
> > > 
> > > It's just that this patch set focuses on the downtime phase as the more
> > > critical thing.
> > > 
> > > After this gets improved there's no reason why not to look at improving
> > > performance of the VM live phase too if it brings sensible improvements.
> > > 
> > > > I remember Avihai used to have plan to look into similar issues, I hope
> > > > this is exactly what he is looking for.  Otherwise changing migration
> > > > protocol from time to time is cumbersome; we always need to provide a flag
> > > > to make sure old systems migrates in the old ways, new systems run the new
> > > > ways, and for such a relatively major change I'd want to double check on
> > > > how far away we can support offload VFIO iterations data to multifd.
> > > 
> > > The device state transfer is indicated by a new flag in the multifd
> > > header (MULTIFD_FLAG_DEVICE_STATE).
> > > 
> > > If we are to use multifd channels for VM live phase transfers these
> > > could simply re-use the same flag type.
> > 
> > Right, and that's also my major purpose of such request to consider both
> > issues.
> > 
> > If supporting iterators can be easy on top of this, I am thinking whether
> > we should do this in one shot.  The problem is even if the flag type can be
> > reused, old/new qemu binaries may not be compatible and may not migrate
> > well when:
> > 
> >    - The old qemu only supports the downtime optimizations
> >    - The new qemu supports both downtime + iteration optimizations
> 
> I think the situation here will be the same as with any new flag
> affecting the migration wire protocol - if the old version of QEMU
> doesn't support that flag then it has to be kept at its backward-compatible
> setting for migration to succeed.
> 
> > IIUC, at least the device threads are currently created only at the end of
> > migration when switching over for the downtime-only optimization (aka, this
> > series).  Then it means it won't be compatible with a new QEMU as the
> > threads there will need to be created before iteration starts to take
> > iteration data.  So I believe we'll need yet another flag to tune the
> > behavior of such, one for each optimizations (downtime v.s. data during
> > iterations).  If they work mostly similarly, I want to avoid two flags.
> > It'll be chaos for user to see such similar flags and they'll be pretty
> > confusing.
> 
> The VFIO loading threads are created from vfio_load_setup(), which is
> called at the very beginning of the migration, so they should be already
> there.
> 
> However, they aren't currently prepared to receive VM live phase data.
> 
> > If possible, I wish we can spend some time looking into that if they're so
> > close, and if it's low hanging fruit when on top of this series, maybe we
> > can consider doing that in one shot.
> 
> I'm still trying to figure out the complete explanation why dedicated
> device state channels improve downtime as there was a bunch of holidays
> last week here.

No rush.  I am not sure whether it'll reduce downtime, but it may improve
total migration time when multiple devices are used.

> 
> I will have a look later what would it take to add VM live phase multifd
> device state transfer support and also how invasive it would be as I
> think it's better to keep the number of code conflicts in a patch set
> to a manageable size as it reduces the chance of accidentally
> introducing regressions when forward-porting the patch set to the git master.

Yes it makes sense.  It'll be good to look one step further in this case,
then:

  - If it's easy to add support then we do in one batch, or

  - If it's not easy to add support, but if we can find a compatible way so
    that ABI can be transparent when adding that later, it'll be also nice, or
    
  - If we have solid clue it should be a major separate work, and we must
    need a new flag, then we at least know we should simply split the
    effort due to that complexity

The hope is option (1)/(2) would work out.

I hope Avihai can also chim in here (or please reach him out) because I
remember he used to consider proposing such a whole solution, but maybe I
just misunderstood.  I suppose no harm to check with him.

Thanks,

-- 
Peter Xu


