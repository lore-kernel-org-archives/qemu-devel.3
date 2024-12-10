Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE62E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL275-0005Zk-Gk; Tue, 10 Dec 2024 10:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26X-0004aI-NL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:53 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26W-0008PZ-3C
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:53 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb3f7cd3a4so1245897b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844291; x=1734449091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cDXczJ1tKAOChu6ukHBYZsWtuVXT9f5SUnK0XOxpfsg=;
 b=XhCA7h6qA/Y1AOahB6ko7qmWGbQ8qS02yUngfpBWYyXzJtwO72HCJLTjBT5mrubUV8
 j9MuA3OCWhNA3320SdutLvPAEbaukqFNrJ1thBQ/aF/Y8dMuvyu+XY+VmZiAEX9SczTW
 xmHtdpcwWCjKaMQGGR+C2SPKSVvbAry45LM8i3pJ+WuE3zX9epGgDzrycAzs8b9eNwJD
 wpKUAq7rDxq2oB4uMHUbPZFC8Ph/yqw+v+UuGUf+5hTM9nTArB4UhewwPVZJfCc/YDrh
 zRzDDL/1zMC13DSV5krV4sNkMDjdPgMRcqKqUpfZVJeJW7rAOfewkhvUmbVp/CzHelh1
 1m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844291; x=1734449091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDXczJ1tKAOChu6ukHBYZsWtuVXT9f5SUnK0XOxpfsg=;
 b=Ggl1T0C/87FJAn2rMvmG60cic9bNMnD3bNIXjar4cWp2yb3FIpCpwiQZqCk5HHN2/w
 +UUmvKyWkBa8pKYlopSKlsNb/ilAf6If0iBB+ppN20aoTjFColKINT9c/8apu2ar0uZ3
 rkAwNmGc3xFLRt1dPUqqmnE7aaz6c9htmTe8eNubgt3UiHgMziXmK1iIpxbGVbC+Ga9Z
 qAW4fmRkwAMDTJVvTNvtPnADUmsin+hlb9T1yndQXkmerQ2xD5BFZf0VIvMwLaIy2MJL
 us3W4iOh0TyN87eEfxuE16ep3jVdTPVq7FyHP973sxMe7zBMHjBRFoBhru/sveW3puF7
 QJJg==
X-Gm-Message-State: AOJu0YxQPLXhe6hPxOT0J/lu+l+VcbSTX8K9chSZx0zA+8mRpKl2QQBY
 T77t8OozKsxMEw9tCkmIgmHEwU4OqR04Mv6fKPQ9ULI5+kK2H2wWCQe/DivczIAh8k2YXn9cBp0
 CCdPVeITn
X-Gm-Gg: ASbGncuFCaQmhHKTLWl/AxC/hU2C+OA1NDcwN8Lac7zw0VqEt9Jt7f0lvhYNsttlVOH
 Pi2gL+X0FlK44T5/WcMcK5rBkh8w++aIfJFPvYPd/jHphtHhNstEsfB7Rd8qTp9aoBBxOgtHg3i
 ZF8BXBMVGe8pMw+r51a4d/kQ8BW1aIlrtNfdnOilll/5mKaoL5EMmPxVt6KFYcN1jynNFamLMHW
 XRx6FukGIz9fHT+8PH/h+S6P5wTRAYz1Q6G4qKi24rzuJvjITOAmoru9sG6IA==
X-Google-Smtp-Source: AGHT+IHmX/a4cb50llWGNtQdl0vETItcldgTg1klh49XFVErI18TTceSUTSOo+AwSAPqCZEfFq/pBg==
X-Received: by 2002:a05:6808:1b2b:b0:3e6:22d4:d2c8 with SMTP id
 5614622812f47-3eb6b8c19bfmr2326606b6e.12.1733844290871; 
 Tue, 10 Dec 2024 07:24:50 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/46] tcg/optimize: Use finish_folding in fold_cmp_vec
Date: Tue, 10 Dec 2024 09:23:49 -0600
Message-ID: <20241210152401.1823648-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index dd6ef3d831..30446baabd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2462,7 +2462,7 @@ static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
         op->args[3] = tcg_swap_cond(op->args[3]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


