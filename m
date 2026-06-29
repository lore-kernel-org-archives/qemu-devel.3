Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03744C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgH-0007MJ-Ui; Mon, 29 Jun 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfu-00071m-EE
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfs-0007Ya-UX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1732755f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734474; x=1783339274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GSKi1D8EQOBK2DIYO8trrK7f2HEfo4qnjX06x2B+U8I=;
 b=gXAdcFG8tJvsfD/XLd6kU26BpqIbfT4vTPBvT5bKWiLmkumVamjYoRr3nuw3teQtm7
 GhJ64TUSCaSNthXK/V9u3Lr3ogieAMoE568wuR62sN4jvtAhvpkY209OHhchvVTp1/3W
 JNv3oSaGlj9TEuwSub3QD+9G4dJB5ZDunVomg/Ipj9JL62UxFEvp3P9jfRz3rrNZ9xcQ
 eO6432ahCeGa7+qpXXsQ0tICknYvpLwz+KISJfwRyjnTi3e5V/c3gLqXOH9uUQPZ8zyA
 R0fvqYbVY3cIOaa8L3a8jGhaZmX2w/cnjTlLI5vRatllSt9g0l8Px/QVfCcUhdnU0hsp
 4KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734474; x=1783339274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GSKi1D8EQOBK2DIYO8trrK7f2HEfo4qnjX06x2B+U8I=;
 b=fpwUOjnruh1ldrD/ggt6FPWB0bgQ6NMt7MaJxvqo+EgM3VwoMJc59MX0jMsQnwi80e
 Bn0tLHm9+7b/znHbID/BrdEyPzXHVo5wPHA74w64sc6RUUReK7WLQAs9q5E8cqPm0rh2
 8SPt+E2mGo/jTnlYf+kPe1gWwib0Z5MHvzIV4Seqcoquo/spAfD4jmJwOU5s17usoHu3
 D3mK8ulm0aJCpnM18K60BNAccGrl0kvWpz9/qrA0Yd/7mVj291S/g9e8Evn1ySNWLMSp
 q+2WlylisjgFay6A0fWW9FQYluIfFu8J1qE5CmNcRAAPfd/1C5M7myamFCBI0kzShOcB
 CoRQ==
X-Gm-Message-State: AOJu0YzJ6H6U+iGXIiyRu5a0fEbmW07IHioExYggxvJ82EhMBGzXcBHW
 e3vi1yeEacjAFbftwe1N+qwv7ZumoEwlxRdo1ocDbWjUvhNNEtETPA731B9P922mbLLTeVxuaao
 /w/A4
X-Gm-Gg: AfdE7cnN+dHDtQ9WI67Tt/DQdOMsIPQGL7TnXTYeCQhD8DuINf+e88uQFy0sth+BH5b
 g9Z6idqDGNbrZJYMAdJysSH5Y1Hb4NSrDmYU6G7FZkHBP1pmnjIrTp5EwiZfUv2Unk18tqvu547
 wJs1z3MKqpSmQ/o+M3pm3hgj6o44igJz2kmLIhsf5zLDo+ubUF7T0WMH11sT13SUr0WtGBhaj+U
 A0Tfz8uN5ZmT0X9vPN2Co/n3cf2IzkXazYpaUpN5HjfUSc42GqX09LIVf9VB+O2RUgVvemL7EBO
 UBDWgs5Y9v2R07XOTH5RZBI/kYMpn6idZe1QRkHeqv6C8fZ3QP6D3Qico3eaaLd1PSHnAXsBpkL
 Ig/peBQz5avU/YIMiDlRYmrYNiwtQmW3S+ljNFfbMqkSrbfGvIH1Rb6aADf4XOnUKbbgkwstALC
 F8kn0WXj7V1igm/O8hPpjnlto4XQjLUuSNrkCk6jRwpLOyT/As0zwR2C7FoRlVlVYna1DAWmxnE
 p8jNDwvvturQUQwLBBGXtzAvVRHxR82
X-Received: by 2002:a05:6000:27cb:20b0:474:d7a5:4b6d with SMTP id
 ffacd0b85a97d-474d7a54d85mr929350f8f.21.1782734473975; 
 Mon, 29 Jun 2026 05:01:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/54] target/arm: split evaluation of CNTHCTL timer IRQ masks
Date: Mon, 29 Jun 2026 13:00:16 +0100
Message-ID: <20260629120032.1645265-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Whether the physical and virtual timer IRQs are masked are independent
of each other so the checking of CNTHCTL:CNTPMASK shouldn't depend of
not changing CNTVMASK.

While unlikely to be seen in real life we should still make sure we
behave correctly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624124527.1018912-2-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddca634538..202ac99f69 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1802,7 +1802,8 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
         gt_update_irq(cpu, GTIMER_VIRT);
-    } else if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
+    }
+    if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
 }
-- 
2.43.0


