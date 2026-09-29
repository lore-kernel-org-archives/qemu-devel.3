Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA253CA5FB2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZ5V-00017t-1g; Tue, 29 Sep 2026 10:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBZ5O-00014N-7z; Tue, 29 Sep 2026 10:45:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBZ5H-0003Zr-Bx; Tue, 29 Sep 2026 10:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790693107; bh=6NQsQMcWuJPTE1p1ppzrULQnYIjU9IBZmlVfQJaJaMg=;
 h=From:To:Cc:Subject:Date;
 b=pr02qysB7m8EBxBVSEeEmhmi6MEcLzYz0gIuVqRVHJxpYd3REhsXJi4iVnB1g1/So
 Lwo8f/x+v70oAe4GFkE4kOexx/cqhGshb5j8q8QWwMbBJuePWY3IWjlRaMIqVmxBp/
 hK2FkbA/Rj5V6nAsowjlSg2z0PQpUdtbf69kROawut7yOjELTSrgtCc1gNZ3fZa1E3
 R+14B6F/SHImn6T3NyrGkipD+FlrOh9bEkb3kyfjYdusEDPs3J9SOjLHAl7I1+NQlF
 zSDTNgzkZKHP9Kx6Caz2640Htk2sxm3bY1s20PUoj4zpn5UEZ97fAB0VJoMP/wFDTX
 Iak28+2yi+9QQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8F471D97DE;
 Tue, 29 Sep 2026 17:45:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D63CE434FB1;
 Tue, 29 Sep 2026 17:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CD82F72D41; Tue, 29 Sep 2026 17:45:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 11.0.5 Stable released
Date: Tue, 29 Sep 2026 17:45:06 +0300
Message-ID: <20260929144507.126710-1-mjt@tls.msk.ru>
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

The QEMU v11.0.5 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.0.5.tar.xz
  https://download.qemu.org/qemu-11.0.5.tar.xz.sig (signature)

v11.0.5 is now tagged in the official qemu.git repository, and the
stable-11.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.0

There are 86 changes since the previous v11.0.4 release.

This is supposed to be the last release in 11.0.x series.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.0-hash master-hash Author Name: Commmit-Subject):

19def23adfc Michael Tokarev:
 Update version for 11.0.5 release
23c269eecde 62728f8c93 Richard Henderson:
 target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC
3b366575e41 460da0e55c Richard Henderson:
 accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
8fc432211ff 6adc9d9cdc Andrey Polivoda:
 target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3
a370c22dd28 a9dbd71f03 Simon Scherer:
 target/i386: Update FPU tag word for FXCH
31d5a11d304 f2357fdcd9 Simon Scherer:
 target/i386: Update FPU tag word for FSTP
d2aeaa5773c 994fb6c218 Simon Scherer:
 target/i386: Update FPU tag word for FXTRACT's old ST(0)
f3b1d788441 c7cc09c85b Simon Scherer:
 target/i386: Fix FXCH to unconditionally clear C1
7068db052e0 cbbd4d74eb Shivang Upadhyay:
 target/ppc: Stop vCPU thread before calling parent_unrealize
07aedeab2d7 1288b0869c Junjie Cao:
 tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch
48a981d837e 3c770d7292 Junjie Cao:
 tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
e45ae574d00 45684127cd Junjie Cao:
 hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
c18d951793f bfb82d57e7 Junjie Cao:
 hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
f606b3de595 f91b0544fe Thomas Huth:
 hw/usb/hcd-xhci: Set reentrancy guard in timer functions (CVE-2026-17588)
0db02fe6055 57d98debdf Richard Henderson:
 tcg/riscv64: Set vtype before whole-register vector loads
14a1d9f7b2c c66fe5b04d Richard Henderson:
 tests/tcg/s390x: Add regression test for #4449
829f85cfc64 0bc331d1c7 Richard Henderson:
 tcg/optimize: Fix expansion/simplification of deposit
a318391bbbf f371388029 Anton Blanchard:
 accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
d160a62e53b cab8663761 Richard Henderson:
 accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
b33ac6d42f0 fe9e30899f Christian Schoenebeck:
 hw/9pfs: mutate FID path from main thread only (CVE-2026-93834)
b3ffb55c727 9b64b3cc83 Omar Elghoul:
 s390x/pci: fix DMA slot leak on I/O TLB entry replacement
0c638ecad2b 8435aadbb9 Jared Rossi:
 hw/s390x/ipl: Fix incorrect PCI IPL block lengths
da235bd3bd6 e95f53e30b SignKirigami:
 linux-user/loongarch64: Detect vector stores in host_signal_write()
68dec6ff693 30fa3eb41f Michael Morrell:
 linux-user: implement mlock2(2) syscall
690bea39279 ebfde6daff wangyang:
 linux-user/riscv: honor zicntr�lse for base counterCSRs
b6eff99aeb2 f277592cfd Luigi Leonardi:
 igvm: mark qigvm_find_param_entry as static
1c5b419fa7e d9275e776e Luigi Leonardi:
 igvm: validate and honor byte_offset in parameter directives
9621bd619fd 4d3b9dc4d1 Luigi Leonardi:
 igvm: Report error on missing parameter area in directive handlers
cda3057401a ff96d56290 Gerd Hoffmann:
 hw/uefi: add missing uefi_str_is_valid check to uefi_vars_mm_lock_variable
fc8247f520d 9d6ac47d31 Daniel Henrique Barboza:
 hw/riscv/virt.c: fix aclint soc/mtimer nodename
a4f83debce2 57197bf183 Doug Cook:
 target/arm/whpx: fix whpx-arm post-reset CPU state
4908ac02c74 518f45b32d Doug Cook:
 target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
a006acdeea7 6ae0b04267 Doug Cook:
 target/arm/whpx: Don't try to sync ARM_CP_CONST registers
2d5a5123e9c 2a8b740e7a Bin Guo:
 hw/intc/bcm2835_ic: reject out-of-range FIQ source values
05d36c222b0 7e5c85f7f2 Kostiantyn Kostiuk:
 qga: Change effective user/group ID in guest-ssh-* commands
c5c52030eb2 01df81b24c Marc-André Lureau:
 vhost-user-gpu: validate command buffer size in submit_3d
cc69b03d9ed 1063bbb711 Denis V. Lunev:
 ui/cursor: make the cursor refcount atomic
03768c0ed92 2c43897356 Denis V. Lunev:
 hw/display/qxl: hold ssd.lock while replacing ssd.cursor
1c1e34cda5d 0ddbce88c4 Junjie Cao:
 hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
0ad411258bb 5440b6b5de Stefan Hajnoczi:
 virtio-scsi: set dataplane_started to false upon failure
4a1383f6e87 fdc3f9a83d Michael S. Tsirkin:
 virtio-balloon: fix free-page BH teardown on unrealize
fa1e74593ca 15dcee9195 Jia Jia:
 hw/virtio: reject inverted virtio-iommu IOVA ranges
b06b5416e78 73c3d017ef Laurent Vivier:
 hw/net/virtio-net: strip trailing padding when caching RSC segment
46af69a2e8a 5d85a09554 Laurent Vivier:
 hw/net/virtio-net: check packet size before VLAN tag access in receive_filter()
dc9bae8d3d4 f10977073c Zhang Chen:
 qapi/misc: Fix missed query-iothreads items
b5b99f00222 713e7e85a2 Junjie Cao:
 hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
b4803666973 c7254cd584 Marc-André Lureau:
 virtio-gpu: clear res->blob on mapping cleanup
7f5e21e922d 3ece85b53c Marc-André Lureau:
 virtio-gpu: disable blob scanouts on mapping cleanup
682e91f8d55 0e57187991 Denis V. Lunev:
 tests/unit: cover blocked IO during the websock handshake
f35b86fbc10 7a72a4652a Denis V. Lunev:
 io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
db6c3cda383 e867e2047c Denis V. Lunev:
 tests/unit: add websock handshake test
9a003099aa0 2295deb488 Denis V. Lunev:
 io/channel-websock: handle a blocked write during the handshake
eaa3085d5cc cd71c2f40a Denis V. Lunev:
 io/channel-websock: send an HTTP 400 when the greeting has no space
61584d64412 a3de21bfa5 Denis V. Lunev:
 io/channel-socket: do not treat a zero length write as an error
f13bd80b57b 259b877eac Junjie Cao:
 hw/cxl: fix timer leak in cxl_destroy_cci()
0c4f5d7a0c3 15d4bc75f8 Alberto Garcia:
 hw/sd/sdcard: Register device ops in drives without media
8c0acf50eec 10dddf15e2 Bin Meng:
 hw/sd: sdhci: Accept version 4 enable without UHS-I
ea9bfc47447 2931a675e9 Peter Maydell:
 target/arm: Make Thumb T1 hint space UNDEF before v6T2
10129d121f1 50d6757147 Peter Maydell:
 target/arm: Make IT insn undef when not present
cf8150a4a0a c05e01a885 Peter Maydell:
 target/arm: Make CBZ/CBNZ UNDEF before v6T2
8db548f41e1 59716ac306 Peter Maydell:
 target/arm: Correct reset value of SCTLR for arm926, arm1026
8b581efb3f1 f63124af78 Alexandre Frey:
 target/arm: fix TTA instruction S bit for IDAU-exempt addresses
bedca022597 b78c6d5b1b Gautam Menghani:
 ppc/xive: Trigger the pending interrupt for a guest after migration
a9484033557 cfa6e2c52c Paolo Bonzini:
 i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails
99267b48f8e d61c8a6fb7 Paolo Bonzini:
 vapic: confine the VAPIC region to 0xc0000..0xe0000
b06221ee7c5 0f410adf6b Paolo Bonzini:
 scsi: hide MODE SELECT block size change behind a quirk
828c067cf3f d30254aec9 Paolo Bonzini:
 scsi-disk: fix out-of-bound read in WRITE SAME
5831efd0554 1332990194 Denis V. Lunev:
 hw/ide: reject an out-of-range PIO transfer window on load
c74d778b1b1 0df27c66dc Denis V. Lunev:
 hw/ide: report the default CHS translation in IDENTIFY DEVICE
7a36dd67c3d 0905ef5b6d Denis V. Lunev:
 tests/qtest/ide-test: cover a CHS translation with zero sectors
971bc1b09aa 6c712a86f6 Denis V. Lunev:
 hw/ide: reject an unsupported CHS translation
83bd5c09b69 d7913fac77 Christian Borntraeger:
 s390x/sclp: pv: only copy the original SCCB buffer
dc94efd15da e80cf29479 Ivan Efremov:
 tests/qtest: Add seed CSR zero extension test
4ea952d30cb 51362da8f7 Ivan Efremov:
 target/riscv: Fix seed CSR sign extension
694b22ccb4a 569aa6280d Nicholas Piggin:
 target/riscv: tt-ascalon: Enable Zkr extension
22065d20ed1 dc04053687 Denis V. Lunev:
 dirty-bitmap: fix integer overflow in serialization coverage
2f78a6b6ea4 9a77ef813f Denis V. Lunev:
 block/monitor: allow dropping a bitmap never stored on disk
c59376b860a 3f3f5cdb92 Denis V. Lunev:
 migration/block-dirty-bitmap: reject bitmap load onto ro node
d48a9de5f57 59ecd8a1ac Denis V. Lunev:
 block/monitor: reject persistent bitmap add on a read-only node
b3c360befcb 438ee08bc9 Denis V. Lunev:
 tests/unit/test-blockjob: cover keeping a job paused while a pause is pending
7e8be8c8027 2667133c27 Denis V. Lunev:
 job: keep job paused across overlapping pause requests
998c0f4f673 0846740652 Christian Quante:
 hw/input/ps2: answer unknown mouse commands with a resend
fa6a6ab7d7b 418396be80 Warisjeet Singh:
 hw/display/vga: fix text-mode OOB write after a graphics surface switch
15cc1a29bc1 ddf5738503 Fabiano Rosas:
 chardev: Don't unregister yank upon async path connection failure
6955ff7e9c5 0e62034ca1 Marc-André Lureau:
 crypto: fix build against nettle >= 4
9b2dcfbca25 eb2b3a1fa8 Marc-André Lureau:
 virtio-gpu: use g_try_malloc to avoid guest-triggered abort
564a86571bb ab7183ed4e Marc-André Lureau:
 hw/display/qxl: validate primary surface stride against width


