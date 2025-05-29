Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FE1C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKWeC-0003ns-HZ; Thu, 29 May 2025 02:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKWe9-0003nX-Iq; Thu, 29 May 2025 02:21:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKWdx-0007BI-K0; Thu, 29 May 2025 02:21:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA6851260B9;
 Thu, 29 May 2025 09:21:22 +0300 (MSK)
Received: from localhost (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 51FA6218BB8;
 Thu, 29 May 2025 09:21:30 +0300 (MSK)
Received: (nullmailer pid 13082 invoked by uid 1000);
 Thu, 29 May 2025 06:21:30 -0000
Subject: [ANNOUNCE] QEMU 10.0.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 May 2025 09:21:30 +0300
Message-Id: <1748499690.323471.13081.nullmailer@localhost>
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

The QEMU v10.0.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.2.tar.xz
  https://download.qemu.org/qemu-10.0.2.tar.xz.sig (signature)

v10.0.2 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 62 changes since the previous v10.0.0 release.

10.0.x is expected to be the next long-term-support series.

There was no 10.0.1 release tarball, instead, 10.0.2 has been
released as a quick fix with a single revert of a commit which
shouldn't be in 10.0.x series in the first place.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

ff3419cbac Michael Tokarev:
 Update version for 10.0.2 release
6f7a53e58e Michael Tokarev:
 Revert "Drop support for Python 3.8"
fd0b1a5b13 Michael Tokarev:
 Update version for 10.0.1 release
3d5b2f81fb d64db833d6 Thomas Huth:
 Drop support for Python 3.8
6966e0ba1d ebd394948d Helge Deller:
 target/hppa: Fix FPE exceptions
5f119c69ff b4b49cf39d Helge Deller:
 linux-user/hppa: Send proper si_code on SIGFPE exception
679450c926 923976dfe3 Helge Deller:
 target/hppa: Copy instruction code into fr1 on FPU assist fault
8a48520c17 17bec9235b Peter Xu:
 migration: Allow caps to be set when preempt or multifd cap enabled
7484d61bdb 6be7696129 Maciej S. Szmigiero:
 migration/multifd: Don't send device state packets with zerocopy flag
5e8ef1da89 7f2131c35c Zhao Liu:
 qapi/misc-target: Fix the doc to distinguish query-sgx and query-sgx-capabilities
ef1655962f 560375cff3 Rakesh Jeyasingh:
 hw/pci-host: Remove unused pci_host_data_be_ops
cdf3fb0617 e5894fd6f4 Rakesh Jeyasingh:
 hw/pci-host/gt64120: Fix endianness handling
3e59fccb03 7a48612306 Xiaoyao Li:
 i386/hvf: Make CPUID_HT supported
2f6357ca96 5979f50fa9 Xiaoyao Li:
 i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG supported
9ac56fb385 f396c217a5 Daniel Henrique Barboza:
 target/riscv/kvm: do not read unavailable CSRs
6ba14ba513 d3b6f1742c Daniel Henrique Barboza:
 target/riscv/kvm: add kvm_csr_cfgs[]
90f7e23cb7 11766e1761 Daniel Henrique Barboza:
 target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
ea8eb871ab b609610349 Daniel Henrique Barboza:
 target/riscv/kvm: turn u32/u64 reg functions into macros
04b855727f 906af6de94 Daniel Henrique Barboza:
 target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
c500814317 73f81da0a3 Daniel Henrique Barboza:
 target/riscv/kvm: minor fixes/tweaks
95c0e6e065 2669b696e2 Anton Blanchard:
 target/riscv: Fix vslidedown with rvv_ta_all_1s
7b21781562 8539a1244b Max Chou:
 target/riscv: Fix the rvv reserved encoding of unmasked instructions
43a4f232fa db21c3eb05 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector indexed load/store instructions
be6e117a83 1f090a229f Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector narrow/widen instructions
faaeaa955c 411eefd56a Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector integer extension instructions(OPMVV)
19d107468e b5480a693e Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vector slide instructions(OPIVI/OPIVX)
2a0eb3c2a1 fda68acb77 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to OPIVV/OPFVV(vext_check_sss) instructions
0bfd8dd14b fbeaf35838 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
bc502d4de9 629c2a8dd7 Max Chou:
 target/riscv: rvv: Apply vext_check_input_eew to vrgather instructions to check mismatched input EEWs encoding constraint
027ea4a2f5 b0450a101d Anton Blanchard:
 target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
336fed6bb8 3e8d1e4a62 Anton Blanchard:
 target/riscv: rvv: Source vector registers cannot overlap mask register
70dbbc2811 22b448ccc6 Icenowy Zheng:
 common-user/host/riscv: use tail pseudoinstruction for calling tail
156321d18e ad63158bdb Ziqiao Kong:
 target/riscv: fix endless translation loop on big endian systems
b76d4a5657 56cde18d04 Paolo Bonzini:
 hw/riscv: Fix type conflict of GLib function pointers
bc15a8db4f 19cf1a7d9e Loïc Lefort:
 target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode
504dcda206 915b203745 Loïc Lefort:
 target/riscv: pmp: move Smepmp operation conversion into a function
f82dd2837c 4541d205f0 Loïc Lefort:
 target/riscv: pmp: don't allow RLB to bypass rule privileges
15143814cd 0b1c23a582 Klaus Jensen:
 hw/nvme: fix nvme hotplugging
40558266b1 0caed25cd1 Akihiko Odaki:
 virtio: Call set_features during reset
8efe15927b bdf12f2a56 Fabiano Rosas:
 s390x: Fix leak in machine_set_loadparm
a0f326228a 89f7b4da76 Christian Schoenebeck:
 9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
5081dc508d 61da38db70 Christian Schoenebeck:
 9pfs: fix concurrent v9fs_reclaim_fd() calls
9340920c3f 54e54e594b Bernhard Beschow:
 hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
bfa3f55f0f 88fb705600 Edgar E. Iglesias:
 xen: mapcache: Split mapcache_grants by ro and rw
a03d7d6e32 a4b20f737c Aleksandr Partanen:
 xen: mapcache: Fix finding matching entry
827be9d37a 1e94ddc685 Paolo Bonzini:
 target/i386: do not block singlestep for STI
f60033d379 e54ef98c8a Paolo Bonzini:
 target/i386: do not trigger IRQ shadow for LSS
01a9f1a6c5 eba837a31b Bernhard Beschow:
 hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
be7b08eb9f 82707dd4f0 Peter Maydell:
 docs: Don't define duplicate label in qemu-block-drivers.rst.inc
ac32612b93 8ed7c0b648 Peter Maydell:
 target/arm: Don't assert() for ISB/SB inside IT block
07f034c7f4 97cdd1b0a7 Tim Lee:
 hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX SoC
86b846f902 9401f91b9b Richard Henderson:
 accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
8a9a719314 a5b30be534 Akihiko Odaki:
 meson: Use osdep_prefix for strchrnul()
e1ccfea380 797150d69d Akihiko Odaki:
 meson: Share common C source prefixes
1604055e4e 6804b89fb5 Akihiko Odaki:
 meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
7bff88a745 563cd698df Akihiko Odaki:
 meson: Use has_header_symbol() to check getcpu()
e60bbdad93 d4a785ba30 Hauke Mehrtens:
 target/mips: Fix MIPS16e translation
dbbb444d72 56a9f0d4c4 Peter Maydell:
 hw/core/cpu: gdb_arch_name string should not be freed
94da90b8c7 d5f241834b Philippe Mathieu-Daudé:
 hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
2da497fd4f 6b661b7ed7 Richard Henderson:
 target/avr: Improve decode of LDS, STS
00a5dc2899 94a159f3dc Paolo Bonzini:
 target/i386/hvf: fix lflags_to_rflags
86ffc25d35 f6b5f71f04 Maciej S. Szmigiero:
 target/i386: Reset parked vCPUs together with the online ones
3af56fc07f 280712b787 Ewan Hai:
 target/i386: Fix model number of Zhaoxin YongFeng vCPU template


