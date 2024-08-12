Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07833C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 12:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdTsn-0002S6-4Q; Mon, 12 Aug 2024 08:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdTsg-0002Ph-Qi
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:10:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdTsX-0003jU-I4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:10:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so29217315e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723464623; x=1724069423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xIbgZX1GHg1Z13uZKqim3VCtutqFmMYk6z/bW+QcsX8=;
 b=NA3DpOOf74qYsbjzedg8DQBKSN9T9vIZ+FTmlmTIE8ssfw0yLy02FjXHnoBe9OQabd
 RFM82ApHZBwV6/HThUZF4mr2qVjBBdwYfnHW6M3dozGjwc/GvdoeSAvTduW2I/37++AK
 3vkb24w+BlUfMiolm4o+xKykKfkgt/N4VCCGqGnbkz7u94Xp0htS5zvgWjqT12VvH+tH
 BWs+NcuMoOF4ttxRG48C73OO9QcJb2gcR1egU4FmvJ5nJ8JPwkPq6M4NlwbsrBEbtxqy
 Kty6DDgCB3Jg9KrrDpPj07YdJLaBniNTGVTufFL/A01zZHh/uWohc2YZHAVWUi2SbihW
 WjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723464623; x=1724069423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIbgZX1GHg1Z13uZKqim3VCtutqFmMYk6z/bW+QcsX8=;
 b=RkNdFEE4dB/1VE/f4HWsOYR1d7w51VV8kIa9/bgp9rdQD2kE7sc+i5c4/mkLbXS4Sy
 p+NaS9yRBYofP6xqO+Vab/QoHC6IvnqMChrTWUpPFtd2gGMWI/U8ath3jEQsEwhjWC0u
 7XP2P1f1YHzRF5/38eWGy044tf459cLURdlI+jRwzUNwvLX29Vi/mAdY1eeNerrYzdPe
 OO0sy5rhATYWHLXfGIq5h6STu0x5mzG6fzghYYKiA+/Y/l/U6XkcRQRj/Qk1qb5AIx2g
 O56BWl9VDkIGLaZ3CHTCWUrR/2qez975uh65UyKqBgnWgpmmDbMlPo8QwIGEJfNKj6PH
 rZXA==
X-Gm-Message-State: AOJu0YxH0lDjJRW+pyeRW0lY+eVl2BqHKNKWtvD5PwtwF+R5dSa/QlIn
 dU+HG3B4TBoe6Pv+MZuxXIjZibZRP4V2UkdjeVD6eOQVxFVOaGgIdnv7fJJe0uSQ2zXKBIepwEl
 u
X-Google-Smtp-Source: AGHT+IFiypq1QMZjMGu/TqyduftyJRYD10cYfDAmAs5qnW3c6/vprjxbM/Q4YYF82NkxTtIKlGPNJg==
X-Received: by 2002:a05:600c:1d81:b0:428:10e3:a000 with SMTP id
 5b1f17b1804b1-429d48a576dmr1454795e9.37.1723464623158; 
 Mon, 12 Aug 2024 05:10:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a5382sm7268096f8f.112.2024.08.12.05.10.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 05:10:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/10] target-arm queue
Date: Mon, 12 Aug 2024 13:10:21 +0100
Message-Id: <20240812121021.1667713-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

v2: dropped PMCCNTR patch

The following changes since commit 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23:

  Merge tag 'pull-nbd-2024-08-08' of https://repo.or.cz/qemu/ericb into staging (2024-08-09 08:40:37 +1000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240812

for you to fetch changes up to ed5031ad5d4c4c3b6eee6ab21aa95ccfc9dffdd4:

  arm/virt: place power button pin number on a define (2024-08-12 11:40:16 +0100)

----------------------------------------------------------------
 * Fix BTI versus CF_PCREL
 * include: Fix typo in name of MAKE_IDENTFIER macro
 * docs: Various txt-to-rST conversions
 * hw/core/ptimer: fix timer zero period condition for freq > 1GHz
 * arm/virt: place power button pin number on a define

----------------------------------------------------------------
Eric Blake (1):
      docs: Typo fix in live disk backup

Jianzhou Yue (1):
      hw/core/ptimer: fix timer zero period condition for freq > 1GHz

Mauro Carvalho Chehab (1):
      arm/virt: place power button pin number on a define

Peter Maydell (6):
      include: Fix typo in name of MAKE_IDENTFIER macro
      docs/specs/rocker.txt: Convert to rST
      docs/interop/nbd.txt: Convert to rST
      docs/interop/parallels.txt: Convert to rST
      docs/interop/prl-xml.txt: Convert to rST
      docs/interop/prl-xml.rst: Fix minor grammar nits

Richard Henderson (1):
      target/arm: Fix BTI versus CF_PCREL

 MAINTAINERS                                   |   7 +-
 docs/interop/index.rst                        |   3 +
 docs/interop/live-block-operations.rst        |   4 +-
 docs/interop/nbd.rst                          |  89 ++++++++++++
 docs/interop/nbd.txt                          |  72 ----------
 docs/interop/{parallels.txt => parallels.rst} | 108 ++++++++-------
 docs/interop/prl-xml.rst                      | 192 ++++++++++++++++++++++++++
 docs/interop/prl-xml.txt                      | 158 ---------------------
 docs/specs/index.rst                          |   1 +
 docs/specs/{rocker.txt => rocker.rst}         | 181 ++++++++++++------------
 include/hw/arm/virt.h                         |   3 +
 include/qapi/qmp/qobject.h                    |   2 +-
 include/qemu/atomic.h                         |   2 +-
 include/qemu/compiler.h                       |   2 +-
 include/qemu/osdep.h                          |   6 +-
 target/arm/tcg/helper-a64.h                   |   3 +
 target/arm/tcg/translate.h                    |   2 -
 hw/arm/virt-acpi-build.c                      |   6 +-
 hw/arm/virt.c                                 |   7 +-
 hw/core/ptimer.c                              |   4 +-
 target/arm/tcg/helper-a64.c                   |  39 ++++++
 target/arm/tcg/translate-a64.c                |  64 ++-------
 tests/unit/ptimer-test.c                      |  33 +++++
 23 files changed, 547 insertions(+), 441 deletions(-)
 create mode 100644 docs/interop/nbd.rst
 delete mode 100644 docs/interop/nbd.txt
 rename docs/interop/{parallels.txt => parallels.rst} (72%)
 create mode 100644 docs/interop/prl-xml.rst
 delete mode 100644 docs/interop/prl-xml.txt
 rename docs/specs/{rocker.txt => rocker.rst} (91%)

