Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAA8C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 11:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ9Hq-0001GG-FQ; Sun, 25 May 2025 07:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ9Fr-0006aj-PI; Sun, 25 May 2025 07:10:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ9Fp-000275-42; Sun, 25 May 2025 07:10:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74DE9124E3B;
 Sun, 25 May 2025 14:10:44 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D28C215F78;
 Sun, 25 May 2025 14:10:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [Stable-9.2.4 v3 00/61] Patch Round-up for stable 9.2.4,
 freeze on 2025-05-24 (frozen)
Date: Sun, 25 May 2025 14:10:39 +0300
Message-Id: <qemu-stable-9.2.4-20250525131554@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following patches are queued for QEMU stable v9.2.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.2

Patch freeze is 2025-05-24, and the release is planned for 2025-05-26:

  https://wiki.qemu.org/Planning/9.2

v3: drop single riscv-related change:

51 73f81da0a362 Daniel Henrique Barboza:
   target/riscv/kvm: minor fixes/tweaks

Please respond here or CC qemu-stable@nongnu.org on any patches
you think shouldn't be included in the release.

This release is expected to be the last release in 9.2.x series.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* e768f0246ce2 hemanshu.khilari.foss:
   docs/specs/riscv-iommu: Fixed broken link to external risv iommu document
02* 2542d5cf471a Heinrich Schuchardt:
   hw/rtc/goldfish: keep time offset when resetting
03* 04e99f9eb792 Philippe Mathieu-Daudé:
   hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
04* 070a500cc0da Richard Henderson:
   target/avr: Fix buffer read in avr_print_insn
05* fca2817fdcb0 Richard Henderson:
   target/mips: Revert TARGET_PAGE_BITS_VARY
06* d89b9899babc Richard Henderson:
   target/mips: Require even maskbits in update_pagemask
07* 256ba7715b10 Richard Henderson:
   target/mips: Simplify and fix update_pagemask
08* c0b32426ce56 Marco Cavenati:
   migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
09* c17ad4b11bd2 Akihiko Odaki:
   virtio-net: Fix num_buffers for version 1
10* 719255486df2 Suravee Suthikulpanit:
   hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU device
11* e139bc4b1772 Philippe Mathieu-Daudé:
   tcg: Allocate TEMP_VAL_MEM frame in temp_load()
12* 9808ce6d5cb7 Nicholas Piggin:
   target/ppc: Big-core scratch register fix
13* b3d47c8303b8 Nicholas Piggin:
   target/ppc: Fix SPRC/SPRD SPRs for P9/10
14* 61b6d9b749ba Kevin Wolf:
   scsi-disk: Apply error policy for host_status errors again
15* a7a05f5f6a40 Daan De Meyer:
   smbios: Fix buffer overrun when using path= option
16* c07cd110a182 Pierrick Bouvier:
   plugins/loader: fix deadlock when resetting/uninstalling a plugin
17* b0b5af62ef9e Arthur Sengileyev:
   Fix objdump output parser in "nsis.py"
18* e28fbd1c525d Antoine Damhet:
   Revert "virtio-net: Copy received header to buffer"
19* 94a159f3dc73 Paolo Bonzini:
   target/i386/hvf: fix lflags_to_rflags
20* 6b661b7ed7cd Richard Henderson:
   target/avr: Improve decode of LDS, STS
21* d5f241834be1 Philippe Mathieu-Daudé:
   hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
22* 56a9f0d4c4a4 Peter Maydell:
   hw/core/cpu: gdb_arch_name string should not be freed
23* d4a785ba30ce Hauke Mehrtens:
   target/mips: Fix MIPS16e translation
24* 563cd698dffb Akihiko Odaki:
   meson: Use has_header_symbol() to check getcpu()
25* 6804b89fb531 Akihiko Odaki:
   meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
26* 9401f91b9b0c Richard Henderson:
   accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
27* 8ed7c0b6488a Peter Maydell:
   target/arm: Don't assert() for ISB/SB inside IT block
28* eba837a31b95 Bernhard Beschow:
   hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
29* e54ef98c8a80 Paolo Bonzini:
   target/i386: do not trigger IRQ shadow for LSS
30* 1e94ddc68544 Paolo Bonzini:
   target/i386: do not block singlestep for STI
31* d5d028eee38d Daniel P. Berrangé:
   gitlab: use --refetch in check-patch/check-dco jobs
32* 54e54e594bc8 Bernhard Beschow:
   hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
33* 61da38db70af Christian Schoenebeck:
   9pfs: fix concurrent v9fs_reclaim_fd() calls
34* 89f7b4da7662 Christian Schoenebeck:
   9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
35* bdf12f2a56bf Fabiano Rosas:
   s390x: Fix leak in machine_set_loadparm
36* 0caed25cd171 Akihiko Odaki:
   virtio: Call set_features during reset
37* 915b20374554 Loïc Lefort:
   target/riscv: pmp: move Smepmp operation conversion into a function
38* ad63158bdb33 Ziqiao Kong:
   target/riscv: fix endless translation loop on big endian systems
39* 22b448ccc661 Icenowy Zheng:
   common-user/host/riscv: use tail pseudoinstruction for calling tail
40* 3e8d1e4a628b Anton Blanchard:
   target/riscv: rvv: Source vector registers cannot overlap mask register
41* b0450a101d6c Anton Blanchard:
   target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
42* 629c2a8dd750 Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to vrgather instructions to 
   check mismatched input EEWs encoding constraint
43* fbeaf3583876 Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to 
   OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
44* fda68acb7761 Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to 
   OPIVV/OPFVV(vext_check_sss) instructions
45* b5480a693e3e Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to vector slide 
   instructions(OPIVI/OPIVX)
46* 411eefd56a39 Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to vector integer extension 
   instructions(OPMVV)
47* 1f090a229f85 Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to vector narrow/widen 
   instructions
48* db21c3eb0550 Max Chou:
   target/riscv: rvv: Apply vext_check_input_eew to vector indexed 
   load/store instructions
49* 8539a1244bf2 Max Chou:
   target/riscv: Fix the rvv reserved encoding of unmasked instructions
50* 2669b696e243 Anton Blanchard:
   target/riscv: Fix vslidedown with rvv_ta_all_1s
51* 906af6de9462 Daniel Henrique Barboza:
   target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
52* b60961034945 Daniel Henrique Barboza:
   target/riscv/kvm: turn u32/u64 reg functions into macros
53* 11766e17616a Daniel Henrique Barboza:
   target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
54* d3b6f1742c36 Daniel Henrique Barboza:
   target/riscv/kvm: add kvm_csr_cfgs[]
55* e5894fd6f411 Rakesh Jeyasingh:
   hw/pci-host/gt64120: Fix endianness handling
56* 560375cff3cc Rakesh Jeyasingh:
   hw/pci-host: Remove unused pci_host_data_be_ops
57* 7f2131c35c17 Zhao Liu:
   qapi/misc-target: Fix the doc to distinguish query-sgx and 
   query-sgx-capabilities
58* 17bec9235bb0 Peter Xu:
   migration: Allow caps to be set when preempt or multifd cap enabled
59* 923976dfe367 Helge Deller:
   target/hppa: Copy instruction code into fr1 on FPU assist fault
60* b4b49cf39dba Helge Deller:
   linux-user/hppa: Send proper si_code on SIGFPE exception
61* ebd394948de4 Helge Deller:
   target/hppa: Fix FPE exceptions

(commit(s) marked with * were in previous series and are not resent)

