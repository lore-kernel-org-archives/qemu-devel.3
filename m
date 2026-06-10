Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C81CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQSc-00028r-Tr; Wed, 10 Jun 2026 17:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXQSa-00028G-Ka
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXQSY-0005KA-H4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oktp8Pas9YaCpF/tWy9A6ZVZtdsYSHYanoVUwn0XCnM=;
 b=KXYqNYJlELwxOzMaflWHcXwrDSV7IZW5eQJRP3oQMKTwr7yPlxogBH6gkOeMaKLcrSBF32
 uj4Ye3VRswT0TB1yzA4D9uw8LMaJRNBSdHE/guKLH+LXvUaaJ793qlgNY3h5AsleB/UjPO
 wvAacan7R9+XPAJEP6WKkwg6AoUm23Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-SmV7mEYdPSews-dHi_M7Bw-1; Wed, 10 Jun 2026 17:27:36 -0400
X-MC-Unique: SmV7mEYdPSews-dHi_M7Bw-1
X-Mimecast-MFC-AGG-ID: SmV7mEYdPSews-dHi_M7Bw_1781126855
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157c8eb597so1076677285a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781126855; x=1781731655; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oktp8Pas9YaCpF/tWy9A6ZVZtdsYSHYanoVUwn0XCnM=;
 b=LvKwLZnvsuc7vFgSG+7dw9JT4pCr6qr1sVQ9o5P8YsVJDzAh2/ll6NPieRgEhcp+xg
 jmlDMo9xdpC2g3rotsiuLE3Fuju7LkuB9PFObe27S8MH6ODcXlQBmgjWJ4UhxwODgeEE
 GmYl6ICzl6q7w/cFclnhi7e9MQbX4i32uB8IQ526AmvdoaZtHyU9eZ36ikIeqOQHToyC
 cGUGVztN5qeXQvKg8d8TTlsfb/ay+9Yqt+JBr3fcuIcLeH9muZ+CUzJqk5zEFSnENwtO
 iQpVQMnfkol+kX+bqO2dH9qNRHhmgVQKasXIwZSrssPH9IHNDEJ9EHrpQ7MG4ra347WE
 yxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126855; x=1781731655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oktp8Pas9YaCpF/tWy9A6ZVZtdsYSHYanoVUwn0XCnM=;
 b=NaIAIzSra08SzZIj3padI4i9TBbIbAYWvffeaUt6Sk0Bfa9KcjWZoL910wkFDmF2e1
 DmEC7QRkUzNd+zFc81A42+o6CkcLM9szkqR1BI/lpz6p4scDdKwcJgspvoMJL5vwlQp/
 l1ERR45VxcAicXuKXjFyfRQY4nGZ5jy0FTdR8qfQrWuC01meYewTe9MZjFGTsd3oTY3K
 HgG0lewmZCeynXJ/OIhyUlY9jCU7Q4rO8iiSrhyL3Km4YpWbXQBavUjtJdiL70p9pusD
 5zb5VhpfTuj7NXfOiiG3BIwWhQVQFuppv+IBlLdpQ7K3PUG+OfImW676fNoR2R/NErSt
 SnGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ82k2anQ2D2A56SAJxpWtGE4LuniuG0ItiToUMBZVAqPsMtPcjcvu1AK5xSVmu5ZBTWZ6cypwXz4oNc@nongnu.org
X-Gm-Message-State: AOJu0YwzNCDL+wfODkHG2qoSOZ9WnUeMD6vtn8IpPnd8Mmw/OwqYJ1sj
 Z1aGVfWXLQkF7vZd3hVjS6dU4FujDpc5UmJ0GHPPbuhjAD3mugEwOohuuvyLsZ24Jgt0OkRxJEM
 +pYnjgFcx7npccnFxgjbIoblfchqnLYWFwyrn9TDlWLAUNO99ZYv2XQGE
X-Gm-Gg: Acq92OEFscmOt7Y28eH1BRWPyWoLFoiXQjto8b2N5NuTimPRe9Mw4a86DC8u6wtHnl3
 j+VISIlf9c6xoCiOQ2vVqpPI+qYZSOAelwThP0tHovE94aIp/KxKap+kEfABP+sgZ+6zH2j8pXk
 QfAPRMDs8zSsMZmpgxZexMEB4L43DhQp337uGxBfcQr6ElzYe8lk90My30nPll1nTpt3Fp3DvTh
 HWGdnZI/Qv2OpWvee6fE5be12tjbGnaJTN7VicTGTgAdUu6uV97EXPxlq64ObCl2fa9HlmhXShu
 ffnzJPsi9hx/HzD2lrQAruxJ0YQBJFUeBSlRkR95y35i6hteXRJfqiknZPEAU4Rr9ROu+76hiJ7
 258xsia+bzgYs3jCIxx3BTFikag==
X-Received: by 2002:a05:620a:690d:b0:915:a457:bf94 with SMTP id
 af79cd13be357-915a9da93f1mr4540586185a.48.1781126855171; 
 Wed, 10 Jun 2026 14:27:35 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:915:a457:bf94 with SMTP id
 af79cd13be357-915a9da93f1mr4540580085a.48.1781126854600; 
 Wed, 10 Jun 2026 14:27:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9159cd628f8sm2219398585a.4.2026.06.10.14.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:27:33 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:27:31 -0400
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
Message-ID: <ainWw13-_TfX_vln@x1.local>
References: <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
 <20260610121846-mutt-send-email-mst@kernel.org>
 <aim2tpHiev3iOkDE@x1.local>
 <20260610170146-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610170146-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 10, 2026 at 05:03:59PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 03:10:46PM -0400, Peter Xu wrote:
> > On Wed, Jun 10, 2026 at 12:19:39PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jun 10, 2026 at 05:11:40PM +0100, Peter Maydell wrote:
> > > > On Wed, 10 Jun 2026 at 16:37, Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > > > > > This is the change that broke it I think?
> > > > > >
> > > > > >
> > > > > > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > > > > > Author: Alex Williamson <alex@shazbot.org>
> > > > > > Date:   Mon Oct 31 09:53:03 2016 -0600
> > > > > >
> > > > > >     memory: Don't use memcpy for ram_device regions
> > > > > >
> > > > > >
> > > > > > Maybe Alex has an opinion on what to do.
> > > > >
> > > > > I can offer one idea here..
> > > > >
> > > > > IIUC the major issue was vector ops but the mr ops might be too heavy, then
> > > > > another way to fix it is in memory API instead of using memcpy()/memmove(),
> > > > > we always use a helper (say, memmove_no_vector()) to do the split and
> > > > > properly aligned IOs as what ram_device_mem_ops does right now, this should
> > > > > only applies to ram_device.
> > > > 
> > > > If the underlying memory needs to be accessed only with specific
> > > > alignment/size, as the 4a2e242bbb30 commit message suggests, then
> > > > we cannot expose it via address_space_map(), so we must have
> > > > a bounce-buffer.
> > 
> > I get the point; this is technically a concern, but IMHO it's still
> > slightly different, and I expect it non-issue in reality.
> > 
> > Essentially we can have two ways to iteract with the pci bar:
> > 
> > 1) via vCPU / CPU access
> > 2) via DMA targets
> > 
> > Alex can correct me, but IIUC that problem was when the CPU accesses the
> > mapped region with memcpy(), rather than making that bar to be DMA target.
> > Hence, use case 1) only.  So my current understanding is the proposal
> > shouldn't (hopefully..) regress that realtek problem because use case 1) is
> > properly covered.
> > 
> > I always think it is very bogus to have any register-like MMIO regions to
> > be passed over, maybe it's a bug already?  It's because I don't know any
> > way to guarantee DMA performs in a way that will be compatible with a pci
> > bar that is register-based and will not have any side effect.  Say, if some
> > pci bar (real register-backed) must be accessed in 4B and aligned, how
> > would a DMA request guarantee that?
> > 
> > >From that perspective, IMHO it's a guest (driver or app, I'm not sure..)
> > bug to make such region to be DMA target in the first place.  The outcome
> > of such setup should be undefined.  It'll be the same after applying the
> > proposal I raised, that QEMU will have undefined behavior for such pci bars
> > to be used as DMA targets.
> > 
> > Thanks,
> 
> Sorry, wasting gibabytes and GB/s of main
> RAM and PCI BW just to shuffle data back out the PCI bus
> is out of the question.
> 
> You don't have to like it)

I'm not sure if my previous comment wasn't clear, but just to make sure it
is..

The proposal was exactly about making ram_device to be directly accessible
by default.  That is, make memory_region_supports_direct_access() return
true for ram_device like before, however when doing direct access from
QEMU, QEMU should use memmove_no_vector() version instead of memcpy().

We leave DMA maps like virtio-blk to be directly accessible without
auditing device emulations using memcpy() or not: then QEMU faces the same
risk to bare metal where MMIO regions used for DMA buffers, then it's
undefined behavior.

In case of GPU bar mapping, it should then work like RAM for virtio-blk.

Thanks,

> 
> > > 
> > > Right. And virtio currently isn't friendly to the bounce buffer.
> > > We can fix that but I worry about the perf impact.
> > > 
> > > > The address_space_map() function says
> > > > "here's a host pointer to  memory, do what you like to it", and
> > > > the caller is entitled to memcpy to/from it or otherwise
> > > > access it with any C operations, which are not guaranteed to
> > > > respect any kind of alignment or similar restrictions.
> > > > 
> > > > My guess from commit 4a2e242bbb30 is that that applied an
> > > > overly broad "don't do direct access" hammer to all
> > > > vfio assigned devices, and that there needs to be some
> > > > concept of "this vfio assigned device's region is OK for
> > > > direct access" vs "this other one is not", such that if
> > > > this GH100 card's BAR guarantees it can be treated entirely
> > > > as RAM then we can have memory_region_supports_direct_access()
> > > > return true for it.
> > > > 
> > > > thanks
> > > > -- PMM
> > > 
> > 
> > -- 
> > Peter Xu
> 
> 

-- 
Peter Xu


