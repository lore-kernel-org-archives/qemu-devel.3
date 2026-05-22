Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E03CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXkq-0007WN-93; Fri, 22 May 2026 17:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkH-0006Dx-LC; Fri, 22 May 2026 17:49:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkE-0002Kh-6t; Fri, 22 May 2026 17:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486558; bh=qtMDvsF8oKl2qvbaPbSkKC3KCjnMO4GNgeHlPMxWAoc=;
 h=From:To:Cc:Subject:Date;
 b=bg0YoP3CgdsNauKceHnYXsTTRBwyHiIU1mNU7DTGH1YtrCd+EIdPVzPMMCjrKNSgI
 +hJ3Qwyq+jk7skzn5mEDFWUk6ijYHd4fqXyHkFm9s3eWJ8ulZ6MsthrA+5wfIdcPuf
 ued7corZVAh3VIAnEbB/rsBHH14TH7OpSBeDdjZXae2AzFfVIgU6y1zVPSWwzhhtmJ
 nnKecfDDkCUSO76Q0yv6+wMqsScQRtukbEhKqCSWp2Wug3gPoMkq9mxJyOmuIZZI0C
 bVg/cyo1Ufm1FmyZvKi+YiXRmE7q/BrBQkBUbwhhcihfxgbUA81lNQGmaq5r8rxZsd
 sUy3zFea2ayAg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DEA061AFB59;
 Sat, 23 May 2026 00:49:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 102923B71A8;
 Sat, 23 May 2026 00:49:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 v2 000/149] Patch Round-up for stable 10.2.3,
 freeze on 2026-05-22 (frozen)
Date: Sat, 23 May 2026 00:48:31 +0300
Message-ID: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

The following patches are queued for QEMU stable v10.2.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.2

Patch freeze is 2026-05-22, and the release is planned for 2026-05-24:

  https://wiki.qemu.org/Planning/10.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* b83a42dc779a Peter Maydell:
   hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug
02* 2ff529c6f64b Razvan Ghiorghe:
   linux-user: Fix zero_bss for RX PT_LOAD segments
03* 5e5b278d2b1b Razvan Ghiorghe:
   linux-user: fix mremap with old_size=0 for shared mappings
04* 37c9f6fce5c5 Peter Maydell:
   hw/dma/pl080: Handle bogus swidth and dwidth in transfers
05* b6e61d1cc3bf Tao Ding:
   hw/dma/pl080: Update interrupts after pl080_run()
06* f9b16f791502 Tao Ding:
   hw/dma/pl080: Ignore bottom 2 bits of LLI register
07* 2741d2cc3903 Sergei Heifetz:
   target/i386: fix NULL pointer dereference in legacy-cache=off handling
08* 48221e371686 Pierrick Bouvier:
   contrib/plugins/uftrace.c: fix depth for exit events
09* 9c8430f5d651 Alberto Garcia:
   throttle-group: Fix race condition in throttle_group_restart_queue()
10* 9ac85f4cc799 Fiona Ebner:
   block/mirror: fix assertion failure upon duplicate complete for job using 
   'replaces'
11* a16d4c2f162a Shivang Upadhyay:
   ppc/pnv: fix dumpdtb option
12* ba48bff09fa1 Shivang Upadhyay:
   ppc/pnv: generate dtb after machine initialization is complete
13* c20f143cc9fb Fabiano Rosas:
   io: Fix TLS bye task leak
14* 6f23dde620ef Fiona Ebner:
   ui/vdagent: add migration blocker when machine version < 10.1
15* c035d5eadf40 Marc-André Lureau:
   virtio-gpu: fix overflow check when allocating 2d image
16* 556817773849 Max Chou:
   target/riscv: rvv: Fix missing flags merge in probe_pages for cross-page 
   accesses
17* 0e8ad6a8460f Max Chou:
   target/riscv: rvv: Fix page probe issues in vext_ldff
18* 6257754bb9b0 Paolo Bonzini:
   rust: suggest passing --locked to "cargo install"
19* 129922c2bc39 Jenny Guanni Qu:
   hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
20* bc72b2996c0b Davidlohr Bueso:
   hw/cxl: Respect Media Operation max ops discovery semantics
21* 20beec283b95 Davidlohr Bueso:
   hw/cxl: Exclude Discovery from Media Operation Discovery output
22* fa4a759fc1e1 Cédric Le Goater:
   hw/net/ftgmac100: Improve DMA error handling
23* 80c5be945877 Cédric Le Goater:
   hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error 
   handling
24* 32ebd6c09c18 Jose Martins:
   target/arm: fix s2prot not set for two-stage PMSA translations
25* 0376e9c2dd1f Peter Maydell:
   linux-user/i386/signal.c: Correct definition of target_fpstate_32
26* 5a2fa06b0957 Tao Ding:
   hw/dma/pl080: Fix transfer logic in PL080
27* cc03b62df47a Hanna Czenczek:
   linux-aio: Put all parameters into qemu_laiocb
28* 7eca3d4883be Hanna Czenczek:
   linux-aio: Resubmit tails of short reads/writes
29* 51fc8443c122 GuoHan Zhao:
   block/curl: free s->password in cleanup paths
30* f093ee7ac3af Paolo Bonzini:
   tdx: fix use-after-free in tdx_fetch_cpuid
31* cb1e8c18df62 Jenny Guanni Qu:
   hw/audio/sb16: validate VMState fields in post_load
32* 539421a428fd Richard Henderson:
   tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
33* 55720ba97d21 Pankaj Raghav:
   hw/nvme: re-enable wzds bit in namespace dlfeat
34* eb5cc99aff17 Kaixuan Li:
   hw/nvme: fix heap-buffer-overflow in nvme_abort
35* b5abb655fab6 Peter Maydell:
   scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
36* 65b9f4791c24 Peter Maydell:
   scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
37* 08497afcb2a7 Peter Maydell:
   scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic
38* 4862d2c95104 Paolo Bonzini:
   lsi53c895a: keep a reference to the device while SCRIPTS execute
39* 64807c84e83f Paolo Bonzini:
   lsi53c895a: do not do anything else if a reset is requested by writing 
   ISTAT0
40* 1ca38f84e194 Paolo Bonzini:
   lsi53c895a: keep lsi_request and SCSIRequest in local variables
41* 7c7aaaa342b5 Paolo Bonzini:
   lsi53c895a: keep lsi_request alive as long as the SCSIRequest
42* d459131ff590 Paolo Bonzini:
   lsi53c895a: keep SCSIRequest alive during DMA
43* 31b8d287b7fe Zenghui Yu:
   target/arm: Don't skip access flag fault for AccessType_AT
44* a0721c099b71 Peter Maydell:
   hw/net/rocker: Avoid double-free of l2_flood.group_ids
45* 3cae0b46be54 Marc-André Lureau:
   ui/vnc-jobs: fix VncRectEntry leak on job cleanup
46* 59c1d3113668 Kevin Wolf:
   ide: Fix potential assertion failure on VM stop for PIO read error
47* ccc613f96c66 Kevin Wolf:
   scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
48* fc1a2ec7da53 hongmianquan:
   monitor: Fix deadlock in monitor_cleanup
49* 17fbf3e18c3d Daniel P. Berrangé:
   util: fix missing aio_wait sym in qemu guest agent only build
50* 813dbe869f4f Richard Henderson:
   accel/tcg: Don't pass NULL to get_page_addr_code_hostp
51* 0039e5fd2234 Richard Henderson:
   accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp
52* ad7a005d672a Peter Maydell:
   include: Don't include guest-host.h in cpu-ldst.h
53* 8330da591ef6 Peter Maydell:
   include/user/guest-host.h: Provide g2h etc for both abi_ptr and vaddr
54* 22966937f413 Clayton Craft:
   linux-user: fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set
55* 9b7d64686b82 Sun Haoyu:
   linux-user: update select timeout writeback
56* fa6dfcc373c2 Sun Haoyu:
   linux-user: Make openat2() use -L for absolute paths
57* 7e966ef38f58 Nicholas Piggin:
   bsd-user, linux-user: signal: recursive signal delivery fix
58* 84771c64a5ae Peter Maydell:
   target/arm: do_ats_write(): avoid assertion when ptw failed
59* 566594f10873 Alex Bennée:
   target/arm: fix fault_s1ns for stage 2 faults
60* 4e4832dd72db Nguyen Dinh Phi:
   util/readline: Fix out-of-bounds access in readline_insert_char().
61* 34f66fdfd285 Paolo Bonzini:
   rust: hide panicking default associated constants from rustdoc
62* 799713029354 Paolo Bonzini:
   virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and 
   virtio_scsi_handle_cmd_req_prepare
63* af74c9e46bb5 Gerd Hoffmann:
   hw/uefi: fix heap overflow (CVE-2026-5744)
64* 4e6fb62fb0f3 Dietmar Maurer:
   qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config
65* 4913ae36f979 Stefan Hajnoczi:
   virtio-blk: fix zone report buffer out-of-memory (CVE-2026-5761)
66* f1b1db98cc3b Bernhard Beschow:
   util/cutils: Fix heap corruption under Windows
67* 7437b3eab6af Werner de Carne:
   serial COM: windows serial COM PollingFunc don't sleep
68* 52cf667ed228 GuoHan Zhao:
   ui/spice-app: detect runtime directory creation failures
69* 181fdf8a7e13 Marc-André Lureau:
   ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
70* 027ad866bd29 Pierrick Bouvier:
   target/arm/tcg/translate.c: remove MO_TE usage
71* 87e1226e6f68 Marc-André Lureau:
   target/i386: fix strList leak in x86_cpu_get_unavailable_features
72* 3eae91a8b93a Simon Scherer:
   target/i386: fix missing PF_INSTR in SIGSEGV context
73* 76ad26dd172d Paolo Bonzini:
   target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
74* 79bc17718677 Stepan Popov:
   meson: add missing semicolon in pthread_condattr_setclock test
75* 30fad722ce68 Alex Bennée:
   hw/display: don't accidentally autofree existing virgl resources
76* d41ce10d0f5a Vladimir Sementsov-Ogievskiy:
   migration: vmstate_save_state_v: fix double error_setg
77* c0306d2b8f45 Thomas Huth:
   hw/misc: Fix the valid access size to the avr-power device
78* 3ab47a47d716 Thomas Huth:
   hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
79* 654dce6c5236 Matt Turner:
   linux-user/ppc: Fix ppc64 rt_sigframe stack offset
80* 029f10e85278 Yixin Wei:
   linux-user: fix off-by-one in host_to_target_for_each_rtattr()
81* 93484c768f2b Gyorgy Tamasi:
   linux-user: Don't define target_stat64 struct for loongarch64
82* c8ea1759009a Richard Henderson:
   linux-user/arm/nwfpe: Replace user_registers with current_cpu
83* 784f1dde90df Richard Henderson:
   linux-user/arm/nwfpe: Use thread-local storage for qemufpa
84* 1730e6f33f97 Alistair Francis:
   linux-user/strace: Use pointer type for read and write values
85* 4c681ba3b82d James Hilliard:
   linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
86* 8b60ed835478 Helge Deller:
   linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
87* edb4588309a7 Helge Deller:
   linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
88* 07c7decaa54a Helge Deller:
   linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
89* b03a6ac6fa5d Helge Deller:
   linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
90* e2af3eadc09b Helge Deller:
   linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
91* 9e7734ead149 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
92* 4cb2f91773e8 Yicong Yang:
   hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
93* b2e874bfec59 Sebastián Alba Vives:
   target/riscv: fix stale ptshift and base on page walk restart
94* d5b33fc180f5 Sebastián Alba Vives:
   hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
95* 14808578ccbc Munkhbaatar Enkhbaatar:
   riscv_htif: reject invalid signature ranges (end <= begin)
96* d107b748072c Alistair Francis:
   target/riscv: Generate access fault if sc comparison fails
97* 175afdb0d155 Alistair Francis:
   target/riscv: Don't OR mip.SEIP when mvien is one
98* 5dcc64828dc7 Alistair Francis:
   target/riscv: Use ELEN for Fractional LMUL check
99* dcb6e96257ee Helge Deller:
   linux-user: Add missing CDROM ioctls
100 9fb681792d65 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
101 08dc3e240fc0 Helge Deller:
   linux-user: Allow getsockopt() with NULL optval address
102 9667bf324925 Helge Deller:
   linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
103 1aee8067fce9 kiki:
   hw/intc/xics: Add a check for an invalid server id
104 7a05be8c70bb Cédric Le Goater:
   tests/rcutorture: Fix build error
105 774e6f5c1533 Vivien LEGER:
   hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
106 a7f27d6903b3 宋文武:
   hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
107 f35f0f1ca121 liugan1:
   hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
108 455a6167f254 Peter Xu:
   migration: Fix low possibility downtime violation
109 41c417290df9 Philippe Mathieu-Daudé:
   target/microblaze: Fix endianness used to disassemble
110 f443b6876362 Peter Maydell:
   target/arm: Report IL=0 for Thumb 16-bit BKPT insn
111 18b664c90085 Peter Maydell:
   hw/misc/bcm2835_rng: Specify valid memory access sizes
112 f252769a23e6 Gerd Hoffmann:
   hw/uefi: fix buffer overruns
113 94d9a8b2c9e6 Gerd Hoffmann:
   hw/uefi: verify pio_xfer_offset before calculating buffer checksum
114 5247b3034c23 Gerd Hoffmann:
   hw/uefi: fix ucs2 string helper functions
115 c45b460d16f9 Gerd Hoffmann:
   hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
116 22b7b222d8f5 Gerd Hoffmann:
   hw/uefi: verify data size before accessing it in wrap_pkcs7
117 b4680c02b8e8 Gerd Hoffmann:
   hw/uefi: avoid possibly unaligned variable_auth_2 struct field access
118 b33fd8ab1caa Gerd Hoffmann:
   hw/uefi: check auth.hdr_length minimum size
119 332ea2978780 Jeuk Kim:
   hw/ufs: Validate MCQ SQ references before use
120 283d921e771e Jeuk Kim:
   hw/ufs: Guard MCQ CQ accesses against missing queues
121 4a909c00b9e1 Jeuk Kim:
   hw/ufs: Reject zero-depth MCQ queues
122 619c2da19a05 Jeuk Kim:
   hw/ufs: Keep MCQ SQs alive while requests are outstanding
123 042dbcff8382 Jeuk Kim:
   hw/ufs: Zero reserved bytes in REPORT LUNS response header
124 aefeecb413a8 Peter Maydell:
   hw/display/cirrus_vga: Fix packed-24 color-expansion transparent pattern 
   fills
125 27d14251b904 Peter Maydell:
   hw/display/cirrus_vga: Fix packed-24 color-expansion transparent copies
126 ff36712da5ae Kane Chen:
   hw/misc/aspeed_sbc: Add bounds checking for OTP write operations
127 534a52755bef Cédric Le Goater:
   aspeed/hace: Fix out-of-bounds read in has_padding()
128 c6aa2d0ac161 Cédric Le Goater:
   aspeed/hace: Prevent total_req_len overflow
129 a824f3531a44 Peter Maydell:
   hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
130 a163fc1f864b Peter Maydell:
   meson.build: Add -fzero-init-padding-bits=all
131 039b057c09c6 Peter Maydell:
   tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't 
   exist
132 2293d8b4bd88 Klaus Jensen:
   hw/nvme: fix admin cq msix setup
133 6b5aef7cac9d Helge Deller:
   linux-user: Fix AT_EXECFN in AUXV for symlinked programs
134 c3176e645774 Matt Turner:
   linux-user/sh4: Fix target_ucontext tuc_link field type
135 9ac5aa722721 Matt Turner:
   linux-user/sh4: Fix setup_sigtramp to match Linux kernel trampoline 
   pattern
136 d5e4090177ad Kevin Wolf:
   blkdebug: Add 'delay-ns' option
137 34a67637767d Kevin Wolf:
   block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
138 53074ba0330a Kevin Wolf:
   block: Add flags parameter to blk_*_pdiscard()
139 095c08a7ba68 Kevin Wolf:
   ide: Minimal fix for deadlock between TRIM and drain
140 c1c71a7e167f Kevin Wolf:
   ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
141 92854c9c7539 Kevin Wolf:
   ide-test: Factor out wait_dma_completion()
142 2fa24e975599 Kevin Wolf:
   ide-test: Test reset during TRIM
143 a1310cc6281d Kevin Wolf:
   block: Create DEFAULT_BLOCK_CONF macro
144 f27aea189633 Kevin Wolf:
   block: Add more defaults to DEFAULT_BLOCK_CONF
145 f0d9ccd46cf8 Kevin Wolf:
   commit: Drain nodes across all of bdrv_commit()
146 7f8466e2ce62 Kevin Wolf:
   qemu-io: Add 'aio_discard' command
147 b8bfb1478d61 Kevin Wolf:
   qcow2: Fix corruption on discard during write with COW
148 389f5bcc744d Kevin Wolf:
   iotests/046: Test that discard/write_zeroes wait for dependencies
149 e3082ab3b385 Denis V. Lunev:
   block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()

(commit(s) marked with * were in previous series and are not resent)

