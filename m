Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2E4C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5Vt-0007Od-1S; Wed, 15 Jan 2025 10:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY5Vr-0007Iy-4G
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY5Vn-0001OU-0h
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736955654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zh4+8xlsdl3tqOU5t3CHQE59Xbr9modTQsuhaq3i2LQ=;
 b=CaINa6vxT2p3udzJsNjg9R5gN8H/S9KOcT4r46DYhNPQK9403PdzgoB8v1oD+DcqKjGhYC
 pwbbI2mGCWbWSJV8GuyzZPpohT4wIUUj6Sy4JMnPS6U1GkKgCykyrsDLghZznHXExbka/3
 6Odb0/gKpnM/A8yLybo9AdZA2fG6G4c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-j40JROQ1MhOX-HJXM0e_FA-1; Wed, 15 Jan 2025 10:40:52 -0500
X-MC-Unique: j40JROQ1MhOX-HJXM0e_FA-1
X-Mimecast-MFC-AGG-ID: j40JROQ1MhOX-HJXM0e_FA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f6903d2eso116444146d6.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955651; x=1737560451;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zh4+8xlsdl3tqOU5t3CHQE59Xbr9modTQsuhaq3i2LQ=;
 b=SZ8ET0lbaVFG89tFhWcXrGfvCQ+lIkTFjHBuAX5mjPDc3A+oZbdvqVYIFbqKNIWmj5
 e4FzwUimUuwdjamlMbWhloTpp2k+fzPUlCKwHrqlvOWXvi3CBd2HTOgzZ/05S6jzPEzQ
 QFCz+ZczP7gO7BvwJrV1G6ri54f02BNPdpj3eWxz26Jb8B2jkoMevEnWytrV1Z08CU+O
 vDU4/Jaj2xV7O65+G1hyWoySbNqbGgqtA55sMc6rUVCSt/1e704IQN++xSIsdIxERM0Z
 SmOF0XQAcK2jSmD+hMSHu3Sr2BhkKwj1Waruc3i8dnBv1ZXfC38WZyYqcM7FeXqwEFaI
 nszQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPEAcxC9FFOtG+jC/UzB/sUEUntE05ZpqzF/DxD6TnRM7aphBDUIZ03gTc6BP9VhN1RBpxq/9n2BCH@nongnu.org
X-Gm-Message-State: AOJu0YxIll9mkNloOksW4bpnQ7Ep9frX9DNVZ1jN+x6HRR8RmJciUPMY
 o/BE2MYYj5kaPyIp1dOVEk4k3wTiBVc1jNESKl575viGGgd5MxsbASmfZLC6ChiNVpJKKOsoP+C
 d2ELkWaEOFh56odyldLINVRsICnmoZ3QTa1R4e+rit5oHUFSi6Tg+
X-Gm-Gg: ASbGncsfxWJGSJSzzcWRoVnBnmm/oo4aENW2gCtZ7DtolnnTiUcJK4LQ8tCKgBT1cPX
 RlbPJR+2w/uOzPKxaleYNh+KFm6gndPkibiSYiagGiO8ySKrkkqAdTa4bqrdvP5h2X+ZJX5c2oh
 5fTuZ7IhfA0CE9bZ5pIxczUhBtJRppBLTmfGYsXOZWHtBiDVEyCEeS8B9NPeh7o1kTo3GClw8px
 pJ7VZ1mlhAH4VKvJPgN/ZN9bUhNQpgS+/1n7rGlGk+n+I1tboypIyl56PhH4fWJgh/MZyleNbuk
 Ac2ct3qzC3iXONhsjg==
X-Received: by 2002:a05:6214:449f:b0:6d8:9677:fbe4 with SMTP id
 6a1803df08f44-6df9b1f6f51mr506229346d6.9.1736955651334; 
 Wed, 15 Jan 2025 07:40:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNiPnnYKJRlXyVi+6SOcm0dyLyRzPpIUw3zSQyXtlfxRSGs/eLXE2Pa12oExbgMqPZEOED5A==
X-Received: by 2002:a05:6214:449f:b0:6d8:9677:fbe4 with SMTP id
 6a1803df08f44-6df9b1f6f51mr506228796d6.9.1736955650873; 
 Wed, 15 Jan 2025 07:40:50 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade88135sm65637756d6.94.2025.01.15.07.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:40:50 -0800 (PST)
Date: Wed, 15 Jan 2025 10:40:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4fW_rI7Mfrtc1Fg@x1n>
References: <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com>
 <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 15, 2025 at 11:54:56PM +0900, Akihiko Odaki wrote:
> On 2025/01/15 22:43, Peter Xu wrote:
> > On Wed, Jan 15, 2025 at 01:46:29PM +0900, Akihiko Odaki wrote:
> > > On 2025/01/15 2:02, Peter Xu wrote:
> > > > On Tue, Jan 14, 2025 at 05:43:09PM +0900, Akihiko Odaki wrote:
> > > > > memory_region_finalize() is not a function to tell the owner is leaving, but
> > > > > the memory region itself is being destroyed.
> > > > 
> > > > It is when the lifecycle of the MR is the same as the owner.  That holds
> > > > true I suppose if without this patch, and that's why I don't prefer this
> > > > patch because it makes that part more complicated.
> > > 
> > > The lifecycle of the MR is not the same as the owner. The MR gets finalized
> > > during the finalization of the owner, and the owner is still alive at the
> > > moment. It is something you should always care when having a child object.
> > 
> > What is the benefit of having such explicit layering of different lifecycle
> > between the owner and the MRs that it owns?
> > 
> > To ask in another way, what's the functional benefit that we order the
> > destruction of MRs within the same owner, paying that with explicit two
> > refcounts concept in memory core?

[1]

> > 
> > AFAICT, that's the only purpose MR->refcount is servicing for in this
> > patchset besides the property link.
> > 
> > Currently, memory_region_ref() takes the refcount _only_ from the host.
> > Considering that's the only memory API to take a reference on a MR, it kind
> > of implies to everyone that the MR and the owner shares the lifetime.
> > 
> > In reality, it's not 100% shared indeed, but almost.  We even have those
> > document for dynamic MRs to make sure that is true even there.
> > 
> > Then it's about the "virtual lifecycle" which triggers a finalize(), or
> > "real lifecycle" which triggers a free() that may make a difference to a
> > MR.  And that's the part on whether we should try to not expose too much at
> > all on these.  I want to keep the concept simple if possible that we stick
> > with sharing lifetime between owner and all MRs underneath.  I want to see
> > whether we can avoid complicating that part.
> 
> I would rather avoid virtual or real lifecycles notions because it's more
> than free(). Memory regions constructed with functions like
> memory_region_init_io() and memory_region_init_ram_ptr() requires the owner
> to retain the backend resource to keep functioning. In other words, the
> memory region refers to the owner, and that is no different from other kind
> of references.
> 
> The uniqueness of this relationship is that the owner also refers to the
> memory region. Memory regions avoid a circular reference by omitting the
> reference from them to the owner and instruct others to refer to the owner
> instead.
> 
> > 
> > I can see why you want to clearly separate the lifetimes, because it's
> > cleaner to you.  But IMHO we already made a decision from that starting
> > from when memory_region_ref() does not take MR->refcount, otherwise you
> > should at least need something like this to make the lifecycle completely
> > separate in your this patch:
> > > diff --git a/system/memory.c b/system/memory.c
> > index b17b5538ff..d4b88c389a 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -1843,15 +1843,23 @@ void memory_region_ref(MemoryRegion *mr)
> >        * Memory regions without an owner are supposed to never go away;
> >        * we do not ref/unref them because it slows down DMA sensibly.
> >        */
> > -    if (mr && mr->owner) {
> > -        object_ref(mr->owner);
> > +    if (mr) {
> > +        /* The MR has its own lifecycle.. even if in most cases, virtually */
> > +        object_ref(mr);
> > +        if (mr->owner) {
> > +            object_ref(mr->owner);
> > +        }
> >       }
> >   }
> >   void memory_region_unref(MemoryRegion *mr)
> >   {
> > -    if (mr && mr->owner) {
> > -        object_unref(mr->owner);
> > +    if (mr) {
> > +        /* The MR has its own lifecycle.. even if in most cases, virtually */
> > +        object_unref(mr);
> > +        if (mr->owner) {
> > +            object_unref(mr->owner);
> > +        }
> >       }
> >   }
> > 
> > To me, QEMU already went the other way.  So I sincerely don't know how that
> > extra mr->refcount usage it could bring us.  It only makes it harder to
> > understand to me.
> 
> The owner refers to the memory region in turn so it is fine omitting
> object_ref(mr).

So you decided to "sometimes" take mr->refcount because it needs to, then
"sometimes" don't take mr->refcounts because it doesn't need to..

Normally such complexity is ok, but to me it's ok only when it services,
for example, a major performance improvements, so that it's justified to
add complexity.  The pay is done whoever going to maintain this code.

In this case, no, I don't yet see how important this idea is yet to
introduce such difference into mr refcounts, which is already complicated
as hell..  We're paying such complexity with some "technical cleanest",
while when with different treatment of mr->refcount in different context,
it isn't that clean either.

> If you draw an object graph that originates from the
> referrer, you can still reach the memory region. That is not true for your
> patch; you cannot reach to the subregion from the container.
> 
> The separate lifetimes still matter even with your patch. In a hypothetical
> world that the lifetime of owner and memory regions completely match, the
> ordering of finalization of memory regions owned by one object simply does
> not happen because they occur simultaneously. It is simply not true, and
> even your patch does not make sense in such a hypothetical world.

I hope that's obvious goal since start, yes, that patch will make
finalize() in any order works for MRs under the same owner, as I don't know
why that order matters.. taking that chance of almost still sticking with
one refcount.

I suppose you finally need to answer my above question [1] to say whether
it makes sense.  To me, it doesn't make sense only if there's a functional
difference on that order of finalize().

> 
> > 
> > > 
> > > > 
> > > > > It should not happen when a container is still referencing it. That is
> > > > > also why it has memory_region_ref(subregion) in
> > > > > memory_region_update_container_subregions() and assert(!mr->container) in
> > > > > memory_region_finalize().
> > > > 
> > > > Again, the line I added was sololy for what you said "automation" elsewhere
> > > > and only should work within MR-links within the same owner.  Otherwise
> > > > anyone referencing the MR would hold the owner ref then this finalize()
> > > > will never happen.
> > > > 
> > > > Now, if I could go back to your original purpose of this work, quotting
> > > > from your cover letter:
> > > > 
> > > > > I saw various sanitizer errors when running check-qtest-ppc64. While
> > > > > I could just turn off sanitizers, I decided to tackle them this time.
> > > > > 
> > > > > Unfortunately, GLib versions older than 2.81.0 do not free test data in
> > > > > some cases so some sanitizer errors remain. All sanitizer errors will be
> > > > > gone with this patch series combined with the following change for GLib:
> > > > > https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
> > > > 
> > > > Is check-qtest-ppc64 the only one that will trigger this issue?  Does it
> > > > mean that most of the devices will do proper removal of device-owned
> > > > subregions (hence, not prone to circular reference of owner refcount)
> > > > except some devices in ppc64?
> > > > 
> > > 
> > > Searching for memory_region_add_subregion() gives 1078 instances where there
> > > are 142 instances of memory_region_del_subregion(). This is a rough estimate
> > > but there are potentially 936 instances of subregions without explicit
> > > deletion.
> > > 
> > > For example, hw/audio/intel-hda.c adds subregions immediately after their
> > > containers never deletes the subregions. I think that's fine because their
> > > lifetimes are obvious with reference counters.
> > 
> > OK, let's try to figure out a best way to move forward then.
> > 
> > Let me try to summarize the two approaches so far.
> > 
> > So in general I think I don't prefer this patch because this patch is kind
> > of in the middle of something.
> > 
> > It neither provides 100% separation of MR lifecycle: as discussed above, on
> > not referencing MR->refcount on memory_region_ref/unref at least yet so far
> > together in this patch, but suddenly started considering it in MR links.
> > To me, that's abuse if ordering of such finalize() is not justified.
> > 
> > Nor it provides best efficiency: needing to take a MR->refcount when
> > linking two MRs, even if we essentially don't need to guarded by the fact
> > that owner must exist already, which must hold true anyway for QEMU to work
> > so far.
> > 
> > What I think the best is we either go one way or another: either we make MR
> > lifecycle clearly separate, or we make it clearly efficient (meanwhile we
> > still keep the concept easy, and we at least try to always stick with one
> > refcount which is easier to maintain too).
> > 
> > IMHO that's what the other older patch does (plus my fixup squashed in):
> > 
> > https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/
> > 
> > That avoids taking a refcount for internal MRs, always stick with owner
> > shares the same lifecycle with MRs, just like the same assumption we have
> > already had in memory_region_ref().  The bad side effect is we need
> > something slightly hackish in mr finalize(), but we can provide some better
> > doc, and keep the comlexity there only (which I think is better than always
> > having two refcounts all over).
> 
> Again, please forget about efficiency. It does not matter and makes noises
> in our thoughts.

It's not only about efficiency, that's pretty much side effect.

It's more about how we should define refcount in the future, then if we
stick with owner sharing lifetime with all MRs then taking that subregion
refcount doesn't help anything except introducing a circular reference.  It
solves the circular reference with even a good side effect of reducing one
atomic op from that pov, even if in a slow path.

> 
> > 
> > If we worry about removal of that container assertion, we could assert
> > instead on the owner.  I've attached a slightly modified full version of
> > such alternative patch below, with the best comment I see suite.
> 
> This is better as it tells the lifetimes of memory regions need to be dealt
> with, but why don't you deal them with reference counters in that case?

We discussed plenty in this area, obviously you don't care about keep
having two refcounts on MRs but I do my best to avoid it.. that's all about
it so far..

> Reference counters are tools specifically designed for this.

I hope I was trying to help.  We could wait for a 2nd opinion.

> 
> > 
> > diff --git a/system/memory.c b/system/memory.c
> > index b17b5538ff..7b2d91ca6b 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -1803,7 +1803,6 @@ static void memory_region_finalize(Object *obj)
> >   {
> >       MemoryRegion *mr = MEMORY_REGION(obj);
> > -    assert(!mr->container);
> >       /* We know the region is not visible in any address space (it
> >        * does not have a container and cannot be a root either because
> > @@ -1813,6 +1812,17 @@ static void memory_region_finalize(Object *obj)
> >        */
> >       mr->enabled = false;
> >       memory_region_transaction_begin();
> > +    if (mr->container) {
> > +        /*
> > +         * If this happens, it must be when MRs share the same owner,
> > +         * because only share-owner-ed links doesn't take a refcount.  In
> > +         * this specific case, we allow random order of finalize() on the
> > +         * MRs the owner owns, so it's possible the child finalize()s
> > +         * before a parent.  When it happens, unlink from the child.
> > +         */
> > +        assert(mr->container->owner == mr->owner);
> > +        memory_region_del_subregion(mr->container, mr);
> > +    }
> >       while (!QTAILQ_EMPTY(&mr->subregions)) {
> >           MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
> >           memory_region_del_subregion(mr, subregion);
> > @@ -2644,7 +2654,15 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> >       memory_region_transaction_begin();
> > -    memory_region_ref(subregion);
> > +    if (mr->owner != subregion->owner) {
> > +        /*
> > +         * MRs always have the same lifecycle of its owner, so that when
> > +         * adding a subregion that shares the same owner of the parent, we
> > +         * don't need any refcounting, because the two MRs share the
> > +         * lifecycle with owner, so they share between each other too.
> > +         */
> > +        memory_region_ref(subregion);
> > +    }
> >       QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
> >           if (subregion->priority >= other->priority) {
> >               QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> > @@ -2702,7 +2720,10 @@ void memory_region_del_subregion(MemoryRegion *mr,
> >           assert(alias->mapped_via_alias >= 0);
> >       }
> >       QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> > -    memory_region_unref(subregion);
> > +    /* See the corresponding comment in add subregion path */
> > +    if (mr->owner != subregion->owner) {
> > +        memory_region_unref(subregion);
> > +    }
> >       memory_region_update_pending |= mr->enabled && subregion->enabled;
> >       memory_region_transaction_commit();
> >   }
> 

-- 
Peter Xu


