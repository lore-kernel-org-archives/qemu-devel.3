Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C449DD185F6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2F-0000XU-Rl; Thu, 08 Jan 2026 08:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2D-0000Vl-Hx
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:41 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2B-0003U3-75
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:41 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34f2a0c4574so2538726a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878797; x=1768483597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJnI+7w3iat9lsMDie0sMCmPRQFcbcF58zi+T1SahEA=;
 b=C8/73RGojA0kjJjAn7d+bZjGCoM8zHkWdtAz7n9eEsbVQRBfaRrKrFEuMLzaTHIYjh
 bhWGaALd4CHEuPTyYapdGnA/GMJw4DH5MnISWRcvffh8ZmJiMUfXVnd82uz+d22xJet3
 o+u13Nra6DSOKaeuWuNMhHtYzsRgrY21xH7Z262EhN+zrt8jtjYjoRGI1VUe1EwpqquJ
 OCUF1N3pV9s1he7+d8s4yX9/mTefZETyBLoRk1mqHkQqlQGqhn7pIINPiRCWmls0MvTC
 rdzkn+WUWBTPP+y24h9QzXTk2p9x30S8zhvlOpnrVinzm+DlK3CPHIj4hwODT2Y4rCJ5
 96Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878797; x=1768483597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJnI+7w3iat9lsMDie0sMCmPRQFcbcF58zi+T1SahEA=;
 b=egOlpVEFeGnCUWjXhWeeaY3NTgLTytkttlZ79wYqpTw+emafJXNVXw51yTq5FdKssW
 +gfw/ZqfCo/ksf0PlYoiiPIFm6gOXss8Se6qnFQQRzA+j6Vxr1p8D14ARssJ29AZokJY
 Str2x7rJMaRqisGNCBDGfnXDmH03OKRSQ7A7zULIkhLXnv9u9Pms5nNgmSkzDMsmtCqY
 xvRxV33gxD6LLMcuCDYuFHt3h1OQpKgXP+w7bjjetGr7dpVwRt+x3ynbO0wsc+vk5OKr
 68k6Ov7KgVSBGZRKfctlEYIuAh0XCPzFZfDOpfZq2vUiFjL/Aj+9faMiFSNhvLwXXop9
 2HDw==
X-Gm-Message-State: AOJu0YzAPi9cRAdKFc/JmiJdsrwuNsK/et+ULLCEIp812lUs/8hbBWjc
 6iO02580TwBcbe9jEyoY7dv6eclZdfOzuum6cPbk3p8bVrZg9EyDwN2X+wkBsrCbFj3KMRXHz3G
 Bau9wNe3Ve9e4vq1MbUvmvyG3w0Ei5ocT49+dPLDuo2Z6gMp4rXCd6zfbLAVUj7Y89eODYXMat8
 xMQnxh3kkqWMC6m7wfw5B3fQNZEukz1B20fNbwTx0=
X-Gm-Gg: AY/fxX79Lwy5dNp40M/PdczmW6x+NqO3vgxLRHBf4BKVgf7gV8nV+/9hYtwXpa1LTqi
 NU4LHCZt6SGYc8uWiqGCUU09n4FG5k84WyGKaIp38Ve52nzBMuJfbfNFJEsM6/QKsFdSBpC4vbY
 ovXp1orgQg6lNoP6hmHSyRLweconQrbCwYlf5MiwfUBeMU2M8f3FUdTLlrsDbMyOqbK6S2mPrZW
 czeqLpvMS+E7CM5RiPKYo1UKf2PPqeOWXunELsFHkjrYudC/gZCUF4F61lrcQFHbIT9DHJDCymq
 ZrwrNa8vzSyCwLWiDayqvDwjxVMdAgWawsafhANuv23/DvA04Xbqd3Tivi8zaw6Cz3Np3gQ+xNG
 7w/nzKTcpPXKHLzebT4B/ubrQUrNJhKsz7DdmOQtpo7rfY1TddZ578FoByigUEycNzjiEXMktYa
 MEMrfKdkCUvpC8QdyzpIPMc+RPh29XN3+yvOZIlk67jnC7BwHWRkmXyIQ=
X-Google-Smtp-Source: AGHT+IFQ8xi/0weGWo/mo6bbLnT7dP/EpW5ZwU95+ZvICFTkWr3ubqQsvA/j2MkE6d3SKDNF6s1h+g==
X-Received: by 2002:a17:90b:4b90:b0:349:3fe8:e7df with SMTP id
 98e67ed59e1d1-34f68c4d77bmr5619811a91.22.1767878797327; 
 Thu, 08 Jan 2026 05:26:37 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:37 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 0/9] Add Zvfbfa extension support
Date: Thu,  8 Jan 2026 21:26:21 +0800
Message-ID: <20260108132631.9429-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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

This patch series adds support for the RISC-V Zvfbfa extension, which
provides additional BF16 vector compute support.

The isa spec of Zvfbfa extension is not ratified yet, so this patch series
is based on the latest draft of the spec (v0.1) and make the Zvfbfa extension
as an experimental extension.

The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
bit position 8.
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Specification:
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc

Changes from v1:
  - Removed RFC designation from the series
  - Updated commit message for patch 3 (VTYPE CSR field - altfmt) to
    clearly explain:
    * VEDIV field removal (bits 8-9) since EDIV extension is not
      planned to be part of the base V extension
    * ALTFMT field addition at bit 8
    * RESERVED field change from bit 10 to bit 9
  - Added new patch 4: Introduce reset_ill_vtype helper function to
    consolidate illegal vtype CSR reset logic

v1: <20250915084037.1816893-1-max.chou@sifive.com>

Max Chou (9):
  target/riscv: Add cfg properities for Zvfbfa extensions
  target/riscv: Add the Zvfbfa extension implied rule
  target/riscv: rvv: Add new VTYPE CSR field - altfmt
  target/riscv: rvv: Introduce reset_ill_vtype to reset illegal vtype
    CSR
  target/riscv: Use the tb->cs_bqse as the extend tb flags.
  target/riscv: Introduce altfmt into DisasContext
  target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
  target/riscv: rvv: Support Zvfbfa vector bf16 operations
  target/riscv: Expose Zvfbfa extension as an experimental cpu property

 include/exec/translation-block.h           |    1 +
 target/riscv/cpu.c                         |   15 +-
 target/riscv/cpu.h                         |    7 +-
 target/riscv/cpu_cfg_fields.h.inc          |    1 +
 target/riscv/helper.h                      |   60 ++
 target/riscv/insn_trans/trans_rvbf16.c.inc |    2 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 1002 ++++++++++++--------
 target/riscv/internals.h                   |    1 +
 target/riscv/tcg/tcg-cpu.c                 |   15 +-
 target/riscv/translate.c                   |   11 +
 target/riscv/vector_helper.c               |  379 +++++++-
 11 files changed, 1087 insertions(+), 407 deletions(-)

-- 
2.43.7


