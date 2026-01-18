Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95F3C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxH-0007oH-EJ; Sun, 18 Jan 2026 17:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxG-0007db-0F
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:06 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxE-0001bQ-EY
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso27710005ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774143; x=1769378943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9u0Q1JjyvUW9YFkrSrLxZdxPG6FLLM0OzXcJAGsPT8=;
 b=PmIfNwiEh3Je07qSiF3FpjZ7ek1KccGZaMa+bp6SBkeFP427cVLHuEr2BoPbjoyy0H
 /bzbCcGS7pfPjjdG1GfHCNReO0wMiolXpXYsbcz58oJASHkyGkYX/Gzi773fXkIydMng
 jWVppzmYiBXSNv4traYHVg0ToGNUu5f63vd+dT4Q1PH9P+JkSNfW+naYYoveI2TIeiFZ
 TaM93vh63Q4kkzL0HtZJX4zuLN+kAGn+9vCtPBQcKHWZg3rwoG7yFiY62a/b1KpMuxlT
 9QXFlbFXApRQ2X9zKr+YdG1Ix2R5d1iLDgDZf2+dF1W7cCzvPeUfcEdOWBt0vaH33znT
 uNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774143; x=1769378943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9u0Q1JjyvUW9YFkrSrLxZdxPG6FLLM0OzXcJAGsPT8=;
 b=qA+4Mx0ze/KXdqmRYFbHmHQjVqxS1dytzl8FvVZjRyLGokF45lVBuR1KGNcoUeLvbC
 PbiG9JujwZ0ukfnqwc8VtizCKyj8qQKfyfMPVGEJl6XmZt1BM/xG2XS9/gdtFSVtCkVg
 QJevR3RLUro1su7wZTveTgE9Tsz0n1UOlKBJaI4ZOPt0hSVx01Ns65LAJbSGn9Nwz/S6
 ivaDmj02eUP6p+AK/2BuXj6Cf993d74KV3R8FfSxOxfC4F7rhJedDOSZeHwLPKo8/69l
 n+VdA3PifE3o1L0D0teuCVmloVBszsj/kKTLqVvUQrHZGBH3+MgLY3wlSy9W7qE6BFQE
 KUcQ==
X-Gm-Message-State: AOJu0Yy+6cEjiPL7D+rJkNfveNjL/zyKvlpQvNagnVv00T7eGSBZYip9
 58AE32znooDjPJVLC0HTlRCIKAlu95rjoPF3YBKkXBrNOuL6LvdxScz2Xo7nHeFaISwZPSgjz3m
 +1DDGZcu//A==
X-Gm-Gg: AY/fxX4BELJUFxnz5ZGl+mVA6Mt2seOkSWvB+p+/Oit3UeNiwHcy+hnyBMMNGzBdiYB
 dMsKZaGV9O/qH+Ny9V3mltJ/BRScFPxy2lekfXrRM9EHWz8rkE2QKPs8dlq8SPvixzWtEqpk0wo
 yn+aqdePfeAle9dQZgmehmBJFdK/dHFa050+xw1U9EuxoxYMW81mlsaiY3mgBU3eRMLYdpD35gL
 PYSmemK5CYGws9ibok+zgOYjmY/LQVLodfxqjjPXaG8WGp6tLzYZr8fmMZr+vJNBPkGa9mpizrr
 DdagpkRaIUticYnyeVaBr2lpcurGShHucTTi0noXB3QotLFpMRPO1Z2bxU8R1io+HCdEHjecEyt
 du5IFBZ/Qow9A6YOK+wzdUug59cU9eRJhN+dSP7lYO65faV7ZFbl2gOpWHBpHrmiPE5g5kfxiP4
 rIeFxuSJUv97hA4j0f2jMIGmks5fRs
X-Received: by 2002:a17:903:986:b0:2a0:97ea:b1bd with SMTP id
 d9443c01a7336-2a70087cbfamr120036635ad.0.1768774142979; 
 Sun, 18 Jan 2026 14:09:02 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 42/54] linux-user/arm: Drop CONFIG_ATOMIC64 test
Date: Mon, 19 Jan 2026 09:04:02 +1100
Message-ID: <20260118220414.8177-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index cd89b7d6f5..40aefc4c1d 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -146,25 +146,8 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
     /* Swap if host != guest endianness, for the host cmpxchg below */
     oldval = tswap64(oldval);
     newval = tswap64(newval);
-
-#ifdef CONFIG_ATOMIC64
-    val = qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
+    val = qatomic_cmpxchg(host_addr, oldval, newval);
     cpsr = (val == oldval) * CPSR_C;
-#else
-    /*
-     * This only works between threads, not between processes, but since
-     * the host has no 64-bit cmpxchg, it is the best that we can do.
-     */
-    start_exclusive();
-    val = *host_addr;
-    if (val == oldval) {
-        *host_addr = newval;
-        cpsr = CPSR_C;
-    } else {
-        cpsr = 0;
-    }
-    end_exclusive();
-#endif
     mmap_unlock();
 
     cpsr_write(env, cpsr, CPSR_C, CPSRWriteByInstr);
-- 
2.43.0


