Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE916CF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 16:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx7Je-0008Rf-ER; Sat, 05 Oct 2024 12:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1sx7Jc-0008RQ-RX
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:07:32 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1sx7Ja-0002g9-GO
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=7lgE9
 Pduy+d6LWKiDl6tG7Ph71Teiyd+BOMZBtSs6OY=; b=V8EZo+Kvf828oWIK5iIpl
 JMcOrH9xkNqOq8CaF2QZGKctFXU+XZdbPoisSwg3Z9id7AaOI6Bd2IJU+KanTUzc
 wEtOTqny5rpjobXb2WgAQWP/5ke4dSGsFnSY7BtoE3q6TlhSTTK6GlMTXVg0++Hk
 YJoMgGq+FU28jfGvgqSxkY=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgCnyun1YwFnyEiwAQ--.25016S2;
 Sun, 06 Oct 2024 00:06:14 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v3 0/2] Drop ignore_memory_transaction_failures for xilink_zynq
Date: Sun,  6 Oct 2024 00:06:04 +0800
Message-ID: <cover.1728141040.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgCnyun1YwFnyEiwAQ--.25016S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw45GF15Gw4UGr4xJFy8uFg_yoW5Gr4xpr
 Z8Xrs0gryFyF9rJr4kKw15ta1Yqa9ayF1UXr15Jrn0krZ8CFWfAFyqya43X398ur1vgry8
 ur1jvFy7ur95taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0eHgUUUUU=
X-Originating-IP: [112.19.146.115]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEQZvKGcBIOd5AwAAsL
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi all,

Following the Zynq-7000 SoC Data Sheet's "Memory Map" section (referenced at [1]),

We have identified the need to create placeholders for unimplemented devices
across the entire range of Zynq-7000 series boards.

This effort aims at ensuring maximum compatibility with different models
within the series.

The following table summarizes the relevant memory map addresses
for the Zynq-7000:

    Start Address  Size (MB)       Description
    0x0000_0000    1,024           DDR DRAM and on-chip memory (OCM)
    0x4000_0000    1,024           PL AXI slave port #0
    0x8000_0000    1,024           PL AXI slave port #1
    0xE000_0000    256             IOP devices
    0xF000_0000    128             Reserved
    0xF800_0000    32              Programmable registers access via AMBA APB bus
    0xFA00_0000    32              Reserved
    0xFC00_0000    64 MB - 256 KB  Quad-SPI linear address base address (except
                                   to 256 KB which is in OCM), 64 MB reserved,
                                   only 32 MB is currently supported
    0xFFFC_0000    256 KB          OCM when mapped to high address space

For the purposes of this patch, we will not be creating placeholders for
DRAM and any reserved regions of the address space.

A test script has been developed that covers the most common board types of
the Zynq-7000 series.

The test script obtained all linux binary images of the zynq-7000 series boards
from xilinx-wiki for script testing(referenced at [2]).

The steps to run the test are as follows:

    a) Clone the repository.
    git clone -b xilinx-zynq-test https://github.com/gevico/qemu-board.git

    b) Apply the patch attached to this email and compile QEMU.

    c) Set the environment variable for the path to your QEMU.
    export QEMU_PATH=<your qemu path>

    d) Execute the testing script.
    ./qemu-zynq-test

    e) Check the results.
    If successful, the output should resemble the following:

    Test Project: <your path>/qemu-board/hw/arm/xilinx-zynq
        Start 1: xilinx-zynq.zc702
    1/3 Test #1: xilinx-zynq.zc702 ......................   Passed
        Start 2: xilinx-zynq.zc706
    2/3 Test #2: xilinx-zynq.zc706 ......................   Passed
        Start 3: xilinx-zynq.zed  
    3/3 Test #3: xilinx-zynq.zed   ......................   Passed

    All tests passed

See:
[1]: https://www.amd.com/content/dam/xilinx/support/documents/data_sheets/ds190-Zynq-7000-Overview.pdf
[2]: http://www.wiki.xilinx.com/Zynq+2016.2+Release

Chao Liu (2):
  xilink_zynq: Add various missing unimplemented devices
  xilink-zynq-devcfg: Fix up for memory address range size not set
    correctly

 hw/arm/xilinx_zynq.c      | 12 +++++++++++-
 hw/dma/xlnx-zynq-devcfg.c |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.46.1


