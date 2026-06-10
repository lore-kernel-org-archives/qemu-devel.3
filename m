Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EF7CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQ5r-00081w-Fz; Wed, 10 Jun 2026 17:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXQ5q-00081K-Kz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXQ5o-0001Y8-Rg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781125446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8EBlXT8ZT3cbqCRoXecK6CqTgg9SqaxiG6QyZjxjFC4=;
 b=YVXLie9+O7ZRmR3Cm1DtnUC2W4VOJ098yCv4LNzwA/OyCaTZrS8LBIO2WvrA5ANExrfYL+
 8wCyJpjfahDGYVQPBdSraxTdZ2IMfRVdTeS5N6z+qUBqDdCCp8DiiVWM3EQBH0Pxuz7Mv6
 47xYb3wL0kDbrFOnTo17j9kff+Zh5Do=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-1inzzv4sPZiI252EiwE59w-1; Wed, 10 Jun 2026 17:04:05 -0400
X-MC-Unique: 1inzzv4sPZiI252EiwE59w-1
X-Mimecast-MFC-AGG-ID: 1inzzv4sPZiI252EiwE59w_1781125443
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso72111355e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781125443; x=1781730243; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8EBlXT8ZT3cbqCRoXecK6CqTgg9SqaxiG6QyZjxjFC4=;
 b=K2HJc+sj3MHPH0XSnX2hMrYZo4eSz9V5VxJ1v/frQR8VuseAsnd4VB5Ef4H2K/YTg5
 7xyi15jTSrJJ1AUkknQv9lv40KdyuA3LehdwLYPe3NMPAchhS2KflhwRLKwvouAtTRdR
 eHtUTJC68ZU5NBb/PxN2puVWZTS8WTarPgouDGnEw6iXhkAg+YIVrWMo5nDNv2JWTay+
 jD7W0YpO3o7KUxjfK23zpcEMqEqEWXL6wqP4vTv4dHIO9mJJeyWHa2HSSfSTch9UueWk
 7iX2mvZ4GORqQC3Cp4LcRRhrHDv+DgVvvLITZJDZvFxYHGh9BzigqUcHHZ4wXUc6Op3X
 IAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781125443; x=1781730243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EBlXT8ZT3cbqCRoXecK6CqTgg9SqaxiG6QyZjxjFC4=;
 b=ek4XmkTFJ/r5xN7oAWwDz6Dq0TsP2c9EknBqmikXG4DZMRC85SpDoFScZhSUeNtqd2
 +ddCQ5b6CN/EWPmLWoKDq3mFj+8Nw+Q7lNXRbskKe0e7ODuff1f1oM9okFt53skoqLld
 PD7IDL1TWaj31+RD0XNnieAAUu7R1Ze+Ng+jtSOZwtaMupEkykNWs6RrB8Y/9ZtusdY/
 Dk6AfXHm36VxSx63/EG6Rsw8Da5dA5z+ZOJJSmQoV8hmkXAt/STB0s4+5afh4QjQqXaU
 k4BE3f4yP76w+zF70m6WKkFgoxRN6trvIiBIRMVnCHeCe2Gc2gDSwlaJcYZorWrYl67Q
 tUPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V5JnaJG8tHHDQZoEKX3NxJYE4x0cJ8QcIQ1VGvQjCuwdeDO7S7mh9c5XZJHTfpNKkjACO8f8mJI3y@nongnu.org
X-Gm-Message-State: AOJu0Yz85DUNNQj1dzXppTjSDRydFTpxmxJNS54x2RqYijAF6yqsCvYR
 b/WzUIdaTTXaeuAoGyV7D5eRUauV2KO3nAOZE7EBCTaLPozECPOYGOKTJohTziSBCeDCde1KN7j
 wXULEjFri0czNW71OSL3WadDIdtN1MI+UG3Up7cqVlOoUJec5dEdZNj/C
X-Gm-Gg: Acq92OFTTMuB1aAW74OTrNisTKMSrYFrPu4c30HQbY1eOzGlfRNNFqXZ00jFbrWVhCj
 ahYI/Bau99cJl7VqVbj3TR6t/U3tkxwPCuf0sSjHVgb0+Bu8lzcN3XcltmGNzTt3MwdhTx4A9yj
 s/m10h7iH06zM3Xs28YUVxt/552lWB5BOUv57p8zQQBen8wknVR5zaTYvKFQFJzlx04OzWjPSgz
 Us3akom6zoUZdVSNCCxxmFSqTN+qYIZv6xW3vaGWknTvbtA1l6SoEexHTOqikrIqLfhi4pIHCBM
 q5RNtMiez7yysgzz4Nsm3rcwBD4z8n+FKXrg93uivkO78EINeOm3AfYdXOzqaIlDgVBqtd0cEsf
 bs2KNz+GjGqVNV47iEQB23iA6+ZRH5fwowfmo+P1/cfvQJbKPjyq6Bg==
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id
 5b1f17b1804b1-490c25e4634mr452192495e9.19.1781125443020; 
 Wed, 10 Jun 2026 14:04:03 -0700 (PDT)
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id
 5b1f17b1804b1-490c25e4634mr452192185e9.19.1781125442520; 
 Wed, 10 Jun 2026 14:04:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c84110sm13393955e9.4.2026.06.10.14.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:04:02 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:03:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610170146-mutt-send-email-mst@kernel.org>
References: <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
 <20260610121846-mutt-send-email-mst@kernel.org>
 <aim2tpHiev3iOkDE@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aim2tpHiev3iOkDE@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 10, 2026 at 03:10:46PM -0400, Peter Xu wrote:
> On Wed, Jun 10, 2026 at 12:19:39PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 05:11:40PM +0100, Peter Maydell wrote:
> > > On Wed, 10 Jun 2026 at 16:37, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > > > > This is the change that broke it I think?
> > > > >
> > > > >
> > > > > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > > > > Author: Alex Williamson <alex@shazbot.org>
> > > > > Date:   Mon Oct 31 09:53:03 2016 -0600
> > > > >
> > > > >     memory: Don't use memcpy for ram_device regions
> > > > >
> > > > >
> > > > > Maybe Alex has an opinion on what to do.
> > > >
> > > > I can offer one idea here..
> > > >
> > > > IIUC the major issue was vector ops but the mr ops might be too heavy, then
> > > > another way to fix it is in memory API instead of using memcpy()/memmove(),
> > > > we always use a helper (say, memmove_no_vector()) to do the split and
> > > > properly aligned IOs as what ram_device_mem_ops does right now, this should
> > > > only applies to ram_device.
> > > 
> > > If the underlying memory needs to be accessed only with specific
> > > alignment/size, as the 4a2e242bbb30 commit message suggests, then
> > > we cannot expose it via address_space_map(), so we must have
> > > a bounce-buffer.
> 
> I get the point; this is technically a concern, but IMHO it's still
> slightly different, and I expect it non-issue in reality.
> 
> Essentially we can have two ways to iteract with the pci bar:
> 
> 1) via vCPU / CPU access
> 2) via DMA targets
> 
> Alex can correct me, but IIUC that problem was when the CPU accesses the
> mapped region with memcpy(), rather than making that bar to be DMA target.
> Hence, use case 1) only.  So my current understanding is the proposal
> shouldn't (hopefully..) regress that realtek problem because use case 1) is
> properly covered.
> 
> I always think it is very bogus to have any register-like MMIO regions to
> be passed over, maybe it's a bug already?  It's because I don't know any
> way to guarantee DMA performs in a way that will be compatible with a pci
> bar that is register-based and will not have any side effect.  Say, if some
> pci bar (real register-backed) must be accessed in 4B and aligned, how
> would a DMA request guarantee that?
> 
> >From that perspective, IMHO it's a guest (driver or app, I'm not sure..)
> bug to make such region to be DMA target in the first place.  The outcome
> of such setup should be undefined.  It'll be the same after applying the
> proposal I raised, that QEMU will have undefined behavior for such pci bars
> to be used as DMA targets.
> 
> Thanks,

Sorry, wasting gibabytes and GB/s of main
RAM and PCI BW just to shuffle data back out the PCI bus
is out of the question.

You don't have to like it)

> > 
> > Right. And virtio currently isn't friendly to the bounce buffer.
> > We can fix that but I worry about the perf impact.
> > 
> > > The address_space_map() function says
> > > "here's a host pointer to  memory, do what you like to it", and
> > > the caller is entitled to memcpy to/from it or otherwise
> > > access it with any C operations, which are not guaranteed to
> > > respect any kind of alignment or similar restrictions.
> > > 
> > > My guess from commit 4a2e242bbb30 is that that applied an
> > > overly broad "don't do direct access" hammer to all
> > > vfio assigned devices, and that there needs to be some
> > > concept of "this vfio assigned device's region is OK for
> > > direct access" vs "this other one is not", such that if
> > > this GH100 card's BAR guarantees it can be treated entirely
> > > as RAM then we can have memory_region_supports_direct_access()
> > > return true for it.
> > > 
> > > thanks
> > > -- PMM
> > 
> 
> -- 
> Peter Xu



