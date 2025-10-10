Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D17FCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqV-0007R0-QT; Fri, 10 Oct 2025 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqT-0007OJ-6j
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpW-00041M-6k
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso1496158f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101597; x=1760706397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dz/pKGGgrfjPnlvU/HHfzUVBqngVWK7gF/6Jqhpwo/E=;
 b=Ooi3ZppqWRz8Cy9Fp58v+BcJg3y9QkuHlkZ//BCNdmdOgFHPvkWc5V4Hc/cVJkOdxd
 CxwNhtvseNI1BdqA8GbHZ+87RSSLpcBTZPlqWwizNFAZj8WNnnReeoV/EvMznDRAP3dT
 c/FOs/2ZRVnyghAASAapnC60PihChWAtzzhnUFyKev524XA8lXr8dWyE/1ckfFkzFdld
 9xlhGNv6BCXQImH+yONBKbc2ZzjLgiqe/N8yaZ8T89jYkjdhWuVPJanUUtVM958uTTE3
 c1lTyOz6yt71/Jg3kJnl/CF/H1PDsTz2RuBkiSbNvjFzBEPuhK0eF60iEBKlGZY+LUCG
 veZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101597; x=1760706397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dz/pKGGgrfjPnlvU/HHfzUVBqngVWK7gF/6Jqhpwo/E=;
 b=NiKjVsMR5TQhmeTnu19Zl/8HUrLms1ZH/EkE9W1gbC/DRSd2Q+rB3C2cG+X0rXMTx3
 B/axsZ5v0hWp1rmXByhZyIYF/jbxnkoP2kPpGrJKRSBpqHB1H+dLfgryNZ7sc5tatbWW
 bR0nrgWg3EXm3ErU9FlbfyoslHlnKctIr+olFPQ5RPP4/WgUeWdTpg0vLaqbvg2ocvQv
 CiPDmobZB4uEbOVqjNxxxnIus0fn6QlawrVJNY3lumIFJEWc5vJYLr8RiCMiIkHsugHK
 EmjpFcsVTXLfp3lfVP94bXmZXGmreaYVTwCup28ai9NGSJfXYMRiXKWBKCtJwgX7iXZH
 tzfA==
X-Gm-Message-State: AOJu0YyTZBxv49c3ful/0QNREHI5HKojoXwdcgLp91aWtzUZXRB4FieO
 KimEtC/C7kMK1vkVl/JWNGDkC+9KMRGm1HaH8esTVtZNCcRy31/gaHzjcvv1GwlFm02PB/LM+tR
 JWej2
X-Gm-Gg: ASbGncs7QoFxSR+wjGLojAlQnPnt2DhSnqPAo3x4NAL8uoVySZDTQQWRj/NoqH/aNBa
 h+WTKVC+b81RtWC46JrpFjy5+W4nKv3itntHKBxNwoWtbMfXAgKZkrL+JOU1/eKRG/YnBkOVYnm
 PqeuOXzB6cVfc1ttmvDo57But6+X6PvT1MeEF/lsfXfgmVHMyTOYzYLnyaRbqzJ+PvK3e10BI3g
 MbVYazDsh98hPOfdFPAHg+kJ86vZyLTOc7WDxwR48dpIxuMcftSRKkvPO9WIYYwxw4jbO0PivxH
 ygUc3LGWg+vyaJY+UtQRe9Fe5N1WuyHu7rrGdrWmEC6jBFDYD5sfPFz92H6ER9F2fO/KJaY6cQ1
 ozO2Sl4D/ibCXQ5PZus38hmiRX2ufSBQYM3pe4CQee5r+RFMMtt56XeKw8k80fA==
X-Google-Smtp-Source: AGHT+IEogQHajiYWM/FlOeCeTvWFjiBq6insM1VhFu3gfe/WDPtySWqO3TVEcEw+ddNxg0V9I9I/ZQ==
X-Received: by 2002:a05:6000:250a:b0:402:a740:1edd with SMTP id
 ffacd0b85a97d-4266e7dfeb4mr8162530f8f.39.1760101597512; 
 Fri, 10 Oct 2025 06:06:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/76] target/arm: Implement EXLOCK check during exception
 return
Date: Fri, 10 Oct 2025 14:05:12 +0100
Message-ID: <20251010130527.3921602-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-62-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 08b7db7c467..ba1d775d818 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -675,6 +675,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    /*
+     * If GetCurrentEXLOCKEN, the exception return path must use GCSPOPCX,
+     * which will set PSTATE.EXLOCK.  We need not explicitly check FEAT_GCS,
+     * because GCSCR_ELx cannot be set without it.
+     */
+    if (new_el == cur_el &&
+        (env->cp15.gcscr_el[cur_el] & GCSCR_EXLOCKEN) &&
+        !(env->pstate & PSTATE_EXLOCK)) {
+        goto illegal_return;
+    }
+
     bql_lock();
     arm_call_pre_el_change_hook(cpu);
     bql_unlock();
-- 
2.43.0


