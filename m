Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1780CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 23:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCRFl-0006N7-4b; Fri, 24 Oct 2025 19:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFh-0006Mm-4f; Fri, 24 Oct 2025 19:31:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFe-0000G8-NU; Fri, 24 Oct 2025 19:31:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B0D7F59736A;
 Sat, 25 Oct 2025 01:31:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "MIME-Version"
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4KjlnHGMBfyF; Sat, 25 Oct 2025 01:31:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA9315972F3; Sat, 25 Oct 2025 01:31:12 +0200 (CEST)
Message-ID: <cover.1761346145.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/4] Some more pegasos patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 25 Oct 2025 01:31:12 +0200 (CEST)
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

Some more short patches to finish the already merged pegasos clean up
series.

BALATON Zoltan (4):
  hw/ppc/pegasos2: Add /chosen/stdin node with VOF
  hw/pci-host/articia: Map PCI memory windows in realize
  hw/ppc/pegasos2: Rename to pegasos
  hw/ppc/pegasos: Update documentation for pegasos1

 MAINTAINERS                             |  4 ++--
 configs/devices/ppc-softmmu/default.mak |  7 +++---
 docs/system/ppc/amigang.rst             | 29 +++++++++++++++----------
 hw/pci-host/articia.c                   | 15 ++++++++++++-
 hw/ppc/Kconfig                          |  2 +-
 hw/ppc/amigaone.c                       | 28 +++++-------------------
 hw/ppc/meson.build                      |  4 ++--
 hw/ppc/{pegasos2.c => pegasos.c}        | 14 +-----------
 8 files changed, 45 insertions(+), 58 deletions(-)
 rename hw/ppc/{pegasos2.c => pegasos.c} (98%)

-- 
2.41.3


