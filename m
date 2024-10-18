Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF99D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1njY-0000w2-Cd; Fri, 18 Oct 2024 10:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njW-0000ur-JN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njU-0006wZ-9Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so18152995e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260814; x=1729865614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/fNL/+P00GzFrkc44mI8B5izEIFvMKA1wzL8Dp5K0oo=;
 b=aRhEOBeoDhqZceLfMsHgHe5i8U1GNRYWeMXt52hhLs/c8wL2VZQ5iqGn+FFB2xbZPf
 gV18EesYoYha/2y6K8pVai8AC672sxTFeD32rhZcDbFZwuAC6T1/1wmDLTUTyvi/zh6a
 1VUYzDbgCCYZ4gycFE/M5zcv2f0HCLj20pgCsBvZ6u9u+7nmLh99b/rC5neas+g1q/Cz
 tmhGe+E+l1PdOEkyQBVAjlufkPfZvmnNo96+VNe521C83AWeL9bD9vOMgNMvz8KZFHpC
 t7h5d+QvvcKphKljAefsNn5u7CPxAp0NabrS/tddMiWqqBBPWxyV73TC+Dwgq9HllBEC
 omFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260814; x=1729865614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fNL/+P00GzFrkc44mI8B5izEIFvMKA1wzL8Dp5K0oo=;
 b=ntDi0iRkZTDXRlncfkP1Ug3Cl6+tY1bMRQHVXnC3NnG36un8yOsvAtDnIKWkSW91MH
 lAje8A0tDN5U9hAJ0PNWgiDQKR5P8qKo8d+Q7uqeGebXHK5au45IiO3Miy4lJbMrz7bW
 uB+X2o5lJNHExP8mEw+A6fv8fPzQDJsJSHTKpzZ0noCazK9jHPtGGdBeh9vgKEyPFMfh
 miedSnCogU7q9XZB7C1mSPQXCbJjLWaHeOqNBgw5BLHRTaOA07PBbp9DMlbVaiAcxKMS
 /HoeyogXZH2INLTKAWYzCDWDNEQi7ANK/VZyaCzSGAhwAQXilUtH4oxmgwovJma3Oz5/
 dUwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRdO9A1d+We1vg4PaDyZSRTWxV1swk2QwprmApWQ9xvrTcg2YU3R4msCEjUpys4JtGuW1bSdK7hEQ3@nongnu.org
X-Gm-Message-State: AOJu0Yy7u12Gd4Uo1L814VsRQqFank9DE6jUUgqUduuzquY/m+LRjMyi
 nBtKQwYAg6NxnG0tYxc6x05XmC7Nc3SyawptczGmHBhXUXN0FTTeW9Qsi7Tis5o=
X-Google-Smtp-Source: AGHT+IF8ih5Nltgj+bsD5fQdyBVr3MuNbid1i1lSXzuOHR6QNrtAvhpMePPfayF6zdDZgJoba/UMWw==
X-Received: by 2002:a5d:4f05:0:b0:37d:462a:9bc6 with SMTP id
 ffacd0b85a97d-37eb488633emr1927192f8f.36.1729260814312; 
 Fri, 18 Oct 2024 07:13:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 0/7] docs/system/arm: Provide at least skeleton docs for all
 boards
Date: Fri, 18 Oct 2024 15:13:25 +0100
Message-Id: <20241018141332.942844-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In target-arm.rst there is an apologetic note:

  Unfortunately many of the Arm boards QEMU supports are currently
  undocumented; you can get a complete list by running
  ``qemu-system-aarch64 --machine help``.

However, the situation isn't actually as bleak as this suggests:
over the years we have generally insisted on documentation for
new machine types and have filled in some of the gaps where
there was no documentation for older machine types. Plus we just
deleted a lot of older undocumented or underdocumented boards.

I did a check of all the board types listed in --help and we
really don't have very many left that weren't listed in the
documentation. This series does some cleanup of existing
docs to ensure that every board covered by a .rst file has
a line in the right place in the list that lists the board
name explicitly. It then adds placeholder docs for the remaining
undocumented boards:
 * nuri, smdkc210 (Exynos4 boards)
 * xlnx-zcu102
 * mcimx6ul-evk
 * mcimx7d-sabre

and removes the apologetic note about the list being incomplete.

The placeholder docs are obviously not very useful, but they
mean we at least have an entry in the list for the board
that gives the manufacturer's name for the board, and we
have a place to put expanded information in future if anybody
wants to write it.

Anybody who has more information on the above boards is of
course welcome to expand on the minimal files here :-)

thanks
-- PMM

Peter Maydell (7):
  docs/system/arm/stm32: List olimex-stm32-h405 in document title
  docs/system/arm: Don't use wildcard '*-bmc' in doc titles
  docs/system/arm: Split fby35 out from aspeed.rst
  docs/system/arm: Add placeholder doc for exynos4 boards
  docs/system/arm: Add placeholder doc for xlnx-zcu102 board
  docs/system/arm: Add placeholder docs for mcimx6ul-evk and
    mcimx7d-sabre
  docs/system/target-arm.rst: Remove "many boards are undocumented" note

 MAINTAINERS                       |  5 +++
 docs/system/arm/aspeed.rst        | 52 ++-----------------------------
 docs/system/arm/exynos.rst        |  9 ++++++
 docs/system/arm/fby35.rst         | 47 ++++++++++++++++++++++++++++
 docs/system/arm/mcimx6ul-evk.rst  |  5 +++
 docs/system/arm/mcimx7d-sabre.rst |  5 +++
 docs/system/arm/nuvoton.rst       |  4 +--
 docs/system/arm/stm32.rst         |  4 +--
 docs/system/arm/xlnx-zcu102.rst   | 19 +++++++++++
 docs/system/target-arm.rst        |  9 +++---
 10 files changed, 101 insertions(+), 58 deletions(-)
 create mode 100644 docs/system/arm/exynos.rst
 create mode 100644 docs/system/arm/fby35.rst
 create mode 100644 docs/system/arm/mcimx6ul-evk.rst
 create mode 100644 docs/system/arm/mcimx7d-sabre.rst
 create mode 100644 docs/system/arm/xlnx-zcu102.rst

-- 
2.34.1


