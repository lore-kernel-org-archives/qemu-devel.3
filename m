Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320C6F46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oeW-0007Jb-QG; Mon, 06 Apr 2026 14:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeV-0007If-9r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:23 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeT-0002Kz-O6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:23 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c76e702e01aso595130a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499980; x=1776104780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=OM1Bvz48ya95GqgipGS2OHTlaSzuOsQzEnCZFJ2myQDi8mAEi8atyOBRs/kkHE+SuE
 bPtsVHHfL3MWqc06iAg2i3nGAmpmuJmnZYtwHGwTHvV0JMAPAmJmRYQpSnB98USO7w7V
 Xm96HtNrrtOsKTcLR/aPMaZR/qttuIg98kGtgRmgtqeKwvBN1fiXqwqt2nImwRgtiPYH
 nuTfmQmA7Ib+uLzmU32VJWwBqMAxZHOPuHBeaKTRyiXUEdPJm40G8yRQEKSaffL+jH4t
 jNcN3OLj/KMevnZw9dZcFdwQRASZDzU0eLXo2RXSJ2WDxpYL+Zx3LUJxLS1r/sep/j06
 pPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499980; x=1776104780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=lFeUcufmLQ2/anJK55cclJ5arUkLnKmw4kiSx4SZV0aBYUu0GLHNwfH7Pc7w17TI7j
 7kfUIQqtso5DCpxeLJxsFpvDQ65AvCgF0CT/0hCzgY1OliC+DHDl0vLDBrpC4q3SJ7h/
 fbtCiJi7u2B4vu0aLmmQjvs99uDIdz2XDeKy8zID/UZQBwIo+eUtFOSxUkdvp9kKNHp4
 L5qK7BzL2XRDAhb/CFmEAT1ugrEbKBXgxaavsO+fKS6l2T7y5mvAgiEnl290TRwg8KtS
 /BCplIuOij1S5Wv5PeQHxKYDIV4t0CZGxgTtuTZGJsDZiAwCY6kOuhYD6oLjIFWQI+us
 TMLA==
X-Gm-Message-State: AOJu0YxsKS6RXZAZz3awHV0f7h4YWkvyOAonWRtGBTEHoKFcEHfWxI3i
 lfHUiZrbukO600lkMR3f7mHxm49AwH+dScW4ymrs6yVDihBegPz+ywdmmW+jCj41fiATfuPhlH9
 f47ikGNLEPw==
X-Gm-Gg: AeBDieu6qQ5AZDznNqzncLERkWTsSDQJnrbfCe9LmeguPTFhM9i4Rmdgm/HC/rAbJ5K
 wC7nRoVdVjzY3PmEMvIJUo10XwHJ45JPYyRS7/sqg5hENionTHu1RsUy06YdyRg8pycaRMSifLp
 VDrANv6tTZiZFEK1PFOFaif2juNN0EH11XFdlMzbYtqQd1e/g/9FpFsjem8pZ268uW4lsjjFD1t
 BeoooQJvM/hRgQgAs2/FulC2N+5H9clszwdaLwqqcRbjA2NqhEtmCn2c9grFQHK38gEi7oTfXpD
 G1msy8/hGyxYJic1FaFFg/Y/WiSLPPYRMYqkZxnTrw53GMvWjS4nbjSerUVAVIqEiXLObwpCcyt
 OlfTwKkJzbKDfKH1X91A2sbElIVfqjC1XY9rpcCtftruRfBst7ZQPXiPEvws/lBfHlkHjvHe7E/
 87Sj+P2jEvUpO5io4FpJSlwAIPrQLmLbFC+rsUaLiZVo3/1pDPtbsIyxjiZ7/P1cEHT3o0qHijG
 a+J8qmCBglnqPQ=
X-Received: by 2002:a05:6a20:6a24:b0:39f:216:f400 with SMTP id
 adf61e73a8af0-39f2f0a39a5mr15130162637.14.1775499980284; 
 Mon, 06 Apr 2026 11:26:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 03/20] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Mon,  6 Apr 2026 11:25:52 -0700
Message-ID: <20260406182609.193886-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


