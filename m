Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A61C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv2FU-0005eC-Vi; Thu, 11 Apr 2024 17:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2FM-0005dL-RQ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:46:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2FK-0005lp-TR
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:46:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed2dbf3c92so237951b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712871973; x=1713476773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpxrA8cRe/B7k0FRnDEX/5CDR+EgATsgI9uZLnSVd4c=;
 b=qo6C2kgSBnOTL1PsfGSPeyD2ZyrlVP54H1QYFfr5epBF5i+hfgOtW+KpdH1R3Pkdbx
 +qLta/4NlcZwfNUq2OdUL/m72IxJAR8fqvWssq/g78m6zxpLn7NvIa1cuCry6pMrwm1S
 7ELBgHMDgTax1zObI196bzDAzakxczlJJIWPq78vMmtvoaOm2vylQG1b2JCHJBtguIwQ
 6SxpJgxoafBKvRf787cliLSBOLPAcYRWSf7p+Z7nLc0V3enKxLMJ4Z4q/447pA+wHRj4
 WHjxJRs8YIFYygpMyzXj50JmE/KQ9hQjiLzbxghXmF8RrRf/tEZAW/ab4F/qAIzldXnz
 cKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712871973; x=1713476773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpxrA8cRe/B7k0FRnDEX/5CDR+EgATsgI9uZLnSVd4c=;
 b=mfU31WrqWRgvRK9XeiGxv9zZBrKt+EvaMaz7ASfthMfnEHL+2XEWnJwDrVIA3BWd37
 LLKLF/F5kNyaovJDMqyzvsnXorTRlgBOjMtQbdhaneqMDQbTnFryX4gHwM1gn1p53DPl
 G7lqeAd79tBmn+zRqqqErX1ORmco6xAnp32zjU0JPfkQlKle2yJMxbub9z1oYdTAzPL2
 UwAm4dTjqFDweH3yQ4dhAA60fmkxjo+Rf9ke+FD2wBPfSdl55pCw+Dezq6mjKSuIFgfr
 mEH49JNp3iitgLPPHb5MVHfpiVgTPJYX8Vu+kPBfac0c+TbTzaE2FMFWIRniixahz6xZ
 QYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxZbHvuMlHwrVNBni3oDwIYjlQGhLcUQ0XPMp7mt5CO4rb+xBGuCqBNBM27/MTEdpOgeZDdogBnFTE84Llw/aRrycecLM=
X-Gm-Message-State: AOJu0Yx9+9tnXiHgRT9FQAR1HZZdrHOR4aVCygnmUGcLOVJocQNAyo2t
 VSzPGb1PhnmSj3HPeMxczvRVVUr6ZfWSULhWxDEiEA6T7F80854cYCQK7rYwNOM=
X-Google-Smtp-Source: AGHT+IEAmMBgzzxSBOQseK4jVdkR+ivU9lItBRBDfAd5s0LfjurNfasO7U9U2ClfQPiqVXdsc9ouUw==
X-Received: by 2002:a05:6a00:1915:b0:6e8:f708:4b09 with SMTP id
 y21-20020a056a00191500b006e8f7084b09mr1103194pfi.15.1712871973271; 
 Thu, 11 Apr 2024 14:46:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a62aa18000000b006eadfbdcc13sm1631776pff.67.2024.04.11.14.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:46:12 -0700 (PDT)
Message-ID: <5245b4a6-7246-456d-8be0-91fef19b8367@linaro.org>
Date: Thu, 11 Apr 2024 14:46:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/i386: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411104340.6617-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/11/24 03:43, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/kvm/kvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe9293..a46d1426bf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5335,7 +5335,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>       case KVM_EXIT_NOTIFY:
>           ctx_invalid = !!(run->notify.flags & KVM_NOTIFY_CONTEXT_INVALID);
>           state = KVM_STATE(current_accel());
> -        sprintf(str, "Encounter a notify exit with %svalid context in"
> +        snprintf(str, sizeof(str),
> +                     "Encounter a notify exit with %svalid context in"
>                        " guest. There can be possible misbehaves in guest."
>                        " Please have a look.", ctx_invalid ? "in" : "");
>           if (ctx_invalid ||

In the larger context,

>         if (ctx_invalid ||
>             state->notify_vmexit == NOTIFY_VMEXIT_OPTION_INTERNAL_ERROR) {
>             warn_report("KVM internal error: %s", str);
>             ret = -1;
>         } else {
>             warn_report_once("KVM: %s", str);
>             ret = 0;
>         }

so there's really no need to sprintf into a buffer at all -- just pass it all to 
warn_report_*.

The English text could use some improvement as well.  :-)


r~

