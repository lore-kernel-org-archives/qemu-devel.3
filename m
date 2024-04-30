Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35127C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qf1-0002Lr-Q0; Tue, 30 Apr 2024 12:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qey-0002E4-Ej
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005bj-I6
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso42023275e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495725; x=1715100525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=irKefQelxCnFURnwBGv7uVNaBVY2VWGSKuE2g+7S4BA=;
 b=LOO/N4IGLWZQlAdFaEOPGRNaJ+FjgYh2APCiNrJ6z+jORWGrh96+fU0X7yIl6K6GSe
 qB6pZTFtGsBWeWMgrtcQIRAdc1/WvHEY8QnafV3ACxsDYBnlsE/naJS8bKOUQvycav48
 L6uAQqJG3bRme8bUMMyPf2tJuV3Bi3Y9ffBGXh+lTKApQqyghe8YsRZaDtcu7SC0dbNI
 VvJe7dWDDrIkDGh5zlR51A4wuEYeyQiCr4ULUNseI/tBimTfK7ZH8siFVgyACnv4uMjk
 rkTnYSl5qGNB53Olokx/cjcg2V97/QlONfjRTu5jTYjanAZUheGvYdwFE8HLmDaLRyOt
 LgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495725; x=1715100525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irKefQelxCnFURnwBGv7uVNaBVY2VWGSKuE2g+7S4BA=;
 b=b892ugu0DdR9AsVc4ZFz5igKXfQ/AOnZ5N2E/sC6U8xOMF3RWsw8Ny+PkoF/Tvr2ZH
 Pt4DR80O1AdqMlKmOUjKVzPEB5qqTMXfiBAzhdIbqgHGK8NpQJsqPn9Ctcd5hrbLL3cv
 aIfx/PFcb2/Ridlm0vpQVXfnD2OCS7mBs3EeboPs3bqYgHajoPNm19Re+TxMrEMY+Psj
 7E8wFFKcKc5pio+J21N4QkBeANUO59JY0hZaEhM9HAarvr8LfoA79oSrhKV4fFcjQSn7
 ue2MCyaurHzDv7WGRon1/jjuzIY3bZ/fh9b7MayGKvIECtEyZxqFnma3o3vMJfIMHUNv
 WXLw==
X-Gm-Message-State: AOJu0YyxP0exNGoR97LmLZeADK3glFFPQEp2vSdzvutZtmX1OGhiDBqC
 T47s3PcRBjJLaJXm1b5urnMOQm/V26kh43WorWr+H5IB0UwKGwCDeL5K7+HxFaMfPX1cZYxId7H
 y
X-Google-Smtp-Source: AGHT+IGTbtO05Q3TJnEgx3D0KE8+KceaUrihjfyXUJTY6AkQ/UvoZryQr95AJFAnJGBWcYFlaWuQPQ==
X-Received: by 2002:a05:600c:c05:b0:41a:bdaf:8d6b with SMTP id
 fm5-20020a05600c0c0500b0041abdaf8d6bmr58729wmb.34.1714495724740; 
 Tue, 30 Apr 2024 09:48:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] hw/core/clock: allow clock_propagate on child clocks
Date: Tue, 30 Apr 2024 17:48:22 +0100
Message-Id: <20240430164842.4074734-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Raphael Poggi <raphael.poggi@lynxleap.co.uk>

clock_propagate() has an assert that clk->source is NULL, i.e. that
you are calling it on a clock which has no source clock.  This made
sense in the original design where the only way for a clock's
frequency to change if it had a source clock was when that source
clock changed.  However, we subsequently added multiplier/divider
support, but didn't look at what that meant for propagation.

If a clock-management device changes the multiplier or divider value
on a clock, it needs to propagate that change down to child clocks,
even if the clock has a source clock set.  So the assertion is now
incorrect.

Remove the assertion.

Signed-off-by: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Message-id: 20240419162951.23558-1-raphael.poggi@lynxleap.co.uk
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: Rewrote the commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index a19c7db7df9..e212865307b 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -108,7 +108,6 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
 
 void clock_propagate(Clock *clk)
 {
-    assert(clk->source == NULL);
     trace_clock_propagate(CLOCK_PATH(clk));
     clock_propagate_period(clk, true);
 }
-- 
2.34.1


