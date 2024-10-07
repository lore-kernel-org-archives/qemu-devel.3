Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371CCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlrf-0007KJ-KR; Mon, 07 Oct 2024 07:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1sxlre-0007Jt-9L
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:22 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1sxlra-00017P-TG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ZmdNc
 3IF/kjBwLfNdOw4FBcA5N40qdDiUyFgWihYMr4=; b=gKySBCtJtMLaei6zLihja
 60ei4RHHV2E2X/JmMh1fmzt190S02u8BYzBoAprkCWr1e0vNN/tHLpgMkto0evCu
 MOzTF6eFYgZcabWH09CjB6FP+ggumtO12XhAYjJ9/FmyO7VxYnCdgpNNr8aJkLnX
 teU2JC17Qm4kI2Wvplvxnk=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgAnSOcMxQNnGGjGAQ--.32547S2;
 Mon, 07 Oct 2024 19:25:00 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v4 0/3] Drop ignore_memory_transaction_failures for xilink_zynq
Date: Mon,  7 Oct 2024 19:24:52 +0800
Message-ID: <cover.1728299530.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgAnSOcMxQNnGGjGAQ--.32547S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr18ur13WF1fXFW3AF1kXwb_yoWDAwc_Ar
 WSka4DXr4kZ3W3AFWkGF1kKrZIvw4I9rW8JF18try7X3yUZF13Cr1DKa4Yv3Wfua98AFZ0
 v3ZrAF1fJw1jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjyCJPUUUUU==
X-Originating-IP: [112.19.146.115]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEQpxKGcDw+gCTwAAsA
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi, maintainer,

Following the reference from the chip manualug585-Zynq-7000-TRM manual
B.3 (Module Summary), placeholders have been added for all unimplemented
devices, including the AXI and AMBA bus controllers that interact with
the FPGA.

We can check against the manual by printing the address space of the
zynq board with the following qemu command:
    ${QEMU_PATH}/qemu-system-aarch64 \
    -M xilinx-zynq-a9 \
    -display none \
    -monitor stdio -s
    (qemu) info mtree -f

The testing methodology previously discussed in earlier email exchanges
will not be repeated here.

Chao Liu (3):
  xilink_zynq: Add various missing unimplemented devices
  xilink-zynq-devcfg: Fix up for memory address range size not set
    correctly
  xilink-zynq-devcfg: Avoid disabling devcfg memory region during
    initialization

 hw/arm/xilinx_zynq.c              | 71 ++++++++++++++++++++++++++++++-
 hw/dma/xlnx-zynq-devcfg.c         |  9 +++-
 include/hw/dma/xlnx-zynq-devcfg.h |  2 +-
 3 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.46.1


