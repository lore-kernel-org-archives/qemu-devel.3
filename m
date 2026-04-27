Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A1FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUh-0000W4-DL; Mon, 27 Apr 2026 08:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO9-0008FM-6Z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO6-0005li-BD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso111458725e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294112; x=1777898912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YDoQbWYjuWr+STze5DrZodJz/uNdiizqomxJ3dlpfIo=;
 b=EnmXoz+n0+qiKrAgQimh2QtejQkE2ROOSINF7uxEX8jYcT43CPh0u3zngtfCMc/Raj
 qSFvAn2Z0tWX76/9zQn0EXLsu7nB5ZoY9dMbfCo5O3T3XBKAxSZYRHhyFpNb3m5NDkz7
 qHcxYfKFkjM591tB9atbBEjW81QaHRocO+sUrX9wSpUsAH8Fgq+bB6yzAcAmaSYiJ9kF
 tvHlHhBPLOn3AYBORuQOWMg+49Q1c6mxkHdlpcpizyOJT67sAc1867HxGKE48gTa3ghY
 grBHHWVPHEPZvzlvyOEgjSFTdl6GbUG2dLWklJWYDJDo4/f1oHug6710Q4ilqRqAaHkl
 51Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294112; x=1777898912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YDoQbWYjuWr+STze5DrZodJz/uNdiizqomxJ3dlpfIo=;
 b=JXrILhLbTud8pqcVVx+uuLE+pOi4HyVX0pIlAOFSeC/bva9MObHpXvlJRN24XbAUfw
 NFc8E7Pvx/KPJp0fUJFHrhDJq//6r7ECv34/4Xl92mVaKwk8+6jBf9djCr2z8q1fRvxJ
 GpkF8h/deFPSNhNXVDXZGMCCvHw+9a6LUQjQhx92Sa85w/ipA3KCKDJuJlNLqFabTWKt
 CSWf1IZ3UVl6er2y0ILk8f6DiqXVyDocDqV146M6NsV3lHd4QpFFW+XtS5AfUXIp6z3O
 9efJb3drmnyr5QnZ0fG8QwDJjyihAzlAuZIxM5iJpynrBnt6P2IGwdsQJX7SVYtZhPqI
 rs2Q==
X-Gm-Message-State: AOJu0YzGuuiNRxQzFyYVI3pP+UEOAAez44PfsZWpkKELfKtUW3/7Tx4M
 ArGD88gy03yJepFttRy0urtcc3weft163WWYfxKywjO8uILJ/sYSZogi3KVDlfGCS9hCksledzE
 gjhTZ
X-Gm-Gg: AeBDiesqYGp4uq4YCMXD1qnazb2nGkSvgSCAaI1vxlEBroPQdUuwGPNBNOTVFErtnzv
 AsM+AD6NTpRqoeeIFAspdNLpF8/rU/0AolYv5SltrvzDdAlwo00x+kY08MHTfP9WnvYSSu7ooWn
 r+yXY4Zter3/bTkyAWMUo0JW8+LqvBohygC/a6kpI2QSVu7TftAuLsOtUMQv7eqqBPjTrwCqY3w
 lJyU45GaoYlBqxxxo/Rx/7KOddOYuOdrAVf8JojUFdDh//HWG+9WhNI+vXWPj3ZdjSAV+Eum70o
 a1laLfjw7GucS+H/EM/ZVC1KLFWa3SPTJJPqDLZpfbu0JgdvouJMp6aJde95JUveMsleKt+w3QF
 GH3Tml7LewJm9bK4PCFNs/xjN7a+2Ktrm3AcdYq6OFv5UuNmLZCZfkOj3mUyBVOKRBOTwQrq4xM
 8smvaYVTkQwXjGWKWZOxcWatmrDXakqls+rZMLGqlUp7sjFORVXRdg2cW/MUkwv3cjcvdwMUaEu
 v4tLNFK8qvTXnsqelzfmic7OUJaW2fBjJB87prKcg==
X-Received: by 2002:a05:600c:1f83:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-488fb787afemr598550145e9.24.1777294111697; 
 Mon, 27 Apr 2026 05:48:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/63] target/arm: use syndrome helpers to set SAME_EL EC bit
Date: Mon, 27 Apr 2026 13:47:31 +0100
Message-ID: <20260427124738.966578-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This removes the last use of ARM_EL_EC_SHIFT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-18-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h  | 1 -
 target/arm/tcg/debug.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 53137394e2..d4dfab8cd1 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -107,7 +107,6 @@ typedef enum {
 } GCSInstructionType;
 
 #define ARM_EL_EC_LENGTH 6
-#define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 5214e3c08a..07a52643e7 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
      * Similarly for watchpoint and breakpoint matches.
      */
     assert(debug_el >= cur_el);
-    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
+    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
     raise_exception(env, excp, syndrome, debug_el);
 }
 
-- 
2.43.0


