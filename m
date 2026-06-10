Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B96FCD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQl0-0002rO-TQ; Wed, 10 Jun 2026 17:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXQjU-0002Y4-Tb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXQjS-0006lk-RM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781127905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+VwT6K+h1UU5mBosQ2pzNZ+g+ZPuQv0L8tsjGrWpLMY=;
 b=iDNX/FHamHak6qsaB0os+JfQuYNFhqOpnZqor04y+ytZe/l6zpqr1ThYqiqFQCIHG6bbeW
 GQIHAySDsSLMTc2WlpIlbHSSm9WE7jc3Ei7Aoa7eeP+S/478uEiTznVboqVJG2I25TeZPA
 DZODxDH3eN/YRCmkBC5+96jDhcHFgYo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-1V9Og1GPMByx-IPiYqMofg-1; Wed, 10 Jun 2026 17:45:04 -0400
X-MC-Unique: 1V9Og1GPMByx-IPiYqMofg-1
X-Mimecast-MFC-AGG-ID: 1V9Og1GPMByx-IPiYqMofg_1781127903
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46011aa5000so3189159f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781127903; x=1781732703; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+VwT6K+h1UU5mBosQ2pzNZ+g+ZPuQv0L8tsjGrWpLMY=;
 b=MGae1T/B3EzhbcGFmtF+ejuutoGV7t4KxTuFQdX0+kTRms07e7fXi8Lm01o/crjfUc
 Veg4OZxu0lK+ept4ToK8LVih9einQXJUr3vKcTLHFdLdA+3fsYx7F13wo2eAQAQcn/BY
 FhJOSt1LIKAN8yglSvaqp+OcPhb3m7sKvbgtIR1hkZIrRMGXz3c6s9lYMWPWLAnE20Q6
 /2q4YlG2u2F753es76ZV6o3A9+3qwTY9JB2OHJ+/JGRt3Vzi5ixHEpeJxuYndjEm8XFi
 dMRJtMm2Qa9zIbflNyqTg0C5imfalAKgxWEcYOwTfAiZeEA1o2zvyFbvo2Lgi5mBZpRg
 rTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127903; x=1781732703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VwT6K+h1UU5mBosQ2pzNZ+g+ZPuQv0L8tsjGrWpLMY=;
 b=lLP+l1oSeQ/86gDsEQqVyeKk0fESme98fl2lpOsSHd9VCRRHhrdk2QqMHF/PoLUzpA
 6UODgICmsbu3A6uKL7fjZYqCHduzZeQNnsap6yohuDmulXSSVCuww4K+ihy52Ek4ZNPh
 DCs5tnmoDMP4xs01K+99WEFKWTF7x2h1RbCZUR6CQxEAy8GLQZ5CabBFcSW4jbKfmBQr
 9Jhed3V2AzDDfAbcG4PqpSw9wsDDCut8nJeuAKlEMAe2lUTNjlHO4hehmMK67D/2kjrC
 qETdAglb3EqrII1L/HVCdVZgFRQJHQ5/6lk4jrSHAbj0e8qjy+iRebMKCKwbRozB9Lqe
 MuWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Va9EBAbZTd2A/itYAOWS7GzVDeRZ4otQuQO1xpMYeWR5TOqvdqD5W/wjCRzdUCtxRTO/3tbGoE/HI@nongnu.org
X-Gm-Message-State: AOJu0YxIxLSbFO+Lr228f6tNoKh6Rc4uJq+2ga8eWEefzOKRCgCkESV8
 TiozyOq3cZeCJ5p49cx/b9rI1+5IohR2nul4qEXE5HwvNNoz9HZBnwuM9FY2czHtCFdomkUnCwR
 NQCFoA6sJVhOQAbbrSXcJndlkv2hKx6ww0Km4KGh+LE346BkUy38GBPCW
X-Gm-Gg: Acq92OHLZWUQ687R8IKnQ9LpBPXFH/z9dUgKVOF9WFW+TPvKM7gf3lk0ZDsR36KuGkA
 lkK24NnM5UWX24lRlcAv+q+wj4KsE/9RlQhlm4tEue65YgNgWTv7D13LaITMedgUO9b3PlM2gnB
 ToBuS3mQDXU42Hyu6ivc8JbGmvAahiHplLE9gNvG5HhjtQXZqFajMyBYs904XLxNnAHR9P2Y82H
 1/UiBuncCujOX/o6s/TOXX/QBtADqow1AeJfzs2isQcgggmSbBdKBykQryzNnFHqiuwCprJjBm1
 UKUn1PmpiWDFpTMRiKKcFSVY87aySaWLWFJdR1pVeHrqQZ+fDu9lD5ygM8V+r8c6vuRueTMqGdf
 KD1r/i7DJQOcJp++6nPidzDW/qadYF4Mb1jJWZemlACAQNjyKduEPNQ==
X-Received: by 2002:a05:600c:1c1f:b0:490:b724:dbd6 with SMTP id
 5b1f17b1804b1-490c2598382mr420257385e9.6.1781127902997; 
 Wed, 10 Jun 2026 14:45:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1f:b0:490:b724:dbd6 with SMTP id
 5b1f17b1804b1-490c2598382mr420257085e9.6.1781127902471; 
 Wed, 10 Jun 2026 14:45:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm58612759f8f.14.2026.06.10.14.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:45:01 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:44:58 -0400
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
Message-ID: <20260610174052-mutt-send-email-mst@kernel.org>
References: <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
 <20260610121846-mutt-send-email-mst@kernel.org>
 <aim2tpHiev3iOkDE@x1.local>
 <20260610170146-mutt-send-email-mst@kernel.org>
 <ainWw13-_TfX_vln@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainWw13-_TfX_vln@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 10, 2026 at 05:27:31PM -0400, Peter Xu wrote:
> On Wed, Jun 10, 2026 at 05:03:59PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 03:10:46PM -0400, Peter Xu wrote:
> > > On Wed, Jun 10, 2026 at 12:19:39PM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 10, 2026 at 05:11:40PM +0100, Peter Maydell wrote:
> > > > > On Wed, 10 Jun 2026 at 16:37, Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > > > > > > This is the change that broke it I think?
> > > > > > >
> > > > > > >
> > > > > > > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > > > > > > Author: Alex Williamson <alex@shazbot.org>
> > > > > > > Date:   Mon Oct 31 09:53:03 2016 -0600
> > > > > > >
> > > > > > >     memory: Don't use memcpy for ram_device regions
> > > > > > >
> > > > > > >
> > > > > > > Maybe Alex has an opinion on what to do.
> > > > > >
> > > > > > I can offer one idea here..
> > > > > >
> > > > > > IIUC the major issue was vector ops but the mr ops might be too heavy, then
> > > > > > another way to fix it is in memory API instead of using memcpy()/memmove(),
> > > > > > we always use a helper (say, memmove_no_vector()) to do the split and
> > > > > > properly aligned IOs as what ram_device_mem_ops does right now, this should
> > > > > > only applies to ram_device.
> > > > > 
> > > > > If the underlying memory needs to be accessed only with specific
> > > > > alignment/size, as the 4a2e242bbb30 commit message suggests, then
> > > > > we cannot expose it via address_space_map(), so we must have
> > > > > a bounce-buffer.
> > > 
> > > I get the point; this is technically a concern, but IMHO it's still
> > > slightly different, and I expect it non-issue in reality.
> > > 
> > > Essentially we can have two ways to iteract with the pci bar:
> > > 
> > > 1) via vCPU / CPU access
> > > 2) via DMA targets
> > > 
> > > Alex can correct me, but IIUC that problem was when the CPU accesses the
> > > mapped region with memcpy(), rather than making that bar to be DMA target.
> > > Hence, use case 1) only.  So my current understanding is the proposal
> > > shouldn't (hopefully..) regress that realtek problem because use case 1) is
> > > properly covered.
> > > 
> > > I always think it is very bogus to have any register-like MMIO regions to
> > > be passed over, maybe it's a bug already?  It's because I don't know any
> > > way to guarantee DMA performs in a way that will be compatible with a pci
> > > bar that is register-based and will not have any side effect.  Say, if some
> > > pci bar (real register-backed) must be accessed in 4B and aligned, how
> > > would a DMA request guarantee that?
> > > 
> > > >From that perspective, IMHO it's a guest (driver or app, I'm not sure..)
> > > bug to make such region to be DMA target in the first place.  The outcome
> > > of such setup should be undefined.  It'll be the same after applying the
> > > proposal I raised, that QEMU will have undefined behavior for such pci bars
> > > to be used as DMA targets.
> > > 
> > > Thanks,
> > 
> > Sorry, wasting gibabytes and GB/s of main
> > RAM and PCI BW just to shuffle data back out the PCI bus
> > is out of the question.
> > 
> > You don't have to like it)
> 
> I'm not sure if my previous comment wasn't clear, but just to make sure it
> is..
> 
> The proposal was exactly about making ram_device to be directly accessible
> by default.  That is, make memory_region_supports_direct_access() return
> true for ram_device like before, however when doing direct access from
> QEMU, QEMU should use memmove_no_vector() version instead of memcpy().
> 
> We leave DMA maps like virtio-blk to be directly accessible without
> auditing device emulations using memcpy() or not: then QEMU faces the same
> risk to bare metal where MMIO regions used for DMA buffers, then it's
> undefined behavior.
> 
> In case of GPU bar mapping, it should then work like RAM for virtio-blk.
> 
> Thanks,

Ah, I get it. not sure we need memmove_no_vector even, we can keep
the bounce buffer thing if we want.

> > 
> > > > 
> > > > Right. And virtio currently isn't friendly to the bounce buffer.
> > > > We can fix that but I worry about the perf impact.
> > > > 
> > > > > The address_space_map() function says
> > > > > "here's a host pointer to  memory, do what you like to it", and
> > > > > the caller is entitled to memcpy to/from it or otherwise
> > > > > access it with any C operations, which are not guaranteed to
> > > > > respect any kind of alignment or similar restrictions.
> > > > > 
> > > > > My guess from commit 4a2e242bbb30 is that that applied an
> > > > > overly broad "don't do direct access" hammer to all
> > > > > vfio assigned devices, and that there needs to be some
> > > > > concept of "this vfio assigned device's region is OK for
> > > > > direct access" vs "this other one is not", such that if
> > > > > this GH100 card's BAR guarantees it can be treated entirely
> > > > > as RAM then we can have memory_region_supports_direct_access()
> > > > > return true for it.
> > > > > 
> > > > > thanks
> > > > > -- PMM
> > > > 
> > > 
> > > -- 
> > > Peter Xu
> > 
> > 
> 
> -- 
> Peter Xu


