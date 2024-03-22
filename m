Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7334C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhwg-0007qK-Qb; Fri, 22 Mar 2024 12:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhwf-0007pq-OO
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhwd-0005rw-Hf
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711125638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=be4ienNALxDQ6eTFQ0YZ+mxwcafA+2bhcFS0ZC/sZT8=;
 b=CVlNkFDCO1bPY9iXOChCU9KUbfwrAcVzgpEJlIUGWFjN4RLC2RPp+DumBYpBS2XNLH4O2T
 FFMqBC2kVaB1oLIpUJSDpdS79JyvMXoKynIv8KJRaeofuQu3MuOjmuVsgzAl9vNgklMFR0
 32pbSjAmv5xpIl8vzTxh9e5h+CKjVt8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-8z99tD-WMi65MH8vMyl-ww-1; Fri, 22 Mar 2024 12:40:36 -0400
X-MC-Unique: 8z99tD-WMi65MH8vMyl-ww-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcdb00ff6e0so434355276.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711125636; x=1711730436;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=be4ienNALxDQ6eTFQ0YZ+mxwcafA+2bhcFS0ZC/sZT8=;
 b=hC4uGKkvB+x34Zfwill2nNiGbklj9ecNDgXKWvgkH6znL7VRJ2bZmIkFZaP+6ySIUz
 Rga2D5Qf1zAjVyPoaaRlF/XvLH7XJ47zo9sNs3ITnWLXdvuAZidFd6mmwDlCJisSXRzi
 uURNrbNRIvaZJCuT7o+GS0f/L+XFMMjWIPYEfEo8KrU8zDe1PwAhxXTnh2SYB7UxIcE7
 3Jm/NenPBKCrrZ+O8D5mWqqEU+V1xCGU477pZ5N8K61zlKsxZFMEq4IR1gfkzcojcKLD
 3KOa18vaN7IOjoWzIDhKPUZTZHRzlxNz2yDJzGZ1YB5ox3LsjFzIySW8eiEoEIEgzjuk
 BWgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF9n99Rp2LEpfmyR+SPsYo84zHqFinXboriQZ0rKK9s+z6VIf+szj9HtSmURwr1U8X4SflyEkQPbg3PKCNjKOStMnwXEc=
X-Gm-Message-State: AOJu0YybK1U7ruUOvPLcratoJixhY4E4cGCLd2PuqrQ8If5qkTJVKI4J
 rXAvuMZbij9YyubADMdrv1F+YGSCO3A9T33oeFaMns3pdNnTGJ+oty1yxkA/a9IxtiUpKhE2Ezw
 AAzWyPYTeeQ7BjdpyKO5WhaLdQVkB1mB2JKiYHMjgaOSMNNt7ldbV
X-Received: by 2002:a25:c846:0:b0:dc7:491a:18c2 with SMTP id
 y67-20020a25c846000000b00dc7491a18c2mr2144482ybf.6.1711125635571; 
 Fri, 22 Mar 2024 09:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJapDXkyljLNKaMDFFJhKmak5A0eYvg6xRieT3/yFoNbSgGd9+tV3EiJp9aukrpaAuzoX0Ug==
X-Received: by 2002:a25:c846:0:b0:dc7:491a:18c2 with SMTP id
 y67-20020a25c846000000b00dc7491a18c2mr2144442ybf.6.1711125635137; 
 Fri, 22 Mar 2024 09:40:35 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 t12-20020a0562140c6c00b00690dcc7ae8dsm1236772qvj.3.2024.03.22.09.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 09:40:34 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:40:32 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Message-ID: <Zf20gJbSavpp93_b@x1n>
References: <20240319164527.1873891-6-yuan1.liu@intel.com>
 <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
 <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

On Fri, Mar 22, 2024 at 02:47:02PM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Liu, Yuan1
> > Sent: Friday, March 22, 2024 10:07 AM
> > To: Peter Xu <peterx@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>; farosas@suse.de; qemu-
> > devel@nongnu.org; hao.xiang@bytedance.com; bryan.zhang@bytedance.com; Zou,
> > Nanhai <nanhai.zou@intel.com>
> > Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of
> > qpl compression
> > 
> > > -----Original Message-----
> > > From: Peter Xu <peterx@redhat.com>
> > > Sent: Thursday, March 21, 2024 11:28 PM
> > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>; farosas@suse.de; qemu-
> > > devel@nongnu.org; hao.xiang@bytedance.com; bryan.zhang@bytedance.com;
> > Zou,
> > > Nanhai <nanhai.zou@intel.com>
> > > Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization
> > of
> > > qpl compression
> > >
> > > On Thu, Mar 21, 2024 at 01:37:36AM +0000, Liu, Yuan1 wrote:
> > > > > -----Original Message-----
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > Sent: Thursday, March 21, 2024 4:32 AM
> > > > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > > > Cc: Daniel P. Berrangé <berrange@redhat.com>; farosas@suse.de; qemu-
> > > > > devel@nongnu.org; hao.xiang@bytedance.com;
> > bryan.zhang@bytedance.com;
> > > Zou,
> > > > > Nanhai <nanhai.zou@intel.com>
> > > > > Subject: Re: [PATCH v5 5/7] migration/multifd: implement
> > > initialization of
> > > > > qpl compression
> > > > >
> > > > > On Wed, Mar 20, 2024 at 04:23:01PM +0000, Liu, Yuan1 wrote:
> > > > > > let me explain here, during the decompression operation of IAA,
> > the
> > > > > > decompressed data can be directly output to the virtual address of
> > > the
> > > > > > guest memory by IAA hardware.  It can avoid copying the
> > decompressed
> > > > > data
> > > > > > to guest memory by CPU.
> > > > >
> > > > > I see.
> > > > >
> > > > > > Without -mem-prealloc, all the guest memory is not populated, and
> > > IAA
> > > > > > hardware needs to trigger I/O page fault first and then output the
> > > > > > decompressed data to the guest memory region.  Besides that, CPU
> > > page
> > > > > > faults will also trigger IOTLB flush operation when IAA devices
> > use
> > > SVM.
> > > > >
> > > > > Oh so the IAA hardware already can use CPU pgtables?  Nice..
> > > > >
> > > > > Why IOTLB flush is needed?  AFAIU we're only installing new pages,
> > the
> > > > > request can either come from a CPU access or a DMA.  In all cases
> > > there
> > > > > should have no tearing down of an old page.  Isn't an iotlb flush
> > only
> > > > > needed if a tear down happens?
> > > >
> > > > As far as I know, IAA hardware uses SVM technology to use the CPU's
> > page
> > > table
> > > > for address translation (IOMMU scalable mode directly accesses the CPU
> > > page table).
> > > > Therefore, when the CPU page table changes, the device's Invalidation
> > > operation needs
> > > > to be triggered to update the IOMMU and the device's cache.
> > > >
> > > > My current kernel version is mainline 6.2. The issue I see is as
> > > follows:
> > > > --Handle_mm_fault
> > > >  |
> > > >   -- wp_page_copy
> > >
> > > This is the CoW path.  Not usual at all..
> > >
> > > I assume this issue should only present on destination.  Then the guest
> > > pages should be the destination of such DMAs to happen, which means
> > these
> > > should be write faults, and as we see here it is, otherwise it won't
> > > trigger a CoW.
> > >
> > > However it's not clear to me why a pre-installed zero page existed.  It
> > > means someone read the guest pages first.
> > >
> > > It might be interesting to know _why_ someone reads the guest pages,
> > even
> > > if we know they're all zeros.  If we can avoid such reads then it'll be
> > a
> > > hole rather than a prefaulted read on zero page, then invalidations are
> > > not
> > > needed, and I expect that should fix the iotlb storm issue.
> > 
> > The received pages will be read for zero pages check first. Although
> > these pages are zero pages, and IAA hardware will not access them, the
> > COW happens and causes following IOTLB flush operation. As far as I know,
> > IOMMU quickly detects whether the address range has been used by the
> > device,
> > and does not invalidate the address that is not used by the device, this
> > has
> > not yet been resolved in Linux kernel 6.2. I will check the latest status
> > for
> > this.
> 
> I checked the Linux mainline 6.8 code, there are no big changes for this.
> In version 6.8, if the process needs to flush MMU TLB, then I/O TLB flush
> will be also triggered when the process has SVM devices. I haven't found
> the code to check if pages have been set EA (Extended-Accessed) bit before
> submitting invalidation operations, this is same with version 6.2.
> 
> VT-d 3.6.2
> If the Extended-Accessed-Flag-Enable (EAFE) is 1 in a scalable-mode PASID-table
> entry that references a first-stage paging-structure entry used by the remapping
> hardware, it atomically sets the EA field in that entry. Whenever EA field is 
> atomically set, the A field is also set in the same atomic operation. For software
> usages where the first-stage paging structures are shared across heterogeneous agents
> (e.g., CPUs and accelerator devices such as GPUs), the EA flag may be used by software
> to identify pages accessed by non-CPU agent(s) (as opposed to the A flag which indicates
> access by any agent sharing the paging structures).

This seems pretty new hardware features.  I didn't check in depths but what
you said makes sense.

> 
> > void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> > {
> >     for (int i = 0; i < p->zero_num; i++) {
> >         void *page = p->host + p->zero[i];
> >         if (!buffer_is_zero(page, p->page_size)) {
> >             memset(page, 0, p->page_size);
> >         }
> >     }
> > }

It may not matter much (where I also see your below comments), but just to
mention another solution to avoid this read is that we can maintain
RAMBlock->receivedmap for precopy (especially, multifd, afaiu multifd
doesn't yet update this bitmap.. even if normal precopy does), then here
instead of scanning every time, maybe we can do:

  /*
   * If it's the 1st time receiving it, no need to clear it as it must be
   * all zeros now.
   */
  if (bitmap_test(rb->receivedmap, page_offset)) {
      memset(page, 0, ...);
  } else {
      bitmap_set(rb->receivedmap, page_offset);
  }

And we also always set the bit when !zero too.
    
My rational is that it's unlikely a zero page if it's sent once or more,
while OTOH for the 1st time we receive it, it must be a zero page, so no
need to scan for the 1st round.

> > 
> > 
> > > It'll still be good we can fix this first to not make qpl special from
> > > this
> > > regard, so that the hope is migration submodule shouldn't rely on any
> > > pre-config (-mem-prealloc) on guest memory behaviors to work properly.
> > 
> > Even if the IOTLB problem can be avoided, the I/O page fault problem
> > (normal
> > pages are loaded by the IAA device and solving normal page faults through
> > IOMMU,
> > the performance is not good)

Do you have a rough estimate on how slow that could be? It'll be good to
mention some details too in the doc file in that case.

> > 
> > It can let the decompressed data of the IAA device be output to a pre-
> > populated
> > memory instead of directly outputting to the guest address, but then each
> > multifd
> > thread needs two memory copies, one copy from the network to the IAA input
> > memory(pre-populated), and another copy from the IAA output memory(pre-
> > populated)
> > to the guest address, which may become a performance bottleneck at the
> > destination
> > during the live migration process.
> >  
> > So I think it is still necessary to use the -mem-prealloc option

Right, that complexity may not be necessary, in that case, maybe such
suggestion is fine.

Thanks,

> > 
> > > >     -- mmu_notifier_invalidate_range
> > > >       |
> > > >       -- intel_invalidate_rage
> > > >         |
> > > >         -- qi_flush_piotlb
> > > >         -- qi_flush_dev_iotlb_pasid
> > >
> > > --
> > > Peter Xu
> 

-- 
Peter Xu


