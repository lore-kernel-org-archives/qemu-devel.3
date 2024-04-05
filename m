Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA6CC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 23:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssZg-0002zd-8n; Fri, 05 Apr 2024 19:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssZf-0002zV-Ae
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 19:02:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssZd-00006Q-OT
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 19:02:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e703e0e5deso2431443b3a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712358136; x=1712962936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9rzELCfan3uzfgWMqfwqu9UPBdZPEYmioyuzFl1McZc=;
 b=W/r1TpScDm01uDI6gq1JEkkDVGIfV3snquQWlddKDWDIw/1P0E2wnhTpxG+oGQBvhp
 ungXF0bySWSBLLPPkjEffNJBgo5plmHNG64dHjXTLhrIpJWxFgQjPMhi8D6xoxxRCx0A
 +ea/o2BCWwkgNQrKEOD8n4txFngHSd65jA3QsU+HJ6Tkx1OG0hDtfEgUh9dE28Pa27Gd
 WP+leFPDVVu0zlu3CbkobPqSLlqKLTkhe9EWzU4ymgpskrMgPEiWncgyZbnFM1smNjpp
 4STtbYis4+N5kkM5dy3yPE/6skD/WyNZX/DfZiIJl0OxG7uZSmAJ/ru53dUg63gwlAAW
 u2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712358136; x=1712962936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rzELCfan3uzfgWMqfwqu9UPBdZPEYmioyuzFl1McZc=;
 b=hBpSeCl0yhNZ0IBOk0F9LHgNPJwwNc/BVr1wbom77Bh0ERb/hUkWP0SUbyi6RIIjcD
 wXNm8mPznE9tky4wwFrtomQluBwpL8b4RUadNY9ct6ctg+/csWwkCYwiQHxL/j8WI848
 nWOpp/qUOCEU3D3DV6F0WvEQyI0YiYJTHj0BSaoZkcya1DIJFCv6cDn0bIKi85+9knlQ
 mWEyB0FApnOh+xO1KxqIhJHNnChksdcBxSL5SV5WxDSxS1Vc4kghndXA/bVKxsnDM9jP
 P/kr2+uVjwVu7luFPBAfUt5GOx3SCottEzHeQz7WXgZodCwAa32PMCzkLLAT4DyjTroc
 rDPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgRVjsrrEL4OQCLFjpOio+ljCBn/Mx+u3V+Lzf/GganCp5W9f2WlDIvmbaDP0k90Bsyak+toa2/2QluiRfTJRyHn4N32E=
X-Gm-Message-State: AOJu0Yxd49IwBh4czXeo8HPE+FPOcntf43TzocIYweadpRILBR2KX06n
 26NJw+3QZNsW5L66mgaQB4p0Zu9mchmF84JoI8NzZ0Y5FK48+uM5AL76eUlFnwfwsMw3ukescx5
 N
X-Google-Smtp-Source: AGHT+IH1Cp44idzOEWq1VWM+ZtcyWq1g3VwAMKRlPWnUwWheDIAfSde7Q7pgc+ipquEJslnIfY1v2A==
X-Received: by 2002:a05:6a21:1f1b:b0:1a3:3260:754f with SMTP id
 ry27-20020a056a211f1b00b001a33260754fmr3006355pzb.28.1712358135975; 
 Fri, 05 Apr 2024 16:02:15 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a17090ac30600b0029b2e5bc1b9sm3856222pjt.23.2024.04.05.16.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 16:02:15 -0700 (PDT)
Message-ID: <48494079-af1c-419d-88a9-bc38ab18c346@linaro.org>
Date: Fri, 5 Apr 2024 13:02:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh4: mac.l: implement saturation arithmetic logic
To: Zack Buhman <zack@buhman.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
 <20240404162641.27528-2-zack@buhman.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240404162641.27528-2-zack@buhman.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/4/24 06:26, Zack Buhman wrote:
> The saturation arithmetic logic in helper_macl is not correct.
> 
> I tested and verified this behavior on a SH7091, the general pattern
> is a code sequence such as:
> 
> 	sets
> 
> 	mov.l _mach,r2
> 	lds r2,mach
> 	mov.l _macl,r2
> 	lds r2,macl
> 
> 	mova _n,r0
> 	mov r0,r1
> 	mova _m,r0
> 	mac.l @r0+,@r1+
> 
>      _mach: .long 0x00007fff
>      _macl: .long 0x12345678
>      _m:    .long 0x7fffffff
>      _n:    .long 0x7fffffff
> 
> Test case 0: (no int64_t overflow)
>    given; prior to saturation mac.l:
>      mach = 0x00007fff macl = 0x12345678
>      @r0  = 0x7fffffff @r1  = 0x7fffffff
> 
>    expected saturation mac.l result:
>      mach = 0x00007fff macl = 0xffffffff
> 
>    qemu saturation mac.l result (prior to this commit):
>      mach = 0x00007ffe macl = 0x12345678
> 
> Test case 1: (no int64_t overflow)
>    given; prior to saturation mac.l:
>      mach = 0xffff8000 macl = 0x00000000
>      @r0  = 0xffffffff @r1  = 0x00000001
> 
>    expected saturation mac.l result:
>      mach = 0xffff8000 macl = 0x00000000
> 
>    qemu saturation mac.l result (prior to this commit):
>      mach = 0xffff7fff macl = 0xffffffff
> 
> Test case 2: (int64_t addition overflow)
>    given; prior to saturation mac.l:
>      mach = 0x80000000 macl = 0x00000000
>      @r0  = 0xffffffff @r1  = 0x00000001
> 
>    expected saturation mac.l result:
>      mach = 0xffff8000 macl = 0x00000000
> 
>    qemu saturation mac.l result (prior to this commit):
>      mach = 0xffff7fff macl = 0xffffffff
> 
> Test case 3: (int64_t addition overflow)
>    given; prior to saturation mac.l:
>      mach = 0x7fffffff macl = 0x00000000
>      @r0 = 0x7fffffff @r1 = 0x7fffffff
> 
>    expected saturation mac.l result:
>      mach = 0x00007fff macl = 0xffffffff
> 
>    qemu saturation mac.l result (prior to this commit):
>      mach = 0xfffffffe macl = 0x00000001
> 
> All of the above also matches the description of MAC.L as documented
> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
> ---
>   target/sh4/op_helper.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)

Queued, thanks.


r~


