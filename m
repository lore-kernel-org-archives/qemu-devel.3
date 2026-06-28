Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2D5C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 07:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdjaN-0002MG-4T; Sun, 28 Jun 2026 03:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wdjaG-0002LV-HW; Sun, 28 Jun 2026 03:05:41 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wdjaC-00088z-6W; Sun, 28 Jun 2026 03:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782630319; bh=ezyJrcALkX15oXfiEHGHOM/lUwEfSZkdajYP9d8kBoQ=;
 h=From:To:Cc:Subject:Date;
 b=CahRQ5IHreuqjDYoTCS/YTyY1cPD2+zf00UwybobeaO+t56Yiyippuck8fkTowA7k
 e2eqe93dw/K+gjtaIgWLnRDLwGWnt26T3eMEg+cAGrN/4t1/j1J4BhI5ymPE8MrovU
 f36MS6Y3Fn41Dp30X5Lk2hofvvBIR2fLueolJF/w=
Received: from qq.com ([110.184.149.103])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 813B641; Sun, 28 Jun 2026 15:02:01 +0800
X-QQ-mid: xmsmtpt1782630121t0nmk564g
Message-ID: <tencent_AB4D09097B1EC06F8C6CD11DF2C14E8A6D05@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfIn2Z1L3Zv8y68yBDn5+EvzGjUNDKbhNSOzwdb8WbqO+MKfMWhW
 VS9pYDMdoD7lO7CKTzuBrmd+eT5zLosEyHKm3Tx7gxtBDoJpAWaxlKbNTXu6bT++RY8chPjsBk/W
 ZO5vaCbV5Xkhy2Ui2PsPnnFCj/3eiHwbD7WujKZW0yzQI8DnS+m1h9SVnDmDTfXH8vEQi2Sec7we
 0QUM2aaAI9JGgpQqFYgOUkFDKLPLoijXdeIJHeGwkhrIRjtx79DmmoS6KwDIVsLiqZR3Jo9W1EV4
 GpVycmQIFVYtoaknlCcWIfA4cTFEP9fr8zGDhwMk3+4jPvvCeqjSWfvRhOUGKojALG9ekTvXXKA8
 QiF/aGLpsHP8MABX8GIlu7RwbCSkWPSFu9pHf10IFdS1xkiINpneaBcP/XLuYDvb6YqsLK/x5M53
 6kEVr/ezcmQl5dYTmVeO34wS0B/k4x44Wl4P64I8DG7i/PePBQIjuZNDZ8oonEojeTGEGY0st8hw
 sobvHYcjTsGW3XsH0dB2b0mk14oZHUcbSJJkBqNhJFLo7hbWminDz5GF6rAYddss04xqvNpm6SqE
 itWGP9TRyu73fsoFn6KPusjCFmx+OsHxxpZA5Y8dapUdAgWrBDoB/fqDObCY2tNVk+fHaEZCV0N5
 RD3z7ZUdvx12H0uaMg2+yLxhcjYVXMHZUH72wSBL+GqirDiUWq7VwFtIp67MQz/OQdyMWrv4eeDp
 B0K0YRj5Ht4PHT+sVZgqf3cgNdOdosJEwne01Qz+kp8AKtPvQF8g9wLcJUmgRmX9D0JSal4L20Sq
 TaAfIUgTEU8XM/70wQy58d2Yo0458lw51Cj+O6iSGrbZDYLF3hAA+Od7rKoBryL8DQEvYVv5do3k
 PX4h+cyR8DQnfS9ukfbVJtUFQjL57Fnowb4i06ajxDtkG4kOnUnJizSezCQgCFB3GhOzr7JDLoub
 Y5gwN7c8upvt8yXDK8QcAcBmr6dGfNLSHjNckQZsmQYXjyAbI0kGgixRew7vihJdarJPR8CnI86g
 qF6hKr8J4mMg7gtLsYCkxrFSbNs2YQd19l4TX/OSS1clDjr85S9539Fe9LsSY=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v1] riscv/virt: Add secondary UART
Date: Sun, 28 Jun 2026 15:01:49 +0800
X-OQ-MSGID: <20260628070149.58048-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.47; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds secondary UART device to RiscV virt board to simplify
multi-core bare-metal development as Virtio needs comparably
more work.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 hw/riscv/virt.c         | 33 +++++++++++++++++++++++----------
 include/hw/riscv/virt.h |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..d414953d6f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -86,6 +86,7 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_MROM] =         {     0x1000,        0xf000 },
     [VIRT_TEST] =         {   0x100000,        0x1000 },
     [VIRT_RTC] =          {   0x101000,        0x1000 },
+    [VIRT_UART1] =        {   0x102000,         0x100 },
     [VIRT_CLINT] =        {  0x2000000,       0x10000 },
     [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
@@ -186,7 +187,8 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
                           FDT_MAX_INT_MAP_WIDTH] = {};
     uint32_t *irq_map = full_irq_map;
 
-    /* This code creates a standard swizzle of interrupts such that
+    /*
+     * This code creates a standard swizzle of interrupts such that
      * each device's first interrupt is based on it's PCI_SLOT number.
      * (See pci_swizzle_map_irq_fn())
      *
@@ -832,28 +834,36 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
 }
 
 static void create_fdt_uart(RISCVVirtState *s,
-                            uint32_t irq_mmio_phandle)
+                            uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
-                           s->memmap[VIRT_UART0].base);
+                           s->memmap[memId].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_UART0].base,
-                                 2, s->memmap[VIRT_UART0].size);
+                                 2, s->memmap[memId].base,
+                                 2, s->memmap[memId].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", UART0_IRQ);
+        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
     } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
+        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
     }
 
-    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
+    if (VIRT_UART0 == memId) {
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
+    }
+}
+
+static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
+{
+    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
+    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s,
@@ -1023,7 +1033,7 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_reset(s, &phandle);
 
-    create_fdt_uart(s, irq_mmio_phandle);
+    create_fdt_uarts(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
 }
@@ -1566,6 +1576,9 @@ static void virt_machine_init(MachineState *machine)
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
+    serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
+        0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
+        serial_hd(1), DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..d27bab9f64 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -78,6 +78,7 @@ enum {
     VIRT_APLIC_S,
     VIRT_UART0,
     VIRT_VIRTIO,
+    VIRT_UART1,
     VIRT_FW_CFG,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
@@ -93,6 +94,7 @@ enum {
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    UART1_IRQ = 12,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
-- 
2.34.1


