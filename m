Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C04CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsma-0000OB-Mw; Tue, 26 May 2026 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmN-0008Kv-No
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:13 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmL-0001F9-0w
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6261485f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805747; x=1780410547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sB4l14E+SamPtLUei0j/FzcwY1KiqKOWEgkGE0g36Sk=;
 b=OZIA/Blj0FbpdGLF4rBpLAjlLO/5/RVoh9tjlikb4UUScyrABOAjNn1iZT5MLUeJJt
 1PH0edcAMqffjlMUGCXPnlf8TIRmZZlFpfScx6nC/GnakrFUJzltStNxEXw46WYY+Tjo
 9ef3HK2KCg5WjaWN4HtgTRkdbs3KAbT3ItmN4bzGjPWoyAKfLAw0piDoBkYUEf88YUSO
 AQUgjwzsAJmOQ3e0kFxF0oaa6umjCZhooK+bGbrc2ruCgW0Ihs5efasv5wc0rUz/FQWu
 cS77rKoZLhlR2jBozoHk0LndeX5ghGNp468I01clWxhvmkVomvB3aSN98X3sFWHgNszy
 0+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805747; x=1780410547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sB4l14E+SamPtLUei0j/FzcwY1KiqKOWEgkGE0g36Sk=;
 b=GPPDnrcJhXlXf2FNajDxQJEHTg8pRyPam57bBgMxb2i9M3VDwDVQuBu6xMKJ/Ss5yO
 3fpNXiXdnkmoETmjqfNVouVKDkoJvuBHCNbUGUK32zK3R1BICI8eJgCPLKCxA49P9kns
 uLl1wCWQG07ztggOEMM4ZyrxX/OezDgpXHtxTRKx/vQDih7k/m4CZPCPmlk0Q7Pl0IFS
 8Ar5D3PolLW9ZisERdYUY52pAebRhAqqie1hPcJ/SM4z1PZRexCcWsMCKhJO9xQqF3vj
 MPAv08Iz3jAe/hxD3ipvimil/rCBOr4UTlWGVtfEmPkhhzRPiLHSkClpPLRwGSR7101g
 5pUw==
X-Gm-Message-State: AOJu0Yw47UELZyHAIef9KbvqZe1rp5cPLpyXCbtt9O02FOXJTC1nYRmk
 0IorWAUjsVmA/9Bz3CbUnfoY1vJ/uaQ/8TBfxaaDJGCdTpgojdg/3NyPvQ/V8MIhm3WGXYYuX5L
 6U5Ls
X-Gm-Gg: Acq92OEPpOjVW2d538UMSnF8bgYvWBbDPwFGkjq+ADUVA9BM/TTVq2xs2UyHpniHIhM
 O0CelQCAuUuWleRDxmXyWrg1ZY1M2Z0vlx7MA1bGETOrlm5owalLenkKkurF4WxdhXHs8IJGiV6
 F/dnE4gVI0L7Kh9tXEhotLjjfnUI6I8vNltELW0G6ZiJcsJHIUDAyh712fYp8DPcwq0p2zqzC7H
 STrWl+uVwv3vwpCPA3iCGCOPxdewqchs1MNfolj7hRwpbSbZurKEAeGFhjdtFXBiBYeUDLU42Uu
 0wTFqr54Hrvxw7/jndXTA5UWXpJ37Q+NpmqlIb9lg7Ewz9qIDsxXbCBXVuEi64NLUnMRb9mfgao
 lmC0Cmt0KBA9x6ukox1yDYcTAvPA/R9CWQz4p7/f8kvLup5FPYXsiKv1VeMdY5es01oxyTZNEz1
 2cvOEDdBSHGYEnWdvXX8OQTtGenL+Kj4ZLWtSBxXtWER7eqx07KVX+M2uUsqmTkR10XVUAR6KGa
 ONYdaX70PDXW3HOj756GEu49kTdFog=
X-Received: by 2002:a05:6000:2888:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-45eb39ec2c4mr33085717f8f.33.1779805747544; 
 Tue, 26 May 2026 07:29:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/54] target/arm/ptw: Flip sense of get_phys_addr_v6 return
 value
Date: Tue, 26 May 2026 15:28:12 +0100
Message-ID: <20260526142850.2326589-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-4-peter.maydell@linaro.org
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 504ecb622a..33735bc14b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1326,11 +1326,11 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     result->f.attrs.space = out_space;
     result->f.attrs.secure = arm_space_is_secure(out_space);
     result->f.phys_addr = phys_addr;
-    return false;
+    return true;
 do_fault:
     fi->domain = domain;
     fi->level = level;
-    return true;
+    return false;
 }
 
 /*
@@ -3791,7 +3791,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                   memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-        return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
+        return !get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
         return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
     }
-- 
2.43.0


