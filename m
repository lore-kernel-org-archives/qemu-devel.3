Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639F9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgG-0007LP-UI; Mon, 29 Jun 2026 08:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfv-00071u-MW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfu-0007ZX-0K
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so190123466b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734476; x=1783339276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F0x/ajmQ2uQVMdgcXju1w+He09D8jrvrrV+1HV0u4K0=;
 b=mW6i5Zb3PWmWejgzMNKzVW+wk3Kt7rS3f3P+Qd5Zj5abdKefFF70lBV8PykCCgu/Ia
 X4yn2KbxWXnMMuFtSMXNgDrbd76U+e3DEzym0iqKWj2lFa91At8HHxZF4mfLHFTCvb5M
 6PL8Leb0tP78SqjcKOmZqrYjNxdWV07QupkRgp7YdR1I3U7tvHmBEway4/dy0C4NGHMy
 uD0D3P0MgDd7KCI13btYtyDycbXcit5PHgWfmxPQm/4vxpHbw03WiMDIhiP6Lln5dq3d
 MdCn1f7TNqHGfPwlZIQZAWxl1R/K3YA8tZ0EKxgoBOw9iWWysJdr4n2xwI2xQuZw00RK
 cvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734476; x=1783339276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F0x/ajmQ2uQVMdgcXju1w+He09D8jrvrrV+1HV0u4K0=;
 b=ASFhJyvhHWbeICy8mlsBKMFsRGKfHZbXu9YYJrmSvGcUNa/m5zwhmgQCExQkq0utyc
 Gxjd444iUUdPaEwnuHUgF73U2HfEkHjT/O1rapKedqOiPoOJpXfHEzQbLRpXv45hreXc
 guHkio38NDlmK9YEm33JYyXHBPNq7t1odymqRFFjD1pIGTVRNOhgu3O2Vadx3TSL1J+h
 zcrYEM7i0hWjY9azZAtgCok6rTLAGEW2/oVnoyuUuU8LLdoZ9+vroi6VCBwrqH4zLqdv
 ZeVKH89y6P46Xtv3Q9IUN3uq9H4VG1BLMI54iV4aNVu4cBin9IWwpcBRSaEW+GRTD7FL
 m11A==
X-Gm-Message-State: AOJu0YyDq7nRmHTvODR8RHXWOsByNGqBHHGDDqtKhXzrWnMT2VtHWWEH
 dOYhQjuzteCmQGaQVKH5eIyj3VuEDbiBQUh82giL0pRhl1lAYnrsv0c9vvm+PPoXa5VofvAcW1x
 iJsh4
X-Gm-Gg: AfdE7cma/E7dyrwth/kMCWp2byVwt4cCGoWNk5uHVv7DDlZPQOkvu+ovxGWKUuh2JDr
 O4goMrRJlDCJDfVwKmcMsl+8eEwmDM0Z+Ds3JUqnz8ftbaomNGRHyklgJin3SA+U0EzmfnfT5sS
 C58dTKY+MHf8vTtNzVIgB9PI0fgiEn1UPaxduXDRWhKGE4rTN9M7ZFqYlbe9me2qgIPsfiSH25C
 tZwkXAe+mWpIjJM7J6xPjJT73AsY/7lCxJoSqI/E9C9EcJfmgSZ7LLTvxvFyhl22o05wF3SBkyK
 TRnpMldO9n1gXAlMPk2TWAs1V2g/hwORSJ27P0KEYPGgRb+yYBcxFfRfwu8M4E/Btse5M4ahF5T
 m5R6Pn6Sm+KkVToewFlqo9/ZKK70hyMPHWs7V8BjxgfD+tpnl47phwCbPwlNTuAKnMAnhNDAeCv
 HN2YjquO+OkQWoWrQl5j6TaGwmV4ablv+9wV494ynN4zuo+I4cIA3d08Cne4gOf5KGLn6sSIKDg
 G0dOmZNm0Uk4UgrNYnQwQ==
X-Received: by 2002:a17:907:9694:b0:c12:2b10:e131 with SMTP id
 a640c23a62f3a-c122b10e261mr579787466b.2.1782734474979; 
 Mon, 29 Jun 2026 05:01:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/54] target/arm: trigger timer recalculation when toggling
 CNTHCTL:ECV
Date: Mon, 29 Jun 2026 13:00:17 +0100
Message-ID: <20260629120032.1645265-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

When toggling the state of ECV we affect the offset applied to timers.
As a result we should trigger a recalculation of the timer value to
take into account the new offset.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624124527.1018912-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 202ac99f69..71c0d3f4d3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1806,6 +1806,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
+    if ((oldval ^ value) & R_CNTHCTL_ECV_MASK) {
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+    }
 }
 
 static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


