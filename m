Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75938CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OK-0000Es-5j; Thu, 07 May 2026 19:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OG-0000Ah-3M
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:24 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OE-0000zs-Dc
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:23 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dd73b7c757so781539a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197461; x=1778802261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=LGG1CIIotYGCSUPqPvZ4LrIIUj8K9UQX1X0KIFRGkUItPsFTgYbQL0JW3b6TlUbHXr
 yc++/8CCbkBgppsD7uBLSoieXrGrAIUquGyCXpD3CBBa1P/xaeHOBMKhhIjXFlWDr/R0
 s4e+FoD24LDnh3ILk/8sO4yd0X0vvDY997OR2LanntbEIKfEJAEZGuR1fbM6axVDLSjh
 l3KRJGXJkpdn24mUw7LNJSb2aY2qqjiygV7K7tEN2Cc+0LzylMHdPwn1niT/Zxy1gTdD
 YUvKmV46nfimPyOy7PEoAxGdNLLHZgY9r4mGx/0vnvbKmoV7XS7H8bl6HpZp69oqftkY
 Bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197461; x=1778802261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=ax+bFj+vUqLhkXZFQC/trAc5AKPTs4PL3QVjK6q2VDFB8PXWHRL5F9bFhI9SyJQ2gV
 UqmyulNB6nF0O+sh2xN7fbkLxBRklOwVvEepqVD0ELjZSbEzq4EGnPZ8uaQz2LFcj/NR
 IA2kpQFaF/5x1COUhgJL1q+Fphf6EfFCZOWsx3DY3Yik8h8jF+BAp5fKBZpdZP72MfO7
 F5oXCmz4JB6Cskuw5alv42Znj5zi43rJ0+oJTjAm77wWK4fJ4wvu7Pjc3ZmZatb07von
 qeJTZF0p4zAnZqo0Ye4q5XFNfPedVEXAtxFAU8DhyWsEUrOgE2QqiFOWO9ppVD0c503T
 M06w==
X-Gm-Message-State: AOJu0YyN7XC5WbuoR1xr8LRF616tiCLVBNkagUbG2lScW6skuErY8QHx
 uL4RxFtBdIQcn908unZWho0qU4PsJQxHFe+lbrVLCqnASxC4Z52lcTc66cntxpOn26fd/ufPnSe
 aUDFz
X-Gm-Gg: AeBDies3ciTJR+XlYnRFCHCoBaZF4ukoDSf5m6J0DYXL+aUihg1iwo8Smde5cYbC57k
 ZvU/YMBt2IFkQj/01N75BKDfopj/hIUnsQAHIqVDtRz0X8FNlyzBR0Iv0Wxf2csetm9Ym9yi2Te
 sCDyMBdXAuVjd9bCNgQXb3hPoNKwOe8pNNd8kZ2bWaJzeWcwi3VHtOYZBvao754E4ze2uu/znjN
 8qWGOi/0tHgk7vmDbcRnorMCYgM8tovQqwsGrjJnO8uEWA5Zu0pyBdle0TXYOWCh8PkhvWwP9gK
 p0LVxOC5IbtMGKllGomrlKTCcSmIcs9jI9+6oqkS1OV9SeHdGMiUL5dgXzuMpu/DxurP/yGP04H
 qjRSZaEQtMAw+dWIb3Z5EpgZXCdFEUslCsgN6rIXyESgw5hPUvtvdSYOEdd+7gOKJH51CuMB9Pd
 /7lc5Kvn2oZV6o5eY1JZluJo3S8VKjxGlVvUZD5vKTkOdQTGA3v+4Ob806
X-Received: by 2002:a05:6830:3142:b0:7dc:3d7e:40c2 with SMTP id
 46e09a7af769-7e1df23c9bemr6443314a34.27.1778197460624; 
 Thu, 07 May 2026 16:44:20 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 05/60] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Thu,  7 May 2026 18:43:18 -0500
Message-ID: <20260507234413.643512-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..ff0c2b1c47 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1266,6 +1266,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..da5f7efce2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
-- 
2.43.0


