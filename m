Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799A8C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiVl-0005QO-Ky; Tue, 02 Jul 2024 14:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiVR-0005Pn-Pg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:35 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiVP-0008Lg-RZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-72c03d2926eso2674659a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945929; x=1720550729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+voljX0AmW22AD8bOWRHKDkhslmC+iUf/qO1GcCxqc=;
 b=kDg3jZHT01cw61Z5stQ0NhPYx0LPzkZ33wp8y5zkyBSS1wNIg3iaaqU9WbWZtcRfBU
 xsYWIfE8cquLLjTLIIvO9mD0i29JHaGhJ8nmRljvQ2+Af1o6wFbhNx8+mESmECUZlOUK
 5OK+aE/1YcNaAwoD0f1o/jAs3PYcFZliktw/PxoeYxMbYeHm+fawW14vlb9CcaASHAxe
 jP/b20ypNldowT86yaGiAzOiXoS+fJqjtenJ6Xsgu1OFd6djvHo3VDzBkeekWUHod6sd
 WHnOSLljHm2LIwU72Y7TKUwRELRJiVi3YRMM+j8zGI0d8vfC4eC7q6nlAfgf1oNoJOuO
 mE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945929; x=1720550729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+voljX0AmW22AD8bOWRHKDkhslmC+iUf/qO1GcCxqc=;
 b=E8ZG3Zu4Jnc5MJn+SctUah8g3uumOYdB+klYEo0oYQLwwNiSsK80rInZLwTo/+dW+y
 IYrhHeaDIUFLXWW1+9VE24aiVFmgUSnIMoKdHaG0ho28j/aIEi753MBdTQYRSvSj7KvM
 MEJF17KkLfkTCmr7g2mIwCTVpk7+EuSViLILOHe7Y3/dVNTZ3yUm5MAFNb3B4upfzkPk
 NolSchwahb0vLYeA21TA/TBWX4sKdlfuTb/R/K6T1mSqOgAT/krTxqbWedV6kI5ScsZy
 Hh1dFZtjJIt1fgKptZYLtFp33twM1sQ4QPPstVwaIllRHA32fPvl7VtKokIAEtIDJs7q
 0MNg==
X-Gm-Message-State: AOJu0YwXuSh4TUP6OQ2iKrIOp2nQWOvh4G6sMGJNujs9Scyyz+u+3I1N
 KGfpAVtwiXioUmn0EfJ/5r73ODbOJRbEVJFSJsy4eZxmjsKTyQh/wn/suwF1I+2bm3M6IbZ5YFQ
 e
X-Google-Smtp-Source: AGHT+IFtWUP2MrDGlyaYBaoPVtloOxL2Mrql9L1SZ646JI2uZ4RHq6zq/htDYHr5fMxQCKxVxm0X0A==
X-Received: by 2002:a05:6a20:4324:b0:1bd:23bd:4b9a with SMTP id
 adf61e73a8af0-1bef60f3bd8mr10314428637.9.1719945929433; 
 Tue, 02 Jul 2024 11:45:29 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708049893a4sm8876364b3a.197.2024.07.02.11.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 11:45:29 -0700 (PDT)
Message-ID: <22b0bf9e-a725-435d-99fe-087e01c0c237@linaro.org>
Date: Tue, 2 Jul 2024 11:45:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] plugins: access values during a memory read/write
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

Posted v4.

On 7/1/24 18:10, Pierrick Bouvier wrote:
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

