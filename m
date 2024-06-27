Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFA2C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrtb-0003Pp-3c; Thu, 27 Jun 2024 12:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrtW-0003NL-GN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:22:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrtU-00074t-LS
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:22:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36742cc9c12so715702f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505363; x=1720110163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4gNEJ7+L3PN7xtgjGNFEWvLx/YiUkhV8z3R5GUXOwXM=;
 b=SnbK82K2aU4YjlPKHZpoJogl7szfENiVUa3yzQe+gkB5qnvfbRMj1wDKHGFQmVPh63
 BIUeBLJwvdq4tIva0Ry8lziaZhP3iiQxjuikRRm9qTsHZrTbu7t2LBfsWIFzCIi7uiGW
 /4Ubcp9iiwhZCzxF21OyBd05fe33RVX1MOmDQqyp6pZJ5cavHYhhgEuoR5d0dQ9CdC4t
 3EugSBi+p3D6gTsCNnfrb4N1x2JdPjfrFs4mmUhW1pBIrEzRqqo/Sq23InRkjN9Ojuwh
 v5G5yDOOTbeOKjunTn4CHJyphBdfxyIgpNQSu0RBljU/U4RtDtMUVVwP3t7S7YTYFl+8
 Klmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505363; x=1720110163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gNEJ7+L3PN7xtgjGNFEWvLx/YiUkhV8z3R5GUXOwXM=;
 b=AyzoGaPrFjju4zJc9k7bebJn8sBdBPcee4rDE/sjsKgo0d0dVTLmcV3Q2DE72fPww9
 xhLAeIAp/9KrvrLWmgwvDnjJlwFxEiR0MF27/4eCZddky1ZpUhWsUa/QfWHlEuJ1K11l
 et6A5F8UOD9YCsWFeb/IherJgA+Tx/5lCEVgB8iq5KLVvlMxefX8oyQxGE12gwEQuWqM
 IQmhBDGIs4j++bHWM4/jKWgfqh8MiX9rBVVuU1UVqvs7PmFfPnKCG/5Kp35YYzDZNkP5
 tXcYJlx8hrAs/11D/Us1S2Vj6Ul31r09s6/NnWv0yuMyV3FBMnEIec1oOKE7qTUogX03
 aNHQ==
X-Gm-Message-State: AOJu0YzTX4n+eVDSElL1msKga1nm/nKFUandunlFhiodVe6eEitKQN9i
 9ECY6e3Ykao2chVwRY6mlOyW61ZIMIGvGUzNiMin8VQu4NHeXWiSuwgBw1bMsmd+eZyiLCeEpUZ
 jElc=
X-Google-Smtp-Source: AGHT+IFIa7RR/yfurpQ9sh05STVLKtDwSpHdQ/MwtvzYeDm9JS5ZwxGo8rYacq+YWTSpXUWZfqrL/g==
X-Received: by 2002:a5d:5f54:0:b0:367:47e6:c7ce with SMTP id
 ffacd0b85a97d-36747e6cab8mr2190647f8f.6.1719505362779; 
 Thu, 27 Jun 2024 09:22:42 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fdcasm2360704f8f.36.2024.06.27.09.22.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:22:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v3 00/17] hw/sd/sdcard: Accumulation of cleanups and fixes
Date: Thu, 27 Jun 2024 18:22:15 +0200
Message-ID: <20240627162232.80428-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since v2:
- Tested-by from Cédric recorded
- more patches added :S
Since v1:
- various patches merged, few more added

Various SD card cleanups and fixes accumulated over
the years. Various have been useful to help integrating
eMMC support (which will come later).

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Cédric Le Goater (1):
  hw/sd/sdcard: Introduce definitions for EXT_CSD register

Philippe Mathieu-Daudé (16):
  hw/sd/sdcard: Deprecate support for spec v1.10
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Track last command used to help logging
  hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
  hw/sd/sdcard: Trace requested address computed by sd_req_get_address()
  hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
  hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
  hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
  hw/sd/sdcard: Use READY_FOR_DATA definition instead of magic value
  hw/sd/sdcard: Assign SDCardStates enum values
  hw/sd/sdcard: Simplify sd_inactive_state handling
  hw/sd/sdcard: Restrict SWITCH_FUNCTION to sd_transfer_state (CMD6)
  hw/sd/sdcard: Add direct reference to SDProto in SDState
  hw/sd/sdcard: Extract sd_blk_len() helper
  tests/qtest: Disable npcm7xx_sdhci tests using hardcoded RCA
  hw/sd/sdcard: Generate random RCA value

 docs/about/deprecated.rst        |   6 ++
 hw/sd/sdmmc-internal.h           |  97 +++++++++++++++++++++
 hw/sd/sd.c                       | 145 ++++++++++++++++++-------------
 tests/qtest/npcm7xx_sdhci-test.c |   7 ++
 hw/sd/trace-events               |   6 +-
 5 files changed, 199 insertions(+), 62 deletions(-)

-- 
2.41.0


