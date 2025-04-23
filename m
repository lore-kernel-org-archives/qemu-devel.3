Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF8FC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ww3-0007G7-JJ; Wed, 23 Apr 2025 06:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7Wvz-0007FE-SU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:02:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7Wvx-0002Ay-Vc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:02:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BE5CD55D23B;
 Wed, 23 Apr 2025 12:02:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id FDMiBN_Zl5Ed; Wed, 23 Apr 2025 12:02:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA0DF55C592; Wed, 23 Apr 2025 12:02:19 +0200 (CEST)
Message-ID: <cover.1745402140.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
To: qemu-devel@nongnu.org
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 philmd@linaro.org
Date: Wed, 23 Apr 2025 12:02:19 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Simple series doing what the subject says.

v2:
- Added changes to qemu.nsi (Philippe)
- Changed order of enum to keep it sorted. This changes value of
existing define but the value is not relevant, always used by name.

BALATON Zoltan (2):
  system/datadir: Add new type constant for DTB files
  pc-bios: Move device tree files in their own subdir

 MAINTAINERS                                |   2 +-
 hw/microblaze/boot.c                       |   2 +-
 hw/ppc/ppc440_bamboo.c                     |   2 +-
 hw/ppc/sam460ex.c                          |   2 +-
 hw/ppc/virtex_ml507.c                      |   2 +-
 include/qemu/datadir.h                     |  11 +++++++---
 pc-bios/{ => dtb}/bamboo.dtb               | Bin
 pc-bios/{ => dtb}/bamboo.dts               |   0
 pc-bios/{ => dtb}/canyonlands.dtb          | Bin
 pc-bios/{ => dtb}/canyonlands.dts          |   0
 pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
 pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
 pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
 pc-bios/meson.build                        |  23 +--------------------
 qemu.nsi                                   |   2 +-
 system/datadir.c                           |   5 ++++-
 18 files changed, 42 insertions(+), 32 deletions(-)
 rename pc-bios/{ => dtb}/bamboo.dtb (100%)
 rename pc-bios/{ => dtb}/bamboo.dts (100%)
 rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
 rename pc-bios/{ => dtb}/canyonlands.dts (100%)
 create mode 100644 pc-bios/dtb/meson.build
 rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

-- 
2.41.3


