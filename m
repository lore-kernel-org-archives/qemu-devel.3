Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F74EC01C4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvj-0001to-CJ; Mon, 23 Mar 2026 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvh-0001sl-QX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvg-00065m-DC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso38151265e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263279; x=1774868079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xX2yGsEAs7o2rPFSa1StWGZ6GI7Skmem7ShM/upVa4Y=;
 b=AiqRux5LoEi9MJlSsJ2Vs6q6jitQk7CV+jdUmEXAsWdJXp68hBEP/QC7uJKBHtUHSt
 9U5entoBI26NUfOooV9/Z4coKXgnBjCbbc2DxCp2T3Hav8qASQgLNnGRigCEdA9/uo2O
 twfrgK2eFjCRcZp3V0qBdOdVLKZOyfCZWooDIAl9HTec2Ls+4ZaMJXKefSk3gcvRDYzB
 j0h42s5xfrmanZS/XdIkxAIat2+v/qBWSO2nNdLv9Yg9MEtcdL8VviOB9E1ILergX+ME
 /4vN5GzX74Gd1FdcLQqPJXhHZJ2cEcobJlseJG4pUtB70byAR/DUg1zd0dXuyqUYiDKx
 ExBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263279; x=1774868079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xX2yGsEAs7o2rPFSa1StWGZ6GI7Skmem7ShM/upVa4Y=;
 b=d5xDXiTBEAyDkFm5ivBwvz92lBBdCet9nYVSICWNZCYd2R5Bkiz0d2NsDVMHbHOiaS
 duomZKc2Wf60CGzlMqMToG4aNJtLyb85Whu1iHpvy4S5AfBXjxiRE4ibvWSVwG4i3lVu
 drkf4qBVm4SDGFe0j1ReW29rVVm4cQpRNn7ZUCz49N4cBg2kSGwQpx6NIQsH4yv2yAPC
 fvdm6GbMQFng1xTpP2r8PvMNeYWZGcY4OXexUzyaPDx+uZaqXNwJZtmzPWumXgpPP7yW
 IpHK04K0vkWJlHdg0hbJSX0HxsKDcnyBGoWgdd87deIDIoRgN5SevBkCwUVQcViTnYhr
 vkqA==
X-Gm-Message-State: AOJu0YxkZrNj4S/mkGGkphWfxRRx5T+RQVRZNuKhNgHcneao07FDFQ+6
 royAhzRKlZ6Vz/E1AGeGbV5nUjF2nQT4OJJibY7nX813KN3xmjPC2UviOuRNciF13KHfWEpk3y3
 hBMkOTYE=
X-Gm-Gg: ATEYQzz01JrKMm8QkscHVw4v4c1c5qLOYxsis9fAvZDY1V0OH0gORVj5zhWiUGTN0SI
 K7+mfQr12+AuWZ6rOTPoNVHwkMj+UjwR1MR5vR5n4TsK40ycb94ec/gKEZPTlJ7Wcjy/EK/HdW7
 Gm7DOGGNNifEmpLkPym+Eq3SsP3+YP4nTYcK2B//fIlAT9uUflQzZ7YFUCbgtctCeS5N1fuguB8
 fl+evxyyMFG19Euvem5sgyqxMUfhaun2yxDxhYMOuMJv2VbCpNEi95r2NArnCeIZIya+7NxyP6H
 jmX6ifLTr9mLiCNZjt/ZgUyPNEE2pPXxa0xfJn7SRJZ5ZDKU8T9eK+J5oSZEEApVvPy0SQo/jsy
 sdbKztZf3uLc6Awk/QVPl6ju/dYphnmVE9aM+jZ93s2E47M2rqQ4v+XpKdBQ4Aq/IDCqr+MGR6n
 AfxRYAw2aUJkUVEAUbIoz2C5/yUBP7QYnGVcfdZwmqOm/pBdqGm76L3Rz29+/aKnX18ljLkd5ZV
 279H8wuT7flXqjmxKWhF8Cwh4k88jfYCqtlaBVkwA==
X-Received: by 2002:a05:600c:828d:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-486fedf8fcbmr172659835e9.9.1774263278749; 
 Mon, 23 Mar 2026 03:54:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] whpx: arm: fix ID_AA64MMFR3_EL1 host feature register
 index
Date: Mon, 23 Mar 2026 10:54:27 +0000
Message-ID: <20260323105429.4059580-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

IdAa64Mmfr3El1 was stored in idregs[ID_AA64MMFR2_EL1_IDX], overwriting
MMFR2 and leaving MMFR3 never set. Use ID_AA64MMFR3_EL1_IDX so the host
MMFR3 value is stored in the correct slot.

Fixes: f7fa2b88084 ("whpx: arm64: implement -cpu host")
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260314221529.47841-7-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8aa24f2adc..bbf0f6be96 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -684,7 +684,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { WHvArm64RegisterIdAa64Mmfr0El1, &ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
         { WHvArm64RegisterIdAa64Mmfr1El1, &ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
         { WHvArm64RegisterIdAa64Mmfr2El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
-        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
+        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR3_EL1_IDX] }
     };
 
     int i;
-- 
2.43.0


