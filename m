Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E338EC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauU-0006Dt-Cv; Sun, 18 Jan 2026 17:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau7-0004zR-Rh
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau5-0000yM-Pd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:51 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a58f2e514eso22985955ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773948; x=1769378748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIX8M3PeuiegMB+HRi2DRYnSj2Vd5HpfS+cGE/3s+Sk=;
 b=scKhCtNjmtrz3SyPl3ZY62a3GsniyCqe6rgsT8AKKsxcmwCyOzqGGxgpVZrtdtd+Rd
 GUzfbw2MFXsKcC//9L6rfuQrFeyckrnIvR2YLpfo8tDXaE4997uuzJ04tdaAzTrkWBVT
 A0+9gTrzgiWYkVlgZiSpmRRHBGhhXiqHKQJCyP0iToNkwjBTZInvnic5MFpSp/dH2v2G
 X/fP1bclYxqIU55BVGnzvy7M9dpVUOD4xxw33YyWmgvIXFxBqVa8TV77v+FvqJHOzC3w
 ceykf/ebXnFZ95f6pVJkJR73AYkdaRcH3QWi1lyXWZ5ApbMY25rcsDVjmi0CIDxxWd2M
 UDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773948; x=1769378748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIX8M3PeuiegMB+HRi2DRYnSj2Vd5HpfS+cGE/3s+Sk=;
 b=Fh1pJRerQeLLjBYpugEht3/SBVgWGwWr4Zn8nxwArkTlollGQcef2LxKuneXx5N6jG
 dvQcTz9IuDumHmMQV8FhmodswSl0w+r17N520m8SppDvqWYBaKfnE4ryUTYRRWo5jocI
 +DmD4C4oDrruKMJS6GjOcozB9acv0LLgYlwqvYIH3kbDlL7MYG8TPa1rYH/O6cIluCZT
 R4ibsU63ukrrILL1RA+OU4i9rpFw4hQ8GX3OacAq6urDyvTk/O65s0JHTH2g1UkzrWqq
 xYk86MYRaWWfX6isB9emZQcrt2WSQ4iGXjgd1kK81Ecl+cgV6PTk8cbPxp83fJd9AAJX
 Kljw==
X-Gm-Message-State: AOJu0YwWzeYPe2DGMXDnMdWYfcYoLtiPgwzBGaO5r8Z9IQEu9pcq3Jgz
 Brw0BxW1LVOlWeg76vLUMmhfI0It0rKJdXW3jqOlTAEQfUSNGd41nDBOA4leKkra5K6/OkBoEw/
 m54GAyyL2Sg==
X-Gm-Gg: AY/fxX78NXMewXzvGEdNO9Q1S4/+3UBmC7i6nWbo+3EXZcv9Ss23Up3CzWcqf1kqueM
 IetoEUCsCtnzNvzinpprI20m8e0UrzA++HXhAxierNhFl4mOQQtfV3C/p/ZouuNlkyhHlaF0Otu
 lolp/+dkCi1nTlDc+mcr7maFz0VYo2Nerzu+4PvC3rri7lmWyJLdwPH5hG73FfNfk0qNUPvKU3+
 lpnq+FySrnPZ8nkUXrCpWT6kq0RXWwpkxhtr3dV/TTrU8eIDrgfawXE9gcajlIxkALj72Bta35z
 uH6KF2vuiVKn+Q3I7tHXRjaWRwUy+8YbtV/I42fWpy8CFgNRsQNx49v72neAdE3QNEC2/0wrjNe
 UKEPaxHcAmjkqxDB8Nh2sLIH6KYcgwAcuwpVo5MTqqGshfaUg3s1snR38Ynnw1XeetCGhf5YgfF
 f6gfnhOIUyYEbZ+xS+HthQ9kLQo9t3
X-Received: by 2002:a17:902:ec87:b0:2a0:f0e2:94b7 with SMTP id
 d9443c01a7336-2a7188fd7f2mr103998115ad.30.1768773948018; 
 Sun, 18 Jan 2026 14:05:48 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 37/54] accel/tcg/runtime: Remove 64-bit shift helpers
Date: Mon, 19 Jan 2026 09:03:57 +1100
Message-ID: <20260118220414.8177-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These were only required for some 32-bit hosts.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h |  4 ----
 accel/tcg/tcg-runtime.c | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 8436599b9f..698e9baa29 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -8,10 +8,6 @@ DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
-DEF_HELPER_FLAGS_2(shl_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(shr_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(sar_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index fa7ed9739c..f483c9c2ba 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -55,21 +55,6 @@ uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
 
 /* 64-bit helpers */
 
-uint64_t HELPER(shl_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 << arg2;
-}
-
-uint64_t HELPER(shr_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 >> arg2;
-}
-
-int64_t HELPER(sar_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 >> arg2;
-}
-
 int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
 {
     return arg1 / arg2;
-- 
2.43.0


