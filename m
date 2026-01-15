Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B260D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSW1-0002JR-OM; Thu, 15 Jan 2026 13:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV3-0000ch-MT
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSUz-0005mV-2s
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so9940715e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503310; x=1769108110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ud2T5sLAWTu5Ijq1YhobwgkD/yOPgwz2pVJhcRpx83k=;
 b=w1Ku8MZbtP9P9rqNbZXldLl6mhY1XOUiGL0FNSvxS873noqZCfCDJWl1p0M7/NF78B
 4x4Zq3jYCfItR1PmGWiV0ymXm/nbBQ+FJ4Udf88PAgFIudrqUgr2NQUQhCBPjkctBCV7
 KsU+/TBJU7aJB5gJKqZ562Dp8rW5HDMIcWFBnBh/sJhxzcxg+n8KKwkvbQ0WTMhp71Ve
 FFF7JxpXczPTOFPAJpRBF52eYMFkfa8SC5/3pQJGE6GboU8YT+jxPivEFP2VTwajN7Uw
 FX6EckR9WUYtXTvxlfNXXra0Js+m3vOCq7oXO7C8fAAHykOwrwFuFhH5Lym62Rocyeya
 9amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503310; x=1769108110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ud2T5sLAWTu5Ijq1YhobwgkD/yOPgwz2pVJhcRpx83k=;
 b=v5PkALh3xh//eCA2JXkkVNPP/FwQuk06RA4/jQwVS7hOStEkNOVN20X8vKizvEnb+l
 JJn1G3Ur64a4Q9yxV//kxJIUUQazCwhMB+KBQ4B2m6eEVLciOynp4xPpDORTgQjoBjGm
 55zcc8tu1OiB6+eQ04VXAJyow6nOidmDpaAeHUOWxfuveYQu3JjSq+9VCdjT6Atw+3nx
 YllBhcFjbpEZ1/RLz3elMdb2skV+kpscO13HTpcbgfDsOTNWFu0u5hnFnsiDJdlvHaIN
 p50yX+sXsZJiqxA5agblRy7KDewnODfWCbyj/weYtLQDhKu8oFTy7pNGIA2GtrcQxZh0
 Se8A==
X-Gm-Message-State: AOJu0YwrHfZyFdxkzwQx7DmrenIralHt5DIThS5nUz/MJ7FALApvMcDx
 WgwMPTPiVRCo04NsrGpayJ4DaHBl2pQ/B15LUAFHwYj0XseUlKz9vtKWXlo/77IB20ryZdhViKF
 JN3sz
X-Gm-Gg: AY/fxX5CDRP253PHxE/tKSU7tx1pr/SxwXjEN/SeCEv6P02C++RrOvI89iWvT2KNFFa
 p0euHa0baobMD1upIkBG05O+kObnVbdmsfw9i/p2p2YDAV2oe/5Awt3FxUnC4UgP/W1NM/CXRa5
 DxjXYR8Xjcu15KrBiQ7Omf2nprZf48X3Hp8OjyWHzp3vL2c3R4Be0+PEkoDeuOwCjTSj+Qb+pV6
 hIuuu9lU/UY4K5sfu9Cu+Lx7g1ig3F+SkBBFKGgTLpVShWZttQqYJwrsqChmJKBEYVxRiDBE3ou
 6o5w2XdaYXjICsESyeC7ZYGb8oMliWUjIzUR3XAWPEobeEbQUG5WeGIk6GnYBbW6Ja/tzGL6phe
 d23EwbhzWvosHPcQBeLSLGQOdXQB+LRjSngAwWS6mZXToiqp1q6gg1WqPR/O9FiHiAUc+Qcer2F
 MxEJob0qFESAKxwqSe9f4RU/2Slg6PoasEJw9/32Z41Ki+lel0rjqe71Mufnhrc4LKCT8R3ecLf
 c3kwNsrHmRzcnhoBh8swwK5VT4b8wIlWm+d0jWPQ7iX9iQVTdAj0DzP
X-Received: by 2002:a05:600d:2388:b0:47e:e7de:7c41 with SMTP id
 5b1f17b1804b1-47f44d4ca19mr27846865e9.16.1768503310303; 
 Thu, 15 Jan 2026 10:55:10 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/25] hw/arm/raspi: remove duplicate include
Date: Thu, 15 Jan 2026 18:54:43 +0000
Message-ID: <20260115185508.786428-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

hw/arm/boot.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 1276bb4df4..00e4a10466 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -24,7 +24,6 @@
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 
-- 
2.47.3


