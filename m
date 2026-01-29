Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25728D61011
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlS8z-0008PM-MD; Thu, 29 Jan 2026 08:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8m-0008L5-MF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:32:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8b-0002YK-Og
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:32:48 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480142406b3so7398405e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693564; x=1770298364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0+WgGqcMTk5fORY0FKKTxDH9SVncLlXUNZHGK/hEGg=;
 b=skAD8DalzQkDQ33ZhJRZ4SKsUiNnyNrpwAFYH3D2jMXShTwRzlWxnvWswNtiWDk1V7
 tpd+EjrfM89wz2TEWd7OxUyjRNSr4n4+OMe5+rd3df5NVj6HKzJ0uhuXCv0qQYT2L+dq
 5jqtASpRid9AFtJvI/sKPnu4Q7sEJ1Xwnbkqh36xuhx3alnLKfYAPV/D0uoN4VxCK+EF
 7jW6dB7yl4lLp1KAs0jTSpMZnK9heOqAF+CvrUpDk5+4snxnKU0/MDYWeTlx+zPgiKeO
 L/9Q6K+qFVuq+Qb/ZD6MmXjNuuZW6CRmkUXrKGHcJkLpML1ypG+P8rFY5Dp47lYlbtQ4
 mHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693564; x=1770298364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0+WgGqcMTk5fORY0FKKTxDH9SVncLlXUNZHGK/hEGg=;
 b=nQKEVfE2Z65EOsqozfQTko2943C3F6w2d6FDOYR2koJCqM+lNTKOJHb9YDCqhzZpu5
 8+bWbhFPrFw5z31TVNeruOx9+W8CV4T+dfwGboI7lSMl3zVy1fVgTX7XL9k1B6cNB3Ud
 d2hIWl7e+tdJRx09HOK98lV7XqL0Ir+qPkKbKkp0hBpfaDMT6e45fGqp9awrYkXS3qXJ
 OcQUykgv6UOv072aGIWbClA1taOrlGwAM/IFTISV6TM3p12rz6NcTK94lSxctDXUp38Q
 46F0RXyAn93AdPg/pQdqHhAiu57I9bpy4k0JfR8YiprnY2F5QFMfApriPMqTqV5KSvEV
 xWjg==
X-Gm-Message-State: AOJu0Yxwgdl1QcElFStKTOmw1rpxTEfhW7HUPPZvg/0e00E76ck3rRrt
 SFTKQdFQs7OwUe7KEoS74+UUsV3D2cj+Ma4nxoz69mRBargONXlcSSV9kxXFF/fhrk1/6aLd6Za
 tb7afNnU=
X-Gm-Gg: AZuq6aIMG9sSVnTgYt8hIC9Za/t0FqiehAdTXr1e5Rb24tC+2JGUsBawZ8amajzyhYs
 r3J9HmuW87b3aL9QgyVjgTlxau2LSojwF0Erxfod4zZIlQqXRDy8tFnT9OIhezwSBbRhAxFAlSK
 XyNptLYYFjGVCrAmMJ+R00DTZFQdG/SUVxZtS6+6ZRhAECxzJKmr2ZxRmi1RhJbSfyPD2lLW1aY
 BzSv4fYzKmdxGsMI6Pv3P6wBtcIqLcuSVRz4ysW03b5S7pgDLc9QUTUcNIB97xPbgEZ2XDfGPbp
 qV3iUO+psW+vAzksen0nz2sZMytF5EB2QHkg7ozFPfYSPw8Puz9JY/PWMUvbItfdGksqPxKXehL
 t2cL8FHJNZrJagq/HChLJso5UwqXKm3Jn575NZvzPGENCtXR9PseW/ggyFCTBan3S5qUREgsXr2
 LKR2X4Xo0LQbuGzK+aUvQB7IwMRfDBfWmeO0pNZzvmo9fkhnGg7s1LuigLiaoU
X-Received: by 2002:a05:600c:8907:b0:480:25ae:9993 with SMTP id
 5b1f17b1804b1-48069c480d5mr83663185e9.20.1769693563686; 
 Thu, 29 Jan 2026 05:32:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm13976799f8f.25.2026.01.29.05.32.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:32:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 0/9] monitor/hmp: Reduce target-specific definitions
Date: Thu, 29 Jan 2026 14:32:32 +0100
Message-ID: <20260129133241.35990-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


