Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B04CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 05:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwD84-0005EJ-Eh; Wed, 10 Sep 2025 01:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uwD81-0005Dv-Nf; Wed, 10 Sep 2025 01:12:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uwD7v-0004Nm-Np; Wed, 10 Sep 2025 01:12:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 00A90151F63;
 Wed, 10 Sep 2025 08:11:57 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 37E9627B8D6;
 Wed, 10 Sep 2025 08:12:03 +0300 (MSK)
Received: (nullmailer pid 441761 invoked by uid 1000);
 Wed, 10 Sep 2025 05:12:02 -0000
Subject: [ANNOUNCE] QEMU 7.2.20 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2025 08:12:02 +0300
Message-Id: <1757481122.401688.441756.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi everyone,

The QEMU v7.2.20 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.20.tar.xz
  https://download.qemu.org/qemu-7.2.20.tar.xz.sig (signature)

v7.2.20 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 34 changes since the previous v7.2.19 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

b26daad0c4 Michael Tokarev:
 Update version for 7.2.20 release
9ac9b7ea53 606978500c Michael Tokarev:
 block/curl: fix curl internal handles handling
cb72e6e445 1f82ca7234 Denis Rastyogin:
 target/mips: fix TLB huge page check to use 64-bit shift
2c2da6ecf8 51c3aebfda Philippe Mathieu-Daudé:
 linux-user/mips: Select M14Kc CPU to run microMIPS binaries
2d035553f3 7a09b3cc70 Philippe Mathieu-Daudé:
 linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
41e2ed199e 14ab44b96d Philippe Mathieu-Daudé:
 elf: Add EF_MIPS_ARCH_ASE definitions
8a9322814e f7e3d7521b Philippe Mathieu-Daudé:
 linux-user/mips: Do not try to use removed R5900 CPU
d790ae865c 450cb7ec2c Philippe Mathieu-Daudé:
 linux-user/mips: Use P5600 as default CPU to run NaN2008 ELF binaries
ee2a2c7d54 8e4649cac9 Laurent Vivier:
 e1000e: Prevent crash from legacy interrupt firing after MSI-X enable
5c8b55967f 28c5d27dd4 minglei.liu:
 qga: Fix truncated output handling in guest-exec status reporting
978cd0679d d6f67b83b8 Daniel Xu:
 qga: Fix memory leak when output stream is unused
c8f0f7c1f3 2e27650bdd Peter Maydell:
 hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
e83c6b7411 5ffd387e9e Peter Maydell:
 scripts/kernel-doc: Avoid new Perl precedence warning
b3ad244853 adda0ad56b Akihiko Odaki:
 virtio-net: Add queues for RSS during migration
361da9bd09 9379ea9db3 Akihiko Odaki:
 virtio-net: Add queues before loading them
653217a501 8c49756825 Akihiko Odaki:
 virtio-net: Add only one queue pair when realizing
465c50ac0f c12cbaa007 Zero Tang:
 i386/tcg/svm: fix incorrect canonicalization
c01efd93cf e262646e12 Philippe Mathieu-Daudé:
 hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
64e5f0f93d c0df98ab1f Werner Fink:
 qemu-iotests: Ignore indentation in Killed messages
7023cde2e4 13ed972b4c Jamin Lin:
 hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1030
423a3bece9 97b3d732af Vacha Bhavsar:
 target/arm: Fix handling of setting SVE registers from gdb
d85e56bc73 35cca0f95f Vacha Bhavsar:
 target/arm: Fix big-endian handling of NEON gdb remote debugging
e3ac46b455 b10bd4bd17 Zenghui Yu:
 hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
f74d5de046 2bfcd27e00 Luc Michel:
 hw/net/cadence_gem: fix register mask initialization
b662b0e862 e895095c78 Philippe Mathieu-Daudé:
 target/mips: Only update MVPControl.EVP bit if executed by master VPE
7b94f67dd0 99870aff90 Peter Maydell:
 linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
7356bc8036 5c922ec5b1 Richard Henderson:
 target/arm/sme: Unify set_pstate() SM/ZA helpers as set_svcr()
3ece4d8a14 f431855714 Richard Henderson:
 target/arm/sme: Rebuild hflags in aarch64_set_svcr()
3629f08406 fccb49182e Richard Henderson:
 target/arm/sme: Reset ZA state in aarch64_set_svcr()
4f50e20ec3 7f2a01e736 Richard Henderson:
 target/arm/sme: Reset SVE state in aarch64_set_svcr()
a2f3bbf35e 2a8af38259 Richard Henderson:
 target/arm/sme: Introduce aarch64_set_svcr()
f365f4e341 3c9ee54894 Richard Henderson:
 target/arm/sme: Rebuild hflags in set_pstate() helpers
73a4a6432a 535ca76425 Richard Henderson:
 target/arm/sme: Reorg SME access handling in handle_msr_i()
489a0714bf feea87cd6b Paolo Bonzini:
 target/i386: fix width of third operand of VINSERTx128
9e9172ffb4 b8882becd5 Michael Tokarev:
 hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk size calculation


