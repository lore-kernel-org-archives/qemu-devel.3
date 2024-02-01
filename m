Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9FC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRZo-000635-GM; Thu, 01 Feb 2024 02:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rVRZm-0005wv-0j
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:33:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rVRZk-00022W-6M
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:33:33 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxF+hDSbtl93QJAA--.8154S3;
 Thu, 01 Feb 2024 15:33:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxDc8_Sbtlc40rAA--.36621S2; 
 Thu, 01 Feb 2024 15:33:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/1] loongarch-to-apply queue
Date: Thu,  1 Feb 2024 15:33:18 +0800
Message-Id: <20240201073319.2849107-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc8_Sbtlc40rAA--.36621S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit bd2e12310b18b51aefbf834e6d54989fd175976f:

  Merge tag 'qga-pull-2024-01-30' of https://github.com/kostyanf14/qemu into staging (2024-01-30 15:53:46 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240201

for you to fetch changes up to 27edd5040cae63bfa92c68f69883ba81aa3b6cda:

  target/loongarch: Fix qtest test-hmp error when KVM-only build (2024-02-01 15:29:40 +0800)

----------------------------------------------------------------
pull-loongarch-20240201

----------------------------------------------------------------
Song Gao (1):
      target/loongarch: Fix qtest test-hmp error when KVM-only build

 target/loongarch/cpu.c            |   2 -
 target/loongarch/cpu_helper.c     | 231 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/internals.h      |  20 +++-
 target/loongarch/meson.build      |   1 +
 target/loongarch/tcg/tlb_helper.c | 230 -------------------------------------
 5 files changed, 250 insertions(+), 234 deletions(-)
 create mode 100644 target/loongarch/cpu_helper.c


