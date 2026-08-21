Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CC6C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1V-000272-L4; Fri, 21 Aug 2026 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1M-0001Vb-TB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1L-0007ak-2a
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so446914f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310165; x=1787914965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OAAP3zU5qLV8bnrzcXkXKuYek438ivdUFWO5xk5urTk=;
 b=fYahDygYgmfB+ViE2KzvHj+9fltg/TafkApE1ImFIJPfhDpEBvAEEF6BfXebUxyruh
 9CkcdPhIuYC3WH94+027iXzwO6jiF+fw2ipPsKPFjO30QiGbzceo4TtMyGlYQoxNVNbH
 HAMMbeRxVbKDyuw11ONppzD45/CcSoSDP0xFCxU8Iq5OOGXm+mpkZkn105ksFWrvR4le
 H+ib02X2YKd05dkF48W+nQZJAp0Jg0p7AyiUqh9FooaH2mdoi65SBub3a7mY6inr0uX7
 4Zsq1Za7/W4MVt2YbAWQzALWW8Ge+kaTNTDDt4uIOlVh/AcdXY7QgAy4zVR+R8fDAGNI
 i7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310165; x=1787914965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OAAP3zU5qLV8bnrzcXkXKuYek438ivdUFWO5xk5urTk=;
 b=HFjBI2+jFJi+2XEEtTB92VBUgiY7ZaZofvcEMmZdzBRYRYjBik3cIwSli3TEWeyVIe
 +Fu8AbmTYbev4uG44efR4hgUXO6MLKABeghp9rrynKLQz+CRxA7VylAj3g6AgjTM6rJe
 Hy2XmNIYk248kmm4U3M+PAggGnIbNDMFq+vsfIRiAJzlOX5heRr3AI6vqLDuWowJ9+At
 A8O6q5xHQdLhUbdDVkljaKwMZyDy0I9QcrTIxn5zjXwcUgqv6Waqkjed132Af5unfPIC
 1V9NlpvdC0D3OBsXKPaPUi3yVhshox9rmhHcqqcGskk2zQ5nPh7QnHb80x0myRi13aVW
 aaiA==
X-Gm-Message-State: AOJu0YxqYCkJb9wZrHGFrRFzDAAXm6tAaDlagctB8cUuKUMKCHVq4fUK
 q0Wzy13XlHQYbG05Nq9B2JPDlJ130+KP0rAPVwCQ+pmaUgX6loFz1O9UjJTYtGH/6GJ4CFXSySf
 yT3lY
X-Gm-Gg: AR+sD10MX6py2d91UpzIYDZexWrurZD4nBt0rscK17de20KehsxFOaSqOq9teIooU6A
 P+/eZrfuihtjZWlDRBTE2QqtLoY2GHBVp8fv22z4KXgAKRJ/VW86BwMoI29YF/PaQ9jA+T02MUC
 UBqjaqHxrgGqa8ZSe+SoF7GSZo5FhgLe6unLDQHzz0eaYyBH0uT3iEa40a0/JqPD3/DOW0fhjkX
 Zq8p4iUX4Kh40hDDjsxVpS1yfowgZ2KCwwNLgb6rVfQouS2bh2E+s6p/dm5mAm+cQe3Nrg9QKe5
 R9QCik0wOcrZdhSeHF4twk7XBLOdHKYJvj0dPicY4bvZTcTXam5CeWHHWPgYhJgRpiimUd3EZhj
 Vddf54fWQwVzH3gHdXW0ipHNvZMizenX+Fc7F2PgCQVJwZQ7Y016/N76rLfmPMXnxojYrhrF45m
 NWuaGmGrnoOhiW1LTx5uHbWo2JGPztvYICorxhN+lDBRAdiRnJHwADN1I6PFtAyePCy84BP+WOi
 v6rbhRbcXpOAM6bYWTDhxH0PPR5iJk5frchln3D7qg6z64BSdmAz4tAjbgl2jmWO1qxTOE=
X-Received: by 2002:a05:600c:628d:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-499b832b95cmr80408485e9.8.1787310165268; 
 Fri, 21 Aug 2026 04:02:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] hw/arm: xilinx_zynq: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:01:01 +0100
Message-ID: <20260821110101.3971391-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing ZynqMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20260816131300.51799-21-bin.meng@processmission.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c         | 17 ++++++++---------
 include/hw/arm/xilinx_zynq.h |  2 ++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c834390174..f3148975406 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -103,8 +103,6 @@ static void zynq_write_board_setup(ARMCPU *cpu,
                        sizeof(board_setup_blob), BOARD_SETUP_ADDR);
 }
 
-static struct arm_boot_info zynq_binfo = {};
-
 static void gem_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
@@ -268,7 +266,7 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
-    zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
+    zynq_machine->bootinfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
     sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
     for (n = 0; n < smp_cpus; n++) {
         /* See "hw/intc/arm_gic.h" for the IRQ line association */
@@ -444,13 +442,14 @@ static void zynq_init(MachineState *machine)
     create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
     create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
 
-    zynq_binfo.ram_size = machine->ram_size;
-    zynq_binfo.board_id = 0xd32;
-    zynq_binfo.loader_start = 0;
-    zynq_binfo.board_setup_addr = BOARD_SETUP_ADDR;
-    zynq_binfo.write_board_setup = zynq_write_board_setup;
+    zynq_machine->bootinfo.ram_size = machine->ram_size;
+    zynq_machine->bootinfo.board_id = 0xd32;
+    zynq_machine->bootinfo.loader_start = 0;
+    zynq_machine->bootinfo.board_setup_addr = BOARD_SETUP_ADDR;
+    zynq_machine->bootinfo.write_board_setup = zynq_write_board_setup;
 
-    arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
+    arm_load_kernel(zynq_machine->cpu[0], machine,
+                    &zynq_machine->bootinfo);
 }
 
 static void zynq_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index cefb7789ff8..669c516ad15 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -14,6 +14,7 @@
 
 #include "target/arm/cpu-qom.h"
 #include "hw/core/qdev-clock.h"
+#include "hw/arm/boot.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
@@ -25,6 +26,7 @@ struct ZynqMachineState {
     Clock *ps_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
     uint8_t boot_mode;
+    struct arm_boot_info bootinfo;
 };
 
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.43.0


