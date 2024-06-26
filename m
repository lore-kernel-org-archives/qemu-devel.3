Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60208C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcEk-0000YP-Ls; Wed, 26 Jun 2024 19:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcEI-00081W-SQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:39:14 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcEH-0007af-8B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:39:10 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b9776123a3so3266457eaf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445147; x=1720049947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6PAWrGahHkqmzjOLaljnEqWW5B3wKtB+bSumQK5+Tc=;
 b=xe1V+W37Ubb04jM2aHgZrw92c8nsU3/79Vq1/y+c/Qn63FvomvFck8Gdfm5UyERbUD
 WrHJQR5kl3rGHTzZ3erY9Ty8/I7bWrxCgmZaoSYFgggnq5tV+afQdssa3nslRknaildm
 BAJIqrIwsZSMciu4W9+ULZs/EjsTIF3ffhOiO0BH+AvC7Do/Zh3hW+6XlK3O3tjthzAO
 u9BRYKFtrKB3MEbSZn19qNkA3H1JnInKTi8ZPDdDymAug7UoyTwj/una1JOkf0mVoQbG
 1LoBLMNl2Fp/iCNHOPKkfRWyuzwajCRDF0kNsG7yI+slRLDkKSpB7lS2y9986V3kiixR
 hjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445147; x=1720049947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6PAWrGahHkqmzjOLaljnEqWW5B3wKtB+bSumQK5+Tc=;
 b=k8oINT1n1MRdMyNr0ERRlc3x5kp/a0DwuzIiOmeiEAoGSd6Wag0UVYmlmRiv1XWg7j
 28EEJEYxPGlpC5oBEsFtrB+WDuuTfU3HXSWsx4+tLt3tInVXBzu8EHC0sJvtV9xY/Uy0
 Exkc3iCT/ijEdQ65e4HA8tO0xS9Aemqrz2/48ZxmjtwzUJRqNsfgUjyuZjL0E1osdJA1
 aqHzqOX2AaKwZFOjAcBK5HjU86jP7q5xx/pIvSsVal7qXEljLxkW7vh0ECj9Q70DiJHO
 T2jcMyNs4mhEif3zUd5IXkIF8a87/Rl3KPzzKQHd8DHCfJgvkybyQlKv519e8N9aoDdC
 6/sw==
X-Gm-Message-State: AOJu0YyaUpfjybcLFrcpJeB8dp2gB7Agf52MPusfKvux5kGaeig4H22s
 +oVyHhRfhLQO6y2OsDP7RRqmQPD0C7NEP936DlMvFceLRC3zg4noZtNpz2e9Dia9M994OkhGhz4
 8JHs=
X-Google-Smtp-Source: AGHT+IE+V3P8dmfH+iE5u2/rSBzG5IAQPkADBwcmQNTditgD6UXTfivSvApJ03yWvv094BjAphu7ng==
X-Received: by 2002:a05:6358:33a5:b0:1a2:255:8bbe with SMTP id
 e5c5f4694b2df-1a23f939759mr1432381255d.0.1719445147430; 
 Wed, 26 Jun 2024 16:39:07 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72745092c11sm68077a12.13.2024.06.26.16.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 16:39:07 -0700 (PDT)
Message-ID: <a5870490-0a99-4c95-a342-8a830f8e3ffb@linaro.org>
Date: Wed, 26 Jun 2024 16:39:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] plugins: access values during a memory read/write
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oo1-xc2d.google.com
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

A v2 was sent to fix a compilation issue on aarch64.

On 6/26/24 16:12, Pierrick Bouvier wrote:
> This series allows plugins to know which value is read/written during a memory
> access.
> 
> For every memory access, we know copy this value before calling mem callbacks,
> and those can query it using new API functions:
> - qemu_plugin_mem_get_value_upper_bits
> - qemu_plugin_mem_get_value_lower_bits
> 
> Mem plugin was extended to print accesses, and a new test was added to check
> functionality work as expected. A bug was found where callbacks were not
> called as expected.
> 
> This will open new use cases for plugins, such as following specific values in
> memory.
> 
> Pierrick Bouvier (7):
>    plugins: fix mem callback array size
>    plugins: save value during memory accesses
>    plugins: extend API to get latest memory value accessed
>    tests/tcg: add mechanism to run specific tests with plugins
>    tests/tcg: allow to check output of plugins
>    tests/plugin/mem: add option to print memory accesses
>    tests/tcg/x86_64: add test for plugin memory access
> 
>   accel/tcg/atomic_template.h                 | 64 +++++++++++++--
>   include/qemu/plugin.h                       |  8 ++
>   include/qemu/qemu-plugin.h                  | 20 +++++
>   accel/tcg/plugin-gen.c                      |  3 +-
>   plugins/api.c                               | 21 +++++
>   plugins/core.c                              |  7 ++
>   tcg/tcg-op-ldst.c                           | 72 +++++++++++++++--
>   tests/plugin/mem.c                          | 28 ++++++-
>   tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
>   accel/tcg/atomic_common.c.inc               | 13 ++-
>   accel/tcg/ldst_common.c.inc                 | 38 +++++----
>   plugins/qemu-plugins.symbols                |  2 +
>   tests/tcg/Makefile.target                   |  8 +-
>   tests/tcg/x86_64/Makefile.target            |  7 ++
>   tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
>   15 files changed, 393 insertions(+), 35 deletions(-)
>   create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
>   create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh
> 

