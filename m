Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE156D148A1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdieO-0000sl-Km; Thu, 08 Jan 2026 00:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicM-00082V-Cc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:38 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicK-0005VR-Jp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:30 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so1680117b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850287; x=1768455087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HNdVDbPSJu0bsdpcMcGgNm7vnYIdjIXTO6+ogoktfFo=;
 b=QZxNrw3Y3oyyfHVIMp1QCvaBAzypbex5LFPx1r7GcVN3dii3OqaJua2QXygQAIo1KY
 4PEV8+d3sx1XkBISYcXWTIid4Jrkc2Dw28HbyYH/EqH66pz8lM33caiZDXmC8SzM1jBh
 VYPrzQ6jWe2tAgQYPoAQlOFQD8OAEyPGYwiuzw5vUqfk6jH59jmld+DP18qN7ylhn1DY
 8qRx8e58hiGHzUvjmog8euo5PrRFv/MbZRF/ZZQ4oYIX34SrkILhiUurZ3tYCaYMJJk6
 fVwfP9CgY6vvLKUVccPsuU+8XFXMfSYoFNNgrz8ywIbyABup3mhulG6pQX/pJoULpvVr
 DHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850287; x=1768455087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HNdVDbPSJu0bsdpcMcGgNm7vnYIdjIXTO6+ogoktfFo=;
 b=v0dVLtrRRbJFnXjlekO9Pi84lN9jTtxIMBAso+YfypCEuTg79V6XESGEmzAQ+TTh0x
 QelRHC9wIQL/Fi4cvBc8JDQJ0QGckKY6y1g3J3PcFUPOneZDEIb77zkJ6bCuA4x+Fitl
 vEp6pR5ui0N/DFszEBWUZoL2tXe8OAEQs7ZxNm6akCKkOCbVP5UO+WoN1amyxDf6/Iek
 JsVnXzxJpXOefluHekZwz5mj0naXdLKMWiNec4A46hC7k6NbDXF5BjW9WsuVzLRFbo2w
 4PqTCNmWGzc93CrwTwVhQIJXg9VO7fG6q2aCsT8TLEmBsA4ZhDjGwbzYm2ir3+20IWX9
 QvwQ==
X-Gm-Message-State: AOJu0YxzE4eVClEuinvShWgfX1bl+E+ae/JwzL35nmqFlTZ6mFjMn5Wi
 wXluSRuWmubgBi7uEZCgHSHzXqsDbYNHjIPLaArzY7hOvfEJ5jNavdPRKW9lsCkXVo4TesrrOFA
 SYDexqNk=
X-Gm-Gg: AY/fxX4PMd6MHYb4nn6MMP8jOvN/mKiFbd93cLqOU0BDSmHwpKNndcifjP3YCjKIlT9
 Gxxh8qcbPC6wEjCALYF/Vr36wvouVsqW6c30daHt1bNDrkkRAInMTPUprXQ+hG/pK4HDhALStHy
 1LeOvEghs1eqGydYoyvpb81sHhS+z1yDmbVvxIVd7LDZBqxBD22A/wLtmyqrNCyRUR95Lhr2LLE
 BlEbpfJ7/5GMhi1pTi1n6lYJsZBg6Rmcfj0/aT4ltK7K5LzWOHjhKGtV6NDEkJg1YCrpfawLBIi
 U/lJoxz4qtTFRpNpR8qrNCi+e7CW6bc+FT6cxy8KGHX7S/UU8BFeCJwi37lqAyTWM+oee7/kYhF
 21UIwDis+TqpeDZqprVdI61fPFa82s67N1b5LCvjLG9CQCaJ8HhuH6/00N+iT40QB5E808ytPoB
 pAqKj0+ijSw9f5jyWJcLV4Qoee8f13
X-Google-Smtp-Source: AGHT+IFLodufoPMFp4gMK0myqTu/wLec1y1njrNpfkJmVF7rskos4zq/h6DowwjkZ0FUefuFPT5zPg==
X-Received: by 2002:a05:6a20:6a08:b0:37e:8eea:3e3f with SMTP id
 adf61e73a8af0-3898f9c28a9mr4421017637.80.1767850286898; 
 Wed, 07 Jan 2026 21:31:26 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/50] target/i386/tcg: Drop TCG_TARGET_REG_BITS test
Date: Thu,  8 Jan 2026 16:30:00 +1100
Message-ID: <20260108053018.626690-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/i386/tcg/emit.c.inc | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 535844dc09..3530186c8f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2093,34 +2093,15 @@ static void gen_IMUL3(DisasContext *s, X86DecodedInsn *decode)
 
     case MO_32:
 #ifdef TARGET_X86_64
-        if (TCG_TARGET_REG_BITS == 64) {
-            /*
-             * This produces fewer TCG ops, and better code if flags are needed,
-             * but it requires a 64-bit multiply even if they are not.  Use it
-             * only if the target has 64-bits registers.
-             *
-             * s->T0 is already sign-extended.
-             */
-            tcg_gen_ext32s_tl(s->T1, s->T1);
-            tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-            /* Compare the full result to the extension of the truncated result.  */
-            tcg_gen_ext32s_tl(s->T1, s->T0);
-            cc_src_rhs = s->T0;
-        } else {
-            /* Variant that only needs a 32-bit widening multiply.  */
-            TCGv_i32 hi = tcg_temp_new_i32();
-            TCGv_i32 lo = tcg_temp_new_i32();
-            tcg_gen_trunc_tl_i32(lo, s->T0);
-            tcg_gen_trunc_tl_i32(hi, s->T1);
-            tcg_gen_muls2_i32(lo, hi, lo, hi);
-            tcg_gen_extu_i32_tl(s->T0, lo);
-
-            cc_src_rhs = tcg_temp_new();
-            tcg_gen_extu_i32_tl(cc_src_rhs, hi);
-            /* Compare the high part to the sign bit of the truncated result */
-            tcg_gen_sari_i32(lo, lo, 31);
-            tcg_gen_extu_i32_tl(s->T1, lo);
-        }
+        /*
+         * This produces fewer TCG ops, and better code if flags are needed.
+         * s->T0 is already sign-extended.
+         */
+        tcg_gen_ext32s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext32s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
         break;
 
     case MO_64:
-- 
2.43.0


