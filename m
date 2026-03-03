Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0646EB3648
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxENg-00054f-9B; Mon, 02 Mar 2026 20:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vxENL-0004zi-Ev
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:40 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vxENE-00088G-Um
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:36 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxacJoNqZpEuMWAA--.2616S3;
 Tue, 03 Mar 2026 09:16:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx_8JfNqZpFmpNAA--.16102S2;
 Tue, 03 Mar 2026 09:16:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] loongarch-to-apply queue
Date: Tue,  3 Mar 2026 08:50:53 +0800
Message-Id: <20260303005101.3561064-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx_8JfNqZpFmpNAA--.16102S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:

  Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260302

for you to fetch changes up to 45e3ef638e73799815a07a31041afe162d856dc3:

  target/loongarch: Add some CPUCFG bits with host CPU model (2026-03-02 18:02:38 +0800)

----------------------------------------------------------------
pull-loongarch-20260302

----------------------------------------------------------------
Bibo Mao (8):
      target/loongarch: Add missing vCPU features with QMP method
      target/loongarch: Add full type support with query-cpu-model-expansion
      target/loongarch: Add property set with query-cpu-model-expansion
      target/loongarch: Add detailed information with CPU Product ID
      target/loongarch: Add default cpucfg3 with LA464 CPU
      target/loongarch: Add generic CPU model information
      target/loongarch: Add host CPU model in kvm mode
      target/loongarch: Add some CPUCFG bits with host CPU model

 hw/loongarch/virt.c                   |   6 +-
 target/loongarch/cpu.c                | 160 +++++++++++++++++++++++++++++++++-
 target/loongarch/cpu.h                |  24 ++++-
 target/loongarch/loongarch-qmp-cmds.c |  46 +++++++---
 4 files changed, 217 insertions(+), 19 deletions(-)


