Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B26CCF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 08:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1supOc-0006iy-E6; Sun, 29 Sep 2024 04:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1supOZ-0006hZ-E8
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 04:35:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1supOS-0006Gd-83
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 04:35:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxrnMwEflmz70DAA--.3376S3;
 Sun, 29 Sep 2024 16:34:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn+QtEflmFt0UAA--.54891S2;
 Sun, 29 Sep 2024 16:34:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/7] loongarch-to-apply queue
Date: Sun, 29 Sep 2024 16:17:17 +0800
Message-Id: <20240929081724.2139556-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+QtEflmFt0UAA--.54891S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

The following changes since commit 3b14a767eaca3df5534a162851f04787b363670e:

  Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu into staging (2024-09-28 12:34:44 +0100)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240929

for you to fetch changes up to f7c8ef7bad7495d8c84b262a8b243efe39e56b13:

  hw/loongarch/fw_cfg: Build in common_ss[] (2024-09-29 16:22:56 +0800)

----------------------------------------------------------------
pull-loongarch-20240929

----------------------------------------------------------------
Bibo Mao (3):
      acpi: ged: Add macro for acpi sleep control register
      hw/loongarch/virt: Add FDT table support with acpi ged pm register
      target/loongarch: Avoid bits shift exceeding width of bool type

Jiaxun Yang (2):
      hw/loongarch/boot: Refactor EFI booting protocol generation
      hw/loongarch/boot: Rework boot code generation

Philippe Mathieu-Daudé (2):
      hw/loongarch/virt: Remove unnecessary 'cpu.h' inclusion
      hw/loongarch/fw_cfg: Build in common_ss[]

 hw/acpi/generic_event_device.c         |   6 +-
 hw/loongarch/boot.c                    | 321 +++++++++++++++++++++------------
 hw/loongarch/meson.build               |   2 +-
 hw/loongarch/virt.c                    |  39 ++++
 include/hw/acpi/generic_event_device.h |   7 +-
 include/hw/loongarch/boot.h            | 106 +++++++++--
 include/hw/loongarch/virt.h            |   1 -
 target/loongarch/arch_dump.c           |   6 +-
 8 files changed, 342 insertions(+), 146 deletions(-)


