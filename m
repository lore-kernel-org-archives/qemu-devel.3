Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A5C369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 04:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9FmA-0004Xg-OO; Mon, 28 Apr 2025 00:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u9FiM-0004Cl-3g
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u9FiG-0003ea-AJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:28 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxDGsF_g5oDf3HAA--.3260S3;
 Mon, 28 Apr 2025 12:03:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxvhsC_g5o63OaAA--.7484S2;
 Mon, 28 Apr 2025 12:03:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/8] loongarch-to-apply queue
Date: Mon, 28 Apr 2025 12:03:05 +0800
Message-Id: <20250428040313.413822-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxvhsC_g5o63OaAA--.7484S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

The following changes since commit 019fbfa4bcd2d3a835c241295e22ab2b5b56129b:

  Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging (2025-04-24 13:44:57 -0400)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250428

for you to fetch changes up to 55985a3fd236acab9e4c16c198246fcace766155:

  hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID (2025-04-28 11:39:20 +0800)

----------------------------------------------------------------
pull-loongarch-20250428 queue

----------------------------------------------------------------
Bibo Mao (8):
      hw/intc/loongarch_ipi: Add reset support
      hw/intc/loongarch_extioi: Add reset support
      hw/intc/loongarch_extioi: Replace legacy reset callback with new api
      hw/intc/loongarch_pch: Add reset support
      hw/intc/loongarch_pch: Replace legacy reset callback with new api
      hw/loongarch/virt: Get physical entry address with elf file
      hw/loongarch/virt: Replace RSDT with XSDT table
      hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID

 hw/intc/loongarch_extioi.c                | 12 ++++---
 hw/intc/loongarch_extioi_common.c         | 41 ++++++++++++++++++++++
 hw/intc/loongarch_ipi.c                   | 29 ++++++++++++++++
 hw/intc/loongarch_pch_pic.c               | 26 +++++---------
 hw/intc/loongarch_pic_common.c            | 25 +++++++++++++
 hw/loongarch/boot.c                       |  1 +
 hw/loongarch/virt-acpi-build.c            | 12 +++----
 hw/loongarch/virt.c                       | 58 +++++++++++++++++++++++++++++++
 include/hw/intc/loongarch_extioi.h        |  1 +
 include/hw/intc/loongarch_extioi_common.h |  1 +
 include/hw/intc/loongarch_ipi.h           |  1 +
 include/hw/intc/loongarch_pch_pic.h       |  1 +
 include/hw/intc/loongarch_pic_common.h    |  1 +
 13 files changed, 181 insertions(+), 28 deletions(-)


