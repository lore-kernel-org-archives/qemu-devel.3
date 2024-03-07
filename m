Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD98C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF7F-0000y4-8J; Thu, 07 Mar 2024 09:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riF7D-0000vL-Oh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riF79-0003Zx-HO
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:59 -0500
Received: from loongson.cn (unknown [43.156.43.207])
 by gateway (Coremail) with SMTP id _____8BxC+m71Oll_PMVAA--.34426S3;
 Thu, 07 Mar 2024 22:52:43 +0800 (CST)
Received: from VM-4-14-ubuntu.. (unknown [43.156.43.207])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs2Y1OllbElQAA--.15045S17; 
 Thu, 07 Mar 2024 22:52:42 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 15/17] hw/loongarch: fdt remove unused irqchip node
Date: Thu,  7 Mar 2024 22:52:05 +0800
Message-Id: <20240307145207.247913-16-gaosong@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307145207.247913-1-gaosong@loongson.cn>
References: <20240307145207.247913-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs2Y1OllbElQAA--.15045S17
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW7Zr47tw1xWr1DKF13KFX_yoW8uw1kpF
 W3ZasrZrW7Jr1vgrs2v345u3y3Ar1DGrW7Xw42krWSya4DuwnxXrWxA34xZFy8W348Xas0
 vFsYqryxX3WIgrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-16-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index d00343f0c2..c80732a223 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -446,34 +446,6 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_irqchip_node(LoongArchMachineState *lams)
-{
-    MachineState *ms = MACHINE(lams);
-    char *nodename;
-    uint32_t irqchip_phandle;
-
-    irqchip_phandle = qemu_fdt_alloc_phandle(ms->fdt);
-    qemu_fdt_setprop_cell(ms->fdt, "/", "interrupt-parent", irqchip_phandle);
-
-    nodename = g_strdup_printf("/intc@%lx", VIRT_IOAPIC_REG_BASE);
-    qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 0x2);
-    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
-
-    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
-                            "loongarch,ls7a");
-
-    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
-                                 2, VIRT_IOAPIC_REG_BASE,
-                                 2, PCH_PIC_ROUTE_ENTRY_OFFSET);
-
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", irqchip_phandle);
-    g_free(nodename);
-}
-
 static void fdt_add_memory_node(MachineState *ms,
                                 uint64_t base, uint64_t size, int node_id)
 {
@@ -1011,8 +983,7 @@ static void loongarch_init(MachineState *machine)
 
     /* Initialize the IO interrupt subsystem */
     loongarch_irq_init(lams);
-    fdt_add_irqchip_node(lams);
-    platform_bus_add_all_fdt_nodes(machine->fdt, "/intc",
+    platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
                                    VIRT_PLATFORM_BUS_BASEADDRESS,
                                    VIRT_PLATFORM_BUS_SIZE,
                                    VIRT_PLATFORM_BUS_IRQ);
-- 
2.34.1


