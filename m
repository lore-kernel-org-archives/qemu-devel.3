Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D322C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0PX-0004PH-Nn; Wed, 05 Jun 2024 19:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF0PW-0004P3-Rj
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:51:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF0PU-0000FA-Md
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:51:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7024cd9dd3dso289768b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717631475; x=1718236275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LerrnjzYQ1Rxikp6A6IA7nlrT1ML+Es19vtnFDisKuk=;
 b=v9ObHT6vpoKq8cLxQqqgC/jZF56h09I7XTVt/n5U5f1kIL8N/j2LqBlrWTSshW30Sy
 vTMiGvmnAJVPyaPUiIYSstjq5OR2GRoe43juk3oyUXTzdH7DLTM0nAlTkHHedsdDPm/k
 U1C5nA484uHobKXuvDSffzfpVFlqJThy720ZHYQNYUVFETpt9GL6Ephmauez6t5ZIc7W
 PFXBojgnXBgLAVdfd3beml+/lh+WK3h3TCHlRoB0nX8m96DRCo7jj2dJe5K+x4/xvbnL
 FMEHkxs3eBGLz+FG9fRjSAM+DleFSJQaX06eXRqbcNcFt5oQHyG4prqmIyZjcioQWQdc
 rlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631475; x=1718236275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LerrnjzYQ1Rxikp6A6IA7nlrT1ML+Es19vtnFDisKuk=;
 b=EX3NZhptpB1i3Goh5QaYGvYYUtS7agd+TXlU0J2iRPLrlP8ojiZN2/bM91kR5W7sJG
 PnqcY5oAwJSeAmOhcgVotNzadtvRNCSyGhJrZO94VEN6CP41NCtDuQlIovaw+XLmA+Ct
 HKq+UHw53LRV5T08v63uwDZ3B2KqpBozEwQId5UcV2gNViyncsuDPW/Jc56hooDIV2Q4
 XgQT8PEbBiqc+LVUh+NB8VPYHMHjYiEQfpek++2jeBhKyPqLwxU2RGpMWxtt2V37CX3J
 5SCShiL3DN575CgPH9Bu28FqbflUJn9oeMR02Jb5xmqKVdEdKiFCJYNvzzznlaX8WxUl
 KmpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUrARzZ7xCoKO2BcVXmC/1mVDciv7bGivUhJph07HQ/C+aiWZo6Cg1avu0oXIABmp29hJWZLweN+/PBxwie+9RTM05OAg=
X-Gm-Message-State: AOJu0YwWtUYZTR9nzz26PaYLbPHdhpot2sRLULAxKbaK0bNI1BqLQp1b
 Pifl/ky1bCr3oCwQy1CrYcUdgiHEVv4ydve+FTJoSpDzo3wDgoEP0RObkwUI+/k=
X-Google-Smtp-Source: AGHT+IG39IUwlNERvtwYnOSWY/XFLo1ZQsEVd2yIWPJQoKougX1RvGrfQQJJ0McEnPwJdYI7BqvQXw==
X-Received: by 2002:a05:6a00:9084:b0:702:7bfa:344c with SMTP id
 d2e1a72fcca58-703e599dc66mr4699253b3a.13.1717631474695; 
 Wed, 05 Jun 2024 16:51:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd3954f2sm61134b3a.51.2024.06.05.16.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 16:51:14 -0700 (PDT)
Message-ID: <5d78d82d-a939-4103-8411-507b1a0372ac@linaro.org>
Date: Wed, 5 Jun 2024 16:51:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] util/bufferiszero: Add simd acceleration for
 loongarch64
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-3-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240605093213.2191929-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/5/24 02:32, Bibo Mao wrote:
> Different gcc versions have different features, macro CONFIG_LSX_OPT
> and CONFIG_LASX_OPT is added here to detect whether gcc supports
> built-in lsx/lasx macro.
> 
> Function buffer_zero_lsx() is added for 128bit simd fpu optimization,
> and function buffer_zero_lasx() is for 256bit simd fpu optimization.
> 
> Loongarch gcc built-in lsx/lasx macro can be used only when compiler
> option -mlsx/-mlasx is added, and there is no separate compiler option
> for function only. So it is only in effect when qemu is compiled with
> parameter --extra-cflags="-mlasx"
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   meson.build         |  11 +++++
>   util/bufferiszero.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 114 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 6386607144..29bc362d7a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2855,6 +2855,17 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
>       void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
>     '''))
>   
> +# For Loongarch64, detect if LSX/LASX are available.
> + config_host_data.set('CONFIG_LSX_OPT', cc.compiles('''
> +    #include "lsxintrin.h"
> +    int foo(__m128i v) { return __lsx_bz_v(v); }
> +  '''))
> +
> +config_host_data.set('CONFIG_LASX_OPT', cc.compiles('''
> +    #include "lasxintrin.h"
> +    int foo(__m256i v) { return __lasx_xbz_v(v); }
> +  '''))

Both of these are introduced by gcc 14 and llvm 18, so I'm not certain of the utility of 
separate tests.  We might simplify this with

   config_host_data.set('CONFIG_LSX_LASX_INTRIN_H',
     cc.has_header('lsxintrin.h') && cc.has_header('lasxintrin.h'))


As you say, these headers require vector instructions to be enabled at compile-time rather 
than detecting them at runtime.  This is a point where the compilers could be improved to 
support __attribute__((target("xyz"))) and the builtins with that.  The i386 port does 
this, for instance.

In the meantime, it means that you don't need a runtime test.  Similar to aarch64 and the 
use of __ARM_NEON as a compile-time test for simd support.  Perhaps

#elif defined(CONFIG_LSX_LASX_INTRIN_H) && \
       (defined(__loongarch_sx) || defined(__loongarch_asx))
# ifdef __loongarch_sx
   ...
# endif
# ifdef __loongarch_asx
   ...
# endif


The actual code is perfectly fine, of course, since it follows the pattern from the 
others.  How much improvement do you see from bufferiszero-bench?


r~

