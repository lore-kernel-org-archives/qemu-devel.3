Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9717CCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLV-0007NW-FB; Fri, 03 Oct 2025 13:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKE-0004xq-KF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:14 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJq-0007fz-OV
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-782023ca359so2524398b3a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511497; x=1760116297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vginp/BWCazHuQzqIb8BXHBvPZrCFhK+/22L3/T0m/s=;
 b=Ot72X9WKFKRpKJihoWqYIB4t0XUSxwdwmI2/70k8ZMCQqKeVh6UExexkKOoq8XvimG
 j7bSNKflBw2ku/hauvKwjJDOnY99EGqqMwQ6Ba0Gi+l5wZ6eABR74g9KB45d6gVtkD6I
 YHbg6KGyjCiUe8OW2pzgOVfTR5yN3lTQX07LVQnKXvCOhKeC1Ext7w5OBF6fKe6jtrIT
 Z8e/odh7aheO5hd6tVKEGPzyUdR1h3we6VPVPI061M0J1M56ndu+85gk8FmOxANImrU3
 UYBVkFtJ/YzvQZ2ujQw7yfjxb4+XbweROp8mjehMp+N38sSqlAN6r8/g2yymfEFst2yt
 ZjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511497; x=1760116297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vginp/BWCazHuQzqIb8BXHBvPZrCFhK+/22L3/T0m/s=;
 b=TirRfUPnRcWrI11FaXj8X88R1M/YHyqnVX/tu7onwT82hhXkvhKWVQpVGRP3OHmgFF
 jtdaff+A43nzj4vSNxICYWyM7tsutN43PcX6o8GC1RGA40IUsadbeYiW3UuQkjwbT88U
 6Gai7mUU8uX4eCg/u1nnc77uXdU24kB0ycgsqN/WEfWncuLjz9OxiKTaWLp3N0AAnyp5
 LUhJ7aqmBfodLvj8YSY+e4bYlghiu6wus1d1XW+rcQUHGqAvJjedAPGn9ZGTynGKU6qi
 lFXDp39FSCbKRZHwgQEMxY6FJXuinWqsFhwmuZTpuqHfOwcuvyPojqtex4COLY4gE7hk
 qTlw==
X-Gm-Message-State: AOJu0Yy4e9Mqlxpx+qt9oXkhhdnamhgTXmaLyBTXQ8QxAbetKE8wgX24
 xkdGWP/8b5H/qfeci1UsD/jn8Nw0FgX0YJ1nra1g7xIjL0AoF1zz6nw+zG0xzrhuQmhl/8O1Q8U
 S/RTJH4g=
X-Gm-Gg: ASbGncuIkNx+QiY1amw5S7L2Xdk2UY+ht1LLaKDB2R1SLFf3odryjW9l/Peth2H46+s
 COMIl3Tqwx4SSUIXoWoiAMznMhp+aPLwkoxmeQGHxl7QbevCmYCTv5MzCu6zDFGRksUgoxmy49f
 TwP4OPi9nT9pv9MuIMK5nRZEIhbNmR1zL25Dn6WDK7rFkEVbHRAGupeyOdsjZ4AVXlYX/t0JySW
 EHExPha05NYc10tb/DLNpP/e6lrQqN9LpcDvOSaKwTl/MaAXogCLa3J4EwM6jPNNIGEMjCtSiC9
 NLcc7SAR174Pl3y9Jct7yIuxQnPiN5vr8iWr+vaLJWlgqZ0MFJvkPWKVA82si9Aq4xFLSm0LlJS
 JeVzvhQ6j3Ce2ziz4Y1MxT1ifYaWvel0b1cltoVyiapOpLo/rndEVO0jg1/xp6HCb9/A=
X-Google-Smtp-Source: AGHT+IEG6FGpOW48MNKQkH8t5RSiOa0v/ft8aHrv4ADtS29Kl+R8gVamgSMhBpMcHiQbl0iWlrU5rw==
X-Received: by 2002:a05:6a00:8c4:b0:781:18dd:31de with SMTP id
 d2e1a72fcca58-78c98a77c8cmr4806661b3a.12.1759511496917; 
 Fri, 03 Oct 2025 10:11:36 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 40/73] target/arm: Split out access_nv1_with_nvx
Date: Fri,  3 Oct 2025 10:07:27 -0700
Message-ID: <20251003170800.997167-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/arm/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b84cd3fbbd..8ab1b3810e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3423,15 +3423,16 @@ static void mdcr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static CPAccessResult access_nv1_with_nvx(uint64_t hcr_nv)
+{
+    return hcr_nv == (HCR_NV | HCR_NV1) ? CP_ACCESS_TRAP_EL2 : CP_ACCESS_OK;
+}
+
 static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
     if (arm_current_el(env) == 1) {
-        uint64_t hcr_nv = arm_hcr_el2_nvx_eff(env);
-
-        if (hcr_nv == (HCR_NV | HCR_NV1)) {
-            return CP_ACCESS_TRAP_EL2;
-        }
+        return access_nv1_with_nvx(arm_hcr_el2_nvx_eff(env));
     }
     return CP_ACCESS_OK;
 }
-- 
2.43.0


