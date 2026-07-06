Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD80C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggib-00078b-7Z; Mon, 06 Jul 2026 06:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiD-0006zp-Pi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiB-0003G1-9M
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso29624585e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334282; x=1783939082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BRHsYyKfovCsOHrpArxC8pbUR651XaJyUPFZuqonhrc=;
 b=gVQ6s0WZkZlRNvZYDZce8rANc3W4zmg4Zsk6N+XQmsYyTxOAwcJ+kJ5TqJJwblKOEC
 QxoixsHIKHRmTXdcpFIjogbSTAzQYvOkw9sFxJc0V0zCCsgDwj0fFHibXSW4wrIhR//y
 bMYz4QG6jdwq4uhKNNaZuOz4Z3mRuyWhbpWWp9hoj8wqGiMvlcHsffJho7N1NLCqMN8B
 UcUIfSQdTM8Zh3McRgv6nFc49pLY3Ntltboxe8dYj4HLJQwiJfdOW60s8CGT37FX6Qij
 iEgMqx5RxDoAkhuzOa7PtuRUS1y6p4MGV28gvQctnesQFsQfLEVF9Yk2CiWg8hW2SK3c
 IEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334282; x=1783939082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BRHsYyKfovCsOHrpArxC8pbUR651XaJyUPFZuqonhrc=;
 b=G5UmOKusJeeYm20cmMvJcXnZi4SS1HUxmFW+EUUiZCNYbTutIqae5t4FyWTagCJlMU
 ou3zYb3mbE6hJ7L/vh/xprIP958+QcMrx9oWCHhM3RdnbqR1DKm/jI7wHQLnOAm+nreR
 oepFPiwY0Dr43MU1TDSFrLnLzjJny6Jq6CM+yex3CwxwFToy5Pfb3zLWKLKZDuCO0Wd1
 DJ1it08QEGIpyEqTmTQDGuhrd5SCOHVPAdtuRyisqGUYjjGov0+b+3/3rma3Ty0QiY5R
 Q0a0Wuuwsf5fycGsSv/Q1o2/T8sXq3xuWVKt7L1TQP0FCm7wCanmQC7c9wyW6CwaBMl+
 +ymw==
X-Gm-Message-State: AOJu0YyqARfLPs6VD0Enwkrxwz8cUMYjw3dDxBNDI+1tjgluzTIAny2D
 qMG+6f94EEuGMuQ+GRnlxb0pLAJSu+JZSSGv/ywm8Hox1vmyHVPfomnw0eJI0vKNi9CSZ5vPkLh
 47tV8pZ+fqw==
X-Gm-Gg: AfdE7cmSkKEzoumMF6l+HWw3NIoRYiz6ZeHpE/cBEuamnLgkOsnehvCWonJOwzarrwm
 Pcw260kgGqDgq2XEYOO4RiF5kZ+J173uPwtS5pLRI3oELQPYnXK7IGAYA1kVeRwV7VobAUFnISe
 WNpXbdkwLUa0/vZXy8Bb+AgWRJZFwJWF15CR7vR02APnCgjV3IGaAOmZDsBdCZUHyS0u8qKvv+I
 nhieouVFRkZv33zI73oKPvunWP6gRMA78zThhR/8rqErC+oh6NDYAB5mrNm45Ys2OdP1SoDrl7z
 PmMLdo5I1o37NJqiVNdblq8UCR/1K7lkBEJ0+oEGbGx0IMEA6o1wv7tOLFdpSE1stHXAkg2Oee3
 BVs4Uc6xQUUMiRaw5gruvDCFa8pt/PNY85U7/XKdo/qF9x+WXfh5668xOjCt2K7PzztX69X7A8O
 YFLPc2cRwCPF6Dqv5FM3EcQqRo0QROGTlgid/YGVQadxGVerTi0fWw3qI469qXJqoN25UMNfsy/
 x31zPmffvqjzCEnJxcYJ/gf0wdvC44D
X-Received: by 2002:a05:600c:5394:b0:493:bd2f:c5fc with SMTP id
 5b1f17b1804b1-493d11d81b1mr114346465e9.15.1783334281698; 
 Mon, 06 Jul 2026 03:38:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/49] linux-user/aarch64/elfload.c: Add FPRCVT
Date: Mon,  6 Jul 2026 11:37:10 +0100
Message-ID: <20260706103752.320511-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260630-jmac-fprcvt-v3-4-f4840d5e0a7f@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 42aeb29306..e33dce7830 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
+    GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
 
     return hwcaps;
 }
-- 
2.43.0


