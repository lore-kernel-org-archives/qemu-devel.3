Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC10CA0FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 22:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqJBs-000631-De; Sun, 24 Aug 2025 18:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBn-00062K-FI
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:51 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBl-0006A4-As
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:51 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-33663b68b06so6485941fa.1
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756074466; x=1756679266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW4KE+q/biI/RulLgySIkhUyzp2bDHwahwhJi5mZvSs=;
 b=mWLD4h51/g/PDlsnkj3MLBDZSPsCOj1BG+LXOSpcMSRpMSLn6Y+9YGLleGtoCo0pJ1
 aS4zYmkKaxmwdTtpO4TvkRE9EbsIbTGY40K0Q5OQnzy5GBRGXBDKR+sPMv8QLzM1YZvX
 LZzS0PV2cUEglkKCx9mS0jnGvBp2QvQbQZ0gYgbZ/zeDO79tPWh9DCPJQd1AnuQSQJ4A
 KintEr7tbI4eVY5UxfK+rQEjJLo5auua4Yndjq6VOSV0T0jiQjKD1sK5StkUQRtmWEKy
 4utUCEY/0eMgeMavGxicRD5CTOxHVFQcKPriafIH4H3MoeEkKOCM6+X46tZoj7KBaPJB
 6Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756074466; x=1756679266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sW4KE+q/biI/RulLgySIkhUyzp2bDHwahwhJi5mZvSs=;
 b=lDsD/ssNqKS2Z18msQPRxg0Qxdza5V1TX1gBxwHRt62MjzhSRb03uIbsdo0lrSX4O3
 Oo4bEMs4n5N8pMZ6nvyczSdIG+Dcvg4W7Cnc8jGbSpHCOlXbCGuxhGezM3JLcZ3gLC/+
 TayVkVuISKu6f1HrUpGr1R3pxJ6wXsrRbyd6nOfhnJIDXB3Wyva5f/uBN/3BfGlXWXSA
 Ba6WCqIcFLT273EMybR9rrxeKmmhAxctjfj0cT039fy8neNYZNpxPE0zit2MgSm8OIy0
 RxHUlCTeYOxDeZJeAh6egKly7qwnBjqUTsu4fj3BZ1WBdkFmWltnzZ211Dl54aLqh9KI
 kxAw==
X-Gm-Message-State: AOJu0Yz2g+VNnR1bCFnui2u2DFBaRYPBP3chMyYdGHtEAJD9XNYvMkfC
 OmFWTEcj49XucQOqACgyOML6QaDHj7UdzFoFDAo3fQLElof1634pnWy6NYciiY6N
X-Gm-Gg: ASbGncvMzrQDcDok18fiwMBwCzbp8zjmaxLLYzhJF1TIaPP2gEXSMaPN9KGlmWRYSqn
 DScoBuppdtCYx6jOKpItZ4ux2V+V84US9BNA8kLRz7AkwYQhV711BOin7fNlWnHLhyDDae5mbob
 pQh8OvEYiJFmcq/3gAFUKpNJ84UN18L+ojxxpdi6L3JkvImXly6lGIHjX9WsrjIHuAZwxUMzljj
 hxUwcLJ9wrBP8YjlBaJIxgy11D0kZUxzmhvUdz3waG21b8T+OP/Z5emtJ2bNbcBxu/NMCNUeuQK
 5p2XBs2FW+91/v6B9p8A6uHaEbS4EUiIV5yNXX/xVsOOiNxvZgAdvNKLD6huDKGQAsBDYcXCsn9
 jhyFXGV8X7qgW4cVKktz6fiAFNFM1rO2KfvjqafUCM0UvjxqxY8/yZ0lqfIoh3D8onkzXHg==
X-Google-Smtp-Source: AGHT+IH+gFc0twzGOAt6AiD5yYfRo1QdsB/dB9UpE6Nm7MIS7bxy9hfG+o+lszs0ol5XReAPbJ47MQ==
X-Received: by 2002:a2e:a008:0:b0:32b:9220:8020 with SMTP id
 38308e7fff4ca-33650f5098cmr15427721fa.34.1756074465609; 
 Sun, 24 Aug 2025 15:27:45 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e5a5b84sm13300821fa.36.2025.08.24.15.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 15:27:44 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 2/4] target/microblaze: div: Rename and reorder function
 args
Date: Mon, 25 Aug 2025 00:27:32 +0200
Message-ID: <20250824222734.4151956-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Rename and reorder function args to better match with spec
and pseudo code.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 target/microblaze/op_helper.c | 18 +++++++++---------
 target/microblaze/translate.c | 12 ++----------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 470526ee92..092977b3e1 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,9 +69,9 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
+static bool check_divz(CPUMBState *env, uint32_t divisor, uintptr_t pc)
 {
-    if (unlikely(b == 0)) {
+    if (unlikely(divisor == 0)) {
         env->msr |= MSR_DZ;
 
         if ((env->msr & MSR_EE) &&
@@ -80,27 +80,27 @@ static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
 
             env->esr = ESR_EC_DIVZERO;
             cs->exception_index = EXCP_HW_EXCP;
-            cpu_loop_exit_restore(cs, ra);
+            cpu_loop_exit_restore(cs, pc);
         }
         return false;
     }
     return true;
 }
 
-uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!check_divz(env, ra, GETPC())) {
         return 0;
     }
-    return (int32_t)a / (int32_t)b;
+    return (int32_t)rb / (int32_t)ra;
 }
 
-uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!check_divz(env, ra, GETPC())) {
         return 0;
     }
-    return a / b;
+    return rb / ra;
 }
 
 /* raise FPU exception.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5098a1db4d..2f5fd5c271 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -450,16 +450,8 @@ DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
 DO_TYPEA0_CFG(fsqrt, use_fpu >= 2, true, gen_fsqrt)
 
-/* Does not use ENV_WRAPPER3, because arguments are swapped as well. */
-static void gen_idiv(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divs(out, tcg_env, inb, ina);
-}
-
-static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divu(out, tcg_env, inb, ina);
-}
+ENV_WRAPPER3(gen_idiv, gen_helper_divs)
+ENV_WRAPPER3(gen_idivu, gen_helper_divu)
 
 DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
 DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
-- 
2.43.0


