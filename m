Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3495C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 02:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUdat-0002kq-8S; Thu, 18 Jul 2024 22:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sUdar-0002j7-3z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:43:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sUdao-0003Lu-3N
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:43:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxdOjQ0plmPeAAAA--.4359S3;
 Fri, 19 Jul 2024 10:43:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxhsXO0plm5uxOAA--.35480S2; 
 Fri, 19 Jul 2024 10:43:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/3] loongarch-to-apply queue
Date: Fri, 19 Jul 2024 10:26:01 +0800
Message-Id: <20240719022604.781608-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxhsXO0plm5uxOAA--.35480S2
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

The following changes since commit 23fa74974d8c96bc95cbecc0d4e2d90f984939f6:

  Merge tag 'pull-target-arm-20240718' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-19 07:02:17 +1000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240719

for you to fetch changes up to 3ed016f525c8010e66be62d3ca6829eaa9b7cfb5:

  hw/loongarch: Modify flash block size to 256K (2024-07-19 10:40:04 +0800)

----------------------------------------------------------------
pull-loongarch-20240719

----------------------------------------------------------------
Song Gao (2):
      target/loongarch/gdbstub: Add vector registers support
      hw/loongarch: Remove unimplemented extioi INT_encode mode

Xianglai Li (1):
      hw/loongarch: Modify flash block size to 256K

 configs/targets/loongarch64-linux-user.mak |  2 +-
 configs/targets/loongarch64-softmmu.mak    |  2 +-
 gdb-xml/loongarch-lasx.xml                 | 60 ++++++++++++++++++++++++
 gdb-xml/loongarch-lsx.xml                  | 59 ++++++++++++++++++++++++
 include/hw/intc/loongarch_extioi.h         |  1 -
 include/hw/loongarch/virt.h                |  2 +-
 target/loongarch/gdbstub.c                 | 73 +++++++++++++++++++++++++++++-
 7 files changed, 193 insertions(+), 6 deletions(-)
 create mode 100644 gdb-xml/loongarch-lasx.xml
 create mode 100644 gdb-xml/loongarch-lsx.xml


