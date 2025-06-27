Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D74AC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8Jy-00005R-KQ; Fri, 27 Jun 2025 08:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV8Jv-000052-2j
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV8Jq-0004Kn-Pt
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751027797;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fh415M1Ib7H+uUOsqnFt5Zc3zlDQJY1oTzK8ervbctU=;
 b=fOGGDnl7NVCut4Gp+xc2LG7mUky8yD/W4S1vp/DTttpgQ6yRF71KRWIEePKIbb7a8eIPT2
 RRmS46oIeyn+6Sh5Cw6ZyQFXxtM0YGsBb/nbiq1KlMJS5spJ7aZUqeAYo7ee9dwvyEJvTk
 Du5WdxY1SIEr6OjPzbTolcJGefb2B6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-mHl8pUZAMI--eeGlVp0xtw-1; Fri, 27 Jun 2025 08:36:36 -0400
X-MC-Unique: mHl8pUZAMI--eeGlVp0xtw-1
X-Mimecast-MFC-AGG-ID: mHl8pUZAMI--eeGlVp0xtw_1751027795
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d90929d6so897310f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751027795; x=1751632595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fh415M1Ib7H+uUOsqnFt5Zc3zlDQJY1oTzK8ervbctU=;
 b=P+VbvxtCh7TVUYX+/J/a3g2V2GFrR5jZNFvnu2y6/HG7LllihdfQjlTMo1c8bXb1tN
 BSZqvBd7bsRb7K8BD25qlJLlxCu4sR9nwEs5xLeAzRR7giJHRUGRtJ+Grvkwn/8UVypv
 M2G6qY71Pt3fhQssjx3QMOwjI1p3Obj+JLdaCcvJiyvdY946RQx706QcwWwdkmL+h+ME
 atZ/N4Pr57Vl1eFsRFH0DWLxmP6EO/MbkgPNSs5dV1diHi3Vgf0VFz0ar8/rc5GHwz2K
 /g5b6WWpqw7NGPYzuh+xja13AnWZY28BfOMzt5I28ynF3PMoie+xSK+JbUeJONOw//qk
 c3mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ADVhY9KAEAI/5ndJaKMCNMAlmPaZ6Ph+1ik+X29kbShFsdMHTJ/4IHG/8Lekeuoz/VKs0h3wVE1r@nongnu.org
X-Gm-Message-State: AOJu0YwtwTuwpcHnzzmJIhIPgC6+k8CabG5zjZ9QGrKZPdqvPvBT7WtF
 uRG7jPgIi9Gu8pBqCubCBjKNvlkcAE7OnLmiS/8Mo2bkbubSnad4wnu0CyvKFmwn6oMuLLLIOpl
 gyBqN5ZtVBJ3DZZ/1oQVFJ4B5Q0HNZsJeWF76AviTLZi0AnlTPw1hNEhA
X-Gm-Gg: ASbGncv7QOYYLwheq1+LuB9Gn3hfKn43K4pRR4oC+vki5hphpZhjfpmLaGeG4/nUgWI
 x/q74dUOffvRVdQq61e5EQet+Z13APnXJadQp0QQo/m0OnbdzXM/LXsmsLiiI5E35k4lHQRnZnY
 D4+m3wJwRS+3bOVz+95kG2R2LpFRCdG5SeCagQXr/PYF7G42od3/+fj+qlk5AzhrFRBLT6THocK
 7JDARTbMBTqk8BzIU+LcTh9AKkpD0KkG/tdRjFSwzTpEa1hrLOHZ4w0BJaHfbcd1hqsnhibG60y
 exBVcoPvUnEAdGCmanDiFPWoxJek0tzVLm/f7pZX9xZqPfveISxhUjcBnO098NgFOijwVg==
X-Received: by 2002:a05:6000:290d:b0:3a4:e6d7:6160 with SMTP id
 ffacd0b85a97d-3a8f577fcbfmr3274172f8f.6.1751027794979; 
 Fri, 27 Jun 2025 05:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6XxGH2AjTq7BHdoq4v3deJyNKwUQERsuoasQetYpGdcQElwfPUMwvhvlB+g4Zf8lGc+KvcA==
X-Received: by 2002:a05:6000:290d:b0:3a4:e6d7:6160 with SMTP id
 ffacd0b85a97d-3a8f577fcbfmr3274120f8f.6.1751027794409; 
 Fri, 27 Jun 2025 05:36:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b5aesm2574885f8f.44.2025.06.27.05.36.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 05:36:31 -0700 (PDT)
Message-ID: <7a878419-d709-4da7-8b06-2c36a2b05287@redhat.com>
Date: Fri, 27 Jun 2025 14:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> Hi All,
>
> Changes from v4:
> https://lore.kernel.org/qemu-devel/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/
>
> Major changes from v4:
this will need a respin after merge of
f5ec751ee70d  hw/arm/virt: Check bypass iommu is not set for iommu-map
DT property

Thanks

Eric
>
> 1. Added stricter validation for PCI buses associated with the SMMU.
>    Only the default PCIe Root Complex (pcie.0) and additional root
>    complexes created using pxb-pcie (see patch #1) are allowed.
>
> 2. While testing this series with a setup involving multiple PCIe root
>    complexes using pxb-pcie, I encountered an issue related to IOMMU
>    ops resolution. Consider the below configuration, where an
>    arm-smmuv3 device is associated with the default root complex pcie.0,
>    and an additional pxb-pcie-based root complex (pcie.1) is added
>    without any associated SMMU:
>
>    -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \
>    ...
>    -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
>    -device pcie-root-port,id=pcie.port1,chassis=2,bus=pcie.1 \
>    -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.2 \
>    ...
>    -device virtio-net-pci,bus=pcie.0,netdev=net0,id=virtionet.0 \
>    -device virtio-net-pci,bus=pcie.port1,netdev=net1,id=virtionet.1
>
>    The guest boots fine, and virtionet.0(behind the SMMUV3) bring up
>    is successful. However, attempting to bring up virtionet.1
>    (behind pcie.1, which lacks a connected SMMU) results in a failure:
>
>    root@ubuntu:/# dhclient enp9s0
>    arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
>    arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000090000000002
>    arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
>    arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
>    arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
>    arm-smmu-v3 arm-smmu-v3.0.auto: event: C_BAD_STREAMID client: (unassigned sid) sid: 0x900 ssid: 0x0
>    virtio_net virtio1 enp9s0: NETDEV WATCHDOG: CPU: 2: transmit queue 0 timed out 5172 ms
>    virtio_net virtio1 enp9s0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5172000 usecs ago
>    ...
>
>    Debug shows that QEMU currently registers IOMMU ops for bus using
>    pci_setup_iommu(). However, when retrieving IOMMU ops for a device
>    via pci_device_get_iommu_bus_devfn(), the function walks up to the 
>    parent_dev and fetches the IOMMU ops from the parent, even if the
>    current root bus has none configured.
>
>    This works today because existing IOMMU models in QEMU are globally 
>    scoped, and pxb-pcie based extra root complexes can use the
>    bypass_iommu property to skip translation as needed.
>
>    However, with this series introducing support for associating
>    arm-smmuv3 devices with specific PCIe root complexes, this
>    becomes problematic. In QEMU, pxb-pcie is implemented as a synthetic
>    root complex whose parent_dev is pcie.0. As a result, even though
>    pcie.1 has no SMMU attached, pci_device_get_iommu_bus_devfn()
>    incorrectly returns the IOMMU ops associated with pcie.0 due to
>    the fallback mechanism via parent_dev. This causes devices on
>    pcie.1 to erroneously use the address space from pcie.0's SMMU,
>    leading to failures like the one above.
>
>    To address this, patch #6 in the series introduces a new helper 
>    function pci_setup_iommu_per_bus(), which explicitly sets the 
>    iommu_per_bus field in the PCIBus structure. This allows 
>    pci_device_get_iommu_bus_devfn() to retrieve IOMMU ops based 
>    on the specific bus.
>
>    Not sure this is the correct approach or not. If there is a better
>    way to handle this, please let me know .
>
> 3. Picked up few R-by tags where the patch content has not changed much.
>
> 4. Dropped T-by from Nathan for some patches as things have changed a bit.
>    @Nathan, apprecaite if you have time to rerun the tests.
>
> 5. Added a bios table tests for both legacy SMMUv3 and new SMMMv3 devices.
>    See last few patches.
>
> Cover letter:
>
> This patch series introduces support for a user-creatable SMMUv3 device
> (-device arm-smmuv3) in QEMU.
>
> The implementation is based on feedback received from the RFCv2[0]:
> "hw/arm/virt: Add support for user-creatable accelerated SMMUv3"
>
> Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the machine
> and does not support instantiating multiple SMMUv3 devices—each associated
> with a separate PCIe root complex. In contrast, real-world ARM systems
> often include multiple SMMUv3 instances, each bound to a different PCIe
> root complex.
>
> This series allows to specify multiple SMMUv3 instances as below,
>
>  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
>   ...
>  -device arm-smmuv3,primary-bus=pcie.1,,id=smmuv3.1
>
> The multiple SMMUv3 instance support lays the groundwork for supporting
> accelerated SMMUv3, as proposed in the aforementioned RFCv2[0]. The
> proposed accelerated support will be an optional property like below,
> -device arm-smmuv3,primary-bus=pcie.1,accel=on,..
>
> Please note, the accelerated SMMUv3 support is not part of this series
> and will be sent out as a separate series later on top of this one.
>
> This series also,
>
> -Supports either the legacy iommu=smmuv3 option or the new
>   "-device arm-smmuv3" model.
>   -Adds device tree bindings for the new SMMUv3 device on the arm/virt
>    machine only, and only for the default pcie.0 root complex.
>    (Note: pxb-pcie root complexes are currently not supported with the
>     device tree due to known limitations[1].)
>
> Example usage:
>   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
>   -device virtio-net-pci,bus=pcie.0
>   -device pxb-pcie,id=pcie.1,bus_nr=2
>   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
>   -device pcie-root-port,id=pcie.port1,bus=pcie.1
>   -device virtio-net-pci,bus=pcie.port1
>
> Please take a look and let me know your feedback.
>
> Thanks,
> Shameer
> [0]:https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
> [1]:https://lore.kernel.org/qemu-devel/20230421165037.2506-1-Jonathan.Cameron@huawei.com/
>
> Nicolin Chen (1):
>   hw/arm/virt: Add an SMMU_IO_LEN macro
>
> Shameer Kolothum (10):
>   hw/arm/smmu-common: Check SMMU has PCIe Root Complex association
>   hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
>   hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
>   hw/arm/virt: Factor out common SMMUV3 dt bindings code
>   hw/pci: Introduce pci_setup_iommu_per_bus() for per-bus IOMMU ops
>     retrieval
>   hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
>   qemu-options.hx: Document the arm-smmuv3 device
>   bios-tables-test: Allow for smmuv3 test data.
>   qtest/bios-tables-test: Add tests for legacy smmuv3 and smmuv3 device
>   qtest/bios-tables-test: Update tables for smmuv3 tests
>
>  hw/arm/smmu-common.c                          |  35 +++-
>  hw/arm/smmuv3.c                               |   2 +
>  hw/arm/virt-acpi-build.c                      | 164 ++++++++++++++----
>  hw/arm/virt.c                                 | 110 +++++++++---
>  hw/core/sysbus-fdt.c                          |   3 +
>  hw/pci-bridge/pci_expander_bridge.c           |   1 -
>  hw/pci/pci.c                                  |  25 +++
>  include/hw/arm/smmu-common.h                  |   1 +
>  include/hw/arm/virt.h                         |   1 +
>  include/hw/pci/pci.h                          |   2 +
>  include/hw/pci/pci_bridge.h                   |   1 +
>  include/hw/pci/pci_bus.h                      |   1 +
>  qemu-options.hx                               |   7 +
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 0 -> 10162 bytes
>  .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10162 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 0 -> 364 bytes
>  .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
>  tests/qtest/bios-tables-test.c                |  86 +++++++++
>  18 files changed, 375 insertions(+), 64 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
>


