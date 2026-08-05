Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C282FC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZM-0005ky-E2; Wed, 05 Aug 2026 11:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZL-0005kg-Fx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:11 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZJ-0007bO-VK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:11 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-497deab2d66so999381b6e.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943808; x=1786548608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=beqgtH4oL0q6EmsLi7MbwC3700oSRm0oLfyE6W+g5pE=;
 b=Lidq1Dcj55VE/1a8nUa1wirz95nfgSHBuSsQ0Itwe5otxVdW7i4THNjwnsCK0Xi6U0
 gzfTLvY4WQLwVetUt2yCduHs2pjGdLmT1CZTCXzWmq4DMz0YeuUTn8PBGhfAJ6URCSdP
 EshcnEL1DXLELbKqej7xqJIO+5tmAdezrcIjwSS95owFQUG/xHwdH0YoRgrgYgF9eESa
 MnoZq9Jv13AdMwQT5s4DUV46pDwEjX9fsBI2VSRB7y8Ac2Vpi1xSW70x9bgFOtOBne3p
 d87yIDlXeC1PNma3awFuaAVE9aAyn/AR/qm7a1yezr3iA6opbWVNjh0LhVr8MjVKC6MH
 CC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943808; x=1786548608;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=beqgtH4oL0q6EmsLi7MbwC3700oSRm0oLfyE6W+g5pE=;
 b=HEeURi7VHuwc8PTU9RBSRdqQRpDQ/yIeJg8oSrqNAE5azwv+CewEsD4TlkgFOVGnlC
 aisA6tU8KXYa5KaMIgPWmCErBzWAnm9ekdQc/fTH9ZSzFJHzhLKEU0f1hVvf5BiXF4uy
 28eqb+sJmNKB+YsLp6nX847ZPKLyD4MO/pAkWgB0tU2W2sUB6uLOfq8bCaK1ZWHjXXH0
 oeRj2yj3nMxNjprGM9RWpHqPotR2oQ9ZKh1DApXMOvqvY/C1slm4EHYCEnOMKT2FPr3n
 WZSJN6CoT+G1N4gdJBhfQiLWXjL5YgrUGiN5ecAvTMjB1KkT7Eq8D/GO1wuddhVqdEGA
 7T8g==
X-Gm-Message-State: AOJu0Yw2Apr+fhJHy01vGz/tBAziN9nCTcrZ8Vd0CdjVUVwn1LU3UduI
 98Ro6hTCxnzJttNbLq4zNnlKjN2tEn57TvP6jy1VL+VEfUBcn/rxKXjsn/lKKPeq
X-Gm-Gg: AR+sD106tWZXcAemAlKPe/YDC3FzFuoPKiIDTOQqB99ptNLm93g6Oo234LuqbHVzvOD
 pbzaIN4T+wYRmRnEv+IQuK2xmaQD3v6+NsdUZBWbIhf6pXS87CTDqYS7nYa56r9BYPvY8ErT4wu
 vXDpq+1VVF/mh8ASX4T/d0zO6m32tjAMwHD5YAFM0QYGFaYiHozHO5DNe/B0zFx62djEK15Ph0o
 aIarQ8y13vmkzv2+3oUt5uFhTzP2QlzOCRBygTgbfV3ygOqDMDyyfguRFXqs0lQUsho1VnI2dUF
 ckNApEsABhySJftsA260QgdMiPBtExr8MBErCsY/a0OMe6DcDoVvBFHPyEh2M6dyGmlp4DLmOjE
 xzPNzkh0YWWuqfKuGUmyRJEecNA7Qx/nSYENx+h9Xy6U9qRCapWLoKG6l48Zb8Vhg3WsbqqM3/y
 GRjfHmPVYr7nTUMqq5xWn7uQe5vh1sTKx7ocpxH/Vyz7QtDNm8+mNp4mca2tugkh8yJ9DwZAZAc
 P8RfbFE8smTg25pp86jvNqK0Yfga7eh
X-Received: by 2002:a05:6808:169f:b0:492:c9a4:2104 with SMTP id
 5614622812f47-4af98934eb6mr9877033b6e.10.1785943807514; 
 Wed, 05 Aug 2026 08:30:07 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:06 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 0/9] arm: add Cortex-M85, SSE-310, and mps3-an555
Date: Wed,  5 Aug 2026 10:29:56 -0500
Message-ID: <20260805153005.9989-1-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

v1 -> v2
	Split armsse patch into multiple patches
	Implement PPUINTSTAT register in sysctl
	Fix AHB read bug in secctl
	Refractor case statements to use range syntax (...)
	Remove sys_config2 property and hard code it to return 0 (No NPU)
	Revert MPS2TZ_NUMIRQ_MAX back to 96
	Fix timing adapter and MPC creation location for an555
	Add QSPI R/W controllers to AHB PPC EX0
	Add GPIOALT2 register for FPGAIO block

I will address the other bugs pointed out regarding the existing models
in another patch series.

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Simon Xu (9):
  target/arm/tcg/cpu-v7m.c: add cortex-m85 model
  hw/arm/armsse: add Arm Corstone SSE-310
  hw/misc/iotkit-sysctl.c: add SSE-310 support
  hw/misc/iotkit-secctl.c: fix AHB secure read
  hw/misc/iotkit-secctl.c: add SSE-310 support
  hw/misc/iotkit-secctl.c: use GNU C case ranges
  hw/misc/iotkit-sysinfo.c: add SSE-310 support
  hw/arm/mps2-tz.c add Arm mps3-an555 board
  hw/misc/mps2-fpgaio.c: add GPIOALT2 register

 docs/system/arm/mps2.rst        |   6 +-
 hw/arm/armsse.c                 | 208 +++++++++++++++++++++++++++++++-
 hw/arm/mps2-tz.c                | 160 +++++++++++++++++++++++-
 hw/misc/iotkit-secctl.c         | 132 ++++++--------------
 hw/misc/iotkit-sysctl.c         |  89 ++++++++++++--
 hw/misc/iotkit-sysinfo.c        |  22 +++-
 hw/misc/mps2-fpgaio.c           |  13 ++
 include/hw/arm/armsse-version.h |   2 +
 include/hw/arm/armsse.h         |   9 +-
 include/hw/misc/iotkit-sysctl.h |   1 +
 include/hw/misc/mps2-fpgaio.h   |   2 +
 target/arm/tcg/cpu-v7m.c        |  41 +++++++
 12 files changed, 566 insertions(+), 119 deletions(-)

-- 
2.53.0


