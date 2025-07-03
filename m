Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F55C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHbd-0003CR-Lx; Thu, 03 Jul 2025 06:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbX-00034Z-L0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbV-0000ei-6r
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so618849f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540143; x=1752144943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f+2R1hBY3Aw7QOuX8M6Qxlc6ucglQYLGGejzuhYkZdw=;
 b=b0mG5AEHCmOcs9QXh0FUiJsWAeVpnMnny+5k5Socr9n022Ghg5w9ORw+DajMr4ch4B
 aK+2OYfkSNjH7W7CHLEaqKqquxMYwmWNWwqJpke85T/ytB6rDCtxUzP2BPP/NzSEzhh6
 ICiHUEVq6amPwquup/E1qKi5QluMe/kgFjhSoTK+Cb7OGCivRT7irwnxfxWg6Gw6mw62
 HsGxHWI7ZwMQiUVbWoi2V3OT/2IJzR9LqJbSqAN98YDUPyWPXQ4HoeIleWjiz4i5Qhg7
 j/F8aHbhprje3DbTfRmrui3sASk9288Ue2sgqYy2rG9GkQLoVaQhH9yg0JIWNlIupsKY
 9pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540143; x=1752144943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+2R1hBY3Aw7QOuX8M6Qxlc6ucglQYLGGejzuhYkZdw=;
 b=RTcwHwMvNUS9iBEntpwP7ZrLLTHoCmlocmzZBnCosy35477GHqu/8MQacYDido4TiT
 jhYESKjx7JGnMpA0eGzxl14x7wLvEQjFHWXICAr75nqty2cPICjUW9YHqQUpHJboNTjh
 9lptZpzCBVJrkd9lXP/3Hqc767AE+sEtcSc8YdOgtwLUv0Ak7UkEnIN/ISEYloJxpKhX
 rIuKbeqnYw8CTBcrRx3qFy9JkDXUh7pNuRjc9XhO+qdGWkv+WIFwtNdPVz714etdzXhr
 QWHQ/KX8/Lid6dm+hkWonKfHQi1BOG+ByixiHDXQX5Y6CkK1xAdI9m6HxQaR2dj6fc38
 6Pdw==
X-Gm-Message-State: AOJu0YypVcA2YRafq3v/fY09+C8iz2cvpWAti4rCYX5W7RXrA/fQDWQi
 vJ4bwzz0xOKwVSepm8YGdEkuhRgRUZv9V73rRJLRGAD8UpZwx9j194MIYVeVGuvP6kRmDhjX99Z
 ZvDQ+X2Y=
X-Gm-Gg: ASbGnctsdqgjdY7bA2jDJxl31PVm9FIegY1PNNtsX3lbJ6gHp2HUnjEWrWY6IPXQ8C7
 WCutHqwepbcc2rFo7ulDY+gK+FfDkah0rgy4wbLqOKxzihSpuaAaNbcDdy+6/Y+2uyyzUpHOh02
 OPL7hm6LbILvREnOcCkMMVlZeuf7y3Rbtd0g2mfvW5Ly8m2Usem34Onsa/esOueCPByD2sdGr6U
 LH7gUULAATK2rDj8/x2rGGpWL/x6LPdO23PcDjeUriq3CsQd+e7hY/AdklPdeYW5DIQyqwBNNAd
 m2nfZAGOxlFiblikFhfC9Hs6fHklw4+9k82TqFMitAS7OBBisOzodIHqlo1WNvB8juWh9aS+f5n
 E2YiMS1tjN6c=
X-Google-Smtp-Source: AGHT+IFEI3kP7+/Q7bvMToK/ATcDsgPgakMUcVNY2RKc9MxdqMTNkkAmPrF1OGt99dCKrN5LxALVVw==
X-Received: by 2002:a05:6000:1885:b0:3a9:16f4:7a38 with SMTP id
 ffacd0b85a97d-3b34243febamr1912922f8f.2.1751540142628; 
 Thu, 03 Jul 2025 03:55:42 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e24bsm23412215e9.16.2025.07.03.03.55.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:55:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/69] accel: Preparatory cleanups for split-accel
Date: Thu,  3 Jul 2025 12:54:26 +0200
Message-ID: <20250703105540.67664-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Missing review: 23-24, 27

Since v4:
- Addressed Pierrick & Zhao review comments
- Added R-b tags

Few changes needed before being able to add the
split acceleration:

- few method docstring added
- remove pointless stubs
- propagate soon required AccelState argument
- try to reduce current_accel() uses
- move declarations AccelClass <-> AccelOpsClass
- display model name in 'info cpus'
- add 'info accel' command to QMP/HMP
- make accel_create_vcpu_thread() more generic
- introduce hwaccel_enabled()

I plan to send a PR once fully reviewed (v5 likely final, 69 is a good number).

Regards,

Phil.

Philippe Mathieu-Daudé (69):
  system/memory: Restrict eventfd dispatch_write() to emulators
  system/runstate: Document qemu_add_vm_change_state_handler()
  system/cpus: Defer memory layout changes until vCPUs are realized
  system/cpus: Assert interrupt handling is done with BQL locked
  accel: Keep reference to AccelOpsClass in AccelClass
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  accel/kvm: Remove kvm_init_cpu_signals() stub
  accel/kvm: Reduce kvm_create_vcpu() declaration scope
  accel: Propagate AccelState to AccelClass::init_machine()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/hvf: Re-use QOM allocated state
  accel/tcg: Prefer local AccelState over global current_accel()
  accel: Directly pass AccelState argument to AccelClass::has_memory()
  accel/kvm: Directly pass KVMState argument to do_kvm_create_vm()
  accel: Remove unused MachineState argument of AccelClass::setup_post()
  accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
  accel: Move supports_guest_debug() declaration to AccelClass
  accel: Move cpus_are_resettable() declaration to AccelClass
  accel: Move cpu_common_[un]realize() declarations to AccelOpsClass
  accel/system: Convert pre_resume() from AccelOpsClass to AccelClass
  hw/core/machine: Display CPU model name in 'info cpus' command
  accel/tcg: Remove 'info opcount' and @x-query-opcount
  accel/tcg: Remove profiler leftover
  accel/tcg: Factor tcg_dump_flush_info() out
  accel/tcg: Factor tcg_dump_stats() out for re-use
  accel/tcg: Extract statistic related code to tcg-stats.c
  qapi: Move definitions related to accelerators in their own file
  accel/system: Introduce @x-accel-stats QMP command
  accel/system: Add 'info accel' on human monitor
  accel/tcg: Implement get_[vcpu]_stats()
  accel/hvf: Implement get_vcpu_stats()
  accel/hvf: Report missing com.apple.security.hypervisor entitlement
  accel/hvf: Restrict internal declarations
  accel/hvf: Move per-cpu method declarations to hvf-accel-ops.c
  accel/hvf: Move generic method declarations to hvf-all.c
  cpus: Document CPUState::vcpu_dirty field
  accel/hvf: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/whpx: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/kvm: Remove kvm_cpu_synchronize_state() stub
  accel/system: Document cpu_synchronize_state()
  accel/system: Document cpu_synchronize_state_post_init/reset()
  accel/nvmm: Expose nvmm_enabled() to common code
  accel/whpx: Expose whpx_enabled() to common code
  accel/system: Introduce hwaccel_enabled() helper
  target/arm: Use generic hwaccel_enabled() to check 'host' cpu type
  accel/dummy: Extract 'dummy-cpus.h' header from 'system/cpus.h'
  accel/dummy: Factor dummy_thread_precreate() out
  accel/tcg: Factor tcg_vcpu_thread_precreate() out
  accel: Factor accel_create_vcpu_thread() out
  accel: Introduce AccelOpsClass::cpu_thread_routine handler
  accel/dummy: Convert to AccelOpsClass::cpu_thread_routine
  accel/tcg: Convert to AccelOpsClass::cpu_thread_routine
  accel/hvf: Convert to AccelOpsClass::cpu_thread_routine
  accel/kvm: Convert to AccelOpsClass::cpu_thread_routine
  accel/nvmm: Convert to AccelOpsClass::cpu_thread_routine
  accel/whpx: Convert to AccelOpsClass::cpu_thread_routine
  accel: Factor accel_cpu_realize() out
  accel: Pass old/new interrupt mask to handle_interrupt() handler
  accel: Expose and register generic_handle_interrupt()
  accel: Always register AccelOpsClass::kick_vcpu_thread() handler
  accel: Always register AccelOpsClass::get_elapsed_ticks() handler
  accel: Always register AccelOpsClass::get_virtual_clock() handler
  accel/tcg: Factor tcg_vcpu_init() out for re-use
  accel/tcg: Factor mttcg_cpu_exec() out for re-use
  accel/tcg: Factor rr_cpu_exec() out
  accel/tcg: Clear exit_request once in tcg_cpu_exec()
  accel/tcg: Unregister the RCU before exiting RR thread

 MAINTAINERS                       |   1 +
 qapi/accelerator.json             |  74 +++++++
 qapi/machine.json                 |  68 +-----
 qapi/qapi-schema.json             |   1 +
 accel/accel-internal.h            |   2 +
 accel/dummy-cpus.h                |  15 ++
 accel/kvm/kvm-cpus.h              |   1 -
 accel/tcg/internal-common.h       |   2 +
 accel/tcg/tcg-accel-ops-icount.h  |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.h   |   4 +-
 accel/tcg/tcg-accel-ops.h         |   5 +-
 include/hw/core/cpu.h             |   3 +-
 include/qemu/accel.h              |  22 +-
 include/system/accel-ops.h        |  42 +++-
 include/system/cpus.h             |   5 -
 include/system/hvf.h              |  38 ----
 include/system/hvf_int.h          |  37 +++-
 include/system/hw_accel.h         |  34 ++-
 include/system/kvm.h              |   8 -
 include/system/nvmm.h             |  23 +-
 include/system/runstate.h         |  10 +
 include/system/whpx.h             |  27 +--
 target/i386/whpx/whpx-accel-ops.h |   1 -
 accel/accel-common.c              |  55 ++++-
 accel/accel-qmp.c                 |  34 +++
 accel/accel-system.c              |  35 ++-
 accel/dummy-cpus.c                |  11 +-
 accel/hvf/hvf-accel-ops.c         | 341 +++++-------------------------
 accel/hvf/hvf-all.c               | 281 ++++++++++++++++++++++--
 accel/kvm/kvm-accel-ops.c         |  25 +--
 accel/kvm/kvm-all.c               |  38 ++--
 accel/qtest/qtest.c               |  10 +-
 accel/stubs/kvm-stub.c            |   9 -
 accel/stubs/nvmm-stub.c           |  12 ++
 accel/stubs/whpx-stub.c           |  12 ++
 accel/tcg/monitor.c               | 212 +------------------
 accel/tcg/tcg-accel-ops-icount.c  |   8 +-
 accel/tcg/tcg-accel-ops-mttcg.c   |  28 +--
 accel/tcg/tcg-accel-ops-rr.c      |  40 ++--
 accel/tcg/tcg-accel-ops.c         |  44 ++--
 accel/tcg/tcg-all.c               |  20 +-
 accel/tcg/tcg-stats.c             | 206 ++++++++++++++++++
 accel/xen/xen-all.c               |  13 +-
 bsd-user/main.c                   |   2 +-
 gdbstub/system.c                  |   7 +-
 hw/core/machine-hmp-cmds.c        |   4 +-
 hw/core/machine-qmp-cmds.c        |   2 +
 linux-user/main.c                 |   2 +-
 system/cpus.c                     |  55 ++---
 system/memory.c                   |  11 +-
 system/physmem.c                  |   8 +
 target/arm/arm-qmp-cmds.c         |   5 +-
 target/arm/cpu.c                  |   5 +-
 target/arm/hvf/hvf.c              |  11 +-
 target/i386/hvf/hvf.c             |  11 +-
 target/i386/hvf/x86hvf.c          |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c |  17 +-
 target/i386/nvmm/nvmm-all.c       |  29 +--
 target/i386/whpx/whpx-accel-ops.c |  18 +-
 target/i386/whpx/whpx-all.c       |  33 ++-
 tests/qtest/qmp-cmd-test.c        |   1 -
 accel/meson.build                 |   2 +-
 accel/stubs/meson.build           |   2 +
 accel/tcg/meson.build             |   1 +
 hmp-commands-info.hx              |  26 ++-
 qapi/meson.build                  |   1 +
 66 files changed, 1186 insertions(+), 928 deletions(-)
 create mode 100644 qapi/accelerator.json
 create mode 100644 accel/dummy-cpus.h
 create mode 100644 accel/accel-qmp.c
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 accel/tcg/tcg-stats.c

-- 
2.49.0


