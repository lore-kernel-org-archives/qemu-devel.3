Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B88C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZ4f-0000fB-3V; Tue, 29 Sep 2026 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBZ4c-0000ek-NO; Tue, 29 Sep 2026 10:44:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBZ4a-0003Jx-8G; Tue, 29 Sep 2026 10:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790693075; bh=tU2yEw60spqgHaWztDI/Y/OyYK+VHiV3+OUw8X43jAY=;
 h=From:To:Cc:Subject:Date;
 b=IO4rmyrr0wa8a2onh3nZgA4iU2dyga8AOrsOiQnqKxgx4ZfRRNhB6x6O+6Ru60D3l
 IXgjfoFUcQ/hLrIXEpkk3LYSCU93OTjme4/jlyrHoIghvoKu7+g7G9gEdsTtHsYhop
 X/ubaqYuSkLHqeYFzDJXq0/3+r4020435sh+WPPJf6SSwn33S5O8cGYF+fbDBtLHFZ
 wzUUTe38ACecZpX+z8u/qaJFDibj7ONgSXozA/XVFxNpBlOHpJd7VDcNli3Kd13Xr5
 e1BOPpbc51p4l8sGbb95fA5ziM/RCMu6KA3zFApFNARF8CAz1Zjk5dYpdDzHAAAvZd
 7o6yenmI2/LkQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE8711D97D8;
 Tue, 29 Sep 2026 17:44:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A9171434FAC;
 Tue, 29 Sep 2026 17:44:35 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9305572D3F; Tue, 29 Sep 2026 17:44:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 10.0.14 Stable released
Date: Tue, 29 Sep 2026 17:44:29 +0300
Message-ID: <20260929144433.126636-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi everyone,

The QEMU v10.0.14 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.14.tar.xz
  https://download.qemu.org/qemu-10.0.14.tar.xz.sig (signature)

v10.0.14 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 72 changes since the previous v10.0.13 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

4cf887f340e Michael Tokarev:
 Update version for 10.0.14 release
5b691bef8b3 62728f8c93 Richard Henderson:
 target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC
33602fcf707 460da0e55c Richard Henderson:
 accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
aa1efcc34a3 6adc9d9cdc Andrey Polivoda:
 target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3
88033080bb4 a9dbd71f03 Simon Scherer:
 target/i386: Update FPU tag word for FXCH
7e8f7e26595 f2357fdcd9 Simon Scherer:
 target/i386: Update FPU tag word for FSTP
e45273954e0 994fb6c218 Simon Scherer:
 target/i386: Update FPU tag word for FXTRACT's old ST(0)
f65eb33ecb4 c7cc09c85b Simon Scherer:
 target/i386: Fix FXCH to unconditionally clear C1
2d1215405fd cbbd4d74eb Shivang Upadhyay:
 target/ppc: Stop vCPU thread before calling parent_unrealize
eff846ffb9f 1288b0869c Junjie Cao:
 tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch
17b0f93f625 3c770d7292 Junjie Cao:
 tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
4a8e99cddab 45684127cd Junjie Cao:
 hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
cccddba9808 bfb82d57e7 Junjie Cao:
 hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
1622c9abec1 f91b0544fe Thomas Huth:
 hw/usb/hcd-xhci: Set reentrancy guard in timer functions (CVE-2026-17588)
5240dbca410 57d98debdf Richard Henderson:
 tcg/riscv64: Set vtype before whole-register vector loads
08beef369cd f371388029 Anton Blanchard:
 accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
d00f1e7f985 cab8663761 Richard Henderson:
 accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
d27cd8d5a1c fe9e30899f Christian Schoenebeck:
 hw/9pfs: mutate FID path from main thread only (CVE-2026-93834)
9ff7a593a10 9b64b3cc83 Omar Elghoul:
 s390x/pci: fix DMA slot leak on I/O TLB entry replacement
a248a6fd3a3 e95f53e30b SignKirigami:
 linux-user/loongarch64: Detect vector stores in host_signal_write()
c88adf28967 30fa3eb41f Michael Morrell:
 linux-user: implement mlock2(2) syscall
c87eedc5d7e ebfde6daff wangyang:
 linux-user/riscv: honor zicntr�lse for base counterCSRs
5fe06d875df ff96d56290 Gerd Hoffmann:
 hw/uefi: add missing uefi_str_is_valid check to uefi_vars_mm_lock_variable
99800c3edc0 9d6ac47d31 Daniel Henrique Barboza:
 hw/riscv/virt.c: fix aclint soc/mtimer nodename
df011b98733 2a8b740e7a Bin Guo:
 hw/intc/bcm2835_ic: reject out-of-range FIQ source values
332ab334bc6 7e5c85f7f2 Kostiantyn Kostiuk:
 qga: Change effective user/group ID in guest-ssh-* commands
305ade8a1c0 01df81b24c Marc-André Lureau:
 vhost-user-gpu: validate command buffer size in submit_3d
31578ed93f8 1063bbb711 Denis V. Lunev:
 ui/cursor: make the cursor refcount atomic
fcea6a65e1f 2c43897356 Denis V. Lunev:
 hw/display/qxl: hold ssd.lock while replacing ssd.cursor
ef04c75d314 0ddbce88c4 Junjie Cao:
 hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
e90b8fbf6d8 5440b6b5de Stefan Hajnoczi:
 virtio-scsi: set dataplane_started to false upon failure
be1244c4239 fdc3f9a83d Michael S. Tsirkin:
 virtio-balloon: fix free-page BH teardown on unrealize
731853c31ee 15dcee9195 Jia Jia:
 hw/virtio: reject inverted virtio-iommu IOVA ranges
cc48e48a3a3 73c3d017ef Laurent Vivier:
 hw/net/virtio-net: strip trailing padding when caching RSC segment
0b193fea526 5d85a09554 Laurent Vivier:
 hw/net/virtio-net: check packet size before VLAN tag access in receive_filter()
e19a771ba75 f10977073c Zhang Chen:
 qapi/misc: Fix missed query-iothreads items
38d75047060 713e7e85a2 Junjie Cao:
 hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
4bcc4c58a6c c7254cd584 Marc-André Lureau:
 virtio-gpu: clear res->blob on mapping cleanup
8eebc546bbd 3ece85b53c Marc-André Lureau:
 virtio-gpu: disable blob scanouts on mapping cleanup
1998111f111 0e57187991 Denis V. Lunev:
 tests/unit: cover blocked IO during the websock handshake
316989d81e9 7a72a4652a Denis V. Lunev:
 io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
833d5a50360 e867e2047c Denis V. Lunev:
 tests/unit: add websock handshake test
d95c50ff7a0 2295deb488 Denis V. Lunev:
 io/channel-websock: handle a blocked write during the handshake
ade3c1a1000 cd71c2f40a Denis V. Lunev:
 io/channel-websock: send an HTTP 400 when the greeting has no space
f86e368f256 a3de21bfa5 Denis V. Lunev:
 io/channel-socket: do not treat a zero length write as an error
beeadf39ed0 10dddf15e2 Bin Meng:
 hw/sd: sdhci: Accept version 4 enable without UHS-I
2153d22983b 2931a675e9 Peter Maydell:
 target/arm: Make Thumb T1 hint space UNDEF before v6T2
67600905969 50d6757147 Peter Maydell:
 target/arm: Make IT insn undef when not present
8060d7e4ac7 c05e01a885 Peter Maydell:
 target/arm: Make CBZ/CBNZ UNDEF before v6T2
9cfc4597f5c 59716ac306 Peter Maydell:
 target/arm: Correct reset value of SCTLR for arm926, arm1026
b605da7ddd8 f63124af78 Alexandre Frey:
 target/arm: fix TTA instruction S bit for IDAU-exempt addresses
7f134f63be0 cfa6e2c52c Paolo Bonzini:
 i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails
c9cfa87402c d61c8a6fb7 Paolo Bonzini:
 vapic: confine the VAPIC region to 0xc0000..0xe0000
60f71663dd0 0f410adf6b Paolo Bonzini:
 scsi: hide MODE SELECT block size change behind a quirk
6bbb24ce21a d30254aec9 Paolo Bonzini:
 scsi-disk: fix out-of-bound read in WRITE SAME
40858bc3d38 0df27c66dc Denis V. Lunev:
 hw/ide: report the default CHS translation in IDENTIFY DEVICE
25d53f2812b 0905ef5b6d Denis V. Lunev:
 tests/qtest/ide-test: cover a CHS translation with zero sectors
0922a862087 6c712a86f6 Denis V. Lunev:
 hw/ide: reject an unsupported CHS translation
4dee22592ab d7913fac77 Christian Borntraeger:
 s390x/sclp: pv: only copy the original SCCB buffer
560839bbf5f e80cf29479 Ivan Efremov:
 tests/qtest: Add seed CSR zero extension test
9016dea77ad 51362da8f7 Ivan Efremov:
 target/riscv: Fix seed CSR sign extension
b836e9697d8 569aa6280d Nicholas Piggin:
 target/riscv: tt-ascalon: Enable Zkr extension
1cdd3f73f6a dc04053687 Denis V. Lunev:
 dirty-bitmap: fix integer overflow in serialization coverage
32a122cec60 9a77ef813f Denis V. Lunev:
 block/monitor: allow dropping a bitmap never stored on disk
49c8abbb886 3f3f5cdb92 Denis V. Lunev:
 migration/block-dirty-bitmap: reject bitmap load onto ro node
eae97b7b8e4 59ecd8a1ac Denis V. Lunev:
 block/monitor: reject persistent bitmap add on a read-only node
716ef96e8ae 438ee08bc9 Denis V. Lunev:
 tests/unit/test-blockjob: cover keeping a job paused while a pause is pending
4b862e13708 2667133c27 Denis V. Lunev:
 job: keep job paused across overlapping pause requests
959c77a714c 0846740652 Christian Quante:
 hw/input/ps2: answer unknown mouse commands with a resend
93186168536 418396be80 Warisjeet Singh:
 hw/display/vga: fix text-mode OOB write after a graphics surface switch
5e990a39498 0e62034ca1 Marc-André Lureau:
 crypto: fix build against nettle >= 4
728584b13e9 eb2b3a1fa8 Marc-André Lureau:
 virtio-gpu: use g_try_malloc to avoid guest-triggered abort
e6d0120e039 ab7183ed4e Marc-André Lureau:
 hw/display/qxl: validate primary surface stride against width


