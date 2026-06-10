Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E93CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOKH-0000Ev-Kh; Wed, 10 Jun 2026 15:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXOKG-0000EG-Eo
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXOKE-0002yC-JG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781118651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dbZuCAR3Qw3b3+uFels71RaLeXUJjBvUUefXt7mDflE=;
 b=cHZ71ytqEtEkF3AXQjjvfOmjs7+j1LGm2RocfTWpXI2tbzqPIH5OsNl+VuH3NLLYKFMYM0
 yFslTKOtqZnOh1fF87dzgWQVcnVMeQ2qZ5HRr+7AeICjm83wXK7O0frrtD8p9GiYjBl+Hv
 ghGiJOsGjGdzg+MUdPjzK4D5xfwIPQk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-ePghZlWhMNaqsafB55ySug-1; Wed, 10 Jun 2026 15:10:49 -0400
X-MC-Unique: ePghZlWhMNaqsafB55ySug-1
X-Mimecast-MFC-AGG-ID: ePghZlWhMNaqsafB55ySug_1781118649
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517d766e05aso4189691cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781118649; x=1781723449; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dbZuCAR3Qw3b3+uFels71RaLeXUJjBvUUefXt7mDflE=;
 b=qrbThSnsbjp0ty6MrxlQicfroJ22qVOyLRDTxuejmq67YDlIGKGPDDO/IvEB5aDHwx
 5tH/8uPDE2TDKdZVqvqD4F6UpNtmFXpAQAZ9qgru93E4OkSzwoGCKwaGM8nR26Gc1rsu
 iXbDihivyLkKvLrCczLIZ/JpmgujmLHe34RV1oxzyRrEwyojoXfV3lv0T5C+p03EtP1J
 MhD16/Aq+CDrcpUOmQtUthgkB4HKmJD3ZW6g0WrEYrVp84pgEZ7dZ20LCk7kMoTiGyrn
 S1+fug3z54dGd44Wloznpme3FoxPanM8/n/oR6twOPN+HmhR9At8ZIq5kL4R0aFpHoZ0
 Afeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781118649; x=1781723449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbZuCAR3Qw3b3+uFels71RaLeXUJjBvUUefXt7mDflE=;
 b=MNVNaCKKywROUi5W99RQiA1qkwnCqUxi5vGIKf0T8WI4tszrs+kWhOnHKkaZ1aXJvC
 PEyjDni6umI6YlUF8eYvnmzpPFsx2DTrfjgq89hsR7b0aSqywIPYGXTJ68wZ4JYONboP
 ElUrQMAB147YMbElX5/3o3nz3feGdk5L7OuZLfMQLGOA/zaa6qamU7cWjd0jZQqxTAsp
 XVWo4hplHeGeBjmVcmkznH8O9OUvEyNeaxAUDn7bpC+dScr4WSyzjOoWKHq3VpJkEyCI
 GLhNkEh4ee5bbnX7JVoqN2IIF5U4sLgvMK/5pPsRZE2vowAH3XsEGxNFEdWLSY5oLtK0
 ogrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/pWY8tDzIqxpnfWtf5eONi/zeHUPrMbrMLNWqVs/+/cgljCjVBm7JePrAiBKE3vro5L4PmJxU8tgc@nongnu.org
X-Gm-Message-State: AOJu0YxIU/r0ejgJxx9DoWN6eocyhs1DgKuFwVu+POqOk8/stH2FmJcx
 Vdmg9JtXhFJ9dvvXEIUdfBdGGcTneLWzm0Y9JpobeCWyjqCljgdHTyCDnETHzYcBl4DfwZec9fC
 tYjgvwyDkpn4g3g9T4tHJ07+ganI/+4NLFZAy6WKfe8NpGIfkEmXCrxj4
X-Gm-Gg: Acq92OHq7h4r/zXkffJx79+6ZJUIg72sf4Xyt1+7GncpvBLDr/Bmbj/4zv2cUeNiQqZ
 IuwSHHPBC2aPQwJpmyOEMtvh3waiXAhC2ZBLHSz5g7jdzaKTN7bkxuafJj2HOUA4GbkuyeHWulb
 91pzbu5knMuh2CoDEDa4c4XIM0r0sN6IQgkCUiZVTq3X50/mg71Cy0LtHYSkxe8UGINFWcSbRRS
 +BO3wD8qAphvO2rWdfG+7Qbcw6iMS+g6ff7RkslZwvI6yfxxN33YLeEgl+q23EBc3XpAYHHZ1uH
 aWCpawSlyvGlKX5eTEmfaqD3QafGSgvru+y5NhfTS6WZiKfZnVsl2WiF6vSvzPSzkaZ/vY8+dno
 KaZeOf7eM5yQ2Ufmkjr8m7aRKMA==
X-Received: by 2002:a05:622a:4010:b0:516:dc75:1aca with SMTP id
 d75a77b69052e-517987df360mr280200401cf.26.1781118649103; 
 Wed, 10 Jun 2026 12:10:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4010:b0:516:dc75:1aca with SMTP id
 d75a77b69052e-517987df360mr280199731cf.26.1781118648633; 
 Wed, 10 Jun 2026 12:10:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775dbd2c9sm228149321cf.23.2026.06.10.12.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:10:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:10:46 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aim2tpHiev3iOkDE@x1.local>
References: <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
 <20260610121846-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610121846-mutt-send-email-mst@kernel.org>
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

On Wed, Jun 10, 2026 at 12:19:39PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 05:11:40PM +0100, Peter Maydell wrote:
> > On Wed, 10 Jun 2026 at 16:37, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > > > This is the change that broke it I think?
> > > >
> > > >
> > > > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > > > Author: Alex Williamson <alex@shazbot.org>
> > > > Date:   Mon Oct 31 09:53:03 2016 -0600
> > > >
> > > >     memory: Don't use memcpy for ram_device regions
> > > >
> > > >
> > > > Maybe Alex has an opinion on what to do.
> > >
> > > I can offer one idea here..
> > >
> > > IIUC the major issue was vector ops but the mr ops might be too heavy, then
> > > another way to fix it is in memory API instead of using memcpy()/memmove(),
> > > we always use a helper (say, memmove_no_vector()) to do the split and
> > > properly aligned IOs as what ram_device_mem_ops does right now, this should
> > > only applies to ram_device.
> > 
> > If the underlying memory needs to be accessed only with specific
> > alignment/size, as the 4a2e242bbb30 commit message suggests, then
> > we cannot expose it via address_space_map(), so we must have
> > a bounce-buffer.

I get the point; this is technically a concern, but IMHO it's still
slightly different, and I expect it non-issue in reality.

Essentially we can have two ways to iteract with the pci bar:

1) via vCPU / CPU access
2) via DMA targets

Alex can correct me, but IIUC that problem was when the CPU accesses the
mapped region with memcpy(), rather than making that bar to be DMA target.
Hence, use case 1) only.  So my current understanding is the proposal
shouldn't (hopefully..) regress that realtek problem because use case 1) is
properly covered.

I always think it is very bogus to have any register-like MMIO regions to
be passed over, maybe it's a bug already?  It's because I don't know any
way to guarantee DMA performs in a way that will be compatible with a pci
bar that is register-based and will not have any side effect.  Say, if some
pci bar (real register-backed) must be accessed in 4B and aligned, how
would a DMA request guarantee that?

From that perspective, IMHO it's a guest (driver or app, I'm not sure..)
bug to make such region to be DMA target in the first place.  The outcome
of such setup should be undefined.  It'll be the same after applying the
proposal I raised, that QEMU will have undefined behavior for such pci bars
to be used as DMA targets.

Thanks,

> 
> Right. And virtio currently isn't friendly to the bounce buffer.
> We can fix that but I worry about the perf impact.
> 
> > The address_space_map() function says
> > "here's a host pointer to  memory, do what you like to it", and
> > the caller is entitled to memcpy to/from it or otherwise
> > access it with any C operations, which are not guaranteed to
> > respect any kind of alignment or similar restrictions.
> > 
> > My guess from commit 4a2e242bbb30 is that that applied an
> > overly broad "don't do direct access" hammer to all
> > vfio assigned devices, and that there needs to be some
> > concept of "this vfio assigned device's region is OK for
> > direct access" vs "this other one is not", such that if
> > this GH100 card's BAR guarantees it can be treated entirely
> > as RAM then we can have memory_region_supports_direct_access()
> > return true for it.
> > 
> > thanks
> > -- PMM
> 

-- 
Peter Xu


