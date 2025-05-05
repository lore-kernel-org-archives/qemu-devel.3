Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23ACC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1B-0004Mk-JK; Sun, 04 May 2025 21:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0q-0003xC-9F
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0k-0002ZV-K3
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso4378426b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409969; x=1747014769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8C01O7GU6PtK/NYVapVL2wa5t0zjMaLo72cjg41Wlg=;
 b=jmXhW9mLoFn09JPUlhIGRvRxCtkZ97nsbLSdEv0gpDQgJ/DO1SBayYDXgfMYsUx+tR
 K1A+0j73EuQR8a1TG9dqfP6MNxg67RNMhc2g08XfvyCJ6lmHgrdjhf+gVwaNtR8095Ad
 1RI7qKT6laElQxLOTfjqr9yhcoASIGWPqxzWawNSdmW4U1iyimWLXRJcO9A4ms49rLwg
 Cfdy42l9Lk/U6Vly9SPuIu/IJQ5duugywoFm8qDbCgt2/R0dTS1bp0LO3OpeDg7WyrKb
 259p/Ynp+pxtkIDkHCTvtzhTs5BcO8d1L4D/J7v1gTn3g7BuQzA5uQi3hlVoLnt6H3eE
 KR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409969; x=1747014769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8C01O7GU6PtK/NYVapVL2wa5t0zjMaLo72cjg41Wlg=;
 b=dhFgYcx8UlnTDnZqlDsePDFkpDQMzbaCocoLmnW8+BgkGdqNhwM5aZ0VxgZP9HPXDc
 iaVq0u4ZcxHhwWswgQS1cybYoqNwVcH6RZwwZAmixeb7VVqDPbbo+2961bu6jZzy9LZp
 VhbyJVxwkfXmRX9cAPe6/GAD8QW6zvitb3R+lpmuNw7pFFI+4s0Kwf8mPiXWJMDhy9Em
 HllOWf1yLB9sfIEjSL0b6plNTXTQ+5D0MmnfVVunUGl2TDMT5ps5lPFgBWm3k+Uv3S6r
 vHo1oBRnqXvFdadBx6wVwb+RA2sbYY0CFoZdCgY7tY7QU9aCwWrbdlVBWIGvmJ2FDZ0K
 zZ6g==
X-Gm-Message-State: AOJu0YxlFGrKzPpolNhU6Zs9Lj32NaklLBsZeDrFx0VHH2SKXEqwuFns
 QDyulPt2oc6vHROYuuwIL32OV5nogIYos6eC1ozUG9GW5ufWkbGqs3GzbytiY3Y26OUJulMNU0c
 5vpM=
X-Gm-Gg: ASbGncuje86jOcmKz1dBXg8BDUkOqIjAlqz/iDegbe4Lc6EvFaET2fc3RAhLqUsK5oW
 rDXceUMjD75UnX6v9w5Cd31y/aBmeTW8vnfuoqEAPVaRpMiYB1q4t57nmrZzM+aQ5ihoDOC1kdd
 fmFUI7kB/h72TqmVD3DWxLcrjNWt2wqKwdXk15pxc1NnHS1sBOdytTR5AdoWWlhu4nJ4O5KeB+m
 +OQJQM4jqR4UZK8WN15MP+cnmXF/KM89kshZ3U/cijuqVpwyBfivfcTcIAbsNFsxUXab1ECLcU8
 adAc2W+cOwxHZtTWCShYvLPLo7qlGWMSnOk3pcUH
X-Google-Smtp-Source: AGHT+IHiEk3UOQip9JYyp7dcUAGKcm8K1pFYoaIR5DOLsapNGpbY+g96PPg3mXrgXS7c1B+8FJb02Q==
X-Received: by 2002:a05:6a20:d046:b0:1f5:8eb1:d5d2 with SMTP id
 adf61e73a8af0-20e966051a7mr7469413637.13.1746409969294; 
 Sun, 04 May 2025 18:52:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 23/48] target/arm/helper: expose aarch64 cpu registration
Date: Sun,  4 May 2025 18:51:58 -0700
Message-ID: <20250505015223.3895275-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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


