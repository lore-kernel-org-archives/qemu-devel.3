Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496EBC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cbK-0006vf-2I; Wed, 08 May 2024 04:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cbF-0006tY-G6
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:24:30 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cbD-0006jC-He
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:24:29 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59c04839caso907219666b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715156666; x=1715761466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yl5hIj6vBCK/p+07Txe/wPj4BqtPWMt/+4YpxXKscEU=;
 b=URb+DPSOoW23Rj9RKSSZvND29z8pbwrxOHeCcQUDpeyo3+JvtrkfPXX5XHY8FA6lkJ
 O8bJHFG62nKTdDRVQiW1evK9/QSLMZevJHM7g5+nwBhMwx6MlYlMk3ovYic7NNRhLIfV
 NM+PQM461fd74d471/JGx0gx3EQ+C2ozC1y6FbIiG13UCMT6X2DXBJIlHUuD+936kbMr
 0iawRnES3LSAxY5mb31Iu+x9f2xVbCUY4XzwCtyDC++wrBw4gwK30ILIK6xn0BTFOzO2
 OgL4YAdWtJJj0fSq8AS9IkmmgZLdva78Qo5RCKRs3vFtVBv/79DviU0C+eudbJyHYnxu
 gUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715156666; x=1715761466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yl5hIj6vBCK/p+07Txe/wPj4BqtPWMt/+4YpxXKscEU=;
 b=FTtJVuby+hU1V17EXe+a64xZfwLMt+pxN18RB/tIzfQyxinh48EC9AzSDqEU0xTfnE
 Javi801d1Xc+bTwqZQLE++demCpSJa6NOsQSwQZ4UB38YvjC4NGKJ5Udm+ZkF7UCDK9Z
 B7awOLIvahq8PZu1zxWHBWRX2bv32iOo18dTdVFbqV+KyELf2x0HW/82xlQ1nDT8Fb+z
 z8rHoRg3ViLq/QPjQBAreNon58HH4axl+FZmtkg5lc2t8ugp0OX+TS/y6fQf8SKjPaNE
 sIEGItKYytcdVdS3XvdHpnikBX+/6InT/g0WqObo8lzdFCzDV6FR8Kaav9E+76K7xJxH
 NX3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ekl2fr3A1zzRuGbHuE0dEsD7xlX4kxddeHOo7GyXQWDerk6rn0fJWqxs7rQnW1WNV1jtrtDfuF+tppJXtYo8Uw0dFIU=
X-Gm-Message-State: AOJu0YzLW9bDVyxI0c8DQkmtAR880Rh3x4Ftx1Yw2ERp93bgadsd8EMq
 oIU+qz2taWpwookgR8pOlzw/QRX/NrvIUSw7XrSldP5gyZiHvzLpTYEfK1w/EdMDcCWv4/GorRy
 u
X-Google-Smtp-Source: AGHT+IGcw5s45t+TGpeDHC9BfhbHJ35JXmZ6QxdQF2/RqDlfxdfXwqw21opgkJZyQk6KBBpXLT/71A==
X-Received: by 2002:a17:906:e942:b0:a59:ce90:27ea with SMTP id
 a640c23a62f3a-a59fb941db7mr97614266b.24.1715156665913; 
 Wed, 08 May 2024 01:24:25 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 mb15-20020a170906eb0f00b00a59cc6d06f2sm3641578ejb.218.2024.05.08.01.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:24:25 -0700 (PDT)
Message-ID: <67c7f49f-cc1a-40d4-8b30-63d6b3408a1a@linaro.org>
Date: Wed, 8 May 2024 10:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: pick libfdt from common_ss when building
 target-specific files
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508075105.15510-1-pbonzini@redhat.com>
 <20240508075105.15510-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508075105.15510-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 8/5/24 09:51, Paolo Bonzini wrote:
> Avoid having to list dependencies such as libfdt twice, both on common_ss
> and specific_ss.  Instead, just take all the dependencies in common_ss
> and allow the target-specific libqemu-*.fa library to use them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build              | 14 +++++++++++---
>   hw/arm/meson.build       |  2 +-
>   hw/loongarch/meson.build |  2 +-
>   hw/mips/meson.build      |  2 +-
>   hw/openrisc/meson.build  |  4 ++--
>   hw/ppc/meson.build       |  4 +---
>   hw/riscv/meson.build     |  2 +-
>   7 files changed, 18 insertions(+), 12 deletions(-)


>     target_common = common_ss.apply(config_target, strict: false)
>     objects = common_all.extract_objects(target_common.sources())
> -  deps = target_common.dependencies()
> +  arch_deps += target_common.dependencies()
>   
>     target_specific = specific_ss.apply(config_target, strict: false)
>     arch_srcs += target_specific.sources()
>     arch_deps += target_specific.dependencies()
>   
> +  # allow using headers from the dependencies but do not include the sources,
> +  # because this emulator only needs those in "objects".  For external
> +  # dependencies, the full dependency is included below in the executable.
> +  lib_deps = []
> +  foreach dep : arch_deps
> +    lib_deps += dep.partial_dependency(compile_args: true, includes: true)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +  endforeach
> +
>     lib = static_library('qemu-' + target,
>                    sources: arch_srcs + genh,
> -                 dependencies: arch_deps,
> +                 dependencies: lib_deps,
>                    objects: objects,
>                    include_directories: target_inc,
>                    c_args: c_args,
> @@ -3924,7 +3932,7 @@ foreach target : target_dirs
>       emulator = executable(exe_name, exe['sources'],
>                  install: true,
>                  c_args: c_args,
> -               dependencies: arch_deps + deps + exe['dependencies'],
> +               dependencies: arch_deps + exe['dependencies'],

