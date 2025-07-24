Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886D3C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uep9B-0004RN-8D; Thu, 24 Jul 2025 02:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uep8z-0004Mp-Nl; Thu, 24 Jul 2025 02:09:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uep8x-0007C6-Kh; Thu, 24 Jul 2025 02:09:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B7B46139B9F;
 Thu, 24 Jul 2025 09:09:22 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id D947124EA69;
 Thu, 24 Jul 2025 08:54:50 +0300 (MSK)
Received: (nullmailer pid 226715 invoked by uid 1000);
 Thu, 24 Jul 2025 05:54:51 -0000
Subject: [ANNOUNCE] QEMU 7.2.19 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jul 2025 08:54:51 +0300
Message-Id: <1753336491.485005.226714.nullmailer@tls.msk.ru>
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

Hi everyone,

The QEMU v7.2.19 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.19.tar.xz
  https://download.qemu.org/qemu-7.2.19.tar.xz.sig (signature)

v7.2.19 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 26 changes since the previous v7.2.18 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

5a6481389d Michael Tokarev:
 Update version for 7.2.19 release
196137c1c6 aef22331b5 Akihiko Odaki:
 ui/vnc: Do not copy z_stream
385eb77f60 5788929e05 Ethan Milon:
 amd_iommu: Fix truncation of oldval in amdvi_writeq
cae7315f45 5959b641c9 Alejandro Jimenez:
 amd_iommu: Remove duplicated definitions
452a0cb27b 67d3077ee4 Alejandro Jimenez:
 amd_iommu: Fix the calculation for Device Table size
dc0191c7c1 123cf4bdd3 Alejandro Jimenez:
 amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
7d8c916b77 108e10ff69 Alejandro Jimenez:
 amd_iommu: Fix masks for various IOMMU MMIO Registers
c309fddb3a ff3dcb3bf6 Alejandro Jimenez:
 amd_iommu: Update bitmasks representing DTE reserved fields
4002ea511d c63b8d1425 Alejandro Jimenez:
 amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
cd4ac461e1 091c7d7924 Alejandro Jimenez:
 amd_iommu: Fix Miscellaneous Information Register 0 encoding
94ab5f6743 983899eab4 Chaney, Ben:
 migration: Don't sync volatile memory after migration completes
5e1f406424 e4e839b2ee Geoffrey Thomas:
 linux-user: Hold the fd-trans lock across fork
1aa8057181 cfc688c00a Richard Henderson:
 target/arm: Fix f16_dotadd vs nan selection
7095d415fd 3801c5b75f Richard Henderson:
 target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
aee67c8b39 e6ffd009c7 Richard Henderson:
 target/arm: Fix 128-bit element ZIP, UZP, TRN
30f9eb2b2a b4b2e070f4 Richard Henderson:
 target/arm: Fix sve_access_check for SME
a9ec693b72 f9b0f69304 Richard Henderson:
 target/arm: Fix SME vs AdvSIMD exception priority
d12f379cd4 a412575837 Philippe Mathieu-Daudé:
 target/arm: Correct KVM & HVF dtb_compatible value
3b2089e6f2 0d0fc3f465 Richard Henderson:
 tcg: Fix constant propagation in tcg_reg_alloc_dup
62ed767ba0 5ad2b1f443 J. Neuschäfer:
 linux-user/arm: Fix return value of SYS_cacheflush
dc8199d66b e372214e66 Ethan Chen:
 qemu-options.hx: Fix reversed description of icount sleep behavior
9d40968725 f5ec751ee7 Shameer Kolothum:
 hw/arm/virt: Check bypass iommu is not set for iommu-map DT property
741f5877da 9c55c03c05 Bibo Mao:
 hw/loongarch/virt: Fix big endian support with MCFG table
2d39032357 eef2dd03f9 Fiona Ebner:
 hw/core/qdev-properties-system: Add missing return in set_drive_helper()
f9a70c82c2 5ddd6c8dc8 Volker Rümelin:
 audio: fix SIGSEGV in AUD_get_buffer_size_out()
9ee786d9d8 a9403bfcd9 Huaitong Han:
 vhost: Don't set vring call if guest notifier is unused
010f9a472c fb8e59abbe Jamin Lin:
 hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware hang


