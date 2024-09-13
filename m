Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60547FA3736
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 09:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2yS-0002ql-1m; Fri, 13 Sep 2024 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sp2yJ-0002q0-W4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:52:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sp2yF-0007Gi-Qj
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:52:10 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxpuhCC+RmE9AGAA--.14640S3;
 Fri, 13 Sep 2024 17:52:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeRCC+RmtrIFAA--.32869S2;
 Fri, 13 Sep 2024 17:52:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/loongarch/virt: Add description for virt machine type
Date: Fri, 13 Sep 2024 17:52:02 +0800
Message-Id: <20240913095202.2007024-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeRCC+RmtrIFAA--.32869S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

The description about virt machine type is removed by mistake, add
new description here. Here is output result with command
"./qemu-system-loongarch64 -M help"

Supported machines are:
none                 empty machine
virt                 QEMU LoongArch Virtual Machine (default)
x-remote             Experimental remote machine

Without the patch, it shows as follows:
Supported machines are:
none                 empty machine
virt                 (null) (default)
x-remote             Experimental remote machine

Fixes: ef2f11454c(hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI)
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 29040422aa..8e80110b24 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1390,6 +1390,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->init = virt_init;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
     mc->default_ram_id = "loongarch.ram";
+    mc->desc = "QEMU LoongArch Virtual Machine";
     mc->max_cpus = LOONGARCH_MAX_CPUS;
     mc->is_default = 1;
     mc->default_kernel_irqchip_split = false;

base-commit: 4b7ea33074450bc6148c8e1545d78f179e64adb4
-- 
2.39.3


