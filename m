Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635E1C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl3n-0003H3-Mq; Wed, 05 Jun 2024 03:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEl3l-0003Gh-SG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEl3j-0004y1-SA
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D28aAPLkBgMceD8pCVZUBe8JEL8L4g07jOdBETGyKrg=;
 b=LEVwCVD/8zMNlym0QYBXpnVWiY/2mBYvdMtBLvjfsChuGAwbaoxY9suDPZYwTU79PNkZPE
 WZDO8Hy+oQ6zbqHiJ6usgUy3f+RNOT53iRQj5ThGUdm8IixBg5PURVxaH6J6fDbqMqomUA
 GGIimmPzXOKgjbSosEGJsImJ4qybIwU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-mZi3dlCzPna3-E3roOnW-g-1; Wed, 05 Jun 2024 03:27:40 -0400
X-MC-Unique: mZi3dlCzPna3-E3roOnW-g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68eb60d73cso73698766b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572458; x=1718177258;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D28aAPLkBgMceD8pCVZUBe8JEL8L4g07jOdBETGyKrg=;
 b=QGGBuFVSSxMNpOTiNT2jdw/GuWpv4F1Wz0hlt7GPU9FMGHOMpEOW/aiiEhVQnTmwaI
 gU3UKuqS2Qa4SQoqpUnHiJmCpQBNymNlJzSqSu+KNBA2LwhoeUguiS8IbodnPtSx4TJA
 vKRYbdXf6qhSGbKR7GjjkfBbLYokBHzeeIHSWMTMAJvnrTDJUIKx9e4x/FnAK+Y0k4G5
 B8KXeVZvqKqmDSITmGyJZzVq6Twbpdp1A39LMlZbTJmHZeSEA1+WGilBabJnbALB9eyK
 4TyRwWbmslaza9EIdYOWFHHjjUhKYta7qgqjKDBhErYWKG7hM80vDKgWNvNb4LisbC/R
 SSWg==
X-Gm-Message-State: AOJu0YxBt4xueyJejPoKmc0exWWe0VGX1DqvaWQPh8ZnlWwGgjbMap3I
 pIYGuE3LhuIAhRwXT5ltpsg0+2zqu1ZBKJtIcx89yuxjLa6BSkGn4SbD5rhhdg/C2mslWAY+lme
 yoMGnRTuOb0urWCHgwGH0HnpIAOyUYiuOHqagLEqFNc14/l9MW58ZqsZXGenbx3bAcdlRQfBl/H
 ZInl1u9xoWqR1Cst4kyx1CBgpl7/eIOQ==
X-Received: by 2002:a17:906:bc4e:b0:a5e:612e:fd58 with SMTP id
 a640c23a62f3a-a699fcfe357mr100841466b.51.1717572457979; 
 Wed, 05 Jun 2024 00:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNTII3GLuh8kQfSPfnOfvG2XKB48tNAHFGzwgPlZjtEMxMMxlqV9wBcSCLD6aOvAQnV8rkfg==
X-Received: by 2002:a17:906:bc4e:b0:a5e:612e:fd58 with SMTP id
 a640c23a62f3a-a699fcfe357mr100839966b.51.1717572457303; 
 Wed, 05 Jun 2024 00:27:37 -0700 (PDT)
Received: from redhat.com ([2.55.58.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a693a755c4fsm243749066b.4.2024.06.05.00.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:27:36 -0700 (PDT)
Date: Wed, 5 Jun 2024 03:27:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 00/46] virtio: features,fixes
Message-ID: <20240605032555-mutt-send-email-mst@kernel.org>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 04, 2024 at 03:06:01PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 60b54b67c63d8f076152e0f7dccf39854dfc6a77:
> 
>   Merge tag 'pull-lu-20240526' of https://gitlab.com/rth7680/qemu into staging (2024-05-26 17:51:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> for you to fetch changes up to bfcacf81d63a3d95f128bce3faf3564e7f98ea8b:

Dropped a patch from this pull at Author's request.
New head a2da15a164ddd798227262b58507b46ad5ab0ca9
Sorry about the noise - ok like this?
Don't want to spam the list posting v2 just for this.

> 
>   hw/cxl: Fix read from bogus memory (2024-06-04 15:05:03 -0400)
> 
> ----------------------------------------------------------------
> virtio: features,fixes
> 
> A bunch of improvements:
> - vhost dirty log is now only scanned once, not once per device
> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> - cxl gained DCD emulation support
> - pvpanic gained shutdown support
> - acpi now supports Generic Port Affinity Structure
> - new tests
> - bugfixes
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alejandro Jimenez (1):
>       pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic shutdown signal
> 
> Christian Pötzsch (1):
>       Fix vhost user assertion when sending more than one fd
> 
> Cindy Lu (2):
>       virtio-pci: Fix the use of an uninitialized irqfd.

This is the patch that I dropped.


>       virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()
> 
> Fan Ni (12):
>       hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
>       hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
>       include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
>       hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
>       hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
>       hw/mem/cxl_type3: Add host backend and address space handling for DC regions
>       hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
>       hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release dynamic capacity response
>       hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
>       hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
>       hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
>       hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> 
> Gregory Price (2):
>       hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
>       hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> 
> Halil Pasic (1):
>       vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
> 
> Ira Weiny (1):
>       hw/cxl: Fix read from bogus memory
> 
> Jiqian Chen (1):
>       virtio-pci: only reset pm state during resetting
> 
> Jonah Palmer (5):
>       virtio/virtio-pci: Handle extra notification data
>       virtio: Prevent creation of device using notification-data with ioeventfd
>       virtio-mmio: Handle extra notification data
>       virtio-ccw: Handle extra notification data
>       vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits
> 
> Jonathan Cameron (6):
>       hw/acpi/GI: Fix trivial parameter alignment issue.
>       hw/acpi: Insert an acpi-generic-node base under acpi-generic-initiator
>       hw/acpi: Generic Port Affinity Structure support
>       bios-tables-test: Allow for new acpihmat-generic-x test data.
>       bios-tables-test: Add complex SRAT / HMAT test for GI GP
>       bios-tables-test: Add data for complex numa test (GI, GP etc)
> 
> Li Feng (2):
>       Revert "vhost-user: fix lost reconnect"
>       vhost-user: fix lost reconnect again
> 
> Marc-André Lureau (1):
>       vhost-user-gpu: fix import of DMABUF
> 
> Si-Wei Liu (2):
>       vhost: dirty log should be per backend type
>       vhost: Perform memory section dirty scans once per iteration
> 
> Stefano Garzarella (1):
>       vhost-vdpa: check vhost_vdpa_set_vring_ready() return value
> 
> Thomas Weißschuh (7):
>       scripts/update-linux-headers: Copy setup_data.h to correct directory
>       linux-headers: update to 6.10-rc1
>       hw/misc/pvpanic: centralize definition of supported events
>       tests/qtest/pvpanic: use centralized definition of supported events
>       hw/misc/pvpanic: add support for normal shutdowns
>       tests/qtest/pvpanic: add tests for pvshutdown event
>       Revert "docs/specs/pvpanic: mark shutdown event as not implemented"
> 
> Wafer (1):
>       hw/virtio: Fix obtain the buffer id from the last descriptor
> 
>  qapi/cxl.json                               | 143 ++++++
>  qapi/qom.json                               |  35 ++
>  qapi/run-state.json                         |  14 +
>  include/hw/acpi/acpi_generic_initiator.h    |  33 +-
>  include/hw/cxl/cxl_device.h                 |  85 +++-
>  include/hw/cxl/cxl_events.h                 |  18 +
>  include/hw/misc/pvpanic.h                   |   6 +
>  include/hw/pci/pci_bridge.h                 |   1 +
>  include/hw/virtio/vhost-user.h              |   3 +-
>  include/hw/virtio/vhost.h                   |   1 +
>  include/hw/virtio/virtio.h                  |   2 +
>  include/standard-headers/linux/ethtool.h    |  55 +++
>  include/standard-headers/linux/pci_regs.h   |   6 +
>  include/standard-headers/linux/pvpanic.h    |   7 +-
>  include/standard-headers/linux/virtio_bt.h  |   1 -
>  include/standard-headers/linux/virtio_mem.h |   2 +
>  include/standard-headers/linux/virtio_net.h | 143 ++++++
>  include/sysemu/runstate.h                   |   1 +
>  linux-headers/asm-generic/unistd.h          |   5 +-
>  linux-headers/asm-loongarch/kvm.h           |   4 +
>  linux-headers/asm-mips/unistd_n32.h         |   1 +
>  linux-headers/asm-mips/unistd_n64.h         |   1 +
>  linux-headers/asm-mips/unistd_o32.h         |   1 +
>  linux-headers/asm-powerpc/unistd_32.h       |   1 +
>  linux-headers/asm-powerpc/unistd_64.h       |   1 +
>  linux-headers/asm-riscv/kvm.h               |   1 +
>  linux-headers/asm-s390/unistd_32.h          |   1 +
>  linux-headers/asm-s390/unistd_64.h          |   1 +
>  linux-headers/asm-x86/kvm.h                 |   4 +-
>  linux-headers/asm-x86/unistd_32.h           |   1 +
>  linux-headers/asm-x86/unistd_64.h           |   1 +
>  linux-headers/asm-x86/unistd_x32.h          |   2 +
>  linux-headers/linux/kvm.h                   |   4 +-
>  linux-headers/linux/stddef.h                |   8 +
>  linux-headers/linux/vhost.h                 |  15 +-
>  hw/acpi/acpi_generic_initiator.c            | 209 ++++++---
>  hw/block/vhost-user-blk.c                   |   6 +-
>  hw/cxl/cxl-mailbox-utils.c                  | 658 +++++++++++++++++++++++++++-
>  hw/display/vhost-user-gpu.c                 |   5 +-
>  hw/mem/cxl_type3.c                          | 637 +++++++++++++++++++++++++--
>  hw/mem/cxl_type3_stubs.c                    |  25 ++
>  hw/misc/pvpanic-isa.c                       |   3 +-
>  hw/misc/pvpanic-pci.c                       |   3 +-
>  hw/misc/pvpanic.c                           |   8 +-
>  hw/net/vhost_net.c                          |   2 +
>  hw/pci-bridge/pci_expander_bridge.c         |   1 -
>  hw/s390x/s390-virtio-ccw.c                  |  17 +-
>  hw/scsi/vhost-scsi.c                        |   1 +
>  hw/scsi/vhost-user-scsi.c                   |   7 +-
>  hw/virtio/vhost-user-base.c                 |   5 +-
>  hw/virtio/vhost-user-fs.c                   |   2 +-
>  hw/virtio/vhost-user-vsock.c                |   1 +
>  hw/virtio/vhost-user.c                      |  18 +-
>  hw/virtio/vhost-vsock-common.c              |   1 +
>  hw/virtio/vhost.c                           | 112 ++++-
>  hw/virtio/virtio-mmio.c                     |  11 +-
>  hw/virtio/virtio-pci.c                      |  45 +-
>  hw/virtio/virtio.c                          |  45 ++
>  net/vhost-vdpa.c                            |  16 +-
>  subprojects/libvhost-user/libvhost-user.c   |   2 +-
>  system/runstate.c                           |   6 +
>  tests/qtest/bios-tables-test.c              |  92 ++++
>  tests/qtest/pvpanic-pci-test.c              |  44 +-
>  tests/qtest/pvpanic-test.c                  |  34 +-
>  docs/specs/pvpanic.rst                      |   2 +-
>  scripts/update-linux-headers.sh             |   2 +-
>  tests/data/acpi/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
>  tests/data/acpi/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
>  tests/data/acpi/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10400 bytes
>  tests/data/acpi/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
>  tests/data/acpi/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
>  71 files changed, 2407 insertions(+), 221 deletions(-)
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/CEDT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat-generic-x
> 


