Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E09EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rah8r-0001JA-LP; Thu, 15 Feb 2024 14:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rah8q-0001Ir-He
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:11:28 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rah8o-0001Gg-Pt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:11:28 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2909978624eso840372a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708024285; x=1708629085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFlCBzvtwCOVRNl3twRHbZHmzPTvnU4xWu2ISNExgbI=;
 b=bnBrX6ynMsXk0TJvS4N20Z0PiV1giC3CBmL+R5afZkR2vEPpBsP4FlD4p0J5WFAIrW
 rA+LA+aRJgyZm1hQPKgo2MKQXyis5x8jq+r0qM07jzCpzKXDuEx7Nz9bd1KMCrkmMVEk
 rvDOkHfy4KEC2c4iwlu0fQc8Gcp4tU74DZi2yV9i6AZcIv6OIAeeQ0E4EmeM9V7B6dJc
 hsyZZmlHOF5GdODVeatVMNn+zt1gsQgH9dvW6LtE8e/yLfLgYSPRFiYrEPSkrVuVq851
 ltZDifsv5qiCsfwzJzIqLGO+WBnUNuYsu5KkVTCfyPs49AWUZizCvN+bqn64S5pVddR+
 qWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708024285; x=1708629085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFlCBzvtwCOVRNl3twRHbZHmzPTvnU4xWu2ISNExgbI=;
 b=PlSK3g94uAFhn/9tloo0yVhdnltKfNDdx5ryOMSte24PeEbq+FRybnpLPq6/AuZCl5
 nIyhgMQY/QFfoGB8TbKaojIFJT3DhvRzDWobSZO9Zu4HoUbuq3vTUSKp6tfatEoY7n1J
 UBdNr08MFreN3w/oxPnEMadQbdByrSsol1lmjtPze0jnDgyhja3ntIzd8HK0WOBO2ZOV
 aCkr6y2xQ1ZsQYc4HrsQ6Lrkovw8nH9F1TWC+nTiTAw4EhKvX712XXkyaAs3t3OlX/iE
 V50hWAagIMxXYtNnB6PRB/2nl2yJ4ePDW/T75SauD4fu4oRfbvZWItyXc0WJSiIhwq04
 Bphw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9tadBMV0oGpx3uIb586q7aQbElsEv+lor1N3d9mRqmABolIOzIlNMklgZHX+VNGrwHLWaWN8kwu/XQPaLoa9lNWa5YhQ=
X-Gm-Message-State: AOJu0YzA89uuKfInSRoQq4QPMkYyoJXCkBB9z2JkRDk6WOFg09Sil5Ca
 qSpoPjUepxhc20oNByTyoK79sGSZ6Uood6+qwFYHA1YZMBIOFh1prcxkAy4RRFg=
X-Google-Smtp-Source: AGHT+IFosHLOzk4ViGv8QCWH+Bff4Yl9/gs4yDNGIeyREt8jgtSy+1qwAXmMbaMwcgP0IxmxKFvbJA==
X-Received: by 2002:a17:90a:e617:b0:298:a03f:ecf7 with SMTP id
 j23-20020a17090ae61700b00298a03fecf7mr2987448pjy.38.1708024285145; 
 Thu, 15 Feb 2024 11:11:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 se14-20020a17090b518e00b002967bc2c852sm3769428pjb.43.2024.02.15.11.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 11:11:24 -0800 (PST)
Message-ID: <11c4cd99-67e1-4a50-94e6-aee3f0b55230@linaro.org>
Date: Thu, 15 Feb 2024 09:11:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/tcg: Set can_do_io at at start of lookup_tb_ptr
 helper
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/15/24 05:01, Jonathan Cameron wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> Peter posted this in the thread trying to fix x86 TCG handling
> of page tables in MMIO space (specifically emulated CXL interleaved memory)
> https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t
> 
> Peter, are you happy to give your SoB on this one?
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   accel/tcg/cpu-exec.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 977576ca14..52239a441f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>       uint64_t cs_base;
>       uint32_t flags, cflags;
>   
> +    /*
> +     * By definition we've just finished a TB, so I/O is OK.
> +     * Avoid the possibility of calling cpu_io_recompile() if
> +     * a page table walk triggered by tb_lookup() calling
> +     * probe_access_internal() happens to touch an MMIO device.
> +     * The next TB, if we chain to it, will clear the flag again.
> +     */
> +    cpu->neg.can_do_io = true;

Yes, this mirrors what is done in cpu_loop_exit(), and I can see how get_page_addr_code() 
and the ptw within would require can_do_io set properly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

