Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A5BF3ED50
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 15:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBadc-0007IJ-4D; Sat, 11 Apr 2026 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivien.leger@gmail.com>)
 id 1wBaWq-0005HZ-UI
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 11:45:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vivien.leger@gmail.com>)
 id 1wBaWk-0001CS-Ik
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 11:45:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so21335425e9.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775922339; x=1776527139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U/uR6qw258G23PmDbEC6+qEwH1s4sVRz5k7AU31IC0I=;
 b=OT6Mt8H3Ww9v07pGnq748gdGW6A/2vPLFXylVAqChU5B2kVKFnueZ3IIEHsrm7QfAM
 E9UzHVB/04BJauE7xLZU6nKBpMF7mytponJOzxwodRE7rq1uykzUXjo5iDIwFIv31tZk
 JK84+/85BF9F1YMPDGDwoVSz7EhXYbHpycZmMgTaEwQ9fK4aKZbgQ5CMRKhbY+l6zQAh
 tvI+/SY7yA1NcqoYENjF4jomKIQFJGAlHRrOs83YeUObrq/n/n3Fy0l+v7H/VYoBBQBa
 wMg+mJl2Qa6GiLIB0jaS6Si5IfDHX28+uG8XzGbXxww28lvKz2iUlWuYeR+1oCuefD9i
 fJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922339; x=1776527139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/uR6qw258G23PmDbEC6+qEwH1s4sVRz5k7AU31IC0I=;
 b=R4YAvQx4pSIVQfPiXdoTEkZWfZ5PFKGV5iqgcw5fiGCch3lnj5VxKCoKC/TcU/eIZC
 G5uJwn4AEGF54PRz9cqhKTKWQ2GSwsjYHygrHVXQ9AWfdxWQbdJbuHFg0940YBGrQegd
 yQofLQsvmzJlNNuv/HvOxFsM7sUH7BmBjnhA9Wn4z/+83hKTz20TYxWqxZSTJRPRNCqj
 P4Ap5+rbYZwLMeYYoIUt65QdcVmm124ve3c5yxdr512N00njfNGLKoX32qjFBd8TIpI7
 /Gg2OYDDiKH/SaMY1/JmQWrRCXhkRDT4U8WZDoN90QgN9aupp1KxK7qIU1n62AcUJ2bM
 Iusg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUobfk1AhTkbpxJWXjVUELyrXUuXmRUPH/8sY8Jz1SrADTQU09PeVAnRd1d6bdP5MkGT5ddkxdosZN6@nongnu.org
X-Gm-Message-State: AOJu0YyknMLKjyY3kcT8/jTaggyP+YeMsLHZdqpyo2CeybIwBeZUq5x7
 5sDOmtwibuc7UgYFSRraAr0rttUADknftd+BteCY1DDf2RUNLVBAjVDX
X-Gm-Gg: AeBDiet72OlnOFRGpePdGPeIfWL9o3n0VQHGAx249Kyp/UPwhcxk35bVUXejrHDKAmR
 KVPYxWLyhIT0NLpjQ4UZCKWpk7zUjGHjVr1z3je8B9qIqFEOiRTKu7jYKo5lkQ1pgtPFtT/h/DR
 aYPJ2avIBuISOV2+LElLJnMRttjqGqZxSKQBqVbUBYnhU8ccbowpJM8BXl0V4e6wTQQQ7w+DWSd
 +pCeHYzlKA3KGFZGHVcOWtbOmVlqNabQ7py9kiTn7lodY5bltkCxkXJCqpIcZE+KQMC3yprR+B6
 qoMiiJos//tjBRh2bsqqyHhz7qr1pPDFCWSLOExxIprcnD6naAZmOhaJZQk5PzIS62DeVEwHrpF
 xMJY3l38wvWc0V5LDnIfDq/RoHC/rMYm4hRGjU9vZwcNMr2pj+h4fqkkVrWokkBBecp67aMd9Zw
 duD3q+RMUp8pxWhOGp1pOcp01k+1p6Rur46FxFxbUjdkEiNKTTssTSh5WGOG190jB+JqAVAHa7Z
 ypsyzw89TUkwg1qOrkCMA1de5PBk5hlBpyF5+g=
X-Received: by 2002:a05:600c:8591:b0:488:a824:fe04 with SMTP id
 5b1f17b1804b1-488d6abe9e4mr68536955e9.26.1775922338396; 
 Sat, 11 Apr 2026 08:45:38 -0700 (PDT)
Received: from vle-arch (88-184-113-142.subs.proxad.net. [88.184.113.142])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6839981sm48974135e9.21.2026.04.11.08.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 08:45:37 -0700 (PDT)
From: Vivien LEGER <vivien.leger@gmail.com>
To: qemu-ppc@nongnu.org
Cc: shentey@gmail.com, qemu-devel@nongnu.org,
 Vivien LEGER <vivien.leger@gmail.com>
Subject: [PATCH] hw/ppc/e500: fix bus-frequency property hardcoded to zero in
 CPU FDT node
Date: Sat, 11 Apr 2026 17:45:35 +0200
Message-ID: <20260411154535.1451361-1-vivien.leger@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=vivien.leger@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Apr 2026 11:52:46 -0400
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

The bus-frequency property in the CPU FDT node was hardcoded to 0.
This is incorrect - it should reflect the actual platform bus clock
frequency, as firmware and RTOSes use it to derive peripheral clock
rates.

Notably, the RTEMS QorIQ BSP uses bus-frequency to program the MPIC
global timer interval. With bus-frequency=0, the timer interval
overflows to ~85 seconds, preventing any clock interrupts from firing.

Fix by adding a bus_freq field to PPCE500MachineClass and using it in
the FDT generator. Set bus_freq = PLATFORM_CLK_FREQ_HZ (400MHz) for
existing machines, matching the existing clock_freq value.

Signed-off-by: Vivien LEGER <vivien.leger@gmail.com>
---
 hw/ppc/e500.c      | 2 +-
 hw/ppc/e500.h      | 1 +
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d6ca2e8..5be2f20 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -518,7 +518,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
                               env->icache_line_size);
         qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-size", 0x8000);
         qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-size", 0x8000);
-        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", 0);
+        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", pmc->bus_freq);
         if (cpu->cpu_index) {
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "disabled");
             qemu_fdt_setprop_string(fdt, cpu_name, "enable-method",
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 11f8ae5..6d56c7b 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -40,6 +40,7 @@ struct PPCE500MachineClass {
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
     uint32_t clock_freq;
+    uint32_t bus_freq;
     uint32_t tb_freq;
 };
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index ca56472..85cec81 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -94,6 +94,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "generic paravirt e500 platform";
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 5826985..d022761 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -56,6 +56,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_pio_base = 0xE1000000ULL;
     pmc->spin_base = 0xEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "mpc8544ds";
-- 
2.53.0


