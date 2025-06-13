Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D0BC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4g3-0001mi-5z; Fri, 13 Jun 2025 09:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4fi-0001iF-VC
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4ff-0006G5-Dn
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so1370091f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1749822133; x=1750426933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bOh9FyN/tuktK0qqnBEKyEfJ25zv1YKKmVceU1nsGvA=;
 b=KAZRp8bGBDHjb0Br4xQzRplloh960GbZAQjWRMDVZkFp8P1fjXd1YvldqIfH/j7Z7R
 jrKCszgsBKT62NXMhk2RX6M5yBsIxgEboT7cz7kZbeeeTPJMso6JszF9HBKRBTBQkyvk
 xU0o43BGm5Ok6eo1a918snuqnbA9jtGOcU+OexURopiAvLeUQVfRTpmRqKRnG28vfid9
 wJXQqc8j5+l3XThRaKJK/M3zWZDsAQNJ6LhaYXNob7mxKVqG+MrRB7qMxllhIem48Yb/
 Byqv7uhKxGuEfng8PAe/vFW1z/ky38nSPRusmq0AmLYVsyaZsAPgWEhRC4CwDKFuAJBc
 HuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749822133; x=1750426933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOh9FyN/tuktK0qqnBEKyEfJ25zv1YKKmVceU1nsGvA=;
 b=XQeeRq7toNHLXM6xqPJEGy4GoGxLz0cACp8KCez0XMcPxHY1vcdoPdmbdoCrToDdYb
 lQAHuJwojwY7C7IBeQEihDX4EirtH2aOOBGGboSuVskpEmSuJImOUgMJhNGoB7kA3CJm
 x0Gp7hVKTOP9PtT5m5XcfZ80h2wKm4tCTs+7ugKyKvvfmf2HRcumHW8BIPP9vlAloP4b
 mmKdtXuad01Te3eumfAajgSFVKRli/zImSDAfDHPsnsaNZ6VNilZIVD5aqY2hzqcsWFw
 rBZarAVLanSLxl/o+JRlX1Nd6K87nfibQWCJ2vmuBSJs4TShhvTw4ypJ0XhrqJdIaVvO
 89bg==
X-Gm-Message-State: AOJu0YykZKrCu2LAAE+rmXVSzz2cFYJ1Lrwa9VEFa8iKGwiaaYbymK6Z
 N4jtvNWxY7YVzFxRAp3fx8lsxfGYxeEgvdzwCIpn5UTJpApgC4YAvqwmIwkoDa0jhW40V2EhkYd
 K2xU=
X-Gm-Gg: ASbGncsLDQvTPKPyiNsOf6Gky75nDiiitHB3knx9sAjGu9npDqHm7L0VstDNn2j9lGG
 DFmSAef0wGG0o66NZcwtLTkIb0QHiqGmU1AXS4bkg5nD+0FednKqu5J3MTGd5rRlOOwCyLBhsQH
 1RDMDPEsgkJ2HnoXFksUPj9mBGPJPcW+UufhLjIS3SFvAo+sYBySe/3dwtjYWCU3I/ecWNLh2Va
 1vf7ke0i967HqO9rFEmGotm6rZt0QHHKIRQ6J0pYlXudLt1ad0F5vJ+F96GW815kGPfNA28ETkP
 +ZYkulg5hyOmzBna86Xr7zUnwPYXuv9ICtgiqBmfXsFMfH005gsF39Of+Udxg1uR2ZvM/cQ=
X-Google-Smtp-Source: AGHT+IGeaJw6KB8F8wNo65lN7hd23sZOp2iJLtEzcabKDv7v3zvOHAUUtwHsCBWZTolgWnDvzOOz+A==
X-Received: by 2002:a05:6000:4285:b0:3a4:ddd6:427f with SMTP id
 ffacd0b85a97d-3a56875d7e3mr2919462f8f.35.1749822132782; 
 Fri, 13 Jun 2025 06:42:12 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8100:3d00:9e4f:bbb8:63a3:78f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224795sm53258035e9.7.2025.06.13.06.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:42:12 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 0/3] xlnx-zynqmp: add support to boot on RPUs
Date: Fri, 13 Jun 2025 15:42:05 +0200
Message-Id: <20250613134208.1509436-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x435.google.com
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

This series enhances Xilinx ZynqMP support to allow booting on RPUs.

It was validated with home-made binaries. FreeRTOS was tested but without
success: outputs/IRQ seems broken. AFAICT, FreeRTOS is expecting Xilinx's
QEMU thus I didn't investigate further. I'd still like advice on the 3rd
patch ("wire a second GIC") since it could be related to it.

Changes sinve v2:
 - address review for patch 3 (typo, create function to compute num_rpus,
   simplify num_rpus usage).
 - remove patch 4 (swapping cluster ids)

Changes since v1:
 - add doc for "first-cpu-index" new property in arm_gic.h.

Clément Chigot (1):
  hw/arm: make cpu targeted by arm_load_kernel the primary CPU.

Frederic Konrad (2):
  hw/intc/arm_gic: introduce a first-cpu-index property
  hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5

 hw/arm/boot.c                    |  15 +++--
 hw/arm/xlnx-zynqmp.c             | 103 ++++++++++++++++++++++++++++---
 hw/intc/arm_gic.c                |   2 +-
 hw/intc/arm_gic_common.c         |   1 +
 include/hw/arm/boot.h            |   3 +
 include/hw/arm/xlnx-zynqmp.h     |   5 ++
 include/hw/intc/arm_gic.h        |   2 +
 include/hw/intc/arm_gic_common.h |   2 +
 8 files changed, 114 insertions(+), 19 deletions(-)

-- 
2.34.1


