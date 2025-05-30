Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B575C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvL-0008D8-D8; Fri, 30 May 2025 03:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvK-0008Cw-Ld
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvI-0006nX-Ic
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0MNYloVPNKh7MQwa4zB8605g917Q9F4K6fJDmePAjcE=;
 b=CEF+ugxKGh6XbFTfFcqLeC5LQ7aOGRdKciaqgCRlWCw9x5FbEDqrHV80UGHObbYdm2jbEr
 m4+x9IiPj9buk6rvo+8FfAojwRm3UZ/1vXlVQU6vRpduKdsW/ggshjZvkX/W3JiufV2j6l
 1kczzJICCBPVRCSnGPn552hyC52cnRQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-DkHB0H6GPiGoEXroOidagg-1; Fri, 30 May 2025 03:12:54 -0400
X-MC-Unique: DkHB0H6GPiGoEXroOidagg-1
X-Mimecast-MFC-AGG-ID: DkHB0H6GPiGoEXroOidagg_1748589173
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6047edc5cebso1806140a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589173; x=1749193973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MNYloVPNKh7MQwa4zB8605g917Q9F4K6fJDmePAjcE=;
 b=ONPm2IJhwk36iltwdk6Car05oUUVxXJsFbQ5KKWsdZQ5UrxknxV63BtU3Y7x8ZQPRl
 Hpg3LqNCpzrKUNmD8jsDxS2h9W2nfDKggWm4TTrkk13n8pcHqJ6jWwrHFnVPleR0t6oU
 chUj6XLXfABdGiAFvsUa2RpuCI/INuUXMJVnTdGUejZBCQVA2Bjq47JdwSDxU3ZgdbZk
 XKeEmKzb5mlS4+yPNptQEg/Q+tvwXyjO2W7jz4Qhja5ajNS/rnByEdo3UKDG7YujCv9D
 8/jXv6/8r7AaiC6x++uZPHF7NP0Ks+cRrld0Jo8MqwXZbo7cZaSxwKAHW77PPPp4FMyo
 wJzw==
X-Gm-Message-State: AOJu0YyTbu+CEAl8Jqk2X7RJPTH2LZLTvQJtNHHBW7P5p30ic8tylRzW
 lfx0QJN4cWn3YuJtv61n56kltsmVy7QP28kURVPG4rwe74Tn0Hist292iWcgKYN0embzgiKWkc6
 EmZrl8zW73deIkMWSOmDjLPdQXEuY8Vob88D0mD/ZWYfbaybwDsLeZHKS35wq2/G1c1roK1wV1A
 tBOuQI2yqLwiY7/rUeOg5bNJLHUvqsJi0+sp5rJsai
X-Gm-Gg: ASbGncv6vN3Ts8U0BYVYsqvBBfVd58MNb74kgwwUIf6jYUnCXSYxiQEeJ3g1bP85Y+u
 wGOuidsgWcBz9ItAmeYnurrqj111SS4vHQ7CPlG73U6YmvKxhXlr8aP/kg1gE/JAEzxte4eU2vN
 yrn07bqq4dobz4053cc4345GmB5rqXH5kbZRdnYFFzneLnwkv7LwcF/7XeO73tIX4QXBhgVTh/V
 vUdTmrFZbBnx868VvnZfF366OcQ/gNOGFwgzwo9GiGNwQL8rkuLer66jpssnVQ/yzOIJ/DQuhFQ
 ArpC+RQeb+z/tA==
X-Received: by 2002:a05:6402:26c3:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-6056ef0065bmr1710251a12.24.1748589172511; 
 Fri, 30 May 2025 00:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyksS01RV99+SICxd23T7z+xeU3mYKS+PRpPX2Lg3H1NSdLO/sjO06DxJA1rxJbMiljafiPA==
X-Received: by 2002:a05:6402:26c3:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-6056ef0065bmr1710223a12.24.1748589171941; 
 Fri, 30 May 2025 00:12:51 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6056714632asm1174668a12.59.2025.05.30.00.12.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:12:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/77] i386, build system changes for 2025-05-30
Date: Fri, 30 May 2025 09:11:30 +0200
Message-ID: <20250530071250.2050910-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit f0737158b483e7ec2b2512145aeab888b85cc1f7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-05-20 10:26:30 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9bd24d8d2756a0771b6677b02c7f9b603ef6afe9:

  target/i386/tcg/helper-tcg: fix file references in comments (2025-05-28 19:35:55 +0200)

----------------------------------------------------------------
* target/i386/kvm: Intel TDX support
* target/i386/emulate: more lflags cleanups
* meson: remove need for explicit listing of dependencies in hw_common_arch and
  target_common_arch
* rust: small fixes
* hpet: Reorganize register decoding to be more similar to Rust code
* target/i386: fixes for AMD models
* target/i386: new EPYC-Turin CPU model

----------------------------------------------------------------
Babu Moger (6):
      target/i386: Update EPYC CPU model for Cache property, RAS, SVM feature bits
      target/i386: Update EPYC-Rome CPU model for Cache property, RAS, SVM feature bits
      target/i386: Update EPYC-Milan CPU model for Cache property, RAS, SVM feature bits
      target/i386: Add couple of feature bits in CPUID_Fn80000021_EAX
      target/i386: Update EPYC-Genoa for Cache property, perfmon-v2, RAS and SVM feature bits
      target/i386: Add support for EPYC-Turin model

Chao Peng (1):
      i386/tdx: load TDVF for TD guest

Fiona Ebner (1):
      target/i386/tcg/helper-tcg: fix file references in comments

Isaku Yamahata (5):
      i386/tdx: Make sept_ve_disable set by default
      i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig
      i386/tdvf: Introduce function to parse TDVF metadata
      i386/tdx: Add TDVF memory via KVM_TDX_INIT_MEM_REGION
      i386/tdx: Don't synchronize guest tsc for TDs

Lei Wang (1):
      i386: Remove unused parameter "uint32_t bit" in feature_word_description()

Paolo Bonzini (4):
      rust: hpet: rename hpet module to "device"
      target/i386/emulate: more lflags cleanups
      rocker: do not pollute the namespace
      rust: make declaration of dependent crates more consistent

Pierrick Bouvier (7):
      meson: build target libraries with common dependencies
      hw/arm: remove explicit dependencies listed
      target/arm: remove explicit dependencies listed
      meson: apply target config for picking files from lib{system, user}
      meson: merge lib{system, user}_ss with {system, user}_ss
      meson: remove lib{system, user}_ss aliases
      meson: merge hw_common_arch in target_common_system_arch

Xiaoyao Li (49):
      i386: Introduce tdx-guest object
      i386/tdx: Implement tdx_kvm_type() for TDX
      i386/tdx: Implement tdx_kvm_init() to initialize TDX VM context
      i386/tdx: Get tdx_capabilities via KVM_TDX_CAPABILITIES
      i386/tdx: Introduce is_tdx_vm() helper and cache tdx_guest object
      kvm: Introduce kvm_arch_pre_create_vcpu()
      i386/tdx: Initialize TDX before creating TD vcpus
      i386/tdx: Add property sept-ve-disable for tdx-guest object
      i386/tdx: Wire CPU features up with attributes of TD guest
      i386/tdx: Validate TD attributes
      i386/tdx: Set APIC bus rate to match with what TDX module enforces
      i386/tdx: Implement user specified tsc frequency
      i386/tdx: Parse TDVF metadata for TDX VM
      i386/tdx: Don't initialize pc.rom for TDX VMs
      i386/tdx: Track mem_ptr for each firmware entry of TDVF
      i386/tdx: Track RAM entries for TDX VM
      headers: Add definitions from UEFI spec for volumes, resources, etc...
      i386/tdx: Setup the TD HOB list
      i386/tdx: Call KVM_TDX_INIT_VCPU to initialize TDX vcpu
      i386/tdx: Finalize TDX VM
      i386/tdx: Enable user exit on KVM_HC_MAP_GPA_RANGE
      i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
      i386/tdx: Wire TDX_REPORT_FATAL_ERROR with GuestPanic facility
      kvm: Check KVM_CAP_MAX_VCPUS at vm level
      i386/cpu: introduce x86_confidential_guest_cpu_instance_init()
      i386/tdx: implement tdx_cpu_instance_init()
      i386/cpu: Introduce enable_cpuid_0x1f to force exposing CPUID 0x1f
      i386/tdx: Force exposing CPUID 0x1f
      i386/tdx: Set kvm_readonly_mem_enabled to false for TDX VM
      i386/tdx: Disable SMM for TDX VMs
      i386/tdx: Disable PIC for TDX VMs
      i386/tdx: Set and check kernel_irqchip mode for TDX
      i386/tdx: Only configure MSR_IA32_UCODE_REV in kvm_init_msrs() for TDs
      i386/apic: Skip kvm_apic_put() for TDX
      cpu: Don't set vcpu_dirty when guest_state_protected
      i386/cgs: Rename *mask_cpuid_features() to *adjust_cpuid_features()
      i386/tdx: Implement adjust_cpuid_features() for TDX
      i386/tdx: Add TDX fixed1 bits to supported CPUIDs
      i386/tdx: Add supported CPUID bits related to TD Attributes
      i386/tdx: Add supported CPUID bits relates to XFAM
      i386/tdx: Add XFD to supported bit of TDX
      i386/tdx: Define supported KVM features for TDX
      i386/cgs: Introduce x86_confidential_guest_check_features()
      target/i386: Print CPUID subleaf info for unsupported feature
      i386/tdx: Fetch and validate CPUID of TD guest
      i386/tdx: Don't treat SYSCALL as unavailable
      i386/tdx: Make invtsc default on
      i386/tdx: Validate phys_bits against host value
      docs: Add TDX documentation

Zhao Liu (3):
      hw/timer/hpet: Reorganize register decoding
      rust: Fix Zhao's email address
      rust: Fix the typos in doc

 docs/system/confidential-guest-support.rst    |    1 +
 docs/system/i386/tdx.rst                      |  161 +++
 docs/system/target-i386.rst                   |    1 +
 configs/devices/i386-softmmu/default.mak      |    1 +
 meson.build                                   |  122 +--
 qapi/qom.json                                 |   35 +
 qapi/run-state.json                           |   31 +-
 hw/i386/tdvf-hob.h                            |   26 +
 hw/net/rocker/rocker.h                        |   14 +-
 hw/net/rocker/rocker_hw.h                     |   20 +-
 include/hw/i386/tdvf.h                        |   45 +
 include/standard-headers/uefi/uefi.h          |  187 ++++
 include/system/kvm.h                          |    1 +
 target/i386/confidential-guest.h              |   44 +-
 target/i386/cpu.h                             |   44 +
 target/i386/host-cpu.h                        |    1 +
 target/i386/kvm/kvm_i386.h                    |   15 +
 target/i386/kvm/tdx.h                         |   65 ++
 target/i386/tcg/helper-tcg.h                  |    4 +-
 accel/kvm/kvm-all.c                           |   11 +-
 hw/i386/kvm/apic.c                            |    5 +
 hw/i386/pc.c                                  |   29 +-
 hw/i386/pc_sysfw.c                            |    7 +
 hw/i386/tdvf-hob.c                            |  130 +++
 hw/i386/tdvf.c                                |  189 ++++
 hw/i386/x86-common.c                          |    6 +-
 hw/net/rocker/rocker_of_dpa.c                 |   40 +-
 hw/timer/hpet.c                               |  166 ++--
 system/runstate.c                             |   65 ++
 target/arm/kvm.c                              |    5 +
 target/i386/cpu.c                             |  522 +++++++++-
 target/i386/emulate/x86_flags.c               |   16 +-
 target/i386/host-cpu.c                        |    2 +-
 target/i386/kvm/kvm.c                         |  110 ++-
 target/i386/kvm/tdx-stub.c                    |   20 +
 target/i386/kvm/tdx.c                         | 1289 +++++++++++++++++++++++++
 target/i386/sev.c                             |   12 +-
 target/loongarch/kvm/kvm.c                    |    4 +
 target/mips/kvm.c                             |    5 +
 target/ppc/kvm.c                              |    5 +
 target/riscv/kvm/kvm-cpu.c                    |    5 +
 target/s390x/kvm/kvm.c                        |    5 +
 accel/tcg/meson.build                         |    8 +-
 gdbstub/meson.build                           |    4 +-
 hw/arm/meson.build                            |    4 +-
 hw/core/meson.build                           |    4 +-
 hw/i386/Kconfig                               |    6 +
 hw/i386/meson.build                           |    1 +
 plugins/meson.build                           |    4 +-
 rust/hw/char/pl011/meson.build                |   12 +-
 rust/hw/char/pl011/src/device.rs              |    4 +-
 rust/hw/timer/hpet/src/{hpet.rs => device.rs} |    2 +-
 rust/hw/timer/hpet/src/fw_cfg.rs              |    2 +-
 rust/hw/timer/hpet/src/lib.rs                 |    4 +-
 rust/meson.build                              |   16 +
 rust/qemu-api-macros/meson.build              |   14 +-
 rust/qemu-api/meson.build                     |    4 +-
 rust/qemu-api/src/bitops.rs                   |    2 +-
 rust/qemu-api/src/qom.rs                      |    4 +-
 rust/qemu-api/src/timer.rs                    |    2 +-
 rust/qemu-api/src/vmstate.rs                  |    2 +-
 rust/qemu-api/tests/vmstate_tests.rs          |    2 +-
 system/meson.build                            |    2 +-
 target/arm/meson.build                        |    2 +-
 target/i386/kvm/meson.build                   |    2 +
 tcg/meson.build                               |    4 +-
 66 files changed, 3231 insertions(+), 346 deletions(-)
 create mode 100644 docs/system/i386/tdx.rst
 create mode 100644 hw/i386/tdvf-hob.h
 create mode 100644 include/hw/i386/tdvf.h
 create mode 100644 include/standard-headers/uefi/uefi.h
 create mode 100644 target/i386/kvm/tdx.h
 create mode 100644 hw/i386/tdvf-hob.c
 create mode 100644 hw/i386/tdvf.c
 create mode 100644 target/i386/kvm/tdx-stub.c
 create mode 100644 target/i386/kvm/tdx.c
 rename rust/hw/timer/hpet/src/{hpet.rs => device.rs} (99%)
-- 
2.49.0


