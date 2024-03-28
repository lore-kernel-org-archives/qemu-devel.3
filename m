Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBB0C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprl7-0008Pr-Ll; Thu, 28 Mar 2024 11:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprl5-0008Ov-Cl
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:33:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprl2-0006IU-Rl
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:33:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34175878e30so767910f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711640015; x=1712244815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HoXcWIswnaiYn+YGfxoqs8bfwHg7SCgsOteFXjUUrDI=;
 b=lrPq1BXStVueusSFfHC1HToxaenBcx4LtMGLV9TidOCdtHYBLjtDSt3tb29WngSAoC
 NeLSh7tRkAOSWCCuONOA+gByvIB/WXOkP7yPVcj61ZTLxijaCwaVfCzyjSSlkGgFHM/B
 hgZEwl1HyEQHibBhwfcQQ9qRHGaR0cGk7JGcnpSXyYB6LjIM7LMAQJ7TlC0j06MNE4hf
 uVkMNYbx0gu8pV3C+jciXZECTny49b9nY9Tr4L6P5fFXH23hYxNUkoK//zX1OOH4btFb
 4zpZZ2Bxu+BXbxkW9+AZWwgE1xyDU/eHyMjitF4Ijs/eg3ZZWolcxKb3/LZY3vKyBknv
 qrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711640015; x=1712244815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HoXcWIswnaiYn+YGfxoqs8bfwHg7SCgsOteFXjUUrDI=;
 b=i0iE6aefeCMxfOAHxKvrgaIIV8cP2ai/AIBxnXuB/nDa/CP+03e2UPcSU7xu2zeFZ4
 tkVpz+odQ3nsaH7hte7GJofCBKIKE0eWnUKcdIyalmsUs024ZQZ1Mj43cSBZNeT0IwZG
 zRj8mQ+zqOxuL3rHi1RNfXVjtLhEr468M1YzemZ1tIc425tf1+uVawuc7NXwhCtTJGWU
 5+CSMAScCsa63fjkZ+QTVMMH6lC+u/c8g1mpfCCHIMsN0C2Qbm3USqcaVPOk1nLmQe7g
 3sVAhi1ucyrd9iRz7kEt4NCZrSPIKhdkl/WWSdV8lDAGdD2Wgz/cRCjMXSy6CHaT/iik
 Bl3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsrsp5/TtW3W2blFzzVdUargIu2MUNQ7xPhsQA/SHXnOtm7sQYkl6WzlD0pZfQasFJl8UdgDR5luN10S7k7XnpsSyLFTk=
X-Gm-Message-State: AOJu0YxOFBQvKI9hkPoxsEYu3zTkV48yVMo6nyFwxjygYBsh9GFgcL19
 PGtN0xktQUoWyb/0bNsKW1bQtlFSPrGO9/p0wedjsbCYzbTy7qcyAKUz/nQEMoI=
X-Google-Smtp-Source: AGHT+IEJQrbm8joYzk/e6QuZrkxTUptRMqeUoXjYFQtfyn+KXmfNHVxZTB4Bid6M1w70nAMAkaKobg==
X-Received: by 2002:a5d:6586:0:b0:33e:34aa:d78a with SMTP id
 q6-20020a5d6586000000b0033e34aad78amr3033455wru.8.1711640014748; 
 Thu, 28 Mar 2024 08:33:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 bt30-20020a056000081e00b00341b9e11b11sm2067039wrb.24.2024.03.28.08.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:33:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is
 disabled
Date: Thu, 28 Mar 2024 15:33:33 +0000
Message-Id: <20240328153333.2522667-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

If the group of the highest priority pending interrupt is disabled
via ICC_IGRPEN*, the ICC_HPPIR* registers should return
INTID_SPURIOUS, not the interrupt ID.  (See the GIC architecture
specification pseudocode functions ICC_HPPIR1_EL1[] and
HighestPriorityPendingInterrupt().)

Make HPPIR reads honour the group disable, the way we already do
when determining whether to preempt in icc_hppi_can_preempt().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Pre-existing bug which I happened to notice while working
on review of the FEAT_NMI patches. I don't suppose real world
code disables interrupt groups which it's actually using, which
is why nobody's noticed it. Still, it's a safe bugfix so might
as well go to stable too.
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e1a60d8c15b..67d8fd07b7f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1067,7 +1067,7 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
      */
     bool irq_is_secure;
 
-    if (cs->hppi.prio == 0xff) {
+    if (icc_no_enabled_hppi(cs)) {
         return INTID_SPURIOUS;
     }
 
@@ -1104,7 +1104,7 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
      */
     bool irq_is_secure;
 
-    if (cs->hppi.prio == 0xff) {
+    if (icc_no_enabled_hppi(cs)) {
         return INTID_SPURIOUS;
     }
 
-- 
2.34.1


