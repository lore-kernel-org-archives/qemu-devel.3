Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241E0CD3445
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 00:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLRc-000065-Dc; Wed, 12 Nov 2025 19:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uykVaQYKCrIqmTafrYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--yubinz.bounces.google.com>)
 id 1vJLR9-0008DK-3f
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:43:44 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uykVaQYKCrIqmTafrYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--yubinz.bounces.google.com>)
 id 1vJLR7-0006Ma-Hy
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:43:42 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-297ddb3c707so2139355ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 16:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762994619; x=1763599419; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gZs1F11NQ7ln9ItBqgDiU6ms6Y1JXhtTywmYjKyFciQ=;
 b=XsWCjlWNRrbkmN3JM1lw0yVW/Xi4bLkty3czncB/NbIsus/86nJ4RgRKEh+PVdcZu8
 cBPBtuqU4pb75QcxxQM29ZE+k9wWxxEibyGAZ7Ia/PaGDLCiiEe8jRfH9bMBwDQtGA2C
 KdJNqafCcl/ptQnEvGi+VBStCQvMWyl9gg3lMoZzq7ncUB14UCKXG+owE+/H8AyqSWpR
 NdLf9CvyOochIYwaDM22+1M2aK9Y/5Kqpb+4gYiT6e1je4JSE7q7VGNnNkGoVmMzRAHU
 6uGleWoP1pmEpJrgO+qCzcqBwY4cxWoqTsr33wmWkAFaiqVbWQCGYGAm4DrUjHb6ANJH
 yqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762994619; x=1763599419;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZs1F11NQ7ln9ItBqgDiU6ms6Y1JXhtTywmYjKyFciQ=;
 b=a3sP7W4YndCUKm9h1d/GnLjB4PWD6NlpnXgr/Di484XvDDOxOEfBs4j3gTQAdhKwJL
 r0srY3wspq4xWf6iyopIeVkWJfPBRUBrVF3UwZubN6LLkkIbOFi6KyiF+k+XkNX8S3kG
 zqM54cIcKCtf/FoSPtwSM2Gfn+4JueiTVsqyZnxaThAR/DhZS+lInurtEaapIflQWGbx
 knpEGt9yvcCoG4ky5g/jsCXObEWdNXKwOn+eABZCiJqLyUGrWuOqhE9JN5ej6JlM6aR9
 hd2q75dQsCuhtmAZzhVslUB3ouRvUHGd9QyvEUHm+R6Tayuq0wEtK0lKE28RfHgF/2qy
 hlmA==
X-Gm-Message-State: AOJu0YzagL1ZLNc3Y4+8Njg3IeD9fmJ9E+fcpDLpQjCB35F/0ATPPU6z
 sotYEAzY14Xc95zuyb4ivaQfF9Ps0IrjM386m1Y2/1qmoA5xvEnrx+NG44LW59kV4fUCXFDqqrb
 rplw6j6jiTm6hzr2xDstv8RHvnkMJxDQwUGQWj90FXEC4RhcUHv+HyoyzbmcOaFt1QSkFxFmbd7
 U9AFC5xHt3wmAjUtPHlo0cK48AjFWKsQUyWa0=
X-Google-Smtp-Source: AGHT+IHNBG46S7Bzz1NYAdpCsQTjmlfTxGXm3pspEX+A9e6VDUorCGtjs3yMV4D2pob4n2yIfAMuu/9q6NI=
X-Received: from dybco9.prod.google.com ([2002:a05:7300:a189:b0:2a4:480f:9430])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:28c:b0:295:5da6:5ff3
 with SMTP id d9443c01a7336-2984ec8bdd8mr61711475ad.0.1762994619131; Wed, 12
 Nov 2025 16:43:39 -0800 (PST)
Date: Thu, 13 Nov 2025 00:43:27 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK8pFWkC/32NQQ7CIBBFr9LM2jGASK0r72G6QDpSkra0UImm4
 e5iD+DyveS/v0Gk4CjCtdogUHLR+amAOFRgej1ZQtcVBsHEmTVc4fLS06pxqfmARHPwY0RGD6O
 IyYvqaijLOdDTvffqvS3cu7j68NlPEv/Z/73EkeFJlV4jjJGS36z3dqCj8SO0OecvcQ6d9rcAA AA=
X-Change-Id: 20250916-quanta-q71l-eeproms-0ebc6e0486d7
X-Mailer: b4 0.14.2
Message-ID: <20251113-quanta-q71l-eeproms-v2-0-e72451b974b0@google.com>
Subject: [PATCH v2 0/3] Add drive-backed EEPROM support to quanta-q71l
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>, 
 Hao Wu <wuhaotsh@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3uykVaQYKCrIqmTafrYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Overview of Changes:
This two-patch series introduces I2C EEPROM devices (AT24C64) to the
quanta-q71l machine model, representing the Baseboard, Frontpanel,
BIOS, PDB, and BMC FRUs.

Improvement to QEMU:
These changes enhance the simulation fidelity of the quanta-q71l board.
By modeling the FRU EEPROMs and allowing them to be backed by drives.

Impact (Before/After):
Before:
The quanta-q71l machine model did not include the I2C EEPROMs for FRU
data storage.

After:
The EEPROMs are added to the appropriate I2C buses at their respective
addresses. Each eeprom now can be associated with a QEMU driver backend
by using the `-drive`option.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
Changes in v2:
Include a patch to add a auxiliary function in the at24c eeprom module to assign unique
unit numbers for each eeproms in each board

- Link to v1: https://lore.kernel.org/qemu-devel/20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com

---
Hao Wu (1):
      hw/nvram: Add a new auxiliary function to init at24c eeprom

Patrick Venture (2):
      hw/arm: add eeproms to quanta-q7l1 board
      hw/arm: enable eeproms for quanta-q71l

 hw/arm/aspeed.c                 | 15 ++++++++++-----
 hw/nvram/eeprom_at24c.c         | 17 +++++++++++++++++
 include/hw/nvram/eeprom_at24c.h |  4 ++++
 3 files changed, 31 insertions(+), 5 deletions(-)
---
base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
change-id: 20250916-quanta-q71l-eeproms-0ebc6e0486d7

Best regards,
-- 
Yubin Zou <yubinz@google.com>


