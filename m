Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B79CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewU-0006d1-6L; Tue, 15 Oct 2024 06:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewS-0006cP-EU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:16 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewQ-0005vc-CC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:15 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso2638128e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988692; x=1729593492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DpVjyeCW+BZmlGUD07St+L+sXb8OqynaasaoJirP3bE=;
 b=cF93caeBQ2lBocu8mzRFgwOGpmfhB66AOpdpLvMmLBQDNczs5tHsnFU4l/QU55L6pD
 dMXxjiQGIGaKqjlXlZlrb4JmFuFcKc6/cLgLkwnUuIrS8UJoBjDFRtB90khs0mecu+w8
 nowWgRs2uj8oeJOO8axDtBQCtO9lVwJt/bschALjt4ZWCxf7Z6QrEHtt9gshD+LXaK/1
 tfLmhPlePyGH7Ru3LLYH+7hAIqItChwoAT2EmEYDuu1qPdutPizO05pO+ZcBKCs0kQyd
 k2FtzbsBpyL3KV4yyq6LJvD/lTvvHv5OMIv+8jACrXVvzvFJ/zzTUSo9n4PlGrxb9XIJ
 iWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988692; x=1729593492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpVjyeCW+BZmlGUD07St+L+sXb8OqynaasaoJirP3bE=;
 b=vpEgPnooIOSI0Zq8fBltBZEsoR/7SE42CgLDrE1dQNXjZdOoe6XnnBTCgg5JFuKfXk
 qs9CsmWE8VyTVyMjimpCoC/1MD//N23qJdYe5CftRZVw67e8ogx7X5w+jJg9VS1uRlNA
 osmJmJbL4cAhcFHxUmMeU1n9Kgfuamj9WtWRDVGR9CM5QMoeEmtdekqaaHpGcavhh2Oj
 NMbGvVaPahqmNe5vMPQpTjAAGAEwgMPtSLOVKdQwefUFzJtrP/mABPxAESXnYtZo5rOf
 8Wgl/u7xGGy7RGgXdncmGQYkE8IJKzSXgSUcfcUFd2I3oGS8lDywfeLXkbwzJ9aBLBbh
 43kQ==
X-Gm-Message-State: AOJu0Yz0rtK/gbnSFiaTv96Z4DO3c5B3Efq+FTCi3WBoL2a1nMKM2PeQ
 lcauzJeE/DQUKn9ZVGCNZ2xRt+xpcmyoNO7lbgJSsIHUMKSLW7SStXZo/qauf9xTyGGxCEA64jA
 X
X-Google-Smtp-Source: AGHT+IGCD3KvRE+ICy35hmJjCj5eEyr7MsNfCliEGxCcEMjvF1n4cY2ZwBeVOfdKRd8XaaSGQ7U1cA==
X-Received: by 2002:a05:6512:b96:b0:539:edf4:68b4 with SMTP id
 2adb3069b0e04-539edf46b73mr4539090e87.57.1728988691618; 
 Tue, 15 Oct 2024 03:38:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/28] hw/intc/arm_gicv3: Add cast to match the documentation
Date: Tue, 15 Oct 2024 11:37:44 +0100
Message-Id: <20241015103808.133024-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Alexandra Diupina <adiupina@astralinux.ru>

The result of 1 << regbit with regbit==31 has a 1 in the 32nd bit.
When cast to uint64_t (for further bitwise OR), the 32 most
significant bits will be filled with 1s. However, the documentation
states that the upper 32 bits of ICH_AP[0/1]R<n>_EL2 are reserved.

Add an explicit cast to match the documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: d2c0c6aab6 ("hw/intc/arm_gicv3: Handle icv_nmiar1_read() for icc_nmiar1_read()")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index bdb13b00e98..ebad7aaea18 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -781,7 +781,7 @@ static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
     if (nmi) {
         cs->ich_apr[grp][regno] |= ICV_AP1R_EL1_NMI;
     } else {
-        cs->ich_apr[grp][regno] |= (1 << regbit);
+        cs->ich_apr[grp][regno] |= (1U << regbit);
     }
 }
 
-- 
2.34.1


