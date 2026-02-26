Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1A9FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjlV-0006RH-62; Thu, 26 Feb 2026 17:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjlT-0006Qc-L9
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:23:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjlS-0006Cf-7c
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:23:23 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so12843975ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144600; x=1772749400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s32RK/RaZMhzo+fuHCxYzkYO6ZGUE/Ln6UxmgQe1cU8=;
 b=WHCcn3mGU+YKgTU8EU+/toQGuPrEDFZI5iYxJ7gvKi3Prc4igHNs9PShf/D99Yuogp
 tR10xfMgEiHjK/3uQTsaOSGFvf1uxa8p10qEZdp8I1U+mMKFwBPR8Fnb4q9kMZv9nPXU
 1fH7++ocPMYi/RuWnAU2R1eyXrxc2AZswjs9prR4iwKeUUVBiEuAFMdj24sQ32IJ4XYz
 N+7Hw5w+CymsDgXUxeuidQDCeuTToCKpZIFC1seQ2T8ksPGxXaejCZvWEQYx6W7pYUm2
 +qeldNs2rD//C/jNQV8D6x/SsQefl+uhPCTgD5qDUQZmPz5iyWKsIAZIHiuFA5h/ykMR
 Fwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144600; x=1772749400;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s32RK/RaZMhzo+fuHCxYzkYO6ZGUE/Ln6UxmgQe1cU8=;
 b=CH7dPfB6cr4ivXIGat5nXotBNkBBXm6ItSEGF+DxrOwqxUZF9KEFQvlFEZITl5m1SG
 CJJGMfSHnOBuUhVsZE03+GLcVblfF1Q62OdJ4gWzD85oUC6+yxDLE5/BpCUxK6W0rwB0
 FzpXT6CEIOL3jG+Mex+uE5dRjTjMsRBzbQakb2K2fnF0HokhwOixNd5SPNssR8XvNVcm
 CgO7UZnTZF07771IxVJSCK8fAV5ZijToMiQZDfwjYWXGsPBHKkXRgZKOwZXxVI/dLFBN
 CseEgFXMQqQtcPzxMAXX+OASJ6JvwrfLD2o1owO2+JWJ6SyMDs040VbKrSAIVTR2BJqF
 HGkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWDSDXyQ9RXrEagIFEIPKb8+EltJFWaJvxNqlEMCk2czeo5BJtUMP6ZiRhrHSdRu4C2j7S2VsVcEF@nongnu.org
X-Gm-Message-State: AOJu0Yyizr9iyrhd3EalTcB4Z5KaUomsEL7ztWRdSX2FAlDf19RxB5Di
 Y2Q6+ZdKbT6KUAwGk8Wma/4fza5LWsuoY4SuBSnIf1AM8DKLssArcOluj+ty9hEqptg=
X-Gm-Gg: ATEYQzwXGzEz5iz1CfGVGEy2+D4GZ5sK4NRW70y6D6ZziI/gx0JfsmpkjQ2wSB7ALFm
 q063Qo8O5JmJTUqgByTKyK8658T6bwEyjiJUio/HUjPuTT4D0clc+ZkIXrG4z3Rur2EhC/4Et+e
 1ChayXVsQsatp6rT3+mLmVGhDqWBNot+jJa7KGbE8ksxkSOTO0apBqmCEB0ZVptOID+K1b/y1OK
 /GloGH0BXlM/kJlH3+d5aCNn8WWFwGwDU7G8ZVATAeHudKAKw2A0GzsmKyVEwQHJ3Yun+XYER5I
 YqOvb9BL10l0tPu5gYLRe8xM6HUK2kF0CjjxF4+vwriRTre9YJ9M4gde2L0o6uH85kzeIklttz9
 hxZBW9LZJld+sEP485JdI80qgcEN5/aLYdQdpLd6PV0Ezj18X/YUuRIdA5HNY64PEfFo6hesU4E
 6fOwT4i1udSKgrEtmovYLs77MlhzkfugZjeKYMcirhpVjLmahHA4CCIj9MsaXzuzEQn+51
X-Received: by 2002:a17:902:f789:b0:2ad:6e0a:ad83 with SMTP id
 d9443c01a7336-2ae2e498544mr4487815ad.34.1772144600254; 
 Thu, 26 Feb 2026 14:23:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5b48f4sm35885145ad.13.2026.02.26.14.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:23:19 -0800 (PST)
Message-ID: <85b73ae6-1f95-4eb4-a395-15d4941c9e70@linaro.org>
Date: Thu, 26 Feb 2026 14:23:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] system/memory: Display address spaces starting at
 0x0000.0000
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> Since AddressSpace root MemoryRegion can be remapped, it is
> bogus to use the MemoryRegion address as the AddressSpace
> absolute address. Besides, the AddressSpace APIs take an
> @addr argument expecting AddressSpaces start at 0x0000.0000.
> 
> Substract the MemoryRegion address in mtree_print_mr() to
> display AddressSpaces starting at 0x0000.0000.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

