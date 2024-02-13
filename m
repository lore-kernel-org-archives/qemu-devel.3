Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BFCC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHK-0000wz-1c; Tue, 13 Feb 2024 04:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHI-0000wZ-FU
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:36 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHG-0000Cz-Jm
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:36 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d10ad20955so3688701fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817231; x=1708422031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ExynNq4o+XvjZwIaKCFSMiMrKDyKce0QXhW5+pGWl3w=;
 b=faI0IbUqiKdP/OiQOWLoYm4uk1i3/StoTg0obFaV9/2MK6al+CGMDreFi1WHQBBIDr
 PEqG5Lx7hY+DlgNuXnHBB66JwOruSVhe7wyi30JAECvwBH4XxYJfFzXYa58+AyoQovcK
 JEbRMxI2aOokYn+NT61hFooZVp+1HL43b3aqDGqCqNxJsmEo/WPkbzWXtqB57hl1wH8f
 iKkY3lFrhmwd8hDdQUAMAbqJw4hQZnuLAOVYKv++2ggqk80cLk8uiStgyNKS+5LBteZE
 UxjQussJQayuOQfvHmdXt4S+c/JwZ/IDedR0RN4iKJuiM3nWP9dxfVTdSAWP3aGZxtZ8
 /i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817231; x=1708422031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExynNq4o+XvjZwIaKCFSMiMrKDyKce0QXhW5+pGWl3w=;
 b=vp6uRVyeGMLDIIZ3q21hG0ch07cPJPd105nSK8xSziFu9qWAT7ItZ4JL8OHbNZpIlN
 wMbz2qIdppeo+WGlM0sOjdPdVLrzYVQlBN7By8a/ZZxqlpDM15LufljmfM0kPXKRgPHM
 VJEVWSCh55uTOtvSv995i+p1FxCT3NEV92HbMX7zxEpJQYQyKZhN+HAm1jbqhSZ89/uQ
 7oGGA7mtyjZnXr9FETFhgKi/6deu/auZPS82pkfz/+KiIBtB476/VJqaVG66LQyNFRRq
 6qMFwnSHROW7nyLmhLYy/2S3qf1vAwDuA12vwnH5dBlfQmifsfqPxwlJjr0Xv1xHX9kX
 nEdg==
X-Gm-Message-State: AOJu0Yy5lBPL9t6fvzFzi5A9FNunY11PGOkH8t1aZCfw3lDN9POuES0P
 r5ZY7egVhQPdoz9212YYbrkXLQl4vZpzGuO1yawqdkt6hLO4qJNfjHgZo3hFaLxV/CQ3o+O+sXY
 y
X-Google-Smtp-Source: AGHT+IHwp3wCbCja/Y/pO4+oXx326UYthbEKVfBeaQHWXyiXe+UvekxOYTNv1gOBT1g5YGwRd05/1Q==
X-Received: by 2002:a2e:8216:0:b0:2d0:cce1:f0a8 with SMTP id
 w22-20020a2e8216000000b002d0cce1f0a8mr5804845ljg.1.1707817231406; 
 Tue, 13 Feb 2024 01:40:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpzDmiGjChTqQTx8KFCuTfe4t5W2Xkao9+h8DxvsVKFNSZNozPALMf4sy1LoiZa2kmHxVCJQKIH8kUI8Roo1nMEtMIKjQkio7AbDcI45VBEROs15lvuMBYkGrsoQeQDF2Kfxr6ls1xE6JEmR6cHYYD8LCoYuH0z/pfmGjd5LJ9BU+Ak+F3iwh2iZII0BEzmxVaJh2Saah4DAD8fkgBOn3PT/6gK5UuutF7LangJq+LNrubhKbkJh+a1bZtja7eDqfpZihPf1BACw325E+u1Xan1v6KeZ9rOSOFXyj2MwUDyvz/+qAtBdWmEVbsni1xCCTzmjKBGoAPNGbYtVtpXIH09xO1Q==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 00/18] TCG Plugin inline operation enhancement
Date: Tue, 13 Feb 2024 13:39:50 +0400
Message-ID: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series adds a new thread-safe API to declare inline operation
inside plugins. As well, it removes the existing non thread-safe API,
and migrates all existing plugins to use it.

Tested on Linux (user, system) for i386, x86_64 and aarch64.

To give some context, this a long term series of work around plugins,
with the goal to be able to do basic operations in a more performant and
accurate way. This will mean to add more inline operations and
conditional callbacks.

One final target of this work is to implement a plugin that implements
the icount=auto feature, and allow QEMU to run at a given "frequency"
based on number of instructions executed, without QEMU needing to keep
track of this.

Another final target is to be able to detect control flow changes in an
efficient and elegant way, by combining inline operation and conditional
callbacks.

v2
--

Implement scoreboard API (cpu local storage), so plugins don't have to deal
with how many cpus are used.

Since plugins have been modified again, I didn't transfer any reviewed-by on
those commits.

v3
--

- introduce qemu_plugin_num_vcpus (how many cpus were initialized)
- fix order of plugin init/idle/resume callbacks
- scoreboard:
  - renamed qemu_plugin_u64_t -> qemu_plugin_u64
  - some functions rename for scoreboard api
  - qemu_plugin_u64 has only value based function (vs address before)
- various cleanup thanks to review of previous series

v4
--

- split scoreboard/qemu_plugin_u64 patches
- use list instead of hash table to keep track of scoreboards
- remove immediate in tcg code gen

Based-on: 20240122145610.413836-1-alex.bennee@linaro.org

 Version number: 4
 Branches:
          base:  plugin_registers_v3_20240122145610.413836-1-alex.bennee@linaro.org
          topic: plugin_inline_per_vcpu

Pierrick Bouvier (18):
  plugins: remove previous n_vcpus functions from API
  plugins: add qemu_plugin_num_vcpus function
  plugins: fix order of init/idle/resume callback
  cpu: call plugin init hook asynchronously
  plugins: scoreboard API
  plugins: define qemu_plugin_u64
  docs/devel: plugins can trigger a tb flush
  plugins: implement inline operation relative to cpu_index
  plugins: add inline operation per vcpu
  tests/plugin: add test plugin for inline operations
  tests/plugin/mem: migrate to new per_vcpu API
  tests/plugin/insn: migrate to new per_vcpu API
  tests/plugin/bb: migrate to new per_vcpu API
  contrib/plugins/hotblocks: migrate to new per_vcpu API
  contrib/plugins/howvec: migrate to new per_vcpu API
  plugins: remove non per_vcpu inline operation from API
  plugins: cleanup codepath for previous inline operation
  MAINTAINERS: Add myself as reviewer for TCG Plugins

 MAINTAINERS                     |   1 +
 docs/devel/multi-thread-tcg.rst |   1 +
 include/qemu/plugin.h           |   7 ++
 include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++------
 plugins/plugin.h                |  23 ++--
 accel/tcg/plugin-gen.c          |  69 +++++++++---
 contrib/plugins/cache.c         |   2 +-
 contrib/plugins/hotblocks.c     |  50 +++++----
 contrib/plugins/howvec.c        |  53 ++++++---
 hw/core/cpu-common.c            |   9 +-
 plugins/api.c                   | 121 +++++++++++++--------
 plugins/core.c                  |  94 ++++++++++++++--
 tests/plugin/bb.c               |  63 +++++------
 tests/plugin/inline.c           | 186 ++++++++++++++++++++++++++++++++
 tests/plugin/insn.c             | 106 +++++++++---------
 tests/plugin/mem.c              |  40 ++++---
 plugins/qemu-plugins.symbols    |  16 ++-
 tests/plugin/meson.build        |   2 +-
 18 files changed, 737 insertions(+), 257 deletions(-)
 create mode 100644 tests/plugin/inline.c

-- 
2.43.0


