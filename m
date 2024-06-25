Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C4CC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 02:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLvtj-0002Dc-6N; Mon, 24 Jun 2024 22:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLvtf-0002Cn-W2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:27:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLvtd-0006q2-V1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:27:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4217990f8baso44204695e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719282420; x=1719887220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84RpPkQd2DBF7+TaxX2PqpYU8EwWFPMS3TNuYOVwLCk=;
 b=HnHqjuhh9t8r7CaoosJozdG2Nty9WCp/36ZUZ4pki4uixU+A+igbrE+sw6WCjD6j3f
 T+rZgQuugR21H0yJCIFFUeX6k/Obl5qsIO6Ax8Fn42biaMZ/tSDDLgyRseRdkHI9lI6s
 U411mv/WRxZ5a/E2FBQAMtm8AwNP/VG3eH3ZB5fDHkRYCW7yC9sN4Dt6k6YIr9AChJwX
 npmW8Y7cyoaKaPh66H2tX6fJ/5B1YzQhzgO6GNF3k0TrdzmiOaH2oqSrf/M6PIOI0fTc
 O74u0GnKZHeavh7MwCC/z+z7m6Pp9UMgOtdLOYIVmbt8Xj3XgB7K3VoxCSWAWlVfvYck
 5BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719282420; x=1719887220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84RpPkQd2DBF7+TaxX2PqpYU8EwWFPMS3TNuYOVwLCk=;
 b=vq6bN6EDoVSv+i+eybPS/vujke+i/tkFka9mZ3oawvMzM/qb8GhF6L6FDORqQbe5sh
 H446Eg0jCE7gfAI7Wl2mhNAcSb1G4rVR9pS5ygIQKzKg/TEEBDOvH6AFVKgkpedrwe6c
 QClwFWpfHi6Ks0dShQUKDaQGz+MJD4Y/qSy9JqN8TEoVVs7X412deAuPrLvqIVuOVNCm
 i1Q2uv/l5BmSMLGSVRcLsX/fFtZxa1v/cW6UWCERM2Ms7xN+gm/E3n0YrFrFGVmj+fhR
 RJvYkf/+kgw7/yqsQffzeXk4V9rVztZR0EoXC/6Z/Znlb68eqbr9XFxJWTjcpECF4Z4y
 ddOQ==
X-Gm-Message-State: AOJu0YzShs+a8J8nfQu4FNMt/Lq5cJMjlK/Y/C6n+eHBVhVogTOHjSB/
 xURQpI/RKhU8WZRBzX+UpAnG+cx33lquwvOFYuxHyRa9Y9kVVf5UTtO3Ign1iLs=
X-Google-Smtp-Source: AGHT+IGGHvbIQBpvDqWRLl9uZivqB0uv0qqv3rQ0bsHDEHjpH8bEtxcOyqbp/czbCuZymn5Om7Iswg==
X-Received: by 2002:a05:600c:4ab0:b0:421:7983:f1a8 with SMTP id
 5b1f17b1804b1-4248b9c9cdcmr54402685e9.32.1719282420102; 
 Mon, 24 Jun 2024 19:27:00 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54e4sm196303705e9.23.2024.06.24.19.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 19:26:59 -0700 (PDT)
Message-ID: <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
Date: Tue, 25 Jun 2024 04:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
To: Felix Wu <flwu@google.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Roman Kiryanov <rkir@google.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240624205647.112034-1-flwu@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624205647.112034-1-flwu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Felix,

On 24/6/24 22:56, Felix Wu wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> to use the QEMU headers with a C++ compiler.
> 
> Signed-off-by: Felix Wu <flwu@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   include/qemu/atomic.h   |  8 ++++++++
>   include/qemu/atomic.hpp | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
>   create mode 100644 include/qemu/atomic.hpp
> 
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index 99110abefb..aeaecc440a 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -20,6 +20,13 @@
>   /* Compiler barrier */
>   #define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
>   
> +#ifdef __cplusplus
> +
> +#ifndef typeof_strip_qual
> +#error Use the typeof_strip_qual(expr) definition from atomic.hpp on C++ builds.
> +#endif
> +
> +#else  /* __cpluplus */
>   /* The variable that receives the old value of an atomically-accessed
>    * variable must be non-qualified, because atomic builtins return values
>    * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
> @@ -61,6 +68,7 @@
>           __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
>           (unsigned short)1,                                                         \
>         (expr)+0))))))
> +#endif  /* __cpluplus */
>   
>   #ifndef __ATOMIC_RELAXED
>   #error "Expecting C11 atomic ops"
> diff --git a/include/qemu/atomic.hpp b/include/qemu/atomic.hpp
> new file mode 100644
> index 0000000000..5844e3d427
> --- /dev/null
> +++ b/include/qemu/atomic.hpp
> @@ -0,0 +1,38 @@
> +/*
> + * The C++ definition for typeof_strip_qual used in atomic.h.
> + *
> + * Copyright (C) 2024 Google, Inc.
> + *
> + * Author: Roman Kiryanov <rkir@google.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * See docs/devel/atomics.rst for discussion about the guarantees each
> + * atomic primitive is meant to provide.
> + */
> +
> +#ifndef QEMU_ATOMIC_HPP
> +#define QEMU_ATOMIC_HPP
> +
> +#include <type_traits>
> +
> +/* Match the integer promotion behavior of typeof_strip_qual, see atomic.h */
> +template <class T> struct typeof_strip_qual_cpp { using result = decltype(+T(0)); };
> +
> +template <> struct typeof_strip_qual_cpp<bool> { using result = bool; };
> +template <> struct typeof_strip_qual_cpp<signed char> { using result = signed char; };
> +template <> struct typeof_strip_qual_cpp<unsigned char> { using result = unsigned char; };
> +template <> struct typeof_strip_qual_cpp<signed short> { using result = signed short; };
> +template <> struct typeof_strip_qual_cpp<unsigned short> { using result = unsigned short; };
> +
> +#define typeof_strip_qual(expr) \
> +    typeof_strip_qual_cpp< \
> +        std::remove_cv< \
> +            std::remove_reference< \
> +                decltype(expr) \
> +            >::type \
> +        >::type \
> +    >::result
> +
> +#endif /* QEMU_ATOMIC_HPP */

As mentioned previously by Thomas, Daniel and Peter, mainstream QEMU
doesn't use C++ and isn't being built-tested for it. I'm not against
trying to keep the code C++ compatible, but I don't see the point of
adding C++ files in the code base. In particular this patch seems
contained well enough to be carried in forks were C++ _is_ used.

Regards,

Phil.

