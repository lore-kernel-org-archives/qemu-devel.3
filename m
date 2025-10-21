Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02EACCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 04:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4LR-0006Nd-8T; Tue, 21 Oct 2025 00:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vB4LP-0006NB-Cf; Tue, 21 Oct 2025 00:51:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vB4LN-00024l-1q; Tue, 21 Oct 2025 00:51:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 476E716039C;
 Tue, 21 Oct 2025 07:51:12 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 38EA62F1F85;
 Tue, 21 Oct 2025 07:51:20 +0300 (MSK)
Received: (nullmailer pid 6272 invoked by uid 1000);
 Tue, 21 Oct 2025 04:51:20 -0000
Subject: [ANNOUNCE] QEMU 10.1.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Oct 2025 07:51:20 +0300
Message-Id: <1761022280.036705.6267.nullmailer@tls.msk.ru>
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

The QEMU v10.1.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.1.2.tar.xz
  https://download.qemu.org/qemu-10.1.2.tar.xz.sig (signature)

v10.1.2 is now tagged in the official qemu.git repository, and the
stable-10.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.1

There are 23 changes since the previous v10.1.1 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.1-hash master-hash Author Name: Commmit-Subject):

ccaea6b265 Michael Tokarev:
 Update version for 10.1.2 release
acef0da910 91fc6d8101 Philippe Mathieu-Daudé:
 linux-user/microblaze: Fix little-endianness binary
e80709183c cea82f8cdd Gabriel Brookman:
 target/hppa: correct size bit parity for fmpyadd
e14614fe78 ec03dd9723 Richard Henderson:
 accel/tcg: Hoist first page lookup above pointer_wrap
95c1555cd8 58aa1d08bb Paolo Bonzini:
 target/i386: user: do not set up a valid LDT on reset
4e58c5bf0c 5142397c79 Paolo Bonzini:
 async: access bottom half flags with qatomic_read
f316e90a82 0d22b621b7 Paolo Bonzini:
 target/i386: fix access to the T bit of the TSS
b70ff85fef 5a2faa0a0a Thomas Ogrisegg:
 target/i386: fix x86_64 pushw op
68630e6701 cdba90ac1b YiFei Zhu:
 i386/tcg/smm_helper: Properly apply DR values on SMM entry / exit
cf8dff8d9f df32e5c568 Paolo Bonzini:
 i386/cpu: Prevent delivering SIPI during SMM in TCG mode
9ca80ff527 00001a22d1 Jon Kohler:
 i386/kvm: Expose ARCH_CAP_FB_CLEAR when invulnerable to MDS
19ab9f3102 df9a3372dd Mathias Krause:
 target/i386: Fix CR2 handling for non-canonical addresses
f0839fec94 ed26056d90 Richard W.M. Jones:
 block/curl.c: Use explicit long constants in curl_easy_setopt calls
400eeeefee 6529f31e0d Hector Cao:
 target/i386: add compatibility property for pdcm feature
608a19009a e9efa4a771 Paolo Bonzini:
 target/i386: add compatibility property for arch_capabilities
be9075c7c9 81d1885dcc Max Chou:
 target/riscv: rvv: Fix vslide1[up|down].vx unexpected result when XLEN=32 and SEW=64
3a184ef664 0b16c7b6a8 Jim Shu:
 target/riscv: Fix ssamoswap error handling
45a31df407 84c1605b76 Jim Shu:
 target/riscv: Fix SSP CSR error handling in VU/VS mode
1cea32f332 c851052a77 Jim Shu:
 target/riscv: Fix the mepc when sspopchk triggers the exception
19a3344754 a23e719ca8 Peter Maydell:
 target/arm: Don't set HCR.RW for AArch32 only CPUs
3a27ff6cb9 bab681f752 Stefan Hajnoczi:
 pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV devices
30ff0b5651 f65918497c nanliu:
 docs/devel: Correct uefi-vars-x64 device name
3870276618 1c0f5142d9 ShengYi Hung:
 hid: fix incorrect return value for hid
c3ae83117d 2e54e5fda7 Damien Bergamini:
 pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs


