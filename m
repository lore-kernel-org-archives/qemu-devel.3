Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EA7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNGq-0002rc-OM; Wed, 29 May 2024 13:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNGn-0002qU-59
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:39:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNGl-0001ms-70
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:39:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f480624d10so19144755ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717004362; x=1717609162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3mRJFYCOgifPjcVFgqf96jf2Wxa7QVuL9Ip8wM3hYc=;
 b=kB3MLGNXClETz6s+RyZoOkP/RO3Vgyl5RuXeEWUXST/Pgyjrh0M3zzaV+d99+EZDMP
 zgL7bbXVLwTqk9Rmgr8G/kDZLkdP0uSJ7TJpOvByi6VmAu68NFe45jtXduP2ILqBEKHA
 sAAiPmY7m9k7QGptQzQXlA2xuvRODLEA8GSosYCfGvEaZ8PV/3onwm5eiBETup/+xl69
 kTd8N5kbPtAX+D7ich/Ks9q27vWneRJsL4oBtDTlMLRXsJ8UZIga2ERT+5Km800fUDO2
 CIhwjNm3AjsNLi2Wxg/8idmTPc2QAUx/d6jltgjs7Qr76fJ/JoKvekIt6vp1Mt3jyfAB
 5DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717004362; x=1717609162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3mRJFYCOgifPjcVFgqf96jf2Wxa7QVuL9Ip8wM3hYc=;
 b=nRGj/8GSMGBA4kfBHDpP1AxgzqNLce6caNNw8IJGYOYbYHmFWzSBCMGXOR4jdEg5d2
 lsKEA6s09ymqfIO64/3GoXvTfveMsFqTz4JY9V5+FnYLBL+anj1dGw8j/erMHtkBAIYJ
 N9A6RRr1mD02PSjxcDpi66bkiGhcv6tJq1Nuge6vVCPJrev1ijkHO7d+ivjn2nETXYIT
 C29xQBoU67ao8TTgo3DSe254ZvMzCnm1umJVAeCJE0SdvFsnu/d/WYDu2P4a7+bkrIIS
 ROMSboVPhAUeqc6A+GQX650Qo++jLPV6r3tDfP7d2GfhIACeoXNCi/wEeC8t/uwFnC9I
 +WCw==
X-Gm-Message-State: AOJu0YwH4BOSLL+VyAQfuMOwRszzI2j8sIRR+mSV87N7pIH8yxNgVKGo
 xPa92qQoTKjWN5RU4IEZfrshKWGstuYHNHxeaBBGmtTEwxR3iTU0MGp3YsW3w/M=
X-Google-Smtp-Source: AGHT+IGKmafdXqfCoI65URztXlYpfXfVXy30BfcduyMEPfgcxpQXtPjZPlgCGUzKc3Jp0i9aaRRBgw==
X-Received: by 2002:a17:902:cecd:b0:1f3:35e8:d309 with SMTP id
 d9443c01a7336-1f4486d9f35mr175791625ad.20.1717004361644; 
 Wed, 29 May 2024 10:39:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c99461asm102177715ad.207.2024.05.29.10.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 10:39:21 -0700 (PDT)
Message-ID: <6ee29ed0-c893-4f16-8afb-55ff365b1f1e@linaro.org>
Date: Wed, 29 May 2024 10:39:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/67] target/arm: Reject incorrect operands to PLD,
 PLDW, PLI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-4-richard.henderson@linaro.org>
 <CAFEAcA89_nWDXhXKds3gezUyXdXfO61bMNgSn=em166ufgQAbQ@mail.gmail.com>
 <3f1baa61-c623-4b5b-b724-15bb68a2df3f@linaro.org>
 <CAFEAcA9ySeup4wE6BwtLYHi53PcktT1AME2Pg7CwgQsAJzb6WA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9ySeup4wE6BwtLYHi53PcktT1AME2Pg7CwgQsAJzb6WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/29/24 06:32, Peter Maydell wrote:
>> We do plenty of other treatments of UNPREDICTABLE as UNDEF (e.g. STREX).  Why is this case
>> any different?
> 
> It just seems like a lot of effort to go to. Sometimes we
> UNDEF for UNPREDICTABLEs, but quite often we say "the
> behaviour we get for free is fine, so no need to write
> extra code".
> 
> In this particular case, also:
>   * we'd need to go back and cross-check against older
>     architecture manuals and also look at whether M-profile
>     and A-profile are doing the same thing here
>   * the "v8 loosens the UNPREDICTABLE case for m = 13 T1
>     encoding" looks suspiciously to me like a "nobody ever
>     actually made this do anything except behave like the A1
>     encoding, so make T1 and A1 the same" kind of relaxation
> 
> Basically, it would take me probably 15+ minutes to review
> the changes against the various versions of the docs and
> I don't think it's worth the effort :-)

Fair enough.  I've sent a patch to update thumb.risu to avoid the problematic patterns.


r~


