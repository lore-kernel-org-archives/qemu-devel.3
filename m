Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D3C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 09:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6o8p-0007l9-CB; Tue, 14 May 2024 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s6o8m-0007ks-1S
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:08:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s6o8j-0001L1-6O
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:08:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxk+rtKUNm1Z4MAA--.18313S3;
 Tue, 14 May 2024 17:07:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx0VXsKUNmNUAeAA--.37396S2; 
 Tue, 14 May 2024 17:07:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Add extioi virt extension support
Date: Tue, 14 May 2024 17:07:54 +0800
Message-Id: <20240514090756.988096-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx0VXsKUNmNUAeAA--.37396S2
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

Base-on: <20240514025109.3238398-1-maobibo@loongson.cn>

On LoongArch, IRQs can be routed to four vcpus with hardware extioi.
This patch adds the extioi virt extension support so that the IRQ can
route to 256 vcpus.  

v2:
- Split the patch to two small patch.
- Drop 'RFC' title. extioi virt extension suport only enable on kvm
  mode and  the extioi driver need patch[1].
  but this series do not affect the old codes in any way.
- Link to v1: https://lore.kernel.org/all/20240116022526.498613-1-gaosong@loongson.cn/#r

[1]: https://gitee.com/openeuler/kernel/commit/5d97cff72f91f4f20a536efd60eca75bfcb78a64

Thanks.
Song Gao.

Song Gao (2):
  hw/intc/loongarch_extioi: Add extioi virt extension definition
  hw/loongarch/virt: Enable extioi virt extension

 include/hw/intc/loongarch_extioi.h |  21 ++++++
 include/hw/loongarch/virt.h        |   2 +
 target/loongarch/cpu.h             |   1 +
 hw/intc/loongarch_extioi.c         |  92 ++++++++++++++++++++++-
 hw/loongarch/virt.c                | 117 +++++++++++++++++++++++++----
 5 files changed, 215 insertions(+), 18 deletions(-)

-- 
2.25.1


