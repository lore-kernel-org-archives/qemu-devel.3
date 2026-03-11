Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F01125811
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OEp-0000he-Kx; Wed, 11 Mar 2026 14:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0OEo-0000gO-GU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0OEm-00071V-EM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773253491;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doUnDX5DJZWrIKZ/jma5ny/v50MeXmf9DwvLugad35I=;
 b=Ahywn0Ok9zBNcz/WYPRUtg7bJx5N2oYKiYKyWIbBvQMkJtkwpKBAw2h2JwQYcPAa9Tw8Xp
 krmg1Vj47PmBlHzKAhnjeLRSgSJDLSVWHX5Cw9II+r/Tw/QcVpBJsDv0EgPw+FDAvdQ4Sf
 r8cRo4F21cr70NwjtCrA8DcfDlQnPZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-FlV7jUuTMJC3EUnRfgz0kQ-1; Wed, 11 Mar 2026 14:24:50 -0400
X-MC-Unique: FlV7jUuTMJC3EUnRfgz0kQ-1
X-Mimecast-MFC-AGG-ID: FlV7jUuTMJC3EUnRfgz0kQ_1773253489
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485390246c8so2130475e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773253489; x=1773858289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doUnDX5DJZWrIKZ/jma5ny/v50MeXmf9DwvLugad35I=;
 b=AhbhhJsvY7CcB2fZ6UDoUVQXT2Nviq16wrOA/ocSxS05UBwFu5sOYLsNKy8LZozgBV
 gaD8ybk4WBbR73sxUwDIiWGABSfzWBm5oa1FXVjgQpm7R1vngJdMd1gC4bAZRQ1NcG7s
 cHbvVyd4WCnfXLC2IB8kCLfZfRp80FBCHRGp3zy7vQKKQ+heH8uUTnpoTxOVFnjMizom
 Owu2n9dav+/JcuSVjddpcl1WG57ooREDJv/pdlatjn357EziBCQxMOCDVeDHhgyvTO0T
 6XYizzqTjQ4pGOIKVk7GENIHXvxPrfkaDmTYSEqtJCT6UmiyjwY13h2IVY7OqL33f4UH
 nE/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL+AHJfT0A++RhN73aWoqVLzk25jDKptyoECjqjbLUSQxdF/Du4EslUK5Oxr3Tgl4Iby2jn/r2/num@nongnu.org
X-Gm-Message-State: AOJu0Ywa4GS1ICb8uIxa05Oq4nULwFvFavZX3JLW6W7c7li/Y2E7IlWp
 pfS+MrtRCl93QArsO2fRuoaeEjQQrSc68M2LfsargZ93acxzQ/t+sQPbJgs07wFaFORuO/tGlbB
 6yfwgDwfwtajuFqFOx+jnGVWl3U3KFLxfB/hjBvnkcKUjg0ZO0WtWMWk3
X-Gm-Gg: ATEYQzxwc1JM+3icao5ZA9NoG+pG5TsevKLVqizDoibD8L03QvnN/RCWMcMOhF0VADn
 YxFKhPsXO+THFNxrxMPMeZpApUoeejqbyjvz/gR8HjN3iccH3mH3O7pM4FmghW/QfkUmFMQZmEJ
 FYY1tDm6NAnc9Ym3IB20J7blvTA8jtuujUkVfzbLNC6Wrt9/zu3NcKj7KRZLyzMnbZQ89834IRs
 FLV6y4szENR7+LUhua8rKWWEkSITtD+JQtofvsiFpxXzWFrR72xUQn3cdmkTGOgvLkh7+ThmX3F
 exnN1yDSAEfQx7V/LjW/1v6yPSU0Y6qDLxCzA/4U0f411B12paplohSZ7TO0ScYxZyy7fCi/5hc
 J/j8lERObgu0cFMzALWpd9xCidHN6he5ctn3/JCnUp4+VnufEJsVWlGns1CtUJ/1HJZOTkw==
X-Received: by 2002:a05:600c:a404:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-4854bd14edamr51984815e9.31.1773253488637; 
 Wed, 11 Mar 2026 11:24:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a404:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-4854bd14edamr51984455e9.31.1773253488146; 
 Wed, 11 Mar 2026 11:24:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485419c2930sm284129365e9.0.2026.03.11.11.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:24:47 -0700 (PDT)
Message-ID: <254dceca-7864-4dbc-b25c-928add5a78e3@redhat.com>
Date: Wed, 11 Mar 2026 19:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Hi,
>
> Changes from v2:
>  https://lore.kernel.org/qemu-devel/20260206144823.80655-1-skolothumtho@nvidia.com/
>
>   - Addressed feedback on v2 and picked up R-by tags. Thanks!
>   - Renamed the property from "tegra241-cmdqv" to a generic OnOffAuto
>     "cmdqv".
>   - Introduced a probe() callback to detect and initialize CMDQV
>     support during device attach (patch #7).
>   - Since CMDQV initialization is now deferred to device attach time,
>     added a helper to link any unmapped MMIO/IRQ resources (patch #12).
>   - Moved VINTF enable handling to the CONFIG ENABLE bit write path
>     instead of any read/write access path (patch #17). Hopefully this
>     won't break any corner cases.
>   - Added checks for VINTF and CMDQV ENABLE bits before allocating
>     vCMDQ HW queues, and free any allocated resources if disabled
>     (patch #19).
>   - Introduced a common helper for vEVENTQ read and validation
>     (patch #23).
>   - Updated bios-tables test IORT blobs for SMMUv3 device identifier
>     changes (patch #29).
>   - Rebasing on top of Philippe's CONFIG_DEVICES cleanup series [0],
>     using tegra241-cmdqv-stubs.c (patch #6).
>
> Please find the complete branch here:
> https://github.com/shamiali2008/qemu-master/tree/master-veventq-v8-vcmdq-v3

with this version I still get those traces:

iommufd_backend_map_dma  iommufd=28 ioas=2 iova=0xc0b0000 size=0x10000
addr=0xffff0bd30000 readonly=0 (-1)
qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
qemu-system-aarch64: warning: vfio_container_dma_map(0xaaaea11e2870,
0xc0b0000, 0x10000, 0xffff0bd30000) = -14 (Bad address)

Eric

>
> I have sanity tested this on an NVIDIA GRACE platform and will
> continue with additional tests.
>
> Feedback and testing are very welcome.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/20260225031658.32095-1-philmd@linaro.org/
>
> ---
> Background(from RFCv1):
> https://lore.kernel.org/qemu-devel/20251210133737.78257-1-skolothumtho@nvidia.com/
>
> Thanks to Nicolin for the initial patches and testing on which this
> is based.
>
> Tegra241 CMDQV extends SMMUv3 by allocating per-VM "virtual interfaces"
> (VINTFs), each hosting up to 128 VCMDQs.
>
> Each VINTF exposes two 64KB MMIO pages:
>  - Page0 – guest owned control and status registers (directly mapped
>            into the VM)
>  - Page1 – queue configuration registers (trapped/emulated by QEMU)
>
> Unlike the standard SMMU CMDQ, a guest owned Tegra241 VCMDQ does not
> support the full command set. Only a subset, primarily invalidation
> related commands, is accepted by the CMDQV hardware. For this reason,
> a distinct CMDQV device must be exposed to the guest, and the guest OS
> must include a Tegra241 CMDQV aware driver to take advantage of the
> hardware acceleration.
>
> VCMDQ support is integrated via the IOMMU_HW_QUEUE_ALLOC mechanism,
> allowing QEMU to attach guest configured VCMDQ buffers to the
> underlying CMDQV hardware through IOMMUFD. The Linux kernel already
> supports the full CMDQV virtualisation model via IOMMUFD[0].
>
> ---
>
> Nicolin Chen (15):
>   backends/iommufd: Update iommufd_backend_get_device_info
>   backends/iommufd: Update iommufd_backend_alloc_viommu to allow user
>     ptr
>   backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
>   backends/iommufd: Introduce iommufd_backend_viommu_mmap
>   hw/arm/tegra241-cmdqv: Implement CMDQV init
>   hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU alloc/free
>   hw/arm/tegra241-cmdqv: Emulate global CMDQV registers
>   hw/arm/tegra241-cmdqv: Emulate global and VINTF VCMDQ register reads
>   hw/arm/tegra241-cmdqv: Emulate global and VINTF VCMDQ register writes
>   hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
>   hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base register programming
>   hw/arm/tegra241-cmdqv: Map VINTF page0 into guest MMIO space
>   hw/arm/tegra241-cmdqv: Add reset handler
>   hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
>   hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT
>
> Shameer Kolothum (17):
>   hw/arm/smmuv3-accel: Introduce CMDQV ops interface
>   hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend stub
>   hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
>   hw/arm/virt: Store SMMUv3 device objects in VirtMachineState.
>   hw/arm/virt-acpi-build: Use stored SMMUv3 devices for IORT build
>   hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV support
>   hw/arm/virt: Link SMMUv3 CMDQV resources to platform bus
>   system/physmem: Add address_space_is_ram() helper
>   hw/arm/tegra241-cmdqv: Use mmap'ed VINTF page0 as VCMDQ backing
>   hw/arm/tegra241-cmdqv: Add vEVENTQ allocation and free
>   hw/arm/smmuv3-accel: Introduce common helper for veventq read
>   hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
>   tests/qtest/bios-tables-test: Prepare for IORT SMMUv3 node identifier
>     change
>   hw/arm/smmuv3: Add per-device identifier property
>   tests/qtest/bios-tables-test: Update IORT blobs for SMMUv3 identifier
>     change
>   hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
>   hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
>
>  hw/arm/smmuv3-accel.h                         |  29 +
>  hw/arm/tegra241-cmdqv.h                       | 342 ++++++++
>  include/hw/arm/smmuv3.h                       |   3 +
>  include/hw/arm/virt.h                         |   1 +
>  include/system/iommufd.h                      |  16 +
>  include/system/memory.h                       |  10 +
>  backends/iommufd.c                            |  64 ++
>  hw/arm/smmuv3-accel-stubs.c                   |  11 +
>  hw/arm/smmuv3-accel.c                         | 196 ++++-
>  hw/arm/smmuv3.c                               |   9 +
>  hw/arm/tegra241-cmdqv-stubs.c                 |  18 +
>  hw/arm/tegra241-cmdqv.c                       | 793 ++++++++++++++++++
>  hw/arm/virt-acpi-build.c                      | 126 ++-
>  hw/arm/virt.c                                 |  27 +
>  hw/vfio/iommufd.c                             |   4 +-
>  system/physmem.c                              |  11 +
>  backends/trace-events                         |   4 +-
>  hw/arm/Kconfig                                |   5 +
>  hw/arm/meson.build                            |   2 +
>  hw/arm/trace-events                           |   5 +
>  tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
>  tests/data/acpi/aarch64/virt/IORT.msi_gicv2m  | Bin 172 -> 172 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 260 -> 260 bytes
>  .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 192 -> 192 bytes
>  24 files changed, 1596 insertions(+), 80 deletions(-)
>  create mode 100644 hw/arm/tegra241-cmdqv.h
>  create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
>  create mode 100644 hw/arm/tegra241-cmdqv.c
>


