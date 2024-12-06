Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AE0E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOlr-0006sv-3D; Thu, 05 Dec 2024 22:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlo-0006rM-HR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:44 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlm-0004TG-Hb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:44 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ea60f074c3so880576b6e.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454761; x=1734059561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvQBmtI9jAhESF4PQRO7FGQkkBcIC5v2Rh4VEFBGyao=;
 b=DT5UXRWRBs1GYn34i4le7jk6rOZlYu7HqV6Q34egMn4KKa7oHagQ5vkXwUKjKZjQL8
 PwwNP2hQaXEFol9I8Wmpp1C7p8hHQ+ONXscgYMjotFS8ktY9oDZZ+Zxi0ZemWxyY226P
 6TzmAB4Z/B6T1mpc81ucxSb+F905fwT7pQEOFFN0j0DWOAtloWu6/bHYbPO3RepVbbcr
 pJvpJcF4zz/YfKvDmYCG/Hm3YFf61LVDK+2ZpwEXIEDRm+s1vDa22YCGyp4p1YfhdYbi
 JL9y3L73mFlDAaS4soluTnjl7CLb8qTJD6drw/nrzkDSvvoGN3F7ypGkPusx+vJodRK4
 RwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454761; x=1734059561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvQBmtI9jAhESF4PQRO7FGQkkBcIC5v2Rh4VEFBGyao=;
 b=ep7kW4QUJK+Dam5640zPt0clYA5M10LRI4gHv7Lo+EBE3oLhop7EptK/cbEQxxeEVI
 sVuUk5ZQm/dIY8NowsFDGUEaIMX1awSuU+erIbKpJH9GZyvUm7XSRQb9KrmXAo33gqCZ
 i3fSrA0yM7bun+qIExF1xkFXwMySOxHq/vD3gvzZSMvRl4Pio+A5R+rCg8VhYw7Zd71D
 FEw+A/kYUCXE4ZfwlayVBtyTkIyYvzpW7XJ0Lk5wovbRuExxVLEY3VG5T8FqqalPul/7
 AOlqTEVcohf/wEkN7R3oQBeKDHjVZMMCVIJ5Q0ebOK5SwOluTycyZQyVBk6BeWJoOFeZ
 p0qg==
X-Gm-Message-State: AOJu0Yx11h84XGRIUeYweMGOpm6G1w2lXPjSAcuFLWpCCv5sINZyZCi4
 hHReTYtEkCSdHFjfwTNwQGLgrB/H58EBbh0CrNJhq/eFjg3UtL1/XabjPWKJSwdaTi3kVS2HD9q
 JLtVIqOHf
X-Gm-Gg: ASbGncsX6rlb78fBclQoprgBktpt4qpxfoGnFtg4nO5C6J0DsByKUb/4vpkNs1BryJG
 XKv0dHwGGIDNyCATb8NMTrYOgnAkruYgXqWqdGq/AMaPS5Qm687iqIsVQAje32EaFR6xqPKCOrC
 H28PK51qB8ZzSMrfdVLPKoZeW0b1Iq0PsSyVTQhr7Y6a+16xvoRn4Y2PbOHe8rUr7Gok2grHPNL
 AN+3Ken2CsA94g1qkD/3fXXAwWDSpCF3fMmX0/boxt+jFIXCfxh+Ik/TXdIn9jeKXcSbWmpPqi+
 hEp8LDezqmHXMvGp68+UgzL3o47AqzmuCUjZ
X-Google-Smtp-Source: AGHT+IFSAFyj10niXdXtERPP0Krbigk4y3gxJY0TfT3RoIiiOIlOV5G/79g0YEHTSngHD+hqd4zR2Q==
X-Received: by 2002:a05:6808:1202:b0:3ea:4ec8:a325 with SMTP id
 5614622812f47-3eb1999dd07mr705034b6e.0.1733454761221; 
 Thu, 05 Dec 2024 19:12:41 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 9/9] target/arm: Convert neon_helper.c to use env alias
Date: Thu,  5 Dec 2024 21:12:24 -0600
Message-ID: <20241206031224.78525-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
References: <20241206031224.78525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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
 target/arm/helper.h          | 56 ++++++++++++++++++------------------
 target/arm/tcg/neon_helper.c |  6 ++--
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 61b135a707..d4c8ff40a1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -314,34 +314,34 @@ DEF_HELPER_3(neon_qrshl_u32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
 DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
-DEF_HELPER_FLAGS_5(neon_sqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 99fbebbe14..e2cc7cf4ee 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -130,11 +130,10 @@ void HELPER(name)(void *vd, void *vn, void *vm, uint32_t desc) \
 }
 
 #define NEON_GVEC_VOP2_ENV(name, vtype) \
-void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
+void HELPER(name)(void *vd, void *vn, void *vm, CPUARMState *env, uint32_t desc) \
 {                                                               \
     intptr_t i, opr_sz = simd_oprsz(desc);                      \
     vtype *d = vd, *n = vn, *m = vm;                            \
-    CPUARMState *env = venv;                                    \
     for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
         NEON_FN(d[i], n[i], m[i]);                              \
     }                                                           \
@@ -142,12 +141,11 @@ void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
 }
 
 #define NEON_GVEC_VOP2i_ENV(name, vtype) \
-void HELPER(name)(void *vd, void *vn, void *venv, uint32_t desc) \
+void HELPER(name)(void *vd, void *vn, CPUARMState *env, uint32_t desc) \
 {                                                               \
     intptr_t i, opr_sz = simd_oprsz(desc);                      \
     int imm = simd_data(desc);                                  \
     vtype *d = vd, *n = vn;                                     \
-    CPUARMState *env = venv;                                    \
     for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
         NEON_FN(d[i], n[i], imm);                               \
     }                                                           \
-- 
2.43.0


