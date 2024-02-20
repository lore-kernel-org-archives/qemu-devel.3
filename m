Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3063C54788
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPRP-0003AJ-BH; Tue, 20 Feb 2024 07:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rcPRM-00039l-O6
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:40 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rcPRH-0000DA-AA
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:40 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxfev5ndRlQD8PAA--.39625S3;
 Tue, 20 Feb 2024 20:41:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxPs_3ndRl5MM8AA--.25558S6; 
 Tue, 20 Feb 2024 20:41:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/loongarch: Set minimium memory size as 256M
Date: Tue, 20 Feb 2024 20:41:25 +0800
Message-Id: <20240220124126.1164081-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220124126.1164081-1-maobibo@loongson.cn>
References: <20240220124126.1164081-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPs_3ndRl5MM8AA--.25558S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKrWkZF47Gw13Wr15Gry5Jrc_yoW8JrW3pr
 ZxAF4kZF42qrZFya4rAryDur1Dtws7A3W2gFsrAw4YkFs8u34kXr4Sy3409FWUAaykXF1v
 vFnYkw1jq3Wav3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The minium memory size for LoongArch UEFI bios is 256M, also some
test cases such as migration and qos uses parameter 256M.

Here set minium memory size for Loongarch VirtMachine with 256M,
also default memory size is changed with 256M.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a7d700497d..5bc332f4e3 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -815,8 +815,8 @@ static void virt_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (ram_size < 1 * GiB) {
-        error_report("ram_size must be greater than 1G.");
+    if (ram_size < 256 * MiB) {
+        error_report("ram_size must be greater than 256M.");
         exit(1);
     }
     create_fdt(vms);
@@ -1144,7 +1144,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = virt_init;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = 256 * MiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
     mc->default_ram_id = "loongarch.ram";
     mc->max_cpus = LOONGARCH_MAX_CPUS;
-- 
2.39.3


