Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3F2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 04:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4LR-0006Nq-CV; Tue, 21 Oct 2025 00:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vB4LP-0006NC-CZ; Tue, 21 Oct 2025 00:51:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vB4LN-00025W-1l; Tue, 21 Oct 2025 00:51:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF6CB16039D;
 Tue, 21 Oct 2025 07:51:19 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id E5B682F1F86;
 Tue, 21 Oct 2025 07:51:27 +0300 (MSK)
Received: (nullmailer pid 6362 invoked by uid 1000);
 Tue, 21 Oct 2025 04:51:27 -0000
Subject: [ANNOUNCE] QEMU 10.0.6 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Oct 2025 07:51:27 +0300
Message-Id: <1761022287.744330.6357.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MIME_QP_LONG_LINE=0.001,
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

Hi everyone,

The QEMU v10.0.6 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.6.tar.xz
  https://download.qemu.org/qemu-10.0.6.tar.xz.sig (signature)

v10.0.6 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 23 changes since the previous v10.0.5 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

e098f79eb2 Michael Tokarev:
 Update version for 10.0.6 release
536f5ac0d7 91fc6d8101 Philippe Mathieu-Daudé:
 linux-user/microblaze: Fix little-endianness binary
2d33b0091b cea82f8cdd Gabriel Brookman:
 target/hppa: correct size bit parity for fmpyadd
e2a2cdb07d 58aa1d08bb Paolo Bonzini:
 target/i386: user: do not set up a valid LDT on reset
bbdedf42f2 5142397c79 Paolo Bonzini:
 async: access bottom half flags with qatomic_read
df1d0ce23b 5a2faa0a0a Thomas Ogrisegg:
 target/i386: fix x86_64 pushw op
c3f08ed6d0 cdba90ac1b YiFei Zhu:
 i386/tcg/smm_helper: Properly apply DR values on SMM entry / exit
1e8a7c403a df32e5c568 Paolo Bonzini:
 i386/cpu: Prevent delivering SIPI during SMM in TCG mode
c1ff7b6eba 00001a22d1 Jon Kohler:
 i386/kvm: Expose ARCH_CAP_FB_CLEAR when invulnerable to MDS
ec60491c80 df9a3372dd Mathias Krause:
 target/i386: Fix CR2 handling for non-canonical addresses
a0f78ee586 ed26056d90 Richard W.M. Jones:
 block/curl.c: Use explicit long constants in curl_easy_setopt calls
47f00fd978 2e54e5fda7 Damien Bergamini:
 pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
381a32c3e2 81d1885dcc Max Chou:
 target/riscv: rvv: Fix vslide1[up|down].vx unexpected result when XLEN=32 and SEW=64
0c21b32947 0b16c7b6a8 Jim Shu:
 target/riscv: Fix ssamoswap error handling
e277608eae 84c1605b76 Jim Shu:
 target/riscv: Fix SSP CSR error handling in VU/VS mode
f64329b0cc c851052a77 Jim Shu:
 target/riscv: Fix the mepc when sspopchk triggers the exception
a81e4657ad a23e719ca8 Peter Maydell:
 target/arm: Don't set HCR.RW for AArch32 only CPUs
7402c4dfe6 bab681f752 Stefan Hajnoczi:
 pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV devices
63180b62bf f65918497c nanliu:
 docs/devel: Correct uefi-vars-x64 device name
45cd6b147b 1c0f5142d9 ShengYi Hung:
 hid: fix incorrect return value for hid
8ec0e0b502 c187a67c9d Filip Hejsek:
 ui/gtk: Fix callback function signature
c784ce6703 a1b28f71f7 Weifeng Liu:
 ui/gtk: Consider scaling when propagating ui info
7917dee17a Michael Tokarev:
 Revert "i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check"
c5c0b16cf7 Michael Tokarev:
 Revert "target/i386: do not expose ARCH_CAPABILITIES on AMD CPU"


