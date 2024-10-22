Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC01D1714E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t342m-0006Nm-5n; Mon, 21 Oct 2024 21:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t342k-0006NP-HS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:50:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t342i-0007co-LM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:50:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cbcd71012so45608885ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729561839; x=1730166639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ICHoqii9beIZTgsHAZZT9OWIgi0BZQQkAHxT10gQEyU=;
 b=iR06e9itb37M5lSEBUCxs575vG1/vNOib1OXaKEaFZX2PuYhmH0whIuOR31LONqOUZ
 PifMhJ4AANHvW1zy0YIvxokzSkHI/Gu8QNRkvgkSffcojjUHbKI5WTGyVNdNH6iIcmxf
 LNWHMA2JUp+mlOIwELdJbuLw+LHWNcQaSchb7BgT6LYW67/LOMVHjmgKZBfyOuogdQ3H
 ZZF3c/AVevBMNGyGPe5ogk1vJKRU8BUNE1Tsn/SzZuSdZBzKzmmwTI0dJ+1wmk/CMgSA
 1fQ7ZBafoNgp8s/M/DwgFbsgsu4Q4jygQAdiWr1WxqA27Fel0pn8W7tAlzbHZDKo9spR
 ywXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729561839; x=1730166639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ICHoqii9beIZTgsHAZZT9OWIgi0BZQQkAHxT10gQEyU=;
 b=pzV4m4SxrgAtIb7GFzqfs4vh2qCfAlXZ5hGfTpankR7PTFosWwzdumseuMQZ+tIXSv
 iQTg4K1yHjtoIumRSlqD59XdtaOn7tgAemXX1fI/ZDMzToHuWpYyVVICcRt3FH9+U4Te
 uhv/TsSWsWhDWSJvR+bEgHlop+iTEoICOG7NGA/Uk5SFCElQt0jm/WFqV/5Nhvkg8stT
 9sbmNbkQQFJQk0U5jsBjjZjLPvUhA/twka/PfPrjP+krIZcUJAsER2b2yX6VWZdXDI74
 r2N10UwNHkrvN9vTpf+wKdd5O2ywfRhpdp2ypwc2+ffe3hrtU+26+R6+l9BGj5lzJPh4
 nwjA==
X-Gm-Message-State: AOJu0Yz4SniD7L3PMxG6kpqyVfkWJ+H986HvbRvf0RPbW6l+7M9VQmmD
 z2c/TGCg+B7mc2M+ZwutjZxMVir1aj2cX/T1+AtUlOQkhnDZ2ano80xeMpG/85fSKkVtJ+lMlh+
 0
X-Google-Smtp-Source: AGHT+IGMjKgo5CtqTANWhI1fmaugNB6leqYi8Ez7tHR2xQOlqRUUgAUOZefL4JAQWEVE6t6JWX8FkQ==
X-Received: by 2002:a17:903:2346:b0:20c:a498:1e4d with SMTP id
 d9443c01a7336-20e5a9509c0mr149124045ad.60.1729561839096; 
 Mon, 21 Oct 2024 18:50:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd550sm32448215ad.169.2024.10.21.18.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 18:50:38 -0700 (PDT)
Message-ID: <94e56b07-1f4d-4c43-9239-795ed060016d@linaro.org>
Date: Mon, 21 Oct 2024 18:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Trace rt_sigprocmask's sigsets
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20241017091449.443799-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017091449.443799-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/17/24 02:14, Ilya Leoshkevich wrote:
> @@ -3312,10 +3358,26 @@ print_rt_sigprocmask(CPUArchState *cpu_env, const struct syscallname *name,
>       case TARGET_SIG_SETMASK: how = "SIG_SETMASK"; break;
>       }
>       qemu_log("%s,", how);
> -    print_pointer(arg1, 0);
> -    print_pointer(arg2, 0);
> +    print_target_sigset_t(arg1, arg3, 0);
> +}
> +
> +static void
> +print_rt_sigprocmask_ret(CPUArchState *cpu_env, const struct syscallname *name,
> +                         abi_long ret, abi_long arg0, abi_long arg1,
> +                         abi_long arg2, abi_long arg3, abi_long arg4,
> +                         abi_long arg5)
> +{
> +    if (is_error(ret)) {
> +        print_pointer(arg2, 0);
> +    } else {
> +        print_target_sigset_t(arg2, arg3, 0);
> +    }
>       print_raw_param("%u", arg3, 1);
>       print_syscall_epilogue(name);

I'm not keen on splitting operands across syscall completion.
There are a few existing syscalls for which we print such results afterward:

   clock_gettime
   clock_getres
   wait4
   waitpid

but we're certainly not consistent about it.


r~

