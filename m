Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC39C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjMW-0006Bj-QX; Fri, 22 Mar 2024 14:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMU-0006B9-EE
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMS-0006tk-GC
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WubQWkcslV/ov2f3B8vk3m2OpqnQFlW63EUQE8TOyfg=;
 b=aFneYCeVd/1RV9UXpjuZGhnA0SOjLKXvy0kptGdmM262gLRTK5dJGG7ixKXgqL4IZW8uIo
 lt+BapkFvO1fYXrjnA5vRl5vrsKw2D4kq4/yFk58Y39yKjeoLcUe8QsaNketKrsohY+7hz
 pcxNszzTJ1nkKlRavyb6cMLsde6gXvo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-0-DNFdO1OyGTpfpIsDykiQ-1; Fri, 22 Mar 2024 14:11:22 -0400
X-MC-Unique: 0-DNFdO1OyGTpfpIsDykiQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4711e69b9bso129985466b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131079; x=1711735879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WubQWkcslV/ov2f3B8vk3m2OpqnQFlW63EUQE8TOyfg=;
 b=vs8s1YU5UFYO6MFv48VYYptm4KfQ9iflt58yE7eRmnWHTufOCCUclnZ54fa7zup5EU
 ozFd0WACbVlX4xfsw6mVGTeCx4cQeGywv0L897zWk40iUblphDUH1FLFmZxcM5S6Zc8a
 sSeklzSkqZuRcRYxZk2W4PPBel7XS+I8xIn6hyhp7A3FiQGr2CKJzFN2wmeg7w1IVhTx
 TlnLrN9Tovo24jfZ+6azIj4BJS/hYiBSeJPXTT7OckhtdluTDo5eRWvXXuHgapWXUpHC
 S0gv43646cRlKoH5FSOGZFPaQ50o+ZSXRNn9ZiShG76HHjdk1wfU/EvxhaZwp3ESyobp
 /NHQ==
X-Gm-Message-State: AOJu0Yx8lnDKB+Ri/5dVGSWoHEKkd3m/Ehodp5L++btWMmUL0m/mteNK
 JVl8QSn+YM33BSow/y9vMrWsNViNinv7QzggAgm8Mlepv2FSYmEG12PoPW+2058dA6I86xJTm4h
 qj87u/8U4NYtxGZvAAfHj4yq6Svd5XF7/nsBFldvoqIlpQyjBjyksb/m0UkdM0j6RIFZJl2reY4
 fwyHol+sBOnDF2UTrQu4hOBAvGxAt7Rnp8JbGA
X-Received: by 2002:a17:906:2a0a:b0:a46:1fa:fc12 with SMTP id
 j10-20020a1709062a0a00b00a4601fafc12mr358070eje.18.1711131079138; 
 Fri, 22 Mar 2024 11:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWeh2MfixfhMXJ0bJagQQWnqhfYmSWuVVfGexcm3bWPFXBf+/luM/B+yZ95T/svyLScaSojg==
X-Received: by 2002:a17:906:2a0a:b0:a46:1fa:fc12 with SMTP id
 j10-20020a1709062a0a00b00a4601fafc12mr358054eje.18.1711131078728; 
 Fri, 22 Mar 2024 11:11:18 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a170906388800b00a4729f093ecsm76502ejd.53.2024.03.22.11.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH for-9.1 00/26] x86, kvm: common confidential computing subset
Date: Fri, 22 Mar 2024 19:10:50 +0100
Message-ID: <20240322181116.1228416-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These are the common bits for TDX and SEV-SNP support for QEMU 9.1.

The main changes compared to what Michael posted is:

1) I am including KVM_SEV_INIT2 support patches without the linux-headers
update hack (however the linux-headers update in these patches is still
not final).  This also includes the bits to track whether guest state
are encrypted, that are needed by TDX as well as SEV-ES/SNP.

2) VFIO currently is blocked, pending a decision on what is worse
between possibly consuming twice the memory and disallowing device
assignment; or someone biting the bullet and implementing the
RamDiscardManager interface.

3) I included another easy patch from the TDX series, "i386/kvm: Move
architectural CPUID leaf generation to separate helper".

Please test. :)

Paolo

Chao Peng (2):
  kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
  kvm: handle KVM_EXIT_MEMORY_FAULT

Isaku Yamahata (2):
  pci-host/q35: Move PAM initialization above SMRAM initialization
  q35: Introduce smm_ranges property for q35-pci-host

Michael Roth (5):
  scripts/update-linux-headers: Add setup_data.h to import list
  scripts/update-linux-headers: Add bits.h to file imports
  [HACK] linux-headers: Update headers for 6.8 + kvm-coco-queue + SNP
  [TO SQUASH] hw/i386: Remove redeclaration of struct setup_data
  RAMBlock: Add support of KVM private guest memfd

Paolo Bonzini (7):
  runstate: skip initial CPU reset if reset is not actually possible
  KVM: track whether guest state is encrypted
  KVM: remove kvm_arch_cpu_check_are_resettable
  target/i386: introduce x86-confidential-guest
  target/i386: Implement mc->kvm_type() to get VM type
  target/i386: SEV: use KVM_SEV_INIT2 if possible
  RAMBlock: make guest_memfd require uncoordinated discard

Sean Christopherson (1):
  i386/kvm: Move architectural CPUID leaf generation to separate helper

Xiaoyao Li (9):
  confidential guest support: Add kvm_init() and kvm_reset() in class
  i386/sev: Switch to use confidential_guest_kvm_init()
  ppc/pef: switch to use confidential_guest_kvm_init/reset()
  s390: Switch to use confidential_guest_kvm_init()
  trace/kvm: Split address space and slot id in
    trace_kvm_set_user_memory()
  kvm: Introduce support for memory_attributes
  kvm/memory: Make memory type private by default if it has guest memfd
    backend
  HostMem: Add mechanism to opt in kvm guest memfd via MachineState
  physmem: Introduce ram_block_discard_guest_memfd_range()

 include/exec/confidential-guest-support.h     |  34 +-
 include/exec/cpu-common.h                     |   2 +
 include/exec/memory.h                         |  20 +-
 include/exec/ram_addr.h                       |   2 +-
 include/exec/ramblock.h                       |   1 +
 include/hw/boards.h                           |   2 +
 include/hw/i386/pc.h                          |   1 +
 include/hw/pci-host/q35.h                     |   1 +
 include/hw/ppc/pef.h                          |  17 -
 include/standard-headers/asm-x86/bootparam.h  |  17 +-
 include/standard-headers/asm-x86/kvm_para.h   |   3 +-
 include/standard-headers/asm-x86/setup_data.h |  83 ++
 include/standard-headers/linux/ethtool.h      |  48 ++
 include/standard-headers/linux/fuse.h         |  39 +-
 .../linux/input-event-codes.h                 |   1 +
 include/standard-headers/linux/virtio_gpu.h   |   2 +
 include/standard-headers/linux/virtio_snd.h   | 154 ++++
 include/sysemu/hostmem.h                      |   1 +
 include/sysemu/kvm.h                          |  19 +-
 include/sysemu/kvm_int.h                      |   3 +
 linux-headers/asm-arm64/kvm.h                 |  15 +-
 linux-headers/asm-arm64/sve_context.h         |  11 +
 linux-headers/asm-generic/bitsperlong.h       |   4 +
 linux-headers/asm-loongarch/kvm.h             |   2 -
 linux-headers/asm-mips/kvm.h                  |   2 -
 linux-headers/asm-powerpc/kvm.h               |  45 +-
 linux-headers/asm-riscv/kvm.h                 |   3 +-
 linux-headers/asm-s390/kvm.h                  | 315 +++++++-
 linux-headers/asm-x86/kvm.h                   | 364 ++++++++-
 linux-headers/linux/bits.h                    |  15 +
 linux-headers/linux/kvm.h                     | 717 +-----------------
 linux-headers/linux/psp-sev.h                 |  71 ++
 target/i386/confidential-guest.h              |  59 ++
 target/i386/kvm/kvm_i386.h                    |   2 +
 target/i386/sev.h                             |   2 -
 target/s390x/kvm/pv.h                         |  14 -
 accel/kvm/kvm-accel-ops.c                     |   2 +-
 accel/kvm/kvm-all.c                           | 236 +++++-
 accel/stubs/kvm-stub.c                        |   5 +
 backends/hostmem-file.c                       |   1 +
 backends/hostmem-memfd.c                      |   1 +
 backends/hostmem-ram.c                        |   1 +
 backends/hostmem.c                            |   1 +
 hw/core/machine.c                             |   5 +
 hw/i386/pc_q35.c                              |   2 +
 hw/i386/x86.c                                 |  19 +-
 hw/pci-host/q35.c                             |  61 +-
 hw/ppc/pef.c                                  |   9 +-
 hw/ppc/spapr.c                                |  10 +-
 hw/s390x/s390-virtio-ccw.c                    |   5 +-
 system/memory.c                               |   5 +
 system/physmem.c                              |  65 +-
 system/runstate.c                             |  15 +-
 target/arm/kvm.c                              |   5 -
 target/i386/confidential-guest.c              |  33 +
 target/i386/kvm/kvm.c                         | 507 +++++++------
 target/i386/kvm/sev-stub.c                    |  21 -
 target/i386/sev.c                             | 173 +++--
 target/loongarch/kvm/kvm.c                    |   5 -
 target/mips/kvm.c                             |   5 -
 target/ppc/kvm.c                              |   5 -
 target/riscv/kvm/kvm-cpu.c                    |   5 -
 target/s390x/kvm/kvm.c                        |   5 -
 target/s390x/kvm/pv.c                         |   8 +
 accel/kvm/trace-events                        |   4 +-
 roms/edk2                                     |   2 +-
 scripts/update-linux-headers.sh               |   8 +-
 target/i386/kvm/meson.build                   |   2 -
 target/i386/meson.build                       |   2 +-
 69 files changed, 2124 insertions(+), 1200 deletions(-)
 delete mode 100644 include/hw/ppc/pef.h
 create mode 100644 include/standard-headers/asm-x86/setup_data.h
 create mode 100644 linux-headers/linux/bits.h
 create mode 100644 target/i386/confidential-guest.h
 create mode 100644 target/i386/confidential-guest.c
 delete mode 100644 target/i386/kvm/sev-stub.c

-- 
2.44.0


