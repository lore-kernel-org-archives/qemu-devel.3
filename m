Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A325F3C99E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuZx-0007yY-45; Tue, 24 Feb 2026 10:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuZn-0007rE-7W
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:43:56 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuZl-0006IR-1s
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:43:54 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-658b6757f7fso119566a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771947830; x=1772552630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLxuXw2XnWGwhF/mhX3epGfGgtQaomurSwQWIXwnoKY=;
 b=vE17HoZ8lvYb0tU2g5N8mBoBqfHJ+DqmXNjuPGtc5jW6WL+H/iwqAFdNL4d8/kSvz4
 HLVwT97b64CDm9E36BdRQEAoOlBe7wD3sgNWpuas2rihIXubURSHt/F9iKSWckCbFnZR
 DvOP68kXXaK0/vm+3lXquwatAyRA0XavS8RDX0DibX9Pb5b25eZzPTTgps/Kk0on04JZ
 Ebu635vBAvQDUTeFJMIdtgMLRLy9LXSzyt20g72VOyQPHsqcNERP0qTQeWylEJOcFrG+
 oW6o/iYcyqxO+2sY+yQhknst8xp3KWaSfHGTAMjuwmZNkjYCTUNq+UQkVTkMmHm63S3h
 XgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947830; x=1772552630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLxuXw2XnWGwhF/mhX3epGfGgtQaomurSwQWIXwnoKY=;
 b=QeZKqkLlj7UiunI4sXPTt2rcPGlr7qlH8TGRDtk79xUcijhiqDXl1wSAF30V+7ENcy
 9JCP7fJnDitDzL08+UCWeNL7SQ8wQ1G1bhf5R17XfciA71vFR2QxQ+pmCA+Li3wfgwy3
 7ro1/AOLKOONY8eMco87mXxX6Mp6Jcp8hx1qrHQob1mMD2n2ZQW8alijGgjuW1yshkkI
 NLeNEGb65GhHzUImG5upsDHf1AA9WJzNQs00mPOXV34xdk3H7m9uMPumFtD9freSBUQQ
 rh1wowEzuGTLnGGQts05Csq2ef2OTGqe/F6Vk59++E26LHccv8vwa07gocXkNRrkQIuZ
 ewGA==
X-Gm-Message-State: AOJu0YyYKTFA9xzBL0KOFRiiSd1Lp7WZ8ot46JyWfW8KYqqqyRyV6ytW
 xzkonWGOugRvwseZgNd3oldrEESAbSqj9R559SKt1HKo/ucI7dJCLyGj8wPj2TQ2cUc=
X-Gm-Gg: ATEYQzz7mZ/Fh7WSwrAAw9i1zuJRGQZfq/2t0CGoEgdQLKRlt96+lCLRNBoftt1tQKM
 Gm5LAvqV6JT7iviyNMtliR4vokEx9QZRk5ZVLO7l3kaTl5Hg65gtNJ6jiFsPp/cf/t1I91R9YRZ
 mvENUz8mn4PMPbzZLgxsS61lkOqFCCc9LaMB9uVmRUSKdcxTg36zCokI8jCbORAeCMFvJbTWGQ5
 vL0es+rekj49ENPK+7LYD0b0Mo1sL660L5eWbC0Dj5pRhOCNhm9AFx9AEYGQX7J5YpkWyye44Xp
 846fSANkDAYi4iK26CCqtmp2CMstxs8u0HC7dHvv6BPMAzOory1vkc59ew683KCxuDWqdCKqPxu
 rjA/8yBc+fTN/8YXtw04xrttQhsDScf/mAoo6Ab9RtkQHm3x0H9Z7pM/38P0mh7p50OVNpWlxZw
 5AI34HjTiu3dg4XITPNvftARE=
X-Received: by 2002:aa7:d5c2:0:b0:65a:23e6:ae60 with SMTP id
 4fb4d7f45d1cf-65f7ba1a129mr180961a12.12.1771947829539; 
 Tue, 24 Feb 2026 07:43:49 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eaba2db5csm3657446a12.24.2026.02.24.07.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:43:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 624525F8BC;
 Tue, 24 Feb 2026 15:43:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] target/arm: use FIELD_DP32 instead of open-coding syn_wfx
Date: Tue, 24 Feb 2026 15:43:44 +0000
Message-ID: <20260224154347.344219-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224154347.344219-1-alex.bennee@linaro.org>
References: <20260224154347.344219-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

We can use the registerfields API to safely set the individual fields
and avoid open coding magic numbers. The EC and IL fields are still
driven by defines but we could convert them later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bff61f052cc..86a2d5ea9d0 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -26,6 +26,7 @@
 #define TARGET_ARM_SYNDROME_H
 
 #include "qemu/bitops.h"
+#include "hw/core/registerfields.h"
 
 /* Valid Syndrome Register EC field values */
 enum arm_exception_class {
@@ -352,11 +353,24 @@ static inline uint32_t syn_breakpoint(int same_el)
         | ARM_EL_IL | 0x22;
 }
 
+FIELD(WFX_ISS, TI, 0, 2)
+FIELD(WFX_ISS, RV, 14, 1)
+FIELD(WFX_ISS, RN, 15, 5)
+FIELD(WFX_ISS, COND, 20, 4)
+FIELD(WFX_ISS, CV, 24, 1)
+
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
-    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
-           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
-           (cv << 24) | (cond << 20) | ti;
+    uint32_t res = (EC_WFX_TRAP << ARM_EL_EC_SHIFT);
+
+    res = FIELD_DP32(res, WFX_ISS, CV, cv);
+    res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, TI, ti);
+
+    if (!is_16bit) {
+        res |= ARM_EL_IL;
+    }
+    return res;
 }
 
 static inline uint32_t syn_illegalstate(void)
-- 
2.47.3


