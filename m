Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA5C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 09:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTIPe-0004tD-IR; Fri, 26 Jan 2024 04:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rTIPc-0004s5-1l
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 04:22:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rTIPX-0000VL-Hi
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 04:22:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40ed3101ce3so3017015e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706260924; x=1706865724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LOFbW62w3tv4jdBTBkUcmlzT27cLcZqEK+XHK1j4x+U=;
 b=NVc4t4xYTJq5VFnowC8iMHupaBy4tpsLmOQMN+i9BHoZ8owgP65KJB/KEExhq80zjk
 1JtDR1DtjG/wZjAmgViaHqAwkflaXwo6lWLtOgAM+MDiDBzb/feqy9DmedxCVGMsY0g8
 2zkRs5r3ZUH0pjfIef0DMM2zkPCiuv/X2W/i2q0yab3XxeKWY4kJvNyq8U+ZBB72ct1F
 48kLqn9iL1kNM8VEsrQdT1lr9/p1tuQ1ZsBotq4ywvhPEp+ipWvIkk6Y4N1OqVs3Q6aP
 +DLW9IXGv8nJXMuuJ6OfAhGcbx6SSsaeguN1p0jxQ5T95+9481XTXRLxwLzeR76ULen7
 QCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706260924; x=1706865724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LOFbW62w3tv4jdBTBkUcmlzT27cLcZqEK+XHK1j4x+U=;
 b=HxTl+/JtjH4gkBOfhyWvTeDGLzqfFYCvFGt/V2BTYvHX4A69RJhU/3PKLkk4cttihC
 mOEKA3kULc/4qOLo5eI63HAl1lufGt90YYmL0BdqLRR3fSOLp8OiSiYQ9xGi6LbTxooW
 Iuc6bJ1/+CWZBMwquLH3JgsGgtJCLb0XNZ5oOAL+ap95LCkmsenrEVPhTs271pRHV/v0
 gfFms6OxAgIiH6xNDD39pQPqz6R45ctR1GUaHKcj9UQGXxuD53eOu3l7MFO4s6rkHqE5
 vC/ssc63ASpq/fN7NnhQcIZ9c/aWgO2KlV0qua8SzK1BdnOMFlrU6RjegxUQrUtJ9k81
 coKQ==
X-Gm-Message-State: AOJu0YwxG8nwLfXx/AG3gptRiqKn+8Ai3cEvlBYwSZrGRI3L+m6p3VXp
 STNEMvF2/ccl4364k0QmlrbPD5T2y1Y+GkIKXxLrvd/z/AArm+tbPGCgwpjOR97qG+1m/sBytdA
 U
X-Google-Smtp-Source: AGHT+IEGkCJEzlNF23V1IHIVd7t3l2jyqc7WqeTOjat4WmnIU5CqRKWCVE04qdsShv/3bML6J4aZdA==
X-Received: by 2002:a05:600c:1553:b0:40e:d75f:e6cf with SMTP id
 f19-20020a05600c155300b0040ed75fe6cfmr255088wmg.319.1706260923828; 
 Fri, 26 Jan 2024 01:22:03 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c19d000b0040e4733aecbsm1262180wmq.15.2024.01.26.01.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 01:22:03 -0800 (PST)
Message-ID: <2520f5a2-b843-49e6-9eb7-1b18a94e5cba@linaro.org>
Date: Fri, 26 Jan 2024 13:21:59 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] TCG Plugin inline operation enhancement
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

A polite ping to request review on this series, especially for 
scoreboard [02/14] which is the main addition compared to v1.

On 1/18/24 07:23, Pierrick Bouvier wrote:
> This series adds a new thread-safe API to declare inline operation
> inside plugins. As well, it removes the existing non thread-safe API,
> and migrates all existing plugins to use it.
> 
> Tested on Linux (user, system) for i386, x86_64 and aarch64.
> 
> To give some context, this a long term series of work around plugins,
> with the goal to be able to do basic operations in a more performant and
> accurate way. This will mean to add more inline operations and
> conditional callbacks.
> 
> One final target of this work is to implement a plugin that implements
> the icount=auto feature, and allow QEMU to run at a given "frequency"
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
> Implement scoreboard API (cpu local storage), so plugins don't have to deal
> with how many cpus are used.
> 
> Since plugins have been modified again, I didn't transfer any reviewed-by on
> those commits.
> 
>   Branches:
>            base:  upstream/staging
>            topic: plugin_inline_per_vcpu
> 
>   Pierrick Bouvier (15):
>         [TO_REMOVE] commit support
>         plugins: implement inline operation relative to cpu_index
>         plugins: scoreboard API
>         docs/devel: plugins can trigger a tb flush
>         plugins: add inline operation per vcpu
>         tests/plugin: add test plugin for inline operations
>         tests/plugin/mem: migrate to new per_vcpu API
>         tests/plugin/insn: migrate to new per_vcpu API
>         tests/plugin/bb: migrate to new per_vcpu API
>         contrib/plugins/hotblocks: migrate to new per_vcpu API
>         contrib/plugins/howvec: migrate to new per_vcpu API
>         plugins: remove non per_vcpu inline operation from API
>         plugins: register inline op with a qemu_plugin_u64_t
>         MAINTAINERS: Add myself as reviewer for TCG Plugins
>         contrib/plugins/execlog: fix new warnings
> 
>    .gitignore                      |   1 +
>    Dockerfile                      |  23 +++++
>    MAINTAINERS                     |   1 +
>    accel/tcg/plugin-gen.c          |  64 +++++++++++---
>    build.sh                        |  18 ++++
>    contrib/plugins/execlog.c       |   6 +-
>    contrib/plugins/hotblocks.c     |  46 +++++-----
>    contrib/plugins/howvec.c        |  50 +++++++----
>    docs/devel/multi-thread-tcg.rst |   1 +
>    include/qemu/plugin.h           |   9 ++
>    include/qemu/qemu-plugin.h      | 135 ++++++++++++++++++++++-------
>    mt.cpp                          |  44 ++++++++++
>    plugins/api.c                   |  74 ++++++++++++----
>    plugins/core.c                  | 112 +++++++++++++++++++++++--
>    plugins/plugin.h                |  13 ++-
>    plugins/qemu-plugins.symbols    |   9 ++
>    run.sh                          |  22 +++++
>    test.sh                         |  34 ++++++++
>    tests/plugin/bb.c               |  63 ++++++--------
>    tests/plugin/inline.c           | 182 ++++++++++++++++++++++++++++++++++++++++
>    tests/plugin/insn.c             | 106 +++++++++++------------
>    tests/plugin/mem.c              |  39 +++++----
>    tests/plugin/meson.build        |   2 +-
>    23 files changed, 846 insertions(+), 208 deletions(-)
> 
> Pierrick Bouvier (14):
>    plugins: implement inline operation relative to cpu_index
>    plugins: scoreboard API
>    docs/devel: plugins can trigger a tb flush
>    plugins: add inline operation per vcpu
>    tests/plugin: add test plugin for inline operations
>    tests/plugin/mem: migrate to new per_vcpu API
>    tests/plugin/insn: migrate to new per_vcpu API
>    tests/plugin/bb: migrate to new per_vcpu API
>    contrib/plugins/hotblocks: migrate to new per_vcpu API
>    contrib/plugins/howvec: migrate to new per_vcpu API
>    plugins: remove non per_vcpu inline operation from API
>    plugins: register inline op with a qemu_plugin_u64_t
>    MAINTAINERS: Add myself as reviewer for TCG Plugins
>    contrib/plugins/execlog: fix new warnings
> 
>   MAINTAINERS                     |   1 +
>   accel/tcg/plugin-gen.c          |  64 +++++++++--
>   contrib/plugins/execlog.c       |   6 +-
>   contrib/plugins/hotblocks.c     |  46 ++++----
>   contrib/plugins/howvec.c        |  50 ++++++---
>   docs/devel/multi-thread-tcg.rst |   1 +
>   include/qemu/plugin.h           |   9 ++
>   include/qemu/qemu-plugin.h      | 135 ++++++++++++++++++-----
>   plugins/api.c                   |  74 ++++++++++---
>   plugins/core.c                  | 112 +++++++++++++++++++-
>   plugins/plugin.h                |  13 ++-
>   plugins/qemu-plugins.symbols    |   9 ++
>   tests/plugin/bb.c               |  63 +++++------
>   tests/plugin/inline.c           | 182 ++++++++++++++++++++++++++++++++
>   tests/plugin/insn.c             | 106 +++++++++----------
>   tests/plugin/mem.c              |  39 ++++---
>   tests/plugin/meson.build        |   2 +-
>   17 files changed, 704 insertions(+), 208 deletions(-)
>   create mode 100644 tests/plugin/inline.c
> 

