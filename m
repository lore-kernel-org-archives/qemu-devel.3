Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8884C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 16:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLQ7E-0003RD-UR; Sun, 23 Jun 2024 12:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLQ7D-0003R3-9g
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 12:30:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLQ7B-0006MM-K6
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 12:30:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c7ecfc9e22so2441227a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719160250; x=1719765050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a2jnsvTvmDSabvV6yr8s15mB7EM1fJWOURwfeJiQrjE=;
 b=a9MQH/9pw5QlWaoR4Kklt7xZmRVpB0O98b/V+lytx1u58DcZRrikNLQrS6lFt+fHb/
 BGxBXjWQbcgV/ix2RWgTHfLBT2qmNIUVCfeNA1w30J4S1+sBD1p2KNIhBjtwD2Hy92Ps
 dHcnjMKcyGw+wUN0jaUnLMYQt8drZ1JuswFKfLVDGK5cVnyL8np2H6SpIQ34iac1kqui
 csq9RgcYL3xFhhWjCt27XEEwjLl69mwcaR0E114ZOYpUlxvc1yo4TxKLTyGWRbT3dXdO
 Rj03ySAQihn99FRIpUqRvP5PxC44WjOVftc/ur9sbGF16re/UlceGZ6x97AypOeFo5sL
 pEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719160250; x=1719765050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2jnsvTvmDSabvV6yr8s15mB7EM1fJWOURwfeJiQrjE=;
 b=XJPB4PdUkVVvMtw4ZDG4vZ//PtklMEUWG9EqD/j2Ah4HUZYLvq3rarQXpHB3Ny4OqE
 ZbAgIi1LbQuhQfyGbm2Gj2J02bemQVlY2MFfMQsPb57VPPAoNWlIBh3RL1XQ2xGI51HT
 2lJutYG4Vs4ljFLMTQbJrWjbkbV0huBem6+wCcFLYvZA0OoVVdxfYH46aVQhU6ojcgtB
 N9gpL901JxxQ/VLrAzBlOKAI3jZT+ZsA1LArOo9KKilROIc+AeOxhRd+VLtISL+K7C4V
 c65YSvs6XvDP4LSJjm36INoEMcTXu1bcvaYSTv61Mv6sflk4IVgB3AkTXNhutHZz6Jl7
 gaRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh1RAvTQX3Yc8OgZcJa414XJ18GdZ/HrOyU+zp7RkRecNoVOAK7h366EWpMb2iYBhKJXzvjMDgyL29QF2TFd+pei5HjbU=
X-Gm-Message-State: AOJu0YwYvNMRstW3o4dvbgybc8jkLC+JEizffNtWw9AiJ3gdn02lgUrb
 zLMr4gfcY6uIvnPwiPPwk78mnRjfdLtFlmQ+fYXTpGR8K66+C1exshagsMlmx/Q=
X-Google-Smtp-Source: AGHT+IHYLdr/A8Hjo+9fFmd9ZhrpNqI3SE32GnesrQFAqDA2HZEB3Ui0FPHrMpsP2ZmfX8ShaE9evg==
X-Received: by 2002:a17:903:32c1:b0:1fa:643:f437 with SMTP id
 d9443c01a7336-1fa23edc81amr24325665ad.25.1719160250225; 
 Sun, 23 Jun 2024 09:30:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb323641sm46904215ad.101.2024.06.23.09.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 09:30:49 -0700 (PDT)
Message-ID: <7db4406b-a4f6-4aa3-ab69-3dc2b0f4e0c3@linaro.org>
Date: Sun, 23 Jun 2024 09:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] Added CPU loop function
To: Warner Losh <imp@bsdimp.com>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org,
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>,
 Kyle Evans <kevans@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-3-itachis@FreeBSD.org>
 <3eed856e-51bf-4dd5-8665-60132adf01a3@linaro.org>
 <CANCZdfpQ0TmCU-9OAMkJo2_4UDFpRVVRPc5qzLgmo75wVXkQew@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfpQ0TmCU-9OAMkJo2_4UDFpRVVRPc5qzLgmo75wVXkQew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/22/24 11:49, Warner Losh wrote:
> 
> 
> On Mon, Jun 17, 2024 at 10:24 PM Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 6/17/24 11:57, Ajeet Singh wrote:
>      > +            /*
>      > +             * The carry bit is cleared for no error; set for error.
>      > +             * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
>      > +             */
>      > +            pstate = pstate_read(env);
>      > +            if (ret >= 0) {
>      > +                pstate &= ~PSTATE_C;
>      > +                env->xregs[0] = ret;
>      > +            } else if (ret == -TARGET_ERESTART) {
>      > +                env->pc -= 4;
>      > +                break;
>      > +            } else if (ret != -TARGET_EJUSTRETURN) {
>      > +                pstate |= PSTATE_C;
>      > +                env->xregs[0] = -ret;
>      > +            }
>      > +            pstate_write(env, pstate);
> 
>     No need for full pstate read/write:
> 
>           env->CF = {0,1};
> 
> 
> If I understand what you're suggesting, the quoted code can be replaced
> by the following, faster construct:
> 
>              /*
>               * The carry bit is cleared for no error; set for error.
>               * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
>               */
>              if (ret >= 0) {
>                  env->CF = 0;
>                  env->xregs[0] = ret;
>              } else if (ret == -TARGET_ERESTART) {
>                  env->pc -= 4;
>                  break;
>              } else if (ret != -TARGET_EJUSTRETURN) {
>                  env->CF = 1;
>                  env->xregs[0] = -ret;
>              }
>              break;
> 
> Is that what you're saying?

Yes.

> 
>      > +            break;
>      > +
>      > +        case EXCP_INTERRUPT:
>      > +            /* Just indicate that signals should be handle ASAP. */
>      > +            break;
>      > +
>      > +        case EXCP_UDEF:
>      > +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
>      > +            break;
>      > +
>      > +
>      > +        case EXCP_PREFETCH_ABORT:
>      > +        case EXCP_DATA_ABORT:
>      > +            /* We should only arrive here with EC in {DATAABORT, INSNABORT}. */
>      > +            ec = syn_get_ec(env->exception.syndrome);
> 
>     Nevermind about my question about syndrome.h vs patch 1.
> 
> 
> Ah, Since we have to re-roll this patch anyway, maybe moving it is a good idea?
> Honestly, I'm good either way.

Least effort is called for.  :-)


r~

