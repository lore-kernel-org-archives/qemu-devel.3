Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDE9CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9Zh-0008AH-6Q; Sat, 17 Oct 2026 14:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ZM-000899-2q; Sat, 17 Oct 2026 14:55:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ZI-0003Zi-Gb; Sat, 17 Oct 2026 14:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263328; bh=2OLpClSdZUZXvU/DXDOMeA6s4oKZKZyJWryRBZH+RQI=;
 h=From:To:Cc:Subject:Date;
 b=SW714P+AUxYjGsb6A2qdS0jNQR4u3lawQSri2sJLbXWObM1zWDdoMGigcK/O7F8tT
 s06p/8AQhF02Xq5PYv5H09aGJ3NBqNovBwS1++Y/QxJtEUBiKnTWL6I8uEUnyPUIc6
 ShMmlEtkjroWqeaMR4CAT1LrPZxljlMUSpjZdtoiqyiFybgj0pdnYO+K/b/gvTHxBH
 x2YcyWaqG6QWf2IIQcudUfJEY95FSKGqAsiuFeSXB4BuWeECbyNMul+iriJBp9yAzC
 /FCUN+6BLpQpdCClmraiLQVwkDT6FoJAGFDR0naa/FxmYT71vuqasRHb/Ie0plNLiy
 jUxUQlGMLfC8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66DBE1DE69F;
 Sat, 17 Oct 2026 21:55:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9759544336B;
 Sat, 17 Oct 2026 21:55:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 00/63] Patch Round-up for stable 10.0.15,
 freeze on 2026-10-26
Date: Sat, 17 Oct 2026 21:54:16 +0300
Message-ID: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.15:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-10-26, and the release is planned for 2026-10-28:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 653b0c06c83d Jean-Francois Bortolotti:
   target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions
02 66d4ea65a064 Fuad Tabba:
   target/arm: Fix next timer tick when the offset puts the count ahead
03 998b6db69e3e Fuad Tabba:
   target/arm: Fix WFxT timeouts when the offset puts the count ahead
04 89e653b77369 Thomas Huth:
   hw/usb/hcd-xhci: Limit DMA transfers to plain memory
05 92b935de2709 Eric Farman:
   virtio-ccw: Limit ISC to MAX_ISC
06 13c7ba5e0f14 Eric Farman:
   virtio-ccw: Do not overwrite existing indicators
07 bd5bc2861fb6 Eric Farman:
   virtio-ccw: Fix rc check in read configuration path
08 057ca01937b7 Eric Farman:
   vfio/ap: Clear error object pointer after non-fatal errors
09 77cc481c2311 Eric Farman:
   hw/intc/s390x: Fix check after g_try_realloc
10 930a188edbbc Eric Farman:
   s390x/css: Use datastream pointer for checking no-data CCWs
11 119860f15cd2 Eric Farman:
   s390x/sclp: Reject short headers in PV case
12 e57ad3670188 Matthew Rosato:
   s390x/pci: Fix frame stepping in rpcit_service_call()
13 10a81449a279 Matthew Rosato:
   s390x/pci: Use qemu_log_mask() for guest-triggered errors in reg_ioat()
14 d818e2b0e631 Matthew Rosato:
   s390x/pci: Reject apertures beyond IOAT capacity in translation mode
15 1847dcd96d7d Marc-André Lureau:
   hw/usb/dev-smartcard-reader: validate interrupt transfer length
16 49851e859506 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: fix OOB read from pending bulk-in ring
17 d7f20657e756 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: fix assert on pending answers overflow
18 069dcc103be7 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: decode bulk-out length as little-endian
19 665494c3ac07 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: validate migrated fields in post_load
20 050f5408bfcf Andrey Drobyshev:
   hw/display/qxl: factor out qxl_guest_phys2virt()
21 95bc45193bbe Andrey Drobyshev:
   hw/display/qxl: validate replayed commands in qxl_post_load
22 7e429d3624c4 Andrey Drobyshev:
   hw/display/qxl: trace skipped stale loadvm commands
23 9998d225bb95 Denis V. Lunev:
   block/nbd: clear reply.cookie when the reply is rejected
24 75b0a993dacb Denis V. Lunev:
   block/nbd: never index requests[] with an unchecked cookie
25 cd3be3bd96c0 Denis V. Lunev:
   block/nbd: clear reply.cookie under receive_mutex
26 90fcba23c526 Daniel Paziyski:
   hw/nvme: fix assertion failure on sr-iov capable nvme controller removal
27 6ee626e34979 Daniel Paziyski:
   hw/nvme: fix memory leak on sr-iov capable nvme controller removal
28 8d496d8f9fce Jakub Lipový:
   target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
29 6802a4b23919 Simon Scherer:
   target/i386: clear C1 for all x87 compare instructions
30 6d5fb14d36a6 Simon Scherer:
   target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
31 0f98b46846eb Maxim Levitsky:
   accel/kvm: protect kvm_resample_fd_list with a mutex
32 a5b4837a253e Paolo Bonzini:
   target/i386/tcg: ignore VEX.L for unary scalar instructions
33 d198957674b3 Tommaso Califano:
   hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List Iteration
34 4668899d6615 Daniel P. Berrangé:
   io: prevent unbounded read of websocket data from client
35 429bf66a1f23 Denis V. Lunev:
   block/throttle-groups: fix crash when enabling I/O limits on a busy disk
36 2910b995f6c8 Denis V. Lunev:
   iotests: cover inactivating a read-only node
37 8daaf8d3b1c5 Denis V. Lunev:
   block: fix bdrv_next() skipping monitor-owned nodes
38 196a50b0902b Stefan Hajnoczi:
   file-posix: add statx(STATX_DIOALIGN) support
39 af28b65fae6f Denis V. Lunev:
   qcow2: do not clear the dirty bit when reopening a read-only node
40 efe98c2a0932 Denis V. Lunev:
   block: reject a reopen of an unusable node instead of crashing
41 0bd5a1b3d60c Kevin Wolf:
   block: Fix corruption from broken RMW atomicity
42 cf4f672c11d6 Kevin Wolf:
   block: Remove now redundant bdrv_wait_serialising_requests() calls
43 c08b84cd6e55 Philippe Mathieu-Daudé:
   accel/kvm: Replace legacy cpu_physical_memory_write() call
44 12916d64b78e Maxim Levitsky:
   accel/kvm: coalesced mmio: check lenght of the MMIO write entry
45 99a8b5a0dda9 Daniel P. Berrangé:
   io: cork TLS writes to avoid small TLS records
46 6728170d2d08 Stefan Berger:
   tpm_emulator: Reject sending commands smaller than the request header
47 35164929cfa3 Marc-André Lureau:
   hw/display/vga: fix OOB writes after external surface resize
48 d228536a5142 Dominic P:
   tcg/optimize: Do not derive s_mask from rotated s_mask
49 f9ca6b19acb1 Dominic P:
   tests/tcg: Add tests for sign extension after rotate
50 0dd9fb43ea22 Artemii Mashanov:
   target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
51 21b6c3e5bccf Artemii Mashanov:
   target/i386: fix immediate stack adjustment for RET and RETF
52 306d9ab85fdb Aurelien Jarno:
   tcg/riscv64: Remove vector min/max ops with immediates
53 0dedeff9328d Fuad Tabba:
   target/arm: Clear TTBR[5:0] from a 52-bit table base address
54 bb79850255c8 Fuad Tabba:
   tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
55 2c372119465e Fuad Tabba:
   target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
56 2579771a28a2 Fuad Tabba:
   tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA
57 366b4fba0fae imaginos:
   target/riscv: check G-stage write permission for VS-stage A/D updates
58 410166b550cc Zephyr Li:
   target/riscv: stop translating after WFI
59 e52de6b65f5f Xie Bo:
   target/riscv/kvm: Preserve FCSR across migration
60 ba280c351011 Rick Richard:
   tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
61 ee23f530e99d Rick Richard:
   hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
62 71041ce05c95 Rick Richard:
   tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden reference
63 cb82463fa9bf dodochicha:
   target/riscv: Check Svnapot PTE before updating A/D bits

