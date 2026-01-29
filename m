Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AE4D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUkv-0004x2-4f; Thu, 29 Jan 2026 11:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlUkp-0004t7-KY
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:20:24 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlUkm-0000du-Oa
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:20:23 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 479B8596A10;
 Thu, 29 Jan 2026 17:20:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id zmkqVO4X1tPH; Thu, 29 Jan 2026 17:20:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3AFBB596A29; Thu, 29 Jan 2026 17:20:12 +0100 (CET)
Message-ID: <cover.1769703287.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/4] memory: Remove most _nomigrate variants
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Thu, 29 Jan 2026 17:20:12 +0100 (CET)
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

OK, let's start with some clean up to simplify memory region API. The
_nomigrate variants are rarely needed, some of them are already unused
so remove them standardising on memory_region_init_ram_flags_nomigrate()
for the few cases where this is really needed.

BALATON Zoltan (4):
  memory: Remove memory_region_init_rom_device_nomigrate()
  hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_ram_nomigrate()

 docs/devel/memory.rst                         | 10 +--
 hw/display/cg3.c                              |  5 +-
 hw/display/tcx.c                              | 10 +--
 hw/display/vga.c                              |  4 +-
 hw/sparc/sun4m.c                              | 15 ++--
 hw/sparc64/sun4u.c                            |  9 ++-
 hw/xtensa/xtfpga.c                            |  4 +-
 include/system/memory.h                       | 76 -------------------
 .../memory-region-housekeeping.cocci          | 42 +---------
 system/memory.c                               | 73 +++++-------------
 10 files changed, 47 insertions(+), 201 deletions(-)

-- 
2.41.3


