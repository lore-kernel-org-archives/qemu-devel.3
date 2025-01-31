Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3290DC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFQ-0004yn-5Z; Fri, 31 Jan 2025 16:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyF9-00048o-Me
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:07 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyF8-00081G-4T
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so2070544f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357680; x=1738962480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNF/vS+/jQgJ4zkGiuyQoIln9Dsv44LkWIV1cquGqWI=;
 b=DyiGMjYhr4bjRpuUXaRG6wUJQ68QO5io48wQxLHVVRkiBd70DjX4KAjMQDchRbFiU/
 mtKB3JmbHN7Sembv88gGWDwfUQXfMyTghIAHu5x+9rGJSMCPbux47dV90nJXADBFQRbW
 IZqe2bC6xmRPltsgz6FfgnYmj+HtsI7ObFVZWEAPwU/hkKlX2JjRiskqJriVgq8iQYUe
 zWKhzpH51lUQjZd2emY6YXTtBrJ/17oZzATgxUE4Kfe4UtvSPfTYyCgVWNjvoNbh8K+x
 aztl2/l7K1oRObww2Z8TZeKem8MeFID+ieUYmFVmf18Vb9doHGBJXIEgLan+dGSdvHDM
 wtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357680; x=1738962480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNF/vS+/jQgJ4zkGiuyQoIln9Dsv44LkWIV1cquGqWI=;
 b=PkiX7oNHsnInhQvPeHWNGALQ3368jHkvgtftl96J/9tnPSgXC2/MyXF6tkkcNPDmMf
 hfv6mRN1wCuND8r7oeqeLWtUbUGh/mDTiPoI8kKNckah29mx4K83mpoMHCID5/PkBkZC
 DUqeKHklGTKCMhkX2sbgkUzSBhOqSaEeq0Ea+Oy1gaaphUJkfx6hA/gSoSqNtgs7cWkN
 tt+CMSiucnrgf3U0kkR/DK+fpT2Li2IXH+08hfdsPUdEfbRRtk2HBS0Iz+Nu6AfWozOx
 nJSIEPFxyV679VjnlUajFqfAIK3zKqTimvMUZRarENY0i+u5pZ1jKqxqR23mQ8b9xqZB
 3qAw==
X-Gm-Message-State: AOJu0YzqqIixki9CsS8UseV7QSC9AOZf+4EzqKv4N6ls61jA6MzN4IvO
 sUeT5hWaI+sx56OVeecJ1sNFLZmjslSxoDKcirvdnIqKfvaFdxm6MqP9ibCjHOrcdB5enoBtmsr
 vHxY=
X-Gm-Gg: ASbGncuWJjhK8XHk0shhoDK0Xb7y3fXKZogl7XSxnhBGUund5jizNhS3IdBsZS9umOL
 IN27WxG4bXc1VTIlm448HhP47NvPH4vfbEAV7s7oBVXNIz6sDm8JR80G4r5HxHYMSFOuhCNmOvp
 4uIbK+/5HbYR+eZWlhk2Dxyo3qbLviVVLkgDsijArm2zus3iRMGwITJE6ruWI3pWcVf1VJFyHor
 nrxh/6C+JIulH+xZ0i0E6ik6csoC715MnpyDs8r3B1sUL3u2Gzn5/gVi2Cngqbgf4aAWvpQgTrS
 ImdBum3sQuuXm31URZJHxcG5k46KtKsnLwEgnNj2v15/v0fRg2IfjNJgwnxi/7/fFA==
X-Google-Smtp-Source: AGHT+IE6kyXvTP4xrKmLRL8B1WWfNtVINE4tctutqfaglYWUNHySTdiKH/SLE9mUWOQZB1lmG2yxlw==
X-Received: by 2002:a5d:64a1:0:b0:385:f00a:a45b with SMTP id
 ffacd0b85a97d-38c5196995emr13178613f8f.21.1738357680352; 
 Fri, 31 Jan 2025 13:08:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c11b851sm5525128f8f.43.2025.01.31.13.07.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/36] hw/sd/omap_mmc: Remove unused coverswitch qemu_irq
Date: Fri, 31 Jan 2025 22:05:15 +0100
Message-ID: <20250131210520.85874-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The coverswitch qemu_irq is never connected to anything, and the only thing
we do with it is set it in omap_mmc_reset(). Remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-8-peter.maydell@linaro.org>
[PMD: Remove unused 'coverswitch' field]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/omap_mmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index a8b541ca788..18016a2f2e2 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -35,7 +35,6 @@ typedef struct OMAPMMCState {
     qemu_irq irq;
     qemu_irq dma_tx_gpio;
     qemu_irq dma_rx_gpio;
-    qemu_irq coverswitch;
     MemoryRegion iomem;
     omap_clk clk;
     uint16_t last_cmd;
@@ -70,7 +69,6 @@ typedef struct OMAPMMCState {
 
     int cdet_wakeup;
     int cdet_enable;
-    int cdet_state;
     qemu_irq cdet;
 } OMAPMMCState;
 
@@ -325,7 +323,6 @@ static void omap_mmc_reset(OMAPMMCState *host)
     host->transfer = 0;
     host->cdet_wakeup = 0;
     host->cdet_enable = 0;
-    qemu_set_irq(host->coverswitch, host->cdet_state);
     host->clkdiv = 0;
 
     omap_mmc_pseudo_reset(host);
-- 
2.47.1


