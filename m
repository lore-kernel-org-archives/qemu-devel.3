Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17782CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXym-0000GA-RT; Fri, 22 May 2026 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxh-0007hN-7l
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:21 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxf-0007vY-Ie
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:20 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so7239993a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487398; x=1780092198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epi5Db+NEJvAV3yjmIz6G1joTWyvNosrwyck86eF+i0=;
 b=PiIUB+idlRHKX+gt2EOYft7FO2uQ7hH+jgkVeNYKqMy8twpPv5653HhzmpBTcuXcxV
 IhN6h2vWCUlXvwrfn6LmePGbXnbp8x/F5YUXv8JCWWekJjyw/DlMS8im0XaS1Yw5bKr7
 qhpVOx9QA1fn6+QSrL6hkmKkoaGFhagNm6hTqCmnyFBJf68h5fSFfV27/lZ/HwXkxak8
 wiNvsuci0z2NXbRYvvdo8PmOeVySMSWT54bam/nuJC/SRMjZoWN9zhBZ42gmBbQi+l3l
 b8BmWDN82M5eusOW9eZk0i3+I3u9rUoo2qbI9xKJX+2DH1nEfrajHIaYApUPuS7YqJRg
 QmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487398; x=1780092198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=epi5Db+NEJvAV3yjmIz6G1joTWyvNosrwyck86eF+i0=;
 b=JkXr6/x2xZi9DCtR4Z9d3St/xDnEkQrc1bX/c0af04kXyx7caGZpnMlpyFrWYit75w
 dGRfd+LBVNNEf+pranizWThRlA3vx6xq82j8RSpWeTylDC/o9HbKVotVYgih78VhuwaH
 G5WAHKdINkA3Rfbpz19kaLpRoKEwujgLuBJMrQuuWf1aXKggof2dcUrrvkijXBhZterq
 IN3oQyBU4aezJXkJBf0qmjuvgcj7P0cBN2VstQ7TNXF8KxcV4Ua3ayCfYmI/a1ee67iC
 7PSWj8A9d5hPwNyURKW7jS2JcTvYcsk8XwTpUQqp9+TTqRZ9dhbPIUKhlLnDnkkdlqpJ
 tgQw==
X-Gm-Message-State: AOJu0YyeFUkmymIF6oqmWCNbLaZYtgZKgdm+ayhpWfhVaTWEI6QLdk4d
 GMNq3QWIoaE8blza19yNi78pXuhggUEd2yvhDCyZUJtQ9SetnIUDBF3pGINycZHl9w1g9zmj3/s
 64Jh3
X-Gm-Gg: Acq92OEDY/kSKW4NqIxgJ+fTBmIWrghA9Qc1dVgDT2XQIELLPiLMFIHDixit6qZDFGU
 iROQi1DJK91lbLAfotpmQWllcw9lqGdmt7hU8oGUngHk/dBRs6Li0ib+zifZMAT5gFKRhCOM1QW
 mjP0xHUF3rgnFu+EuTkaiBCcIh0F8g2QvG4opfgxFMBHFhzTVeDHB2NsJ/sh0SPySXob6OAwbMx
 VADCPA2OA4ZLcUyXHXwuOXbwaGbGSJGuKYCPEmB5x6wPstRU6C+aVGsHQYhCZKh4w1WJA8PEI+Y
 6FQb5aoLWhyh1Hnc6+Vi6nD1bx4VKeVyZHsn8X85Kr1Tk1bpwRRLLgT0ujGi2sRFjsjdcLQclih
 dNL3ebTGYKssB5NXORQwNIDHf3PZwCq5A4Fhe50wqxRQw8RWCo/rO0r2mlOD1aTjR6TXLNPW7Z2
 DSX8HJ58ULnBNcTytMT6qAAbbNkvonQScvepaoUwI=
X-Received: by 2002:a17:90b:58ec:b0:368:57db:784a with SMTP id
 98e67ed59e1d1-36a67640b16mr4885595a91.22.1779487397980; 
 Fri, 22 May 2026 15:03:17 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 10/64] target/arm: Enable EnFPM bits for FEAT_FPMR
Date: Fri, 22 May 2026 15:02:12 -0700
Message-ID: <20260522220306.235200-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
 target/arm/cpu.c    | 3 +++
 target/arm/helper.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e1ea41fdc5..84b2cc70e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -742,6 +742,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_mec, cpu)) {
                 env->cp15.scr_el3 |= SCR_MECEN;
             }
+            if (cpu_isar_feature(aa64_fpmr, cpu)) {
+                env->cp15.scr_el3 |= SCR_ENFPM;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae1dd42dc4..7eb7031294 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            valid_mask |= SCR_ENFPM;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -3973,6 +3976,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_gcs, cpu)) {
         valid_mask |= HCRX_GCSEN;
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        valid_mask |= HCRX_ENFPM;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4046,6 +4052,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             hcrx |= HCRX_GCSEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            hcrx |= HCRX_ENFPM;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
-- 
2.43.0


