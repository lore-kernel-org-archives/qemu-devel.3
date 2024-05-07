Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30E9C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Fc9-0001PK-Fz; Tue, 07 May 2024 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Fc3-0001OG-9b
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:51:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Fbw-0004Rq-4U
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:51:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so2081178f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715068295; x=1715673095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VyukWpb9qzlz10FlZyVxwFP3uu1RZsm/+BJxgU39+Jo=;
 b=oBCsP8Vr7QGC0cN34RYGh2mBoLgfc7WdgD5Z6A4ezr8XkSc2xQU0knE2M+RuOv564K
 42J68DO7rgdOVh/Y9shVQ1TAcydIppJkEfLcJOHey+14vdki0EgYTHiHpebDozPV9dCN
 pRnIHRnlx2hWYa0kmjqiB5EHcYXytNDtnkwjQ1/954dlPY8dpBnujghD3KIZn5Q8QMn5
 BT6tJLqKovqiPmq/9bpOCVKops4QC/MpMZCkA5jFU/9aaFX+3iBwOMfU+JVtE+pUXkGN
 228cyeVgw8/drXkD1JJEr5FTLma47r3YBq/QVS6U3B24zG+5edeQQgjSEugozTZyJgvf
 67HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715068295; x=1715673095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VyukWpb9qzlz10FlZyVxwFP3uu1RZsm/+BJxgU39+Jo=;
 b=VfDb2u1bteLUvo55SY9IwRSoPe+HiRQpaUK0WFz/FxaTGZ62PQjYgvAMntrlCW/L7G
 Hbq70zo9ffX2zdVh4jl6m/4sG0c+s4gvkhX7vBKvXbxHze0VFYnrrTHONbRnWWdcxddN
 K+C4SxKz2bTbvoUsafSkY5cyxhMsKm0RTFoiZc8dyAC81u5dRyUILFoXejaKna0IU5ji
 h96NT8nQHXzu1XxMMPyqe913B3rthkaKPd9Wcit0dP59lqWjr/TW7gIuuMz6kewOriFT
 ELuCIGAT/8gaD5QdPVEzET2simPYoqMhUIxj91ORnIMa4vwXb1VuY2khit0PvaZM8uTy
 bGZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgj2EMV6+PGqNHMQ4WX1ukMjUCHKV+Xb1sQ/J5NqhAlznINFdPByhMOI1dnqcrVdYyAxUHg2kSjX53/Ayt+ALFvQjKotE=
X-Gm-Message-State: AOJu0YyXC00VCD/cVCW+g3r2/Bek80X0LOsuWpHtQAByP8GfVsRbg+OF
 XChu6tftHArEvQkAQfR+av1SD3/wfL8oSTXGVxIa7Ugdk3NUF5Y0xgaZlsrZhx0=
X-Google-Smtp-Source: AGHT+IFud+FgNWX2WakPWfUZnn7yBcVGvHmKJOiiN+Jv6rTn8FFI3/RH5X3zWH8CqaNfyKcClEXTrQ==
X-Received: by 2002:adf:f68c:0:b0:346:e590:1a0f with SMTP id
 v12-20020adff68c000000b00346e5901a0fmr10162468wrp.61.1715068295561; 
 Tue, 07 May 2024 00:51:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a5d544f000000b0034db8184b41sm12306037wrv.112.2024.05.07.00.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:51:35 -0700 (PDT)
Message-ID: <2db3a42b-8d90-44e9-b10a-cef05c91ceae@linaro.org>
Date: Tue, 7 May 2024 09:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: disable emulators that require it if libfdt
 is not found
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507071948.105022-1-pbonzini@redhat.com>
 <20240507071948.105022-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507071948.105022-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/5/24 09:19, Paolo Bonzini wrote:
> Since boards can express their dependency on libfdt and
> system/device_tree.c, only leave TARGET_NEED_FDT if the target has a
> hard dependency.
> 
> By default, unless --enable-libfdt is passed (in which case the
> dependency is mandatory, as usual for --enable-* options) or the
> target is mention in --target-list, those emulators will be skipped if
> libfdt is not present.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/targets/aarch64-softmmu.mak      |  1 +
>   configs/targets/arm-softmmu.mak          |  1 +
>   configs/targets/i386-softmmu.mak         |  1 -
>   configs/targets/loongarch64-softmmu.mak  |  1 +
>   configs/targets/microblaze-softmmu.mak   |  1 +
>   configs/targets/microblazeel-softmmu.mak |  1 +
>   configs/targets/mips64el-softmmu.mak     |  1 -
>   configs/targets/or1k-softmmu.mak         |  1 +
>   configs/targets/ppc-softmmu.mak          |  1 -
>   configs/targets/ppc64-softmmu.mak        |  1 +
>   configs/targets/riscv32-softmmu.mak      |  1 +
>   configs/targets/riscv64-softmmu.mak      |  1 +
>   configs/targets/rx-softmmu.mak           |  1 +
>   configs/targets/x86_64-softmmu.mak       |  1 -
>   meson.build                              | 14 ++++++++++----
>   .gitlab-ci.d/buildtest.yml               |  7 ++++---
>   16 files changed, 24 insertions(+), 11 deletions(-)


> -  if 'TARGET_NEED_FDT' in config_target
> -    fdt_required += target
> +  if 'TARGET_NEED_FDT' in config_target and not fdt.found()
> +    if default_targets
> +      warning('Disabling ' + target + 'due to missing libfdt')

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    else
> +      fdt_required += target
> +    endif
> +    continue
>     endif


