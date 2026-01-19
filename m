Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAC8D29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq80-00040Q-TA; Mon, 19 Jan 2026 09:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vhq7z-0003z8-3F
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vhq7x-0002d2-2D
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768832467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Md4u4B3qPMGYpyekR4QheAwPqVi2i6kfTWLfVbjDkYw=;
 b=Bwfnmhb99UmuYMm66pX7kxpGlCeXZyIm/A4UgGyM0HrB+PH0dkKoeKML+X4L5NfEmRlglu
 taM1ySJlnLsQAuocjF7JE4ugBbd3HUyrwpSWN/sT5FuQkAItgcu1+tdJBNKG15DyX5yMnI
 YjQHk5WA680BVgRyMHJD9K+7no/cM3s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-hsyHFPMtMoq9llTnRVjscQ-1; Mon, 19 Jan 2026 09:21:04 -0500
X-MC-Unique: hsyHFPMtMoq9llTnRVjscQ-1
X-Mimecast-MFC-AGG-ID: hsyHFPMtMoq9llTnRVjscQ_1768832463
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so1994440f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768832463; x=1769437263; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Md4u4B3qPMGYpyekR4QheAwPqVi2i6kfTWLfVbjDkYw=;
 b=tQQhR63HtdajHgHdaK960XGuv6CDqoQgFJQcMYsTD2yI4zB4mfIjpvAhTwO92P9BAf
 +FJoQ7igE9bWBhHWqzKoaOfNc/Epu48830wZ3VJZWBRM7Gf78NarZox2XqCrGDkcSiN8
 lC0KNGOprx5bOLl9ODJPO4McP8e3bgDVoCskAciJmyFVl2iXL+fYFhrOARR9vWyHaMDr
 GNTACm5z264upBmmoL8r1FQQaL5k1NVcoS46lSwpNuCKUe4vpWqzKLD+1GUr6LT+0sfB
 JUDAW+0r54q7+DU66A5U7AFDJ8PJy2SmnMcdUDNmbUtsko7pW4BiTwETksPe0bsf9IXc
 F37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768832463; x=1769437263;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Md4u4B3qPMGYpyekR4QheAwPqVi2i6kfTWLfVbjDkYw=;
 b=CqnuwUUzWFjrpnb8S3vbSJrWdnDKn625P8nbCpdAy1fEJ/sCuFmvc0H0V5N68cS03F
 F8jGgFEN5BnI9eQgz9Hu3QraMf03A0Qvsorcv8ENmseBq1P9I7oLE2eGLaZHUIcDRSeW
 3InjVQZim/c+wo/Oy4erwsNHQbngJOIBbSS4BkhMAxN3B+6VV6dTRPIbLRSPJOCldsXl
 Y+TdBGM7KkbYQsxhJkA6gLUYB1qfxxZhrEyfkEL1Dl1CSwi6d8PlSKHCvgHgwMEebw8B
 Ui4z8JaJq2Ci48dVyo6oNGnOy1EbHVe5dMYOaGhKZWXJIwpTRK59nDVjbH0GmQ7By2Zq
 ZZiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBEtiEdROPhgGBNM4riiuRSmdM9UwX75aHi1DrU2nBN+pYJs4a4/nuMIqP2yTk7v6Z2q4GDd5gzRyg@nongnu.org
X-Gm-Message-State: AOJu0YxhQc9QiRI//CCr10UU5XUByPcucnjJHiODvwbx6L80XFXD4BIl
 oYSyrOlbmrA1tZYqOgGCN93V5JDiJjd/BzjbVgG0aXhlmdLNJsxIJQAJplid3befJthcvWWgSUs
 0evOiiUsDkXzma1HjGNm6pLRleJWIJy79+X48BE5pumrvWt2KHNBcLYn1
X-Gm-Gg: AZuq6aIWgTy5YKv20p2FGXnH0oVrUV4+F1ZrFOKx0q4YR1dUC1a5JwGdSmVpCHpyDO+
 BXsW0d8UsEyOJfRkO/E8pSFKOufJE3ofnEBGKJqCyOV07IVrCSM8O+eIqCWEO61JXZuMLIOHOvB
 NvSoaNgG3wPzLsPjQ23aYYEnpPIupI6ed6ww+YzHAqgcGGAPqkvVz6nl1f34eEVcMR5TOc4qcyN
 Rg8W+ARNrUnPXwqGnODCKQtRSlYcvizEtJmv1wU692UqDp+1AE2x1nKSa/bXyzrxGngvryfjeJE
 GnJel8tG8xIJHfV7QbNt5qSQbHVzD1T8LS5J85SujAjF737CamMw+cvfq50Yi9VuVvVkCj324Cb
 nztCphkmfdv5gBFtGkneRHetSqk3vEWs=
X-Received: by 2002:a05:6000:609:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-4356a05d519mr14359916f8f.50.1768832462549; 
 Mon, 19 Jan 2026 06:21:02 -0800 (PST)
X-Received: by 2002:a05:6000:609:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-4356a05d519mr14359831f8f.50.1768832461865; 
 Mon, 19 Jan 2026 06:21:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm23537241f8f.11.2026.01.19.06.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 06:21:01 -0800 (PST)
Date: Mon, 19 Jan 2026 09:20:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com,
 alex@shazbot.org, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, kjaju@nvidia.com
Subject: Re: [PATCH v7 00/36] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Message-ID: <20260119092047-mutt-send-email-mst@kernel.org>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jan 11, 2026 at 07:52:46PM +0000, Shameer Kolothum wrote:
> Hi,
> 
> Major changes since v6:
>  https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/
> 
>  - Addressed feedback from v6 and picked up R-by tags. Thanks!
>  - Fixed build and compilation issues reported on multiple architectures.
>  - Reworked and introduced a HostIOMMUDeviceClass callback to retrieve
>    pasid info(patch #32)
>  - Added an helper to insert a CAP ID at an offset in PCIe config space
>    (patch #33)
>  - Added an x-vpasid-cap-offset property for vfio-pci devices to allow
>    opt-in synthesis of the PASID capability (patch #35).
>  - Renamed the pasid property to ssidsize (patch #36).
>  - VFIO/IOMMUFD changes depend on Zhenzhong’s pass-through support series,
>    patches 4/5/8 [0].


PCI bits:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Patch organization:
> 
> 1–27: Enable accelerated SMMUv3 with features aligned to the default QEMU
> SMMUv3 implementation, including IORT RMR-based MSI support.
> 
> 28–30: Add user-configurable options for RIL, ATS, and OAS features.
> 
> 31–36: Add PASID support, including required VFIO changes.
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
> A complete branch can be found here,
> https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v7-ext
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/20260106061304.314546-1-zhenzhong.duan@intel.com/
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
> Nicolin Chen (3):
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
>  backends/iommufd.c                            |  50 +-
>  backends/trace-events                         |   1 +
>  hw/arm/Kconfig                                |   5 +
>  hw/arm/meson.build                            |   3 +-
>  hw/arm/smmu-common.c                          |  51 +-
>  hw/arm/smmuv3-accel.c                         | 768 ++++++++++++++++++
>  hw/arm/smmuv3-accel.h                         |  88 ++
>  hw/arm/smmuv3-internal.h                      |  30 +-
>  hw/arm/smmuv3.c                               | 227 +++++-
>  hw/arm/trace-events                           |   6 +
>  hw/arm/virt-acpi-build.c                      | 127 ++-
>  hw/arm/virt.c                                 |  40 +-
>  hw/pci-bridge/pci_expander_bridge.c           |   1 -
>  hw/pci-host/gpex-acpi.c                       |  29 +-
>  hw/pci/pci.c                                  |  43 +-
>  hw/pci/pcie.c                                 |  77 +-
>  hw/vfio/iommufd.c                             |   7 +-
>  hw/vfio/pci.c                                 |  84 ++
>  hw/vfio/pci.h                                 |   1 +
>  include/hw/arm/smmu-common.h                  |   7 +
>  include/hw/arm/smmuv3.h                       |  10 +
>  include/hw/arm/virt.h                         |   1 +
>  include/hw/core/iommu.h                       |   1 +
>  include/hw/pci-host/gpex.h                    |   1 +
>  include/hw/pci/pci.h                          |  36 +
>  include/hw/pci/pci_bridge.h                   |   1 +
>  include/hw/pci/pcie.h                         |   4 +
>  include/system/host_iommu_device.h            |  18 +
>  include/system/iommufd.h                      |  15 +-
>  target/arm/kvm.c                              |  18 +-
>  tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
>  .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
>  34 files changed, 1650 insertions(+), 100 deletions(-)
>  create mode 100644 hw/arm/smmuv3-accel.c
>  create mode 100644 hw/arm/smmuv3-accel.h
> 
> -- 
> 2.43.0
> 
> 


