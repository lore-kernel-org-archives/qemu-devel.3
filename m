Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D4C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57O-0006f3-TD; Mon, 05 May 2025 19:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC578-0006Ng-7y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:46 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC574-0003be-Mh
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:45 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af28bc68846so4710073a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487241; x=1747092041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8C01O7GU6PtK/NYVapVL2wa5t0zjMaLo72cjg41Wlg=;
 b=Ix9HqNicOxFtQ3+VZw8+DyCmy7HGN2Fv51rrw0RDUnXCT0RGG/VCayWV32a6ZBRgcy
 VeV/WZUMEzocyJDL8bZRcnqPF0ZlnMco40QBIeauUSD9u2H9Lx0GiSfZTOh5KJDXHQY7
 rBzdZSDH0dR7c1Z0oHZAXhvgM9KqUrRFtVWzMYS16B4X7GmuG/+ji8wd7vP+00lZr3ac
 ZjsFO6c/r/jbJ1K9YAcEOcvzBOtkvTNBer0hlT7ws0SsCTjTyrCeN/knbBuFyUIGGal8
 YONZd+eTAWBTEVUuW46KNKZYr9X6CyqH93viqz1N255T2RqecsGW7DpL0Q76H3epaGQj
 /I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487241; x=1747092041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8C01O7GU6PtK/NYVapVL2wa5t0zjMaLo72cjg41Wlg=;
 b=cY5aLZycB+Aov1bZ6duMvwiZlaFeNOG2isIFwnGjR6Lw54WhwmUrAB9ELnEorFErOf
 EBcxsV4jS+ns8bhrkPPtlYtgfuAWWDMu6wuzmFXe2ECXyUTVukpOdriiEo/wYd7yLPOH
 LFZjVPlfnIsqM0vc5zrO1k4K3Ffor3Xpu8PGX8zkvZ53l7/Hllp7tModWrWB2xZianIf
 cbgXdyWIr/OucQaHpzI40aqjmXehNTwIFf6o8HtnXXLSiUdocHG9H3gq8dQfo/qE7UrX
 qhpwdBRfGADUfI59kZayOqpEze2aouPrJkGq8jmM6vydDxJJHXgUuJMH+pcbwxl+vKfv
 gL0Q==
X-Gm-Message-State: AOJu0YznjcPAjxoGz8aRASCQej2yYmYGtrmbULo3gpYBmA4LNM+3hz+V
 b/MYXb5pphzpKTUvZs9KO4aOhm/uvkEuSC5QxzMvqKQxgM8Nrrn7+ZdF+J5bRwyCjfbf6IE+0Mf
 ZOVk=
X-Gm-Gg: ASbGncuXhLBoRm5iDxqsQSKOs+tMnX+kznkUUmTscyVLFmE2wxq0T8lAuY2ICgbUpet
 pLCLdT2EV6QDNmUfmGEI7xFT4yv1GDDVhChY0f6trnvLRHU8iukugZ9HwyTUcn3t8zwfUmoYWfS
 YdBnIbMBpouThbBYcSau/bQWQoCkUgc8dWfilEA255zHe5aS6I79ngZ9+7EhWXfZf1D5/lO501Q
 R4bAIEkRmSs/8LMc62swTlnqIxLZgIu3Zl0Y5b6UjZkJGNudGzRdMrVm6Wdvtl+fWbrBI8U/pkh
 NpwIiSvc7Q5ptH5Ddr1HzkPueLk81NWMzLC4EcWYC4HqcvvhqIM=
X-Google-Smtp-Source: AGHT+IEpYzPq9ezMy4I+jEKbu52ggydOFGVSukSx9xmYEV4nOTZH+rYgC1fwP4d94dqdVjUQVDDRYQ==
X-Received: by 2002:a17:90b:2dc1:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-30a619b0dabmr16714791a91.17.1746487241023; 
 Mon, 05 May 2025 16:20:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 23/50] target/arm/helper: expose aarch64 cpu registration
Date: Mon,  5 May 2025 16:19:48 -0700
Message-ID: <20250505232015.130990-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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
index 7daf44e199d..7e07ed04a5b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6590,7 +6590,6 @@ static const ARMCPRegInfo zcr_reginfo[] = {
       .writefn = zcr_write, .raw_writefn = raw_write },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
 {
@@ -6824,7 +6823,6 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .writefn = aa64_allint_write, .readfn = aa64_allint_read,
       .resetfn = arm_cp_reset_ignore },
 };
-#endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
 {
@@ -7016,7 +7014,6 @@ static const ARMCPRegInfo lor_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -7509,8 +7506,6 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
-#endif /* TARGET_AARCH64 */
-
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -8951,7 +8946,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &hcrx_el2_reginfo);
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sme, cpu)) {
         define_arm_cp_regs(cpu, sme_reginfo);
     }
@@ -9012,7 +9006,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
-#endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
-- 
2.47.2


