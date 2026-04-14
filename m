Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41546F531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRfS-0001Ih-4a; Mon, 13 Apr 2026 20:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfO-0001G7-6m
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfL-0002f7-0A
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso27337075e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126603; x=1776731403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WssZ5uJWE2KTCsVGYiCPJWJhvSyVD2anQoKcMv+JU7Q=;
 b=Zpb+pnWToj4qWnve8oqoUPdLdMt/T8Y8XxSkV2Ztqeregz57Grkadnv29RAOMLhBWr
 X8vKELw9gJYhiB9MMvbEDT7UewHQZ6jZDRYCktQiI13dqPFpgmU+mUSefNUQUCj1wucg
 m+1Yl/tGh/g7Qh9JGTjXw1H0rDzTIOHYwv0f/xvx+qETafkjgDkZlklO1BQgprqS0rXu
 PkxU1Dfl8xcdAgaRhgfBt2qsUQFJdtfDy6wb5aRtQdSwaJHPbKar4qqtJAaF1qicQAFf
 7oe8klcPVvdaXK/6ABURCi1G+O17BxsWBo5yWD02ZRB9s7RARYK4PdKoF8oLzntDiPon
 EsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126603; x=1776731403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WssZ5uJWE2KTCsVGYiCPJWJhvSyVD2anQoKcMv+JU7Q=;
 b=onNSLb7KiaLpt7Aciwy5TN+PPzNGWbvQG8n/vLbgxJJTvjFhw6fdsPgVIfTiH6f1iA
 if9dE6yzixZPbf73AKQwlFDsLoabJAiw/K5ii3RRJzbfz35ySJofCcCqeyg+ruSPhy1Y
 oLaLUPPrmfI5bKjayBQcCDqduiZevezrOCvaztX3ORL12ZO+eVuXUgMNGWAqK6pJlOyn
 0u0w/4jI6FPHbhueODZLfPGVIqoooqY13RdEmVHcPxdfqhgR0WKdq3ihoVfZ6bcnu+jl
 KOHxJZH7tUXt4szwJzxIV5em2WK6Y9NXSYr5mo+DAoMyM/2UBEXqD1SNwIx9QgNZWhXb
 h+/w==
X-Gm-Message-State: AOJu0YzItALNpPpLxNyX2OfQCI4nYPaBQloqyGjgcM1kCO7NB78qmrpK
 hZjYzlz2/1cP99a/v7+qnGrSNCfRWehCjk3gqXRr82K1NgOngKLvYFI2oyJ5nsTVLfGQiATYtxq
 71gN31ZU=
X-Gm-Gg: AeBDieuOIhz/jZ2WLV6jIG4Ah5RGpnUWGhYZQOQnCgzTWiOXfKU71zlzZi8IX/MGxw1
 lmxvP2uIJ5txLDcc9MRwEbY8YIhWpoTM8cO2EnUBaT8rL8hlyFpVnKjtSOV5u4USRsD/DO+lN1l
 1C0JJBB57DeXut4dTs95a/C9DZ8dqbqeer9Ignf1wfStUitawEA2Qcwy9NG/P9BqVs+ZdMN6irT
 6i8K3f1SB6tQqkgf6qDItp7f4ILHZHSQ785C+j/xsp0vMrnU7q5gByH86gBxQUlLQ/VI14UtNax
 teLFlj8P5zGMGznrwqgpdKtvJl2ncIxCs5S2MSg4I9dkmmG0RRN30C3Ms32mFsUiAhDIXr136eC
 BRB9Y7y3A70TLARXC3D1eJ5+utPToQ2Lj5+ih1o3/Ck3TOPum26oATAP0cEsD6D9db7ITQewJux
 ZB9RW7bgWnkH8ksOpdnIzRG8EPx/06iVBe2IBIIj7cRI9rHnJq0fnxrYlWvlDxPZTxSRRcu9aV
X-Received: by 2002:a05:600d:1c:b0:487:1108:48bc with SMTP id
 5b1f17b1804b1-488d6836d87mr160121775e9.17.1776126603345; 
 Mon, 13 Apr 2026 17:30:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e826sm12835515e9.6.2026.04.13.17.30.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/27] monitor: Remove need of per-target handlers
Date: Tue, 14 Apr 2026 02:29:32 +0200
Message-ID: <20260414003001.97571-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missing review: 1-3, 16, 18

Since v2:
- Addressed rth review comments

Changes needed for the single binary (and heterogeneous emulation).

Convert target_monitor_defs() and target_monitor_defs()
to SysemuCPUOps fields, adapting the 4 targets using these
'legacy' code.

Instead of filtering the commands per target / device at
build time, add a new field to HMPCommand to filter them
at runtime, allowing to compile the command array once.

Philippe Mathieu-Daudé (27):
  stubs: Rename monitor* -> qmp* files
  monitor/meson: Use SPICE with migration HMP commands
  monitor: Restrict monitor_set_cpu() method scope
  monitor: Make 'info via' a generic command
  monitor: Make Xen emulation commands generic ones
  system: Expose 'arch_init.h' as 'qemu/base-arch-defs.h'
  monitor: Introduce HMPCommand::arch_bitmask field
  hw/s390x: Reduce 'monitor/monitor.h' inclusions
  monitor: Do not check TARGET_S390X to build s390x commands
  monitor: Do not check TARGET_I386 to build target/i386/ commands
  monitor: Do not check TARGET_I386 to build 'info sgx' command
  monitor: Do not check TARGET_I386 to build 'info sev' command
  monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
  monitor: Do not check multiple TARGET_* to build 'info tlb' command
  cpus: Introduce SysemuCPUOps::monitor_get_register() hook
  target/riscv: Register target_get_monitor_def in SysemuCPUOps
  monitor: Remove target_get_monitor_def()
  monitor: Have MonitorDef::get_value() always return int64_t type
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header
  monitor: Forward-declare the MonitorDef type
  cpus: Introduce SysemuCPUOps::monitor_defs hook
  target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/sparc: Replace target_monitor_defs ->
    SysemuCPUOps::monitor_defs
  monitor: Remove target_monitor_defs()
  monitor: Merge hmp-target.c code within hmp-cmds.c

 MAINTAINERS                                   |  14 ++-
 include/hw/core/sysemu-cpu-ops.h              |  14 +++
 include/hw/s390x/storage-attributes.h         |   4 -
 include/hw/s390x/storage-keys.h               |   3 -
 include/monitor/hmp-target.h                  |  46 -------
 include/monitor/hmp.h                         |  21 ++++
 include/monitor/monitor.h                     |   1 -
 .../qemu/base-arch-defs.h                     |  10 +-
 include/qemu/typedefs.h                       |   1 +
 monitor/monitor-internal.h                    |  13 +-
 target/riscv/internals.h                      |   3 +
 hw/i386/kvm/xen-stubs.c                       |  12 ++
 hw/i386/sgx-hmp-stub.c                        |  16 +++
 hw/i386/sgx-stub.c                            |   6 -
 hw/i386/sgx.c                                 |   1 -
 hw/misc/mos6522-stub.c                        |  16 +++
 hw/pci/pci.c                                  |   2 +-
 hw/s390x/s390-skeys.c                         |   2 +
 hw/s390x/s390-stattrib.c                      |   2 +
 monitor/hmp-cmds.c                            |  41 ++++++-
 monitor/hmp-target.c                          | 115 ------------------
 monitor/hmp.c                                 |  45 ++++++-
 stubs/hmp-cmd-info_mem.c                      |  12 ++
 stubs/hmp-cmd-info_sev.c                      |  16 +++
 stubs/hmp-cmd-info_tlb.c                      |  12 ++
 stubs/hmp-cmds-hw-s390x.c                     |  15 +++
 stubs/hmp-cmds-target-i386.c                  |  13 ++
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}    |   0
 ...or-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |   0
 .../{monitor-cpu-s390x.c => qmp-cpu-s390x.c}  |   0
 stubs/{monitor-cpu.c => qmp-cpu.c}            |   0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}  |   0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}  |   0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}  |   0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}  |   0
 stubs/target-get-monitor-def.c                |  29 -----
 stubs/target-monitor-defs.c                   |   7 --
 system/arch_init.c                            |   2 +-
 system/qdev-monitor.c                         |   2 +-
 system/vl.c                                   |   2 +-
 target/i386/cpu-apic.c                        |   1 -
 target/i386/cpu.c                             |  29 +++++
 target/i386/monitor.c                         |  26 ----
 target/i386/sev-system-stub.c                 |   6 -
 target/i386/sev.c                             |   1 -
 target/m68k/cpu.c                             |  18 +++
 target/m68k/monitor.c                         |  22 ----
 target/ppc/monitor.c                          |   2 -
 target/riscv/cpu.c                            |   1 +
 target/riscv/monitor.c                        |  12 +-
 target/sh4/monitor.c                          |   1 -
 target/sparc/cpu.c                            |  19 +++
 target/sparc/monitor.c                        |  19 ---
 target/xtensa/monitor.c                       |   1 -
 hmp-commands-info.hx                          |  26 ++--
 hmp-commands.hx                               |  13 +-
 hw/i386/meson.build                           |   1 +
 hw/misc/meson.build                           |   1 +
 migration/meson.build                         |   2 +-
 monitor/meson.build                           |   5 +-
 stubs/meson.build                             |  23 ++--
 61 files changed, 375 insertions(+), 352 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)
 create mode 100644 hw/i386/sgx-hmp-stub.c
 create mode 100644 hw/misc/mos6522-stub.c
 delete mode 100644 monitor/hmp-target.c
 create mode 100644 stubs/hmp-cmd-info_mem.c
 create mode 100644 stubs/hmp-cmd-info_sev.c
 create mode 100644 stubs/hmp-cmd-info_tlb.c
 create mode 100644 stubs/hmp-cmds-hw-s390x.c
 create mode 100644 stubs/hmp-cmds-target-i386.c
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)
 delete mode 100644 stubs/target-get-monitor-def.c
 delete mode 100644 stubs/target-monitor-defs.c

-- 
2.53.0


