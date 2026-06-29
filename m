Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5102CC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgV-0007ov-7v; Mon, 29 Jun 2026 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfv-00071t-54
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAft-0007ZD-NK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso42249525e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734476; x=1783339276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F3Usoptu4/Ftkfff+NbElWmrL+NRp28tLW+NHEpvB9g=;
 b=w1M9jX9dYXPMp35fMD1hab/pt7u412617+1yUcvWKbGFP89x6KX6HCE/bcyo2uYsdX
 s+XxxCZAuO1x3ChFKJ/Z2Xw6HF87uZHvizDgv3vdMoJlul3hUHDsBV8C0m1upNDAVmTd
 0UNqUTG6ZEFMseHL3LvhY8JYgQAiZU7W1OcbQzJuFyRxSp0ddzddSl5DJU05JqbdW7E0
 23JIsPKIMGjXlHBqHCa/e/3agnqJayO+Rad/bQWTN3XgoiPJ0HKvi1VmfwbsNRHY3k6E
 YqDe3KXsHdskcUgA7QIq2gnYXHNR6UCLFDuvylCDWC9/Piu9+k7011YINKvVvw47FriG
 C0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734476; x=1783339276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F3Usoptu4/Ftkfff+NbElWmrL+NRp28tLW+NHEpvB9g=;
 b=EuSIDJ3myl5geHihR17/vlFKe2zqTobD7ElZm2JiX20iDln0Fyz1sZjKvyqG6LeHu0
 X7n9rrFWUzq95AtxyI5nct+8V4B+1GTWtLlb8oMHrybC4rUKgmSYNRljE82w42C9gPt4
 D3YuUQcqpWaO+b9N2HcyPA89RvdpOnOzdFh+477YsGPUGDGmh+tsKm0yzoPOKATyUuEP
 XSy1+SRl1tADRKaJUhZVzRU+v+ZzvWsKcQeCOrJDFFDtpr9Mrmrdqn9uDfORBwh00K1y
 nAQtCNhdj8XOxmjuaLAqLlcZqEj0JCLcMPLhGsPCfVCSQd7nn4XC4tasACuUh9mNQnPA
 +RIQ==
X-Gm-Message-State: AOJu0YzpSHyvYewaBOFLNnuyRDnl8jJQrFiCTlUwPAsvFXwGyGS2HHWc
 EDgNyNMQTI7aupkIaPIs2+hAoEUxqkuppR+4QbUAVx3vGin2OrhCogY+JhnhIRduxceVWdKi5r9
 /iP1Z
X-Gm-Gg: AfdE7cljxGsBbNWSu+NjpzJ46xM0GxYN5Q/SOJKW3BXnEe39+CoTUSgLJgWTRisAugV
 y+mMo62bN/tRAMpUUp9Bg/uXunxtT4hogvoPN98mbFpjHOhIfnLMtN7wdV5CtG5dwXpqHdG14mk
 eTKEkokkHaRSgzo/nHFFlN7+NGPWLTGZywWexRriDxjOW5tMoMdgEcfmC67egi2QWHqfvLMKEeA
 FjzJH5mR3YpE6+1oUng2B6kcRLH2v1papkHdiEBHPXExb9zzb3N2HdKPjcETOF8wgMu92mWJu2j
 mC9QGGpyDuPK2vbH0lkRBHJNks2KhhSKlwMp+evsyF3It/wODZGHK+JZGqxnYtVynGWi7uFAD6m
 tYj5S9dyXR+eCi4hHcR66yQ6ZAmM6PJhwuWHwFqlcH8kj/KnJ8kw+0VGYrzQu/jQJZ+fk2LTNJO
 d2CUrgxl+Hb06kfhDUexkPf8Q3mCvtFK7Qr+iGceSz9g0AFUrMBCyb+K3ftonlPazT+7uDt5yfj
 51mmpPPmbZOSTSjtkwn5g==
X-Received: by 2002:a05:600c:4e15:b0:493:b163:42e8 with SMTP id
 5b1f17b1804b1-493b1634364mr36443185e9.21.1782734476023; 
 Mon, 29 Jun 2026 05:01:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/54] target/arm: trigger timer recalc on SCR:ECVEN change
Date: Mon, 29 Jun 2026 13:00:18 +0100
Message-ID: <20260629120032.1645265-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Toggling the ECVEN state affects the offset calculated in
gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624124527.1018912-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71c0d3f4d3..4f3281feaf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -37,6 +37,9 @@
 #include "qemu/plugin.h"
 
 static void switch_mode(CPUARMState *env, int mode);
+#ifndef CONFIG_USER_ONLY
+static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
+#endif
 
 int compare_u64(const void *a, const void *b)
 {
@@ -821,6 +824,12 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     changed = env->cp15.scr_el3 ^ value;
     env->cp15.scr_el3 = value;
 
+#ifndef CONFIG_USER_ONLY
+    if (changed & SCR_ECVEN) {
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+    }
+#endif
+
     /*
      * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
      * we must invalidate all TLBs below EL3.
-- 
2.43.0


