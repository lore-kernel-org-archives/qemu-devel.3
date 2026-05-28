Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7E0CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTv9-0002Rq-84; Thu, 28 May 2026 02:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSTv7-0002Rd-PY; Thu, 28 May 2026 02:08:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSTv3-00035Y-Sh; Thu, 28 May 2026 02:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779948505; bh=c44dBrC6At6dQjughRh7N4MI8rtI90SDpcW9UUj+IA8=;
 h=Subject:From:To:Cc:Date;
 b=iK6Sk3660wnPpKXKsCZWRXkcu23H6itKNq3WPV7RsuxvmTvkB6vO4QwlRozXr7vgN
 9fnql0u+va5RHPE+RgT3xyu0O+0Q+2LMU7VvAEufoZY/TB9/MnWc3W3NIslUzKFyXL
 IJuGsHaVvbX+87TewH6CnIl0Yo41t73Lb2U1IIB9WOQXd6BUEOwul2cdRYfKIsrJ/e
 Mik9VapkcB5hzwf3w55mq7vd4WmG33Ldh3BgRUsAl+jB5Tyj/bAt/nhLtzljnxHKKu
 XO0mujkTwM7rgjCyRb7gfP7EVTtPOafMHkTSCtdD3yXlJgSMJeXOVN3laAus0npONr
 AEHZGqHLJrhFQ==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 056391B1F19;
 Thu, 28 May 2026 09:08:25 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id B09C41691A3; Thu, 28 May 2026 09:08:31 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.0.10 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260528060831.B09C41691A3@think4mjt.localdomain>
Date: Thu, 28 May 2026 09:08:31 +0300 (MSK)
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

The QEMU v10.0.10 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.10.tar.xz
  https://download.qemu.org/qemu-10.0.10.tar.xz.sig (signature)

v10.0.10 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 133 changes since the previous v10.0.9 release.
These changes, among others, fixes several discovered vulnerabilities
in the UEFI code (CVE-2026-5744, CVE-2026-8341, CVE-2026-41435, CVE-2026-41436,
CVE-2026-41437, CVE-2026-41438, CVE-2026-41439, CVE-2026-41440), 2 virtio-gpu
vulnerabilies (CVE-2026-3886, CVE-2026-6502), virtio-blk and virtio-scsi
vulnerabilies (CVE-2026-5761, CVE-2026-5763), an issue in lsi53c895a controller
(CVE-2024-6519), and an issue in ohci controller code (CVE-2026-3890).

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

4fef525eea Michael Tokarev:
 Update version for 10.0.10 release
0df8e9466b e3082ab3b3 Denis V. Lunev:
 block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
4693cc8686 f27aea1896 Kevin Wolf:
 block: Add more defaults to DEFAULT_BLOCK_CONF
0166a057c7 a1310cc628 Kevin Wolf:
 block: Create DEFAULT_BLOCK_CONF macro
cf1a95791c 2fa24e9755 Kevin Wolf:
 ide-test: Test reset during TRIM
9a14eb952a 92854c9c75 Kevin Wolf:
 ide-test: Factor out wait_dma_completion()
1824728e2e c1c71a7e16 Kevin Wolf:
 ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
0f7f9e0fe0 095c08a7ba Kevin Wolf:
 ide: Minimal fix for deadlock between TRIM and drain
a42e233c59 53074ba033 Kevin Wolf:
 block: Add flags parameter to blk_*_pdiscard()
0a0af01730 34a6763776 Kevin Wolf:
 block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
396229165a d5e4090177 Kevin Wolf:
 blkdebug: Add 'delay-ns' option
651f822082 9ac5aa7227 Matt Turner:
 linux-user/sh4: Fix setup_sigtramp to match Linux kernel trampoline pattern
e693705466 c3176e6457 Matt Turner:
 linux-user/sh4: Fix target_ucontext tuc_link field type
704c6355db 6b5aef7cac Helge Deller:
 linux-user: Fix AT_EXECFN in AUXV for symlinked programs
95eb2a9207 2293d8b4bd Klaus Jensen:
 hw/nvme: fix admin cq msix setup
c2b5686679 039b057c09 Peter Maydell:
 tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't exist
53a405c2df a163fc1f86 Peter Maydell:
 meson.build: Add -fzero-init-padding-bits=all
328c4efcbe a824f3531a Peter Maydell:
 hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
b009309972 c6aa2d0ac1 Cédric Le Goater:
 aspeed/hace: Prevent total_req_len overflow
23d47ab876 534a52755b Cédric Le Goater:
 aspeed/hace: Fix out-of-bounds read in has_padding()
a9619146f7 27d14251b9 Peter Maydell:
 hw/display/cirrus_vga: Fix packed-24 color-expansion transparent copies
8ab668fcaa aefeecb413 Peter Maydell:
 hw/display/cirrus_vga: Fix packed-24 color-expansion transparent pattern fills
149ae83454 619c2da19a Jeuk Kim:
 hw/ufs: Keep MCQ SQs alive while requests are outstanding
8898027474 4a909c00b9 Jeuk Kim:
 hw/ufs: Reject zero-depth MCQ queues
644e5f0c72 283d921e77 Jeuk Kim:
 hw/ufs: Guard MCQ CQ accesses against missing queues
3be34408cf 332ea29787 Jeuk Kim:
 hw/ufs: Validate MCQ SQ references before use
4264ab7d5b b33fd8ab1c Gerd Hoffmann:
 hw/uefi: check auth.hdr_length minimum size
75791d8424 b4680c02b8 Gerd Hoffmann:
 hw/uefi: avoid possibly unaligned variable_auth_2 struct field access
a47465c034 22b7b222d8 Gerd Hoffmann:
 hw/uefi: verify data size before accessing it in wrap_pkcs7
e035b69bef c45b460d16 Gerd Hoffmann:
 hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
8136b98b2e 5247b3034c Gerd Hoffmann:
 hw/uefi: fix ucs2 string helper functions
7b6746e726 94d9a8b2c9 Gerd Hoffmann:
 hw/uefi: verify pio_xfer_offset before calculating buffer checksum
c11db18a9f f252769a23 Gerd Hoffmann:
 hw/uefi: fix buffer overruns
5b790d64c3 18b664c900 Peter Maydell:
 hw/misc/bcm2835_rng: Specify valid memory access sizes
01f2eb29bf f443b68763 Peter Maydell:
 target/arm: Report IL=0 for Thumb 16-bit BKPT insn
3b48a82b81 41c417290d Philippe Mathieu-Daudé:
 target/microblaze: Fix endianness used to disassemble
baf584404f f35f0f1ca1 liugan1:
 hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
b99e16eb01 a7f27d6903 宋文武:
 hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
d5056ae28d 774e6f5c15 Vivien LEGER:
 hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
ca8b1aea7f ea585b1022 BALATON Zoltan:
 hw/ppc/e500: Move clock and TB frequency to machine class
a3c3b0c18e 7a05be8c70 Cédric Le Goater:
 tests/rcutorture: Fix build error
daf89461af 1aee8067fc kiki:
 hw/intc/xics: Add a check for an invalid server id
1078b6f08e 9667bf3249 Helge Deller:
 linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
b76d44e977 08dc3e240f Helge Deller:
 linux-user: Allow getsockopt() with NULL optval address
59561e535c 9fb681792d Helge Deller:
 linux-user: Flush errors by using exit() instead of _exit() in error path
9e375dd0a1 dcb6e96257 Helge Deller:
 linux-user: Add missing CDROM ioctls
45846350ca 5dcc64828d Alistair Francis:
 target/riscv: Use ELEN for Fractional LMUL check
6883570012 175afdb0d1 Alistair Francis:
 target/riscv: Don't OR mip.SEIP when mvien is one
f5ab17c3e1 d107b74807 Alistair Francis:
 target/riscv: Generate access fault if sc comparison fails
73172a8a64 14808578cc Munkhbaatar Enkhbaatar:
 riscv_htif: reject invalid signature ranges (end <= begin)
13f59cb2f1 d5b33fc180 Sebastián Alba Vives:
 hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
e988f135a7 b2e874bfec Sebastián Alba Vives:
 target/riscv: fix stale ptshift and base on page walk restart
265e2dd873 4cb2f91773 Yicong Yang:
 hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
b10683c3ad 9e7734ead1 Helge Deller:
 linux-user: Flush errors by using exit() instead of _exit() in error path
c7cc43dcd9 e2af3eadc0 Helge Deller:
 linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
95a80ecb0b b03a6ac6fa Helge Deller:
 linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
57326ab579 07c7decaa5 Helge Deller:
 linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
60e6dddff7 edb4588309 Helge Deller:
 linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
542abc51d8 8b60ed8354 Helge Deller:
 linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
38fb994cf4 4c681ba3b8 James Hilliard:
 linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
1411df4df3 1730e6f33f Alistair Francis:
 linux-user/strace: Use pointer type for read and write values
c532e31252 784f1dde90 Richard Henderson:
 linux-user/arm/nwfpe: Use thread-local storage for qemufpa
2a03182240 c8ea175900 Richard Henderson:
 linux-user/arm/nwfpe: Replace user_registers with current_cpu
7f0290dd8e 93484c768f Gyorgy Tamasi:
 linux-user: Don't define target_stat64 struct for loongarch64
4780c8e152 029f10e852 Yixin Wei:
 linux-user: fix off-by-one in host_to_target_for_each_rtattr()
ebb8933335 654dce6c52 Matt Turner:
 linux-user/ppc: Fix ppc64 rt_sigframe stack offset
c1fcb682e5 3ab47a47d7 Thomas Huth:
 hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
a16faafd30 c0306d2b8f Thomas Huth:
 hw/misc: Fix the valid access size to the avr-power device
80fdb861b1 d41ce10d0f Vladimir Sementsov-Ogievskiy:
 migration: vmstate_save_state_v: fix double error_setg
ba3ed73d27 30fad722ce Alex Bennée:
 hw/display: don't accidentally autofree existing virgl resources
631f055e2d 79bc177186 Stepan Popov:
 meson: add missing semicolon in pthread_condattr_setclock test
396a517d0c 76ad26dd17 Paolo Bonzini:
 target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
b9eb5becd6 3eae91a8b9 Simon Scherer:
 target/i386: fix missing PF_INSTR in SIGSEGV context
1ba3edb77e 87e1226e6f Marc-André Lureau:
 target/i386: fix strList leak in x86_cpu_get_unavailable_features
0ad3a00e4e 027ad866bd Pierrick Bouvier:
 target/arm/tcg/translate.c: remove MO_TE usage
dde66ed86a 181fdf8a7e Marc-André Lureau:
 ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
0eeca728d7 52cf667ed2 GuoHan Zhao:
 ui/spice-app: detect runtime directory creation failures
c7d777379e 7437b3eab6 Werner de Carne:
 serial COM: windows serial COM PollingFunc don't sleep
27577a064f f1b1db98cc Bernhard Beschow:
 util/cutils: Fix heap corruption under Windows
e715b72ff6 4913ae36f9 Stefan Hajnoczi:
 virtio-blk: fix zone report buffer out-of-memory (CVE-2026-5761)
20822b3b62 4e6fb62fb0 Dietmar Maurer:
 qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config
c870df8f16 af74c9e46b Gerd Hoffmann:
 hw/uefi: fix heap overflow (CVE-2026-5744)
1884511ed6 7997130293 Paolo Bonzini:
 virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare
0d4a6d7e06 4e4832dd72 Nguyen Dinh Phi:
 util/readline: Fix out-of-bounds access in readline_insert_char().
1438343753 566594f108 Alex Bennée:
 target/arm: fix fault_s1ns for stage 2 faults
767f37942c 84771c64a5 Peter Maydell:
 target/arm: do_ats_write(): avoid assertion when ptw failed
1629a7860e 7e966ef38f Nicholas Piggin:
 bsd-user, linux-user: signal: recursive signal delivery fix
e9f848cc15 fa6dfcc373 Sun Haoyu:
 linux-user: Make openat2() use -L for absolute paths
db901b89cc 9b7d64686b Sun Haoyu:
 linux-user: update select timeout writeback
53946af76f 22966937f4 Clayton Craft:
 linux-user: fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set
fba104f0a1 17fbf3e18c Daniel P. Berrangé:
 util: fix missing aio_wait sym in qemu guest agent only build
d09cb865b3 fc1a2ec7da hongmianquan:
 monitor: Fix deadlock in monitor_cleanup
a4995bbea2 ccc613f96c Kevin Wolf:
 scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
dadfcfe5f9 59c1d31136 Kevin Wolf:
 ide: Fix potential assertion failure on VM stop for PIO read error
901872398d 3cae0b46be Marc-André Lureau:
 ui/vnc-jobs: fix VncRectEntry leak on job cleanup
5cbf2a2c1e a0721c099b Peter Maydell:
 hw/net/rocker: Avoid double-free of l2_flood.group_ids
e8db39494a d459131ff5 Paolo Bonzini:
 lsi53c895a: keep SCSIRequest alive during DMA
4a1ac90ea4 7c7aaaa342 Paolo Bonzini:
 lsi53c895a: keep lsi_request alive as long as the SCSIRequest
d0644443f1 1ca38f84e1 Paolo Bonzini:
 lsi53c895a: keep lsi_request and SCSIRequest in local variables
8dc591c4d9 64807c84e8 Paolo Bonzini:
 lsi53c895a: do not do anything else if a reset is requested by writing ISTAT0
d5f0c3aa7e 4862d2c951 Paolo Bonzini:
 lsi53c895a: keep a reference to the device while SCRIPTS execute
4d61a1ca97 08497afcb2 Peter Maydell:
 scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic
203589d581 65b9f4791c Peter Maydell:
 scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
6e3d65c3d2 b5abb655fa Peter Maydell:
 scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
0714b8b26f eb5cc99aff Kaixuan Li:
 hw/nvme: fix heap-buffer-overflow in nvme_abort
3ef71d2b93 55720ba97d Pankaj Raghav:
 hw/nvme: re-enable wzds bit in namespace dlfeat
931a7f55d4 539421a428 Richard Henderson:
 tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
5585c4d5fc cb1e8c18df Jenny Guanni Qu:
 hw/audio/sb16: validate VMState fields in post_load
84afbc0cb7 51fc8443c1 GuoHan Zhao:
 block/curl: free s->password in cleanup paths
860738a04f 7eca3d4883 Hanna Czenczek:
 linux-aio: Resubmit tails of short reads/writes
1db94bea95 cc03b62df4 Hanna Czenczek:
 linux-aio: Put all parameters into qemu_laiocb
905a465a7a 5a2fa06b09 Tao Ding:
 hw/dma/pl080: Fix transfer logic in PL080
86d5341303 0376e9c2dd Peter Maydell:
 linux-user/i386/signal.c: Correct definition of target_fpstate_32
341fccc208 80c5be9458 Cédric Le Goater:
 hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error handling
aec9eb4cc1 fa4a759fc1 Cédric Le Goater:
 hw/net/ftgmac100: Improve DMA error handling
1392caa885 129922c2bc Jenny Guanni Qu:
 hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
dc02bc06bc 6257754bb9 Paolo Bonzini:
 rust: suggest passing --locked to "cargo install"
181cb43348 0e8ad6a846 Max Chou:
 target/riscv: rvv: Fix page probe issues in vext_ldff
f852a82ac2 5568177738 Max Chou:
 target/riscv: rvv: Fix missing flags merge in probe_pages for cross-page accesses
6235b276d0 d887736225 Paolo Savini:
 Expand the probe_pages helper function to handle probe flags.
54c829cbe0 9dbfd4e28d Wesley Hershberger:
 block: Drop detach_subchain for bdrv_replace_node
b36743f165 c035d5eadf Marc-André Lureau:
 virtio-gpu: fix overflow check when allocating 2d image
f990473869 c20f143cc9 Fabiano Rosas:
 io: Fix TLS bye task leak
7860faac8c ba48bff09f Shivang Upadhyay:
 ppc/pnv: generate dtb after machine initialization is complete
b7460b0d54 a16d4c2f16 Shivang Upadhyay:
 ppc/pnv: fix dumpdtb option
4ec49f1159 9ac85f4cc7 Fiona Ebner:
 block/mirror: fix assertion failure upon duplicate complete for job using 'replaces'
d5e7ad8915 9c8430f5d6 Alberto Garcia:
 throttle-group: Fix race condition in throttle_group_restart_queue()
7cc54cca5a 2741d2cc39 Sergei Heifetz:
 target/i386: fix NULL pointer dereference in legacy-cache=off handling
44083a648b f9b16f7915 Tao Ding:
 hw/dma/pl080: Ignore bottom 2 bits of LLI register
ec3261995a b6e61d1cc3 Tao Ding:
 hw/dma/pl080: Update interrupts after pl080_run()
3c89612471 37c9f6fce5 Peter Maydell:
 hw/dma/pl080: Handle bogus swidth and dwidth in transfers
5788573b71 5e5b278d2b Razvan Ghiorghe:
 linux-user: fix mremap with old_size=0 for shared mappings
9336732d22 2ff529c6f6 Razvan Ghiorghe:
 linux-user: Fix zero_bss for RX PT_LOAD segments
e5bf6a39f0 b83a42dc77 Peter Maydell:
 hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug


