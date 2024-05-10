Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3F6C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R4Q-0006x7-Ms; Fri, 10 May 2024 10:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4O-0006wj-Om; Fri, 10 May 2024 10:17:56 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4C-0001SX-Po; Fri, 10 May 2024 10:17:56 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59b49162aeso505146366b.3; 
 Fri, 10 May 2024 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350661; x=1715955461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0X08T+k5cn0w6oTynEC8kV54PftNRadYl3T03e4UFIc=;
 b=NGa/x6trkJClzW6nvANL6p1BdYrVn/50eAzgRPWXjOKx09/Gbi/BpyIgtgH/VDtIp8
 cCyNaVS8lz+uWoZdS3kIVORCEKlzXqSM1CIPTUiC6SJzFfVN2tGPE0qtM0OyDj5wbEHB
 VCgbvpB00gXmMGolsggnH0o/iYyz4aGYTuakR3h/mD6YentR9n70AlkmpkHPFVA8cb8T
 xwvneT6gIWhvB+DnWvjr/Q5D1cbanxBr1r28Gcg7us+fE8wgH/0gVPNFTq6HZRVZr5ox
 5M8p8pca0I+mrunzcgr/u6Dzf0FM+ax45voT4cSggsKwhHkI8RF8KbOltaLr5044tFl5
 QyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350661; x=1715955461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0X08T+k5cn0w6oTynEC8kV54PftNRadYl3T03e4UFIc=;
 b=f+2smpeYlST2DssYwjnuFYAXKUWUxl1aCTiAtpOLCrq0TtWUxYNDOJsvIsneYmr4af
 2yal4d6u2f3ngfcIMbvryx6/oXbwawQxoSwsmVYfPgkamq1KLq5aQ7DdNQGBXWaeu+jo
 Dv3w9aPGvvjCDoIM1rOvKil4lzU7mU+JUJ8kYepJXlEPcxTy6fyhJDzW9m3S9/1vGwh0
 6VlDci/Uaq/Ro7GbsEb1UZwfBPr3/BUTYAVVhnNUie0aTs8PbyyX/DMz0BMCGtdFrtIz
 /sp+g/rEm/YLsycMTs0xDAgG54k+kidvfeUJxgPsq9yrhVv20elg7+/V4/e4CXe4RVZ9
 5DiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOFHDs4jib9vRwC+GtdY0wjIDJ/fXUSzTXhWcNZfWAOgb2gYxQxm5HNL/mcW8sG1yTMQgpNwMc9vnL0Q62Ubeemi7w
X-Gm-Message-State: AOJu0YwLDBG3MslzcA9+/ComeVIfKlCJm8J4P+wYXGD2vXbHIx3E3Q7R
 TtbHo8WBAP93efQLfzsH+8/YaMloSly/Q5MKRj3n2QS1gzKmP1rx2rUTkg==
X-Google-Smtp-Source: AGHT+IHKNDGc61uzMkB/jkVuYUXC3kZI+qLC9aAe08xWaeUBbvOnaIK6XoQO5fAPCBnDSurK3+ihWQ==
X-Received: by 2002:a17:906:b7c6:b0:a59:ef1f:83e4 with SMTP id
 a640c23a62f3a-a5a2d6417f0mr180172466b.59.1715350660801; 
 Fri, 10 May 2024 07:17:40 -0700 (PDT)
Received: from localhost.localdomain ([212.70.119.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891f6esm190093466b.54.2024.05.10.07.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:17:40 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 0/3] Initial support for One-Time Programmable Memory (OTP) in
 BCM2835
Date: Fri, 10 May 2024 19:40:07 +0530
Message-Id: <20240510141010.656561-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All BCM2835 boards have on-board OTP memory with 66 32-bit rows. Usually,
its contents are accessible via mailbox commands.

Rayhan Faizel (3):
  hw/nvram: Add BCM2835 OTP device
  hw/arm: Connect OTP device to BCM2835
  hw/misc: Implement mailbox properties for customer OTP and device
    specific private keys

 hw/arm/bcm2835_peripherals.c         |  15 ++-
 hw/misc/bcm2835_property.c           |  71 ++++++++++
 hw/nvram/bcm2835_otp.c               | 187 +++++++++++++++++++++++++++
 hw/nvram/meson.build                 |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/arm/raspberrypi-fw-defs.h |   2 +
 include/hw/misc/bcm2835_property.h   |   2 +
 include/hw/nvram/bcm2835_otp.h       |  43 ++++++
 8 files changed, 322 insertions(+), 2 deletions(-)
 create mode 100644 hw/nvram/bcm2835_otp.c
 create mode 100644 include/hw/nvram/bcm2835_otp.h

-- 
2.34.1


