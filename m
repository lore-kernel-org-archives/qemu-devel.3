Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE66C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRLY-0004Gh-2f; Fri, 06 Sep 2024 01:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRKx-0003rI-He; Fri, 06 Sep 2024 01:16:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRKv-0007do-Ik; Fri, 06 Sep 2024 01:16:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2649B8C114;
 Fri,  6 Sep 2024 08:15:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BD67D13335A;
 Fri,  6 Sep 2024 08:16:33 +0300 (MSK)
Received: (nullmailer pid 10382 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 00/40] Patch Round-up for stable 7.2.14,
 freeze on 2024-09-16
Date: Fri,  6 Sep 2024 08:15:48 +0300
Message-Id: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following patches are queued for QEMU stable v7.2.14:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-09-16, and the release is planned for 2024-09-18:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 3becc9390810 Markus Armbruster:
   qapi/qom: Document feature unstable of @x-vfio-user-server
02 31d93fedf41c Daniyal Khan:
   target/arm: Use float_status copy in sme_fmopa_s
03 207d30b5fdb5 Richard Henderson:
   target/arm: Use FPST_F16 for SME FMOPA (widening)
04 c510fe78f1b7 Zheyu Ma:
   hw/nvme: fix memory leak in nvme_dsm
05 a207d5f87d66 Zhao Liu:
   hw/cxl/cxl-host: Fix segmentation fault when getting cxl-fmw property
06 a3c8d7e38550 Clément Mathieu--Drif:
   intel_iommu: fix FRCD construction macro
07 13be929aff80 Paolo Bonzini:
   target/i386: do not crash if microvm guest uses SGX CPUID leaves
08 903cc9e1173e songziming:
   chardev/char-win-stdio.c: restore old console mode
09 2465c89fb983 Bibo Mao:
   hw/intc/loongson_ipi: Access memory in little endian
10 851495571d14 Peter Maydell:
   util/async.c: Forbid negative min/max in 
   aio_context_set_thread_pool_params()
11 d72479b11797 Thomas Huth:
   hw/virtio: Fix the de-initialization of vhost-user devices
12 83340193b991 Richard Henderson:
   target/rx: Use target_ulong for address in LI
13 546d574b11e0 Frederik van Hövell:
   hw/char/bcm2835_aux: Fix assert when receive FIFO fills up
14 0892fffc2aba Peter Maydell:
   hw/misc/bcm2835_property: Fix handling of FRAMEBUFFER_SET_PALETTE
15 56f1c0db928a Peter Maydell:
   target/arm: Don't assert for 128-bit tile accesses when SVL is 128
16 ea3f5a90f036 Peter Maydell:
   target/arm: Fix UMOPA/UMOPS of 16-bit values
17 76916dfa89e8 Peter Maydell:
   target/arm: Avoid shifts by -1 in tszimm_shr() and tszimm_shl()
18 f573ac059ed0 Peter Maydell:
   target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled
19 48e5b5f994bc Peter Maydell:
   docs/sphinx/depfile.py: Handle env.doc2path() returning a Path not a str
20 9a45b0761628 Peter Maydell:
   hw/i386/amd_iommu: Don't leak memory in amdvi_update_iotlb()
21 5a558be93ad6 Marco Palumbi:
   hw/arm/mps2-tz.c: fix RX/TX interrupts order
22 55f9f4ee018c Peter Maydell:
   target/arm: Handle denormals correctly for FMOPA (widening)
23 f1595ceb9aad Akihiko Odaki:
   virtio-net: Ensure queue index fits with RSS
24 f937309fbdbb thomas:
   virtio-net: Fix network stall at the host side waiting for kick
25 ed5a159c3de4 Philippe Mathieu-Daudé:
   hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers
26 b881cf00c99e Amjad Alsharafi:
   vvfat: Fix bug in writing to middle of file
27 21b25a0e466a Amjad Alsharafi:
   vvfat: Fix usage of `info.file.offset`
28 f60a6f7e17bf Amjad Alsharafi:
   vvfat: Fix wrong checks for cluster mappings invariant
29 5eed3db33650 Amjad Alsharafi:
   vvfat: Fix reading files with non-continuous clusters
30 c8f60bfb4345 Amjad Alsharafi:
   iotests: Add `vvfat` tests
31 fb1c2aaa981e Eric Blake:
   nbd/server: Plumb in new args to nbd_client_add()
32 c8a76dbd90c2 Eric Blake:
   nbd/server: CVE-2024-7409: Cap default max-connections to 100
33 b9b72cb3ce15 Eric Blake:
   nbd/server: CVE-2024-7409: Drop non-negotiating clients
34 3e7ef738c846 Eric Blake:
   nbd/server: CVE-2024-7409: Close stray clients at server-stop
35 3874f5f73c44 Eric Blake:
   nbd/server: CVE-2024-7409: Avoid use-after-free when closing server
36 547c4e50929e Stefano Garzarella:
   block/blkio: use FUA flag on write zeroes only if supported
37 416f2b16c02c Richard Henderson:
   target/i386: Do not apply REX to MMX operands
38 940d802b24e6 Alexander Ivanov:
   module: Prevent crash by resetting local_err in module_load_qom_all()
39 87e012f29f2e Peter Maydell:
   crypto/tlscredspsk: Free username on finalize
40 446e5e8b4515 Jianzhou Yue:
   hw/core/ptimer: fix timer zero period condition for freq > 1GHz

