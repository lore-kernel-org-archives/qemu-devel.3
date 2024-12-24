Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025BE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDg-0007VC-HN; Tue, 24 Dec 2024 15:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDV-0006wf-P7
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:21 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDU-0002yS-0R
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166022c5caso50557955ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070959; x=1735675759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VUIKMuGpZcO333SHRrlgYIo9hY7EVMRSpYe/wTFZLaI=;
 b=xPuf381Psyw8zye033aHwe0G8pGlidd+1CYnlUfFeKJ5v9dCbcndCR56zGjhR2/Sn5
 TZMO5P+0K6Dos+vvCq2NW2KeBMNB0MBUS+lcZ414T7vV9chvxicAVpSNbEAp3v+uJfzX
 Hfo+sJAGTP/ETrH580EepUdXH12dhqXC2//BfOGeVDayCYGd9m4xnrLCjXeISZfnqSvk
 cUQFUMTBCC35yklc0I8Q6gDjk4hxic+vTts4OqiUAUpxVl2Vujq7IgSZTl+CLvvOHkY9
 ydEGDtmTmTBIN4uMi1g2k5YTMp8o+/pGgdtyNzWgBXdVo/jVRzHwZupUWf3FNZpoUywN
 XsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070959; x=1735675759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUIKMuGpZcO333SHRrlgYIo9hY7EVMRSpYe/wTFZLaI=;
 b=d7ME0vTje7w9X24q0T9Pjlub21Z0Z2Xlsg4NY3IpLIDYLFVOgeYeM6IrHBgY3ZyrAU
 cMFgzMSjMS7pDbbsVp9N96gpfP8G2X4xLL6OvVK2aiK7gU2i0oYnGQiDLHMLBkqIsxKs
 PUur/npfan17Iy46SYfdV40DsXLR/hWf6IdKimOtFUrKp8jCR2nDENGdejcRJdLHlIDy
 fxwhhVEWPAL1NiUdYmZUjk6K2tUdn7ioXhiZBjDTJivTUIq1MK00IHCkIRin2rhqZFDF
 oKmuE414Plu7pK8s0jLLntV42fImewczcWKCSNfVplwWPkLYfsKetvGSKOSqtH0j0tLf
 ryCA==
X-Gm-Message-State: AOJu0YxVMWHk98NH8pCZi6kMZQWHSU4PIf1dEZ35iL2B9jBEPR/CVukT
 uBlfB2J5UnPaK9jS0QeI5YveQe3hTSMiLLfeCEK2cuaVoz0UI67IUNqTzSKrMIQK94Wp4dyqo7P
 Rctk=
X-Gm-Gg: ASbGncsjSRaUmmf7W4NvIAxXBThw2xxtYQ51trvFq+r7Rg+pNQ9dyKuMM9tM9spSg2D
 IXT1W7UAARoXqveSRUxCOdMGAHDenB591ZwY4OPjIU1VsYPy54Sttian1DOzcoZHFBXjQNmcr+a
 LbYyzeQ0D6/mz+1PqqaGsIkPzi9mFokkQt50/dX4/l9XYif/5U5VK56UgunNdBa58y1txMB4c+G
 iuLqE810Aoq4OHoTaSYdVd9ayoXhs+GboKWRL1olZyrQdcTKaNJxz44X7cB25lGiN78kn9NjHnM
 cf8Y6P2k2/kv9bAcnkCJiCHT/g==
X-Google-Smtp-Source: AGHT+IHosgTQiG47smae7drmSIgIpOP8jmI73YBiq/FH0psrJHepFqx9R7C5KTaQsZNz/9yarPl4FQ==
X-Received: by 2002:a05:6a00:918a:b0:725:322a:922c with SMTP id
 d2e1a72fcca58-72abdd20f53mr24150743b3a.3.1735070958732; 
 Tue, 24 Dec 2024 12:09:18 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/72] softfloat: Add float_round_nearest_even_max
Date: Tue, 24 Dec 2024 12:05:08 -0800
Message-ID: <20241224200521.310066-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

This rounding mode is used by Hexagon.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h | 2 ++
 fpu/softfloat-parts.c.inc     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 79ca44dcc3..9d37cdfaa8 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -140,6 +140,8 @@ typedef enum __attribute__((__packed__)) {
     float_round_to_odd       = 5,
     /* Not an IEEE rounding mode: round to closest odd, overflow to inf */
     float_round_to_odd_inf   = 6,
+    /* Not an IEEE rounding mode: round to nearest even, overflow to max */
+    float_round_nearest_even_max = 7,
 } FloatRoundMode;
 
 /*
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a724f317c5..37d046cfe9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -241,6 +241,9 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     int exp, flags = 0;
 
     switch (s->float_rounding_mode) {
+    case float_round_nearest_even_max:
+        overflow_norm = true;
+        /* fall through */
     case float_round_nearest_even:
         if (N > 64 && frac_lsb == 0) {
             inc = ((p->frac_hi & 1) || (p->frac_lo & round_mask) != frac_lsbm1
-- 
2.43.0


