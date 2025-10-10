Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470DCCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cox-00069b-0A; Fri, 10 Oct 2025 09:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cop-00067I-Gj
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoX-0003lM-W1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so2384193f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101536; x=1760706336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=op1IEfIKIcRCoQLOQttqu/+UadW3y7InhKh3c9xcRII=;
 b=obknaknlqp4Ni2Xp6bbUrpApDxbLjFRuAr4jdFWggBkodd/dhZ/EeA1KiffnPVHxlD
 37ZHLzmqJ/xMs2V/R7eazVkeHkV8PQ3x+FSrb+lCzIz1r1xomg+J+4Kv4hF9FFd76lmB
 PHZFk54eRAJxlkfoO9NPv13MWFjPGcnu08dLB0Zw+g5ar3/tc1/Ax6twRWZDEQ6fFQ+8
 HKzwc+6/CKQhuaNYTCeGcU0ZX2agAxHn6HL64kYMuy8MaLUEP3AuFosyQZUSdIi1Avve
 1sNbHEMPNkZaZ2uRqaUYbbluIiFkkJcEUxtt3ap+LzchhMcvmzw0RRaiGSSzkK6wqSVG
 gDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101536; x=1760706336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=op1IEfIKIcRCoQLOQttqu/+UadW3y7InhKh3c9xcRII=;
 b=MED1R2LqZO7O2JlgIuTL7XoBhniOFxZumZy/LVjz2IRGHgDVLomC5eiprnBFZJx8Xf
 HcYbLNljr51xFxMi8G8Kc+5I8NVOYtuDeR18NHQyqNvGP8MMqJYZ+0y0kMQsO/uezPhR
 r/jJ2P+9pjP+3ygEt4kRilOX6N+1xi5XmQIKZySsbMNgCVMWYdVmEieA7ekZ/0THr7Dm
 QyAEpa6L9v8umCcUBL3VBOiYHYPNqV2JECT2tROjZWJ4y/ODogNIV1warjCGq8v5JD5H
 qcS7VutEknsQTB1eqk71c3YV6N9PNdhvTeyf6aLg7nL26EA7DU5KetUE1WSc8o6YyXDM
 QeIQ==
X-Gm-Message-State: AOJu0YzEY342pGvnKWHbWst5n/u+66mkz3NfSzvzvYc99c/Y5CqAk/2b
 5rDnV6CQIVAZ6b2+oEM7BY92dJYO6PRWyjWl6ANfsdyXabAQ3TvehzbPRjcUFe5mLELWUgEjfG+
 7Xp5R
X-Gm-Gg: ASbGncv3rZ7rPBHhg2p3MF5RcgBlxkYNGG7xulh7gjNM72rZpy1s6PTXyVdQ6mP2vNI
 VLLBkZBuh9nQJonxxUSO24ou1rz35ZgtTarH6CAZdGq2MPTYDOLxqBYFqAtNcvah/XMfKcK56vy
 delGT3xUgGFxO+43OpiijUnCG6X2VsixRINNEab9Nyh0VUJJsUiHR3UzOy2FD1eeeXKly1Xihhd
 v0wn2y4vggveyz9bQ2JgRlNTVK5VJINjsMLLb9WzwPJwn28E4KfrewuCLw/APrp8jDstDuFuiPc
 GuWm58sm7tqjJrOohtQGMoHC2EgrnWR0bgA5wVzILIOPRScA3FB+MUGjYQ6z9P5QnJ3eBRpwyWb
 DMNSfW1DnwasIcU/YNquEN5yG1GbDU3w9iBP6v0cuW7hhYll35nghBZz6ONblJg==
X-Google-Smtp-Source: AGHT+IEmWLOuWJf4vCeyg7j3MBKkAf2QSpQJDffgII4Br1+Plvx6/lrOiUS4TLHAAnlyOE2xOa/+HA==
X-Received: by 2002:a05:6000:604:b0:424:2275:63b4 with SMTP id
 ffacd0b85a97d-4266e8e4cd7mr7611866f8f.61.1760101535684; 
 Fri, 10 Oct 2025 06:05:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/76] target/arm: Force HPD for stage2 translations
Date: Fri, 10 Oct 2025 14:04:16 +0100
Message-ID: <20251010130527.3921602-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Stage2 translations do not have hierarchial permissions.
Setting HPD means we can eliminate an extra check against
regime_is_stage2.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c |  7 +++++--
 target/arm/ptw.c    | 24 +++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20a189ef4f7..b7bc27436f7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9397,8 +9397,11 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         gran = tg0_to_gran_size(extract32(tcr, 14, 2));
         if (stage2) {
-            /* VTCR_EL2 */
-            hpd = false;
+            /*
+             * Stage2 does not have hierarchical permissions.
+             * Thus disabling them makes things easier during ptw.
+             */
+            hpd = true;
         } else {
             hpd = extract32(tcr, 24, 1);
         }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e03657f309e..26570231205 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1507,8 +1507,12 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
         }
         tsz = sextract32(tcr, 0, 4) + 8;
         select = 0;
-        hpd = false;
         epd = false;
+        /*
+         * Stage2 does not have hierarchical permissions.
+         * Thus disabling them makes things easier during ptw.
+         */
+        hpd = true;
     } else if (el == 2) {
         /* HTCR */
         tsz = extract32(tcr, 0, 3);
@@ -2014,16 +2018,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * except NSTable (which we have already handled).
      */
     attrs = new_descriptor & (MAKE_64BIT_MASK(2, 10) | MAKE_64BIT_MASK(50, 14));
-    if (!regime_is_stage2(mmu_idx)) {
-        if (!param.hpd) {
-            attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
-            /*
-             * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
-             * means "force PL1 access only", which means forcing AP[1] to 0.
-             */
-            attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
-            attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
-        }
+    if (!param.hpd) {
+        attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
+        /*
+         * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
+         * means "force PL1 access only", which means forcing AP[1] to 0.
+         */
+        attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
+        attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
     }
 
     ap = extract32(attrs, 6, 2);
-- 
2.43.0


