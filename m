Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A1DC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkRH-0002Gz-0j; Wed, 07 Feb 2024 11:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkRF-0002Gb-2a
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:06:17 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkRB-000051-BX
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:06:16 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33b4e58102fso414698f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707321970; x=1707926770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljf3BYdJSa7DAc88F22C+FjPwOpQu7o1gFWU5dokdZE=;
 b=lkMrCY+IQV/J0qd+YNL41kV+w58AxAEFRUaypZ8aJcOrkLdsBRe//CSqEwmoE1jCnv
 uCXTqH9byqoQr0Xxtq4dbdbuLWBRJZPxFZfCKn4S2IYtsYQ8f2ks7pTjIULaknTyZTPQ
 gEPMpWYvTdmldSUKBmzkdxAdoWHbRI1OC5Fgqt/TItLxbpuXuNtKZB75HgXiKhu6CjEL
 zmM0vuDMVDKIWyhXv9ZJBb+t0BEM37wFHD7PdeMISxYCPgEvLftjHC6WzcNrHAZ770VG
 U0EVklIdFPXx8g7J0fv1NlkQWPFue8WDUAcw4+hTLSWEt3SMr3Mbze+axb5Ngps9kIm6
 Yh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707321970; x=1707926770;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ljf3BYdJSa7DAc88F22C+FjPwOpQu7o1gFWU5dokdZE=;
 b=dKSH8f056KhWO4aPTDPDu3iaD/5E70J1GZq6DjtQ7NiRnMrKGfcqWEce5I8DcMuyK1
 3D6+Kz+71RU6a8oR2ZD4j4i0LKnCvTw3cQr0iTQ2mQQbQvzt82WDDcgmFaedrB5Wrcnf
 K87x/PKw2AKBlR9SKy2mSsTbLWyVjutZZVrj5iBOveWgq2RtNntx3LOivsIaj6o69ey0
 mwmXVLAatFv/ykdnDAvYmUwyFKJDCoN1MZph6aomjO1VUTkWV4iZdYsmCZ7rXQMEjeMa
 pmXPri0LvgTKqratIEtinHdbhd6/Y7jF8CHSV4sOFSKtQO7UDLrG7FyNjCKPt6ZlSMKu
 Y8qA==
X-Gm-Message-State: AOJu0Yz81dJcsmgsEROGegc+UJ5iSeyzY5BHIpYlnOu8CkYy825RsGlO
 9KmmdVBl9wuoj7zBkzrAf/orL0qIiXoXMOPsoxruO7gxbgjrHaM48j6h7NCgeck=
X-Google-Smtp-Source: AGHT+IEpiqdd9JMceRnVCtznKW7WpWVmuGj4Cki/UrY5l4iru7vLfzHB4km3+q3t9u7ZoQx0WkLRIQ==
X-Received: by 2002:adf:cc8c:0:b0:33b:4d13:30aa with SMTP id
 p12-20020adfcc8c000000b0033b4d1330aamr1899826wrj.1.1707321970457; 
 Wed, 07 Feb 2024 08:06:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXU1vmMlfQwxQrM4JCAG2KCHAPUhTy2lw3IV0qBUQfIfZa8gOk3iNNJ84LzpyNz4VWlr2gGJtdh69BCGfNcMEU1kH5EJ2xxkS6ZpkJpX5FF87qghhC+qwN6iw+gPuLk464Ca8tDAfyEf9wJHs8Iow5b6JHjtnw05ND0T52Pb3eCXOtmy4fFzt/eY6dbaFzdcQg+k8FFC12eMrxBIhugJBUwyOLEz7VI41Z6AiNUSIvRytOFJzED9RxEkJfv25fP9tHQ0x4VUQ/fWeLDf9NDHjZwGBs75KaKZoJ3q00jlxRphL3JzdfzOhI=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s1-20020a5d69c1000000b0033b4719eb6esm1784675wrw.27.2024.02.07.08.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:06:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9806B5F7B1;
 Wed,  7 Feb 2024 16:06:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/17] TCG Plugin inline operation enhancement
In-Reply-To: <87msscl1l5.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 07 Feb 2024 15:45:58 +0000")
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <87msscl1l5.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 07 Feb 2024 16:06:09 +0000
Message-ID: <87h6ikl0ni.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>
>> This series adds a new thread-safe API to declare inline operation
>> inside plugins. As well, it removes the existing non thread-safe API,
>> and migrates all existing plugins to use it.
>
> I've cherry-picked 3 and 4 into plugins/next so I can re-base the
> registers work. I'll have a look at the rest of the series once I'm back
> at my desk.

Actually belay that, I'm caught in a circular dependency because this is
based on the registers series. I'll sort it out tomorrow.

>
>>
>> Tested on Linux (user, system) for i386, x86_64 and aarch64.
>>
>> To give some context, this a long term series of work around plugins,
>> with the goal to be able to do basic operations in a more performant and
>> accurate way. This will mean to add more inline operations and
>> conditional callbacks.
>>
>> One final target of this work is to implement a plugin that implements
>> the icount=3Dauto feature, and allow QEMU to run at a given "frequency"
>> based on number of instructions executed, without QEMU needing to keep
>> track of this.
>>
>> Another final target is to be able to detect control flow changes in an
>> efficient and elegant way, by combining inline operation and conditional
>> callbacks.
>>
>> v2
>> --
>>
>> Implement scoreboard API (cpu local storage), so plugins don't have to d=
eal
>> with how many cpus are used.
>>
>> Since plugins have been modified again, I didn't transfer any reviewed-b=
y on
>> those commits.
>>
>> v3
>> --
>>
>> - introduce qemu_plugin_num_vcpus (how many cpus were initialized)
>> - fix order of plugin init/idle/resume callbacks
>> - scoreboard:
>>   - renamed qemu_plugin_u64_t -> qemu_plugin_u64
>>   - some functions rename for scoreboard api
>>   - qemu_plugin_u64 has only value based function (vs address before)
>> - various cleanup thanks to review of previous series
>>
>> Based-on: 20240122145610.413836-1-alex.bennee@linaro.org
>>
>>  Version number: 3
>>  Branches:
>>           base:  plugin_registers_v3_20240122145610.413836-1-alex.bennee=
@linaro.org
>>           topic: plugin_inline_per_vcpu
>>
>>  To: qemu-devel@nongnu.org
>>
>>  Pierrick Bouvier (17):
>>        plugins: remove previous n_vcpus functions from API
>>        plugins: add qemu_plugin_num_vcpus function
>>        plugins: fix order of init/idle/resume callback
>>        cpu: call plugin init hook asynchronously
>>        plugins: scoreboard API
>>        docs/devel: plugins can trigger a tb flush
>>        plugins: implement inline operation relative to cpu_index
>>        plugins: add inline operation per vcpu
>>        tests/plugin: add test plugin for inline operations
>>        tests/plugin/mem: migrate to new per_vcpu API
>>        tests/plugin/insn: migrate to new per_vcpu API
>>        tests/plugin/bb: migrate to new per_vcpu API
>>        contrib/plugins/hotblocks: migrate to new per_vcpu API
>>        contrib/plugins/howvec: migrate to new per_vcpu API
>>        plugins: remove non per_vcpu inline operation from API
>>        plugins: cleanup codepath for previous inline operation
>>        MAINTAINERS: Add myself as reviewer for TCG Plugins
>>
>>   MAINTAINERS                     |   1 +
>>   docs/devel/multi-thread-tcg.rst |   1 +
>>   include/qemu/plugin.h           |   6 ++
>>   include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++++++--------
>>   plugins/plugin.h                |  24 ++++--
>>   accel/tcg/plugin-gen.c          |  65 +++++++++++---
>>   contrib/plugins/cache.c         |   2 +-
>>   contrib/plugins/hotblocks.c     |  50 ++++++-----
>>   contrib/plugins/howvec.c        |  53 ++++++++----
>>   hw/core/cpu-common.c            |   9 +-
>>   plugins/api.c                   | 121 ++++++++++++++++----------
>>   plugins/core.c                  | 104 +++++++++++++++++++---
>>   tests/plugin/bb.c               |  63 ++++++--------
>>   tests/plugin/inline.c           | 186 ++++++++++++++++++++++++++++++++=
++++++++
>>   tests/plugin/insn.c             | 106 +++++++++++------------
>>   tests/plugin/mem.c              |  40 +++++----
>>   plugins/qemu-plugins.symbols    |  16 ++--
>>   tests/plugin/meson.build        |   2 +-
>>   18 files changed, 745 insertions(+), 255 deletions(-)
>>
>> Pierrick Bouvier (17):
>>   plugins: remove previous n_vcpus functions from API
>>   plugins: add qemu_plugin_num_vcpus function
>>   plugins: fix order of init/idle/resume callback
>>   cpu: call plugin init hook asynchronously
>>   plugins: scoreboard API
>>   docs/devel: plugins can trigger a tb flush
>>   plugins: implement inline operation relative to cpu_index
>>   plugins: add inline operation per vcpu
>>   tests/plugin: add test plugin for inline operations
>>   tests/plugin/mem: migrate to new per_vcpu API
>>   tests/plugin/insn: migrate to new per_vcpu API
>>   tests/plugin/bb: migrate to new per_vcpu API
>>   contrib/plugins/hotblocks: migrate to new per_vcpu API
>>   contrib/plugins/howvec: migrate to new per_vcpu API
>>   plugins: remove non per_vcpu inline operation from API
>>   plugins: cleanup codepath for previous inline operation
>>   MAINTAINERS: Add myself as reviewer for TCG Plugins
>>
>>  MAINTAINERS                     |   1 +
>>  docs/devel/multi-thread-tcg.rst |   1 +
>>  include/qemu/plugin.h           |   6 ++
>>  include/qemu/qemu-plugin.h      | 151 ++++++++++++++++++++------
>>  plugins/plugin.h                |  24 +++--
>>  accel/tcg/plugin-gen.c          |  65 +++++++++--
>>  contrib/plugins/cache.c         |   2 +-
>>  contrib/plugins/hotblocks.c     |  50 +++++----
>>  contrib/plugins/howvec.c        |  53 ++++++---
>>  hw/core/cpu-common.c            |   9 +-
>>  plugins/api.c                   | 121 +++++++++++++--------
>>  plugins/core.c                  | 104 ++++++++++++++++--
>>  tests/plugin/bb.c               |  63 +++++------
>>  tests/plugin/inline.c           | 186 ++++++++++++++++++++++++++++++++
>>  tests/plugin/insn.c             | 106 +++++++++---------
>>  tests/plugin/mem.c              |  40 ++++---
>>  plugins/qemu-plugins.symbols    |  16 ++-
>>  tests/plugin/meson.build        |   2 +-
>>  18 files changed, 745 insertions(+), 255 deletions(-)
>>  create mode 100644 tests/plugin/inline.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

