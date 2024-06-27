Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6576C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs9A-0000xX-En; Thu, 27 Jun 2024 12:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs99-0000x2-Bs
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:38:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs97-0006iA-LZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:38:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4256742f67fso5207105e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506332; x=1720111132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ElTFXrWk1t5GFFl/PEOUB6AD+AcjxlfHmcfeuSqI9GI=;
 b=S34anmV3H/d5LD516RqlN2k+Q8Ek3CoHI0fEr9X5AjfRVwNdQdn9UtdWXEUTLS+tE+
 sgW/25mz+DQFojZMtvcL9f9hDI95u5wDmnHIo0NC/3pXhXw2HQLeD1MB/96nv5bZLxFS
 rW0BNCWZaRiWl7b5Xp/eXpSMJaLaFzOrI1xWOkGTCT7LUavScdYOc9t+KngEp05OZgf1
 eZRkQ4kVdCuy0o2UkzNVIWSKwueIQCqaS4IrOxmT7y1h668GDS4WN+N9yYNtVT/aNSAQ
 TRtIkQgxViZ7xqajlX95JRn+yVjJ1i3FdulteOTQHlzK/LLXHzOiYyYxRgZO+GVUbn59
 wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506332; x=1720111132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ElTFXrWk1t5GFFl/PEOUB6AD+AcjxlfHmcfeuSqI9GI=;
 b=PmISaaEdkVw4VAYvclWQTgpMzJGWbjLktx1F0VLf1u54dTm4Qw2Ga0SIceZQqTZv0b
 G3Ow2xj+OjhRIuye0YBMBtcH8QCQUU1FmeF0Bf4qMbDsm3EQEVkqBWUHfdvo17YGHTXM
 uU/2Uq/5nL2dienGQ/iHqMF0auTdw9youdM6U2mTW7scR/JvsD1DbyDiQxtChCe+oYoP
 6S67/V3yQ1POaSXCBSbuU7LT8v6sb5u6n4WUr5Q2LN6m6R+7r0DjYqfRy7uzsnz9XXi3
 DvS+9kmTFIUuWvmh0WMn56e8kFVcFxjhSa9zEJzLwfI/NGqKAtU6CSqxBO2R9WPqEo5L
 MJbQ==
X-Gm-Message-State: AOJu0YxXCf79/blMq+M1u6VtQWUdOwaDx9Rxw6ndHdjGMifFom18mSDM
 yg2LXe58mt7wLCwUXg0zVQBnkW+rvqgQeuV3TKF95iysGyMFBRSwYMrxzcgg/kDD5s2a2/AfbUL
 gEi0=
X-Google-Smtp-Source: AGHT+IG9nfF0tPZhnt3WuKOnPoEzAAnQP1wFJnO1LyO3oOxnER+0yQH6LJ9aSxhgQr8f7KsXQIYFUA==
X-Received: by 2002:a05:600c:5118:b0:424:a56d:83a with SMTP id
 5b1f17b1804b1-424a56d08fbmr59252955e9.0.1719506330723; 
 Thu, 27 Jun 2024 09:38:50 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc59f5sm35960875e9.42.2024.06.27.09.38.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:38:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 00/11] hw/sd/sdcard: Consolidate SDProto::cmd[] arrays
Date: Thu, 27 Jun 2024 18:38:32 +0200
Message-ID: <20240627163843.81592-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Use the SDProto structure to handle command properties
such name, type, class and handler.
Add stubs for optional commands to ease tracing.

Based-on: <20240627163403.81220-1-philmd@linaro.org>

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Philippe Mathieu-Daudé (11):
  hw/sd/sdcard: Move sd_[a]cmd_name() methods to sd.c
  hw/sd/sdcard: Pass SDState as argument to sd_[a]cmd_name()
  hw/sd/sdcard: Prepare SDProto to contain more fields
  hw/sd/sdcard: Store command name in SDProto
  hw/sd/sdcard: Store command type in SDProto
  hw/sd/sdcard: Store command class in SDProto
  hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
  hw/sd/sdcard: Register generic optional handlers (CMD11 and CMD20)
  hw/sd/sdcard: Register optional handlers from spec v6.00
  hw/sd/sdcard: Register SDIO optional handlers
  hw/sd/sdcard: Register Security Extension optional handlers

 hw/sd/sdmmc-internal.h |  26 ------
 include/hw/sd/sd.h     |   5 +-
 hw/sd/sd.c             | 192 ++++++++++++++++++++++++++++++-----------
 hw/sd/sdmmc-internal.c |  72 ----------------
 hw/sd/meson.build      |   2 +-
 5 files changed, 144 insertions(+), 153 deletions(-)
 delete mode 100644 hw/sd/sdmmc-internal.c

-- 
2.41.0


