Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679D8C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 22:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7jTQ-0006g6-30; Thu, 16 May 2024 18:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s7jTH-0006ZR-TS
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:21:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s7jTF-0003BL-Ba
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:21:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4f2b1c997so767293b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715898062; x=1716502862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+t61NbUjxKfzRZ5sJjz14N/rj3jqOYZUILd+pfu8YsI=;
 b=YNCLekCp7LCdQiUlAp/lGfc8fsv6EgfDFGmc0hfwmH3bGTjz1NY5MgL5ZT4jyL3olf
 9+TcYAYgx3SAa6v8PBKslcjBs3yF0BgQOJBrxqPBx/jgb6M+EEEdrdeoRnccUtKAuo1+
 Ys/naJRKAIAy5aLxnvH/0nILXIqGJpqRC3RlSgBI8Y6SIc1jGUkZ51UknWVv8xFU6ISu
 mUkJPO3OFaC8CZIDgnW7pZZ8llrgJHAP8dMLUkuXNFDjfkamrgO4l7uMFs7FKcZHHUzr
 Q9jTSjuDbgdqTlIeD+FYrrY+MTiPjBZkZGBUpaq99PRSS04VTqrdH24nQTAWG/zXyZgq
 v2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715898062; x=1716502862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+t61NbUjxKfzRZ5sJjz14N/rj3jqOYZUILd+pfu8YsI=;
 b=gd2aWO46dPcw3aItg6Ax+Jj3AcGFokvwzI8YGQO6mryyio4pFj9isdr0UUJl0gKDJG
 l3Q2eci9VJVTsFeLqHN4KpkwVo1D/3wdbjYmrBI6D1C9biTMIaJ/9rRoZc7JkTwbe/7w
 rd8xw/cMwOFGzsHyyyL2ObGE9SZswGkF5JeIXiILK5XRaGC9tzZU/4hEC/jzBeKihs4+
 8vVXBHFV4xtFcE4qVumvf4m5ROalEo8emD27sjB4p91B9VEu2MmUxX4xdxJ3YH1L9RCl
 syZKPmleBLYA/Ev/irpfwEBYXa4fZk0RikuBu38S0lnXrYNUE5ap26gDnFLQQhnzOX6V
 Z5VA==
X-Gm-Message-State: AOJu0Yx2Qm+bIpIxQfAppV1qjK1MnOFDOV89mOFsxoPX0nFsnvDeCF15
 bLTyI0gUnWcjfQDMdu0WKeNmWy7cHD/1syLuTDKn9mDfsXlvI3Pm0PjiNA/xiLuBxTsQTLHbcrw
 q82w=
X-Google-Smtp-Source: AGHT+IG06uyTk5lYQkaz/WNIBK2Am4G9SQAJqNmg6i4dW2htQkadOsvxS0s9YyuV8SkoJSFxetUI0A==
X-Received: by 2002:a05:6a21:32a7:b0:1a7:186:f976 with SMTP id
 adf61e73a8af0-1afde1b7285mr22559923637.40.1715898062088; 
 Thu, 16 May 2024 15:21:02 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66476sm13589219b3a.28.2024.05.16.15.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 15:21:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] Implement icount=auto using TCG Plugins
Date: Thu, 16 May 2024 15:20:42 -0700
Message-Id: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

The goal here is to be able to scale temporally execution of qemu-user/system,
using a given number of instructions per second.

We define a virtual clock, that can be late or in advance compared to real time.
When we are in advance, we slow execution (by sleeping) until catching real
time.

Finally, we should be able to cleanup icount=auto mode completely, and keep
icount usage for determistic purposes only.

It is built upon new TCG Plugins inline ops (store + conditional callbacks), now
merged on master.

Example in user-mode:

- Retrieve number of instructions to execute /bin/true
$ ./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true
cpu 0 insns: 120546
total insns: 120546
- Slow execution to match 5 seconds
$ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips,ips=$((120546/5)) /bin/true
real    0m4.985s

Alex Bennée (4):
  sysemu: add set_virtual_time to accel ops
  qtest: use cpu interface in qtest_clock_warp
  sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
  plugins: add time control API

Pierrick Bouvier (1):
  contrib/plugins: add ips plugin example for cost modeling

 include/qemu/qemu-plugin.h                    |  23 ++
 include/qemu/timer.h                          |  15 ++
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   1 +
 accel/qtest/qtest.c                           |   1 +
 contrib/plugins/ips.c                         | 239 ++++++++++++++++++
 plugins/api.c                                 |  31 +++
 ...t-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 system/cpus.c                                 |  11 +
 system/qtest.c                                |  27 +-
 util/qemu-timer.c                             |  26 ++
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   6 +-
 15 files changed, 383 insertions(+), 26 deletions(-)
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


