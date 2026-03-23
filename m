Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93668EC01CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvi-0001t8-Qc; Mon, 23 Mar 2026 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvd-0001pq-V4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvc-00064X-2I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fe36cfabso14128875e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263274; x=1774868074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zlVq/Av1FrXr6O4hUjgJxKbJ6OtteFefeJ3KwVeLfck=;
 b=TGyPYlrdtXpKQMkmZ4kigDHoCJwa35JzzcO2yl6ig+IslgPe/b3zW+HPfrCHDqkXHc
 2/ozNHXMSNVKntygQN1663lByysEtHt6/GMjAXMqZBnQXn8Q4TehK4jOvnoeO4QJqlaJ
 p50KqZvHIETS9Ri7FpGq/K7WOCjJgeW41gLJjwwSkmkHgMFVdfFqk00yRAUG9Ux2T3DV
 x/mwaJxtT46rZN8d+BSNCV8UXYicmNpCnWLjhHTTFo+5FSlgG/g1Su76mYIhXjGs+0lo
 G4JH+yJTdH0YvNyoM075VuT/PC9OBfbmIU2w7lYNdAcgVvYHSc3zuT74c9Uy+0gyM+XT
 Ozzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263274; x=1774868074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zlVq/Av1FrXr6O4hUjgJxKbJ6OtteFefeJ3KwVeLfck=;
 b=MazqGzQwkf51yDx3QzfHEpSTngcbgUHOWMQ3yCdrN0TKyi3vN1jHIskO6zAmAvWhf/
 gN5OQ2WEQ6kyBIpyA22I3TfreOemnIxVxeMUH85reBXuB2aHezTJZrckisHMwZsnFiTN
 mC3yTff7O/j6DuAAvUqYWVvNgh4/1lfU4FDPoStdBSvqixZJP3ts0xkIWkafVWOKvbaf
 NZ/crZGuKI0WOJkj2IJkJww2G61HrUlrLo61t7/ZCS1bBLVbRWQZAmr7mK6PORCC+jmk
 FRIvtvX8kRUsyEGBd1qFZwn1nF0uJLtrEG4yPtsZq12FlvvHjpQzIeS/KJ5Ylo+ZUU1Q
 /S8g==
X-Gm-Message-State: AOJu0YxjZgLVTAaR1sktJRDWRy97huEury9PM6s7ykDWeJcOF+TUX0+/
 nURdTgRFGnSDqYi7Rk4FU+3onbeGwrSFUlnMyMUOtj0g0DTlUgyuOH/AJDZsIk3wk0qCPtCRAU4
 47XyDXGQ=
X-Gm-Gg: ATEYQzwtAXMwsvFrJqW7qQ5h4NiHYCv7RcgigspXrInFccdoVBHxxakmEAjzzblD7dd
 KRscokmavn435s7fwZy4kVNmtWxyU8Ukh5hThTupljnPyVFYpaPKbHGZJ1/LpQH3i//EkupL+QK
 jzl4Y4UkaxJeFf5zpI8wYuxkGQ9sPiDSQ0qL5lU3YYA5LMT+pl93eGWEwilqM2751foB74W7blW
 BstqTbu9UJ8b3ySquYl+rzyTh9WOPCU+TYmDtBRUZYorLGjBR6NOp8nWQ2Vx63YcSUL1b6XZxGM
 uyLzULBMK1f+Z+8xpGfQzE60D9M0KW+qMDBJqTmTHYHrlsi6WTrlwQG63evDLYsobdj/FPU84pK
 Qr97oq/Rb4/MrOO/640qjQ2QnlYEgiN0Y62SqWAzTFsOMM59De4n6LaNyF4+OFvb18bbe2/Xx3X
 aR4Kf4ZFxtKvjrLliExDb+fDtM+dMiolg0jTo5lUmcP0Ksez2rRAe4QVIzWMGJtUQFCFhLJFt8T
 P9Zt6OrD5jKCqFIlJHDBMPeVw9zjK0ts34ShxI5Jw==
X-Received: by 2002:a05:600c:a312:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-486fe8b7afdmr146446415e9.6.1774263274392; 
 Mon, 23 Mar 2026 03:54:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] whpx: arm: add EC_DATAABORT assert for
 WHvRunVpExitReasonGpaIntercept/UnmappedGpa
Date: Mon, 23 Mar 2026 10:54:23 +0000
Message-ID: <20260323105429.4059580-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

If we get anything else from Hyper-V there's a problem, so enforce
this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260314221529.47841-3-mohamed@unpredictable.fr
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1..3df60a950d 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -439,6 +439,7 @@ int whpx_vcpu_run(CPUState *cpu)
         switch (vcpu->exit_ctx.ExitReason) {
         case WHvRunVpExitReasonGpaIntercept:
         case WHvRunVpExitReasonUnmappedGpa:
+            assert(syn_get_ec(vcpu->exit_ctx.MemoryAccess.Syndrome) == EC_DATAABORT);
             advance_pc = true;
 
             if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
-- 
2.43.0


