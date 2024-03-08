Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB031C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAn-00024L-Bt; Fri, 08 Mar 2024 06:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAg-0001j3-LM
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:51 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAf-0001n0-6M
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:50 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso4803885ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896428; x=1710501228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DnEMCcr0Qj1knLItAv463oq6B5h3oQbJJe+Tph2P5o=;
 b=SlzzrVFSatuINXJY6kU8BrLm4zGe5Wxxm4fWEpm7i2UiR/bxb5ZYnIExAMrKnTfMRP
 QGi62+iEf1PyuhdSDQLibtTayELb1drIfMMJw3AbHLGFxIC6JJQ+s4uti1gRc+ue5vbb
 r6xA97X2qNki5erQvZPmhtQ3woqsk0a1dZ7eXPKCy8I2GXdO96W9xBUqCUELDwPO6QHJ
 JrQa3GXR15+3iZwg40G9GJfNwyGY5RJCiFpXEjY9PT11b3bdBJebrpLO6AgsrZQdN7xz
 S0w6Xo1m+e93IlCfMD7vvZuH678dxLQWMN7p2ZVJkLn1ycm8HHO4gnTVJb7HBvXQWnmd
 y3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896428; x=1710501228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DnEMCcr0Qj1knLItAv463oq6B5h3oQbJJe+Tph2P5o=;
 b=hoaK2sUCo7IxgtJ3JcV51iBC5MslbnSFR0c603jWI4lPsRWN18MhsCMM61Tk/iEMDI
 bdODfNQ5QNg9kJZmwKr48QjaBmMvu8GUDumMsaEiaLR2c7t8EWLFvf4SDrVcYhKy9gw2
 mIpy09z5gV8D8iM2+JaEhZRU3/G9BDUV2+eACaTqZ5gJD2G+hmWOenQigAZLMbGPw2Yb
 qu0QHv9gxOGI9RYkxUURJvSrZOrRb3y9w/OlcTzail5IRS9qwmc+dWxqj4la/GSpzvZQ
 j32WhE7JEobpHo0EF9jhJ1xnBiA2bENBhcmL8OKaDQ8XY7GVrM1u9qreZ1ci6hnAvPl5
 deDQ==
X-Gm-Message-State: AOJu0YzsjuMJPoAGSlqK1bKnYDstbUJiVSmYrAtJAAifQzeVp1BG+uI4
 WXQm8buEL7xPJY8QNWDbJO2YuS3hq1A+QShxGVsu9CCH3NSik3LV7zfvW31swxv6Yg==
X-Google-Smtp-Source: AGHT+IFQuyCppisNAP3DYunfseafyd+zW60Kl+JhE82gd8AhyEr/3O/9Zb8ThwaIrSeakkJjCor0jw==
X-Received: by 2002:a17:902:9a04:b0:1dc:a60f:4bf0 with SMTP id
 v4-20020a1709029a0400b001dca60f4bf0mr9624978plp.42.1709896427658; 
 Fri, 08 Mar 2024 03:13:47 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anup Patel <apatel@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/34] hw/intc/riscv_aplic: Fix in_clrip[x] read emulation
Date: Fri,  8 Mar 2024 21:11:50 +1000
Message-ID: <20240308111152.2856137-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anup Patel <apatel@ventanamicro.com>

The reads to in_clrip[x] registers return rectified input values of the
interrupt sources.

A rectified input value of an interrupt source is defined by the section
"4.5.2 Source configurations (sourcecfg[1]–sourcecfg[1023])" of the RISC-V
AIA specification as:
"rectified input value = (incoming wire value) XOR (source is inverted)"

Update the riscv_aplic_read_input_word() implementation to match the above.

Fixes: e8f79343cfc8 ("hw/intc: Add RISC-V AIA APLIC device emulation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240306095722.463296-3-apatel@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 775bb96164..6a7fbfa861 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -162,7 +162,7 @@ static bool is_kvm_aia(bool msimode)
 static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
                                             uint32_t word)
 {
-    uint32_t i, irq, ret = 0;
+    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret = 0;
 
     for (i = 0; i < 32; i++) {
         irq = word * 32 + i;
@@ -170,7 +170,20 @@ static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
             continue;
         }
 
-        ret |= ((aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0) << i;
+        sourcecfg = aplic->sourcecfg[irq];
+        if (sourcecfg & APLIC_SOURCECFG_D) {
+            continue;
+        }
+
+        sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
+        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+            continue;
+        }
+
+        raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
+        irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
+                        sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
+        ret |= (raw_input ^ irq_inverted) << i;
     }
 
     return ret;
-- 
2.44.0


