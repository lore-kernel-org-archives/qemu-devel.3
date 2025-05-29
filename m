Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD12DC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKWe2-0003lJ-9D; Thu, 29 May 2025 02:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKWdt-0003kU-Eg; Thu, 29 May 2025 02:21:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKWdp-0007Au-HM; Thu, 29 May 2025 02:21:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02F6B1260B8;
 Thu, 29 May 2025 09:21:14 +0300 (MSK)
Received: from localhost (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 5B1B2218BB7;
 Thu, 29 May 2025 09:21:21 +0300 (MSK)
Received: (nullmailer pid 13074 invoked by uid 1000);
 Thu, 29 May 2025 06:21:21 -0000
Subject: [ANNOUNCE] QEMU 9.2.4 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 May 2025 09:21:21 +0300
Message-Id: <1748499681.325917.13073.nullmailer@localhost>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, MIME_QP_LONG_LINE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi everyone,

The QEMU v9.2.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-9.2.4.tar.xz
  https://download.qemu.org/qemu-9.2.4.tar.xz.sig (signature)

v9.2.4 is now tagged in the official qemu.git repository, and the
stable-9.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-9.2

There are 61 changes since the previous v9.2.3 release.

This is expected to be the last release in 9.2.x series.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-9.2-hash master-hash Author Name: Commmit-Subject):

b2995afed2 Michael Tokarev:
 Update version for 9.2.4 release
0befc056f3 ebd394948d Helge Deller:
 target/hppa: Fix FPE exceptions
148eb79f57 b4b49cf39d Helge Deller:
 linux-user/hppa: Send proper si_code on SIGFPE exception
b1ff64ba4e 923976dfe3 Helge Deller:
 target/hppa: Copy instruction code into fr1 on FPU assist fault
53a4bf6830 17bec9235b Peter Xu:
 migration: Allow caps to be set when preempt or multifd cap enabled
5a1414313b 7f2131c35c Zhao Liu:
 qapi/misc-target: Fix the doc to distinguish query-sgx and query-sgx-capabilities
361bd5efe4 560375cff3 Rakesh Jeyasingh:
 hw/pci-host: Remove unused pci_host_data_be_ops
5d139247e9 e5894fd6f4 Rakesh Jeyasingh:
 hw/pci-host/gt64120: Fix endianness handling
289dcab554 d3b6f1742c Daniel Henrique Barboza:
 target/riscv/kvm: add kvm_csr_cfgs[]
e2d4d3c2ac 11766e1761 Daniel Henrique Barboza:
 target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
6b10b25ddd b609610349 Daniel Henrique Barboza:
 target/riscv/kvm: turn u32/u64 reg functions into macros
800495a394 906af6de94 Daniel Henrique Barboza:
 target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
ac053657f0 2669b696e2 Anton Blanchard:
 target/riscv: Fix vslidedown with rvv_ta_all_1s
41c984df66 8539a1244b Max Chou:
 target/riscv: Fix the rvv reserved encoding of unmasked instructions
84dd432553 db21c3eb05 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector indexed load/store instructions
dec1f0b924 1f090a229f Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector narrow/widen instructions
32f8a2b429 411eefd56a Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector integer extension instructions(OPMVV)
d5166dad55 b5480a693e Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector slide instructions(OPIVI/OPIVX)
80eebc00f9 fda68acb77 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to OPIVV/OPFVV(vext_check_sss) instructions
fd0fc3eb48 fbeaf35838 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
28ee50bbe9 629c2a8dd7 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vrgather instructions to check mismatched input EEWs encoding constraint
6c4ddafa0d b0450a101d Anton Blanchard:
 target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
10bfc8d45e 3e8d1e4a62 Anton Blanchard:
 target/riscv: rvv: Source vector registers cannot overlap mask register
fb1f88ee29 22b448ccc6 Icenowy Zheng:
 common-user/host/riscv: use tail pseudoinstruction for calling tail
82c0f4946a ad63158bdb Ziqiao Kong:
 target/riscv: fix endless translation loop on big endian systems
d6258d62cf 915b203745 Loïc Lefort:
 target/riscv: pmp: move Smepmp operation conversion into a function
0b8c7cdeff 0caed25cd1 Akihiko Odaki:
 virtio: Call set_features during reset
0883bdd92e bdf12f2a56 Fabiano Rosas:
 s390x: Fix leak in machine_set_loadparm
3d2e7e1428 89f7b4da76 Christian Schoenebeck:
 9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
649ef0c6f1 61da38db70 Christian Schoenebeck:
 9pfs: fix concurrent v9fs_reclaim_fd() calls
93e5ecd780 54e54e594b Bernhard Beschow:
 hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
dc5208769a d5d028eee3 Daniel P. Berrangé:
 gitlab: use --refetch in check-patch/check-dco jobs
5dd4660f5f 1e94ddc685 Paolo Bonzini:
 target/i386: do not block singlestep for STI
4ba45dffde e54ef98c8a Paolo Bonzini:
 target/i386: do not trigger IRQ shadow for LSS
9e13cd7232 eba837a31b Bernhard Beschow:
 hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
7407d2319d 8ed7c0b648 Peter Maydell:
 target/arm: Don't assert() for ISB/SB inside IT block
83c926daf8 9401f91b9b Richard Henderson:
 accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
8696da0495 6804b89fb5 Akihiko Odaki:
 meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
dc13fed5f0 563cd698df Akihiko Odaki:
 meson: Use has_header_symbol() to check getcpu()
639cee5ed7 d4a785ba30 Hauke Mehrtens:
 target/mips: Fix MIPS16e translation
c7e0189982 56a9f0d4c4 Peter Maydell:
 hw/core/cpu: gdb_arch_name string should not be freed
e6e49667ae d5f241834b Philippe Mathieu-Daudé:
 hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
9f8bb7edac 6b661b7ed7 Richard Henderson:
 target/avr: Improve decode of LDS, STS
1cc062970e 94a159f3dc Paolo Bonzini:
 target/i386/hvf: fix lflags_to_rflags
af01cf195b e28fbd1c52 Antoine Damhet:
 Revert "virtio-net: Copy received header to buffer"
7f637d2922 b0b5af62ef Arthur Sengileyev:
 Fix objdump output parser in "nsis.py"
138d48eca8 c07cd110a1 Pierrick Bouvier:
 plugins/loader: fix deadlock when resetting/uninstalling a plugin
d1960fafec a7a05f5f6a Daan De Meyer:
 smbios: Fix buffer overrun when using path= option
6a3304c84a 61b6d9b749 Kevin Wolf:
 scsi-disk: Apply error policy for host_status errors again
697209ff41 b3d47c8303 Nicholas Piggin:
 target/ppc: Fix SPRC/SPRD SPRs for P9/10
849a6aea33 9808ce6d5c Nicholas Piggin:
 target/ppc: Big-core scratch register fix
5313973fd4 e139bc4b17 Philippe Mathieu-Daudé:
 tcg: Allocate TEMP_VAL_MEM frame in temp_load()
83d36ab099 719255486d Suravee Suthikulpanit:
 hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU device
ff765e490e c17ad4b11b Akihiko Odaki:
 virtio-net: Fix num_buffers for version 1
6e827147d6 c0b32426ce Marco Cavenati:
 migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
08c3572736 256ba7715b Richard Henderson:
 target/mips: Simplify and fix update_pagemask
4580c38134 d89b9899ba Richard Henderson:
 target/mips: Require even maskbits in update_pagemask
8a669b8aae fca2817fdc Richard Henderson:
 target/mips: Revert TARGET_PAGE_BITS_VARY
fa7638d8c1 070a500cc0 Richard Henderson:
 target/avr: Fix buffer read in avr_print_insn
358f7c6892 04e99f9eb7 Philippe Mathieu-Daudé:
 hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
d87ee29327 2542d5cf47 Heinrich Schuchardt:
 hw/rtc/goldfish: keep time offset when resetting
ec877d2ab0 e768f0246c hemanshu.khilari.foss:
 docs/specs/riscv-iommu: Fixed broken link to external risv iommu document


