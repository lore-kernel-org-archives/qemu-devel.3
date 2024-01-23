Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FEBC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPZl-00070o-Lg; Tue, 23 Jan 2024 17:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZh-000701-B9
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:48:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZc-0004Gf-QJ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:48:56 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3392291b21bso4159650f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050130; x=1706654930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ne9fETa/FFUb8yRzxwXxz52suSQeNnRaNemXs5i2sTM=;
 b=ZRuyS8QntMWqxs9s7HxavN5d2ok6Fulqs2JUCVXbQypc/+ztBEyHIWPblsxiVnxM8P
 +k5ZkCPzqB4XgUzFqQQ01YJJXkvcwEueh9Lz0xOene4T7DSBZuDibeYeG8SWd+Kg2G5K
 sb9rkDZuXOcaCB3+0KKZrDCdSjRDspMWQm5IBWOHuLpKQE71EWWd0PxhCXmF8fAARpRD
 qJy1RETk+py0JJ2Kx1FVxdD0zR+4XRlaICI4+aTCXD35DVFwVeeGX/sk1CuAXtbZa/Ec
 s5qgyfDA+76CV9A/RFTulO0vqnz4DZYFYeDrCmv93JdEbL2jtu/BtelRsAVXsB+NEZvx
 Tp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050130; x=1706654930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ne9fETa/FFUb8yRzxwXxz52suSQeNnRaNemXs5i2sTM=;
 b=UGQ0RLR+aOyF6LO4/rvG1aokAMWZWP6J7iNQOHFtltqPyRGo8pvrcrefsoQ045Bv2z
 xHWSpxPOvf/RCC+0/Qj2dBfur2yaWYwrGLJun/X6c/Ds/Ky2X/S6lqxklcNZAURCxNhy
 35DtfvUxBsuu6l7oe4Xty20HkbFpz/db8vsSjsFG/8E8lHF3nMQhZDf2sIRt2gMz/3vn
 D0y5rjhWnP1r30mbWJ5Y7ni2eEc7Znh4C8aMNPBXm6EQkoGSkWFbm6GrftGEHr14bw2K
 tOO6tPLOjPitcWGtRMa5b7zh3WgcrShtce7Q8ZIiP5RUDsTpIHHKPZxXSBeq3tF6Gyvb
 4yYQ==
X-Gm-Message-State: AOJu0Yx53vvo6uRAzSyLKXPH2GgF8drWATvHyG/iwdjSR5CGe+3k/yA4
 iF8rzmKK5QdIhcd0zyfy8ObGQGHai0Ai++zyAre3m/v+S3+9OESV3MW+1nv3PBmSPo2hmtyzp7g
 A
X-Google-Smtp-Source: AGHT+IEsLn0gu3/ul/a7wwdWYPC9lbz5J/FGN3rQ2aX9XX7XsK6y3+3tF/hzWolIs2TRxoKJiIj3zg==
X-Received: by 2002:a05:6000:799:b0:339:3595:56a with SMTP id
 bu25-20020a056000079900b003393595056amr2564123wrb.26.1706050130455; 
 Tue, 23 Jan 2024 14:48:50 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a5d67d1000000b003392f229b60sm7627985wrw.40.2024.01.23.14.48.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:48:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] hw/arm/aspeed: Remove dead code
Date: Tue, 23 Jan 2024 23:48:38 +0100
Message-ID: <20240123224842.18485-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123224842.18485-1-philmd@linaro.org>
References: <20240123224842.18485-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Remove copy/paste typo from commit 6c323aba40 ("hw/arm/aspeed:
Adding new machine Tiogapass in QEMU").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cc59176563..4bc292ff84 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1301,7 +1301,6 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size       = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
-        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


