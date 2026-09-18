Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5019C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7VZg-0003Hh-GL; Fri, 18 Sep 2026 06:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZb-0003H3-UU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:05 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZZ-0007Z0-RP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso7704435e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789726320; x=1790331120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hnKCbrC0Zs/mZbt9e5kbgGMShsQaKsoLEnuOqJTSAUA=;
 b=eR3dKhoHIPHKdZTGeyIsPXGuFz7UIR9y6KY5WUmO1mAfR3MsA3reqehOMVPCTH0nnZ
 ib8R51Kb9nZr+tuUOcGSv3mGAMZZ1xRRBIy82meT3+oIvh7ujV1e8bAasVkP0VGH5/Ha
 Xu0Z9NH1MXy9b5ELfFivwf4Hl1O6cM3Riphl9E4rKY5jS3ogXZ9+eIulsuH8N6wYR61A
 DZ/XYjMi1yYWEOUSD1l9GcajJk5+kTxkUdR1iJ7X5Cy2oFfQRmXWKtWngEwpyKJLl15v
 Lh0PIxggYhZnACISEDUzbXW6269RS9J9mWzCg2F6/NrSknv0rYlNIJRzuxmy6uZW/ZJX
 E/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726320; x=1790331120;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hnKCbrC0Zs/mZbt9e5kbgGMShsQaKsoLEnuOqJTSAUA=;
 b=KsCWjtWxyohmIJHevm2X+dYxA7iHpOhABPkSuuqgHn/FXzQV+KZgZlYlh6P82xqKA0
 ATiNomvQngMk+Dv17YK0v+6YKVw1OXG2K1zuX0VhZ1msKttm37J0VL1+urP0R4qZlTjC
 gy6GjpG1vqJ0RiRJyptRYDnWH0qTwYvx1610H1rCtYapPZkth8DHAl8n2I2qpHaGFDZ/
 RoctE53IR8kyI5nn1mdrOM+1MMg09BDYTjd4ttyDKnasrxx/VLuNf/Ia8uKtFsjtTeiM
 PbbcggOk4Nk3CIqFwuNPhjWbR+bwDug0nnznG3F8Yq1tkWgrYhj6Lcqq1zxqWMX5qjXK
 0iWA==
X-Gm-Message-State: AFuF++nFwBmJLSzKstQinPTFnqj51EGdqQNsG4E/9V7k28U5TndE9MOy
 ZG/JHYiDfxmAbFxsoy53wTtWRIi9N8I5R/L/dxluqpcyXjggD1pP7uw7hGzxvbfw
X-Gm-Gg: AYBFou399gwQj0jxZDtObeNixTscBExFNLeP1XdH/zTcqYXgzUTwZR3uvl95RiP9zA4
 ZWN7Y4hAg2NGZC1n2Crg++Ek8ODsbmPYQrMF9AnHGavsdb8aZLTip6cWu3f++HdgICVt260Nlti
 i+kBai+lwtgY4bqAvWD6HxTZA0Nu46MEdT6ZKee8A3GKCaBbQeeIhU3tGNrzwH2lGnFd3kqt6tf
 HMMGFRP6XNrzDXcOEHHkdQWkWbHQS+3rvubRmw5VoUV1+dsWngovkx/l8ah75dUjPMUYDncZ33+
 dAMtI/oJvIbkXjQQ6Ph382gQ/3Eb1Yym0mmIFFeHONU6iOKwxiz3NfhShr2mFSb7/XLjc/b7+D+
 73hwOFC2+D9ObEXPzTqiRsHaYZD1D3WoXNDwAgrsizu5wbXkOh1Q82LxAloX7zP9qI2lL/C5BBb
 gPGu5H1VIej5kYqTxbgBT2HmrpxNk8TW1pLADT6QBu5pcAntm8tUreraDRgAEBNECnjUmkHSuJb
 JA3uOv96J79YFCsY2zqoirmEKytudus
X-Received: by 2002:a05:600c:354e:b0:49f:bd3c:bc1d with SMTP id
 5b1f17b1804b1-49fc573a7famr22729335e9.24.1789726319860; 
 Fri, 18 Sep 2026 03:11:59 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc20:5e84:de9d:56c6:df83:7819])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm153886245e9.9.2026.09.18.03.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:11:59 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 0/7] hw/arm: add Beckhoff CX7200 board
Date: Fri, 18 Sep 2026 12:11:51 +0200
Message-ID: <20260918101158.42101-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm2-x10.google.com
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

From: Corvin Köhne <c.koehne@beckhoff.com>

Hi,

Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
platform. This commit series adds the Beckhoff CX7200 as new board variant to
QEMU.

The emulation is able to successfully boot an CX7200 image. The image includes
some self tests executed on every boot. Only the cache self test fails due to
QEMU emulating the cache as always being coherent. The self tests include f.e.:

* Network
* Flash
* CCAT DMA + EEPROM [1]
* TwinCAT (Beckhoff's automation control software [2])

[1] https://github.com/beckhoff/ccat
[2] https://www.beckhoff.com/en-us/products/automation/

YannickV (7):
  hw/misc: Add Beckhoff CCAT device
  hw/arm/xilinx_zynq: Add flash type as machine class property
  hw/misc/zynq_slcr: Add CPU clock outputs and ratios
  hw/timer,cpu: Add Clock API support to A9MPCore timers
  hw/arm/xilinx_zynq: Make PS frequency configurable
  hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
  docs/system/arm: Add support for Beckhoff CX7200

 MAINTAINERS                         |   9 +
 docs/system/arm/beckhoff-cx7200.rst |  68 ++++++
 docs/system/target-arm.rst          |   1 +
 hw/arm/Kconfig                      |   7 +
 hw/arm/beckhoff_CX7200.c            |  79 +++++++
 hw/arm/meson.build                  |   1 +
 hw/arm/xilinx_zynq.c                |  23 +-
 hw/cpu/a9mpcore.c                   |  12 +
 hw/misc/Kconfig                     |   2 +
 hw/misc/beckhoff_ccat.c             | 347 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 hw/misc/zynq_slcr.c                 |  37 +++
 hw/timer/a9gtimer.c                 |  42 +++-
 hw/timer/arm_mptimer.c              |  19 +-
 include/hw/arm/xilinx_zynq.h        |   9 +-
 include/hw/cpu/a9mpcore.h           |   1 +
 include/hw/timer/a9gtimer.h         |   1 +
 include/hw/timer/arm_mptimer.h      |   2 +
 18 files changed, 643 insertions(+), 18 deletions(-)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst
 create mode 100644 hw/arm/beckhoff_CX7200.c
 create mode 100644 hw/misc/beckhoff_ccat.c

-- 
2.47.3


