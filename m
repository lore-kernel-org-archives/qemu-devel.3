Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4173BCFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewX-0006fw-H8; Tue, 15 Oct 2024 06:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewS-0006cR-Fl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewQ-0005vf-DB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43055b43604so50119785e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988693; x=1729593493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uMQQ7fdyXd07jMQ0rVrq7jETk7cjRhNibU6XZ/lFh88=;
 b=PGMCd8GXUKSRl5AqD8c3+g+UnmEqSNzq6MDTqCmTSTipsgtKx6k5pbXifQ+tO2d+y5
 v+BO2SNwngBqsH84URDZ9mFg1HWYVlcxNgMaWj+v6gFDkY+TBREohzkL5xe1S4hlnk2g
 LxB3FIbxxU0FYu+3r4WgJy5GTLnX68peS0/Dqb/n3tDD/82AHp03x9AKLSkmF9OpcLex
 JpbzChPmJsovlQ+dtkGCEuaMc+uU/+/Majk/9hKNL0HWnHPc/fk5KsKwnA8xrTIeagnz
 5KnbYXRQOT4xa4u4zSqHqci+DWczhlwIaUyQffKyxuEK+x9hUS0Y5k+WgDO9o3tqfEVg
 Abpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988693; x=1729593493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMQQ7fdyXd07jMQ0rVrq7jETk7cjRhNibU6XZ/lFh88=;
 b=e4lBxfQ3tznX70giO+OHZk8SlnXBhgUsI6Oprn8QB0Ga1DZLVqp56GUG3dBfNKtB57
 +F/yaiAv+8CbSSUlO6TSn8KDh1zXWX9p1xu2Rwv+klf7FAPLET263d7zV8KgqMrEAxRM
 aiIhL1y24Iq8Di1NEiGGYeB9CARkKAca0uabH0dnA67svIkUhrMMAKAuC0AHe5h4cbzY
 MhUmUYxym6xes/1vuE9l0Nl4zgfWUeRL1DR7OspoRNquyfDGg4Hal5pN2PTcgwnLfLo2
 I/yjCUnCqFXCUQCxVw2GCRyHspYflxcR77HLtnRmhfecF44AL1HHeJbGf7gHuehpIZvp
 /K3Q==
X-Gm-Message-State: AOJu0YxFfGQVXm5nJOOm/52XN4mbtVSI8DiRPk4hh7RGqxMwA4wmYKnD
 kyc4P/bCzfaYC07j5SXGeoiYLYJLJg5aH8lNu2uvKpzHN3RGDIG9kyiXti20n53K2luN3hBFEXW
 N
X-Google-Smtp-Source: AGHT+IH/t4pjRBLvgpjtys5YCCNmPZEUd4N+E1omAikdRTF6o0Dq3HazMun3CU6aps+swMMUbx8PXg==
X-Received: by 2002:a5d:6591:0:b0:37c:cdb6:6a9e with SMTP id
 ffacd0b85a97d-37d5518e759mr9495410f8f.9.1728988692609; 
 Tue, 15 Oct 2024 03:38:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/28] hw/intc/arm_gicv3_cpuif: Add cast to match the
 documentation
Date: Tue, 15 Oct 2024 11:37:46 +0100
Message-Id: <20241015103808.133024-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Alexandra Diupina <adiupina@astralinux.ru>

The result of 1 << regbit with regbit==31 has a 1 in the 32nd bit.
When cast to uint64_t (for further bitwise OR), the 32 most
significant bits will be filled with 1s. However, the documentation
states that the upper 32 bits of ICH_AP[0/1]R<n>_EL2 are reserved.

Add an explicit cast to match the documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: c3f21b065a ("hw/intc/arm_gicv3_cpuif: Support vLPIs")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 89359db7004..ea1d1b34551 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -793,7 +793,7 @@ static void icv_activate_vlpi(GICv3CPUState *cs)
     int regno = aprbit / 32;
     int regbit = aprbit % 32;
 
-    cs->ich_apr[cs->hppvlpi.grp][regno] |= (1 << regbit);
+    cs->ich_apr[cs->hppvlpi.grp][regno] |= (1U << regbit);
     gicv3_redist_vlpi_pending(cs, cs->hppvlpi.irq, 0);
 }
 
-- 
2.34.1


