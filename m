Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04307CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTLD-0006in-Qv; Fri, 22 Aug 2025 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTKb-0006OK-Hk
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:05:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTKX-0005ej-On
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:05:28 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24615b3445dso11780395ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755875118; x=1756479918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dS+zgdCpAYFGUoKW0yLhg60e3pstpN/f2LpdahNz4mc=;
 b=Tk2kn8+TIsXFE2GYxnpK0Mr3iEPYvrfZHt9pYtmuO0s5SYzKgXOajDXwSvKQDfQ2QR
 g2riPIltmtPi73q0GTPqn6Boasl6o9uQyKkXjLNCRkRo92YpnGcTluusEEdBNUIlOKMs
 nrWznVt+2M+FxrRZJBtvE1iEIHmW/2iW+snQZ+MACAycyBNHqiE9GR5l4GLWsQ6uo01/
 bkpvka/PtT4mMNhAkyLOf+ZauuVGTPnS+2MTizi+IiaH3pNgK5YOEZSM4/LnasOPZb10
 GZuZPpBR4yxohBRh5udAFUFth90gK0jgZHD3nX6JW25ZFPFeHNmLOg7OfLdZ5/05qujc
 TAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755875118; x=1756479918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dS+zgdCpAYFGUoKW0yLhg60e3pstpN/f2LpdahNz4mc=;
 b=ZJoC7r/9Hqsd/1KfA04QQjfh+xyQinNi0JvFmZNLv12eAsclrXUHKVfeD3BU5jC8K1
 VbhWhOlsjTV1UeKQKRu4nU6qSY/ymB0R5TXZYz5I8kr1PQd/BRMc/+SROXT2ag/ZGQ6H
 qs20EfDBkx8/9r9m1nUQnZYDPt3iSHcrbnqGkPzECD4JwHR5Y0Ns6aED5C+0sIPTpJOq
 kHvn4RrQmbpJDjF9K4W4GrFArnqYRnbpnWSQ1PAP8nOf8f7URiIlY7mbgJ8nSMXz7OjX
 5PW4eJZixRjYXBpiQBkSJKncxC/j0m7iAG8TZyyadHcIscE4PHRoSri2c8M89/hrGCHa
 qhMQ==
X-Gm-Message-State: AOJu0Yxc9O0rp+GVIiybksYF+kPxH3unDnizss3LYUElmzfyP01eWVtA
 2vhYpq9QS9hH0aFJu2XBRIZSN2L7BHuZkTeDeUBI5f7rf2z5e8RzTi3OOWrxAJ6PjrL48rDJEtL
 6isTBZpKBXg==
X-Gm-Gg: ASbGnctWvMf0c+5UbuztvalA7PWDsJZZEVFLiitRE1pE2ytoep7DVjd4by6LrdQ92bX
 uBiEDorRWeHMY2H+kFkBGgC2hzwJaCisr99l0KODS/WAF1pMsPOdIZt8VWKkujrQW7Bbbzv0u40
 c54ku1n2EOrUwd7itASRF6OXeJT9bXVX6bpwRgx4q64c771wdL95LwaJSY3Er0C3hWILV6hG70c
 4rF+iLSKdpEsHOVtU3mIA4f98wctWnTWtsmSVT32rP9d9OUnMPQXJtNxSK0Qu3VUFi0Rn5dYFYL
 KnO7lrDLLVMn3Pgn6P6LR64R94zUjNO0VjHbKQZR1gdA5VBrC8z84pOeZUSmJnjM4gCGnwhpr8d
 /7zTFIrs2FoO69uHS4b7XMXP+1FjQ95Xvz8Dq
X-Google-Smtp-Source: AGHT+IGwmVzt4v7vtICSxFyeNLhu8d2iYdGZCJun6cCI7hb9syFdiuvxMEYfvu+Q196s15zxdgdXXA==
X-Received: by 2002:a17:902:d48f:b0:237:e696:3d56 with SMTP id
 d9443c01a7336-2462ef037d8mr40854575ad.32.1755875117868; 
 Fri, 22 Aug 2025 08:05:17 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245f0d86c05sm79796045ad.93.2025.08.22.08.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 08:05:16 -0700 (PDT)
Message-ID: <40cf55e8-b7d5-49ee-8c0e-10c32a1df00f@linaro.org>
Date: Fri, 22 Aug 2025 08:05:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] single-binary: compile once semihosting
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025-08-22 08:00, Pierrick Bouvier wrote:
> This series compiles once semihosting files in system mode.
> The most complicated file was semihosting/arm-compat-semi.c, which was carefully
> cleaned in easy to understand steps.
> 
> v2
> --
> 
> - use vaddr for syscalls.c/.h
> - static qualifier for console_{in,out}_gf
> - use vaddr for arm-compat-semi.c
> - semihosting/arm-compat-semi: fix cast for common_semi_set_ret
> 
> v3
> --
> 
> - keep common_semi_sys_exit_extended (Peter)
> 
> v4
> --
> 
> - fix patch 9 commit message to s/uint64_t/vaddr (Phil)
> 
> Pierrick Bouvier (12):
>    semihosting/syscalls: compile once in system and per target for user
>      mode
>    semihosting/syscalls: replace uint64_t with vaddr where appropriate
>    semihosting/guestfd: compile once for system/user
>    semihosting/arm-compat-semi: change common_semi_sys_exit_extended
>    target/riscv/common-semi-target: remove sizeof(target_ulong)
>    target/{arm,riscv}/common-semi-target: eradicate target_ulong
>    include/semihosting/common-semi: extract common_semi API
>    semihosting/arm-compat-semi: eradicate sizeof(target_ulong)
>    semihosting/arm-compat-semi: replace target_ulong with vaddr
>    semihosting/arm-compat-semi: eradicate target_long
>    semihosting/arm-compat-semi: remove dependency on cpu.h
>    semihosting/arm-compat-semi: compile once in system and per target for
>      user mode
> 
>   include/semihosting/common-semi.h             |   6 +
>   include/semihosting/guestfd.h                 |   7 --
>   include/semihosting/semihost.h                |   2 +
>   include/semihosting/syscalls.h                |  30 ++---
>   semihosting/arm-compat-semi-stub.c            |  19 +++
>   semihosting/arm-compat-semi.c                 |  65 ++++++++---
>   semihosting/guestfd.c                         |  26 +----
>   semihosting/syscalls.c                        | 109 +++++++++---------
>   ...mon-semi-target.h => common-semi-target.c} |  22 ++--
>   ...mon-semi-target.h => common-semi-target.c} |  27 +++--
>   semihosting/meson.build                       |  18 +--
>   target/arm/meson.build                        |   4 +
>   target/riscv/meson.build                      |   4 +
>   13 files changed, 190 insertions(+), 149 deletions(-)
>   create mode 100644 semihosting/arm-compat-semi-stub.c
>   rename target/arm/{common-semi-target.h => common-semi-target.c} (59%)
>   rename target/riscv/{common-semi-target.h => common-semi-target.c} (53%)
> 

Ping on this series.
I'll be out next week, but it should be ready to be pulled once the
trunk reopens.

Regards,
Pierrick

