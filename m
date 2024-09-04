Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2740DCD4F30
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxQK-0003QY-Ji; Wed, 04 Sep 2024 17:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slxQE-0003PO-OV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slxQA-0006tK-J2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725484809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBkeH706DtLLvCQoRJO4XUKRj81UvjEpoi6Iw+aZXss=;
 b=C3q5READgTzibmdjDaz9gs4CLv66fsXsYUwgEZWpJ1K+mtNWCtxibxyx3SuRv8nSAe6X5h
 ydr6MPQoUlzVTTZRVmLBGQhbzAEk4xqXKcHqeiwFMBfPEupoLliqZz8FPscTl9mRzoLqQr
 H1pBwwBl+KsfovNkq5B8lbjwlXIis9Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-vKhMV9Y-OGqBjxCFm4WDPw-1; Wed, 04 Sep 2024 17:20:07 -0400
X-MC-Unique: vKhMV9Y-OGqBjxCFm4WDPw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c353a05885so516616d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725484807; x=1726089607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBkeH706DtLLvCQoRJO4XUKRj81UvjEpoi6Iw+aZXss=;
 b=nPhxaowpDI1lyeegyu0Y7Q7/aOL2Re5cjGRJaEs4SBdLM30tV7GQxMJwBrHfsDde38
 kRX3CfB7p2fYDc+pZkRcIdgLU4TnrQtHSsoQoA4l+Ulc+ORiFU8MUK1ce7BLfb88Hth9
 Bvw0SAn10bEbpqPrQeimDe5rd5RcxBUl8R8ouMXEkMyt9tJw3cuexkIIgWUvK4yObUam
 vDtPyF9F2DmwTQuPvnB2Mdi9QczPyJt+6EqgUJUspVCTkEG7cPDtdNwLLokuGHM8UmfY
 4OeshC87BsjywHDqSJrxo1KlhnPsKoGCeLAztmLT5xW8u/tCzl6NPt7qs5bIqtp70k19
 jHOA==
X-Gm-Message-State: AOJu0YyNxoo/QIVcZq9GI6hYiyiKOZY9Mtw3HNT/jJQ9FtbdpJng5N2v
 sxV8sxFxmA3JMV84PaV1Iu4PpZSpiLr733dRgvYMLdOkMIvFd01hfbfHPTNi5ftajuomj11zw7V
 tNT/nobZRjhhnk33EZ1OPUkjDSyW/JklMmBVkerI9zoUOEQ5fu9jP
X-Received: by 2002:a05:6214:498e:b0:6c3:8fae:9660 with SMTP id
 6a1803df08f44-6c38fae97c8mr112712396d6.46.1725484806908; 
 Wed, 04 Sep 2024 14:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc1hj5WtPxF7nZlC+RX9Zc8Cl4x5203ND24dbD8jvsy615w0PfUJ9ccuM5bJg04HxVvmh2Kg==
X-Received: by 2002:a05:6214:498e:b0:6c3:8fae:9660 with SMTP id
 6a1803df08f44-6c38fae97c8mr112712246d6.46.1725484806477; 
 Wed, 04 Sep 2024 14:20:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5203148f8sm2004556d6.86.2024.09.04.14.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:20:05 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:20:03 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZtjPA9eCN1Ro9HFp@x1n>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 04, 2024 at 11:07:44PM +0200, David Hildenbrand wrote:
> On 04.09.24 21:16, Peter Xu wrote:
> > Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
> > was a separate discussion, however during that I found a regression of
> > dirty sync slowness when profiling.
> > 
> > Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
> > statically allocated to be the max supported by the kernel.  However after
> > Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
> > the max supported memslots reported now grows to some number large enough
> > so that it may not be wise to always statically allocate with the max
> > reported.
> > 
> > What's worse, QEMU kvm code still walks all the allocated memslots entries
> > to do any form of lookups.  It can drastically slow down all memslot
> > operations because each of such loop can run over 32K times on the new
> > kernels.
> > 
> > Fix this issue by making the memslots to be allocated dynamically.
> > 
> > Here the initial size was set to 16 because it should cover the basic VM
> > usages, so that the hope is the majority VM use case may not even need to
> > grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
> > it'll consume 9 memslots), however not too large to waste memory.
> > 
> > There can also be even better way to address this, but so far this is the
> > simplest and should be already better even than before we grow the max
> > supported memslots.  For example, in the case of above issue when VFIO was
> > attached on a 32GB system, there are only ~10 memslots used.  So it could
> > be good enough as of now.
> > 
> > In the above VFIO context, measurement shows that the precopy dirty sync
> > shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
> > to any KVM enabled VM even without VFIO.
> > 
> > Reported-by: Zhiyi Guo <zhguo@redhat.com>
> > Tested-by: Zhiyi Guo <zhguo@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> 
> 
> >   {
> >       int i;
> > -    kml->slots = g_new0(KVMSlot, s->nr_slots_max);
> >       kml->as_id = as_id;
> > -    for (i = 0; i < s->nr_slots_max; i++) {
> > -        kml->slots[i].slot = i;
> > -    }
> > +    kvm_slots_grow(kml, KVM_MEMSLOTS_NUM_ALLOC_DEFAULT);
> 
> I would just keep the static initialization here, and add the additional
> 
> 	kml->nr_slots_allocated = KVM_MEMSLOTS_NUM_ALLOC_DEFAULT;

IMHO it'll be cleaner to always allocate in the grow() so as to avoid
details on e.g. initializations of kml->slots[].slot above.

> 
> here.
> 
> Then, you can remove the parameter from kvm_slots_grow() completely and just call it
> kvm_slots_double() and simplify a bit:
> 
> static bool kvm_slots_double(KVMMemoryListener *kml)
> {
>     unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
>     KVMSlot *slots;
> 
>     nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
>     if (nr_slots_new == kvm_state->nr_slots_max) {
>         /* We reached the maximum */
> 	return false;
>     }
> 
>     assert(kml->slots);
>     slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
>     /*
>      * g_renew() doesn't initialize extended buffers, however kvm
>      * memslots require fields to be zero-initialized. E.g. pointers,
>      * memory_size field, etc.
>      */
>     memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
> 
>     for (i = cur; i < nr_slots_new; i++) {
>         slots[i].slot = i;
>     }
> 
>     kml->slots = slots;
>     kml->nr_slots_allocated = nr_slots_new;
>     trace_kvm_slots_grow(cur, nr_slots_new);
> 
>     return true;
> }

Personally I still think it cleaner to allow setting whatever size.

We only have one place growing so far, which is pretty trivial to double
there, IMO.  I'll wait for a second opinion, or let me know if you have
strong feelings..

> 
> 
> Apart from that looks sane. On the slot freeing/allocation path, there is certainly
> more optimization potential :)
> 
> I'm surprised this 32k loop wasn't found earlier.

Yes, it's in the range where it isn't too big to be discovered I guess, but
large enough to affect many things, so better fix it sooner than later.

This reminded me we should probably copy stable for this patch.  I think it
means I'll try to move this patch to the 1st patch to make Michael's life
and downstream easier.

-- 
Peter Xu


