Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB27D72349
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjC3M-0003o2-5L; Fri, 23 Jan 2026 02:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vjC11-00018x-Nj
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vjC0x-0003Ki-4K
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhvbLy8fs130JJiPG7sVG+BnMVxDdAUEPqvbqFmmcX0=;
 b=c/0kMC1WsR5oV+5sobCsGjzsZpqrs8TpO4fQsnpS7gArEhA8xAOYTBOAiUp3+joDemjMt3
 JyPVx36oPXI39lqxvbQ2QKuGIB+mp6/MRm4Xxu7s7b07oBXnxAuLbGVHI+B+o5GEXYly8t
 gsY+26e1Jy/4Jo+ts9SRZtBnE5FrFfo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-g-vMJVJRMH6JVVg43U6XjQ-1; Fri, 23 Jan 2026 02:55:23 -0500
X-MC-Unique: g-vMJVJRMH6JVVg43U6XjQ-1
X-Mimecast-MFC-AGG-ID: g-vMJVJRMH6JVVg43U6XjQ_1769154922
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so9015185e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 23:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769154922; x=1769759722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhvbLy8fs130JJiPG7sVG+BnMVxDdAUEPqvbqFmmcX0=;
 b=ZCK5b379fm35O8DlBen7fdqb9FTSD8wa0OP96eR0j4odAAEeiSorDAj65RMvQjvCsQ
 rtpt2QPWNkVVHXPNQUah3X9iTqdzs4WjWzQ9fAUwsmy8cPjc0aim6RQNX9Pcn/TUIapw
 KhPhLgcjIugaoOsHHoCt72XQy7hIvkqZnp3qHrgwLQ4x82h/qY9ad8O9QqHrqAyDEKBx
 53JDdyvqyNtWPYfjjgYX6E1Om/hZZ+O8nvKQibJ9KOWFYvAOJFOWuzgL9C+0QqCJvrZe
 ISj8OOmAwdq/tSsHTrptRjhl1akmmo3UkmzH0tlEUtoXcfuSeO7+boXhO/0yZCZR1YU+
 WKJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIdge0H7o0qaKrRLHZVArIf4rmCjpfgIG8b41gjYpgD3wkjYj13tZ2s6sPmJnc4ORRZ/ioA2xFdmWZ@nongnu.org
X-Gm-Message-State: AOJu0YzNL3/S3wXSXs4riy156jqXiess/ENqD8/B8o9qS7GMrBvPvHRv
 1kBMnsVIl1/KJby/qyaq+IE4aG5WpT/vhZqdGGU/2e5KKsFvYu31ACeRRxFcig/Ow2cQ3Nt05xj
 K04LwfLSqFOeMOQfb617Vkdh9G0A7O5Qt1BMdviVZLgwB/VmFhOhONKK2
X-Gm-Gg: AZuq6aLNiKlKVk6zThIpciuCrBkkFGrhzPg2K7Eg3v3K+BItdr+ARn4rguXA1MwmZwF
 boVpbyq65Af7MhybK2VznEMqfMbFUDNpJvNtqnL+zUOVFRkjuB6TJbmYpP3mnHP53ax0e12p5hM
 YhmUM7jrPdhV099ajGz1zvaGvwXRRj963Q4u4OrU3cADl/Pp88lmrie1gMtipBRbXbpXZpDmr4q
 d9eQ9AeIHajzXfOwRCOI6K2Cj0y4nPALQR7xFi2bPg5zhfuGm4bzkTYbWjHUtEB6bQa+/jUPges
 OG/7gF9Dd0k8qgY5E+HljqEl4u7Xt1ts4euyoVwkQsvUCCVIGGfMDxG242QyubYlOCbYLMe9PS6
 I88ewjOKzCOy/Snloy49Byq3OGu4MUFgfykOFeSXrBCpNvkt9L1VQEN6BDg==
X-Received: by 2002:a05:600c:6095:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-4804c9624f5mr38523015e9.16.1769154921782; 
 Thu, 22 Jan 2026 23:55:21 -0800 (PST)
X-Received: by 2002:a05:600c:6095:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-4804c9624f5mr38522605e9.16.1769154921325; 
 Thu, 22 Jan 2026 23:55:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5fee94sm17081625e9.1.2026.01.22.23.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 23:55:20 -0800 (PST)
Message-ID: <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
Date: Fri, 23 Jan 2026 08:55:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: jgg@nvidia.com, nicolinc@nvidia.com, ddutile@redhat.com,
 berrange@redhat.com, clg@redhat.com, alex@shazbot.org, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter, Richard,

On 1/21/26 6:52 PM, Shameer Kolothum wrote:
> Hi,
>
> Changes since v7:
>  https://lore.kernel.org/qemu-devel/20260111195508.106943-1-skolothumtho@nvidia.com/
>  -Addressed comments and collected R-by and T-by tags. Thanks!.
>  -Rebased to latest master.
>  -Reworked PASID support patches (patch #34, #36).
>
> I think this series is in good shape now and mature enough for inclusion.
>
> Patch organization:
>
> 1–28: Enable accelerated SMMUv3 with features aligned to the default QEMU
> SMMUv3 implementation, including IORT RMR-based MSI support.
>
> 29–31: Add user-configurable options for RIL, ATS, and OAS features.
>
> 32–37: Add PASID support, including required VFIO changes.
>
> Please take a look and let me know your feedback.

This big series collected R-b's and T-bs for all patches I think. Please
could you consider pulling it?

Thank you in advance

Eric
>
> Thanks,
> Shameer
>
> A complete branch can be found here,
> https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v8-dmabuf-v4
>
> Testing:
>  Basic sanity testing was performed on an NVIDIA Grace platform with GPU
>  device assignment. A CUDA test application was used to validate the SVA
>  use case. Additional testing and feedback are welcome.
>
> Eg: Qemu Cmd line:
>
> qemu-system-aarch64 -machine virt,gic-version=3,highmem-mmio-size=2T \
> -cpu host -smp cpus=4 -m size=16G,slots=2,maxmem=66G -nographic \
> -bios QEMU_EFI.fd -object iommufd,id=iommufd0 -enable-kvm \
> -object memory-backend-ram,size=8G,id=m0 \
> -object memory-backend-ram,size=8G,id=m1 \
> -numa node,memdev=m0,cpus=0-3,nodeid=0 -numa node,memdev=m1,nodeid=1 \
> -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 -numa node,nodeid=5 \
> -numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 -numa node,nodeid=9 \
> -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
> -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on,ats=on,ril=off,ssidsize=20,oas=48 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=512G,id=dev0 \
> -device vfio-pci,host=0019:06:00.0,rombar=0,id=dev0,iommufd=iommufd0,bus=pcie.port1,x-vpasid-cap-offset=0xff8 \
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> ...
> -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
> -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.1,accel=on,ats=on,ril=off,ssidsize=20,oas=48 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2,pref64-reserve=512G \
> -device vfio-pci,host=0018:06:00.0,rombar=0,id=dev1,iommufd=iommufd0,bus=pcie.port2,x-vpasid-cap-offset=0xff8 \
> -device virtio-blk-device,drive=fs \
> -drive file=image.qcow2,index=0,media=disk,format=qcow2,if=none,id=fs \
> -net none \
> -nographic
>
> Details from RFCv3 Cover letter:
> -------------------------------
> https://lore.kernel.org/qemu-devel/20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com/
>
> This patch series introduces initial support for a user-creatable,
> accelerated SMMUv3 device (-device arm-smmuv3,accel=on) in QEMU.
>
> This is based on the user-creatable SMMUv3 device series [0].
>
> Why this is needed:
>
> On ARM, to enable vfio-pci pass-through devices in a VM, the host SMMUv3
> must be set up in nested translation mode (Stage 1 + Stage 2), with
> Stage 1 (S1) controlled by the guest and Stage 2 (S2) managed by the host.
>
> This series introduces an optional accel property for the SMMUv3 device,
> indicating that the guest will try to leverage host SMMUv3 features for
> acceleration. By default, enabling accel configures the host SMMUv3 in
> nested mode to support vfio-pci pass-through.
>
> This new accelerated, user-creatable SMMUv3 device lets you:
>
>  -Set up a VM with multiple SMMUv3s, each tied to a different physical SMMUv3
>   on the host. Typically, you’d have multiple PCIe PXB root complexes in the
>   VM (one per virtual NUMA node), and each of them can have its own SMMUv3.
>   This setup mirrors the host's layout, where each NUMA node has its own
>   SMMUv3, and helps build VMs that are more aligned with the host's NUMA
>   topology.
>
>  -The host–guest SMMUv3 association results in reduced invalidation broadcasts
>   and lookups for devices behind different physical SMMUv3s.
>
>  -Simplifies handling of host SMMUv3s with differing feature sets.
>
>  -Lays the groundwork for additional capabilities like vCMDQ support.
> -------------------------------
>
> Eric Auger (2):
>   hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
>   hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
>     binding
>
> Nicolin Chen (4):
>   backends/iommufd: Introduce iommufd_backend_alloc_viommu
>   backends/iommufd: Introduce iommufd_backend_alloc_vdev
>   hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
>   hw/arm/smmuv3-accel: Add nested vSTE install/uninstall support
>
> Shameer Kolothum (31):
>   hw/arm/smmu-common: Factor out common helper functions and export
>   hw/arm/smmu-common: Make iommu ops part of SMMUState
>   hw/arm/smmuv3-accel: Introduce smmuv3 accel device
>   hw/arm/smmuv3-accel: Initialize shared system address space
>   hw/pci/pci: Move pci_init_bus_master() after adding device to bus
>   hw/pci/pci: Add optional supports_address_space() callback
>   hw/pci-bridge/pci_expander_bridge: Move TYPE_PXB_PCIE_DEV to header
>   hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
>     with iommufd
>   hw/arm/smmuv3: Implement get_viommu_cap() callback
>   hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to caller
>   hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
>   hw/pci/pci: Introduce a callback to retrieve the MSI doorbell GPA
>     directly
>   hw/arm/smmuv3-accel: Implement get_msi_direct_gpa callback
>   hw/arm/virt: Set msi-gpa property
>   hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
>   hw/arm/smmuv3: Initialize ID registers early during realize()
>   hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
>   hw/arm/virt: Set PCI preserve_config for accel SMMUv3
>   tests/qtest/bios-tables-test: Prepare for IORT revison upgrade
>   tests/qtest/bios-tables-test: Update IORT blobs after revision upgrade
>   hw/arm/smmuv3: Block migration when accel is enabled
>   hw/arm/smmuv3: Add accel property for SMMUv3 device
>   hw/arm/smmuv3-accel: Add a property to specify RIL support
>   hw/arm/smmuv3-accel: Add support for ATS
>   hw/arm/smmuv3-accel: Add property to specify OAS bits
>   backends/iommufd: Retrieve PASID width from
>     iommufd_backend_get_device_info()
>   backends/iommufd: Add get_pasid_info() callback
>   hw/pci: Add helper to insert PCIe extended capability at a fixed
>     offset
>   hw/pci: Factor out common PASID capability initialization
>   hw/vfio/pci: Synthesize PASID capability for vfio-pci devices
>   hw/arm/smmuv3-accel: Make SubstreamID support configurable
>
>  backends/iommufd.c                            |  76 +-
>  backends/trace-events                         |   2 +
>  hw/arm/Kconfig                                |   5 +
>  hw/arm/meson.build                            |   3 +-
>  hw/arm/smmu-common.c                          |  51 +-
>  hw/arm/smmuv3-accel.c                         | 768 ++++++++++++++++++
>  hw/arm/smmuv3-accel.h                         |  88 ++
>  hw/arm/smmuv3-internal.h                      |   1 +
>  hw/arm/smmuv3.c                               | 227 +++++-
>  hw/arm/trace-events                           |   6 +
>  hw/arm/virt-acpi-build.c                      | 127 ++-
>  hw/arm/virt.c                                 |  39 +-
>  hw/pci-bridge/pci_expander_bridge.c           |   1 -
>  hw/pci-host/gpex-acpi.c                       |  29 +-
>  hw/pci/pci.c                                  |  43 +-
>  hw/pci/pcie.c                                 |  88 +-
>  hw/vfio/iommufd.c                             |   6 +-
>  hw/vfio/pci.c                                 |  75 ++
>  hw/vfio/pci.h                                 |   1 +
>  hw/vfio/trace-events                          |   1 +
>  include/hw/arm/smmu-common.h                  |   7 +
>  include/hw/arm/smmuv3-common.h                |  27 +-
>  include/hw/arm/smmuv3.h                       |  10 +
>  include/hw/arm/virt.h                         |   1 +
>  include/hw/core/iommu.h                       |   1 +
>  include/hw/pci-host/gpex.h                    |   1 +
>  include/hw/pci/pci.h                          |  36 +
>  include/hw/pci/pci_bridge.h                   |   1 +
>  include/hw/pci/pcie.h                         |   4 +
>  include/system/host_iommu_device.h            |  20 +
>  include/system/iommufd.h                      |  29 +-
>  target/arm/kvm.c                              |  18 +-
>  tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
>  .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
>  36 files changed, 1692 insertions(+), 100 deletions(-)
>  create mode 100644 hw/arm/smmuv3-accel.c
>  create mode 100644 hw/arm/smmuv3-accel.h
>


