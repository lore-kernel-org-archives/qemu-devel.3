Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C70C3814E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTZf-0006UP-7n; Thu, 04 Jul 2024 17:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZd-0006Qd-EZ; Thu, 04 Jul 2024 17:01:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZZ-0004IJ-LT; Thu, 04 Jul 2024 17:01:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57BA17755D;
 Fri,  5 Jul 2024 00:00:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6DFF4FEC97;
 Fri,  5 Jul 2024 00:00:55 +0300 (MSK)
Received: (nullmailer pid 1507710 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 00/22] Patch Round-up for stable 9.0.2,
 freeze on 2024-07-14
Date: Fri,  5 Jul 2024 00:00:30 +0300
Message-Id: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following patches are queued for QEMU stable v9.0.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.0

Patch freeze is 2024-07-14, and the release is planned for 2024-07-16:

  https://wiki.qemu.org/Planning/9.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 3973615e7fba Mark Cave-Ayland:
   target/i386: fix size of EBP writeback in gen_enter()
02 2c3e4e2de699 Alexey Dobriyan:
   virtio-net: drop too short packets early
03 77bf310084da Dongwon Kim:
   ui/gtk: Draw guest frame at refresh cycle
04 719c6819ed9a Stefan Hajnoczi:
   Revert "monitor: use aio_co_reschedule_self()"
05 a276ec8e2632 Philippe Mathieu-Daudé:
   hw/audio/virtio-snd: Always use little endian audio format
06 b1cf266c82cb Gerd Hoffmann:
   stdvga: fix screen blanking
07 3b279f73fa37 Anton Johansson:
   accel/tcg: Fix typo causing tb->page_addr[1] to not be recorded
08 54b27921026d Ilya Leoshkevich:
   linux-user: Make TARGET_NR_setgroups affect only the current thread
09 6b4965373e56 Clément Chigot:
   target/sparc: use signed denominator in sdiv helper
10 521d7fb3ebdf Richard Henderson:
   tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
11 6d3279655ac4 Fabiano Rosas:
   migration: Fix file migration with fdset
12 641b1efe01b2 Thomas Huth:
   tests: Update our CI to use CentOS Stream 9 instead of 8
13 903916f0a017 Chuang Xu:
   i386/cpu: fixup number of addressable IDs for processor cores in the 
   physical package
14 76bccf3cb9d9 Richard Henderson:
   target/arm: Fix VCMLA Dd, Dn, Dm[idx]
15 7619129f0d4a Richard Henderson:
   target/arm: Fix FJCVTZS vs flush-to-zero
16 9d7950edb0cd Daniel P. Berrangé:
   hw/core: allow parameter=1 for SMP topology on any machine
17 e68dcbb07923 Daniel P. Berrangé:
   tests: add testing of parameter=1 for SMP topology
18 bd385a5298d7 Kevin Wolf:
   qcow2: Don't open data_file with BDRV_O_NO_IO
19 2eb42a728d27 Kevin Wolf:
   iotests/244: Don't store data-file with protocol in image
20 7e1110664ecb Kevin Wolf:
   iotests/270: Don't store data-file with json: prefix in image
21 7ead94699861 Kevin Wolf:
   block: Parse filenames only when explicitly requested
22 a71d9dfbf63d Richard Henderson:
   tcg/optimize: Fix TCG_COND_TST* simplification of setcond2

