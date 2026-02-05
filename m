Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4697EA7959
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpdx-0008Pf-Um; Wed, 04 Feb 2026 22:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpdw-0008PH-5S
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:02:56 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpdt-0007QQ-KR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:02:55 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso109926a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260571; x=1770865371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jkPFlg8BUjHFNU3QrKzJPmnhXCRvh6+BQ/DjEey7xGQ=;
 b=L1G9RsNCeYiznm+di5ND/5qhJDXsfiIydkjFskx5la98GRdO8FmIrBdrkGXPPJJO4U
 WOvsJfTetUIqe8OwY2C+kkVA89m+P2AZXdDKc8ydomooGi61k854bnblu0ypY0r5Ns30
 nWbPOykgcQu7ADw2/7EFBerk4YgZLERSJMwDyK2i80UHS9NHDFcvTLDvPOyyb+6uZ5j8
 dNuFfe7AU4z7xymlfTUf5wG6a/7n81HwoCajsTwXRp9rsLzpeMjrC3DjHxhzbgVNkNqy
 7DIBJuc0mDHitvGG/PmnnsV3+ntrf5heXld42UVSB6d3Pe0ymObpSLHCIPHV+5tHhVqN
 61Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260571; x=1770865371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkPFlg8BUjHFNU3QrKzJPmnhXCRvh6+BQ/DjEey7xGQ=;
 b=JYPtwtt8AMuT4gr7dUrVpo09Y3IW0sX1U8AopFXXov3ZL+jUN10OZYsLYZEhysT5Bp
 B1dYZmX/PNCZq1hFEIDGuHpzKcsXL5LCbUjDWGBycMv5b+OihQuk6jZTzsK+y9x9oPMz
 6GzSM6T+k0hitzDld8kcnVDSu1mNs28IEGAsTTIiQaayuhjMhEpkRsO788Q4vbGsg5C/
 0ibnjoBqV/cTL3VnGTcppH6tpO9Wxlf7b+E7K510RxQpCjWNKRgNQV1y/MC95clorDQS
 3K9t14P2B69mGLjfYsTwRN9JyGOcvJLa6WMj/rkHaAcLWXhcr3zfQ5czSPBatJqZJaEO
 WKgQ==
X-Gm-Message-State: AOJu0YwHhFZgnkoyrmFMfcj+4/8kuOCLb3na1moG2We+wl520egU5krP
 +07usqkfXJSdyL5qQKpvziIDElck6Yq4y9A3IHWMc87AEWR+UkpXik+NbA4JvBcjSqZnpXLnqT/
 wRT41Du/lxA==
X-Gm-Gg: AZuq6aIn68Krz3gNYz/0DKzBEEdiI/LSv7cWIfY3WZHqAhIqiW7Cn90rKVX8L34E5GG
 N3gHRw4M1er8Mamd8mGSdJwk+t2eTzN+dBMWjEHVb8SHXEiZig+ZrQNGo4rhQLcyFCw9m5CbiEJ
 91inOAgmY3b02ipmd4coCeJgufjtNRo09EfX85m3c206h0EVrR1Ai6MelcUSAkJY22L0KOKQRWo
 3x970UTyI/I2o8F/2djvatumWlGZhDq/PyWNgQaKsvWSLxXsUpx1jRMQYuRqCf4rGFTC83S0tsU
 bDrNff3K84u/VmUQhVWhKyjC8P+oqJ9ML1KcHO1VdzU4aDK6cx5sB10tlHH0c4S6Uj7Am3odA8P
 yHUp8sMGW1aJxJdNW4ldM62csZ8Tl7flKKr7wIM2Ff7MUxSMiwMt+Wp5+ZaDQBgsReMq8JSNYgh
 hg41B7fnQiNT6SQXMN29+9
X-Received: by 2002:a05:6a20:93a1:b0:364:be7:6ffa with SMTP id
 adf61e73a8af0-39372115576mr4710649637.36.1770260571116; 
 Wed, 04 Feb 2026 19:02:51 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:02:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 0/6] or1k: Rename the architecture from openrisc
Date: Thu,  5 Feb 2026 13:02:38 +1000
Message-ID: <20260205030244.266447-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

We have an odd mix of 'openrisc' and 'or1k' in use.
Standardize TARGET_ARCH and all of the filenames to use 'or1k'.


r~


Richard Henderson (6):
  target/or1k: Rename from openrisc
  include/hw/or1k: Rename from openrisc
  hw/or1k: Rename from openrisc
  tests/tcg/or1k: Rename from openrisc
  docs/system/or1k: Rename from openrisc
  hw/or1k: Rename or1k-sim.c from openrisc_sim.c

 include/exec/poison.h                              |  2 +-
 include/hw/{openrisc => or1k}/boot.h               |  6 +++---
 include/system/arch_init.h                         |  2 +-
 include/user/abitypes.h                            |  2 +-
 linux-user/{openrisc => or1k}/sockbits.h           |  0
 linux-user/{openrisc => or1k}/target_cpu.h         |  0
 linux-user/{openrisc => or1k}/target_elf.h         |  0
 linux-user/{openrisc => or1k}/target_errno_defs.h  |  0
 linux-user/{openrisc => or1k}/target_fcntl.h       |  0
 linux-user/{openrisc => or1k}/target_mman.h        |  0
 linux-user/{openrisc => or1k}/target_prctl.h       |  0
 linux-user/{openrisc => or1k}/target_proc.h        |  0
 linux-user/{openrisc => or1k}/target_ptrace.h      |  0
 linux-user/{openrisc => or1k}/target_resource.h    |  0
 linux-user/{openrisc => or1k}/target_signal.h      |  0
 linux-user/{openrisc => or1k}/target_structs.h     |  0
 linux-user/{openrisc => or1k}/target_syscall.h     |  0
 linux-user/{openrisc => or1k}/termbits.h           |  0
 linux-user/syscall_defs.h                          |  4 ++--
 target/{openrisc => or1k}/cpu-param.h              |  0
 target/{openrisc => or1k}/cpu-qom.h                |  0
 target/{openrisc => or1k}/cpu.h                    |  0
 target/{openrisc => or1k}/exception.h              |  0
 target/{openrisc => or1k}/helper.h                 |  0
 hw/{openrisc => or1k}/boot.c                       |  2 +-
 hw/{openrisc => or1k}/cputimer.c                   |  0
 hw/{openrisc/openrisc_sim.c => or1k/or1k-sim.c}    |  2 +-
 hw/{openrisc => or1k}/virt.c                       |  2 +-
 linux-user/{openrisc => or1k}/cpu_loop.c           |  0
 linux-user/{openrisc => or1k}/elfload.c            |  0
 linux-user/{openrisc => or1k}/signal.c             |  0
 system/qdev-monitor.c                              |  2 +-
 target/{openrisc => or1k}/cpu.c                    |  0
 target/{openrisc => or1k}/disas.c                  |  0
 target/{openrisc => or1k}/exception.c              |  0
 target/{openrisc => or1k}/exception_helper.c       |  0
 target/{openrisc => or1k}/fpu_helper.c             |  0
 target/{openrisc => or1k}/gdbstub.c                |  0
 target/{openrisc => or1k}/interrupt.c              |  0
 target/{openrisc => or1k}/interrupt_helper.c       |  0
 target/{openrisc => or1k}/machine.c                |  0
 target/{openrisc => or1k}/mmu.c                    |  0
 target/{openrisc => or1k}/sys_helper.c             |  0
 target/{openrisc => or1k}/translate.c              |  0
 tests/tcg/{openrisc => or1k}/test_add.c            |  0
 tests/tcg/{openrisc => or1k}/test_addc.c           |  0
 tests/tcg/{openrisc => or1k}/test_addi.c           |  0
 tests/tcg/{openrisc => or1k}/test_addic.c          |  0
 tests/tcg/{openrisc => or1k}/test_and_or.c         |  0
 tests/tcg/{openrisc => or1k}/test_bf.c             |  0
 tests/tcg/{openrisc => or1k}/test_bnf.c            |  0
 tests/tcg/{openrisc => or1k}/test_div.c            |  0
 tests/tcg/{openrisc => or1k}/test_divu.c           |  0
 tests/tcg/{openrisc => or1k}/test_extx.c           |  0
 tests/tcg/{openrisc => or1k}/test_fx.c             |  0
 tests/tcg/{openrisc => or1k}/test_j.c              |  0
 tests/tcg/{openrisc => or1k}/test_jal.c            |  0
 tests/tcg/{openrisc => or1k}/test_lf_add.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_div.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_eqs.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_ges.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_gts.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_les.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_lts.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_mul.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_nes.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_rem.c         |  0
 tests/tcg/{openrisc => or1k}/test_lf_sub.c         |  0
 tests/tcg/{openrisc => or1k}/test_logic.c          |  0
 tests/tcg/{openrisc => or1k}/test_lx.c             |  0
 tests/tcg/{openrisc => or1k}/test_movhi.c          |  0
 tests/tcg/{openrisc => or1k}/test_mul.c            |  0
 tests/tcg/{openrisc => or1k}/test_muli.c           |  0
 tests/tcg/{openrisc => or1k}/test_mulu.c           |  0
 tests/tcg/{openrisc => or1k}/test_sfeq.c           |  0
 tests/tcg/{openrisc => or1k}/test_sfeqi.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfges.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfgesi.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfgeu.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfgeui.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfgts.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfgtsi.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfgtu.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfgtui.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfles.c          |  0
 tests/tcg/{openrisc => or1k}/test_sflesi.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfleu.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfleui.c         |  0
 tests/tcg/{openrisc => or1k}/test_sflts.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfltsi.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfltu.c          |  0
 tests/tcg/{openrisc => or1k}/test_sfltui.c         |  0
 tests/tcg/{openrisc => or1k}/test_sfne.c           |  0
 tests/tcg/{openrisc => or1k}/test_sfnei.c          |  0
 tests/tcg/{openrisc => or1k}/test_sub.c            |  0
 MAINTAINERS                                        | 14 +++++++-------
 configs/targets/or1k-linux-user.mak                |  2 +-
 configs/targets/or1k-softmmu.mak                   |  2 +-
 docs/system/{openrisc => or1k}/cpu-features.rst    |  0
 docs/system/{openrisc => or1k}/emulation.rst       |  0
 docs/system/{openrisc => or1k}/or1k-sim.rst        |  0
 docs/system/{openrisc => or1k}/virt.rst            |  0
 .../{target-openrisc.rst => target-or1k.rst}       |  8 ++++----
 docs/system/targets.rst                            |  2 +-
 hw/Kconfig                                         |  2 +-
 hw/meson.build                                     |  2 +-
 hw/{openrisc => or1k}/Kconfig                      |  4 ++--
 hw/{openrisc => or1k}/meson.build                  |  4 ++--
 linux-user/meson.build                             |  2 +-
 linux-user/openrisc/meson.build                    |  5 -----
 linux-user/or1k/meson.build                        |  5 +++++
 linux-user/{openrisc => or1k}/syscall.tbl          |  0
 linux-user/{openrisc => or1k}/syscallhdr.sh        |  0
 target/Kconfig                                     |  2 +-
 target/meson.build                                 |  2 +-
 target/{openrisc => or1k}/Kconfig                  |  2 +-
 target/{openrisc => or1k}/insns.decode             |  0
 target/{openrisc => or1k}/meson.build              |  4 ++--
 tests/tcg/{openrisc => or1k}/Makefile              |  0
 119 files changed, 43 insertions(+), 43 deletions(-)
 rename include/hw/{openrisc => or1k}/boot.h (93%)
 rename linux-user/{openrisc => or1k}/sockbits.h (100%)
 rename linux-user/{openrisc => or1k}/target_cpu.h (100%)
 rename linux-user/{openrisc => or1k}/target_elf.h (100%)
 rename linux-user/{openrisc => or1k}/target_errno_defs.h (100%)
 rename linux-user/{openrisc => or1k}/target_fcntl.h (100%)
 rename linux-user/{openrisc => or1k}/target_mman.h (100%)
 rename linux-user/{openrisc => or1k}/target_prctl.h (100%)
 rename linux-user/{openrisc => or1k}/target_proc.h (100%)
 rename linux-user/{openrisc => or1k}/target_ptrace.h (100%)
 rename linux-user/{openrisc => or1k}/target_resource.h (100%)
 rename linux-user/{openrisc => or1k}/target_signal.h (100%)
 rename linux-user/{openrisc => or1k}/target_structs.h (100%)
 rename linux-user/{openrisc => or1k}/target_syscall.h (100%)
 rename linux-user/{openrisc => or1k}/termbits.h (100%)
 rename target/{openrisc => or1k}/cpu-param.h (100%)
 rename target/{openrisc => or1k}/cpu-qom.h (100%)
 rename target/{openrisc => or1k}/cpu.h (100%)
 rename target/{openrisc => or1k}/exception.h (100%)
 rename target/{openrisc => or1k}/helper.h (100%)
 rename hw/{openrisc => or1k}/boot.c (99%)
 rename hw/{openrisc => or1k}/cputimer.c (100%)
 rename hw/{openrisc/openrisc_sim.c => or1k/or1k-sim.c} (99%)
 rename hw/{openrisc => or1k}/virt.c (99%)
 rename linux-user/{openrisc => or1k}/cpu_loop.c (100%)
 rename linux-user/{openrisc => or1k}/elfload.c (100%)
 rename linux-user/{openrisc => or1k}/signal.c (100%)
 rename target/{openrisc => or1k}/cpu.c (100%)
 rename target/{openrisc => or1k}/disas.c (100%)
 rename target/{openrisc => or1k}/exception.c (100%)
 rename target/{openrisc => or1k}/exception_helper.c (100%)
 rename target/{openrisc => or1k}/fpu_helper.c (100%)
 rename target/{openrisc => or1k}/gdbstub.c (100%)
 rename target/{openrisc => or1k}/interrupt.c (100%)
 rename target/{openrisc => or1k}/interrupt_helper.c (100%)
 rename target/{openrisc => or1k}/machine.c (100%)
 rename target/{openrisc => or1k}/mmu.c (100%)
 rename target/{openrisc => or1k}/sys_helper.c (100%)
 rename target/{openrisc => or1k}/translate.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addc.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_and_or.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bnf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_divu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_extx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_fx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_j.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_jal.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_eqs.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_ges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_gts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_les.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_lts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_nes.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_rem.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_sub.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_logic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_movhi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_muli.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mulu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeq.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeqi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfles.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfne.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfnei.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sub.c (100%)
 rename docs/system/{openrisc => or1k}/cpu-features.rst (100%)
 rename docs/system/{openrisc => or1k}/emulation.rst (100%)
 rename docs/system/{openrisc => or1k}/or1k-sim.rst (100%)
 rename docs/system/{openrisc => or1k}/virt.rst (100%)
 rename docs/system/{target-openrisc.rst => target-or1k.rst} (96%)
 rename hw/{openrisc => or1k}/Kconfig (89%)
 rename hw/{openrisc => or1k}/meson.build (60%)
 delete mode 100644 linux-user/openrisc/meson.build
 create mode 100644 linux-user/or1k/meson.build
 rename linux-user/{openrisc => or1k}/syscall.tbl (100%)
 rename linux-user/{openrisc => or1k}/syscallhdr.sh (100%)
 rename target/{openrisc => or1k}/Kconfig (76%)
 rename target/{openrisc => or1k}/insns.decode (100%)
 rename target/{openrisc => or1k}/meson.build (79%)
 rename tests/tcg/{openrisc => or1k}/Makefile (100%)

-- 
2.43.0


