Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69072E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM2AD-0001ak-Gg; Fri, 13 Dec 2024 04:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tM2A9-0001Yu-RK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:40:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tM2A6-0006e3-9s
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:40:45 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxmeENAVxnp4lWAA--.40831S3;
 Fri, 13 Dec 2024 17:40:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxDuELAVxnQ8aBAA--.54481S2;
 Fri, 13 Dec 2024 17:40:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 00/18] loongarch-to-apply queue
Date: Fri, 13 Dec 2024 17:40:09 +0800
Message-Id: <20241213094027.1732484-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxDuELAVxnQ8aBAA--.54481S2
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

The following changes since commit a5ba0a7e4e150d1350a041f0d0ef9ca6c8d7c307:

  Merge tag 'pull-aspeed-20241211' of https://github.com/legoater/qemu into staging (2024-12-11 15:16:47 +0000)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git pull-loongarch-20241213

for you to fetch changes up to 78aa256571aa06f32001bd80635a1858187c609b:

  hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic (2024-12-13 14:39:39 +0800)

----------------------------------------------------------------
pull-loongarch-20241213

----------------------------------------------------------------
Bibo Mao (8):
      include: Add loongarch_pic_common header file
      include: Move struct LoongArchPCHPIC to loongarch_pic_common header file
      hw/intc/loongarch_pch: Merge instance_init() into realize()
      hw/intc/loongarch_pch: Rename LoongArchPCHPIC with LoongArchPICCommonState
      hw/intc/loongarch_pch: Move some functions to file loongarch_pic_common
      hw/intc/loongarch_pch: Inherit from loongarch_pic_common
      hw/intc/loongarch_pch: Add pre_save and post_load interfaces
      hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic

 hw/intc/loongarch_pch_pic.c            | 106 +++++++++++----------------------
 hw/intc/loongarch_pic_common.c         |  97 ++++++++++++++++++++++++++++++
 hw/intc/meson.build                    |   2 +-
 hw/loongarch/virt.c                    |   2 +-
 include/hw/intc/loongarch_pch_pic.h    |  70 +++++-----------------
 include/hw/intc/loongarch_pic_common.h |  82 +++++++++++++++++++++++++
 6 files changed, 230 insertions(+), 129 deletions(-)
 create mode 100644 hw/intc/loongarch_pic_common.c
 create mode 100644 include/hw/intc/loongarch_pic_common.h


