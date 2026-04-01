Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041EF107638D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zha-0004lm-Rz; Wed, 01 Apr 2026 13:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7zhZ-0004lR-BM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:50:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7zhX-0005sb-Gw
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:50:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82ce09b61beso20722b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775065797; x=1775670597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=idaNdcBJWyF+6rkPZEh9BOULGO0s+hjNQm1sxEStP3Y=;
 b=cNVKZe9suoJ16YCAVNam7GvCQq3vcTWYWf1ysBOmyNi1WwiS+Z0w5mWDSv4TdQ5Nra
 fSLa9aZ+UJqfy5cQTZTT9Fz7CosSTB8aD7A2JVh+joAAOO69Bld08JrETa0C4f2hs39v
 HAJ5sksbk67vFjMvMG6J7RAgBD8Kl1GkEkLAtgwm21SfiJNUI6d04sLBlkiKE3p+Wf3l
 2xb5fRp/QldPJMWlK1EQ8gPdEN1y5ZzFf6WlLtb4rSmScED2I9WqCRcqvZKshE7z2Wme
 VioRvAa9Yx8LjjRfwDY3jDJSbk4Wn6COKqrqTUj9FThq6T0IY42cs0/bSw+h5eXgYFJ5
 OQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775065797; x=1775670597;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=idaNdcBJWyF+6rkPZEh9BOULGO0s+hjNQm1sxEStP3Y=;
 b=pE2cHX76qdtc/dixWCbox6rf4gEwLEkXJELD1SkO1A+urhAJWlaRdDi4nFv4EIoztn
 i15sYI4O+pLz88TC3FyD0TwhMMewXociC6bnohOoK+brbWutasvA6omFKVOKH/SDI19S
 jHq4GkQiE9TlML0AKmuI/137MOoJEt0jS33Gnww/y0UiG0CL7zSjq016ZKwoxDjBrkbX
 jzAswPUpGUBKu4dBfigXwO5uY+0TQeDIfpHgwl8tfubGF9T8FBxGrTAA3q3I3qEkXCzu
 hRRPt9qenDAVvT6ul39o5tejnJJUyi6dPKgF1Ex5Mf6zUaC0L2nMRpoOTTXdAN5TnEUu
 8D1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVriQXvhuRCYJcpux4pvIQFkac4j+rqJow8HW2sdamkY3SBFcsaG+3yBVGcxcQGAGX5maIkd8RXnAJQ@nongnu.org
X-Gm-Message-State: AOJu0YwjO7M1GgCjlKZ6cc0RL8yOEWfZI9xHcuNi0lQ4ZLvNCASAu6gN
 7afFwfzU4aEyBynK7+e7F5KJiAaL3tL5IB4/mHCzyc8q0nduGpjGWV4Aq5g3JFLPvL0=
X-Gm-Gg: ATEYQzwjSk+RhtDf61YBGHmjaEXQPWvMQwV4GFClPGUaRF/Slvd1Ra8GhUs5rIX53+j
 5AQ924YH/gfAaECoHO8fgmO+A1gdWZR7aeDd4KrT2xKZWuTCFFhuh3EObqzG0zLoiWaYIYtNUan
 IHL8sYbZbAeGqLvH5i2gD/LN3FNeXPflBlmFU4ASeZzI4B6xjBO38hCJQTtsbSJH4dL8k01N1Jo
 v3r5udRi5/YPdpoL2Sef5hRvObwEx9iF3Yp8AvodAflinA9m6lDEEwkH63G03/PYI9tbNYU3r8O
 MuSHW9TOZehPzl3LxyLwXFNfDjNNLhJmL9WRYQUa5x29X3ZIWTwGbR9qnZjxjwHMM8NmQiZAoO5
 vzzhR5xHgp4Lj6b1qjZ7OJOOjts/cRsok9MucKgWqfqYJtJT9D3dZL58HZwDfvg3tpaEFGcZZik
 jE8W/VsdHOgRnBlwlLXumIck15ub35a6/6IartfuEMTqfBLbTnHh0uty7vsAmK451NExh3
X-Received: by 2002:a05:6a00:ad87:b0:82a:ea3:c16f with SMTP id
 d2e1a72fcca58-82ce8b1b545mr4900513b3a.53.1775065797373; 
 Wed, 01 Apr 2026 10:49:57 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3ccc8sm738645b3a.19.2026.04.01.10.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 10:49:56 -0700 (PDT)
Message-ID: <a806e8d5-facb-4831-9d6a-0518af41ea50@linaro.org>
Date: Wed, 1 Apr 2026 10:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] contrib/plugins: add syscall-filter local-library
 demos
Content-Language: en-US
To: XU Kailiang <xukl2019@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Ziyang Zhang <functioner@sjtu.edu.cn>,
 Yun Wang <yunwang94@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>
References: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Kailiang,

On 3/31/26 10:36 AM, XU Kailiang wrote:
> Hi,
> 
> This series adds two contrib/plugins examples for the linux-user syscall
> filter API.
> 
> The first patch adds a minimal zlib-based demo. It redirects the guest
> loader's library open to a local thunk library and handles the thunk's
> magic syscalls by calling the host zlib implementation directly.
> 
> The second patch adds a callback-capable qsort prototype. It shows that
> the same interface can also bridge callback-style library calls back
> into guest translated code, using a small thunk library plus a
> ucontext-based host-side bridge.
> 
> The final patch extends both demos from the openat()-based loader path
> to open() and openat2().
> 
> To keep the examples small, both demos currently target x86_64
> linux-user and assume guest_base == 0 on a little-endian 64-bit host,
> so guest virtual addresses are directly usable as host pointers. The
> qsort prototype is built only on hosts with working ucontext support.
> 
> Once the demo library path matches, both demos intentionally assert that
> opening the thunk library succeeds. These examples are meant to show the
> local-library hand-off path once a known thunk library is in place, not
> fallback behavior when that local library is missing or unusable.
> 
> One limitation is worth calling out explicitly: straightforward local
> library hand-off is only part of the problem. Once execution needs to
> leave the guest, run host code, and then re-enter guest translated code
> again, for example through a host-side function pointer callback,
> additional target- and ABI-specific handling is needed. The qsort
> prototype shows one such bridge for x86_64 guest callbacks, but this
> series does not attempt to provide a general solution for that broader
> case.
> 
> Patch 1 adds the zlib compression demo.
> Patch 2 adds the callback-capable qsort prototype.
> Patch 3 extends both demos to open() and openat2().
> 
> Reproduction instructions are included in docs/about/emulation.rst and
> in each example directory.
> 
> Thanks,
> XU Kailiang
> 
> XU Kailiang (3):
>    contrib/plugins: add a zlib compression filter example
>    contrib/plugins: add a callback-capable qsort prototype
>    contrib/plugins: handle more loader open syscalls in the syscall
>      filter demos
> 
>   contrib/plugins/meson.build                   |  16 +-
>   .../Makefile                                  |  19 +
>   .../README.rst                                |  47 ++
>   .../callback-demo.c                           |  75 +++
>   .../callback-qsort.h                          |  14 +
>   .../callback-thunk.S                          |  38 ++
>   .../plugins/syscall_filter_callback_qsort.c   | 484 ++++++++++++++++++
>   .../syscall_filter_zlib-example/Makefile      |  19 +
>   .../syscall_filter_zlib-example/README.rst    |  44 ++
>   .../zcompress-demo.c                          |  94 ++++
>   .../zcompress-thunk.c                         |  35 ++
>   .../zcompress-thunk.h                         |  16 +
>   contrib/plugins/syscall_filter_zlib.c         | 319 ++++++++++++
>   docs/about/emulation.rst                      |  41 ++
>   14 files changed, 1260 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/Makefile
>   create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/README.rst
>   create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-demo.c
>   create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-qsort.h
>   create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-thunk.S
>   create mode 100644 contrib/plugins/syscall_filter_callback_qsort.c
>   create mode 100644 contrib/plugins/syscall_filter_zlib-example/Makefile
>   create mode 100644 contrib/plugins/syscall_filter_zlib-example/README.rst
>   create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-demo.c
>   create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.c
>   create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.h
>   create mode 100644 contrib/plugins/syscall_filter_zlib.c
> 
> 
> base-commit: 512b794b1091bc4810d28e8ef28addf6344c3889

that's a good demonstration of the thunk approach you have been working 
on. However, I'm not sure of the value to add those manually crafted 
examples upstream for now. All they test is the syscall filter, but we 
already have tests for it.

In case we want to have something more useful upstream, it would be nice 
to provide a plugin than can automatically execute a program linked with 
any of those thunk libraries (ideally hosted somewhere, so we don't have 
to compile this).

What do you think about this? Are you missing specific bits to make it work?

Regards,
Pierrick

