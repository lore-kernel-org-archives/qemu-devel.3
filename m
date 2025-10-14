Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F415CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJN-0002BV-5x; Tue, 14 Oct 2025 16:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJI-00028v-S4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIv-0005L0-UV
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-273a0aeed57so3529385ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472445; x=1761077245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ARUYNEiSDCx6dUOsxKOfcVAkTmdI2Q03KQKAjoC4js=;
 b=yIHlYprMq9iXaXUKv6YnzhVnPuRFtxlYI/NqKeEeHdm2IE79zBvH1Bu72UIK7M/RjH
 aZLS3oCf0A/VNBM5/Vw4YkUjpLY4CbE4Pi4eGqMStb2pEUH9lMT6Xej6vlVvx4f8PGwh
 clfOqjR1R+76RmpxswCAuAQ7xBvHnDS1yYjlyIxHzGbCeApVgCAPPSKGvAQAGDlfUzel
 ZQ1/7MCyWLnK+tpvU7XGQEyeoZMLhoV01zRauxm0O8g4q0cIEVx8Dww09L4db72JKn7u
 jLpivbu5gQdcLUieR8Asdz90Ulaelpq0mwUBd493hCJjAUEJ41OOpf+4o3toTRt9Zz/Z
 DlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472445; x=1761077245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ARUYNEiSDCx6dUOsxKOfcVAkTmdI2Q03KQKAjoC4js=;
 b=k2QWWpgRcVVaPTwGGFI5y5KZ7csWpRIf9ny2rhvHMsVVWkVXk6QS5oJfWr4L3+1j8u
 fz6lzoLSu/m/tJwO+L2vLR+GvAtDBhAH1w3hyGGJAxBcLyeexZyhumKV3PskxOiOL9HM
 gRT+RzVQ/m6OT6Vvje/sN2dWEWp6yow+lAlfuXxlsS7qex/TZm13A1jkZH/COphFihy3
 JpAsZhoKYrz+YWZ+wkMuSnG6XJvK8dp1bVqGi8jDBE1CYmEbYOGhaRdRRGhDC2zHmqIk
 PM9rnqdLQqhaBLcv//jY6wjaHyvW4qElBwk4UGf0Rf1xVGjGp+HQiK0+aWC5leB5IfGE
 5JsA==
X-Gm-Message-State: AOJu0YwTrrHBJEmiry/EclMYApQbRVwPZqMXeM4DtBB9u+YxdRsujytP
 Ck2RbX+fv52Wpokqd1pZ4+F+P5IrlbRvicSlR9hX3+CfyOfgTEyLfkrhrJXgsxGkK62P4LoJnz1
 r+Y0AYXc=
X-Gm-Gg: ASbGncvZ+zTqaGNhdTShGq8eH2KtM757l9hPrnYocFS5KhLATihkk8fZiB9xTpDz1hz
 ETXdWerMCDGTMR+JOGj1a2eFXcbC1uFB2Ni6Oa+KPQaVAH/jnuI1Qyk//TnO9fqsBb1R/aUznZE
 yblBOrpHeeXt/9UzbiTSywr19GYRMf66wfFoPQbgu6H9Lw6fO2RSb4d8b0wTx5p+vFtJ8b1rU0e
 P0k1XnT9KxkaW8K19fyF5GI4cz+fSk/t24ieW1OkOfImqmwGedG+xbsh8e7L8qDrhhZT1Bo2Txg
 6kscd0CCSTQY0goUnebcWmFXWCtHA4+XRyo6KOVHNXVCjXp0LGQS5zlAya0YoyzmkHo4RkAbpRj
 Vx8v2OsZUkqPFa8do6g5+zLyoUw38y48wo0qqUItMiQHQ1L+13nM=
X-Google-Smtp-Source: AGHT+IH21jFpL/bS81DHPbHi/pP111ZmhHJzcDXosPjr09I9i3JezC31Cq3blrVFawB/o9GEsn0CyQ==
X-Received: by 2002:a17:903:faf:b0:28e:873d:8a with SMTP id
 d9443c01a7336-29027f0cd0cmr322417955ad.15.1760472445567; 
 Tue, 14 Oct 2025 13:07:25 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 09/37] target/arm: Merge arm_gen_one_feature_sysreg into
 the single caller
Date: Tue, 14 Oct 2025 13:06:50 -0700
Message-ID: <20251014200718.422022-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/gdbstub.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 89324e4ae9..8583057b58 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -271,18 +271,6 @@ static int arm_gdb_set_sysreg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
-static void arm_gen_one_feature_sysreg(GDBFeatureBuilder *builder,
-                                       DynamicGDBFeatureInfo *dyn_feature,
-                                       ARMCPRegInfo *ri, uint32_t ri_key,
-                                       int n)
-{
-    int bitsize = 8 << cpreg_field_type(ri);
-    gdb_feature_builder_append_reg(builder, ri->name, bitsize, n,
-                                   "int", "cp_regs");
-
-    dyn_feature->data.cpregs.keys[n] = ri_key;
-}
-
 static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
                                             gpointer p)
 {
@@ -291,7 +279,6 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     RegisterSysregFeatureParam *param = p;
     ARMCPU *cpu = ARM_CPU(param->cs);
     CPUARMState *env = &cpu->env;
-    DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
     if (ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB)) {
         return;
@@ -310,8 +297,10 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
         }
     }
 
-    arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                               ri, ri_key, param->n++);
+    gdb_feature_builder_append_reg(&param->builder, ri->name,
+                                   8 << cpreg_field_type(ri),
+                                   param->n, "int", "cp_regs");
+    cpu->dyn_sysreg_feature.data.cpregs.keys[param->n++] = ri_key;
 }
 
 static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
-- 
2.43.0


