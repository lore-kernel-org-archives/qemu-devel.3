Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1EAC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 21:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifj9-0001Lx-Pj; Sat, 11 Jul 2026 17:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifj7-0001LL-6J; Sat, 11 Jul 2026 17:59:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifj4-0007l4-8R; Sat, 11 Jul 2026 17:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807134; bh=6jP/+r6z61JAvFP37s/QcbBHw1INJ/nc++bKr8qk9lA=;
 h=From:To:Cc:Subject:Date;
 b=GakUuWAgTq4c67X6lu3LH5Zbm0Hlc1xh09uqEOlcB1pek8qeuL3NPX0m3qxhRweq5
 A+U7WqVNHl2CNVBv2RTiPEwnLPIOw+yWuRd7HQLPPvlQSMtpb6tEQNbhI8sX3tLROm
 oYBipns0jWq+voqwlDQd+NXDc+nSsMrmYrNz1+A4IgdatFgPmDRcEd6mrn3JeOQF6N
 rnUKeHpGK2n3RTHOEkkzBfHFpvtZzXQozQfeKkvsxll5IxAZcUfaPlyxdAtQSRzuGY
 T+hyImfRV+R8D+HQ+kU1bx83bC8QdQJ7yDEWF6MS1QIuyBj7ITc34xWpttfEgWxSQB
 NIi96FRs6kFkg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 75ECC1C0A8A;
 Sun, 12 Jul 2026 00:58:54 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 27A8C3EAF16;
 Sun, 12 Jul 2026 00:59:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9C9D1132E3; Sun, 12 Jul 2026 00:59:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 00/81] Patch Round-up for stable 11.0.3,
 freeze on 2026-07-22
Date: Sun, 12 Jul 2026 00:57:38 +0300
Message-ID: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

The following patches are queued for QEMU stable v11.0.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.0

Patch freeze is 2026-07-22, and the release is planned for 2026-07-24:

  https://wiki.qemu.org/Planning/11.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 eef29e060dcc Emmanuel Blot:
   meson: build macOS signed binary as part of the default target
02 27f6d5ba9c97 Marc-André Lureau:
   ui/gtk: fix bad widget realize on non-GFX VC
03 a57e4612b61d Christian Borntraeger:
   s390x/kvm: clamp stsi 3.2.2 size
04 a1c0e5a73740 Christian Schoenebeck:
   hw/9pfs: add msize_limit transport callback
05 4a1a2fa4d351 Christian Schoenebeck:
   9pfs/virtio: implement msize_limit callback
06 815d1799c3d3 Christian Schoenebeck:
   9pfs/xen: implement msize_limit callback
07 bb5ab96e35a1 Christian Schoenebeck:
   hw/9pfs: cap negotiated msize to transport limit
08 4b615eaa1be4 Christian Schoenebeck:
   hw/9pfs: add response_buffer_size transport callback
09 12bcbdca8ae9 Christian Schoenebeck:
   9pfs/virtio: implement response_buffer_size callback
10 69c8f5e6946f Christian Schoenebeck:
   9pfs/xen: implement response_buffer_size callback
11 64c6c7e0df72 Christian Schoenebeck:
   hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
12 693b296b176d Christian Schoenebeck:
   hw/9pfs: add xattr FID limit to prevent memory exhaustion
13 e6116a81f04c Christian Schoenebeck:
   hw/9pfs: add max_xattr option
14 44cb540d2d07 Christian Schoenebeck:
   qemu-options: document 9pfs max_xattr option
15 54b8f64c422d Christian Schoenebeck:
   tests/9p: add Tread / Rread test client functions
16 c46150530b3d Christian Schoenebeck:
   tests/9p: add Tclunk / Rclunk test client functions
17 7664feb26fef Christian Schoenebeck:
   tests/9p: add Txattrcreate / Rxattrcreate test client functions
18 0e3085ddc7fb Christian Schoenebeck:
   hw/9pfs: enable xattr (mockup) support for synth fs driver
19 7e42d569a68a Christian Schoenebeck:
   hw/9pfs: add xattr count query interface to fs synth driver
20 df8825554366 Christian Schoenebeck:
   tests/9p: increase P9_MAX_SIZE for test client
21 84525ece6817 Christian Schoenebeck:
   tests/9p: add virtio_9p_add_synth_driver_args() test client function
22 0e1085819e44 Christian Schoenebeck:
   tests/9p: add 3 xattr FID limit test cases (synth fs driver)
23 04a62cdfe873 Christian Schoenebeck:
   tests/9p: add 3 xattr FID limit test cases (local fs driver)
24 32cae47c332f Christian Schoenebeck:
   hw/9pfs: fix invalid union access by v9fs_co_fsync()
25 c3aa2491cd2c Christian Schoenebeck:
   hw/9pfs: fix invalid union access by v9fs_co_fstat()
26 75893c058b21 Christian Schoenebeck:
   hw/9pfs/local: harden local_fid_fd() on FID types
27 fa2cf7488379 Inochi Amaoto:
   target/riscv: Check PMP before updating PTE
28 fdfcd98f6656 Qingwei Hu:
   hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
29 46d96da13098 ZhengXiang Qin:
   target/riscv: avoid abort when reading vtype before env->xl is set
30 dcd028517749 SeungJu Cheon:
   target/riscv: Apply UXL WARL handling to vsstatus
31 64ce9ac18757 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
32 36b37f849480 Laurent Vivier:
   hw/char/virtio-serial-bus: fix guest-triggerable OOM in control_out()
33 32a90850e1e4 Junjie Cao:
   virtio-net: validate RSS indirections_len in post_load
34 bc22c7e4187a Feifan Qian:
   hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
35 d77a93ca4b53 Oliver Upton:
   target/arm: Only evaluate SCR_EL3.PIEN if ARM_FEATURE_EL3 is present
36 62b425bec3d5 Alex Bennée:
   hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
37 ec917cd49918 Jesper Wendel Devantier:
   hw/nvme: fix FDP set FDP events
38 034baf047fe1 Keith Busch:
   hw/nvme: ensure sgl forward progress
39 d88cd8f5570f Christian Borntraeger:
   s390x/sclp: reject invalid write event data headers
40 2d709a70c757 Matthew Rosato:
   s390x/pci: Tighten region detection for BAR read/write
41 b8c8ec1d7526 Matthew Rosato:
   s390x/pci: Shrink RPCIT ranges to registered window
42 386268daea86 Matthew Rosato:
   s390x/ioinst: Require strict length and format for SEI CHSC handler
43 22f2da06a8b2 Eric Farman:
   s390x/css: limit number of CHPIDs in description
44 e819c126a8d9 Miao Wang:
   target/loongarch: Enable TARGET_PAGE_BITS_VARY for loongarch64 user-only
45 42f599172ae0 Torin Carey:
   hw/misc/edu: restrict dma access to dma buffer
46 3565faa0ace1 Junjie Cao:
   hw/display/ati: reset host_data.next in write handler after flush
47 90f8e5c30767 Junjie Cao:
   hw/display/ati: guard against zero bpp in ati_host_data_flush
48 d9f78431d8eb Denis V. Lunev:
   hw/ide/ahci: cancel in-flight buffered reads on command engine restart
49 cb7bc10385f3 Denis V. Lunev:
   tests/qtest/ahci: test ATAPI read completing after engine restart
50 03071f99a3e1 Peter Maydell:
   hw/dma/i8257: Return zeroes for read_memory in verify mode
51 831a13665ab1 Peter Maydell:
   hw/scsi/mptsas: Reset doorbell state on reset
52 0e51b71c7b77 Thomas Huth:
   hw/display/qxl: Fix mono cursor validation that can read past a cursor 
   chunk
53 dbc0ed562230 no92:
   intel_iommu: Correctly set pt bit in extended capability register
54 e03463812e74 lizhaoxin04:
   vdpa: fix use-after-free of vqs in vhost_vdpa_device_unrealize
55 8addbdb793b7 Nathan Chen:
   hw/arm/smmuv3: Update ATC invalidation check
56 7913b3b9463f hemanshu.khilari.foss:
   hw/core/qdev-clock: Fix potential null pointer dereference
57 15c57ac351cc Stefan Hajnoczi:
   scsi: adjust error_prepend() formatting
58 15a202656cd5 Stefan Hajnoczi:
   scsi: always send valid PREEMPT TYPE field
59 b9a3b329d09d Stefan Hajnoczi:
   scsi: register again after PREEMPT without reservation
60 9e41b5d22aeb Sanjeeva Yerrapureddy:
   hw/net: fix e1000e/igb ip_len inflation by Ethernet minimum-frame padding
61 b79a9b6e5b56 Richard Henderson:
   accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only plugins
62 e03b7dac65d9 Ilya Leoshkevich:
   accel/tcg: Make PageFlagsNodes' start and last immutable
63 c56ebd64b82a Richard Henderson:
   tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
64 614a52cf549e Randy Schifflin:
   target/sh4: fixup tcg for sh4 fipr/ftrv instructions
65 4952681a5fdc yujun:
   crypto/x509-utils: fix gnutls error code in crt_init failure path
66 90aacd5bc405 Jia Jia:
   hw/ufs: avoid double unref of wrapped scsi-hd
67 b18e3f0e2d0f Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
68 c1d5ec3a2f4b Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: check for reserved PTE bits
69 b795ea0ba471 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
70 9158c900ab30 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
71 11486349ad9b Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
72 58e801f74e6a Daniel Henrique Barboza:
   hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
73 bf274c54295c Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
74 79616dd6e499 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
75 6d2b9d542fe2 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
76 ca7bac51e04f Chengbo Gao:
   hw/riscv/riscv-iommu: Avoid caching PCI device IDs
77 ce7fb3282756 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()
78 c7e61854544b Alistair Francis:
   hw/pci/pcie_doe: Check mailbox length for overflows
79 18a522099090 Heinrich Schuchardt:
   tests: allow differences in SPCR
80 15c73b0f17d2 Heinrich Schuchardt:
   hw/acpi: correct field sequence in SPCR table
81 ec7d32428757 Heinrich Schuchardt:
   tests: update SPCR loongarch64 and riscv64 test data

