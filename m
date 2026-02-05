Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFF4E91272
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 07:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntLy-0003Bu-Dm; Thu, 05 Feb 2026 02:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vntLu-0003Bc-FE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:00:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vntLs-0007LR-AR
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770274830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jruo+VruJRTXh4GLtwaZU38qf1L2p3lkzjbatmxInDE=;
 b=JFROLc34oUwk0zVDMomkxCvhXa0wcAprHfji3OJD32pE/Sy8YL6fgGqEA4ziGpZ+stAvBe
 +6nk9WaPx91LWbIoJ/txwqJbDKZuoJKtFUCt36Usv7CLLdGit8chT74xVPXHc9gJ4v/kFn
 8Eu8vdSPF61XorDq05eKcc/ZrEMxdQQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-1U7VZVy9NSm3C71WSbSOhg-1; Thu, 05 Feb 2026 02:00:28 -0500
X-MC-Unique: 1U7VZVy9NSm3C71WSbSOhg-1
X-Mimecast-MFC-AGG-ID: 1U7VZVy9NSm3C71WSbSOhg_1770274828
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b885979bfa9so50448866b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 23:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770274827; x=1770879627; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jruo+VruJRTXh4GLtwaZU38qf1L2p3lkzjbatmxInDE=;
 b=r5iTd1zj5/AIEWueUQKZJYabI0kB+LFL7kcE1AFyf8Dxb9q7srGtRNeincusd2Zmhz
 BMfP6Rs2LXGg82gex9Sy20Qghe2vi+9tmTPInoCHNJvl9yVBDf3FuPmuPRCmmb78ZaZM
 I0aiFKBpmvS6e+i2+7A6TKVJSV1TKkCIQN5dTM5StjuiTTGybDyC4Zpssv1Figm+bckx
 rvpsZFWMuvwBSnoLUz1CqIKpbgRm0rj3NJYjkue7jAHwv4KT6ogssbcxUKXVktDskzTp
 BeXnKEQsVuyn/Y03TYJ5QGci8hB8WvR5FoWJ37IRJixEuqZPBTO2xD+0a13oHpVy9t2H
 yomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770274827; x=1770879627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jruo+VruJRTXh4GLtwaZU38qf1L2p3lkzjbatmxInDE=;
 b=NOFnwo8Y9X2vJxJ4dbQrfCxbUN9FPPNFbuLH9PbsDqUC1gHxNO5qmNp5baYHX8Dozl
 kfClKNNsjgpnu1ULJBtxVkIfXIWb+jLRya5DUrmOhmfvo7EDYDwCRg4rR1RdKcYukIQW
 ydOrTJ5f+3JNSclINf1NBrFPcPzP0ap2qDkK+L/uue7qPgUs7h6KZNxeJblvX0NNqFgh
 8TlrDA2M3lqwCEoU+wJVj0BFltp9EEmSN1Mt1DAzf7idbnRm7DieOU1u3hOb3o5ck2Zr
 o9MpBnS0VMsLrI18WHy2kqUgrk3lP2w7Ajn0t9pyOpnIBvAwzkq8Bxxg4R8dpznEpKSr
 Nzmw==
X-Gm-Message-State: AOJu0Yy0IWnA72lLGBOOPL9yAmkhuSLMqGG1+DjXf4/f89r2/v4ijMKG
 YTTjzjPY/bKbNFxoJAM5zk/0XOcdeg+YMSWNBawn280ujsXj8hxz9s0nKvnWA3ZMK3W5TW1Pi8/
 q5A2J2BeL8WtapEJGYH8MMH30xH4A6NKdqRFbx1h6QmtolVFO/DmN49B/+gWs9OB13y9XtAVjEs
 4UEGp8ofashn2fFFYS4XutYZwrKqRPcIUT3g==
X-Gm-Gg: AZuq6aIH+e95zmll8ZsMDHP1Yrr+Fraa06Wpt67quaKysB8env4A2wi1Blhn2KHhq+o
 XPck2gQGtf4PyOz5CbvK/qE01YdvHHnwT+/oPwC5dK3qot/PziEvr6ISfDd5IhBjgTjSa2Pf+2t
 ep30ZN1DeniJN6SsLDgvl7wmt/nDbS21slW3IS1trA3gvP4Bl/wvW8jeWwAWhfgNuicjPGXXelr
 rO8IpWcI11Cd9PbZJs32836juqtjCf3uvDcg4iqcUxY5MZhOz9ahh43hZmwlCgDqmfcJC7JCalG
 StAmqMzPhivGAaVRaJK+h32vqiDTOfeymrZU5kdT3o6f2MWAOJaiQQXl42fQFJwA/oKhOfHs4lr
 V3nFv0p7ZQTGtRtF8hWmaoT073sqQ36uDRw==
X-Received: by 2002:a17:907:746:b0:b87:2b61:b036 with SMTP id
 a640c23a62f3a-b8e9f04f6fdmr317995866b.18.1770274827062; 
 Wed, 04 Feb 2026 23:00:27 -0800 (PST)
X-Received: by 2002:a17:907:746:b0:b87:2b61:b036 with SMTP id
 a640c23a62f3a-b8e9f04f6fdmr317993466b.18.1770274826343; 
 Wed, 04 Feb 2026 23:00:26 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8ea006c50asm191434266b.70.2026.02.04.23.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 23:00:25 -0800 (PST)
Date: Thu, 5 Feb 2026 02:00:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/51] virtio,pci,pc: features, fixes
Message-ID: <20260205015956-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
 <20260205015022-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205015022-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Feb 05, 2026 at 01:51:39AM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 02:16:23PM -0500, Michael S. Tsirkin wrote:
> > The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:
> > 
> >   Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to 1ef708ee4b765b9eac097192d54b69a603589f9b:
> > 
> >   hw/cxl: Take into account how many media operations are requested for param check (2026-02-04 07:42:50 -0500)
> 
> updated to 591fb214b96be2fab1dcf41282e567d6b64e613d now.
> 
> It is the same patchset with 5 patches dropped (and tag message
> updated accordingly). So I am guessing it is better not
> to resend the whole pull, but pls let me know.

sent too early, there is a dependency i missed.
will post v2 later.

> 
> > ----------------------------------------------------------------
> > virtio,pci,pc: features, fixes
> > 
> > cxl:
> >     Additional RAS features support.
> >     Back-Invalidate support
> >     PCIe Flit mode support
> >     Misc fixes
> > intel_iommu:
> >     SVM support
> > vhost:
> >     support for indirect descriptors in shadow virtqueue
> > vhost-user:
> >     vhost-user-spi support
> >     vhost-user-blk inflight migration support
> >     vhost-user-blk inflight migration support
> > acpi:
> >     update VIOT maintainer
> >     WDAT watchdog support
> > 
> > misc fixes in pci, vhost, virtio, acpi
> > cleanups in acpi/ghes
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Akihiko Odaki (1):
> >       pci/shpc: Do not unparent in instance_finalize()
> > 
> > Alexandr Moshkov (5):
> >       vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
> >       vhost-user: introduce protocol feature for skip drain on GET_VRING_BASE
> >       vmstate: introduce VMSTATE_VBUFFER_UINT64
> >       vhost: add vmstate for inflight region with inner buffer
> >       vhost-user-blk: support inter-host inflight migration
> > 
> > Clément Mathieu--Drif (7):
> >       intel_iommu: Add an IOMMU index for pre-translated addresses
> >       intel_iommu: Support memory operations with pre-translated addresses
> >       pcie: Add a function to check if pasid privileged mode is enabled
> >       pci: Block ATS requests when privileged mode is disabled
> >       intel_iommu: Handle insufficient permissions during translation requests
> >       intel_iommu: Minimal handling of privileged ATS request
> >       intel_iommu: Add a CLI option to enable SVM
> > 
> > Daniil Tatianin (1):
> >       virtio/vhost: don't consider non-MAP_SHARED regions public
> > 
> > Davidlohr Bueso (1):
> >       hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)
> > 
> > Dorinda Bassey (1):
> >       virtio-dmabuf: Ensure UUID persistence for hash table insertion
> > 
> > Eugenio Pérez (1):
> >       vhost: accept indirect descriptors in shadow virtqueue
> > 
> > Gavin Shan (5):
> >       acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
> >       acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
> >       target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
> >       acpi/ghes: Bail early on error from get_ghes_source_offsets()
> >       acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> > 
> > Haixu Cui (2):
> >       standard-headers: Update virtio_spi.h from Linux v6.18-rc3
> >       virtio-spi: Add vhost-user-spi device support
> > 
> > Honglei Huang (2):
> >       virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
> >       virtio-gpu: use consistent error checking for virtio_gpu_create_mapping_iov
> > 
> > Igor Mammedov (6):
> >       x86: q35: ich9: add 'wdat' property
> >       acpi: add API to build WDAT instructions
> >       x86: q35: generate WDAT ACPI table
> >       tests: x86: q35: acpi: add WDAT table test case
> >       tests: acpi: update expected WDAT blob
> >       q35: Fix migration of SMRAM state
> > 
> > Jean-Philippe Brucker (1):
> >       MAINTAINERS: Update VIOT maintainer
> > 
> > Joelle van Dyne (1):
> >       virtio-gpu-virgl: correct parent for blob memory region
> > 
> > Jonathan Cameron (2):
> >       hw/cxl: Check for overflow on santize media as both base and offset 64bit.
> >       hw/cxl: Take into account how many media operations are requested for param check
> > 
> > Kevin Wolf (2):
> >       virtio: Fix crash when sriov-pf is set for non-PCI-Express device
> >       pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
> > 
> > Li Chen (1):
> >       virtio-pmem: ignore empty queue notifications
> > 
> > Michael S. Tsirkin (1):
> >       vhost-user: ancilliary -> ancillary
> > 
> > Philippe Mathieu-Daudé (1):
> >       hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent class_init()
> > 
> > Shiju Jose (7):
> >       hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature attributes in cmd_features_set_feature()
> >       hw/cxl: Add emulation for memory sparing control feature
> >       qapi: cxl: Refactor CXL event injection for common commands arguments
> >       hw/cxl/events: Update for rev3.2 common event record format
> >       hw/cxl/events: Updates for rev3.2 general media event record
> >       hw/cxl/events: Updates for rev3.2 DRAM event record
> >       hw/cxl/events: Updates for rev3.2 memory module event record
> > 
> > Wafer Xie (1):
> >       vdpa: fix vhost-vdpa suspended state not be shared
> > 
> > zhenwei pi (2):
> >       hw/virtio/virtio-crypto: verify asym request size
> >       cryptodev-builtin: Limit the maximum size
> > 
> >  MAINTAINERS                                 |   8 +-
> >  backends/cryptodev-builtin.c                |   9 +-
> >  docs/interop/vhost-user.rst                 |  60 +--
> >  docs/system/devices/virtio/vhost-user.rst   |   3 +
> >  hw/acpi/aml-build.c                         |  14 +
> >  hw/acpi/ghes-stub.c                         |   6 +-
> >  hw/acpi/ghes.c                              |  45 +--
> >  hw/acpi/ich9.c                              |   5 +
> >  hw/acpi/meson.build                         |   3 +-
> >  hw/acpi/wdat-ich9.c                         |  85 ++++
> >  hw/acpi/wdat-stub.c                         |  16 +
> >  hw/block/vhost-user-blk.c                   |  27 ++
> >  hw/cxl/cxl-events.c                         |   3 +-
> >  hw/cxl/cxl-mailbox-utils.c                  | 580 +++++++++++++++++++++++++++-
> >  hw/display/virtio-dmabuf.c                  |   6 +-
> >  hw/display/virtio-gpu-virgl.c               |   8 +-
> >  hw/display/virtio-gpu.c                     |   4 +-
> >  hw/i386/acpi-build.c                        |  13 +
> >  hw/i386/intel_iommu.c                       | 204 +++++++---
> >  hw/i386/intel_iommu_internal.h              |  14 +-
> >  hw/isa/lpc_ich9.c                           |   1 +
> >  hw/mem/cxl_type3.c                          | 330 +++++++++++++++-
> >  hw/mem/cxl_type3_stubs.c                    |  41 +-
> >  hw/pci-host/articia.c                       |   1 -
> >  hw/pci-host/aspeed_pcie.c                   |   1 -
> >  hw/pci-host/designware.c                    |   3 -
> >  hw/pci-host/gpex.c                          |   2 -
> >  hw/pci-host/grackle.c                       |   1 -
> >  hw/pci-host/gt64120.c                       |   1 -
> >  hw/pci-host/mv64361.c                       |   1 -
> >  hw/pci-host/pnv_phb.c                       |   1 -
> >  hw/pci-host/ppce500.c                       |   1 -
> >  hw/pci-host/q35.c                           |  28 +-
> >  hw/pci-host/raven.c                         |   1 -
> >  hw/pci-host/remote.c                        |   1 -
> >  hw/pci-host/sabre.c                         |   1 -
> >  hw/pci-host/uninorth.c                      |   4 -
> >  hw/pci-host/xilinx-pcie.c                   |   2 -
> >  hw/pci/pci.c                                |   4 +
> >  hw/pci/pci_host.c                           |   1 +
> >  hw/pci/pcie.c                               |  21 +-
> >  hw/pci/pcie_sriov.c                         |   9 +-
> >  hw/pci/shpc.c                               |   1 -
> >  hw/virtio/Kconfig                           |   5 +
> >  hw/virtio/meson.build                       |   3 +
> >  hw/virtio/vhost-shadow-virtqueue.c          |   1 +
> >  hw/virtio/vhost-user-spi-pci.c              |  69 ++++
> >  hw/virtio/vhost-user-spi.c                  |  65 ++++
> >  hw/virtio/vhost-user.c                      |   7 +
> >  hw/virtio/vhost-vdpa.c                      |   6 +-
> >  hw/virtio/vhost.c                           |  66 +++-
> >  hw/virtio/virtio-crypto.c                   |   7 +
> >  hw/virtio/virtio-pci.c                      |  20 +-
> >  hw/virtio/virtio-pmem.c                     |   1 -
> >  hw/virtio/virtio.c                          |   4 +-
> >  include/hw/acpi/ghes.h                      |   6 +-
> >  include/hw/acpi/ich9.h                      |   1 +
> >  include/hw/acpi/wdat.h                      | 121 ++++++
> >  include/hw/cxl/cxl_device.h                 | 152 +++++++-
> >  include/hw/cxl/cxl_events.h                 |  85 +++-
> >  include/hw/i386/intel_iommu.h               |   1 +
> >  include/hw/pci/pcie.h                       |   1 +
> >  include/hw/virtio/vhost-user-blk.h          |   1 +
> >  include/hw/virtio/vhost-user-spi.h          |  25 ++
> >  include/hw/virtio/vhost-user.h              |   2 +
> >  include/hw/virtio/vhost-vdpa.h              |   8 +-
> >  include/hw/virtio/vhost.h                   |   6 +
> >  include/migration/vmstate.h                 |  10 +
> >  include/standard-headers/linux/virtio_spi.h | 181 +++++++++
> >  qapi/cxl.json                               | 186 ++++++---
> >  target/arm/kvm.c                            |  10 +-
> >  tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
> >  tests/qtest/bios-tables-test.c              |  13 +
> >  tests/qtest/q35-test.c                      |   6 -
> >  74 files changed, 2342 insertions(+), 297 deletions(-)
> >  create mode 100644 hw/acpi/wdat-ich9.c
> >  create mode 100644 hw/acpi/wdat-stub.c
> >  create mode 100644 hw/virtio/vhost-user-spi-pci.c
> >  create mode 100644 hw/virtio/vhost-user-spi.c
> >  create mode 100644 include/hw/acpi/wdat.h
> >  create mode 100644 include/hw/virtio/vhost-user-spi.h
> >  create mode 100644 include/standard-headers/linux/virtio_spi.h
> >  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat


