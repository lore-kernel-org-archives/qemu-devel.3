Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED4DE9126B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntDU-0000zt-GK; Thu, 05 Feb 2026 01:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vntDP-0000ze-2E
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vntDM-0005Gs-A2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770274303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujQrZl2bkgx2vb1Gik4g+h25SaLSdLDNuxUZ/iIlNaA=;
 b=i1BKXzD0HkXEgrNGpwgUyXOfSYHxFqQYeYTvrVlJf+eaPf4nJl+h7ZOicgdlhhjBoMaDQE
 st9zLBJztZzQ08JbulnzyrH18fAjzbVKTXJ7mQQTwS7rY8g2zHug3j2Yaq2jnrITKNNG38
 34rxHSMoXFXqCGD5NpB893cjReKb0I0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-FZRmr7hrP7uInTsfSomAPQ-1; Thu, 05 Feb 2026 01:51:42 -0500
X-MC-Unique: FZRmr7hrP7uInTsfSomAPQ-1
X-Mimecast-MFC-AGG-ID: FZRmr7hrP7uInTsfSomAPQ_1770274301
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-482ef3af991so3052865e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 22:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770274300; x=1770879100; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ujQrZl2bkgx2vb1Gik4g+h25SaLSdLDNuxUZ/iIlNaA=;
 b=QbG9PdPjhyhywH480O1NXkQhrt5TZYeA+9BOiiU9TRGTsZGywgKi0rUzZkIpS0oyRa
 2CkCt2TOI6TpPi9uF+wTd9kdAMPpFEOcrUOCkg+HU34YUaYAFj9pwbmv4Q2M7otw/SSZ
 rMPAtptp37cPuDnzQJrG0lqy1+UfXQ8dGiIob7F7ML4c/chsYKi4d5mz3kPRDLb+Fi4v
 Un14QIRFVZual17IaOMrXFjx9UXBbmo7A2I26/+YB9ybJEFOYn9gTvPtYszYlyGrdhy3
 53CzRIiu3rnY4K7OWOwzhlm7ayV7BJd0JlowQdzT2R9ZyDSl9km2AXP5Bthge8L8E9j6
 KD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770274300; x=1770879100;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujQrZl2bkgx2vb1Gik4g+h25SaLSdLDNuxUZ/iIlNaA=;
 b=GrUzcBCnto6umHEWT+IqN6D+WxLHdQKPUZdKqFWmc7wMYJPqT4hwN+1HuJszWnv8vB
 zkf6asQ4myROij+1ufjhlT9tS2gJKhTVblV8+KocG1EiwLHjf52PtihfLdROU7YjWQOl
 GVSA0Fob9Bbneeb3KYZWQCKWcz83wLmWnEjvpGFiuwgchP6t45MY5mDYqys6cye1L9Su
 lanzFXrlQj4LFjHMhZ7HvfzJE/OOxBbLe0GY18MCrk5bCN9BqYanfJ9Ij+2iZgP+j6c9
 SEgGibO1qyFVBfm6HMwHmsVACTIKoaMhjVi2/3JkDV3MsfZmKr+ZwwJYCFvQKxnjskU7
 Dxqg==
X-Gm-Message-State: AOJu0YxQwU0GFfzss/lIzx38aqcowUv6qeE3Ihk38IVBbHe5drrJ1Jem
 9wT6Pt1cN5CqhIkw+PGkaslTUFxtIWwP94eDiwXnEfI7MuWMtE7Kp0DNW/bEgC2Gx7bZ+/4CBoq
 3vcl4kQ8iHpPyNMHNpgpXl06+21qBOFhNuPOluhmzrpeWoCXzcTOuu90NBaIs5PQt8Z2nbA0bLC
 MBDUoPoL1AHSoBpItcFAOckBX7BBh4A0vjhg==
X-Gm-Gg: AZuq6aJ7QUeDi7lm+0uIToXSLQVlgzDLhmzYk/6kKib6PG+9HBOSgIraBF1Bgbaubxe
 wgNDiGvigmk1B2aBv5HOuJMpkps4x/9DxGGT9rIm/qKEO6mZvRX0CiBAJAUXSyMTEgLfjnr3/Yh
 DX/GzgsmXMQboGKiIa2EiwiHTAegwqFv6cLPySEpsVGei676es2vOiP68Q8P5JbRrVIv/t62Cut
 NJFt/+XJfW1+Zi+l6xmoW+L0RP9INdakrerry2+0Lb6pu/n/9/Q1PjhkdNDZyD3gmQyeaAUgUFk
 OkBFAOx4y4t4rpNhx1jxnEvKH4iSiKw5nWIk4cDSSZA2aZVYrhASj9j+I8KlZMirVLtYJJa4yyt
 nQeA4ujMijvpswBIHDX26fhtygdP91xRBHQ==
X-Received: by 2002:a05:600c:d8:b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-48317921817mr16471405e9.15.1770274300416; 
 Wed, 04 Feb 2026 22:51:40 -0800 (PST)
X-Received: by 2002:a05:600c:d8:b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-48317921817mr16471115e9.15.1770274299875; 
 Wed, 04 Feb 2026 22:51:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618064813sm11985530f8f.38.2026.02.04.22.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 22:51:39 -0800 (PST)
Date: Thu, 5 Feb 2026 01:51:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/51] virtio,pci,pc: features, fixes
Message-ID: <20260205015022-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 02:16:23PM -0500, Michael S. Tsirkin wrote:
> The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:
> 
>   Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 1ef708ee4b765b9eac097192d54b69a603589f9b:
> 
>   hw/cxl: Take into account how many media operations are requested for param check (2026-02-04 07:42:50 -0500)

updated to 591fb214b96be2fab1dcf41282e567d6b64e613d now.

It is the same patchset with 5 patches dropped (and tag message
updated accordingly). So I am guessing it is better not
to resend the whole pull, but pls let me know.


> ----------------------------------------------------------------
> virtio,pci,pc: features, fixes
> 
> cxl:
>     Additional RAS features support.
>     Back-Invalidate support
>     PCIe Flit mode support
>     Misc fixes
> intel_iommu:
>     SVM support
> vhost:
>     support for indirect descriptors in shadow virtqueue
> vhost-user:
>     vhost-user-spi support
>     vhost-user-blk inflight migration support
>     vhost-user-blk inflight migration support
> acpi:
>     update VIOT maintainer
>     WDAT watchdog support
> 
> misc fixes in pci, vhost, virtio, acpi
> cleanups in acpi/ghes
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       pci/shpc: Do not unparent in instance_finalize()
> 
> Alexandr Moshkov (5):
>       vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
>       vhost-user: introduce protocol feature for skip drain on GET_VRING_BASE
>       vmstate: introduce VMSTATE_VBUFFER_UINT64
>       vhost: add vmstate for inflight region with inner buffer
>       vhost-user-blk: support inter-host inflight migration
> 
> Clément Mathieu--Drif (7):
>       intel_iommu: Add an IOMMU index for pre-translated addresses
>       intel_iommu: Support memory operations with pre-translated addresses
>       pcie: Add a function to check if pasid privileged mode is enabled
>       pci: Block ATS requests when privileged mode is disabled
>       intel_iommu: Handle insufficient permissions during translation requests
>       intel_iommu: Minimal handling of privileged ATS request
>       intel_iommu: Add a CLI option to enable SVM
> 
> Daniil Tatianin (1):
>       virtio/vhost: don't consider non-MAP_SHARED regions public
> 
> Davidlohr Bueso (1):
>       hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)
> 
> Dorinda Bassey (1):
>       virtio-dmabuf: Ensure UUID persistence for hash table insertion
> 
> Eugenio Pérez (1):
>       vhost: accept indirect descriptors in shadow virtqueue
> 
> Gavin Shan (5):
>       acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
>       acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
>       target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
>       acpi/ghes: Bail early on error from get_ghes_source_offsets()
>       acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> 
> Haixu Cui (2):
>       standard-headers: Update virtio_spi.h from Linux v6.18-rc3
>       virtio-spi: Add vhost-user-spi device support
> 
> Honglei Huang (2):
>       virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
>       virtio-gpu: use consistent error checking for virtio_gpu_create_mapping_iov
> 
> Igor Mammedov (6):
>       x86: q35: ich9: add 'wdat' property
>       acpi: add API to build WDAT instructions
>       x86: q35: generate WDAT ACPI table
>       tests: x86: q35: acpi: add WDAT table test case
>       tests: acpi: update expected WDAT blob
>       q35: Fix migration of SMRAM state
> 
> Jean-Philippe Brucker (1):
>       MAINTAINERS: Update VIOT maintainer
> 
> Joelle van Dyne (1):
>       virtio-gpu-virgl: correct parent for blob memory region
> 
> Jonathan Cameron (2):
>       hw/cxl: Check for overflow on santize media as both base and offset 64bit.
>       hw/cxl: Take into account how many media operations are requested for param check
> 
> Kevin Wolf (2):
>       virtio: Fix crash when sriov-pf is set for non-PCI-Express device
>       pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
> 
> Li Chen (1):
>       virtio-pmem: ignore empty queue notifications
> 
> Michael S. Tsirkin (1):
>       vhost-user: ancilliary -> ancillary
> 
> Philippe Mathieu-Daudé (1):
>       hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent class_init()
> 
> Shiju Jose (7):
>       hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature attributes in cmd_features_set_feature()
>       hw/cxl: Add emulation for memory sparing control feature
>       qapi: cxl: Refactor CXL event injection for common commands arguments
>       hw/cxl/events: Update for rev3.2 common event record format
>       hw/cxl/events: Updates for rev3.2 general media event record
>       hw/cxl/events: Updates for rev3.2 DRAM event record
>       hw/cxl/events: Updates for rev3.2 memory module event record
> 
> Wafer Xie (1):
>       vdpa: fix vhost-vdpa suspended state not be shared
> 
> zhenwei pi (2):
>       hw/virtio/virtio-crypto: verify asym request size
>       cryptodev-builtin: Limit the maximum size
> 
>  MAINTAINERS                                 |   8 +-
>  backends/cryptodev-builtin.c                |   9 +-
>  docs/interop/vhost-user.rst                 |  60 +--
>  docs/system/devices/virtio/vhost-user.rst   |   3 +
>  hw/acpi/aml-build.c                         |  14 +
>  hw/acpi/ghes-stub.c                         |   6 +-
>  hw/acpi/ghes.c                              |  45 +--
>  hw/acpi/ich9.c                              |   5 +
>  hw/acpi/meson.build                         |   3 +-
>  hw/acpi/wdat-ich9.c                         |  85 ++++
>  hw/acpi/wdat-stub.c                         |  16 +
>  hw/block/vhost-user-blk.c                   |  27 ++
>  hw/cxl/cxl-events.c                         |   3 +-
>  hw/cxl/cxl-mailbox-utils.c                  | 580 +++++++++++++++++++++++++++-
>  hw/display/virtio-dmabuf.c                  |   6 +-
>  hw/display/virtio-gpu-virgl.c               |   8 +-
>  hw/display/virtio-gpu.c                     |   4 +-
>  hw/i386/acpi-build.c                        |  13 +
>  hw/i386/intel_iommu.c                       | 204 +++++++---
>  hw/i386/intel_iommu_internal.h              |  14 +-
>  hw/isa/lpc_ich9.c                           |   1 +
>  hw/mem/cxl_type3.c                          | 330 +++++++++++++++-
>  hw/mem/cxl_type3_stubs.c                    |  41 +-
>  hw/pci-host/articia.c                       |   1 -
>  hw/pci-host/aspeed_pcie.c                   |   1 -
>  hw/pci-host/designware.c                    |   3 -
>  hw/pci-host/gpex.c                          |   2 -
>  hw/pci-host/grackle.c                       |   1 -
>  hw/pci-host/gt64120.c                       |   1 -
>  hw/pci-host/mv64361.c                       |   1 -
>  hw/pci-host/pnv_phb.c                       |   1 -
>  hw/pci-host/ppce500.c                       |   1 -
>  hw/pci-host/q35.c                           |  28 +-
>  hw/pci-host/raven.c                         |   1 -
>  hw/pci-host/remote.c                        |   1 -
>  hw/pci-host/sabre.c                         |   1 -
>  hw/pci-host/uninorth.c                      |   4 -
>  hw/pci-host/xilinx-pcie.c                   |   2 -
>  hw/pci/pci.c                                |   4 +
>  hw/pci/pci_host.c                           |   1 +
>  hw/pci/pcie.c                               |  21 +-
>  hw/pci/pcie_sriov.c                         |   9 +-
>  hw/pci/shpc.c                               |   1 -
>  hw/virtio/Kconfig                           |   5 +
>  hw/virtio/meson.build                       |   3 +
>  hw/virtio/vhost-shadow-virtqueue.c          |   1 +
>  hw/virtio/vhost-user-spi-pci.c              |  69 ++++
>  hw/virtio/vhost-user-spi.c                  |  65 ++++
>  hw/virtio/vhost-user.c                      |   7 +
>  hw/virtio/vhost-vdpa.c                      |   6 +-
>  hw/virtio/vhost.c                           |  66 +++-
>  hw/virtio/virtio-crypto.c                   |   7 +
>  hw/virtio/virtio-pci.c                      |  20 +-
>  hw/virtio/virtio-pmem.c                     |   1 -
>  hw/virtio/virtio.c                          |   4 +-
>  include/hw/acpi/ghes.h                      |   6 +-
>  include/hw/acpi/ich9.h                      |   1 +
>  include/hw/acpi/wdat.h                      | 121 ++++++
>  include/hw/cxl/cxl_device.h                 | 152 +++++++-
>  include/hw/cxl/cxl_events.h                 |  85 +++-
>  include/hw/i386/intel_iommu.h               |   1 +
>  include/hw/pci/pcie.h                       |   1 +
>  include/hw/virtio/vhost-user-blk.h          |   1 +
>  include/hw/virtio/vhost-user-spi.h          |  25 ++
>  include/hw/virtio/vhost-user.h              |   2 +
>  include/hw/virtio/vhost-vdpa.h              |   8 +-
>  include/hw/virtio/vhost.h                   |   6 +
>  include/migration/vmstate.h                 |  10 +
>  include/standard-headers/linux/virtio_spi.h | 181 +++++++++
>  qapi/cxl.json                               | 186 ++++++---
>  target/arm/kvm.c                            |  10 +-
>  tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
>  tests/qtest/bios-tables-test.c              |  13 +
>  tests/qtest/q35-test.c                      |   6 -
>  74 files changed, 2342 insertions(+), 297 deletions(-)
>  create mode 100644 hw/acpi/wdat-ich9.c
>  create mode 100644 hw/acpi/wdat-stub.c
>  create mode 100644 hw/virtio/vhost-user-spi-pci.c
>  create mode 100644 hw/virtio/vhost-user-spi.c
>  create mode 100644 include/hw/acpi/wdat.h
>  create mode 100644 include/hw/virtio/vhost-user-spi.h
>  create mode 100644 include/standard-headers/linux/virtio_spi.h
>  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat


