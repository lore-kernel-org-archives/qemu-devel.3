Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04964CA0EED
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 22:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqJBt-00063Z-CK; Sun, 24 Aug 2025 18:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBp-00062f-Ar
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:54 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBm-0006AP-Jy
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:53 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3364e945ce7so22806351fa.1
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756074467; x=1756679267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=db2OzonHRQ050MpGz+D2/nC+yn3PdcqKa98jxUWnj1E=;
 b=MEJy9GBMiAe9kGAGbI+oUtr1Xf8dOlZELFATUObqqkFoXsi8DR6g2vUyA5FxlDtKvA
 Cx0MjL4ajAmfARSstixxacIK0NnZrKpMYjdN8JDfBiw+8CoRfV5UgYWa/Hp5XJ89gRhN
 6ZKql5CzkECWsITMx/2yDIo+i21NpFmSqQDlRgI3+q5zNqVUvHRNwGgu993ks3FyuW9k
 Daf2G2oiA4iy9QZc571dK9F+4iRSXGhi9u2sFC2NPasYH/DOkxIHa0iOPpdwJ4FMYCMC
 sZEQZZc1nSMp0wfFBF0LaFwLAa3GI6GChMj3iLyfli6O0QitnfJ4gtlbK6MeoGGwXlt5
 T4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756074467; x=1756679267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=db2OzonHRQ050MpGz+D2/nC+yn3PdcqKa98jxUWnj1E=;
 b=ZFgnJEq6/qzgRfxhLEDYb8E/Yeo/wgdCmDUAdLh/xLHdwNbR19mchyTBgCY98BYcjk
 c1RztOBJ4Sdj90XbBrEcyw77Z0WCW+I07tZ6NSiismg1KkLV0BqqfaUteOk3g+fbgR2b
 g/AjqtzNGyi6IjOAQAeeHByTTclR4COMs9k0I5N7VffmIuLVITuBlO18k1scsmT1PIWE
 XCjQVMfx9sDsczcpHB2ZiouKWhbjYtqIqZ78Ceh3h+qOOg6VxOPRAUsDQ1OS3XmCFZSE
 f6TmBLXXkbs11T6TmlQOigeIoS/Uku6znMcsHAqfiMsV3tcXkc/7polkk6F5Olqw2ERC
 qtcQ==
X-Gm-Message-State: AOJu0Yy8Vfw58x2A42L3n6KCLb7bfUYDSpE+eOHTl+8aWRQfWghO0rEF
 jC2WH5VaVXuQ0xSicx1GXx1ZRrnE2KWNZ2ZlUcVf2InhiaBXAypPOXr0TUtakmf/
X-Gm-Gg: ASbGncsvqsfxnbDpux420IWMkLWidu2pWLJEb8M/Z1T0M9yB0m4iTQOq9aZTomsYpzF
 I+CZJqmBjCWPenTlCmTu1wFqAjhC6WgVF1z4qFBLqJjFpx2D+2/n0v60xuh8Qr7veO+kSSPf4yJ
 2XK46/9JIg8Ung7QEZPCq5GUX+RuUA3In85nQbKG2TPrfbHHwaHWoHd5Mp9THwK9/TKKQ6oKe0H
 CMtgOk4X+SEJQA5vvBFh96Br7/9Hqjm1AkGhcOI91xqpSOkphZWzcmI9qDf+YMS7P9P3F+/cL1X
 B96DXrWM1MjE1l4DGNcqrdjIhiwHt9guPxPP7VaLIYKKWhPEJc3S+xyNSIBxxMQ1Kwdv68Txyax
 uLXLIcOHyR9/Ar6gaghHFnkCBURzuDB7AQbu6Q6KsMSVjs24OMakOporM7H8QZVzRE34Gkg==
X-Google-Smtp-Source: AGHT+IEI6kzCCSBOqK3QRoMmkRx5ueh5FqPh/AziJ4xlK7bEbR3HUus4Dh9JjNnJhDSfX/rWU6A/Nw==
X-Received: by 2002:a05:651c:2124:b0:327:fec0:b85d with SMTP id
 38308e7fff4ca-33650f977d1mr25975711fa.21.1756074467111; 
 Sun, 24 Aug 2025 15:27:47 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e2650cdsm12141601fa.33.2025.08.24.15.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 15:27:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 3/4] target/microblaze: Break out raise_divzero()
Date: Mon, 25 Aug 2025 00:27:33 +0200
Message-ID: <20250824222734.4151956-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
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

Break out raise_divzero(). No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 target/microblaze/op_helper.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 092977b3e1..d9444aee29 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,27 +69,24 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t divisor, uintptr_t pc)
+/* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
+static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t pc)
 {
-    if (unlikely(divisor == 0)) {
-        env->msr |= MSR_DZ;
-
-        if ((env->msr & MSR_EE) &&
-            env_archcpu(env)->cfg.div_zero_exception) {
-            CPUState *cs = env_cpu(env);
-
-            env->esr = ESR_EC_DIVZERO;
-            cs->exception_index = EXCP_HW_EXCP;
-            cpu_loop_exit_restore(cs, pc);
-        }
-        return false;
+    env->msr |= MSR_DZ;
+
+    if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
+        CPUState *cs = env_cpu(env);
+
+        env->esr = esr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, pc);
     }
-    return true;
 }
 
 uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, ra, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
     return (int32_t)rb / (int32_t)ra;
@@ -97,7 +94,8 @@ uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
 
 uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, ra, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
     return rb / ra;
-- 
2.43.0


