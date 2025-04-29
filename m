Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83051C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kY3-0002Ya-DW; Tue, 29 Apr 2025 08:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXy-0002XD-F9
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXv-0000Dq-Of
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736a72220edso5914957b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931525; x=1746536325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4k+EkRWesQ4zw2RansWLgi7SNhdPMFPjDG5O4INDl94=;
 b=hYoKPdlia9PpVfR1oPSxgqzEVKoLD1Yf95w2HqHaW4afhz2NNJgGg+kHBJJRfbDOpK
 Khpwxt89nppUTc/EpZfuVw0EpvYueAVmOlrn9b9gJgJjPJGFfK3ssZOuaUU+V6ltC32R
 sBs5uRYXheDdd/ONSTm/DTQm/1QISoSRqJFxjlzJjJTH6tUpDHeadEYODkq88Wgb2DbX
 IXNU8PrAip94xJjVSIkI6Zw+vACKuyB9RfHwOUo19NkYR5j0ftZ2IMsBbCdXJGh/TQiD
 3Df10AOGspYB/HXgDbhLHLZ64I79R/exUvk+BXrL4yJ+xiHTgfRiwkZ718T9ljXmJbH/
 bG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931525; x=1746536325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4k+EkRWesQ4zw2RansWLgi7SNhdPMFPjDG5O4INDl94=;
 b=adlJQuxrwmTkuH369Aqcdbrv6FgAwLhRCpZ8UGsE7vgE+0Qs40qtFrMfDFB0PoTlJs
 Tt9LTNw0nVxdbBN1Oe9YDZAAj1sUdwz+rxhjdKY8Zq0TqiwU4ghNxSNzyG3Znhn/35yn
 NXiphqa7FY8Ma2zP23NDUsBumymjZ4sNZSo1v4V7lv9U9in0w+4yWhWJGT2xBwYtdNvB
 llCyH5mejl58JUxTnWJU9SOw6Dei0JPy50YQMgF8sFv37+ZJ0BmhL6YFRnazpkjRClyy
 P/KRTuebSBm3S0f0d0D/imO4yKAFEieLJHVGc4POmR0cChxzXf4dXa2Ja/yMrUYjXE07
 0gIQ==
X-Gm-Message-State: AOJu0YwWSHATRByUQ9sYmtpj0eXG6z3IPbrujgMasfkNe6wRNEYMWj7N
 0nPG6vW/7kh0YoAGeUPIdNCkScJiGwDgMlq3Ycn3yec4u7N4nxv7gXBMQvYLwvnM/pjfjH2hbNG
 w
X-Gm-Gg: ASbGncuRmgIqBLRGhgE9njl3rNXIb3eqFEjrDfyVXdWemJ4VGB9yBhYKUiw8eAd0A89
 zQe2/t/f0cldTLdu6zTvz1KQKL36hj8Ph5j+EF7D1KBW1VGZ/qJ3Lr9qd4FXVPTM7xqf5b4vROV
 EVvoLMIzN2qKR36LpjSdjoLkvBTww5vwH4iYbDYYJOfr5urIP91V46oara6jnzpI4DngFPL+nIT
 LeLKVLdVT8797Ez+omQbZvF6KFWnoyAvx+lzS6pynZM6GeGp5Vh94EWz0Y133U4YrCIRYbjzhT0
 pfLiOpUckwlxPdM9s5SVUXYEhrtACpWMTcbhDhCLg3k=
X-Google-Smtp-Source: AGHT+IENDgcIHl3JGRs1Zrnt/0/JkMc77WKokJSN6ATmUhcurxFqRvSi4w5WCZ1f3sffjokNWbVE5Q==
X-Received: by 2002:a05:6a21:4002:b0:1ee:e24d:8fe3 with SMTP id
 adf61e73a8af0-209591a63b8mr4282658637.10.1745931524918; 
 Tue, 29 Apr 2025 05:58:44 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7fb7e54sm8889440a12.30.2025.04.29.05.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:58:44 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, joel@jms.id.au,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
Date: Tue, 29 Apr 2025 09:58:11 -0300
Message-ID: <20250429125811.224803-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
strings for uint64_t and hwaddr types.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f38b64d836..0020d8f404 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -303,12 +303,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
 static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
 {
     g_autofree char *mem_name = NULL;
-    uint64_t addr, size;
+    hwaddr addr;
+    uint64_t size;
     MachineState *ms = MACHINE(s);
 
     addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
     size = riscv_socket_mem_size(ms, socket);
-    mem_name = g_strdup_printf("/memory@%lx", (long)addr);
+    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
     qemu_fdt_add_subnode(ms->fdt, mem_name);
     qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
         addr >> 32, addr, size >> 32, size);
@@ -879,8 +880,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/pci@%lx",
-        (long) s->memmap[VIRT_PCIE_ECAM].base);
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                           s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
         FDT_PCI_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
@@ -924,8 +925,8 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
     MachineState *ms = MACHINE(s);
 
     test_phandle = (*phandle)++;
-    name = g_strdup_printf("/soc/test@%lx",
-        (long)s->memmap[VIRT_TEST].base);
+    name = g_strdup_printf("/soc/test@%"HWADDR_PRIx,
+                           s->memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     {
         static const char * const compat[3] = {
@@ -963,8 +964,8 @@ static void create_fdt_uart(RISCVVirtState *s,
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/serial@%lx",
-                           (long)s->memmap[VIRT_UART0].base);
+    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
+                           s->memmap[VIRT_UART0].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, name, "reg",
@@ -988,7 +989,8 @@ static void create_fdt_rtc(RISCVVirtState *s,
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/rtc@%lx", (long)s->memmap[VIRT_RTC].base);
+    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
+                           s->memmap[VIRT_RTC].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "google,goldfish-rtc");
@@ -1041,8 +1043,8 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *iommu_node = NULL;
     g_autofree char *pci_node = NULL;
 
-    pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) s->memmap[VIRT_PCIE_ECAM].base);
+    pci_node = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                               s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
                                  PCI_SLOT(bdf), PCI_FUNC(bdf));
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
@@ -1110,8 +1112,8 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *iommu_node = NULL;
     g_autofree char *pci_node = NULL;
 
-    pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) s->memmap[VIRT_PCIE_ECAM].base);
+    pci_node = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                               s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_add_subnode(fdt, iommu_node);
@@ -1180,8 +1182,8 @@ static void create_fdt(RISCVVirtState *s)
      * The "/soc/pci@..." node is needed for PCIE hotplugs
      * that might happen before finalize_fdt().
      */
-    name = g_strdup_printf("/soc/pci@%lx",
-                           (long) s->memmap[VIRT_PCIE_ECAM].base);
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                           s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_add_subnode(ms->fdt, name);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
-- 
2.49.0


