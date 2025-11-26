Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48061D11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM3J-0004l5-AD; Wed, 26 Nov 2025 15:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3H-0004bd-36
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3E-0002YX-FB
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso1468775e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188623; x=1764793423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fTaxNly4DgcgF2+VUNXcxi8mtgdCJ/FSAiYjjUPHnU=;
 b=P1mwTb96VEnRm5S90sas3bbwYG+bWGihQKfvDjU9pFCHuHI2uLD7Zt7h51pB/rMona
 1Hl1w5XwHMsjAkUa1D+PLIBT0+H2Tn+0IosPJSAO9P4/BtJRHDtGD/65ccj1oK8i1IZM
 6K7cfBXAp4EeZRGcxTJldoanlp4Fa0VVEyOiBz1HYlGxH9Y193r+R9/KKdz/+t+ZJC+T
 wd1mVTUForp9YuPg3w4QThnOmYtr1sTYxGSglL2OUeLB2dvUtNy0bNWTXBDgPhFmHMN4
 Zc5OA3TzRsdEq8RD1epyBOh0K3ZhfYepMQHsJk8oCz1384Arl5vb9O5+KZ7NrRxhBwV3
 M/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188623; x=1764793423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7fTaxNly4DgcgF2+VUNXcxi8mtgdCJ/FSAiYjjUPHnU=;
 b=dJGhWBP5qmPVbVFki8W+rnK9K4oaeWLNoYaf1QIAqyJLDdHdx9SzcpYr99IlhNLsWo
 n2whp8988DkVwoO+U+r2V8CKdlowQNb+z84xd8o90LlkpNV9p2gphaCc5MgMoRgX6dbC
 y3klfhKkiwhRcaFGnL/b/bsx0h9hVhnUQodJjIfWh1RURWHOILl/QdBnXR+waLiZkVlr
 GpZnm9LDeVHWWG/d7Abf/AIdijqcv6lDZLoBkF0VBpGmwqaNp5pLhdiAOOPIW7RcVxLt
 GR0lM7IxCQs434wRB5tuEXFvIPyMjfzZZOV3txY2HhFBKDRywAk1Ztht5sPc0L0uuppN
 vlkA==
X-Gm-Message-State: AOJu0YyNoxlnPWlRlUUavC7B5miTTgvDxd6KxZ2tsNOhFnte75geoR8o
 jah0PFSVb6aVlRJUUETdLfVMXXDt1Y07z5GxkmMFwBq3FrAgyiFjw8mJLSDpfu4l31vi/LhNsvg
 Adc01TRBBRjVf
X-Gm-Gg: ASbGncvpK81VF64+5/LNLQflXu8M10gkptkAcjBMaOnig4IRQ7+qW06LsMmTGlsu0CO
 FcuLPAXDYClMAdqhSjuQUdrQCJ2L3+ucF8NTRHqhAHfgqVXRWqwXesa1AHA9AD2c5eEuisMxZ8d
 Rr+NwsvAv42635XZhyXMBJp3b743Gfv8WLFRLhpsMMOf4Q9ojYG1CqiOCbQpYJtWuv8L1xtd5nn
 ZYEUE6ESRHFPdaz6LD1ovspa8/sUtNxZkKcNkYguufC4ZRt3xj4RYenz816mQ71qqdg5H914HPM
 qEX3HtRlEZmmRtFytwCKdVHPO2+bBH16ihH3ZaLVSpkvJ67Px4TUrXXVBOjdFdXjmwHAw0DDqKk
 MDciaA8eYckb2seq1jgLW1hy8xDWj3axLSZcJ78rg95EfyOgORxdMrpgGnGMGoJhwfwusvO9UO3
 BGNpL7HQtswLNZHSko9czwHpYJ1UiYrqSCRKsdok4VkAGIeB+pZVK076DKWmNwpconrsIEeoY=
X-Google-Smtp-Source: AGHT+IHw2uyDk6WlA+6rkBCgnJXOP8CY3imzrRItSfWfgzs+nxra//KypHVpH9oH1AcBm+q8WacrCg==
X-Received: by 2002:a05:600c:4b19:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-477b9ef5131mr167959045e9.14.1764188622638; 
 Wed, 26 Nov 2025 12:23:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adf5387sm57551845e9.12.2025.11.26.12.23.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 14/22] target/mips: Drop almask argument of
 HELPER_LD_ATOMIC() macro
Date: Wed, 26 Nov 2025 21:21:50 +0100
Message-ID: <20251126202200.23100-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

HELPER_LD_ATOMIC() now has a MemOpIdx, from which we
can extract the MemOp size. Use it to check the address
alignment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 013cd825dac..bef384575c2 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -29,12 +29,14 @@
 
 #ifndef CONFIG_USER_ONLY
 
-#define HELPER_LD_ATOMIC(name, almask, cpu_load)                              \
+#define HELPER_LD_ATOMIC(name, cpu_load)                                      \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
 {                                                                             \
     MemOpIdx oi = memop_idx;                                                  \
     unsigned mem_idx = get_mmuidx(oi);                                        \
-    if (arg & almask) {                                                       \
+    MemOp op = get_memop(oi);                                                 \
+    unsigned size = memop_size(op);                                           \
+    if (arg & (size - 1)) {                                                   \
         if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
             env->CP0_BadVAddr = arg;                                          \
         }                                                                     \
@@ -52,14 +54,14 @@ static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
 {
     return (target_long)(int32_t)cpu_ldl_mmuidx_ra(env, arg, mem_idx, ra);
 }
-HELPER_LD_ATOMIC(ll, 0x3, loads4)
+HELPER_LD_ATOMIC(ll, loads4)
 #ifdef TARGET_MIPS64
 static target_ulong loadu8(CPUMIPSState *env, target_ulong arg,
                            unsigned mem_idx, uintptr_t ra)
 {
     return (target_ulong)cpu_ldq_mmuidx_ra(env, arg, mem_idx, ra);
 }
-HELPER_LD_ATOMIC(lld, 0x7, loadu8)
+HELPER_LD_ATOMIC(lld, loadu8)
 #endif
 #undef HELPER_LD_ATOMIC
 
-- 
2.51.0


