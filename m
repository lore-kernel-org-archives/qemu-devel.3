Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F797D358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV4g-0008R0-FE; Thu, 29 Jan 2026 11:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4Z-0008MT-9M
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:47 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4V-00058p-Rt
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so917139f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704841; x=1770309641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=01xvXdE8z9gfIchU+uhtndBGw9J6GysW2uSPlCW8IcA=;
 b=tOnRkZZKmsCbTv2Pqtiaoh61M3VrQ3X/5tJffbUjNdO1aivyHg3rTNRsdpF7Pj31by
 I5ToNxj416z2m9hsb0kBagGVTkS2ofW9bPS8wAQ+H7tnuhL83UuCspo0CpxcEY9GthzP
 +OTHb2WGoISl0eA23sFenuCzq+zV9Cwm7k/nNcLQ6lKjIfJwz8XRQBFII6CtDDqW92WR
 twxQnZdP6+niB8hG4sDv9mWhdi8QpG0YtX4RsaoNWZGWoyK4jrUOcUZNHGoASG363WkS
 ijKrr8zncXFrlA01yDpDwzHcl003FhheVBT0WP4ozt5oZaeJF6YRu+7UinX4vAaES5FV
 8hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704841; x=1770309641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01xvXdE8z9gfIchU+uhtndBGw9J6GysW2uSPlCW8IcA=;
 b=w5XZTnLi5KKjqDedyGEP6clvzPRx8t+7trNdu8VMiWknLztNQg7w5jX9r7xNFlM5yg
 RN4bAbzL2zm74sOMoWFSAiUKTcUPsizRlzxXfkz8Liq/dx45wIhjQtmI/xsvhHyjAq7T
 s4H5f99LZeJJ3atc/jNMzN+/0dukq4wufwLjSo3ZlrtmdbNpegKA5mDegTOS841UM5Su
 JdM/Sm2E3YBbUFIgoDdqQ2bHiHaGhRU0ndPTSwP2tS0Pii2F4JM6FMj011EkFTfww8vt
 85ZQ3VcQijlLMkPbnX88peTz8T6FaX4RMuT1iEZXQXzt1aewQImpQRpdHXc49/4dnzwF
 lzTg==
X-Gm-Message-State: AOJu0YziYoQond4NxJ632+/5vLJH7X8ntKA8gH84X4KkmuYyrujIPe4Y
 MvKAOaH2l36cmTnyrrsNl/TYpFKTFmN7IWueDizM6vHfmutWx+7qbQxE61qOdVfAW5/BzJFatIw
 edAaf8wY=
X-Gm-Gg: AZuq6aJEz/VvwDfxslm0issj3SY7QPxUlyNmyFsdMy5LOmQcHgFNE3LUMlQxEoOChes
 SJ8U9v6BdV/cwrTbR02DVWCACSVTDbnu5BqEPeanp1DpqH8FStV8VOeVwxPrLiHbxfzgWxGf2rs
 lONM8wo+CN8scoJJA5rCXfC2zPsfL/aJDkKvCgFqh7JjgJUfwYDkVZiEywqs3pqj4N8O1Lughu0
 SMGSJjBt/Ol0ATv4JaqsFvl1IUM4CvPxdhj/fZV+a8zGgnsiGvmS91+445YMMKiTewDyeXn0EIO
 x3zM3Wp77Houi5q3vo+4nyYAPV28/UVE6LsHMMo0P5+tuyw7IYt1PyWGXzZZrjbQJjgI15gE9Hi
 Kzpki6MVHe0XW0DLp90ceDpxFXlRNPIkdY2IqwIY1N4H93FRM733KR0iAZXP6ri5QwDdOE3Zt8i
 ovcLBw0NEl8uN3ax/lWVvqCP51E4QWH6hv30Xfu2xL9JTKeXVVCuOs2sqcu0YF
X-Received: by 2002:a05:6000:22c1:b0:431:808:2d60 with SMTP id
 ffacd0b85a97d-435f3a7a4c3mr292026f8f.12.1769704840642; 
 Thu, 29 Jan 2026 08:40:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm15193877f8f.7.2026.01.29.08.40.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:40:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 0/9] monitor/hmp: Reduce target-specific definitions
Date: Thu, 29 Jan 2026 17:40:29 +0100
Message-ID: <20260129164039.58472-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Missing review: #2 and #7

v5: Fixed mis-rebase (Zoltan)
v4: Remove duplicated hmp_info_via() declaration
v3: Rename MD_I32 -> MD_U32 (Dave)
v2: Change get_value() prototype signature, use ldn_he_p()

Move most of target-agnostic definitions from
"monitor/hmp-target.h" to "monitor/hmp.h" to
reduce files target-poisoning.

Philippe Mathieu-Daudé (9):
  target/i386: Include missing 'svm.h' header in 'sev.h'
  monitor: Reduce target-specific declarations
  monitor: Add hmp_cmds_for_target() helper
  monitor: Reduce target-specific methods
  monitor: Have MonitorDef::get_value() return an unsigned type
  monitor: Have *get_monitor_def() fill an unsigned value
  monitor: Truncate target register using ldn_he_p() API
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header

 MAINTAINERS                   |   2 +-
 include/hw/misc/mos6522.h     |   2 -
 include/monitor/hmp-target.h  |  64 -------------------
 include/monitor/hmp.h         |  30 +++++++++
 monitor/monitor-internal.h    |  10 ++-
 target/i386/sev.h             |   2 +
 hw/i386/sgx-stub.c            |   2 +-
 hw/i386/sgx.c                 |   2 +-
 monitor/hmp-cmds.c            |   2 +-
 monitor/hmp-target.c          | 108 +------------------------------
 monitor/hmp.c                 | 116 ++++++++++++++++++++++++++++++++--
 stubs/target-monitor-defs.c   |   2 +-
 target/i386/cpu-apic.c        |   2 +-
 target/i386/monitor.c         |   9 ++-
 target/i386/sev-system-stub.c |   2 +-
 target/i386/sev.c             |   2 +-
 target/m68k/monitor.c         |  62 +++++++++---------
 target/ppc/ppc-qmp-cmds.c     |  26 ++++----
 target/riscv/monitor.c        |   2 +-
 target/riscv/riscv-qmp-cmds.c |   1 -
 target/sh4/monitor.c          |   1 -
 target/sparc/monitor.c        |  11 ++--
 target/xtensa/monitor.c       |   1 -
 23 files changed, 214 insertions(+), 247 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

-- 
2.52.0


