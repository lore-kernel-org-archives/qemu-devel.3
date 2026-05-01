Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B5FCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuI-00042Z-9Z; Fri, 01 May 2026 06:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku1-0003x8-13
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktz-0008L6-4T
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so29038645e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630517; x=1778235317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dwdpNuQzmGhSaNwgQnbl3GNGGmyJ/o/emE+Fj3bUbk0=;
 b=c1oLbFQC9wb0vkDx+pLZdklwhS9yFRGJMvewPfH116RwSlnASE0p8CP+D3dyYZI45K
 aTyzyTMYpfe+Ikx8/sTVwJ7LKmDk56GXUNCyaktVKfvKz06xzM2DRKMkSWlnA2a5//M2
 /f3dUtXbYdiX6WGWIv5ijLXf8dKqrAhBnO9JGOVBNIB1WCzj6rfXnFwyYdMF1KfI8Udo
 jnGJjERppwXPXurvtaaR/4y4mL1sBaaCeOEni6jjdoiBFCDkODD3PjarRzT5+vVu9mKL
 stVt681ok631iIF2ZPRf9SRBBMCfiJ87uRNzq0XjYQpBSVS73z3lskqHu39OHOeDy2lz
 rq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630517; x=1778235317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dwdpNuQzmGhSaNwgQnbl3GNGGmyJ/o/emE+Fj3bUbk0=;
 b=G9lX5zEgkl+HvS0cCecIdx6ztE19g8W3J6odYYcs/mlvfOskhK03pvhPI9M4I4ULOd
 riYADBO0NVYK4ktK77gWNaRZ02VOLAbzlbFjBbtgNh+SuUDwro2AHDK5Nrj+vbtO/FSA
 nemh1s7WEd6vGGnUCgqAglQkqyi5UugLfjZxo9WXW2pHOYjlplOQBIF3LTRNBc4gxMd3
 XzyavM5EuxMtueTfhFf/gAzFhHBANOTLxyPQmz4ErZZ5k8WUVPdRc9BT+EMOte5gU/8K
 P2lI9+5VTdrrPDcCQpF8tZSNDrTR7uHXAnO9l+pZRPCLEiFwqWM0R4YLTCOZmgBrqap1
 HNfw==
X-Gm-Message-State: AOJu0YwzHjKAolFjRq5nAAZy3G6o9YjcBO3Rs/jWvojiEKS10oZeAS0f
 cKkJf3EIFM96NfWwK87bdtdqLBJcuHJIghNAEOylxx2KWK4b0qvFd0N2b+if2V/2TKRxwiFpokI
 FjI6f
X-Gm-Gg: AeBDieuPMZIwBHTbl1YHlqfrF+cVwq8ohvjJP5Z7ukHeFCMULbT2aPAxPPuoZ97bxES
 c/5fyYWziGIUGlBO80tsezBggV+fZUAntd+HV+pnbQ2zAnTz8IDqLLIVlcQWupnCCxKOq1LyxKQ
 u0qSH9L/N1XsLSVCIRl3bhFXTCzELHEwiBXghy7w8/UvRK+yUcKZniQOOLqGbONyss3WSaOrJp9
 twnLVa9UPC+cVPvXBM9u5p7OAtvscrphyBmRrbPz/LcSTxBUxhRI3KDPtDyhG5AWQVvhd0BOWfU
 UjfDTzKjkkXBTPGqkdVVQxGBOEe5p8qZfmJ2zysyygKLBhxYKMuiZ5EuDXE9wNF4WwnltLi3aVw
 vEO5WKlZ4pbzqgpMYnH2d2jXY1fsinGhwPhUOUqsO5T6S3AxGMKKbdHc9UEWx9BSVSbUOZKVepZ
 54YbA3Rz7gK5/BmIxvEPooVpyvqUzK3YymLD9S7uo0pp1s0JRk0fMss/WSssw+1+98XoFHtI3+1
 UztI7u0znUr2zsVMLZQggLo6cBU+QnOcqHur3w4QQ==
X-Received: by 2002:a05:600c:3e10:b0:488:a2ac:a34c with SMTP id
 5b1f17b1804b1-48a844533d6mr108261655e9.12.1777630516902; 
 Fri, 01 May 2026 03:15:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/28] target/arm/ptw.c: Add GDI spaces to the granule
 protection case
Date: Fri,  1 May 2026 11:14:45 +0100
Message-ID: <20260501101505.3485916-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

System Agent, Non-secure Protected and two other GPI field encodings.

These are explicitly denied access for any processing element when
the relevant GPCCR bit is set, and reserved values when the relevant
GPCCR bit is zero.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260421-jmac-feat_rme_gdi-v3-3-ecd20c77eae1@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7b993bb5b3..316e201cfe 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -510,6 +510,26 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         break;
     case 0b1111: /* all access */
         return true;
+    case 0b0100: /* system agent only */
+        if (FIELD_EX64(gpccr, GPCCR, SA) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0101: /* non-secure protected */
+        if (FIELD_EX64(gpccr, GPCCR, NSP) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0110: /* reserved if NA6==0, otherwise no access */
+        if (FIELD_EX64(gpccr, GPCCR, NA6) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0111: /* reserved if NA7==0, otherwise no access */
+        if (FIELD_EX64(gpccr, GPCCR, NA7) == 0) {
+            goto fault_walk;
+        }
+        break;
     case 0b1000: /* secure */
         if (!config.support_sel2) {
             goto fault_walk;
-- 
2.43.0


