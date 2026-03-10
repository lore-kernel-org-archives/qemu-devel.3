Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AD5EB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyma-0006Go-3q; Tue, 10 Mar 2026 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzymW-0006GM-Ns
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:00 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzymT-000078-8g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:00 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so2063002666b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773155634; x=1773760434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YANBTeEh1icFtrmNl32SO7WazL5/0sCyFlnfAWhuROo=;
 b=Ka/EbdMiFEAXOmRL6aR2j0517UkegVX92rnclB3PVVowKwXL50oLD0SxuYeTTyvIVf
 4tXnZ3RYzQpUWwMdnTYcj8S7+9G43u/bDT8KUb908xjlRrN4vQymMnE37KZr2ztZ8B25
 jzAJdViIzeZAqeA7CHEp5aaB/GlSTXXWs6pgMubiel58oqjoIJiOGPl3Q4PhtwxxbmS1
 wFEx63iwwh6IyZtmyiVV9HgERDqZ4KU1STbOz+t107utzPkZDclJtF9TRSzPT4UBjiU4
 E782CD9+pfPveugHG5Kt6eBtSH3RTvsEYklIsUnW5GGHM3iBHFgZIXzafPSvNjahR7uJ
 8FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155634; x=1773760434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YANBTeEh1icFtrmNl32SO7WazL5/0sCyFlnfAWhuROo=;
 b=TUYbBW9WcPXu5xvhvLbK2hLFux08cx4++vxbQ0CoushQ2rMTRGH/s9sP4qKfXsdcLN
 Dm33PH7H/EpAJTVDSarmnP8HTOCygj2rP3fPJe5uY6gi9rUjd/cvUSjwZrPaLatR/rAF
 ihDiVYiEKUxagNy1MahfIZsV6SibgkWrp9qAjL8Ox3magPaW83VsHIlLompXVXYoyx7F
 nNLgdGytvKiYHTI9Myl6r5FCaGk4x6pHewBJuK/dwU0TZiqSd2lE5k6CSh+OnFpz7Bjj
 FCv+b/WDqwz5eH8TPPrMv1bRC5i214LkU1MLxlPETGunYQnL8f0WLCL1nfyTDLzZ0xmy
 itDw==
X-Gm-Message-State: AOJu0YxGYw7k1FTQk4heO0N+mGD9937O2QXXfOm2S9ON/2VYHUc5wV6z
 huSn5dA0F8kEj8CZ8RY2xDn53yBG+dG1xEGgndRzXvVXJ5JdgggA2RP/X+WxiadQ/D4=
X-Gm-Gg: ATEYQzw3XKW132Ap5PoZZMQWWXCFLLrAZ286Pb0XStLJY6UlZfVPLLvbXt+ojH9sl3g
 6ZbkaJOGXXwockMoc78KHn4zJwmN5qu1PbBHKyJre6sqkYPFo1LCxZpNt0BkjDoOYHLQgFC745t
 pNnh0ll3IGOKbQ5ZPie2U/T35KDwfpktq9AqJ2UxmR97MU4aOl80cB90ZtD8QKHugzWG4HAbyzH
 op8qXqaOScEHfvOcjikENzAW3KHctkI2mBnmJ6RX/H4O6Eej6WpE09gW/3kKoO5s7QVmi45M48H
 ckbqG/Xw7kQSszPOulVVy99N/mZ1f++Lp2bSmNylYpHYvia2wAx76/6Ub0KVkF2rmvQIiwfRvYN
 amDkjKJeLXDKla/OzPD0WSDqtyYHD99J2eA1uo2MWjqfXgZoUeAJZsu06b7DciaQMOsxvZo1kM1
 9oSSqW0tEC0meaJ9I6PkUo2BfRfFZetr0gwJyEolNfwz3VTIMPvxpiAIkwUAVijNJw8Z0=
X-Received: by 2002:a17:907:9707:b0:b94:1871:f223 with SMTP id
 a640c23a62f3a-b942dfc67cdmr917527566b.58.1773155634385; 
 Tue, 10 Mar 2026 08:13:54 -0700 (PDT)
Received: from localhost.localdomain ([193.35.234.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b942ef8cb2esm480204066b.26.2026.03.10.08.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:13:54 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v3 0/3] target/riscv: add unratified RISC-V Zbr0p93 ext
Date: Tue, 10 Mar 2026 15:13:44 +0000
Message-ID: <20260310151347.67263-1-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FUZZY_PRICES=2.311,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reorganised as a vendor extension for Ibex and renamed to xlrbr (as in
X-LowRisc-Bitmanip-R, like Zbr).

Apologies for the double-post, I realised right after the last patch that this
name would be better. Please disregard v2.

James Wainwright (3):
  util: export CRC32[C] lookup tables
  target/riscv: add draft RISC-V Zbr ext as xbr0p93
  disas: diassemble RISC-V Zbr0p93 instructions

 MAINTAINERS                               |  5 +-
 disas/meson.build                         |  3 +-
 disas/riscv-xlrbr.c                       | 79 +++++++++++++++++++++
 disas/riscv-xlrbr.h                       | 19 +++++
 disas/riscv.c                             |  2 +
 include/qemu/crc32.h                      | 18 +++++
 include/qemu/crc32c.h                     |  1 +
 target/riscv/bitmanip_helper.c            | 20 ++++++
 target/riscv/cpu.c                        |  4 +-
 target/riscv/cpu_cfg.h                    |  1 +
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/helper.h                     |  2 +
 target/riscv/insn_trans/trans_xlrbr.c.inc | 45 ++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +
 target/riscv/xlrbr.decode                 | 30 ++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++
 util/crc32.c                              | 85 +++++++++++++++++++++++
 util/crc32c.c                             |  4 +-
 util/meson.build                          |  1 +
 21 files changed, 388 insertions(+), 5 deletions(-)
 create mode 100644 disas/riscv-xlrbr.c
 create mode 100644 disas/riscv-xlrbr.h
 create mode 100644 include/qemu/crc32.h
 create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
 create mode 100644 target/riscv/xlrbr.decode
 create mode 100644 tests/tcg/riscv64/test-crc32.S
 create mode 100644 util/crc32.c

-- 
2.48.1


