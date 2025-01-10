Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAxA-0001yy-7i; Fri, 10 Jan 2025 04:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tWAwm-0001fW-V5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tWAwi-0005Nx-Gd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:52 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxuuCl4oBn0g9hAA--.61126S3;
 Fri, 10 Jan 2025 17:04:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx7sWk4oBn718cAA--.42742S2;
 Fri, 10 Jan 2025 17:04:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/intc/loongarch_extioi: CPU irq routing enhancement
Date: Fri, 10 Jan 2025 17:04:32 +0800
Message-Id: <20250110090436.2831690-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx7sWk4oBn718cAA--.42742S2
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

LoongArch extioi can send intterrupt to multiple CPUs, physical cpu id is
used to route interrupt for CPUs.

With cpu hotplug feature in future, notification for extioi interrupt
controller is required. Here cpu hotplug interface is added on extioi
class, so that gpio irq line is connected to cpu irq line, and irq
routing can be setup.

Bibo Mao (4):
  hw/intc/loongarch_extioi: Move gpio irq initial to common code
  hw/intc/loongarch_extioi: Add basic hotplug framework
  hw/intc/loongarch_extioi: Implment cpu hotplug interface
  hw/intc/loongarch_extioi: Use cpu plug notification

 hw/intc/loongarch_extioi.c        |  8 +--
 hw/intc/loongarch_extioi_common.c | 84 ++++++++++++++++++++++++++++++-
 hw/loongarch/virt.c               | 12 ++---
 3 files changed, 87 insertions(+), 17 deletions(-)


base-commit: bc6afa1c711da5b4f37c9685a812c77b114d84cb
-- 
2.39.3


