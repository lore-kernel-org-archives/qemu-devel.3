Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DA1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgJ-0007N5-EL; Mon, 29 Jun 2026 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfk-0006xS-Ed
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAff-0007QY-Sr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so1874647f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734460; x=1783339260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oRoVJlErjISZoAYlDzMkIDN1xz0mq2qqKsIVdJjMoI4=;
 b=c4+tellhhAjp608/yKAvTWCYQEyuCxuk8e7EP1QcwtS3fHagVfULVcZOp20sbh2wAr
 c3OuyovljWgBEWsYrL348XrhVTXlXruo8JaXnp7HdQM+zAQc1PUTPl/w8bWURSpPtRjT
 kU2YQOLIWPACkuNCW6NoUc/MaKz9lZa2OPI0mp6vaANNGjZFLcb6aICwkXzUQ5JBqyGS
 aktDhPQqhSlm2RR9RjA1ovFMq4sDHRQ7XMaZwpvw+QxLWkJtvHMzzfs5NBs979/vw52I
 jwJ74woE1es7nz2Yd8wGZffVk+NxltaA8xz85/R95domAeH0s99Fz9UiuUagQ9eVJzcY
 F8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734460; x=1783339260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oRoVJlErjISZoAYlDzMkIDN1xz0mq2qqKsIVdJjMoI4=;
 b=ZhPB08l4hNjsXYM9Ef/PVT0wF6W6xFcmP7uLKLemMd3iX5gs4JB+egCZmRF7h3OWT2
 Ov8QDY6WW4oQp31eqGe+Zt4kemUnPAZTP2Q9UNBjCQmCkwbyk5L+Eh+/COV/SJaxU1nQ
 Wu5WptKTawlzWaMuZ0aIPpEtbsJXY8Rp98i89q5jgkgBBJE/nQR+/kZu9Mfi2QpW8Y3u
 pdUO/VjB5piOxMZ1WplbFf9ijCaIinNKx2VApVJwhPiFdX2jgN+ItTq+IQMGTCQgsCIA
 9+cZqJSuh8iI0vcqKdQ/zLTfGEszFD5vVRECc0fVFRe3EDtqSWs63ZlrDwz36l/vsGnm
 fSGw==
X-Gm-Message-State: AOJu0Yx+rbBG+eYhLAsuLqClPzb95sq2fY9OkIqpRVPHnwTA7EM1TR+e
 EYrHULC8HFe0fyjWrFaMXlSSn+jTRAODhVNbEpVp/w0FiwNWR3BaNTDkI5AOzJ/1DhpQBypgw8b
 I12iW
X-Gm-Gg: AfdE7ck6ANqpmPVWAWwtLgIUYwHEoyz/7k52rBjQhZf+05fgy/qkXvdaWcWjwkshavT
 q+cZik+7ZJRAXvwom2T2hVmp7d7SCw4ejhVuBhkksnkHLffca4bRSw0utiBiyyvS2aLACKuikeK
 1N9ksJsYv7OyqM6l/4Bixdk+/iJQ2zikwo10WYGXxpRb0AvpVqT2Ag27s0blMGJxk8c752Psh2x
 wFLNQp0dntiWe0juofPFRj+Y3fZqiMPqmXH5Qg8WRCiy5CMih5OnyOPHO6kMr6F0fL8OzAI55mW
 7hdISy2PoZNDca+x+WhDUSE+qJSHlXt7xCSslMh9Udus+BQZnX0WaGpM+ALHPko7wONt2b4Wybn
 KTwKZBbQ7gqs29mQTJuyv85fl9yHcax8vuCNVEVqY87n/1e8LB385JIsZf+urJ8Cp4vgXY9GQ69
 y/yJaghzj8Z97M780scB+sXoxpBPgTPK88AojBX4v+0INnAImydjlDNoRF+OKKJuWQPu0B3OONg
 Ed1wa1/9w8xT1kbIeL7IQ==
X-Received: by 2002:adf:ef0d:0:b0:46d:19b6:8653 with SMTP id
 ffacd0b85a97d-475013289b2mr218495f8f.40.1782734460194; 
 Mon, 29 Jun 2026 05:01:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/54] target/arm/tcg/cpu64.c: Extra test for GPC3.
Date: Mon, 29 Jun 2026 13:00:03 +0100
Message-ID: <20260629120032.1645265-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260618-jmac-gpc3b-v3-1-353e546067e7@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 45213f71ab..2e4f22f193 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1159,6 +1159,11 @@ static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
 }
 
+static inline bool isar_feature_aa64_rme_gpc3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 3;
+}
+
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;
-- 
2.43.0


