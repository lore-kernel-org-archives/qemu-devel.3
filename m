Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F35C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 19:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2bvT-0001G7-J2; Thu, 02 May 2024 15:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s2bvO-0001Er-0F
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:16:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s2bvJ-0007UN-7S
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:16:55 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ed112c64beso7624272b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714677409; x=1715282209; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inOX7LCYhMlbN4oNfNroFHN9z5E4NzCgROpYRcjuDko=;
 b=tRmTk8r/m8D60TvQ11qRoirOGn39spI/MvFt4xQ8zjwHIqjQ1Ow9yfD9V+ADbxi4DP
 6MyJcf7AoXMro6Bkl515cn0ggRctXPXoy+BnY0V/QFilD4C9Jix4Sl61MSfoe0Vv7O1Y
 +jJiTQLXTv32nnVQK2VM+SsAnM7AHSsb3gD1NaLryQo4N+ugHLyGOREbzsiAyzX8O6mV
 4aFqCCNtD+k+fHFNeP4lGFs2yAfLjoGfHbkUmBXA7jdeEw4CJj5gI9d8N2p67P6e8KIB
 ws6xfvfXV+rRQgxp+GGH19JtjuRRUqoVmH8f5rty69g1JCPlPSGymrJTdfkgzgdZArtL
 lUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714677409; x=1715282209;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=inOX7LCYhMlbN4oNfNroFHN9z5E4NzCgROpYRcjuDko=;
 b=aZuOyxo2yZ44szwvKnjft0QsHOQnYU+avwuw9gu1PecklyclFZgjG9rhYsr+9KopGm
 Nee0vnzrtA3SuQBdKrKKfapfs3t2PohFwFHbQZUQKKRJsm8xJc9i3nhkhht2HF9pjOyT
 tcKL4dbkzgapcjDR6VnTjLxT/T08JV3KSF/LHnfMH+h1nvAf7Hsh5ieInzBtuk4YY3HW
 ZpcgYngJjE+kLAqOUa6NNOfIUA1X5OklYt9whW6EQcNCaRq2lM8ao8EsR095AYDve1Ny
 b9ixSGykp/z7EP51wx+OFvJ9TA6OCaZ3qe/bK5JOSFOjiXN9DBIlYvQITYJHuLBil2+D
 HwqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Yap+RsYmkWgFoltS07/qN4chDfF+Z+mmSgv0mv0b6EwFZSVlEFjqMMlLO+bxYAtP5/9pVfuoWGHd5ulOfiXt0THTNFw=
X-Gm-Message-State: AOJu0Yw3Zs9pMsS2VGm53t9pBvv3XStgi/K0g9ZaA2EWtDiXAh/xqEw8
 DJbIUUgJ1MbpCuVTk27qLXEo1tq/ArefkUmNjVMHOTDFXdgmKMXF9hxfM327qua4vn4gbBjuARj
 D
X-Google-Smtp-Source: AGHT+IEqfulaU34ckilB4CY/ApciIAFj7K8NnnIRYrE97Voht0mz5oX6mOQvu13eflm+tuOrLXp9VA==
X-Received: by 2002:a05:6a20:734e:b0:1a3:6833:1cf5 with SMTP id
 v14-20020a056a20734e00b001a368331cf5mr804225pzc.29.1714677408571; 
 Thu, 02 May 2024 12:16:48 -0700 (PDT)
Received: from [192.168.0.102] (201-1-51-131.dsl.telesp.net.br. [201.1.51.131])
 by smtp.gmail.com with ESMTPSA id
 sr14-20020a17090b4e8e00b002a2f3cfc92asm3564897pjb.16.2024.05.02.12.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 12:16:47 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] TCG plugins new inline operations
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <b78563fd-1c06-8ee1-5508-39b3e83249cf@linaro.org>
Date: Thu, 2 May 2024 16:16:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.296,
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

Hi Pierrick,

On 5/2/24 3:08 PM, Pierrick Bouvier wrote:
> This series implement two new operations for plugins:
> - Store inline allows to write a specific value to a scoreboard.
> - Conditional callback executes a callback only when a given condition is true.
>    The condition is evaluated inline.
> 
> It's possible to mix various inline operations (add, store) with conditional
> callbacks, allowing efficient "trap" based counters.
> 
> It builds on top of new scoreboard API, introduced in the previous series.
> 
> NOTE: Two patches still need review
> 
> v2
> --
> 
> - fixed issue with udata not being passed to conditional callback
> - added specific test for this in tests/plugin/inline.c (udata was NULL before).
> 
> v3
> --
> 
> - rebased on top of "plugins: Rewrite plugin code generation":
>    20240316015720.3661236-1-richard.henderson@linaro.org
> - single pass code generation
> - small cleanups for code generation
> 
> v4
> --
> 
> - remove op field from qemu_plugin_inline_cb
> - use tcg_constant_i64 to load immediate value to store
> 
> v5
> --
> 
> - rebase on top of master now that Richard's series was merged
> 
> Pierrick Bouvier (9):
>    plugins: prepare introduction of new inline ops
>    plugins: extract generate ptr for qemu_plugin_u64
>    plugins: add new inline op STORE_U64
>    tests/plugin/inline: add test for STORE_U64 inline op
>    plugins: conditional callbacks
>    tests/plugin/inline: add test for conditional callback
>    plugins: distinct types for callbacks
>    plugins: extract cpu_index generate
>    plugins: remove op from qemu_plugin_inline_cb
> 
>   include/qemu/plugin.h        |  42 +++++++----
>   include/qemu/qemu-plugin.h   |  80 ++++++++++++++++++++-
>   plugins/plugin.h             |  12 +++-
>   accel/tcg/plugin-gen.c       | 136 +++++++++++++++++++++++++++--------
>   plugins/api.c                |  39 ++++++++++
>   plugins/core.c               | 109 ++++++++++++++++++++--------
>   tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
>   plugins/qemu-plugins.symbols |   2 +
>   8 files changed, 466 insertions(+), 84 deletions(-)

The description in the commit message of patches 1/9, 2/9, 6/9, 7/9, and 8/9 is missing.

Is this intentional?


Cheers,
Gustavo

