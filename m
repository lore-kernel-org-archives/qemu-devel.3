Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56073E748FC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 22:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAqZ-0005Yj-2G; Tue, 23 Dec 2025 17:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqX-0005Y2-OD
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:13 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqW-0007O3-9D
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:13 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so47920215ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 14:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766528830; x=1767133630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOVaD0jg0/GjW5dyxIzZiWG1PvtxfZzn9U04k4yMi6U=;
 b=elyKkhQBOtSZKRqAjl+fy1gqu5qGueVGgOIVE0uJElMztvozW3JBrulSJ31mPsf3rd
 /c40noEzvGJ2o43E0fCcFYwEqU8YxNEPrFNpoPM8uo0xx9TKOSSHU+rWSpjL4ikZixjj
 YToovd8KQ64DvIz5fx0siVrgGuyVimfoyvAPBnXZ7toFKRjy/6PvCxOWHERI4ohhCqor
 I/WCPqt7c3nrBMFmxHsu9md3Yl0V8jRLhFhvvukCW/FFPBE6+C2rnCsqMQAJFhqTAWg6
 xeWXPCGlPlpQcUH2B/KJ45gfi1YIXrReOW0Vjja+tOP3cdW9CQXPFDSA9mEFu+byAiv0
 HjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766528830; x=1767133630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xOVaD0jg0/GjW5dyxIzZiWG1PvtxfZzn9U04k4yMi6U=;
 b=nveLa0PjP24PjEFtCPTB0xYEyUU3By6ab9y+yxEeUNW942xtLDOE6yRN+sb20IY/2E
 qQiR4ue06pavBmaCxQWZU2NMMIaCYge9LCTliPlWAJN933fLquwWwXIuXz4fXALsU/7B
 JfzN84m8ASZmGpXzpmAHmkBiWt1iLMCJSIiSDzuz9XaZGra4yU6hDSBAYgnPKB1+GVCq
 85I/kcrtwrTk55X9pihXPwYf+tUMeKW6oW+TTo8rTAQTYmzqTjc4KGlSb27l6XTiDgJJ
 RVFU+Lf/QqIZG95SuPFURPawguBGt/UivukkiE2CdaK433nnrwW2c1oZdHEkuApksNzw
 MiZw==
X-Gm-Message-State: AOJu0YztOc2Ynl/OWn79M9+IId4H3jcHSxlAkVFu7aouD99aKKu1M4IO
 a950oZELPs87QUdB690DOKF/Wfr51bty0jzeH+kVFzqE4rt0wUDwmd2P4Vl/NbCkQNotWRVcwbf
 4mh5x
X-Gm-Gg: AY/fxX5eIgofrfqMQD3tyTMssGVQRXo9UjQz+mLbRs5yEBS0hsaGt8WgO9za/CcLB5e
 K5UjVzXYShihP9N88JqKTnEf3XfXwAg5ce9j1OeYeKJuQyP35knF2PLvPF3cR9fA1uFClbmoGvC
 l5pp4wZU0047gT417L21jUKO/uY3VrJc8IptcduXivTaNTgjDgh79LN0Atwxu5v5LFwJEvS0kwS
 5jqywCn23mWtvpqblJ8jXqC2BfqGsek9c5mdac5QD6OLne81pBbULxUBOSIQrOEYb83aZgty2iz
 b/CNuaJZPEaxGYSWefKqO2ufUdRXvNOJ+ncIVibKY20NSNpppYH+lXtd+IbPmtV91Ek8b0HDU/6
 COCR3i5xM0MAGhvDCuU9aVjfwIJKWh0ZKViN77Sywlj/JWYnr8vhtHMPrOEZh5uAdENsxHsF9Px
 FWpIuLPTpAbIUfaYX7
X-Google-Smtp-Source: AGHT+IExL8BskEM26aQ8zwIbFwIP4O2H971Oyx6pAs3XvZjPwjLfwQsIp4M5kujgSNzVIVbsOMmvKA==
X-Received: by 2002:a05:7022:eac5:b0:11c:b3ae:c9f1 with SMTP id
 a92af1059eb24-121721ab82fmr17761991c88.1.1766528830024; 
 Tue, 23 Dec 2025 14:27:10 -0800 (PST)
Received: from gromero0.. ([179.93.129.179]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217243bbe3sm62803123c88.0.2025.12.23.14.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 14:27:09 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 2/4] target/i386: Add a _MAX sentinel to X86ASIdx enum
Date: Tue, 23 Dec 2025 19:26:47 -0300
Message-Id: <20251223222649.187935-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223222649.187935-1-gustavo.romero@linaro.org>
References: <20251223222649.187935-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
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

Add a sentinel to the X86ASIdx enum so it can be used when the total
number of address spaces is required.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/i386/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1..ba0c4fa548 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2600,6 +2600,8 @@ void cpu_sync_avx_hflag(CPUX86State *env);
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
     X86ASIdx_SMM = 1,
+    X86ASIdx_MAX = X86ASIdx_SMM
+#define X86ASIdx_COUNT (X86ASIdx_MAX + 1)
 } X86ASIdx;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


