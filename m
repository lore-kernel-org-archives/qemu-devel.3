Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92CCD17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34j7-00039o-Jb; Mon, 21 Oct 2024 22:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34j6-00039M-LM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:34:28 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34j4-0003Mj-S2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:34:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so38135685ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729564464; x=1730169264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rKQcdRNGpdnsHkX541RiM+Fub1nh0YSApjfSuafCB5Y=;
 b=Pwyx5FBsGt5fD9UGKKQ+JZDH//I+DNsIW7Tj00XkQRHPRE9WrhWgcCxqSbKuEcH6iz
 XR9MSs7BlJ2CyqCbKaBHuIvPj+8gCcyA56jwImOWQdRQOnw88VLN/wJEPL2of81hAnl3
 g6CFabknsIHJP/oaWhmaF9Rqz3O8sDXL/Le8vci5ZiwSBzHo7w6eUHxBrpnZW4USTFzk
 uhcLpDf1/hYyi44uwq2nGuapo0RLCgGlclIMZ2KX22swcfkHOdmEYxPbAHxNj/0/mVMF
 buIHuZetWpyaukR3oAPTu+Ig+5kSCAGAHidkA4SLPkR3nWHvTYg8P/0wVsKKjT/YZ5mR
 9zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729564464; x=1730169264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKQcdRNGpdnsHkX541RiM+Fub1nh0YSApjfSuafCB5Y=;
 b=Le0x5Y0Tp19KXJjfcHi054FgTF1LypNPhHX0ivZvmENplO4ZZxZfbMHtSfFwGm8jHU
 tIrBjDeBYYCSnO8eBsSUhTmI+FiX+l4sVGpzVz35JnCk42rE12cmfWe53ouBTFGKOQll
 fWcFVcrwJkX40IFMSWhJc3trMPEiREAcCY+X2BuH03BoMwcArkJbMA49/pNJzI5LT+mD
 FoVyLKnMCk9wZ4aC+dVVE2Li1G1Nzc8X8vb6E7ThMzWakEvur1Q1YCjy5MSMlqwIXeIy
 mRbURCJLpmuaROpNaRT9kSojBk3WgKqjios3PqxGAch4ejLaGII+/0tgN8zEJJc2nDxu
 HSnQ==
X-Gm-Message-State: AOJu0Ywq7G6JuY8tEqbhEq9rUY2lwyUVaZvAHiH2xo+FGxzdM6EHhHlS
 TRvIQaCBCFVfm/qaMGhsBXcS5Bm7nFV5vw4Zdn/iwSEFVyeA2ykdnrq0sJRB25Y=
X-Google-Smtp-Source: AGHT+IFQsbOpcDZ+9FVwpzomsuu9A0rYtLmcbvdAxAul/Q4wAZrS9yyUrFT/ZtPqWLQ9fdtLvsZBVQ==
X-Received: by 2002:a17:903:22ce:b0:205:8763:6c2d with SMTP id
 d9443c01a7336-20e96ebde15mr20210425ad.9.1729564463982; 
 Mon, 21 Oct 2024 19:34:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0c0cc5sm32707585ad.125.2024.10.21.19.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 19:34:23 -0700 (PDT)
Message-ID: <38ff2ca7-7156-4ad8-b777-dab689043ecc@linaro.org>
Date: Mon, 21 Oct 2024 19:34:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
References: <20241021121820.483535-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241021121820.483535-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/21/24 05:17, Ilya Leoshkevich wrote:
> Running qemu-i386 on a system running with SELinux in enforcing mode
> fails with:
> 
>      qemu-i386: tests/tcg/i386-linux-user/sigreturn-sigmask: Unable to find a guest_base to satisfy all guest address mapping requirements
>        00000000-ffffffff
> 
> The reason is that main() determines mmap_min_addr from
> /proc/sys/vm/mmap_min_addr, but SELinux additionally defines
> CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K, but,
> in general, can be anything. There is no portable way to query its
> value: /boot/config, /proc/config and /proc/config.gz are distro- and
> environment-specific.
> 
> For maximum compatibility, probing is required. Use pgb_find_fallback()
> for this purpose. The downside of this approach is that mmap_min_addr
> remains incorrect, but there don't seem to be any practical
> consequences from this. If a correct mmap_min_addr will be required in
> the future, probing will need to be moved to linux-user main().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 4 ++++
>   1 file changed, 4 insertions(+)

This is

     https://gitlab.com/qemu-project/qemu/-/issues/2598

which we closed as a system configuration / kernel bug.

I'm open to working around the issue, because I can see it coming up again and again.

In pgb_find_fallback, we use a skip value of 4M or 4G, using that skip as the base at 
which to begin the search.  I think it might be better to use this as the initial start 
point in pgb_find_itree as well, rather than mmap_min_addr.

Since I never had a setup in which this triggered, would you be willing to test such a change?


r~

