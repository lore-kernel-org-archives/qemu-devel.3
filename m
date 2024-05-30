Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF1C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 18:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCkIz-0004ER-8h; Thu, 30 May 2024 14:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCkIs-0004ED-TX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 14:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCkIo-0006sm-NK
 for qemu-devel@nongnu.org; Thu, 30 May 2024 14:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717092900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibUAbSQC0eZ4QRXpHOKvh8gAK13VlX3RMbm23MvShg8=;
 b=O8g17+R0bCDXb/qvHCvFXulu8lWJU/P1TeYGBR3vePdcC7RLxQZtXdktRE+M+qTprDxAd9
 Rk1LsUKEhRRqb5By+n+OaqXDTFK6oFyI/zjgkOQOUL4AkEwVoVhjUGDF41SoiBloaW7JD8
 06CmnbbAJ2VlUcvudVBYF19frSHGrug=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-UiUBruVgPyqJ_2Y5-D93GQ-1; Thu, 30 May 2024 14:14:59 -0400
X-MC-Unique: UiUBruVgPyqJ_2Y5-D93GQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ae4a58fa7cso277186d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 11:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717092898; x=1717697698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibUAbSQC0eZ4QRXpHOKvh8gAK13VlX3RMbm23MvShg8=;
 b=BBk2COsW/18raYEkeP0fok7D+3IBs+NTc9OSzxgHntEZZqDEucDZHEvxIrAjDnNNrl
 mfglqBGuDizcYbh+9VD/w3dx1lzdekTB1Y+a8FXG15X03YEXnVUVi/vh4cKT/QdJL4VM
 YosFtprWED5S6tQjKMW0g5DHxgji9MSp8LUpPZklc7+ezJWxNvP+BTqkjLYJWMGmWq88
 DLHvE+lamnCHhjtah16KL5Ck4Qon0PeB6aQqjCm0CPpe8XY7GEONUwFI7nvJHhi7vq9X
 ooy1b/j1sx1n96dW5DjElu4QXqNkR6VpuxPbGeSG9jWWQb2x2m2asLVXHtRdcWuHZack
 /Gqg==
X-Gm-Message-State: AOJu0YxT/hOskzLOoqWanX+LVZQ8+Jz0zruEJi6ndIF61/SCnU+wQ+k9
 QMAkEM5Z/sx8mpz5tMOyFB9hoYzzibrI8ogS+ld5ITV8Juj/iY0qxZPXLEg/p0oiCOXl6mRn6ui
 /gPfNDB4VHS0UI6rW6smta3+GAYSEM1KLH4uZlkDeuMV91IAxy7Os
X-Received: by 2002:a05:6214:5094:b0:6ab:7ce8:820c with SMTP id
 6a1803df08f44-6ae0cf697a0mr31365236d6.5.1717092898250; 
 Thu, 30 May 2024 11:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZu03BVZ36+5Xf6r7OOQDdTY5FZWMJ592ohoHsnbX2F4x7upP5wXaEAC92X6JzzTDdx301fw==
X-Received: by 2002:a05:6214:5094:b0:6ab:7ce8:820c with SMTP id
 6a1803df08f44-6ae0cf697a0mr31364866d6.5.1717092897503; 
 Thu, 30 May 2024 11:14:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b4195f7sm598136d6.126.2024.05.30.11.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 11:14:57 -0700 (PDT)
Date: Thu, 30 May 2024 14:14:54 -0400
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
Message-ID: <ZljCHgwJhGcFiP1J@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n>
 <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n>
 <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 30, 2024 at 01:11:09PM -0400, Steven Sistare wrote:
> On 5/29/2024 3:14 PM, Peter Xu wrote:
> > On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
> > > > > diff --git a/system/memory.c b/system/memory.c
> > > > > index 49f1cb2..ca04a0e 100644
> > > > > --- a/system/memory.c
> > > > > +++ b/system/memory.c
> > > > > @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
> > > > >                                          uint64_t size,
> > > > >                                          Error **errp)
> > > > >    {
> > > > > +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> > > > 
> > > > If there's a machine option to "use memfd for allocations", then it's
> > > > shared mem... Hmm..
> > > > 
> > > > It is a bit confusing to me in quite a few levels:
> > > > 
> > > >     - Why memory allocation method will be defined by a machine property,
> > > >       even if we have memory-backend-* which should cover everything?
> > > 
> > > Some memory regions are implicitly created, and have no explicit representation
> > > on the qemu command line.  memfd-alloc affects those.
> > > 
> > > More generally, memfd-alloc affects all ramblock allocations that are
> > > not explicitly represented by memory-backend object.  Thus the simple
> > > command line "qemu -m 1G" does not explicitly describe an object, so it
> > > goes through the anonymous allocation path, and is affected by memfd-alloc.
> > 
> > Can we simply now allow "qemu -m 1G" to work for cpr-exec?
> 
> I assume you meant "simply not allow".
> 
> Yes, I could do that, but I would need to explicitly add code to exclude this
> case, and add a blocker.  Right now it "just works" for all paths that lead to
> ram_block_alloc_host, without any special logic at the memory-backend level.
> And, I'm not convinced that simplifies the docs, as now I would need to tell
> the user that "-m 1G" and similar constructions do not work with cpr.
> 
> I can try to clarify the doc for -memfd-alloc as currently defined.

Why do we need to keep cpr working for existing qemu cmdlines?  We'll
already need to add more new cmdline options already anyway, right?

cpr-reboot wasn't doing it, and that made sense to me, so that new features
will require the user to opt-in for it, starting with changing its
cmdlines.

> 
> > AFAIU that's
> > what we do with cpr-reboot: we ask the user to specify the right things to
> > make other thing work.  Otherwise it won't.
> > 
> > > 
> > > Internally, create_default_memdev does create a memory-backend object.
> > > That is what my doc comment above refers to:
> > >    Any associated memory-backend objects are created with share=on
> > > 
> > > An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
> > > 
> > > The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
> > > 
> > > +#     Memory backend objects must have the share=on attribute, and
> > > +#     must be mmap'able in the new QEMU process.  For example,
> > > +#     memory-backend-file is acceptable, but memory-backend-ram is
> > > +#     not.
> > > +#
> > > +#     The VM must be started with the '-machine memfd-alloc=on'
> > > +#     option.  This causes implicit ram blocks -- those not explicitly
> > > +#     described by a memory-backend object -- to be allocated by
> > > +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> > > +#     RAM when it is specified without a memory-backend object.
> > 
> > VGA is IIRC 16MB chunk, ROM is even smaller.  If the user specifies -object
> > memory-backend-file,share=on propertly, these should be the only outliers?
> > 
> > Are these important enough for the downtime?  Can we put them into the
> > migrated image alongside with the rest device states?
> 
> It's not about downtime.  vfio, vdpa, and iommufd pin all guest pages.
> The pages must remain pinned during CPR to support ongoing DMA activity
> which could target those pages (which we do not quiesce), and the same
> physical pages must be used for the ramblocks in the new qemu process.

Ah ok, yes DMA can happen on the fly.

Guest mem is definitely the major DMA target and that can be covered by
-object memory-backend-*,shared=on cmdlines.

ROM is definitely not a DMA target.  So is VGA ram a target for, perhaps,
an assigned vGPU device?  Do we have a list of things that will need that?
Can we make them work somehow by sharing them like guest mem?

It'll be a complete tragedy if we introduced this whole thing only because
of some minority.  I want to understand whether there's any generic way to
solve this problem rather than this magical machine property.  IMHO it's
very not trivial to maintain.

> 
> > > >     - Even if we have such a machine property, why setting "memfd" will
> > > >       always imply shared?  why not private?  After all it's not called
> > > >       "memfd-shared-alloc", and we can create private mappings using
> > > >       e.g. memory-backend-memfd,share=off.
> > > 
> > > There is no use case for memfd-alloc with share=off, so no point IMO in
> > > making the option more verbose.
> > 
> > Unfortunately this fact doesn't make the property easier to understand. :-( >
> > > For cpr, the mapping with all its modifications must be visible to new
> > > qemu when qemu mmaps it.
> > 
> > So this might be the important part - do you mean migrating
> > VGA/ROM/... small ramblocks won't work (besides any performance concerns)?
> > Could you elaborate?
> 
> Pinning.
> 
> > Cpr-reboot already introduced lots of tricky knobs to QEMU.  We may need to
> > restrict that specialty to minimal, making the interfacing as clear as
> > possible, or (at least migration) maintainers will start to be soon scared
> > and running away, if such proposal was not shot down.
> > 
> > In short, I hope when we introduce new knobs for cpr, we shouldn't always
> > keep cpr-* modes in mind, but consider whenever the user can use it without
> > cpr-*.  I'm not sure whether it'll be always possible, but we should try.
> 
> I agree in principle.  FWIW, I have tried to generalize the functionality needed
> by cpr so it can be used in other ways: per-mode blockers, per-mode notifiers,
> precreate vmstate, factory objects; to base it on migration internals with
> minimal change (vmstate); and to make minimal changes in the migration control
> paths.

Thanks.

For this one I think reusing -object interface (hopefully without
introducing a knob) would be a great step if that can fully describe what
cpr-exec is looking for.  E.g., when cpr-exec mode enabled it can sanity
check the memory backends making sure all things satisfy its need, and fail
migration otherwise upfront.

-- 
Peter Xu


