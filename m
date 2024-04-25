Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588ECC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWP-0001zW-Ll; Thu, 25 Apr 2024 06:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWN-0001y0-KS
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:07 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWL-00079s-Ur
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:07 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2de232989aaso8444251fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041604; x=1714646404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mn9K63HdD8L7FJC0CZzxAEg6D39lTDIquKUS1Fhgckk=;
 b=ceY2JbRKZ3Zgw2m/X/1TV6Pvj2+EQ8i1cPc1BWrKCtlxLzjZ8SJwHUTlp0caLXwIcK
 5Vy8/VzdbN++cb3n3wTDMfiiRbl7C+V0+4xNTUAwmZIDsystLp/pxxHnSvaRFpFqC7Tq
 cvfhJ76YwfMdwihMr/uyJoO4pxEAJrBY+EBrYDTm21dx2iJAuVHhasKna5fraHoNi3Cx
 72sArzuZLuAfCm+9LjOKiFTk/vLLofIzvK4ohbjyK0ilqtyvQcZliTrReCRQ/o3inBrE
 nq824MBFj3rf0UKO+us+PiC9Uo73LoDDtKtzhS2OeqN139zSXS+vXXDc+4bLHW7IR0gJ
 LIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041604; x=1714646404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mn9K63HdD8L7FJC0CZzxAEg6D39lTDIquKUS1Fhgckk=;
 b=HyQRy4X1SdwCQ4IfRU3FHTqjr9ZJA1ek/NKDi+pnFG7CZjE3tgEnaXhijNOiJTrxfq
 ZIj/4HdCnVZePoEnSNAf7CQpstJxPmllkUzsd0N2tjFpl4ERyY+wE4dQloNmz3mcig2T
 poafQc5CnSf9jw2iiQjugcQyoZUrBgdfLArUofsUj377YbQihKkdXDcrE0+ct4FMCCiC
 RwtkQ+wD8zY98XYKaibdfSyXPRzPvnZuu57uK5ySHk6lZCIKe36cedj1PC28p+7CRGkV
 bWpJwzUpEN2mo/BQemzjZihwsNcN+m0B+9FE2WV36TRk1d0fLScA8O2/2U1StsjfnXRX
 oV0Q==
X-Gm-Message-State: AOJu0YyZhEekQ29v3UQoFHBf7iNPLlWPUGsSKBuqtxL0rZVoS0n7ukGg
 cMTdWJpqSHTJJ7sNO/9mmuSjFbjAH7iA77Ir6yIA9gh3ofIE9bWLEvhCI89XbcuJnYGjkn8dVlJ
 n
X-Google-Smtp-Source: AGHT+IGfPYl0KtmFyP4UqpaLkWP+508nQz29WNu0e90cVrFAcmuMYyjio+FVAJYoN82GnMzhi3LQTw==
X-Received: by 2002:a2e:9dd4:0:b0:2db:348f:5c28 with SMTP id
 x20-20020a2e9dd4000000b002db348f5c28mr3336495ljj.51.1714041604274; 
 Thu, 25 Apr 2024 03:40:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/37] target/arm: Add support for NMI in
 arm_phys_excp_target_el()
Date: Thu, 25 Apr 2024 11:39:28 +0100
Message-Id: <20240425103958.3237225-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
with superpriority is always IRQ, never FIQ, so handle NMI same as IRQ in
arm_phys_excp_target_el().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-8-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f61a65d8114..4ee59b37059 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10763,6 +10763,7 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     hcr_el2 = arm_hcr_el2_eff(env);
     switch (excp_idx) {
     case EXCP_IRQ:
+    case EXCP_NMI:
         scr = ((env->cp15.scr_el3 & SCR_IRQ) == SCR_IRQ);
         hcr = hcr_el2 & HCR_IMO;
         break;
-- 
2.34.1


