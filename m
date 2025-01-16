Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAA2E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 07:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYJxM-0005LG-Us; Thu, 16 Jan 2025 02:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYJxK-0005Id-MJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYJxH-0006Z4-MK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737011173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E47Zn/fi7gZe/DzzSBjV6Emnp7HhUif7hclHDVtVWHc=;
 b=gfek9MS01t0nFAHBtJ4WCZUFry2CeHVlmElDwrY3i3OdGYL4UGsS3RsCNkJhFsdW9Hcg3L
 Y69pwgIuDrNsBd6Se8y3ayvZl1IzqJuj8luH96eD2v3r3RJ6Pw9V7kPwb4C9exDrMCIlpI
 qdB+5tFHzRldMNJrkE5qiFf27H/8wNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-dVq3xA92N1mkAw1OzoZCTQ-1; Thu, 16 Jan 2025 02:06:11 -0500
X-MC-Unique: dVq3xA92N1mkAw1OzoZCTQ-1
X-Mimecast-MFC-AGG-ID: dVq3xA92N1mkAw1OzoZCTQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so384791f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 23:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737011169; x=1737615969;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E47Zn/fi7gZe/DzzSBjV6Emnp7HhUif7hclHDVtVWHc=;
 b=tmDTy3dIyZSTNh5ZzVvzy1pANF+8mYvYHZikkLQ+b6G/wYKnyZ4I1HP9yHYYBv/6oA
 WxOrX5EHZIgIBtUAvO2qWd5WbcwE0kYjigx2kUmeWzogdlK69W0RHZPPcFG6dt1ngeWc
 zp2ORzplCzhXRni9afhXD+FW7eK+jTyNy0hutji4ZfJscupM706B76S0Zs5hIoraeeVO
 O6t72uS+Jy6t60fNRqZxcxODiQx7j1GcNdOVtW+PRaHn7zqLJjl82U8TAmLcc0ZnXZwA
 zomd1JA1zgzdJuHANl73+x703iGVJUXO2+lVCEN74qvTRAO82vJo10NO81BcnZ1gQxsk
 fSow==
X-Gm-Message-State: AOJu0Yzzb+ZYW+wDJ01FDrlTC6SuL12++P4Xyal4IYPhUjy33ULLWXfu
 0KgCkI2eM6qGODYMgAE6lOrtLEScTPpcxhIm+qxqroQoqJPSfpAjlMtwQGv7OYPWX3neNbEi0/D
 z6gXeiTcZN+xcP/gW1SQkhFBIsblKRScAZvgWkTAEDaxZmvj6wbyJxLxQTxirxOc91p1s0x7Ib4
 JwQNp7oqW/HLtgfrQ5TdOgGBhQbdSD6g==
X-Gm-Gg: ASbGncvme4iCPOAO3tN06XG96dJJZx9/i3gW9opryde/4g5TnYm9GaywgVN3x9yCz6N
 Nd9c/9Oc6zR8QXWWhLHJq9k560UAzNheRkbWeSBNTAhzSa5RCQAeycfWo0lDLEobOMcg3U74fg9
 lhamvze1NigbD1KR3sao7c3/MZrcsPTDW9LxsxBWo4F2l0UVxID8xjI15RyqlLlPTsn3bhq+cT4
 MpvLi8IGXLUxkQQ9M8VGOc6Ci17hDys6BbLkMkKAgQX6Fr2lGcJ
X-Received: by 2002:a05:6000:1f8d:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38a87305259mr28995846f8f.14.1737011169513; 
 Wed, 15 Jan 2025 23:06:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpFsK4Twma7/Q1YQJ+ESa35iuxB+eS/vm7JiwjQHk9Di+mVmKTuW6CVRu6DVi1A9wMgRSqAw==
X-Received: by 2002:a05:6000:1f8d:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38a87305259mr28995804f8f.14.1737011168959; 
 Wed, 15 Jan 2025 23:06:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bebccc93asm1312960f8f.17.2025.01.15.23.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 23:06:08 -0800 (PST)
Date: Thu, 16 Jan 2025 02:06:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/48] virtio,pc,pci: features, fixes, cleanups
Message-ID: <20250116020536-mutt-send-email-mst@kernel.org>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 15, 2025 at 01:08:28PM -0500, Michael S. Tsirkin wrote:
> The following changes since commit 7433709a147706ad7d1956b15669279933d0f82b:
> 
>   Merge tag 'hw-misc-20250113' of https://github.com/philmd/qemu into staging (2025-01-14 12:46:56 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 60f543ad917fad731e39ff8ce2ca83b9a9cc9d90:
> 
>   virtio-net: vhost-user: Implement internal migration (2025-01-15 13:07:34 -0500)


OK I missed including David's patch but he'll merge it himself.
So the request stands.

> ----------------------------------------------------------------
> virtio,pc,pci: features, fixes, cleanups
> 
> The big thing here are:
> stage-1 translation in vtd
> internal migration in vhost-user
> ghes driver preparation for error injection
> new resource uuid feature in virtio gpu
> 
> And as usual, fixes and cleanups.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Clément Mathieu--Drif (4):
>       intel_iommu: Check if the input address is canonical
>       intel_iommu: Set accessed and dirty bits during stage-1 translation
>       intel_iommu: Add an internal API to find an address space with PASID
>       intel_iommu: Add support for PASID-based device IOTLB invalidation
> 
> Dorinda Bassey (1):
>       virtio-gpu: Add definition for resource_uuid feature
> 
> Igor Mammedov (6):
>       tests: acpi: whitelist expected blobs
>       cpuhp: make sure that remove events are handled within the same SCI
>       tests: acpi: update expected blobs
>       tests: acpi: whitelist expected blobs
>       pci: acpi: Windows 'PCI Label Id' bug workaround
>       tests: acpi: update expected blobs
> 
> Laurent Vivier (2):
>       vhost: Add stubs for the migration state transfer interface
>       virtio-net: vhost-user: Implement internal migration
> 
> Li Zhijian (1):
>       hw/cxl: Fix msix_notify: Assertion `vector < dev->msix_entries_nr`
> 
> Mauro Carvalho Chehab (16):
>       acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
>       acpi/ghes: simplify acpi_ghes_record_errors() code
>       acpi/ghes: simplify the per-arch caller to build HEST table
>       acpi/ghes: better handle source_id and notification
>       acpi/ghes: Fix acpi_ghes_record_errors() argument
>       acpi/ghes: Remove a duplicated out of bounds check
>       acpi/ghes: Change the type for source_id
>       acpi/ghes: don't check if physical_address is not zero
>       acpi/ghes: make the GHES record generation more generic
>       acpi/ghes: better name GHES memory error function
>       acpi/ghes: don't crash QEMU if ghes GED is not found
>       acpi/ghes: rename etc/hardware_error file macros
>       acpi/ghes: better name the offset of the hardware error firmware
>       acpi/ghes: move offset calculus to a separate function
>       acpi/ghes: Change ghes fill logic to work with only one source
>       docs: acpi_hest_ghes: fix documentation for CPER size
> 
> Nicholas Piggin (1):
>       pci/msix: Fix msix pba read vector poll end calculation
> 
> Sebastian Ott (1):
>       pci: ensure valid link status bits for downstream ports
> 
> Yi Liu (2):
>       intel_iommu: Rename slpte to pte
>       intel_iommu: Implement stage-1 translation
> 
> Yu Zhang (1):
>       intel_iommu: Use the latest fault reasons defined by spec
> 
> Zhenzhong Duan (13):
>       intel_iommu: Make pasid entry type check accurate
>       intel_iommu: Add a placeholder variable for scalable mode stage-1 translation
>       intel_iommu: Flush stage-2 cache in PASID-selective PASID-based iotlb invalidation
>       intel_iommu: Check stage-1 translation result with interrupt range
>       intel_iommu: Flush stage-1 cache in iotlb invalidation
>       intel_iommu: Process PASID-based iotlb invalidation
>       intel_iommu: piotlb invalidation should notify unmap
>       tests/acpi: q35: allow DMAR acpi table changes
>       intel_iommu: Set default aw_bits to 48 starting from QEMU 9.2
>       tests/acpi: q35: Update host address width in DMAR
>       intel_iommu: Introduce a property x-flts for stage-1 translation
>       intel_iommu: Introduce a property to control FS1GP cap bit setting
>       tests/qtest: Add intel-iommu test
> 
>  hw/i386/intel_iommu_internal.h                    | 101 ++-
>  include/hw/acpi/ghes.h                            |  16 +-
>  include/hw/i386/intel_iommu.h                     |   8 +-
>  include/hw/virtio/vhost.h                         |  23 +
>  include/hw/virtio/virtio-gpu.h                    |   3 +
>  hw/acpi/cpu.c                                     |  43 +-
>  hw/acpi/generic_event_device.c                    |   4 +-
>  hw/acpi/ghes-stub.c                               |   2 +-
>  hw/acpi/ghes.c                                    | 256 ++++----
>  hw/arm/virt-acpi-build.c                          |   5 +-
>  hw/display/vhost-user-gpu.c                       |   8 +
>  hw/display/virtio-gpu-base.c                      |   3 +
>  hw/i386/acpi-build.c                              |  33 +-
>  hw/i386/intel_iommu.c                             | 734 +++++++++++++++++-----
>  hw/i386/pc.c                                      |   1 +
>  hw/mem/cxl_type3.c                                |   2 +-
>  hw/net/virtio-net.c                               | 135 +++-
>  hw/pci/msix.c                                     |   2 +-
>  hw/pci/pcie.c                                     |  12 +-
>  target/arm/kvm.c                                  |   2 +-
>  tests/qtest/intel-iommu-test.c                    |  64 ++
>  MAINTAINERS                                       |   1 +
>  docs/specs/acpi_hest_ghes.rst                     |   6 +-
>  tests/data/acpi/x86/pc/DSDT                       | Bin 8526 -> 8611 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst              | Bin 8437 -> 8522 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat              | Bin 9851 -> 9936 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge                | Bin 15397 -> 15482 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp                  | Bin 8990 -> 9075 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm               | Bin 10180 -> 10265 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge              | Bin 8477 -> 8562 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot              | Bin 5033 -> 5100 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs               | Bin 8598 -> 8683 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp                 | Bin 9885 -> 9970 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet                | Bin 8384 -> 8469 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem               | Bin 8532 -> 8617 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp                | Bin 12319 -> 12404 bytes
>  tests/data/acpi/x86/q35/DMAR.dmar                 | Bin 120 -> 120 bytes
>  tests/data/acpi/x86/q35/DSDT                      | Bin 8355 -> 8440 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst             | Bin 8372 -> 8457 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat             | Bin 9680 -> 9765 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x   | Bin 12565 -> 12650 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator | Bin 8634 -> 8719 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc             | Bin 8401 -> 8486 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge               | Bin 11968 -> 12053 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count           | Bin 12913 -> 12998 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2          | Bin 33770 -> 33855 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp                 | Bin 8819 -> 8904 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl                  | Bin 13146 -> 13231 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm              | Bin 10009 -> 10094 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt               | Bin 8430 -> 8515 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus            | Bin 8443 -> 8528 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs                 | Bin 8372 -> 8457 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp                | Bin 9714 -> 9799 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64               | Bin 9485 -> 9570 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge         | Bin 13208 -> 13293 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp             | Bin 8235 -> 8302 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet               | Bin 8213 -> 8298 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem              | Bin 8361 -> 8446 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa          | Bin 8456 -> 8541 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count         | Bin 12913 -> 12998 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2        | Bin 33770 -> 33855 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12            | Bin 8961 -> 9046 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2             | Bin 8987 -> 9072 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count          | Bin 18589 -> 18674 bytes
>  tests/data/acpi/x86/q35/DSDT.viot                 | Bin 14612 -> 14697 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic                | Bin 35718 -> 35803 bytes
>  tests/qtest/meson.build                           |   1 +
>  67 files changed, 1132 insertions(+), 333 deletions(-)
>  create mode 100644 tests/qtest/intel-iommu-test.c
> 


