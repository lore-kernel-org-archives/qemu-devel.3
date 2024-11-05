Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2366D2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JFz-0003Qs-Gp; Tue, 05 Nov 2024 08:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFx-0003Mc-LT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFv-0002YQ-Tb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:01 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43155afca99so39755345e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811958; x=1731416758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owZyMcyuMkQxG2xNbQN7m9vwX8uFO4GAfwfRH2jZDis=;
 b=tTxcnEmWdAewOUh5wvOKpkIMlfoSnSJv3+6oidwpJLIygkp9qeMQJ2zwtWOF2nrRRh
 gdNpSKUdM+EveBZHpaJlnSrlIMn0eE5p4Z1sgo44VGZuaQYL/K/NeX0gC8uBjAUOM+Uk
 thuaxsGGP0L/TkMAUsHrimZc6UBpLDc9WmYI8HX2C3Nk0FMMaxEDHjLfuJC5YpLTGvei
 hNFKtJ8x93QUs9puGcGSWl9g1BnRjcFzvX46LIVwyB3GXJ8UuDx0rYNIjlvtg17B9zbt
 Xa3cb2ei2gHzN6qk1fRkAliNINGvFhWtSTlGoo5+vBIGcledLcI7ArUIK03KceaecVK3
 /rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811958; x=1731416758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owZyMcyuMkQxG2xNbQN7m9vwX8uFO4GAfwfRH2jZDis=;
 b=cBA3tyzB2NIocZhIaiq6agohc+uMi6nCcVqXFGcNLrx+TRntH7iJC0P2ohduATBZyb
 oujnQCt6HLAqtASqdYiBRyeHJo7x5N/8a8FZnTlA7IqdmnMqnuN03Bd8f4yWdt5f2cl+
 sjWtX55cS/ph5/BASrI/LPWTiSbE5E72vQ0iBPOvd+tJwsjOho+A8n6iDY8sU1Y+oQxX
 JG9uGC2pMCCNUQveLqp5NP3EnTblWBmagRqFERxLSMMsV5YOu+S5Q9uSysnkZxRrxBsf
 Kue0OWWQ+KoMjDEMMATVCYCpmUF6zFPl+9yJG34ve3KNcUmrTcAIpnuFPFec5BrDHqSW
 4Gnw==
X-Gm-Message-State: AOJu0YwqkZHcsFXzNCBViAPi5fGnLsheK/Aw69W7eDXvfVpto+yMNdWm
 XcRhlHO07lBBYUmzxo9/fnEii0zla7lCGzpfoWfny2SmzjzIopU673AwB1Uodw9mg6GwJ3zYZoZ
 Ujxc=
X-Google-Smtp-Source: AGHT+IFDsyI/h2Z9thZvULAcUPo5quUd3qcyvFOAaWGsITkd9/JwC0tT1aea1ulv+PoZJu95BU7vrw==
X-Received: by 2002:a05:600c:35c5:b0:431:9340:77e0 with SMTP id
 5b1f17b1804b1-4327dab3f6cmr161052765e9.9.1730811957278; 
 Tue, 05 Nov 2024 05:05:57 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e853esm223671995e9.8.2024.11.05.05.05.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:05:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/19] hw/microblaze: Propagate CPU endianness to
 microblaze_load_kernel()
Date: Tue,  5 Nov 2024 14:04:20 +0100
Message-ID: <20241105130431.22564-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Pass vCPU endianness as argument so we can load kernels
with different endianness (different from the qemu-system-binary
builtin one).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/boot.h                     | 4 ++--
 hw/microblaze/boot.c                     | 8 ++++----
 hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/boot.h b/hw/microblaze/boot.h
index 5a8c2f79750..d179a551a69 100644
--- a/hw/microblaze/boot.h
+++ b/hw/microblaze/boot.h
@@ -2,8 +2,8 @@
 #define MICROBLAZE_BOOT_H
 
 
-void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
-                            uint32_t ramsize,
+void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
+                            hwaddr ddr_base, uint32_t ramsize,
                             const char *initrd_filename,
                             const char *dtb_filename,
                             void (*machine_cpu_reset)(MicroBlazeCPU *));
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index ed61e483ee8..3675489fa5b 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -114,8 +114,8 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
     return addr - 0x30000000LL;
 }
 
-void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
-                            uint32_t ramsize,
+void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
+                            hwaddr ddr_base, uint32_t ramsize,
                             const char *initrd_filename,
                             const char *dtb_filename,
                             void (*machine_cpu_reset)(MicroBlazeCPU *))
@@ -144,13 +144,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
         /* Boots a kernel elf binary.  */
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, &high, NULL,
-                               TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
+                               !is_little_endian, EM_MICROBLAZE, 0, 0);
         base32 = entry;
         if (base32 == 0xc0000000) {
             kernel_size = load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL, NULL,
-                                   TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
+                                   !is_little_endian, EM_MICROBLAZE, 0, 0);
         }
         /* Always boot into physical ram.  */
         boot_info.bootstrap_pc = (uint32_t)entry;
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 61e47d83988..d2b2109065d 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -204,7 +204,7 @@ petalogix_ml605_init(MachineState *machine)
     cpu->cfg.pvr_regs[5] = 0xc56be000;
     cpu->cfg.pvr_regs[10] = 0x0e000000; /* virtex 6 */
 
-    microblaze_load_kernel(cpu, MEMORY_BASEADDR, ram_size,
+    microblaze_load_kernel(cpu, true, MEMORY_BASEADDR, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 6c0f5c6c651..8110be83715 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -129,7 +129,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
-    microblaze_load_kernel(cpu, ddr_base, ram_size,
+    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 567aad47bfc..bdbf7328bf4 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -172,7 +172,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     qdev_realize(DEVICE(pmu), NULL, &error_fatal);
 
     /* Load the kernel */
-    microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
+    microblaze_load_kernel(&pmu->cpu, true, XLNX_ZYNQMP_PMU_RAM_ADDR,
                            machine->ram_size,
                            machine->initrd_filename,
                            machine->dtb,
-- 
2.45.2


