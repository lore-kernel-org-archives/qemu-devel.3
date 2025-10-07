Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0870DCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68RH-0006Ow-1r; Tue, 07 Oct 2025 10:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qx-00063i-FU
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qe-0002Q2-50
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so57814125e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846352; x=1760451152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OVtMeI/FVDsMoa56+s5FLsgV/tUeeQKVrnHYRfnwDuw=;
 b=ktyWOyQgDFSv7fG7Whh1jQnTQBE4oBxXPN4tPLU3tGpMPmPbSrrMOHpF3Cfvn49SxS
 Ij29x1T38On1oJtwfyiA2ocWzSQ4UpqW3zDaLPG2JSVBVWKcdiedemjKtm66m15REO+M
 zRYhemD6SMwHl8GT5MBGuYRzkL8/c2qTBPaetbjUAt5qHwXtqCLy1/9+koO5zpkLAoEa
 UezfzeEfaaYJZ9ZE55VuRGScbihAcYsCiGUWDbhJlJyVVIDIAJUg33oJ+/mc8bdlpDca
 0Dl1WJi9lgluPzMbG/X7Iig1gunsV/oWxMY7QZ9j4hmvP3bgSMCawNBdgCXbR5bPpAFd
 /U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846352; x=1760451152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVtMeI/FVDsMoa56+s5FLsgV/tUeeQKVrnHYRfnwDuw=;
 b=THJrkctgKtWc8+xKQ/YCMN5dhFboxzWRfCp7p8FR1sqBbtlCF7ShFvwNBTDrC3+xrm
 7Tmu+mkfeo0hhu0BXoSndKcQ195gOmIhb+xhmLhwrV+glfy1gbU7Nj8WhPCAnfNCwf7e
 iJvdDLjFdamVRaIsbaGcC0u5iYcTO2keqGAIpKWh0HqbcguHwE6DAjryUSiAxNNWzuSJ
 sy1ntC4L9bVCZIrqysFW9c5sYcZQNRsu94gVdVz4u4i4EasoaL40T676Sk119+aKn0oQ
 vfC8IugvQSJdzEE0zvwvYuFgSeubFWPiqX4j+Ojgy/ikQZZUaGAV7pDokRTu//iId8vi
 yzeQ==
X-Gm-Message-State: AOJu0YwoDwwFeSAGvsIQ6xO6EQA2LPvlMyeIS5SExLh+hCIPMWCxTnf+
 MVGWv/VeBnY+RvhVl4nFjYsRcKzXlXMo3S8nqdF4h2byi2otuB7QCSAmwUJqksRksU1L8th0wb2
 LakG5
X-Gm-Gg: ASbGncvcQDmoXNxkFpbm8YZ/ZyO88W60JcVOZzMNiIIAfHdd0OHBgDXxiT5Q2EsnDto
 ZYGIjURl8evkkl5cn4MqZDEa/GWdzJm2NUR27c8kF2swVsheZvSlpfKmU2i7942h0Roig78bKSb
 54ln25t7OyZAa7/HH/ndhTo0nL9ZUEkFwLColHxA4J4nCXXOtSckO8xCK6LzIbLVipphBaaj2dF
 eRvLw8QHwTrTxOSW2FRn6RyBXwN0186Yuyx34FqB7sjtobNKIAP+gxcHlJZrShkfNY7DU8jf+he
 rwfeh0pA58fjhKhL5h2bjX8C5qMB7Ad2m4ghQtdPXXT5AjGzC8T77n5PlanOdb0B9VdwwFsEhnq
 O3j6WjldavqfMDQzAeegSh1/XhogSOg9OFrCb6pF1b+NWRbxuwUOmgmmX+oudH8mlxCM=
X-Google-Smtp-Source: AGHT+IGPChO3zUgyERnDqITOyfwu41DlyKmV0Gwkofj4cBJ1zn/P/vrMW/e6MdLks8SsU5HgtbPKow==
X-Received: by 2002:a05:600c:540c:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-46e71124468mr111984995e9.12.1759846352318; 
 Tue, 07 Oct 2025 07:12:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/62] target/arm: Enable FEAT_RME_GPC2 for -cpu max with x-rme
Date: Tue,  7 Oct 2025 15:11:22 +0100
Message-ID: <20251007141123.3239867-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6b04c96c8c4..1aa0a6e4c39 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -120,6 +120,7 @@ the following architecture extensions:
 - FEAT_RASv1p1 (RAS Extension v1.1)
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
+- FEAT_RME_GPC2 (RME Granule Protection Check 2 Extension)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 90b6c0ebb0e..8c617fe37b2 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -159,7 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value);
+    /* Enable FEAT_RME_GPC2 */
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,
-- 
2.43.0


