Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD7FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOJ-0006RB-5l; Tue, 06 May 2025 10:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOH-0006Qc-G8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOF-00011q-7k
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso3710068f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542114; x=1747146914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8IJm7D/h+TTh6vMPLy4x/Ypy1SJR36i3aKLyqJFnHoM=;
 b=ID8TEdbu9fT2x+f/zFejoYfj9aQ7hadB4L5pMg/2q6hFj8Jc0ZNJ4P08arS1Z+HVxz
 bKIsSqOVBpwizNSKMmcLCKU8XaribjQ0mfDmUZi8wkdPpKCcDEFUijCrN77pMqmDFlHj
 0M+unl9tOIympFKZIVH9QZPDJoKoEJCkDbYaBkukplMnMsJJf7LIjE+g5kBFO0XSLfr9
 4xARmfRT+mLYhLEiSGXv21W40HxpZYl95Jjwwka/ep5WPWuETzkz/BwMCivrNpON3qAa
 Xx/a8vheUsQlMpYdgLF7QeFTbWqSz2br3SSO10QanDyJgQXvl/NhslXyOHfPOUNaOBif
 tidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542114; x=1747146914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8IJm7D/h+TTh6vMPLy4x/Ypy1SJR36i3aKLyqJFnHoM=;
 b=LF3cKjU15ocOenZm+YqM9ZY/96sX/9gRktYERZayw8KYf3Ja/gT0+2oye1Z0ZsIyJ9
 4qZSI3Oqh4aGYAjUnQbOgeVkrzCwdanUbs2v+JgOQ/food1+B0DNyTsisIAaDJaC+1b+
 BOoGQw26QoU1vsE3YRfixHo1gS8Ebs8rLBScFqIJvVYBJiuNuH/wf55xZap/ryfZ/wcR
 6U5qqP4WbBw8vlqiFc5wAmE1/LujUk6tB5RBfvx93IV4gW8BKwEVgv7ZahpWIVtRt5JH
 Zh5RaBBgx9OUww/oVSWd8oKuG5F31u5D8pJgCDRzReKOCRlKKJl+y8B+P01x9Zm6ZU4b
 o7BQ==
X-Gm-Message-State: AOJu0YzZEdmCssOCn0St6yOC8m6ErvHeQO+zbkzgPq8UIqcN7Ly+Q+3H
 AHo586yH6JVEsbkFmYii9KTky6/zawujLDR7HyD2yRBl9jqWNzOKceNdJNGU+SxGmRWzQvN3ajk
 G
X-Gm-Gg: ASbGnctJ+Rg+gwYrU+UfJd8awJQ3N3BoiScOn22SI3gTRYa44mhFjQ4THuEzNXckMyl
 rLZjYVDUNQwD1fjHLVh02h4lScpbVy5XPT/4W6RgG2G/t8AVYSHemCLNAJxpQP8nEcwpjtsFvXm
 etoRhOjCIyoc+0KI44bKrho1Vg47VRYc/lDl6wk2YvO+89CMPjZlCPtipE57vVHsD0q5dHHdksr
 v7Ojy78YxjmGw9qq33VAd0Gazx5pmAj1uTAx5txXtrczBhWxNs851uSMCWxA0r3TgacLYXf/OM2
 mT91+scVJcInGL/qIpbFplCVogCgFmEiot2q44KB6Z0l7KvDiHFiKxMuaNG3ZPaaYPACKtTNSG8
 a+OjWmp/9EtVKvzLZ36hI
X-Google-Smtp-Source: AGHT+IGU8UZlmPSIynqxPR0B9C9eM6Rkidj83nc66jqP8LQPDvasOCYAECnV7Qire/EHrgXvvVlGjw==
X-Received: by 2002:a05:6000:2dc6:b0:3a0:8707:dad6 with SMTP id
 ffacd0b85a97d-3a099ad1ab2mr14732250f8f.3.1746542113661; 
 Tue, 06 May 2025 07:35:13 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3403sm13797270f8f.28.2025.05.06.07.35.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/22] Misc HW patches for 2025-05-06
Date: Tue,  6 May 2025 16:34:49 +0200
Message-ID: <20250506143512.4315-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:

  Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250506

for you to fetch changes up to dc495b919f1d9d98e01aea22f545fdc7de07e28d:

  hw/isa/ich9: Remove stray empty comment (2025-05-06 16:32:02 +0200)

----------------------------------------------------------------
Misc HW patches

- Allow using plugins on BSD user-emulation
- Inline VMSTATE_CPU() macro
- Fix headear includes for HVF x86
- Build hw/hyperv/ files once
- Various typo fixed

----------------------------------------------------------------

Eric Auger (3):
  hw/pci/pcie_port: Fix pcie_slot_is_hotpluggbale_bus typo
  hw/acpi/ged: Fix wrong identation
  hw/i386/acpi-build: Fix build_append_notfication_callback typo

Gustavo Romero (6):
  qom/object: Fix typo in comment
  hw/core/machine: Fix indentation
  hw/i386/acpi-build: Update document reference
  hw/i386/acpi-build: Fix typo and grammar in comment
  hw/acpi/pcihp: Fix typo in function name
  hw/isa/ich9: Remove stray empty comment

Philippe Mathieu-Daudé (4):
  target/migration: Inline VMSTATE_CPU()
  target/i386/hvf: Include missing 'exec/target_page.h' header
  system/hvf: Avoid including 'cpu.h'
  system/hvf: Expose hvf_enabled() to common code

Pierrick Bouvier (8):
  bsd-user: add option to enable plugins
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit
  hw/hyperv/hyperv: common compilation unit

Steve Sistare (1):
  qom: Factor qom_resolve_path() out

 MAINTAINERS                     |  1 +
 hw/i386/acpi-build.h            |  2 +-
 include/hw/acpi/pcihp.h         |  2 +-
 include/hw/core/cpu.h           | 12 ------------
 include/hw/hyperv/hyperv.h      |  3 ++-
 include/system/hvf.h            | 17 +++++++++++------
 include/system/hvf_int.h        |  2 ++
 accel/stubs/hvf-stub.c          | 12 ++++++++++++
 bsd-user/main.c                 | 12 ++++++++++++
 hw/acpi/acpi-pci-hotplug-stub.c |  2 +-
 hw/acpi/generic_event_device.c  | 10 +++++-----
 hw/acpi/ich9.c                  |  2 +-
 hw/acpi/pcihp.c                 |  2 +-
 hw/acpi/piix4.c                 |  2 +-
 hw/core/machine.c               |  8 ++++----
 hw/hyperv/hyperv.c              |  3 ++-
 hw/hyperv/syndbg.c              |  9 ++++++---
 hw/hyperv/vmbus.c               |  2 +-
 hw/i386/acpi-build.c            | 10 +++++-----
 hw/isa/lpc_ich9.c               |  1 -
 hw/pci/pcie_port.c              |  4 ++--
 qom/object.c                    |  2 +-
 qom/qom-qmp-cmds.c              | 21 +++++++++++++++------
 target/alpha/machine.c          |  2 +-
 target/hppa/machine.c           |  2 +-
 target/i386/hvf/hvf.c           |  1 +
 target/microblaze/machine.c     |  2 +-
 target/openrisc/machine.c       |  2 +-
 accel/stubs/meson.build         |  1 +
 hw/hyperv/meson.build           | 11 ++++++-----
 30 files changed, 99 insertions(+), 63 deletions(-)
 create mode 100644 accel/stubs/hvf-stub.c

-- 
2.47.1


