Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F2C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMseR-00079C-Fy; Thu, 27 Jun 2024 13:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMseP-00078l-1y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:13 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMseL-0001oA-Oj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:12 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ce674da85so5275224e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508267; x=1720113067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eQi11i6sS/5zW2RybooXX9phFmWU7bnalYMVQCv/JUk=;
 b=pc5iUN9PclnEyd+8ZRGVrQ25mlAP7+UfuqaMd6ChHX765HddTovvbH83gwNUAKwgmk
 U4aF1b/0ntnBxOeXw0A0zcNtHuAwSrLSQoZK7ZPfuhNpvndpadX2FxnOY0elFn65GqIP
 fH2bYVhlWtpXLzEV/SHtdHvvUxaDUx6wELHGGw0VpD2RgMqVg+9dwUOqt5rkqOq/JQ2m
 4THz2R/OJBlkTlHmAD+Q7hPeOyP2UJKVGB9XisasqTeAx7ufWM1TBQ/PV2/JuQIIMYVG
 gp6c0MtovuDOP4kDA7KlgegciiO/rZIHcCy/Rqa1YGLfu5gNYx7ptaJIJRiYp08ulPOk
 ZqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508267; x=1720113067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eQi11i6sS/5zW2RybooXX9phFmWU7bnalYMVQCv/JUk=;
 b=aD4mxCngA8eEOxZHv3JDsrntuGhYAURlqxHl4LlPw/37cTmnHsf8A6y6p6i2wkL30Z
 e0fh8gOpzSTTTQD7Hwy3Z26SguZUxhTK90JEIAr6eP4TpLH/zt1MwoyUrD3yAOAQwC2k
 pige2e1z73TN0l+erjHFP/DmQ7sss7uWUmFDexC5HW0/EI46fSImdA3AjFrynax8fxcD
 eBPZO3Fp2oVM3v+LBVD9yuShue+wjXdJfhe9i+ztdWbvMD6I49tDxPeoMkpNNJ8HMLs3
 wnZp1kwX4GGpZ4pou+F8ECmzh7iFG7C1A5r+soSaPGxjA2xtcFHtP1+TjFHa8Wh8sJDH
 Ehug==
X-Gm-Message-State: AOJu0Yx8HR+6qHpgFMPVPQ8ZAwIzoPsQmfBAZ59nY80y8so0dF5fJ1uN
 fKtz2sYB4KjmPwKutlH7HeTow+pJKbLiSAixLU8BUVRI9633Ql+n+HkvBLbpMYev0VaaxH9dXv1
 iSOk=
X-Google-Smtp-Source: AGHT+IHm9mJ8ypAA977Qld7vNyxVworelTJNZTaZK+ByCNNgkMKFMBi95aXrByGnTW8F77PuXgQjng==
X-Received: by 2002:a05:6512:10c7:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-52ce185d33amr13908920e87.50.1719508267399; 
 Thu, 27 Jun 2024 10:11:07 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699b02sm2505219f8f.85.2024.06.27.10.11.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:11:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 00/19] hw/sd: Add support for eMMC cards
Date: Thu, 27 Jun 2024 19:10:40 +0200
Message-ID: <20240627171059.84349-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Trying to land what Vincent Palatin started 13 years ago!
https://lore.kernel.org/qemu-devel/1311635951-11047-5-git-send-email-vpalatin@chromium.org/
with fixes from Sai, Joel and Cédric.

I reviewed Cédric patches but still plan to review the EXT_CSD
layout and Joel "boot config" patches.

In order to avoid deviation with the spec, the experimental
'x-aspeed-emmc-kludge' property is used.

Based-on: <20240627164815.82606-1-philmd@linaro.org>

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Including Aspeed branch from Cédric on top (aspeed-9.1):
https://gitlab.com/philmd/qemu/-/tags/aspeed_emmc-v4

Cédric Le Goater (5):
  hw/sd/sdcard: Basis for eMMC support
  hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR() handler
  hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)
  hw/sd/sdcard: Adapt sd_cmd_ALL_SEND_CID handler for eMMC (CMD2)
  hw/sd/sdcard: Adapt sd_cmd_APP_CMD handler for eMMC (CMD55)

Joel Stanley (3):
  hw/sd/sdcard: Support boot area in emmc image
  hw/sd/sdcard: Subtract bootarea size from blk
  hw/sd/sdcard: Add boot config support

Luc Michel (1):
  hw/sd/sdcard: Implement eMMC sleep state (CMD5)

Philippe Mathieu-Daudé (6):
  hw/sd/sdcard: Introduce set_csd/set_cid handlers
  hw/sd/sdcard: Cover more SDCardStates
  hw/sd/sdcard: Register generic command handlers
  hw/sd/sdcard: Register unimplemented command handlers
  hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
  hw/sd/sdcard: Add experimental 'x-aspeed-emmc-kludge' property

Sai Pavan Boddu (3):
  hw/sd/sdcard: Add emmc_cmd_SEND_OP_COND handler (CMD1)
  hw/sd/sdcard: add emmc_cmd_SEND_TUNING_BLOCK handler (CMD21)
  hw/sd/sdcard: Add mmc SWITCH function support (CMD6)

Vincent Palatin (1):
  hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)

 hw/sd/sdmmc-internal.h |   3 +
 include/hw/sd/sd.h     |   6 +
 hw/sd/sd.c             | 419 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 420 insertions(+), 8 deletions(-)

-- 
2.41.0


