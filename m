Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F49CD6E56
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1IO-000379-G9; Fri, 29 May 2026 13:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IJ-000365-Tz
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IG-0001bj-79
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so84627225e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780076806; x=1780681606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ot3n2Oo9vnyF+OptGzLoEZCf8T45qVznpIm4PeIK0AU=;
 b=t7THP4XwMiT+8H86ebMJhFrIckFhIK5wSdIIgPR+2eeBAXCDW/W0IoxFRgYeVJqRXo
 u/G4HsUddCfawZPsZ6u3UE8qIuOySnBgCSoqg3fE2QfOy45Wmk8Wr+vMKCiLmByrcy4G
 2RA4pXppyoLya+16Pr25dUUUCvmJs7nahMQvd6Hs1fzMgI8pnKOT0SJpeehrw0P5dWIC
 3CTg4/mz9jyL1iBOQxW6yxS0oMSU8teZbEj5LOaI9yf26CYnkFavDFb9ri98ouLMVsvI
 CuueppiY8Nq/1PRTKo/IzpWM+Xh53HjOZF1FWYzXT9iPLIeKtK7Ne1sX+j8PtTgPdnAy
 lR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076806; x=1780681606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ot3n2Oo9vnyF+OptGzLoEZCf8T45qVznpIm4PeIK0AU=;
 b=aHjTt4t/BpWzeadLhDc1C4A8nuxrq51lEvI8bihZ1Bx1lNsRDTP8YKZ07XtaRLyFVh
 p0tRCeqzkEH5mQgt+5XYSoQGci8gMthgOgsjvcYGtnnYNRH3q+GgLtxfDBEMsVcgSlPT
 1dy3ej7Do+kHMwwZYogdYH8tC89tMvd3M28gGMkah0EK+tQyUI4uBM8Bm/cWNmyn+wxa
 xi3Ge/qzwI2LiaW5kjVL+lJUnFW5pqFhIiYJzNDeh2+jg8NWJBB/ZjgDYFjnzrinUebP
 LqPqb9HAIq9OKoam4wkaMer3rC+mRH3BPNz/SuaTffxnGcN1Heo7b962NYmf/fGknGmu
 ozmg==
X-Gm-Message-State: AOJu0YwQFl9zXtDTsAjwLbxapgVJ2EMmrJIbL+8DLkMIMEWRaju/8TAh
 E47RwlWeEEp4cggA1uVCUqxoao2kpBpJVRi106yvzQt05sXDdqmhxduHKTB8vYMO6OcUguMreJy
 /eVJB
X-Gm-Gg: Acq92OGTTN0YXdm5d33DX87EUSGR4O8udonPLCS5bfKmOOsbNPNoMpuDz6I/KW6LGho
 UhD2cL/QZ1Mo0UzNB1XgE97NBKJWfq5xvp5HBSQwpn43SPgVNUtbiQhqMVs0yJIap9cMiTEgi8W
 QGnatvpPwK8xvHvcc6NKFtPihhBoAFqewkUknr1LXB462Lgeo/l6i/XtW2u4hNFMLx00L9FCe57
 ydrWYJExzxSqKALe61+dkJW0istAEfnOgjn/Ilpkdfy/j3HYrQKC1YuuiS3guFhfC6NpWaSKVbH
 YJCHWgTJynfJr+LGN+ogsDShnvmgl5kfxJm7YPjdeLijHcw8I9LhjaKoaKUbY9V8vvvqFv9A5wl
 GVWLUwcDpXlHpLddRazrc8puIdOOLxwAg83WKEqVbO067Y3MLgnKpCEPbK/Fh1pgOcA9bYvgtoM
 ATtWFZM5XTy5lAum8pfwRosH7DZLW0XyCpi4NwrORp52JKf7f+D3zlSIU5J2btkap6whz6xcUMY
 WmZn+8RN5tPHatZSAM/h/s/oLTvFLym3iIkpwuqwzFijyo8n5FE/g==
X-Received: by 2002:a05:600c:8582:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490a29399fcmr8297785e9.14.1780076805863; 
 Fri, 29 May 2026 10:46:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aa24bsm18668895e9.9.2026.05.29.10.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:46:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 2/5] hw/nvram/fw_cfg: Enforce standard layout for
 fw_cfg_init_mem_dma()
Date: Fri, 29 May 2026 18:46:36 +0100
Message-ID: <20260529174639.451353-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Currently fw_cfg_init_mem_dma() allows the caller to customize the
register layout, by specifying separately the offsets for control,
data and DMA registers, plus the width of the data register.

In practice, all the boards using this function specify the same
standard layout: "base + 8, base, 8, base + 16", meaning that the
data register is 8 bytes and the registers are data at offset 0,
control/selector at offset 8, and DMA at offset 16.

Allowing every board to be different is gratuitous and useless
variation which leads to code in guest OSes having architecture
ifdeffery to cope with it.  Avoid potentially introducing any more of
this by removing all the arguments from fw_cfg_init_mem_dma(), so
that the callers only specify the base address.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c             |  2 +-
 hw/loongarch/fw_cfg.c     |  3 +--
 hw/nvram/fw_cfg.c         | 10 ++++------
 hw/riscv/virt.c           |  3 +--
 include/hw/nvram/fw_cfg.h | 23 ++++++++++++++++++++---
 5 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893..2cd1c639f5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1941,7 +1941,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     FWCfgState *fw_cfg;
     char *nodename;
 
-    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16, as);
+    fw_cfg = fw_cfg_init_mem_dma(base, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
diff --git a/hw/loongarch/fw_cfg.c b/hw/loongarch/fw_cfg.c
index d2a79efbf7..4c976ce1e5 100644
--- a/hw/loongarch/fw_cfg.c
+++ b/hw/loongarch/fw_cfg.c
@@ -23,8 +23,7 @@ FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms)
     int max_cpus = ms->smp.max_cpus;
     int smp_cpus = ms->smp.cpus;
 
-    fw_cfg = fw_cfg_init_mem_dma(VIRT_FWCFG_BASE + 8, VIRT_FWCFG_BASE, 8,
-                                 VIRT_FWCFG_BASE + 16, &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(VIRT_FWCFG_BASE, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1d7d835421..59cf92293c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1088,13 +1088,11 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
-                                hwaddr data_addr, uint32_t data_width,
-                                hwaddr dma_addr, AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_mem_dma(hwaddr base_addr, AddressSpace *dma_as)
 {
-    assert(dma_addr && dma_as);
-    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width,
-                                    dma_addr, dma_as);
+    assert(dma_as);
+    return fw_cfg_init_mem_internal(base_addr + 8, base_addr, 8,
+                                    base_addr + 16, dma_as);
 }
 
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7..a10840a81d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1266,8 +1266,7 @@ static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
 
-    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
-                                 &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(base, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     return fw_cfg;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 56f17a0bdc..45a3747908 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -309,9 +309,26 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
-FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
-                                hwaddr data_addr, uint32_t data_width,
-                                hwaddr dma_addr, AddressSpace *dma_as);
+/**
+ * fw_cfg_init_mem_dma:
+ * @base_addr: address to map the device at
+ * @as: the device will do DMA to/from this AddressSpace
+ *
+ * Create and map a fw_cfg device at the specified base address.
+ *
+ * This always creates a device with DMA support, and the "standard"
+ * register layout:
+ *  - offset 0 : data, 64 bits
+ *  - offset 8 : selector, 16 bits
+ *  - offset 16 : DMA address, 64 bits
+ *
+ * The device will be created, configured and realized, and its
+ * memory regions for the registers will be mapped at the specified
+ * address.
+ *
+ * Returns the device object.
+ */
+FWCfgState *fw_cfg_init_mem_dma(hwaddr base_addr, AddressSpace *dma_as);
 
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
-- 
2.43.0


