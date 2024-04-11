Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F497CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruruH-0002kC-FK; Thu, 11 Apr 2024 06:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruG-0002jN-6P
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:43:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruD-00048C-Bm
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:43:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-345522f7c32so1476098f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832223; x=1713437023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=StAg582IsYUfzw7jTeYwZAGK85x75PWnZXDo6iqC+rM=;
 b=jUJhgtshcfKZbJ3KL3IFB8D3BAMZNSnSbsLDimh9H2aDa+ZgUwCLa9IDHvxuRRsxoZ
 P+qpTuxPO8YhVszlq/M5kYG4oaZc4vRYNeEtoBFcF5exfwjMZKdNDmNAo9gpeU/8BO0H
 HIavHQvuzwgLg1rEFQ6+DEFioXnZ9b9gj/3g1IRGr8pmfT5rNUs0b6JRQ/XTJDnkF+31
 avEgkcdVZVpDYp/pA9NYPCUpbpkLzLsNimVAjQToUXNI2BYnQarHDEOfIn0jiovAhGsp
 Vl4NUXNbiZhqnH+zH5k4RCNobaRCj1qZwQ26OzjGEeyEZIHoHocMXgcIS9kds4xbHv0B
 Rolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832223; x=1713437023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StAg582IsYUfzw7jTeYwZAGK85x75PWnZXDo6iqC+rM=;
 b=tcKpHc9bqgclSzRxL840R8a12SlG3WjHub5kCsduvw3lFy2To3lsV9Cky2u2jBvlOZ
 wjeaOt3wPa8f/e94dUSdBsA/nR0abruyS76TqNiFSHvY9XNNlzs+oJX8V+M3LKPJNaMl
 KaUOu0MTvEsqyTMcijBcDM5gDIa5utGBWcx1kXsTUf7rXowDrv/oA/iH7ookhMWKcTCw
 C6kCdVEKeORDUtNPfkZyo6SppuSi/3Wupw0KkB+y5C3kmphnvLAE3/qitFm5RTtTANuZ
 1STIZiMcx9AkECwDLwrv3pXCjzxc9o/0roVAOV8mH/tHKFinIjdDvhOlJ2xbnkGGEITb
 iSEw==
X-Gm-Message-State: AOJu0Yx9USMFuzOP1Wyaer/ruaVYOhAyABR30Thug0c9G6VN6Fmqycnw
 MCHgy/hT9NMfmU/mjW/w3BLVYapqAQXPneQV2ix01RlHKlZor681xzE8yITd5TD1yBck3LUyscG
 nVbM=
X-Google-Smtp-Source: AGHT+IFi9/8iv6Qesk2ck+iKMFQl0VhFPHk3PrG4jLviJ88A8hvuZ0qNjj9KAPOtFpNX9gIPVohOig==
X-Received: by 2002:a5d:5885:0:b0:346:b8cf:b61d with SMTP id
 n5-20020a5d5885000000b00346b8cfb61dmr1142647wrf.43.1712832223279; 
 Thu, 11 Apr 2024 03:43:43 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a5d5046000000b00346df659e7dsm98738wrt.17.2024.04.11.03.43.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:43:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] misc: Replace sprintf() by snprintf() due to macOS
 deprecation
Date: Thu, 11 Apr 2024 12:43:31 +0200
Message-ID: <20240411104340.6617-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Continuation of:
https://lore.kernel.org/qemu-devel/20240411101550.99392-1-philmd@linaro.org/

*** BLURB HERE ***

Philippe Mathieu-Daudé (9):
  disas/m68k: Replace sprintf() by snprintf()
  disas/microblaze: Replace sprintf() by snprintf()
  disas/riscv: Replace sprintf() by snprintf()
  linux-user/flatload: Replace sprintf() by snprintf()
  hw/misc/imx: Replace sprintf() by snprintf()
  hw/net/rocker: Replace sprintf() by snprintf()
  hw/riscv/virt: Replace sprintf() by snprintf()
  target/arm: Replace sprintf() by snprintf()
  target/i386: Replace sprintf() by snprintf()

 disas/m68k.c           |  2 +-
 disas/microblaze.c     | 25 ++++++++++++++++---------
 disas/riscv.c          | 10 +++++-----
 hw/misc/imx25_ccm.c    |  2 +-
 hw/misc/imx31_ccm.c    |  2 +-
 hw/misc/imx6_ccm.c     |  4 ++--
 hw/misc/imx6_src.c     |  2 +-
 hw/misc/imx6ul_ccm.c   |  4 ++--
 hw/misc/imx7_src.c     |  2 +-
 hw/net/imx_fec.c       |  2 +-
 hw/net/rocker/rocker.c | 24 ++++++++++++------------
 hw/riscv/virt.c        |  5 +++--
 hw/ssi/imx_spi.c       |  2 +-
 linux-user/flatload.c  |  2 +-
 target/arm/cpu64.c     |  4 ++--
 target/i386/kvm/kvm.c  |  3 ++-
 16 files changed, 52 insertions(+), 43 deletions(-)

-- 
2.41.0


