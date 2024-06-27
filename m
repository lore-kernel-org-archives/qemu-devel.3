Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF8FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsn6-0005OR-3o; Thu, 27 Jun 2024 13:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMsn4-0005MZ-A8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:20:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMsmz-0003r9-9z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:20:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7066c9741b7so4053743b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508803; x=1720113603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bLvHBy8eQBMjMdzqqJMMqwAWeNUvQ9mKhw9ayUi7+q8=;
 b=Bf8vxeXExMvw8dy/NtfVQNoFXqKfLiWxfG3SU7TfiW1O0Q24H82I0tt9waRug6DQu+
 VlHXaaY7FM6alTlvj3FS8zR2DdwWhugvoAyYyoRqv1TQeCuLCAi5ppJ9HEdGGKnplW49
 buquYyng0YJnQlHePEr02sFje4AAjy41430aro121t1YH5qFgFRKIdBTnMoERJoAoinw
 ONb6EYdfz/l2eWaC308sRe0dys+G0MS3/RimumWYMDc72tv0sdqXtk2z4Ip/iVTazks3
 HjascRs+l3KG4vJaJz3O4oEeOsbmazvZ+7CDeCXvr5si4ufYAL9Cyga6u3PaA7UjpRiu
 w2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508803; x=1720113603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLvHBy8eQBMjMdzqqJMMqwAWeNUvQ9mKhw9ayUi7+q8=;
 b=nAmBlope8uvDNdaj8kEZsT3IeqAhmYg2NpAHcW433SuTkkRoKa3/CkCzD5x8a6ZPp+
 31CN/Wl6bB/Lukwy0SAip18Ma6o4iAR8KM1JIq4cWucc1CZHC56F+YPclYftIsi4Ny2E
 6q0r3KNcAE0JJtGG+erEoBhVNr/vyhFcNGqmnbzq8ZGhye5EvGXbQyb6qE8zdOg7kCM2
 HVOxv2yzpYJisgO9DcqEpfUnKf9zeAsGuilRZCBoWdI6rqs6dvmNLGCulvR8PAFV051v
 QbPNMe9nmOL9JnT47ARnTjFdqBbZ/rV1wqRsty6YyjMGlOZJQr+BADqdYWWgFQWvwG9s
 EPYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXafDqzHW4SHRU4RHKPYmlPaNhQG27A8DlAwnDH0x3mTW/IQ1FKhTFBgyYP8c7ZraU3Oh0hvjttOEcm7VIOEyFC55fgF20=
X-Gm-Message-State: AOJu0YybeX3dBhRQ5S0rTgD52VEgD24ZuG2IUvAYXyQC7BpGfo97pJuQ
 p9fJVKOyAPMvpTqWLzMrKcnTuzqKesUPg/nelAiIuRRsqJZBAebSfZ28EEMF6uE3CLxLWWkoQ1i
 z
X-Google-Smtp-Source: AGHT+IEWpQyA8BWoJmN6Gq3Kix7tDT/rqsSWxXvX7PUJYJPuBibZnRoScLB6YFH28wYmljm2xK7aiw==
X-Received: by 2002:a05:6a20:12c5:b0:1be:c5ab:7388 with SMTP id
 adf61e73a8af0-1bec5ab74ccmr5685803637.25.1719508802580; 
 Thu, 27 Jun 2024 10:20:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a3abd2sm1674956b3a.149.2024.06.27.10.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 10:20:02 -0700 (PDT)
Message-ID: <ee7713f2-a05e-4533-a070-97df934d7888@linaro.org>
Date: Thu, 27 Jun 2024 10:20:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv: Fix building on OpenBSD/riscv64
To: Brad Smith <brad@comstyle.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <ZnzqNlUbHG5Ue6L1@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZnzqNlUbHG5Ue6L1@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/26/24 21:27, Brad Smith wrote:
> tcg/riscv: Fix building on OpenBSD/riscv64
> 
> Use ucontext_t/struct sigcontext member name from machine/signal.h
> instead of Linux specific name.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 5 +++++
>   1 file changed, 5 insertions(+)

Thanks.  I'm going to clean all of this up into util/cpuinfo-riscv.c, similar to other 
hosts, and I will include this.


r~

> 
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 639363039b..aeae9a8ad8 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2116,7 +2116,12 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
>   {
>       /* Skip the faulty instruction */
>       ucontext_t *uc = (ucontext_t *)data;
> +
> +#ifdef __OpenBSD__
> +    uc->sc_sepc += 4;
> +#else
>       uc->uc_mcontext.__gregs[REG_PC] += 4;
> +#endif
>   
>       got_sigill = 1;
>   }


