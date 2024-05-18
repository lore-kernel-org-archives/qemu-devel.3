Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D272C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 20:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8QIR-0003cx-PL; Sat, 18 May 2024 16:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8QIQ-0003ca-7f; Sat, 18 May 2024 16:04:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8QIO-000628-M4; Sat, 18 May 2024 16:04:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eeb1a4c10aso41180625ad.3; 
 Sat, 18 May 2024 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716062682; x=1716667482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BQxp37GhYhVHDU/IEijSHQWWh4OTP5IYepXnlACFcnw=;
 b=gpZottmwH2Chk+eZzbfh7qZF57m9Pvlke3IV7MJvy1su5sfO0UxQGQYEA+r3enbh5/
 mFpIseoScCTSal9pMP/cQgBJO7yEtJ31OVPAbkwJIiSGsu0RRnQt78RLzG5umyrh+EUR
 VJjqKAXfur096I5lRDu9RI/6m1X5DiYwDa3gjuuNNw84bCenxFkAZr2Nc1dWATEzyGFq
 IOep4DL/gaGxl294407xPO1Z0CB2f/a1U7WJFKvaQ15dJ3mYYQrPo4b9pAt/8Xx6wYuw
 fD8tjkaFZ9WDJCQNpT3IjvBtyI0t4QX2DdZx6z16vxAPhafkPZN++uFSOblwRowBtOAZ
 nSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716062682; x=1716667482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQxp37GhYhVHDU/IEijSHQWWh4OTP5IYepXnlACFcnw=;
 b=ILHm+PNurCyczZgTcDuawrO1Xp3135daqrQet4LcMfwHcxifiozFojAvyE7TaQTPGj
 1ie85NWnNppKd2/bKRytTN6vHMZcBRgErDx3tsF5Ki6gDHESpSPzgUMsKFrdSrIlZxcG
 M2vrvNn2K6CiZcExdk6JM8yaqoe7l51+OpkvQ3MpLPDInAxOnnjyUBM+EDr3W4HExCRq
 Nlwb0KTqi2NDZeUPKCGzD3B0y3N94jPh99zIozcJluKKqw4Hh8/D1rz919SzRvq7upaK
 rC4VfhWY5S8hTbhZdJBUdWK+vvmdtS3aLfv7wlMIEJTyFFBsjTTUCT/HFiA2bT2qEVsO
 TEOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRnCVd0TIHSJfzIH7LKc09H8RVtzreYJtUUDuxEXfDFe1aXW63EvcT9kk/FRZXiXFkk3+hpPE5RhhsmmgMTwQicbJB
X-Gm-Message-State: AOJu0YwUn4erOmlu/Oq3Fo+g/CMC2StjcDyDqvqe07Y9PeEwSNrGK0DH
 3UeVe4KkJKIlo/vS1f8+Qr30+HeRzDW5HDARrDxxJvVHLwK1rqBduBMbiQ==
X-Google-Smtp-Source: AGHT+IEs3RwEmEKw39hbJGHNyZWZ/WiYKoktCNqhudf8OVhqHLVR5WYlfK6j04+qZmPwM+eiV++76Q==
X-Received: by 2002:a05:6a00:1943:b0:6f4:46ea:2f26 with SMTP id
 d2e1a72fcca58-6f4e02d32f9mr24330148b3a.15.1716062681804; 
 Sat, 18 May 2024 13:04:41 -0700 (PDT)
Received: from localhost.localdomain ([49.47.193.102])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ae0de0sm16637481b3a.116.2024.05.18.13.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 13:04:41 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v2 0/3] Initial support for One-Time Programmable Memory (OTP)
 in BCM2835
Date: Sun, 19 May 2024 01:31:33 +0530
Message-Id: <20240518200136.1448672-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

All BCM2835 boards have on-board OTP memory with 66 32-bit rows. Usually,
its contents are accessible via mailbox commands.

[Changes in v2]

- Replace read/write with get/set in bcm2835_otp.c.
- Use impl instead of valid in bcm2835_otp.c.
- Replace all constant values with macros defined in bcm2835_otp.h.
- Change memory region size of OTP device to 0x80.
- After further testing on a real Raspberry Pi 3, I noticed a few things
contrary to my initial assumptions:
-- The customer OTP lock bit is bit 6 of row 32, NOT bit 30 of row 30. This is
currently undocumented to my knowledge.
-- The above lock indeed applies to the private key as well.

Rayhan Faizel (3):
  hw/nvram: Add BCM2835 OTP device
  hw/arm: Connect OTP device to BCM2835
  hw/misc: Implement mailbox properties for customer OTP and device
    specific private keys

 hw/arm/bcm2835_peripherals.c         |  15 ++-
 hw/misc/bcm2835_property.c           |  87 +++++++++++++
 hw/nvram/bcm2835_otp.c               | 187 +++++++++++++++++++++++++++
 hw/nvram/meson.build                 |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/arm/raspberrypi-fw-defs.h |   2 +
 include/hw/misc/bcm2835_property.h   |   2 +
 include/hw/nvram/bcm2835_otp.h       |  67 ++++++++++
 8 files changed, 362 insertions(+), 2 deletions(-)
 create mode 100644 hw/nvram/bcm2835_otp.c
 create mode 100644 include/hw/nvram/bcm2835_otp.h

-- 
2.34.1


