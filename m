Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C361C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzal-00039t-0H; Wed, 20 Mar 2024 13:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzah-00035C-U8; Wed, 20 Mar 2024 13:19:03 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzag-0006cl-5D; Wed, 20 Mar 2024 13:19:03 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-568a53d2ce0so51176a12.0; 
 Wed, 20 Mar 2024 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710955140; x=1711559940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d648cIqv4adrDGQLSyAe4RYTDK5Brk0bN+L7RP5Dtnk=;
 b=YBuY7xM9D6ih/AlgWTlK8PSDASuYqoawEhioSXiIMigd2vBh1hDvge/iWIynHD9nuO
 yocwhpsSf22xMzcv5wXaeZcOjYB1FHE1Y1lNaEnRfGvm9+BQi2QXBC1yBjA0vTQvi5Ld
 hXf9Tqmf19rezm4nBCh+66D53zjWMTagYx/a9gMqIPvb3tNq5S2OagQf/pBMyAeqCS2O
 J9GjbQjK6qXsJ6B+BrZCQ5fiFCAvN9wTAkaPbwXv5sjPKyr1bqUiK1hrBH0DrUUIOgVK
 d+cFANY0xUXIyiYO2AIKGz/Vu7sL3qRKONoHrX6wR2O7To0HtQLHYcxV3XCC9BiEHu0q
 7U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710955140; x=1711559940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d648cIqv4adrDGQLSyAe4RYTDK5Brk0bN+L7RP5Dtnk=;
 b=iqEEtJ4dtgWfwuD3RJGA9S/uOuLeLpK+wbiNiiapCLYwNFmjN+xKbEYPa8NpwYs0W0
 ZkhajVS2IiGwtIByUYchuF15rDQO39LOu0xjjPwxCJwdrap0sjO3ku8p0LaHEOqz4jzz
 uGfYFsiEqCMYQy3Y7QrUGjlZ+Hmhyt/ET8QUIiZFuzovX//4/KwJl4RUhjCAb16vVobU
 krI3ovA107i/Pf77UHDWziS9GOBJIOMwAZQ9Ee0bOjSEA21+Y5S1l94gN4wa1lnM69o8
 PJY+KNUj1VourZl6rKSPs6RcrF5jnClVIURNgEJUwuEtYdEOGdSY2sT9d7asPkZBEc4a
 c7aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAe8W1cfvhBgMhJRobJCRdo+A7uf0F+7+TMOzH1ysiSBeEbQmlkWe7+EmtH0qSzrNJc3QKwXwLors3mZuYg5ygpsMduJKiiwhY2npmUllzcpiol1BTiMGgA2ALYA==
X-Gm-Message-State: AOJu0YzwSW3K56K64qmzm5MbDmdmxdc8RsCcmAaGktBfD137C55L4P1o
 c8CW2F8KePT976dPJRScHaxH/cd7QJJ9x1myZhs1w4btoZ4pUW3G
X-Google-Smtp-Source: AGHT+IHZ+p8vTBBwXU7lcKWO+htpvdsHiUncHav9ytESk1u7d5+6mhZ6i47zcij87nvx+XipXKhL1w==
X-Received: by 2002:a17:906:a153:b0:a45:6cc0:8f19 with SMTP id
 bu19-20020a170906a15300b00a456cc08f19mr12050055ejb.38.1710955139213; 
 Wed, 20 Mar 2024 10:18:59 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a4576dd5a8csm7481639ejb.201.2024.03.20.10.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 10:18:58 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v8 0/6] Pointer Masking update for Zjpm v0.8
Date: Wed, 20 Mar 2024 20:18:44 +0300
Message-Id: <20240320171850.1197824-1-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x532.google.com
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

From: Alexey Baturo <space.monkey.delivers@gmail.com>

Hi,

Rebasing patches on current qemu branch and resubmitting them.

Thanks.

[v7]:
I'm terribly sorry, but previous rebase went wrong and somehow I missed it.
This time I double-checked rebased version.
This patch series is properly rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

[v6]:
This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

[v5]:
This patch series targets Zjpm v0.8 extension.
The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
This patch series is updated after the suggested comments:
- add "x-" to the extension names to indicate experimental

[v4]:
Patch series updated after the suggested comments:
- removed J-letter extension as it's unused
- renamed and fixed function to detect if address should be sign-extended
- zeroed unused context variables and moved computation logic to another patch
- bumped pointer masking version_id and minimum_version_id by 1

[v3]:
There patches are updated after Richard's comments:
- moved new tb flags to the end
- used tcg_gen_(s)extract to get the final address
- properly handle CONFIG_USER_ONLY

[v2]:
As per Richard's suggestion I made pmm field part of tb_flags.
It allowed to get rid of global variable to store pmlen.
Also it allowed to simplify all the machinery around it.

[v1]:
It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
Compared to the original implementation with explicit base and mask CSRs, we now only have
several fixed options for number of masked bits which are set using existing CSRs.
The changes have been tested with handwritten assembly tests and LLVM HWASAN
test suite.

Alexey Baturo (6):
  target/riscv: Remove obsolete pointer masking  extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v0.8
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c           |  21 +--
 target/riscv/cpu.h           |  45 +++--
 target/riscv/cpu_bits.h      |  90 +---------
 target/riscv/cpu_cfg.h       |   3 +
 target/riscv/cpu_helper.c    |  97 +++++-----
 target/riscv/csr.c           | 337 ++---------------------------------
 target/riscv/machine.c       |  20 +--
 target/riscv/pmp.c           |  13 +-
 target/riscv/pmp.h           |  11 +-
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  46 ++---
 target/riscv/vector_helper.c |  15 +-
 12 files changed, 157 insertions(+), 546 deletions(-)

-- 
2.34.1


