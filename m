Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298CAC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ric8M-0008In-7r; Fri, 08 Mar 2024 10:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ric8K-0008I4-AA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:27:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ric84-0007O5-PU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:27:40 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e70d71756so913622f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1709911642; x=1710516442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8rWxjERfBQLukJUYhiMHoSnMrSfR3ecMY1UceHVB5qM=;
 b=jI5YeQC9iCuoipc0Tb1v9kdNT6o5QgKFWnbSeQHuJodWO77O2VUYNJvaF1fHocFz3M
 C74S707xFcEqoZzznD92BkSEZit84la8rq/sCW0DzwOHgPPxqSe6H9BXX5pIwZL1NjxM
 rBneUyRpCI7RUev5yU/Dw+PvwZHOv4WxQua4ZVTOkjAK97O3UCbWLh/yrq0LqGPEZwkl
 HNB841GRt66oMiCPAk1UBiWopllTvjHOZjww7v8b+3izPO05PAtw4zG/iyCWEXj87S1o
 FbYpTFHaxS6SZ/Abn/+r7A4jVyszAHOGgdRBxCi1n5nqxW1C/K6CK/DkPfBW/J7WmVGv
 tpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709911643; x=1710516443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rWxjERfBQLukJUYhiMHoSnMrSfR3ecMY1UceHVB5qM=;
 b=Xwh0haEcc3XwxFfSUBQaY2vPpx8eZ5Q1sjqMXTgK1BBIGT9LP30q/5m+FUBBdHcqBz
 Y9/pmABhpUEt0df7qVyqGFR2InO27IHbuJxtlbRh7rLH7hl8vJRCq95ircEyNmpT4Va4
 YQOUIkV2St0lUNV4PBxA+bQTQ6ZGEDtZ885wJ8wf4SqL5C2AsrQt+Ola02Eoa3d2DCF4
 3vR+WIvk6JCoCBf355l+Te63X2GLYOUyFMx8njIYsKStDx/VhDsm7acAVOTOXKwECpIS
 IBLXIzi8/uc1WI9MllxL2GyKXvY3NthOAT2WYXH0dE9HT0gUUJtPIKIMDg3MuqY5Yd9V
 478A==
X-Gm-Message-State: AOJu0Yx0vbD6SgbGgVaFMvH6pyEaliwLReI65nx1vCI84A9phXNRn02s
 3rqcdIkPq+P5xhzTTU2aI+16sDSBMmcu6TvM7JWohxrrmSHT25ruhzU654+BS1/QLwSawMPJLj8
 =
X-Google-Smtp-Source: AGHT+IFdY3vDP48IjBaB/KLCn979HZks9r6MlUI5dbKOlfRXiYu3u1G2DlLsZG3bmtWBwoBBLJDy9A==
X-Received: by 2002:adf:b19c:0:b0:33e:6ce4:feb8 with SMTP id
 q28-20020adfb19c000000b0033e6ce4feb8mr581136wra.12.1709911642640; 
 Fri, 08 Mar 2024 07:27:22 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033e2291fbc0sm19937686wrc.68.2024.03.08.07.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:27:22 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: konrad.frederic@yahoo.fr, philmd@linaro.org, peter.maydell@linaro.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] hw/intc/grlib_irqmp: abort realize when ncpus value is out of
 range
Date: Fri,  8 Mar 2024 16:27:19 +0100
Message-Id: <20240308152719.591232-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Even if the error is set, the build is not aborted when the ncpus value
is wrong, the return is missing.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/intc/grlib_irqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 144b121d48..c6c51a349c 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -356,6 +356,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "Invalid ncpus properties: "
                    "%u, must be 0 < ncpus =< %u.", irqmp->ncpus,
                    IRQMP_MAX_CPU);
+        return;
     }
 
     qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
-- 
2.25.1


