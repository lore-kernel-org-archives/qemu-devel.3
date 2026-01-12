Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AE5CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoK-0001it-KK; Mon, 12 Jan 2026 17:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoI-0001K7-8f
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoG-0003q3-EU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso5601482f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258491; x=1768863291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ah9BF/VcfsLL8VVVNiMpTcrCPmkwaYSoypo2iXLHxLA=;
 b=kPlVasWP8jULiANbGyWoD0ZSy5b84WeTsS43U/rEyAhnHQ+g+jwXdmMK/T7pG/0CpG
 MCF+bsCi7cMkVmx0zINt/IGQH5B/o9Cqi5N/xMoYgTZbcQh5c58scFNFcPUjNiI4MiBm
 ILEh8jnPGs0ebd0SP5/aeOX1iDkplPU+qwy6aWS5oBNm2m7xoyp7AAYk8wwEn8rg/1hI
 7perrz2Fr69wquFzUrI8TnajYTAsoCDj5Gmlv/hjJvomZzFMuukT9LAJLtBan5ICAByh
 8rsq8AK+Brao6TG5o5S/nh6AABM2GNjg8t/BnimHq8RlRPDzcdFXMBeb7BjKRTKuRAFS
 nEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258491; x=1768863291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ah9BF/VcfsLL8VVVNiMpTcrCPmkwaYSoypo2iXLHxLA=;
 b=AAOGVJ3wU1FOXBemS/ho/XZXvioa/bx+UNvk3ZLcXE/aD0IK4dq9YBRm/TThFSpEXX
 dr7Gpl7NieILr0r9vxZqL487m7cEe+swf0xA4MxHizNvyog5mb6FOSKsXduhYqOowom1
 Rc11UFjkQzcGa9tMPmJjYeqvqxNfPAzDm04NCtIAH5y+yzQh1zqeXf1VnpGo7HExdpZN
 Zwa1Fhg2rM9KIReRhxqBxxnY9EgJiyfjnQuC3hd6nqK+mBUwgetlF0P2rW4FO5leJjOM
 YHg82aZuCuGjxq+NhT8/JvYkB7ZJuM+bhNo4x9783LuopWgjhsFZO8FMwHvBYnN219HL
 WzVg==
X-Gm-Message-State: AOJu0YwWZb9v3g2zBRmQIBav8kTbfOQQrexLGYezYpCEyOJJ2zbgPk/D
 ehcNjW54s/F/rh1mSuMzxbWUKtVndsYfEzmagC0PxvWmfXCoS+KQ+c6h4Tp6nURWrJB8aYspWkY
 W7jrnixc=
X-Gm-Gg: AY/fxX7H/oC0Tdlm30/teBHhfhBHjOngcXv9BHcaw7bmrVfIVNqLGcQdj6+P0K32wN5
 Qz/lUM9qHucSUP5zNYkqMlXL5BoEc3gMg3oKEO7U1c69bPmtXJtazr/rAzNqlOHIBMDKoJvPntY
 zGarg9kDK2D78hoe0G4/jaiQq1ZhN2qdJMHM/T8ZUsZt9USWQ6pEp+n9S9vK4/l5FnG/cTNUsIw
 xbPuzGCr4SkSXA2avoH2n2IdwBs7l5VoEy05ioYDtJdgAIQrwW23psfNPhmq8UpNjN7ukoDUpnb
 uejSSg/U9SNzHuUMK8yyIBILSV1J1ITjEThvPfFiyiLXuZoG26oh9vWlRyAmP4MsQpF9MqnWFcw
 ILQ1/iiBrLwd6+H0tWvbcdp5u7xHGQBd01ChuUmSmhmBNpXX6Xouq5wPi2TbugqUrVvLUcLrqNc
 DFS6hMRA6gOWVAAZXjredTfYU5BFjnSfHn4PAZKKqcVRTFBzVy9Cqz2orFPLoX
X-Google-Smtp-Source: AGHT+IFwMLobgUCMmCWmKpuqKGjIPqcsikTS/fNCPS1TbUiuW2qE+fGsnMHYJfEoTvK5BD4bbQECrA==
X-Received: by 2002:a05:6000:1449:b0:430:feb3:f5ae with SMTP id
 ffacd0b85a97d-432c37a721dmr19382355f8f.55.1768258490557; 
 Mon, 12 Jan 2026 14:54:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df90dsm41009150f8f.20.2026.01.12.14.54.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/61] hw/sparc: Use explicit big-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:46 +0100
Message-ID: <20260112224857.42068-52-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The SPARC architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' hw/sparc*/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Chigot Clément <chigot@adacore.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251218221457.73341-2-philmd@linaro.org>
---
 hw/sparc/leon3.c   | 42 +++++++++++++++++++++---------------------
 hw/sparc/sun4m.c   |  6 +++---
 hw/sparc64/sun4u.c |  6 +++---
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d4e25f761a6..9147d56bd4e 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -79,21 +79,21 @@ typedef struct ResetData {
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 {
-    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
-    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
-    stl_p(code++, 0x03000000 +
+    stl_be_p(code++, 0x82100000); /* mov %g0, %g1             */
+    stl_be_p(code++, 0x84100000); /* mov %g0, %g2             */
+    stl_be_p(code++, 0x03000000 +
       extract32(addr, 10, 22));
                                /* sethi %hi(addr), %g1        */
-    stl_p(code++, 0x82106000 +
+    stl_be_p(code++, 0x82106000 +
       extract32(addr, 0, 10));
                                /* or %g1, addr, %g1           */
-    stl_p(code++, 0x05000000 +
+    stl_be_p(code++, 0x05000000 +
       extract32(val, 10, 22));
                                /* sethi %hi(val), %g2         */
-    stl_p(code++, 0x8410a000 +
+    stl_be_p(code++, 0x8410a000 +
       extract32(val, 0, 10));
                                /* or %g2, val, %g2            */
-    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
+    stl_be_p(code++, 0xc4204000); /* st %g2, [ %g1 ]          */
 
     return code;
 }
@@ -113,13 +113,13 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
 
     /* If we are running on a secondary CPU, jump directly to the kernel.  */
 
-    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
-    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
-    stl_p(p++, 0x80908000); /* tst  %g2            */
+    stl_be_p(p++, 0x85444000); /* rd %asr17, %g2      */
+    stl_be_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
+    stl_be_p(p++, 0x80908000); /* tst  %g2            */
     /* Filled below.  */
     sec_cpu_branch_p = p;
-    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
-    stl_p(p++, 0x01000000); /* nop */
+    stl_be_p(p++, 0x0BADC0DE); /* bne xxx             */
+    stl_be_p(p++, 0x01000000); /* nop */
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -134,17 +134,17 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
     p = gen_store_u32(p, 0x80000318, 3);
 
     /* Now, the relative branch above can be computed.  */
-    stl_p(sec_cpu_branch_p, 0x12800000
-          + (p - sec_cpu_branch_p));
+    stl_be_p(sec_cpu_branch_p, 0x12800000
+             + (p - sec_cpu_branch_p));
 
     /* JUMP to the entry point                                     */
-    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
-    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
-                            /* sethi %hi(kernel_addr), %g1 */
-    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
-                            /* or kernel_addr, %g1 */
-    stl_p(p++, 0x81c04000); /* jmp  %g1 */
-    stl_p(p++, 0x01000000); /* nop */
+    stl_be_p(p++, 0x82100000); /* mov %g0, %g1 */
+    stl_be_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
+                               /* sethi %hi(kernel_addr), %g1 */
+    stl_be_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
+                               /* or kernel_addr, %g1 */
+    stl_be_p(p++, 0x81c04000); /* jmp  %g1 */
+    stl_be_p(p++, 0x01000000); /* nop */
 }
 
 static void leon3_cpu_reset(void *opaque)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 8ad4eb46bbe..0c0d658d301 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -268,9 +268,9 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
         if (*initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
                 ptr = rom_ptr(KERNEL_LOAD_ADDR + i, 24);
-                if (ptr && ldl_p(ptr) == 0x48647253) { /* HdrS */
-                    stl_p(ptr + 16, INITRD_LOAD_ADDR);
-                    stl_p(ptr + 20, *initrd_size);
+                if (ptr && ldl_be_p(ptr) == 0x48647253) { /* HdrS */
+                    stl_be_p(ptr + 16, INITRD_LOAD_ADDR);
+                    stl_be_p(ptr + 20, *initrd_size);
                     break;
                 }
             }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d3ce32b6b09..5d7787fc1a5 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -206,9 +206,9 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
         if (*initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
                 ptr = rom_ptr(*kernel_addr + i, 32);
-                if (ptr && ldl_p(ptr + 8) == 0x48647253) { /* HdrS */
-                    stl_p(ptr + 24, *initrd_addr + *kernel_addr);
-                    stl_p(ptr + 28, *initrd_size);
+                if (ptr && ldl_be_p(ptr + 8) == 0x48647253) { /* HdrS */
+                    stl_be_p(ptr + 24, *initrd_addr + *kernel_addr);
+                    stl_be_p(ptr + 28, *initrd_size);
                     break;
                 }
             }
-- 
2.52.0


