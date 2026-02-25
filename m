Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6502FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5I-0004fl-NT; Wed, 25 Feb 2026 18:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5H-0004fZ-HY
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:23 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5F-0002Yb-T1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:23 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480706554beso3653835e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061260; x=1772666060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q6Q5twDVx+EMyTGURjeIurHbeB+x9YVAYczCagCNOKI=;
 b=bla0pk1WOy+H9pdwxFSCxcWWfxa1a1Z8HCRVaa558BX7wQSOxICln+wRaUM9ogn46D
 OZnb1vV5/Fg59apmYiD/3tPtXgXA6JtTdk3hnPQp5HmY4OQx98/DIdeoUwd9QDbRdEk2
 SefDf+fas6wF8PtIT0kZOn8RQPq7VDyzJExBql+RDdWKya/9SPU88jZVRRsgiqa7zz4L
 2HS1qjkLNIddCQnU2V/Sq4G8IPOtmEpXff/FSvLS/V4NSrhqv/M/EerDUW5TSPxA1dmY
 EqzA/Sc/iUu4uwbtJmobWzkB61jzFBlMB8wtPEUURfPxsaIvT4ANQuhxSOhIn/Ae1BLh
 og3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061260; x=1772666060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q6Q5twDVx+EMyTGURjeIurHbeB+x9YVAYczCagCNOKI=;
 b=LcQD2cinP/7uMCq2hjZoVX7MBlfZ6KhudpbfY7RSKEid0NfqtFeXU6GIsgW0Fb+t9n
 Suz1W3TH5kKJAw+2idYd5Bl2J+VtbIU23f9adEwB31m9B7oMF5eULRWX/p4r/IqVlww8
 PraPAv+Uvx4+Lk35/dW1PXWyeW0ZBUw/SvnpKnIiGW9Uw/9uW0XSoRHUnwVevgQl4zKP
 rxF1SRHwW+XwcRNi3TFfWc3SseRDeOjCYlvIuVI8Xmn/NMOmr4un+WD0aYWVEfgIfkhw
 cUBeeZQK8TvbV5ABAGkJyKv3lArgpGs9gFLyvHFLnr0Sl53QMFO13GXas/inLtRQa9hX
 +MAw==
X-Gm-Message-State: AOJu0YylD+o2jhuCZPkA72RxGOe0c/8YbA8oEJUolMZfHBmofbATSRa4
 6c3yDlxpovCKiUkYT3x9P28DZkBKcNETGs7R6ZCFwIdp0urYzquj/6J8dQ1HFrIlQMcCfxoMsu2
 ZdNhqrfw=
X-Gm-Gg: ATEYQzxBqYbC7uye42kgAOXDFUYZ4yisB/bcnoQjI56kO2e5MKKcm4B2pMw7YcSQHEZ
 b9KukBLLFBuBfBsjTzJ5e6gB0x9AkzvHKahNFDDBB6GSn/RC4yvP230/aOmEwTzWo1yCjL19I8Z
 M96qHBea087gIekAC4QQHU4emPh4K1YejV3iuWMfFQ1CJP0hjMC9OKL10NIba5XVR14niH2ikMw
 QLEWTV5nqBzrKWG3sBoqwcFwYHnvToXJCpCJ+kL598c2mwrHIWrBiW10OQZtpSw+cRPkEfb1obY
 /pnilYO+L92rrS6D+TtPNIN+4VV3hMkLF7FHyuX1G/4Ht2jiFGco+5t0IHqtXvOXPlO7zN9GsG8
 zn9dIkOL+lD6+RP90Y/5HDqCUxdAJ33s8iNWCEziGfYJPVBgWtemYu2U1FDNlZR7J/h++44ttfp
 MhuVq4/jpNx5hEiCPTr/gBI447OY1YdTsy/XXBfTPhUnN78HYAlrzC1SJb1nbrkaMTLnGgcIqf
X-Received: by 2002:a05:600c:6815:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-483c21a10c5mr36598535e9.27.1772061259860; 
 Wed, 25 Feb 2026 15:14:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3474dsm4795205e9.1.2026.02.25.15.14.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/70] target/hppa: Define PA[20|1X] physical address space size
Date: Thu, 26 Feb 2026 00:13:01 +0100
Message-ID: <20260225231411.96482-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Anton Johansson <anjo@rev.ng>

When converting virtual to physical addresses,
TARGET_PHYS_ADDR_SPACE_BITS is used under PA-RISC 2.0, and an explicit
cast to uint32_t is used under PA-RISC 1.X.  Replace the former with a
more specific macro limited to mem_helper.c, and make the latter
conversion explicit by defining the size of the physical address space
for PA-RISC 1.X.

Note: while 44 bits should be used for the 64-bit address space running
a C3700, 40 bits is still chosen as this is expected by the SeaBIOS
functional test.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260218-phys_addr-v6-1-a603bf363218@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/mem_helper.c | 32 +++++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 012e54f8f6f..092e647ccf5 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -336,6 +336,7 @@ static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
 }
 
+hwaddr hppa_abs_to_phys_pa1x(vaddr addr);
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
 hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index cce82e65999..9199d1e06ab 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -29,6 +29,28 @@
 #include "hw/core/cpu.h"
 #include "trace.h"
 
+/*
+ * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-bit
+ * machines 7300LC.  This should give 44 and 32 bits of physical address
+ * space respectively.
+ *
+ *   CPU model        Physical address space bits
+ *   PA-7000--7300LC  32
+ *   PA-8000--8600    40
+ *   PA-8700--8900    44
+ *
+ * FIXME: However, the SeaBIOS firmware that is that tested against
+ * uses 40-bit physical addresses, despite supposedly running a C3700
+ * with a PA-8700 cpu, so use 40-bits for 64-bit.
+ */
+#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 40
+#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
+
+hwaddr hppa_abs_to_phys_pa1x(vaddr addr)
+{
+    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
+}
+
 hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
 {
     /*
@@ -42,8 +64,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
      * Since the supported physical address space is below 54 bits, the
      * H-8 algorithm is moot and all that is left is to truncate.
      */
-    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
-    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
+    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
+    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
 }
 
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
@@ -67,7 +89,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
          * is what can be seen on physical machines too.
          */
         addr = (uint32_t)addr;
-        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
+        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
     }
     return addr;
 }
@@ -217,7 +239,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             if (hppa_is_pa20(env)) {
                 phys = hppa_abs_to_phys_pa2_w0(addr);
             } else {
-                phys = (uint32_t)addr;
+                phys = hppa_abs_to_phys_pa1x(addr);
             }
             break;
         default:
@@ -558,7 +580,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     /* Align per the page size. */
     ent->pa &= TARGET_PAGE_MASK << mask_shift;
     /* Ignore the bits beyond physical address space. */
-    ent->pa = sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);
+    ent->pa = sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
 
     ent->t = extract64(r2, 61, 1);
     ent->d = extract64(r2, 60, 1);
-- 
2.52.0


