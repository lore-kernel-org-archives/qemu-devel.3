Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4894DCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu8F-0003xj-R0; Tue, 12 May 2026 16:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu85-0003si-53; Tue, 12 May 2026 16:55:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu81-0002bI-Ra; Tue, 12 May 2026 16:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619273; bh=mOYUYTCYgPVwaFt/u2EQybNe49pp93L+KM6WRHhUhz0=;
 h=From:To:Cc:Subject:Date;
 b=EtVf1ZuVbm8EUIoJw1R+xK1qdDS0kzX/0n1CkyMafuVBjnWLmJ/TFMdM6iKREeoMA
 W3PfkcMPelRpuGS/QHCq0wP9bJ4fwFbspYPHHaw2ddnUvpg987+9hsfwm+Lw9jcvyl
 iDVmyBJEJfYyolvH+tXMNin9X06fQqUS1uP6N976eBhiITpy6hU8wxDG9Urv+y7zg6
 ErbMpKefcB8g5slN9o8NlFf3ADeEm37/EFR5+yKEXH+7uKIW8Ln6/IhIqx3UmfRuJR
 E1x1Lfqvr5Kcnoa9HaW6c0PZV3hOvfI2naUn4RmnYciEDRyaal0OvqPnlraKNpsYFg
 sA+LqN9ZLuX6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 552871AA2CC;
 Tue, 12 May 2026 23:54:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FA6E3ABC3D;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 000/107] Patch Round-up for stable 10.0.10,
 freeze on 2026-05-22
Date: Tue, 12 May 2026 23:52:47 +0300
Message-ID: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.10:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-05-22, and the release is planned for 2026-05-24:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 b83a42dc779a Peter Maydell:
   hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug
02 2ff529c6f64b Razvan Ghiorghe:
   linux-user: Fix zero_bss for RX PT_LOAD segments
03 5e5b278d2b1b Razvan Ghiorghe:
   linux-user: fix mremap with old_size=0 for shared mappings
04 37c9f6fce5c5 Peter Maydell:
   hw/dma/pl080: Handle bogus swidth and dwidth in transfers
05 b6e61d1cc3bf Tao Ding:
   hw/dma/pl080: Update interrupts after pl080_run()
06 f9b16f791502 Tao Ding:
   hw/dma/pl080: Ignore bottom 2 bits of LLI register
07 2741d2cc3903 Sergei Heifetz:
   target/i386: fix NULL pointer dereference in legacy-cache=off handling
08 9c8430f5d651 Alberto Garcia:
   throttle-group: Fix race condition in throttle_group_restart_queue()
09 9ac85f4cc799 Fiona Ebner:
   block/mirror: fix assertion failure upon duplicate complete for job using 
   'replaces'
10 a16d4c2f162a Shivang Upadhyay:
   ppc/pnv: fix dumpdtb option
11 ba48bff09fa1 Shivang Upadhyay:
   ppc/pnv: generate dtb after machine initialization is complete
12 c20f143cc9fb Fabiano Rosas:
   io: Fix TLS bye task leak
13 c035d5eadf40 Marc-André Lureau:
   virtio-gpu: fix overflow check when allocating 2d image
14 9dbfd4e28dd1 Wesley Hershberger:
   block: Drop detach_subchain for bdrv_replace_node
15 d88773622598 Paolo Savini:
   Expand the probe_pages helper function to handle probe flags.
16 556817773849 Max Chou:
   target/riscv: rvv: Fix missing flags merge in probe_pages for cross-page 
   accesses
17 0e8ad6a8460f Max Chou:
   target/riscv: rvv: Fix page probe issues in vext_ldff
18 6257754bb9b0 Paolo Bonzini:
   rust: suggest passing --locked to "cargo install"
19 129922c2bc39 Jenny Guanni Qu:
   hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
20 fa4a759fc1e1 Cédric Le Goater:
   hw/net/ftgmac100: Improve DMA error handling
21 80c5be945877 Cédric Le Goater:
   hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error 
   handling
22 0376e9c2dd1f Peter Maydell:
   linux-user/i386/signal.c: Correct definition of target_fpstate_32
23 5a2fa06b0957 Tao Ding:
   hw/dma/pl080: Fix transfer logic in PL080
24 cc03b62df47a Hanna Czenczek:
   linux-aio: Put all parameters into qemu_laiocb
25 7eca3d4883be Hanna Czenczek:
   linux-aio: Resubmit tails of short reads/writes
26 51fc8443c122 GuoHan Zhao:
   block/curl: free s->password in cleanup paths
27 cb1e8c18df62 Jenny Guanni Qu:
   hw/audio/sb16: validate VMState fields in post_load
28 539421a428fd Richard Henderson:
   tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
29 55720ba97d21 Pankaj Raghav:
   hw/nvme: re-enable wzds bit in namespace dlfeat
30 eb5cc99aff17 Kaixuan Li:
   hw/nvme: fix heap-buffer-overflow in nvme_abort
31 b5abb655fab6 Peter Maydell:
   scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
32 65b9f4791c24 Peter Maydell:
   scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
33 08497afcb2a7 Peter Maydell:
   scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic
34 4862d2c95104 Paolo Bonzini:
   lsi53c895a: keep a reference to the device while SCRIPTS execute
35 64807c84e83f Paolo Bonzini:
   lsi53c895a: do not do anything else if a reset is requested by writing 
   ISTAT0
36 1ca38f84e194 Paolo Bonzini:
   lsi53c895a: keep lsi_request and SCSIRequest in local variables
37 7c7aaaa342b5 Paolo Bonzini:
   lsi53c895a: keep lsi_request alive as long as the SCSIRequest
38 d459131ff590 Paolo Bonzini:
   lsi53c895a: keep SCSIRequest alive during DMA
39 a0721c099b71 Peter Maydell:
   hw/net/rocker: Avoid double-free of l2_flood.group_ids
40 3cae0b46be54 Marc-André Lureau:
   ui/vnc-jobs: fix VncRectEntry leak on job cleanup
41 59c1d3113668 Kevin Wolf:
   ide: Fix potential assertion failure on VM stop for PIO read error
42 ccc613f96c66 Kevin Wolf:
   scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
43 fc1a2ec7da53 hongmianquan:
   monitor: Fix deadlock in monitor_cleanup
44 17fbf3e18c3d Daniel P. Berrangé:
   util: fix missing aio_wait sym in qemu guest agent only build
45 22966937f413 Clayton Craft:
   linux-user: fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set
46 9b7d64686b82 Sun Haoyu:
   linux-user: update select timeout writeback
47 fa6dfcc373c2 Sun Haoyu:
   linux-user: Make openat2() use -L for absolute paths
48 7e966ef38f58 Nicholas Piggin:
   bsd-user, linux-user: signal: recursive signal delivery fix
49 84771c64a5ae Peter Maydell:
   target/arm: do_ats_write(): avoid assertion when ptw failed
50 566594f10873 Alex Bennée:
   target/arm: fix fault_s1ns for stage 2 faults
51 4e4832dd72db Nguyen Dinh Phi:
   util/readline: Fix out-of-bounds access in readline_insert_char().
52 799713029354 Paolo Bonzini:
   virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and 
   virtio_scsi_handle_cmd_req_prepare
53 af74c9e46bb5 Gerd Hoffmann:
   hw/uefi: fix heap overflow (CVE-2026-5744)
54 4e6fb62fb0f3 Dietmar Maurer:
   qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config
55 4913ae36f979 Stefan Hajnoczi:
   virtio-blk: fix zone report buffer out-of-memory (CVE-2026-5761)
56 f1b1db98cc3b Bernhard Beschow:
   util/cutils: Fix heap corruption under Windows
57 7437b3eab6af Werner de Carne:
   serial COM: windows serial COM PollingFunc don't sleep
58 52cf667ed228 GuoHan Zhao:
   ui/spice-app: detect runtime directory creation failures
59 181fdf8a7e13 Marc-André Lureau:
   ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
60 027ad866bd29 Pierrick Bouvier:
   target/arm/tcg/translate.c: remove MO_TE usage
61 87e1226e6f68 Marc-André Lureau:
   target/i386: fix strList leak in x86_cpu_get_unavailable_features
62 3eae91a8b93a Simon Scherer:
   target/i386: fix missing PF_INSTR in SIGSEGV context
63 76ad26dd172d Paolo Bonzini:
   target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
64 79bc17718677 Stepan Popov:
   meson: add missing semicolon in pthread_condattr_setclock test
65 30fad722ce68 Alex Bennée:
   hw/display: don't accidentally autofree existing virgl resources
66 d41ce10d0f5a Vladimir Sementsov-Ogievskiy:
   migration: vmstate_save_state_v: fix double error_setg
67 c0306d2b8f45 Thomas Huth:
   hw/misc: Fix the valid access size to the avr-power device
68 3ab47a47d716 Thomas Huth:
   hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
69 654dce6c5236 Matt Turner:
   linux-user/ppc: Fix ppc64 rt_sigframe stack offset
70 029f10e85278 Yixin Wei:
   linux-user: fix off-by-one in host_to_target_for_each_rtattr()
71 93484c768f2b Gyorgy Tamasi:
   linux-user: Don't define target_stat64 struct for loongarch64
72 c8ea1759009a Richard Henderson:
   linux-user/arm/nwfpe: Replace user_registers with current_cpu
73 784f1dde90df Richard Henderson:
   linux-user/arm/nwfpe: Use thread-local storage for qemufpa
74 1730e6f33f97 Alistair Francis:
   linux-user/strace: Use pointer type for read and write values
75 4c681ba3b82d James Hilliard:
   linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
76 8b60ed835478 Helge Deller:
   linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
77 edb4588309a7 Helge Deller:
   linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
78 07c7decaa54a Helge Deller:
   linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
79 b03a6ac6fa5d Helge Deller:
   linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
80 e2af3eadc09b Helge Deller:
   linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
81 9e7734ead149 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
82 4cb2f91773e8 Yicong Yang:
   hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
83 b2e874bfec59 Sebastián Alba Vives:
   target/riscv: fix stale ptshift and base on page walk restart
84 d5b33fc180f5 Sebastián Alba Vives:
   hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
85 14808578ccbc Munkhbaatar Enkhbaatar:
   riscv_htif: reject invalid signature ranges (end <= begin)
86 d107b748072c Alistair Francis:
   target/riscv: Generate access fault if sc comparison fails
87 175afdb0d155 Alistair Francis:
   target/riscv: Don't OR mip.SEIP when mvien is one
88 5dcc64828dc7 Alistair Francis:
   target/riscv: Use ELEN for Fractional LMUL check
89 dcb6e96257ee Helge Deller:
   linux-user: Add missing CDROM ioctls
90 9fb681792d65 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
91 08dc3e240fc0 Helge Deller:
   linux-user: Allow getsockopt() with NULL optval address
92 9667bf324925 Helge Deller:
   linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
93 1aee8067fce9 kiki:
   hw/intc/xics: Add a check for an invalid server id
94 7a05be8c70bb Cédric Le Goater:
   tests/rcutorture: Fix build error
95 ea585b1022f7 BALATON Zoltan:
   hw/ppc/e500: Move clock and TB frequency to machine class
96 774e6f5c1533 Vivien LEGER:
   hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
97 a7f27d6903b3 宋文武:
   hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
98 f35f0f1ca121 liugan1:
   hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
99 41c417290df9 Philippe Mathieu-Daudé:
   target/microblaze: Fix endianness used to disassemble
100 f443b6876362 Peter Maydell:
   target/arm: Report IL=0 for Thumb 16-bit BKPT insn
101 18b664c90085 Peter Maydell:
   hw/misc/bcm2835_rng: Specify valid memory access sizes
102 f252769a23e6 Gerd Hoffmann:
   hw/uefi: fix buffer overruns
103 94d9a8b2c9e6 Gerd Hoffmann:
   hw/uefi: verify pio_xfer_offset before calculating buffer checksum
104 5247b3034c23 Gerd Hoffmann:
   hw/uefi: fix ucs2 string helper functions
105 c45b460d16f9 Gerd Hoffmann:
   hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
106 22b7b222d8f5 Gerd Hoffmann:
   hw/uefi: verify data size before accessing it in wrap_pkcs7
107 b4680c02b8e8 Gerd Hoffmann:
   hw/uefi: avoid possibly unaligned variable_auth_2 struct field access

