Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5ADCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu7T-0002yB-CY; Fri, 15 May 2026 11:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7P-0002xm-NS
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7N-0006Ke-15
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so6007875e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778857581; x=1779462381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NTp9qB2AUfuzoLzxM+fbdvCoWx5A4KcOT8YAPOKWhRk=;
 b=L7o+UKlWV3nnnnFZrAiZrkXZ/HW6EbIJisNq0i8+5TEZYLyUVhOUxrN1Ls5z8QlEyn
 RmzKngfyrdq2N+LmqwwuyRAYy4Qb7j8+nG2NdkzzmB4nCYjjwOdKKWrXX3siYUpogyBw
 ne5mzQipOvY3zxSvYWNesHsqoSdpHstJjjadOMiNFXnmrZEoGsnWuaMSn003XbPmwycT
 xqiBvwEBYAc+iizq4Y2HcB5w0vvuPKaSR7NUAsX2K7JhMV1vZgCAB3AdlEXgta4CkyLZ
 X7Jt3Z/LscrxBnGOQl8qGZQ2TSqchLhpsYpL3v/SVkkIhul9lWNE+t+VjNAlk/HsUUXb
 xX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857581; x=1779462381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTp9qB2AUfuzoLzxM+fbdvCoWx5A4KcOT8YAPOKWhRk=;
 b=MtGoBMrqPpGNI0cSCEka27wKGPg5hSHUFAuz8d6qKxlqdOTeP7urnwOi0z5Fs3W/BR
 nlHt42/pmtQhum3r4TshZpjZmhI26BUanoiNVnlJzFWc8AlNqVZe11wCFiq4UU19k/IN
 QJQQpD6/BiR/nV/peGMA/x8dqI6REjgBMW7LK51oRepJdXfcy3B3jkBrHzrAFz5eaoij
 4KEjsYxnszTvtyhlp3Cwmyqu88TAOkYQh2LiajAWiFnJM1x+rTVJrAVic/b2h/VaGl8o
 IcUDuaPsKGxjM6IH3tjEFE1WqutsZlWUELtk2FdZnt2wWYSyFL2EI51g4pKCuECvCTjs
 4sQQ==
X-Gm-Message-State: AOJu0YxeyI5n3toEYtxOx6BHltSmFIGsDahfWdjedZcXLp77apVnOsCV
 BO0cvp9OwJanYqUD4wrROUaEDOBxf0x+6b8+bvbkH1owXyT0GLxQwhFyLbA5d77GWCbYxtuT2mv
 Ow62ylEA=
X-Gm-Gg: Acq92OHRyOa2I0p0wjqBblWwKnnzcmfila91fA4yUhHL4zLkS7W7vMK8eKRIj+slIEx
 z7ZVeDA7x1S4iVNkZJMtW1VL1Hls2pZ2jzfdcYbAmZx6KPnsan9FgnQDwxSQakowb9cweHCUMxR
 lqsTSWKBnuLR23Es5ND/kabszwux4VK+7KAJx+nZ+VO53556M9Qpd4AN5CrlXia0a5ShiC1Tx++
 6Uzq5rQimw3/1ScVZuH7Vj4E63P0PB5f09V/fepeub+kXu3EROdoXa65Q6yKnnZEOXYufd2AOdl
 yD2oUn6x56V08Wdswgn1WxqmYI6LwLZLiM3O/ohjH559BMqyp9ebNZdfYrerPXb3hx4tREK0RrS
 XiDHPT0TceYwYchP5MWx3z+pXVW/4AaMneprIzwkbj96xuXxy9muL3wQT4CbPP0BqqLG+75Vxsx
 CFATSubcjevMjPvukOybi1ihTRISLlIQdJc1ZhZ5x1T8dJ
X-Received: by 2002:a05:600c:1d09:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-48fe537fb44mr52091765e9.11.1778857581225; 
 Fri, 15 May 2026 08:06:21 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab290e1sm29444715e9.2.2026.05.15.08.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:06:20 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>
Subject: [PATCH v4 0/5] initial support for yosemite v4
Date: Fri, 15 May 2026 16:57:57 +0200
Message-ID: <20260515150610.381066-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x331.google.com
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

Add initial and incomplete support for yosemite v4 BMC-side emulation.

As part of this effort 3 new sensor ICs are added.

Thanks to Cedric and Titus for review of patchset 3.

Summary of changes from patchset 3:

- changed commit message for functional test to be more clear
- amended my .gitconfig to present changes matching qemu orderfil
- max31790: fix indent to 4 spaces
- max31790: removed extra header file from patch
- max11615: rename variable to channel_select to match qemu coding style
- max11615: fix typo
- all sensors in this series: fix reset handling. Set dc->legacy_reset
  instead of manually calling reset function in realize.
  I was mildly confused because both tmp105 and tmp421 call a reset
  function in their realize functions. Anyways, hopefully i did it right
  this time :)

Alexander Hansen (5):
  ast2600: yosemite4 initial support
  ast2600: yosemite4 functional test
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615
  hw/sensor: support Texas Instruments ADC128D818

 MAINTAINERS                              |   3 +
 include/hw/sensor/adc128d818.h           |  20 +
 include/hw/sensor/max11615.h             |  21 +
 hw/arm/aspeed_ast2600_fby4.c             | 280 +++++++++++++
 hw/sensor/adc128d818.c                   | 410 +++++++++++++++++++
 hw/sensor/max11615.c                     | 206 ++++++++++
 hw/sensor/max31790.c                     | 501 +++++++++++++++++++++++
 hw/arm/Kconfig                           |   3 +
 hw/arm/meson.build                       |   1 +
 hw/sensor/Kconfig                        |  12 +
 hw/sensor/meson.build                    |   3 +
 hw/sensor/trace-events                   |  24 ++
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py |  80 ++++
 14 files changed, 1566 insertions(+)
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/adc128d818.c
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

-- 
2.54.0


