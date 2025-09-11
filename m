Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC94CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwpHx-0004pR-LD; Thu, 11 Sep 2025 17:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uwpHv-0004ot-Or
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uwpHt-00052T-1k
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757627823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeJBnIxI7fCyyv5uMKIJP4CDgBtM5fDDyIX6A5uoIDk=;
 b=Iz1aq39LCT8rEdqhCbkeoCXzWjutIsq7g9PSbFShTCFBNB0q0F9OpwaAMDPGMgLHUFuiY4
 oxZRfdVZYRblXtK1xAreBBOoOUup92uds8y6F9u/OINJnfXCbDXGybY5woHnvzDnKHnu2C
 Q8U4BZWIW9f2MCzlm0uSIDD87PXBVWg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-jbu6rqxlOvukGbBlfni8gQ-1; Thu, 11 Sep 2025 17:55:19 -0400
X-MC-Unique: jbu6rqxlOvukGbBlfni8gQ-1
X-Mimecast-MFC-AGG-ID: jbu6rqxlOvukGbBlfni8gQ_1757627719
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b5eb7b2c05so29331141cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627719; x=1758232519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SeJBnIxI7fCyyv5uMKIJP4CDgBtM5fDDyIX6A5uoIDk=;
 b=AMiOZHxkkTEPvC+uOIxErSMBdG2Qus4fyUsfGT94zP7dYkMB4tAkOGsDmpk2JpmcWR
 FTsMfHxpAb5En4AjHkcln84vSJcxrfIzHw4WLP200idNmsixOdFy4rRVKbfKAR+R8i1h
 rBaWPOcsRkvS/w4o8gtbynR+h5rOq1Pb1uurX+FGwRWj5FJ2UrTIS3FcT/bithBfOkTl
 +5+1VTfXQdkDpiMr1XVsWChvq2shZy4NVsJZTPfC+8KYeviHgWyz4qn2r5x0ZzC1tuM/
 30g/B2kKEZGGLfOOWg6B6iH4J9/GV/CpSZwZDFU3HOrZla7mGtC4GYY/stvrDMwTs2CQ
 0u1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsCGrlj6HGKt8oySrjddyUGvmAXGxQRj4yh9ysLeH38L+2cTEUchcuy7Wj6+lmn9+mK1hCG5J9eFlP@nongnu.org
X-Gm-Message-State: AOJu0YyqxKE2kWRbIBJ4JC+DCkCkusFvCdTaS6VlzkH/ImBpn4jIb9uc
 iRzVerK1iLUBtpC9N/qrmT5maSrqgJT4L9sJxem2Ew9hSnxSBZMyFTLYSwTIiK9jZNlK9Tg1G4u
 4us2ThEMLjaXyBqp5QSmZy1JZAAS2UmPSdA7m7YNbZItM8JcgXHA7JT85
X-Gm-Gg: ASbGncuL83cctypbpSaZS/2Q+L7OslEbDbJg9ltMugmx3wB+DUtNbSoyMFNRARzHryF
 3+Qit1BZeScf5YG5UBwJKllkYFecSYqY7w6dK19/d2Rxsi9feLb9AoRgEDoixMk94ir3M2I+dPF
 /8iKOX1G0HAHjLTgfAc5uCe/dO7G9LCjL/al1Kbrm0Iks9U/oULUylajT3EkdHm3g9Rwdbl8o3R
 4oX9RgC3oC8hR16ytOs84ci1FGDD5I9A8O0Xk0+iChVK+KkxhQ4t1k8L/IpCjF0i4WtZts6Io5i
 Y1tNP69kZryuKz560M3DSKAIPnn9sUZW80prhqAW
X-Received: by 2002:ac8:7f43:0:b0:4b3:48f2:b8c9 with SMTP id
 d75a77b69052e-4b77d14e177mr8904561cf.60.1757627718790; 
 Thu, 11 Sep 2025 14:55:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1mcRVtot2RIJd/gtDwHQc/m7fWyppt29U/D0VWZ2bpuaRyPNRicnMYvA0+s99uY7mofxUqA==
X-Received: by 2002:ac8:7f43:0:b0:4b3:48f2:b8c9 with SMTP id
 d75a77b69052e-4b77d14e177mr8903571cf.60.1757627716456; 
 Thu, 11 Sep 2025 14:55:16 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763b3f4ab6asm16992086d6.3.2025.09.11.14.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 14:55:15 -0700 (PDT)
Message-ID: <e80211ce-e99e-4857-a4b4-ddc144c372f9@redhat.com>
Date: Thu, 11 Sep 2025 17:55:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/29/25 4:25 AM, Shameer Kolothum wrote:
> Hi,
> 
> Changes from v8:
> https://lore.kernel.org/qemu-devel/20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com/
> 
> 1.Dropped previous patch #1 as that one is now already in.
> 2.Rebased and updated DSDT in patch #11 to make bios table tests happy.
>    The DSDT has changed since Eric's PCI hotplug series work.
> 3.Added T-by tags from Nicolin. Thanks!.
> 
> I think this is in a good shape now. Please take a look.
> 
> Thanks,
> Shameer
> 
> Changes from v7:
> https://lore.kernel.org/qemu-devel/20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com/
> 
> 1. Rebased to latest target-arm.next(I have included patch#1
>     as I can't find that after a git pull of latest)
> 2. Addressed comments from Nicolin and added R-by tags. Thanks!
> 
> Changes from v6:
> https://lore.kernel.org/qemu-devel/20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com/
> 
> 1. Fixed the warning case for DT support, reported by Eric(patch #1).
> 2. Picked up R-by's and T-by's. Thanks!
> 
> Changes from v5:
> https://lore.kernel.org/qemu-devel/20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com/
> 
> 1. Rebased to target-arm.next and resolved conflicts with the series
>     [PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off'.
> 2. While at it, noticed an issue with RC id mappings creation
>     and patch #1 is a fix for that.
> 3. Patches 3 and 4 have changes because of the conflict resolution with the
>     above series. I have retained the R-by tags, but encourage all to take
>     another look in case I missed anything.
> 4. Collected R-by and T-by tags. Thanks!.
> 
> Changes from v4:
> https://lore.kernel.org/qemu-devel/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/
> 
> Major changes from v4:
> 
> 1. Added stricter validation for PCI buses associated with the SMMU.
>     Only the default PCIe Root Complex (pcie.0) and additional root
>     complexes created using pxb-pcie (see patch #1) are allowed.
> 
> 2. While testing this series with a setup involving multiple PCIe root
>     complexes using pxb-pcie, I encountered an issue related to IOMMU
>     ops resolution. Consider the below configuration, where an
>     arm-smmuv3 device is associated with the default root complex pcie.0,
>     and an additional pxb-pcie-based root complex (pcie.1) is added
>     without any associated SMMU:
> 
>     -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \
>     ...
>     -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
>     -device pcie-root-port,id=pcie.port1,chassis=2,bus=pcie.1 \
>     -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.2 \
>     ...
>     -device virtio-net-pci,bus=pcie.0,netdev=net0,id=virtionet.0 \
>     -device virtio-net-pci,bus=pcie.port1,netdev=net1,id=virtionet.1
> 
>     The guest boots fine, and virtionet.0(behind the SMMUV3) bring up
>     is successful. However, attempting to bring up virtionet.1
>     (behind pcie.1, which lacks a connected SMMU) results in a failure:
> 
>     root@ubuntu:/# dhclient enp9s0
>     arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
>     arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000090000000002
>     arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
>     arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
>     arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
>     arm-smmu-v3 arm-smmu-v3.0.auto: event: C_BAD_STREAMID client: (unassigned sid) sid: 0x900 ssid: 0x0
>     virtio_net virtio1 enp9s0: NETDEV WATCHDOG: CPU: 2: transmit queue 0 timed out 5172 ms
>     virtio_net virtio1 enp9s0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5172000 usecs ago
>     ...
> 
>     Debug shows that QEMU currently registers IOMMU ops for bus using
>     pci_setup_iommu(). However, when retrieving IOMMU ops for a device
>     via pci_device_get_iommu_bus_devfn(), the function walks up to the
>     parent_dev and fetches the IOMMU ops from the parent, even if the
>     current root bus has none configured.
> 
>     This works today because existing IOMMU models in QEMU are globally
>     scoped, and pxb-pcie based extra root complexes can use the
>     bypass_iommu property to skip translation as needed.
> 
>     However, with this series introducing support for associating
>     arm-smmuv3 devices with specific PCIe root complexes, this
>     becomes problematic. In QEMU, pxb-pcie is implemented as a synthetic
>     root complex whose parent_dev is pcie.0. As a result, even though
>     pcie.1 has no SMMU attached, pci_device_get_iommu_bus_devfn()
>     incorrectly returns the IOMMU ops associated with pcie.0 due to
>     the fallback mechanism via parent_dev. This causes devices on
>     pcie.1 to erroneously use the address space from pcie.0's SMMU,
>     leading to failures like the one above.
> 
>     To address this, patch #6 in the series introduces a new helper
>     function pci_setup_iommu_per_bus(), which explicitly sets the
>     iommu_per_bus field in the PCIBus structure. This allows
>     pci_device_get_iommu_bus_devfn() to retrieve IOMMU ops based
>     on the specific bus.
> 
>     Not sure this is the correct approach or not. If there is a better
>     way to handle this, please let me know .
> 
> 3. Picked up few R-by tags where the patch content has not changed much.
> 
> 4. Dropped T-by from Nathan for some patches as things have changed a bit.
>     @Nathan, apprecaite if you have time to rerun the tests.
> 
> 5. Added a bios table tests for both legacy SMMUv3 and new SMMMv3 devices.
>     See last few patches.
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
>   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
>    ...
>   -device arm-smmuv3,primary-bus=pcie.1,,id=smmuv3.1
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
>    "-device arm-smmuv3" model.
>    -Adds device tree bindings for the new SMMUv3 device on the arm/virt
>     machine only, and only for the default pcie.0 root complex.
>     (Note: pxb-pcie root complexes are currently not supported with the
>      device tree due to known limitations[1].)
> 
> Example usage:
>    -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
>    -device virtio-net-pci,bus=pcie.0
>    -device pxb-pcie,id=pcie.1,bus_nr=2
>    -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
>    -device pcie-root-port,id=pcie.port1,bus=pcie.1
>    -device virtio-net-pci,bus=pcie.port1
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> [0]:https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
> [1]:https://lore.kernel.org/qemu-devel/20230421165037.2506-1-Jonathan.Cameron@huawei.com/
> 
> Nicolin Chen (1):
>    hw/arm/virt: Add an SMMU_IO_LEN macro
> 
> Shameer Kolothum (10):
>    hw/arm/smmu-common: Check SMMU has PCIe Root Complex association
>    hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
>    hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
>    hw/arm/virt: Factor out common SMMUV3 dt bindings code
>    hw/pci: Introduce pci_setup_iommu_per_bus() for per-bus IOMMU ops
>      retrieval
>    hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
>    qemu-options.hx: Document the arm-smmuv3 device
>    bios-tables-test: Allow for smmuv3 test data.
>    qtest/bios-tables-test: Add tests for legacy smmuv3 and smmuv3 device
>    qtest/bios-tables-test: Update tables for smmuv3 tests
> 
>   hw/arm/smmu-common.c                          |  37 +++-
>   hw/arm/smmuv3.c                               |   2 +
>   hw/arm/virt-acpi-build.c                      | 201 ++++++++++++++----
>   hw/arm/virt.c                                 | 111 +++++++---
>   hw/core/sysbus-fdt.c                          |   3 +
>   hw/pci-bridge/pci_expander_bridge.c           |   1 -
>   hw/pci/pci.c                                  |  31 +++
>   include/hw/arm/smmu-common.h                  |   1 +
>   include/hw/arm/virt.h                         |   1 +
>   include/hw/pci/pci.h                          |   2 +
>   include/hw/pci/pci_bridge.h                   |   1 +
>   include/hw/pci/pci_bus.h                      |   1 +
>   qemu-options.hx                               |   7 +
>   tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 0 -> 10230 bytes
>   .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10230 bytes
>   tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 0 -> 364 bytes
>   .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
>   tests/qtest/bios-tables-test.c                |  86 ++++++++
>   18 files changed, 410 insertions(+), 75 deletions(-)
>   create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
>   create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
>   create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
>   create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
> 
Apologies for delayed response; lots to catch up on after extended PTO.

Final cleanup from v8 looks good, and +1 on Nicolin's testing!

for series:
Reviewed-by: Donald Dutile <ddutile@redhat.com>


