Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED5606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OB2F/kGS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NrYxhnSv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOaly-0005qX-By; Wed, 04 Nov 2026 08:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOalv-0005q6-1b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOals-0002EN-I7
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793797878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2d0yVPNE+dWSvbmpZmx3OcTzKGLua3Iw2hXVBqo74I=;
 b=OB2F/kGShKiXUsey22sdT1MXro0RgCdrbuULt3jQenSylTIYYkjJ9Ire6AFSbxWwl789ke
 8zJOr6TgDLYawTwK1OxcgaQotPM3JcO7SPZUBM8tL8jpTKpR+jJz1A26g4lHss1JGJioa3
 u8eYkhhAHh0VdpnrXetPf9D3W4qC+d4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Kg9hB8jYOyqEOHZsatWgfA-1; Wed, 04 Nov 2026 08:11:17 -0500
X-MC-Unique: Kg9hB8jYOyqEOHZsatWgfA-1
X-Mimecast-MFC-AGG-ID: Kg9hB8jYOyqEOHZsatWgfA_1793797876
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab353585f1so4503411fa.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793797876; x=1794402676; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N2d0yVPNE+dWSvbmpZmx3OcTzKGLua3Iw2hXVBqo74I=;
 b=NrYxhnSvkQJvwVoi2AiVJmnahU6I1xENAsPkSeEYlhyMkTDTqb/5de3yzR6A+aU4Z6
 Plj5Mgy5syQJ3/InkKeJ0aAGyVK/UUl6RUfmdmyHiJe2BahqTtxy7349EvYKKMxpLSCL
 w/eKpNN5ohogCxJ+4ERQR94Mq+zEutKiMB8WDhv0w1a0i73DdC57Re0v3hQ83gVCVB04
 u5jFLzeJXfdHp7ueyPJ5AG60EjjOJ+sauh16E7DuQ+eP74HNvVwEKG2fiDf6UuXhDKDl
 m2Sn8U0ZjPoYqpxGcmTAh8h94fCUMzIujl7chqfsNK5UiwypH/QPIk2eEc+DBq3pkTv/
 uZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793797876; x=1794402676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2d0yVPNE+dWSvbmpZmx3OcTzKGLua3Iw2hXVBqo74I=;
 b=JuyIA6CvhYiFt483IeeeEoE5EkeHW8QBU3NXYjFHoAP8auAxxKF4vrVGHQlwtmsusP
 tMLmk1Ag5vTWM5+ALUOkMNCjFwZcoq7xm73VSYHeKwTezTsSc5n5w2ZkkUL+W361d1fT
 XzCKzXelYN8dpSg1QGArRUbO06ZZa3L+PLvAZHT0OpJ+BKRN2U88GgpdyviMRFz9Y6KQ
 SMDSBoNVCTEtNFzVWMf4EUWdYUTlRIJalulMu3LAHITCiIWL6TbR8F13zAvnhh9BySOA
 AnUVTPCk/up7i9Xv2BC6y0GLT9PaEuqDakk8c0ws1gbgl+cv6M28WoEKNo1jh+IXVGhn
 gL2A==
X-Gm-Message-State: APuU4Z/+DVGGVlIpQu3qklznrXhIgrPaiV30rCbki+YPlsmRrnvGvY0b
 Hx3cTiIvUuTILlJ/14LkGAks/EP3owDcuTV4ITvNz4/ZJpRlrfj1sOp4YSTsaYxNAZpJhig1WxX
 ngWXYw9YtGPRYpUwD+LvL/NVpeNAq3GMqIv0U3oBLaxt5CBL2F0sBulDd
X-Gm-Gg: AYBFou21JRLB7Tzj9ZfcDuKnCiWEp9kYH54AqyWPZ953FmnssvrNztrnEtIQYNBCU2g
 3fTA0OBG0KSMBPtTH6TmzXQcYGWpe6hGwdgRzErs2FL9KHxBHHRY4uywQuw3+PzTzGE11QDFLLG
 5yt69AU79ziyCSH2caZUhtYAPqUqXDVLxWnIy29RomF6kVOy0Z9tY0MSBrxZfJVBz/ZBzHjkkk0
 lEUnvO6KSRlDIXBLWf60P8z4pmbhkAf5QZdHLw3u/oXuL7FHmgGZ5Paje6FT0az+/ndGjCMgAO6
 WMGcdFaGnypuLcweJScmqFF6VhiWb/0/4a7QSoSjAOEFagm7qcgx68NPWAU5s6Xey9aI4XnslKw
 f++rpdha3zNgiyg/G9vkMdKGFwniDZH6YrZTQxbZFGQ==
X-Received: by 2002:a05:6512:4020:b0:5bf:a193:7a5b with SMTP id
 2adb3069b0e04-5bfd956d6f1mr5914616e87.34.1793797875605; 
 Wed, 04 Nov 2026 05:11:15 -0800 (PST)
X-Received: by 2002:a05:6512:4020:b0:5bf:a193:7a5b with SMTP id
 2adb3069b0e04-5bfd956d6f1mr5914598e87.34.1793797874886; 
 Wed, 04 Nov 2026 05:11:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bff38cf919sm379963e87.63.2026.11.04.05.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 05:11:14 -0800 (PST)
Date: Wed, 4 Nov 2026 08:11:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org, kraxel@redhat.com
Subject: Re: [PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <20261104071853-mutt-send-email-mst@kernel.org>
References: <20261102181241.3077981-1-tdave@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102181241.3077981-1-tdave@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 12:12:36PM -0600, Tushar Dave wrote:
> This patch series introduces a mechanism to specify Guest Physical Addresses
> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR addresses
> to match host physical addresses for assigned devices.


My understanding is that all this does it pass a property to
the firmware asking it to set the bar to a given value?

There are two standard ways to do this:
- EA capability in pci config space
- fixed BAR _DSM in ACPI


If none of these are appropriate, pls document why.



> On some platforms, P2P DMA between devices in the same IOMMU group is required
> for the desired data path and performance. The PCI fabric ACS is configured
> to permit direct P2P without routing traffic through the host bridge.
> 
> To support this multi-device IOMMU group P2P scenario in virtualization, the
> VM may need to preserve the host PCI BAR addresses in the guest.
> 
> A new fixed-bar-N property on a PCI endpoint device specifies the required
> guest address for BAR N (N = 0 through 5):
> 
>     -device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...
> 
> Once any fixed-bar-N property is set on a device, every memory BAR on that
> device must have a fixed address. Under a PCIe root port, fixed BAR placement
> is all-or-nothing within that root port's subtree. If one endpoint below the
> root port has a fixed BAR, every other endpoint with a memory BAR below that
> same root port must also have all of its memory BARs fixed.
> 
> QEMU validates the configuration when the machine is done initializing. Each
> address must be aligned to its BAR size, fall within the appropriate PCIe MMIO
> aperture, and not overlap any other fixed BAR. QEMU aborts on any validation
> failure. QEMU performs neither PCI enumeration nor BAR allocation; the
> validated configuration is exported to firmware through the "etc/fixed-bars"
> fw_cfg blob, which carries each PCI function's vendor/device identification,
> firmware device path, and, for fixed devices, the configured address, size,
> and type of each BAR. The blob format is documented in
> docs/specs/pci-fixed-bars.rst.
> 
> The fixed-bar-N property and its validation are generic and apply to any PCI
> device. A machine type opts in by setting the new pci_fixed_bar_supported
> MachineClass flag. Machine types that leave it unset reject fixed-bar-N. This
> series enables it on the virt machine only, by setting the flag and wiring up
> the fw_cfg export. Other machine types would need equivalent wiring to expose
> the same mechanism to firmware.
> 
> On the firmware side, the existing IncompatiblePciDeviceSupportDxe driver is
> extended to consume this blob. During device discovery, its CheckDevice()
> implementation returns ACPI address descriptors with _MIF|_MAF set for the
> fixed BARs found in the blob. PciBusDxe's resource allocator already supports
> fixed BARs, including sizing and pinning the bridge windows above them. It now
> treats a BAR as fixed when the descriptor carries _MIF|_MAF, and programs the
> fixed address into the BAR register.
> 
> Fixed BAR placement requires the guest to preserve the PCI resource
> configuration established by firmware. This is requested through the PCI boot
> configuration preservation mechanism using ACPI _DSM function 5. Fixed BAR
> configuration is rejected when firmware is not loaded or ACPI is disabled.
> 
> Example 1: VFIO passthrough device with fixed BARs and the PCIe MMIO
> aperture adjusted to accommodate the fixed addresses.
> 
>     -machine virt,...,highmem-mmio-base=4T,highmem-mmio-size=4T
>     -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
>     -device x3130-upstream,id=upstream1,bus=pcie.port1
>     -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=2
>     -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,id=dev0,\
>             fixed-bar-0=0x48000000000,fixed-bar-2=0x50000000000,fixed-bar-4=0x58000000000
> 
> Example 2: VFIO and emulated devices under the same root port with fixed BARs
> and the PCIe MMIO aperture adjusted using highmem-mmio-base.
> 
>     -machine virt,...,highmem-mmio-base=64T,highmem-mmio-size=64T
>     -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0
>     -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
>     -device x3130-upstream,id=upstream1,bus=pcie.port1
>     -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=1
>     -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,rombar=0,id=dev0,iommufd=iommufd0,\
>             fixed-bar-0=0x6b4000000000,fixed-bar-2=0x6b8000000000,fixed-bar-4=0x6c0000000000
>     -device xio3130-downstream,id=downstream1_2,bus=upstream1,chassis=1,slot=2
>     -device vfio-pci,host=0012:03:00.1,bus=downstream1_2,id=nic1,iommufd=iommufd0,fixed-bar-0=0x6c8000000000
>     -device xio3130-downstream,id=downstream1_3,bus=upstream1,chassis=1,slot=3
>     -device e1000,netdev=net0,bus=downstream1_3,id=nic_emu,fixed-bar-0=0x20000000
> 
> Limitations:
> 
> * I/O BARs and the expansion ROM BAR are not covered by fixed-bar-N.
> * SR-IOV VF BARs are not covered.
> 
> Testing:
> 
> The series was tested on the AArch64 virt machine with a range of PCIe
> configurations, including emulated and VFIO passthrough devices, PCIe
> switches, single and multiple fixed-BAR endpoints behind a shared root port,
> devices attached directly to the host bridge, and endpoints behind nested
> bridges. All rejection paths were also exercised, with the corresponding
> error messages verified. These included unsupported machine types,
> hot-plugged devices, non-existent BARs, I/O BARs, unaligned, overlapping, or
> out-of-aperture BARs, incomplete BAR configurations, highmem-mmio=off,
> missing firmware, and highmem-mmio-base values that cause address-space
> overflow.
> 
> Changes since v1:
> 
> * Add a pci_fixed_bar_supported MachineClass flag; fixed-bar-N is rejected
>   on machine types that do not set it. virt sets it.
> * Keep the fixed BAR claims in FixedBarsInfo instead of a static array, and
>   report validation failures through Error ** to the machine code instead of
>   calling exit(1).
> * Allow a 64-bit non-prefetchable BAR in either aperture when the device is
>   attached to the host bridge; behind a PCI bridge it must lie below 4 GiB.
>   A 64-bit prefetchable BAR must still lie in the 64-bit aperture.
> * Treat the high PCIe MMIO aperture as absent with highmem-mmio=off, and
>   reject fixed BAR configuration unless firmware is loaded and ACPI is
>   enabled.
> * Check highmem-mmio-base + highmem-mmio-size against the PA space without
>   overflow, and document highmem-mmio-base in docs/system/arm/virt.rst.
> * Document the etc/fixed-bars format in docs/specs/pci-fixed-bars.rst, and
>   note that the firmware device path is carried for future matching.
> * Move pci-fixed-bar.h to include/hw/pci/.
> 
> v1:
> https://lore.kernel.org/qemu-arm/20260916185554.917526-1-tdave@nvidia.com/
> 
> A git branch with this series applied is available at:
> https://github.com/tdavenvidia/upstream-qemu/tree/Upstream-fixed-bar-Oct-29-V2
> 
> The related EDK2 change is available at:
> https://github.com/tianocore/edk2/pull/13183
> 
> Tushar Dave (5):
>   hw/pci: introduce PCI fixed BAR properties
>   hw/pci: add validation for fixed BAR configuration
>   hw/pci: add fixed BAR fw_cfg blob export
>   hw/arm/virt: export fixed BAR metadata via fw_cfg
>   hw/arm/virt: add highmem-mmio-base property
> 
>  docs/specs/index.rst            |   1 +
>  docs/specs/pci-fixed-bars.rst   |  75 +++++++
>  docs/system/arm/virt.rst        |   4 +
>  hw/arm/virt.c                   |  82 ++++++-
>  hw/pci/meson.build              |   2 +
>  hw/pci/pci-fixed-bar-blob.c     | 308 +++++++++++++++++++++++++++
>  hw/pci/pci-fixed-bar-validate.c | 365 ++++++++++++++++++++++++++++++++
>  hw/pci/pci-fixed-bar-validate.h |  22 ++
>  hw/pci/pci.c                    |  71 +++++++
>  include/hw/core/boards.h        |   3 +
>  include/hw/pci/pci-fixed-bar.h  |  63 ++++++
>  include/hw/pci/pci_device.h     |   7 +
>  12 files changed, 1002 insertions(+), 1 deletion(-)
>  create mode 100644 docs/specs/pci-fixed-bars.rst
>  create mode 100644 hw/pci/pci-fixed-bar-blob.c
>  create mode 100644 hw/pci/pci-fixed-bar-validate.c
>  create mode 100644 hw/pci/pci-fixed-bar-validate.h
>  create mode 100644 include/hw/pci/pci-fixed-bar.h
> 
> -- 
> 2.34.1


