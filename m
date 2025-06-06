Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4798C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBH-0004bv-FZ; Fri, 06 Jun 2025 12:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBF-0004bO-PW
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBE-00037y-9y
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so15384975e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228270; x=1749833070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xncKsFHoKiGF9zIgTrjiHDIYawtS38KWgNsBt6WFVxY=;
 b=HXf6s17RHu9+jhRY3KIGpTjtqQZPorQmREls4ISU2+kacWeBvToKBh8ZCc9TlGlO77
 p7zaENBYyxWVegHRzzsw1/e+8ohG6ZUp1m/flTXmS5e9EF6CO1szL44Zfhn0RFJl6Z3A
 qxVm4zkghxa3d+O9/FH/wK5bTxLHsKLRpDKdHGm3g6tasuTHgHat24v3nuG0JW8aLm54
 YIfGUR8nAF3f0+cGGfCgyZj+oUgxcF8nr23jUiBDEYWT5MRv2v4t+nvlrTS9Q6XVO7B8
 rKmHHMH0eH/gChimFlbzTceDRdCRyo8L/6LbViPF2LMz5rXAFyVyvNuXHNLQb4ua4UWA
 ze/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228270; x=1749833070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xncKsFHoKiGF9zIgTrjiHDIYawtS38KWgNsBt6WFVxY=;
 b=mkuRctxhiDIYqOmNV+SVF8q+ZsIYLfhNzMxPSuzU1zx4pTCpBDFNmYakvTTwhEqyzG
 WVnLJwMq4an7g0j/76mIHCvh01MhW9awJdf+UmXpugp9jO7k+Gxmj0nQIduYqvXPt0Hq
 ButKyrOEL6GZugVkCJuz/03+FftKdOZLxqXEGiSFyfQ3MFX1CW6OffABstmVyO8Onm7q
 5oZh+UucZxZPD6tVUfgBn93FiIa0RGGXiDoDpKIE55GOce2iQ00mvlHPT3ycLP89yLrk
 x5KWlSZ3i5ajgYirDLhpKc07sfVlTjroq62EDiaH1P+M/2zhnzw0etIEnCC+BRjs0jnh
 gmvg==
X-Gm-Message-State: AOJu0YwBbOOxcAQnaVR0h0yMNid03yRcysb7PJXQ8qF76U7gMNjbxCCQ
 hvh6bnjikAPbcuuVfz3gt6viEGPeOhRo2CVdMKL8Jg+j3EEHRvColSem+IdPbes7GFJo8qOCkMl
 vTHWbT8Nkww==
X-Gm-Gg: ASbGncsU5UQ8cksZymGD3ImcY69ZITsAUXEb3DsEVY+ruVgSvjoctUdj0SaUgRUvclm
 BPcyrzT0MpWKMMKL8vMCBIwAy5SuR+eetiXnDTqa8CWLi7U+cxk+j4vTjjWYL2zcBNfuWEMvZX9
 Y/2y0osZtmDZAy2kaYk1HRsfjTKDNBgxw/FkrRdlp9S9WcoD+khAWOVvC1dY15CtqKqBWwB/Dme
 GBPIXQ3VxjDfmWc7STRpgCMq36YlTivO9H9GgKS+nP5lFEcDa2jWykPPMV/iezyusmywATK0LKW
 lew4BhLz6yXrjDXn27c8olqwz7QF7eCEFSLor3nar7Swb60zkpWud6+oWXUypUsviD8Ait9A8Sp
 dQ3Hke5BlWgQEQZvmWwUc1K3JXnMbIOc9YwuJ8tj1Tz7kaDfN
X-Google-Smtp-Source: AGHT+IGyymJQ4AlQL4XA1khDXxyS75SWyWGAowwEWF3FEQ+c35QOAwfqzYg9VdbiUSs22lWuJuqtjA==
X-Received: by 2002:a05:600c:1c1b:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-4520139c741mr45039555e9.13.1749228270392; 
 Fri, 06 Jun 2025 09:44:30 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521370961csm29805915e9.22.2025.06.06.09.44.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:44:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Date: Fri,  6 Jun 2025 18:44:00 +0200
Message-ID: <20250606164418.98655-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a37..d55ce2c0f4e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2205,7 +2205,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
+    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.49.0


