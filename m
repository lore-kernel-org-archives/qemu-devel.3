Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597EDFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuY-00069P-Jk; Wed, 29 Apr 2026 20:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuX-00069C-Gc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuV-0001jb-W9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82cf636dac8so171715b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507543; x=1778112343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/ftQiotywHoX9E8XzX0XwrkoezWs1gu+rPw1xNgooc=;
 b=EuyiLonfd9YTgilrV9BUgCPzVNug8CyDv46UlzI8EYNZHtJJ0DWnes+xvxDpJ7wv6p
 t2Ni8bmIdidYPyJKy+qH5TmR6MKowCVkOPYfAAI3ke6HSmh3tX6fCMNdohgg6cWnKqk9
 iq5yeWsAGx34UklvKYy+Enms8Vgzv1UAK6idinr4EQeijOMkilPcpW7afj/LC+76A4CT
 eeiQQvRmVJ465e9zM5lTW1uyCY70VJcg2SexjjVAzGXT3L+lsg0VcZycpUqv7PxKy2Bg
 E3ZZySJOzL0Ei2zSTt4IfcbZnb880a+WCU82J+rO7lHeW26rgu/dQPVR1JXDvYn3QCag
 Ta3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507543; x=1778112343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/ftQiotywHoX9E8XzX0XwrkoezWs1gu+rPw1xNgooc=;
 b=N1aOdbT5AyhHPXGxexMptVgnNGhzqKcAdNTWqwa459yJkvl+rGns9qEyLb/scJMtXp
 EAsXi85SuCdTxPGz3m1ATM4OJ5QfWbuKFcfF8NB8TXKSYnmOh9O4FXX/7AVf0Gu5bkgb
 pIQB1R5tjXqSztzjooP0No7zcSYLyESMgOiqIg735yZ6sblJEXFGdRpXIUD8t/rg+I5F
 pWLBNSEcXnq7sWcG4qO7Yv8iyt6Psh00o2ZbA+YEj0Mf0IzwN0ed+Kk4Ctl9JQkrNFWP
 ugNkKqMk2BCV1ay2YBLAZ6j9g3NF6lQ56NBodMAPOg0sFJCg46+YTsezVQ/BQKhyBpR6
 d9Jg==
X-Gm-Message-State: AOJu0YyemZWg3jiQRNf4VtZLoTL5Kq3TZ1DPUXQrZuUf+EW1SWthWlZ0
 J+9XlxyCQ3i+osqDOGqal//8vk2EzV54sckybMblGsjcS7kB/yoyP2feusxiVAnxFpXCBQhKVW9
 9buEWumA=
X-Gm-Gg: AeBDieu/HiPfdpQZMsHVyDQN0fDS9j2NQA/zaPBxxeqp19bTlJh4NPNNlo3qFh5h2On
 +Olb9HdEfZmIlaUqdV93OjTFuqZHFrS60ouT7F4mnJagiFhlGkvD5FIzsV9PV6SPRzMexMrNmm7
 HJZL5/U/i0i4vDsoMyQ5aOMS0Qhh6ccAKMJq3cR1N0TDo92LcyICksFf5ddnKzuW3ZPdQAwK7XK
 H4DVupVbxV29jFnTHB978yRlHERJk8z8OFsqkiZ2P2a5RwHuNCoTGdGYY0iuGCDNXKx+eYi3R1x
 YjwRmzBIfH/nrECnOl4tXWyMOXg3vuzHdoklDVQOxQxXjN4OTJQZFp54/iSyZupjEc9e8E3a/us
 qkAN/XnsKX6ltUuSYOcdwxgI9r6u318nY0dVQja6emsKyO0AxfInJX4BXYCzt1HC3kun3I4OxJ7
 vzHnNamTes4c7JJF4BEny9Y5bcCJfvjcEn3uf3TUZQ
X-Received: by 2002:a05:6a00:230b:b0:82f:b519:a5d0 with SMTP id
 d2e1a72fcca58-834fdc49eb8mr765127b3a.39.1777507542580; 
 Wed, 29 Apr 2026 17:05:42 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 06/40] fpu: Inline float64_pack_raw into callers
Date: Thu, 30 Apr 2026 10:04:49 +1000
Message-ID: <20260430000524.56046-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d1acf383e9..302612fe42 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
-{
-    return make_float64(pack_raw64(p, &float64_params));
-}
-
 static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 {
     const int f_size = float128_params.frac_size - 64;
@@ -1506,7 +1501,7 @@ static float64 float64_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
     parts64_uncanon(p, s, &float64_params, false);
-    return float64_pack_raw(p);
+    return pack_raw64(p, &float64_params);
 }
 
 static float64 float64r32_pack_raw(FloatParts64 *p)
@@ -1548,7 +1543,7 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
         g_assert_not_reached();
     }
 
-    return float64_pack_raw(p);
+    return pack_raw64(p, &float64_params);
 }
 
 static float64 float64r32_round_pack_canonical(FloatParts64 *p,
@@ -2047,7 +2042,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return float64_pack_raw(pr);
+    return pack_raw64(pr, &float64_params);
 }
 
 static bool force_soft_fma;
@@ -4725,7 +4720,7 @@ float64 float64_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
-    return float64_pack_raw(&p);
+    return pack_raw64(&p, &float64_params);
 }
 
 float128 float128_default_nan(float_status *status)
@@ -4777,7 +4772,7 @@ float64 float64_silence_nan(float64 a, float_status *status)
     p.frac <<= float64_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
-    return float64_pack_raw(&p);
+    return pack_raw64(&p, &float64_params);
 }
 
 bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
-- 
2.43.0


