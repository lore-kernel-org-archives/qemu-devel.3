Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D764CCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcj9-0000iS-Cb; Wed, 06 May 2026 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcit-0000hk-7n
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcip-0007jp-G4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso36212905e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075728; x=1778680528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=u67NLgGAVZ3WEFEBEcEk/abEnpCtRNgA/BZvSAaGlY0=;
 b=ddrXawQuQuJv067tqcSenzkCDlJBNPil53NH0mvb9iv3/ZuBSQ4FcicifD1U3bUyi1
 xOnfBJWoS7KBYu1jqefTNochnGEtLjITzIFtq++RSm5y7tg0RCVDhz6bnyQwDnktswE+
 byJ0DMY3BAlNCi0lBYrvOsMpNbC0Cz5+IyQtkpnS1ny8LBTL9NG01CtV4zvAUqGCvtHr
 V4CC85vL1zkAWTmSvtCEQU3WtypHc+edE3Rn4fo0+u7bYytJsF/KBMhMbRZCRjTfotOO
 2XIN6uEwUAQUbXrQUrVao9hq55jxDQeBbtFgpK0NO//6EhcFEJYOj2oydiQkMljhOZ74
 z5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075728; x=1778680528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u67NLgGAVZ3WEFEBEcEk/abEnpCtRNgA/BZvSAaGlY0=;
 b=oNx/0g+9baKJF03u+ArDNLeCbHiwjYzECN4evsHnWW/XQ05PlC7u1ORBC7ixcu+ZJZ
 WnHorgTkTax7hKiwOZp6uQ1i/1whouGODukQD8P5sdmyHAKiS0fr4MyF5f/hfIEZ9S6E
 pjPBkB/zTaLgK7fdXS6cDZXUAm0XmLL4h4EAglt385tLi+xVW0ASw/m7OwvDa6XL6NN1
 TQ0+RyVkHu0aKx/bxcwKNkBG0jKV5I5oQnfBiN3n1xAZKb3GHQ/DMJmNJ2tl8figWOsm
 zTfJTQoAlvKRWFYVHjvGAdSVodNpymsYuROeVzck3yRHP6eQ4vJaH8AB+AHDr/k++duw
 99dw==
X-Gm-Message-State: AOJu0YyRWYWNVz1Rn+A9olXI1Ss1inSouhIo5H9z0MwUnSBY3mAvlHyv
 zu8rWxN5me7E8D3WKhPlipIP/1f3fyU6407Eblw8ZpcpN0EbsETHSNGjnSrW6xd5bBrDRV15tOd
 9w4n0n9w=
X-Gm-Gg: AeBDieskRiA4eH3dpbwh4doGZeIdvIa41zCcWP/jRBMF43cg/P3Y0qqXNdm44+rbRUg
 ReX8O6QMtMIyryv6AFc0BhiQgnZ2Z9exzukEUQMC8n2bHdaESoAP2BPstH1IVPQLhUDrK7VWDY1
 tgKwhkgMy569ZqG9+qSTGrpQ745YpYNb0qVyiv4uUZ055LVPIt3Gm6yR5xTETdI37C/z/7hLLk2
 RFIbDn0WW1ogMXbtMFnjZUKvDbh8sGSBSldnSeaaCqgCEzihZqS8XBdq0ldR5RMvIicGAtcsFW3
 modo6298sqXinWOXB60SR0Mhvw7L/vRKKpRYZoGohU0j7WBvvDjRGJkj9kYa8mpo/8VFWQxMAMB
 1IQemTX3TEhUhM9ENAyygW/dRRE6sKFvIfgDm4R7NrJtP7W7kw7jSppVYVXjkK4YtLK3RQCLcr6
 DWfWYU3Hy0Gvby0sT2gtYX1xWwikzItIHLxrIEYZmaJBI66cTfEKW3cTB35OJMGYONk5QIZ/pbv
 76XxztG9ZE=
X-Received: by 2002:a05:600c:4e0c:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-48e51f3fa43mr65342315e9.13.1778075727588; 
 Wed, 06 May 2026 06:55:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5310930esm25704625e9.7.2026.05.06.06.55.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:55:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 000/110] Single binary patches
Date: Wed,  6 May 2026 15:53:32 +0200
Message-ID: <20260506135524.20617-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The following changes since commit a85c588d07f8d3345ccad38b22026569a04571d1:

  Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armbru into staging (2026-05-05 10:11:49 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260506

for you to fetch changes up to 1927b5ec6ef486b3dfaecb885c5f093f85f6a65f:

  system/vl: inline qemu_opts_parse_noisily() result checks (2026-05-06 15:52:32 +0200)

----------------------------------------------------------------
Various patches related to single binary effort:

- Reduce "exec/cpu-defs.h" inclusions
- Build various target specific files once
- Remove need of per-target monitor handlers
- Reduce target_ulong uses in migration code
- Reduce uses of legacy native endianness & ld/st_phys APIs
- Removed MIPSCPU::mvp memory leak
- Clear dangling GLib event source tag
- Remove pointless variable initialization in *FOREACH*() macro uses
- Few checkpatch.pl updates

The following spurious checkpatch.pl error being deliberately ignored:

  Checking "target/mips: Reduce CPUState scope when used with CPU_FOREACH()"
  ERROR: space prohibited after that '&' (ctx:WxW)
  #44: FILE: target/mips/internal.h:294:
  +            ((other_env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
                                                           ^
----------------------------------------------------------------

Akihiko Odaki (1):
  scripts/checkpatch: Avoid false positive on empty blocks

Bernhard Beschow (1):
  scripts/checkpatch: Reject another license boilerplate pattern

Bin Guo (1):
  system/vl: inline qemu_opts_parse_noisily() result checks

Peter Maydell (3):
  target/mips: Move 'mvp' field from CPUMIPSState to MIPSCPU
  target/mips: Free mvp in unrealize
  target/mips: Move count_clock to MIPSCPU struct

Philippe Mathieu-Daudé (100):
  monitor/hmp: : Include missing 'exec/target_long.h' header
  target-info: Include 'exec/cpu-defs.h' explicitly
  target/xtensa: Restrict inclusion of 'exec/cpu-defs.h' header
  target/hexagon: Include missing 'exec/target_long.h' header
  target/hppa: Include missing 'exec/target_long.h' header
  target/i386: Include missing 'exec/target_long.h' header
  target/m68k: Include missing 'exec/target_long.h' header
  target/mips: Include missing 'exec/target_long.h' header
  target/ppc: Include missing 'exec/target_long.h' header
  target/riscv: Include missing 'exec/target_long.h' header
  target/sparc: Include missing 'exec/target_long.h' header
  system/kvm_xen: Include missing 'exec/target_page.h' header
  target/s390x/tcg: Include missing '*cpu.h' headers
  exec/helper-head: Include missing 'exec/target_long.h' header
  target/cpu: Do not include 'exec/cpu-defs.h' anymore
  target/ppc/mmu: Remove unused hash32_store_hpte() helpers
  target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
  target/sparc/monitor: Dump all registers as 32-bit
  monitor: Remove MonitorDef::type field and MD_TLONG / MD_I32
  monitor: Extract completion declarations to 'monitor/hmp-completion.h'
  target/loongarch: Replace legacy ldq_le_phys() ->
    address_space_ldq_le()
  configs/targets: Restrict the legacy ldst_phys() API on LoongArch64
  target/loongarch: Avoid target-specific migration headers in machine.c
  target/avr: Avoid target-specific migration headers in machine.c
  migration: Revert "Add VMSTATE_UINTTL_2DARRAY()"
  migration: Remove unused target-specific macros
  target/sparc: Inline qemu_get/put_betl()
  target/mips: Inline qemu_get/put_betls()
  target/i386: Expand VMSTATE_UINTTL_SUB_ARRAY for APX registers
  target/sparc: Replace VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY
  cpus: Remove CPUClass::init_accel_cpu() left-over hook
  target/i386: Replace target_ulong -> uint64_t for TARGET_X86_64
  target/mips: Pass MemOpIdx argument to Load/Store Multiple helpers
  target/mips: Remove unnecessary target_ulong uses in LD/ST Multiple
  target/mips: Inline cpu_ld/st_mmuidx_ra() calls in LD/ST Multiple
  target/mips: Check alignment for microMIPS pre-R6 LD/ST multiple
  stubs: Rename monitor* -> qmp* files
  monitor/meson: Use SPICE with migration HMP commands
  monitor: Restrict monitor_set_cpu() method scope
  monitor: Make 'info via' a generic command
  monitor: Make Xen emulation commands generic ones
  system: Expose 'arch_init.h' as 'qemu/base-arch-defs.h'
  monitor: Introduce HMPCommand::arch_bitmask field
  hw/s390x: Reduce 'monitor/monitor.h' inclusions
  monitor: Do not check TARGET_S390X to build s390x commands
  monitor: Do not check TARGET_I386 to build target/i386/ commands
  monitor: Do not check TARGET_I386 to build 'info sgx' command
  monitor: Do not check TARGET_I386 to build 'info sev' command
  monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
  monitor: Do not check multiple TARGET_* to build 'info tlb' command
  cpus: Introduce SysemuCPUOps::monitor_get_register() hook
  target/riscv: Register target_get_monitor_def in SysemuCPUOps
  monitor: Remove target_get_monitor_def()
  monitor: Have MonitorDef::get_value() always return int64_t type
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header
  monitor: Forward-declare the MonitorDef type
  cpus: Introduce SysemuCPUOps::monitor_defs hook
  target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/sparc: Replace target_monitor_defs ->
    SysemuCPUOps::monitor_defs
  monitor: Remove target_monitor_defs()
  monitor: Merge hmp-target.c code within hmp-cmds.c
  monitor: Remove hmp_info_pic() left-over declaration
  target/mips: Inline cpu_ld{uw,l}_code() calls in
    set_badinstr_registers
  accel/tcg: Remove non-explicit endian cpu_ld*_code() wrappers
  target/mips: Expand TCGv type as 32-bit for XBurst MXU
  target/mips: Expand TCGv type for 64-bit extensions
  target/mips: Pass MemOpIdx argument to Linked Load/Store helpers
  target/mips: Inline cpu_ld/st_mmuidx_ra() calls in Atomic LD/ST
    helpers
  target/mips: Inline translator_ld[uw,l,q]() calls
  target/mips: Remove last MO_TE use
  meson: Allow building with empty target_arch[] source set
  tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
  target/microblaze: Fix endianness used to disassemble
  target/microblaze: Replace translator_ldl_swap() ->
    translator_ldl_end()
  target/microblaze: Introduce common system/user meson source set
  target/microblaze: Compile helper.c as common unit
  target/microblaze: Compile op_helper.c as common unit
  target/microblaze: Compile cpu.c as common unit
  target/microblaze: Include missing cpu-mmu-index.h header in
    translate.c
  target/microblaze: Compile translate.c as common unit
  target/s390x: Introduce common system/user meson source set
  target/s390x: Compile few files as common unit
  target/s390x: Compile translate.c as common unit
  target/s390x: Compile vec_helper.c as common unit
  target/s390x: Have MSA helper pass a mmu_idx argument
  target/s390x: Compile crypto_helper.c as common unit
  target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu in STFLE opcode
  target/riscv: Iterate vCPUs using CPU_FOREACH() macro
  target/mips: Reduce CPUState scope when used with CPU_FOREACH()
  target/mips: Do not initialize variable used by CPU_FOREACH macro
  target/s390x: Do not compile KVM stubs for linux-user binary
  io: Clear dangling GLib event source tag
  io: use g_clear_handle_id() for GSource cleanup
  cocci: Do not initialize variable used by QLIST_FOREACH macro
  cocci: Do not initialize variable used by QSLIST_FOREACH macro
  cocci: Do not initialize variable used by QSIMPLEQ_FOREACH macro
  cocci: Do not initialize variable used by QTAILQ_FOREACH macro
  cocci: Do not initialize variable used by RAMBLOCK_FOREACH* macro

Pierrick Bouvier (4):
  hw/misc/allwinner-cpucfg.c: make compilation unit common
  meson.build: define stubs library per target base architecture
  target/arm: define stub library
  target/xtensa/core: register types using type_init

 MAINTAINERS                                   |   16 +-
 docs/devel/loads-stores.rst                   |   21 +-
 configs/targets/loongarch64-softmmu.mak       |    1 +
 meson.build                                   |   30 +-
 include/accel/tcg/cpu-ldst.h                  |   33 +-
 include/hw/core/cpu.h                         |    6 -
 include/hw/core/sysemu-cpu-ops.h              |   14 +
 include/hw/ppc/spapr_ovec.h                   |    2 +-
 include/hw/s390x/storage-attributes.h         |    4 -
 include/hw/s390x/storage-keys.h               |    3 -
 include/migration/cpu.h                       |   32 -
 include/monitor/hmp-completion.h              |   40 +
 include/monitor/hmp-target.h                  |   50 -
 include/monitor/hmp.h                         |   43 +-
 include/monitor/monitor.h                     |    1 -
 .../qemu/base-arch-defs.h                     |   10 +-
 include/qemu/typedefs.h                       |    1 +
 include/system/kvm_xen.h                      |    2 +
 include/tcg/tcg-op-mem.h                      |    2 +
 monitor/monitor-internal.h                    |   13 +-
 target/alpha/cpu.h                            |    1 -
 target/arm/cpu.h                              |    1 -
 target/avr/cpu.h                              |    1 -
 target/hexagon/cpu.h                          |    3 +-
 target/hexagon/mmvec/mmvec.h                  |    3 +
 target/hppa/cpu.h                             |    2 +-
 target/i386/cpu.h                             |   10 +-
 target/loongarch/cpu.h                        |    1 -
 target/m68k/cpu.h                             |    1 -
 target/microblaze/cpu.h                       |    8 -
 target/mips/cpu.h                             |    8 +-
 target/mips/helper.h                          |    4 +-
 target/mips/internal.h                        |   14 +-
 target/or1k/cpu.h                             |    1 -
 target/ppc/cpu.h                              |    2 +-
 target/ppc/mmu-hash32.h                       |   32 -
 target/riscv/cpu.h                            |    2 +-
 target/riscv/debug.h                          |    1 +
 target/riscv/internals.h                      |    3 +
 target/riscv/pmp.h                            |    1 +
 target/rx/cpu.h                               |    1 -
 target/s390x/cpu.h                            |    1 -
 target/s390x/tcg/tcg_s390x.h                  |    3 +
 target/sh4/cpu.h                              |    1 -
 target/sparc/cpu.h                            |    2 +-
 target/tricore/cpu.h                          |    1 -
 target/xtensa/cpu.h                           |    1 -
 target/xtensa/overlay_tool.h                  |    5 +-
 include/exec/helper-head.h.inc                |   15 +-
 accel/accel-common.c                          |   13 -
 block/blkdebug.c                              |    2 +-
 block/blkio.c                                 |    2 +-
 block/gluster.c                               |    4 +-
 chardev/char-hmp-cmds.c                       |    1 +
 ebpf/ebpf.c                                   |    2 +-
 hw/arm/virt-acpi-build.c                      |    2 +-
 hw/char/cmsdk-apb-uart.c                      |    5 +-
 hw/char/nrf51_uart.c                          |    5 +-
 hw/char/serial.c                              |    6 +-
 hw/char/stm32l4x5_usart.c                     |    5 +-
 hw/char/terminal3270.c                        |    5 +-
 hw/char/virtio-console.c                      |   10 +-
 hw/i386/kvm/xen-stubs.c                       |   12 +
 hw/i386/sgx-hmp-stub.c                        |   16 +
 hw/i386/sgx-stub.c                            |    6 -
 hw/i386/sgx.c                                 |    1 -
 hw/i386/xen/xen-hvm.c                         |    4 +-
 hw/mips/malta.c                               |    4 +-
 hw/misc/mips_cpc.c                            |    4 +-
 hw/misc/mos6522-stub.c                        |   16 +
 hw/misc/riscv_cmgcr.c                         |    1 +
 hw/pci/pci.c                                  |    2 +-
 hw/ppc/spapr.c                                |    2 +-
 hw/ppc/spapr_events.c                         |    4 +-
 hw/riscv/boot.c                               |    9 +-
 hw/riscv/riscv-iommu.c                        |    2 +-
 hw/s390x/s390-skeys.c                         |    2 +
 hw/s390x/s390-stattrib.c                      |    2 +
 hw/usb/redirect.c                             |    9 +-
 hw/vfio/cpr-legacy.c                          |    2 +-
 hw/vfio/listener.c                            |    4 +-
 hw/xen/xen_pt_config_init.c                   |    4 +-
 io/channel-websock.c                          |   21 +-
 migration/block-dirty-bitmap.c                |    2 +-
 migration/dirtyrate.c                         |    4 +-
 migration/migration-hmp-cmds.c                |    1 +
 monitor/hmp-cmds.c                            |   41 +-
 monitor/hmp-target.c                          |  124 --
 monitor/hmp.c                                 |   45 +-
 net/colo-compare.c                            |    4 +-
 net/net-hmp-cmds.c                            |    1 +
 net/net.c                                     |    2 +-
 net/passt.c                                   |    8 +-
 net/stream.c                                  |   15 +-
 net/stream_data.c                             |    5 +-
 net/vhost-user.c                              |    8 +-
 qom/qom-hmp-cmds.c                            |    1 +
 stubs/hmp-cmd-info_mem.c                      |   12 +
 stubs/hmp-cmd-info_sev.c                      |   16 +
 stubs/hmp-cmd-info_tlb.c                      |   12 +
 stubs/hmp-cmds-hw-s390x.c                     |   15 +
 stubs/hmp-cmds-target-i386.c                  |   13 +
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}    |    0
 ...or-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |    0
 .../{monitor-cpu-s390x.c => qmp-cpu-s390x.c}  |    0
 stubs/{monitor-cpu.c => qmp-cpu.c}            |    0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}  |    0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}  |    0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}  |    0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}  |    0
 stubs/target-get-monitor-def.c                |   29 -
 stubs/target-monitor-defs.c                   |    7 -
 system/arch_init.c                            |    2 +-
 system/qdev-monitor.c                         |    3 +-
 system/runstate-hmp-cmds.c                    |    1 +
 system/vl.c                                   |   41 +-
 target-info-stub.c                            |    1 +
 target/avr/machine.c                          |    3 +-
 target/i386/cpu-apic.c                        |    1 -
 target/i386/cpu.c                             |   29 +
 target/i386/kvm/tdx-quote-generator.c         |    5 +-
 target/i386/machine.c                         |    2 +-
 target/i386/monitor.c                         |   26 -
 target/i386/sev-system-stub.c                 |    6 -
 target/i386/sev.c                             |    1 -
 target/loongarch/cpu_helper.c                 |   13 +-
 target/loongarch/machine.c                    |    2 +-
 target/loongarch/tcg/tlb_helper.c             |   10 +-
 target/m68k/cpu.c                             |   18 +
 target/m68k/m68k-semi.c                       |    2 +-
 target/m68k/monitor.c                         |   22 -
 target/microblaze/cpu.c                       |    6 +-
 target/microblaze/op_helper.c                 |    2 +-
 target/microblaze/translate.c                 |   11 +-
 target/mips/cpu.c                             |   18 +-
 target/mips/system/cp0_timer.c                |   12 +-
 target/mips/system/machine.c                  |   16 +-
 target/mips/tcg/lcsr_translate.c              |   16 +-
 target/mips/tcg/ldst_helper.c                 |  101 +-
 target/mips/tcg/loong_translate.c             |   92 +-
 target/mips/tcg/mxu_translate.c               | 1954 ++++++++---------
 target/mips/tcg/octeon_translate.c            |   60 +-
 target/mips/tcg/system/cp0_helper.c           |   63 +-
 target/mips/tcg/system/tlb_helper.c           |   25 +-
 target/mips/tcg/translate.c                   |   25 +-
 target/mips/tcg/tx79_translate.c              |   14 +-
 target/ppc/machine.c                          |    1 +
 target/ppc/mmu-hash32.c                       |   14 +
 target/ppc/monitor.c                          |    2 -
 target/riscv/cpu.c                            |    1 +
 target/riscv/monitor.c                        |   12 +-
 target/s390x/kvm/stsi-topology.c              |    2 +-
 target/s390x/tcg/crypto_helper.c              |   80 +-
 target/s390x/tcg/misc_helper.c                |    7 +-
 target/s390x/tcg/translate.c                  |    6 +-
 target/s390x/tcg/vec_helper.c                 |   34 +-
 target/sh4/monitor.c                          |    1 -
 target/sparc/cpu.c                            |   19 +
 target/sparc/machine.c                        |   24 +-
 target/sparc/monitor.c                        |   19 -
 target/xtensa/cpu.c                           |    1 +
 target/xtensa/monitor.c                       |    1 -
 trace/trace-hmp-cmds.c                        |    1 +
 ui/dbus-clipboard.c                           |    6 +-
 ui/input-barrier.c                            |    6 +-
 ui/ui-hmp-cmds.c                              |    1 +
 ui/vnc-auth-vencrypt.c                        |    6 +-
 ui/vnc-ws.c                                   |   12 +-
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/tcg/micromips_translate.c.inc     |   20 +-
 target/mips/tcg/mips16e_translate.c.inc       |    8 +-
 target/mips/tcg/nanomips_translate.c.inc      |    5 +-
 hmp-commands-info.hx                          |   26 +-
 hmp-commands.hx                               |   13 +-
 hw/i386/meson.build                           |    1 +
 hw/misc/meson.build                           |    3 +-
 migration/meson.build                         |    2 +-
 monitor/meson.build                           |    5 +-
 scripts/checkpatch.pl                         |    4 +-
 stubs/meson.build                             |   23 +-
 target/arm/meson.build                        |    8 +-
 target/arm/tcg/meson.build                    |    2 +-
 target/avr/meson.build                        |    3 +-
 target/loongarch/meson.build                  |    2 +-
 target/microblaze/meson.build                 |   12 +-
 target/s390x/kvm/meson.build                  |    2 +-
 target/s390x/meson.build                      |   25 +-
 target/s390x/tcg/meson.build                  |    8 +-
 188 files changed, 2018 insertions(+), 2030 deletions(-)
 create mode 100644 include/monitor/hmp-completion.h
 delete mode 100644 include/monitor/hmp-target.h
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)
 create mode 100644 hw/i386/sgx-hmp-stub.c
 create mode 100644 hw/misc/mos6522-stub.c
 delete mode 100644 monitor/hmp-target.c
 create mode 100644 stubs/hmp-cmd-info_mem.c
 create mode 100644 stubs/hmp-cmd-info_sev.c
 create mode 100644 stubs/hmp-cmd-info_tlb.c
 create mode 100644 stubs/hmp-cmds-hw-s390x.c
 create mode 100644 stubs/hmp-cmds-target-i386.c
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)
 delete mode 100644 stubs/target-get-monitor-def.c
 delete mode 100644 stubs/target-monitor-defs.c

-- 
2.53.0


