Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1400DCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNLg-0004fC-Ov; Sat, 30 Aug 2025 11:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryqV-0002Dk-2T
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryqP-0002Gh-Ek
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t1YLAREREMgvXglJ3soAfbuaGVQEaukQoE3lXSXWXHc=;
 b=IXJuO7OhYYaR+ckSkJgxWgTcfbPgj5o+Q19SKV37ohayfwL+81bYS5Oem3FfO+DVSFY8bI
 jhIQbhpw+s/ldgCZ7va+yUIhFoUyyzjQR72E1OGF99pyS8YXY4D9KCgBU3cRll4OmWgl8c
 2i+9FFI6wGbxY4AbhvPkNnIeDMRPbIU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-xZk1784iPHi0gC5Rw59BPg-1; Fri, 29 Aug 2025 08:59:39 -0400
X-MC-Unique: xZk1784iPHi0gC5Rw59BPg-1
X-Mimecast-MFC-AGG-ID: xZk1784iPHi0gC5Rw59BPg_1756472378
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ccd58af2bbso1091625f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472378; x=1757077178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t1YLAREREMgvXglJ3soAfbuaGVQEaukQoE3lXSXWXHc=;
 b=KOmINV1EAcWCgW1SlLbxvnh2GCD2oxXSk+XlrS1aZQjDcWNKkY1KPra9NjoOEkX8W1
 VzDXOWap+F6DX4+puqWFYyNKlohPq1WiKQWM0/18f5seH218E1YnfriN0oFLvgeaiAWC
 iw+vKxblWbt/1CqZ4eK1RJBswyg5N3Va5eGvbtHlWENlRAZk2jWxqm2hsrG6twbUK+Gw
 ukYsvpMs0NmfV0EESijdteJR+lbk6vsfFWRW83ZYQBlOM2Y+bI3WpdvK6nSZ3/X2r8Zi
 hWfbdGKjy21pkBIe8/dzIQ44sXd7R8aR4XlTQsWIZonFrKq5FSXPkqdeeWJ2ZiyStG9+
 RIfg==
X-Gm-Message-State: AOJu0Yz6/ZXsv6zoCrkpSX5Ybi4z0uRTgx7b/Y3Ahk4J62z3KU3Di+3h
 dxGFheuZJZaXep2q+Xf2ovY06RHGrnhGSwubQGNWU/TpmD1UAO/d1caNDfPwgE/GgXodGVoQmIz
 zeDaZpt3j+uTBlyd27jrCj0L3vktpnaEnlkj5O2h34kukpI4NovD+jj2BzGjSnSL3skJZBph0en
 SYw5c1d3QENRx18J17wg6JKIQyEkSDTZjaK44hflFJ
X-Gm-Gg: ASbGncsW9StrlZqBxHQjbscsl+TInuVYROVcZjqMIeaHHPozJJ/cobI1jW3qz/UGDvv
 jcI08AhwfcbSdbpMZkmhzz82XjZhJul18xlaQqu+UI03uljQpUONX7tAzlv+4WIBqOxwhOR+/pM
 iDmgNm972F6S0Kw0fizpgHNoyRUu4ae0eDbLxvuZOEUMCZXhtadZ3sfGBLCMCkiB6j4CJLGMIfr
 4RWIQkIh1pSrJnIk+MM2ms+yybkWjOrAAw6nzyJZMxYjycEr1CBw/Ur9tpZ1Eiu3HR/dxlLDflO
 CC0ri4F/zXU5l5TQPgsBLDtoSYa4UPTkdCSQPziM9Fgbkgg7U0iR90sI14bTMxkNp62H7bM3XTt
 CZZeRXbE2KsPKnUUNZa9wEVmlBXb7g1lpOlps3U8DbDY=
X-Received: by 2002:a05:6000:24c3:b0:3d1:2828:c2ee with SMTP id
 ffacd0b85a97d-3d12828ca25mr833783f8f.11.1756472377805; 
 Fri, 29 Aug 2025 05:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDrEt6fzHmZXZ5g5IXTjkYeKXPP2Gxk6MQTC/7slewC8bXhb6P+837H+nZ1i/nqcJTMie9ZQ==
X-Received: by 2002:a05:6000:24c3:b0:3d1:2828:c2ee with SMTP id
 ffacd0b85a97d-3d12828ca25mr833761f8f.11.1756472377258; 
 Fri, 29 Aug 2025 05:59:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d643dsm3361021f8f.26.2025.08.29.05.59.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] i386, accel, memory patches for 2025-08-29
Date: Fri, 29 Aug 2025 14:59:07 +0200
Message-ID: <20250829125935.1526984-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 59f504bb43366594e97cf496c9a9ccf59be00b73:

  Merge tag 'pull-loongarch-20250828' of https://github.com/gaosong715/qemu into staging (2025-08-29 07:44:50 +1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 83bd8e65bc70cef03a207df315004f8b1301dc53:

  tcg: move interrupt caching and single step masking closer to user (2025-08-29 12:48:14 +0200)

----------------------------------------------------------------
* hw/i386: split isapc from PCI boards
* cpu-exec, accel: remove BQL usage for interrupt_request != 0
* memory, hpet, pmtimer: introduce BQL-free PIO/MMIO

----------------------------------------------------------------
Igor Mammedov (8):
      add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide
      memory: reintroduce BQL-free fine-grained PIO/MMIO
      acpi: mark PMTIMER as unlocked
      hpet: switch to fine-grained device locking
      hpet: move out main counter read into a separate block
      hpet: make main counter read lock-less
      kvm: i386: irqchip: take BQL only if there is an interrupt
      tcg: move interrupt caching and single step masking closer to user

Mark Cave-Ayland (19):
      hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
      hw/i386/pc_piix.c: restrict isapc machine to 3.5G memory
      hw/i386/pc_piix.c: remove include for loader.h
      hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into pc_xen_hvm_init()
      hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
      hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation from pc_init_isa()
      hw/i386/pc_piix.c: remove igvm initialisation from pc_init_isa()
      hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from pc_init_isa()
      hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
      hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
      hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
      hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
      hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from pc_init_isa()
      hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
      hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()
      hw/i386: move isapc machine to separate isapc.c file
      hw/i386/pc_piix.c: remove unused headers after isapc machine split
      hw/i386/pc_piix.c: replace rom_memory with pci_memory
      hw/i386/isapc.c: replace rom_memory with system_memory

Paolo Bonzini (1):
      user-exec: ensure interrupt_request is not used

 include/hw/core/cpu.h               |  23 ++++
 include/system/memory.h             |  12 ++
 accel/tcg/cpu-exec.c                |  31 +++--
 accel/tcg/tcg-accel-ops.c           |   2 +-
 accel/tcg/user-exec.c               |   4 +-
 hw/acpi/core.c                      |   1 +
 hw/i386/isapc.c                     | 189 +++++++++++++++++++++++++++
 hw/i386/pc_piix.c                   | 248 ++++++++++++------------------------
 hw/intc/s390_flic.c                 |   2 +-
 hw/openrisc/cputimer.c              |   2 +-
 hw/timer/hpet.c                     |  38 ++++--
 system/cpus.c                       |   9 +-
 system/memory.c                     |  15 +++
 system/physmem.c                    |   2 +-
 target/alpha/cpu.c                  |   8 +-
 target/arm/cpu.c                    |  20 +--
 target/arm/helper.c                 |  18 +--
 target/arm/hvf/hvf.c                |   6 +-
 target/avr/cpu.c                    |   2 +-
 target/hppa/cpu.c                   |   2 +-
 target/i386/hvf/hvf.c               |   4 +-
 target/i386/hvf/x86hvf.c            |  21 ++-
 target/i386/kvm/kvm.c               |  46 ++++---
 target/i386/nvmm/nvmm-all.c         |  24 ++--
 target/i386/tcg/system/seg_helper.c |   2 +-
 target/i386/tcg/system/svm_helper.c |   2 +-
 target/i386/whpx/whpx-all.c         |  34 ++---
 target/loongarch/cpu.c              |   2 +-
 target/m68k/cpu.c                   |   2 +-
 target/microblaze/cpu.c             |   2 +-
 target/mips/cpu.c                   |   6 +-
 target/mips/kvm.c                   |   2 +-
 target/openrisc/cpu.c               |   3 +-
 target/ppc/cpu_init.c               |   2 +-
 target/ppc/kvm.c                    |   2 +-
 target/rx/cpu.c                     |   3 +-
 target/rx/helper.c                  |   2 +-
 target/s390x/cpu-system.c           |   2 +-
 target/sh4/cpu.c                    |   2 +-
 target/sh4/helper.c                 |   2 +-
 target/sparc/cpu.c                  |   2 +-
 target/sparc/int64_helper.c         |   4 +-
 hw/i386/Kconfig                     |   3 -
 hw/i386/meson.build                 |   1 +
 44 files changed, 490 insertions(+), 319 deletions(-)
 create mode 100644 hw/i386/isapc.c
-- 
2.51.0


