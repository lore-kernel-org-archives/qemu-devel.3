Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC9EC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITuc-0006TV-OW; Fri, 23 May 2025 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITua-0006Sa-Kj; Fri, 23 May 2025 11:02:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITuY-0003Av-QM; Fri, 23 May 2025 11:02:16 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E532A55C0D0;
 Fri, 23 May 2025 17:02:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id il06cKTGNUp9; Fri, 23 May 2025 17:02:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1804555BC02; Fri, 23 May 2025 17:02:10 +0200 (CEST)
Message-ID: <cover.1748012109.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/3] Misc ppc/e500 patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 23 May 2025 17:02:10 +0200 (CEST)
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

Some small patches to e500 related parts. Also includes a patch from
Bernhard that is rebased on current version.

Regards,
BALATON Zoltan

BALATON Zoltan (2):
  hw/ppc/e500: Move clock and TB frequency to machine class
  hw/net/fsl_etsec: Set default MAC address

Bernhard Beschow (1):
  hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
    resources

 hw/net/fsl_etsec/etsec.c |  1 +
 hw/pci-host/ppce500.c    |  8 ++++----
 hw/ppc/e500.c            | 26 +++++++++++++-------------
 hw/ppc/e500.h            |  4 ++++
 hw/ppc/e500plat.c        |  2 ++
 hw/ppc/mpc8544ds.c       |  2 ++
 6 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.41.3


