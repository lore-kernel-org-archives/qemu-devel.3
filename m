Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F394BC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb5g-0000x4-3i; Thu, 01 May 2025 17:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb5d-0000uG-NE
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:05 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb5c-0006K7-0Z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:05 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8640d43f5e0so116478639f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133502; x=1746738302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=chTEKfhDE/uSKXfGIxpPQdBKtvzKQoAGrKDYUQ0Sip4=;
 b=hfGK94QIIMwlpKUZ+ZzcyoJO12fffAz4Hj5FATpQhcZTemRZz/YNvh4r++V8W11aSm
 CLibtCxFlQclfAXidXroyRYO8JkzWmd37Ujh6MsjvjoP2qkoWQQt2HjIpQ3yIYjpJXxh
 gvVVAS+yc/OMRouQnFk6LU+5oZZS1MjSqEyKP1YQ8CK6EVchlVhPa1LC85MuqAARVtfa
 gs1qlFZFFLsEzHLIoHyVXLS09Bv24V1gJ6jEIBwyVgD7FydEFe/I61OOIwXziNyb2bDH
 gF0TuyJYNpBYVhNQhy24QRYz6dWcmBD6FMuTlGX3Eb483pqUZzD0rzXc1bPh8Iy2/A6A
 CpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133502; x=1746738302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chTEKfhDE/uSKXfGIxpPQdBKtvzKQoAGrKDYUQ0Sip4=;
 b=urdtDY2JA9zEjZIDIqp1ufY1HQ7qVNamUQjVOMImu1ovdAbMcc2oXnFL1qg3d5eYPq
 0uFQbZ+2ROqK8zW9j3rM5UHG6Eak2aU6YSha8t/QeQCJPfCKcULironTdHQDE1FOzACM
 PEnPBus1JHc1uhz8Wj5tUSPQeCVBvYU8F/O0SwROc+d/wUtwK4Vlhnt7/v/fat5wyMPH
 BWaUTP9s9MNmQwKlRV9/mQ66RZHA3BqCYf247G5GdK86ynzBaz/ge7NhFqtyh7WlN7Yx
 V9X2nYg+jRnDeXCId8LXoJnTuTzdBucBhZQXUm/qlIsvGGO1OZWSE+EpIbPepdKrTQ3Z
 FSUA==
X-Gm-Message-State: AOJu0Yy4sHpaMu9scO89tI4Kl2MXYtOU6H1KpBcGqMZN0MDMoMzcihTT
 pu6iCX2mnZA8yHdV4EhWsl53h9Qo0aMfn+TjP3NcDXTEXorhx/2YqJZTGm+r/yVglhjH7j33GY5
 l
X-Gm-Gg: ASbGnct3xReIjIY1ql18dwaD6FL4k74RpaUz0h8SVM1DJiwFklVeW3lj1V9rYy70n9T
 V2QTixvJ/draU6i55cZhi4nx0eGA35mfpKKN8puuhWSHlnbK9NUZEOGO1sgVnxhSUtaNWh81djp
 Kk/l/IlS3cQfDlBFmWbBCdXLkFXgODVqHH8DTB9eKtWJ93BSN9xiKfZzb51pCuYpry0EudPQz86
 d09MqtbfNHLzXJtUNGom/LUDcpoxzqiSeMGuiKGOtv3zNcznD6zP9wNIurMqZTSJMBDChwLfHYg
 Md1QRO8IR6fHVMIZD2ke34YJ8QjHQLeTJEDzDajhKEzh2ZS3CdzmAjP3Acad2KVisBIMFlCDu0T
 1PY21Qv3Lqy9bvfE=
X-Google-Smtp-Source: AGHT+IE6kNRteRiGmxaRLSa1f3lpQOEIzr+o7N//ao4Lnp5V84KSDgoW6ndTXeYIWcZGkuWn3SfbzQ==
X-Received: by 2002:a05:6602:380e:b0:861:628f:2d2b with SMTP id
 ca18e2360f4ac-8669f993535mr117729439f.1.1746133502180; 
 Thu, 01 May 2025 14:05:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa585a1fsm25629439f.44.2025.05.01.14.04.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 00/18] hw/i386/pc: Remove deprecated 2.8 and 2.9 PC machines
Date: Thu,  1 May 2025 23:04:38 +0200
Message-ID: <20250501210456.89071-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.8 and 2.9 machines removal,
as it is a big enough number of LoC removed. Rest will
follow.

Based-on: <20250501183628.87479-1-philmd@linaro.org>

Philippe Mathieu-Daudé (18):
  hw/i386/pc: Remove deprecated pc-q35-2.8 and pc-i440fx-2.8 machines
  hw/i386/pc: Remove pc_compat_2_8[] array
  hw/southbridge/ich9: Remove ICH9_LPC_SMI_F_BROADCAST_BIT definition
  hw/i386/kvm: Remove KVMClockState::mach_use_reliable_get_clock field
  hw/core/machine: Remove hw_compat_2_8[] array
  hw/block/pflash: Remove PFlashCFI01::old_multiple_chip_handling field
  hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_DEVERR definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_LNKCTL definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_PM definition
  hw/nvram/fw_cfg: Remove FWCfgState::file_slots field
  hw/nvram/fw_cfg: Inline fw_cfg_file_slots()
  hw/i386/pc: Remove deprecated pc-q35-2.9 and pc-i440fx-2.9 machines
  hw/i386/pc: Remove pc_compat_2_9[] array
  hw/core/machine: Remove hw_compat_2_9[] array
  hw/net/virtio-net: Remove VirtIONet::mtu_bypass_backend field
  hw/pci-bridge/gen_pcie_rp: Remove GenPCIERootPort::migrate_msix field
  hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field

 include/hw/boards.h                |  6 -----
 include/hw/i386/pc.h               |  6 -----
 include/hw/i386/x86-iommu.h        |  1 -
 include/hw/nvram/fw_cfg.h          |  1 -
 include/hw/pci/pci.h               |  2 --
 include/hw/southbridge/ich9.h      |  1 -
 include/hw/virtio/virtio-net.h     |  1 -
 include/hw/virtio/virtio-pci.h     | 12 ----------
 hw/acpi/ich9.c                     |  6 ++---
 hw/block/pflash_cfi01.c            | 14 +++---------
 hw/core/machine.c                  | 22 -------------------
 hw/i386/amd_iommu.c                | 12 ++--------
 hw/i386/intel_iommu.c              | 13 ++---------
 hw/i386/kvm/clock.c                | 18 ---------------
 hw/i386/pc.c                       | 14 ------------
 hw/i386/pc_piix.c                  | 18 ---------------
 hw/i386/pc_q35.c                   | 18 ---------------
 hw/i386/x86-iommu.c                |  1 -
 hw/isa/lpc_ich9.c                  | 22 +++----------------
 hw/net/virtio-net.c                |  8 ++-----
 hw/nvram/fw_cfg.c                  | 35 ++++--------------------------
 hw/pci-bridge/gen_pcie_root_port.c | 16 ++------------
 hw/pci/pci.c                       |  2 --
 hw/pci/pcie.c                      |  5 -----
 hw/virtio/virtio-pci.c             | 35 ++++++++----------------------
 25 files changed, 29 insertions(+), 260 deletions(-)

-- 
2.47.1


