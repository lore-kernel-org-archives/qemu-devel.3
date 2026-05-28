Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487AECD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSclN-0002Na-Gu; Thu, 28 May 2026 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wSclE-0002HA-Ce
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wScl8-0007aj-2H
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so54797395e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982496; x=1780587296; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Prn28n3Jtc9lkZ9JMLt8fUDHcxOQUIzcf136Tt7m1Jc=;
 b=a6m37c9WYhFVPWQ7/aD0uNXUQnxzYVQIRCyzzuOQwzSLjwK36/jOkPakY6d9dV8rPz
 yaVslAOiQdYbhvEtJYe7pRUHu4zwlLkYWy9x1260W0Pn+IN5+eSJZxUxva2+NxI0gXXa
 SV7GhyZ/cr52SMRkQvamcELVwgtRCEwzF6MeDxzLpJZ4XiBUI41dWUcKV7lIJjMRYQlr
 cv5LgSdfU37DBqEOsJIpcyENR1p0gurMB0B62XdSWpXNP79EFdL7hkFOk9FrJ67jJmWb
 8Lt07JOyvJ3eGasRVQUnn1//NOTI9KaaZkmKey1ylJGxQSN3JkNblASH4YE2XWmD3+ae
 Z8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982496; x=1780587296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Prn28n3Jtc9lkZ9JMLt8fUDHcxOQUIzcf136Tt7m1Jc=;
 b=C67MbRA7CRQnUxaP+FsIXDbTE+qGbgzG8JX6PrirRk/pCU3ChRHY2u30cnxOCuILRw
 pWmwphxBM+vJwDz8h/gwyxrWlpWydTBaiHZ65LFtVIMbVCXNuajgNFqI8ZTixK9oB/ls
 BSCrxWecyPCJYrleXINacfcGo+oOFmim0yJyCesNff10TyBRslZr+9+F/xSmYkLod7+L
 K3mUV7t0T+qneo8Hl0p0PgaojlouYDgyyC1kiaEQVkBkjCSxukLn3gGiRT5HCiw3EkrW
 CU2U8MpkhzgX6DjHI5lkb9ivWuEi1HLmBhwUoj7riupW0qK20dYjn5StB5LLy2hbWrVT
 vu8Q==
X-Gm-Message-State: AOJu0YxdVFmdzgL+Eeu80Z6zCuUZbSfU/G0fUfi9FtA6Z8eTWrY3JxiH
 joWjJ/uj7LSES1bCFdyVpm/9BlOpED6vCytaIUfBSrnFPult8BfndQ5tht/O+Wj5zs8=
X-Gm-Gg: Acq92OFdbqvznKe+zRnC0Uk/KGO9Ed6ycO72aq6c/BAlscIof7hoP9q5+8+z4u36GIm
 8BhfrpuV10FuPrrS5RlIDm7zNCtDmGR8IbR5E0EUBEFLCw065Gg+o7YM82jkM3o6Q0MzZ0Q4DQW
 iwkj3n9Jg3dw7AM72FyU8mqS2bBR0duMdOpgIKpYSNT47swqPRwP013s9W47CezfUEJqjena7a2
 t4BaGZ0W/h6uNJ4LDl5eDbzlkciUgLzzbd/cmUyru2i5XlVTIRf0gXJ0uWApvLr9ROfl9qiARXJ
 c9dm2BFO+p+4962rhdAGFb6IvOsNFbThXyonpUwmo6zYs4kB44AtNg+2NIoIc/uwMKGQOocLOui
 e+cMSp/FQXCaw2wwBfHZ9drHqY5RBTtTvTmePB0/vfWlAmNN6KhO4CJ9HRnxekWBPUL7EHKQS3S
 DUC+OxpzcaHQuwDZqmm5hN9c3ZxejnwxYvZgNCrsIzwR2u+wgP
X-Received: by 2002:a05:600c:3b8d:b0:490:50eb:b753 with SMTP id
 5b1f17b1804b1-4905eab6ee4mr370729435e9.32.1779982496502; 
 Thu, 28 May 2026 08:34:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f5a7:372a:ab8b:3c01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm46514785e9.11.2026.05.28.08.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:34:56 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 28 May 2026 16:34:38 +0100
Subject: [PATCH 3/5] target/arm/ptw.c: Add Granule Bypass Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-jmac-gpc3b-v1-3-d34c46c5069f@linaro.org>
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
In-Reply-To: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/ptw.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0a5201763a..46568cc5cb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -341,11 +341,21 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         .space = ARMSS_Root,
     };
     const uint64_t gpccr = config.gpccr;
+    const uint64_t gpcbw = config.gpcbw;
     unsigned pps, pgs, l0gptsz, level = 0;
     uint64_t tableaddr, pps_mask, align, entry, index;
     MemTxResult result;
     int gpi;
 
+    const uint64_t BW_ADDR_SHIFT = 30;
+    const uint64_t BW_SIZE_SHIFT = 30;
+    const uint64_t BW_STRIDE_SHIFT = 40;
+
+    uint64_t bw_start = FIELD_EX64(gpcbw, GPCBW, BWADDR) << BW_ADDR_SHIFT;
+    uint64_t bw_size_field = FIELD_EX64(gpcbw, GPCBW, BWSIZE);
+    uint64_t bw_stride_mask = -1L << (FIELD_EX64(gpcbw, GPCBW, BWSTRIDE) +
+                                      BW_STRIDE_SHIFT + 1);
+
     /*
      * We assume Granule Protection Check is enabled when
      * calling this function (GPCCR.GPC == 1).
@@ -383,6 +393,28 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         goto fault_walk;
     }
 
+    /* At this point, GPCCR_EL3 is valid */
+
+    /*
+     * GPC Priority 1 (R_GMGRR):
+     * If GPCCR_EL3.GPCBW is 1 and the configuration GPCBW
+     * is invalid, the access fails as GPT walk fault at level 0.
+     */
+    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
+        /*
+         * GPCBW is invalid if the base address is:
+         * not aligned to the size programmed in BWSIZE, or
+         * greater than or equal to the stride value configured by BWSTRIDE.
+         */
+        uint64_t bw_size_mask = -1L << (bw_size_field + 31);
+        if (bw_start & bw_size_mask) {
+            goto fault_walk;
+        }
+        if (bw_start & bw_stride_mask) {
+            goto fault_walk;
+        }
+    }
+
     switch (FIELD_EX64(gpccr, GPCCR, PGS)) {
     case 0b00: /* 4KB */
         pgs = 12;
@@ -431,6 +463,23 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         goto fault_fail;
     }
 
+    /*
+     * Bypass window check.
+     * I_JJLRM: Granule Protection Table (GPT) lookups can be skipped
+     * in portions of the memory map by using GPC bypass windows.
+     * I_XNHTX: The GPC bypass window check (...) is performed
+     * immediately after priority 3.
+     */
+    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
+        uint64_t bw_size = 1 << (bw_size_field + BW_SIZE_SHIFT);
+        uint64_t effective_address = paddress & bw_stride_mask;
+
+        if (effective_address >= bw_start &&
+            effective_address < (bw_start + bw_size)) {
+            return true;
+        }
+    }
+
     /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
     tableaddr = config.gptbr << 12;
     if (tableaddr & ~pps_mask) {
@@ -3817,6 +3866,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
         };
         struct ARMGranuleProtectionConfig config = {
             .gpccr = env->cp15.gpccr_el3,
+            .gpcbw = env->cp15.gpcbw_el3,
             .gptbr = env->cp15.gptbr_el3,
             .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
             .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),

-- 
2.43.0


