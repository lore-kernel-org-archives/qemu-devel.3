Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D45D10987A3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cP1-00006W-64; Fri, 20 Mar 2026 12:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOa-0008VS-LM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOW-0008Rs-S4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso9308475e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022894; x=1774627694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/TwYNwDVqp2JsJx/yake4tl42zrVAFy5AIYCi5c+cug=;
 b=pmW8dAFJRGW9mtUp3yrbLTdghZ7/yu735NxukI6USc1o7WC5j8FYpEAArJ++58cIvh
 BOXhIqltJz/7Gym/ZRcA/vcaUg4IdjdWWy7eQNblp7Q4sZnDxyXcoD6I06/oErV977Hq
 cU4edOTDMMB+sZp7Sqdi7eTwFxopddB+WlXbTUVpgQKEthaP+Z+LAganA4mq1V/uhdYF
 E9vG/5f6r0OIegcHPE1ONDy50JlSfnEFKT6OhddGDo1ShnK8dklcE/4z+JsPqR9W3MZK
 JkblLRC+PzX6k3YQ4OLQUo9b8I0S/h+YHGL3c7o8pmFAdVhjVH3pVX5cMzsgIpxZz7o2
 Xb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022894; x=1774627694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TwYNwDVqp2JsJx/yake4tl42zrVAFy5AIYCi5c+cug=;
 b=UTNvTHW2ei61x2DkLZG7lbqWtsUX6eF726prdB6SMo1u9WgIjL9tN0B+By0hjDgiap
 SnxEy6/JFb3Cin081zGotpYIB1iG/sViuRZ1XhA8EekdUs90jP+dqc3/exPhpwN6IH/f
 +GpWEIGn2xs/DypcTRUAZcqc6fBzSKjRn7+Ak0AY+6Hgd7aKFL7zLN0kD+Zg9vH2Tyhy
 nJnz/++M/U1vgprlupz6w2CWJBR1/1Qn3nUkxbls0hdQnDiUZKOSZQfoqJj0QU4aVfzy
 bIt0BsgAbQmIoXp4p1zsA6E+pYFAj3hfbiWA8Nk1Zztl+M0wEMgZ1gf9tNtqm9Gc7zX1
 kyCg==
X-Gm-Message-State: AOJu0YzwhDSjG9kaajEbNWDXtCkxsjODuPtyKONy5mbhtj1OwfJJ7tvQ
 JLY8+tbHK/6/9rDsoTaOdV3VvJTHcqGysxwY6VuHyEi8fYNWacPNSEiBMiZPh2Jd4TVfqA7JNxW
 a+sYw+rU=
X-Gm-Gg: ATEYQzxQzNWojcUi0RWkKjpF1LRp4fwqNLIqFABBAnCaH8kRgexIQVs7+wlqadua5Su
 8H44OHTZwXNL774GbCHlFsRYYVvEMKe+s6BTAPaYM0eoPMrwCWpdXutfjcwByjtWnAqJEg+MXq+
 WJXwXN0Pi0CXBl6Jsb0ZmpdiJ3QsZQWsyGTdN6A+Fm3Qls5w6OexMOkeUr/4wJBo9fXxCRsFo/L
 MxEIwDpA/h+tfYPurq6cgnvQSzkcKepCNKBNCXqEsA3l+xf9SaD2RqD/v5oY0lGITrsvMeddyLS
 cuAasS4WhuIIHkhctxI8vaJvYKMKa4bFwvhMWfmJ3rFGfPEBzdwHOjZHoijlAFTHlRexXAHNVWM
 FqUyEEaYRxWLw9/ix1UH8+fvJ/Lrn3NI0Bb97k10eAOblkkm3lUvrhdElFJv+rG1/ZZKeUOip7J
 vMbeu/ogdkTCY2jldYdmqAicMMURXJ744v+H2VkDRymOUmrSWTQf3Iqmmyw1yelfLdPW6lcCNB
X-Received: by 2002:a05:600c:828d:b0:485:481c:e7bb with SMTP id
 5b1f17b1804b1-486ff027c3emr55098305e9.20.1774022894035; 
 Fri, 20 Mar 2026 09:08:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48700512087sm23720855e9.4.2026.03.20.09.08.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 00/10] monitor: Remove need of per-target handlers
Date: Fri, 20 Mar 2026 17:08:00 +0100
Message-ID: <20260320160811.28611-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Convert target_monitor_defs() and target_monitor_defs()
to CPUClass fields, adapting the 4 targets using these
legacy code.

Philippe Mathieu-Daudé (10):
  monitor: Extract completion declarations to 'monitor/hmp-completion.h'
  monitor: Forward-declare the MonitorDef type
  cpus: Introduce CPUClass::legacy_monitor_defs hook
  target/i386: Replace legacy target_monitor_defs -> legacy_monitor_defs
  target/m68k: Replace legacy target_monitor_defs -> legacy_monitor_defs
  target/sparc: Replace legacy target_monitor_defs ->
    legacy_monitor_defs
  monitor: Remove target_monitor_defs()
  cpus: Introduce CPUClass::legacy_monitor_get_register() hook
  target/riscv: Register target_get_monitor_def in CPUClass
  monitor: Remove target_get_monitor_def()

 MAINTAINERS                      |  1 +
 include/hw/core/cpu.h            |  8 +++++++
 include/monitor/hmp-completion.h | 40 ++++++++++++++++++++++++++++++++
 include/monitor/hmp.h            | 28 ++--------------------
 include/qemu/typedefs.h          |  1 +
 target/i386/cpu.h                |  2 ++
 target/m68k/cpu.h                |  2 ++
 target/riscv/internals.h         |  3 +++
 target/sparc/cpu.h               |  2 ++
 chardev/char-hmp-cmds.c          |  1 +
 migration/migration-hmp-cmds.c   |  1 +
 monitor/hmp-target.c             |  1 +
 monitor/hmp.c                    |  8 +++++--
 net/net-hmp-cmds.c               |  1 +
 qom/qom-hmp-cmds.c               |  1 +
 stubs/target-get-monitor-def.c   | 29 -----------------------
 stubs/target-monitor-defs.c      |  7 ------
 system/qdev-monitor.c            |  1 +
 system/runstate-hmp-cmds.c       |  1 +
 target/i386/cpu.c                |  1 +
 target/i386/monitor.c            |  7 ++----
 target/m68k/cpu.c                |  1 +
 target/m68k/monitor.c            |  5 +---
 target/riscv/cpu.c               |  1 +
 target/riscv/monitor.c           |  4 +++-
 target/sparc/cpu.c               |  3 +++
 target/sparc/monitor.c           |  9 +++----
 trace/trace-hmp-cmds.c           |  1 +
 ui/ui-hmp-cmds.c                 |  1 +
 stubs/meson.build                |  2 --
 30 files changed, 91 insertions(+), 82 deletions(-)
 create mode 100644 include/monitor/hmp-completion.h
 delete mode 100644 stubs/target-get-monitor-def.c
 delete mode 100644 stubs/target-monitor-defs.c

-- 
2.53.0


