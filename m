Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC34FCF34CC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTeO-0004U9-O1; Thu, 03 Oct 2024 17:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTeE-0004TH-Qt
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:46:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTeC-0002X7-NL
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:46:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso15128155e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991967; x=1728596767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnN6jLsDl+p4pWf+ZTOLJ12/z5S4Sk1IkjuFC/29rAs=;
 b=Ib9qjY4+uMdfH1ae7rQrbkXl8fBluyxf0MRU/+uKQB9Rifs86dnQDdUB8+7xP9uMEd
 2H1/mcbw0lJyrWhzqO1yZxJS1l6qg0uh+ikjTRxD9WqxmogBCQkNtVjzGwgOttr09VY4
 3vIOm3B4+i77X69X1Xn9eGzi3UOfpnktitdTSP+ZS/FjtcOaRsKCOZXCSUfZxg87f+d5
 6zZvt5iJplaS9JELegbuWOcLjTIuEupwG3Y1Jhkh3g35Pmh33LUxAvGIV6RneYxPuSc3
 WT0rGfGTYl6MIaXJ+tLKld+Oy0+4NFfm6LXIhva7H9j8wds1cDWvDSj68pSkPj13jeQF
 ACVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991967; x=1728596767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnN6jLsDl+p4pWf+ZTOLJ12/z5S4Sk1IkjuFC/29rAs=;
 b=k3FLC4kqouL7iCpWsEpqQUPTdyxKV1wXa50BmcZ2/RHLM6ZNrf5y/IA8sMnzUz2S/B
 njPBdWoXhFDQJFQ9NiJLQoFJyTvYVX+qazF+0DCtPV+uaFd930rgm9Wn1Et9ax6xxS0u
 dNCckUM1lr08ZubwmcDYk/6Ci4vRIX4Po/FkSSzRGk1FYuZDY2ero/+3T03uiMf+ZOcf
 FeU3DS6jCxfjQjVWN5teDF/1nTsRxmQOvfJFIM7SnVhGypCCYlSw9VOqjjO1VF3QKLDL
 5kV2OBJQT/CUVwrBBuAuKBUFSnsV3NRXIdGp4bMbuZjH0H57bMH7xX6DmdKtuJ1pteR8
 Nvyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU21ydHGb5QX4ZC9sdk0gnJgxnES4DX5dpZHQM6Ra657Gqows8qX8V8uzskca2OfoQkVzNr4OYrKZI2@nongnu.org
X-Gm-Message-State: AOJu0YyLrUyKZnDb1kjP6QZfKbQQp7rekqU8AQvxGOv2nY9T8UWa9j2G
 wDRdNjOsPPlHigCcRC3o4e6LFwXVV6c0aD6iozZSLqTYXGar/LRYuGzJtguj/5/1H9/jogQW6oT
 dFo0=
X-Google-Smtp-Source: AGHT+IHH6xFK2NyltzuqQlBRcKqEFBGVJA9EPjyJWN0CIaRkCtMJ0mnmjmNAxkLLpn03DEeCkAN1Wg==
X-Received: by 2002:adf:fd50:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-37d0f6c612fmr242941f8f.15.1727991966964; 
 Thu, 03 Oct 2024 14:46:06 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d0824502fsm2031592f8f.52.2024.10.03.14.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:46:05 -0700 (PDT)
Message-ID: <2d126eab-8521-4a6f-9144-15b43252892c@linaro.org>
Date: Thu, 3 Oct 2024 23:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-2-philmd@linaro.org>
 <4c8e6941-e73d-4504-b289-987ddf49582d@linaro.org>
 <39042725-ed09-4ab4-9cd2-52d4899c2e3b@linaro.org>
 <f2b0908d-6e8f-4625-a297-5ad189da790b@linaro.org>
 <3146a8f5-7439-4566-ab24-eb0771dd0954@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3146a8f5-7439-4566-ab24-eb0771dd0954@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/10/24 23:37, Richard Henderson wrote:
> On 10/3/24 14:34, Philippe Mathieu-Daudé wrote:
>> On 3/10/24 23:28, Richard Henderson wrote:
>>> On 10/3/24 13:50, Philippe Mathieu-Daudé wrote:
>>>> On 30/9/24 09:34, Philippe Mathieu-Daudé wrote:
>>>>> Introduce the ld/st_endian_p() API, which takes an extra
>>>>
>>>> Alternatively we could use ld/st_te_p() since we already
>>>> have ld/st_he_p() for host endianness.
>>>
>>> That's what ld/st_p are -- target-specific, in exec/cpu-all.h.
>>
>> They are indeed *target-specific*, so we can not use them in
>> target-agnostic code.
>>
>> By explicitly passing the endianness, ld/st_endian_p() API is
>> target-agnostic.
> 
> Then I miss whatever you meant here re st_te_p().
> Care to elaborate?

I might had a bad start by adding this now endian-agnostic API
before removing the current endian-specific one.

Goal is instead of having machine code build twice, one for each
endianness, the same machine will be built once, but registering
2x machines. Endianness being a machine property, propagated to
the vCPUs and HW.

Instead of the following target-specific API:

   #if TARGET_BIG_ENDIAN
   #define stl_p(p, v) stl_be_p(p, v)
   #else
   #define stl_p(p, v) stl_le_p(p, v)
   #endif

I'm suggesting this target-agnostic one:

   #define stl_endian_p(big_endian, p, v) \
                       (big_endian) ? stl_be_p(p, v) : stl_le_p(p, v)

