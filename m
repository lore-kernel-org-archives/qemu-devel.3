Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC2CC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjHg-0008Vf-2v; Sun, 27 Sep 2026 03:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHR-0008V2-1s; Sun, 27 Sep 2026 03:26:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHN-0005E8-Ul; Sun, 27 Sep 2026 03:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790493983; bh=w0GrSvnFs3xfmauba96pYn3zQjqGQXW4nLcMsOZ03SI=;
 h=From:To:Cc:Subject:Date;
 b=r5kqaKe8bMW4J2pbxYy59s0TOF5qSKAlqWzwQcNR3V/BTECCfW1fIKplnTx54IFaa
 EtqQa0Efaynh2uHysqMUq9nZbRaIpA3LLTS2k2XbPnoFkEKR3bnGcMT/afnSLJlkgb
 jBcGZH5RBpffXDwV3/l/WG1fJZwsXbCbkARRilrIF2rT6ZilvnpVrRYn4PpeYr6I0e
 9mQEGmBpv0FtU3S5a6te8zraJIf0/of5Dg6Nj+ZA4ifkim7Ylyu1/91YGvxhwm8pLz
 YcEyrIw6GHHcSUT0sqvMDoUsE/pnT78+5cuFSHNX/r8sisgZIw3XT+Xzmy/0/OtC4a
 V2r1+oBCwND+w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA75E1D8AB2;
 Sun, 27 Sep 2026 10:26:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8C8B432045;
 Sun, 27 Sep 2026 10:26:22 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BDDAB5E615; Sun, 27 Sep 2026 10:26:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 00/72] Patch Round-up for stable 10.0.14,
 freeze on 2026-09-26 (frozen)
Date: Sun, 27 Sep 2026 10:25:41 +0300
Message-ID: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.14:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-09-26 (frozen), and the release is planned for 2026-09-28:

  https://wiki.qemu.org/Planning/10.0

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
04* 418396be8013 Warisjeet Singh:
   hw/display/vga: fix text-mode OOB write after a graphics surface switch
05* 0846740652d1 Christian Quante:
   hw/input/ps2: answer unknown mouse commands with a resend
06* 2667133c2799 Denis V. Lunev:
   job: keep job paused across overlapping pause requests
07* 438ee08bc97a Denis V. Lunev:
   tests/unit/test-blockjob: cover keeping a job paused while a pause is 
   pending
08* 59ecd8a1ac3f Denis V. Lunev:
   block/monitor: reject persistent bitmap add on a read-only node
09* 3f3f5cdb929e Denis V. Lunev:
   migration/block-dirty-bitmap: reject bitmap load onto ro node
10* 9a77ef813f5f Denis V. Lunev:
   block/monitor: allow dropping a bitmap never stored on disk
11* dc04053687ec Denis V. Lunev:
   dirty-bitmap: fix integer overflow in serialization coverage
12* 569aa6280d14 Nicholas Piggin:
   target/riscv: tt-ascalon: Enable Zkr extension
13* 51362da8f73b Ivan Efremov:
   target/riscv: Fix seed CSR sign extension
14* e80cf2947978 Ivan Efremov:
   tests/qtest: Add seed CSR zero extension test
15* d7913fac7747 Christian Borntraeger:
   s390x/sclp: pv: only copy the original SCCB buffer
16* 6c712a86f6c8 Denis V. Lunev:
   hw/ide: reject an unsupported CHS translation
17* 0905ef5b6d48 Denis V. Lunev:
   tests/qtest/ide-test: cover a CHS translation with zero sectors
18* 0df27c66dc72 Denis V. Lunev:
   hw/ide: report the default CHS translation in IDENTIFY DEVICE
19* d30254aec931 Paolo Bonzini:
   scsi-disk: fix out-of-bound read in WRITE SAME
20* 0f410adf6b0d Paolo Bonzini:
   scsi: hide MODE SELECT block size change behind a quirk
21* d61c8a6fb738 Paolo Bonzini:
   vapic: confine the VAPIC region to 0xc0000..0xe0000
22* cfa6e2c52ca8 Paolo Bonzini:
   i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails
23* f63124af7846 Alexandre Frey:
   target/arm: fix TTA instruction S bit for IDAU-exempt addresses
24* 59716ac3067d Peter Maydell:
   target/arm: Correct reset value of SCTLR for arm926, arm1026
25* c05e01a88581 Peter Maydell:
   target/arm: Make CBZ/CBNZ UNDEF before v6T2
26* 50d6757147db Peter Maydell:
   target/arm: Make IT insn undef when not present
27* 2931a675e9d3 Peter Maydell:
   target/arm: Make Thumb T1 hint space UNDEF before v6T2
28* 10dddf15e294 Bin Meng:
   hw/sd: sdhci: Accept version 4 enable without UHS-I
29* a3de21bfa5d0 Denis V. Lunev:
   io/channel-socket: do not treat a zero length write as an error
30* cd71c2f40a53 Denis V. Lunev:
   io/channel-websock: send an HTTP 400 when the greeting has no space
31* 2295deb48898 Denis V. Lunev:
   io/channel-websock: handle a blocked write during the handshake
32* e867e2047c6c Denis V. Lunev:
   tests/unit: add websock handshake test
33* 7a72a4652a79 Denis V. Lunev:
   io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
34* 0e5718799199 Denis V. Lunev:
   tests/unit: cover blocked IO during the websock handshake
35* 3ece85b53c12 Marc-André Lureau:
   virtio-gpu: disable blob scanouts on mapping cleanup
36* c7254cd584bb Marc-André Lureau:
   virtio-gpu: clear res->blob on mapping cleanup
37* 713e7e85a2b4 Junjie Cao:
   hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
38* f10977073cb4 Zhang Chen:
   qapi/misc: Fix missed query-iothreads items
39* 5d85a09554fb Laurent Vivier:
   hw/net/virtio-net: check packet size before VLAN tag access in 
   receive_filter()
40* 73c3d017ef6a Laurent Vivier:
   hw/net/virtio-net: strip trailing padding when caching RSC segment
41* 15dcee919555 Jia Jia:
   hw/virtio: reject inverted virtio-iommu IOVA ranges
42* fdc3f9a83ddf Michael S. Tsirkin:
   virtio-balloon: fix free-page BH teardown on unrealize
43* 5440b6b5de46 Stefan Hajnoczi:
   virtio-scsi: set dataplane_started to false upon failure
44* 0ddbce88c45a Junjie Cao:
   hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
45* 2c43897356ac Denis V. Lunev:
   hw/display/qxl: hold ssd.lock while replacing ssd.cursor
46* 1063bbb71185 Denis V. Lunev:
   ui/cursor: make the cursor refcount atomic
47* 01df81b24c50 Marc-André Lureau:
   vhost-user-gpu: validate command buffer size in submit_3d
48* 7e5c85f7f2a8 Kostiantyn Kostiuk:
   qga: Change effective user/group ID in guest-ssh-* commands
49* 2a8b740e7acf Bin Guo:
   hw/intc/bcm2835_ic: reject out-of-range FIQ source values
50 9d6ac47d3182 Daniel Henrique Barboza:
   hw/riscv/virt.c: fix aclint soc/mtimer nodename
51 ff96d5629066 Gerd Hoffmann:
   hw/uefi: add missing uefi_str_is_valid check to uefi_vars_mm_lock_variable
52 ebfde6dafff2 wangyang:
   linux-user/riscv: honor zicntr=false for base counterCSRs
53 30fa3eb41f85 Michael Morrell:
   linux-user: implement mlock2(2) syscall
54 e95f53e30be7 SignKirigami:
   linux-user/loongarch64: Detect vector stores in host_signal_write()
55 9b64b3cc833e Omar Elghoul:
   s390x/pci: fix DMA slot leak on I/O TLB entry replacement
56 fe9e30899ffc Christian Schoenebeck:
   hw/9pfs: mutate FID path from main thread only (CVE-2026-93834)
57 cab866376194 Richard Henderson:
   accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
58 f371388029c9 Anton Blanchard:
   accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
59 57d98debdf8a Richard Henderson:
   tcg/riscv64: Set vtype before whole-register vector loads
60 f91b0544fe1f Thomas Huth:
   hw/usb/hcd-xhci: Set reentrancy guard in timer functions (CVE-2026-17588)
61 bfb82d57e729 Junjie Cao:
   hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
62 45684127cdee Junjie Cao:
   hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
63 3c770d72925e Junjie Cao:
   tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
64 1288b0869c08 Junjie Cao:
   tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch
65 cbbd4d74eb29 Shivang Upadhyay:
   target/ppc: Stop vCPU thread before calling parent_unrealize
66 c7cc09c85b89 Simon Scherer:
   target/i386: Fix FXCH to unconditionally clear C1
67 994fb6c218f8 Simon Scherer:
   target/i386: Update FPU tag word for FXTRACT's old ST(0)
68 f2357fdcd984 Simon Scherer:
   target/i386: Update FPU tag word for FSTP
69 a9dbd71f033e Simon Scherer:
   target/i386: Update FPU tag word for FXCH
70 6adc9d9cdc53 Andrey Polivoda:
   target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3
71 460da0e55c31 Richard Henderson:
   accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
72 62728f8c932f Richard Henderson:
   target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC

(commit(s) marked with * were in previous series and are not resent)

