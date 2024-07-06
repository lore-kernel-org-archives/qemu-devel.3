Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE50C3DA42
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQArG-0002FQ-PG; Sat, 06 Jul 2024 15:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQArF-0002F0-BD
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:14:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAr8-00046E-CT
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:14:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fb4a332622so8425205ad.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293237; x=1720898037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7STuWpVF1UhnYDMLUoD7ybWThdG6Ll4ZkyWilqjfQZY=;
 b=LwtvRVLgbIldQj7/i/wodp+ZQwF6zs70kwMINjaV65QOQy1cnM017+m2+FtgZtn6lB
 6JyZnJSP15iY6paHbSYat3aQ7YtedIuUJhNNZtT7SBPrn4L6QPifIKgcoLPy1OfyHQW7
 q0JlbnFxtrAzjSVMfYBDINN7/OXKW3pQ+30eKY9HhfeBMU8RAXYTSwNgvsmbAMOe9jdi
 YxiPvyrCYYpqAyEaa5oF+7sSurHKlYJwVT7s9eBpx48JMvhD4v4Iu/nHXUdfRc4Z2J59
 YKDH3/ysfqgn663GE4NK4Kyp1fcZdd9/f8wAJtH7xpKLS3JHpvaQPJUf9QB2D4LIcwXV
 NT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293237; x=1720898037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7STuWpVF1UhnYDMLUoD7ybWThdG6Ll4ZkyWilqjfQZY=;
 b=wa0+tmd4Ay9wZheCdF6kJwIG2kXaO6ymD0tjswkJLlsMSbl8fvWaKsYYvwziG9VZ1G
 6aQQLx11lY14S2iMv6Uhzod/NU7ZuQwI9MMN5Dtm9JHAqQZkNEOx/MYtg8wgMH92DXn+
 OG4jU5v801Lx7L1FkHp5BakAo72/6GFv9Vi3fYXtwCPCLRhErJP5ABJG4Zmcr7zW7q98
 SSnqlhtC3ieMYJNowidhXN0hgyX/164H3/x+CEzVnF1V8a3xFKcuOuVFRMSOTezFHonl
 gGhulqcaYLyukU5GzsOMYyE6N9rp8fuXqhsnAj21jk18NmxIV8wZW1KiyUNEafuKVw9X
 1vhQ==
X-Gm-Message-State: AOJu0YxSUSYno3L7u9zz7N3OvCOI083ewG1PhYUUoLifr7ADesHmOGy4
 +8P7KFbeWWaRe8nByP4eYKJndI6ey3g5yHKrqDpkqVbqGskmLvieDnYOysGfZtEB4hqL1gr6Fba
 UB0M=
X-Google-Smtp-Source: AGHT+IHTL6NT1sW8URpJu9m2uFRmW/cc/If1a+q5LARAES8piU9M7S3hw4ZBD/4KtxF7X1vZNWxTrQ==
X-Received: by 2002:a17:902:e844:b0:1fb:5e1f:f5e1 with SMTP id
 d9443c01a7336-1fb5e1ff933mr22902575ad.26.1720293236742; 
 Sat, 06 Jul 2024 12:13:56 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb21a90136sm64264995ad.298.2024.07.06.12.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 12:13:56 -0700 (PDT)
Message-ID: <5e01abc8-50dc-4601-9df9-cb74c02a22ec@linaro.org>
Date: Sat, 6 Jul 2024 12:13:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] plugins: access values during a memory read/write
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Posted v6.

On 7/4/24 17:34, Pierrick Bouvier wrote:
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
> v5
> - fixed width output for mem values in mem plugin
> - move plugin_mem_value to CPUNegativeOffset
> - tcg/tcg-op-ldst.c: only store word size mem access (do not set upper bits)
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
>   include/hw/core/cpu.h                       |  4 +
>   include/qemu/plugin.h                       |  4 +
>   include/qemu/qemu-plugin.h                  | 32 ++++++++
>   accel/tcg/plugin-gen.c                      |  3 +-
>   plugins/api.c                               | 33 ++++++++
>   plugins/core.c                              |  6 ++
>   tcg/tcg-op-ldst.c                           | 66 +++++++++++++--
>   tests/plugin/mem.c                          | 69 +++++++++++++++-
>   tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
>   accel/tcg/atomic_common.c.inc               | 13 ++-
>   accel/tcg/ldst_common.c.inc                 | 38 +++++----
>   plugins/qemu-plugins.symbols                |  1 +
>   tests/tcg/Makefile.target                   | 10 ++-
>   tests/tcg/x86_64/Makefile.target            |  7 ++
>   tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
>   16 files changed, 455 insertions(+), 34 deletions(-)
>   create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
>   create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh
> 

