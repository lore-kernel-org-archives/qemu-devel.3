Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7687C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 07:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSuB8-0006ws-MQ; Thu, 25 Jan 2024 02:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rSuB3-0006wW-V5
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:29:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rSuB1-0007ke-Ib
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:29:33 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbevVDbJlhWwFAA--.20580S3;
 Thu, 25 Jan 2024 15:29:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxZMzVDbJlOOIYAA--.48769S2; 
 Thu, 25 Jan 2024 15:29:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/2] loongarch-to-apply queue
Date: Thu, 25 Jan 2024 15:13:16 +0800
Message-Id: <20240125071318.53255-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxZMzVDbJlOOIYAA--.48769S2
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

The following changes since commit 4a4efae44f19528589204581e9e2fab69c5d39aa:

  Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging (2024-01-23 13:40:45 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240125

for you to fetch changes up to fc70099621fe7002d30fc1509456d1ae57264aa6:

  target/loongarch/kvm: Enable LSX/LASX extension (2024-01-25 15:25:31 +0800)

----------------------------------------------------------------
pull-loongarch-20240125

----------------------------------------------------------------
Bibo Mao (1):
      target/loongarch: Set cpuid CSR register only once with kvm mode

Song Gao (1):
      target/loongarch/kvm: Enable LSX/LASX extension

 linux-headers/asm-loongarch/kvm.h |  1 +
 target/loongarch/kvm/kvm.c        | 54 +++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 10 deletions(-)


