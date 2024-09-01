Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28779CA101E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 21:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sksIO-0001Uu-OX; Sun, 01 Sep 2024 17:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sksIM-0001Tq-Of
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 17:39:38 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sksIK-0007i7-Sy
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 17:39:38 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5e172cc6d97so48098eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725226775; x=1725831575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1VOrZ1PVX8DPdNLCX+9PpssbiYXTEsseXMzj2n+YkE=;
 b=Av12F2N0I7peNRSt6OfBA1jsdSSjJhmZGMP1EKH11XBFfkB88ZdU9WAz+4EHdH60Sw
 7TiovTEo5qTiLYH6Vvd2VMh5xMVFz8is0+kXqCxQEUplyMhqGpUy169xuMnGPQWmEWAK
 o6JNVWBP1l6AaTuKGleLRolryF3u2krxVYKwkVCCO2ijAZAD3lb8UU0k60lLw6Ge2RS3
 xDp1AHZmp9IQyYQtnwrIdWiQP8PQLtZUIPOxIz46gsnz+N+ennIo+4H02AYbUe0BAPef
 B5F4G7FXpTS+bdkXhHLHTOlPM9+ORaPGo8VejFqQmiDwwiv0sYQhfYTE0mKNAvWtm8ZJ
 VvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725226775; x=1725831575;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j1VOrZ1PVX8DPdNLCX+9PpssbiYXTEsseXMzj2n+YkE=;
 b=S9Jt2Rma18DtwtpeS7XH2CB7SYsgSm7Rk3oXzUwjdSvdvCZCHVjGqO0qtkWeYtXpYr
 wgCHVRtxCgm2ouqkZ2kfpSP3+bYMT6k/IDsDiz5IHJ5GsDgK38FofQJI+NJzPrGfqrNY
 fvtKRHhOAp5jg6KrmmICMPEal2bFNKF/057HM6VLpmoPbXGJlutYE8VRtjtSC4ItyQlI
 EaG7+dF6aePJG527bRL/WHkPL1bXKQDfM3QLNtWPrkholX9jBUYvIJtOuTmBMXfcoIZy
 vKyolmWqwGCvA1T5ecp7nqMz4Sxo/veKRP+lWUhuNmYeR7CH9jgrzswnX0v8Fr8pXiv1
 4C0A==
X-Gm-Message-State: AOJu0YyyqalGoj2pUJjaxtBqvS0oi1h9PjcafmTykfTslmpF3fQc2abz
 KklK/Hl+brBGK25FV2xcoD7L3hlJ0soe5UdixNODXwfyH4y7IR+sBLMxb7sAg6UyROcleHKBK4/
 MzFg=
X-Google-Smtp-Source: AGHT+IHwrbrP1OQswbM3RxqSOKQUCze3TKcgwbrcf1LMMEZaFzsEnHCO/OJZn7RzB26+IJ1SRZbzTg==
X-Received: by 2002:a05:6358:5918:b0:1ac:f144:2b16 with SMTP id
 e5c5f4694b2df-1b7ef7089d9mr756045155d.26.1725226775142; 
 Sun, 01 Sep 2024 14:39:35 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445d7822sm10239541a91.9.2024.09.01.14.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 14:39:34 -0700 (PDT)
Message-ID: <268c5d7f-9ced-4804-9c5b-97c255e48855@linaro.org>
Date: Mon, 2 Sep 2024 07:39:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/m68k/mcf5208: Avoid shifting off end of integer
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
 <20240830173452.2086140-2-peter.maydell@linaro.org>
 <65291b1a-e1cd-42ea-8aad-233bd899b528@linaro.org>
Content-Language: en-US
In-Reply-To: <65291b1a-e1cd-42ea-8aad-233bd899b528@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 9/2/24 07:34, Richard Henderson wrote:
>> @@ -158,7 +158,7 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>>           {
>>               int n;
>>               for (n = 0; n < 32; n++) {
>> -                if (current_machine->ram_size < (2u << n)) {
>> +                if (current_machine->ram_size < (2ULL << n)) {
>>                       break;
>>                   }
>>               }
> 
>    31 - clz32(ram_size)

We might could do with lg2_pow2ceil() in host-utils.h, if that's clearer.


r~

