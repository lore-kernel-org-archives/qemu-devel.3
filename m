Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65ECCEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGKz-0005I9-Lj; Tue, 06 Jan 2026 18:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGKj-00057d-Sw
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:26 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGKf-0000xl-B3
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:23 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so10450205e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767741553; x=1768346353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+9w7thfu5c3pBXFtSWKIvBi4Bj0QrdvceYXlmaBg92w=;
 b=RRQM22XPTcjDc3mvwJ6YMxL056wPsCo/nmUw+i3LFy2CrwZPKZIH18Wv4vGWpEFsZV
 XEhfcPrPO8fRljIT5pH3fYGzJGFO/FrrVFV6eD8AfI4VXQhW2em9qZM9PYBV8U6SlQkA
 hjjn6/xTgFgpv4C3KqPnsqesFqAFAu3vrmq+4z9GmIHWsZyjOB+AwSTq+iP73V42m602
 SAXv/2DcMZowhdxnyYRUAkGgzIBk0Fuqa8kabRN8WphQwUoRcrwfoFV0q79Zy8fOZx2w
 cAxc0IDHvVfiAkfvueBYSx/inmUIV5ktkOYcTWxamcONEd9yg1IcTG+AFuCWjvztwl/S
 Xoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741553; x=1768346353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9w7thfu5c3pBXFtSWKIvBi4Bj0QrdvceYXlmaBg92w=;
 b=GI+eEv9ioElcfIrIG4EUgTllW8oiM8lO1kX9SnkUfhtAB5oFcc91t88nXmzdc6nREx
 f1RrQ6x4rXv22VL2dbXpPYxFfk/aDRSeowG2V6LC1TIhvxs7/ejFaWYHIIceIVubuHs4
 7VRm7C/qrdnP7B6sAoAPYSLWp8rcBm65Brp9PrZmJvKGn4pdgYIFpyoR3Oq+iP9E2o4e
 8KNvigrxcNZm0ICuHgQXYVTBsFGn24kUMgQHEdVPVCCglk3Tu5KV+6d7CCD4at83AG87
 Vy29mKbxerKcK1kdmaZa7R606BhszE2Tsk6OgXkkbJtOM8LWcJ22bKX8ZCh8dYPgU1e+
 ns4w==
X-Gm-Message-State: AOJu0YwGna5g3CEnKuleXXkLealfs5qPO2dHsSCognO0/cPtRrX0mj/D
 hKwze+YkBEYD5E2/Y/t5nCrUy5uFT+2gN9HBggr0H+nONZREzflHNgcaLlVZcj3sw+V/Qn9TSK2
 huHwLFtDlpw==
X-Gm-Gg: AY/fxX4AFYFnz/e4SJ8cyjYAWPngUGm/wlAy0CpGYbr436RolR9+O1JZ7WA9990hLpz
 COXOgoU5+xGOxsoRuL4XzwwYwxTo3LiQH8UIrFP+dK1zgY47lyejgo62PwFPt+1XF7mcOQzW+5C
 snL9f/Sh+9BoA2f5brCObomMDsHTCWcgj/HE219Lc2/fKI090ZTEDYjNGPhO++vPzK0aL3OFoaZ
 GKzacQDikQzw25l5mLcGDo207ILmQ6+luNfIo8IdbnU/UXNDmX0qrqrr+Fy8jWTHLF84Xe3OzUk
 luGro46HVk6sPL0XkDVM+Th3W2kb1n0KYAO/eB0Mlmn47MLodL5V2HPoLXTQIPjuVD+h8k6dhzT
 IaqTuWMQOz4zGf2xBgatr2z5x4DAJBj5vTKn7jDDkIo21lyfmqxIECCcf8Dc8b7tLVpMHpNSBwo
 mEKn7Nz+vqrIM5BHEtqbwENqB1HHSJEg==
X-Google-Smtp-Source: AGHT+IGKemZnXUO7w171dckeaPrAX6sBe/uM+eCTVeuDrhKx3ZsU5uJ4Apmrg3wNyTOvH/FWj6k3RQ==
X-Received: by 2002:a05:600c:1385:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-47d84b0a227mr5217845e9.4.1767741553173; 
 Tue, 06 Jan 2026 15:19:13 -0800 (PST)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb4c451sm30263405e9.5.2026.01.06.15.19.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:19:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] accel/tcg: Restrict WatchPoint API to TCG
Date: Wed,  7 Jan 2026 00:19:02 +0100
Message-ID: <20260106231908.16756-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Hi,

This series is related to single binary, where we want
to build compilation units once. Headers using the
'CONFIG_USER_ONLY' definition are "poisoned", except if
we duplicate the meson source set, in that case we define
COMPILING_SYSTEM_VS_USER and CONFIG_USER_ONLY is no more
poisoned.

Looking at the watchpoint API, CONFIG_USER_ONLY is only
used to avoid stubs, so it can easily be reworked to avoid
the need of duplicated source set.

Since here, we also restrict the API to TCG, and unify it
in a single header: "accel/tcg/watchpoint.h", since it is
distinct to the BreakPoint API which can be used by hardware
accelerators.

Philippe Mathieu-Daudé (5):
  target/i386: Restrict WatchPoint API to TCG
  target/ppc: Restrict WatchPoint API to TCG
  target/s390x: Restrict WatchPoint API to TCG
  accel/tcg: Un-inline WatchPoint API user-emulation stubs
  accel/tcg: Unify watchpoint API

 MAINTAINERS                         |   1 -
 include/accel/tcg/cpu-ops.h         |  45 +-----------
 include/accel/tcg/watchpoint.h      |  57 ++++++++++++++++
 include/exec/breakpoint.h           |  10 ---
 include/exec/watchpoint.h           |  41 -----------
 include/hw/core/cpu.h               |   3 +-
 target/arm/internals.h              |   2 +-
 target/ppc/internal.h               |   2 +-
 target/riscv/debug.h                |   2 +-
 target/s390x/s390x-internal.h       |   1 -
 target/s390x/tcg/tcg_s390x.h        |   4 ++
 accel/tcg/cputlb.c                  |   1 +
 accel/tcg/tcg-accel-ops.c           |   2 +-
 accel/tcg/user-exec-stub.c          |  32 +++++++++
 accel/tcg/watchpoint.c              |  83 +++++++++++++++++++++-
 system/watchpoint.c                 | 102 ----------------------------
 target/arm/debug_helper.c           |   2 +-
 target/arm/tcg/mte_helper.c         |   2 +-
 target/arm/tcg/sve_helper.c         |   2 +-
 target/i386/cpu.c                   |   6 +-
 target/i386/machine.c               |   2 +-
 target/i386/tcg/system/bpt_helper.c |   2 +-
 target/ppc/cpu.c                    |  83 +---------------------
 target/ppc/cpu_init.c               |   2 +-
 target/ppc/watchpoint.c             |  93 +++++++++++++++++++++++++
 target/riscv/cpu_helper.c           |   2 +-
 target/riscv/debug.c                |   2 +-
 target/s390x/cpu.c                  |  30 ++++----
 target/s390x/helper.c               |  40 +----------
 target/s390x/tcg/debug.c            |  53 +++++++++++++++
 target/s390x/tcg/excp_helper.c      |   2 +-
 target/s390x/tcg/mem_helper.c       |   1 +
 target/xtensa/dbg_helper.c          |   2 +-
 system/meson.build                  |   1 -
 target/ppc/meson.build              |   1 +
 target/s390x/tcg/meson.build        |   3 +
 36 files changed, 366 insertions(+), 353 deletions(-)
 create mode 100644 include/accel/tcg/watchpoint.h
 delete mode 100644 include/exec/watchpoint.h
 delete mode 100644 system/watchpoint.c
 create mode 100644 target/ppc/watchpoint.c
 create mode 100644 target/s390x/tcg/debug.c

-- 
2.52.0


