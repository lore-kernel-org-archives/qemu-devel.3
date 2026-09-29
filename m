Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62303CA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZ5T-00017X-UK; Tue, 29 Sep 2026 10:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBZ5L-00013w-Ja; Tue, 29 Sep 2026 10:45:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBZ5E-0003bg-Ms; Tue, 29 Sep 2026 10:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790693114; bh=4YDhbJXy2CEsHsMTW9JqfwdpFCo4/QgpTKFfFvyhfvA=;
 h=From:To:Cc:Subject:Date;
 b=Olo0nRQC/ZnGEg14/jOwd6ikSbsDkN8JLvw8F4LlCa90HIGAlZFm+TxhbW6Nebx1e
 rZ4FxEyP5qOww8MoqKrf+HYKDNAGpI1TF/zRFnVSzfoX1joWpCvu25g1ichzQBWeiI
 BKf6A/q6RxRH9U9e4XATk4peYq0s8VMnnX2G/sjBoTFcnkWJo/P7BOcdPFdqZIW6jv
 yolyA64j3Q6yFjiJDZ7fJjw+EHiKyL2qk8e4BGnDeQA8J7DqORkYNpyXW7mVLmo7Em
 v0rLQP3CTm0pYgUVOOCYZHfNdZAe4I/s0wdKt+t1YwEo9zgYSH1xh5u9nMJQSmfPQB
 K8YcCjXJo0g9A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F1D2A1D97DF;
 Tue, 29 Sep 2026 17:45:14 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EF166434FB2;
 Tue, 29 Sep 2026 17:45:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E59C472D43; Tue, 29 Sep 2026 17:45:14 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 11.1.2 Stable released
Date: Tue, 29 Sep 2026 17:45:10 +0300
Message-ID: <20260929144512.126747-1-mjt@tls.msk.ru>
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

The QEMU v11.1.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.1.2.tar.xz
  https://download.qemu.org/qemu-11.1.2.tar.xz.sig (signature)

v11.1.2 is now tagged in the official qemu.git repository, and the
stable-11.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.1

There are 91 changes since the previous v11.1.1 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.1-hash master-hash Author Name: Commmit-Subject):

4fc49f46dc9 Michael Tokarev:
 Update version for 11.1.2 release
e9418396e05 62728f8c93 Richard Henderson:
 target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC
b267cdd260c 460da0e55c Richard Henderson:
 accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
44457d5e452 95e14595d3 Matt Turner:
 linux-user/sh4: align the vdso sigreturn trampolines
aa969e71b7c 5c98e72e6a Matt Turner:
 linux-user/sh4: fix vdso CFA for rt_sigreturn frames
f4745b370d9 170dfd8d1f Matt Turner:
 linux-user/sh4: use the kernel's sigreturn trampoline sequence in the vdso
47c250d7a70 6adc9d9cdc Andrey Polivoda:
 target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3
18e276bc72b a9dbd71f03 Simon Scherer:
 target/i386: Update FPU tag word for FXCH
0df1fa13114 f2357fdcd9 Simon Scherer:
 target/i386: Update FPU tag word for FSTP
115f1213aef 994fb6c218 Simon Scherer:
 target/i386: Update FPU tag word for FXTRACT's old ST(0)
e0e13147cbb c7cc09c85b Simon Scherer:
 target/i386: Fix FXCH to unconditionally clear C1
ddb63413208 cbbd4d74eb Shivang Upadhyay:
 target/ppc: Stop vCPU thread before calling parent_unrealize
5d5237bf630 1288b0869c Junjie Cao:
 tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch
6e2f88f2fa8 3c770d7292 Junjie Cao:
 tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
bfdbb47bcf7 45684127cd Junjie Cao:
 hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
273bb4dcdeb bfb82d57e7 Junjie Cao:
 hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
ed582623e23 f91b0544fe Thomas Huth:
 hw/usb/hcd-xhci: Set reentrancy guard in timer functions (CVE-2026-17588)
7d220b64fb4 57d98debdf Richard Henderson:
 tcg/riscv64: Set vtype before whole-register vector loads
3c4817284ce c66fe5b04d Richard Henderson:
 tests/tcg/s390x: Add regression test for #4449
99d5f67cc4e 0bc331d1c7 Richard Henderson:
 tcg/optimize: Fix expansion/simplification of deposit
7fe042fef2c 4278a7ba36 Richard Henderson:
 tests/tcg/arm: Add regression test for #4448
20d62bf3a9a e2ef4fc38c Richard Henderson:
 tcg/optimize: Fix fold_multiply2 vs 1
14375ddc834 f371388029 Anton Blanchard:
 accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
827802a3384 cab8663761 Richard Henderson:
 accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
abae50de244 fe9e30899f Christian Schoenebeck:
 hw/9pfs: mutate FID path from main thread only (CVE-2026-93834)
d5fc2b5b2e8 9b64b3cc83 Omar Elghoul:
 s390x/pci: fix DMA slot leak on I/O TLB entry replacement
9ba5f72d1d3 8435aadbb9 Jared Rossi:
 hw/s390x/ipl: Fix incorrect PCI IPL block lengths
f6f4446a6f3 e95f53e30b SignKirigami:
 linux-user/loongarch64: Detect vector stores in host_signal_write()
3e650785f6b 30fa3eb41f Michael Morrell:
 linux-user: implement mlock2(2) syscall
389e0fd0b90 ebfde6daff wangyang:
 linux-user/riscv: honor zicntr�lse for base counterCSRs
e1e70bd3bab 666dd3c9b1 Cam Miller:
 system/ram-discard-manager: fix offset_within_address_space in replay_by_populated_state()
c4d12277351 f277592cfd Luigi Leonardi:
 igvm: mark qigvm_find_param_entry as static
b485d9fb4e9 d9275e776e Luigi Leonardi:
 igvm: validate and honor byte_offset in parameter directives
f9590c25d59 ff96d56290 Gerd Hoffmann:
 hw/uefi: add missing uefi_str_is_valid check to uefi_vars_mm_lock_variable
f070e57cd5e 1d3e5a4b37 Bibo Mao:
 target/loongarch: Fix data race in CSR_ESTAT
ab845a4b74e 9d6ac47d31 Daniel Henrique Barboza:
 hw/riscv/virt.c: fix aclint soc/mtimer nodename
93483720ca2 99fb8e570e Showta Ishizaki:
 target/arm/hvf: implement MDCCSR_EL0 as RAZ
a2eedf74c6b 57197bf183 Doug Cook:
 target/arm/whpx: fix whpx-arm post-reset CPU state
9d57e090868 518f45b32d Doug Cook:
 target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
1609265bf85 6ae0b04267 Doug Cook:
 target/arm/whpx: Don't try to sync ARM_CP_CONST registers
569447fdf77 2a8b740e7a Bin Guo:
 hw/intc/bcm2835_ic: reject out-of-range FIQ source values
de05f5d842c 7e5c85f7f2 Kostiantyn Kostiuk:
 qga: Change effective user/group ID in guest-ssh-* commands
71f0dd0bd63 01df81b24c Marc-André Lureau:
 vhost-user-gpu: validate command buffer size in submit_3d
2fa544fc697 1063bbb711 Denis V. Lunev:
 ui/cursor: make the cursor refcount atomic
b335975ee3d 2c43897356 Denis V. Lunev:
 hw/display/qxl: hold ssd.lock while replacing ssd.cursor
82f79d6087c 0ddbce88c4 Junjie Cao:
 hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
f5154a5eb2a 5440b6b5de Stefan Hajnoczi:
 virtio-scsi: set dataplane_started to false upon failure
f731c7d2d4c fdc3f9a83d Michael S. Tsirkin:
 virtio-balloon: fix free-page BH teardown on unrealize
8928e734954 15dcee9195 Jia Jia:
 hw/virtio: reject inverted virtio-iommu IOVA ranges
ec2fdc85829 73c3d017ef Laurent Vivier:
 hw/net/virtio-net: strip trailing padding when caching RSC segment
fa82475d5ae 5d85a09554 Laurent Vivier:
 hw/net/virtio-net: check packet size before VLAN tag access in receive_filter()
d1f4c42cb4a f10977073c Zhang Chen:
 qapi/misc: Fix missed query-iothreads items
25de49d394e 713e7e85a2 Junjie Cao:
 hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
241b1bc3a15 c7254cd584 Marc-André Lureau:
 virtio-gpu: clear res->blob on mapping cleanup
0a46e9b7d06 0e57187991 Denis V. Lunev:
 tests/unit: cover blocked IO during the websock handshake
c6f7053d768 7a72a4652a Denis V. Lunev:
 io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
0fdf54ddd50 e867e2047c Denis V. Lunev:
 tests/unit: add websock handshake test
a1bc6e49b35 2295deb488 Denis V. Lunev:
 io/channel-websock: handle a blocked write during the handshake
756836f32a3 cd71c2f40a Denis V. Lunev:
 io/channel-websock: send an HTTP 400 when the greeting has no space
98b79943b28 a3de21bfa5 Denis V. Lunev:
 io/channel-socket: do not treat a zero length write as an error
5beb969b456 dd9641cb14 Bibo Mao:
 target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
4a39c7d61e4 259b877eac Junjie Cao:
 hw/cxl: fix timer leak in cxl_destroy_cci()
f0118c072ed 15d4bc75f8 Alberto Garcia:
 hw/sd/sdcard: Register device ops in drives without media
c826d95dc65 10dddf15e2 Bin Meng:
 hw/sd: sdhci: Accept version 4 enable without UHS-I
e9fd4f6b8e5 2931a675e9 Peter Maydell:
 target/arm: Make Thumb T1 hint space UNDEF before v6T2
1c6befcc91d 50d6757147 Peter Maydell:
 target/arm: Make IT insn undef when not present
2a9d29d76a1 c05e01a885 Peter Maydell:
 target/arm: Make CBZ/CBNZ UNDEF before v6T2
18c7eddcf17 59716ac306 Peter Maydell:
 target/arm: Correct reset value of SCTLR for arm926, arm1026
da1314967fc f63124af78 Alexandre Frey:
 target/arm: fix TTA instruction S bit for IDAU-exempt addresses
656e3d9cffb b78c6d5b1b Gautam Menghani:
 ppc/xive: Trigger the pending interrupt for a guest after migration
1e51b89fbc1 cfa6e2c52c Paolo Bonzini:
 i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails
d79bb5387c1 d61c8a6fb7 Paolo Bonzini:
 vapic: confine the VAPIC region to 0xc0000..0xe0000
c6a163896f8 0f410adf6b Paolo Bonzini:
 scsi: hide MODE SELECT block size change behind a quirk
775b21ddaaf d30254aec9 Paolo Bonzini:
 scsi-disk: fix out-of-bound read in WRITE SAME
0d4875d099a ddac7cfb00 Xie Bo:
 target/riscv/kvm: Preserve MP state across migration
5ba54cebb42 7df9aa5f6d Xie Bo:
 target/riscv/kvm: Synchronize privilege mode
920bfe35bd9 0df27c66dc Denis V. Lunev:
 hw/ide: report the default CHS translation in IDENTIFY DEVICE
508876a6287 0905ef5b6d Denis V. Lunev:
 tests/qtest/ide-test: cover a CHS translation with zero sectors
b534d228ba9 6c712a86f6 Denis V. Lunev:
 hw/ide: reject an unsupported CHS translation
c45fc7fe190 d7913fac77 Christian Borntraeger:
 s390x/sclp: pv: only copy the original SCCB buffer
2dcdde86fd6 dc04053687 Denis V. Lunev:
 dirty-bitmap: fix integer overflow in serialization coverage
0cec8aab7df 9a77ef813f Denis V. Lunev:
 block/monitor: allow dropping a bitmap never stored on disk
7a9ef209e14 3f3f5cdb92 Denis V. Lunev:
 migration/block-dirty-bitmap: reject bitmap load onto ro node
2ff183b94fb 59ecd8a1ac Denis V. Lunev:
 block/monitor: reject persistent bitmap add on a read-only node
62a019079b3 438ee08bc9 Denis V. Lunev:
 tests/unit/test-blockjob: cover keeping a job paused while a pause is pending
87d0c15627e 2667133c27 Denis V. Lunev:
 job: keep job paused across overlapping pause requests
eb8a247c05a 0846740652 Christian Quante:
 hw/input/ps2: answer unknown mouse commands with a resend
f3c6a0a6dca 418396be80 Warisjeet Singh:
 hw/display/vga: fix text-mode OOB write after a graphics surface switch
6df51ffaf61 ddf5738503 Fabiano Rosas:
 chardev: Don't unregister yank upon async path connection failure
0036ba296ca 0e62034ca1 Marc-André Lureau:
 crypto: fix build against nettle >= 4
5d8033f249d eb2b3a1fa8 Marc-André Lureau:
 virtio-gpu: use g_try_malloc to avoid guest-triggered abort
f39ebe53c3f ab7183ed4e Marc-André Lureau:
 hw/display/qxl: validate primary surface stride against width


