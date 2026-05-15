Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE71CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtG5-0005RH-8z; Fri, 15 May 2026 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFy-0005QP-Vf
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFx-0003xT-6t
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488d2079582so92952495e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854272; x=1779459072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+U9wwPM1Xta3FX+ZaXH8IQr8ni1ssktAw0s7odT+ws=;
 b=lukLWVzGVMJxVuS+YTssa4GNWEX+OJfyD/85GN65301HIJGLj6oGyGVMuDRyF9d01G
 0Sp1031rZmu67EewpPKIQr0ZTgUH6S1OpEdcdeR209+O4M+C8EM0JScFwqwwsE6RPJpw
 IzBsHGmL/lnPGHkhFXWagWq+8UJW/i+OKXjJ4qqBodinf35x0hrS8bBbTVZc5+nvu5AT
 h2O/E2SxpQnzRu2bvUuxvSVf9/dL1kg7cmzO1HYp6cBkt4pRJ025bZntsGgWURX6WurF
 zek1cSCTZIykTLgvjn7Sc4C1cDz7Pg25Q6IJ3rHvDapmqU0Ov1/LaJH6rvtIQm36hb3s
 1VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854272; x=1779459072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R+U9wwPM1Xta3FX+ZaXH8IQr8ni1ssktAw0s7odT+ws=;
 b=ctBffxpz6Ti5P2Zylnf6wR0eE1u4cBoc7C7gOg4FcTQq4Ymy7LX96MLzQDIC26DU3V
 Ouw32BsFPCsqTJWuZPgUNCXVd8wpWB8QSGcJpX3lDrq1w00WchScGfy658uHV0pSa4lh
 v4Cp/8YU/Xewn3uF1nTWFejRhlTWgktZ6gCBGsQX+UfGyHJ5mAfcawYIXRf68u5Ox6NO
 1isvwCKMYMAqmvTOEvMlF0HYgouprm4iTZ1ksHxtaHqM064dWNnqGRFDGthsO5rfNHm9
 prcSMzETYdoZsmw2Ahs+zWB86EVocK9evwvaPwwtH+y3yzZux+VHeo+5SahL9Ieyg0yL
 wcdg==
X-Gm-Message-State: AOJu0Yw+GdrTlxPKarw6ukwmYIGPndXIVlIWoh0Ft3dBMjFyHQNvcsOT
 1L+j7eoLAcHol+zNUcYhA4ubhyAkw926uU5i5wiYcWTqbUXEzf2a8Mv5GuzVl+OVcmrqBXkbdxU
 Vn8Vrw70=
X-Gm-Gg: Acq92OF5cNJTqIq7UQrNo+a7n/OMryOrXbKFTeCc9fy/Ac7NyjEEMZ/cNf/Fn9icJpo
 ttMSbOtKSpPtGP0DFZjDUr0yrWIDthXW/GYI1AJgO8U6ZEcpLaKun9LollDTGZ4tbyHH08repsf
 IL5GQipQgim4b6EDzEsst3RCRHVdlkkdPKCx+ERga7uM7y5bA/hhKx8gtHcvjiiwymgc+y2J8R7
 GUhqcpdpaIA0d+vc6ZZLI33wnx9UODnDDT630EvGrqzuT/4II8CuNWl9VtdYR9nohau2dYoqOXF
 UmhJrUb8iGgnXaL0ZpgHS3m5Bax+qwBy62XrWF7MOBuV1Dbi0X4ecWZlgmbVYeKGWHAdz/SPxMq
 eg62t/S34qE8SVkpkg1giel3I8WT/KszC3h9fmeaIYwKjCi3w2W4BF7h9Ff81GivjtF76HINGRd
 AdYVD/vuZmRUuqHAVK5QCTFFt9M250AGFFxsSQdqj082ThcH6ucDBp05L6FZMbcwm62jx0YNFuv
 43h/4UpWBA=
X-Received: by 2002:a05:600c:181c:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-48fe60eca66mr37497555e9.13.1778854271541; 
 Fri, 15 May 2026 07:11:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fead1c364sm16398215e9.8.2026.05.15.07.11.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:11:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 05/20] hw/arm/aspeed: Build objects once
Date: Fri, 15 May 2026 16:10:16 +0200
Message-ID: <20260515141032.3271-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Commit 064f1ce95fe ("hw/arm/aspeed: Split AST2700 EVB
machine into a separate source file for maintainability")
remove the last TARGET_AARCH64 use.

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
compile the aspeed.c file once, moving it from arm_ss[]
source set to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 144e4827660..7c3d66f4378 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
@@ -66,8 +66,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
-  'aspeed_ast10x0_evb.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast10x0_evb.c',
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
-- 
2.53.0


