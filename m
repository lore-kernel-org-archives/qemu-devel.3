Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B86CD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPwW-0002El-9B; Wed, 27 Mar 2024 05:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwT-0002CH-Dr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:33 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwR-0006bt-30
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:33 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-513cf9bacf1so8687047e87.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533087; x=1712137887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PzptXiz+ck3TSURqGaOmlbce928PdtGTlHWQ8uE8o54=;
 b=t0cX9dUHNXN6qMJJvGnf8TsvNQsKUmZFgieI4C6B04oC3FYwF6r/F5wv5SJ8wIgn5R
 Rj4h63bFKyH7QtcPNdva1kx/ozU7SZNNWOPNpAMUFPu8q123DAAAUUoSujmt7cmvXwdX
 ymWvpGkrY8/DrE8qxQn/A+nhv/wSlTSPxVCsQ3Hs4o7AhSG+SAMnexUQyZsoywCwa79B
 IUD1+F11ruqIbu8LPXC1nYWz30xNuVkhAIgwkckIIs0qkFxN5YSMzTV+s8aKV+hkU885
 4GtP2VAzYG3qP5taSEQNB8l1+WGAwqCa+vcQTckoZak76sW2wDz3xqvf1G3j9cZzs/aN
 XppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533087; x=1712137887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PzptXiz+ck3TSURqGaOmlbce928PdtGTlHWQ8uE8o54=;
 b=CuvwDEHk4NosAJZQdggyfDsrooFcMdcZ7ZNPU4/8KJB1npakYMpKqRSw5BhUTsXH5O
 OTUz/1BBuFJXrWLh0xlZdgcFP++xv8mmsMcUmd1f2rSCR+K285cYrFNS9EMb8N9iN/uQ
 isKapIVF8/m9LySRvTJpaGPdW6FMJu0KfdhJtuKVoC5ioY5H8isZa7CikqZlzixSUfsd
 aYHZh14RWieWwUhAXGD9b3JFfdAPFyjhUWJ8V4LF0CwjFQC4Lnpq+vJeFi7SWHDa2mCC
 HsU3mc+FaLMKPXwEFS2xy4tI2kLMzkCnC28EsSQLuV7D72VVw3tTEqgljUAn4YVqOG95
 olmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGlDDwiZciafvRs0Pp3De+PjUg9Wdy21RrEr0mlxZMTDHcVBe3X7X2lbM5wLxd2BzWkx3yjLKq3mrM+fyXWb2z/3k17pk=
X-Gm-Message-State: AOJu0Yw9M7kL2XsavCYc+zmguYTyJ3nuE8W80+H5BodzMg6mQYVaqEj4
 Ql5ScqDCKNhm84cjFpLqrbM26g70Y2Y0PLbluJp9xoegy6TIUlyjs1URNeAm9d5MnFVwmpZ+D9v
 a
X-Google-Smtp-Source: AGHT+IFrRLDTgjxDLk+AoLGzBxvzXBGkjLIbnP1BO/QjIp1FKhHVZz5IExLlVWQjmBBbWD16rPwP6A==
X-Received: by 2002:ac2:4f0a:0:b0:515:c102:c825 with SMTP id
 k10-20020ac24f0a000000b00515c102c825mr294300lfr.19.1711533087243; 
 Wed, 27 Mar 2024 02:51:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a056402100d00b00568abb329a3sm5125344edu.88.2024.03.27.02.51.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:51:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 00/21] hw/i386: Remove deprecated pc-i440fx-2.0 ->
 2.3 machines
Date: Wed, 27 Mar 2024 10:51:02 +0100
Message-ID: <20240327095124.73639-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Missing review: 4-6, 10-12, 16, 19-20

Since v1:
- Addressed Zhao and Thomas review comments
- Removal around ICH9 acpi_memory_hotplug (Thomas)

Kill legacy code, because we need to evolve.

I ended there via dynamic machine -> ICH9 -> legacy ACPI...

This should also help Igor cleanups:
http://lore.kernel.org/qemu-devel/20240326171632.3cc7533d@imammedo.users.ipa.redhat.com/

Philippe Mathieu-Daudé (21):
  hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
  hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
  hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
  hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
  hw/acpi/ich9: Remove 'memory-hotplug-support' property
  hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
  hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
  target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
  hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
  hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
  hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
  hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
  hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
  hw/mem/memory-device: Remove legacy_align from
    memory_device_pre_plug()
  hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
  hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
  hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
  hw/i386/acpi: Remove AcpiBuildState::rsdp field
  hw/i386/pc: Remove 2.3 and deprecate 2.4 to 2.7 pc-i440fx machines
  target/i386: Remove X86CPU::kvm_no_smi_migration field
  hw/i386/pc: Replace PCMachineClass::acpi_data_size by
    PC_ACPI_DATA_SIZE

 docs/about/deprecated.rst             |   2 +-
 docs/about/removed-features.rst       |   2 +-
 hw/usb/hcd-xhci.h                     |   4 +-
 include/hw/firmware/smbios.h          |   3 +-
 include/hw/i386/pc.h                  |  22 ------
 include/hw/mem/memory-device.h        |   2 +-
 include/hw/mem/pc-dimm.h              |   3 +-
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ----------
 hw/acpi/ich9.c                        |  46 ++---------
 hw/arm/virt.c                         |   5 +-
 hw/i386/acpi-build.c                  |  95 ++---------------------
 hw/i386/fw_cfg.c                      |   3 +-
 hw/i386/pc.c                          | 107 ++++----------------------
 hw/i386/pc_piix.c                     | 101 ------------------------
 hw/loongarch/virt.c                   |   4 +-
 hw/mem/memory-device.c                |  12 +--
 hw/mem/pc-dimm.c                      |   6 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/riscv/virt.c                       |   2 +-
 hw/smbios/smbios.c                    |  13 +---
 hw/usb/hcd-xhci-nec.c                 |   4 -
 hw/usb/hcd-xhci-pci.c                 |   4 +-
 hw/usb/hcd-xhci.c                     |  42 ++--------
 hw/virtio/virtio-md-pci.c             |   2 +-
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 tests/avocado/mem-addr-space-check.py |   3 +-
 29 files changed, 64 insertions(+), 481 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

-- 
2.41.0


