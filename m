Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DACAE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8cZ-0004Jo-VA; Sun, 12 Jan 2025 19:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cW-0004J6-Pc
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:47:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cU-0000fy-13
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:47:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso36554435e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729272; x=1737334072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ7F9oRarx8FS7cL5OgCcFv244CWrusVaSTKfTV+FRU=;
 b=eyMPdn+q7vuQY5jN4hUwslZk7Vb1TUdD9eo6Qv/a+bEGPb4B9PRk6XoJ+U/5mfXvF6
 CjxUsBNn2dQDosreiROYzFJlNuF3DyTT5tregERK9X516iI3y2KOyS04evth0+xgX2b4
 +MZF2vbDInepBlRTe3cIWQmYeA3azLUuXIsr5t0/NlGOBIJSaHHt4CPGikUlgcTK2mFZ
 H00zSWzxUNdLRkUKpzQUh7ZYYIcGDJVWw1qaXn2zg2HRX/bnZ/6zaub5M9cK5KFq1L0C
 IBb0Qc0w6HScjvkxCYLbV86dCZ3T2BIiSa1HE6UeUNyPJ0ZWMgphWUey5y63UgZBSIlT
 yhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729272; x=1737334072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZ7F9oRarx8FS7cL5OgCcFv244CWrusVaSTKfTV+FRU=;
 b=nGIFdhJ3mE6yhLgosFZ3lac1Qz13o/SLIUpJqPja+oiv38QKCFyxUIOF1zXBx0pFwd
 ijgWoYBCBIOp3D9+Z3QgLi/yTubxpqBQBkVou1TCrirvGYHJJezpuOr0Q5z2EpOYWfhy
 Rr7AwDHTjHkuYpHaVHlxnfcRYxzs073frzG3TYw0k16uhAMjv9p4QYwhZwVmkkMpDd7Y
 GtkDjWayhVfyTvNS+HvM/ZFNpN2BoF9ECxe9ATZeziHFVf5ElrwuDJeWJDnx2mk8AvyN
 Q8ayLpq2MP/3ZViAlNZuuM2p6HW17vU8frslFoprFLu4SI7NZKSTlu5BO9nyeMpcfsNY
 l1KQ==
X-Gm-Message-State: AOJu0Yw5KOT6Ya04bi2isWcerRcPaD6+Y9VbHkMYm+8l610tpFNLrno7
 0vADixdpSgtZMJXYFmHlMySrV733dJx8Rtyec9XwVtEAWrsNpIx8a3YUp43kV5Zrcc/IsM45TM0
 wz1A=
X-Gm-Gg: ASbGncvZoGrnMQc/DDv4aChPRBZ4ls3iN74gakJGtcC1+11TraVOslm5uRUoqnlwDHk
 u8RjGD2+IdZ8KfLw7nqkmuz7cRvqY3UBxV1CSFLBcnsSvPKu/oYtpoGa/80v3UtRq2MGptWD4zB
 q4USKHyguhl+MBaDXB/SvJVkexVR6HyC6oevFbkUnjpvZBsxhxcJvYDqiw82lNg4a9Frgdd9J4N
 NDn4ckDng3M9SIu1Ln3hkfON0GxN8g9ijVrDUoKhXLkMobm4W7m1931HETo1jlhFNBT7zXjrQy8
 NWdhacVkKru63Z5jaQgDa44uE6/Islc=
X-Google-Smtp-Source: AGHT+IGT59kNEo8T+DCzFGlE06h9zlG9KtWLXIdnLejYtAP8FYmuzCR4mYo/zJMEZI4yyr4azTtMHg==
X-Received: by 2002:a05:600c:1d9e:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-436e2707c41mr145481315e9.22.1736729271980; 
 Sun, 12 Jan 2025 16:47:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8802sm125732025e9.10.2025.01.12.16.47.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:47:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/23] hw/mips: Remove all uses of &first_cpu
Date: Mon, 13 Jan 2025 01:47:25 +0100
Message-ID: <20250113004748.41658-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

- Keep references to vCPUs in CPS and MaltaState,
- Refactor the MIPS Bootloader API to take CPU argument
- Access first CPU propagate from machine_init()

Based-on: <20250112215835.29320-1-philmd@linaro.org>
"hw/mips/loongson3: Remove uses of &first_cpu global"

Philippe Mathieu-Daudé (23):
  hw/mips/cps: Keep reference of vCPUs in MIPSCPSState
  hw/mips/malta: Check CPU index instead of using &first_cpu
  hw/mips/boston: Replace bl_gen_write_ulong() -> bl_gen_write_u64()
  hw/mips/bootloader: Propagate CPU env to bootcpu_supports_isa()
  hw/mips/bootloader: Propagate CPU env to bl_gen_nop()
  hw/mips/bootloader: Propagate CPU env to bl_gen_dsll()
  hw/mips/bootloader: Propagate CPU env to bl_gen_jalr()
  hw/mips/bootloader: Propagate CPU env to bl_gen_sw()
  hw/mips/bootloader: Propagate CPU env to bl_gen_sd()
  hw/mips/bootloader: Propagate CPU env to bl_gen_li()
  hw/mips/bootloader: Propagate CPU env to bl_gen_dli()
  hw/mips/bootloader: Propagate CPU env to bl_gen_load_ulong()
  hw/mips/bootloader: Propagate CPU to bl_gen_jump_to()
  hw/mips/bootloader: Propagate CPU to bl_gen_jump_kernel()
  hw/mips/bootloader: Propagate CPU to bl_gen_write_ulong()
  hw/mips/bootloader: Propagate CPU to bl_gen_write_u32()
  hw/mips/bootloader: Propagate CPU to bl_gen_write_u64()
  hw/mips/boston: Propagate CPU to gen_firmware()
  hw/mips/fuloong: Propagate CPU to write_bootloader()
  hw/mips/malta: Keep reference of vCPUs in MaltaState
  hw/mips/malta: Propagate MaltaState to write_bootloader()
  hw/mips/malta: Propagate MaltaState to bl_setup_gt64120_jump_kernel()
  hw/mips/malta: Remove all uses of &first_cpu global

 include/hw/mips/bootloader.h |  14 +++--
 include/hw/mips/cps.h        |   1 +
 hw/mips/bootloader.c         | 103 +++++++++++++++++++----------------
 hw/mips/boston.c             |  21 ++++---
 hw/mips/cps.c                |   4 +-
 hw/mips/fuloong2e.c          |   6 +-
 hw/mips/malta.c              |  59 +++++++++++---------
 7 files changed, 118 insertions(+), 90 deletions(-)

-- 
2.47.1


