Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED691CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28i-0005Fi-Dj; Tue, 09 Jun 2026 15:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24z-0005i6-BB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24u-0005XJ-Ej
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so50371505ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781033086; x=1781637886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/Nwiw9t72saqAIpJgwvgLiVqmULMLb29nkCaEYkMzk=;
 b=H/Mmzvt/bE7CTHL9Bae9JLbYlMf5V6YkkVp4ZFTMva0TIsPTyJwA9oFu+s4Fh88CzZ
 PaaBo4wd8ZwZI3jK0Pl/zCM+p5EVS5VRYKC6P5yN27Xo4XZ0mF+XvUIscnKklX0Z/Rl5
 2NBEESUJh0xXP9V7CUln+yqbsrFIdxpS7ZnsbsU5YY3G0sAgPwQDjn7JDwaK8JlvCMoN
 gXGF9yE9o7PtSTvgpQ616JP1UatcaOGyXr6JXcMzX0jiESUyoa4X6xW5/KS5Un7mrLZ9
 OWMZWl4DtbyfaO3TE9GqYvJnikx1dAV60M6bwXXyJ6iU9YAscvw+KQHZlym8GD6vaD/B
 99DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781033086; x=1781637886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J/Nwiw9t72saqAIpJgwvgLiVqmULMLb29nkCaEYkMzk=;
 b=KTOMUvfAot5TeNC0Yp13SqwkSOx1za0TYGQJF8q2LZGvcVXw7XkmZt/d/jbAlfT/xE
 /uHbqHgYbJUJWuKVsWgalAc0Fg7dg5eOPg3Od6V/dMvAT4wgQ5Rlx7qmEbhQnP2usXEz
 d8iSNgnPlO+uE2HEQ+Eg4AtAGMd0lWjhAOjK4YssORQYtwEEpGH3fiGTUmH/daLLJxqO
 ByE8LluWhZHP0W/kWUpF58U+SR4deyV1JW+/QtJarpvHqsqMdy+CwNzztbMLZuX00A15
 fVw5DofIzfuumAyN/Amv8IPpTYiOuXStkkBEFDEW9u88+iMpJ4ff6OysMW6z5WPc3N0E
 36wQ==
X-Gm-Message-State: AOJu0YyiXTOGiZhj9EWQye7GpQcGks5knWShZ+sOjfMvdR4eiRebrCd4
 slr0OQv5sGB3zGqd8JEctKZBvhYqSrRDAani7EWN2K+04Q+ojL27wcYcSgGkTfNJgp2aeNckJSv
 L4twQwCI=
X-Gm-Gg: Acq92OG9IsNPoBrniWeIuZfvzsO99tCV1PTNIvuGEAR2/OnUkl4LVEpHuiY9xd+ktGj
 ijAuujPzRMOp22lu3VzMxWaWVAiqxJYpPPbA39ekrI2RAF7WLn+SVU0hO/fn6otcS0kORZBYAum
 y9FHA6YDVSYe2YF2LqOkuompL50Y7geKh19+BFp8CivFW3Mc/kpI3+zKXjRzXeromBiZYBsOkUm
 rNW2LeGjL2BzXUIFlzfzloE+FhGFkT0LeMJlOwFdjfbW2RgRTMyMPT0Z2K8flcPL/WenUr43Thm
 ie0kYZBNJC8N48zwknnCQw/45yzy9Pst7tsO/QEnqKvXvbc3gr/yoFofFStlHjMKvgC3wgaen3P
 adcTZf50dXz12NS+XyDpeITHOqHf1tx4mdEGY2SkrNZTnzyAPADNuXjMyw8/09NU5cwdTCogXiw
 I7n75495X1vO9EdDAkTeNUkAeiDp7ynitT4JQW97U=
X-Received: by 2002:a17:902:f745:b0:2c2:2a8a:af69 with SMTP id
 d9443c01a7336-2c22a8ab1a9mr197825995ad.9.1781033085791; 
 Tue, 09 Jun 2026 12:24:45 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm212247045ad.32.2026.06.09.12.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:24:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 44/45] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Tue,  9 Jun 2026 12:21:08 -0700
Message-ID: <20260609192110.752384-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      | 5 +++++
 target/arm/tcg/translate-sve.c | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6d65706186..5a14507682 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1713,6 +1713,11 @@ static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
     return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm4(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f6705ee95d..a85558bdaa 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8477,3 +8477,5 @@ static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
 
 TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
                         gen_helper_gvec_fmmla_sb)
+TRANS_FEAT_NONSTREAMING(FMMLA_hb, aa64_sve2_f8mm4, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 6610432528..b53fe6a58f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1809,6 +1809,7 @@ FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_hb        01100100 01 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 Memory Gather Load Group
 
-- 
2.43.0


