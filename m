Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534A4CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSU1x-0006rJ-VT; Thu, 28 May 2026 02:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSU1m-0006pf-Pa; Thu, 28 May 2026 02:15:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSU1g-0005rP-Fy; Thu, 28 May 2026 02:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779948916; bh=Ip8JM6v0CbZyYDhdnwSrKVrGrmPyb3VkYpX6Mds7yZc=;
 h=Subject:From:To:Cc:Date;
 b=TQ2eXDup1E3iuf9L2NSlYTsKHyNd/rwKT8JBbNiUMT4JHFCT4QRHWiN8EfJR/zAcx
 a/1ofy5ClVx2o8RCC0A26qt2N7PpWkjlAuO8XmnsMtFBJk/7crt4am/pPfaQYv7N4h
 6pinB5WgeXe+cEsxbKCo/Vlnye+w6rkq5Ut2/Mnja2mwOyKOTrG+/JRxv8F6FiFEIm
 Q+W+6Ak9t7b1+GDnkhhQdLplny6K7opoONm6vE8+DHPY34nkKj1uCF9RDkgLQnkAdZ
 P0YXdXLOMVG81b538evy848FyxP0KQoU9id/gai3aQQBCVqwnKZEMNbD+TY78FyIxb
 ibYWs/C84mNfA==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id D61521B1F2D;
 Thu, 28 May 2026 09:15:16 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id 92D181691A6; Thu, 28 May 2026 09:15:23 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.2.3 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260528061523.92D181691A6@think4mjt.localdomain>
Date: Thu, 28 May 2026 09:15:23 +0300 (MSK)
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MIME_QP_LONG_LINE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi everyone,

The QEMU v10.2.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.2.3.tar.xz
  https://download.qemu.org/qemu-10.2.3.tar.xz.sig (signature)

v10.2.3 is now tagged in the official qemu.git repository, and the
stable-10.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.2

There are 146 changes since the previous v10.2.2 release.
This release, among other things, fixes multiple vulnerabilities in the UEFI
code (CVE-2026-5744, CVE-2026-8341, CVE-2026-41435, CVE-2026-41436,
CVE-2026-41437, CVE-2026-41438, CVE-2026-41439, CVE-2026-41440), 2 virtio-gpu
issues (CVE-2026-3886, CVE-2026-6502), vulnerabilities in virtio-blk
(CVE-2026-5761) and virtio-scsi (CVE-2026-5763), an issue in lsi53c895a code
(CVE-2024-6519) and in ohci code (CVE-2026-3890).

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.2-hash master-hash Author Name: Commmit-Subject):

2e7e8b7eae Michael Tokarev:
 Update version for 10.2.3 release
9972a3f283 e3082ab3b3 Denis V. Lunev:
 block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
b7a2b41e9e f0d9ccd46c Kevin Wolf:
 commit: Drain nodes across all of bdrv_commit()
c75c1f83b5 f27aea1896 Kevin Wolf:
 block: Add more defaults to DEFAULT_BLOCK_CONF
22792c426b a1310cc628 Kevin Wolf:
 block: Create DEFAULT_BLOCK_CONF macro
5a6401e064 2fa24e9755 Kevin Wolf:
 ide-test: Test reset during TRIM
844b940929 92854c9c75 Kevin Wolf:
 ide-test: Factor out wait_dma_completion()
4bae9baf39 c1c71a7e16 Kevin Wolf:
 ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
792ce55e29 095c08a7ba Kevin Wolf:
 ide: Minimal fix for deadlock between TRIM and drain
4e1e50b0f4 53074ba033 Kevin Wolf:
 block: Add flags parameter to blk_*_pdiscard()
794b70d024 34a6763776 Kevin Wolf:
 block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
94880dd3c6 d5e4090177 Kevin Wolf:
 blkdebug: Add 'delay-ns' option
a78df9ab50 9ac5aa7227 Matt Turner:
 linux-user/sh4: Fix setup_sigtramp to match Linux kernel trampoline pattern
632f496f17 c3176e6457 Matt Turner:
 linux-user/sh4: Fix target_ucontext tuc_link field type
552967257a 6b5aef7cac Helge Deller:
 linux-user: Fix AT_EXECFN in AUXV for symlinked programs
1058ad0d3c 2293d8b4bd Klaus Jensen:
 hw/nvme: fix admin cq msix setup
ec7e6e6562 039b057c09 Peter Maydell:
 tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't exist
1dd1386955 a163fc1f86 Peter Maydell:
 meson.build: Add -fzero-init-padding-bits=all
88304ba742 a824f3531a Peter Maydell:
 hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
bb28b1d899 c6aa2d0ac1 Cédric Le Goater:
 aspeed/hace: Prevent total_req_len overflow
6e146a0eff 534a52755b Cédric Le Goater:
 aspeed/hace: Fix out-of-bounds read in has_padding()
3fa89be81e ff36712da5 Kane Chen:
 hw/misc/aspeed_sbc: Add bounds checking for OTP write operations
ee359b5895 27d14251b9 Peter Maydell:
 hw/display/cirrus_vga: Fix packed-24 color-expansion transparent copies
e7c8621547 aefeecb413 Peter Maydell:
 hw/display/cirrus_vga: Fix packed-24 color-expansion transparent pattern fills
fbff555944 042dbcff83 Jeuk Kim:
 hw/ufs: Zero reserved bytes in REPORT LUNS response header
14a88a04e5 619c2da19a Jeuk Kim:
 hw/ufs: Keep MCQ SQs alive while requests are outstanding
504f334394 4a909c00b9 Jeuk Kim:
 hw/ufs: Reject zero-depth MCQ queues
1b71cb361c 283d921e77 Jeuk Kim:
 hw/ufs: Guard MCQ CQ accesses against missing queues
38e407de9b 332ea29787 Jeuk Kim:
 hw/ufs: Validate MCQ SQ references before use
689117427e b33fd8ab1c Gerd Hoffmann:
 hw/uefi: check auth.hdr_length minimum size
a9bcab7208 b4680c02b8 Gerd Hoffmann:
 hw/uefi: avoid possibly unaligned variable_auth_2 struct field access
16429eea9a 22b7b222d8 Gerd Hoffmann:
 hw/uefi: verify data size before accessing it in wrap_pkcs7
35eaa28887 c45b460d16 Gerd Hoffmann:
 hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
23c38ec6f6 5247b3034c Gerd Hoffmann:
 hw/uefi: fix ucs2 string helper functions
8bf75ce7af 94d9a8b2c9 Gerd Hoffmann:
 hw/uefi: verify pio_xfer_offset before calculating buffer checksum
eee43d91c0 f252769a23 Gerd Hoffmann:
 hw/uefi: fix buffer overruns
baa047808a 18b664c900 Peter Maydell:
 hw/misc/bcm2835_rng: Specify valid memory access sizes
acf81ae6bf f443b68763 Peter Maydell:
 target/arm: Report IL=0 for Thumb 16-bit BKPT insn
f381a79070 41c417290d Philippe Mathieu-Daudé:
 target/microblaze: Fix endianness used to disassemble
17ccebbb50 455a6167f2 Peter Xu:
 migration: Fix low possibility downtime violation
144d98cd16 f35f0f1ca1 liugan1:
 hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
b9a80dd25d a7f27d6903 宋文武:
 hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
86fa106b40 774e6f5c15 Vivien LEGER:
 hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
edceee14b4 7a05be8c70 Cédric Le Goater:
 tests/rcutorture: Fix build error
bc429dd4c8 1aee8067fc kiki:
 hw/intc/xics: Add a check for an invalid server id
10703dcfaa 9667bf3249 Helge Deller:
 linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
4130c71eac 08dc3e240f Helge Deller:
 linux-user: Allow getsockopt() with NULL optval address
be01857b07 9fb681792d Helge Deller:
 linux-user: Flush errors by using exit() instead of _exit() in error path
3b5d55ece4 dcb6e96257 Helge Deller:
 linux-user: Add missing CDROM ioctls
3aaddc00e1 5dcc64828d Alistair Francis:
 target/riscv: Use ELEN for Fractional LMUL check
2c1d02069d 175afdb0d1 Alistair Francis:
 target/riscv: Don't OR mip.SEIP when mvien is one
c3d2ce5020 d107b74807 Alistair Francis:
 target/riscv: Generate access fault if sc comparison fails
5419da9f50 14808578cc Munkhbaatar Enkhbaatar:
 riscv_htif: reject invalid signature ranges (end <= begin)
7d4387d996 d5b33fc180 Sebastián Alba Vives:
 hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
ef37fe63a5 b2e874bfec Sebastián Alba Vives:
 target/riscv: fix stale ptshift and base on page walk restart
020e5f3f28 4cb2f91773 Yicong Yang:
 hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
d33c4176d1 9e7734ead1 Helge Deller:
 linux-user: Flush errors by using exit() instead of _exit() in error path
60fbf87e6d e2af3eadc0 Helge Deller:
 linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
1c4edb1338 b03a6ac6fa Helge Deller:
 linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
960697c2b5 07c7decaa5 Helge Deller:
 linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
399d13e92f edb4588309 Helge Deller:
 linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
f0ebf0b7c6 8b60ed8354 Helge Deller:
 linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
34ffed9518 4c681ba3b8 James Hilliard:
 linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
c2a0deae77 1730e6f33f Alistair Francis:
 linux-user/strace: Use pointer type for read and write values
66c9463cdb 784f1dde90 Richard Henderson:
 linux-user/arm/nwfpe: Use thread-local storage for qemufpa
68045dea8d c8ea175900 Richard Henderson:
 linux-user/arm/nwfpe: Replace user_registers with current_cpu
6b073173a2 93484c768f Gyorgy Tamasi:
 linux-user: Don't define target_stat64 struct for loongarch64
050805b786 029f10e852 Yixin Wei:
 linux-user: fix off-by-one in host_to_target_for_each_rtattr()
d86794e9d9 654dce6c52 Matt Turner:
 linux-user/ppc: Fix ppc64 rt_sigframe stack offset
962bd5ec28 3ab47a47d7 Thomas Huth:
 hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
db373da2a7 c0306d2b8f Thomas Huth:
 hw/misc: Fix the valid access size to the avr-power device
c4f78bd036 d41ce10d0f Vladimir Sementsov-Ogievskiy:
 migration: vmstate_save_state_v: fix double error_setg
5a44a38332 30fad722ce Alex Bennée:
 hw/display: don't accidentally autofree existing virgl resources
d22dd2a689 79bc177186 Stepan Popov:
 meson: add missing semicolon in pthread_condattr_setclock test
30ac69aa67 76ad26dd17 Paolo Bonzini:
 target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
da5beca9eb 3eae91a8b9 Simon Scherer:
 target/i386: fix missing PF_INSTR in SIGSEGV context
5aabe40c38 87e1226e6f Marc-André Lureau:
 target/i386: fix strList leak in x86_cpu_get_unavailable_features
ca77baf544 027ad866bd Pierrick Bouvier:
 target/arm/tcg/translate.c: remove MO_TE usage
d631117be8 181fdf8a7e Marc-André Lureau:
 ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
9a6b1d0b9c 52cf667ed2 GuoHan Zhao:
 ui/spice-app: detect runtime directory creation failures
8243d867ce 7437b3eab6 Werner de Carne:
 serial COM: windows serial COM PollingFunc don't sleep
8ad6c43183 f1b1db98cc Bernhard Beschow:
 util/cutils: Fix heap corruption under Windows
bdf965c067 4913ae36f9 Stefan Hajnoczi:
 virtio-blk: fix zone report buffer out-of-memory (CVE-2026-5761)
ca0bca5068 4e6fb62fb0 Dietmar Maurer:
 qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config
d3c3a7c21b af74c9e46b Gerd Hoffmann:
 hw/uefi: fix heap overflow (CVE-2026-5744)
4c47362705 7997130293 Paolo Bonzini:
 virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare
9207e06585 34f66fdfd2 Paolo Bonzini:
 rust: hide panicking default associated constants from rustdoc
f2b63e289f 4e4832dd72 Nguyen Dinh Phi:
 util/readline: Fix out-of-bounds access in readline_insert_char().
5d3259da4d 566594f108 Alex Bennée:
 target/arm: fix fault_s1ns for stage 2 faults
6dea849abc 84771c64a5 Peter Maydell:
 target/arm: do_ats_write(): avoid assertion when ptw failed
353efac0f4 7e966ef38f Nicholas Piggin:
 bsd-user, linux-user: signal: recursive signal delivery fix
7b5b46057e fa6dfcc373 Sun Haoyu:
 linux-user: Make openat2() use -L for absolute paths
7ef60a5b1b 9b7d64686b Sun Haoyu:
 linux-user: update select timeout writeback
3b68c2db23 22966937f4 Clayton Craft:
 linux-user: fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set
b16930ecb9 8330da591e Peter Maydell:
 include/user/guest-host.h: Provide g2h etc for both abi_ptr and vaddr
254631b11d ad7a005d67 Peter Maydell:
 include: Don't include guest-host.h in cpu-ldst.h
cf0d771952 0039e5fd22 Richard Henderson:
 accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp
35cfa889f3 813dbe869f Richard Henderson:
 accel/tcg: Don't pass NULL to get_page_addr_code_hostp
8449013324 17fbf3e18c Daniel P. Berrangé:
 util: fix missing aio_wait sym in qemu guest agent only build
2da5757fba fc1a2ec7da hongmianquan:
 monitor: Fix deadlock in monitor_cleanup
a0820871f8 ccc613f96c Kevin Wolf:
 scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
0f2605ef80 59c1d31136 Kevin Wolf:
 ide: Fix potential assertion failure on VM stop for PIO read error
ccffe22759 3cae0b46be Marc-André Lureau:
 ui/vnc-jobs: fix VncRectEntry leak on job cleanup
4f2e81f0a7 a0721c099b Peter Maydell:
 hw/net/rocker: Avoid double-free of l2_flood.group_ids
a4ecadcd7b 31b8d287b7 Zenghui Yu:
 target/arm: Don't skip access flag fault for AccessType_AT
1b33499c43 d459131ff5 Paolo Bonzini:
 lsi53c895a: keep SCSIRequest alive during DMA
96ef66a733 7c7aaaa342 Paolo Bonzini:
 lsi53c895a: keep lsi_request alive as long as the SCSIRequest
2d69bf45f9 1ca38f84e1 Paolo Bonzini:
 lsi53c895a: keep lsi_request and SCSIRequest in local variables
52ae183c0c 64807c84e8 Paolo Bonzini:
 lsi53c895a: do not do anything else if a reset is requested by writing ISTAT0
54071d735e 4862d2c951 Paolo Bonzini:
 lsi53c895a: keep a reference to the device while SCRIPTS execute
4feab33510 08497afcb2 Peter Maydell:
 scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic
976c9167d9 65b9f4791c Peter Maydell:
 scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
b223c77aae b5abb655fa Peter Maydell:
 scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
e78cb08376 eb5cc99aff Kaixuan Li:
 hw/nvme: fix heap-buffer-overflow in nvme_abort
64c260df23 55720ba97d Pankaj Raghav:
 hw/nvme: re-enable wzds bit in namespace dlfeat
fd10558b42 539421a428 Richard Henderson:
 tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
84a8f3ed1d cb1e8c18df Jenny Guanni Qu:
 hw/audio/sb16: validate VMState fields in post_load
11678b9ad7 f093ee7ac3 Paolo Bonzini:
 tdx: fix use-after-free in tdx_fetch_cpuid
6928b79753 51fc8443c1 GuoHan Zhao:
 block/curl: free s->password in cleanup paths
c31a6ebade 7eca3d4883 Hanna Czenczek:
 linux-aio: Resubmit tails of short reads/writes
7997e9e7fa cc03b62df4 Hanna Czenczek:
 linux-aio: Put all parameters into qemu_laiocb
fb16dc31e1 5a2fa06b09 Tao Ding:
 hw/dma/pl080: Fix transfer logic in PL080
385d3e593d 0376e9c2dd Peter Maydell:
 linux-user/i386/signal.c: Correct definition of target_fpstate_32
00a49b69c5 32ebd6c09c Jose Martins:
 target/arm: fix s2prot not set for two-stage PMSA translations
3fd0091d45 80c5be9458 Cédric Le Goater:
 hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error handling
53bb480853 fa4a759fc1 Cédric Le Goater:
 hw/net/ftgmac100: Improve DMA error handling
4e5251eed6 20beec283b Davidlohr Bueso:
 hw/cxl: Exclude Discovery from Media Operation Discovery output
207a75123c bc72b2996c Davidlohr Bueso:
 hw/cxl: Respect Media Operation max ops discovery semantics
4ac6a8ae82 129922c2bc Jenny Guanni Qu:
 hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
7ea57b6806 6257754bb9 Paolo Bonzini:
 rust: suggest passing --locked to "cargo install"
6eb0fabd11 0e8ad6a846 Max Chou:
 target/riscv: rvv: Fix page probe issues in vext_ldff
fa3fd597a1 5568177738 Max Chou:
 target/riscv: rvv: Fix missing flags merge in probe_pages for cross-page accesses
2a28de12ba c035d5eadf Marc-André Lureau:
 virtio-gpu: fix overflow check when allocating 2d image
8884c7559a 6f23dde620 Fiona Ebner:
 ui/vdagent: add migration blocker when machine version < 10.1
d9699fd014 c20f143cc9 Fabiano Rosas:
 io: Fix TLS bye task leak
44b84a2d94 ba48bff09f Shivang Upadhyay:
 ppc/pnv: generate dtb after machine initialization is complete
43ed0362d0 a16d4c2f16 Shivang Upadhyay:
 ppc/pnv: fix dumpdtb option
fed9f7ac6a 9ac85f4cc7 Fiona Ebner:
 block/mirror: fix assertion failure upon duplicate complete for job using 'replaces'
444d9054a7 9c8430f5d6 Alberto Garcia:
 throttle-group: Fix race condition in throttle_group_restart_queue()
9f70db93b2 48221e3716 Pierrick Bouvier:
 contrib/plugins/uftrace.c: fix depth for exit events
982e99a451 2741d2cc39 Sergei Heifetz:
 target/i386: fix NULL pointer dereference in legacy-cache=off handling
61f9a8b128 f9b16f7915 Tao Ding:
 hw/dma/pl080: Ignore bottom 2 bits of LLI register
4244a2d65d b6e61d1cc3 Tao Ding:
 hw/dma/pl080: Update interrupts after pl080_run()
80d0acaf6c 37c9f6fce5 Peter Maydell:
 hw/dma/pl080: Handle bogus swidth and dwidth in transfers
23e03a02fd 5e5b278d2b Razvan Ghiorghe:
 linux-user: fix mremap with old_size=0 for shared mappings
ef06d7853c 2ff529c6f6 Razvan Ghiorghe:
 linux-user: Fix zero_bss for RX PT_LOAD segments
1c1bf4f638 b83a42dc77 Peter Maydell:
 hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug


