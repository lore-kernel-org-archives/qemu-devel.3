Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A14CEBF89
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su6i9-0005R1-B3; Fri, 27 Sep 2024 04:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1su6i4-0005J6-Li
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 04:52:20 -0400
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1su6i0-0005oR-5f
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 04:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=cH1uO
 /jZ4N875H+lKdc9i+XyQ72WmTPa9RRpilxjzNI=; b=XFXyDhBIW0ZwAODcvxhWL
 HEgIYbcSB6r/C+X8ful4F6bWoSOnbre5GYneJTwLg/bKT+6gpYsZdHpUp5/4ZlaJ
 tIc9xaw6e5xjZn4A9WA0Yg90OGfRfTbj+8Q4EcGnROkNvchnutaC28UnXidINOjY
 BVmpAT40XLJlJr8l8U1cj8=
Received: from localhost.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgD31KoOcvZmhEQ4AQ--.49283S2;
 Fri, 27 Sep 2024 16:51:26 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v2 0/2] Drop ignore_memory_transaction_failures for xilink_zynq
Date: Fri, 27 Sep 2024 16:51:17 +0800
Message-ID: <cover.1727425255.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgD31KoOcvZmhEQ4AQ--.49283S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DAr13tFy3CrWrAr17GFg_yoW8try5pr
 4rKa15KryrGrn7XrZ3Wan7GF4Fqwn3Aan5Gr47A34agFZxCr9ay395KayYq347WFnFqF1f
 Xr1jva1F9w17taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jXku7UUUUU=
X-Originating-IP: [117.173.247.123]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCxhnKGb2K8rKhAAAsj
Received-SPF: pass client-ip=220.197.32.17; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi, thank you for your prompt reply, it's a great encouragement to me!

Based on your review suggestions, I have improved the v1 patch.

By using create_unimplemented_device() during the initialization phase,
I added a "znyq.umip" device early on, which covers the 32-bit address space
of GPA. This can better serve as a replacement for the effect of the
ignore_memory_transaction_failures flag.

Since create_unimplemented_device() sets the priority of the
memory region (mr) to -100, normally created devices will override the address
segments corresponding to the unimplemented devices.

Even if our test set is not sufficiently comprehensive, we can create an
unimp_device for the maximum address space allowed by the board. This prevents
the guest system from triggering unexpected exceptions when accessing
unimplemented devices or regions.

Additionally, I still use create_unimplemented_device() for other
unimplemented devices. This makes it easier to debug when these devices
are added later.

Finally, here are my testing steps:

Step 1, Referring to the Xilinx Wiki,
I compiled a Linux kernel binary image for convenience in testing.
You can directly obtain it via:

git clone https://github.com/zevorn/QEMU_CPUFreq_Zynq.git

Step 2, Use the following command to run the QEMU:

./qemu/build/qemu-system-arm -M xilinx-zynq-a9 \
-serial /dev/null \
-serial mon:stdio \
-display none \
-kernel QEMU_CPUFreq_Zynq/Prebuilt_functional/kernel_standard_linux/uImage \
-dtb QEMU_CPUFreq_Zynq/Prebuilt_functional/my_devicetree.dtb \
--initrd QEMU_CPUFreq_Zynq/Prebuilt_functional/umy_ramdisk.image.gz

If there are no issues during execution and it boots successfully
into the terminal, for example:

...

PetaLinux 2016.4 zedboard-zynq7 /dev/ttyPS0
zedboard-zynq7 login: 
root
root@zedboard-zynq7:~#


Chao Liu (2):
  xilink_zynq: Add various missing unimplemented devices
  xilink-zynq-devcfg: Fix up for memory address range size not set
    correctly

 hw/arm/xilinx_zynq.c      | 46 ++++++++++++++++++++++++++++++++++++++-
 hw/dma/xlnx-zynq-devcfg.c |  2 +-
 2 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.46.1


