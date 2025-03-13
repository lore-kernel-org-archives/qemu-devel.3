Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FAFC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsedk-0005rf-SG; Thu, 13 Mar 2025 05:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsede-0005qF-IQ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:14:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsedb-0000n8-Mf
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:14:02 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxvnLPodJnr7+UAA--.56838S3;
 Thu, 13 Mar 2025 17:13:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfOodJnGD1IAA--.8822S4;
 Thu, 13 Mar 2025 17:13:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
Date: Thu, 13 Mar 2025 17:13:49 +0800
Message-Id: <20250313091350.3770394-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250313091350.3770394-1-maobibo@loongson.cn>
References: <20250313091350.3770394-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfOodJnGD1IAA--.8822S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

There is NULL pointer checking function error_propagate() already,
it is not necessary to add checking for function parameter. Here remove
NULL pointer checking with function parameter.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a5840ff968..ab951fc642 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -913,9 +913,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
     numa_cpu_pre_plug(cpu_slot, dev, &err);
 out:
-    if (err) {
-        error_propagate(errp, err);
-    }
+    error_propagate(errp, err);
 }
 
 static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
@@ -935,9 +933,7 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
     }
 
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
-    if (err) {
-        error_propagate(errp, err);
-    }
+    error_propagate(errp, err);
 }
 
 static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
@@ -1001,9 +997,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
 
     if (lvms->acpi_ged) {
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
-        if (err) {
-            error_propagate(errp, err);
-        }
+        error_propagate(errp, err);
     }
 
     return;
-- 
2.39.3


