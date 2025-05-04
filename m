Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE0BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvC-0002GM-H8; Sun, 04 May 2025 01:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv6-0002Aq-LA
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv3-0004Nk-ME
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso3518630b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336580; x=1746941380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WEHgb3PA0pyGgNPS7z7gsuRl+TMt0z9hzrheqBn6Fo=;
 b=z2ccpe8zDpCEswURml3dyJthobyym0IFMygvoU1sui+/4h09W21x3pdDRihwhpvi83
 5Zgy5H/149a70qx1ossHR/PVJ6GijsZCdP7/Qh69XJqTCWHxKfeUWWc1vrzsiarkEWk1
 BrNFr1vwIJRJVQjP0gzBhJzJ3kx+Wr0YXp26T+Za8+dRY4YfOcTAEEv+pF5DUG4CvVKn
 mHsuOcHHeONzPewI5XTIQ0oBCw8b8RAFPDKhDXTOGxCxRK4cQ0HjwxEV/YIGGB/TWL6x
 O/ahbmw1SeEf6u36ZuqR8VKlgNHV3BfdTq4l87ujpt+F+w15MFLiabKO5Y1CLSsmX+7R
 rWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336580; x=1746941380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WEHgb3PA0pyGgNPS7z7gsuRl+TMt0z9hzrheqBn6Fo=;
 b=lOtZjmHp2GJWdgsv0BZPUmVo5DsUlJWJGpEBRPn2QZjaAVCHCErE4Ndgqzpb7udHcu
 +GqpHxyXTtJ5b2DqPVntUtUnvieOCsFupQOAdSeodipLQnyqg4RSzyyE/Yfo6H4or/0c
 1hChjgkFcObGuJTLUwZen3MRVjh3U8wtswdYnZe22iY4v4lhvpURu9KJIUsOzC5obRY1
 wofwYLh1YhugLSkATx3aZoNddoRu0Q1l3IzCT9xLgMSBBGh+naIX8wOAvT777Vy4ewwk
 le22Vyuz+0dwf9ON+HI2FsLsd189bg22KxCW9uu0dET+F8xF8QWkNGxCFh/3xUySn2kF
 +4Jg==
X-Gm-Message-State: AOJu0YxFp5ZDOc0cEYfQA5xF8xi+y0mCG9ZfRXzB7XxAva3yUWNulAdf
 Z7HraUhe1ktOyJ1PnovIA1vnVXzT6Y70Am2Vb4hgm8FiFWFkTO9CU0fY+YKUjdMZd1zxQQhmPRP
 XkBY=
X-Gm-Gg: ASbGncvaRV/4q+gyOO9iCNRGBssUFm54Afm/rjiMdkCl36FEjLOUzxiKplvHwLlT6uC
 qT4G2bjFwKkeBkk0TQ3IaLz4BcHRXJ8BCDYKDwON0/nmnXsIWfpW2CTH29WVkrlJDndQ56BlbaS
 33fLEQDf/9jr5lCT+MD6GOtx8v4w5HrE2L8BIJCR+x+98mceBpKGaqmQ7x6FFUAOvjmgTq79ahN
 66090XyaHU2SeJ1TrNEK/3Cjk6ov0IhPZmeOwAPdFnXCNRUu1G+dhAoQi5FwbHQOfBX1AaxGcfS
 lLxp84Nugn+lzC/R9jVl2sm9Tw1fY1JgPynS4UKf
X-Google-Smtp-Source: AGHT+IFZdCoc3EOd/pC3yget6airBTErnzBtACDv5VxHLSXZtnFHlYBZlNTtgrNT1W+tQ518XpSk9A==
X-Received: by 2002:a05:6a21:c8d:b0:1f5:6d00:ba05 with SMTP id
 adf61e73a8af0-20ce03ee7a8mr11142737637.38.1746336580375; 
 Sat, 03 May 2025 22:29:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 23/40] target/arm/helper: expose aarch64 cpu registration
Date: Sat,  3 May 2025 22:28:57 -0700
Message-ID: <20250504052914.3525365-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

associated define_arm_cp_regs are guarded by
"cpu_isar_feature(aa64_*)", so it's safe to expose that code for arm
target (32 bit).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 595d9334977..1db40caec38 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6591,7 +6591,6 @@ static const ARMCPRegInfo zcr_reginfo[] = {
       .writefn = zcr_write, .raw_writefn = raw_write },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
 {
@@ -6825,7 +6824,6 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .writefn = aa64_allint_write, .readfn = aa64_allint_read,
       .resetfn = arm_cp_reset_ignore },
 };
-#endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
 {
@@ -7017,7 +7015,6 @@ static const ARMCPRegInfo lor_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -7510,8 +7507,6 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
-#endif /* TARGET_AARCH64 */
-
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -8952,7 +8947,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &hcrx_el2_reginfo);
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sme, cpu)) {
         define_arm_cp_regs(cpu, sme_reginfo);
     }
@@ -9013,7 +9007,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
-#endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
-- 
2.47.2


