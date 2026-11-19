Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AA606A33E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTs7S-0000rZ-Sm; Wed, 18 Nov 2026 21:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7O-0000pY-Gy; Wed, 18 Nov 2026 21:43:22 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7K-0005St-Qe; Wed, 18 Nov 2026 21:43:22 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowAD3Hfg8Yv5qZFtAAQ--.232S2;
 Thu, 19 Nov 2026 10:43:09 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 0/3] hw/riscv: iommu: Add migration support
Date: Thu, 19 Nov 2026 10:42:47 +0800
Message-ID: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3Hfg8Yv5qZFtAAQ--.232S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4rZFWUKF4kXrWUGr4xtFb_yoW8Wr4xpF
 4rWa4Fyanxtrn7JFnxJ3yUGryYqan5ur1YqrsrA348trZ8WF18ZF9Fqa45Xr95tFWFgryU
 Z34Fgw1UuF1jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
 0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
 x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
 0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb9NVDUUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds migration support for the emulated RISC-V IOMMU,
covering both PCI and system-bus devices.

The common IOMMU state is migrated using VMState, including the
registers, device directory configuration, and command, fault,
and page-request queue state. HPM cycle counter state and the
overflow timer are saved in a separate subsection, while the
event-to-counter mapping is reconstructed after loading.

For the PCI device, the existing PCI and MSI-X migration helpers
are used to preserve the configuration space, MSI-X table, and
pending bit array. The system-bus device saves its MSI-X table
and pending bit array directly.

The series was tested with TCG and KVM live migration of
RISC-V Linux guests using both PCI and system-bus IOMMUs.
NVMe and e1000e DMA continued working after migration.
Queue, interrupt, and HPM state restoration were also tested
with qtest.

KVM live migration was tested with the following AIA
migration series applied:
https://lore.kernel.org/qemu-devel/20261026024048.630015-1-wang.yechao255@zte.com.cn/

Tan Chi (3):
  hw/riscv: iommu: Add migration support for common state
  hw/riscv: iommu-pci: Add migration support
  hw/riscv: iommu-sys: Add migration support

 hw/riscv/riscv-iommu-hpm.c | 27 +++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |  2 ++
 hw/riscv/riscv-iommu-pci.c | 22 +++++++++++++---
 hw/riscv/riscv-iommu-sys.c | 21 +++++++++++++++
 hw/riscv/riscv-iommu.c     | 54 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+), 4 deletions(-)

-- 
2.53.0


