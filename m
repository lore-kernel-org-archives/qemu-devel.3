Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167EBF483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWy-0002Tj-DK; Mon, 23 Mar 2026 12:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWX-0001ll-Hf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWU-0000VA-V1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43b4fd681c2so319334f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284781; x=1774889581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rzoFtsUXcWO2CsqhXorD4l05nkjxjOTs8D6KMk1lCcY=;
 b=KbwVLXD0G+qB7tFGrrju4nJUhSpBY70XLWGIofKM2X8JWPcoU95AnfQvNJGpIGbWCX
 zqBJZSgsLnonEFX+Lrv64ZarFeDzSIrr6Qkkkl/Y71igeOv3u+c/N5cmw6rnN5jKCWm1
 vDmHFibqYsX9HnT8vVjW7hQ3m/lSIHbln4zNcsHjUuJruPVUSFWQ2c4jCXOWjWoiwc+M
 /9pmwDFKuvNBGpKsGNR69R9sN70BMhwsWdj/e8ufSdsWgbm8v3yjJNYv8U1f/xXimZzR
 V4kY0pxeGcR+x1RYoM1z5bWEMeBaltkJMfH0b3+D8mhgqvY2qL+C17rCELxjyxHweNRt
 479A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284781; x=1774889581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rzoFtsUXcWO2CsqhXorD4l05nkjxjOTs8D6KMk1lCcY=;
 b=BJR1aW/q98GLr17lxGA1zCqKsII4ER4VjCtSDvcE5iy5/x94VK/PbQaq4qYxFxIoso
 BhIOnGGbtXcUNeVgNipl3prV5fRJPeic8PxlmaSn3FUkYaIq0y5LjIZO1KaY+b3wVEIX
 kewKcUlvxO71JaEAkkgB4nwO5gE+kmwuRU9EMD7WuGf4dv2KQitP5sHosmKjoyVPMjgk
 KFriSmP/mDJfp6UqwhC3bcSqL9UuHGdh+ZFHzi7PPx4T294RsRzof7UKZaFc+xStKieI
 l+VP103E0sGD6pvunUDQsvjlPs+g2OPc1el1mkM7sSI0o2fsannVQz5aTb5MS0z8rVdv
 xBFw==
X-Gm-Message-State: AOJu0YxTuwLX8HbYuKI7Dem++hDL8FyQbby+tMkD5Qcx1J8K9Lx0ppb4
 b3ItB1gcSqN78U0rimCeAOm/hzniLAfLPMzbl+wMGQtv3WHfc8CbFTl1NaDWvaZbVmQH01QBfRQ
 7h8L7u0g=
X-Gm-Gg: ATEYQzxyV9p536I5qUEBRlSRsxCBNCtG7HcSsgFf9e9SMm4DK56X/gyc+nhqwsrrzF6
 sKkpf8ADXSPXiyY7F4IdAGrbjnhmwG9iqt56uYKvBcWXHMbEhYy1e8/2DhJ1ohTqX2cRtVXMlP/
 20MO3EfX5rdNIue/ZP8ppwxjg10hgBIcXyIv5gx+Yfl1IiD52kBylBZa2MsZd5T8lJs8xzzqjPL
 c9dR507Sq4g7ffkRAV8ztCiouRvSscdXUJiX9u84LSq8Z+hrYo3U/ba2odNSIJChi995inliPnq
 5qU9ZAUcXZ0sOrKjQ9U+NVdOAEd2TMb0TDEoCQPBjowO1Ge6vk2pHM6sBR+qXvSlwO7xKaT6OC2
 NsgCXpOLbLOsjXgHuJHeakn+K17pPOWpuUF7pyW0EkMO7M/iDuGUad//81iyHveCAMnq3TiDhEk
 yilZ8GHZAlkRa/yXpDm8uSxW+Zvbt6N2bttUL/BHH6X/wiZ1D7XS/k3OKROdak7mAOwIFLwquX
X-Received: by 2002:a05:6000:3113:b0:439:abcd:b314 with SMTP id
 ffacd0b85a97d-43b6423fb6fmr19020361f8f.18.1774284780711; 
 Mon, 23 Mar 2026 09:53:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae16fsm31818360f8f.8.2026.03.23.09.52.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/27] hw/core/loader: fix error handling for get_image_size
 callers
Date: Mon, 23 Mar 2026 17:51:57 +0100
Message-ID: <20260323165218.96607-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check the return value of get_image_size() and report failures
for non-mandatory file such as FRU image.

- Use ret < 0 to detect failures in getting image size.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260318141415.8538-3-vikingtc4@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 012e2ee4fe2..fd875491f55 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
             g_free(fru->data);
             fru->data = NULL;
         }
+    } else {
+        error_report("Could not get file size '%s'", fru->filename);
     }
 
 out:
-- 
2.53.0


