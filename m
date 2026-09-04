Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577D4C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMl-0008B4-NF; Fri, 04 Sep 2026 01:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMS-0007LS-3H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMO-0001Qo-8L
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so515197b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499266; x=1789104066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gzG33ZflpHsNU12q0lawwbD4l3008W2OYblc4qZnjCc=;
 b=AJ02pjX7gL3+6Mw0VqGO62U4r1OSY2anZKema35yNadOA7E71s0P4krKW7X3THTihC
 60Vupjn4h3uihO7hHTRoQBIvzp0bUFBJ+RJHzzfAHmXkDI0ao1fGOrgZoEnh9orG0rQC
 gXPyi1eCtOFnEdoLnPIN7ubzLA1TnghN+A62IVynNPOhEcUriT+Wdfq9/jS8HLIpg8/o
 JVGinx/NdaeJpQ8CbRR/uyB/lwZAxckbCDjuI2XCBDzJBlC8hrhs1qLksYhDLNHUydFH
 d57S6uoTUWA53d0gxgHzs1ktPJjwX1IqDfGgLvRTwBNzLMDX2EYJJugROZG9NcZReeth
 SLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499266; x=1789104066;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gzG33ZflpHsNU12q0lawwbD4l3008W2OYblc4qZnjCc=;
 b=c+OngLlLqB3aQzbdO+6uB4p8xMVciS7EQUQ6BThMCo7pzEV8FAsBVnelL/GijVNW7w
 I1W6vp4s2ZQdzqMn9dL9XyHuVFtRezpbJWtgSZLNiEYB/W/32NYJW05yfOivtL5FIUMF
 aM4k4jvTOhwVB+n5FOQwIJStR5eyMk/tUW8YY+Y6oP7qKDltJv0tqH3TwWFB0/YyYTy6
 ZVqb9kfJNaGMaf8MNz1pGO4vRwgDIQLs3uNuGKlYylnKjMrQqpJJ1qfVzjzKXa8yHAu9
 x/yuqkOKT2uadSxKYYm19Ke9g3VkTzEShAtiHmkYl2zZUzt3x+ImdiU7QEUZobCCk64X
 S6xw==
X-Gm-Message-State: AFuF++mGXDQKWzU/qXvP1eXHlZBBu2RVBu1LKZXygcmWdGR854FRGXg/
 3ol8xv7aKyufRdR7bdr5XLTEo9gusOMJ01NApSqToqrSp9hvyf9+CqZ1zL1wtQ==
X-Gm-Gg: AYBFou0+2BJct/c/UBp/cYmpiz8NHYQAOPz81Q+jywmDK+TMoM+G6Q07nEMJdyQWC5c
 8H8NpOqVTOewHegmNrwxkuOraa/0DeCqgusN5o0Ylx4n4lYFhkf9pYnoMA3rmlLUZrXFEWfUH5j
 A+akf3HRG+X4tlKl2E9Y3xJtfPuNf3478uNsfn/ua407bbjtv/3u9GpFN2udygmig/4kdE4qOhU
 ZOR+OjtxpVZymqPHD4iHsVuX+XyqahPuuSdt3ccXiAmtTt+Wws6nLXb5WsItePdmpPn9opEioNE
 P8cRPKnwAEG603tqM2T5/hI6nKhDO1fVQKCStlI7k0owYfDGwyKObEMjSWA8fwq6op1Ah5KR0Nl
 kVh67aHhC7TmhnuthSPXQHDiU9SMgWtknsp8DHH4ABP7ARQlZOUrsNBBh+zCGx38viKkGo1y4TH
 namGiN/lUJV6n2LudlcjbVoI9WDnNXVELJ85oZBJxYt3cHM8y+VX/Y+DR4uGzwwW0ndq/24JAeR
 YY1iA==
X-Received: by 2002:a05:6a00:440f:b0:84e:b7ed:7d50 with SMTP id
 d2e1a72fcca58-861684928fcmr5829118b3a.16.1788499266510; 
 Thu, 03 Sep 2026 22:21:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 23/47] hw/riscv/fdt-common, virt.c: add riscv_create_fdt_uart()
Date: Fri,  4 Sep 2026 15:19:19 +1000
Message-ID: <20260904051943.799041-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Add a common uart FDT helper to be used by 'virt' and the future
'riscv-server-ref' board.

The 'tt-atlantis' board is left out of this patch because it's going
through UART related changes and its FDT might change soon, thus it's
better to wait for the final DT to be determined and then we can
evaluate whether it can share a common helper.

The "/chosen" and "/alias" changes are UART0 only so we're keeping them
out of the common helper.  The board can set both manually as
appropriate.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-11-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  5 +++++
 hw/riscv/fdt-common.c         | 29 +++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 35 +++++++++--------------------------
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index a45b063f66..c8b25348bd 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -128,4 +128,9 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                                    uint32_t *aplic_phandles);
 void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                                     uint32_t *intc_phandles);
+/* Caller must free the returned string.  */
+char *riscv_fdt_get_uart_nodename(hwaddr addr);
+void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                           int uart_irq, int aia_type,
+                           uint32_t irq_phandle);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index d2ce93ad28..0107aadaad 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -22,6 +22,8 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/riscv/aia.h"
 
+#define UART_STD_CLOCK_FREQ 3686400 /* 3.6864 MHz */
+
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
 {
@@ -799,3 +801,30 @@ void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
         g_free(name);
     }
 }
+
+char *riscv_fdt_get_uart_nodename(hwaddr addr)
+{
+    return g_strdup_printf("/soc/serial@%"HWADDR_PRIx, addr);
+}
+
+void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                           int uart_irq, int aia_type,
+                           uint32_t irq_phandle)
+{
+    g_autofree char *name = riscv_fdt_get_uart_nodename(uart_mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, uart_mem->base,
+                                 2, uart_mem->size);
+
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", UART_STD_CLOCK_FREQ);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
+
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", uart_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c9b1a669a5..ae809ecb5f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -417,39 +417,22 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_uart(RISCVVirtState *s,
-                            uint32_t irq_mmio_phandle, int memId, int irqNo)
+static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
-                           s->memmap[memId].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[memId].base,
-                                 2, s->memmap[memId].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
+    if (s->uart1_present) {
+        riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART1],
+                              UART1_IRQ, s->aia_type, irq_mmio_phandle);
     }
 
-    if (VIRT_UART0 == memId) {
-        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
-    }
-}
+    riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
+                          s->aia_type, irq_mmio_phandle);
 
-static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
-{
-    if (s->uart1_present) {
-        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
-    }
-    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
+    name = riscv_fdt_get_uart_nodename(s->memmap[VIRT_UART0].base);
+    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s,
-- 
2.55.0


