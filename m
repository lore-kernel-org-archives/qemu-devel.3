Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1B8C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs4C-00011B-7R; Fri, 19 Jul 2024 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4A-000106-IE
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:10:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs47-0003dc-Ic
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:10:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so681508f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412645; x=1722017445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tJQVf3BbDguAsYpbzIbV3goR+q4yFrTTHvQYqXEoamQ=;
 b=jC6/yBRSXp2UpJ9G7yrgoeKAB/Yfswv/Yz4qrphuObVxkkJecfp/cAH2LNqBObI7sh
 DY496lwwnu5HMbmlHV6lRSAK0u8AqKkz/8BILuIkbNMiuM180tTHa14Q/Oz6J9cX0Jgs
 9q0ON+KQavyxnZVBN/5eoIkT3tLjFv2xfxFi2haPZ4oLfrMt47tdyAPIo1PDeLsgnk0z
 zPyJiCVvHkD6stufq4cjngDD0A9A0U9uKuFPdAxLUf9PPsWE3eAy60qwU5QS+VT9JdZn
 vfHvoIsbX48JdFp1mR+QBkksvMXrvWACHTb6499MTNQWJEwDC+2XlzJuEo7tIiXFvibY
 0upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412645; x=1722017445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tJQVf3BbDguAsYpbzIbV3goR+q4yFrTTHvQYqXEoamQ=;
 b=jgwVcmzZw51u8L8i83UPNVYOH7Kkdc3P74+nCAGB2WAk7qC4WFtcTBsAVt6FfPoTr4
 27A7SxYR/Z7g7QjsbM2G2xiwI56dqzMzxuytRk8dMVC6X5rvU4xcz0WR2CReKmp3ytAI
 xEqAztCra3q6Zsw/emnziHaZcWSSN+PZ6aF87WRrcTonSaCBc8o3bC4tMksH1DnRdFU9
 tb4FKrobx7+kDOn08reFztrHJB2ADfXBmBmWKgkgIO3qqiNxYpEdSnTuyzz3gGkt6vC1
 fwsC7k9Jau4nXW3O6EJ9hFLU7ZshwZCep3++RVhNtbpCEgP/yyN/2uN54NjEcgV18+Hx
 91Vg==
X-Gm-Message-State: AOJu0YylIBXhw6Pc+GawDnWADkuhAaBiQquohm4V0pzQK1bzZYRqmzT4
 ZVL2PDGkmzBNyDxVJKy0rSfiV3tJYVg1cjY4tEVntvyym/6b/OdFsnNqz+iq5aNIL/EokaMQKXh
 6
X-Google-Smtp-Source: AGHT+IG8E8Crd22Mc4FAZy6qunBhAOnUZaKi+d46fEq8Tu+0dOO8BEjD5R/IpPnPiMKOzP1yJ8FS8g==
X-Received: by 2002:adf:e34c:0:b0:367:9279:c401 with SMTP id
 ffacd0b85a97d-3683165c8cfmr5506717f8f.34.1721412645178; 
 Fri, 19 Jul 2024 11:10:45 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cece3sm2224012f8f.69.2024.07.19.11.10.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:10:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/16] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
Date: Fri, 19 Jul 2024 20:10:25 +0200
Message-ID: <20240719181041.49545-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi,

This series add support for (async) FIFO on the transmit path
of the PL011 UART.

Last patch still broken (chars are emitted async),
still patches 1-11 could be merged for this release...

Since v4:
- Rebased (loopback)
- Addressed Richard & Juan migration comments
- Split in smaller patches

Since v3:
- Document migration bits (Alex, Richard)
- Just check FIFO is not empty in pl011_xmit_fifo_state_needed (rth)
- In pl011_xmit check TX enabled first, and ignore < 8-bit TX (rth)

Since v2:
- Added R-b tags
- Addressed Richard comments on migration

Since v1:
- Restrict pl011_ops[] impl access_size,
- Do not check transmitter is enabled (Peter),
- Addressed Alex's review comments,
- Simplified migration trying to care about backward compat,
  but still unsure...

Philippe Mathieu-Daudé (16):
  tests/avocado: Add 'device:pl011' tag to tests exercising PL011 UART
  hw/char/pl011: Remove unused 'readbuff' field
  hw/char/pl011: Move pl011_put_fifo() earlier
  hw/char/pl011: Move pl011_loopback_enabled|tx() around
  hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
  hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
  hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
  hw/char/pl011: Warn when using disabled transmitter
  tests/qtest: Update tests using PL011 UART
  hw/char/pl011: Check if receiver is enabled
  hw/char/pl011: Rename RX FIFO methods
  hw/char/pl011: Add transmit FIFO to PL011State
  hw/char/pl011: Introduce pl011_xmit() as GSource
  hw/char/pl011: Consider TX FIFO overrun error
  hw/char/pl011: Drain TX FIFO when no backend connected
  hw/char/pl011: Implement TX FIFO

 include/hw/char/pl011.h                  |   3 +-
 hw/char/pl011.c                          | 339 ++++++++++++++++-------
 tests/qtest/boot-serial-test.c           |  15 +-
 hw/char/trace-events                     |   9 +-
 tests/avocado/boot_linux.py              |   1 +
 tests/avocado/boot_linux_console.py      |   2 +
 tests/avocado/boot_xen.py                |   1 +
 tests/avocado/machine_aarch64_sbsaref.py |   1 +
 tests/avocado/machine_aarch64_virt.py    |   1 +
 tests/avocado/smmu.py                    |   1 +
 tests/avocado/tuxrun_baselines.py        |   5 +
 11 files changed, 277 insertions(+), 101 deletions(-)

-- 
2.41.0


