Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A94C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmR1-0005pS-IB; Sun, 27 Sep 2026 06:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmQv-0005oW-Dw; Sun, 27 Sep 2026 06:48:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmQk-0000xY-QD; Sun, 27 Sep 2026 06:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506101; bh=PH24OI1D/PQ+nYYhToAHgtqbjXC4ZvD3KwE0YgZEuvM=;
 h=From:To:Cc:Subject:Date;
 b=kRqIIKLAg4aY4Yik+w37cmqINOix4a7jYnwD+E3IMt+i4t/mxLFNsXKbwHieaBoxF
 KlK+5GBFdHqNjsnwlEpUZ/kaK4FKYZhR/eriFclSomIHcmniWaR8qEPEZOmfBjhN2/
 swJUuKrnnIt8Sm4ongiythJoL6bUVeTWBel0XVzS5R0H3rS4JGjEHcs7/ipmQoWuKn
 sq3sPFcvLEFMu9x4wLb/Jb7LCDABx7b5BxTUwvWwBtsx5aNvfXoB+o1ziitC7jXCn9
 ZhZAnJys4TnW6bnEzHO+bqlYey5VHKd9n7S5v+Z//nR7WF7mqChjmgYOuTChhzIZXF
 /yi8vm5j10waw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F9B11D8B57;
 Sun, 27 Sep 2026 13:48:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4A17643215E;
 Sun, 27 Sep 2026 13:48:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2FE495E766; Sun, 27 Sep 2026 13:48:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 00/92] Patch Round-up for stable 11.1.2,
 freeze on 2026-09-26 (frozen)
Date: Sun, 27 Sep 2026 13:47:32 +0300
Message-ID: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v11.1.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.1

Patch freeze is 2026-09-26 (frozen), and the release is planned for 2026-09-28:

  https://wiki.qemu.org/Planning/11.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* ab7183ed4eec Marc-André Lureau:
   hw/display/qxl: validate primary surface stride against width
02* eb2b3a1fa807 Marc-André Lureau:
   virtio-gpu: use g_try_malloc to avoid guest-triggered abort
03* 0e62034ca10f Marc-André Lureau:
   crypto: fix build against nettle >= 4
04* ddf5738503e2 Fabiano Rosas:
   chardev: Don't unregister yank upon async path connection failure
05* 418396be8013 Warisjeet Singh:
   hw/display/vga: fix text-mode OOB write after a graphics surface switch
06* 0846740652d1 Christian Quante:
   hw/input/ps2: answer unknown mouse commands with a resend
07* 2667133c2799 Denis V. Lunev:
   job: keep job paused across overlapping pause requests
08* 438ee08bc97a Denis V. Lunev:
   tests/unit/test-blockjob: cover keeping a job paused while a pause is 
   pending
09* 59ecd8a1ac3f Denis V. Lunev:
   block/monitor: reject persistent bitmap add on a read-only node
10* 3f3f5cdb929e Denis V. Lunev:
   migration/block-dirty-bitmap: reject bitmap load onto ro node
11* 9a77ef813f5f Denis V. Lunev:
   block/monitor: allow dropping a bitmap never stored on disk
12* dc04053687ec Denis V. Lunev:
   dirty-bitmap: fix integer overflow in serialization coverage
13* d7913fac7747 Christian Borntraeger:
   s390x/sclp: pv: only copy the original SCCB buffer
14* 6c712a86f6c8 Denis V. Lunev:
   hw/ide: reject an unsupported CHS translation
15* 0905ef5b6d48 Denis V. Lunev:
   tests/qtest/ide-test: cover a CHS translation with zero sectors
16* 0df27c66dc72 Denis V. Lunev:
   hw/ide: report the default CHS translation in IDENTIFY DEVICE
17* 7df9aa5f6d60 Xie Bo:
   target/riscv/kvm: Synchronize privilege mode
18* ddac7cfb00ad Xie Bo:
   target/riscv/kvm: Preserve MP state across migration
19* d30254aec931 Paolo Bonzini:
   scsi-disk: fix out-of-bound read in WRITE SAME
20* 0f410adf6b0d Paolo Bonzini:
   scsi: hide MODE SELECT block size change behind a quirk
21* d61c8a6fb738 Paolo Bonzini:
   vapic: confine the VAPIC region to 0xc0000..0xe0000
22* cfa6e2c52ca8 Paolo Bonzini:
   i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails
23* b78c6d5b1bf0 Gautam Menghani:
   ppc/xive: Trigger the pending interrupt for a guest after migration
24* f63124af7846 Alexandre Frey:
   target/arm: fix TTA instruction S bit for IDAU-exempt addresses
25* 59716ac3067d Peter Maydell:
   target/arm: Correct reset value of SCTLR for arm926, arm1026
26* c05e01a88581 Peter Maydell:
   target/arm: Make CBZ/CBNZ UNDEF before v6T2
27* 50d6757147db Peter Maydell:
   target/arm: Make IT insn undef when not present
28* 2931a675e9d3 Peter Maydell:
   target/arm: Make Thumb T1 hint space UNDEF before v6T2
29* 10dddf15e294 Bin Meng:
   hw/sd: sdhci: Accept version 4 enable without UHS-I
30* 15d4bc75f817 Alberto Garcia:
   hw/sd/sdcard: Register device ops in drives without media
31* 259b877eac36 Junjie Cao:
   hw/cxl: fix timer leak in cxl_destroy_cci()
32* dd9641cb140d Bibo Mao:
   target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
33* a3de21bfa5d0 Denis V. Lunev:
   io/channel-socket: do not treat a zero length write as an error
34* cd71c2f40a53 Denis V. Lunev:
   io/channel-websock: send an HTTP 400 when the greeting has no space
35* 2295deb48898 Denis V. Lunev:
   io/channel-websock: handle a blocked write during the handshake
36* e867e2047c6c Denis V. Lunev:
   tests/unit: add websock handshake test
37* 7a72a4652a79 Denis V. Lunev:
   io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
38* 0e5718799199 Denis V. Lunev:
   tests/unit: cover blocked IO during the websock handshake
39* c7254cd584bb Marc-André Lureau:
   virtio-gpu: clear res->blob on mapping cleanup
40* 713e7e85a2b4 Junjie Cao:
   hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
41* f10977073cb4 Zhang Chen:
   qapi/misc: Fix missed query-iothreads items
42* 5d85a09554fb Laurent Vivier:
   hw/net/virtio-net: check packet size before VLAN tag access in 
   receive_filter()
43* 73c3d017ef6a Laurent Vivier:
   hw/net/virtio-net: strip trailing padding when caching RSC segment
44* 15dcee919555 Jia Jia:
   hw/virtio: reject inverted virtio-iommu IOVA ranges
45* fdc3f9a83ddf Michael S. Tsirkin:
   virtio-balloon: fix free-page BH teardown on unrealize
46* 5440b6b5de46 Stefan Hajnoczi:
   virtio-scsi: set dataplane_started to false upon failure
47* 0ddbce88c45a Junjie Cao:
   hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
48* 2c43897356ac Denis V. Lunev:
   hw/display/qxl: hold ssd.lock while replacing ssd.cursor
49* 1063bbb71185 Denis V. Lunev:
   ui/cursor: make the cursor refcount atomic
50* 01df81b24c50 Marc-André Lureau:
   vhost-user-gpu: validate command buffer size in submit_3d
51* 7e5c85f7f2a8 Kostiantyn Kostiuk:
   qga: Change effective user/group ID in guest-ssh-* commands
52* 2a8b740e7acf Bin Guo:
   hw/intc/bcm2835_ic: reject out-of-range FIQ source values
53* 6ae0b0426705 Doug Cook:
   target/arm/whpx: Don't try to sync ARM_CP_CONST registers
54* 518f45b32d04 Doug Cook:
   target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
55* 57197bf183f3 Doug Cook:
   target/arm/whpx: fix whpx-arm post-reset CPU state
56* 99fb8e570e54 Showta Ishizaki:
   target/arm/hvf: implement MDCCSR_EL0 as RAZ
57 9d6ac47d3182 Daniel Henrique Barboza:
   hw/riscv/virt.c: fix aclint soc/mtimer nodename
58 1d3e5a4b37fb Bibo Mao:
   target/loongarch: Fix data race in CSR_ESTAT
59 ff96d5629066 Gerd Hoffmann:
   hw/uefi: add missing uefi_str_is_valid check to uefi_vars_mm_lock_variable
60 d9275e776e95 Luigi Leonardi:
   igvm: validate and honor byte_offset in parameter directives
61 f277592cfdbe Luigi Leonardi:
   igvm: mark qigvm_find_param_entry as static
62 666dd3c9b10a Cam Miller:
   system/ram-discard-manager: fix offset_within_address_space in 
   replay_by_populated_state()
63 ebfde6dafff2 wangyang:
   linux-user/riscv: honor zicntr=false for base counterCSRs
64 5089493e45d3 wangyang:
   linux-user/riscv: invalidate reservations after stores
65 30fa3eb41f85 Michael Morrell:
   linux-user: implement mlock2(2) syscall
66 e95f53e30be7 SignKirigami:
   linux-user/loongarch64: Detect vector stores in host_signal_write()
67 8435aadbb9ad Jared Rossi:
   hw/s390x/ipl: Fix incorrect PCI IPL block lengths
68 9b64b3cc833e Omar Elghoul:
   s390x/pci: fix DMA slot leak on I/O TLB entry replacement
69 fe9e30899ffc Christian Schoenebeck:
   hw/9pfs: mutate FID path from main thread only (CVE-2026-93834)
70 cab866376194 Richard Henderson:
   accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
71 f371388029c9 Anton Blanchard:
   accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
72 e2ef4fc38ceb Richard Henderson:
   tcg/optimize: Fix fold_multiply2 vs 1
73 4278a7ba36c2 Richard Henderson:
   tests/tcg/arm: Add regression test for #4448
74 0bc331d1c7d5 Richard Henderson:
   tcg/optimize: Fix expansion/simplification of deposit
75 c66fe5b04d64 Richard Henderson:
   tests/tcg/s390x: Add regression test for #4449
76 57d98debdf8a Richard Henderson:
   tcg/riscv64: Set vtype before whole-register vector loads
77 f91b0544fe1f Thomas Huth:
   hw/usb/hcd-xhci: Set reentrancy guard in timer functions (CVE-2026-17588)
78 bfb82d57e729 Junjie Cao:
   hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
79 45684127cdee Junjie Cao:
   hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
80 3c770d72925e Junjie Cao:
   tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
81 1288b0869c08 Junjie Cao:
   tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch
82 cbbd4d74eb29 Shivang Upadhyay:
   target/ppc: Stop vCPU thread before calling parent_unrealize
83 c7cc09c85b89 Simon Scherer:
   target/i386: Fix FXCH to unconditionally clear C1
84 994fb6c218f8 Simon Scherer:
   target/i386: Update FPU tag word for FXTRACT's old ST(0)
85 f2357fdcd984 Simon Scherer:
   target/i386: Update FPU tag word for FSTP
86 a9dbd71f033e Simon Scherer:
   target/i386: Update FPU tag word for FXCH
87 6adc9d9cdc53 Andrey Polivoda:
   target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3
88 170dfd8d1f86 Matt Turner:
   linux-user/sh4: use the kernel's sigreturn trampoline sequence in the vdso
89 5c98e72e6aae Matt Turner:
   linux-user/sh4: fix vdso CFA for rt_sigreturn frames
90 95e14595d398 Matt Turner:
   linux-user/sh4: align the vdso sigreturn trampolines
91 460da0e55c31 Richard Henderson:
   accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
92 62728f8c932f Richard Henderson:
   target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC

(commit(s) marked with * were in previous series and are not resent)

