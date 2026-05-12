Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA6BCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 23:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMwH7-0005Px-CC; Tue, 12 May 2026 19:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMwH1-0005Na-Dc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 19:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMwGs-0006LM-G0
 for qemu-devel@nongnu.org; Tue, 12 May 2026 19:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778627531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YasJDCzxfNBcrakQ0lPIeppZdyED0d1agrLsSyUi29A=;
 b=bsbDpKH0ZCLUcOK7Ac0tx0KFXj2TZxoQnYKV9JtW+r68P4qHUgITlymtu1LOaj6/k43BZj
 eJ4Poji1VSF+10uO38cL39U1lRgb5HrDB60d5JeqsMqzkJxEoyhPEdnXlusaz3BcPT+fWG
 1lKglkw1hx55+lNmjs0GOlHYg9udCA8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-rkc0a66nMH62niTp-CIzeg-1; Tue, 12 May 2026 19:12:10 -0400
X-MC-Unique: rkc0a66nMH62niTp-CIzeg-1
X-Mimecast-MFC-AGG-ID: rkc0a66nMH62niTp-CIzeg_1778627529
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso5510141f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778627529; x=1779232329; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YasJDCzxfNBcrakQ0lPIeppZdyED0d1agrLsSyUi29A=;
 b=lIF26/2HyHecKkHE6Rv1lMSdNZZUdeIuS97cXngdAkLrQ+UOfz/KqWo2AcWhi2qb9s
 vjfEXUHe9HaztZ6AANQCgtAm+ff3bIytdch8UWLzIkh/+PHP3XZ1BSrwhb84Nk4m3k3G
 p6z92hEHVL1OoJtirMT5T37g9JjvBT6LbzuekvSuqW1c3kaJZUtHdRaUe6aPVgy6K7er
 jb71m6gCP1jWHV7Vc63DLkncdggMyRBk25H2loVHaLMbbN2TSgdMe8gjDwzFkOylLCoM
 XuLnnf6rMh5nXA5S+fwEaqvkBPSucuppd2120DtjCC9vn3igSyMrOhoH4Vh8BpP5cNmM
 m7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778627529; x=1779232329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YasJDCzxfNBcrakQ0lPIeppZdyED0d1agrLsSyUi29A=;
 b=JSLTVTiA//0ucpps7byWE0CbuiuBhB5nACGWThXm+xGMkaE8VaJaeGFc7fE3UdDT5h
 +GvAroSwEQh4s8QaCxiis0gZO8xx5dw2AUxLPi/OtAbujsdVjBy6KLDkcY3AoGJYYfUJ
 M9fakp1PGSly/eptf6dGkh4x6s8NH5/Dj6xtonI/BhYcJUuTjg00x534IMEoZvLQoLqa
 U/2LxV4aaZTkkaJVxCoys6LI6P19+6WVqiaghpC5ERh4H/d7I41d0c0Fj+si09jevOv9
 I7PauevFhyKREM7m2PFQNboYA5XV8rfx6ya9YVtaLf4jzwHd8qA/COgGf9DGOOgayIWD
 0kRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y2H4sg/Fpnve0YR15UQuZk5DBVbxI7fZPxsIV/xN2wrLMAKJJCm8LMwNE688PGuoLMCoo9PMDC/gL@nongnu.org
X-Gm-Message-State: AOJu0YyruAPejWdFu6Fw8bC5TLcSKNKrb2JrMBhtjnKz+CyAlW2xdj03
 IhyDJv6bX6Qwf1sPWSCbmxE4Hs5U8bcI6k3oM2SzLU9ZMQnZF6z+cZk8OFe4/Wg4VYs3cJ0ykmy
 afUWzAVFDgJ7ipTNSRAE7rmNYafqYkY4qy6SxTJXa2It43wC5mBepGm/A
X-Gm-Gg: Acq92OE9ABzs5vE4oZJB9D8gaodMFfZM+rOesh6EF+WO+bpTHguur7ew27hOZymxWqm
 S7as6sGeqjYIc4rQ+34RYR3CLoYZaLSv89NShn86pOIgODa7q3fD+jh8ERe/4kAPsCGZxV/VXtQ
 RtKbLWyD+VW0AELqTML8B7iVI+AZ2qeYVYuovto26QOIQYG+nrShSmklKoI/KmfNGQ7tO5taOkQ
 RlcU6e+JfXDs+7aZEytyamOWCn5CW+PioGHsSFzcQG7KPbj3ZwGRu0SXl3hHszO47Mi/T56zpmY
 KG56W8tVGj6GVz0vg48bsInEvHyxWHIMT3duDy4RqnXxh4VQ2ihRDhJTMKKSgJh5afljT7j+zTB
 Gby9fcwzi8Fgv2avxZzXSIS5M/olCVed6Sm1DvQ6G
X-Received: by 2002:a05:6000:4028:b0:449:a07a:9676 with SMTP id
 ffacd0b85a97d-45c5a68a7d6mr960267f8f.29.1778627529070; 
 Tue, 12 May 2026 16:12:09 -0700 (PDT)
X-Received: by 2002:a05:6000:4028:b0:449:a07a:9676 with SMTP id
 ffacd0b85a97d-45c5a68a7d6mr960237f8f.29.1778627528615; 
 Tue, 12 May 2026 16:12:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549130549bsm36930151f8f.18.2026.05.12.16.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 16:12:07 -0700 (PDT)
Date: Tue, 12 May 2026 19:12:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Tushar Dave <tdave@nvidia.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 qemu-devel@nongnu.org, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI
 pre-enumeration and fixed BAR allocation
Message-ID: <20260512191140-mutt-send-email-mst@kernel.org>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
 <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
 <20260512170650.4551c9f6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512170650.4551c9f6@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, May 12, 2026 at 05:06:50PM -0600, Alex Williamson wrote:
> On Tue, 12 May 2026 12:25:45 -0500
> Tushar Dave <tdave@nvidia.com> wrote:
> 
> > On 5/11/2026 6:43 AM, Ard Biesheuvel wrote:
> > > Hello Tushar,
> > > 
> > > On Fri, 8 May 2026, at 20:37, Tushar Dave via groups.io wrote:  
> > >> This RFC introduces a mechanism to specify Guest Physical Addresses
> > >> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> > >> addresses to match host physical addresses for assigned devices.
> > >>
> > >> On some platforms, P2P DMA is performed between devices within the same
> > >> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> > >> without going through the host bridge in order to achieve the required
> > >> performance.
> > >>
> > >> To support this multi-device IOMMU group P2P scenario in virtualization,
> > >> the VM may need to use the same MMIO BAR addresses as the host physical
> > >> address layout.
> > >>  
> > > 
> > > Did you consider implementing this using Enhanced Allocation (EA)? If so,
> > > could you explain why it is not suitable here?  
> > 
> > I have not evaluated EA for this design. When I looked at EDK2, I
> > chose PcdPciDisableBusEnumeration because it cleanly preserves fixed
> > BAR programming established by the hypervisor — at the cost of QEMU
> > performing PCI bus number and resource assignment.
> > 
> > I did a quick search and do not see EA support in EDK2. Any pointers
> > to EA being used in a similar fashion to achieve fixed BAR placement
> > would be appreciated.
> 
> EA wasn't on my radar either, but I did some research and chatted with
> Tushar and I think it could work.  I'll sketch out a rough idea of what
> it might looks like.
> 
> EA describes BAR equivalents (fixed base address, size, and type) in a
> separate capability while the corresponding device BAR registers appear
> unimplemented.  Linux already consumes endpoint EA capabilities and
> marks the resulting resources IORESOURCE_PCI_FIXED.  EDK2 doesn't know
> about EA (cap 0x14 isn't defined anywhere in MdePkg, and PciBusDxe
> never consults it afaict), but that turns out to be useful here rather
> than a problem.
> 
> Starting at the QEMU device, for a vfio-pci device we'd need to
> virtualize the real BARs as unimplemented and surface that information
> via a synthesized EA capability instead.  It's debatable whether this
> is a generic PCI mechanism or vfio-pci specific, whether HPA is
> automatically used as the base address for vfio-pci devices or
> user-specified, and the capability offset in config space.  None of
> those fundamentally change the shape of the flow.
> 
> For the absolute bare-minimum level of support (EA device on the root
> complex, EA resources don't overlap the VM address space or MMIO range,
> EDK2 firmware, Linux guest booted with pci=nocrs) I think this actually
> works with just adding the EA capability above.  Let's walk through
> those constraints and how we relax them.
> 
> At the firmware level we lean on the real BAR registers being
> unimplemented for EA devices, so EDK2 allocates no MMIO or IO resources
> for them.  Only bus numbers get assigned if the EA device sits in a PCI
> hierarchy.  That's exactly what we want, EDK2 doing conventional bus
> assignment but staying out of the EA resource flow entirely.
> 
> Instead of firmware EA enlightenment we lean on the guest OS.  Linux
> reads endpoint EA today, but the bridge aperture sizing path ignores
> those fixed resources.  As Tushar's series demonstrates, generically
> handling mixed "fixed-BAR" and programmable-BAR devices in one
> hierarchy is hard.  An incremental Linux enhancement that greatly
> simplifies the problem space would be to program bridge apertures only
> for hierarchies consisting entirely of fixed resources.  The math
> becomes trivial (window spans min..max of fixed children, aligned to
> bridge granularity), and there's no regression risk, these hierarchies
> currently fail silently.  The sizer ignores fixed children and the
> fixed-claim walk-up finds no containing parent.  This enhancement,
> plus the homogeneous-hierarchy constraint, removes the root-complex
> constraint and lets us mirror the bare-metal topologies we need.
> 
> Resource ranges are a bit messier.  The extent of the EA device ranges
> could be determined in QEMU and the VM address map adjusted to prevent
> overlap.  Tushar already has a similar user-specified machine option in
> this series.  That range also needs to reach the guest as a CRS (to
> avoid pci=nocrs) but needs to stay distinct from the DT range passed to
> EDK2 for programmable BAR devices so EDK2 won't place a programmable
> BAR or bridge window into the EA region.  So long as we keep EA and
> programmable devices in separate hierarchies, EDK2 only needs the
> programmable range via DT and we can add the EA range as additional CRS
> ranges visible only to the guest.
> 
> In practice, EDK2 programs all the programmable devices and the EA
> devices live entirely in the additional CRS.  A possibly cleaner
> alternative is additional PXB host bridges for the EA devices, each
> with its own CRS.  That sidesteps the DT/CRS split entirely since the
> EA PXB has nothing for EDK2 to allocate anyway.
> 
> If we agree that homogeneous hierarchies (no mixing of EA and
> programmable BARs) is a reasonable constraint, and possibly extend that
> to homogeneous per host bridge to simplify the CRS mapping, we have the
> following work items:
> 
>  * Extend Linux EA support to program bridge apertures for subordinate
>    homogeneous EA hierarchies.
> 
>  * Develop options to virtualize programmable BARs as EA for vfio-pci
>    devices, if not generically for the benefit of testing.
> 
>  * Implement a way to poke holes in the VM address space and plumb
>    through to account for addresses used by EA devices.
> 
>  * Provide those same ranges to the guest via CRS (but not via DT to
>    EDK2), or alternatively expose them through additional PXB host
>    bridges.
> 
> Does that shape roughly seem accurate?  Are there additional gaps I've
> missed?  Thanks,
> 
> Alex


just one question why not do it in firmware so windows
is thinkably also handled?


