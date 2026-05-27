Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F608CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBao-0001Tm-0Q; Wed, 27 May 2026 06:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaa-0000og-AJ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaX-0001ds-BF
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso7318760f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878051; x=1780482851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ttRC7jhcF8srzoB9LI+SHHsPyswGDW9kHUSpZKI/FE0=;
 b=wTbSuYd55YvqCyLerit5Ehqtog4V/CfKj5UrG75nBIxYLaOXP+0CC/WRE6KpSgnP9K
 Qy3bYDEmivXyRfCEk77zs3rHiMNoNa84QkarQV5qsOv8vxlgEan0Clqm6w72rkkB8qgD
 eJuR9mxVhXERFpzViTSGFw+CR9oMXaMC3AhTIudNTsMNWwXfxcwgx2oI6OfHFxwp4BCP
 XHBsWHnm39R25lbtVxYWpczje5/Lfmjuwqrm/7cN9i0XUz3DrdqTMT1q41G3Q3Bmtb9S
 wyeVZY25AasqWd9ExJmJzSqnZqVljEodNg1Tkhd+/USncaRzdQBLHstrhvUALyY2olKt
 i9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878051; x=1780482851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ttRC7jhcF8srzoB9LI+SHHsPyswGDW9kHUSpZKI/FE0=;
 b=gLBbVrLvJpp2mktPAzdrzd7KPYj6CUa7H55rOI8NrhaFIFs35EovWqsK1PmcgGuQT1
 mJXynJkCPnl0v0lDUu30DBP8RjpToY+T+XU0siQYS3d3mMi/GTUcswF+E6yS4swCyxfS
 WMgiZHmbi2h65wlw07ChLXG4qumygigBgRBFS6mfSHz3Z0pLD/hwrK8cisg2hIH7NRGd
 jaQrFSdA8B3RizpG4T12aVysAkNEvrIeOlRcUs/VbhSjWSKA4RFW8HbbyR1aV9Uc8HsH
 gtchr4Ujci2UhwuKtAkXA0AR2c7GOSvdQAQzVxPxpqVFxQTY7316ZecX0JJfrJppJ6Cr
 DGCQ==
X-Gm-Message-State: AOJu0YwmYemQ8l5/DxbsCdGjk6eXziHLTY4fhP+k9SZ81DBOqCHyv1FH
 JCvImgok8I6UbqEA3+SBwKbjw9/kzNyenL6te3iFTJedFIh9cpUkjoZ77/bO1XyuHfv6pAnY6XA
 /kjRGjRMrdQ4T
X-Gm-Gg: Acq92OHDLCr8BgR2eDusSUYXLFfXb0q6OLszmyn2z71iI2dyst4bW5xfX3K0MJlfXmK
 d+CW8oDUWoBQWZP/TZytiaVWVLQNS2tU7OTe4UAlhTvg1AHdTH28s4+GtlJI9JQ1+c3RcG0Lw1K
 ALbV17m4kNd+ESDsR8g1F0jAJTq+lgW6rBGBe77ZIcOh0k0gL63iXXLRl1/+8wJ8z6wiPkm6j76
 Dp/IolcH1wGKWe7eGnVC4fvOKXw7XJJ/zODPwqFAYwvjmxtOWr8rofEyBYMMio6VURlJj32sT5T
 gWu2Nfo4fxwiuTlc85J/OCAlGpL7ZVghEdIeQ1AUSWlWIGqJ9Gfh3m4QtcMeGrUIFQJ+GQPbb8I
 ephNvrxjxodXAFG4XbYYqQXjT6oZIuhgCn3oeFQ351zd+M2w1mQ/vKWr1V5K2Ppg8iNWxEtAmeD
 4YjuvYz4CD1HJ1gaGFuHXx3FPGN/s0meXgwAMWJr3YHIgROwtqo7p9AvM=
X-Received: by 2002:a05:6000:4919:b0:454:a41f:d082 with SMTP id
 ffacd0b85a97d-45eb36b0242mr32720975f8f.3.1779878050922; 
 Wed, 27 May 2026 03:34:10 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c47a2sm4950494f8f.37.2026.05.27.03.34.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:34:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] MAINTAINERS: update qualcomm git tree URL
Date: Wed, 27 May 2026 12:30:35 +0200
Message-ID: <20260527103037.4461-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The git repo has been migrated to https://github.com/qualcomm/qemu

Note also that for some time, https://github.com/quic/qemu should continue
to redirect to https://github.com/qualcomm/qemu

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260522222827.3239334-1-brian.cain@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15982c04614..35ab2b458a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -259,7 +259,7 @@ F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
 F: docker/dockerfiles/debian-hexagon-cross.docker
 F: gdbstub/gdb-xml/hexagon*.xml
-T: git https://github.com/quic/qemu.git hex-next
+T: git https://github.com/qualcomm/qemu.git hex-next
 
 Hexagon idef-parser
 M: Alessandro Di Federico <ale@rev.ng>
-- 
2.53.0


