Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D7BF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI1v-0007OJ-Ed; Fri, 10 Apr 2026 16:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI1t-0007Nn-70
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:00:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI1r-0006ah-Nt
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:00:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so33857975e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851234; x=1776456034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cxj5AYLphBEzhwo2MazkRnd3wQFnp4YvtA7GMP+lRHQ=;
 b=hFh/TvSeDgXk1uVBeaxe2mmbx7qsHI7aY0l2CAc6vnhVVR2YG5F8+vUkloKmRRixM6
 FWaa50Ie5SqiwgGG+oIapGoTph+9q3Cy81mJh0AJu97SKpIy3gDMRV/lhjFLIYPrLq/+
 CuEP16IikRkjVPphs7alLK4wNhRTlbkbY2adhsE2P8xvLPFHqInFlCoobWHSAPMv0ZoR
 gOiSgQrCapEitmUVty/vclzPCjo+/5gLVewWNeewXUMOLlsFQAtzOLple5BolWwmBpLi
 u9zD9sDkNMWDWYB7k4lUa2F/j52ldrUHJzD9rCVUD2QOd4G1pjoJn82XZwDpwJAcj4rV
 11/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851234; x=1776456034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cxj5AYLphBEzhwo2MazkRnd3wQFnp4YvtA7GMP+lRHQ=;
 b=h38+anSB+kIHUiw2FJSHnfzdALX1cVR7aLcdFh5BNPQ36oUI5n0cgZHsACNaiTArzB
 kywUNRgRTFGtW1PINGFSXpzWtcNtLacBqBurniWafeW4gxzk+3JBXa/+8f6H+qGS+Guq
 jZpi8ifWGAWS7PVSDPzGswcqnO8NlY2YJaWFPtQXtmy21fZLYUhF5hjF6DcBydUVZhE5
 Ewjoa+ArS0X8e5zJxzdq4WoV0aUCYpNNkjkz3dETpvx3K9rukdCEWbw3/Whb/c38CQKY
 xY19eV/E+CSpH988d7yx4LfMVXqYOgqrlU6S63IJ99CT8M472A4EumRDcTH/eGEMy9Ba
 TyjA==
X-Gm-Message-State: AOJu0Yxf+KU3jTPUcp5vlLXfmXhrgQc2vIGhcFFaSAQritYeu1+7yh/L
 Ba3knXeDUmTNxp2YxnQaLDYxuLmxLmXnAwa8kTrRKy93qi76820QPwuR8UcyIuhgAQYtiOFKrG/
 GzGfbNcc=
X-Gm-Gg: AeBDietmCN8Nixb3Imjgi2X+2yD1MDn2JKRVZDu0nNfDCYwql9ayZdwiMsK33bqZAdF
 MAKMsCSH5o2SJdReRFGteDTPMf+YtM3km856oYp+mMStS3XrS6YxxtmdVkOxPnEl6pR2bqjCj9B
 YR+U8rZeTnzr3Zf5kwoYJlMOQxsFv/sCOMOxMpp1TYequdlQCsbBSQhot9ZDIPWFDaM/hqw2grx
 YoXZfx9oGaUZwadABKMa9ZH3tyoy2PIAxa1ut1+YeTACgOgT0FkPvDKM17R95bn6T19eiq16gK4
 NPhdb7hnoR6JNAIyLAWoMDnF4BBvOFTsdcdE9BC6t10HD7LRTLlzc3wmnjZI+oqX39UBlBTPfmc
 tJneiHlt8RMGNEC2ne/RBlw/g6tWlVvcTB8BWSClwoiFjd4kyshOD4IWW7MHNx74Ww/CqYtfBiW
 j8ocfe76R3vtnGs57rAAXfjgue+GrRnrTLHwY6O8tLGKfeo5EaudTGF6W1tA5aTybiQCDPA081
X-Received: by 2002:a05:600c:a404:b0:488:bfc3:ef3 with SMTP id
 5b1f17b1804b1-488d6671271mr55576245e9.0.1775851233596; 
 Fri, 10 Apr 2026 13:00:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ced32sm38979025e9.7.2026.04.10.13.00.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:00:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/
 header
Date: Fri, 10 Apr 2026 22:00:29 +0200
Message-ID: <20260410200031.18572-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v2:
- Restrict to ARM SMMUv3
- Address Shameer review comments

By inlinining the stubs we can avoid the use of target-specific
CONFIG_DEVICES include in a hw/ header, allowing to build the
source files including it as common objects.

Philippe Mathieu-Daudé (2):
  hw/arm/smmuv3: Have smmuv3_accel_init() take an Error* parameter
  hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/ header

 hw/arm/smmuv3-accel.h       | 41 +----------------------------
 hw/arm/smmuv3-accel-stubs.c | 52 +++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.c       |  3 ++-
 hw/arm/smmuv3.c             | 11 +++-----
 hw/arm/meson.build          |  5 ++--
 5 files changed, 61 insertions(+), 51 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel-stubs.c

-- 
2.53.0


