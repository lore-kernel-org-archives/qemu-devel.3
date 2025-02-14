Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43091C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixj6-0005mM-2n; Fri, 14 Feb 2025 10:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tixj0-0005lW-Jy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:35:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tixiv-0002VF-0c
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739547319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wMrqMA1V2Ibv4J8YvabBkfYqvVzDSJ7WBKmCie8DHyk=;
 b=c3YQBMX/NmitsxXYMiQW13XflK33X9fj9aGAJ12Mbp7PfCgqVy37YobRjGNYwMOtPIaoAy
 Qke5Oi01kUQtDATIM0UrQw47Y9cP/H2ClK90kJ7TdJrmeafTzTNxjpKoEDD9ShDar3mCkc
 KIuV/Gt4WqlruibGomRn1Af5B0R5t0Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-KshbwwM1PaKLekXnc_qERg-1; Fri, 14 Feb 2025 10:35:17 -0500
X-MC-Unique: KshbwwM1PaKLekXnc_qERg-1
X-Mimecast-MFC-AGG-ID: KshbwwM1PaKLekXnc_qERg_1739547317
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-220e7d654acso25998265ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739547314; x=1740152114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMrqMA1V2Ibv4J8YvabBkfYqvVzDSJ7WBKmCie8DHyk=;
 b=pOX3wMQZLbFeYGsWPK6uTzn/1FudAhr5Ozkbd4puUixugABU/selYfujh/xKeXcP4L
 KlD7NhVHEgDuH+lgMhfT4j3KOc9GyRvOANOaRAD2PUSj0bR0NX5qTAdDY8vXOQRqPYbE
 68ng1FLDOaZPdvSxKISucy+LuN1Tra8aUP4BjAefmi0RSGt+sY8Ktfmv6nBelkKmUW3C
 kAGYUFe3BLEvhFCO3LamSI6lf0/pnIPEGNSacaJQlcPxfpavdVV0lwM/12Bj4zEjWLii
 1V5CZU5IeHudqIXtqoU84YHDSWv6DGSA4oTfJHazHwNJKbcRiaLSuEFd52rAx4OSOXXy
 5hlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGN6arwt/UlzVTfzV7THr2OElGK+SAIaqQhcCz9ZgePoV7G94V0xRXKp2irt+CxQrTtjw6nWLV/5So@nongnu.org
X-Gm-Message-State: AOJu0Yx/BdAMbQagX3fnYxs7t08tktV6oK7SI5CkMPamxr2ju/KBIO+o
 9z1g7RCl/bWX+2QkULUoIvf3TW/l+nV6cAO5x5CLY9iZqTwbJmle/r3RoTB8sFULkB2chYfuYEI
 vJIxmfkaNAgdaNTn4hlXgAylfVL8cYcrgy9JGAk54zdFhQmgbBrV2
X-Gm-Gg: ASbGncsSdCp7RpHAWIOJyJr2bErZBCPdJI2dsfVOprIAlhxOqG7Uds8BCNCXatWnfkG
 yPjtGFes3IJFGbUPzez+41n3YKjL+RY6uqYr4gJi+gSrc+tSaotVygrBBNYNA5FyFAWkTlO1p5c
 szRa9mOtKxw6fMLdkHwvCZ8jB1uBvXos5Nq/DuhHT81B2hdAQxGP+Z4IzETEZB4Gn4G7ZEZf9yk
 oaxjTEM32MDpibdlv/QwCzOOjeMGaN/s4E/35f6UcCzQQDCnsWp57iN3xbNqU4JdOOqwvxDE31A
 Tj3DOeA8HArP4kerY2BBcBhbIc0f
X-Received: by 2002:a17:902:ce88:b0:21f:3823:482b with SMTP id
 d9443c01a7336-220d35e098dmr110196595ad.25.1739547313517; 
 Fri, 14 Feb 2025 07:35:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHggyluSAl30VrDkzyZhPUFBoL/YxEfdMyoxhUJDoe96wiYeQunmRX/MbePF/lgvOdw8yjFhQ==
X-Received: by 2002:a17:902:ce88:b0:21f:3823:482b with SMTP id
 d9443c01a7336-220d35e098dmr110195895ad.25.1739547312935; 
 Fri, 14 Feb 2025 07:35:12 -0800 (PST)
Received: from localhost.localdomain ([115.96.107.202])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-220d5364385sm30382945ad.63.2025.02.14.07.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 07:35:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg interface
 support
Date: Fri, 14 Feb 2025 21:04:07 +0530
Message-ID: <20250214153443.159889-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

VM firmware update is a mechanism where the virtual machines can use their
preferred and trusted firmware image in their execution environment without
having to depend on a untrusted party to provide the firmware bundle. This is
particularly useful for confidential virtual machines that are deployed in the
cloud where the tenant and the cloud provider are two different entities. In
this scenario, virtual machines can bring their own trusted firmware image
bundled as a part of their filesystem (using UKIs for example[1]) and then use
this hypervisor interface to update to their trusted firmware image. This also
allows the guests to have a consistent measurements on the firmware image.

This change introduces support for the fw-cfg based hypervisor interface
and the corresponding device.The change also includes the
specification document for this interface. The interface is made generic
enough so that guests are free to use their own ABI to pass required
information between initial and trusted execution contexts (where they are
running their own trusted firmware image) without the hypervisor getting
involved in between. For pc machines, it implements support for
copying firmware image from the guest source physical address specifiied
by the guest where the guest loaded the next stage firmware.

Currently, this device is only supported for pc machines. Hence, the device
is not initialized for other machine types. Trying to initialize it
for arm for example will lead to failure:

$ ./qemu-system-arm -device vmfwupdate -machine virt
qemu-system-arm: -device vmfwupdate: This machine does not support vmfwupdate device

Functional and qtests has been added to test basic device operations and fw-cfg
files.

[1] See systemd pull requests https://github.com/systemd/systemd/pull/35091
and https://github.com/systemd/systemd/pull/35281 for some discussions on
how we can bundle firmware image within an UKI.

CC: Alex Graf <graf@amazon.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Gerd Hoffman <kraxel@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                         |  11 ++
 docs/specs/index.rst                |   1 +
 docs/specs/vmfwupdate.rst           | 119 ++++++++++++++++
 hw/core/machine.c                   |   2 +
 hw/i386/pc.c                        |  55 ++++++++
 hw/i386/x86.c                       |   8 ++
 hw/misc/meson.build                 |   2 +
 hw/misc/vmfwupdate.c                | 208 ++++++++++++++++++++++++++++
 include/hw/boards.h                 |   1 +
 include/hw/misc/vmfwupdate.h        | 101 ++++++++++++++
 tests/functional/meson.build        |   2 +
 tests/functional/test_vmfwupdate.py |  82 +++++++++++
 tests/qtest/meson.build             |   1 +
 tests/qtest/vmfwupdate-test.c       |  67 +++++++++
 14 files changed, 660 insertions(+)
 create mode 100644 docs/specs/vmfwupdate.rst
 create mode 100644 hw/misc/vmfwupdate.c
 create mode 100644 include/hw/misc/vmfwupdate.h
 create mode 100644 tests/functional/test_vmfwupdate.py
 create mode 100644 tests/qtest/vmfwupdate-test.c

changelogs:
v6: Alex's inputs on v5 taken into consideration.
Pipeline is still green:
https://gitlab.com/anisinha/qemu/-/pipelines/1671565480
v5: Alex's input, add qtest and functional test. guest reset full
support for x86. More testing is required but will need support of
DMA based fw-cfw file write capability. This has been added in the
patchset https://patchwork.ozlabs.org/project/qemu-devel/list/?series=441003
Cover letter: 
https://patchwork.ozlabs.org/project/qemu-devel/cover/20250120043847.954881-1-anisinha@redhat.com/
 .
For more comprehensive testing of this patch, I am requesting inputs and
suggestions.

CI pipeline is green - so no regressions.
https://gitlab.com/anisinha/qemu/-/pipelines/1646036807

v4: remove delay in functional test. Not needed now.
v3: inputs from Gerd and Phil taken into account. One basic functional
test added. Spec doc updated as per Gerd's suggestions.
v2: do not allow changing bios region if advertized size is 0 (non-pc
platforms).

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38..4eff7f3c20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2564,6 +2564,17 @@ F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
+VM Firmware Update
+M: Ani Sinha <anisinha@redhat.com>
+M: Alex Graf <graf@amazon.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: hw/misc/vmfwupdate.c
+F: include/hw/misc/vmfwupdate.h
+F: docs/specs/vmfwupdate.rst
+F: tests/qtest/vmfwupdate-test.c
+F: tests/functional/test_vmfwupdate.py
+
 LED
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index d7675cebc2..8d78b647f2 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -34,6 +34,7 @@ guest hardware that is specific to QEMU.
    virt-ctlr
    vmcoreinfo
    vmgenid
+   vmfwupdate
    rapl-msr
    rocker
    riscv-iommu
diff --git a/docs/specs/vmfwupdate.rst b/docs/specs/vmfwupdate.rst
new file mode 100644
index 0000000000..6e8a8ae32b
--- /dev/null
+++ b/docs/specs/vmfwupdate.rst
@@ -0,0 +1,119 @@
+VMFWUPDATE INTERFACE SPECIFICATION
+##################################
+
+Introduction
+************
+
+``Vmfwupdate`` is an extension to ``fw-cfg`` that allows guests to replace early boot
+code in their virtual machine. Through a combination of vmfwupdate and
+hypervisor stack knowledge, guests can deterministically replace the launch
+payload for guests. This is useful for environments like SEV-SNP where the
+launch payload becomes the launch digest. Guests can use vmfwupdate to provide
+a measured, full guest payload (BIOS image, kernel, initramfs, kernel
+command line) to the virtual machine which enables them to easily reason about
+integrity of the resulting system.
+For more information, please see the `KVM Forum 2024 presentation <KVMFORUM_>`__
+about this work from the authors [1]_.
+
+
+.. _KVMFORUM: https://www.youtube.com/watch?v=VCMBxU6tAto
+
+Base Requirements
+*****************
+
+#. **fw-cfg**:
+     The target system must provide a ``fw-cfg`` interface. For x86 based
+     environments, this ``fw-cfg`` interface must be accessible through PIO ports
+     0x510 and 0x511. The ``fw-cfg`` interface does not need to be announced as part
+     of system device tables such as DSDT. The ``fw-cfg`` interface must support the
+     DMA interface. It may only support the DMA interface for write operations.
+
+#. **BIOS region**:
+     The hypervisor must provide a BIOS region which may be
+     statically sized. Through vmfwupdate, the guest is able to atomically replace
+     its contents. The BIOS region must be mapped as read-write memory. In a
+     SEV-SNP environment, the BIOS region must be mapped as private memory at
+     launch time.
+
+Fw-cfg Files
+************
+
+Guests drive vmfwupdate through special ``fw-cfg`` files that control its flow
+followed by a standard system reset operation. When vmfwupdate is available,
+it provides the following ``fw-cfg`` files:
+
+* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitmap of additional
+  capabilities the interface supports. List of available capabilities:
+
+     ``VMFWUPDATE_CAP_BIOS_RESIZE        0x0000000000000001``
+
+* ``vmfwupdate/bios-size`` (``u64``) - Little Endian encoded size of the BIOS region.
+  Read-only by default. Optionally Read-write if ``vmfwupdate/cap`` contains
+  ``VMFWUPDATE_CAP_BIOS_RESIZE``. On write, the BIOS region may resize. Guests are
+  required to read the value after writing and compare it with the requested size
+  to determine whether the resize was successful. Note, x86 BIOS regions always
+  start at 4GiB - bios-size.
+
+* ``vmfwupdate/opaque`` (``4096 bytes``) - A 4 KiB buffer that survives the BIOS replacement
+  flow. Can be used by the guest to propagate guest physical addresses of payloads
+  to its BIOS stage. It is recommended to make the new BIOS clear this file on boot
+  if it exists. Contents of this file are under control by the hypervisor. In an
+  environment that considers the hypervisor outside of its trust boundary, guests
+  are advised to validate its contents before consumption.
+
+* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is disabled.
+  Returns 0 for enabled, 1 for disabled. Writing any value disables it. Writing is
+  only allowed if the value is 0. When the interface is disabled, the replace file
+  is ignored on reset. This value resets to 0 on system reset.
+
+* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded guest physical address
+  at the beginning of the replacement BIOS region. The provided payload must reside
+  in shared memory. 0 on system reset.
+
+
+Triggering the Firmware Update
+******************************
+
+To initiate the firmware update process, the guest issues a standard system reset
+operation through any of the means implemented by the machine model.
+
+On reset, the hypervisor evaluates whether ``vmfwupdate/disable`` is ``1``. If it is, it ignores
+any other vmfwupdate values and performs a standard system reset.
+
+If ``vmfwupdate/disable`` is ``0``, the hypervisor checks if bios-addr is ``0``. If it is, it
+performs a standard system reset.
+
+If ``vmfwupdate/bios-addr`` is ``non-0``, the hypervisor replaces the contents of the system’s
+BIOS region with the guest physically contiguous ``vmfwupdate/bios-size`` sized payload at the
+guest physical address address vmfwupdate/bios-addr.
+
+The firmware update mechanism works both for confidential and non-confidential
+guests. In confidential guests, as a part of the reset operation, all existing
+guest shared memory (shared with the hypervisor) as well as the ``vmfwupdate/opaque`` file
+are preserved. The reset causes recreation of the VM context which triggers a fresh
+measurement of the replaced BIOS region and reset CPU state [2]_ .
+For non-confidential guests, there is no concept of guest private memory and all the existing
+guest memory is preserved (this is the default behavior today - QEMU does not reset/clear
+guest memory upon reset).
+
+In both confidential and non-confidential cases, CPU and device state are reset to
+the default hypervisor specific reset states. In confidential environments, the guest
+always resumes operation in the highest privileged mode available to it (VMPL0 in SEV-SNP).
+
+Closing Remarks
+***************
+The handover protocol (format of the ``vmwupdate/opaque`` file etc.) will be implemented by
+the firmware loader and firmware image, both provided by the guest.  The hypervisor does
+not need to know these details, so it is not included in this specification.
+
+
+
+Footnotes:
+^^^^^^^^^^
+.. [1] Original author of the specification: *Alex Graf <graf@amazon.com>*,
+       converted to re-structured-text (rst format) and slightly edited
+       by *Ani Sinha <anisinha@redhat.com>*.
+.. [2] Currently SEV-SNP guests do not support reset. Upon reset, the instance is
+       terminated and a new instance must be created with new VM confidential context.
+       Work is being done currently to support resetting SEV-SNP guests with a new
+       confidential/SEV context after reset.
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 254cc20c4c..35b56916fb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/misc/vmfwupdate.h"
 #include "audio/audio.h"
 
 GlobalProperty hw_compat_9_2[] = {
@@ -256,6 +257,7 @@ GlobalProperty hw_compat_2_8[] = {
     { "virtio-pci", "x-pcie-pm-init", "off" },
     { "cirrus-vga", "vgamem_mb", "8" },
     { "isa-cirrus-vga", "vgamem_mb", "8" },
+    {TYPE_VMFWUPDATE, "disable", "1"},
 };
 const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0eb52d315b..db8792b431 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -53,6 +53,7 @@
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/misc/vmfwupdate.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/i386/kvm/xen_overlay.h"
@@ -1719,10 +1720,64 @@ static void pc_machine_initfn(Object *obj)
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
+static void handle_vmfwupd_reset(MachineState *machine,
+                                 ResetType type, VMFwUpdateState *vmfw)
+{
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    void *biosmem = memory_region_get_ram_ptr(&x86ms->bios);
+    uint64_t bios_size = memory_region_size(&x86ms->bios);
+
+    if (type != RESET_TYPE_COLD) {
+        return;
+    }
+
+    if (vmfw->disable) {
+        return;
+    }
+
+    if (!vmfw->fw_blob.bios_paddr) {
+        return;
+    }
+
+    if (!vmfw->fw_blob.bios_size) {
+        return;
+    }
+
+    g_assert(!(vmfw->fw_blob.bios_size % 65536));
+    g_assert(vmfw->fw_blob.bios_size <= vmfw->plat_bios_size);
+
+    /*
+     * bios memory region initialization will need to be performed here
+     * if bios_size < vfw->plat_bios_size. We may need to call
+     * memory_region_init_ram() or memory_region_init_ram_guest_memfd()
+     * to initialize a new bios memory region.
+     */
+
+    /*
+     * Read new BIOS from guest RAM into the BIOS region.
+     */
+    cpu_physical_memory_read(vmfw->fw_blob.bios_paddr,
+                             biosmem + bios_size - vmfw->fw_blob.bios_size,
+                             vmfw->fw_blob.bios_size);
+    x86_firmware_configure(0x100000000ULL - vmfw->fw_blob.bios_size,
+                           biosmem, vmfw->fw_blob.bios_size);
+}
+
 static void pc_machine_reset(MachineState *machine, ResetType type)
 {
     CPUState *cs;
     X86CPU *cpu;
+    VMFwUpdateState *vmfw = vmfwupdate_find();
+
+    /*
+     * When vmfwupdate device is present, handle reset actions for
+     * this firmware update device. The reset operations are
+     * defined in the device specification document. See
+     * docs/specs/vmfwupdate.rst.
+     */
+    if (vmfw) {
+        handle_vmfwupd_reset(machine, type, vmfw);
+    }
 
     qemu_devices_reset(type);
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 69bfc00b9a..c00fafab04 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -357,10 +357,18 @@ static int x86_kvm_type(MachineState *ms, const char *vm_type)
     return kvm_enabled() ? kvm_get_vm_type(ms) : 0;
 }
 
+static uint64_t mr_bios_size_x86(MachineState *ms)
+{
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    return memory_region_size(&x86ms->bios);
+}
+
 static void x86_machine_initfn(Object *obj)
 {
+    MachineState *ms = MACHINE(obj);
     X86MachineState *x86ms = X86_MACHINE(obj);
 
+    ms->mr_bios_size = mr_bios_size_x86;
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->acpi = ON_OFF_AUTO_AUTO;
     x86ms->pit = ON_OFF_AUTO_AUTO;
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 55f493521b..e806bf48f5 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -150,6 +150,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
+specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmfwupdate.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
new file mode 100644
index 0000000000..5007139f8c
--- /dev/null
+++ b/hw/misc/vmfwupdate.c
@@ -0,0 +1,208 @@
+/*
+ * Guest driven VM boot component update device
+ * For details and specification, please look at docs/specs/vmfwupdate.rst.
+ *
+ * Copyright (C) 2025 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "system/reset.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/i386/pc.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/vmfwupdate.h"
+#include "qemu/error-report.h"
+
+/*
+ * the following is the list of machines currently
+ * supporting this device.
+ * If a new machine is added in this list, the
+ * corresponding vm/machine reset operations must also
+ * be implemented. Please see pc_machine_reset() ->
+ * handle_vmfwupd_reset() as an example. The reset
+ * implementation must adhere to the device spec.
+ */
+static const char *supported_machines[] = {
+    TYPE_X86_MACHINE,
+    NULL,
+};
+
+static const char *vmfwupdate_supported(void)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const char **machine = supported_machines;
+    while (*machine) {
+        if (object_dynamic_cast(OBJECT(ms), *machine)) {
+            return *machine;
+        }
+        machine++;
+    }
+    return NULL;
+}
+
+static uint64_t get_bios_size(void)
+{
+    Object *m_obj = qdev_get_machine();
+    MachineState *ms = MACHINE(m_obj);
+
+    if (ms->mr_bios_size) {
+        return ms->mr_bios_size(ms);
+    } else {
+        /*
+         * for machine types and platforms where the call is not implemented,
+         * return 0 for now.
+         */
+        return 0;
+    }
+}
+
+static void fw_blob_write(void *dev, off_t offset, size_t len)
+{
+    VMFwUpdateState *s = VMFWUPDATE(dev);
+
+    /* for non-pc platform, we do not allow changing bios_size yet */
+    if (!s->plat_bios_size) {
+        return;
+    }
+
+    /*
+     * in order to change the bios size, appropriate capability
+     * must be enabled
+     */
+    if (s->fw_blob.bios_size &&
+        !(s->capability & VMFWUPDATE_CAP_BIOS_RESIZE)) {
+        warn_report("vmfwupdate: VMFWUPDATE_CAP_BIOS_RESIZE not enabled");
+        return;
+    }
+
+    /*
+     * For now, we do not let the guest resize the bios size to a value
+     * larger than the size of the memory region that holds the current image.
+     * If the size is larger, we may have to reinitialize the bios
+     * memory region. For pc, see x86_bios_rom_init().
+     */
+    if (s->fw_blob.bios_size > get_bios_size()) {
+        warn_report("vmfwupdate: bios size cannot be larger than %" PRIu64,
+                    get_bios_size());
+        return;
+    }
+
+    s->plat_bios_size = s->fw_blob.bios_size;
+
+    return;
+}
+
+static void vmfwupdate_realize(DeviceState *dev, Error **errp)
+{
+    VMFwUpdateState *s = VMFWUPDATE(dev);
+    FWCfgState *fw_cfg = fw_cfg_find();
+
+    /* multiple devices are not supported */
+    if (!vmfwupdate_find()) {
+        error_setg(errp, "at most one %s device is permitted",
+                   TYPE_VMFWUPDATE);
+        return;
+    }
+
+    /* if current machine is not supported, do not initialize */
+    if (!vmfwupdate_supported()) {
+        error_setg(errp, "This machine does not support vmfwupdate device");
+        return;
+    }
+
+    /* fw_cfg with DMA support is necessary to support this device */
+    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
+        error_setg(errp, "%s device requires fw_cfg",
+                   TYPE_VMFWUPDATE);
+        return;
+    }
+
+    /*
+     * If the device is disabled on purpose, do not initialize.
+     * Old machines like pc-i440fx-2.8 does not have enough fw-cfg slots
+     * and hence this device is disabled for those machines.
+     */
+    if (s->disable) {
+        info_report("vmfwupdate device is disabled on the command-line");
+        return;
+    }
+
+    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
+    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
+
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
+                             NULL, NULL, s,
+                             &s->opaque_blobs,
+                             sizeof(s->opaque_blobs),
+                             false);
+
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
+                             NULL, fw_blob_write, s,
+                             &s->fw_blob,
+                             sizeof(s->fw_blob),
+                             false);
+
+    /*
+     * Add global capability fw_cfg file. This will be used by the guest to
+     * check capability of the hypervisor.
+     * We do not allow the guest to change bios size for now.
+     * Effectively all capability bits are cleared for now.
+     */
+    memset(&s->capability, 0, sizeof(s->capability));
+
+    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
+                    &s->capability, sizeof(s->capability));
+
+    s->plat_bios_size = get_bios_size(); /* for non-pc, this is 0 */
+    /* size of bios region for the platform - read only by the guest */
+    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
+                    &s->plat_bios_size, sizeof(s->plat_bios_size));
+    /*
+     * add fw cfg control file to disable the hypervisor interface.
+     */
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
+                             NULL, NULL, s,
+                             &s->disable,
+                             sizeof(s->disable),
+                             false);
+    /*
+     * This device requires to register a global reset because it is
+     * not plugged to a bus (which, as its QOM parent, would reset it).
+     */
+    qemu_register_resettable(OBJECT(s));
+}
+
+static const Property vmfwupdate_properties[] = {
+    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
+};
+
+static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    /* we are not interested in migration - so no need to populate dc->vmsd */
+    dc->desc = "VM firmware update device";
+    dc->realize = vmfwupdate_realize;
+    dc->hotpluggable = false;
+    device_class_set_props(dc, vmfwupdate_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vmfwupdate_device_types[] = {
+    {
+        .name          = TYPE_VMFWUPDATE,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(VMFwUpdateState),
+        .class_init    = vmfwupdate_device_class_init,
+    },
+};
+
+DEFINE_TYPES(vmfwupdate_device_types)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e1f41b2a53..eaba4aedf9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -441,6 +441,7 @@ struct MachineState {
     SmpCache smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
+    uint64_t (*mr_bios_size)(MachineState *ms);
 };
 
 /*
diff --git a/include/hw/misc/vmfwupdate.h b/include/hw/misc/vmfwupdate.h
new file mode 100644
index 0000000000..2e1b9b9ba1
--- /dev/null
+++ b/include/hw/misc/vmfwupdate.h
@@ -0,0 +1,101 @@
+/*
+ * Guest driven VM boot component update device
+ * For details and specification, please look at docs/specs/vmfwupdate.rst.
+ *
+ * Copyright (C) 2025 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef VMFWUPDATE_H
+#define VMFWUPDATE_H
+
+#include "hw/qdev-core.h"
+#include "qom/object.h"
+#include "qemu/units.h"
+
+#define TYPE_VMFWUPDATE "vmfwupdate"
+
+#define VMFWUPDATE_CAP_BIOS_RESIZE 0x01 /* guests may resize bios region */
+
+#define VMFWUPDATE_OPAQUE_SIZE (4 * KiB) /* PAGE_SIZE */
+
+/* fw_cfg file definitions */
+#define FILE_VMFWUPDATE_OBLOB "etc/vmfwupdate/opaque-blob"
+#define FILE_VMFWUPDATE_FWBLOB "etc/vmfwupdate/fw-blob"
+#define FILE_VMFWUPDATE_CAP "etc/vmfwupdate/cap"
+#define FILE_VMFWUPDATE_BIOS_SIZE "etc/vmfwupdate/bios-size"
+#define FILE_VMFWUPDATE_CONTROL "etc/vmfwupdate/disable"
+
+/*
+ * Address and length of the guest provided firmware blob.
+ * The blob itself is passed using the guest shared memory to QEMU.
+ * This is then copied to the guest private memeory in the secure vm
+ * by the hypervisor.
+ */
+typedef struct {
+    uint64_t bios_size; /*
+                         * this is used by the guest to update plat_bios_size
+                         * when VMFWUPDATE_CAP_BIOS_RESIZE is set.
+                         */
+    uint64_t bios_paddr; /*
+                          * starting gpa where the blob is in shared guest
+                          * memory. Cleared upon system reset.
+                          */
+} VMFwUpdateFwBlob;
+
+typedef struct VMFwUpdateState {
+    DeviceState parent_obj;
+
+    /*
+     * capabilities - 64 bits.
+     * Little endian format.
+     */
+    uint64_t capability;
+
+    /*
+     * size of the bios region - architecture dependent.
+     * Read-only by the guest unless VMFWUPDATE_CAP_BIOS_RESIZE
+     * capability is set.
+     */
+    uint64_t plat_bios_size;
+
+    /*
+     * disable - disables the interface when non-zero value is written to it.
+     * Writing 0 to this file enables the interface.
+     */
+    uint8_t disable;
+
+    /*
+     * The first stage boot uses this opaque blob to convey to the next stage
+     * where the next stage components are loaded. The exact structure and
+     * number of entries are unknown to the hypervisor and the hypervisor
+     * does not touch this memory or does any validations. The contents of
+     * this memory survives a vm reset.
+     * The contents of this memory needs to be validated by the guest and
+     * must be ABI compatible between the first and second boot stages of
+     * the guest.
+     */
+    unsigned char opaque_blobs[VMFWUPDATE_OPAQUE_SIZE];
+
+    /*
+     * firmware blob addresses and sizes. These are moved to guest
+     * private memory.
+     */
+    VMFwUpdateFwBlob fw_blob;
+} VMFwUpdateState;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VMFwUpdateState, VMFWUPDATE);
+
+/* returns NULL unless there is exactly one device */
+static inline VMFwUpdateState *vmfwupdate_find(void)
+{
+    Object *o = object_resolve_path_type("", TYPE_VMFWUPDATE, NULL);
+
+    return o ? VMFWUPDATE(o) : NULL;
+}
+
+#endif
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b516d21cba..5e455f2e03 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -80,6 +80,7 @@ tests_aarch64_system_thorough = [
   'aarch64_xen',
   'aarch64_xlnx_versal',
   'multiprocess',
+  'vmfwupdate',
 ]
 
 tests_alpha_system_quick = [
@@ -277,6 +278,7 @@ tests_x86_64_system_quick = [
   'virtio_version',
   'x86_cpu_model_versions',
   'vnc',
+  'vmfwupdate',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/functional/test_vmfwupdate.py b/tests/functional/test_vmfwupdate.py
new file mode 100644
index 0000000000..13eefd3d75
--- /dev/null
+++ b/tests/functional/test_vmfwupdate.py
@@ -0,0 +1,82 @@
+#!/usr/bin/env python3
+#
+# Check for vmfwupdate device.
+#
+# Copyright (c) 2025 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+import time
+
+class VmFwUpdateDeviceCheck(QemuSystemTest):
+    DELAY_BOOT_SEQUENCE = 1
+
+    def test_vmfwupdate_pass(self):
+        """
+        Basic test to make sure vmfwupdate device can be instantiated.
+        """
+        if self.arch != 'x86_64':
+            return
+
+        self.vm.add_args('-device', 'vmfwupdate,id=fwupd1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertEqual(self.vm.exitcode(), 0, "QEMU exit code should be 0")
+
+    def test_vmfwupdate_disabled(self):
+        """
+        Basic test to make sure vmfwupdate device can be instantiated.
+        """
+        if self.arch != 'x86_64':
+            return
+
+        self.vm.add_args('-device', 'vmfwupdate,id=fwupd,disable=1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertRegex(self.vm.get_log(),
+                         r'vmfwupdate device is disabled on the command-line')
+        self.assertEqual(self.vm.exitcode(), 0, "QEMU exit code should be 0")
+
+    def test_multiple_device_fail(self):
+        """
+        Only one vmfwdevice can be instantiated. Ensure failure if
+        user tries to create more than one device.
+        """
+        if self.arch != 'x86_64':
+            return
+
+        self.vm.add_args('-device', 'vmfwupdate,id=fw1',
+                         '-device', 'vmfwupdate,id=fw2')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(),
+                         r'at most one vmfwupdate device is permitted')
+
+    def aarch64_fail_test(self):
+        """
+        Currently the device is only supported for pc platforms.
+        """
+        if self.arch != 'aarch64':
+            return
+
+        self.vm.add_args('-machine', 'virt', '-device',
+                         'vmfwupdate,id=fwupd1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(),
+                         r'This machine does not support vmfwupdate device')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 68316dbdc1..2b82fb2ea8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -58,6 +58,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_Q35') ? ['vmfwupdate-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
diff --git a/tests/qtest/vmfwupdate-test.c b/tests/qtest/vmfwupdate-test.c
new file mode 100644
index 0000000000..9bbe0bf560
--- /dev/null
+++ b/tests/qtest/vmfwupdate-test.c
@@ -0,0 +1,67 @@
+/*
+ * vmfwupdate device fwcfg test.
+ *
+ * Copyright (c) 2025 Red Hat, Inc.
+ *
+ * Author:
+ *   Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
+#include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
+#include "hw/misc/vmfwupdate.h"
+
+static void test_vmfwupdate_capability(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint64_t capability = 0;
+    size_t filesize;
+
+    s = qtest_init("-device vmfwupdate");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMFWUPDATE_CAP,
+                                &capability, sizeof(capability));
+    g_assert_cmpint(filesize, ==, sizeof(capability));
+    capability = le64_to_cpu(capability);
+    g_assert_cmpint(capability, ==, 0);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
+static void test_vmfwupdate_bios_size(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint64_t bios_size = 0;
+    size_t filesize;
+
+    s = qtest_init("-device vmfwupdate");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
+                                &bios_size, sizeof(bios_size));
+    g_assert_cmpint(filesize, ==, sizeof(bios_size));
+    bios_size = le64_to_cpu(bios_size);
+    fprintf(stderr, "bios_size: %" PRIu64 "\n", bios_size);
+    g_assert_cmpint(bios_size, !=, 0);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("vmfwupdate/cap", test_vmfwupdate_capability);
+    qtest_add_func("vmfwupdate/bios_size", test_vmfwupdate_bios_size);
+
+    return g_test_run();
+}
-- 
2.45.2


