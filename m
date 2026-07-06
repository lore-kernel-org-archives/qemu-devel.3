Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABF8C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggip-0007UW-Dd; Mon, 06 Jul 2026 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiT-00076U-Qt
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiQ-0003Qi-TR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso29627095e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334296; x=1783939096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v/UwCQS2eNQSRnaSr3MMhfV2p8lUEGh6xQ596ua5JSo=;
 b=JK/1fXc3N9EWvseBdU7sQmEO9JtWVvgb19GvodPYZ9p13Z0Wf6t9EwaAoLrd4pDYH7
 7ooF9SJyy0BXsYeqJaRw06sPPAV2UbKkFu/4OoeIlcUOiHWCaKJ6eAMMsK4CrhJBmI0M
 Gpoyda5YyornRgKIayCAqwX1D7ca7tE7rWHGcbukh8LYBLLB4BhQJJRO91+pW96NSuZt
 7WM/YeWbF63s628EUgopu2TKCR4oEdqJxa9OC16xoq1t92e94uYYMxS2ax6cTJ034/8W
 nG4StvdW1HFWOkhrNknkWZ2K8oeO+gWXBVsRbgm0MpzYvKdvB+wrLLTvxS+7M58ao0LE
 jfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334296; x=1783939096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v/UwCQS2eNQSRnaSr3MMhfV2p8lUEGh6xQ596ua5JSo=;
 b=rqLWLnswXJo8raiZ0dD7Bfg+MUBqaZznHQVNrsqyDCSa6cSZFNlKQRlvE73C8VucJC
 2U5pebiWQva06R3uaGGxFIVij7gck/fIbfcwEKorLMvsX+L2+sE32sjJAJgCNceq0ksR
 xJRS7CU+Mkgy7U1QJ3BvA/oMsk9VaNxxum44cMB7qmUupvygREHdCBvljlje5piKmHpA
 UpxE60RfHgY81RXPdXqXYli/oiiuVLE/bB96C/rCckcwkCppZTj6YTlZaZvY9jF+vXOX
 93eankQBN/wiP2UHRoYc1R0alRez7fcu7zBWYm9qtHoeI4pLUCkDvrHAcjKGn8lylnNW
 Tj/Q==
X-Gm-Message-State: AOJu0Yxs6Lo+ad1GXXs/DWt1/DQiOf+pju7BG37bt4zjmQ64EQOmoYsT
 yIXc2wL0ZBP12Z+gCTRPcEMbgfEY3t2OpGmpU/J90aCqm+euq/R/jbksHBh3zymfQhBEuXy7Xbb
 ShHIBy3hPNQ==
X-Gm-Gg: AfdE7ckqtBbXLxrS6hN9yJuTgn8tDNDioolR64QP47oggW7hoSeXPy4bIQ4O313YH+A
 CGJ4kQohRvNMWTV/m6x6NuRbMDPw50v8vtBdGXwXy286lukyVpQy4rjxbIHDr/DxBidv2YbawFB
 3n6uEj1+AQhXxGSfVkFYDVlkoQHrCDTG7Lcc9R6ekpr1MSa6rPOT5AZ1aoPvShJx1mKYFicxcty
 kTNY+jMJAJlVAeBeqYuW32WlMBhDdCpzNkVE2IV8b+XUDCTydZqNWqzhFE/3oea4duTeewxesXA
 GeoX+UROpRsaJUPU0O79WMQ6VPoZAMFWavFBeJEBkjd6Mu/AB4fkZWT3uY1ctCpqFET4At7+56m
 0QJ3HVSZxB+8TLWZjPV/HXyzSqCuR10nWB5C+t7CbBjEdthF4ePzJt4MMCWT1Za1fSrBY6ti1lc
 343jD95KD6q6JxfeArSm4zyt+ZYUxvmfoMUcISOGv/kWIKt0KacqlUl99LnUiAPKcAMS+zcTnJ5
 WcxheMXBZm3pAmSVxuRLg==
X-Received: by 2002:a05:600c:37cd:b0:493:c82d:f3fb with SMTP id
 5b1f17b1804b1-493d11f6d3fmr122048755e9.28.1783334296100; 
 Mon, 06 Jul 2026 03:38:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/49] hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg
 I/O ports
Date: Mon,  6 Jul 2026 11:37:23 +0100
Message-ID: <20260706103752.320511-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The fw_cfg_init_io_dma() function allows the caller to specify the
base port number of the selector/data register and the base port
number of the DMA address register separately. No caller actually
uses this: they all pass in base + 4 for the dma_iobase.

To reduce the risk of unnecessary variation in what different x86
machine types use as their fw_cfg register layout, remove the
dma_iobase argument from fw_cfg_init_io_dma(), and have the function
always use the same "DMA port is base port + 4" layout.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Message-id: 20260529174639.451353-4-peter.maydell@linaro.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/fw_cfg.c          |  3 +--
 hw/i386/microvm.c         |  3 +--
 hw/i386/pc.c              |  3 +--
 hw/nvram/fw_cfg.c         |  8 ++++----
 include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 2876490f06..d422302c1c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -127,8 +127,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
     const CPUArchIdList *cpus = mc->possible_cpu_arch_ids(ms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, boot_cpus);
 
     /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 779741ec76..e7adab7d2e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -320,8 +320,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
         e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
     }
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, &address_space_memory);
 
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73a625327c..6d000e2dba 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -568,8 +568,7 @@ void xen_load_linux(PCMachineState *pcms)
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 59cf92293c..f68191553b 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1019,15 +1019,14 @@ static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_ready);
 }
 
-FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
-                                AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
     FWCfgIoState *ios;
     FWCfgState *s;
     MemoryRegion *iomem = get_system_io();
-    bool dma_requested = dma_iobase && dma_as;
+    bool dma_requested = dma_as;
 
     dev = qdev_new(TYPE_FW_CFG_IO);
     if (!dma_requested) {
@@ -1048,7 +1047,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
-        memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
+        /* DMA register ioport is always at base + 4 */
+        memory_region_add_subregion(iomem, iobase + 4, &s->dma_iomem);
     }
 
     return s;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 45a3747908..be3fb5f8aa 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
                                     Object *parent, const char *part,
                                     const char *filename, Error **errp);
 
-FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
-                                AddressSpace *dma_as);
+/**
+ * fw_cfg_init_io_dma:
+ * @iobase: x86 port number which is the base of the fw_cfg port range
+ * @dma_as: the device will do DMA to/from this AddressSpace
+ *
+ * Create a fw_cfg device and map it into the specified I/O port range.
+ *
+ * This creates a device with the x86 PC standard port I/O layout:
+ * - Selector Register IOport: @iobase
+ * - Data Register IOport:     @iobase + 1
+ * - DMA Address IOport:       @iobase + 4
+ *
+ * Returns the device object.
+ */
+FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
 /**
-- 
2.43.0


