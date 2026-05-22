Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38D2CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXVt-0008Ct-LL; Fri, 22 May 2026 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXVV-00087M-Ue; Fri, 22 May 2026 17:34:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXVR-0007Ut-1Q; Fri, 22 May 2026 17:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485632; bh=Y1dzVZYMfCVlBxKUJ3PCXf2xiN9wgFfaN1QV/64t6gs=;
 h=From:To:Cc:Subject:Date;
 b=PCgK9RgPdsetZmcev9dOfIvN550I4SpwMD3CIIJzxhwwmzZXgGUPlz6YIMHYRL+AA
 RUV01lA8SXknCIbEBtXvVeDyXQK0/tayLYakvHEdKVFKMzQSUeuCceQJvNhQR2QnhV
 KeQPbx7gTesX48GgW6coMV7zlQjBQAd9p+pvmS8wyUJvuS2wOZHsWt6VL/ZGmjeo4w
 OckKURqdIp+KRF0z0SdM7LhsHqmtnW+RJub6d1vXopEJoLMLMZbsC0aJUqkmaP3Hb2
 wj0pB0+kNambzuDt4hXTmUU79PcvD3imfwYNtUISLRgDhwWtnvxkRg1PQJxUj8bfYt
 qziwMGQyP+i0g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B4AF1AFAC9;
 Sat, 23 May 2026 00:33:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C8573B714F;
 Sat, 23 May 2026 00:33:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 v2 00/94] Patch Round-up for stable 11.0.1,
 freeze on 2026-05-22 (frozen)
Date: Sat, 23 May 2026 00:33:15 +0300
Message-ID: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v11.0.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.0

Patch freeze is 2026-05-22, and the release is planned for 2026-05-24:

  https://wiki.qemu.org/Planning/11.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 7437b3eab6af Werner de Carne:
   serial COM: windows serial COM PollingFunc don't sleep
02* 52cf667ed228 GuoHan Zhao:
   ui/spice-app: detect runtime directory creation failures
03* 181fdf8a7e13 Marc-André Lureau:
   ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
04* 027ad866bd29 Pierrick Bouvier:
   target/arm/tcg/translate.c: remove MO_TE usage
05* 87e1226e6f68 Marc-André Lureau:
   target/i386: fix strList leak in x86_cpu_get_unavailable_features
06* 3eae91a8b93a Simon Scherer:
   target/i386: fix missing PF_INSTR in SIGSEGV context
07* c906c2337058 rickgcn:
   hw: i386: vapic: restore IRQ polling for non-kernel irqchip backends
08* 7d6231dfb5ea Magnus Kulke:
   target/i386/mshv: Fix segment regression in MMIO emu
09* 76ad26dd172d Paolo Bonzini:
   target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
10* 79bc17718677 Stepan Popov:
   meson: add missing semicolon in pthread_condattr_setclock test
11* 7077c83f71a7 Anthony Roberts:
   ui/sdl2: Fix assumption of EGL presence at runtime
12* 30fad722ce68 Alex Bennée:
   hw/display: don't accidentally autofree existing virgl resources
13* d41ce10d0f5a Vladimir Sementsov-Ogievskiy:
   migration: vmstate_save_state_v: fix double error_setg
14* 0990cc8b286b Junjie Cao:
   ati-vga: fix unsigned integer overflow in cursor bounds checks
15* c0306d2b8f45 Thomas Huth:
   hw/misc: Fix the valid access size to the avr-power device
16* 3ab47a47d716 Thomas Huth:
   hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
17* 654dce6c5236 Matt Turner:
   linux-user/ppc: Fix ppc64 rt_sigframe stack offset
18* 029f10e85278 Yixin Wei:
   linux-user: fix off-by-one in host_to_target_for_each_rtattr()
19* 93484c768f2b Gyorgy Tamasi:
   linux-user: Don't define target_stat64 struct for loongarch64
20* c8ea1759009a Richard Henderson:
   linux-user/arm/nwfpe: Replace user_registers with current_cpu
21* 784f1dde90df Richard Henderson:
   linux-user/arm/nwfpe: Use thread-local storage for qemufpa
22* 1730e6f33f97 Alistair Francis:
   linux-user/strace: Use pointer type for read and write values
23* 4c681ba3b82d James Hilliard:
   linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
24* 8b60ed835478 Helge Deller:
   linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
25* edb4588309a7 Helge Deller:
   linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
26* 07c7decaa54a Helge Deller:
   linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
27* b03a6ac6fa5d Helge Deller:
   linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
28* e2af3eadc09b Helge Deller:
   linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
29* 9e7734ead149 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
30* b8c2426157f5 Daniel P. Berrangé:
   util: fix use of pthread_get_name_np on OpenBSD
31* 57abf6b1d576 Luc Michel:
   hw/core/register: add register_array_get_owner
32* 4cb2f91773e8 Yicong Yang:
   hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
33* b2e874bfec59 Sebastián Alba Vives:
   target/riscv: fix stale ptshift and base on page walk restart
34* d5b33fc180f5 Sebastián Alba Vives:
   hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
35* 14808578ccbc Munkhbaatar Enkhbaatar:
   riscv_htif: reject invalid signature ranges (end <= begin)
36* d107b748072c Alistair Francis:
   target/riscv: Generate access fault if sc comparison fails
37* 175afdb0d155 Alistair Francis:
   target/riscv: Don't OR mip.SEIP when mvien is one
38* 5dcc64828dc7 Alistair Francis:
   target/riscv: Use ELEN for Fractional LMUL check
39* dcb6e96257ee Helge Deller:
   linux-user: Add missing CDROM ioctls
40* 9fb681792d65 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
41* 08dc3e240fc0 Helge Deller:
   linux-user: Allow getsockopt() with NULL optval address
42* 9667bf324925 Helge Deller:
   linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
43* 1aee8067fce9 kiki:
   hw/intc/xics: Add a check for an invalid server id
44* 774e6f5c1533 Vivien LEGER:
   hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
45* a7f27d6903b3 宋文武:
   hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
46* f35f0f1ca121 liugan1:
   hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
47* f77a7cec9f64 Fabiano Rosas:
   migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
48* 455a6167f254 Peter Xu:
   migration: Fix low possibility downtime violation
49* 41c417290df9 Philippe Mathieu-Daudé:
   target/microblaze: Fix endianness used to disassemble
50* f443b6876362 Peter Maydell:
   target/arm: Report IL=0 for Thumb 16-bit BKPT insn
51* 18b664c90085 Peter Maydell:
   hw/misc/bcm2835_rng: Specify valid memory access sizes
52* f252769a23e6 Gerd Hoffmann:
   hw/uefi: fix buffer overruns
53* 94d9a8b2c9e6 Gerd Hoffmann:
   hw/uefi: verify pio_xfer_offset before calculating buffer checksum
54* 5247b3034c23 Gerd Hoffmann:
   hw/uefi: fix ucs2 string helper functions
55* c45b460d16f9 Gerd Hoffmann:
   hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
56* 22b7b222d8f5 Gerd Hoffmann:
   hw/uefi: verify data size before accessing it in wrap_pkcs7
57* b4680c02b8e8 Gerd Hoffmann:
   hw/uefi: avoid possibly unaligned variable_auth_2 struct field access
58 b33fd8ab1caa Gerd Hoffmann:
   hw/uefi: check auth.hdr_length minimum size
59* b4ec2e8dae4d Fabiano Rosas:
   tests/functional: Make socat wait longer in migration exec test
60 332ea2978780 Jeuk Kim:
   hw/ufs: Validate MCQ SQ references before use
61 283d921e771e Jeuk Kim:
   hw/ufs: Guard MCQ CQ accesses against missing queues
62 4a909c00b9e1 Jeuk Kim:
   hw/ufs: Reject zero-depth MCQ queues
63 619c2da19a05 Jeuk Kim:
   hw/ufs: Keep MCQ SQs alive while requests are outstanding
64 042dbcff8382 Jeuk Kim:
   hw/ufs: Zero reserved bytes in REPORT LUNS response header
65 aefeecb413a8 Peter Maydell:
   hw/display/cirrus_vga: Fix packed-24 color-expansion transparent pattern 
   fills
66 27d14251b904 Peter Maydell:
   hw/display/cirrus_vga: Fix packed-24 color-expansion transparent copies
67 ff36712da5ae Kane Chen:
   hw/misc/aspeed_sbc: Add bounds checking for OTP write operations
68 534a52755bef Cédric Le Goater:
   aspeed/hace: Fix out-of-bounds read in has_padding()
69 c6aa2d0ac161 Cédric Le Goater:
   aspeed/hace: Prevent total_req_len overflow
70 a824f3531a44 Peter Maydell:
   hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
71 6197c11dd5d2 Chad Jablonski:
   ati-vga: fix ati_set_dirty address calculation
72 0129c626503c Peter Maydell:
   tests/qtest/iommu-smmuv3-test: Skip if no TCG GICv3 device present
73 a163fc1f864b Peter Maydell:
   meson.build: Add -fzero-init-padding-bits=all
74 4e8ac6857faa Peter Maydell:
   hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and AArch32
75 039b057c09c6 Peter Maydell:
   tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't 
   exist
76 a86024eb2df5 Scott J. Goldman:
   target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
77 2293d8b4bd88 Klaus Jensen:
   hw/nvme: fix admin cq msix setup
78 6b5aef7cac9d Helge Deller:
   linux-user: Fix AT_EXECFN in AUXV for symlinked programs
79 c3176e645774 Matt Turner:
   linux-user/sh4: Fix target_ucontext tuc_link field type
80 9ac5aa722721 Matt Turner:
   linux-user/sh4: Fix setup_sigtramp to match Linux kernel trampoline 
   pattern
81 d5e4090177ad Kevin Wolf:
   blkdebug: Add 'delay-ns' option
82 34a67637767d Kevin Wolf:
   block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
83 53074ba0330a Kevin Wolf:
   block: Add flags parameter to blk_*_pdiscard()
84 095c08a7ba68 Kevin Wolf:
   ide: Minimal fix for deadlock between TRIM and drain
85 c1c71a7e167f Kevin Wolf:
   ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
86 92854c9c7539 Kevin Wolf:
   ide-test: Factor out wait_dma_completion()
87 2fa24e975599 Kevin Wolf:
   ide-test: Test reset during TRIM
88 a1310cc6281d Kevin Wolf:
   block: Create DEFAULT_BLOCK_CONF macro
89 f27aea189633 Kevin Wolf:
   block: Add more defaults to DEFAULT_BLOCK_CONF
90 f0d9ccd46cf8 Kevin Wolf:
   commit: Drain nodes across all of bdrv_commit()
91 7f8466e2ce62 Kevin Wolf:
   qemu-io: Add 'aio_discard' command
92 b8bfb1478d61 Kevin Wolf:
   qcow2: Fix corruption on discard during write with COW
93 389f5bcc744d Kevin Wolf:
   iotests/046: Test that discard/write_zeroes wait for dependencies
94 e3082ab3b385 Denis V. Lunev:
   block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()

(commit(s) marked with * were in previous series and are not resent)

