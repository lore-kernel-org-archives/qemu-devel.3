Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA79C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCS-0003yC-2Y; Thu, 30 Jan 2025 13:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCF-0003sy-B7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCD-0000WE-Lb
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d161947so654130f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261400; x=1738866200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfOY/642ADAin6VFxYNR1rJN6MAtVOu/6BLcp/293aA=;
 b=fZWPrBnj3cItmlANqIkoP1Eij6As5zyGwmu2l1uGAPepW8ZcL7CWvJDIjjR5nwGZ9Z
 2XG/9aVqi1kh7W8xjdyAsPnvHg379Lsi52iljjwgQsrGU5dKEppWtO3vG/AGS/nGG/Rj
 HLNlXYvs6MxWkQ1nix+VNRkxlFjE5ooS+f3tcSzTDiYz/OBcs3zcX/8o4O2sLs5oBnJs
 OzrvN/Q/kyR6g+H4jYwQx9dEhYstZGxiMRQLw35vRel4kb1CjmS42N7KjQfjJhjEOdcM
 Iu2mqoWY4YC/rgHKYfcZ/NNMncU0+YsfDNkSq7lvBulCjNCG4KFWFXBdr8x/tuANAE9/
 EyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261400; x=1738866200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FfOY/642ADAin6VFxYNR1rJN6MAtVOu/6BLcp/293aA=;
 b=xUOGfpAMd5MQqIoH6b9+v8nOU4xaCd6a4sV9n26337uKO+C9IYaKOl5PvlZr5CJCrR
 IFMUzEEIAuTX8h2looZLaO8/SnBzHi8lOgA6REnjXGfsG98p9Dkb6X2csbkKAS/cnSiG
 u4BYzEdn8j4n/jHLDqgYP4p9gj4wgzpvN1TOlkCfISZbNiqofLimfc+YJ+bMs233/+c0
 lQw3xqHAems6u0QuuKtM9+qw8hlp8eVKmO2LSizqU7Eno8X+RPUNkHS0T9oPpQnspCnJ
 dTxdQ2GPU5M8/V6VrbB2U908u+wA/RBGGCczg15aC6X5B609KOFLf9MA+sydZcDYBh4p
 /aHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH6PuvGdP4Zv8P/G1SV4VA9kViN8hmbetx0g7JFQ3kX3eEd51s+TPdW69N+X3HUUdzg8XDkGlqYmfP@nongnu.org
X-Gm-Message-State: AOJu0YyVDXGslcAcPV8aHum9oJodnJ8TbF0rC9L5pYLamvDgKT2FO5C4
 HKZge6l2KRqlnX3YVKAaZ+UqheB+k1QLwks+I2v0wcjvSy2rQyzSmtAz9JSwqNdlN/3sC2kDrvJ
 U
X-Gm-Gg: ASbGncv390XuibvfHTj/32YyS7CEIn8z8uyoO6WZxifJGSM0BuTZ2SjOVTxD9d2s6sA
 X4B/VRfVbP+VS7QPH7Jkj/XhGEDsoIU650psXZRxitqa8S9nBFl0sPsb6s8CLrN5LKRmpiIk8JT
 /ETGo/GpHB6LTSPfhrRG/ZxFMeU22JavKEU1pjKJ8TxSw9rMOoO1bBg7xzx02MY31gVYWAK/8+N
 8eZeheqPepBRxzgpPY0tKvWvdkPTIhRTTaXCYVZf+jSNVX0z/UsO3QNnOBfht2zIz0RGi47xI69
 MwGyHSF0W9vfBP+v3CkhkA==
X-Google-Smtp-Source: AGHT+IGiuiMHrThD+uWTll5N2DRzacpqO1X8j2qlN8vV9ZDCgL/ut6vM/QMSQvs3Geru69+PmJUeug==
X-Received: by 2002:a05:6000:1866:b0:385:fdc2:1808 with SMTP id
 ffacd0b85a97d-38c52094219mr7873930f8f.40.1738261399765; 
 Thu, 30 Jan 2025 10:23:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 08/14] hw/intc/arm_gicv3_cpuif(): Remove redundant tests of
 is_a64()
Date: Thu, 30 Jan 2025 18:23:03 +0000
Message-Id: <20250130182309.717346-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

In the gicv3_{irq,fiq,irqfiq}_access() functions, in the
arm_current_el(env) == 3 case we do the following test:
    if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
        r = CP_ACCESS_TRAP_EL3;
    }

In this check, the "!is_a64(env)" is redundant, because if
we are at EL3 and in AArch64 then arm_is_el3_or_mon() will
return true and we will skip the if() body anyway.

Remove the unnecessary tests.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 8a715b3510b..7f1d071c198 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2291,7 +2291,7 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
             r = CP_ACCESS_TRAP_EL3;
             break;
         case 3:
-            if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
+            if (!arm_is_el3_or_mon(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -2353,7 +2353,7 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
             r = CP_ACCESS_TRAP_EL3;
             break;
         case 3:
-            if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
+            if (!arm_is_el3_or_mon(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -2389,7 +2389,7 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
             r = CP_ACCESS_TRAP_EL3;
             break;
         case 3:
-            if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
+            if (!arm_is_el3_or_mon(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
-- 
2.34.1


