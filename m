Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB60E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRl-000099-Gi; Wed, 11 Dec 2024 11:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRk-00008J-C2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:20 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRi-0007cp-JX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:20 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862d161947so3392912f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934017; x=1734538817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JXAkJPzlbPpI9TBbDQ7RCzmNVKijs33Nwl+I0eteC5M=;
 b=J15HBVqoVcsmeNGpl3DNGBN7kScvO2OULEdtZrIVha9qozyI9NsdsaqlFsD3Te7hBm
 nZ0qNO3HrwM0j000sP7b1QLBge8SwpFxutQ6SiBe6YSSDZnH/YdgF4HAnEsu/cPb5kBi
 droMa47gkK1pxGNLtn4MVcn601kKDdJCrybXo8lpAngu/+n5dIe8Kl9/tHMym4kiAeY4
 XT+uJMBraOTVjRRNEwCq27l++GhGrrru9EEpQyzPWwSUoFQyC1/Aoyr67VPGm+sEp13X
 yB/KJ2U4p68373smVnG5OMx7YBjnTADNRJkB1XYiQU7tWGZc9boGFf7KaAVUF15G30vH
 k7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934017; x=1734538817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXAkJPzlbPpI9TBbDQ7RCzmNVKijs33Nwl+I0eteC5M=;
 b=gBd6GBZ1ynJ9ZZhbJvMhWyyNOO+sWjvsvrqT7cleBzCvMw1xZWesZs6s0FINFLtMV+
 I+nObUbDKL0laKMJLMsA71rLLHJ4yrgqSDRYdcYDuNmOg/jQ9LpJXbpILEbI2k99yasw
 shE2l0QNCLA1iE+a4t2zNN0BKfW158ot4F8oNkLVIZoosCgsJRcIzbDmT7q4vs8Agm8x
 TwEt8yPn2Jy8rPnjPQhnuq+p3PVcPPyh5EBb9Sl3LotgGMbkgOrECBtd52Ao5s6TmbFN
 8q2O6nxHiDcjtsA5rtc2yxUTrImP/VFC6luOF1ORePat9zG2i+K4Ki6Bhlvrue3y+Yom
 1Uiw==
X-Gm-Message-State: AOJu0YywDZ+NBiNJlWF5dfhQEaJ6N4wZlLx2O/UIj1ZjGizr7yjmjqt3
 e/Oa5fHGCRtfV6ja7tB7pohsk9DrPiUIUbJcSb4V9gbQadfql4E01zWeJmj9pcZRnTub21MU5yr
 I
X-Gm-Gg: ASbGncuOPHHsIgf2UU1/UDRfwk1DbcGDrrZDgWGIDgFwVRGtNeZa1OAtCP1XVWHzerI
 ++AvpXtoY+xTXPz91lP7uM96ixm3zwfy/N46pqDAsCrT5JuaHfwBrWS2a/1BfXe2hJ94T+gfpqO
 PDbsI0wsMLETUFpf2r6Dg1777wttfwZP9dCKbOMhXaVR3A5b0OnQ9yDdRS6IvPDk+GHoAzz/BjE
 LsgvBnaFkyDj10WrRlELnf/tgvhdGjAjPglPriTlw/HKNlHZo94ceTSBRT2
X-Google-Smtp-Source: AGHT+IE1ick7m4mMya0WtwTJ0c/ZxZ3PSSt2qNlagb89RN7ntcbgIvxiAwKt7jcl0KdQSh86XKXfXg==
X-Received: by 2002:a05:6000:71e:b0:385:f631:612 with SMTP id
 ffacd0b85a97d-3878768e1eamr191041f8f.17.1733934017038; 
 Wed, 11 Dec 2024 08:20:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/72] fpu: Check for default_nan_mode before calling
 pickNaNMulAdd
Date: Wed, 11 Dec 2024 16:18:59 +0000
Message-Id: <20241211162004.2795499-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

If the target sets default_nan_mode then we're always going to return
the default NaN, and pickNaNMulAdd() no longer has any side effects.
For consistency with pickNaN(), check for default_nan_mode before
calling pickNaNMulAdd().

When we convert pickNaNMulAdd() to allow runtime selection of the NaN
propagation rule, this means we won't have to make the targets which
use default_nan_mode also set a propagation rule.

Since RiscV always uses default_nan_mode, this allows us to remove
its ifdef case from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-3-peter.maydell@linaro.org
---
 fpu/softfloat-parts.c.inc      | 8 ++++++--
 fpu/softfloat-specialize.c.inc | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d63cd957a19..aac1f9cd28c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -77,9 +77,13 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
 
-    which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+    if (s->default_nan_mode) {
+        which = 3;
+    } else {
+        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+    }
 
-    if (s->default_nan_mode || which == 3) {
+    if (which == 3) {
         parts_default_nan(a, s);
         return a;
     }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c557c41b2af..81a67eb67b5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,6 +475,13 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
+    /*
+     * We guarantee not to require the target to tell us how to
+     * pick a NaN if we're always returning the default NaN.
+     * But if we're not in default-NaN mode then the target must
+     * specify.
+     */
+    assert(!status->default_nan_mode);
 #if defined(TARGET_ARM)
     /* For ARM, the (inf,zero,qnan) case sets InvalidOp and returns
      * the default NaN
@@ -578,8 +585,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     } else {
         return 1;
     }
-#elif defined(TARGET_RISCV)
-    return 3; /* default NaN */
 #elif defined(TARGET_S390X)
     if (infzero) {
         return 3;
-- 
2.34.1


