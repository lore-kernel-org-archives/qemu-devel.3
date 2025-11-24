Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92618CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTGb-0004n2-DQ; Mon, 24 Nov 2025 04:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTES-0004Ru-KN
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:48 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEM-0001YA-8V
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:38 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso2490966f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977893; x=1764582693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCezNN/txmXrYZ6BZ8Ldxddi41Hxexd+q2ZF1K5QXyk=;
 b=T1YP+3AFn+5rBjcX3P6T1n5g1YkVAtF1ZYR93UhaE3Lr9OetfH6533WjIIEIIYjXHp
 OGWpfDCMOPH98X0AyTRexzZkb/lxGRsL8QGoct74k6TYylAPkJni5WO0TkIvqeeGumjG
 4ks54BawYITK0F8USMhRzmfei6P30y5jaUSVFaoUvZxj1hTOTRNe4y0X7g2G1fnqwor1
 mS8Zfbqs70lKqUOoLegOrRKY8BXQv3GlLHCm8aNXdKUJEzJ8hTxqtffefZHL4lunZ9+k
 Kms9kpP9Ii4KS/hqepeO1g+og6LHHGT4g6wY8aTI08Bfk9KEgLUfYWkKMBX/kslRFH4X
 iKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977893; x=1764582693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCezNN/txmXrYZ6BZ8Ldxddi41Hxexd+q2ZF1K5QXyk=;
 b=fVwo49Iq9hP3WzecLbzd/EiwuEnOPovewynrWTj185TEuWtss3829NE0WWypARIBDd
 aGiGx/rZHBWtWvue/7MYH9HY0sEOdc/PEPI0EOYCzRf2+oBVx1KY2kr1nc+MtCYBEnUq
 pSLbls6aXFziEM8ZmkJ6Jo7ibQ/uuTu1fHkPuEEDSKmv0QV2aPM2WIAo3z8t/BiYhcs0
 VBCIdzgZf3mC6priBRcQ1Iy6ho27mHxqiI6E0oD+dMm0/Q1unpcs1/OIx+px7J6T5utm
 Fv6rHUki9nY/OX7M9jOYX6VH+152Cnal3R5aU6KhPB2WWrFcjlMT+yhLKf9PSc1R+Liv
 Bn7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEhlczcH1yo/HhTWbIdoS+5b6T0EcUrLbLx1FMoX/p2qFarBV8XHb2/Ks8VPR682hITabSAPlA+2s0@nongnu.org
X-Gm-Message-State: AOJu0YwG4HXAdLlJIF19F7Hg4Bp+nH8vWK61eDhsf3lyXRCNVvpCwB7y
 vPF4+FlTdnnYXwkm8H7qtKaXqnMiu1H0otVShcuc0GbwwIs6Ra+eptjGxlK09Cto/Wo=
X-Gm-Gg: ASbGnctwYwyIS/BO/tO9dm9OA7VBVKfcm2ZB5UMEuPOg2XpVyjApc7BJasFWlVKXfcF
 vMNMGOua8G5+BYYLWBiYOrfHNwCaoumEdwb+yEGxFVcn1ivjqJjyJa9rjMFRsBfEtwlXtWHfYoH
 6nWIVxdmfHcqVIRPo46HEb5/nwwVK0QaD/NcbmryOqHkFgsn7SXfKCX0bnnDnW/MnZGSEfZnyiM
 wUNGcZiyKrVBNEjxW0OyM1XpPuFJU29L2Y5QJxjrPbZ7hxJrwkHtN7QSVJUCEWHlC5IgZPiqufB
 +CYbQmfOVo8YkuO93n03/I4+CkMfHc7JEf7JHA1Ygle2iYZCDtU3Zi0jSic7wdNmAbwAgmAv85v
 FACyoNu3KgZvkVwM3ABZ6pjivBFE3NWMc5u4a+RycjKMQ/bQbz8Le4rcmbGIuh6ceTrlH8thZOP
 lX2rmBiDs6+T54qapWqsxL+Vgz6DuYhfkdLWRs1cwfwjTid5mQ/7tPefu7pUAz
X-Google-Smtp-Source: AGHT+IGyvQCmzOVQZfAkts8ZgbzGna0YcRb/Py1cmbK9iKhKBwIQBPKtdJCyZZVUIMjrajWC9u8HGg==
X-Received: by 2002:a5d:584d:0:b0:429:d391:642d with SMTP id
 ffacd0b85a97d-42cc1ac9a9fmr10524149f8f.5.1763977892812; 
 Mon, 24 Nov 2025 01:51:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e581sm25966916f8f.8.2025.11.24.01.51.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 03/13] hw/sh4/r2d: Introduce sdram_base and
 sdram_size variables
Date: Mon, 24 Nov 2025 10:50:58 +0100
Message-ID: <20251124095109.66091-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Soon RAM base / size won't be fixed, so introduce local
variables for them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 5f8c034e1af..51c7c3e2e07 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -251,9 +251,12 @@ static void r2d_init(MachineState *machine)
     PCIBus *pci_bus;
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
+    hwaddr sdram_base;
+    uint64_t sdram_size = SDRAM_SIZE;
 
     switch (machine->ram_size) {
     case 64 * MiB:
+        sdram_base = SDRAM_BASE;
         break;
     default:
         error_report("This machine can only use 64M of memory");
@@ -269,8 +272,8 @@ static void r2d_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate memory space */
-    memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
-    memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
+    memory_region_init_ram(sdram, NULL, "r2d.sdram", sdram_size, &error_fatal);
+    memory_region_add_subregion(address_space_mem, sdram_base, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
     fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
@@ -338,7 +341,7 @@ static void r2d_init(MachineState *machine)
         int kernel_size;
 
         kernel_size = load_image_targphys(kernel_filename,
-                                        SDRAM_BASE + LINUX_LOAD_OFFSET,
+                                        sdram_base + LINUX_LOAD_OFFSET,
                                         INITRD_LOAD_OFFSET - LINUX_LOAD_OFFSET,
                                         NULL);
         if (kernel_size < 0) {
@@ -352,15 +355,15 @@ static void r2d_init(MachineState *machine)
         address_space_stw(&address_space_memory, SH7750_BCR2, 3 << (3 * 2),
                           MEMTXATTRS_UNSPECIFIED, NULL); /* cs3 32bit */
         /* Start from P2 area */
-        reset_info->vector = (SDRAM_BASE + LINUX_LOAD_OFFSET) | 0xa0000000;
+        reset_info->vector = (sdram_base + LINUX_LOAD_OFFSET) | 0xa0000000;
     }
 
     if (initrd_filename) {
         int initrd_size;
 
         initrd_size = load_image_targphys(initrd_filename,
-                                          SDRAM_BASE + INITRD_LOAD_OFFSET,
-                                          SDRAM_SIZE - INITRD_LOAD_OFFSET,
+                                          sdram_base + INITRD_LOAD_OFFSET,
+                                          sdram_size - INITRD_LOAD_OFFSET,
                                           NULL);
 
         if (initrd_size < 0) {
-- 
2.51.0


