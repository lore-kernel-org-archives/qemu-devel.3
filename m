Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E50C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOxm-0007RN-Hu; Wed, 12 Mar 2025 12:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tsOxi-0007Qt-17
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tsOxf-0003br-61
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741796977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bp6sd+VUQnZJAk+YIgjjXpXCcGW1rFD2qhUEKBLX5jw=;
 b=Makw/9yPanHXOicS1znnXS83hS82GbpuKWGbXdiSDDjQkkayOwvfhOBt2DjR7NfMq4lagJ
 bF1Uwje6xzChnZG5dmtSfxunSz6Ovjn4jspxtsK3V6w2Hn2K6CHKy/tdSK//UZls6vfY+1
 nUCxgHZ/d+v3dTe+wcPbzBbS4KC14ZQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-s6aJXHLYOQSM5PfbhDJoaQ-1; Wed, 12 Mar 2025 12:29:33 -0400
X-MC-Unique: s6aJXHLYOQSM5PfbhDJoaQ-1
X-Mimecast-MFC-AGG-ID: s6aJXHLYOQSM5PfbhDJoaQ_1741796973
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-8556de861d4so223639f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796973; x=1742401773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bp6sd+VUQnZJAk+YIgjjXpXCcGW1rFD2qhUEKBLX5jw=;
 b=Ml5gk6FZJ4H1gtYTuJOtIkM8cZFPuWXX7+E35WSO35HgZVRd2Yy2NziCh2LRtvfFK3
 NwNzu2BNIulh48aPxoRyIoYYsPGC5VKJ06rwyslOXtTj3oE9fUn+UCUxKPmfORIiKq01
 ES2pxuUP9cnKUg1gPZr2wtmaeZYeW2AaIZ99w1LZhQvi/w3xH8TpMOLkzJiX9XRZ0tSt
 KTxEzlY0eYpjQ3I+6U4Edw/4LrjiGXJk5+YjlnM7izGALEkWBathJoFIH2AmGHHzhdtR
 mKSbCttrXIsFpj8v948P70OlTdpizrA6vxyVnFBnioczlI3R3SpZPnjgN8RDSjDRTPSF
 QRyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5dvltj3LpAJEOQzGU+Wxkc0CVqJHLLIA4ublI3zx1SPRxLHuQtEnwzrNFKnCGlQqYUgSjswBCCFUn@nongnu.org
X-Gm-Message-State: AOJu0Yy8PYqUhSOsM4cSGqWzlQsUDJp6gdGYbxO8XFd/b1ljM1UD5utM
 TUgmZracj/GBvGFrQVK2XfHjHoWPt6r+uJkdGbt9bjzs3P1XgDznWv5Oemr7G02nNjYAaBas8v5
 eUOi+2H61Y/YhZSZ2cfOwJly8Nqi9pV3vsOwB/7gRJvZgusuY4V2/
X-Gm-Gg: ASbGncsL5X35NEhrb8eIbhlC8Vy9MPpPmy2i/q7RG91/dt9wv8CVcqbjekBkBIS+9Ed
 sd/gqOHVYbyM1cLuI1x2mSQowIrSuANgdfpC8aQaujwsk5/R1FXak1mK8PmxVd2F0UE7lS/ioJb
 SPLq8EGWa6bIw98clvvl4/U707I94h4rOH3n9OnXs6cDtlmMCzHOhWbd+Ub4jW7IoCG025XEzr0
 d/R9I1rJBvuSYnql/+MVPUjvsc6MHwVt7O8qn2V+k0bFRGQ2oTq35tXWmB0hx/5+1g9weGmXH8p
 jRi5VcyLlKvrFkiHCS8=
X-Received: by 2002:a05:6e02:34a0:b0:3d4:29b5:dc0 with SMTP id
 e9e14a558f8ab-3d44c021a5emr56053945ab.2.1741796972829; 
 Wed, 12 Mar 2025 09:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9QaitgaN8rNLn2scNvyXEFL4rf9SK1khEw8bmqZoVLq0hnvXhi4wGBEl8qi+xqgDOH02Few==
X-Received: by 2002:a05:6e02:34a0:b0:3d4:29b5:dc0 with SMTP id
 e9e14a558f8ab-3d44c021a5emr56053825ab.2.1741796972233; 
 Wed, 12 Mar 2025 09:29:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d43b4e1fafsm30991325ab.13.2025.03.12.09.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:29:31 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:29:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <corvin.koehne@gmail.com>
Subject: Re: [PATCH] vfio/igd: Update IGD passthrough docoumentation
Message-ID: <20250312102929.329ff4f5.alex.williamson@redhat.com>
In-Reply-To: <20250312155002.286841-1-tomitamoeko@gmail.com>
References: <20250312155002.286841-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Wed, 12 Mar 2025 23:50:02 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> A previous change made the OpRegion and LPC quirks independent of the
> exising legacy mode, update the docoumentation accordingly. More related
> topics, like creating EFI Option ROM of IGD for OVMF, how to solve the
> VFIO_DMA_MAP Invalid Argument warning, as well as details on IGD memory
> internals, are also added.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  docs/igd-assign.txt | 262 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 193 insertions(+), 69 deletions(-)
> 
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index e17bb50789..c7c4565906 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -1,44 +1,69 @@
>  Intel Graphics Device (IGD) assignment with vfio-pci
>  ====================================================
>  
> -IGD has two different modes for assignment using vfio-pci:
> -
> -1) Universal Pass-Through (UPT) mode:
> -
> -   In this mode the IGD device is added as a *secondary* (ie. non-primary)
> -   graphics device in combination with an emulated primary graphics device.
> -   This mode *requires* guest driver support to remove the external
> -   dependencies generally associated with IGD (see below).  Those guest
> -   drivers only support this mode for Broadwell and newer IGD, according to
> -   Intel.  Additionally, this mode by default, and as officially supported
> -   by Intel, does not support direct video output.  The intention is to use
> -   this mode either to provide hardware acceleration to the emulated graphics
> -   or to use this mode in combination with guest-based remote access software,
> -   for example VNC (see below for optional output support).  This mode
> -   theoretically has no device specific handling dependencies on vfio-pci or
> -   the VM firmware.
> -
> -2) "Legacy" mode:
> -
> -   In this mode the IGD device is intended to be the primary and exclusive
> -   graphics device in the VM[1], as such QEMU does not facilitate any sort
> -   of remote graphics to the VM in this mode.  A connected physical monitor
> -   is the intended output device for IGD.  This mode includes several
> -   requirements and restrictions:
> -
> -    * IGD must be given address 02.0 on the PCI root bus in the VM
> -    * The host kernel must support vfio extensions for IGD (v4.6)
> -    * vfio VGA support very likely needs to be enabled in the host kernel
> -    * The VM firmware must support specific fw_cfg enablers for IGD
> -    * The VM machine type must support a PCI host bridge at 00.0 (standard)
> -    * The VM machine type must provide or allow to be created a special
> -      ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
> -      PCI address 1f.0.
> -    * The IGD device must have a VGA ROM, either provided via the romfile
> -      option or loaded automatically through vfio (standard).  rombar=0
> -      will disable legacy mode support.
> -    * Hotplug of the IGD device is not supported.
> -    * The IGD device must be a SandyBridge or newer model device.
> +Using vfio-pci, we can passthrough Intel Graphics Device (IGD) to guest, either
> +serve as primary and exclusive graphics adapter, or used in combination with an
> +emulated primary graphics device, depending on the config and guest driver
> +support. However, IGD devices are not "clean" PCI devices, they use extra
> +memory regions other than BARs. Special handling is required to make them work
> +properly, including:
> +
> +* OpRegion for accessing Virtual BIOS Table (VBT) that contains display output
> +  information.
> +* Data Stolen Memory (DSM) region used as VRAM at early stage (BIOS/UEFI)
> +
> +Certain guest software also depends on following conditions to work:
> +(*-Required by)
> +
> +| Condition                                   | Linux | Windows | VBIOS | EFI GOP |
> +|---------------------------------------------|-------|---------|-------|---------|
> +| #1 IGD has a valid OpRegion containing VBT  |  * ^1 |    *    |   *   |    *    |
> +| #2 VID/DID of LPC bridge at 00:1f.0 matches |       |         |   *   |    *    |
> +| #3 IGD is assigned to BDF 00:02.0           |       |         |   *   |    *    |
> +| #4 IGD has VGA controller device class      |       |         |   *   |    *    |
> +| #5 Host's VGA ranges are mapped to IGD      |       |         |   *   |         |
> +| #6 Guest has valid VBIOS or UEFI Option ROM |       |         |   *   |    *    |
> +
> +^1 Though i915 driver is able to mock a OpRegion, it is still recommended to
> +   use the VBT copied from host OpRegion to prevent incorrect configuration.
> +
> +For #1, the "x-igd-opregion=on" option exposes a copy of host IGD OpRegion to
> +guest via fw_cfg, where guest firmware can set up guest OpRegion with it.
> +
> +For #2, "x-igd-lpc=on" option copies the IDs of host LPC bridge and host bridge
> +to guest. Currently this is only supported on i440fx machines as there is
> +already an ICH9 LPC bridge present on q35 machines, overwriting its IDs may
> +lead to unexpected behavior.
> +
> +For #3, "addr=2.0" assigns IGD to 00:02.0.
> +
> +For #4, the primary display must be set to IGD in host BIOS.
> +
> +For #5, "x-vga=on" enables guest access to standard VGA IO/MMIO ranges.
> +
> +For #6, ROM either provided via the ROM BAR or romfile= option is needed, this
> +Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
> +"Guest firmware" section.
> +
> +QEMU also provides a "Legacy" mode that implicitly enables full functionality
> +on IGD, it is automatically enabled when
> +* Machine type is i440fx
> +* IGD is assigned to guest BDF 00:02.0
> +* ROM BAR or romfile is present
> +
> +In "Legacy" mode, QEMU will automatically setup OpRegion, LPC bridge IDs and
> +VGA range access, which is equivalent to:
> +  x-igd-opregion=on,x-igd-lpc=on,x-vga=on
> +
> +By default, "Legacy" mode won't fail, it continues on error. User can set
> +"x-igd-legacy-mode=on" to force enabling legacy mode, this also checks if the
> +conditions above for legacy mode is met, and if any error occurs, QEMU will
> +fail immediately. Users can also set "x-igd-legacy-mode=off" to disable legacy
> +mode.
> +
> +In legacy mode, as the guest VGA ranges are assigned to IGD device, all other
> +graphics devices should be removed, this can be done using "-nographic" or
> +"-vga none" or "-nodefaults", along with adding the device using vfio-pci.
>  
>  For either mode, depending on the host kernel, the i915 driver in the host
>  may generate faults and errors upon re-binding to an IGD device after it
> @@ -73,31 +98,39 @@ DVI, or DisplayPort) may be unsupported in some use cases.  In the author's
>  experience, even DP to VGA adapters can be troublesome while adapters between
>  digital formats work well.
>  
> -Usage
> -=====
> -The intention is for IGD assignment to be transparent for users and thus for
> -management tools like libvirt.  To make use of legacy mode, simply remove all
> -other graphics options and use "-nographic" and either "-vga none" or
> -"-nodefaults", along with adding the device using vfio-pci:
>  
> -    -device vfio-pci,host=00:02.0,id=hostdev0,bus=pci.0,addr=0x2
> +Options
> +=======
> +* x-igd-opregion=[on|*off*]
> +  Copy host IGD OpRegion and expose it to guest with fw_cfg
> +
> +* x-igd-lpc=[on|*off*]
> +  Creates a dummy LPC bridge at 00:1f:0 with host VID/DID (i440fx only)
> +
> +* x-igd-legacy-mode=[on|off|*auto*]
> +  Enable/Disable legacy mode
> +
> +* x-igd-gms=[hex, default 0]
> +  Overriding DSM region size in GGC register, 0 means uses host value.
> +  Use this only when the DSM size cannot be changed through the
> +  'DVMT Pre-Allocated' option in host BIOS.
>  
> -For UPT mode, retain the default emulated graphics and simply add the vfio-pci
> -device making use of any other bus address other than 02.0.  libvirt will
> -default to assigning the device a UPT compatible address while legacy mode
> -users will need to manually edit the XML if using a tool like virt-manager
> -where the VM device address is not expressly specified.
>  
> -An experimental vfio-pci option also exists to enable OpRegion, and thus
> -external monitor support, for UPT mode.  This can be enabled by adding
> -"x-igd-opregion=on" to the vfio-pci device options for the IGD device.  As
> -with legacy mode, this requires the host to support features introduced in
> -the v4.6 kernel.  If Intel chooses to embrace this support, the option may
> -be made non-experimental in the future, opening it to libvirt support.
> +Examples
> +========
> +* Adding IGD with automatically legacy mode support
> +  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0
>  
> -Developer ABI
> -=============
> -Legacy mode IGD support imposes two fw_cfg requirements on the VM firmware:
> +* Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
> +  (For UEFI guests)
> +  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-opregion=on,x-igd-lpc=on,romfile=efi_oprom.rom
> +
> +
> +Guest firmware
> +==============
> +Guest firmware is responsible for setting up OpRegion and Base of Data Stolen
> +Memory (BDSM) in guest address space. IGD passthrough support imposes two
> +fw_cfg requirements on the VM firmware:
>  
>  1) "etc/igd-opregion"
>  
> @@ -117,17 +150,108 @@ Legacy mode IGD support imposes two fw_cfg requirements on the VM firmware:
>     Firmware must allocate a reserved memory below 4GB with required 1MB
>     alignment equal to this size.  Additionally the base address of this
>     reserved region must be written to the dword BDSM register in PCI config
> -   space of the IGD device at offset 0x5C.  As this support is related to
> -   running the IGD ROM, which has other dependencies on the device appearing
> -   at guest address 00:02.0, it's expected that this fw_cfg file is only
> -   relevant to a single PCI class VGA device with Intel vendor ID, appearing
> -   at PCI bus address 00:02.0.
> +   space of the IGD device at offset 0x5C (or 0xC0 for Gen 11+ devices using
> +   64-bit BDSM).  As this support is related to running the IGD ROM, which
> +   has other dependencies on the device appearing at guest address 00:02.0,
> +   it's expected that this fw_cfg file is only relevant to a single PCI
> +   class VGA device with Intel vendor ID, appearing at PCI bus address 00:02.0.
> +
> +Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) support.
> +However, the support is not accepted by upstream EDK2/OVMF. A recommended
> +solution is to create a virtual OpRom with following DXE drivers:
> +
> +* IgdAssignmentDxe: Set up OpRegion and BDSM according to fw_cfg (must)
> +* IntelGopDriver: Closed-source Intel GOP driver
> +* PlatformGopPolicy: Protocol required by IntelGopDriver
> +
> +IntelGopDriver and PlatformGopPolicy is only required when enabling GOP on IGD.
> +
> +The original IgdAssignmentDxe can be found at [3]. A Intel maintained version
> +with PlatformGopPolicy for industrial computing is at [4]. There is also an
> +unofficially maintained version with newer Gen11+ device support at [5].
> +You need to build them with EDK2.
> +
> +For the IntelGopDriver, Intel never released it to public. You may contact
> +Intel support to get one as [4] said, if you are an Intel primer customer,

s/primer/premier/ ?

> +or you can try extract it from your host firmware using "UEFI BIOS Updater"[6].
> +
> +Once you got all the required DXE drivers, a Option ROM can be generated with
> +EfiRom utility in EDK2, using
> +  EfiRom -f 0x8086 -i <Device ID of your IGD> -o output.rom \
> +  -e IgdAssignmentDxe.efi PlatformGOPPolicy.efi IntelGopDriver.efi
> +
> +
> +Known issues
> +============
> +When using OVMF as guest firmware, you may encounter the following warning:
> +warning: vfio_container_dma_map(0x55fab36ce610, 0x380010000000, 0x108000, 0x7fd336000000) = -22 (Invalid argument)
> +Solution:
> +Set the host physical address bits to IOMMU address width using
> +  -cpu host,host-phys-bits-limit=<IOMMU address width>
> +Or in libvirt XML with
> +  <cpu>
> +    <maxphysaddr mode='passthrough' limit='<IOMMU address width>'/>
> +  </cpu>
> +The IOMMU address width can be determined with
> +echo $(( ((0x$(cat /sys/devices/virtual/iommu/dmar0/intel-iommu/cap) & 0x3F0000) >> 16) + 1 ))

That's handy!

> +Refer https://edk2.groups.io/g/devel/topic/patch_v1/102359124 for more details
> +
> +
> +Memory View
> +===========
> +IGD has it own address space. To use system RAM as VRAM, a single-level page
> +table named Graphics Translation Table (GTT) is used for the address
> +translation. Each page table entry points a 4KB page. The translation flow is:
> +
> +(PTE size 8)             +-------------+---+
> +                         |   Address   | V |  V: Valid Bit
> +                         +-------------+---+
> +                         | ...         |   |
> +IGD:0x01ae9010     0xd740| 0x70ffc000  | 1 |  Mem:0x42ba3e010^
> +-----------------> 0xd748| 0x42ba3e000 | 1 +------------------>
> +(addr << 12) * 8   0xd750| 0x42ba3f000 | 1 |
> +                         | ...         |   |
> +                         +-------------+---+

I think this was meant to be '(addr >> 12) * 8'.  A simpler
representation is just (addr >> 9), but maybe you're trying to
emphasize the PTE size here.

> +^ The address may be remapped by IOMMU
> +
> +The memory region store GTT is called GTT Stolen Memory (GSM), it is located
> +right below the Data Stolen Memory (DSM). Accessing this region directly is
> +not allowed, any access will immediately freeze the whole system. The only way
> +to access it is through the second half of MMIO BAR0.
> +
> +The Data Stolen Memory is reserved by firmware, and acts as the VRAM in pre-OS
> +environments. In QEMU, guest firmware (Seabios/OVMF) is responsible for
> +reserving a continuous region and program its base address to BDSM register,
> +then let VBIOS/GOP driver initializing this region. Illustration below shows
> +how DSM is mapped.
> +
> +       IGD Addr Space                 Host Addr Space         Guest Addr Space
> +       +-------------+                +-------------+         +-------------+
> +       |             |                |             |         |             |
> +       |             |                |             |         |             |
> +       |             |                +-------------+         +-------------+
> +       |             |                | Data Stolen |         | Data Stolen |
> +       |             |                |   (Guest)   |         |   (Guest)   |
> +       |             |  +------------>+-------------+<------->+-------------+<--Guest BDSM
> +       |             |  | Passthrough |             | EPT     |             |   Emulated by QEMU
> +DSMSIZE+-------------+  | with IOMMU  |             | Mapping |             |   Programmed by guest FW
> +       |             |  |             |             |         |             |
> +       |             |  |             |             |         |             |
> +      0+-------------+--+             |             |         |             |
> +                        |             +-------------+         |             |
> +                        |             | Data Stolen |         +-------------+
> +                        |             |   (Host)    |
> +                        +------------>+-------------+<--Host BDSM
> +                          Non-        |             |   "real" one in HW
> +                          Passthrough |             |   Programmed by host FW
> +                                      +-------------+
>  
>  Footnotes
>  =========
> -[1] Nothing precludes adding additional emulated or assigned graphics devices
> -    as non-primary, other than the combination typically not working.  I only
> -    intend to set user expectations, others are welcome to find working
> -    combinations or fix whatever issues prevent this from working in the common
> -    case.
> +[1] https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/dump-video-bios.html
>  [2] # echo "vfio-pci" > /sys/bus/pci/devices/0000:00:02.0/driver_override
> +[3] https://web.archive.org/web/20240827012422/https://bugzilla.tianocore.org/show_bug.cgi?id=935
> +    Tianocore bugzilla was down since Jan 2025 :(
> +[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004
> +[5] https://github.com/tomitamoeko/VfioIgdPkg
> +[6] https://winraid.level1techs.com/t/tool-guide-news-uefi-bios-updater-ubu/30357

This is great and a much needed update.  Thanks!

With above corrections:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


