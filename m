Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B9C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9BC-00035W-BJ; Sat, 17 Jan 2026 11:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9B7-0002oE-Mc
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:33 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9B5-00069Y-L1
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:33 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1638609f8f.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667369; x=1769272169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2532O0k8pnF1/V/9RUllydi6LWO9vpowQkKxRBx9C/M=;
 b=RkXFjwq4VDBbhdJrZQWf+X/4PnXgxNu1H39CVvxhSN4poq9OFoiSbUPNjB5JKtblmf
 d4qxvKdYpM6cQQj2xber7I6lLmP86gDoNkuHTlnxm+kktCDJ4F/SSc2CW0BZIlXNC4ZR
 3gXtOfXJyW31hn0/ZIYfB1kPQ/lUk/Lyre6R3vaKtth1oO+X1DQFCFr0N0l/ZOKOX0tz
 xKjzIhoGrGSmgR2PxDfecWWacj8rj2tPnpjz2HvwF1bZXU5nE7Ec3tmIvx4CUO7vL2yz
 3rVD/JClasGDTtLuBeOIQfqrxXRrS6bfSCkOcN4aQwbY1Q7OoR/nt9XHOIUP18nO9f+U
 sAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667369; x=1769272169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2532O0k8pnF1/V/9RUllydi6LWO9vpowQkKxRBx9C/M=;
 b=R2grgqCJ7he7iCmJBv3OoGQD8pgx+w6neSeM3k1ygVKgHQSzVXyT80Jhs0uueX3/3I
 HFkzRCTq8m2f0eb49ByN6JzlQTYtgVpQdZeQrYRz67vBDAuGdtHMA89KOOrgR6lkeI8L
 8ZiH32ZCAeU6Lq273CR5rQI+Gm+XPchMdC3obakuE6OetGtRgGOGfsec6KdWhxRfU/SK
 FKwmo/45vUKXxBCTZAGv+b6F/lhMuUu+Eca/QJGW8KqD/fJcaG8UsSFmY+ndrhayXJXS
 B/V5OSNL6WHTvgWljWstwg90Ac3OBdgu/GTh9g7Kz6zCi0ens2/tEns/pjO7G8cj13Qw
 gZ/Q==
X-Gm-Message-State: AOJu0YwgS5v0pUYnxS6lqYrhNnKrTtskuzqaI+E/jwAz/RP4fcJXFaFf
 P1wK4mnNQYeIs73aNjUBOWPQM6u/VPNmiQiHQgYw4mf4KVbR0unP3Jpj+L33uofTaQ83Nhuhybx
 VVzVMtG0=
X-Gm-Gg: AY/fxX5NDSc88/3+/a9imF+faJLQ6c+YvUFYMEdGRMfX6SpYVPYru1o4zRgMvtwsGV7
 miPU4s9jzFNC5Vk4E6YEl5ej3eCGZlFKL+kHTWAzuNrkvup3bPPjVmDMfrP09Y+oVuQyQu7g4M3
 yrxNLHEtZlOCBaTLmFzeAiy6qCXcPXdC8udl7cbukYp6dcGJkC8oAKG5G7t0AZDpJMjOnfjr1T/
 oooUEDqKzSdqXo5rvfxlh9TwFgAngRzyNL6ExMgkh02kutAoq1UFjsoi+MRlxLix2MW7Kq5r26d
 1yiCyoNi7K/O/3RMmPckXMCVunXYmeffSXu7IKT7EsY1TO/x817uIifQx81l8enljkZuHEHE78v
 CvR62J92UdiswAgGgTqGkfgTqHhqntohNCrvXf1Cf85b4IEQzBpySVQSRSd+YOXOeWSY60QvP6G
 PCmgakBOOzELxHmywY+whlg/VxlBzJMvWnIsgPPQC8eIv8aAmbaH/C7hEspV3U7QMxaVBPIyg=
X-Received: by 2002:a05:600c:310e:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-4801eb11002mr70222375e9.29.1768667368921; 
 Sat, 17 Jan 2026 08:29:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb0bsm11639968f8f.34.2026.01.17.08.29.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:29:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/8] monitor/hmp: Reduce target-specific definitions
Date: Sat, 17 Jan 2026 17:29:18 +0100
Message-ID: <20260117162926.74225-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

v2: Change get_value() prototype signature, use ldn_he_p()

Move most of target-agnostic definitions from
"monitor/hmp-target.h" to "monitor/hmp.h" to
reduce files target-poisoning.

Philippe Mathieu-Daudé (8):
  target/i386: Include missing 'svm.h' header in 'sev.h'
  monitor: Add hmp_cmds_for_target() helper
  monitor: Reduce target-specific methods
  monitor: Have MonitorDef::get_value() return an unsigned type
  monitor: Have *get_monitor_def() fill an unsigned value
  monitor: Truncate target register using ldn_he_p() API
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header

 MAINTAINERS                   |   2 +-
 include/monitor/hmp-target.h  |  64 -------------------
 include/monitor/hmp.h         |  31 +++++++++
 monitor/monitor-internal.h    |  10 ++-
 target/i386/sev.h             |   2 +
 hw/i386/sgx-stub.c            |   2 +-
 hw/i386/sgx.c                 |   1 -
 monitor/hmp-cmds.c            |   1 -
 monitor/hmp-target.c          | 108 +------------------------------
 monitor/hmp.c                 | 116 ++++++++++++++++++++++++++++++++--
 stubs/target-monitor-defs.c   |   2 +-
 target/i386/cpu-apic.c        |   2 +-
 target/i386/monitor.c         |   5 +-
 target/i386/sev-system-stub.c |   2 +-
 target/i386/sev.c             |   1 -
 target/m68k/monitor.c         |   2 +-
 target/ppc/ppc-qmp-cmds.c     |  26 ++++----
 target/riscv/monitor.c        |   2 +-
 target/riscv/riscv-qmp-cmds.c |   1 -
 target/sh4/monitor.c          |   1 -
 target/sparc/monitor.c        |   9 ++-
 target/xtensa/monitor.c       |   1 -
 22 files changed, 179 insertions(+), 212 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

-- 
2.52.0


