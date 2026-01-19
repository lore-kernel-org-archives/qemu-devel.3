Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEDFCCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn3M-00069Y-Cl; Mon, 19 Jan 2026 06:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3F-0005ty-Uz
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:07 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3D-0006Uq-80
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:05 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso2253092f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820641; x=1769425441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1oLWab/Xaud4IgoL2Fl+eccutCbR+6dlUmvzxaTjay0=;
 b=Z9pqDHdWp1YtBIdqM6G53JsddxJe8LvcK5upQlimjqi3eIO69k9ITonollWdgRDX0C
 PMyc/9chFruJMfN2SjiUeQ1hpdn1d4UyDaTnVO9Ja4EyG16i+fWDn9V+ul9buNgIFLVa
 qS02bDpZ+q+OkJI16XJsKV5hkQ7P2A53U0ERUPGUkqx3bXqKRXiFIeErOH1VvbF+MfKI
 KuIK1uQ/B3uNfTH4RqguhR+MyK7PdFOVgRgyYPWozJywZTBcNK+yHNnJspGW+RFIJ1FE
 eet8mtUC55IhWM43wvo4r1SS/6e6VehFn/sHaXOCjPzG+mD0c3k1klIsSIKPAYPcArX2
 SFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820641; x=1769425441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oLWab/Xaud4IgoL2Fl+eccutCbR+6dlUmvzxaTjay0=;
 b=PEEWVtxskkBGagiHZu0H8rJNpMDfqw0gTSQcn2I2zyQfU2uYWl/6qS8Bak5VsPVfty
 Bod6AZx06R9BgTZbKn/hrZsiDKXEnH/mMEOmJdljuIwCowqgUy6vKF97vm1DvtYaMeWY
 XobihVdOM6v80W9ZWnBP98DCd9/71Hr0QXmujVkyNU2zha8rmsnDq1QziEIKl2Qvcv/Q
 SEY4Z6cldBqklH4mz+PHKBISm9BfbMwor2Da1dbMNDRq8LRMo9FmcDMWzXyppIaQFuTJ
 MXvl/fneSby2M557h8L22U1QQEX3bjOjBhqXpeRlyINFLtTZv4noCPtjgSCbnVioAsAE
 ZVYg==
X-Gm-Message-State: AOJu0YzxoRoPACoiCzxsr5oOi0bsbiE3imbrXAoKsIa6Ltex7n7JScqd
 mK4dPg6HQiSkmcEsW5e1DuIoMPeqIPvbEkWxCAhIPtsjRyaWCXYhUoNyXfypVbvhUcz0kns2S/V
 HKbDWfSU=
X-Gm-Gg: AZuq6aKQjks99AGSiUt6IezyCFTrjh3I+67Vz0T6Fo24Ili1CJVqbJFV62J4XVf5zyn
 tBuNfs9pc2OYlHjh2WkSTEm6vxgKSHybj2QwuDAozIZWOQI1kSPP8msuowgYxnHvBJHP0/xCANv
 3T1vlaF3gMplqSri7A5FLA6Wk2+xKC7291M5oRx/6+hsbcvbveTrYI5cqZOorcjs5sNr1jHeu1t
 QPxtCrHlgJjFsDhf5EOtLYXRGl1i+LTVqZgSAY/QtxeBJurf+70qymzZfeWqLbqvunHmRVObxMg
 wz/w767gOM3Ur9DMzQ2E8ZIjuN740dUqMtROvX3Km7VtxHTNjBmt68NHrDg4cvXWZpv4n0VcQN1
 qaoBKFIkRhdrfcdxDZd0f6hEiGz9bBZS4aNnZj/x/eamcTalFTcweco7TML3JdnG/Vcmd9LO24r
 RtY6KnsGvi2RzGx8G/AX8mYIMhJzClYK+Monb5OsoX24A1JvYffVw6V2MlyDFAdsIqqYFHxHI=
X-Received: by 2002:a05:6000:200d:b0:430:fdc8:8bc9 with SMTP id
 ffacd0b85a97d-43569bc17c2mr14631364f8f.40.1768820640923; 
 Mon, 19 Jan 2026 03:04:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6cdsm23521377f8f.31.2026.01.19.03.03.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 0/8] monitor/hmp: Reduce target-specific definitions
Date: Mon, 19 Jan 2026 12:03:50 +0100
Message-ID: <20260119110358.66821-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Missing review: #6

v3: Rename MD_I32 -> MD_U32 (Dave)
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
 target/i386/monitor.c         |   9 ++-
 target/i386/sev-system-stub.c |   2 +-
 target/i386/sev.c             |   1 -
 target/m68k/monitor.c         |  62 +++++++++---------
 target/ppc/ppc-qmp-cmds.c     |  26 ++++----
 target/riscv/monitor.c        |   2 +-
 target/riscv/riscv-qmp-cmds.c |   1 -
 target/sh4/monitor.c          |   1 -
 target/sparc/monitor.c        |  11 ++--
 target/xtensa/monitor.c       |   1 -
 22 files changed, 212 insertions(+), 245 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

-- 
2.52.0


