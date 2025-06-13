Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B2FC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrwx-0008Rc-Lv; Thu, 12 Jun 2025 20:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FWtLaAcKCmIKOMLODIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--komlodi.bounces.google.com>)
 id 1uPrub-0005tQ-Oo
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:55 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FWtLaAcKCmIKOMLODIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--komlodi.bounces.google.com>)
 id 1uPruV-0000c6-J7
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:47 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-742c03c0272so1733348b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773078; x=1750377878; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3dMmftlsYq0W3pEEdzMB8bc0OSbplvg01s3pXlWG/po=;
 b=Tl8Kk/rnyoEYS8H/Xa8TqCUeJt5/LR6Y7NV5jI+ikkg1sQvYEeqz2O0q+UyziazF8X
 y+zEvLgS0K1GKi38EL3IavD5l4WxvG+JFyHB1G+z2081ldEeTTcJaTeVwBPhDoc3uebP
 HOjTt8mN9GosDglc8bETYmDUu3XSkiRxOKXKoZ3Urfu6J2alxKmTyyzZDVtS/unUpJVe
 9jm84K4igJZ4toZQ50msIMYwgC6HMukT7tX7pbDh8c24bIIrlwymdE2iswZeG0ruEupR
 fgtVQFEXK1fPMVNRcbrkDubIzmXDvuic7xKQcR52i2onX4R9b/XfVLLKYmzsE4ygOb+c
 it7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773078; x=1750377878;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dMmftlsYq0W3pEEdzMB8bc0OSbplvg01s3pXlWG/po=;
 b=Jyao/hie5YU9PqUCiHEYIaMsaGrbgd33bzKkWc2Xv/uz3eIhhIgMm71L4JQW1u+HTb
 Hj5h8jrZRF77VaeJA+iqkD3nxv2YmiyijLUnlAMFThWm0d5DhN+uYUeeN+SUav6jh++u
 AMEaoA7mMZRF6BXgX7FglOcJUnZ4JgBFyYS/nFMDmAJkINEbAjbs/6sruvghtprfOnob
 +b+w45191dZEJt0x3iFeQfvD6Hc0GcphNXxZ51BTJfK6Z8LcGgLdr2eF+V0L58Eq8Rhl
 tGCu5WXJPBNSWg4aknrPESDivqBddBHFwVcYYZAx/Ai0DeTr0PxWGCZtkUbVzGlYdfgA
 6WIg==
X-Gm-Message-State: AOJu0YwNqyswznLaZbkTdUty8Vf4LRltPjLhzmuyqlOheBkMYJwc1UkD
 qTVZoI9jNn72v7/YqeyLwGmbbc6A4L7dEh+2ZM/l4IJaMBcBGL+BBpIg9gIRbERb8AVsjYvrIt3
 buMvui3MR9m1FrvBNWAhfUeD4HNpNSHnu8lTf3BIzlmFfZUDvbNVXlm8NOLHZo+wmSXJ7tqaT0e
 EgvJYVqlwhV2wyA4BF6lyiXLULtxNpNSRUwyVrQnQX
X-Google-Smtp-Source: AGHT+IFxP4kScfo/Q+nLp6caWjyHqPRwwREtqqxFR1/6/5XujpNYyvJHUa59u4jlTa2G1cQGPLys28z8V/9b
X-Received: from pgct19.prod.google.com ([2002:a05:6a02:5293:b0:b2c:2139:ff4])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6e01:b0:21f:5598:4c2c
 with SMTP id adf61e73a8af0-21facb9ed49mr1243456637.13.1749773077886; Thu, 12
 Jun 2025 17:04:37 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:10 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-19-komlodi@google.com>
Subject: [PATCH 18/19] hw/arm/aspeed: Build with I3C_DEVICES
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3FWtLaAcKCmIKOMLODIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--komlodi.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Allows us to attach the mock I3C target

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 53d62cd08d..940418b46b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -532,6 +532,7 @@ config ASPEED_SOC
     select I2C
     select I3C
     select DW_I3C
+    select I3C_DEVICES
     select DPS310
     select PCA9552
     select SERIAL_MM
-- 
2.50.0.rc1.591.g9c95f17f64-goog


