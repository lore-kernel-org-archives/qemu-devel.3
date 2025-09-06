Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105ECA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv02L-0003QA-Vq; Sat, 06 Sep 2025 17:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02H-0003DC-Ol; Sat, 06 Sep 2025 17:01:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02A-0005kA-EO; Sat, 06 Sep 2025 17:01:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C5D33150F7D;
 Sun, 07 Sep 2025 00:00:54 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A82A278688;
 Sun,  7 Sep 2025 00:00:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 v2 00/34] Patch Round-up for stable 7.2.20,
 freeze on 2025-09-06 (frozen)
Date: Sun,  7 Sep 2025 00:00:38 +0300
Message-ID: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v7.2.20:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-09-06 (frozen), and the release is planned for 2025-09-08:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* b8882becd572 Michael Tokarev:
   hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk size calculation
02* feea87cd6b64 Paolo Bonzini:
   target/i386: fix width of third operand of VINSERTx128
03* 535ca76425fc Richard Henderson:
   target/arm/sme: Reorg SME access handling in handle_msr_i()
04* 3c9ee5489488 Richard Henderson:
   target/arm/sme: Rebuild hflags in set_pstate() helpers
05* 2a8af3825958 Richard Henderson:
   target/arm/sme: Introduce aarch64_set_svcr()
06* 7f2a01e7368f Richard Henderson:
   target/arm/sme: Reset SVE state in aarch64_set_svcr()
07* fccb49182e23 Richard Henderson:
   target/arm/sme: Reset ZA state in aarch64_set_svcr()
08* f43185571491 Richard Henderson:
   target/arm/sme: Rebuild hflags in aarch64_set_svcr()
09* 5c922ec5b136 Richard Henderson:
   target/arm/sme: Unify set_pstate() SM/ZA helpers as set_svcr()
10* 99870aff907b Peter Maydell:
   linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
11* e895095c78ab Philippe Mathieu-Daudé:
   target/mips: Only update MVPControl.EVP bit if executed by master VPE
12* 2bfcd27e00a4 Luc Michel:
   hw/net/cadence_gem: fix register mask initialization
13* b10bd4bd17ac Zenghui Yu:
   hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
14* 35cca0f95ff5 Vacha Bhavsar:
   target/arm: Fix big-endian handling of NEON gdb remote debugging
15* 97b3d732afec Vacha Bhavsar:
   target/arm: Fix handling of setting SVE registers from gdb
16* 13ed972b4ce5 Jamin Lin:
   hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1030
17* c0df98ab1f3d Werner Fink:
   qemu-iotests: Ignore indentation in Killed messages
18* e262646e12ac Philippe Mathieu-Daudé:
   hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
19 c12cbaa007c9 Zero Tang:
   i386/tcg/svm: fix incorrect canonicalization
20 8c49756825da Akihiko Odaki:
   virtio-net: Add only one queue pair when realizing
21 9379ea9db3c0 Akihiko Odaki:
   virtio-net: Add queues before loading them
22 adda0ad56bd2 Akihiko Odaki:
   virtio-net: Add queues for RSS during migration
23 5ffd387e9e0f Peter Maydell:
   scripts/kernel-doc: Avoid new Perl precedence warning
24 2e27650bddd3 Peter Maydell:
   hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
25 d6f67b83b81b Daniel Xu:
   qga: Fix memory leak when output stream is unused
26 28c5d27dd4dc minglei.liu:
   qga: Fix truncated output handling in guest-exec status reporting
27 8e4649cac9bc Laurent Vivier:
   e1000e: Prevent crash from legacy interrupt firing after MSI-X enable
28 450cb7ec2c5f Philippe Mathieu-Daudé:
   linux-user/mips: Use P5600 as default CPU to run NaN2008 ELF binaries
29 f7e3d7521b41 Philippe Mathieu-Daudé:
   linux-user/mips: Do not try to use removed R5900 CPU
30 14ab44b96d5b Philippe Mathieu-Daudé:
   elf: Add EF_MIPS_ARCH_ASE definitions
31 7a09b3cc70ab Philippe Mathieu-Daudé:
   linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
32 51c3aebfda64 Philippe Mathieu-Daudé:
   linux-user/mips: Select M14Kc CPU to run microMIPS binaries
33 1f82ca723478 Denis Rastyogin:
   target/mips: fix TLB huge page check to use 64-bit shift
34 606978500c3d Michael Tokarev:
   block/curl: fix curl internal handles handling

(commit(s) marked with * were in previous series and are not resent)

