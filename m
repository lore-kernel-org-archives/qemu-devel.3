Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533C5CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkbx-0004YT-EY; Fri, 01 May 2026 05:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkbw-0004Y8-25
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:56:40 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkbu-00018s-4s
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:56:39 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-364eef1891dso279537a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629396; x=1778234196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tB3VthALBBbMv7Vsm6N5vILQaffCn9uRmFV7g9muNn4=;
 b=mDvxdqFQIul55ER4GSRrvf4TKTl2Gf/Hxk5tNB2UVF25L0NyoQS/erqlIoSGGM2gKW
 lxz6IhJhWur1jxvvSCb7Y71Qb27QThpE5oWQ4JNtem78DW/nNVc5+Tgn89wYKry528O9
 RAKLW228kwU3iUv93+llXQfOvs/Ql0ikZhCHKOKmYagrTme3RYUDaTNxfgigO7+OG8TH
 eed4P5HRihjL9LXJnCgletN51nPbc8v/pz3TBHr0tAL7DvS1u2aVKRUQp6vr8OT0fQbB
 JJfkegiYYlZdjp0TRER5Os+/qBvOzbjOpGrjNKcW5+gURCC+vB6i2Ou+jvn6FpE7Cyq3
 tCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629396; x=1778234196;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tB3VthALBBbMv7Vsm6N5vILQaffCn9uRmFV7g9muNn4=;
 b=AaNmSMFAghQFKQnU1/VUY5+WtmcSJWvhjy47y0xmXg+MN8CX1O4kUm+RwJeHLcuuTG
 w9gA0jk4xRIFj0QiBlsZZqeSSsXBYpAsTzjuLRwKoHW+INnU6YhP3pQ1FQlv+XE+TWf6
 oT0Q38WAD1SmniCoLLhswsung4BAsVh/wZz8fz2XiHizugGyCHBMCDDL7mG9wpfePf4h
 WJLzr2lT8bMWKTYwFvQ17WGLcgVgAxahIeTOsQuLhxCexkiM0NX7q5OgUF21gGlX3EkZ
 HDFBe/zfpSmchKCwR67+XsWnUsgQAdgL37Cpx9IYIEpZk6k5htia/vdaSujuRUXPf3U0
 fWMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TSCslWTPxhK3dM9r1GG1Fp1tQMOBhKPy9RilzSRmZyOc/d3TTegkcSHLLNF8Yem8lkZGVFpx+zWbC@nongnu.org
X-Gm-Message-State: AOJu0YyimSOSkH/MKM5/u0aWeankFgzsDQ6aYwmBrpuuws0XQOjt2DaG
 /XUFtS5Wx6WVaLx2k+oiSOnoeNhHEy1KzddZSAx0xNrX5VBOFpg7V5FF1ilRHxq+4ss=
X-Gm-Gg: AeBDievSpxwJQfTa1xtCK9l/3oHodguNBZ0J5jCn822kWjGflXgpLarIZeSMKGi83YU
 FLsYZE3MB1ENZWX5v3gcjs6xG3sSH4lBCNllCiMOGACL5CZlYAc7SJZGFCVHR7ut4DAe1lE9dFk
 TrAOI2Xb8gfQoMZmqts7rs541vsWBkz2wcTtXr+KnuC3/2Mhz9Tnvb4IzWYeAfckEu9u3UFSSkJ
 lkfjFaaVJFO89ieHFj6P63V54yr4GmngrpUSSelzvflDjpFLUvAWPmsl3ari+kDkZL40x9e+BPY
 6N0g+W7tH89+KyBv6zbqzdsuD7gyrX8bo57PfsVrO+edCKijN6PjDGtjfFbGY9PV7++hWSoigRk
 GdtCSEmylQAafcT2qrxBh9uSqSVAaqTCRwctEmULUBKJnVWyvt1rwIu4Qtae9GvXVBztXMswar1
 rgNy4x6jCHT98UHmh81YIx+DpAlXTOr13XSVqndAL/3cMxkUsUYQ0v
X-Received: by 2002:a17:90b:17c2:b0:35a:cf:64a6 with SMTP id
 98e67ed59e1d1-364c3174d7amr6665139a91.23.1777629392395; 
 Fri, 01 May 2026 02:56:32 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ec00a280sm1895271a91.10.2026.05.01.02.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:56:31 -0700 (PDT)
Message-ID: <09b4afa7-4291-4652-8e61-3c4bd6aaf368@linaro.org>
Date: Fri, 1 May 2026 19:56:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/25] hw/core: Implement new cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/26 19:38, Peter Maydell wrote:
> In cpu_memory_rw_debug() we need to do a virtual-to-physical address
> translation for debug access.  Currently we assume that the
> translation is valid for an entire guest page, but this may not be
> true if the target implements some protection regions that have
> sub-page granularity. (Currently the only such target is the Arm
> CPUs when using an MPU, as in R-profile and M-profile.)
> 
> For TCG's emulated accesses, we handle sub-page granularity by the
> CPU filling in the lg_page_size field of the CPUTLBEntryFull struct
> to tell us how large the region covered by the result is.  But we
> didn't extend this to the debug-access code path, with the result
> that debug accesses might incorrectly fail because they are looking
> at the mapping for the address rounded down to a page boundary.
> 
> Provide a cpu_translate_for_debug() function which reports to the
> caller not just the physical address and attributes of the
> translation but also the lg_page_size for which it is valid.  The
> fallback implementation calls cpu_get_phys_addr_attrs_debug() and
> assumes target-page-sized validity.
> 
> NB: the "return true on valid access, false on failure" follows
> the same convention asTCGCPUOps::tlb_fill_align() (though it
> is the opposite of what we use in some other places, e.g.
> in target/arm's get_phys_addr_* functions).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-id:20260417173105.1648172-15-peter.maydell@linaro.org
> ---
> changes in v2: lg_page_size wants TARGET_PAGE_BITS, not TARGET_PAGE_SIZE
> ---
>   hw/core/cpu-system.c             | 32 ++++++++++++++++++++++++++++++++
>   include/hw/core/cpu.h            | 32 ++++++++++++++++++++++++++++++++
>   include/hw/core/sysemu-cpu-ops.h | 27 +++++++++++++++++++++++++--
>   3 files changed, 89 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

