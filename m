Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F06C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 18:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT4m1-0007WR-9X; Thu, 25 Jan 2024 13:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rT4lz-0007WA-RA
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:48:24 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rT4lw-0000lj-Qx
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:48:23 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5100c3f7df1so4183546e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706208498; x=1706813298; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ONx91jBu5LRK3syKrOs9LilMUK1Ea9I59D06jidi0tU=;
 b=O1YSVgsb4elWUrVyDGm3ZUwmUlhrrJBfopxCpyhtyqvhBF+77xWZqpwbbIg4iWKqQo
 ix78JXl662V7h7TKmOycTBQfzDo/dq0p4RFBBqSyS0FaCQvpvwHtXZ0+LkK3ppndJMJ8
 VlBN9r2OcAz6K7EmudUb0tx78y6mJi5oZt/PhMiA59HP9s8xvmHifRxfh1oVWxfFHAyk
 5PBrdqaYsPLRojbxQY3FXyF01kD1Fvr5L6vLEtP4LHemRj2WNdBGkIuT9sbUWMYsF15y
 7a5vvU6EbvsH4yUKow2cmI+pYr19+fKH428+tXvHPB3Nu9ufhPfrQ7PcGfe8F4K5uFaJ
 A2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706208498; x=1706813298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONx91jBu5LRK3syKrOs9LilMUK1Ea9I59D06jidi0tU=;
 b=dA4Yr8nMgz1xAJ6NXvIzKeuo42rlakoy057uqoBiZ/TxfWfEjglLLolBxnfUT1vJF5
 B3ILDIcM0t31RQHlRPxhpw/99sVAy+CvEmDMwv7FZbf9y/X2MdqK3PSI3KkLPKEK9gLT
 Ebe5xCxfWXX6oAcULG4qKP6um+Ih6JpumhU2g0TXMdakplOIMGfOXPOLKynE1q0OeNX/
 2UX+za5gzYXXMLRoZ4tYNvEoTLbsV6I1DTtMnfk+W4eWmFN7dQhqDS+YCT3Z46pd5y0c
 //gScrnDPuAbO3Q9R5g6/m9RPUbVqaubejqzy3F1cDmeKZ7Fe1i8bcsBj5WyUDRruzJM
 9ZXA==
X-Gm-Message-State: AOJu0Yx40EMQFObx4N1CBKZiVOuEQS76l8OAkQAtVhRaziwTe5VKePYu
 WaDL29bIDk2mzJmvBzN2RruLE0nKetqxnLxHgmhREhV8bNJ/pyCMWJ3szO9gyZE=
X-Google-Smtp-Source: AGHT+IGGzd/BaeJ51IqiLPAfklhov9IMf+cWA+nQ78fq319Sb6a4Xys9Dhq3eD6qF4gvu67xiPNa3Q==
X-Received: by 2002:a05:6512:4019:b0:510:f7c:1b91 with SMTP id
 br25-20020a056512401900b005100f7c1b91mr368234lfb.47.1706208497667; 
 Thu, 25 Jan 2024 10:48:17 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b0040e486bc0dfsm3496789wmo.27.2024.01.25.10.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 10:48:17 -0800 (PST)
Date: Thu, 25 Jan 2024 18:48:22 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
 for hotplugged devices
Message-ID: <20240125184822.GB122027@myrica>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <SJ0PR11MB6744C50921CC63221A93C75492712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7bc955a1-f58d-43b1-8e95-c452bb11f208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc955a1-f58d-43b1-8e95-c452bb11f208@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=jean-philippe@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On Thu, Jan 18, 2024 at 10:43:55AM +0100, Eric Auger wrote:
> Hi Zhenzhong,
> On 1/18/24 08:10, Duan, Zhenzhong wrote:
> > Hi Eric,
> >
> >> -----Original Message-----
> >> From: Eric Auger <eric.auger@redhat.com>
> >> Cc: mst@redhat.com; clg@redhat.com
> >> Subject: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
> >> for hotplugged devices
> >>
> >> In [1] we attempted to fix a case where a VFIO-PCI device protected
> >> with a virtio-iommu was assigned to an x86 guest. On x86 the physical
> >> IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
> >> virtio-iommu used to expose a 64b address space by default.
> >> Hence the guest was trying to use the full 64b space and we hit
> >> DMA MAP failures. To work around this issue we managed to pass
> >> usable IOVA regions (excluding the out of range space) from VFIO
> >> to the virtio-iommu device. This was made feasible by introducing
> >> a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
> >> This latter gets called when the IOMMU MR is enabled which
> >> causes the vfio_listener_region_add() to be called.
> >>
> >> However with VFIO-PCI hotplug, this technique fails due to the
> >> race between the call to the callback in the add memory listener
> >> and the virtio-iommu probe request. Indeed the probe request gets
> >> called before the attach to the domain. So in that case the usable
> >> regions are communicated after the probe request and fail to be
> >> conveyed to the guest. To be honest the problem was hinted by
> >> Jean-Philippe in [1] and I should have been more careful at
> >> listening to him and testing with hotplug :-(
> > It looks the global virtio_iommu_config.bypass is never cleared in guest.
> > When guest virtio_iommu driver enable IOMMU, should it clear this
> > bypass attribute?
> > If it could be cleared in viommu_probe(), then qemu will call
> > virtio_iommu_set_config() then virtio_iommu_switch_address_space_all()
> > to enable IOMMU MR. Then both coldplugged and hotplugged devices will work.
> 
> this field is iommu wide while the probe applies on a one device.In
> general I would prefer not to be dependent on the MR enablement. We know
> that the device is likely to be protected and we can collect its
> requirements beforehand.
> 
> >
> > Intel iommu has a similar bit in register GCMD_REG.TE, when guest
> > intel_iommu driver probe set it, on qemu side, vtd_address_space_refresh_all()
> > is called to enable IOMMU MRs.
> interesting.
> 
> Would be curious to get Jean Philippe's pov.

I'd rather not rely on this, it's hard to justify a driver change based
only on QEMU internals. And QEMU can't count on the driver always clearing
bypass. There could be situations where the guest can't afford to do it,
like if an endpoint is owned by the firmware and has to keep running.

There may be a separate argument for clearing bypass. With a coldplugged
VFIO device the flow is:

1. Map the whole guest address space in VFIO to implement boot-bypass.
   This allocates all guest pages, which takes a while and is wasteful.
   I've actually crashed a host that way, when spawning a guest with too
   much RAM.
2. Start the VM
3. When the virtio-iommu driver attaches a (non-identity) domain to the
   assigned endpoint, then unmap the whole address space in VFIO, and most
   pages are given back to the host.

We can't disable boot-bypass because the BIOS needs it. But instead the
flow could be:

1. Start the VM, with only the virtual endpoints. Nothing to pin.
2. The virtio-iommu driver disables bypass during boot
3. Hotplug the VFIO device. With bypass disabled there is no need to pin
   the whole guest address space, unless the guest explicitly asks for an
   identity domain.

However, I don't know if this is a realistic scenario that will actually
be used.

By the way, do you have an easy way to reproduce the issue described here?
I've had to enable iommu.forcedac=1 on the command-line, otherwise Linux
just allocates 32-bit IOVAs.

> >
> >> For coldplugged device the technique works because we make sure all
> >> the IOMMU MR are enabled once on the machine init done: 94df5b2180
> >> ("virtio-iommu: Fix 64kB host page size VFIO device assignment")
> >> for granule freeze. But I would be keen to get rid of this trick.
> >>
> >> Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
> >> MR to have been enabled and the corresponding vfio_listener_region_add()
> >> to be executed. Instead this series proposes to replace the usage of this
> >> API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci:
> >> modify
> >> pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
> >> called earlier, once the usable IOVA regions have been collected by
> >> VFIO, without the need for the IOMMU MR to be enabled.
> >>
> >> This looks cleaner. In the short term this may also be used for
> >> passing the page size mask, which would allow to get rid of the
> >> hacky transient IOMMU MR enablement mentionned above.
> >>
> >> [1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
> >>    https://lore.kernel.org/all/20231019134651.842175-1-
> >> eric.auger@redhat.com/
> >>
> >> [2] https://lore.kernel.org/all/20230929161547.GB2957297@myrica/
> >>
> >> Extra Notes:
> >> With that series, the reserved memory regions are communicated on time
> >> so that the virtio-iommu probe request grabs them. However this is not
> >> sufficient. In some cases (my case), I still see some DMA MAP failures
> >> and the guest keeps on using IOVA ranges outside the geometry of the
> >> physical IOMMU. This is due to the fact the VFIO-PCI device is in the
> >> same iommu group as the pcie root port. Normally the kernel
> >> iova_reserve_iommu_regions (dma-iommu.c) is supposed to call
> >> reserve_iova()
> >> for each reserved IOVA, which carves them out of the allocator. When
> >> iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
> >> the iova domain is already allocated and set and we don't call
> >> iova_reserve_iommu_regions() again for the vfio-pci device. So its
> >> corresponding reserved regions are not properly taken into account.
> > I suspect there is same issue with coldplugged devices. If those devices
> > are in same group, get iova_reserve_iommu_regions() is only called
> > for first device. But other devices's reserved regions are missed.
> 
> Correct
> >
> > Curious how you make passthrough device and pcie root port under same
> > group.
> > When I start a x86 guest with passthrough device, I see passthrough
> > device and pcie root port are in different group.
> >
> > -[0000:00]-+-00.0
> >            +-01.0
> >            +-02.0
> >            +-03.0-[01]----00.0
> >
> > /sys/kernel/iommu_groups/3/devices:
> > 0000:00:03.0
> > /sys/kernel/iommu_groups/7/devices:
> > 0000:01:00.0
> >
> > My qemu cmdline:
> > -device pcie-root-port,id=root0,slot=0
> > -device vfio-pci,host=6f:01.0,id=vfio0,bus=root0
> 
> I just replayed the scenario:
> - if you have a coldplugged vfio-pci device, the pci root port and the
> passthroughed device end up in different iommu groups. On my end I use
> ioh3420 but you confirmed that's the same for the generic pcie-root-port
> - however if you hotplug the vfio-pci device that's a different story:
> they end up in the same group. Don't ask me why. I tried with
> both virtio-iommu and intel iommu and I end up with the same topology.
> That looks really weird to me.

It also took me a while to get hotplug to work on x86:
pcie_cap_slot_plug_cb() didn't get called, instead it would call
ich9_pm_device_plug_cb(). Not sure what I'm doing wrong.
To work around that I instantiated a second pxb-pcie root bus and then a
pcie root port on there. So my command-line looks like:

 -device virtio-iommu
 -device pxb-pcie,id=pcie.1,bus_nr=1
 -device pcie-root-port,chassis=2,id=pcie.2,bus=pcie.1

 device_add vfio-pci,host=00:04.0,bus=pcie.2

And somehow pcieport and the assigned device do end up in separate IOMMU
groups.

Thanks,
Jean


