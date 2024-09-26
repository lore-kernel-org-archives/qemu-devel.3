Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E23CDE026
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 17:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1strvh-0000dh-8T; Thu, 26 Sep 2024 13:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1strvf-0000cT-5A
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 13:05:23 -0400
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1strvZ-0003kM-Qm
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 13:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=nj4Pj
 I6uuLYGapn6bpIBKWVqJYUrBwm0veoDZb9bxwU=; b=T79+aUShud2/dEj4cRaJb
 izN8XXDXnGr0BVg3TNCJXwSDu1uyXzyD854Igg6IJlFBt7cU3dbiRLrU/O40dUAS
 B6zGE9A6czo0r2Eycbxsjq/84OtWY7ZSQj75zUpKBVV8r1CaGIDFvXgD0kTnz9xf
 4hhp7Tw9ighW0GmN2K1b38=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgBn5Zs4lPVmxE8yAQ--.46443S2;
 Fri, 27 Sep 2024 01:04:56 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me
Subject: [PATCH v1 0/2] Re: Drop ignore_memory_transaction_failures for
 xilink_zynq
Date: Fri, 27 Sep 2024 01:04:51 +0800
Message-ID: <20240926170451.1479647-1-chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgBn5Zs4lPVmxE8yAQ--.46443S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try3WFy7KFWrKw18GF4Uurg_yoW8JFyUpr
 WUAFs8Gry8Kry3Za4fXrsrZw1ava95A34Utry3Jwn8G3W3CFnrZrZ5KanxG3WDWr1vqa1a
 qry7XF1UurnrZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jB9a9UUUUU=
X-Originating-IP: [117.173.244.102]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEg1lKGbz8ewFcgACsv
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

> The ignore_memory_transaction_failures is used for compatibility
> with legacy board models. 
> 
> I attempted to remove this property from the
> xilink_zynq board and replace it with unimplemented devices to 
> handle devices that are not implemented on the board.
> 
> Chao Liu (2):
>   xilink_zynq: Add various missing unimplemented devices
>   xilink-zynq-devcfg: Fix up for memory address range size not set
>     correctly
> 
>  hw/arm/xilinx_zynq.c      | 44 ++++++++++++++++++++++++++++++++++++++-
>  hw/dma/xlnx-zynq-devcfg.c |  2 +-
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> -- 
> 2.46.1

Hello, maintainers,

Could you please provide any suggestions or feedback on the set of patches?
This is my first contribution to the QEMU community,
and it makes me feel very honored.

Additionally, I have used creat_unimplemented_device() to
add all the unimplemented devices on the Xilinx Zynq board,
primarily referencing the Zynq DTS, located at

roms/u-boot/arch/arm/dts/zynq-7000.dtsi.

You can verify whether all the board devices have been added correctly by
following these commands:

Step1:
./qemu/build/qemu-system-arm -M xilinx-zynq-a9 -display none -monitor stdio

Step2:
(qemu) info mtree

I am looking forward to your reply.

Regards,
Chao Liu


