Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D16C04FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwl9n-0001xm-B1; Tue, 16 Apr 2024 11:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rwl9m-0001xI-00
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rwl9j-0006tj-MY
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713282933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQBWeaqODzmr8hsr6l1ktupGFbcUK4piN++3rHs4ofw=;
 b=JccFBWEyrXhffptGHeEzaRYhdfbFF/lwAPCIdMQ7dhlMmWt1ANFQt8W+Rdt6yvXIqRgGtz
 ygKB6yU2n06LcVsZubLgHLJcKdK5dcFCh3TZHHrIv6B4ttdYg4yd82kNSb8as5q17RrNwc
 TLa+iiEw84NyyrtBc4Hdst/eolFP/LE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-KlOfUtmANvOe8K_Ne1wRnA-1; Tue, 16 Apr 2024 11:55:32 -0400
X-MC-Unique: KlOfUtmANvOe8K_Ne1wRnA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4347df2ad8cso2064031cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 08:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713282932; x=1713887732;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mQBWeaqODzmr8hsr6l1ktupGFbcUK4piN++3rHs4ofw=;
 b=uliFNKu/4yZ8qQfhA038nDj0vN4ahWep2J6l6LaHQnfFKhUyWGJO3tbJOX9wvZrUUV
 K7BJ6bE6JeFnU52ey6gTxmuZYceirDc6mxH2VDrBiUihiBmnU6BBRJC55OfKlt0mc6iQ
 WVDCNVcFzjH2JSfvQtJHKoqLnKnKXxGIuDpIdhuPWiPStVd3+Mu85hw7S+0nKXsB7z9G
 njG4aK7vLbi2Pst3XBH5ihF8Z3B5ZBKj9L33tOL0HSljc/nJa4ZuG5zRXR+202ENguuT
 nB7wVRtwYro/y954BWP+PDXxe6sQLVtJKkW4WVMSvB5RvHIizAr5FL2cSmSVoySH8Nj0
 s5eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjBfGlTPhv13cBEWHEz6cwEwhba0J2fa5xlfXHGl3ZX6DOWElr2+vB7Z4zi8ATbDO/66PY9+jpjZseNa97jQgc/Gyo/cc=
X-Gm-Message-State: AOJu0YyUJ8qxBn8QB5TjPgaoKOKbMm6a87//Zy1ZFdTEzwmZOWb5A5Xf
 ESzXMP7HrmX7GP8Z27CPRiqjVxz5OCSZddoaiySiQtgNg/LtF/cY6frKOE5rZHv4Y3Djr+bvceg
 vxviRXj/cA0VaHeABy73paA9cw3z5hBmzHuz2p011ppk0fZktb8UW
X-Received: by 2002:a05:620a:4726:b0:78e:fba3:701d with SMTP id
 bs38-20020a05620a472600b0078efba3701dmr782274qkb.1.1713282931563; 
 Tue, 16 Apr 2024 08:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdZV+nbfnOtVR8CchifqsUdt2gRKWHFj7evRmm8ZbE9ae6Sid6eZP/0kKYoj589TN0kET2xA==
X-Received: by 2002:a05:620a:4726:b0:78e:fba3:701d with SMTP id
 bs38-20020a05620a472600b0078efba3701dmr782235qkb.1.1713282930814; 
 Tue, 16 Apr 2024 08:55:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c22-20020a05620a135600b0078d68c42962sm7634847qkl.83.2024.04.16.08.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 08:55:30 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:55:28 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, sstabellini@kernel.org, vikram.garhwal@amd.com
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
Message-ID: <Zh6fcLzbm4cpknbT@x1n>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
 <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
 <Zhbg9alYH1-J9poU@x1n>
 <CAJy5ezpfNGDC4Q=eMcQ-df_xZVYnc-CR5wfn4izW2CT532PbAA@mail.gmail.com>
 <3abfdbdd-ee70-4b61-a652-c7b2490732d6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3abfdbdd-ee70-4b61-a652-c7b2490732d6@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 16, 2024 at 03:28:41PM +0200, Jürgen Groß wrote:
> On 16.04.24 13:32, Edgar E. Iglesias wrote:
> > On Wed, Apr 10, 2024 at 8:56 PM Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > On Wed, Apr 10, 2024 at 06:44:38PM +0200, Edgar E. Iglesias wrote:
> > > > On Tue, Feb 27, 2024 at 11:37 PM Vikram Garhwal <vikram.garhwal@amd.com>
> > > > wrote:
> > > > 
> > > > > From: Juergen Gross <jgross@suse.com>
> > > > > 
> > > > > In order to support mapping and unmapping guest memory dynamically to
> > > > > and from qemu during address_space_[un]map() operations add the map()
> > > > > and unmap() callbacks to MemoryRegionOps.
> > > > > 
> > > > > Those will be used e.g. for Xen grant mappings when performing guest
> > > > > I/Os.
> > > > > 
> > > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > > > > 
> > > > 
> > > > 
> > > > Paolo, Peter, David, Phiippe, do you guys have any concerns with this patch?
> > > 
> > 
> > Thanks for your comments Peter,
> > 
> > 
> > > This introduces a 3rd memory type afaict, neither direct nor !direct.
> > > 
> > > What happens if someone does address_space_write() to it?  I didn't see it
> > > covered here..
> > 
> > You're right, that won't work, the memory needs to be mapped before it
> > can be used.
> > At minimum there should be some graceful failure, right now this will crash.
> > 
> > > 
> > > OTOH, the cover letter didn't mention too much either on the big picture:
> > > 
> > > https://lore.kernel.org/all/20240227223501.28475-1-vikram.garhwal@amd.com/
> > > 
> > > I want to have a quick grasp on whether it's justified worthwhile we should
> > > introduce this complexity to qemu memory core.
> > > 
> > > Could I request a better cover letter when repost?  It'll be great to
> > > mention things like:
> > 
> > I'll do that, but also answer inline in the meantime since we should
> > perhaps change the approach.
> > 
> > > 
> > >    - what is grant mapping, why it needs to be used, when it can be used (is
> > >      it only relevant to vIOMMU=on)?  Some more information on the high
> > >      level design using this type or MR would be great.
> > 
> > https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt
> > 
> > Xen VM's that use QEMU's VirtIO have a QEMU instance running in a separate VM.
> > 
> > There's basically two mechanisms for QEMU's Virtio backends to access
> > the guest's RAM.
> > 1. Foreign mappings. This gives the VM running QEMU access to the
> > entire RAM of the guest VM.
> 
> Additionally it requires qemu to run in dom0, while in general Xen allows
> to run backends in less privileged "driver domains", which are usually not
> allowed to perform foreign mappings.
> 
> > 2. Grant mappings. This allows the guest to dynamically grant and
> > remove access to pages as needed.
> > So the VM running QEMU, cannot map guest RAM unless it's been
> > instructed to do so by the guest.
> > 
> > #2 is desirable because if QEMU gets compromised it has a smaller
> > attack surface onto the guest.
> 
> And it allows to run the virtio backend in a less privileged VM.
> 
> > 
> > > 
> > >    - why a 3rd memory type is required?  Do we have other alternatives?
> > 
> > Yes, there are alternatives.
> > 
> > 1. It was suggested by Stefano to try to handle this in existing qemu/hw/xen/*.
> > This would be less intrusive but perhaps also less explicit.
> > Concerns about touching the Memory API have been raised before, so
> > perhaps we should try this.
> > I'm a little unsure how we would deal with unmapping when the guest
> > removes our grants and we're using models that don't map but use
> > address_space_read/write().
> 
> Those would either need to use grant-copy hypercalls, or they'd need to map,
> read/write, unmap.
> 
> > 
> > 2. Another approach could be to change the Xen grant-iommu in the
> > Linux kernel to work with a grant vIOMMU in QEMU.
> > Linux could explicitly ask QEMU's grant vIOMMU to map/unmap granted regions.
> > This would have the benefit that we wouldn't need to allocate
> > address-bit 63 for grants.
> > A drawback is that it may be slower since we're going to need to
> > bounce between guest/qemu a bit more.
> 
> It would be a _lot_ slower, unless virtio-iommu and grants are both modified
> to match. I have looked into that, but the needed effort is rather large. At
> the last Xen summit I have suggested to introduce a new grant format which
> would work more like a normal page table structure. Using the same format
> for virtio-iommu would allow to avoid the additional bounces between qemu and
> the guest (and in fact that was one of the motivations to suggest the new
> grant format).

I have a better picture now, thanks both.

It really looks like an vIOMMU already to me, perhaps with a special refID
mapping playing similar roles as IOVAs in the rest IOMMU worlds.

I can't yet tell what's the best way for Xen - as of now QEMU's memory API
does provide such translations via IOMMUMemoryRegionClass.translate(), but
only from that.  So far it works for all vIOMMU emulations in QEMU, and I'd
hope we don't need to hack another memory type if possible for this,
especially if for performance's sake; more on below.

QEMU also suffers from similar issues with other kind of DMA protections,
at least that's what I'm aware with using either VT-d, SMMU, etc.. where
dynamic DMA mappings will slow the IOs down to a degree that it may not be
usable in real production.  We kept it like that and so far AFAIK we don't
yet have a solution for that simply because of the nature on how DMA
buffers are mapped and managed within a guest OS no matter Linux or not.

For Linux as a guest we basically suggest enabling iommu=pt so that kernel
drivers are trusted, and kernel driven devices can have full access to
guest RAMs by using the vIOMMU's passthrough mode. Perhaps similar to
foreign mappings for Xen, but maybe still different, as Xen's topology is
definitely special as a hypervisor here.

While for userspace drivers within the guest OS it'll always go through
vfio-pci now, which will enforce effective DMA mappings not the passthrough
mode. Then it's suggested to only map as less as possible, e.g. DPDK only
maps at the start of the user driver so it's mostly not affected by the
slowness of frequently changing DMA mappings.

I'm not sure whether above ideas would even be applicable for Xen, but I
just to share the status quo regarding to how we manage protected DMAs when
without Xen, just in case there's anything useful to help route the path
forward.

Thanks,

-- 
Peter Xu


