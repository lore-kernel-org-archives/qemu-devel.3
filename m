Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE9C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYV-0006pn-O0; Mon, 13 Jan 2025 14:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXx-0006HC-5u
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:30 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXv-0007U0-Aq
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so3329104f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798178; x=1737402978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PieuWU0nqmvAznlB9XhRFnXCB0Z6Na0267ppDpJt9t8=;
 b=Ub2kOUEWe3GGWE+es2dBtFmpqNIypw++oPIehecrkI6a43H31qfLcyesaK7Bw6s0nG
 U5O9hgPOiZvEpTwjZpG5NyxqTwEATcuM8NS1RaEGX8i/YvwZDfiP5UZDLgsyrcvdJprS
 Sb+EO6qUe78NdWVlU+z87IOsLEeG3D60+f/aIf26mEYRW3pypjSm3SJ4eLoCbOP+xzck
 DrqRwHergzyN/TramS3hLppHC+Stavrewz35aON1Ayca1LrGRzqmLbv2mMbs5xIxUkQX
 guFpXel8VFIObNZKT1mwJN/TYT4eS8EBPygGHppHsx7ZEbHzK9YZrQt1bYruwBS+qPhw
 Fs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798178; x=1737402978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PieuWU0nqmvAznlB9XhRFnXCB0Z6Na0267ppDpJt9t8=;
 b=b1QTdnLvPGHLhOCPNERR9N/zpAEPWJHlObw1tkhuOpikWMj8gDFgVDfnttqYdTyVQI
 uBUZOhDQzWUwReGd6WxN/S8IO5cEopDjOZ7MQHWLkosTlB16FBqC/UbgE/e4swFzKwUM
 X3UWuZZAA/3wji4dJMxDGhcFKMtcZZzUmT8+BEEEnSmHmxb+4ovKl+s5IujGOdMZokIO
 SRgMgfY3JrhU8bJngAEzVr0zH+shd58Tl2QurJQIrLsKYykU2ebDNE5mLv5f5q/OwyXG
 uCTDQVz7kGlhw7E1JHnviK37pB/lUHvMExWdypB82Ymw55Gtp8A+X2BWePY4SYf7j8n+
 A2ZA==
X-Gm-Message-State: AOJu0Yx+u7EfgJZexHMb6a70+i8xkAjul0abHoZlFGzGzKQHphnWS9A3
 xI9WDIP27QRPf5nBbjzKp4RqfmhVeqoc9uF0SMime7ZoCAHh+vcwbsnDQxqFxbZIzijN1TsNh6V
 JRm0=
X-Gm-Gg: ASbGncufvf11HbqZtGpNHvzr9Ia804XdgIXEGc0UninuadunT9j9/7nd1w2kWq9V9iO
 XiYJzH2x+htgF3fkHiVgQnqChjK1Mdjv0RN3lIYEoLXxmXSR3eyGJOrKcO7Dx6C6itd2AqLDxb8
 /rk8hufdh9RtaBCFJs9ZRz76iK4zR5ElFUpkRxL2cwUi9hskEEbPqBygymsBJnCp2U4BqgR4Hte
 eYxHHZImoUIzyLFvXg3YIuDy+HcsyEd44ridFCfmVHY0+DlfsEP5JQbrkSnPYZ+Z9unf7JBQ/AI
 Pt43iq+zkLQMPokgi8pZ2UPmkJnNevw=
X-Google-Smtp-Source: AGHT+IGbHFsmkLAQ8VJyCXlhbGRSKbLN69rh5HIAwOliJ09ugEIF1qTQtyPJQNhCIqKxEdMx0b8aWg==
X-Received: by 2002:a05:6000:1a8c:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-38a872fc261mr19917243f8f.10.1736798177928; 
 Mon, 13 Jan 2025 11:56:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81a4sm13245516f8f.68.2025.01.13.11.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 10/19] hw/mips/bootloader: Propagate CPU to
 bl_gen_write_u[32, 64, long]()
Date: Mon, 13 Jan 2025 20:55:16 +0100
Message-ID: <20250113195525.57150-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Propagate the target agnostic CPU pointer to the publicly
declared bl_gen_write_u32(), bl_gen_write_u64() and
bl_gen_write_ulong() functions.

For the Malta machine in bl_setup_gt64120_jump_kernel(),
pass its first CPU (the one we want to start running the
bootloader).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h | 13 ++++++++++---
 hw/mips/bootloader.c         |  9 ++++++---
 hw/mips/boston.c             |  6 +++---
 hw/mips/malta.c              | 19 ++++++++++---------
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index 8533a16ca62..bc54ea8c7fb 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -10,6 +10,7 @@
 #define HW_MIPS_BOOTLOADER_H
 
 #include "exec/cpu-defs.h"
+#include "target/mips/cpu-qom.h"
 
 /**
  * bl_gen_jump_to: Generate bootloader code to jump to an address
@@ -47,30 +48,36 @@ void bl_gen_jump_kernel(void **ptr,
  * bl_gen_write_ulong: Generate bootloader code to write an unsigned long
  *                     value at an address
  *
+ * @cpu: The MIPS CPU which will run the bootloader code
  * @ptr: Pointer to buffer where to write the bootloader code
  * @addr: Address to write to
  * @val: Value to write at @addr
  */
-void bl_gen_write_ulong(void **ptr, target_ulong addr, target_ulong val);
+void bl_gen_write_ulong(const MIPSCPU *cpu, void **ptr,
+                        target_ulong addr, target_ulong val);
 
 /**
  * bl_gen_write_u32: Generate bootloader code to write a 32-bit unsigned
  *                   value at an address
  *
+ * @cpu: The MIPS CPU which will run the bootloader code
  * @ptr: Pointer to buffer where to write the bootloader code
  * @addr: Address to write to
  * @val: Value to write at @addr
  */
-void bl_gen_write_u32(void **ptr, target_ulong addr, uint32_t val);
+void bl_gen_write_u32(const MIPSCPU *cpu, void **ptr,
+                      target_ulong addr, uint32_t val);
 
 /**
  * bl_gen_write_u64: Generate bootloader code to write a 64-bit unsigned
  *                   value at an address
  *
+ * @cpu: The MIPS CPU which will run the bootloader code
  * @ptr: Pointer to buffer where to write the bootloader code
  * @addr: Address to write to
  * @val: Value to write at @addr
  */
-void bl_gen_write_u64(void **ptr, target_ulong addr, uint64_t val);
+void bl_gen_write_u64(const MIPSCPU *cpu, void **ptr,
+                      target_ulong addr, uint64_t val);
 
 #endif
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 1dd6ef20968..7db3bf7511f 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -277,7 +277,8 @@ void bl_gen_jump_kernel(void **p,
     bl_gen_jump_to(p, kernel_addr);
 }
 
-void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
+void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
+                        target_ulong addr, target_ulong val)
 {
     bl_gen_load_ulong(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
@@ -288,14 +289,16 @@ void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
     }
 }
 
-void bl_gen_write_u32(void **p, target_ulong addr, uint32_t val)
+void bl_gen_write_u32(const MIPSCPU *cpu, void **p,
+                      target_ulong addr, uint32_t val)
 {
     bl_gen_li(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
     bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
-void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
+void bl_gen_write_u64(const MIPSCPU *cpu, void **p,
+                      target_ulong addr, uint64_t val)
 {
     bl_gen_dli(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 491e1c4f7ea..b646c104df7 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -330,19 +330,19 @@ static void gen_firmware(const MIPSCPU *cpu, void *p,
 
     /* Move CM GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, GCR_BASE_ADDR + GCR_BASE_OFS),
-    bl_gen_write_u64(&p, regaddr,
+    bl_gen_write_u64(cpu, &p, regaddr,
                      boston_memmap[BOSTON_CM].base);
 
     /* Move & enable GIC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_GIC_BASE_OFS),
-    bl_gen_write_u64(&p, regaddr,
+    bl_gen_write_u64(cpu, &p, regaddr,
                      boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
 
     /* Move & enable CPC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_CPC_BASE_OFS),
-    bl_gen_write_u64(&p, regaddr,
+    bl_gen_write_u64(cpu, &p, regaddr,
                      boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
 
     /*
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index f7eb990c629..9bc3fc9da3e 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -627,6 +627,7 @@ static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
     static const char pci_pins_cfg[PCI_NUM_PINS] = {
         10, 10, 11, 11 /* PIIX IRQRC[A:D] */
     };
+    const MIPSCPU *cpu = s->cpus[0];
 
     /* Bus endianness is always reversed */
 #if TARGET_BIG_ENDIAN
@@ -638,29 +639,29 @@ static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
     /* setup MEM-to-PCI0 mapping as done by YAMON */
 
     /* move GT64120 registers from 0x14000000 to 0x1be00000 */
-    bl_gen_write_u32(p, /* GT_ISD */
+    bl_gen_write_u32(cpu, p, /* GT_ISD */
                      cpu_mips_phys_to_kseg1(NULL, 0x14000000 + 0x68),
                      cpu_to_gt32(0x1be00000 << 3));
 
     /* setup PCI0 io window to 0x18000000-0x181fffff */
-    bl_gen_write_u32(p, /* GT_PCI0IOLD */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0IOLD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x48),
                      cpu_to_gt32(0x18000000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0IOHD */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0IOHD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x50),
                      cpu_to_gt32(0x08000000 << 3));
 
     /* setup PCI0 mem windows */
-    bl_gen_write_u32(p, /* GT_PCI0M0LD */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0M0LD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x58),
                      cpu_to_gt32(0x10000000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0M0HD */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0M0HD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x60),
                      cpu_to_gt32(0x07e00000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0M1LD */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0M1LD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x80),
                      cpu_to_gt32(0x18200000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0M1HD */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0M1HD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x88),
                      cpu_to_gt32(0x0bc00000 << 3));
 
@@ -671,12 +672,12 @@ static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
      * Load the PIIX IRQC[A:D] routing config address, then
      * write routing configuration to the config data register.
      */
-    bl_gen_write_u32(p, /* GT_PCI0_CFGADDR */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0_CFGADDR */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcf8),
                      tswap32((1 << 31) /* ConfigEn */
                              | PCI_BUILD_BDF(0, PIIX4_PCI_DEVFN) << 8
                              | PIIX_PIRQCA));
-    bl_gen_write_u32(p, /* GT_PCI0_CFGDATA */
+    bl_gen_write_u32(cpu, p, /* GT_PCI0_CFGDATA */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcfc),
                      tswap32(ldl_be_p(pci_pins_cfg)));
 
-- 
2.47.1


