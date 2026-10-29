Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75476606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Fo8UvvA0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIYT-0002Nz-OY; Thu, 29 Oct 2026 01:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMIYS-0002Nc-Dc; Thu, 29 Oct 2026 01:20:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMIYO-0006cI-Vl; Thu, 29 Oct 2026 01:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793251184; bh=c1dp97AKFVkq/f0fb3FbCEj6eiCInDXdH2gTNFEieRM=;
 h=From:To:Cc:Subject:Date;
 b=Fo8UvvA0vWRa3hkiqFoOKpb5370Eoqv/GJJLDkJabRXC+gUT9QKesEFNqkeu083El
 7TSbVIfPKP74j3sB+rTc36sneAP8CDyb1UPk25y8CS7/lmaPchUpTO3RpNjUg/jexo
 fsQpWaKCRWjcsIysYNjPih7iIODjVDJeVRz7dOTfPOvL7EYLEvAzSIyNujlT/zmOAz
 D1nyEpg7Nr3Z9epLWYVE2oBUxvue+ItngdeZgSBh6J1+Q54erh9waVVD/7QBEQ4wlu
 RvDlY5glOf94hYIElFCvSp8Od97NoE8zQHivqjQ65frTb/SDoVsG9NHi+9fCf7dznc
 aBgOiJVcP3Uyw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 159961E219D;
 Thu, 29 Oct 2026 08:19:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E3ECC44DF22;
 Thu, 29 Oct 2026 08:19:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D8573A63E6; Thu, 29 Oct 2026 08:19:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 10.0.15 Stable released
Date: Thu, 29 Oct 2026 08:19:21 +0300
Message-ID: <20261029051934.1487878-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everyone,

The QEMU v10.0.15 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.15.tar.xz
  https://download.qemu.org/qemu-10.0.15.tar.xz.sig (signature)

v10.0.15 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 91 changes since the previous v10.0.14 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

c2cfbc6c121 Michael Tokarev:
 Update version for 10.0.15 release
a03f7a246fb fe0f4a5a57 Philippe Mathieu-Daudé:
 target/ppc: Name the EBB exceptions
1512e7081b1 ab6579bf73 Peter Maydell:
 hw/intc/exynos4210_combiner: Fix group register range check
d84c58726aa b6d36a1af7 Peter Maydell:
 hw/intc/exynos4210_combiner: Avoid hw_error for guest errors
fe555001f53 be67e61e29 Peter Maydell:
 hw/misc/bcm2835_cprman: Treat invalid clock mux source select as GND
bbe891ad260 cfa70f3a82 Thomas Huth:
 hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code
47d9b40b21e 6ab4cd2f13 Tommaso Califano:
 hw/usb/dev-mtp: Fix heap OOB read in usb_mtp_write_metadata()
5e6592a696a 1ccf17e9dc Tommaso Califano:
 hw/usb/dev-mtp: Fix assert crash on short CMD_SEND_OBJECT
a9fd9d39e4b a86338565c Haotian Jiang:
 usb-host: delete bottom halves during unrealize
c4bb1e2ecf1 59cb510910 Haotian Jiang:
 usb-host: free request on libusb submit failure
47d21dd39d3 432f505fa6 Junjie Cao:
 tests/qtest/usb-hcd-xhci: test interrupt pacing above 2^32
90927e3ec39 322894eed3 Junjie Cao:
 usb-host: free configuration descriptors on error paths
a5ce15c94a8 e1b7f5e2a6 Junjie Cao:
 usb-host: validate interface number before indexing altsetting
30cb44b2ee3 46dcc681ea Junjie Cao:
 tests/qtest: Cover OHCI endpoint type mismatches
1492ccd15a3 9ad9a5a923 Peter Maydell:
 hw/usb/hcd-ohci: Fail iso packets sent to non-iso endpoints and vice-versa
f1141c7a483 7b1eba96ae Munkhbaatar Enkhbaatar:
 hw/usb/hcd-ohci: Assert isochronous TDs are never deferred
8ad945fcd76 b17205f23a Tommaso Califano:
 hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
cf6d43b4c11 e90644eea1 Martin Pitt:
 hw/uefi: fix ContentInfo detection in wrap_pkcs7()
f15c9697dcd 12df325604 Christian Schoenebeck:
 hw/9pfs: fix dirent stream protection for legacy (9p2000.u) Tread
dcc8ced891f faa80b9847 Denis V. Lunev:
 iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node
c3af9ee5dde 4d11088a08 Denis V. Lunev:
 migration/block-dirty-bitmap: fix postcopy abort with bitmaps on several nodes
6764b0482a0 319cd41f11 Denis V. Lunev:
 migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
ba67576e839 aea4af8c51 Marc-André Lureau:
 migration: fix qemu_get_counted_string annotation
72e4aaf50ce 901ac73874 Fiona Ebner:
 qemu-img: convert: flush target image after copying
7d2cd6ce36b c6c8bdc21a Fiona Ebner:
 block: report flush error during bdrv_close()
26cb31d844e 9d2cdc4d3b Fiona Ebner:
 iotests.py: add filter_qemu()
75d3c2c0495 90b5f6ca17 Fiona Ebner:
 iotests: add test cases for failing flush after qemu-img convert
6dab43cfc73 a567ef8655 Daniel P. Berrangé:
 seccomp: really fix blocking of setns/execveat/unshare
423790f470e f33fb19cab Daniel P. Berrangé:
 seccomp: fix blocking of setns/execveat/unshare
5adad78115d cb82463fa9 dodochicha:
 target/riscv: Check Svnapot PTE before updating A/D bits
9064b3c3a38 71041ce05c Rick Richard:
 tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden reference
33abdb05b81 ee23f530e9 Rick Richard:
 hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
f4f7454d35d ba280c3510 Rick Richard:
 tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
e7e31066a89 e52de6b65f Xie Bo:
 target/riscv/kvm: Preserve FCSR across migration
73cf2e46757 410166b550 Zephyr Li:
 target/riscv: stop translating after WFI
aec6fcff960 366b4fba0f imaginos:
 target/riscv: check G-stage write permission for VS-stage A/D updates
c632f939cdc 2579771a28 Fuad Tabba:
 tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA
83a28a4d68e 2c37211946 Fuad Tabba:
 target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
e3d2faa5b1f bb79850255 Fuad Tabba:
 tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
dc7d51d9499 0dedeff932 Fuad Tabba:
 target/arm: Clear TTBR[5:0] from a 52-bit table base address
52f320e75ef 306d9ab85f Aurelien Jarno:
 tcg/riscv64: Remove vector min/max ops with immediates
1df9ad99263 21b6c3e5bc Artemii Mashanov:
 target/i386: fix immediate stack adjustment for RET and RETF
bae874b7b8e 0dd9fb43ea Artemii Mashanov:
 target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
809dd797f53 f9ca6b19ac Dominic P:
 tests/tcg: Add tests for sign extension after rotate
dc6b1c4d187 d228536a51 Dominic P:
 tcg/optimize: Do not derive s_mask from rotated s_mask
b2ddd7f25f6 35164929cf Marc-André Lureau:
 hw/display/vga: fix OOB writes after external surface resize
4bd95de9c08 6728170d2d Stefan Berger:
 tpm_emulator: Reject sending commands smaller than the request header
70e4da2656b 99a8b5a0dd Daniel P. Berrangé:
 io: cork TLS writes to avoid small TLS records
042a9626f21 12916d64b7 Maxim Levitsky:
 accel/kvm: coalesced mmio: check lenght of the MMIO write entry
ef63d921cc2 c08b84cd6e Philippe Mathieu-Daudé:
 accel/kvm: Replace legacy cpu_physical_memory_write() call
2e24f41f227 cf4f672c11 Kevin Wolf:
 block: Remove now redundant bdrv_wait_serialising_requests() calls
e3477f56b4d 0bd5a1b3d6 Kevin Wolf:
 block: Fix corruption from broken RMW atomicity
49cdf02ec04 efe98c2a09 Denis V. Lunev:
 block: reject a reopen of an unusable node instead of crashing
f0ab78cc138 af28b65fae Denis V. Lunev:
 qcow2: do not clear the dirty bit when reopening a read-only node
2fb5b90bcb8 196a50b090 Stefan Hajnoczi:
 file-posix: add statx(STATX_DIOALIGN) support
cebdfa66441 8daaf8d3b1 Denis V. Lunev:
 block: fix bdrv_next() skipping monitor-owned nodes
c7911040464 2910b995f6 Denis V. Lunev:
 iotests: cover inactivating a read-only node
0988558e7ff 429bf66a1f Denis V. Lunev:
 block/throttle-groups: fix crash when enabling I/O limits on a busy disk
fddbc5808a0 4668899d66 Daniel P. Berrangé:
 io: prevent unbounded read of websocket data from client
8427571b7e9 d198957674 Tommaso Califano:
 hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List Iteration
a0e8772ea98 a5b4837a25 Paolo Bonzini:
 target/i386/tcg: ignore VEX.L for unary scalar instructions
88f98d017f8 0f98b46846 Maxim Levitsky:
 accel/kvm: protect kvm_resample_fd_list with a mutex
70eb89a733a 6d5fb14d36 Simon Scherer:
 target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
2043b0a2ece 6802a4b239 Simon Scherer:
 target/i386: clear C1 for all x87 compare instructions
9ead086e94b 8d496d8f9f Jakub Lipový:
 target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
adc18430352 6ee626e349 Daniel Paziyski:
 hw/nvme: fix memory leak on sr-iov capable nvme controller removal
dcb58f52a81 90fcba23c5 Daniel Paziyski:
 hw/nvme: fix assertion failure on sr-iov capable nvme controller removal
b2d8b205bd0 cd3be3bd96 Denis V. Lunev:
 block/nbd: clear reply.cookie under receive_mutex
993baad5f7b 75b0a993da Denis V. Lunev:
 block/nbd: never index requests[] with an unchecked cookie
7d71a686a33 9998d225bb Denis V. Lunev:
 block/nbd: clear reply.cookie when the reply is rejected
cffb6ec5680 7e429d3624 Andrey Drobyshev:
 hw/display/qxl: trace skipped stale loadvm commands
5edee5b289f 95bc45193b Andrey Drobyshev:
 hw/display/qxl: validate replayed commands in qxl_post_load
51f2fccc3c3 050f5408bf Andrey Drobyshev:
 hw/display/qxl: factor out qxl_guest_phys2virt()
cd98d19283e 665494c3ac Marc-André Lureau:
 hw/usb/dev-smartcard-reader: validate migrated fields in post_load
44b4d537094 069dcc103b Marc-André Lureau:
 hw/usb/dev-smartcard-reader: decode bulk-out length as little-endian
d5b0c53ef65 d7f20657e7 Marc-André Lureau:
 hw/usb/dev-smartcard-reader: fix assert on pending answers overflow
74ee55b345c 49851e8595 Marc-André Lureau:
 hw/usb/dev-smartcard-reader: fix OOB read from pending bulk-in ring
b4db9809f87 1847dcd96d Marc-André Lureau:
 hw/usb/dev-smartcard-reader: validate interrupt transfer length
c237d816b57 d818e2b0e6 Matthew Rosato:
 s390x/pci: Reject apertures beyond IOAT capacity in translation mode
852545bdd9d 10a81449a2 Matthew Rosato:
 s390x/pci: Use qemu_log_mask() for guest-triggered errors in reg_ioat()
19d83f68378 e57ad36701 Matthew Rosato:
 s390x/pci: Fix frame stepping in rpcit_service_call()
a2800762474 119860f15c Eric Farman:
 s390x/sclp: Reject short headers in PV case
6c218591440 930a188edb Eric Farman:
 s390x/css: Use datastream pointer for checking no-data CCWs
f9a74e82c52 77cc481c23 Eric Farman:
 hw/intc/s390x: Fix check after g_try_realloc
33da8dcb96b 057ca01937 Eric Farman:
 vfio/ap: Clear error object pointer after non-fatal errors
2bf4137b190 bd5bc2861f Eric Farman:
 virtio-ccw: Fix rc check in read configuration path
b6685a19f01 13c7ba5e0f Eric Farman:
 virtio-ccw: Do not overwrite existing indicators
6a5c712efc5 92b935de27 Eric Farman:
 virtio-ccw: Limit ISC to MAX_ISC
f0ab9fa0b5c 89e653b773 Thomas Huth:
 hw/usb/hcd-xhci: Limit DMA transfers to plain memory
dbb787645c0 998b6db69e Fuad Tabba:
 target/arm: Fix WFxT timeouts when the offset puts the count ahead
6bc59d730cd 66d4ea65a0 Fuad Tabba:
 target/arm: Fix next timer tick when the offset puts the count ahead
655cc93e201 653b0c06c8 Jean-Francois Bortolotti:
 target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions


