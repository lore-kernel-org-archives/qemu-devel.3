Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF4EC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCd3-0004uz-PC; Tue, 21 Jan 2025 06:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCd2-0004ua-2g
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCcv-0003Jd-Kz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso38456415e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459658; x=1738064458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wb6pqRiqYW/ELGfXwHxoafyELsOoRfg106goBLltgwQ=;
 b=Zl5XxVi2a4DlX3Uj+JbFUifJ6WtPnVBRSuVgCxIpMn/eGJWvG0rzzKN2ggdEueS+FM
 ESQZ+CNplNbVpVrEXdKZpWVcUG5xGBnFi+8H2AXFH+UiP9umusRkhLbTKCimyhlWtcCd
 QMWQwvjAGp/0Vm5nx/sl4SytuZ3YONEw2M3fcBpcrcJTH3OZPSmLGv2NA0Oa/6G/tasq
 M3/M+9ROshKcUqlm8FLL2caaVNtbmpcThEI7ORbCFic0b3ozQw1rOHs+VMa83gSgG3da
 gfwg2PPz+mPATLj28SBwjETnfuONSltGvriyMS9Ed02uxx8bFX7VKccQdbLAJV/QgCIf
 uVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459658; x=1738064458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wb6pqRiqYW/ELGfXwHxoafyELsOoRfg106goBLltgwQ=;
 b=qp8c+be/f32ZW9emV9LMXKx+25F5kDSYuV6Bh6cNmBeeT7rKM7ZRdQDNSS4KmvGcae
 DF1s/nUTc70lKITxQkCg8LoQiuHz+WGbva8S+jLQmxWZs8xbc981wTwlGY0M1uQORBCm
 YDkVFvjKsUYk1jt80GWDXe+r5rmyGX94ysBYYTkuVP22TosUd2Rq5opd/UowIV5YesNm
 2VVt4QJVCbNWdh2JvI/kX+PPjE8SiIFVCv2cjwwW1osWaS6M2Oo1jpOuc64b3mYTTP8l
 hLak9Vby0n/S7lxE/2KPwMoa8HuekLjwCH/2xjvRbPTJV1pkW/SgHVZQ67coXaLI1c3K
 8fFA==
X-Gm-Message-State: AOJu0YzVWkimUnnQGJwxaMw8UOLD/AZ8Bp4X+vXv+K0hP6nZQMTsEyhL
 EcczBQFjE/FIn3YAIixyH4/PkCI6nl60Sp2qN9twzGxVlOVEfWvLTmY1PXbPgbkT2b6b12vb9nX
 bEqQ=
X-Gm-Gg: ASbGncsw7CT7iAbCY9Eblq8/TNxUq1NEUA9aayVkh8vA87JaADkYmoHCNcIhS9MKn7C
 VtLKbPOOXnSVjMoKVKOKPPWa7tiLhyayv9lluOI+cr4F7EkVI1PbOnN4nk7DhGf6zevVX/2jsOb
 l3+nS5ZEBAHM9EAzdCruF1slsXjip+N7Z6hzHD9HOfiKJV+ZgDFqFDdCIcfJMEo9MPLdFlG+S4i
 rjZBjQ/GszoCdFfHH3sIxSGcPC6PAmQCRBpcYZzkOV6Q7vmzzD+AIPCVylVlbGNpJqBDx0t5+2/
 afbUezL/mK1GnYauWbLy1avTrum1oKrB2tQiRcn9tmyk
X-Google-Smtp-Source: AGHT+IHvCwHTxvrZLJtGZxKuMxkpCKgyNfvOwzXnYWAoIfvtGRSVA33e7SjQFpKw+svx2RNDvz/BhQ==
X-Received: by 2002:a05:600c:3593:b0:434:a239:d2fe with SMTP id
 5b1f17b1804b1-4389144d62cmr139826785e9.28.1737459658183; 
 Tue, 21 Jan 2025 03:40:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c752935csm232604555e9.26.2025.01.21.03.40.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:40:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/11] cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:45 +0100
Message-ID: <20250121114056.53949-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Use cached CPUState::cc to get CPUClass.
Main rationale is overall code style.

Philippe Mathieu-Daudé (11):
  cpus: Cache CPUClass early in instance_init() handler
  cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
  accel: Prefer cached CpuClass over CPU_GET_CLASS() macro
  user: Prefer cached CpuClass over CPU_GET_CLASS() macro
  disas: Prefer cached CpuClass over CPU_GET_CLASS() macro
  gdbstub: Prefer cached CpuClass over CPU_GET_CLASS() macro
  hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS() macro
  hw/core/generic-loader: Prefer cached CpuClass over CPU_GET_CLASS
    macro
  target/arm: Prefer cached CpuClass over CPU_GET_CLASS() macro
  target/microblaze: Prefer cached CpuClass over CPU_GET_CLASS() macro
  target/openrisc: Prefer cached CpuClass over CPU_GET_CLASS() macro

 include/hw/core/cpu.h          | 10 ++-----
 linux-user/alpha/target_proc.h |  2 +-
 accel/accel-target.c           | 12 ++++----
 accel/tcg/tcg-accel-ops.c      |  3 +-
 accel/tcg/translate-all.c      |  2 +-
 accel/tcg/watchpoint.c         |  9 +++---
 bsd-user/signal.c              |  4 +--
 cpu-common.c                   | 10 +++----
 cpu-target.c                   |  9 ++----
 disas/disas-common.c           |  5 ++--
 gdbstub/gdbstub.c              | 26 ++++++----------
 gdbstub/system.c               |  7 ++---
 gdbstub/user-target.c          |  6 ++--
 gdbstub/user.c                 |  7 ++---
 hw/acpi/cpu.c                  |  4 +--
 hw/acpi/cpu_hotplug.c          |  3 +-
 hw/core/cpu-common.c           | 16 +++++-----
 hw/core/cpu-system.c           | 55 ++++++++++++----------------------
 hw/core/generic-loader.c       |  5 +---
 linux-user/signal.c            |  4 +--
 target/arm/cpu.c               |  3 +-
 target/arm/tcg/cpu-v7m.c       |  3 +-
 target/microblaze/gdbstub.c    |  3 +-
 target/openrisc/gdbstub.c      |  3 +-
 24 files changed, 76 insertions(+), 135 deletions(-)

-- 
2.47.1


