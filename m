Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACA6C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPX29-00024T-Vo; Thu, 04 Jul 2024 20:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPX28-00023L-4n
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:42:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPX26-0006gS-8T
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:42:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fa9f540f45so6613735ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720140156; x=1720744956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QcWRUXboWQGErs9Vw8rcF2NNyPNQW1LJklcHVieAbjs=;
 b=eiYo39rpNAA7nnDKfbq4JLGCM3fOc6sLAw31iO9IBjFGmkTtZXnmVVtlZVYa8Z1gsA
 t0UlpKCu1S/s5nWbO8cgn4A5j74PiKALzNxXArpC6tJz8yAa/ndIHzVDz0aKfzDcAy0h
 +tjpo0eIzrlJEK36HghKApNBd8LEzfxuDU5cLXB2no6tBAToRLd8i2wWBOxPUbTR2fHv
 cTUfHFf7tMl+POoP4VuHa3kB/AkqNgzu4IWSTiFwy/MqXrRsObzTFevWUb/O73KJENc7
 MOGJwiP/itO+mklKKW2mJh5bA5URLMAB4PMqgCuRWlKfq0J415Pp3Ntrs46BM/4nI63R
 eRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720140156; x=1720744956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QcWRUXboWQGErs9Vw8rcF2NNyPNQW1LJklcHVieAbjs=;
 b=Fa4Zd0zYippm6plm22cGInqeDrabvVGbwEqS1ilqlzqlYLhfPPc3WGXlp4r4SyerjP
 z173RSkUEv7PgAYVHe/sQvvL0YOpFlz95mNcy4WoJO8iB0ExnWSlOY4YQR3eqCqM2Wiu
 bCewTnHGeno/KPF39M6BrsYDVrr3qSoniL2gLsel2c10UBQOOBZpNb6YPsK4Uz5ut6MD
 rEMWP5xzHfO+BM4dcJPR1rvSpIVrdoDa3KIHKtZIzpjjsSktpJnxlmr+JQ/ScptduQ0u
 JmKo4NDecSDzyj69iJHbzDM+86hlE0e0oLfwZRlfENH6weSuL4opNYW9KlZvZwDVoIpi
 7MfQ==
X-Gm-Message-State: AOJu0YyCKP2zwKSeQlphwS/m17OcGpZj+cZQKpbe9j4m8RO/LO9fyQa6
 AeXDSCwTlfxieV7xV6tPqhfjc3Vk4QpvwGCjB9yZJRnt4vShwKx2SeE401+GcqhIYRAi5m6uLci
 oGO4=
X-Google-Smtp-Source: AGHT+IEbwVMvKqlnlrqNuNZZYJ2vyjuAHWFdbP2NpN2moroK1D9myaadqGHsJOii1w/P/H+d550Zjw==
X-Received: by 2002:a17:903:1250:b0:1fa:fb88:3a15 with SMTP id
 d9443c01a7336-1fb33eea803mr19699945ad.42.1720140155664; 
 Thu, 04 Jul 2024 17:42:35 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac2f03acdsm128602405ad.302.2024.07.04.17.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 17:42:35 -0700 (PDT)
Message-ID: <1fae0be3-b80c-427a-8999-9d420d74b9d5@linaro.org>
Date: Thu, 4 Jul 2024 17:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] plugins: access values during a memory read/write
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Posted v5.

On 7/2/24 11:44, Pierrick Bouvier wrote:
> This series allows plugins to know which value is read/written during a memory
> access.
> 
> For every memory access, we know copy this value before calling mem callbacks,
> and those can query it using new API function:
> - qemu_plugin_mem_get_value
> 
> Mem plugin was extended to print accesses, and a new test was added to check
> functionality work as expected. A bug was found where callbacks were not
> called as expected.
> 
> This will open new use cases for plugins, such as following specific values in
> memory.
> 
> v4
> - fix prototype for stubs qemu_plugin_vcpu_mem_cb (inverted low/high parameters
>    names)
> - link gitlab bugs resolved (thanks @Anton Kochkov for reporting)
>    https://gitlab.com/qemu-project/qemu/-/issues/1719
>    https://gitlab.com/qemu-project/qemu/-/issues/2152
> 
> v3
> - simplify API: return an algebraic data type for value accessed
>    this can be easily extended when QEMU will support wider accesses
> - fix Makefile test (use quiet-command instead of manually run the command)
> - rename upper/lower to high/low
> - reorder functions parameters and code to low/high instead of high/low, to
>    follow current convention in QEMU codebase
> 
> v2
> - fix compilation on aarch64 (missing undef in accel/tcg/atomic_template.h)
> 
> v3
> - add info when printing memory accesses (insn_vaddr,mem_vaddr,mem_hwaddr)
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
>   accel/tcg/atomic_template.h                 | 66 +++++++++++++--
>   include/qemu/plugin.h                       |  8 ++
>   include/qemu/qemu-plugin.h                  | 32 ++++++++
>   accel/tcg/plugin-gen.c                      |  3 +-
>   plugins/api.c                               | 34 ++++++++
>   plugins/core.c                              |  7 ++
>   tcg/tcg-op-ldst.c                           | 72 +++++++++++++++--
>   tests/plugin/mem.c                          | 69 +++++++++++++++-
>   tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
>   accel/tcg/atomic_common.c.inc               | 13 ++-
>   accel/tcg/ldst_common.c.inc                 | 38 +++++----
>   plugins/qemu-plugins.symbols                |  1 +
>   tests/tcg/Makefile.target                   | 10 ++-
>   tests/tcg/x86_64/Makefile.target            |  7 ++
>   tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
>   15 files changed, 462 insertions(+), 35 deletions(-)
>   create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
>   create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh
> 

