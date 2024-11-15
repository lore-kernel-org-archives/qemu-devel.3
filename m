Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16394D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8A-0001n1-3W; Fri, 15 Nov 2024 10:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy86-0001md-9d
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy82-00043J-Ck
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314b316495so6761275e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684055; x=1732288855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2oVIoGN5+KTiuTHFLsyY+4yDft6p5jyzLihrKyZIft8=;
 b=tLeeiGU6uhNpyupeJOrIifXpX/nl4bCp9ukjJk0UDuoNhGLRUb0LWNbHg3ErmUb2J7
 2ivVQC97BmEdziLjC1Hj3ILFglzbZ1JVkFNMIzvjnUzj8CP91q0OHqVl/3wAtmoK0a9l
 D6uUZNLpkyDYsPdFYablv92kTu4Xu/PNYw84/gKJCHHTKcKPGH28GlwTVr9uqx16D103
 ri2rvvlagJuttvPVGNq5EYfTe+kEXas/kFMp8ZQ2+f/pu9Crv+ZtYMxT6Gm5rWDoUR4Y
 KaF9FsRiVNo9gAWGnpTxupFCRGWejMpKWye+V/0JuDUvN+FLH2FQSLqGxi8/00oBHPAg
 WM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684055; x=1732288855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2oVIoGN5+KTiuTHFLsyY+4yDft6p5jyzLihrKyZIft8=;
 b=hQAJ+NdzD2hkZSbYlmezD8G/G4+T6fsN/B/RjcKmD6qw8A6LWGIc5u9aCGHTH+oHiT
 QhiiGQ/JfRCgVrfedu0Zqu+aLcLRtz4Hx4tHkaDD4kAnvGW77I2F0C+YqjkyKvYduZO7
 hujQiZhjQS1210dOFRt2zqTUT6x+/i3GTvfMHqLMkjsh4fdWxK3u0GTYd1BgDi8sPTX9
 FSibPB0Y0hmwLWcY/nZZe5n0UWH74sEe3V79h/ctvitgx/5iRhThL466SrLszhlzWK40
 RNIYG8DdYiaYKfZeX+9k+hk5Qo76ooktyPGDGHMwWiIiaQ17QJZVi7KkzdTWFw+QlHPj
 +wmw==
X-Gm-Message-State: AOJu0YwhmYFBCgofjHJe5/ietKlJp/3nOMeASBrtpwJR0+3cWOazRRwF
 Q3dkviP+R+XfCO1YWpgbM9yp3R9kkdUDEArnFJl600GmEeo51X2mo1FRUqkwOR9AxBc4Ht1hIFf
 +
X-Google-Smtp-Source: AGHT+IGZ+D0kW+eVIuhsTpoVZxTfbxtiFRj4jDVOjwh9wZcIaOH2iCbuqeg3ffOOW5+k9VW0/3U+SA==
X-Received: by 2002:a05:600c:4693:b0:431:55af:a22f with SMTP id
 5b1f17b1804b1-432df72c9e7mr26704305e9.13.1731684055592; 
 Fri, 15 Nov 2024 07:20:55 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab7878esm57379325e9.14.2024.11.15.07.20.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:20:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/10] accel/tcg: API prototype cleanups
Date: Fri, 15 Nov 2024 16:20:43 +0100
Message-ID: <20241115152053.66442-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Preparatory cleanup patches extracted to bigger series which
rename TCG frontend functions to avoid name clash when linking
multiple target into the same binary.

Worth to remove few QOM cast boilerplate, per diff-stat:

 64 files changed, 230 insertions(+), 355 deletions(-)
                   ---                ^^^

Philippe Mathieu-Daudé (10):
  target/mips: Drop left-over comment about Jazz machine
  target/loongarch: Declare loongarch_cpu_dump_state() locally
  target/sparc: Move sparc_restore_state_to_opc() to cpu.c
  accel/tcg: Ensure frontends define restore_state_to_opc handler
  accel/tcg: Move cpu_unwind_state_data() declaration
  accel/tcg: Remove cpu_unwind_state_data() unused CPUState argument
  accel/tcg: Reduce log_pc() declaration scope
  hw/core/cpu: Pass CPUArchState to set/get_pc() handlers
  hw/core/cpu: Pass CPUArchState to restore_state_to_opc() handler
  hw/core/cpu: Pass CPUArchState to cpu_dump_state() handler

 accel/tcg/internal-target.h    | 10 ---------
 include/exec/cpu-common.h      | 13 ------------
 include/exec/translate-all.h   | 11 ++++++++++
 include/hw/core/cpu.h          |  8 +++----
 include/hw/core/tcg-cpu-ops.h  |  2 +-
 target/alpha/cpu.h             |  2 +-
 target/arm/internals.h         |  2 +-
 target/hppa/cpu.h              |  2 +-
 target/i386/cpu.h              |  2 +-
 target/loongarch/internals.h   |  2 --
 target/m68k/cpu.h              |  2 +-
 target/microblaze/cpu.h        |  2 +-
 target/mips/tcg/tcg-internal.h |  2 +-
 target/openrisc/cpu.h          |  2 +-
 target/ppc/cpu.h               |  2 +-
 target/rx/cpu.h                |  2 +-
 target/s390x/s390x-internal.h  |  4 ++--
 target/sh4/cpu.h               |  2 +-
 target/sparc/cpu.h             | 11 +++++++---
 target/tricore/cpu.h           |  2 +-
 target/xtensa/cpu.h            |  2 +-
 accel/tcg/cpu-exec.c           | 25 +++++++++++++++++-----
 accel/tcg/translate-all.c      |  6 +++---
 hw/core/cpu-common.c           |  2 +-
 hw/core/generic-loader.c       |  2 +-
 target/alpha/cpu.c             | 10 +++------
 target/alpha/helper.c          |  3 +--
 target/arm/cpu.c               | 28 ++++++++----------------
 target/avr/cpu.c               | 19 ++++++-----------
 target/hexagon/cpu.c           | 21 +++++++-----------
 target/hppa/cpu.c              | 18 ++++++----------
 target/hppa/helper.c           |  3 +--
 target/hppa/int_helper.c       |  2 +-
 target/hppa/sys_helper.c       |  6 ++----
 target/i386/cpu-dump.c         |  5 ++---
 target/i386/cpu.c              | 12 ++++-------
 target/i386/helper.c           |  3 ++-
 target/i386/tcg/tcg-cpu.c      |  4 +---
 target/loongarch/cpu.c         | 15 ++++++-------
 target/m68k/cpu.c              | 19 ++++++-----------
 target/m68k/translate.c        |  3 +--
 target/microblaze/cpu.c        | 22 +++++++------------
 target/microblaze/translate.c  |  3 +--
 target/mips/cpu.c              | 17 +++++----------
 target/mips/tcg/translate.c    |  4 +---
 target/openrisc/cpu.c          | 24 ++++++++-------------
 target/openrisc/sys_helper.c   |  7 +++---
 target/openrisc/translate.c    |  3 +--
 target/ppc/cpu_init.c          | 23 +++++++-------------
 target/riscv/cpu.c             | 16 ++++----------
 target/riscv/tcg/tcg-cpu.c     |  4 +---
 target/rx/cpu.c                | 18 ++++++----------
 target/rx/translate.c          |  3 +--
 target/s390x/cpu-dump.c        |  3 +--
 target/s390x/cpu.c             | 12 ++++-------
 target/s390x/tcg/translate.c   |  3 +--
 target/sh4/cpu.c               | 20 ++++++-----------
 target/sh4/translate.c         |  3 +--
 target/sparc/cpu.c             | 39 ++++++++++++++++++++++++----------
 target/sparc/translate.c       | 32 ----------------------------
 target/tricore/cpu.c           | 12 +++++------
 target/tricore/translate.c     |  3 +--
 target/xtensa/cpu.c            | 18 ++++++----------
 target/xtensa/translate.c      |  3 +--
 64 files changed, 230 insertions(+), 355 deletions(-)

-- 
2.45.2


