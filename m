Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 15:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXk7k-00073w-CI; Wed, 07 Feb 2024 10:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXk7i-00073O-LB
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 10:46:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXk7e-0004qa-0K
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 10:46:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-410177e41a8so4832925e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707320759; x=1707925559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3APjiv5N/ETe0UF4UnKRu8bwpuINq7QWAndmsbz07/4=;
 b=LOqkRkuiU9HCVC78XDvdFzeU5VznwtbcE1ehli/6HICFSNXK8Lguc7tfN/6Np90cev
 YcGX37u1K1PyRkZHo1uuQfG/yQ6f1MXxTowJFVTOY5U/I9qMmpzgXMBhaXOauiRRhSiI
 TjVAx0KceeTmxRReEFfWJtHJNyodVItl9MtTfKqWIj9m6CKEpVMUEGY/kQ9sXu/AUw78
 WDlchnLZItFIMAmLZ7pk7CKR4CMnYpSCmjChgUl6SbU7ZpmzI85A3iRMetJ0uQtg986m
 O5tjfC/j0mO+awselGw4BllBiya25QASZGPRy8O/KNeFj2806apxEUgxFSHsvMmU2Kx6
 cYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320759; x=1707925559;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3APjiv5N/ETe0UF4UnKRu8bwpuINq7QWAndmsbz07/4=;
 b=P/oDCKDadBxLWikW4RKu0SB6iBNtowc0G6C61nY3c/jnGTRsgw8j5yafHQL9EvGC8o
 VDCRAdBxOJgCRjrLVY3NNS0FU8ist46aO9COasPRjfMLztbeFoigM4IhmYcn4TRlBHyK
 MnF0SYfn8RUmSApXDiqkNCokcs6qCpLVASkiWPwWLWeLW8gLuXmAkYiFmXBN3AEvXdGV
 0KhjFDYwSjAvhPMQkJFiUmSlPqZqhqoVIKmcn2guYKEeje9WOB1qLi+xteGoR2WVE+MK
 Fazks1a7JwyS866cjpHR1UY0jYXsP2tT/6gdHtDuz3tnaI2lmZLp6D2LN8CCX+BWXrRW
 4C3w==
X-Gm-Message-State: AOJu0YwL6xbdhIahKa0PSQOuRi3ZwjefMpNWl8dc4eiu0uvjaekH3MUP
 fXMSRu5BaePapSOQUd48M9YtoJkykuIEur/A6r9AtjsBT7Gj4xjCuB6HW7aLMHA=
X-Google-Smtp-Source: AGHT+IEDSYWuuGz9AZzTChcrjDbH9tI7oBW1mjn+eR5xOYnKK8XaE7EfR5LjaZT4AIfuwOM+/bV9kA==
X-Received: by 2002:a05:600c:4ec6:b0:40f:d25f:718d with SMTP id
 g6-20020a05600c4ec600b0040fd25f718dmr4179430wmq.37.1707320759440; 
 Wed, 07 Feb 2024 07:45:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVgIpiNrCroAQE1YHZQNglrZ+fUSFtBCFbw8AvdIeOlbLutZ+qzLN27rUZ/OsG5YeB6rdlT+LXH8CWPMRpV5orS0RSaUg4fHXJUQAr1P9nWLiGODTChlK2XciC0fKQ2sUUEUaEBf5sNVniZQ5m0N9NXMSDVHFz8hsrRCnt/GaHg/f79FvGWlQQ6abOqXMmJAXjacjykKlh4FrAR+a6ZEvjf+a4pdGGzp4C8shc+NioDi+2GVJ3WWelXCm0dESdDK3iYl3YRliRkPpjTcnd9mHgDoZILDgZeL7/7plSBcOgJ7H0f1DJi9Uc=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c154800b0040fb03f803esm2520777wmg.24.2024.02.07.07.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8944C5F7B1;
 Wed,  7 Feb 2024 15:45:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/17] TCG Plugin inline operation enhancement
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 6 Feb 2024 13:24:05 +0400")
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 07 Feb 2024 15:45:58 +0000
Message-ID: <87msscl1l5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series adds a new thread-safe API to declare inline operation
> inside plugins. As well, it removes the existing non thread-safe API,
> and migrates all existing plugins to use it.

I've cherry-picked 3 and 4 into plugins/next so I can re-base the
registers work. I'll have a look at the rest of the series once I'm back
at my desk.

>
> Tested on Linux (user, system) for i386, x86_64 and aarch64.
>
> To give some context, this a long term series of work around plugins,
> with the goal to be able to do basic operations in a more performant and
> accurate way. This will mean to add more inline operations and
> conditional callbacks.
>
> One final target of this work is to implement a plugin that implements
> the icount=3Dauto feature, and allow QEMU to run at a given "frequency"
> based on number of instructions executed, without QEMU needing to keep
> track of this.
>
> Another final target is to be able to detect control flow changes in an
> efficient and elegant way, by combining inline operation and conditional
> callbacks.
>
> v2
> --
>
> Implement scoreboard API (cpu local storage), so plugins don't have to de=
al
> with how many cpus are used.
>
> Since plugins have been modified again, I didn't transfer any reviewed-by=
 on
> those commits.
>
> v3
> --
>
> - introduce qemu_plugin_num_vcpus (how many cpus were initialized)
> - fix order of plugin init/idle/resume callbacks
> - scoreboard:
>   - renamed qemu_plugin_u64_t -> qemu_plugin_u64
>   - some functions rename for scoreboard api
>   - qemu_plugin_u64 has only value based function (vs address before)
> - various cleanup thanks to review of previous series
>
> Based-on: 20240122145610.413836-1-alex.bennee@linaro.org
>
>  Version number: 3
>  Branches:
>           base:  plugin_registers_v3_20240122145610.413836-1-alex.bennee@=
linaro.org
>           topic: plugin_inline_per_vcpu
>
>  To: qemu-devel@nongnu.org
>
>  Pierrick Bouvier (17):
>        plugins: remove previous n_vcpus functions from API
>        plugins: add qemu_plugin_num_vcpus function
>        plugins: fix order of init/idle/resume callback
>        cpu: call plugin init hook asynchronously
>        plugins: scoreboard API
>        docs/devel: plugins can trigger a tb flush
>        plugins: implement inline operation relative to cpu_index
>        plugins: add inline operation per vcpu
>        tests/plugin: add test plugin for inline operations
>        tests/plugin/mem: migrate to new per_vcpu API
>        tests/plugin/insn: migrate to new per_vcpu API
>        tests/plugin/bb: migrate to new per_vcpu API
>        contrib/plugins/hotblocks: migrate to new per_vcpu API
>        contrib/plugins/howvec: migrate to new per_vcpu API
>        plugins: remove non per_vcpu inline operation from API
>        plugins: cleanup codepath for previous inline operation
>        MAINTAINERS: Add myself as reviewer for TCG Plugins
>
>   MAINTAINERS                     |   1 +
>   docs/devel/multi-thread-tcg.rst |   1 +
>   include/qemu/plugin.h           |   6 ++
>   include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++++++--------
>   plugins/plugin.h                |  24 ++++--
>   accel/tcg/plugin-gen.c          |  65 +++++++++++---
>   contrib/plugins/cache.c         |   2 +-
>   contrib/plugins/hotblocks.c     |  50 ++++++-----
>   contrib/plugins/howvec.c        |  53 ++++++++----
>   hw/core/cpu-common.c            |   9 +-
>   plugins/api.c                   | 121 ++++++++++++++++----------
>   plugins/core.c                  | 104 +++++++++++++++++++---
>   tests/plugin/bb.c               |  63 ++++++--------
>   tests/plugin/inline.c           | 186 +++++++++++++++++++++++++++++++++=
+++++++
>   tests/plugin/insn.c             | 106 +++++++++++------------
>   tests/plugin/mem.c              |  40 +++++----
>   plugins/qemu-plugins.symbols    |  16 ++--
>   tests/plugin/meson.build        |   2 +-
>   18 files changed, 745 insertions(+), 255 deletions(-)
>
> Pierrick Bouvier (17):
>   plugins: remove previous n_vcpus functions from API
>   plugins: add qemu_plugin_num_vcpus function
>   plugins: fix order of init/idle/resume callback
>   cpu: call plugin init hook asynchronously
>   plugins: scoreboard API
>   docs/devel: plugins can trigger a tb flush
>   plugins: implement inline operation relative to cpu_index
>   plugins: add inline operation per vcpu
>   tests/plugin: add test plugin for inline operations
>   tests/plugin/mem: migrate to new per_vcpu API
>   tests/plugin/insn: migrate to new per_vcpu API
>   tests/plugin/bb: migrate to new per_vcpu API
>   contrib/plugins/hotblocks: migrate to new per_vcpu API
>   contrib/plugins/howvec: migrate to new per_vcpu API
>   plugins: remove non per_vcpu inline operation from API
>   plugins: cleanup codepath for previous inline operation
>   MAINTAINERS: Add myself as reviewer for TCG Plugins
>
>  MAINTAINERS                     |   1 +
>  docs/devel/multi-thread-tcg.rst |   1 +
>  include/qemu/plugin.h           |   6 ++
>  include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++------
>  plugins/plugin.h                |  24 +++--
>  accel/tcg/plugin-gen.c          |  65 +++++++++--
>  contrib/plugins/cache.c         |   2 +-
>  contrib/plugins/hotblocks.c     |  50 +++++----
>  contrib/plugins/howvec.c        |  53 ++++++---
>  hw/core/cpu-common.c            |   9 +-
>  plugins/api.c                   | 121 +++++++++++++--------
>  plugins/core.c                  | 104 ++++++++++++++++--
>  tests/plugin/bb.c               |  63 +++++------
>  tests/plugin/inline.c           | 186 ++++++++++++++++++++++++++++++++
>  tests/plugin/insn.c             | 106 +++++++++---------
>  tests/plugin/mem.c              |  40 ++++---
>  plugins/qemu-plugins.symbols    |  16 ++-
>  tests/plugin/meson.build        |   2 +-
>  18 files changed, 745 insertions(+), 255 deletions(-)
>  create mode 100644 tests/plugin/inline.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

