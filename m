Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D43C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHh2-0004bZ-QF; Tue, 06 Feb 2024 04:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHh1-0004al-0n
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:39 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHgy-0004kH-FO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:38 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-511344235c6so6670342e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211474; x=1707816274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VikB749n6aEnxbtikli/1CKKNBXsXb3S0VGlIjoR0gs=;
 b=hCfGneEkqee0A5Kiie4NPYqkeG/9QfnnaDqAlCkrud2rfYH9zpB15IhrT9n+A/WZG3
 VTm4L6pUIZacLUc1IoYLDgvaPmRjUkNX2uO39gbX0i3Qhuki/ndncCxk9tH0cxCan1II
 jJLQJ9GmL5RE0bOpv0j46W24UaFUVSc85RsssKbayek4KEp/YFGq2lAU/rYTWmOG+ubq
 32mTyS5++e9A9Dn4oVFEGGfvgnnEdo9vb7UOpiLDO1lWMWL8ymJudXCxFK6y13GP00Wh
 iOOyjf6ypb4w1VJk8A5agkWfwM6+JeUIEOe1vtMI5JjorHfanl/1AHXIf7fIeWzzEGHC
 tvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211474; x=1707816274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VikB749n6aEnxbtikli/1CKKNBXsXb3S0VGlIjoR0gs=;
 b=r8f5dTuZPwq6gqVFnJensTWzQvJ7eIFbVsEI5gxN+/3JNdCna1Ti1rrHm6VyCE1Kxo
 Wr8kkiXLCE8SWgzvpTX6FuzMQgXftmJYv+KoIXafraOuof31MN2rzSilmp6cZBMhmIr0
 JhPEplFFf6iz8Me6eXarbP1+oynlaVUnYKPhyK4H8Me6VccmyhcAL+td0z1EnKJrO6nC
 vlKHHbcJ2ZAVP4YoHVxMFU/mrODPEMKXOdfzgKDTfZhsr8Z+NDaByeEIHKN3jT+HWMZ3
 7bi5e8GJfgct6yk3w2uSET30O1QfqBILM/uK76oKhqBuVRAmC1OGuFXV8V6fODqfXxQv
 lfqg==
X-Gm-Message-State: AOJu0YzMhs52BGC9MITGhpYXuXoS4974aa4al3ZpjMAYwzv1YSN0hCik
 dMz2cx9WW2dApY5ACpiezYTzqUgY+CgHzn8ulkOSACeYHSz6gdEZHyiZi3jX4TtdaHG/idgk2i1
 1/ts=
X-Google-Smtp-Source: AGHT+IHB6Q56bz8myU8usuEXca5HBQ5T7bbmVB8GK44vEMgJBAYtI6lMURr1nQOqTTPyY7xK2lXdLQ==
X-Received: by 2002:a05:6512:469:b0:511:486d:454a with SMTP id
 x9-20020a056512046900b00511486d454amr1304159lfd.39.1707211473941; 
 Tue, 06 Feb 2024 01:24:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXff+ccV318jIqJRRGx92+IialFY6ycrI+7vfkiJkcCAeHtS0nNd1uyskMoiBt0X71kPYzp1yINxX0b6HDTrkuz5U0+DiVpJIhKK0LL4iy4v6//g35eOjPqSE2HPMI0Y1NdCgWDE0w7N7eWGgy8iuwCuSB3OJ/9YSQUJRmaEg6JvC7jFoROpjPIZevZynchHjaSvVE49W87Xo/lHgtcuaPXWak5FOn+s3hDHWAMKhsOjZWm6ozhdjv/sWP1For8137yymZbOPQLnSgAXB6vtpgrotH+/L96DUc8WuoW+zYU+px2dQyYalzs9b8E9/4yyoIfWJ9Bn7N4hvNENrTe79UzpR4IzQH2wg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/17] TCG Plugin inline operation enhancement
Date: Tue,  6 Feb 2024 13:24:05 +0400
Message-ID: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x135.google.com
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

Based-on: 20240122145610.413836-1-alex.bennee@linaro.org

 Version number: 3
 Branches:
          base:  plugin_registers_v3_20240122145610.413836-1-alex.bennee@linaro.org
          topic: plugin_inline_per_vcpu

 To: qemu-devel@nongnu.org

 Pierrick Bouvier (17):
       plugins: remove previous n_vcpus functions from API
       plugins: add qemu_plugin_num_vcpus function
       plugins: fix order of init/idle/resume callback
       cpu: call plugin init hook asynchronously
       plugins: scoreboard API
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
  include/qemu/plugin.h           |   6 ++
  include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++++++--------
  plugins/plugin.h                |  24 ++++--
  accel/tcg/plugin-gen.c          |  65 +++++++++++---
  contrib/plugins/cache.c         |   2 +-
  contrib/plugins/hotblocks.c     |  50 ++++++-----
  contrib/plugins/howvec.c        |  53 ++++++++----
  hw/core/cpu-common.c            |   9 +-
  plugins/api.c                   | 121 ++++++++++++++++----------
  plugins/core.c                  | 104 +++++++++++++++++++---
  tests/plugin/bb.c               |  63 ++++++--------
  tests/plugin/inline.c           | 186 ++++++++++++++++++++++++++++++++++++++++
  tests/plugin/insn.c             | 106 +++++++++++------------
  tests/plugin/mem.c              |  40 +++++----
  plugins/qemu-plugins.symbols    |  16 ++--
  tests/plugin/meson.build        |   2 +-
  18 files changed, 745 insertions(+), 255 deletions(-)

Pierrick Bouvier (17):
  plugins: remove previous n_vcpus functions from API
  plugins: add qemu_plugin_num_vcpus function
  plugins: fix order of init/idle/resume callback
  cpu: call plugin init hook asynchronously
  plugins: scoreboard API
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
 include/qemu/plugin.h           |   6 ++
 include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++------
 plugins/plugin.h                |  24 +++--
 accel/tcg/plugin-gen.c          |  65 +++++++++--
 contrib/plugins/cache.c         |   2 +-
 contrib/plugins/hotblocks.c     |  50 +++++----
 contrib/plugins/howvec.c        |  53 ++++++---
 hw/core/cpu-common.c            |   9 +-
 plugins/api.c                   | 121 +++++++++++++--------
 plugins/core.c                  | 104 ++++++++++++++++--
 tests/plugin/bb.c               |  63 +++++------
 tests/plugin/inline.c           | 186 ++++++++++++++++++++++++++++++++
 tests/plugin/insn.c             | 106 +++++++++---------
 tests/plugin/mem.c              |  40 ++++---
 plugins/qemu-plugins.symbols    |  16 ++-
 tests/plugin/meson.build        |   2 +-
 18 files changed, 745 insertions(+), 255 deletions(-)
 create mode 100644 tests/plugin/inline.c

-- 
2.43.0


