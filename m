Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFF7CF537D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uOl-00047n-Le; Thu, 24 Oct 2024 05:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3uOj-00044U-0x
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:44:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3uOf-0002ZD-BK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:44:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxQK8JFxpnHG4KAA--.458S3;
 Thu, 24 Oct 2024 17:44:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxPMICFxpnHi0PAA--.1186S6;
 Thu, 24 Oct 2024 17:44:41 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 4/6] linux-headers: loongarch: Add kvm_para.h and unistd_64.h
Date: Thu, 24 Oct 2024 17:26:23 +0800
Message-Id: <20241024092626.1328049-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241024092626.1328049-1-gaosong@loongson.cn>
References: <20241024092626.1328049-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPMICFxpnHi0PAA--.1186S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

KVM LBT supports on LoongArch depends on the linux-header file
kvm_para.h, also unistd_64.h is required by unistd.h on LoongArch
since 6.11, otherwise there will be compiling error such as:

linux-headers/asm/unistd.h:3:10: fatal error: asm/unistd_64.h: No such file or directory
 #include <asm/unistd_64.h>

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20241017020708.1728620-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 scripts/update-linux-headers.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index c34ac6454e..3c411f0318 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -186,6 +186,10 @@ EOF
     if [ $arch = riscv ]; then
         cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
     fi
+    if [ $arch = loongarch ]; then
+        cp "$hdrdir/include/asm/kvm_para.h" "$output/linux-headers/asm-loongarch/"
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-loongarch/"
+    fi
 done
 arch=
 
-- 
2.34.1


