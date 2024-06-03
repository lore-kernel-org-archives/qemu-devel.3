Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB76C25B78
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 21:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEFXq-0004Lc-F1; Mon, 03 Jun 2024 17:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEFXo-0004LK-Gy
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 17:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEFXl-0003rh-Q8
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 17:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717451320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16AaxwBcMhp1OdxPvVWu5SgrYUkkn1eg4g4mtgI7QnU=;
 b=CA91SV+2Z0t6Pkzu/hI5gQcfuY6Q3GbdzhWbAX8ms6dMRyNQJ5VL8HeFWM1VVg3DvgS48G
 qxfLm6MxoNrURiIuF3R2pldMFXImxvdzCbEV7EnBBaWzIcrsS0KFcPrgO9wpxQNtOsvQyv
 /DxjHdIf6dfHB0HNC0PwRtn024YIbHk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-UzlFQxxaPhGR_BD5ApQOFw-1; Mon, 03 Jun 2024 17:48:39 -0400
X-MC-Unique: UzlFQxxaPhGR_BD5ApQOFw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e2c5354f9so4123631cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717451317; x=1718056117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16AaxwBcMhp1OdxPvVWu5SgrYUkkn1eg4g4mtgI7QnU=;
 b=LIOnp6xh4JbefmFbz8IATS407Ir0zj9rjFOGZtuD9wS64JiZo+FaVY7YpBcmYfEqBT
 4ggwhuSFmusvRlwEAL/qmcU6YSHX52oiJ/iaELqgx2lgvH2LnW7QjCoR192+z5XRqPbi
 FnaJkOasuG2JIHFRJhqOfvuIFpUoM0r95L4qdbNHF8NSEkeAmhiCiLINfE2m0ha8TJOd
 AFOPBH/GPQLY5SVg1w2/YxkTDqWAO3JVcVlW5ve+eggnw/iq7O3JW3EC4YlIiG4kZGp6
 VXnAHaWqig3F9Ie1yFqVmSmAwI00xd2MCj8eJTfrULW3zjWpQK8/Voy0DguqvL78aPK1
 iX5Q==
X-Gm-Message-State: AOJu0YwMknwzzHG3M52cBaVdf97D8+g7GaS/YJ8fNeGg734A764zAMEC
 yjhSn1G650jF2a/Pl29xLEDKqQ7h1SYPTbX7nzdC6eCczmVJc3Jx5aD/aibF2c1PneKtsygR7J3
 +7sD/R6aPlqbiDh14F6tY3NBMbGRJhMgdJ8wPsXTCuTEG6zt2/wZQ
X-Received: by 2002:a05:620a:2403:b0:794:eccb:69c5 with SMTP id
 af79cd13be357-794f5ccc8b4mr1184118185a.3.1717451316817; 
 Mon, 03 Jun 2024 14:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMzNZBmseaW3SphdF2GbO310dtgLuvRcb4TiH9tZVMhCfVlMcNfh5wFGWyr+UlE6Qk76Zdkg==
X-Received: by 2002:a05:620a:2403:b0:794:eccb:69c5 with SMTP id
 af79cd13be357-794f5ccc8b4mr1184114285a.3.1717451315776; 
 Mon, 03 Jun 2024 14:48:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f30614afsm315862885a.97.2024.06.03.14.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 14:48:35 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:48:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
Message-ID: <Zl46MIO30mGrtsQk@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n>
 <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n>
 <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
 <ZljCHgwJhGcFiP1J@x1n>
 <e6d5f123-37ad-4d77-8536-f7f85213073d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6d5f123-37ad-4d77-8536-f7f85213073d@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, May 31, 2024 at 03:32:05PM -0400, Steven Sistare wrote:
> On 5/30/2024 2:14 PM, Peter Xu wrote:
> > On Thu, May 30, 2024 at 01:11:09PM -0400, Steven Sistare wrote:
> > > On 5/29/2024 3:14 PM, Peter Xu wrote:
> > > > On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
> > > > > > > diff --git a/system/memory.c b/system/memory.c
> > > > > > > index 49f1cb2..ca04a0e 100644
> > > > > > > --- a/system/memory.c
> > > > > > > +++ b/system/memory.c
> > > > > > > @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
> > > > > > >                                           uint64_t size,
> > > > > > >                                           Error **errp)
> > > > > > >     {
> > > > > > > +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> > > > > > 
> > > > > > If there's a machine option to "use memfd for allocations", then it's
> > > > > > shared mem... Hmm..
> > > > > > 
> > > > > > It is a bit confusing to me in quite a few levels:
> > > > > > 
> > > > > >      - Why memory allocation method will be defined by a machine property,
> > > > > >        even if we have memory-backend-* which should cover everything?
> > > > > 
> > > > > Some memory regions are implicitly created, and have no explicit representation
> > > > > on the qemu command line.  memfd-alloc affects those.
> > > > > 
> > > > > More generally, memfd-alloc affects all ramblock allocations that are
> > > > > not explicitly represented by memory-backend object.  Thus the simple
> > > > > command line "qemu -m 1G" does not explicitly describe an object, so it
> > > > > goes through the anonymous allocation path, and is affected by memfd-alloc.
> > > > 
> > > > Can we simply now allow "qemu -m 1G" to work for cpr-exec?
> > > 
> > > I assume you meant "simply not allow".
> > > 
> > > Yes, I could do that, but I would need to explicitly add code to exclude this
> > > case, and add a blocker.  Right now it "just works" for all paths that lead to
> > > ram_block_alloc_host, without any special logic at the memory-backend level.
> > > And, I'm not convinced that simplifies the docs, as now I would need to tell
> > > the user that "-m 1G" and similar constructions do not work with cpr.
> > > 
> > > I can try to clarify the doc for -memfd-alloc as currently defined.
> > 
> > Why do we need to keep cpr working for existing qemu cmdlines?  We'll
> > already need to add more new cmdline options already anyway, right?
> > 
> > cpr-reboot wasn't doing it, and that made sense to me, so that new features
> > will require the user to opt-in for it, starting with changing its
> > cmdlines.
> 
> I agree.  We need a new option to opt-in to cpr-friendly memory allocation, and I
> am proposing -machine memfd-alloc. I am simply saying that I can try to do a better
> job explaining the functionality in my proposed text for memfd-alloc, instead of
> changing the functionality to exclude "-m 1G".  I believe excluding "-m 1G" is the
> wrong approach, for the reasons I stated - messier implementation *and* documentation.
> 
> I am open to different syntax for opting in.

If the machine property is the only way to go then I agree that might be a
good idea, even though the name can be further discussed.  But I still want
to figure out something below.

> 
> > > > AFAIU that's
> > > > what we do with cpr-reboot: we ask the user to specify the right things to
> > > > make other thing work.  Otherwise it won't.
> > > > 
> > > > > 
> > > > > Internally, create_default_memdev does create a memory-backend object.
> > > > > That is what my doc comment above refers to:
> > > > >     Any associated memory-backend objects are created with share=on
> > > > > 
> > > > > An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
> > > > > 
> > > > > The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
> > > > > 
> > > > > +#     Memory backend objects must have the share=on attribute, and
> > > > > +#     must be mmap'able in the new QEMU process.  For example,
> > > > > +#     memory-backend-file is acceptable, but memory-backend-ram is
> > > > > +#     not.
> > > > > +#
> > > > > +#     The VM must be started with the '-machine memfd-alloc=on'
> > > > > +#     option.  This causes implicit ram blocks -- those not explicitly
> > > > > +#     described by a memory-backend object -- to be allocated by
> > > > > +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> > > > > +#     RAM when it is specified without a memory-backend object.
> > > > 
> > > > VGA is IIRC 16MB chunk, ROM is even smaller.  If the user specifies -object
> > > > memory-backend-file,share=on propertly, these should be the only outliers?
> > > > 
> > > > Are these important enough for the downtime?  Can we put them into the
> > > > migrated image alongside with the rest device states?
> > > 
> > > It's not about downtime.  vfio, vdpa, and iommufd pin all guest pages.
> > > The pages must remain pinned during CPR to support ongoing DMA activity
> > > which could target those pages (which we do not quiesce), and the same
> > > physical pages must be used for the ramblocks in the new qemu process.
> > 
> > Ah ok, yes DMA can happen on the fly.
> > 
> > Guest mem is definitely the major DMA target and that can be covered by
> > -object memory-backend-*,shared=on cmdlines.
> > 
> > ROM is definitely not a DMA target.  So is VGA ram a target for, perhaps,
> > an assigned vGPU device?  Do we have a list of things that will need that?
> > Can we make them work somehow by sharing them like guest mem?
> 
> The pass-through devices map and pin all memory accessible to the guest.
> We cannot make exceptions based on our intuition of how the memory will
> and will not be used.

True, but if you see my whole point is trying to see whether we can get rid
of the machine property completely, and it's also because we're just so
close to getting rid of it.. which I feel.

QEMU memory layout can be complicated across all the platforms, but I doubt
whether that's true for CPR's purpose and archs that it plans to support.
A generic VM's memory topology shouldn't be that complicated at all,
e.g. on x86:

              Block Name    PSize              Offset               Used              Total                HVA  RO
                  pc.ram    4 KiB  0x0000000000000000 0x0000000008000000 0x0000000008000000 0x00007f684fe00000  rw
   0000:00:02.0/vga.vram    4 KiB  0x0000000008080000 0x0000000001000000 0x0000000001000000 0x00007f684e800000  rw
    /rom@etc/acpi/tables    4 KiB  0x0000000009100000 0x0000000000020000 0x0000000000200000 0x00007f684dc00000  ro
                 pc.bios    4 KiB  0x0000000008000000 0x0000000000040000 0x0000000000040000 0x00007f68dc200000  ro
  0000:00:03.0/e1000.rom    4 KiB  0x00000000090c0000 0x0000000000040000 0x0000000000040000 0x00007f684e000000  ro
                  pc.rom    4 KiB  0x0000000008040000 0x0000000000020000 0x0000000000020000 0x00007f684fa00000  ro
    0000:00:02.0/vga.rom    4 KiB  0x0000000009080000 0x0000000000010000 0x0000000000010000 0x00007f684e400000  ro
   /rom@etc/table-loader    4 KiB  0x0000000009300000 0x0000000000001000 0x0000000000010000 0x00007f684d800000  ro
      /rom@etc/acpi/rsdp    4 KiB  0x0000000009340000 0x0000000000001000 0x0000000000001000 0x00007f684d400000  ro

It's simply the major ram, ROMs, and VGA.

I hoped it can work without it, I'll mention one more reason below.

So if we're going to have this machine property, can I still request a
possible list of things that can be the target of this property besides
guest mem?  I just want to know where it can be used "for real".  I know it
might be complicated, but maybe not.  I really can only think of VGA, and I
doubt whether that should be DMAed at all.

> 
> Also, we cannot simply abandon the old pinned ramblocks, owned by an mm_struct
> that will become a zombie.  We would actually need to write additional code
> to call device ioctls to unmap the oddball ramblocks.  It is far cleaner
> and more correct to preserve them all.
> 
> > It'll be a complete tragedy if we introduced this whole thing only because
> > of some minority.  I want to understand whether there's any generic way to
> > solve this problem rather than this magical machine property.  IMHO it's
> > very not trivial to maintain.
> 
> The machine property is the generic way.
> 
> A single opt-in option to call memfd_create() is an elegant and effective solution.
> The code is small and not hard to maintain.  This is the option patch.  Most of it
> is the boiler plate that any option has, and the single code location that formerly
> called qemu_anon_ram_alloc now optionally calls qemu_memfd_create:
> 
>   machine: memfd-alloc option             25 insertions(+), 28 deletions(-)
> 
> These patches are simply stylistic and modularity improvements for ramblock,
> valuable in their own right, which allows the previous patch to be small and clean.
> 
>   physmem: ram_block_create               29 insertions(+), 21 deletions(-)
>   physmem: hoist guest_memfd creation     48 insertions(+), 37 deletions(-)
>   physmem: hoist host memory allocation   36 insertions(+), 44 deletions(-)
>   physmem: set ram block idstr earlier    25 insertions(+), 28 deletions(-)

Let me explain the other reason why I don't want to have that machine
property..

That property, irrelevant of what it is called (and I doubt whether Dan's
suggestion on "shared-ram" is good, e.g. mmap(MAP_SHARED) doesn't have user
visible fd but it's shared-ram for sure..), is yet another way to specify
guest mem types.

What if the user specified this property but specified something else in
the -object parameters?  E.g. -machine share-ram=on -object
memory-backend-ram,share=off.  What should we do?

Fundamentally that's also why I "hope" we can avoid adding yet one more
place configure guest mem, and stick with -objects.

> 
> > > > > >      - Even if we have such a machine property, why setting "memfd" will
> > > > > >        always imply shared?  why not private?  After all it's not called
> > > > > >        "memfd-shared-alloc", and we can create private mappings using
> > > > > >        e.g. memory-backend-memfd,share=off.
> > > > > 
> > > > > There is no use case for memfd-alloc with share=off, so no point IMO in
> > > > > making the option more verbose.
> > > > 
> > > > Unfortunately this fact doesn't make the property easier to understand. :-( >
> > > > > For cpr, the mapping with all its modifications must be visible to new
> > > > > qemu when qemu mmaps it.
> > > > 
> > > > So this might be the important part - do you mean migrating
> > > > VGA/ROM/... small ramblocks won't work (besides any performance concerns)?
> > > > Could you elaborate?
> > > 
> > > Pinning.
> > > 
> > > > Cpr-reboot already introduced lots of tricky knobs to QEMU.  We may need to
> > > > restrict that specialty to minimal, making the interfacing as clear as
> > > > possible, or (at least migration) maintainers will start to be soon scared
> > > > and running away, if such proposal was not shot down.
> > > > 
> > > > In short, I hope when we introduce new knobs for cpr, we shouldn't always
> > > > keep cpr-* modes in mind, but consider whenever the user can use it without
> > > > cpr-*.  I'm not sure whether it'll be always possible, but we should try.
> > > 
> > > I agree in principle.  FWIW, I have tried to generalize the functionality needed
> > > by cpr so it can be used in other ways: per-mode blockers, per-mode notifiers,
> > > precreate vmstate, factory objects; to base it on migration internals with
> > > minimal change (vmstate); and to make minimal changes in the migration control
> > > paths.
> > 
> > Thanks.
> > 
> > For this one I think reusing -object interface (hopefully without
> > introducing a knob) would be a great step if that can fully describe what
> > cpr-exec is looking for.  E.g., when cpr-exec mode enabled it can sanity
> > check the memory backends making sure all things satisfy its need, and fail
> > migration otherwise upfront.
> 
> For '-object memory-backend-*', I can tell whether cpr is allowed or not
> without additional knobs.  See the blocker patches for examples where cpr
> is blocked.
> 
> The problem is the implicit ramblocks that currently call qemu_ram_alloc_internal.

I hope it won't ever happen that we introduced this property because "we
don't know", then when we know we found no real RAM regions are using it if
properly specify -object.  So I hope at least we know what we're doing, and
for explicitly what reason..

Let me know if you think I'm asking too much (which is possible.. :).  But I
hope in case that might be interesting to you too to know the real answer.

Thanks,

-- 
Peter Xu


