Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91B4D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 03:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t357r-0000z9-0z; Mon, 21 Oct 2024 23:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t357p-0000yb-BQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 23:00:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t357m-0005Sl-0H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:59:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20caccadbeeso56435185ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729565996; x=1730170796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UvJ7evOcun3UzoAlB9PcTSkMKLSQtABdVwPugHhjx4k=;
 b=XFcD+xIbRVGnOiVTjXiO+S3rhj6wB7llrPj5QhBPMhDCw2npinwMQkXddPu7YSEgFP
 BaPP6TAXyFoz1Tax8UoPIGw1gWYpEw2dRxdLK2T1r9Do5lyfVC8aQmza6K8tUa2kl73y
 5XkAPuto1NR9LAEjaYwSCz0lTDR1HUr6DuuPwPC3GaES9crEwB4oJ/zaIPXAfolo67z7
 /GWzSuK7PECrMmOE+qDrntfeLFksuDbnaUI0dcnKJTugrsFwv7CTlHgvB25CcqTpBAxq
 0+bxiXhjQM4QIkwTLgDJn1Wc9cpJfI1DAGiBX5xgeCb2jnzyNAKV6MeSk5dRqGshs/GV
 O8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729565996; x=1730170796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UvJ7evOcun3UzoAlB9PcTSkMKLSQtABdVwPugHhjx4k=;
 b=j9moWyCrpoE6aL+GnUghkiKlqjl1pkF8E1O4yfu89xKFM9gISsivY9NgBHB2Jd9fSs
 +ZDF48rtvNWAC0eVquJGSTGnZKDh4T40BHl3hDz6kxZYoXODe9UDzLCIeLVTlBTUam5e
 56eqJZH0Wp5kJA9KwhAK+OIixiKECBfb5j6VMGvAbZqLRq30tKl98+4RQ6LaxgNnyWJk
 HDiDVJqilXPhdtdhxF2qjTk2Y1au8qTNkhNn4t3H5cFyvXBaRbno7LXMvxbfBgyWJumI
 YMiyOjBKVammVJ+SiMmyjabe0ycD9qsg29FGHymlycUHpQtcivhjnMNK9dUTZD/SCtfq
 HiIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSNFhI30Qg6HzDRrbx0x0pK6RP+tPFmriiyyW03ZQns0iS7B3ujvA9fGsqa4HmVwCttSg+P8XoXY7L@nongnu.org
X-Gm-Message-State: AOJu0YyFQrRQaVUT9RLAOlBezbeMNBhaNVjkAgdvkiTQJhjIXwmDMtj2
 hYsMKhcbk0RLuB2GSBJGK/yp8a0nW6+lE2qH+eJCC4aGtY9U4hJ80sY+8Wf9zCU=
X-Google-Smtp-Source: AGHT+IHWPs2rbSpe1P+7OjeNbNlmud8Hd9+pLbBmpH/AkR9ne6GfmuU3C8u8h+kQabMisn0b10hMOw==
X-Received: by 2002:a17:903:2304:b0:207:1675:6709 with SMTP id
 d9443c01a7336-20e982a919bmr16616295ad.0.1729565995828; 
 Mon, 21 Oct 2024 19:59:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6cf9sm32915055ad.293.2024.10.21.19.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 19:59:55 -0700 (PDT)
Message-ID: <56b09f33-d176-4489-989a-ddf02329636f@linaro.org>
Date: Mon, 21 Oct 2024 19:59:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Replace -mpower8-vector with -mvsx
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Kewen Lin <linkw@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20241021142830.486149-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241021142830.486149-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/21/24 07:27, Ilya Leoshkevich wrote:
> [1] deprecated -mpower8-vector, resulting in:
> 
>      powerpc64-linux-gnu-gcc: warning: switch '-mpower8-vector' is no longer supported
>      qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error: expected ';' before 'float'
>          4 | typedef vector float vsx_float32_vec_t;
>            |               ^~~~~~
> 
> Similar to how this was done for the GCC testcases, replace
> -mpower8-vector with -mvsx.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109987
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/ppc64/Makefile.target | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
> index 1940886c737..d1b00d2bf09 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -6,7 +6,7 @@ VPATH += $(SRC_PATH)/tests/tcg/ppc64
>   
>   config-cc.mak: Makefile
>   	$(quiet-@)( \
> -	    $(call cc-option,-mpower8-vector,   CROSS_CC_HAS_POWER8_VECTOR); \
> +	    $(call cc-option,-mvsx,             CROSS_CC_HAS_VSX); \
>   	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak

I don't think this is quite right.
I think you need -mpower8 to get OPTION_MASK_P8_VECTOR set.

> +ifneq ($(CROSS_CC_HAS_VSX),)
>   PPC64_TESTS=bcdsub non_signalling_xscv

bcdsub is not in the base VSX instruction set, for instance.


r~

