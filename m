Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE23CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmo-00014w-KO; Tue, 26 May 2026 10:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmk-0000wW-FY
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmi-0001OK-Vd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso8553011f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805771; x=1780410571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N55g6uOUkcXbuwCj3DQHO8MRkbx5OGQICT/gKIBW97Q=;
 b=HZ3J5/wN39debsgXgKlv8pH08iiusAxSOrHVKUOChBIhVeGza/SiR/48FLIdF0PILn
 hK95ySoXRq/co+UG9gkXHsIHZxq/tjsJd2jVMZ5KmU56+qO6biKQSknRi6GfiDierUlD
 oMz2feIqUwCI60UHK7Y4pUXpOpduo7RLWhFjjctrqWlLgeATcgJkPWopm0+HA2O5zqg+
 NruwX4lQ66z864h1cSWt5OFuObT/wVmUJS96i1ddPJ9LRvG5aaooBI/TCQMj+ZAipg16
 3scuMqFHTXfJ3RtAOT7X/zLwFcv5QRFmhnaf3b7w3lxlvWGYUez6tYGI8+haBnHblzjo
 BABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805771; x=1780410571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N55g6uOUkcXbuwCj3DQHO8MRkbx5OGQICT/gKIBW97Q=;
 b=FINKLdHW/ikGOLFg4N16tsCR9+r4+dlnYrCIfr/Jp2bN3C72ttGFwvPh6gcEo+kONs
 RSt12HyH/bR0nMn9LZiuigOUsaaOzSHarKHVRBmlcbTCAV9U6SiMLR2VLaPwaidVcews
 9i/Kadv5ehkhH3OV1bjk3m0IR+t9oGPH0iJPxSMB6VebHPpJFvot36isOxOLhwMhVwro
 u22v45tPEGjvCCaHu2Lq1w0Lg8jAtfyEpzETtlxXiskqw8z9uGl4NTL13aXL5W9Tr2Hh
 XN4dD2nb57H0ZspZIVlnrBwFn96FX1ktKGUWFgu3rMwgyDFrjC2pqjieTXe0xiiLCqFF
 LgXA==
X-Gm-Message-State: AOJu0YxLaQ56r8KfBV4U/K2AuYea43UXwtp1ByiVB0sEt5ncMipEy4o6
 oeAEoC9GH5OopswXsUtnLt5CyDUEUY+Lvtbm7aUHKymdp7dKdk+sMVw7HDI0W02yQyCjmqQW4oM
 X7h2p
X-Gm-Gg: Acq92OEOmrv0BzsS//cHZzvejZ8FUFckO2TM3whcUP3dEJ2BTd0O3zb3IBb2pSmJE1u
 dDu7nH4yiWWJQQ9jQhLD2diiJ10UGcYs3uOAGUPLRwiL9CL3hFCwnHp8ewkG6qSNHmQfvarXyOg
 fTWo018P5Wh8UJjraNrNLgcbGnegKu/PXyxIjI8b3LieonO+WFXkQsKB0g6rU1zRDvdYyvVSO7U
 pPlYMG3PJFzF3ymMn9LIjlKsQ275oAVdhd+sh9Cu1oTOYKw/PMu2GEaBSRW2in8MkyXYQlsIDR5
 sN1q0Q4Mn6jZPPqTvOfOEHucAp0UpPQnxKDoJRH7065fHRWzOnJn0RCZzcLxT1nhcVLzE+ZIsAL
 /+ZKrgzfvLXI5S/lDdC1i/itQHkwhT6qipO6M2NECXBEdG3hG2uCgfUrh74zywBhZLCjgNaQGgr
 WpBx3xSsMLcXGb3T1VBXAsa+A/mMAwjIiQwn0jGt44VddxUfr9tJRiSmCbzB3vtDLa9JUslnY05
 sEe7RC7Si/1g5ieU9Y4bJXnmKygmm0=
X-Received: by 2002:a05:6000:2508:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-45eb36aa739mr32013498f8f.10.1779805771437; 
 Tue, 26 May 2026 07:29:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/54] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Tue, 26 May 2026 15:28:36 +0100
Message-ID: <20260526142850.2326589-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a549a50b7d..e9e261eb2a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1485,6 +1485,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


