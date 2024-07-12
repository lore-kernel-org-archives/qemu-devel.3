Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C28C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5UA-0002i0-IX; Thu, 11 Jul 2024 21:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sS5U8-0002gd-6J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sS5U5-0007Ev-6L
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxP_G7jJBmloQDAA--.10538S3;
 Fri, 12 Jul 2024 09:54:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnsezjJBmVSdFAA--.27574S6; 
 Fri, 12 Jul 2024 09:54:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 4/8] MAINTAINERS: Add myself as a reviewer of LoongArch virt
 machine
Date: Fri, 12 Jul 2024 09:36:28 +0800
Message-Id: <20240712013632.3464731-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240712013632.3464731-1-gaosong@loongson.cn>
References: <20240712013632.3464731-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnsezjJBmVSdFAA--.27574S6
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

I would like to be informed on changes made to the LoongArch virt machine.

I'm fairly familiar with Loongson-3 series platform hardware and doing
firmwre (U-Boot) development as hobbyist on LoongArch virt platform,
so I believe I can give positive review input to changes on that machine.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240627-ipi-fixes-v1-2-9b061dc28a3a@flygoat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b..41bece23c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1240,6 +1240,7 @@ LoongArch Machines
 ------------------
 Virt
 M: Song Gao <gaosong@loongson.cn>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: docs/system/loongarch/virt.rst
 F: configs/targets/loongarch64-softmmu.mak
-- 
2.34.1


