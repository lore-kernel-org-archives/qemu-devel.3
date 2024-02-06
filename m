Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5D0C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIec-00028g-JC; Tue, 06 Feb 2024 05:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXIeb-00028W-OB
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXIeW-0006P5-BV
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707215167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2S1HFa9lKXEvQrZh7w6xdy0Z9CgWDw9nZHJYZmO2Uk=;
 b=bZvIFk2IA95B+TFO49BFcsfJyxHIC6TDNb3A1knhAGdMEcqtwAGq0ddzhKD5MrdrV86Ugr
 rrwYbCZ2JoAVVYDpcBblM87oCyFOpdCZ3eeFej9ACZskTkAGXqVfHubVXlB67JAVD0SXUM
 7aBeXh+J9GY73sT4vsYB/QZkch1TMIg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-bGTHMkdZPlags1Oo7e2dWw-1; Tue, 06 Feb 2024 05:26:06 -0500
X-MC-Unique: bGTHMkdZPlags1Oo7e2dWw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso1741758b3a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 02:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707215164; x=1707819964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2S1HFa9lKXEvQrZh7w6xdy0Z9CgWDw9nZHJYZmO2Uk=;
 b=p7AMpml6P9DweSMir4DZ3vWp5LLAVpo/K/+KdlXFZLJrNiZkQDSjnK9g3Vmy2qVGsX
 m5WwfA6hTNzjI7QVMEDNSu1xPFpq4AV9vntAOxhjeMAjOJnk5vFSG1lnvtkpTW81DE2Q
 ysOs5VkI5n0ifn+7mU7zxBypKbQpjaj3doWqg6bPsPpHGHNCI8Pq7tg1idu6T0NXmAcY
 2/Pd07uHFExiKU6gd+f5fxDryE0HHzYDPQiSlRgSFRLUVBGE89z4v7VxeKKtjUu0w0mE
 MFRn3sv92IzdaO/ZDSWtF8ruzcieXz3MSBxoqCG9WHoYHsakZmSgeAIhO4vNDup03EpV
 U0Gg==
X-Gm-Message-State: AOJu0Yy4qO/FMYQaLAwWc59+wu4HPcVE0z72lC3geduN1wdakos1Cz6o
 uJVHLGnKnvPA6AQw96T5ZG8HvPgske0C9AyPWUe6Wl0qUFlVcwr+j5rn2H6p0jvs7MQ7plRVd49
 jBDAFy7GbShnX9Akg3oksu2VTV55H7PAEdblm+G8rpQZSJRQMKFD6blTEiHZnLQk=
X-Received: by 2002:a05:6a00:1d11:b0:6e0:3a9b:12dd with SMTP id
 a17-20020a056a001d1100b006e03a9b12ddmr2414168pfx.0.1707215164654; 
 Tue, 06 Feb 2024 02:26:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW11n5FAtu3BjaHc3YJImJkYjJ+Ch1fF7zZliCuTAbusoZZE0QQYISh1kXQZvJulJv768Wyg==
X-Received: by 2002:a05:6a00:1d11:b0:6e0:3a9b:12dd with SMTP id
 a17-20020a056a001d1100b006e03a9b12ddmr2414154pfx.0.1707215164126; 
 Tue, 06 Feb 2024 02:26:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWq5yNKjbzDFh4NL2oHXsyiuYK1Az7+ICEvrquPQQJ6npS8m24O5TxPjN6qJ7fePBST02msNl11/WzP2XHQQpyTmn1JSS8=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t37-20020a634625000000b005d8aef12380sm1653878pga.73.2024.02.06.02.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 02:26:03 -0800 (PST)
Date: Tue, 6 Feb 2024 18:25:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
Message-ID: <ZcIJNfoHs6iC1ZwN@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
 <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com>
 <Zbcm1nXzQ_r0eGG0@x1n>
 <0f75090d-bbe1-43cb-b649-a0880bc413c4@nvidia.com>
 <ZbiP1Ayqxj9BLdY7@x1n>
 <113f4fe5-30d4-4aff-9f60-91b2a0c103e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <113f4fe5-30d4-4aff-9f60-91b2a0c103e5@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

On Tue, Jan 30, 2024 at 08:44:19PM +0200, Avihai Horon wrote:
> 
> On 30/01/2024 7:57, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Jan 29, 2024 at 02:20:35PM +0200, Avihai Horon wrote:
> > > On 29/01/2024 6:17, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Sun, Jan 28, 2024 at 05:43:52PM +0200, Avihai Horon wrote:
> > > > > On 25/01/2024 22:57, Fabiano Rosas wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > > 
> > > > > > 
> > > > > > Avihai Horon <avihaih@nvidia.com> writes:
> > > > > > 
> > > > > > > The commit in the fixes line moved multifd thread creation to a
> > > > > > > different location, but forgot to move the p->running = true assignment
> > > > > > > as well. Thus, p->running is set to true before multifd thread is
> > > > > > > actually created.
> > > > > > > 
> > > > > > > p->running is used in multifd_save_cleanup() to decide whether to join
> > > > > > > the multifd thread or not.
> > > > > > > 
> > > > > > > With TLS, an error in multifd_tls_channel_connect() can lead to a
> > > > > > > segmentation fault because p->running is true but p->thread is never
> > > > > > > initialized, so multifd_save_cleanup() tries to join an uninitialized
> > > > > > > thread.
> > > > > > > 
> > > > > > > Fix it by moving p->running = true assignment right after multifd thread
> > > > > > > creation. Also move qio_channel_set_delay() to there, as this is where
> > > > > > > it used to be originally.
> > > > > > > 
> > > > > > > Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
> > > > > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > > > Just for context, I haven't looked at this patch yet, but we were
> > > > > > planning to remove p->running altogether:
> > > > > > 
> > > > > > https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de
> > > > > Thanks for putting me in the picture.
> > > > > I see that there has been a discussion about the multifd creation/treadown
> > > > > flow.
> > > > > In light of this discussion, I can already see a few problems in my series
> > > > > that I didn't notice before (such as the TLS handshake thread leak).
> > > > > The thread you mentioned here and some of my patches point out some problems
> > > > > in multifd creation/treardown. I guess we can discuss it and see what's the
> > > > > best way to solve them.
> > > > > 
> > > > > Regarding this patch, your solution indeed solves the bug that this patch
> > > > > addresses, so maybe this could be dropped (or only noted in your patch).
> > > > > 
> > > > > Maybe I should also put you (and Peter) in context for this whole series --
> > > > > I am writing it as preparation for adding a separate migration channel for
> > > > > VFIO device migration, so VFIO devices could be migrated in parallel.
> > > > > So this series tries to lay down some foundations to facilitate it.
> > > > Avihai, is the throughput the only reason that VFIO would like to have a
> > > > separate channel?
> > > Actually, the main reason is to be able to send and load multiple VFIO
> > > devices data in parallel.
> > > For example, today if we have three VFIO devices, they are migrated
> > > sequentially one after another.
> > > This particularly hurts during the complete pre-copy phase (downtime), as
> > > loading the VFIO data in destination involves FW interaction and resource
> > > allocation, which takes time and simply blocks the other devices from
> > > sending and loading their data.
> > > Providing a separate channel and thread for each VIFO device solves this
> > > problem and ideally reduces the VFIO contribution to downtime from sum{VFIO
> > > device #1, ..., VFIO device #N} to max{VFIO device #1, ..., VFIO device #N}.
> > I see.
> > 
> > > > I'm wondering if we can also use multifd threads to send vfio data at some
> > > > point.  Now multifd indeed is closely bound to ram pages but maybe it'll
> > > > change in the near future to take any load?
> > > > 
> > > > Multifd is for solving the throughput issue already. If vfio has the same
> > > > goal, IMHO it'll be good to keep them using the same thread model, instead
> > > > of managing different threads in different places.  With that, any user
> > > > setting (for example, multifd-n-threads) will naturally apply to all
> > > > components, rather than relying on yet-another vfio-migration-threads-num
> > > > parameter.
> > > Frankly, I didn't really put much attention to the throughput factor, and my
> > > plan is to introduce only a single thread per device.
> > > VFIO devices may have many GBs of data to migrate (e.g., vGPUs) and even
> > > mlx5 VFs can have a few GBs of data.
> > > So what you are saying here is interesting, although I didn't test such
> > > scenario to see the actual benefit.
> > > 
> > > I am trying to think if/how this could work and I have a few concerns:
> > > 1. RAM is made of fixed-positioned pages that can be randomly read/written,
> > > so sending these pages over multiple channels and loading them in the
> > > destination can work pretty naturally without much overhead.
> > >     VFIO device data, on the other hand, is just an opaque stream of bytes
> > > from QEMU point of view. This means that if we break this data to "packets"
> > > and send them over multiple channels, we must preserve the order by which
> > > this data was
> > >     originally read from the device and write the data in the same order to
> > > the destination device.
> > >     I am wondering if the overhead of maintaining such order may hurt
> > > performance, making it not worthwhile.
> > Indeed, it seems to me VFIO migration is based on a streaming model where
> > there's no easy way to index a chunk of data.
> 
> Yes, you can see it here as well: https://elixir.bootlin.com/linux/v6.8-rc2/source/include/uapi/linux/vfio.h#L1039
> 
> > 
> > Is there any background on how that kernel interface was designed?  It
> > seems pretty unfriendly to concurrency already: even if multiple devices
> > can migrate concurrently, each single device can already contain GBs of
> > data as you said, which is pretty common here.  I'm a bit surprised to see
> > that the kernel interface is designed in this way for such a device.
> 
> Not that I know of. There has been a pretty big discussion about the uAPI
> back then when it was introduced, but not something formal.
> However, I don't think having a few GBs of device data is the common case
> for VFIO devices, I just pointed out the extreme cases.

I had that impression possibly because our QE team tests VFIO normally with
vGPU, and my memory is 1Q ~= 1GB device data, where NQ ~= N GB (mostly vRAM
per my understanding).

> 
> > I was wondering the possibility of whether VFIO can provide data chunks
> > with indexes just like RAM (which is represented in ramblock offsets).
> 
> I am not sure this would be feasible, as it will involve major changes to
> the uAPI and for the devices.
> But if that's something you wish to explore I can ask around and see if it's
> a hard no go.

The thing is if VFIO always relies on 1 fd read() then it's impossible to
scale.  Maybe there's chance in the future to provide other interfaces so
that at least data can be concurrently read or updated, even if they can
not directly be offseted.

> 
> > > 2. As I mentioned above, the main motivation for separate VFIO migration
> > > channel/thread, as I see today, is to allow parallel migration of VFIO
> > > devices.
> > >     AFAIU multifd, as it is today, doesn't provide such parallelism (i.e., in
> > > the complete pre-copy phase each device, be it RAM or VFIO, will fully send
> > > its data over the multifd threads and only after finishing will the next
> > > device send its data).
> > Indeed. That's actually an issue not only to VFIO but also to migration in
> > general: we can't migrate device states concurrently, and multifd is out of
> > the picture here so far, but maybe there's chance.
> > 
> > Consider huge VMs where there can be already ~500 vCPUs, each need their
> > own get()/put() of CPU states from/to KVM.  It'll be nice if we can do this
> > in concurrent threads too.  Here VFIO is one of the devices that will also
> > benefit from such a design, and greatly.
> 
> Interesting, do you know how much time migrating these vCPUs take?

Most of the vCPUs took only a portion of milliseconds, but some may took a
long time like 100+ ms.  We still haven't looked into why some vCPU is
special and what caused that slowness when save(), however consider >1
vCPUs taking 100ms they'll be added up lump sum contributing to the total
downtime.  That's definitely unwanted.

If we can somehow concurrently submit device states save() jobs to multiple
threads, then it could be potentially useful.

> 
> > I added a todo in our wiki for this, which I see it a general improvement,
> > and hopefully someone can look into this:
> > 
> > https://wiki.qemu.org/ToDo/LiveMigration#Device_state_concurrency
> > 
> > I hope VFIO can consider resolving this as a generic issue, rather than
> > providing its own solution.
> > 
> > > This is just what came to mind. Maybe we can think this more thoroughly and
> > > see if it could work somehow, now or in the future.
> > > However, I think making the multifd threads generic so they can send any
> > > kind of data is a good thing in general, regardless of VFIO.
> > Right.
> > 
> > In general, having a VFIO separate channel may solve the immediate issue,
> > but it may still won't solve all, meanwhile it may introduce the first
> > example of using completely separate channel that migration won't easily
> > manage itself, which IMHO can cause migration much harder to maintain in
> > the future.
> > 
> > It may also in the future become some technical debt that VFIO will need to
> > take even if such a solution merged, because VFIO could have its own model
> > of handling a few similar problems that migration has.
> > 
> > I hope there's some way out that we can work together to improve the
> > framework, providing a clean approach and consider for the long terms.
> 
> I understand your concern, and I hope as well we can work together towards a
> proper and maintainable solution.
> Even if we don't get VFIO to use the multifd framework directly, maybe
> adding common APIs would be good enough.

Yes.  Note that I haven't looked closely in your patchsets right now, as I
mentioned it may not apply due to the recent fixes.  However please feel
free to repost whatever that you think would still be worthwhile.

> For example, take this series of adding a common API to create migration
> channels.
> I also saw you and Fabiano have been talking about a thread-pool model to
> replace the multifd threads. Maybe we can use such scheme also for VFIO and
> even for the vCPUs case you mentioned above, each component stating how many
> threads it needs and creating a big pool for all migration clients.

We can keep discussing that.  So far I still think it'll be more valuable
if you can propose something that will apply not only to VFIO but also
other devices on concurrent save/loads, but I don't think I have everything
thought thoroughly.  So feel free to go with what you think proper, and we
can keep the discussion in your new thread if you're going to prepare
something.

Thanks,

-- 
Peter Xu


