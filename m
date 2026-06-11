Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF6DCD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmQZ-0004OH-AS; Thu, 11 Jun 2026 16:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXmQX-0004O4-Vy
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXmQU-00037a-VG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781211297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ax6mCs2EE1riUYJP6428hU6jTaztbD/y/OZ9SMF/EDU=;
 b=UUj1WzLZIz733W+XvVBNRXiIImojPQQenRGAg4tjsDdUwi+QBr4pjMvHrxP6pn0m/sbpPI
 xGp3A3XDs1TDbj9UmxdL/y5tRoQpjnm4dOuCsU90muxcF9oB9AgVv8oagqPCfeGoR64N51
 JEmxUq6VXLrC1R9+XdsZEQUbHa1aueU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-mgyeSDyANWmJazlVHmD4Aw-1; Thu, 11 Jun 2026 16:54:55 -0400
X-MC-Unique: mgyeSDyANWmJazlVHmD4Aw-1
X-Mimecast-MFC-AGG-ID: mgyeSDyANWmJazlVHmD4Aw_1781211295
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5175a1e32e3so5314941cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781211295; x=1781816095; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ax6mCs2EE1riUYJP6428hU6jTaztbD/y/OZ9SMF/EDU=;
 b=Ydw/Bq2ErEbyNo8wxGjWxsR8s+1tmsby00WWGOni2JRbkde0l4GcT5X+R70z5N5qOS
 cEUfOq6yfqbYOOoBPKEXFabi4sjsjaUrel43KSLboD39CoUFKYwGi+GHWS5TWrNezSRd
 Oprp/0O36/opetXRUzkZr+wQjyHO0xhFEr/ViPeM6hH+T7d4kDwpgv6Y8CFSMp1V6gYf
 Vv9dyUWjMNhZ9/Y9dZeq9O7VQkqy1PlKbZ3Cr1QGw8xP7RqCRe+ZC5xTcclfj0IWQp3f
 20T8iIdGtk5Br6281U2HlGP0w2CYqEIwFfA5BpeUyEBwsCoIbiZQHJTa9aEnkt60Phg3
 mlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781211295; x=1781816095;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ax6mCs2EE1riUYJP6428hU6jTaztbD/y/OZ9SMF/EDU=;
 b=gxlmJzriqReq+12rC1CS22U+Ph2paOxpwSDXl5vukn2AJa5qclB14vJQOEwqxCUGXo
 lPF3t1BmVHmwjh+uKRFpNezSoc92FOFibhxZ8wFseAoIF9BLRbr8i4qGxE0h9lU1OJdo
 iqN+nIHxNLrrO+aGJsTQ9lP4sU/iT8NTv7KR8uxlspyuF2q/J+cy6OsFoCL6gH57edmO
 QnRnQbdjNf3Lcbt6cvIARPxHJ6UJ45P9NZlUjeAMD5ifgDdWqsbw65OT8bUsjJ9B+r+S
 nKD/jF0eSdBtatCmw6IDApoIlpprCCmoQ7VfOI8wkzal1g3rwNvpvHJAy0Ra9iRmGKvG
 Tu2Q==
X-Gm-Message-State: AOJu0Yy/1kC9dqm+3douxNVl4FzexW22Un/vUCKI8VCfI4LEGkqmgoeX
 QYraLTVgueLTBOogzQA9I8Aa8hARPB2WsJxSzLy+xnIpw6XSYNValewP8wyDBBSA7axDC13H6SC
 FumdurEJMRDoHdRyWvZeJglb40zFYBP29JzTaIDjCdpMDGnAcXgU9KBPQ
X-Gm-Gg: Acq92OGeb+lW+ksOrekfJskCYgIkJ3cH9otMveSukbHH2sPErwJHzQZ+lkyDWuedqlf
 tba5ES0XpnfXqmXIBzsnX9mv7hj4yLAThjWsgwpVk2DATNijdECb89DptpQ3LwITh0VXzTSNUJd
 YZlpQ42s+2iFeDTUUMZA5vXroCMoyoTJkCSvrSaIsR3t64krWP2+XzFZ8IZq5DA+PNBuSfCjc8M
 mbhw7gDPMdFNH1b4WfRn/cfuQonRrxh+s2mpT7FG/l/Tz2wIW916Tiyx2mOI+GPloTF+bRuj0Wl
 Vqa17JyGo+OvRTu6Ud3w+Yh7C3vTOUVSwh17FNGmry9zHIDesyCVaELFCW9miD3giGchFefVGDY
 dYwLPJeaCVZSQwGQ=
X-Received: by 2002:ac8:5a43:0:b0:50e:a1ab:67ea with SMTP id
 d75a77b69052e-517ee27e43amr69839671cf.40.1781211294945; 
 Thu, 11 Jun 2026 13:54:54 -0700 (PDT)
X-Received: by 2002:ac8:5a43:0:b0:50e:a1ab:67ea with SMTP id
 d75a77b69052e-517ee27e43amr69839131cf.40.1781211294150; 
 Thu, 11 Jun 2026 13:54:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb841970sm3295991cf.30.2026.06.11.13.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:54:53 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:54:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <aisgm-Kk2OGxJ5XN@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
 <aiCAFWKEAHkPLCO5@x1.local>
 <lpkcfd2crgparcd64ydry3ocryx3sfc5gj5pzrrms4nwvw6j4c@ulc3wa3rmefo>
 <aiLj3o7IIixCvX2A@x1.local>
 <osgeqdz7fukls5irhg2e3zi23yl7ej4depttlrphhinb76zlws@5gtyfdw4u3yu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <osgeqdz7fukls5irhg2e3zi23yl7ej4depttlrphhinb76zlws@5gtyfdw4u3yu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 08, 2026 at 12:59:55PM -0500, Michael Roth wrote:
> On Fri, Jun 05, 2026 at 10:57:34AM -0400, Peter Xu wrote:
> > On Thu, Jun 04, 2026 at 05:36:42PM -0500, Michael Roth wrote:
> > > > IIUC it's a matter of if we expect future property of guest-memfd that will
> > > > stop applying to memfd anymore?
> > > 
> > > Yah, I think that's the main thing to consider. There's a few things in the
> > > pipeline where the options associated with guest_memfd might diverage
> > > quite a bit from memfd:
> > 
> > Thanks for all these contexts.  I'll throw some random questions below,
> > some of them may not be directly related to the current discussion, but
> > please bare with me.
> > 
> > > 
> > >   - hugetlb: yes, these could potentially use the same options memfd
> > >     uses, and I'm guessing that will end up being the case, but one
> > >     large gap there is that shared memory is always split to 4K, which
> > >     we've accepted for now, but if you consider use-cases like DPDK
> > >     there can still be major performance bottlenecks that would drive
> > >     us to try to enable larger mappings for the shared ranges, and then
> > >     we'd end up with guest-memfd-specific parameters intermix with
> > >     normal memfd options, and our related documentation would need to
> > >     covers these differences case by case
> > 
> > The first thing I thought about is mTHP and how it can also be similarly
> > applied to normal memfd (now, or in the future, that I'm not sure).
> 
> That might work, though for some architectures the shared pages might
> benefit from a wider range of hugepage granularities than private. For
> instance with SNP it might make sense to expose 1GB hugepages but then
> limit them to 2MB granularity for private (since private pages get 2MB
> TLB entries anyway so rebuilding from 2MB->1GB is a waste)
> 
> https://github.com/AMDESE/amdsev#prepare-hostBut IIUC that sort of support will likely depend on some mm/ changes
> are refcounting that probably won't be completed any time soon so it's
> hard to say to anticipate what that'll end up looking like.
> 
> > 
> > Before that..  shouldn't the whole concept of private mem / gmem about
> > reducing the area of mapping the host (including dpdk, if we're talking
> > about things like OpenVswitch)?  Can you roughly describe how huge mapping
> > is expected to be allowed in such case?  Does it mean the guest driver
> > should also be aware to allocate huge continuous physical mem for DMA only?
> 
> Guest drivers would generally end up either going through SWIOTLB to get
> access to shared memory, or convert their pages to shared directly prior
> to use. Optimizations for hugepages would work roughly the same as any
> optimizations that have already been done for the non-confidential case.
> Shared guest allocations/conversions at granularities smaller than the
> backing page/hugepage size are where confidential VMs start to pay an
> extra tax in guest_memfd and potentially with the security architecture
> (e.g. extra RMP table checks for SNP, not just the TLB/TLB misses).
> 
> It seems to be in everyone's best interest to have a common shared
> memory pool that gets initialized/converted/replenished at hugepage-sized
> granularities. Here's one patchset[1] that takes the natural choice of
> doing this through SWIOTLB. Not sure that's ultimately what it will look
> like but I think it's safe to expect some level of optimization.

[sorry for a late response]

OK, yes this sounds reasonable in general.

> 
> So with all these pieces in play, what I would expect is that DPDK
> applications could access these shared buffers using hugepages both in
> the guest and host-side as they do today, since the whole hugepage/folio

So even if physical continous chunks (each 2M in size) are preserved, it's
still part of gmem page cache (based on either 2M or larger huge pages).

Then I assume if we want to have OVS-DPDK be able to hugely map it, we'll
need to support in gmem's fault handler when seeing some shared huge 2M and
do the job right.  There seems to have some details missing (e.g. I wonder
if it's still safer to only map 4K by default..), but it sounds working
indeed.

> will be homogenous with the above guest optimizations... but that still
> requires the above-mentioned mm/ rework for refcounting to allow hugepages
> for shared ranges so this is another thing that we probably won't need to
> deal with any time soon, but I think that's roughly what we could expect
> it to look like eventually.
> 
> [1] https://lkml.org/lkml/2024/1/12/65
> 
> > 
> > >   - DAX-like stuff: there are some proposals for making device memory
> > >     available to use as private guest memory, and since 'guest-memfd'
> > >     is generally responsible for managing private memory, it will
> > >     likely end up being extended to handle this at some point. One
> > >     proposal/PoC[1] would involve at least needing additional options
> > >     for the /dev/dax path, but there have also been discussions about
> > >     having a general notion of custom allocators that can be plugged
> > >     into guest_memfd, and some of these might have overlapping options
> > >     WRT things like hugepages/etc. But at a high-level, DAX would map
> > >     more to memory-backend-file than memory-backend-memfd, so we'd
> > >     already be crossing up some wires there.
> > 
> > I have no deep understanding on this, but IIUC we used to stick with
> > memory-backend-file for dax.  Why switch to memory-backend-guest-memfd?
> > Are we still exposing a dax via a file path ultimately, even with CoCo?
> 
> I touched on this a bit below, but I don't necessarily think
> memory-backend-guest-memfd should handle DAX, it's just one example
> where we clearly need to think beyond 'memfd', but are still potentially
> in the realm of 'guest_memfd' depending on what the API ends up looking
> like.
> 
> But I agree with your below point that we don't need the backend to
> match up with implementation details of how guest_memfd works
> internally, and that the core point that memory-backend-file might still
> end up seeming like the most appropriate way for a QEMU user to specify
> a DAX path, even if internally it's still using guest_memfd.
> 
> Though going that route, we'd still have a
> memory-backend-file,...,guest_memfd=on that brings 'memfd's' back into
> the discussion. We could take it a step further and rename the
> 'guest_memfd' backend option to 'securable', but maybe this is ends up
> being that right level of balance between 'i need to open a file that
> can do guest_memfd-related stuff', and 'i need to create a guest_memfd
> instance can handle a DAX path'.

What I have in mind is, when used as CoCo where we will need to apply the
machine property first saying "this is a CoCo VM", we shouldn't need to
specify "guest-memfd=on" all over the places anymore. QEMU should be able
to identify it's required to initialize everything to use guest-memfd, or
fail when it's not supported.

I introduced "guest-memfd" parameter in this series because this series
still haven't gone as far: unlike CoCo+in-place-conversion or the old CoCo
with two-layered backends, init-shared is an opt-in feature, and there's no
machine property to imply anything. It's different from CoCo VMs.

I wonder if you think that's a good idea.  So I found it redundant to
specify guest-memfd=on for CoCo VMs for all such backends (unless if we
decide to go with memory-backend-guest-memfd, then it's fine).

Say, after in-place conversion ready, we should specify this:

  $QEMU -M $SOME_COCO_PARAMS,in-place-conversion=on -object memory-backend-memfd,id=*
  (without guest-memfd=on)

Then that memory-backend-memfd should automatically notice "ok this is a
CoCo VM with in-place conversion enabled, we don't do dual-layer, this must
be a gmemfd".

> 
> My thinking was that since the hugepage PoC already implements the notion
> of custom allocators in the uAPI, and that there's been talk of 'pluggable'
> backends for guest_memfd, that the kernel would also need to do a reasonable
> job in creating a consistent uAPI/documentation, such that the hugepage/DAX
> cases would end up looking something like:
> 
>   memory-backend-guest-memfd,allocator=hugetlb,pagesize=2M,...
>   memory-backend-guest-memfd,allocator=dax,path=/dev/daxX,pagesize=2M,...

So far I'm still a bit conservative to introduce a path= parameter to a
memfd backend.. but we can hold the discussion until the idea becomes
clearer.

> 
> which is firmly on the 'i need to create a guest_memfd instance that's
> back by a DAX path' end of the spectrum, compared to the more abstracted
> approach you're suggesting, and so for the most part we'd be passing
> through the kernel options/documentation to users vs. abstracting it and
> then touching on it case-by-case in 'memfd'/'file'/etc. documentation.

If you agree with my above idea, we don't need to document anything special
for CoCo.  We support all things internally, no doc change needed except
telling people how to enable CoCo.

Say, if we have a command line that works for QEMU without CoCo:

  $QEMU -M ... -object memory-backend-memfd,id=...

Then my imagination is if we want to boot that same VM but with CoCo, the
cmdline should be:

  $QEMU $COCO_PARAMS1 -M ...,$COCO_PARAMS2 -object memory-backend-memfd,id=...
  (again, no guest-memfd=on anywhere)

I wish it will just work all like before, except that it now boots a
confidential VM, so safety guaranteed.

I agree that's the ideal case, and I may over look things.. Please correct
me if I missed some.

> 
> Personally, I'm not sure at this point which approach will end up being
> the more workable one. But it is harder/more-confusing to start with
> memory-backend-guest-memfd, and then go back to e.g.
> memory-backend-file,guest_memfd=on later for future extensions. So I'm
> start to lean toward doing the minimal
> '<existing_backend>,guest_memfd=on' thing for now, and then just
> deprecating it if we really feel like we need a more direct interface
> that memory-backend-guest-memfd down the road.
> 
> Does that seem reasonable for a starting point? I feel like we'll be
> better positioned to make a better long-term decision once some of these
> patchsets are further along.

The more I read into it, the more I feel like we should settle this early..
It might be a good timing to discuss this.

Again, I don't actually have any strong opinion right now, say, duplicating
the current memfd backend file isn't a huge deal. Now, I'm uncertain
slightly more about the future, and whether that's the right start to
future's QEMU cmdline interfacing with CoCo.

> 
> > 
> > Note, here I want to differenciate two concepts: QEMU interfacing and
> > kernel/KVM interfacing.  I mean, I have a gut feeling that for coco dax we
> > could still stick with memory-backend-file, even if internally we can still
> > use new KVM ioctls to set them up: there's no rule to say only
> > memory-backend-guest-memfd can use the KVM ioctl.  IMHO they're different
> > stories, and here I'm focused more on the QEMU interfacing that we're
> > discussing here.
> > 
> > IMHO for QEMU's interfacing, any memory-backend should play one solo role
> > which is to point to QEMU (as a hypervisor) a backing store for some piece
> > of resource that can be used as guest memory backend.  It doesn't need to
> > have any implication on how we implement that backend internally.
> > 
> > >   - live update: there's work[2] on enabling preservation of confidential
> > >     guest memory across kexec by preserving it through guest_memfd. This
> > >     one is still a bit mind-blowing to me but I could see us needing
> > >     some additional options here that would really make no sense for
> > >     memfd.
> > 
> > Could you elaborate what kind of parameter you would expect?
> 
> I was thinking stuff like the metadata that would be needed to rebuild a
> KVM instance with the same GPA->HPA mappings to the pages previously
> allocated by guest_memfd. It makes semse that each backend has it's own
> associated metadata so that each can be restored in-turn, but yes there
> would also need to be some common state like KVM itself that needs to be
> serialized, and this would probably have separate options. So in theory it
> wouldn't need to be tied to the backend, but IMO it feels very natural
> to imagine the options like something like that.

So live update should ideally work both for CoCo and non-CoCo, and work for
all memory-backends, am I right?  I'm not sure if it means gmem is not
special in this case, because they should all be reserved on save(), and
recovered on load().

If you put everything above into this picture, live update (or CPR) only
means: let's do a migration with this VM, no matter if it's CoCo or not.
It hopefully shouldn't care some parameter the memfd (gmem or not) has.

> 
> > 
> > I'm not sure if you have investigated QEMU's CPR approach, now memfd
> > backend is really the core of supporting such infrastructure, where fds can
> > be persisted.  For live update, it'll be persisted across kexec and kernel
> > switchover.  For CPR, it actually also works when with cpr-reboot with its
> > own tricky way to persist memory.
> > 
> > In general, what I want to say is, I really think they should play the same
> > in term of live update case too: if we need to register some fd for
> > persistency, we need to register gmem, kvm, but also memfd if some of them
> > are attached to the current VM, right?
> 
> I definitely need to look into this more (and intra-host live update for
> guest_memfd/in-place converison in general), but for guest memory
> persistence it seems like we'd generally be relying on
> memory-backend-file=<path> as a target/src for serializing guest memory
> to persistent storage for normal/'memfd' case.
> 
> But for confidential VMs we don't just need the data for a particular GPA,
> but the original HPA and maybe details like the associated shared/private
> memory attributes, which is why I'm thinking we might need something like a
> separate path argument for that, or maybe QEMU abstracting this out into its
> own user-configurable format.
> 
> > 
> > >   - directmap removal: these[3] patches allow a new guest_memfd flag to
> > >     be set to unmap guest_memfd pages from kernel directmap to help
> > >     mitigate speculative attacks, probably would involve a new option
> > >     as well that wouldn't be applicable to normal memfds
> > 
> > Now the question is, do we want to remove directmap for "some" memory
> > backend, or do we want to remove it per-VM?
> > 
> > This is another thing I want to make sure we're on the same page: I want to
> > make sure we don't introduce per-VM setup for memory backends.
> > 
> > Say, "init-shared" or "in-place CoCo", what should we use for one gmem fd?
> > IMHO it shouldn't be a parameter in the memory-backend.  It should be a
> > parameter for the -machine or some similar per-vm setup, which will apply
> > to all gmemfd across the current VM.
> > 
> > My understanding is directmap removal is similar in this case, which seems
> > to be a per-VM (rather than per-memory-backend) attribute?  We can still
> > operate on that per-memory-backend, but then it'll be internally, the
> > backends need to understand the VM setup and do things properly, IMHO.
> 
> I think all-or-nothing would be most common, but it's completely
> controlled at the guest_memfd inode level so it would support that sort
> of flexibility if needed. One side effect is that setting it currently
> sets AS_NO_DIRECT_MAP which can have some performance downsides...
> maaaaaybe that's enough for someone to want to fine-tune 'isolated' vs.
> 'non-isolated' GPA ranges?

Yes, it sounds possible, but it sounds non-trivial to do any fine tuning..
and maybe the admin will just go take or not take the penalty. :)

I'll see how you think about my above comments in general, the summary is
whether we can relying on a machine prop to define the VM completely on all
internal things, rather than needing to touch everything.  If that's a good
idea, then maybe we don't need a new backend for the same reason, because
memfd backend "must" be guest-memfd backend for CoCo.

This made me also thought about when CPR was introduced: not relevant to
"live update" perspective, but similarly we need something special all over
the places, and what CPR does was exactly requiring one global -M parameter
with:

-machine aux-ram-share=on

That enables all internal RAMs allocated (like, ROMs) to be fully fd-based.
All rest QEMU cmdlines untouched to support CPR.

CPR hided quite some tricky checks all over the place.  Sometimes I don't
like it, but I think what I don't like is not the interfacing part, only
when it hides things too deep in stack..  Logically the idea still makes
sense and it's similar here on one knob controlling everything.

https://www.qemu.org/docs/master/devel/migration/CPR.html

Thanks again for all the details!

> 
> So I think it's pretty safe to say we don't *need* to expose this
> functionality per-backend/inode initially, and if we end up preferring a
> global option then that's probably fine too. So we can probably set this
> example aside for now.
> 
> > 
> > > 
> > > It could also end up that even memory-backend-guest-memfd is too
> > > generic, and that some of these would involve a more specialized memory
> > > backend where may they can share a common base class for some of the
> > > core guest_memfd stuff but otherwise be separate backends with their
> > > own specific options. So to me, starting off building up
> > > memory-backend-memfd seems like a potential misstep, whereas we don't
> > > really lose much to start with a clean slate.
> > > 
> > > [1] DAX: https://lwn.net/ml/all/20260423170219.281618-1-dave.jiang@intel.com/
> > > [2] LUO: https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/#r
> > > [3] directmap removal: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/
> > > 
> > > > 
> > > > > 
> > > > > I also saw you were open to having someone pick up these patches if you
> > > > > don't think you'll have a chance to get to them near-term, so I'd be
> > > > > happy to pick them up if that's preferable.
> > > > 
> > > > Sure!  Indeed I don't have bandwidth to keep working on this one in the
> > > > near future. Please feel free to pick whatever needed into your series.
> > > 
> > > Ok, sounds good, I'll pick these up for my next posting and incorporate
> > > any changes/comments that might still be pending at that time.
> > > 
> > > Thanks for getting things to this stage!
> > 
> > Thanks for picking it up!  Juraj in our team may have some future
> > exploration on gmem over 1G for postcopy on init-shared, so it's great the
> > code is moving closer to that direction.
> 
> Nice, lots of interesting work ahead it seems :)
> 
> Thanks,
> 
> Mike
> 
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> > 
> > 
> 

-- 
Peter Xu


