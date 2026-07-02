Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9DBC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKXH-0002wB-1I; Thu, 02 Jul 2026 12:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKX9-0002qk-T8; Thu, 02 Jul 2026 12:45:03 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKX8-00038x-4g; Thu, 02 Jul 2026 12:45:03 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 006722003D6;
 Thu,  2 Jul 2026 18:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783010697;
 bh=TG5kydt9Wp3FlmPphyzQNFzJaZ2564ZWIrgvy4ZnNPE=;
 h=From:Subject:Date:To:Cc:From;
 b=N6FOlFnRJS8XJTaMjKgSjswUbMG2vakqjZsjV+/Dw1ytPd1aOYJMpRUY8pS0qywxH
 fmh5dUUhIBFCZQVBD+Rb5S0gr43P42KDgYa3xgRKYsf/whsgGXVNWxVef7gsrZxbHj
 UcuIw0rDQzEHX5Vp/Iw8R/wUw/1j8mH1CaxWIGne1xYUIE8tIFhfW4UFgqBSvjDNvC
 geUcXQx8UrRLfUSzL6+aZs20e9oD9qk3lVI3NW8Uvhyq8TTXNXG7zed5Z3Puem5x/w
 kH0YrR3DMgOrJg2jqvqxMqMgg33PkBOvnqyW+illc4zk/2Zikzqer7/KDYZzYYmGH9
 cExnwwJFrzH+Q==
From: Emmanuel BLOT <emmanuel.blot@free.fr>
Subject: [PATCH 0/4] hw/arm/aspeed: Add sanmiguel-bmc machine type
Date: Thu, 02 Jul 2026 18:44:27 +0200
Message-Id: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMj3eLEvNzM9NLUHN2k3GRdEwuLJHMLSwvLNBNTJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAGs7ZI1xAAAA
X-Change-ID: 20260702-sanmiguel-bmc-488b78989f45
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010682; l=992;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=TG5kydt9Wp3FlmPphyzQNFzJaZ2564ZWIrgvy4ZnNPE=;
 b=UaeeHp2+16bXjttkpnpED7KCq84RY6k/eGoJND2g+mvivV0KhLOGQzXkoCnijFfNin9KaICEa
 cs45qxC1kRxDl4No/ArMXvPZyCynqL6/xZFfaA+x0+6845DVeD2NLl1
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

- Add initial support with I2C EEPROM populated with FRU data
- OpenBMC boot test with DT type check

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel BLOT (2):
      hw/arm: sanmiguel-bmc: add Facebook SanMiguel BMC machine
      hw/arm: sanmiguel-bmc: populate EEPROM data

Emmanuel Blot (2):
      tests/functional: aspeed: optionally check the device tree model on boot
      tests/functional: arm: add SanMiguel BMC boot test

 hw/arm/aspeed_ast2600_sanmiguel.c             | 407 ++++++++++++++++++++++++++
 hw/arm/meson.build                            |   1 +
 tests/functional/arm/meson.build              |   2 +
 tests/functional/arm/test_aspeed_sanmiguel.py |  33 +++
 tests/functional/aspeed.py                    |   4 +-
 5 files changed, 446 insertions(+), 1 deletion(-)
---
base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
change-id: 20260702-sanmiguel-bmc-488b78989f45

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


