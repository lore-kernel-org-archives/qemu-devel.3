Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5027C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1QA-00068b-RO; Thu, 08 May 2025 09:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Q7-00067o-1J
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:36:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Q3-0003gg-1g
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:36:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e661313a3so9802375ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711368; x=1747316168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9KuBrSw61wT1TUDNwR8So3hV4T+jBIcjNnsvQibQhUU=;
 b=v7MK66rWl+/gtcAjLXnjGZ1UPMBUlatDxgLkdFo80EJm+v0uSPfJ/gKS9XZid5Jr6n
 6GNmaZOx5BqV/ZcTb4FihCfxmUdrQmZsqxD/E6fHEV8PWWv2VdA9mDbJcXU2uOKussQH
 O+XLH53pbIjyMBRZ730H7kAvGybtZvbjISjtyOlTlqKiy/trlBrCwJE6GQ+7qrR/Ohbv
 pVzxiYyo4p/CRgSJkQIlz7efrPmj9eKSJ80mLgcKzJbWfi5sb2pNccSHSsb3ESPh026d
 tSrRF+oYPqjfS/X2Jg1Hgz+lnYbDKqmWI+1nOtMnIpHy8WV+7Jzbza4CH5SEHjY0ntPt
 SnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711368; x=1747316168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9KuBrSw61wT1TUDNwR8So3hV4T+jBIcjNnsvQibQhUU=;
 b=YYFh/6kUuz4PKxkokbsqS6+Y4Ld7ASGgU+BWph3yccM2EmknajKqDUawENsK8FibVe
 AIaSNzAxG2Ra0VjyTjU1LoE/tV1s3pfI1rcNgHRgvsXPEcxeclSrXns9WnqGtxLyvxzo
 NzmvaAhE+r9PB1i4uNm6wtNd/OE1Jf5nbKON4knsooi3nQ6pbRMGu3Wh6u+6g4NHIVdL
 XD1sSdL4SZKbXuKu0YyuzeMC757Igqd86jss2Y/uhaqcEJk1rmRrIm1+21iBGJcBOIkZ
 0xL2QEYurCTgkutmFDKjSAt2Uawl6wFZI6n8SK4/tiSgDNA/+rLE2mp+zY6IcDfZ9YS1
 w+sw==
X-Gm-Message-State: AOJu0YztPt1Oe5RGfcGDUZ+49YatFCymUIfpwwl/ohit99WlqoKg0rpc
 FdqYUVr5y9upOHBVUqDmS0fJxEJ59LhR87eEjAg2ekC1QXwjY8xWwz7tnLJ3qdld8gcJnVRmA7k
 UieCBpg==
X-Gm-Gg: ASbGncu6mr3byV1/W/sxCM8Sj31K9NzDu2r/dWwaaZgHQlTH7A2nz25NNfANFVl//fP
 3l8iAznTo2065+utd3WtY0lt6qTgE2dr7s95jhUjIa4PXA4Ub5Zw+yCSnONYQPBQv6aELMZaf5e
 Dc7owhoO+l5HdUATWLtfG+T2SoCb0dbrDxATeAEMFI6AWt1nJOBqvL4utxoGoPF5ktlX+gP+b7p
 /8f4T7y3ugZ/Shfc6DFbWmXmeVGmbPWPU+rGBlVH/tKFrfV6GPCzo5Mp418hXENaEW62O9DDtY2
 N/GEJrnTcH2A6Dnt7+PvRdoDaBCdMYSyJhy9gXay+W+VPOxpW7MZDkF6nZhTvA6ev4c4UffH1Sf
 IJDhGGLh9va5sArn8Kjjpg8cViA==
X-Google-Smtp-Source: AGHT+IHCT7Ta0iqmowfn6JqxQ1updQHvZZpvmqe29UPiMd4qZ7+roOQP5pRKO/ivAKjg6VTKGbWo9g==
X-Received: by 2002:a17:903:478d:b0:220:e924:99dd with SMTP id
 d9443c01a7336-22e5ecc52a4mr120970055ad.34.1746711368214; 
 Thu, 08 May 2025 06:36:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fd31sm112108055ad.130.2025.05.08.06.35.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:36:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
Date: Thu,  8 May 2025 15:35:23 +0200
Message-ID: <20250508133550.81391-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62e.google.com
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

Since v3:
- Addressed Thomas and Zhao review comments
- Rename fw_cfg_init_mem_[no]dma() helpers
- Remove unused CPU properties
- Remove {multi,linux}boot.bin
- Added R-b tags

Since v2:
- Addressed Mark review comments and added his R-b tags

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.6 and 2.7 machines removal,
as it is a big enough number of LoC removed. Rest will
follow.

Based-on: <20250506143905.4961-1-philmd@linaro.org>

Philippe Mathieu-Daudé (27):
  hw/i386/pc: Remove deprecated pc-q35-2.6 and pc-i440fx-2.6 machines
  hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
  hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with '_nodma' suffix
  hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem_nodma()
  hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
  hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
    fw_cfg_init_mem_dma()
  hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
  hw/i386/pc: Remove multiboot.bin
  hw/nvram/fw_cfg: Remove fw_cfg_io_properties::dma_enabled
  hw/i386/pc: Remove linuxboot.bin
  hw/i386/pc: Remove pc_compat_2_6[] array
  target/i386/cpu: Remove CPUX86State::enable_cpuid_0xb field
  target/i386/cpu: Remove CPUX86State::fill_mtrr_mask field
  hw/intc/apic: Remove APICCommonState::legacy_instance_id field
  hw/core/machine: Remove hw_compat_2_6[] array
  hw/virtio/virtio-mmio: Remove
    VirtIOMMIOProxy::format_transport_address field
  hw/i386/pc: Remove deprecated pc-q35-2.7 and pc-i440fx-2.7 machines
  hw/i386/pc: Remove pc_compat_2_7[] array
  target/i386/cpu: Remove CPUX86State::full_cpuid_auto_level field
  target/i386/cpu: Remove CPUX86State::enable_l3_cache field
  hw/audio/pcspk: Remove PCSpkState::migrate field
  hw/core/machine: Remove hw_compat_2_7[] array
  hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
  hw/intc/ioapic: Remove IOAPICCommonState::version field
  hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
    field
  hw/char/virtio-serial: Do not expose the 'emergency-write' property
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ definition

 hw/intc/ioapic_internal.h           |   3 +-
 include/hw/acpi/cpu_hotplug.h       |   3 -
 include/hw/boards.h                 |   6 -
 include/hw/i386/apic_internal.h     |   1 -
 include/hw/i386/intel_iommu.h       |   1 -
 include/hw/i386/pc.h                |   9 --
 include/hw/i386/x86.h               |   2 -
 include/hw/nvram/fw_cfg.h           |   9 +-
 include/hw/virtio/virtio-mmio.h     |   1 -
 include/hw/virtio/virtio-pci.h      |   2 -
 include/hw/virtio/virtio-serial.h   |   2 -
 pc-bios/optionrom/optionrom.h       |   4 -
 target/i386/cpu.h                   |  15 --
 hw/acpi/cpu_hotplug.c               | 230 ---------------------------
 hw/arm/virt.c                       |   2 +-
 hw/audio/pcspk.c                    |  10 --
 hw/char/virtio-serial-bus.c         |   9 +-
 hw/core/machine.c                   |  17 --
 hw/display/virtio-vga.c             |  10 --
 hw/hppa/machine.c                   |   2 +-
 hw/i386/acpi-build.c                |   4 +-
 hw/i386/fw_cfg.c                    |   5 +-
 hw/i386/intel_iommu.c               |   5 +-
 hw/i386/microvm.c                   |   3 -
 hw/i386/multiboot.c                 |   7 +-
 hw/i386/pc.c                        |  22 +--
 hw/i386/pc_piix.c                   |  23 ---
 hw/i386/pc_q35.c                    |  24 ---
 hw/i386/x86-common.c                |   6 +-
 hw/i386/x86.c                       |   2 -
 hw/intc/apic_common.c               |   5 -
 hw/intc/ioapic.c                    |  18 +--
 hw/intc/ioapic_common.c             |   2 +-
 hw/mips/loongson3_virt.c            |   2 +-
 hw/nvram/fw_cfg.c                   |  48 +++---
 hw/riscv/virt.c                     |   4 +-
 hw/virtio/virtio-mmio.c             |  15 --
 hw/virtio/virtio-pci.c              |  12 +-
 target/i386/cpu.c                   | 152 ++++++++----------
 target/i386/kvm/kvm.c               |  10 +-
 tests/qtest/test-x86-cpuid-compat.c |  11 --
 pc-bios/meson.build                 |   2 -
 pc-bios/multiboot.bin               | Bin 1024 -> 0 bytes
 pc-bios/optionrom/Makefile          |   2 +-
 pc-bios/optionrom/linuxboot.S       | 195 -----------------------
 pc-bios/optionrom/multiboot.S       | 232 ---------------------------
 pc-bios/optionrom/multiboot_dma.S   | 234 +++++++++++++++++++++++++++-
 47 files changed, 349 insertions(+), 1034 deletions(-)
 delete mode 100644 pc-bios/multiboot.bin
 delete mode 100644 pc-bios/optionrom/linuxboot.S
 delete mode 100644 pc-bios/optionrom/multiboot.S

-- 
2.47.1


