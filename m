Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802CCD3B98E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvQ6-0007so-89; Tue, 26 Nov 2024 08:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQ1-0007q8-5Y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:15:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvPz-0003Wk-80
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:15:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3823cae4be1so3445907f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626949; x=1733231749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qicA4tgCJfDpFBaDTHOXe1Z6RwEjpfQXVt8zL8Tv2/8=;
 b=tlVjA7SQvITe5blKwsmzTNO5HijKQDSouBMhXBA0Wrs0el9f5MdLSXxnz+Zv7I4BnH
 LsnvBJ6VI+/Yc6D8TYkNxJMugdYJGbqPDN+9vfZDC7/bQYd7wH7NF5kdlNE22CSxOsOL
 sF+Zp6yJXmABserqxoNGFhWVCspzTad+WB0Pj6Z6zmtGzNBtDxBP3dB1RovYiTYV0nfO
 VRKODhliTpobEIuLDQtYPe2t4UNMKH0K+W26HBXugSX3nKaNvemvT7q0D95/RQp8Lcc4
 +MscyMHpNFZs5Lo7OXGOWARg/npnqeH3FZsT0doBfejldFYmzRRwrCaxZEJSRQweMEBQ
 6yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626949; x=1733231749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qicA4tgCJfDpFBaDTHOXe1Z6RwEjpfQXVt8zL8Tv2/8=;
 b=gupisJj69kHwFo9eCJbi5vEH+szEu/szvCgaIgznz8fadWW6je+wek/h1GUQkmEQQr
 mID8Si5cbPKRTMDbvu80Xp9XiwBse4r7a7DjqrPaTFrXrvMJPpoROePMAyXRvZIjcNT8
 PzYSbC+IQpvry0ibqZ6QmQZ8ztJQVvB4c19oeN/KjyDUOkSZ/vr2G4mV3zD9rxW7pWH6
 a6RXkdaatCmoOWOrGdTGqMUlOlzwtUm/naH2evHTnijIAEH3nQAMBJn7Xtbbsi9x74p0
 k9PYl9RHyYwGzA8Zcgh0Uz6VJL17PCLOv9R2ORGIIODhZpOMC7hMC8oZHst0ezvsyR3T
 ywnQ==
X-Gm-Message-State: AOJu0YzNPu2K7dRv/StPx04/NOEk6DqqKGUBx3iGNROn4H/zlBbgQ4yf
 WLBojeOVo4fPko9WJsuGonm3IrIb2sUIaL5fr0Cs/SJL5IS/CKnD/HxY1gBw9DP18bAu3KOfH64
 s
X-Gm-Gg: ASbGncsch86d9nzRdUx5g35f8skqV/jnjWXWi0FR7N1c4wTYTPJRalVSXwKcksKRbJ1
 B4hKiv/yJ4JGCwBjNQEXpyJbrIO6gthaJPBQIG16k5YxGqviegS/rB8lX2Ww+9n8eXr4P2q3btb
 ewG6BhhgKVLp8xe4pVtGxLuUtHN8i30VGbGOmDA/rxJ1nY9wsGyemVIAYP1Yc0lwQXGxGaq0INI
 Fde8ujLz7w7qE0SSWIsxjapW7VEx8XSFO1kKbZf4EfrsVEYDGN2sTlZSyxeL13i39ahgpq9
X-Google-Smtp-Source: AGHT+IFFESbkUg4JfyK9FpiXksBHo/+OWpjEVuF6qRfNb5JoyBDwN1JBjbGWfjoTTPSURKX1lZblGg==
X-Received: by 2002:a05:6000:1887:b0:382:5284:989 with SMTP id
 ffacd0b85a97d-38260bcdbc5mr15485941f8f.46.1732626949376; 
 Tue, 26 Nov 2024 05:15:49 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc38afsm13223769f8f.67.2024.11.26.05.15.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:15:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/13] target/mips: Simplify some target_ulong registers to
 32-bit
Date: Tue, 26 Nov 2024 14:15:32 +0100
Message-ID: <20241126131546.66145-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

This series is part of an experiment trying to run 32/64-bit
MIPS cores in the same process.

MXU is only available for 32-bit ISA, so there we have
target_ulong == uint32_t.
DSPControl is a 32-bit register, so we can also use uint32_t.

First introduce 32-bit equivalent helper_i32() for some MIPS
specific helper_tl(), then use them in mxu_translate.c, using
32-bit registers.

For DSPControl register, we convert it to 32-bit, and use
truncate() when using a 64-bit argument, or extu() when
returning to 64-bit.

Philippe Mathieu-Daudé (13):
  target/mips: Rename gen_load_gpr() -> gen_load_gpr_tl()
  target/mips: Rename gen_store_gpr() -> gen_store_gpr_tl()
  target/mips: Rename gen_move_low32() -> gen_move_low32_tl()
  target/mips: Rename gen_move_high32() -> gen_move_high32_tl()
  target/mips: Rename gen_base_offset_addr() ->
    gen_base_offset_addr_tl()
  target/mips: Rename gen_op_addr_add?() -> gen_op_addr_add?_tl()
  target/mips: Introduce gen_load_gpr_i32()
  target/mips: Introduce gen_store_gpr_i32()
  target/mips: Introduce gen_move_low32_i32()
  target/mips: Introduce gen_move_high32_i32()
  target/mips: Declare MXU registers as 32-bit
  target/mips: Access MXU registers using TCGv_i32 API
  target/mips: Make DSPControl register 32-bit wide

 target/mips/cpu.h                         |    6 +-
 target/mips/tcg/translate.h               |   18 +-
 target/mips/tcg/sysemu_helper.h.inc       |    4 +-
 target/mips/sysemu/machine.c              |    9 +-
 target/mips/tcg/dsp_helper.c              |   10 +-
 target/mips/tcg/lcsr_translate.c          |   12 +-
 target/mips/tcg/loong_translate.c         |   20 +-
 target/mips/tcg/msa_translate.c           |    6 +-
 target/mips/tcg/mxu_translate.c           | 1546 ++++++++++-----------
 target/mips/tcg/octeon_translate.c        |   28 +-
 target/mips/tcg/sysemu/cp0_helper.c       |    4 +-
 target/mips/tcg/translate.c               |  520 +++----
 target/mips/tcg/translate_addr_const.c    |    8 +-
 target/mips/tcg/tx79_translate.c          |   36 +-
 target/mips/tcg/vr54xx_translate.c        |    6 +-
 target/mips/tcg/micromips_translate.c.inc |   38 +-
 target/mips/tcg/mips16e_translate.c.inc   |   32 +-
 target/mips/tcg/nanomips_translate.c.inc  |  438 +++---
 18 files changed, 1400 insertions(+), 1341 deletions(-)

-- 
2.45.2


