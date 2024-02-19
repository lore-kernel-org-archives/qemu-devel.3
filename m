Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDA3C54787
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 23:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcCdv-0001VC-AH; Mon, 19 Feb 2024 18:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcCdr-0001UC-H2; Mon, 19 Feb 2024 18:01:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcCdn-0003zs-Cf; Mon, 19 Feb 2024 18:01:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412698ac6f9so6063615e9.0; 
 Mon, 19 Feb 2024 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708383697; x=1708988497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hfWqgvNo3KgIoNH0dwckl7DaqUjC10wh4x4jZEDgMQ8=;
 b=RcTpCJVbtTKYyrq5rxRTNS7PT+lZFEGE1Z91hsla/KgLYgaeveCMQHwNJx/H1eB1/a
 V2i4PUxFiHPLF0T+/ZinJct9L4UrQ+bd5SlJ6o79MdchnTaLiVdjwvkJ9UCofIKOnr5s
 M85J+m+w+73lc2HN/mFXawPDiLZyCHGPW1RPl7LODBrw97OLgrVVIS080sFpgvjNea5H
 65DsiGtMIs7SpHNifXhjqUlvFzY4njPK9jRmlvKvqCHIsHxc5OwnRBNDDL/vpdtY7P//
 U9wtSRH9k3lJZJBoRmptbxzTGdC4WZR3U1odORZXfNqYzpRTPaEccgYBN8bIffn5mUeO
 qAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708383697; x=1708988497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hfWqgvNo3KgIoNH0dwckl7DaqUjC10wh4x4jZEDgMQ8=;
 b=DrkHv2pyUdTsJIkmDlZVEq1irpYeg3BSNfQnJ67M1eaQzwwtOX2raftQMiXCQumibY
 rkk416nZPWIinsvpOwVcK8w0SvtZlxWLjytHVu5PbzR8gadnHjGVePSd91zvYQIR673D
 nhWoxvIeU5wQCxYyiMwK1TR2iT9xVE3cJkHaxhqrpM3vuZmNYvXEPdm8cc/Y2Pou0v2S
 A3klJlqn1v2ewi4B7Xc+2OEvSvQh979BXnzTFvVtr1rPafGVheqc9AcRXP6q/bQOTf0G
 XjKytMUS3DaPl8II8xyC5UgNqsZqbfy02beU32syx7LffqbrlRZNQGZnQsXJ3D1dxP0M
 6DLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkjABTap4zBEmRe27WNpAJez2lRwS0+KZjvSb725FwIywy9XWWZ8hiq4oeI7ax5Hiu1g/XKhGvfAx0L2ruZpg0xaFx
X-Gm-Message-State: AOJu0YyOR1SQ21dO0YzqxldaoZ4MpDuwUSVvdkXFeQOpVtFkyg06ERng
 Mh526ZkCVZmqiMMOeAeODpZVrbckArBQJb7hXfG8d0syfYsxn93WzEZ94YMa6r8=
X-Google-Smtp-Source: AGHT+IELPDi7/S18y08fHKgKJ4zLHiJWV2VxLh7Y8ZC7k15MBxqYfx9Cc3ufncmoguJpT44OiITKSQ==
X-Received: by 2002:adf:f991:0:b0:33d:5985:5137 with SMTP id
 f17-20020adff991000000b0033d59855137mr2832565wrr.13.1708383696946; 
 Mon, 19 Feb 2024 15:01:36 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c020d00b00410dd253008sm12508206wmi.42.2024.02.19.15.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 15:01:36 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v2 0/3] Add support for I2C in BCM2835 boards
Date: Tue, 20 Feb 2024 04:29:55 +0530
Message-Id: <20240219225958.2421873-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series implements support for the Broadcom Serial Controller used
by BCM2835 based boards for I2C.

[Changes in v2]

- Fixed and simplified writing to status register

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/481
Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Rayhan Faizel (3):
  hw/i2c: Implement Broadcom Serial Controller (BSC)
  hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
  tests/qtest: Add testcase for BCM2835 BSC

 docs/system/arm/raspi.rst            |   1 +
 hw/arm/Kconfig                       |   1 +
 hw/arm/bcm2835_peripherals.c         |  32 +++-
 hw/i2c/Kconfig                       |   4 +
 hw/i2c/bcm2835_i2c.c                 | 274 +++++++++++++++++++++++++++
 hw/i2c/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/i2c/bcm2835_i2c.h         |  78 ++++++++
 tests/qtest/bcm2835-i2c-test.c       | 105 ++++++++++
 tests/qtest/meson.build              |   2 +-
 10 files changed, 496 insertions(+), 5 deletions(-)
 create mode 100644 hw/i2c/bcm2835_i2c.c
 create mode 100644 include/hw/i2c/bcm2835_i2c.h
 create mode 100644 tests/qtest/bcm2835-i2c-test.c

-- 
2.34.1


